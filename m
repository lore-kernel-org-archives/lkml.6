Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA46C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 21:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1EC02083F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 21:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YnPNCLgq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1EC02083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbeIABhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 21:37:55 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42729 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727281AbeIABhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 21:37:54 -0400
Received: by mail-qk1-f194.google.com with SMTP id g13-v6so2333845qki.9
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 14:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=OPsUovlMABJGeFdHeNwnykwxvaWpvnEXhRqBdRUkVPc=;
        b=YnPNCLgqYZpPY4/xjjhz4vQGdvZd0/YDDKa31OWMJUIBXI+Z9Fw6xmMg3SMc3cBGfn
         JspftWs5GbpOtZNIgXzzHvym2og5cLhBNnPuiN+FOFKshcfSdyJGP+Is7YSibCNVzXi8
         9dIlaJ/bpBo7uWN5XyXAExhreHNCyrlDcHG4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=OPsUovlMABJGeFdHeNwnykwxvaWpvnEXhRqBdRUkVPc=;
        b=JMrlzmYGwWx40BD1rK432cO3ZSUthLVYrpFzjM2REneU/eInLjdhinSKQRKD5c1rx1
         mUhjCKZIBSe7FtzasT5lZ8vhAPRyHwur7MOgumcNOWVM0flUJluAUnHuYqg6jlfrAww4
         N+3XRHniG1X/BbamL6ToRu1TxsROZZd+11HncYZOCtAvpaLNOQfQIJ4lEYFuTJJgFVpu
         bsl4l+BXAlP6eQn70gjDvD6aGRqTSEewe5xKxNQs6Hhr0ZpTF+Q3o/uJPY0Dcf0q/tGO
         Tt10E8KU1Y7Iof8W1ArOLzpiRUhaHRwmTUNkrxQP/DJGqwrq8tzG/RS30rKmL8vf8tlr
         zjfQ==
X-Gm-Message-State: APzg51Aj8a3yzKwSHXgQtLyfjlcE427LxFp6vwia8kqwC+N8mBz702b+
        sSPR6MYSwoCc1QRRb7UNAoDFKApWPXHqGw==
X-Google-Smtp-Source: ANB0VdYJCdaEt+dylGhW4SAOQp6Is3HJ5znQDlSEbvyIGpDAymKJh70EqdcPdjgq+DhVyLvGthHpew==
X-Received: by 2002:a37:8106:: with SMTP id c6-v6mr16638121qkd.261.1535750913181;
        Fri, 31 Aug 2018 14:28:33 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id c15-v6sm5998049qkm.42.2018.08.31.14.28.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 14:28:32 -0700 (PDT)
Subject: Re: [PATCH] arm64: defconfig: enable EFI_ARMSTUB_DTB_LOADER
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Olof Johansson <olof@lixom.net>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1535563287-24803-1-git-send-email-scott.branden@broadcom.com>
 <CAOesGMhjcJ1p3QcEYb9fsx3fMXAOsgR2njOq=VKgEbWGwJi36g@mail.gmail.com>
 <fb07b89d-d427-5e59-9f17-b12df26284ec@broadcom.com>
 <CAKv+Gu-R7eX=aj=O2-gpzmp0K4t0T4s536UiqJZs0WuxRjkYwQ@mail.gmail.com>
 <CAOesGMho8CfT7iDXadmkB5=7DoOi6n8qXcS9X643vf+Y0BbD6w@mail.gmail.com>
 <CAKv+Gu_mKU+RdPgg2Dfezy4-L+KDEEBx02R49ObomRhEkJJ6Mw@mail.gmail.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <fa0a06bc-2a4d-000e-66ec-852e6ff3012e@broadcom.com>
Date:   Fri, 31 Aug 2018 14:28:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu_mKU+RdPgg2Dfezy4-L+KDEEBx02R49ObomRhEkJJ6Mw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Olof/Ard,


