Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 704E2C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 174C72087F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OjK/lWa5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 174C72087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbeIJUkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 16:40:14 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46740 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727411AbeIJUkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 16:40:14 -0400
Received: by mail-wr1-f66.google.com with SMTP id a108-v6so22442454wrc.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 08:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=e5aoVLMQDvRZDoIZ3wZdjRwe3tZxPt0/pw8UN3pLQRc=;
        b=OjK/lWa51MLlBr8khrJIRqWOH3+/fjM+x5x08QkEz5cGHFhJjAa6W2eARKuDD2gsNI
         A73CCKI/doNW+kdaESbIqyB45FrERgKuqWT+ECDL4m3xmP+CN8n30hW2ZJjbNE5mhY++
         /wuKAV8sWUWuLlOmwFWeOBECtACzfvY6itEdw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=e5aoVLMQDvRZDoIZ3wZdjRwe3tZxPt0/pw8UN3pLQRc=;
        b=FKkqffjHTHw+Szi7RMrq5S/wun7nBKwb5byJtpIHPrBuY1OvtyylFuywniBssbGv9I
         h2mP+hVPYWYJkFuACX1c4KiSVcPMonNFx0du/UScbpYcVGHLikCoxIgrsWC/iKQk2pOQ
         YnBs/WkIM54iBRyv4+Jzp2UXogwVGyZYFVGUnM7/Tlp996g3bZRq/9VZ8EKudsd0Yojy
         F1BoSAAxZ76d6x1NjkcfiDSskKa0xlq7tV8Ecu8Ofo9xBOMAgxAURz0B0/LSFgvs7oFj
         VjCi4kIimNu52c8+qSRlS56z1xQWi08CNPChZg/CU8k4kHIRnCeEEicoDN+yqrnP8nXR
         aDYQ==
X-Gm-Message-State: APzg51AgAuT5zu9ZYmAKRcWHYQX3t1Vg93PujUbCfpDjIghRZ1Vkkop4
        jjO1L2Fe1Gt6G6YsT5MdssMNFw==
X-Google-Smtp-Source: ANB0VdZKL6N8jNFSlA1eod/TektolDPzqMizrW45AueKEpM0xcfjZEXnVxZue2xP76vtcwxO8eWsWg==
X-Received: by 2002:a5d:434c:: with SMTP id u12-v6mr15269461wrr.189.1536594332188;
        Mon, 10 Sep 2018 08:45:32 -0700 (PDT)
Received: from dell ([2.27.167.7])
        by smtp.gmail.com with ESMTPSA id x16-v6sm11426216wro.84.2018.09.10.08.45.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 08:45:31 -0700 (PDT)
Date:   Mon, 10 Sep 2018 16:45:29 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Immutable branch between MFD and IRQChip due for the
 v4.20 merge window
Message-ID: <20180910154529.GF28860@dell>
References: <20180830132005.19500-1-rf@opensource.cirrus.com>
 <20180910154424.GE28860@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180910154424.GE28860@dell>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Resending with correct subject line this time]

Enjoy!

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-irqchip-v4.20

for you to fetch changes up to d31ca7e5d0fa066d59540859af32ab6f95adb519:

  mfd: madera: Add irqchip data pointer into struct madera (2018-09-10 16:43:27 +0100)

----------------------------------------------------------------
Immutable branch between MFD and IRQChip due for the v4.20 merge window

----------------------------------------------------------------
Richard Fitzgerald (1):
      mfd: madera: Add irqchip data pointer into struct madera

 include/linux/mfd/madera/core.h | 2 ++
 1 file changed, 2 insertions(+)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
