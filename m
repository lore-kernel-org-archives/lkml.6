Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292BFC46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E489020827
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uy7wE0D/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E489020827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729902AbeKFAgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 19:36:41 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39616 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729588AbeKFAgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 19:36:41 -0500
Received: by mail-qk1-f195.google.com with SMTP id e4so15241035qkh.6;
        Mon, 05 Nov 2018 07:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=YPnAi1esP9IKU6Xc3LVuqpFvOOLgyC8RGZAv05a5sP4=;
        b=Uy7wE0D/+G+nKh7w3jo8ZvIAj+8piaLEFIxy84QlHm+swW6u4O2AIXRv4/lnOZ82uF
         TCCDajOXkkU5TpsCQsFY4vnltxhqZ1q/bEUeNDLb8otNgb+r+BUgQVaicegeP4HAGcVJ
         ZFAe0AuNpJAYo11yiasP7oVmnmh65v3DxwxqKu8PcmEfBESPdyiDRkvxOZAMU1gGVrRM
         TLEnN54pjPZ/3HNaPxyaMn/hsoprPuhdxufiF/DHUmViaTY6m2T1yOBKtS0XiA8js0Bz
         /ZflbSnWeeBMQW56ZrEgIYJ0MJVHWemVi+LAa+XgQAsWiSBC6MGtO+Zu504yK4TEjgfm
         af1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=YPnAi1esP9IKU6Xc3LVuqpFvOOLgyC8RGZAv05a5sP4=;
        b=bpNjaY5ZoVQmqX5czSfMo6c4yhserumSwJp9QuLblBDLLUa5fxuuSOBRjLuhlO/2pR
         0vYhyqn+sYKHFnoSPz6PxJl4Th0J2DB7QftgyAK8OcZekTT/zKS03WeJ3SfY7v+kCAxB
         XmMdZwMl182xXQrE7DUK4x0ld/Vs6upFjjKdBRPrB18C3mouStzonyTlBd9PTaTjucCw
         T4eXSKJUlvcaIIqbpcFWNjYK2nNA+OE489eQMujSgqBgrXMOyxCv8sLGrRZEobCUwdg6
         vH5Kr7VHoW/u1gRY8r2Dl8HBPOWEAnixNglmh1YY5sylU7T2FnFTPu9paXSLTYe2rhAd
         rI+Q==
X-Gm-Message-State: AGRZ1gIi0h4aJaLPtJ5aFPrf51Hnf1oW8hdSZPeuytOEWr1pwBMxtwyt
        DBsB54RR5wscl4d3VJSJ+51iZpWV5PoZt2qqRb8=
X-Google-Smtp-Source: AJdET5eHcVzbNpbYJJUBrbD0ZyCDwP9zPpRNHfQQM5xmEBY2dNXbcbEQrnAj1T4uzU4v6v9x0kje7xuEtIOqdMOoXEE=
X-Received: by 2002:ac8:2c34:: with SMTP id d49mr7746223qta.152.1541430990161;
 Mon, 05 Nov 2018 07:16:30 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a0c:9881:0:0:0:0:0 with HTTP; Mon, 5 Nov 2018 07:16:29 -0800 (PST)
In-Reply-To: <20181105133301.GE10650@smile.fi.intel.com>
References: <20181102110653.118257-1-arnd@arndb.de> <20181102151644.GB10650@smile.fi.intel.com>
 <CAK8P3a2ESTVLG3q0LgDmjqa_LbYhLCeqYW3Jod6WUCh2fwFOZg@mail.gmail.com> <20181105133301.GE10650@smile.fi.intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 5 Nov 2018 16:16:29 +0100
X-Google-Sender-Auth: sS757O9u1LHaW2K2mwskOm5YbIk
Message-ID: <CAK8P3a1NqtY-WH=m9hOO=0=OYEvH8ok5bsgAX7d4hQCzsWAThQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI / PMIC: xpower: fix IOSF_MBI dependency
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/5/18, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> On Fri, Nov 02, 2018 at 11:07:34PM +0100, Arnd Bergmann wrote:
>> On 11/2/18, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>> > On Fri, Nov 02, 2018 at 12:06:43PM +0100, Arnd Bergmann wrote:
>
>> >> -	depends on MFD_AXP20X_I2C && IOSF_MBI
>> >> +	depends on MFD_AXP20X_I2C && IOSF_MBI=y
>> >
>> > To me sounds like
>> >
>> > select IOSF_MBI would be more appropriate here.
>>
>> It looks like we have a mix of the two two, with most drivers
>> using 'select' and only a few ones using 'depends on'. Mixing
>> the two often leads to trouble, especially for user-visible
>> symbols.
>>
>> Making it a hidden symbol that is always selected is probably
>> fine, but then every driver selecting it must also use 'depends
>> on X86 && PCI'.
>
> I doubt every is a correct word here. Whenever driver uses IOSF_MBI it
> implies X86 and PCI (or should have those dependencies in mind already).

I mean it must depend on those two in some form. If a driver uses 'depends on
IOSF_MBI' today, that is implied through that dependency. Changing it
to 'select'
means we have to add that dependency, like

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 56ccb1ea7da5..fb750a8a9b77 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -489,6 +489,7 @@ config I2C_DESIGNWARE_PLATFORM
        tristate "Synopsys DesignWare Platform"
        select I2C_DESIGNWARE_CORE
        depends on (ACPI && COMMON_CLK) || !ACPI
+       select IOSF_MBI if I2C_DESIGNWARE_BAYTRAIL
        help
          If you say yes to this option, support will be included for the
          Synopsys DesignWare I2C adapter.
@@ -520,9 +521,8 @@ config I2C_DESIGNWARE_PCI

 config I2C_DESIGNWARE_BAYTRAIL
        bool "Intel Baytrail I2C semaphore support"
-       depends on ACPI
-       depends on (I2C_DESIGNWARE_PLATFORM=m && IOSF_MBI) || \
-                  (I2C_DESIGNWARE_PLATFORM=y && IOSF_MBI=y)
+       depends on ACPI && X86 && PCI
+       depends on I2C_DESIGNWARE_PLATFORM
        help
          This driver enables managed host access to the PMIC I2C bus on select
          Intel BayTrail platforms using the X-Powers AXP288 PMIC. It allows

For anything that already has the dependency, nothing changes.

    Arnd
