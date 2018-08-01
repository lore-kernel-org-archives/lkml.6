Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D0C1C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E82B8208A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:51:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E82B8208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390477AbeHATi2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:38:28 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50216 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406046AbeHATIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:08:41 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BCCB3D2F;
        Wed,  1 Aug 2018 17:21:55 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        Douglas Anderson <dianders@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 203/246] regulator: Dont return or expect -errno from of_map_mode()
Date:   Wed,  1 Aug 2018 18:51:53 +0200
Message-Id: <20180801165021.441105529@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165011.700991984@linuxfoundation.org>
References: <20180801165011.700991984@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Douglas Anderson <dianders@chromium.org>

[ Upstream commit 02f3703934a42417021405ef336fe45add13c3d1 ]

In of_get_regulation_constraints() we were taking the result of
of_map_mode() (an unsigned int) and assigning it to an int.  We were
then checking whether this value was -EINVAL.  Some implementers of
of_map_mode() were returning -EINVAL (even though the return type of
their function needed to be unsigned int) because they needed to
signal an error back to of_get_regulation_constraints().

In general in the regulator framework the mode is always referred to
as an unsigned int.  While we could fix this to be a signed int (the
highest value we store in there right now is 0x8), it's actually
pretty clean to just define the regulator mode 0x0 (the lack of any
bits set) as an invalid mode.  Let's do that.

Fixes: 5e5e3a42c653 ("regulator: of: Add support for parsing initial and suspend modes")
Suggested-by: Javier Martinez Canillas <javierm@redhat.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/regulator/cpcap-regulator.c |    2 +-
 drivers/regulator/of_regulator.c    |   13 +++++++------
 drivers/regulator/twl-regulator.c   |    2 +-
 include/linux/regulator/consumer.h  |    1 +
 4 files changed, 10 insertions(+), 8 deletions(-)

--- a/drivers/regulator/cpcap-regulator.c
+++ b/drivers/regulator/cpcap-regulator.c
@@ -222,7 +222,7 @@ static unsigned int cpcap_map_mode(unsig
 	case CPCAP_BIT_AUDIO_LOW_PWR:
 		return REGULATOR_MODE_STANDBY;
 	default:
-		return -EINVAL;
+		return REGULATOR_MODE_INVALID;
 	}
 }
 
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -31,6 +31,7 @@ static void of_get_regulation_constraint
 	struct regulation_constraints *constraints = &(*init_data)->constraints;
 	struct regulator_state *suspend_state;
 	struct device_node *suspend_np;
+	unsigned int mode;
 	int ret, i;
 	u32 pval;
 
@@ -124,11 +125,11 @@ static void of_get_regulation_constraint
 
 	if (!of_property_read_u32(np, "regulator-initial-mode", &pval)) {
 		if (desc && desc->of_map_mode) {
-			ret = desc->of_map_mode(pval);
-			if (ret == -EINVAL)
+			mode = desc->of_map_mode(pval);
+			if (mode == REGULATOR_MODE_INVALID)
 				pr_err("%s: invalid mode %u\n", np->name, pval);
 			else
-				constraints->initial_mode = ret;
+				constraints->initial_mode = mode;
 		} else {
 			pr_warn("%s: mapping for mode %d not defined\n",
 				np->name, pval);
@@ -163,12 +164,12 @@ static void of_get_regulation_constraint
 		if (!of_property_read_u32(suspend_np, "regulator-mode",
 					  &pval)) {
 			if (desc && desc->of_map_mode) {
-				ret = desc->of_map_mode(pval);
-				if (ret == -EINVAL)
+				mode = desc->of_map_mode(pval);
+				if (mode == REGULATOR_MODE_INVALID)
 					pr_err("%s: invalid mode %u\n",
 					       np->name, pval);
 				else
-					suspend_state->mode = ret;
+					suspend_state->mode = mode;
 			} else {
 				pr_warn("%s: mapping for mode %d not defined\n",
 					np->name, pval);
--- a/drivers/regulator/twl-regulator.c
+++ b/drivers/regulator/twl-regulator.c
@@ -274,7 +274,7 @@ static inline unsigned int twl4030reg_ma
 	case RES_STATE_SLEEP:
 		return REGULATOR_MODE_STANDBY;
 	default:
-		return -EINVAL;
+		return REGULATOR_MODE_INVALID;
 	}
 }
 
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -80,6 +80,7 @@ struct regmap;
  * These modes can be OR'ed together to make up a mask of valid register modes.
  */
 
+#define REGULATOR_MODE_INVALID			0x0
 #define REGULATOR_MODE_FAST			0x1
 #define REGULATOR_MODE_NORMAL			0x2
 #define REGULATOR_MODE_IDLE			0x4


