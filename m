Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33CC6C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 08:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 084BA21773
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 08:55:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbeLXIzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 03:55:40 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39859 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbeLXIzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 03:55:40 -0500
Received: by mail-ed1-f66.google.com with SMTP id b14so9621458edt.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 00:55:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uvgDl0zaRclmAWSUoyGF73jp9Q0y9utqlwKPLMiDedM=;
        b=nw0s2EbKE/Z2bYtqNfLtnJHMV8B4Gw/VBhs3dKSFHLh2s5e/kMPy+w+RkyLDmZcqlr
         RafBZ5qzZRk7YB8HfU5RGjgESBocPLZu1qzchr6ZyP5bA0Qkd7nfGaHdv+8/9NwcUilY
         C4TQp6A23Hi4ep2/vyq38LFnraZekxtsRnb2Nl546LdZ4pta3o6ygUCCPJ0W/0ld6g+1
         qoCK+Ba647EIy5VbduystklmkDh/agLhjZH+UbZ7XIUfYsWaZpHAppueySkmSx1Eu6c9
         ltpwEIE5u8Oh//yQ72p6rvGDOU9d5bYMvb0VX88Qp7shVRdIKyPwMe8wJpj1qX6qEl1R
         q+jA==
X-Gm-Message-State: AA+aEWZ2WnJA0NhyJfKWZ8thSspK/343SuTTglzXyV1g8yCl4YTHKHkN
        IrzUSBpYuBXyO84d8GElbitUqT6y7Gg=
X-Google-Smtp-Source: AFSGD/VdcA83vWXu0jMmWjRNqba1ITVqBs2MmDfWz/ohdeUlnho4PEFvTfAvWkoqONjY+XO9fYZuDA==
X-Received: by 2002:a50:8e16:: with SMTP id 22mr10057084edw.269.1545641737689;
        Mon, 24 Dec 2018 00:55:37 -0800 (PST)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id s19-v6sm4713219ejz.2.2018.12.24.00.55.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Dec 2018 00:55:36 -0800 (PST)
Subject: Re: [PATCH v2 0/9] i2c: move handling of suspended adapters to the
 core
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-i2c@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20181222202623.4521-1-wsa+renesas@sang-engineering.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <7fd31445-6cf8-5094-3cd8-d6ca5c059541@redhat.com>
Date:   Mon, 24 Dec 2018 09:55:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181222202623.4521-1-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 22-12-18 21:26, Wolfram Sang wrote:
> Here is the new version without specific I2C helpers but using the
> 'is_suspended' flag from the PM core. I didn't like messing with the
> flag directly, so I did a helper in patch 1. So far, I like the
> approach. The diffstat looks nice, and i2c-rcar.c and i2c-sh_mobile.c
> rejected rightfully too later transfers without further modifications.
> Tested on a Renesas Lager board (R-Car H2).
> 
> I dropped a few Tested-by tags because I think this approach is too
> different from V1 to keep them. I hope you guys can have a look again.
> Thanks for all the testing, so far!
> 
> A branch can be found here:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/i2c/reject-when-suspended
> 
> If this series is acceptable, I'd suggest to take it via my i2c tree
> after rc1. And then I'll provide an immutable branch for the PM tree to
> pick. Let me know if this works for you.
> 
> And thanks to Renesas for funding this work!

Series looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans




> 
> Thanks and kind regards,
> 
>     Wolfram
> 
> Wolfram Sang (9):
>    PM / core: add helper to return suspend status of a device
>    i2c: reject new transfers when adapters are suspended
>    i2c: synquacer: remove unused is_suspended flag
>    i2c: brcmstb: don't open code to reject transfers when suspended
>    i2c: zx2967: don't open code to reject transfers when suspended
>    i2c: sprd: don't use pdev as variable name for struct device *
>    i2c: sprd: don't open code to reject transfers when suspended
>    i2c: exynos5: don't open code to reject transfers when suspended
>    i2c: s3c2410: don't open code to reject transfers when suspended
> 
>   Documentation/i2c/fault-codes      |  4 ++++
>   drivers/i2c/busses/i2c-brcmstb.c   | 22 +-------------------
>   drivers/i2c/busses/i2c-exynos5.c   | 10 ----------
>   drivers/i2c/busses/i2c-s3c2410.c   |  7 -------
>   drivers/i2c/busses/i2c-sprd.c      | 32 ++++++++++--------------------
>   drivers/i2c/busses/i2c-synquacer.c |  5 -----
>   drivers/i2c/busses/i2c-zx2967.c    |  8 --------
>   drivers/i2c/i2c-core-base.c        |  3 +++
>   drivers/i2c/i2c-core-smbus.c       |  4 ++++
>   include/linux/device.h             |  5 +++++
>   10 files changed, 27 insertions(+), 73 deletions(-)
> 
