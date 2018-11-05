Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 155CFC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF72420869
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:15:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hpZk47D/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF72420869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388080AbeKFEgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 23:36:11 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41147 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387659AbeKFEgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 23:36:11 -0500
Received: by mail-qk1-f196.google.com with SMTP id 189so16784991qkj.8;
        Mon, 05 Nov 2018 11:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HiIV5c0pyju/OZ+2mp4LyYN/kJGYikFjdsbcyKgsdTE=;
        b=hpZk47D/nW6h1DgbyeUYNMBNMSaBKiCvhaTX9dht9ZyYmUSPzxt+r49XE8Q2jrQWrs
         ktyWkqYdUtRC5d99S2ZBHXWomstSU8cWVG/KkoiEFsxg1i3YCmRrbsJ8alB4yJSo3Mmd
         zGADia0zL+axz/mRDuNhKE90l+zFdp1orGvC4W1AeecSvVNi9t7k5KXda7Om+C3eQL90
         /15ZQOnX5E/faWTirIiOUYipd0TLwNAjYvw28c369pdFa/yJqFrNoDauFkE6UzJPPmps
         EWrre8Dlf/BAAfp1hVXe9rJrT0KgT2vezPHoMrqW9SAfFtCL3ydiKyyQARrP+ekvosPh
         cbfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HiIV5c0pyju/OZ+2mp4LyYN/kJGYikFjdsbcyKgsdTE=;
        b=PBjcdGxb9Vr/IxM7WkLiz1Ba0Y2IZ5GqeuI48JwUJ1s8UmG86uBKEw9XuZBwBteG+S
         0vm37PP8F4DqYiZNDYxKf/LBrvI661Rmktsigt9axjQ7STOSXnzyIktV1BahaGfuLpNo
         YYVyBpWF9u/R6qFCxExwdRFlTR9lv4OW/jnKVtOaqICt5ltW7hCQ91oNX5jo+0cDbUw+
         JM+DA6jvuAz43r3SPuttgHNMXno41LrtD3zERb0eu+gdUWgAeGqpCrx8wIhM5yydapj0
         Ki3w25GtHhsLTXh4rRD4Q4dtWDAmszV2MfbuJcNebxHSevFiVuTUmcY+Y+hT+yqpne4t
         doqQ==
X-Gm-Message-State: AGRZ1gJ+q1VdVTwZsMrLZ1erto9krKWjhnnC+oKGSP/zY9M6RJ2qk3+9
        lA2W6rb/w4sYSXnnzDAJnk4=
X-Google-Smtp-Source: AJdET5fxSbr9ArhxZb2rifXjZePBGgNB6AGbB2hCese2PkTzSHkM0xL/l4xDqsqKkwuugBR17g5Bcw==
X-Received: by 2002:a0c:aff9:: with SMTP id t54mr22541753qvc.93.1541445303455;
        Mon, 05 Nov 2018 11:15:03 -0800 (PST)
Received: from renatolg ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id 67sm11428931qku.60.2018.11.05.11.15.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 11:15:03 -0800 (PST)
Date:   Mon, 5 Nov 2018 17:14:58 -0200
From:   Renato Lui Geh <renatogeh@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        giuliano.belinassi@usp.br
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH v4 1/2] staging: iio: ad7780: update voltage on read
Message-ID: <4b47bd8f4bac2575b72529b37e5ac90bebae2446.1541444377.git.renatogeh@gmail.com>
References: <cover.1541444377.git.renatogeh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <cover.1541444377.git.renatogeh@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ad7780 driver previously did not read the correct device output, as
it read an outdated value set at initialization. It now updates its
voltage on read.

Signed-off-by: Renato Lui Geh <renatogeh@gmail.com>
---
Changes in v3:
	- removed initialization (int voltage_uv = 0)
	- returns error when voltage_uv is null
Changes in v4:
	- returns error when voltage_uv is negative

 drivers/staging/iio/adc/ad7780.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
index b67412db0318..c7cb05cedbbc 100644
--- a/drivers/staging/iio/adc/ad7780.c
+++ b/drivers/staging/iio/adc/ad7780.c
@@ -87,12 +87,16 @@ static int ad7780_read_raw(struct iio_dev *indio_dev,
 			   long m)
 {
 	struct ad7780_state *st = iio_priv(indio_dev);
+	int voltage_uv;
 
 	switch (m) {
 	case IIO_CHAN_INFO_RAW:
 		return ad_sigma_delta_single_conversion(indio_dev, chan, val);
 	case IIO_CHAN_INFO_SCALE:
-		*val = st->int_vref_mv * st->gain;
+		voltage_uv = regulator_get_voltage(st->reg);
+		if (voltage_uv < 0)
+			return voltage_uv;
+		*val = (voltage_uv / 1000) * st->gain;
 		*val2 = chan->scan_type.realbits - 1;
 		return IIO_VAL_FRACTIONAL_LOG2;
 	case IIO_CHAN_INFO_OFFSET:
-- 
2.19.1

