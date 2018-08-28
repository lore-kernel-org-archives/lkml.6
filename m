Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA54C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49C0E2087B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LHCIEvDu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49C0E2087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbeH1TEA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 15:04:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:36310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727040AbeH1TD7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 15:03:59 -0400
Received: from mail-qk0-f179.google.com (mail-qk0-f179.google.com [209.85.220.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 921D32087B;
        Tue, 28 Aug 2018 15:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535469112;
        bh=E1300YIJXwFE3OmFR1mKnEkgrIYHMHpbAihY+SpKptg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LHCIEvDusTAYlqsVDXRpN78gw+Kd/lQfGyHJ5RX5dFRf7wNqEl0dPm7JkF91TO2vh
         65onQp21hEgykFCzCoR74/lbPEn4Y08LXqklhcRjyZTfMYD8g5/aU7RTiwwDaivH5j
         6E6oSPjS5UBOO/iccahZn70h73f59JMu3+0sX6EI=
Received: by mail-qk0-f179.google.com with SMTP id d131-v6so1200980qke.11;
        Tue, 28 Aug 2018 08:11:52 -0700 (PDT)
X-Gm-Message-State: APzg51CbLQOOqHCUXqCBOuN//p9XPytUkm4kQQrL6KRVNwcSl0iFOMTU
        x/6HHW0FNenhME7D/UMZ0qNboVZFPldei9eeQA==
X-Google-Smtp-Source: ANB0VdbX/kbilSD1nvoNE4Qxf+/+oC8WLIVpCwERggcgEQ0/UeoXk64joltalabvX1uo9kMqPdKPUkbrfo58rC/E2ro=
X-Received: by 2002:a37:56c7:: with SMTP id k190-v6mr1871190qkb.29.1535469111755;
 Tue, 28 Aug 2018 08:11:51 -0700 (PDT)
MIME-Version: 1.0
References: <20180828015252.28511-1-robh@kernel.org> <20180828015252.28511-20-robh@kernel.org>
 <aa9473ef-61f6-270f-ff7c-284a2789c0a9@roeck-us.net>
In-Reply-To: <aa9473ef-61f6-270f-ff7c-284a2789c0a9@roeck-us.net>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 28 Aug 2018 10:11:40 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+3LOyXJQ88Q5pqWTnyvK5v2PDdTjK45H+03QdG30=ajg@mail.gmail.com>
Message-ID: <CAL_Jsq+3LOyXJQ88Q5pqWTnyvK5v2PDdTjK45H+03QdG30=ajg@mail.gmail.com>
Subject: Re: [PATCH] hwmon: Convert to using %pOFn instead of device_node.name
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Linux HWMON List <linux-hwmon@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 8:57 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 08/27/2018 06:52 PM, Rob Herring wrote:
> > In preparation to remove the node name pointer from struct device_node,
> > convert printf users to use the %pOFn format specifier.
> >
> > Cc: Jean Delvare <jdelvare@suse.com>
> > Cc: Guenter Roeck <linux@roeck-us.net>
> > Cc: linux-hwmon@vger.kernel.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
>
> The devm_kstrdup((..., "iio_hwmon") is getting a bit ridiculous and is asking
> for a rewrite, but that can be done in a separate patch.

Yeah, I tend to think the drivers should just set a name rather than
pass thru whatever is in DT. If the DT follows good practice then the
node name is just going to reflect the generic class of device.

> Other than that, do you want this taken through hwmon or as a series on its own ?

You can take it.

Rob
