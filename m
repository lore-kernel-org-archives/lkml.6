Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1354CC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C322720875
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="if6KkQ0Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C322720875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754476AbeGIIml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 04:42:41 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43886 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754569AbeGIIhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 04:37:07 -0400
Received: by mail-ed1-f68.google.com with SMTP id u11-v6so13258828eds.10
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 01:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AnPdz71tzpAowtCFc4wpuTxDlL40bTWT6Uy4GnWWwKQ=;
        b=if6KkQ0QREsvOX/QLboxmPCRTgFyW3Qv4UM1Q59OyYCsLO24j6HUlHSXdIOgJ0EJ17
         uB1F+1xpG/QDrcDX71kwa2R8dCCJ6Beu3uI+y0LpGYmcAS5BPcgJf/eknWru6vf9GHsv
         7SJG+C4gpXV5vk2p2jJQ1v+YBUTJYAsZ1STbs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AnPdz71tzpAowtCFc4wpuTxDlL40bTWT6Uy4GnWWwKQ=;
        b=ovHchjv60EZuajMXJpt5izgTBuJ/lSgBvD5wN0Hr9a0/qAhwdnrOGKvmQV1liZNW8K
         c099QE5yvyJuNUXIDdQJ5Kqdjhzpm/TY5YMuNKkRtyrJMBuPiSnTf96T6k1KLxQoedgZ
         0gB4RW8gFyOnj9HGX+ciccTil17cT6QLw3GYmq64OmfTiH+DHN7oSwuzECsJbWQU3MjI
         EgOFXrdq/HtsGhLk6Lx5WJmaABqHTBcBN24twUcRFBU0SgOohO4gF6+Cbykra4SWi3ug
         9tfb1iO5FrPO4RQd7rg5rro4YCRqXw9F58O7VOhs6lr4RjHNH4PH/6V6hN2fqudoqrAr
         O3gA==
X-Gm-Message-State: APt69E1K1RlWRYlyWQQSSyAdlnn6c2GQNQGYxRGMNxYK6u8AH7+Xe+YE
        uLESRfHIJIfB1NzIHftXtpGTvC/O
X-Google-Smtp-Source: AAOMgpeN3GebpRkcugROTz5kjaFmLrr6CTLi4BbRGaqRZhcs8U2Vob34CgbrZScqv9ob2Fos+AXUWQ==
X-Received: by 2002:a50:8f42:: with SMTP id 60-v6mr20618263edy.248.1531125426223;
        Mon, 09 Jul 2018 01:37:06 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:5628:0:496f:7dc5:66d7:a057])
        by smtp.gmail.com with ESMTPSA id 8-v6sm340067edv.77.2018.07.09.01.37.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 01:37:05 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Subject: [PATCH 08/12] netdev: use for_each_if
Date:   Mon,  9 Jul 2018 10:36:46 +0200
Message-Id: <20180709083650.23549-8-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180709083650.23549-1-daniel.vetter@ffwll.ch>
References: <20180709083650.23549-1-daniel.vetter@ffwll.ch>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoids complaints from gcc about ambiguous else clauses.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org
---
 include/linux/netdevice.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 3ec9850c7936..cdffe7f88dbe 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2476,7 +2476,7 @@ extern rwlock_t				dev_base_lock;		/* Device list lock */
 	list_for_each_entry_continue_rcu(d, &(net)->dev_base_head, dev_list)
 #define for_each_netdev_in_bond_rcu(bond, slave)	\
 		for_each_netdev_rcu(&init_net, slave)	\
-			if (netdev_master_upper_dev_get_rcu(slave) == (bond))
+			for_each_if (netdev_master_upper_dev_get_rcu(slave) == (bond))
 #define net_device_entry(lh)	list_entry(lh, struct net_device, dev_list)
 
 static inline struct net_device *next_net_device(struct net_device *dev)
-- 
2.18.0

