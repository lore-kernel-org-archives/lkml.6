Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuz8AMT3ypWs3jmyuvsVjCvH092A0e6Sti72eTL2kHEu1RZI4XQp/za/w/FW4Dmd3gE1Ogv
ARC-Seal: i=1; a=rsa-sha256; t=1520954886; cv=none;
        d=google.com; s=arc-20160816;
        b=RoZSCQ5yoCkePvQ6PgOjhggHLFcxXtCz5ogWBo3T/tM2ais74KpwkCbxj9ariy7bZP
         aMJlMZ+Tirpc34v054WliZCZgUXvltZHaOWavjJiTHsIxw+ST+6bYi2InSiOq8sKG7vk
         5TbOUtPvUoHVyxrJ4faO7sOhZgiK4Tpj0JGUcusLX1zcXXVBs3nAQEGCFqxf+TAvhUtt
         n0M1yEa+IiWUj5B+7Av/vVfv0oKklB6jtUJq3ibF0s76fiDktD+5xwhIVmCLIPS77VGU
         IpuIBLBZyANTV47Y77+Hu7+ymtm8iBtgvhieQRZJ7Sb3cTpI2pBMWIhgf09nu3gICH+W
         vSug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=8s18KT+N/Kz324u14CuQdl8Mk0AVHxFutCEDcNinUqg=;
        b=Sjkj5JUm/wD3hdkaeFJlna0pTPmqATReEsauFTN4eR+Fjk4VqNNuHrtBNuUStgN/iZ
         KbGwwntWJbsr0ct9McWXZ3mbIjxr0j4E00k33mmWLLXrWwcv93pmi95UshGn4m1ngjkV
         UJM0z9tzj3r3OK7fhSAIQabLa5uRACLmn9eXS9YJxhRVxWaPUZwfvoziEyPnUw7f+njR
         tEG43Nok7FO7PEL6dJmLRDvzG2NZPl9uL+3CTEtM1RbA6mJwY0MEVb6Cr4KJ7NSFmIc9
         Aj8WU0P74dAi1NYsOSS/q1LlvUm7AhCKgGEkC7Pmtq+iRCA/wYGoe/qVa6FYMFr0Fpj9
         feIQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Davide Caratti <dcaratti@redhat.com>,
	Ursula Braun <ubraun@linux.vnet.ibm.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 007/146] net/smc: fix NULL pointer dereference on sock_create_kern() error path
Date: Tue, 13 Mar 2018 16:22:54 +0100
Message-Id: <20180313152321.194503396@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836790781623415?=
X-GMAIL-MSGID: =?utf-8?q?1594836790781623415?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Davide Caratti <dcaratti@redhat.com>

commit a5dcb73b96a9d21431048bdaac02d9e96f386da3 upstream.

when sock_create_kern(..., a) returns an error, 'a' might not be a valid
pointer, so it shouldn't be dereferenced to read a->sk->sk_sndbuf and
and a->sk->sk_rcvbuf; not doing that caused the following crash:

general protection fault: 0000 [#1] SMP KASAN
Dumping ftrace buffer:
    (ftrace buffer empty)
Modules linked in:
CPU: 0 PID: 4254 Comm: syzkaller919713 Not tainted 4.16.0-rc1+ #18
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
Google 01/01/2011
RIP: 0010:smc_create+0x14e/0x300 net/smc/af_smc.c:1410
RSP: 0018:ffff8801b06afbc8 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff8801b63457c0 RCX: ffffffff85a3e746
RDX: 0000000000000004 RSI: 00000000ffffffff RDI: 0000000000000020
RBP: ffff8801b06afbf0 R08: 00000000000007c0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: ffff8801b6345c08 R14: 00000000ffffffe9 R15: ffffffff8695ced0
FS:  0000000001afb880(0000) GS:ffff8801db200000(0000)
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000040 CR3: 00000001b0721004 CR4: 00000000001606f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  __sock_create+0x4d4/0x850 net/socket.c:1285
  sock_create net/socket.c:1325 [inline]
  SYSC_socketpair net/socket.c:1409 [inline]
  SyS_socketpair+0x1c0/0x6f0 net/socket.c:1366
  do_syscall_64+0x282/0x940 arch/x86/entry/common.c:287
  entry_SYSCALL_64_after_hwframe+0x26/0x9b
RIP: 0033:0x4404b9
RSP: 002b:00007fff44ab6908 EFLAGS: 00000246 ORIG_RAX: 0000000000000035
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00000000004404b9
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 000000000000002b
RBP: 00007fff44ab6910 R08: 0000000000000002 R09: 00007fff44003031
R10: 0000000020000040 R11: 0000000000000246 R12: ffffffffffffffff
R13: 0000000000000006 R14: 0000000000000000 R15: 0000000000000000
Code: 48 c1 ea 03 80 3c 02 00 0f 85 b3 01 00 00 4c 8b a3 48 04 00 00 48
b8
00 00 00 00 00 fc ff df 49 8d 7c 24 20 48 89 fa 48 c1 ea 03 <80> 3c 02
00
0f 85 82 01 00 00 4d 8b 7c 24 20 48 b8 00 00 00 00
RIP: smc_create+0x14e/0x300 net/smc/af_smc.c:1410 RSP: ffff8801b06afbc8

Fixes: cd6851f30386 smc: remote memory buffers (RMBs)
Reported-and-tested-by: syzbot+aa0227369be2dcc26ebe@syzkaller.appspotmail.com
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
Signed-off-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/smc/af_smc.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1369,8 +1369,10 @@ static int smc_create(struct net *net, s
 	smc->use_fallback = false; /* assume rdma capability first */
 	rc = sock_create_kern(net, PF_INET, SOCK_STREAM,
 			      IPPROTO_TCP, &smc->clcsock);
-	if (rc)
+	if (rc) {
 		sk_common_release(sk);
+		goto out;
+	}
 	smc->sk.sk_sndbuf = max(smc->clcsock->sk->sk_sndbuf, SMC_BUF_MIN_SIZE);
 	smc->sk.sk_rcvbuf = max(smc->clcsock->sk->sk_rcvbuf, SMC_BUF_MIN_SIZE);
 
