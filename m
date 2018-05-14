Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrB+l2oDA/DOkUv65DUwvRMh7mxLsMJZxSTkahmE5fGdAqKLG1Qw5Wodhm9RbWEsC9E1ANS
ARC-Seal: i=1; a=rsa-sha256; t=1526281102; cv=none;
        d=google.com; s=arc-20160816;
        b=ILji4jBnBdBDtiz2Mb5PkGxADmBX7isN4G67ttiVKadfxc3ayDJ8Q5AlF9uSJ7ZN7g
         Dsu4p43rDAmvO88YR5+uqaVenC4j9ADoz2G4XyVP2mHZCJBO3HhIOwRPPK0n7ypGhnzF
         DIR+CgVPEr8E3cmUOC5Hz2T3hcyaBOZuHPYyQx+lwI6glZshnL3O9o6H7iOKzS12TyYd
         i1ubaa6TUDXPdoRp+P6cqD4us85yE3O5zDjhlmLHfG0qUidPl7uEFsqlV/an1dWNENfU
         Qi2QhD3Hwufp+34zxHH7oS+AN+ov02o/uoInGebgQ/6Y0/2TG6+lBJaF635DpXbVY4HF
         yr5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=XUgG4DOevkOFN1HJP9eLAa2Ghb/QTIa5PMyxafWnc/s=;
        b=X0+2q0xXQxiW/e0bcwz32ygCEL9FOKzKwaIE5K3ylNXCVfyAJ5J42FI+ATiLvs1sjO
         38zXpDP35FN7J8AbqI4eWDS1mFL4/TNzZzYlHKVeW8ba5GukYtqJTfLa0Hyg1qtjO6t0
         T0yrnbSwwJsoGiwf4fhG3TicKMxD2PpqtQE0NZCazk8MTeKjeBMoF2H4WRj6a4SHT6cO
         sQ3nd25A3pKYhy15BQUMWm+kayF0HD0NvC9acO7zIVEZLwenjIwESbV5ytuIRwWngpfl
         gShEVDw73czKFCGc9nAQ4q1FrquIzbBFYuoas8eiB4OUrEi2mDU3qyy6AFcjNObBoD4F
         dwdQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=UuHAa/hL;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=UuHAa/hL;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	syzbot <syzkaller@googlegroups.com>,
	Pavel Emelyanov <xemul@parallels.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 19/72] tcp: fix TCP_REPAIR_QUEUE bound checking
Date: Mon, 14 May 2018 08:48:36 +0200
Message-Id: <20180514064823.849870585@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064823.033169170@linuxfoundation.org>
References: <20180514064823.033169170@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421256400782370?=
X-GMAIL-MSGID: =?utf-8?q?1600421733953372605?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2690,7 +2690,7 @@ static int do_tcp_setsockopt(struct sock
 	case TCP_REPAIR_QUEUE:
 		if (!tp->repair)
 			err = -EPERM;
-		else if (val < TCP_QUEUES_NR)
+		else if ((unsigned int)val < TCP_QUEUES_NR)
 			tp->repair_queue = val;
 		else
 			err = -EINVAL;
