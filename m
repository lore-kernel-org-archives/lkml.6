Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9FEC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 12:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9314C20817
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 12:40:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9314C20817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730964AbeKGWKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 17:10:16 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37961 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbeKGWKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 17:10:16 -0500
Received: by mail-ed1-f65.google.com with SMTP id a2-v6so8700166edi.5
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 04:40:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n2vey61mauEgB8Bos0irlzpX4C+U/tQvb6hV36sZRbg=;
        b=VIOe2pYG721Uteu84fcGDM3Kpy8nMIYA/pG+46LS3wYQ136eRMHJ0SvKw087vOBt12
         joOKJHdn7AxlxP0oclpcjIO35ML2EGOzPYXoXDdJ3pxOdD4IxHnOki11Ocd/T9/u+zLy
         Yk5z2JjHo+g1RjO3LCSyv/Dl3DqKUDxNeKlu90pHO4jTmHttdtwEEu7g5IhO6wWasjb5
         V2WBxkkvv7FH0F70o/GBoenaSqnkZMp5BY06wyAhs04Hefmi4rJO1CvHF+w/ufrcnkg2
         LLj1DGoJ4iXW82zST2PNgkKlThs0CRexqG7okr6caYz/2nKIW/A6TnwOtKfvOFZPXh9S
         VEAw==
X-Gm-Message-State: AGRZ1gIBbMLMnNl9mHb62t5EKeambuqiO8soQYcmGvKse/GBolvL8Rj9
        Z3+I2lvMtKG0sItZmWx4WtlH3bBiVWc=
X-Google-Smtp-Source: AJdET5e9j5ikcairMZQmBnTvUSLzMFP1PSP6RJ2aD6DwX9BswYD/zAx0r5HNrPaNmw8DeTX1iOepwg==
X-Received: by 2002:a50:b4bb:: with SMTP id w56-v6mr30936edd.179.1541594401111;
        Wed, 07 Nov 2018 04:40:01 -0800 (PST)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id m1-v6sm224803edb.10.2018.11.07.04.40.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 04:40:00 -0800 (PST)
Subject: Re: [PATCH] ACPI / PMIC: xpower: fix IOSF_MBI dependency
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20181102110653.118257-1-arnd@arndb.de>
 <CAJZ5v0grpLSh=QAO3iwwrX0MPzJVxFenFo3j7V+JpeYEu63CjA@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <74d77804-bc05-4060-3182-a7cdecba3c53@redhat.com>
Date:   Wed, 7 Nov 2018 13:39:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0grpLSh=QAO3iwwrX0MPzJVxFenFo3j7V+JpeYEu63CjA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 07-11-18 13:22, Rafael J. Wysocki wrote:
> On Fri, Nov 2, 2018 at 12:07 PM Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> We still get a link failure with IOSF_MBI=m when the xpower driver
>> is built-in:
>>
>> drivers/acpi/pmic/intel_pmic_xpower.o: In function `intel_xpower_pmic_update_power':
>> intel_pmic_xpower.c:(.text+0x4f2): undefined reference to `iosf_mbi_block_punit_i2c_access'
>> intel_pmic_xpower.c:(.text+0x5e2): undefined reference to `iosf_mbi_unblock_punit_i2c_access'
>>
>> This makes the dependency stronger, so we can only build when IOSF_MBI
>> is built-in.
>>
>> Fixes: 6a9b593d4b6f ("ACPI / PMIC: xpower: Add depends on IOSF_MBI to Kconfig entry")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>   drivers/acpi/Kconfig | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
>> index 18851e7eedd5..31a3c4a03f61 100644
>> --- a/drivers/acpi/Kconfig
>> +++ b/drivers/acpi/Kconfig
>> @@ -514,7 +514,7 @@ config CRC_PMIC_OPREGION
>>
>>   config XPOWER_PMIC_OPREGION
>>          bool "ACPI operation region support for XPower AXP288 PMIC"
>> -       depends on MFD_AXP20X_I2C && IOSF_MBI
>> +       depends on MFD_AXP20X_I2C && IOSF_MBI=y
>>          help
>>            This config adds ACPI operation region support for XPower AXP288 PMIC.
>>
>> --
> 
> At this point I'm inclined to apply the patch as is as a short-term
> fix and improvements can be made on top of it.
> 
> Any objections?

Not from me, go for it :)

Regards,

Hans

