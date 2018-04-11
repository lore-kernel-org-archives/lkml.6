Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48o0hUyceFIJGNjpTS/2ATOvp2yXrpu0jxKXQZ4jCF2+9IB15ZVQbB+dN7wyzsVRGaukRsg
ARC-Seal: i=1; a=rsa-sha256; t=1523472735; cv=none;
        d=google.com; s=arc-20160816;
        b=BZ1tUAIsibVzHkddzVhOjTt1wfNZe+UK2FIfKMPcv6qm1wsuEbycP/eA1hZCTX++ma
         i4X2fZbZGRMcKqO2F/0B+7n9v8pyF+CJWyzAXv3PzT0i8/KWzkbylS2fxHXYXb/D+cfW
         4jnK66B9cVDHFVjk+EBAByPARlWEQgjlPGtfyyX9uGmcP8SvCRbZcNP6VOzgq8ZqPKpP
         dAKabSQp/24ouJRq9kmD3aXoDx8hdOFnsipljvPJFuMjN+6CI1QYSCQyAv+NJQ0i9p9T
         s5qCcZOaiqf43c2w1aEhwgCzwybDtKwFc5RtIOnqItJrVT/arjyEnMVHP7/lIKB3aCjB
         Bvow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Fi/hBuTtjC6m+1e8FjgdKG1l3AP44LJxJZ8U9yj459w=;
        b=h09Lqu4AE5w3MZ2/EuuL0b9bB3SxEKL45m5e86dRvzkY098fHBk8Y4vGd4YSRCgHOU
         CVnTWOGCHh3U3gLuSW2z9f9qJsN3ESJnvbN4ioJtbkvqEGRtEK0C1sqTvhXWhgrJ1BUY
         SsJDHspyzbszBlN0C8amnkXQJep0HmLYUmukWdWboaTjnWf7jWSPiM06viJZdQ8sPP1e
         YW9LpDFjXSmR09BUG+1PaJZUjmV1qeCWWTjJEHhSg7MZ7x7zmSlxafedaICJHRo2s7a/
         BYVQDDShqsNdlefR0RiuH4hpI87JHA+c/5L1uO0Qz15AJcE5SCMRVnwW0t7uIItGNKCa
         YW+A==
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
Subject: [PATCH 4.4 173/190] sctp: sctp_sockaddr_af must check minimal addr length for AF_INET6
Date: Wed, 11 Apr 2018 20:36:59 +0200
Message-Id: <20180411183602.810363254@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476340196273876?=
X-GMAIL-MSGID: =?utf-8?q?1597476946883326579?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>


[ Upstream commit 81e98370293afcb58340ce8bd71af7b97f925c26 ]

Check must happen before call to ipv6_addr_v4mapped()

syzbot report was :

BUG: KMSAN: uninit-value in sctp_sockaddr_af net/sctp/socket.c:359 [inline]
BUG: KMSAN: uninit-value in sctp_do_bind+0x60f/0xdc0 net/sctp/socket.c:384
CPU: 0 PID: 3576 Comm: syzkaller968804 Not tainted 4.16.0+ #82
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:17 [inline]
 dump_stack+0x185/0x1d0 lib/dump_stack.c:53
 kmsan_report+0x142/0x240 mm/kmsan/kmsan.c:1067
 __msan_warning_32+0x6c/0xb0 mm/kmsan/kmsan_instr.c:676
 sctp_sockaddr_af net/sctp/socket.c:359 [inline]
 sctp_do_bind+0x60f/0xdc0 net/sctp/socket.c:384
 sctp_bind+0x149/0x190 net/sctp/socket.c:332
 inet6_bind+0x1fd/0x1820 net/ipv6/af_inet6.c:293
 SYSC_bind+0x3f2/0x4b0 net/socket.c:1474
 SyS_bind+0x54/0x80 net/socket.c:1460
 do_syscall_64+0x309/0x430 arch/x86/entry/common.c:287
 entry_SYSCALL_64_after_hwframe+0x3d/0xa2
RIP: 0033:0x43fd49
RSP: 002b:00007ffe99df3d28 EFLAGS: 00000213 ORIG_RAX: 0000000000000031
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 000000000043fd49
RDX: 0000000000000010 RSI: 0000000020000000 RDI: 0000000000000003
RBP: 00000000006ca018 R08: 00000000004002c8 R09: 00000000004002c8
R10: 00000000004002c8 R11: 0000000000000213 R12: 0000000000401670
R13: 0000000000401700 R14: 0000000000000000 R15: 0000000000000000

Local variable description: ----address@SYSC_bind
Variable was created at:
 SYSC_bind+0x6f/0x4b0 net/socket.c:1461
 SyS_bind+0x54/0x80 net/socket.c:1460

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Vlad Yasevich <vyasevich@gmail.com>
Cc: Neil Horman <nhorman@tuxdriver.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sctp/socket.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -335,11 +335,14 @@ static struct sctp_af *sctp_sockaddr_af(
 	if (!opt->pf->af_supported(addr->sa.sa_family, opt))
 		return NULL;
 
-	/* V4 mapped address are really of AF_INET family */
-	if (addr->sa.sa_family == AF_INET6 &&
-	    ipv6_addr_v4mapped(&addr->v6.sin6_addr) &&
-	    !opt->pf->af_supported(AF_INET, opt))
-		return NULL;
+	if (addr->sa.sa_family == AF_INET6) {
+		if (len < SIN6_LEN_RFC2133)
+			return NULL;
+		/* V4 mapped address are really of AF_INET family */
+		if (ipv6_addr_v4mapped(&addr->v6.sin6_addr) &&
+		    !opt->pf->af_supported(AF_INET, opt))
+			return NULL;
+	}
 
 	/* If we get this far, af is valid. */
 	af = sctp_get_af_specific(addr->sa.sa_family);
