Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D13C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 19:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C11A121872
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 19:42:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="RyPm2Z/h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729875AbfBATm1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 14:42:27 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38760 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729332AbfBATm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 14:42:27 -0500
Received: by mail-pg1-f194.google.com with SMTP id g189so3405551pgc.5
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 11:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ikkrNAAb5W6LlYZAOE4T04sldz3VVYnPcJ+f/96f/sI=;
        b=RyPm2Z/hmsrjwWW9fGANcB5l4A9O0xjaMrGtm4fNLkUGrLEvL1Dsuo1kKqDhbl4mcN
         a0Q6+mFSHblqyIW5ojbBFTuJksGUiWv4Mejq19BQoun6WF3aTyc1lXmImxft5CjOGD+F
         dcuruJ5tchXCm9NvYXkHDfAf3p4y4seIG9U/Kq6PcaCuBq1UNux38WTAPVbyfd8ERNzq
         VljU5NBS57lGV7eR3YJyvaOecYTL+Kblez4Rek387mo8BUq5ufpL6gnLZJWNAhqnnjML
         +yk7LBo5D/BktMnwBSbHncnAi1XW1KCyvIb01y/YBXSaefePQJnZXoyS4MzNOSvy+W8M
         0QkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ikkrNAAb5W6LlYZAOE4T04sldz3VVYnPcJ+f/96f/sI=;
        b=dqZYiqi4n4VHsJalOwHH6PSSH9i9175BpgLTju6B43H9h0um1mbUTHg64PAYmVHrxf
         Sl3En5ojz4n2KNxAfxIKHC48JgCJ74w3z/Dirk4Xsr66nP57PH+22KaV+Ysm5281T/EK
         +pJroZBlqzVxpGpFl150NXSe0TSX/diEcQEDDh+84X2xakS8Ahs4FkdjUIYLe7DdIvcE
         fUXz/3x1g1ief4VeX3r2Gimp3aN2TKo1aRaHkjZ7zMWbrD4RujLs18hy9Ji0bwAbs7z5
         hsvFrBpp8a5TayfqwhRlJqemon8fGCr96hrhrB5rERV4xNynkgPUfAnBM4iMKgalm3Yn
         8lwQ==
X-Gm-Message-State: AJcUukc8I+HD4HXIBC8UtiP/DtEe97dc165HxB9aiYPj8CcOB/e/+Li5
        2QMQKoCh8OVigsc8I/V3PmcfPdMzOQE=
X-Google-Smtp-Source: ALg8bN4iktMfMqLSre8tNeSNvw3QP0+jSdwPVMDbUZk7UhaN6hD62m2/n6PrzDde1d4bwKjnv6LU+A==
X-Received: by 2002:a62:6b8a:: with SMTP id g132mr41043441pfc.201.1549050145483;
        Fri, 01 Feb 2019 11:42:25 -0800 (PST)
Received: from nebulus.mtv.corp.google.com ([2620:0:1000:1612:b4fb:6752:f21f:3502])
        by smtp.gmail.com with ESMTPSA id f13sm9721125pgq.82.2019.02.01.11.42.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 11:42:24 -0800 (PST)
From:   Mark Salyzyn <salyzyn@android.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Salyzyn <salyzyn@android.com>,
        Ronen Arad <ronen.arad@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Dmitry Safonov <dima@arista.com>,
        David Ahern <dsahern@gmail.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Andrei Vagin <avagin@virtuozzo.com>,
        Li RongQing <lirongqing@baidu.com>, YU Bo <tsu.yubo@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>, netdev@vger.kernel.org
