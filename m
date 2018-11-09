Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA87C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 07:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5A022086C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 07:38:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EraU+Qkx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5A022086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbeKIRSB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 12:18:01 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41875 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbeKIRSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 12:18:00 -0500
Received: by mail-pg1-f193.google.com with SMTP id 70so498829pgh.8;
        Thu, 08 Nov 2018 23:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mv3W8L/OrmYU2mKhLZMK0Ul1e9qD7XLq6l5YIls48S0=;
        b=EraU+Qkxc1/6VnYGNeJltz2WWcrkWjQb3lT4M94pebvZEncZkOanqM8NMOtEsYV1ym
         BBAYztr89QWKEm16QTvyD0Y2ZiHIF0wSRuKzWnXqmObAo5laVAb193h1xe9moZDjldPl
         lE0MoiZbLzSugt0ZokfL3l9DNtTf/Da7o97R8/EjPXhdreBgeUL7X4EnKb+t9uJhdm1C
         ioiITfy+1bMogec6cjbDbbzJ9R1ak+V79dhvngrXPdPy+x/EKKD97mGnPJr/916lqrc4
         Zv/Ml+Txp5hTTTlezV5+hB8CPEZqrz1gNKlaHURoUzq7ZK70yVFfKPFoheroiUEgYRsb
         xq9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mv3W8L/OrmYU2mKhLZMK0Ul1e9qD7XLq6l5YIls48S0=;
        b=DDGPpqu+GzmK/1tObpIii+YX4nv3/0cSsFLoslIOg3QQVCOMi2QrRIi+jN4jaQqAW5
         oh5kTSFJzX3WQwdMA62SD1GXuD+eIryreo3EWsI1WBNJfyKYqeaYYumkruZHovvKO385
         WWrkOsA5jzwfBISCLWI8dw+quzb31iy1OVkdRaQR1+lm0LwV14NjTHCZjIdcvqvEUqJs
         eNV2WTx6fdcGebOovZt34I4V8Ef3TyQs+buYjm+LUprhhUnw6hCc6HfBz8qLteNradO8
         UfqycpXSPfHdjNUNMRCm2eT3VSmD2pyrypCsnEDaD51bkfqaBlEMRpm5HRS06JdKaRdH
         LsgA==
X-Gm-Message-State: AGRZ1gIkaQJ2en+QPZmbpE9PFevgaquHIY7tzGR1/vNt/82kqvSuCcK9
        zzUYcObi4bZ7DHDL7l0GsMc=
X-Google-Smtp-Source: AJdET5dQ4HDrzyjxjzqP5hL2Hi1PKdgkZ/fdve9EViF7H6OcM6TjzCzniUg/QqY3lueR3kXKC7pKdQ==
X-Received: by 2002:a63:4e41:: with SMTP id o1mr6705523pgl.282.1541749120981;
        Thu, 08 Nov 2018 23:38:40 -0800 (PST)
Received: from nishad ([106.210.186.71])
        by smtp.gmail.com with ESMTPSA id r6-v6sm333838pfk.157.2018.11.08.23.38.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 23:38:40 -0800 (PST)
Date:   Fri, 9 Nov 2018 13:08:32 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] staging: iio: ad7816: Add device tree table.
Message-ID: <209172d47d8d14c1244556e5f05bbd6455b4de04.1541733949.git.nishadkamdar@gmail.com>
References: <cover.1541733949.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1541733949.git.nishadkamdar@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree table for matching vendor ID.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/iio/adc/ad7816.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index a2fead85cd46..b8a9149fbac1 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -422,6 +422,12 @@ static int ad7816_probe(struct spi_device *spi_dev)
 	return 0;
 }
 
+static const struct of_device_id ad7816_of_match[] = {
+	{ .compatible = "adi,ad7816", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ad7816_of_match);
+
 static const struct spi_device_id ad7816_id[] = {
 	{ "ad7816", ID_AD7816 },
 	{ "ad7817", ID_AD7817 },
@@ -434,6 +440,7 @@ MODULE_DEVICE_TABLE(spi, ad7816_id);
 static struct spi_driver ad7816_driver = {
 	.driver = {
 		.name = "ad7816",
+		.of_match_table = of_match_ptr(ad7816_of_match),
 	},
 	.probe = ad7816_probe,
 	.id_table = ad7816_id,
-- 
2.17.1

