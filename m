Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELu6C/S1Bd0PnTAGZTn45szYxlaAcdGw7QXeYxNJk+FipK8P7dFXK9Ms3t0yV8O1zyiNVyxY
ARC-Seal: i=1; a=rsa-sha256; t=1520451949; cv=none;
        d=google.com; s=arc-20160816;
        b=fu88o1wqy5iRznDbHOvYYP8ztcjrOxGhG8jnT7flR2e5Rcd9BXEz9W2XizoVhLENrS
         wfNMQryuGZYi2swkUZ6oqHQYQmefGS2FYm1UW8nkn4j4yLR93uutTebhKSb8GSDqcCks
         T5MxzaTEHY1kKh82L2GunWLFRsQ8hscJTF2REos78f3SvuPLbMJKIMy8gEJoWNHsnCix
         Rl9MT5Ueq4q/Uxfy9YXhlblS38inUeKAW8fUXAbrfpoLB1tg560iVojU/IoTrTZ20w+x
         vQphzMZ+Z5QQL+FfCfkZAyzQ7Au6C//e/hDsmmiWmJDXH/4PvcfGkx7b46kmheVdCNUH
         24Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=BbLQ2DiitoyeXeVDNOXaG735WU4A+RXDmzev96o+RKg=;
        b=ZHqayAhHEmsd6Rggpv729LTwgOloSfIKZeQENFtd8Jo2bOXdOuiR/T25sKn4f05k08
         rgrAfjW4syN+Z68F667STG53FIGb+mRiV0IYOgCaKcwMj804ifFJ5vmo+BCE7Z0vCiZn
         JZPPmg+Kd6vJirGIpw72Az1vsX16AhxLcNbQQzuVm9I/8Sk765lEgvQ6UiIbxLcnXoIr
         6sYAyPSM2tGvQ3sxDZLVvcu1nZ5BSdjzS7FEWJrvgz13MumZkNJV5q60rzk5cquIwhPY
         rPmoG27b4bt6JCDtG4WVF+81Bc+AuzI0p2bVhTBjwXjvAIGtpdH/X7GSCtFukJP3vyCi
         +jBw==
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
Subject: [PATCH 4.14 042/110] netlink: ensure to loop over all netns in genlmsg_multicast_allns()
Date: Wed,  7 Mar 2018 11:38:25 -0800
Message-Id: <20180307191045.128205302@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309132128532441?=
X-GMAIL-MSGID: =?utf-8?q?1594309423553194127?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
