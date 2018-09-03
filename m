Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC0D1C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 18:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 988D120843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 18:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IqwcvWw5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 988D120843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbeICWYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 18:24:19 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:40269 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727271AbeICWYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 18:24:19 -0400
Received: by mail-oi0-f65.google.com with SMTP id l202-v6so2249320oig.7;
        Mon, 03 Sep 2018 11:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P8070j0pHB8FWga0Ow2mDVroSkOVwLt7/K7gOaS7NoM=;
        b=IqwcvWw5xjRsU9a6k/euqg2vuXmsZW+BrOI6gKcrP5U/+5LttCMgeJq/cBoEyiF4iN
         fdt6l5vBB/ZAeVGY0xFf044Zx1JynUidYKUmJGYAn/EyQViicVy7/7W18r1GjZY8Bwsp
         5NeQbegFUjD4z35dnRtu/qnJEyISCkvn4DyS8qRoitTHHiBjlOvMXnYhEC8jkNLCjQ8d
         e47rcLsT/TrJFgSUWRjoAhMGtSgV7rTUaquNzVDK8EywQepOVpC3XRjtgsMBhqQEbFUI
         tL0UE5YtSHGSfuafNvis7wAbXJ+lJRqKDar2kWcKdte6Y4c7daC+C3jinTRpIeGZzGb7
         VHFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P8070j0pHB8FWga0Ow2mDVroSkOVwLt7/K7gOaS7NoM=;
        b=SII0H03n2uqMqFaXnxGEQPXlfPmjBVP/STnOWUqwREHZzBEpvdI41sXhmp12r5WboL
         uypy2HnZGnrW0rwzFSVQCnRHDryvZDJESUKJZDfvz5k18hHafQ5wIHI8R7//cani5sNu
         hyiUm6Q7UfPDIfoZUoQsBdnDjl6g7o4vOl2TPt9dp6g7RoQd6kzvzW2AIOu7edK1qXJE
         fQ7P4ch5RWBCD6oYO15mm7a448H2OgqEsstPcB8TxfDScFJ5NNFDDHZu/Xy2pTOixFCQ
         J0N9uMWOiIMc9owfCywQAp1ol8nF6u2OWKNvuC3i1iXny531pLm1GmYBgBew0SyK1/SK
         jXZg==
X-Gm-Message-State: APzg51BafY1VmPda4ZvMvhzmVz1Q6D3WwX4M1lwGoA1ZvGL9dsxKN50x
        UjSjGemnylXZOdbn/8XY+A4YJwJA6oM=
X-Google-Smtp-Source: ANB0VdZpO2FfJq10Tc9XyyBRe0tbkdGETay7ed6FYojvwe8I8b/SN8T+5gmPDQRvUl1qKgrHWsjxAg==
X-Received: by 2002:aca:bdc4:: with SMTP id n187-v6mr19765754oif.3.1535997781153;
        Mon, 03 Sep 2018 11:03:01 -0700 (PDT)
Received: from nuclearis2-1.lan (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id q124-v6sm15785737oif.8.2018.09.03.11.03.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Sep 2018 11:03:00 -0700 (PDT)
From:   Alexandru Gagniuc <mr.nuke.me@gmail.com>
To:     linux-pci@vger.kernel.org, bhelgaas@google.com
Cc:     keith.busch@intel.com, alex_gagniuc@dellteam.com,
        austin_bolen@dell.com, shyam_iyer@dell.com,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Ariel Elior <ariel.elior@cavium.com>,
        everest-linux-l2@cavium.com,
        "David S. Miller" <davem@davemloft.net>,
        Michael Chan <michael.chan@broadcom.com>,
        Ganesh Goudar <ganeshgr@chelsio.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Dirk van der Merwe <dirk.vandermerwe@netronome.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
        oss-drivers@netronome.com
Subject: [PATCH 1/9] PCI: sysfs: Export available PCIe bandwidth
Date:   Mon,  3 Sep 2018 13:02:28 -0500
Message-Id: <20180903180242.14504-2-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180903180242.14504-1-mr.nuke.me@gmail.com>
References: <20180903180242.14504-1-mr.nuke.me@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For certain bandwidth-critical devices (e.g. multi-port network cards)
it is useful to know the available bandwidth to the root complex. This
information is only available via the system log, which doesn't
account for link degradation after probing.

With a sysfs attribute, we can computes the bandwidth on-demand, and
will detect degraded links.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
 drivers/pci/pci-sysfs.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 9ecfe13157c0..6658e927b1f5 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -218,6 +218,18 @@ static ssize_t current_link_width_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(current_link_width);
 
+static ssize_t available_bandwidth_show(struct device *dev,
+				       struct device_attribute *attr, char *buf)
+{
+	struct pci_dev *pci_dev = to_pci_dev(dev);
+	u32 bw_avail;
+
+	bw_avail = pcie_bandwidth_available(pci_dev, NULL, NULL, NULL);
+
+	return sprintf(buf, "%u.%03u Gb/s\n", bw_avail / 1000, bw_avail % 1000);
+}
+static DEVICE_ATTR_RO(available_bandwidth);
+
 static ssize_t secondary_bus_number_show(struct device *dev,
 					 struct device_attribute *attr,
 					 char *buf)
@@ -786,6 +798,7 @@ static struct attribute *pcie_dev_attrs[] = {
 	&dev_attr_current_link_width.attr,
 	&dev_attr_max_link_width.attr,
 	&dev_attr_max_link_speed.attr,
+	&dev_attr_available_bandwidth.attr,
 	NULL,
 };
 
-- 
2.17.1

