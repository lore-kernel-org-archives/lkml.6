Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/T25sWeatl0fo9bGslghbSZnmGSPGyduNUomX9oe+9U1Q/ysVEWTwE/v15bihX7gZG8bgG
ARC-Seal: i=1; a=rsa-sha256; t=1523472705; cv=none;
        d=google.com; s=arc-20160816;
        b=THKYbJUYE5Lh85J7zTdJlc6Vh+VGboTX3FHdVX/b69doy86iIEE81t2GZ8pCegAUJ4
         3n+L99TZEJ+J5lo7UVsfAhflSZReapradeM5jj+YpKNOXkfXImXtOBS8bz/DvG7Kb7qY
         tlDCLiSQ1EaKNTLQwYNfFpYH8H4lc5RI73WYiovJbfFdcdsxZgKus/CnNxbzsLZP7ljS
         k9cMfKZYVplB6PCzZ9YXT/4SH2mbSOEq1FGM+LsMQaAo0L2KVXqNNkfGsMFLXNGULn/U
         hww4aVlf3+/Ix0kn9ovCT2bh+8w2Git5ozsdSxGLLXnTZmvs6v6MXEbSnJq0i+n1uj70
         0Wlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=u2XppUwlwo3WUpJ0dcfaIfE6s1e9ST6ZPmXOvzgl1iA=;
        b=vWyQyqppuwl2PEgw6kP9A/hM1UeZ8GF8grl07/OecaKNHfQWRZTUh5XJju+4B+lojU
         2wBxyuNJAv8LLaqx/ozAUGKuVk5P7zZFyF8DA7/Co3SWoyBiCeQFIAYmks3Q1y0nOQ15
         h4AYYBnljWmJWqtYkrP2sOehhUd7bFLVcbaVXuCXwvK6Oo3b5eCIYzhfp24IbfLbIOsy
         t+I6KBL+Suu8Z2+qj1UJZ2i/R4lk1DDYICNbmj0BiQha995+Ja7a+UhCu6lI2tOeNW8H
         vVg1xIrUB5DGmooHFhzFqdBvxje/xQWU9yQQymlyxwS6AoiYWyCHBYtU5zgA2yYIunSJ
         +mzw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Vlad Yasevich <vyasevich@gmail.com>,
	Neil Horman <nhorman@tuxdriver.com>,
	syzbot <syzkaller@googlegroups.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 172/190] sctp: do not leak kernel memory to user space
Date: Wed, 11 Apr 2018 20:36:58 +0200
Message-Id: <20180411183602.645674183@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476337838554595?=
X-GMAIL-MSGID: =?utf-8?q?1597476915553012073?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>


[ Upstream commit 6780db244d6b1537d139dea0ec8aad10cf9e4adb ]

syzbot produced a nice report [1]

Issue here is that a recvmmsg() managed to leak 8 bytes of kernel memory
to user space, because sin_zero (padding field) was not properly cleared.

[1]
BUG: KMSAN: uninit-value in copy_to_user include/linux/uaccess.h:184 [inline]
BUG: KMSAN: uninit-value in move_addr_to_user+0x32e/0x530 net/socket.c:227
CPU: 1 PID: 3586 Comm: syzkaller481044 Not tainted 4.16.0+ #82
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:17 [inline]
 dump_stack+0x185/0x1d0 lib/dump_stack.c:53
 kmsan_report+0x142/0x240 mm/kmsan/kmsan.c:1067
 kmsan_internal_check_memory+0x164/0x1d0 mm/kmsan/kmsan.c:1176
 kmsan_copy_to_user+0x69/0x160 mm/kmsan/kmsan.c:1199
 copy_to_user include/linux/uaccess.h:184 [inline]
 move_addr_to_user+0x32e/0x530 net/socket.c:227
 ___sys_recvmsg+0x4e2/0x810 net/socket.c:2211
 __sys_recvmmsg+0x54e/0xdb0 net/socket.c:2313
 SYSC_recvmmsg+0x29b/0x3e0 net/socket.c:2394
 SyS_recvmmsg+0x76/0xa0 net/socket.c:2378
 do_syscall_64+0x309/0x430 arch/x86/entry/common.c:287
 entry_SYSCALL_64_after_hwframe+0x3d/0xa2
RIP: 0033:0x4401c9
RSP: 002b:00007ffc56f73098 EFLAGS: 00000217 ORIG_RAX: 000000000000012b
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 00000000004401c9
RDX: 0000000000000001 RSI: 0000000020003ac0 RDI: 0000000000000003
RBP: 00000000006ca018 R08: 0000000020003bc0 R09: 0000000000000010
R10: 0000000000000000 R11: 0000000000000217 R12: 0000000000401af0
R13: 0000000000401b80 R14: 0000000000000000 R15: 0000000000000000

Local variable description: ----addr@___sys_recvmsg
Variable was created at:
 ___sys_recvmsg+0xd5/0x810 net/socket.c:2172
 __sys_recvmmsg+0x54e/0xdb0 net/socket.c:2313

Bytes 8-15 of 16 are uninitialized

==================================================================
Kernel panic - not syncing: panic_on_warn set ...

CPU: 1 PID: 3586 Comm: syzkaller481044 Tainted: G    B            4.16.0+ #82
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:17 [inline]
 dump_stack+0x185/0x1d0 lib/dump_stack.c:53
 panic+0x39d/0x940 kernel/panic.c:183
 kmsan_report+0x238/0x240 mm/kmsan/kmsan.c:1083
 kmsan_internal_check_memory+0x164/0x1d0 mm/kmsan/kmsan.c:1176
 kmsan_copy_to_user+0x69/0x160 mm/kmsan/kmsan.c:1199
 copy_to_user include/linux/uaccess.h:184 [inline]
 move_addr_to_user+0x32e/0x530 net/socket.c:227
 ___sys_recvmsg+0x4e2/0x810 net/socket.c:2211
 __sys_recvmmsg+0x54e/0xdb0 net/socket.c:2313
 SYSC_recvmmsg+0x29b/0x3e0 net/socket.c:2394
 SyS_recvmmsg+0x76/0xa0 net/socket.c:2378
 do_syscall_64+0x309/0x430 arch/x86/entry/common.c:287
 entry_SYSCALL_64_after_hwframe+0x3d/0xa2

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc:	Vlad Yasevich <vyasevich@gmail.com>
Cc:	Neil Horman <nhorman@tuxdriver.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sctp/ipv6.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/net/sctp/ipv6.c
+++ b/net/sctp/ipv6.c
@@ -723,8 +723,10 @@ static int sctp_v6_addr_to_user(struct s
 			sctp_v6_map_v4(addr);
 	}
 
-	if (addr->sa.sa_family == AF_INET)
+	if (addr->sa.sa_family == AF_INET) {
+		memset(addr->v4.sin_zero, 0, sizeof(addr->v4.sin_zero));
 		return sizeof(struct sockaddr_in);
+	}
 	return sizeof(struct sockaddr_in6);
 }
 
