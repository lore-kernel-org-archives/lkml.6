Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 007B5C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 22:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C46152146F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 22:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f3aDYoTF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731818AbfBRWaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 17:30:19 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44280 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729048AbfBRWaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 17:30:18 -0500
Received: by mail-ot1-f68.google.com with SMTP id g1so30881915otj.11;
        Mon, 18 Feb 2019 14:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=37AB+jKFBj4540g7viQ3gpj5b0bjpTaQ1GOL6HQCd1o=;
        b=f3aDYoTF7zPsUTHFgcpAnYz2xMJDSxyxyVR4zMkvoSsYjzZwCz9p8RM/UatbB99dBk
         MpiXloYYxYRy/iusGIRGZIJSIAMarEnpqcYgPambThmPzb2SFtaqEwCWb8t1CEizLDW5
         CElRBvsICM/UogGbs/g6rtIHbf+mhO66USygXb0QhLmtqEhLQIK5g/PpGOoLQXMIA+TQ
         Dy7hE8UZAulpfkcVOa7NFzZms5uR01S3jQ6pv6uLjpWHIxLw8ecrtag/WyQ1vck063xa
         CyKJ+Gu2Gdq7razrJkLmF1Xr06puB72jJBTk7OT54oH1FoCqVdMuip3y3g+AjXhUx2PX
         gI+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=37AB+jKFBj4540g7viQ3gpj5b0bjpTaQ1GOL6HQCd1o=;
        b=IJsLBW6M+J/r9LF32sZ4SRDSPR5ywlBPo0md/7y/b6LPneK4F5Xg7XWx2qEvvxO2FL
         TbqtQHCF+3F5A1EcLbLnbWgts+/TZ33ZO47aINXBDaq7lD9xB3rF6MZ6NcSAqn9mu3S+
         R54tzWjG0QurllOWZsIOuYe2ur5vRdJjlEtMECsq99pR29vZ6D9bltGJk59wYAN5M3m0
         UcO3CS733b4W52abGZkEyxreSJj7ZMuKWH9tPsv8f5gGTjnxvprA/bSaTQ/dq4bXE7jZ
         Od6QjT4n7qo/opvsK8tHuU80KEPa/rmuv2H8NqI7OPsD2XRgyELnz8khkSHcUvx/UHTo
         M0Ag==
X-Gm-Message-State: AHQUAubSDct1aeCg52RbV+jChZA2/lvWomOUBzvDLeK0AFY+zuawLkxt
        Hsv/m6Zp7rRA8ucl3yl1YpUZoVH+
X-Google-Smtp-Source: AHgI3IbwK/kzB6IDvR9N8QtCzOEwIbbVQskA+d7gNpppfKY1Bvz/juRLzvRNRLDUMMkMe+XL2Us0kQ==
X-Received: by 2002:aca:7201:: with SMTP id p1mr670614oic.159.1550529016637;
        Mon, 18 Feb 2019 14:30:16 -0800 (PST)
Received: from localhost.localdomain (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.gmail.com with ESMTPSA id v20sm5539733oto.31.2019.02.18.14.30.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 14:30:15 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, frank-w@public-files.de,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v4.15..v4.19] net: dsa: Fix NPD checking for br_vlan_enabled()
Date:   Mon, 18 Feb 2019 14:30:11 -0800
Message-Id: <20190218223011.4824-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is possible for the DSA slave network device not to be part of a
bridge, yet have an upper device like a VLAN device be part of a bridge.
When that VLAN device is enslaved, since it does not define any
switchdev_ops, we will recurse down to the lower/physical port device,
call switchdev_port_obj_add() with a VLAN, and here we will check
br_vlan_enabled() on a NULL dp->bridge_dev, thus causing a NULL pointer
de-reference.

This is no longer a problem upstream after commit d17d9f5e5143
("switchdev: Replace port obj add/del SDO with a notification").

Fixes: 2ea7a679ca2a ("net: dsa: Don't add vlans when vlan filtering is disabled")
Reported-by: Frank Wunderlich <frank-w@public-files.de>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
David,

This affects v4.15..v4.19, but not v5.0-rc1 can you still queue this up
for -stable? Thanks!

 net/dsa/port.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/dsa/port.c b/net/dsa/port.c
index ed0595459df1..792a13068c50 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -255,7 +255,7 @@ int dsa_port_vlan_add(struct dsa_port *dp,
 	if (netif_is_bridge_master(vlan->obj.orig_dev))
 		return -EOPNOTSUPP;
 
-	if (br_vlan_enabled(dp->bridge_dev))
+	if (dp->bridge_dev && br_vlan_enabled(dp->bridge_dev))
 		return dsa_port_notify(dp, DSA_NOTIFIER_VLAN_ADD, &info);
 
 	return 0;
@@ -273,7 +273,7 @@ int dsa_port_vlan_del(struct dsa_port *dp,
 	if (netif_is_bridge_master(vlan->obj.orig_dev))
 		return -EOPNOTSUPP;
 
-	if (br_vlan_enabled(dp->bridge_dev))
+	if (dp->bridge_dev && br_vlan_enabled(dp->bridge_dev))
 		return dsa_port_notify(dp, DSA_NOTIFIER_VLAN_DEL, &info);
 
 	return 0;
-- 
2.19.1

