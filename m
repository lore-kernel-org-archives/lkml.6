Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A465C677E8
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 16:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D99D1208E7
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 16:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oXDjbvGl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D99D1208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=capella.pro
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbeJFXbR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 19:31:17 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35673 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725266AbeJFXbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 19:31:16 -0400
Received: by mail-qk1-f194.google.com with SMTP id v68-v6so2771951qka.2;
        Sat, 06 Oct 2018 09:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=5AOdYjiWJ4t8xEnWc8GFhiQ4jwvaMABs6lSPdqosYXw=;
        b=oXDjbvGl+UTZeHErd8QJzz/r/pYKAj+WmSOGSad4GhSv+un7sXZS3ixSIY665QRCtl
         Tek9+PKgalj503MRjmOuHm2ymTecQZYtdrWdFwG5yEnAZD4nMFFe04XzeeLIISr4v/Db
         LmmXZsljUqQFkTbwl8zcz0l26RDB2bnfuXV/Xw5UW1YApLomlXJ3ICaxb47v0MH8ohJN
         P/HPFPv3uAXzNfXUG7D+ap/9WuE6MK26lxAusTJkxi5gUibE1Ca3zztWj7ncdHJgRAj2
         6rZS1tnHf7d4ffupsouMtE/oyGoAbuGitIERm+HKASGKgZB9pSQQkhZTVoiou3L4liJQ
         AeOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=5AOdYjiWJ4t8xEnWc8GFhiQ4jwvaMABs6lSPdqosYXw=;
        b=TUqwFoIpNQjpWcoXubRAYD/66TrtPamI1kpZQTu7x+j8v3hZlW3tNxLQZT2bwxqeXr
         HDat2lqpuK/DinwGf+nW8iWxgAOnMb+lhJTtjO3P5eJKiuwE3wldF3QxH2X84kwi7f07
         fYCTSACg8EQtS1hcSz1gfuA2+shalWm0+Ck5KI7v4MdlO3HId2vPe/GqrceKYifxTXzB
         YIeGPpJBxKOh8tIDBrDFtW/LV+O/YN+/ZcvqA/ccbQver89PESbbrOoF4CLbx39URNvX
         h07BkUSs72F89wqJR4MsN7kR7osLJQ+KX7Mx0rb2rAJcPijMN+KAsNtTIMwqriwtT7jE
         LcXQ==
X-Gm-Message-State: ABuFfojPcW6MqkO/MA6Q8180yzx5ruuGCHjx5bM1a6g+oUzGBT5TkeFq
        Acowkf3wm8+XIU+xxGumPqA=
X-Google-Smtp-Source: ACcGV63oEzZIghVKbK5HzbEq0jWeANU7qq3I3NtD2C13K/yGGO9JHnci8ZzFoznY2fXWyFMfaV77yg==
X-Received: by 2002:a37:a70a:: with SMTP id q10-v6mr13314761qke.110.1538843238137;
        Sat, 06 Oct 2018 09:27:18 -0700 (PDT)
Received: from localhost ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id m2-v6sm3582064qkg.92.2018.10.06.09.27.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Oct 2018 09:27:17 -0700 (PDT)
Date:   Sat, 6 Oct 2018 13:27:15 -0300
From:   Gabriel Capella <gabriel@capella.pro>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Hennerich <michael.hennerich@analog.com>
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: iio: adc: ad7280a: fix 2 checks
Message-ID: <20181006162715.GA8476@mantaray>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch does not change the logic, it only
corrects the checkpatch checks.

The patch fixes 2 checks of type:
"CHECK: spaces preferred around that '-'"

Signed-off-by: Gabriel Capella <gabriel@capella.pro>
---
 drivers/staging/iio/adc/ad7280a.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index 58420dcb406d..a4b4f8678c56 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -750,14 +750,14 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
 }
 
 static IIO_DEVICE_ATTR_NAMED(in_thresh_low_value,
-		in_voltage-voltage_thresh_low_value,
+		in_voltage - voltage_thresh_low_value,
 		0644,
 		ad7280_read_channel_config,
 		ad7280_write_channel_config,
 		AD7280A_CELL_UNDERVOLTAGE);
 
 static IIO_DEVICE_ATTR_NAMED(in_thresh_high_value,
-		in_voltage-voltage_thresh_high_value,
+		in_voltage - voltage_thresh_high_value,
 		0644,
 		ad7280_read_channel_config,
 		ad7280_write_channel_config,
-- 
2.17.1 (Apple Git-112)


-- 
Gabriel Capella
gabrielcapella.com
hardwarelivreusp.org
+55 11 98124-5668
