Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13058C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 18:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0C8620693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 18:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AogPeAx8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0C8620693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754630AbeFTS2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 14:28:44 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:38308 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753925AbeFTS2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 14:28:42 -0400
Received: by mail-pl0-f68.google.com with SMTP id d10-v6so233322plo.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 11:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=/t4s4wlDSwOT83qnURylb60VdFe1H4dhzJXobLFZd64=;
        b=AogPeAx83WYAiLWKW2Vn4r6vzJTda/YDZinWOvH76PM0daovoO66CTVAupqe6GjR05
         pmLtP6iAPDE2cYZbe7rx/eMloPUSBi1Jv5uE1aHQmc5yC2wTS90gmisG2J5yRZiWlK5H
         ghT8F16JACa3VsF28JzhG8+652g7bs9R73EMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=/t4s4wlDSwOT83qnURylb60VdFe1H4dhzJXobLFZd64=;
        b=HSaC0HYqNJykUz55wuPZNddvLivgBQspPMSmj8sSNciA7qFjNerf7S779sYw2ZHGiO
         DmFUOW29qWpuOuv4NnbV1NtNSBKJ9NCtiXd2eXVgieUTtFKWrxB3U5e62HDqpx7O+Qxr
         oGsckP9pt9+TkZyWKaQfQJKOm52rXIHDrH2CNCfj8Dxrrqc6tOnBNqbT7KFSEdrNsBCj
         E8LCXEy/Qgatov5dLoUghuvcvsvB+EOMJdmgT8uuBdCt0v1XvCyOAu3lgoMMTtdjdPpb
         KyuoHAxKjdB1SFi9N2FvsFrYigRiEKrFcwO5uHz2Cm2Zg4GJDZp+3yXBWBmjcIt5ebFX
         XbSQ==
X-Gm-Message-State: APt69E1Xa6t3KWIf1pUozUziI1koXgSV36ir+RCh//yiO2IHaQj4vK8y
        XayTeof70Zwtdr0hpTrF3MNAbg==
X-Google-Smtp-Source: ADUXVKL5SHNFucGSNk6eC+My/o6a6d7gSOG+rKy3ps+QheEzkprJAkdETjp8HVtTdLtf4e07R+NYTA==
X-Received: by 2002:a17:902:8348:: with SMTP id z8-v6mr24803161pln.239.1529519322476;
        Wed, 20 Jun 2018 11:28:42 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id p12-v6sm5772661pfi.175.2018.06.20.11.28.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 11:28:41 -0700 (PDT)
Date:   Wed, 20 Jun 2018 11:28:40 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH] usb: typec: tps6598x: Remove VLA usage
Message-ID: <20180620182840.GA24775@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the quest to remove all stack VLA usage from the kernel[1], this
uses the maximum buffer size and adds a sanity check.

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/usb/typec/tps6598x.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tps6598x.c b/drivers/usb/typec/tps6598x.c
index 4b4c8d271b27..396193f85e6d 100644
--- a/drivers/usb/typec/tps6598x.c
+++ b/drivers/usb/typec/tps6598x.c
@@ -81,12 +81,17 @@ struct tps6598x {
 	struct typec_capability typec_cap;
 };
 
+#define TPS_MAX_LEN	sizeof(u64)
+
 static int
 tps6598x_block_read(struct tps6598x *tps, u8 reg, void *val, size_t len)
 {
-	u8 data[len + 1];
+	u8 data[TPS_MAX_LEN + 1];
 	int ret;
 
+	if (WARN_ON(len + 1 > sizeof(data)))
+		return -EINVAL;
+
 	if (!tps->i2c_protocol)
 		return regmap_raw_read(tps->regmap, reg, val, len);
 
-- 
2.17.1


-- 
Kees Cook
Pixel Security
