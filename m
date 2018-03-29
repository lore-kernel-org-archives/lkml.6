Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+Bnn38bbMgMFuvzFlKsGbjpLcpjHMiIzjRLznKU8uCaIf11qd+M4k9twsBqIUPt8i/JMo3
ARC-Seal: i=1; a=rsa-sha256; t=1522346605; cv=none;
        d=google.com; s=arc-20160816;
        b=UhjIr3HaEl4afHSXpPr6qDg/23WP5G7LVNqVb+28VAbksxsVOV8amjhCSxvh3qrELS
         QOxVY0indq3j5VuPIs4VaHW/3O2v3sA/aju4uOBrxZOTPA7lCU5l9AAvUToloa5w5Lx5
         6MDr88G7nNxFFdCL5pV4zNWD/XlZNN42zXUGiTymsjrY65/uT4sEiolLN7skgeAAASFy
         1N3uUnjpIDd0OPQJWfng51RVCJD6XXci7QW9UGmlTlgB8twfg32bsNuNFxY+Xg5I5nTv
         NVqAY1f4kDEzW10HtlOOMxpb69Ah/BKd+KN1f4bj2VTKMcXVeN7yEBr0J9er33DCxWY2
         uMPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=colTGz6zKT+uybzJStRf82xDBx/MYdLQ8foR5GgsDxo=;
        b=W+3KsjecWnUOgEruM6J+UNyPCNFiX/lyamfG8KxuMQwuVwORvmBCdMol6t85XPDzTi
         wdS56rDJJAvK6HtTYnztSFVg6peoh9BiIJ9m9/gCROTaMJ1WB+LkQO38kMvbcME3Kqi3
         NNY/IGaTDdNomCCBuBWCPIo7QqkXvmjockSMJa46pi71zDuum8mCizZ65JEJO2goIRT7
         mVxJMYR1Spb1+D4VgK6dAdXecCM14Wdi3fOqvm21r17cB7MA8ctWpQkEZstiag7FcLCL
         GWNmtZQl+xS7TzBJ4HRn/yHwdMVS5c2ATwBW77kfcXhdNzr09HVEvm3vXzR6MrycIOAR
         /SGA==
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
Subject: [PATCH 4.15 42/47] netlink: avoid a double skb free in genlmsg_mcast()
Date: Thu, 29 Mar 2018 20:00:23 +0200
Message-Id: <20180329175733.010629598@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175729.225211114@linuxfoundation.org>
References: <20180329175729.225211114@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296114205984093?=
X-GMAIL-MSGID: =?utf-8?q?1596296114205984093?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1106,7 +1106,7 @@ static int genlmsg_mcast(struct sk_buff
 	if (!err)
 		delivered = true;
 	else if (err != -ESRCH)
-		goto error;
+		return err;
 	return delivered ? 0 : -ESRCH;
  error:
 	kfree_skb(skb);
