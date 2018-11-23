Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6159DC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 23:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CE6720861
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 23:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IXuBjAtF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CE6720861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbeKXKiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 05:38:21 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38660 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727607AbeKXKiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 05:38:21 -0500
Received: by mail-qt1-f194.google.com with SMTP id p17so11999850qtl.5;
        Fri, 23 Nov 2018 15:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=cXw5hDZ1MF23Ces5fW3GTGxZseSaFQ1WGGsY/s3p/es=;
        b=IXuBjAtFNjgP579f3hWbbYuyC0zXGNSndQev7/ioug2cZZ0v4M+UjbiZ6/Iot/aQ6P
         Bs7Mb8ZvMbvoJfdphedeLGG7PGhDY5dE1DhxdgwBK6n2uj2yz0MNMixxtpUPpzm+nyMB
         hfA4qGp5dwJWGCg288j5VUUHMhsWmVISEYBCwT8dHCbfEqilh3B2pikfOgE1i+AU50UL
         157ErHM9wLMMWfgJHXldn87ngpy1vnRkpslCkghdNq+rYOAQaE8fQBcp8ouoc+CKkr9u
         UApnf1t3PJswz/Y5T/ST1aem//c4FFAKAOdR4HrU2wHVjMDVeaCvyPeanRxpTo86Zc7f
         pYTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=cXw5hDZ1MF23Ces5fW3GTGxZseSaFQ1WGGsY/s3p/es=;
        b=V7Pn+H4vsjPaFzpVceukcZ+gqlWLgZlNNF6jgqcPDem9AN9xroKcoUcPMytAyQ0VVT
         xdiomCTDYBXkUMUMEe5SU2d8xWwZARs6qdNHSuaBVn8dMDfVBo/ofMinSoSYz2LvQxkk
         9nzUZ0DLrKriqTxkryTcjKPlb8HOAe8z+467FZ0xAuCv8l4nK0z62EcTxlugrHGz9Ias
         FxjyP0xOVxa3Y8GMEnLaN1wb9SsXx2L3DtUu4SYhJSaB/diucq6i+A2lVeqZkdmzJswA
         2WOy/h1lSlOk4tebej65m2YtUJ/KMPyc1qsXKrIrngEMqZf4QZ9WXTbea3tf6zz4gsi6
         AExA==
X-Gm-Message-State: AGRZ1gJXWSUM94nnRkqNUPF/fcq3Nm6beethy0zZqlgRlQWl/ZxG1csM
        0ZX6J1SiRNQ7UNzf9oPNqC8=
X-Google-Smtp-Source: AJdET5e5EhQYR3WJS47+/FsIkcnepmyOBbTskAiE9Q7+aZpBg2n5Ygfcls3iqPQgQeV+GNBzYVG1gw==
X-Received: by 2002:ac8:326a:: with SMTP id y39mr16891977qta.175.1543017124414;
        Fri, 23 Nov 2018 15:52:04 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id q2sm13710831qkc.68.2018.11.23.15.52.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Nov 2018 15:52:03 -0800 (PST)
Date:   Fri, 23 Nov 2018 21:51:59 -0200
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH] staging: iio: ad5933: finalized device-tree support
Message-ID: <20181123235159.hh43xnvvwsil4on2@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added a of_device_id struct variable and subsequent call to
MODULE_DEVICE_TABLE macro to complete device-tree support for this
driver.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
---
 drivers/staging/iio/impedance-analyzer/ad5933.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index edb8b540bbf1..19e8b6d2865c 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -771,9 +771,18 @@ static const struct i2c_device_id ad5933_id[] = {
 
 MODULE_DEVICE_TABLE(i2c, ad5933_id);
 
+static const struct of_device_id ad5933_of_match[] = {
+	{ .compatible = "analog-devices,ad5933" },
+	{ .compatible = "analog-devices,ad5934" },
+	{ },
+};
+
+MODULE_DEVICE_TABLE(of, ad5933_of_match);
+
 static struct i2c_driver ad5933_driver = {
 	.driver = {
 		.name = "ad5933",
+		.of_match_table = ad5933_of_match,
 	},
 	.probe = ad5933_probe,
 	.remove = ad5933_remove,
-- 
2.17.1

