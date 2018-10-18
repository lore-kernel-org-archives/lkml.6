Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC724ECDE42
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 01:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C4B321470
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 01:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ilTvxIzz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C4B321470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727396AbeJRJah (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 05:30:37 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40069 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbeJRJag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 05:30:36 -0400
Received: by mail-qk1-f193.google.com with SMTP id x11-v6so558209qkl.7;
        Wed, 17 Oct 2018 18:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=pwt34DZ8W47/I8E8oXqSyBfO0kw2BfmzXZy/V4jFHvc=;
        b=ilTvxIzzJ9UuzWHTVO9SKeo9zWK44Ngb78BGMtqICrx3vGI5CeFpKqaydqeYj5O/5i
         VwBwdAOdXWK9VcIy+9b0jzxTdY+FN4mIzdF0wDDB/vcVuBMLR3rbHKqIZ4o+wUKj5iiu
         4jM8zEjSisnrG76kWHwY+QpKfWWyLeZWwbKUD5lFvMvsGLnb5WRp2vRuAj0YLOWYXBAg
         HhRqY8LdgkTocMtvWM8l06qZTHjvdy8KPjNK6cbp31GU2qCJhhP7YUfe5/SSkcLP/Jl6
         FoNRv1NmPj+oQUyP4iRB2OPf2I3u0N6jlGF/Mj4V95RCqPXqepcA9515iD/cnYWhCWez
         EhyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pwt34DZ8W47/I8E8oXqSyBfO0kw2BfmzXZy/V4jFHvc=;
        b=oH3dI2qqIOyltDU4iVwmk5HRWDxQ9pkl+maoYHg4N+pxRQHMC5nAzZ3si0FpJ6PoEn
         KKmG7eegqjBhZzUvJ/w6YFHiMMqnKwn6InbTcrSsAKtRymraE4Vms1mROz+4ZuSQmXG9
         KRfBawFclbL76JrdV1YsDza6xBRTYyORx5R7sRlPV+Dieq4VqPMBMYx/mDPahe5sKg3p
         vSu8gRquLMTtStLh+Kt5a3dKTnMhRlj3nM49XNSofR06AImS6zngpdHMq6JisWc6KF2L
         G9JDBCou7bRqQQWb6Xe7cG5+b4Jixep9h9/ISHeGnqrTW7dSg3a1MFHatFwk6vx9R+fL
         e6cQ==
X-Gm-Message-State: ABuFfoj6EXuztZvomaMyH9E7iGk6raQjYLACQ7kA5wMIqSmSAGjdjmTH
        6hMzRRwDPMA3AV0L6ZqGm+ueoi5auNI=
X-Google-Smtp-Source: ACcGV61ogsWT8AKVDyAQ+RivagLN7nAv0+eE0qNdcRI0Qe/uWhjB33dxmH4ZQdUKsTHa5389PFiteg==
X-Received: by 2002:a37:d6c2:: with SMTP id p63-v6mr26793471qkl.190.1539826328647;
        Wed, 17 Oct 2018 18:32:08 -0700 (PDT)
Received: from marcelo-Aspire-5750.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id c44-v6sm15043429qtb.53.2018.10.17.18.32.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 18:32:08 -0700 (PDT)
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Subject: [PATCH v2] Staging iio: adc: Match parenthesis alignment
Date:   Wed, 17 Oct 2018 22:31:47 -0300
Message-Id: <20181018013147.15352-1-marcelo.schmitt1@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change close parenthesis alignment to match respective open parenthesis at
iio/drivers/staging/iio/adc/ad7606.c line 379.
This makes the file more compliant with the preferred coding style for the
linux kernel.

Signed-of-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
---
 drivers/staging/iio/adc/ad7606.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/adc/ad7606.c b/drivers/staging/iio/adc/ad7606.c
index 0b728b6ea135..230faae38c12 100644
--- a/drivers/staging/iio/adc/ad7606.c
+++ b/drivers/staging/iio/adc/ad7606.c
@@ -376,7 +376,7 @@ static int ad7606_request_gpios(struct ad7606_state *st)
 		return 0;
 
 	st->gpio_os = devm_gpiod_get_array_optional(dev, "oversampling-ratio",
-			GPIOD_OUT_LOW);
+						    GPIOD_OUT_LOW);
 	return PTR_ERR_OR_ZERO(st->gpio_os);
 }
 
-- 
2.17.1

