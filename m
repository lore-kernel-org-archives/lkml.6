Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88058C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4510921746
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UlKW44K/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4510921746
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbeH0MIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 08:08:18 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43957 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727118AbeH0MIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 08:08:16 -0400
Received: by mail-lj1-f195.google.com with SMTP id m84-v6so11587615lje.10;
        Mon, 27 Aug 2018 01:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OSgQNn2jsMA2girm3EvRrD5oHLWuMlB9P4psrBtfdr8=;
        b=UlKW44K/wZEnGfNhb9Gj+5CEHuztSf1puhBrdisAMQxGbB4o4v/Tcxv2jddXyOwuwy
         buLn8hnNgy4WyhxjIzdZmOww9ijeaTgi/rQUfpK5xGUdSL3za1TCA4s9b6thIUAuDfq6
         2Ru+Fqv/McLBOXMdEZTjx+fDz/1NZk/v7mvFzYTpKzI+c6YI6WPdVMrR5hvu7a7BlsJY
         rtF/Bsgn/62+YFE1m/QcX3uECQsit++Vg9A6uUaSo9jQzXRn1CH6cJlObgeXbvk/eFVu
         3l3YEsAasxUZHUObWxWEE+oeUsQ/56UbDfEt2tmaG4OTT475HjgylGao+y6EkS44C6Ex
         BtSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=OSgQNn2jsMA2girm3EvRrD5oHLWuMlB9P4psrBtfdr8=;
        b=kh+HRj+s9ALYguLR5hw7gcjeSyjLqw25l8nYlU976d8+q5hECcXY48lwh3kG2mq8DP
         IC1CNMIrvdnU6UfqXGGc+IgJ7gQk9sZnNthS76c+di5ZW2A+f1nXlsCiSFwj0jGrbsX7
         DRlT/paxw1iDskAkOWAe1QvwzlQ9zMUcrm+aenh/dz/X9/ldrTb/oxkPUM7kAEE0+URI
         s7AbWE2Iha/IVsWWd8F4eUItU976dF5Sj/2aAGOCnKyyB8tUU+lylZfiSAaSTQ1ZmhzS
         5voDWBAbMQEzmmioICiALx2TywzbqToiaQY5GcS5EkDWeMTm0PIM2SrD3aD2quDj+vp4
         1ELg==
X-Gm-Message-State: APzg51CquuOGh3ir7OIo22g0xjdo39IJmnO41knKWugEW9EpRv8BJW8r
        kFOmVxlwXbcSLByuidv/rOQ=
X-Google-Smtp-Source: ANB0VdZgoy1YUgvl0x0mDvinkTeFPRgv4hgJ2J+Ej0EOw9DSlaCszYefxQfQQTvweKtqZqI/1QsV1A==
X-Received: by 2002:a2e:9941:: with SMTP id r1-v6mr7445948ljj.53.1535358158432;
        Mon, 27 Aug 2018 01:22:38 -0700 (PDT)
Received: from xi.terra ([85.230.190.116])
        by smtp.gmail.com with ESMTPSA id p4-v6sm2780133lfj.49.2018.08.27.01.22.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 01:22:36 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@xi.terra>)
        id 1fuCn6-0005sh-SK; Mon, 27 Aug 2018 10:22:28 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        stable <stable@vger.kernel.org>,
        Carlo Caione <carlo@endlessm.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 4/9] mmc: meson-mx-sdio: fix OF child-node lookup
Date:   Mon, 27 Aug 2018 10:21:48 +0200
Message-Id: <20180827082153.22537-5-johan@kernel.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180827082153.22537-1-johan@kernel.org>
References: <20180827082153.22537-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new of_get_compatible_child() helper to lookup the slot child
node instead of using of_find_compatible_node(), which searches the
entire tree from a given start node and thus can return an unrelated
(i.e. non-child) node.

This also addresses a potential use-after-free (e.g. after probe
deferral) as the tree-wide helper drops a reference to its first
argument (i.e. the node of the device being probed).

While at it, also fix up the related slot-node reference leak.

Fixes: ed80a13bb4c4 ("mmc: meson-mx-sdio: Add a driver for the Amlogic Meson8 and Meson8b SoCs")
Cc: stable <stable@vger.kernel.org>     # 4.15
Cc: Carlo Caione <carlo@endlessm.com>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/mmc/host/meson-mx-sdio.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/meson-mx-sdio.c b/drivers/mmc/host/meson-mx-sdio.c
index 09cb89645d06..2cfec33178c1 100644
--- a/drivers/mmc/host/meson-mx-sdio.c
+++ b/drivers/mmc/host/meson-mx-sdio.c
@@ -517,19 +517,23 @@ static struct mmc_host_ops meson_mx_mmc_ops = {
 static struct platform_device *meson_mx_mmc_slot_pdev(struct device *parent)
 {
 	struct device_node *slot_node;
+	struct platform_device *pdev;
 
 	/*
 	 * TODO: the MMC core framework currently does not support
 	 * controllers with multiple slots properly. So we only register
 	 * the first slot for now
 	 */
-	slot_node = of_find_compatible_node(parent->of_node, NULL, "mmc-slot");
+	slot_node = of_get_compatible_child(parent->of_node, "mmc-slot");
 	if (!slot_node) {
 		dev_warn(parent, "no 'mmc-slot' sub-node found\n");
 		return ERR_PTR(-ENOENT);
 	}
 
-	return of_platform_device_create(slot_node, NULL, parent);
+	pdev = of_platform_device_create(slot_node, NULL, parent);
+	of_node_put(slot_node);
+
+	return pdev;
 }
 
 static int meson_mx_mmc_add_host(struct meson_mx_mmc_host *host)
-- 
2.18.0