On 18-08-30 09:23 AM, Ard Biesheuvel wrote:
> On 30 August 2018 at 17:06, Olof Johansson <olof@lixom.net> wrote:
>> On Wed, Aug 29, 2018 at 10:54 PM, Ard Biesheuvel
>> <ard.biesheuvel@linaro.org> wrote:
>>> On 29 August 2018 at 20:59, Scott Branden <scott.branden@broadcom.com> wrote:
>>>> Hi Olof,
>>>>
>>>>
>>>> On 18-08-29 11:44 AM, Olof Johansson wrote:
>>>>> Hi,
>>>>>
>>>>> On Wed, Aug 29, 2018 at 10:21 AM, Scott Branden
>>>>> <scott.branden@broadcom.com> wrote:
>>>>>> Enable EFI_ARMSTUB_DTB_LOADER to add support for the dtb= command line
>>>>>> parameter to function with efi loader.
>>>>>>
>>>>>> Required to boot on existing bootloaders that do not support devicetree
>>>>>> provided by the platform or by the bootloader.
>>>>>>
>>>>>> Fixes: 3d7ee348aa41 ("efi/libstub/arm: Add opt-in Kconfig option for the
>>>>>> DTB loader")
>>>>>> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
>>>>> Why did Ard create an option for this if it's just going be turned on
>>>>> in default configs? Doesn't make sense to me.
>>>>>
>>>>> It would help to know what firmware still is crippled and how common
>>>>> it is, since it's been a few years that this has been a requirement by
>>>>> now.
>>>> Broadcom NS2 and Stingray in current development and production need this
>>>> option in the kernel enabled in order to boot.
>>> And these production systems run mainline kernels in a defconfig configuration?
>>>
>>> The simply reality is that the DTB loader has been deprecated for a
>>> good reason: it was only ever intended as a development hack anyway,
>>> and if we need to treat the EFI stub provided DTB as a first class
>>> citizen, there are things we need to fix to make things works as
>>> expected. For instance, GRUB will put a property in the /chosen node
>>> for the initramfs which will get dropped if you boot with dtb=.
>>>
>>> Don't be surprised if some future enhancements of the EFI stub code
>>> depend on !EFI_ARMSTUB_DTB_LOADER. On UEFI systems, DTBs [or ACPI
>>> tables] are used by the firmware to describe itself and the underlying
>>> platform to the OS, and the practice of booting with DTB file images
>>> (taken from the kernel build as well) conflicts with that view. Note
>>> that GRUB still permits you to load DTBs from files (and supports more
>>> sources than just the file system the kernel Image was loaded from).
>> Ard,
>>
>> Maybe a WARN() splat would be more useful as a phasing-out method than
>> removing functionality for them that needs to be reinstated through
>> changing the config?
>>
> We don't have any of that in the stub, and inventing new ways to pass
> such information between the stub and the kernel proper seems like a
> cart-before-horse kind of thing to me. The EFI stub diagnostic
> messages you get on the serial console are not recorded in the kernel
> log buffer, so they only appear if you actually look at the serial
> output.
>
>> Once the stub and the boot method is there, it's hard to undo as we
>> can see here. Being loud and warn might be more useful, and set a
>> timeline for hard removal (12 months?).
>>
> The dtb= handling is still there, it is just not enabled by default.
> We can keep it around if people are still using it. But as I pointed
> out, we may decide to make new functionality available only if it is
> disabled, and at that point, we'll have to choose between one or the
> other in defconfig, which is annoying.
dtb= handling does need to be enabled in the only defconfig
upstreamed though.  ARM64 maintainers have mandated a single
defconfig upstreamed up this point.  If another incompatible
efistub is needed in the future then 2 kernel images would need
to be built to support booting on all platforms.
>
>> Scott; an alternative for you is to do a boot wrapper that bundles a
>> DT and kernel, and boot that instead of the kernel image (outside of
>> the kernel tree). Some 32-bit platforms from Marvell use that. That
>> way the kernel will just see it as a normally passed in DT.
The EFI stub is the boot wrapper?  Everything works perfectly today
with the upstream kernel (with the defconfig fix of the efistub regression).
We support a single kernel image booting with multiple DTs
(selected in UEFI and passed in via dtb= on command line).
>>
> Or use GRUB. It comes wired up in all the distros, and let's you load
> a DT binary from anywhere you can imagine, as opposed to the EFI stub
> which can only load it if it happens to reside in the same file system
> (or even directory - I can't remember) as the kernel image. Note that
> the same reservations apply to doing that - the firmware is no longer
> able to describe itself to the OS via the DT, which is really the only
> conduit it has available on an arm64 system..
Ard, GRUB is not a requirement to boot the kernel.  But, it sounds like
using GRUB may be a solution to your problem?  You could use GRUB
and leave the efistub alone then (or at least leave dtb= in the upstream
defconfg).

Regards,
  Scott

