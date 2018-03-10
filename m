Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvS9AANR9Q145cKRYiR5c4KbaeTPA5oWDXrD5C/cKfvfEqai1ri/ix5fgqTnTXYmefPJPJ5
ARC-Seal: i=1; a=rsa-sha256; t=1520641255; cv=none;
        d=google.com; s=arc-20160816;
        b=Qa/UkQG06hCWrfaP4mxUsqdURxyaiGL1rXq4vry5dUz/YgpvwgUKom3WckHCU5L/k1
         jGXGPMKbHd3iJdpp6k2D5gGjxOXG8fbXh4/GCuU1rNDRNSAvBEdfbxkvTlZwnq7JPPAR
         eByvusQvcaG1DsLhqrNJh+C4hnxC17Z6rBBuCKWU212dHRF7ryLmwyZxa0MO20I0q0xT
         RX12aDqUpu4xH0846e3SduFGe9bEVqpXv9C/DVCl29JWheaqNTqk+0AK/3TFtmVkPetF
         TyNCCAq/nBHHS4hdL6BVDfalmEvrCcImG67ZE3kZatA4tgiYkGADtHW8Kz9SXYKn3v1a
         sLPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=2T2Xac1KsBmwQiJJv1amX+KVQark1oahClZHuxMJDCI=;
        b=aDR1NuF9YV0+MBQWolJZnxWU1aMHZpxUHgCQDQjwK4KohLNgVWoGj3Z9hnDCQkfFfG
         19Y4LavRm9MGIN7tlr65rtewLAEPfqc3W5X4E1Ybx1PzZL+RMpm3LKK0Hv38/mJIpjl0
         7CfvvkbOTFIr1H3tijJalOll5FCxAOj2BZvhtnIjZ+DHz5ghCybwDMdr7R/BXIoVwXNd
         RhSI6MB7V+dOBUy8f04oWXYr7kzQdpMw7FJhnZF0Gnfe4Xe37kux0Xu7LSgqGKgoFKjc
         TJixxGpugMJngP5JUNHqqawrlA2rnF/t1Lp5SXSx1fuQ/6zaWo4p0mpavWT4wuQWg9xl
         q23g==
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
Subject: [PATCH 4.4 24/36] netlink: ensure to loop over all netns in genlmsg_multicast_allns()
Date: Fri,  9 Mar 2018 16:18:40 -0800
Message-Id: <20180310001808.681346858@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001807.213987241@linuxfoundation.org>
References: <20180310001807.213987241@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594507839258352822?=
X-GMAIL-MSGID: =?utf-8?q?1594507925059052327?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1118,6 +1118,7 @@ static int genlmsg_mcast(struct sk_buff
 {
 	struct sk_buff *tmp;
 	struct net *net, *prev = NULL;
+	bool delivered = false;
 	int err;
 
 	for_each_net_rcu(net) {
@@ -1129,14 +1130,21 @@ static int genlmsg_mcast(struct sk_buff
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
