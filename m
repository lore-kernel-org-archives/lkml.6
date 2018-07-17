Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D70ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 04:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E917720877
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 04:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bD3/zPmr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E917720877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbeGQElL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 00:41:11 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:41373 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbeGQElK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 00:41:10 -0400
Received: by mail-pl0-f65.google.com with SMTP id w8-v6so16239216ply.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 21:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=bS/dGDtps74Dnu1W9AyHmqv48Koii476PtexhRHToM8=;
        b=bD3/zPmr+hQdSFXzjePpWRnWBIwFUjFdZIV3W0mImxBbvPk4Z2M/a5SmfVOQd+SDXA
         RTaKnv4Kd+GlsxqN/7Anklhj+96PR86TBJPPm4VI0xg1LBkKHg8I4T7Vps5auhA02ggc
         YQlzATzio5u5F3vxVvxF9peckOtLacwIMz5jA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=bS/dGDtps74Dnu1W9AyHmqv48Koii476PtexhRHToM8=;
        b=QPU7me/4KWOLaPPbccyvHtRK6SDzxebJAEtRBhAPs73RZH71hNaJKsCZnMmdxGj33K
         Ev5pz9/fpOiurTr0LtXhEgJhhNhQ1GrEJDNq8jKBYbFoIkQpdJXvGN0c+34hHuu6hXb5
         xAxK5Un7pXFlBhckCj3Vpnly3xQWwficzlhvw/QIgGyGjFrbp20+JkmvJx6aQL8bX7lz
         zuIAm14W5NaLpdX9JFnkxvaj6H4jv3wf9IrOqf2bj6AIB/QzWpGvwVkb0BzQNNrp6hvN
         8tclXW7cC+OIF4kENC68T9paE8wiyjFMt2T4ZL41sPdzbIQkO6vJ4yvDpP/wvReu3RVs
         npLA==
X-Gm-Message-State: AOUpUlFvZZt3fZDlJQvbFodI7zOlsnL1mQlnACR0DDg86DdBycer/myo
        68GSSCTuhV+X3c8qaHw5clGc4g==
X-Google-Smtp-Source: AAOMgpdKn81PyTHz5ZX/Gjt4GFiJJJwlexFQb5agMQyHArX044DMEgdbIHuExdsZto89GoZz7vL1OA==
X-Received: by 2002:a17:902:a40b:: with SMTP id p11-v6mr19293772plq.228.1531800638009;
        Mon, 16 Jul 2018 21:10:38 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id h69-v6sm12840738pfh.13.2018.07.16.21.10.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 21:10:36 -0700 (PDT)
Date:   Mon, 16 Jul 2018 21:10:34 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        David Laight <David.Laight@aculab.com>
Subject: [PATCH v2] net: dsa: Remove VLA usage
Message-ID: <20180717041034.GA37382@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Salvatore Mesoraca <s.mesoraca16@gmail.com>

We avoid 2 VLAs by using a pre-allocated field in dsa_switch. We also
try to avoid dynamic allocation whenever possible (when using fewer than
bits-per-long ports, which is the common case).

Link: http://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
Link: http://lkml.kernel.org/r/20180505185145.GB32630@lunn.ch
Signed-off-by: Salvatore Mesoraca <s.mesoraca16@gmail.com>
[kees: tweak commit subject and message slightly]
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/net/dsa.h |  3 +++
 net/dsa/dsa2.c    | 14 ++++++++++++++
 net/dsa/switch.c  | 22 ++++++++++------------
 3 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index fdbd6082945d..461e8a7661b7 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -259,6 +259,9 @@ struct dsa_switch {
 	/* Number of switch port queues */
 	unsigned int		num_tx_queues;
 
+	unsigned long		*bitmap;
+	unsigned long		_bitmap;
+
 	/* Dynamically allocated ports, keep last */
 	size_t num_ports;
 	struct dsa_port ports[];
diff --git a/net/dsa/dsa2.c b/net/dsa/dsa2.c
index dc5d9af3dc80..a1917025e155 100644
--- a/net/dsa/dsa2.c
+++ b/net/dsa/dsa2.c
@@ -775,6 +775,20 @@ struct dsa_switch *dsa_switch_alloc(struct device *dev, size_t n)
 	if (!ds)
 		return NULL;
 
+	/* We avoid allocating memory outside dsa_switch
+	 * if it is not needed.
+	 */
+	if (n <= sizeof(ds->_bitmap) * 8) {
+		ds->bitmap = &ds->_bitmap;
+	} else {
+		ds->bitmap = devm_kcalloc(dev,
+					  BITS_TO_LONGS(n),
+					  sizeof(unsigned long),
+					  GFP_KERNEL);
+		if (unlikely(!ds->bitmap))
+			return NULL;
+	}
+
 	ds->dev = dev;
 	ds->num_ports = n;
 
diff --git a/net/dsa/switch.c b/net/dsa/switch.c
index b93511726069..142b294d3446 100644
--- a/net/dsa/switch.c
+++ b/net/dsa/switch.c
@@ -136,21 +136,20 @@ static int dsa_switch_mdb_add(struct dsa_switch *ds,
 {
 	const struct switchdev_obj_port_mdb *mdb = info->mdb;
 	struct switchdev_trans *trans = info->trans;
-	DECLARE_BITMAP(group, ds->num_ports);
 	int port;
 
 	/* Build a mask of Multicast group members */
-	bitmap_zero(group, ds->num_ports);
+	bitmap_zero(ds->bitmap, ds->num_ports);
 	if (ds->index == info->sw_index)
-		set_bit(info->port, group);
+		set_bit(info->port, ds->bitmap);
 	for (port = 0; port < ds->num_ports; port++)
 		if (dsa_is_dsa_port(ds, port))
-			set_bit(port, group);
+			set_bit(port, ds->bitmap);
 
 	if (switchdev_trans_ph_prepare(trans))
-		return dsa_switch_mdb_prepare_bitmap(ds, mdb, group);
+		return dsa_switch_mdb_prepare_bitmap(ds, mdb, ds->bitmap);
 
-	dsa_switch_mdb_add_bitmap(ds, mdb, group);
+	dsa_switch_mdb_add_bitmap(ds, mdb, ds->bitmap);
 
 	return 0;
 }
@@ -204,21 +203,20 @@ static int dsa_switch_vlan_add(struct dsa_switch *ds,
 {
 	const struct switchdev_obj_port_vlan *vlan = info->vlan;
 	struct switchdev_trans *trans = info->trans;
-	DECLARE_BITMAP(members, ds->num_ports);
 	int port;
 
 	/* Build a mask of VLAN members */
-	bitmap_zero(members, ds->num_ports);
+	bitmap_zero(ds->bitmap, ds->num_ports);
 	if (ds->index == info->sw_index)
-		set_bit(info->port, members);
+		set_bit(info->port, ds->bitmap);
 	for (port = 0; port < ds->num_ports; port++)
 		if (dsa_is_cpu_port(ds, port) || dsa_is_dsa_port(ds, port))
-			set_bit(port, members);
+			set_bit(port, ds->bitmap);
 
 	if (switchdev_trans_ph_prepare(trans))
-		return dsa_switch_vlan_prepare_bitmap(ds, vlan, members);
+		return dsa_switch_vlan_prepare_bitmap(ds, vlan, ds->bitmap);
 
-	dsa_switch_vlan_add_bitmap(ds, vlan, members);
+	dsa_switch_vlan_add_bitmap(ds, vlan, ds->bitmap);
 
 	return 0;
 }
-- 
2.17.1


-- 
Kees Cook
Pixel Security
