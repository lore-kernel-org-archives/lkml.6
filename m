Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21CD7C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 861BC20870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Atgkh+Eg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 861BC20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbeIJUjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 16:39:09 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37347 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727411AbeIJUjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 16:39:08 -0400
Received: by mail-wm0-f68.google.com with SMTP id n11-v6so21909606wmc.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 08:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=4FYmIPieNdPNF3D8x42wKoCR9PMIsOBi5+RtoBilOhI=;
        b=Atgkh+EgRIw5MRY5RNsZ4pT9wFpcbegyLlgbDWnJlmgoIceHwVrn0WToOoXD6PgN0i
         eog3Dm/croOqRapqO7n9u/JeRZgS5638hPrHCS/1j11JZ0Ibn20tVDZipt3yNawtmZvG
         AG0QzE0yz1gUkvFCC6JNN8YSJcugU4vXCZPi4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=4FYmIPieNdPNF3D8x42wKoCR9PMIsOBi5+RtoBilOhI=;
        b=YazdTgooDZukQOE6/dyYRXelHEm0AHGWM7IGA8y5I5oZcFMgx0mFEz9SpbM1Erlw4z
         z1CImbCVP1qNd8m1gmzE/dVzyarLkL5WxUaKfMCSdtnb6vitxHr6WmhKHH3G1d5p7wwm
         VrhHjWG/BAFFfC9/u92bC0ZKx132cRZ8WldcDX536gY/BEbsmFSKLS0M2+ec5jfR2A2o
         i6n+AzuAAQ5L6fLNHbzliRBNNk+t4ikDkMquBgR/FI9V6vcG4QLNHjTFWk0EJ2hAQrCm
         J1vmhw9/itJdVSV8+cAJ5z6fcOi0QBGeB+eAq8GSa5XCgCQdgvZDhNIe+ofP1Pitnbqk
         T8rQ==
X-Gm-Message-State: APzg51ABUVgToFhP4y57SfYvYFjVn/VbqH0c0Sjcx8lxWsmdW2tt4CDG
        6IHRzyFguZQgnNfxcmVhjbrOhQ==
X-Google-Smtp-Source: ANB0VdZLmCy0ZIVea86Du+3ZL6cCJ6S9mOpKPqnhRIDzPnqjFl+aw9/4uKugYGRpo2XCnGxNAzh5bQ==
X-Received: by 2002:a1c:6782:: with SMTP id b124-v6mr1144954wmc.30.1536594266910;
        Mon, 10 Sep 2018 08:44:26 -0700 (PDT)
Received: from dell ([2.27.167.7])
        by smtp.gmail.com with ESMTPSA id c19-v6sm16081085wre.86.2018.09.10.08.44.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 08:44:26 -0700 (PDT)
Date:   Mon, 10 Sep 2018 16:44:24 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 1/2] mfd: madera: Add irqchip data pointer into
 struct madera
Message-ID: <20180910154424.GE28860@dell>
References: <20180830132005.19500-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180830132005.19500-1-rf@opensource.cirrus.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
