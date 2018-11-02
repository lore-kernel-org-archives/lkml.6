Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B2BC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 11:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A46A320657
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 11:09:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A46A320657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbeKBUQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 16:16:24 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40095 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbeKBUQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 16:16:24 -0400
Received: by mail-ed1-f67.google.com with SMTP id z12-v6so1530420edp.7
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 04:09:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UIFc9oNn9r8kf5ryMUgyfVV0qnVjMHy456yKeip5pw0=;
        b=uoZTPG7DpfgR7MJadzR9tYNQ3l/wYcyJWuLkt7oJGB5X+/3tQO+DyVpUQBeqpHpHjW
         UBsqLd0X8Llv5fp/lOudl7KIuY5/i5IBsjLuC6RwX6NIM78H0Km+LXVmwIGmjAJA21gQ
         xo7Q9MwE1CD7EaXH5js6v4sPQJBbjfNF7K1iR5uSJPQUeD4QZv02hTkPj/G+6A7CW2Be
         5zN+KegwR1ZPQWzXBO7M3QVehKejgfIPsE/jCIT0LCfkv7czX5PuLT7feGNCUTAH5rXE
         IcjFJtR7i8jOQB1+G3HYXKhxc9bXZgSC8S/RHGWmRjuucvjRQoerNg8GqHXlUjU65u9r
         Ff7A==
X-Gm-Message-State: AGRZ1gKY6rrT990/O0PYx9cj51r2JW95XdnysM0g9dhscq1gWGQneHTr
        p9wjR+M/DcRTS+U9GXgx+WQNVYp619I=
X-Google-Smtp-Source: AJdET5e3j5qilAIJFHQaUu0AG/7Li5uK3rwLr13awE6NoafY/Bm//rR1jVGR8toBRYj6vvlly2esjw==
X-Received: by 2002:a50:b203:: with SMTP id o3-v6mr8664871edd.11.1541156975856;
        Fri, 02 Nov 2018 04:09:35 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id m90-v6sm4835346ede.58.2018.11.02.04.09.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 04:09:35 -0700 (PDT)
Subject: Re: [PATCH] ACPI / PMIC: xpower: fix IOSF_MBI dependency
To:     Arnd Bergmann <arnd@arndb.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181102110653.118257-1-arnd@arndb.de>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <3c6ddd48-b419-52db-38d3-e0ebf9c46dfc@redhat.com>
Date:   Fri, 2 Nov 2018 12:09:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20181102110653.118257-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 02-11-18 12:06, Arnd Bergmann wrote:
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

Hmm, it is probably better to make IOSF_MBI a bool, it is selected by:
X86_INTEL_QUARK and X86_INTEL_LPSS which are both bools themselves.

Arguably it should also be hidden and only enabled through these selects.
Does someone from Intel have an opinion on making it hidden?

Regards,

Hans



> ---
>   drivers/acpi/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 18851e7eedd5..31a3c4a03f61 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -514,7 +514,7 @@ config CRC_PMIC_OPREGION
>   
>   config XPOWER_PMIC_OPREGION
>   	bool "ACPI operation region support for XPower AXP288 PMIC"
> -	depends on MFD_AXP20X_I2C && IOSF_MBI
> +	depends on MFD_AXP20X_I2C && IOSF_MBI=y
>   	help
>   	  This config adds ACPI operation region support for XPower AXP288 PMIC.
>   
> 
