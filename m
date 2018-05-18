Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrJpo9QktmrpuGzjM4tfRjRSkEBeeJQK1+ROtx3+2MQxXQEj0o6p6Bx/YyaOn0KNY1iztav
ARC-Seal: i=1; a=rsa-sha256; t=1526631667; cv=none;
        d=google.com; s=arc-20160816;
        b=jRdte/eiFsHENs/2+3kM2IXlj/JH2BMPxTDQ0/sZNBHjIa3KDLqSQdh9TxFyZjYmIu
         3cUpEySHHjD3dwHlC4vlBGxo8aqx3CwM8m7zFYEPzpS/Y9EhH6ocWOoVzgcQcMRKroPu
         jEAtXEne3S+5XKUkAlohWthJMuKmhg+bUOL4b1YYwrIcNVxhQ4S3RcHgaFkxJc4Y8HsM
         A4gxT08Sapm6fYu35qq4MLDVmGXylWZ8vSdV+HiWEMrK523HxQvQwXlOJ5nZA4LPdR/A
         I9n69+LiRxlu8omSEDpFuNIk5FSUIrtvkT4zOm+DY6/k/8JDEJ4v8D8/u0Cl7jGn5rXa
         kt0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=x9PO3IZDkqGgWiPVEHshe7L4H1CwO/hjXmGQojuN03g=;
        b=y5yA2OVnLNlxcenU2d5rvpckFd6Wh0gzzNP9FtwFdD9B7JGztZ5+YNqiUPmzTYnQ4X
         v12gPs73ZfTOsepKQPaTG96B3F96gemNyZ5FmoTopxCQafEIHJztAS25i+dUxg6ih9/8
         EsHVuuRHEayGLOENGoV6waLXMq0PEfWSQQrtmGyeWgASNTydKsksdYItBrEGfi8U8CUt
         zDtB/LACc3mURy+KBC+y8Jl5YCK4vY3hOXpA+CBMmNbL8luO0AqgncKp1ALg4gYFCc26
         hiNdR8BIiaz0AXCDiLZs4PXYiAeYkPA39JgmIK/ykdTCf5w4v8Z/Gu6aGsIazv/cRUHo
         rWpA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=VM2rVZSf;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=VM2rVZSf;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+cd494c1dd681d4d93ebb@syzkaller.appspotmail.com,
	Xin Long <lucien.xin@gmail.com>,
	Neil Horman <nhorman@tuxdriver.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 24/45] sctp: handle two v4 addrs comparison in sctp_inet6_cmp_addr
Date: Fri, 18 May 2018 10:15:41 +0200
Message-Id: <20180518081531.566075673@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081530.331586165@linuxfoundation.org>
References: <20180518081530.331586165@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789099921166414?=
X-GMAIL-MSGID: =?utf-8?q?1600789327107718393?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit d625329b06e46bd20baf9ee40847d11982569204 ]

Since sctp ipv6 socket also supports v4 addrs, it's possible to
compare two v4 addrs in pf v6 .cmp_addr, sctp_inet6_cmp_addr.

However after Commit 1071ec9d453a ("sctp: do not check port in
sctp_inet6_cmp_addr"), it no longer calls af1->cmp_addr, which
in this case is sctp_v4_cmp_addr, but calls __sctp_v6_cmp_addr
where it handles them as two v6 addrs. It would cause a out of
bounds crash.

syzbot found this crash when trying to bind two v4 addrs to a
v6 socket.

This patch fixes it by adding the process for two v4 addrs in
sctp_inet6_cmp_addr.

Fixes: 1071ec9d453a ("sctp: do not check port in sctp_inet6_cmp_addr")
Reported-by: syzbot+cd494c1dd681d4d93ebb@syzkaller.appspotmail.com
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Neil Horman <nhorman@tuxdriver.com>
Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sctp/ipv6.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/net/sctp/ipv6.c
+++ b/net/sctp/ipv6.c
@@ -865,6 +865,9 @@ static int sctp_inet6_cmp_addr(const uni
 	if (sctp_is_any(sk, addr1) || sctp_is_any(sk, addr2))
 		return 1;
 
+	if (addr1->sa.sa_family == AF_INET && addr2->sa.sa_family == AF_INET)
+		return addr1->v4.sin_addr.s_addr == addr2->v4.sin_addr.s_addr;
+
 	return __sctp_v6_cmp_addr(addr1, addr2);
 }
 
