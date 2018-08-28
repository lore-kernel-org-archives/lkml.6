Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A75A9C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6905020645
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:57:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6905020645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbeH1FoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 01:44:05 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:39766 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbeH1FoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 01:44:04 -0400
Received: by mail-oi0-f65.google.com with SMTP id c190-v6so14371oig.6;
        Mon, 27 Aug 2018 18:54:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yLsZxzjoAPbWtG9fCYKw9jIVtTQlJsGEbn0grKaCpS8=;
        b=n9vMhMU+YOnmakcE50V3upCN+LZybC/wH9kAhC3InzEGqaqrejOd9tNqZ57x1ohjFy
         sFtdl5kbLq6bW74xE8alxyiKQyVc/zrUePf6doza6CMi2FrY4/vJbxGQafv3oBSGFmHh
         lie5PZO1OUh6dNfzCuocX+hZLlUFRwWs+8dYntpQdKHtDkQE9gVQUjqYROek7ctEuhiP
         GBUnmGsZmWLJG8svhF4Zu3MBj1Q3DrNGZlkmdk0pq2JAqfcLtmX0VoQqFPEb32yBukFL
         nuK1qLXo3fOFfuXV5v4bAoUA000IFZOC3ejng1bPajpnCnoF2EfsvI81gOpgqINCAGgF
         GCpg==
X-Gm-Message-State: APzg51A/H3X2d7jLx+WMyNYMKsWjS78ExJYHMuPqSD/oPNkDI4sCcoWP
        DYocM8FSqRI78Omx0iuN9VO0Fik=
X-Google-Smtp-Source: ANB0VdZ8fqQF6vI4vqjxkfJTh68HzS7lLiZV35TUeAEL/yDh3wWLGX4Ia8Jr63MzoF9JvTCJ7vrv+g==
X-Received: by 2002:aca:c74d:: with SMTP id x74-v6mr985009oif.97.1535421288615;
        Mon, 27 Aug 2018 18:54:48 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id n71-v6sm1652696oig.48.2018.08.27.18.54.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 18:54:47 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Subject: [PATCH] iio: Convert to using %pOFn instead of device_node.name
Date:   Mon, 27 Aug 2018 20:52:23 -0500
Message-Id: <20180828015252.28511-22-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180828015252.28511-1-robh@kernel.org>
References: <20180828015252.28511-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/iio/adc/qcom-pm8xxx-xoadc.c |  4 ++--
 drivers/iio/adc/rcar-gyroadc.c      | 12 ++++++------
 drivers/iio/frequency/adf4350.c     |  2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/qcom-pm8xxx-xoadc.c b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
index b093ecddf1a8..c30c002f1fef 100644
--- a/drivers/iio/adc/qcom-pm8xxx-xoadc.c
+++ b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
@@ -708,8 +708,8 @@ static int pm8xxx_of_xlate(struct iio_dev *indio_dev,
 	 * mux.
 	 */
 	if (iiospec->args_count != 2) {
-		dev_err(&indio_dev->dev, "wrong number of arguments for %s need 2 got %d\n",
-			iiospec->np->name,
+		dev_err(&indio_dev->dev, "wrong number of arguments for %pOFn need 2 got %d\n",
+			iiospec->np,
 			iiospec->args_count);
 		return -EINVAL;
 	}
diff --git a/drivers/iio/adc/rcar-gyroadc.c b/drivers/iio/adc/rcar-gyroadc.c
index dcb50172186f..4e982b51bcda 100644
--- a/drivers/iio/adc/rcar-gyroadc.c
+++ b/drivers/iio/adc/rcar-gyroadc.c
@@ -343,8 +343,8 @@ static int rcar_gyroadc_parse_subdevs(struct iio_dev *indio_dev)
 	for_each_child_of_node(np, child) {
 		of_id = of_match_node(rcar_gyroadc_child_match, child);
 		if (!of_id) {
-			dev_err(dev, "Ignoring unsupported ADC \"%s\".",
-				child->name);
+			dev_err(dev, "Ignoring unsupported ADC \"%pOFn\".",
+				child);
 			continue;
 		}
 
@@ -381,16 +381,16 @@ static int rcar_gyroadc_parse_subdevs(struct iio_dev *indio_dev)
 			ret = of_property_read_u32(child, "reg", &reg);
 			if (ret) {
 				dev_err(dev,
-					"Failed to get child reg property of ADC \"%s\".\n",
-					child->name);
+					"Failed to get child reg property of ADC \"%pOFn\".\n",
+					child);
 				return ret;
 			}
 
 			/* Channel number is too high. */
 			if (reg >= num_channels) {
 				dev_err(dev,
-					"Only %i channels supported with %s, but reg = <%i>.\n",
-					num_channels, child->name, reg);
+					"Only %i channels supported with %pOFn, but reg = <%i>.\n",
+					num_channels, child, reg);
 				return ret;
 			}
 		}
diff --git a/drivers/iio/frequency/adf4350.c b/drivers/iio/frequency/adf4350.c
index 6d768431d90e..f4748ff243f7 100644
--- a/drivers/iio/frequency/adf4350.c
+++ b/drivers/iio/frequency/adf4350.c
@@ -388,7 +388,7 @@ static struct adf4350_platform_data *adf4350_parse_dt(struct device *dev)
 	if (!pdata)
 		return NULL;
 
-	strncpy(&pdata->name[0], np->name, SPI_NAME_SIZE - 1);
+	snprintf(&pdata->name[0], SPI_NAME_SIZE - 1, "%pOFn", np);
 
 	tmp = 10000;
 	of_property_read_u32(np, "adi,channel-spacing", &tmp);
-- 
2.17.1

