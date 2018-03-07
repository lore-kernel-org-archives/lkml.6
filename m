Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuS+nn/sfdAR+ZZZhY46JHVekk8EdFXfR5FHtozlnumgAYM3Va6TvoCSH4V4LnsPNBq67pD
ARC-Seal: i=1; a=rsa-sha256; t=1520451671; cv=none;
        d=google.com; s=arc-20160816;
        b=CADBn1rutEg3GA3mIh2kBTOwoWmPsfB/R4LLyR4HnwnXGWE9DYiTGV//lYu/Lpjsy9
         Gu/wrBklz5uo4Zpk8WdlmgQuYcr1pPYJU1OFHTw7B2Ql4fZ5MMUkewuuqCQBu8CEuRbY
         GCS99P1iGAqECjL1+WyxievTybkJf7q+uc7B7RUaXU1zxS1S8wJPHWQ8tNirFdN88UpO
         3J4/CA4XAHI9MWGjGk70+rjexr/EFy3IEJGNoqyyT707BnO5qr7Ec4w2fv/Uek/HcR/b
         94FCpviM7hoKKN6+RFFHbPTwX5Y45bEqQD6JpPMybvzABHd3V3zmdlat3nCKIsQIEwgm
         LNTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=NBrtvk0HuVYDbif7hfHCtwz1cp4drZOHoEU0cUbIOd4=;
        b=hyANBB/sV4BSFROlws01N13v5AonOUWz0a2e46tqF9lzAZa1YhRTmeSDIy2bSJ3QQv
         cpO+XymR4a3QBZCiYH8ZA3tEVwm8ePmEt4JxxHnY06wshaLXhOcJlBukjDEosjjmxnLZ
         WBB7QZKaljdfB79sJNEq9jJA133ZTn2FVnu4Wxl4yRrWkVDGdOhtTRIFgBW0UzEczSua
         P68tpfCp6OsUhqFKdIjnqiLkF4UPSN9AaPTtFJk/qgIXqY5mNbogCpvhXzk3SGyLXcy3
         +yUMvMFCLIkzloWQ+RoJRA2z39bloNrrTqZmHYvVt3XrFUuPCyHdFOirRX/4NTXZpz1t
         nELw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 047/122] netlink: ensure to loop over all netns in genlmsg_multicast_allns()
Date: Wed,  7 Mar 2018 11:37:39 -0800
Message-Id: <20180307191735.784440687@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309132128532441?=
X-GMAIL-MSGID: =?utf-8?q?1594309132128532441?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicolas Dichtel <nicolas.dichtel@6wind.com>


[ Upstream commit cb9f7a9a5c96a773bbc9c70660dc600cfff82f82 ]

Nowadays, nlmsg_multicast() returns only 0 or -ESRCH but this was not the
case when commit 134e63756d5f was pushed.
However, there was no reason to stop the loop if a netns does not have
listeners.
Returns -ESRCH only if there was no listeners in all netns.

To avoid having the same problem in the future, I didn't take the
assumption that nlmsg_multicast() returns only 0 or -ESRCH.

Fixes: 134e63756d5f ("genetlink: make netns aware")
CC: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netlink/genetlink.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

--- a/net/netlink/genetlink.c
+++ b/net/netlink/genetlink.c
@@ -1081,6 +1081,7 @@ static int genlmsg_mcast(struct sk_buff
 {
 	struct sk_buff *tmp;
 	struct net *net, *prev = NULL;
+	bool delivered = false;
 	int err;
 
 	for_each_net_rcu(net) {
@@ -1092,14 +1093,21 @@ static int genlmsg_mcast(struct sk_buff
 			}
 			err = nlmsg_multicast(prev->genl_sock, tmp,
 					      portid, group, flags);
-			if (err)
+			if (!err)
+				delivered = true;
+			else if (err != -ESRCH)
 				goto error;
 		}
 
 		prev = net;
 	}
 
-	return nlmsg_multicast(prev->genl_sock, skb, portid, group, flags);
+	err = nlmsg_multicast(prev->genl_sock, skb, portid, group, flags);
+	if (!err)
+		delivered = true;
+	else if (err != -ESRCH)
+		goto error;
+	return delivered ? 0 : -ESRCH;
  error:
 	kfree_skb(skb);
 	return err;
