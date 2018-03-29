Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+24Z0X36ZkKyQH+cHMr2gTUO0DU7Ptqp3AmMMPNmEUQMcI7UuJwnNQTf9GxRBzIQ5wqP0e
ARC-Seal: i=1; a=rsa-sha256; t=1522346856; cv=none;
        d=google.com; s=arc-20160816;
        b=mQKr2fVktolygsznYCYunkMGQG1EnCPR33B/Cjak8Ho4cU3YlOjA/uHI4FObbTv0/i
         ksW3yLXpuMs5Q/x9Mq1vNPxOFw8KYhKUXc7zQYyekaVo2MzE6wYxRSp/vC0vWNi8oEZh
         ayT+qVyBD6X9Z58+nVPTmP5OH4AfxV6vz8obxRueRmnjWhUyFjD/PmycNMJME82ggGiM
         okK6jboGwkPGUmRh8sPZHm+m2KyjQuwDLAwMHFlRxO0mi3C7naQ3/bx74/04z4hSSITe
         hOAWlcyYCHjtBeEnBO2B7VzYkfa2/ZguKys9+fNG4L8Q3wrtn/JSQ196tM59wqIRhR2b
         IW+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=9EG/WJhnoZ69WS7trs7vdegznyIZzgHwCTRF3MEpxjQ=;
        b=KA5r+haSnY0HfgHQ3lPDNV2fXXfkz/su7svL/VH1zFqTJ8/ZCvYWddEWP13kQZQoZa
         I/fNjQsRrxLH9hIqMDn94QLuymo3c5nER+lXOdJTplxIioXvKs9JkW2migundnzqXUIp
         BgY4FIUZqOkEhwcOrKd6iUZ5Nz5oBeiux3xwru1eT40gY94Pu+SLGyYbpw6eD+1Yndv4
         xO2Z/Ha3vK3YKd5jTN17H6YLPsK3zw5yydcZwoKGKzh47sRPDxV/417fcDniHlrvE1Eg
         EgxAApGRELoJS7GJWtAdnGapB1OtndcePwlFyw3kdWX66MFLQmo2jZ/yLtezwfLFI950
         YSWA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ben Hutchings <ben.hutchings@codethink.co.uk>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 10/20] netlink: avoid a double skb free in genlmsg_mcast()
Date: Thu, 29 Mar 2018 20:00:46 +0200
Message-Id: <20180329175742.320701878@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175741.886181131@linuxfoundation.org>
References: <20180329175741.886181131@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296114205984093?=
X-GMAIL-MSGID: =?utf-8?q?1596296377060969363?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicolas Dichtel <nicolas.dichtel@6wind.com>


[ Upstream commit 02a2385f37a7c6594c9d89b64c4a1451276f08eb ]

nlmsg_multicast() consumes always the skb, thus the original skb must be
freed only when this function is called with a clone.

Fixes: cb9f7a9a5c96 ("netlink: ensure to loop over all netns in genlmsg_multicast_allns()")
Reported-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netlink/genetlink.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/netlink/genetlink.c
+++ b/net/netlink/genetlink.c
@@ -1143,7 +1143,7 @@ static int genlmsg_mcast(struct sk_buff
 	if (!err)
 		delivered = true;
 	else if (err != -ESRCH)
-		goto error;
+		return err;
 	return delivered ? 0 : -ESRCH;
  error:
 	kfree_skb(skb);
