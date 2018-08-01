Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3623C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C2DF208A5
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:02:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C2DF208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731865AbeHATte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:49:34 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50150 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405848AbeHATIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:08:38 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1C9521139;
        Wed,  1 Aug 2018 17:05:10 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Changbin Du <changbin.du@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 224/336] regulator: add dummy function of_find_regulator_by_node
Date:   Wed,  1 Aug 2018 18:49:19 +0200
Message-Id: <20180801165037.646658184@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Changbin Du <changbin.du@intel.com>

[ Upstream commit 08813e0ec1cb48e53c86a24d88d26b26878e7b6e ]

If device tree is not enabled, of_find_regulator_by_node() should have
a dummy function since the function call is still there.

This is to fix build error after CONFIG_NO_AUTO_INLINE is introduced.
If this option is enabled, GCC will not auto-inline functions that are
not explicitly marked as inline.

In this case (no CONFIG_OF), the copmiler will report error in function
regulator_dev_lookup().

W/O NO_AUTO_INLINE, function of_get_regulator() is auto-inlined and then
the call to of_find_regulator_by_node() is optimized out since
of_get_regulator() always return NULL.

W/ NO_AUTO_INLINE, the return value of of_get_regulator() is a variable
so the call to of_find_regulator_by_node() cannot be optimized out. So
we need a stub of_find_regulator_by_node().

static struct regulator_dev *regulator_dev_lookup(struct device *dev,
						  const char *supply)
{
	struct regulator_dev *r = NULL;
	struct device_node *node;
	struct regulator_map *map;
	const char *devname = NULL;

	regulator_supply_alias(&dev, &supply);

	/* first do a dt based lookup */
	if (dev && dev->of_node) {
		node = of_get_regulator(dev, supply);
		if (node) {
			r = of_find_regulator_by_node(node);
			if (r)
				return r;
	...

Signed-off-by: Changbin Du <changbin.du@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/regulator/internal.h |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/drivers/regulator/internal.h
+++ b/drivers/regulator/internal.h
@@ -56,14 +56,19 @@ static inline struct regulator_dev *dev_
 	return container_of(dev, struct regulator_dev, dev);
 }
 
-struct regulator_dev *of_find_regulator_by_node(struct device_node *np);
-
 #ifdef CONFIG_OF
+struct regulator_dev *of_find_regulator_by_node(struct device_node *np);
 struct regulator_init_data *regulator_of_get_init_data(struct device *dev,
 			         const struct regulator_desc *desc,
 				 struct regulator_config *config,
 				 struct device_node **node);
 #else
+static inline struct regulator_dev *
+of_find_regulator_by_node(struct device_node *np)
+{
+	return NULL;
+}
+
 static inline struct regulator_init_data *
 regulator_of_get_init_data(struct device *dev,
 			   const struct regulator_desc *desc,


