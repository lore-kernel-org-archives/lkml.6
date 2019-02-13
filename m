Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C52DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F068F222CC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:07:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IHJRj4jE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403984AbfBMWHW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 17:07:22 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34750 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729139AbfBMWHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 17:07:21 -0500
Received: by mail-pl1-f195.google.com with SMTP id w4so1882112plz.1;
        Wed, 13 Feb 2019 14:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y8cTug1MK//k9Db5o5+0BQipNr3buFiSVSYrdmVTLt0=;
        b=IHJRj4jEFq6ttIG7knysvmaiyUJgYNGoCoMmFI1eherIlPsaRePnt5vV/UHbU4CqoJ
         UIFty1Izaiou73nHPXGjQDYYME01snLmUqZxxYV/pOYs6BMSoByJLCsjyAihKIvxrdWZ
         n2SSeu9pze3pvs3+ti5nyqRcTF0dvuNgwqcThng4OOpr4vyHLMRR+t/McZQtsa6jRAWl
         TGwnILVRNckBxk7As2SjqGYsWRv8MXPVyPiVO86/4dARMeLRdN19gSu2e3gY5ZR8qvyt
         jOYpF6idK+0Yi7OJVDTGC2UKaRyHw/wy5/Vd3PwwuGzrOrH7VWeUixVSN6ihfSvWqN2m
         nHGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Y8cTug1MK//k9Db5o5+0BQipNr3buFiSVSYrdmVTLt0=;
        b=YN0b8+l71J5pXXo29/QMOE/vSYmtAyAKxSocv5l5db2T8mX1lxhUmYZuXdRK38OrBi
         4LkV03Kl3ZV6R2VBYMbSs9UWII2XHy5hjcNWLo4ukIhKDNMdibI3iptViQt0vU+TDk8r
         5alRNmCStFwrZpB9N2ceJwh8K5FcCyF9vDna1hhEsFBUmcPaiMEnqXrUyJJFyjuLjPAT
         oarRNy7UI3MR2Ld4jidX38RilAQDblmk5Vbrz12iGtBQ5TmT5GxN4mcYq0Zn8TgFl9tB
         mzCWr9+Ra5Yh6gsjj5nibZeXfe4z4DJjN0gb38GTViMDCbjZY+VeScw8zLds/jSEXp8j
         VJ4g==
X-Gm-Message-State: AHQUAuala4MbYsXHwtzsvfnADqPNLhWN2EiqYNDqVn6J9l0tsLB4vvVe
        1cpRzw1D++N6f+NlqcNF+qkJ74UY
X-Google-Smtp-Source: AHgI3IYE3SNAmEdjIwKFDvIIAD0/C+eZ/PmmxMUEDSLiSKDxoU7q6yjp2u/AvXuOPwz/hIxYEOxPyw==
X-Received: by 2002:a17:902:8643:: with SMTP id y3mr467232plt.80.1550095640066;
        Wed, 13 Feb 2019 14:07:20 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id o1sm383735pgn.63.2019.02.13.14.07.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 14:07:19 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE),
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next 2/9] net: switchdev: Add PORT_PRE_BRIDGE_FLAGS
Date:   Wed, 13 Feb 2019 14:06:31 -0800
Message-Id: <20190213220638.1552-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190213220638.1552-1-f.fainelli@gmail.com>
References: <20190213220638.1552-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for removing switchdev_port_attr_get(), introduce
PORT_PRE_BRIDGE_FLAGS which will be called through
switchdev_port_attr_set(), in the caller's context (possibly atomic) and
which must be checked by the switchdev driver in order to return whether
the operation is supported or not.

This is entirely analoguous to how the BRIDGE_FLAGS_SUPPORT works,
except it goes through a set() instead of get().

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 include/net/switchdev.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index 5e87b54c5dc5..de72b0a3867f 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -46,6 +46,7 @@ enum switchdev_attr_id {
 	SWITCHDEV_ATTR_ID_PORT_STP_STATE,
 	SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS,
 	SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT,
+	SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS,
 	SWITCHDEV_ATTR_ID_PORT_MROUTER,
 	SWITCHDEV_ATTR_ID_BRIDGE_AGEING_TIME,
 	SWITCHDEV_ATTR_ID_BRIDGE_VLAN_FILTERING,
@@ -61,7 +62,7 @@ struct switchdev_attr {
 	void (*complete)(struct net_device *dev, int err, void *priv);
 	union {
 		u8 stp_state;				/* PORT_STP_STATE */
-		unsigned long brport_flags;		/* PORT_BRIDGE_FLAGS */
+		unsigned long brport_flags;		/* PORT_{PRE}_BRIDGE_FLAGS */
 		unsigned long brport_flags_support;	/* PORT_BRIDGE_FLAGS_SUPPORT */
 		bool mrouter;				/* PORT_MROUTER */
 		clock_t ageing_time;			/* BRIDGE_AGEING_TIME */
-- 
2.17.1

