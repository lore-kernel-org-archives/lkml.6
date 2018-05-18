Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZo2O6cv9w6IDOTpnhkRxr2wb9wv2LDFJFGZxfGMLahPz1f5wD9HxpnjzLruqnU/EnPuuT23
ARC-Seal: i=1; a=rsa-sha256; t=1526631696; cv=none;
        d=google.com; s=arc-20160816;
        b=V/O+t3TGicL6aAGIWfXv+GsO5h8QeY6ucHvNl2ZYoneqErgfR/BZmnjjWNUa1gaKE7
         o18TsqkCVti789/QlE8TVSJ4eww5jtniiCI3Mu9xK5BoDfX7kFoomn2Nju1cljOvP00H
         htdiw/dvdbIF7uLUI4xJnzZ5L3lhxvLuZzL6hvL/5qgUmuy0IIV6qpEx7Jo0nVIBCUBF
         U4zYcmFv6ybY2dSobD27jZvYXrpYpbL97WghdHJ3GlZDPTSJC6p/OkdqZue/USSKfO50
         bMIH8Nw5DBCxFBIrPVNOvZanlJ+ey9vwDrso1JQ05KX6IbXPlahuh1nThKublq42572W
         ndVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=e++axm6qQJFDaZP0xLBz27n1jjgV2HcslSYN7Lkx5z4=;
        b=VtiMtwzw88id+N0bQNiIaU5cJhTkTDSau88zrWmx8TQvtMH6erLE7NCzIxluGk7yP4
         OWfz8VK6QS/VIN6PFX7WdsNkmxB870maNf54OVVAbaH/MSyal7Yn2j5kGcH8n1Fc9Q9y
         S9kunLaYAS8a/eRVG8VwO2cOSi91vcEnFLzE7eiE31yEvlnuF5z9V7cp50E1BZvdLIWb
         XTlNk/MCW2wgoLhggxRvLB/hESgL5nf/Y4hmpJ1AwGJPqEYRO7As4nqzskGe6xSvJAek
         sX2YSaFSmTWKhguInrwoD+42ggyVoeXbEZ2fUZnZPLp9FLvbbBvRuXaNbUy17sueAHhO
         2BPA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=jjWjbQsi;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=jjWjbQsi;
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
Subject: [PATCH 4.9 15/33] sctp: handle two v4 addrs comparison in sctp_inet6_cmp_addr
Date: Fri, 18 May 2018 10:15:54 +0200
Message-Id: <20180518081535.712594336@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081535.096308218@linuxfoundation.org>
References: <20180518081535.096308218@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789099921166414?=
X-GMAIL-MSGID: =?utf-8?q?1600789357738029916?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -864,6 +864,9 @@ static int sctp_inet6_cmp_addr(const uni
 	if (sctp_is_any(sk, addr1) || sctp_is_any(sk, addr2))
 		return 1;
 
+	if (addr1->sa.sa_family == AF_INET && addr2->sa.sa_family == AF_INET)
+		return addr1->v4.sin_addr.s_addr == addr2->v4.sin_addr.s_addr;
+
 	return __sctp_v6_cmp_addr(addr1, addr2);
 }
 
