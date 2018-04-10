Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/guMn578Bsjw4mEmMTWC1KUdUEcyHjtXfBtMsK42BqDLuuHWoq9WogLZdhC6lDTB1hDH0t
ARC-Seal: i=1; a=rsa-sha256; t=1523399648; cv=none;
        d=google.com; s=arc-20160816;
        b=ht1TvDc59BwqTSAoW6YMCQxrugp98A3DcaFhxmsnzuM3fQ931gfLwJ7MQ2D4cmSluw
         IbVf6cuwNWHxlzLtEff1WfLo0a5gaCuo6zzpZE5rArZ6dPF28GGuKif6ob5aNq4TSMlJ
         7G5LtcYAgGt0YiQjY7CAUgCqILipjEjDM3AFPmggKEF/MKFr4inoXE5clgTXcVI0jtps
         P00Gj2wn6+4WlEKmC8OfTjPGlfiVgTXEoWhIL47ymNRlOgdmbFyv95S6qHkdTu7dCWtf
         L4C6sbaA5fVddh1Ru6yndoxN/ixRg1f4Fb56i8AoPd9hAJUTSbG7LGn32Y52p3SmJ/mY
         K98w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=gooQ9amF4vhYhayEMMzUJXhkm3KH/rOyRs84SZPU3Zo=;
        b=BBvBAO9WAz+jEGUt+jfY+kHxRVlSGmbM/AzhstEsY5FlFsDh3c7+mSvLn3iFW90nYk
         tnhZaWodk3DGabuMkXG/ZlMyqflZl6UYqUrBPZ7oACyXOjpnrM2loMKe4i2rZB6XJHZ+
         6G2OAaRT59EAvPT9a7+l9uOm6eFPn2rWyOzdWv3jL8FK+3QQIKm2z8mj6t0i6iu91VO0
         XdMw1rNSICy52nmZ7exFGGVHQ+upCA8R81qiUg6G2+irZgy3YB79O5McpcSfastiSvCB
         PhIZdcwCXjgiYb3mas+SIx5Auv4Oxue6W9q/lYCQFlCr+bAcNSJwyr9nMcIX+HTjIKPP
         29XQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jianlin Shi <jishi@redhat.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 014/138] l2tp: fix missing print session offset info
Date: Wed, 11 Apr 2018 00:23:24 +0200
Message-Id: <20180410212903.781429198@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399876281543493?=
X-GMAIL-MSGID: =?utf-8?q?1597400310032929457?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hangbin Liu <liuhangbin@gmail.com>


[ Upstream commit 820da5357572715c6235ba3b3daa2d5b43a1198f ]

Report offset parameter in L2TP_CMD_SESSION_GET command if
it has been configured by userspace

Fixes: 309795f4bec ("l2tp: Add netlink control API for L2TP")
Reported-by: Jianlin Shi <jishi@redhat.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/l2tp/l2tp_netlink.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/l2tp/l2tp_netlink.c
+++ b/net/l2tp/l2tp_netlink.c
@@ -765,6 +765,8 @@ static int l2tp_nl_session_send(struct s
 
 	if ((session->ifname[0] &&
 	     nla_put_string(skb, L2TP_ATTR_IFNAME, session->ifname)) ||
+	    (session->offset &&
+	     nla_put_u16(skb, L2TP_ATTR_OFFSET, session->offset)) ||
 	    (session->cookie_len &&
 	     nla_put(skb, L2TP_ATTR_COOKIE, session->cookie_len,
 		     &session->cookie[0])) ||