Subject: stable 3.18 backport: netlink: Trim skb to alloc size to avoid MSG_TRUNC
Date:   Fri,  1 Feb 2019 11:41:57 -0800
Message-Id: <20190201194211.44372-1-salyzyn@android.com>
X-Mailer: git-send-email 2.20.1.611.gfbb209baf1-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Direct this upstream db65a3aaf29ecce2e34271d52e8d2336b97bd9fe sha to
stable 3.18.  This patch addresses a race condition where a call to

 nlk->max_recvmsg_len = max(nlk->max_recvmsg_len, len);
 nlk->max_recvmsg_len = min_t(size_t, nlk->max_recvmsg_len,

one thread in-between another thread:

 skb = netlink_alloc_skb(sk,

and

 skb_reserve(skb, skb_tailroom(skb) -
             nlk->max_recvmsg_len);

in netlink_dump.  The result can be a negative value and will cause
a kernel panic ad BUG at net/core/skbuff.c because the negative value
turns into an extremely large positive value.

Original commit:

netlink_dump() allocates skb based on the calculated min_dump_alloc or
a per socket max_recvmsg_len.
min_alloc_size is maximum space required for any single netdev
attributes as calculated by rtnl_calcit().
max_recvmsg_len tracks the user provided buffer to netlink_recvmsg.
It is capped at 16KiB.
The intention is to avoid small allocations and to minimize the number
of calls required to obtain dump information for all net devices.

netlink_dump packs as many small messages as could fit within an skb
that was sized for the largest single netdev information. The actual
space available within an skb is larger than what is requested. It could
be much larger and up to near 2x with align to next power of 2 approach.

Allowing netlink_dump to use all the space available within the
allocated skb increases the buffer size a user has to provide to avoid
truncaion (i.e. MSG_TRUNG flag set).

It was observed that with many VLANs configured on at least one netdev,
a larger buffer of near 64KiB was necessary to avoid "Message truncated"
error in "ip link" or "bridge [-c[ompressvlans]] vlan show" when
min_alloc_size was only little over 32KiB.

This patch trims skb to allocated size in order to allow the user to
avoid truncation with more reasonable buffer size.

Signed-off-by: Ronen Arad <ronen.arad@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>

(cherry pick commit db65a3aaf29ecce2e34271d52e8d2336b97bd9fe)
Signed-off-by: Mark Salyzyn <salyzyn@android.com>
---
 net/netlink/af_netlink.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 50096e0edd8e..57d9a72f8b6d 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1977,6 +1977,7 @@ static int netlink_dump(struct sock *sk)
 	struct nlmsghdr *nlh;
 	struct module *module;
 	int err = -ENOBUFS;
+	int alloc_min_size;
 	int alloc_size;
 
 	mutex_lock(nlk->cb_mutex);
@@ -1985,9 +1986,6 @@ static int netlink_dump(struct sock *sk)
 		goto errout_skb;
 	}
 
-	cb = &nlk->cb;
-	alloc_size = max_t(int, cb->min_dump_alloc, NLMSG_GOODSIZE);
-
 	if (atomic_read(&sk->sk_rmem_alloc) >= sk->sk_rcvbuf)
 		goto errout_skb;
 
@@ -1996,22 +1994,34 @@ static int netlink_dump(struct sock *sk)
 	 * to reduce number of system calls on dump operations, if user
 	 * ever provided a big enough buffer.
 	 */
+	cb = &nlk->cb;
+	alloc_min_size = max_t(int, cb->min_dump_alloc, NLMSG_GOODSIZE);
+
 	if (alloc_size < nlk->max_recvmsg_len) {
-		skb = netlink_alloc_skb(sk,
-					nlk->max_recvmsg_len,
-					nlk->portid,
+		alloc_size = nlk->max_recvmsg_len;
+		skb = netlink_alloc_skb(sk, alloc_size, nlk->portid,
 					(GFP_KERNEL & ~__GFP_WAIT) |
 					__GFP_NOWARN | __GFP_NORETRY);
-		/* available room should be exact amount to avoid MSG_TRUNC */
-		if (skb)
-			skb_reserve(skb, skb_tailroom(skb) -
-					 nlk->max_recvmsg_len);
 	}
-	if (!skb)
+	if (!skb) {
+		alloc_size = alloc_min_size;
 		skb = netlink_alloc_skb(sk, alloc_size, nlk->portid,
 					(GFP_KERNEL & ~__GFP_WAIT));
+	}
 	if (!skb)
 		goto errout_skb;
+
+	/* Trim skb to allocated size. User is expected to provide buffer as
+	 * large as max(min_dump_alloc, 16KiB (mac_recvmsg_len capped at
+	 * netlink_recvmsg())). dump will pack as many smaller messages as
+	 * could fit within the allocated skb. skb is typically allocated
+	 * with larger space than required (could be as much as near 2x the
+	 * requested size with align to next power of 2 approach). Allowing
+	 * dump to use the excess space makes it difficult for a user to have a
+	 * reasonable static buffer based on the expected largest dump of a
+	 * single netdev. The outcome is MSG_TRUNC error.
+	 */
+	skb_reserve(skb, skb_tailroom(skb) - alloc_size);
 	netlink_skb_set_owner_r(skb, sk);
 
 	if (nlk->dump_done_errno > 0)
-- 
2.20.1.611.gfbb209baf1-goog

