Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF76FC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 12:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7EA42086B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 12:22:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7EA42086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbeKGVw4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 16:52:56 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36503 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbeKGVwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 16:52:55 -0500
Received: by mail-ot1-f66.google.com with SMTP id k98so4352262otk.3;
        Wed, 07 Nov 2018 04:22:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5pno4t+SJk+xSPz+MEHryyP72JoQu+JF1pHNOTwLtJo=;
        b=RB7NMTIMST0L8oxGRjchbMxjLqWHqg0ktpbLlj9F2hrkyZvJ665tGbSqLKHWIIjBQt
         sXgi4IK56KDO9LbZESA0K9CJey3xpw8+abOGwrSbutiHP1JFj7IWKpuspPyB0ip7jSvp
         MkU4qdndv6o3OTBDo5G0JtWqluZHDL2FyUEZSXoha5DUyvzBCzdit+BtRNzl7fw6k7lx
         /eG+v6YzhyaDYlhRDDE+iYlWHzLTWlAFnKcnmsRh6kmBukyeyA12A8JizI017zFTkY82
         97NcWLsbVaO2HYBwSi0mChbz3s8GbZ2Z8GuntncSikwrPAbSiihgbXl2h82xtBzT7pCF
         FBnQ==
X-Gm-Message-State: AGRZ1gIOwXNWCPDiFCx9xvSmzCSPxrClZmrW3vzlYj4YUrBUU5FTBHJU
        gUWwTo+OtaFbnOf6rhjleO25BnjRCODZkmBgK0Zuhw==
X-Google-Smtp-Source: AJdET5e4cVppaFc8mejKuyPv9vtVfnMZwiQ54sv3H7tFsOHv3a/GODuSh+pd9ZHhWh2Qm3D7NJkSY8FMORCf+LQTjWc=
X-Received: by 2002:a9d:42c7:: with SMTP id c7mr816018otj.119.1541593366399;
 Wed, 07 Nov 2018 04:22:46 -0800 (PST)
MIME-Version: 1.0
References: <20181102110653.118257-1-arnd@arndb.de>
In-Reply-To: <20181102110653.118257-1-arnd@arndb.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 7 Nov 2018 13:22:35 +0100
Message-ID: <CAJZ5v0grpLSh=QAO3iwwrX0MPzJVxFenFo3j7V+JpeYEu63CjA@mail.gmail.com>
Subject: Re: [PATCH] ACPI / PMIC: xpower: fix IOSF_MBI dependency
To:     Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 2, 2018 at 12:07 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> We still get a link failure with IOSF_MBI=m when the xpower driver
> is built-in:
>
> drivers/acpi/pmic/intel_pmic_xpower.o: In function `intel_xpower_pmic_update_power':
> intel_pmic_xpower.c:(.text+0x4f2): undefined reference to `iosf_mbi_block_punit_i2c_access'
> intel_pmic_xpower.c:(.text+0x5e2): undefined reference to `iosf_mbi_unblock_punit_i2c_access'
>
> This makes the dependency stronger, so we can only build when IOSF_MBI
> is built-in.
>
> Fixes: 6a9b593d4b6f ("ACPI / PMIC: xpower: Add depends on IOSF_MBI to Kconfig entry")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/acpi/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 18851e7eedd5..31a3c4a03f61 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -514,7 +514,7 @@ config CRC_PMIC_OPREGION
>
>  config XPOWER_PMIC_OPREGION
>         bool "ACPI operation region support for XPower AXP288 PMIC"
> -       depends on MFD_AXP20X_I2C && IOSF_MBI
> +       depends on MFD_AXP20X_I2C && IOSF_MBI=y
>         help
>           This config adds ACPI operation region support for XPower AXP288 PMIC.
>
> --

At this point I'm inclined to apply the patch as is as a short-term
fix and improvements can be made on top of it.

Any objections?
