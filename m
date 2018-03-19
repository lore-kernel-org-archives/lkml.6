Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuX3FXeDz3MYoUQ7VaehdBJ5J5nVfi+eoUvGs3dNjc3uwZ4iKKTqP+YYzr0Iq4vRq707/6t
ARC-Seal: i=1; a=rsa-sha256; t=1521483018; cv=none;
        d=google.com; s=arc-20160816;
        b=BPLzbQFacEfFuwBYd7v0eW1sy9NhOej1TPsDRvwBoRlS1T630gDthhgzTNgI0bmsBM
         QVar662T2w2klJA2slqiDvomDgvJIl1gQWajv6x7XlHHSB9/UElrmrOFLW3ODG02wpwh
         jnZxXM+qUTPJbkBuVfD4qr7gfoc+SF0SDZZoP9FVrdeQJF1j149YLhUQfoezDCT6WOdd
         EAHkYlDgMK+Xcd1I5t3R/2bOQxVVLIyui4xSWtACezBT7F715cr9U56ZF8WVcHPbhmlH
         jNj4DoFfaeOniWk05IYOyP/8nY/KnrYnVGZOTclkMsth6yMQ5QYmoQjuXCC0XZ78amf7
         I0kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=pBWNlJCRTSsZ7177ccSzhGs1WJo7ALLrNV4ZeT8m2kE=;
        b=q87qS7Ia2+Lre40xlTcJLnK30UGVAu/W5i+g/H/yyV9xUI8d1zYo5KXTmbzAVpd7QK
         nSWBAm9qE9BDg4M18ONGwxjrgeDUh58F3Jf4sJfHoAM7+XGup27fGWpfLCb9gvTFVPH6
         gC3onaVrtQs3fODwqyX6P+flHFzQOdR+IPdqMovIgJomTOHd82ce37yJG9ksSt7nCJYH
         yS3Di8Vh8e6vTn09JTyHI0XVzgZ1gKClCRvYbCRg7ybzLL2fr6oV9sIajsAaiyEc1fcW
         PLX5lMZsjOscQrBvjAd5MXCLWWHyccgdsB/HBCiVPvx7D8JCcLdpn/3e4y9K/mpGf6/K
         /DpQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Alexander Potapenko <glider@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Paul Moore <paul@paul-moore.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 05/68] selinux: check for address length in selinux_socket_bind()
Date: Mon, 19 Mar 2018 19:05:43 +0100
Message-Id: <20180319171828.655000665@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171827.899658615@linuxfoundation.org>
References: <20180319171827.899658615@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390577263174550?=
X-GMAIL-MSGID: =?utf-8?q?1595390577263174550?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Potapenko <glider@google.com>


[ Upstream commit e2f586bd83177d22072b275edd4b8b872daba924 ]

KMSAN (KernelMemorySanitizer, a new error detection tool) reports use of
uninitialized memory in selinux_socket_bind():

==================================================================
BUG: KMSAN: use of unitialized memory
inter: 0
CPU: 3 PID: 1074 Comm: packet2 Tainted: G    B           4.8.0-rc6+ #1916
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
 0000000000000000 ffff8800882ffb08 ffffffff825759c8 ffff8800882ffa48
 ffffffff818bf551 ffffffff85bab870 0000000000000092 ffffffff85bab550
 0000000000000000 0000000000000092 00000000bb0009bb 0000000000000002
Call Trace:
 [<     inline     >] __dump_stack lib/dump_stack.c:15
 [<ffffffff825759c8>] dump_stack+0x238/0x290 lib/dump_stack.c:51
 [<ffffffff818bdee6>] kmsan_report+0x276/0x2e0 mm/kmsan/kmsan.c:1008
 [<ffffffff818bf0fb>] __msan_warning+0x5b/0xb0 mm/kmsan/kmsan_instr.c:424
 [<ffffffff822dae71>] selinux_socket_bind+0xf41/0x1080 security/selinux/hooks.c:4288
 [<ffffffff8229357c>] security_socket_bind+0x1ec/0x240 security/security.c:1240
 [<ffffffff84265d98>] SYSC_bind+0x358/0x5f0 net/socket.c:1366
 [<ffffffff84265a22>] SyS_bind+0x82/0xa0 net/socket.c:1356
 [<ffffffff81005678>] do_syscall_64+0x58/0x70 arch/x86/entry/common.c:292
 [<ffffffff8518217c>] entry_SYSCALL64_slow_path+0x25/0x25 arch/x86/entry/entry_64.o:?
chained origin: 00000000ba6009bb
 [<ffffffff810bb7a7>] save_stack_trace+0x27/0x50 arch/x86/kernel/stacktrace.c:67
 [<     inline     >] kmsan_save_stack_with_flags mm/kmsan/kmsan.c:322
 [<     inline     >] kmsan_save_stack mm/kmsan/kmsan.c:337
 [<ffffffff818bd2b8>] kmsan_internal_chain_origin+0x118/0x1e0 mm/kmsan/kmsan.c:530
 [<ffffffff818bf033>] __msan_set_alloca_origin4+0xc3/0x130 mm/kmsan/kmsan_instr.c:380
 [<ffffffff84265b69>] SYSC_bind+0x129/0x5f0 net/socket.c:1356
 [<ffffffff84265a22>] SyS_bind+0x82/0xa0 net/socket.c:1356
 [<ffffffff81005678>] do_syscall_64+0x58/0x70 arch/x86/entry/common.c:292
 [<ffffffff8518217c>] return_from_SYSCALL_64+0x0/0x6a arch/x86/entry/entry_64.o:?
origin description: ----address@SYSC_bind (origin=00000000b8c00900)
==================================================================

(the line numbers are relative to 4.8-rc6, but the bug persists upstream)

, when I run the following program as root:

=======================================================
  #include <string.h>
  #include <sys/socket.h>
  #include <netinet/in.h>

  int main(int argc, char *argv[]) {
    struct sockaddr addr;
    int size = 0;
    if (argc > 1) {
      size = atoi(argv[1]);
    }
    memset(&addr, 0, sizeof(addr));
    int fd = socket(PF_INET6, SOCK_DGRAM, IPPROTO_IP);
    bind(fd, &addr, size);
    return 0;
  }
=======================================================

(for different values of |size| other error reports are printed).

This happens because bind() unconditionally copies |size| bytes of
|addr| to the kernel, leaving the rest uninitialized. Then
security_socket_bind() reads the IP address bytes, including the
uninitialized ones, to determine the port, or e.g. pass them further to
sel_netnode_find(), which uses them to calculate a hash.

Signed-off-by: Alexander Potapenko <glider@google.com>
Acked-by: Eric Dumazet <edumazet@google.com>
[PM: fixed some whitespace damage]
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 security/selinux/hooks.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4061,10 +4061,18 @@ static int selinux_socket_bind(struct so
 		u32 sid, node_perm;
 
 		if (family == PF_INET) {
+			if (addrlen < sizeof(struct sockaddr_in)) {
+				err = -EINVAL;
+				goto out;
+			}
 			addr4 = (struct sockaddr_in *)address;
 			snum = ntohs(addr4->sin_port);
 			addrp = (char *)&addr4->sin_addr.s_addr;
 		} else {
+			if (addrlen < SIN6_LEN_RFC2133) {
+				err = -EINVAL;
+				goto out;
+			}
 			addr6 = (struct sockaddr_in6 *)address;
 			snum = ntohs(addr6->sin6_port);
 			addrp = (char *)&addr6->sin6_addr.s6_addr;
