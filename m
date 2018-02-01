Return-Path: <eric.dumazet@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1517528587; cv=none;
        d=google.com; s=arc-20160816;
        b=QAqqE5ie4OCnfO5eza9jOzaIvMfMk5jvdujjfihjTEp529B0D3qIFyMoIC8Ebuncys
         3wzDLZrp7DtwjKsYzt7a2OX6WCxHBNaJKiT1cAXMyXoiE21xEiorRaW5UuApVKKaNDl0
         ZuvD2o+mH5ujhbTx03UQhtPcKzRbuMk0rcRty5pw+JVu8Mzla0ksJkrUC5iJNakGJjHR
         iUoY1ivbvAp7IAxOUhSwRP9T0RFFAxQzi6GrVp9gPFMrJE084zLB00nWRmIGdPPsEXX5
         9AYofG11Wq4Ztr7EIlSCExsO8EdAT3TgDG0jfBd6Ywt7V7dOZVkPSWPhMEAruI9fmohQ
         5Quw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:dkim-signature
         :arc-authentication-results;
        bh=x1/t4X39n/I55U9W91wpiSRINMQwKYPE9UVhyw3f3Yc=;
        b=RdU9aDSvkAusI/ebZj9FTe4HSF2D4TtCBvKMCR2jNpnECGvaVvxUnIjTihDYLj/i18
         ORQBFUMWORIJjk1G00+TbarCJD9bEMTY4QojvGGKQnRZFDnKXtONHT/nbDpt1hTkcUiI
         pdxUTkqgoBFIQGety5dRcP1Lbd6D1rfAH3MjcsnvSu9qFs14yBdgBiEZXt8U9NuzBrCl
         caqAEymqznIBMlxmWFFdIymWYT1AAr+PtJQBanzeNhrPfMr36gU5kutrUDtfpsdIPSNp
         Uy12SA1erEcpqXf3uC/Y02pTUsztrM9ZfPp7nZWGnG7oxqtP1bNB8P5HoW552A8wztNN
         v1UQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=FCutQzel;
       spf=pass (google.com: domain of eric.dumazet@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=eric.dumazet@gmail.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=FCutQzel;
       spf=pass (google.com: domain of eric.dumazet@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=eric.dumazet@gmail.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x226NpuLMJPHOeZ3jN0jaqf1GB+yGtrBYwhyeT7qyBi6XAqvlVngLzJYYqJCgtkuXx044RZP7JQ==
Message-ID: <1517528585.3715.122.camel@gmail.com>
Subject: Re: WARNING in reuseport_add_sock
From: Eric Dumazet <eric.dumazet@gmail.com>
To: Eric Biggers <ebiggers3@gmail.com>, syzbot
	 <syzbot+c0ea2226f77a42936bf7@syzkaller.appspotmail.com>
Cc: adobriyan@gmail.com, davem@davemloft.net, gregkh@linuxfoundation.org,
	kraig@google.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pombredanne@nexb.com, syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Date: Thu, 01 Feb 2018 15:43:05 -0800
In-Reply-To: <20180201233012.fgcve3ohufcspb2c@gmail.com>
References: <94eb2c1fcf4cdda26b05629d08d4@google.com>
	 <20180201233012.fgcve3ohufcspb2c@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1589433054887734562?=
X-GMAIL-MSGID: =?utf-8?q?1591244055397606507?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 2018-02-01 at 15:30 -0800, Eric Biggers wrote:
> On Fri, Jan 12, 2018 at 03:58:01PM -0800, syzbot wrote:
> > Hello,
> > 
> > syzkaller hit the following crash on
> > 30a7acd573899fd8b8ac39236eff6468b195ac7d
> > git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/master
> > compiler: gcc (GCC) 7.1.1 20170620
> > .config is attached
> > Raw console output is attached.
> > C reproducer is attached
> > syzkaller reproducer is attached. See https://goo.gl/kgGztJ
> > for information about syzkaller reproducers
> > 
> > 
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+c0ea2226f77a42936bf7@syzkaller.appspotmail.com
> > It will help syzbot understand when the bug is fixed. See footer for
> > details.
> > If you forward the report, please keep this part and the footer.
> > 
> > ------------[ cut here ]------------
> > socket already in reuseport group
> > WARNING: CPU: 0 PID: 3496 at net/core/sock_reuseport.c:119
> > reuseport_add_sock+0x742/0x9b0 net/core/sock_reuseport.c:117
> > Kernel panic - not syncing: panic_on_warn set ...
> > 
> > CPU: 0 PID: 3496 Comm: syzkaller869503 Not tainted 4.15.0-rc6+ #245
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > Google 01/01/2011
> > Call Trace:
> >  __dump_stack lib/dump_stack.c:17 [inline]
> >  dump_stack+0x194/0x257 lib/dump_stack.c:53
> >  panic+0x1e4/0x41c kernel/panic.c:183
> >  __warn+0x1dc/0x200 kernel/panic.c:547
> >  report_bug+0x211/0x2d0 lib/bug.c:184
> >  fixup_bug.part.11+0x37/0x80 arch/x86/kernel/traps.c:178
> >  fixup_bug arch/x86/kernel/traps.c:247 [inline]
> >  do_error_trap+0x2d7/0x3e0 arch/x86/kernel/traps.c:296
> >  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:315
> >  invalid_op+0x22/0x40 arch/x86/entry/entry_64.S:1079
> > RIP: 0010:reuseport_add_sock+0x742/0x9b0 net/core/sock_reuseport.c:117
> > RSP: 0018:ffff8801bf5f7968 EFLAGS: 00010286
> > RAX: dffffc0000000008 RBX: ffff8801bf4905c0 RCX: ffffffff8159d9de
> > RDX: 0000000000000000 RSI: 1ffff10037ebeee8 RDI: 0000000000000293
> > RBP: ffff8801bf5f7b00 R08: 1ffff10037ebeeaa R09: 0000000000000000
> > R10: ffff8801bf5f7820 R11: 0000000000000000 R12: 1ffff10037ebef37
> > R13: ffff8801bf47b930 R14: ffff8801bf5f7ad8 R15: 1ffff10037ebef3b
> >  inet_reuseport_add_sock net/ipv4/inet_hashtables.c:456 [inline]
> >  __inet_hash+0x767/0xb90 net/ipv4/inet_hashtables.c:477
> >  inet_hash+0x61/0x90 net/ipv4/inet_hashtables.c:501
> >  inet_csk_listen_start+0x38f/0x460 net/ipv4/inet_connection_sock.c:885
> >  inet_listen+0x19a/0x440 net/ipv4/af_inet.c:228
> >  SYSC_listen net/socket.c:1483 [inline]
> >  SyS_listen+0x1aa/0x350 net/socket.c:1469
> >  entry_SYSCALL_64_fastpath+0x23/0x9a
> > RIP: 0033:0x445639
> > RSP: 002b:00007f2966197db8 EFLAGS: 00000246 ORIG_RAX: 0000000000000032
> > RAX: ffffffffffffffda RBX: 00000000006dac24 RCX: 0000000000445639
> > RDX: 0000000000445639 RSI: 0000000000000000 RDI: 0000000000000006
> > RBP: 00000000006dac20 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> > R13: 00007ffc328a273f R14: 00007f29661989c0 R15: 0000000000000008
> > Dumping ftrace buffer:
> >    (ftrace buffer empty)
> > Kernel Offset: disabled
> > Rebooting in 86400 seconds..
> > 
> 
> Still happens.  Here's a simplified reproducer:
> 
> #include <linux/filter.h>
> #include <linux/in.h>
> #include <sys/socket.h>
> 
> int main()
> {
> 	struct sock_filter filt = { .code = 6 };
> 	struct sock_fprog prog = { .len = 1, .filter = &filt };
> 	struct sockaddr_in addr = {
> 		.sin_family = AF_INET,
> 		.sin_port = htobe16(20000),
> 	};
> 
> 	for (;;) {
> 		int fd = socket(AF_INET, SOCK_STREAM, 0);
> 		setsockopt(fd, IPPROTO_TCP, IP_TRANSPARENT, &(int){ 1 }, 4);
> 		setsockopt(fd, SOL_SOCKET, SO_REUSEPORT, &(int){ 1 }, 4);
> 		setsockopt(fd, SOL_SOCKET, SO_ATTACH_REUSEPORT_CBPF,
> 			   &prog, sizeof(prog));
> 		bind(fd, (void *)&addr, sizeof(addr));
> 		listen(fd, 0);
> 	}
> }

It seems commit 1b5f962e71bf ("soreuseport: fix initialization race")
was not complete, and missed check done in reuseport_add_sock()

( That was my update in Google-Bug-Id 71459017 )

I probably can send a fix today, if time permits.
