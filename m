Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpOwukKhvzrFjofd+tcutF2YGNi4Y7L1pDVMBtoYaZp029JYfntNvrXpPCCLLhdTpNbHfq5
ARC-Seal: i=1; a=rsa-sha256; t=1526280924; cv=none;
        d=google.com; s=arc-20160816;
        b=ZByh3yDA1SmBCksLJ7GwwplOLcu7mdRXZktswXug3tkAH6TPkcn+8SyqwpulGxZC63
         2xTxViodp7wxbBTuL8J8P+xn+DO4pzP2YQSEO01NbKR/j1ZVEeujQufClby124mzOsLx
         /O/5ZRlmHVXowigoYLwzuZcLahqTDdM5aNj7d3Aa1uFiGoDPR6CX/Bd+AUZp1PI0z4Gp
         vPGOG+FGEMUR5f98gQdiI5gwmgr1XgfmmM4+33GyfEejrTdg6gqoue6RUBKX0rdV+GYP
         4JvzL15FpINOoq4aZ5FJ5opWLyMo9iUrxxE2xB1YDSjaQtvSyBstKkumz2L6MbAyqt9n
         u71g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=Jni7dW1BrTWuWgIm4vpVxyR5kRCEd0UXA7rqUHjeD3c=;
        b=AncDtzY2aPHIAWtX/pMBrKugTv8Rk94zAbmn7hstXFw7rOzQewGJpANzgZGCKRAsGU
         10rlq0u7M8F/KEiIA2YW3rugVs8EQTLV+zEzdbOpj2R73vnjO16QFPj6LEhri/Fqtlxn
         OZaBM2LmxRRqUx1hjwYkwKBsjkHnBI2c9xOVpO24Wp82fbEL5t7/C58Vtr3mvFQsbn+3
         t5uTfGzsgdpPI56zYNV3FiDh5NT3X8yM1QCP9MNxd1BO3asb9OtEQtvGAoRmd5T3YLTN
         evl94pvFzGRmm1y+dwppuvr+xL/XDOaAUPvezMMucIao4iVHfRvAPvbB4s4U6Inm/w0f
         8nAQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=ZIEBtFuz;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=ZIEBtFuz;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	syzbot <syzkaller@googlegroups.com>,
	Pavel Emelyanov <xemul@parallels.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 15/62] tcp: fix TCP_REPAIR_QUEUE bound checking
Date: Mon, 14 May 2018 08:48:31 +0200
Message-Id: <20180514064817.250728387@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064816.436958006@linuxfoundation.org>
References: <20180514064816.436958006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421256400782370?=
X-GMAIL-MSGID: =?utf-8?q?1600421546473326218?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

commit bf2acc943a45d2b2e8a9f1a5ddff6b6e43cc69d9 upstream.

syzbot is able to produce a nasty WARN_ON() in tcp_verify_left_out()
with following C-repro :

socket(PF_INET, SOCK_STREAM, IPPROTO_IP) = 3
setsockopt(3, SOL_TCP, TCP_REPAIR, [1], 4) = 0
setsockopt(3, SOL_TCP, TCP_REPAIR_QUEUE, [-1], 4) = 0
bind(3, {sa_family=AF_INET, sin_port=htons(20002), sin_addr=inet_addr("0.0.0.0")}, 16) = 0
sendto(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
	1242, MSG_FASTOPEN, {sa_family=AF_INET, sin_port=htons(20002), sin_addr=inet_addr("127.0.0.1")}, 16) = 1242
setsockopt(3, SOL_TCP, TCP_REPAIR_WINDOW, "\4\0\0@+\205\0\0\377\377\0\0\377\377\377\177\0\0\0\0", 20) = 0
writev(3, [{"\270", 1}], 1)             = 1
setsockopt(3, SOL_TCP, TCP_REPAIR_OPTIONS, "\10\0\0\0\0\0\0\0\0\0\0\0|\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 386) = 0
writev(3, [{"\210v\r[\226\320t\231qwQ\204\264l\254\t\1\20\245\214p\350H\223\254;\\\37\345\307p$"..., 3144}], 1) = 3144

The 3rd system call looks odd :
setsockopt(3, SOL_TCP, TCP_REPAIR_QUEUE, [-1], 4) = 0

This patch makes sure bound checking is using an unsigned compare.

Fixes: ee9952831cfd ("tcp: Initial repair mode")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Cc: Pavel Emelyanov <xemul@parallels.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/ipv4/tcp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2601,7 +2601,7 @@ static int do_tcp_setsockopt(struct sock
 	case TCP_REPAIR_QUEUE:
 		if (!tp->repair)
 			err = -EPERM;
-		else if (val < TCP_QUEUES_NR)
+		else if ((unsigned int)val < TCP_QUEUES_NR)
 			tp->repair_queue = val;
 		else
 			err = -EINVAL;
