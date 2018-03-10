Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvzn1yRP3pEsdzuTWdayuxzd6GpuGghGFysHOQkhgWjutprOkHySdHS1U5WTyYHx3dsBHFa
ARC-Seal: i=1; a=rsa-sha256; t=1520641321; cv=none;
        d=google.com; s=arc-20160816;
        b=vf0NW154Km3QjgcEiMivgpqyaYgdsip5J2nqgmR8yVYCP8ycHO0UTQLENwNa4jwvIm
         YZ0qJiG0sNep/wudR0BRVi5MOAPydbBE+utE21R8+nSFOPiTRv569xNRkLhagSBBh8tm
         fmAmHEa2U3nTgMcW8T1V2E/11mRWElGuAmQf6U7eN8HMbF07bvV587vogmkpqOzYQyEL
         bohZZPnRVw0zafAiGM4viDFO5Xp98UAT7pSA6Fa4T9FNmEoTkCTbyjdbbFUURLtz/+5+
         dqV+FqZcdpyjj9/6aRyJVwFCgaDkNTRYXrJeBvS2Ip8FnWkn0mrV/yHS2Rj+Yk7saeGz
         5scA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=8+neLeWGdBi5aDTighUoRKT5RO+6S9pjg8Uv7nOc6Dc=;
        b=rRdez4Q3XRxkbvyVpFTuLmauHtlGj3edO0YpVpHorjvEuctWpqqwaZKG3x36Q6fYEu
         ZYWYfrEb6ZQJdBlfheLN3FMaxqw9cIkQKCBpI6k7hCBKnqySbGu58brn+fEI3ZAcn9iQ
         HdED0ei9nO6sTBNTDQ7gzriLVWLA6yTc7fc4mFyYd7VrDdkubBDISf7qNuR7Tdc5gzV1
         KgcET2niwyM44t25ZJUEP864KJHDynGAXmHwZUXGlkxrlWeHYPBarOCHpXBCCyHCHBFS
         w2O8Y7qdWodIpe39wcUNwhz/Am8xXqzSEE7w490Sd4wVootnlCTPCw9Wh71lbyaqdkiX
         2gsQ==
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
Subject: [PATCH 4.9 39/65] netlink: ensure to loop over all netns in genlmsg_multicast_allns()
Date: Fri,  9 Mar 2018 16:18:39 -0800
Message-Id: <20180310001828.152582509@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001824.927996722@linuxfoundation.org>
References: <20180310001824.927996722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594507839258352822?=
X-GMAIL-MSGID: =?utf-8?q?1594507994503846227?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1103,6 +1103,7 @@ static int genlmsg_mcast(struct sk_buff
 {
 	struct sk_buff *tmp;
 	struct net *net, *prev = NULL;
+	bool delivered = false;
 	int err;
 
 	for_each_net_rcu(net) {
@@ -1114,14 +1115,21 @@ static int genlmsg_mcast(struct sk_buff
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
