Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9534C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 16:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 578D720661
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 16:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gqM0Zocn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 578D720661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbeH3UZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 16:25:56 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:39454 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbeH3UZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 16:25:56 -0400
Received: by mail-io0-f196.google.com with SMTP id l7-v6so8048396iok.6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 09:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YiCG75RsxiC4V9bYQLWHLXMbEvVwaSVLMlg36jGwtBY=;
        b=gqM0ZocnNpIPv7Eqfk3Ymvrn/WEYdbiog9QmtwDjwMuqahvK3wfiXsCPvQbQJjINgb
         Wakd3w7FSbDKDXU6F16m6MMMwFnXaKkEUaDCoS7q5GhbLeDYghzdh+XrTIjrR4I3fYjr
         GYq5r3emz/NIgiphAZce9/7jEqsdvnNYW+s0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YiCG75RsxiC4V9bYQLWHLXMbEvVwaSVLMlg36jGwtBY=;
        b=fMoVfA4tukC3BeGL1Y8dTjMvUa5lc5qYhuN0qbM+IbAbNU/YtA9v90GKO4EJRZVWG6
         uPS45+8jHfvCaE1w85OId0ldYsLt2cI2i7vdtS7eRP4nPczC5lXvGpsCnXjEb8PZJcDY
         mcfF2W7TB72tCwBo2egT8o7rSGG6Ine38H+huvYEY5y7+xLVvQcZUEM4WBN0wEa8EMv2
         gDNLa2fSar6BXqrOD8BPMO/6aryqs6jQ02NkwixS7QQX7fNGbyIoh33le4mf/42Q9kKU
         4FZi1cgAbAqEraXMFIUtmqvANbOed5rSDqmzHs5aPgHBdaIbMLiUP0A1+7s9DyNBJ0nv
         Sp6g==
X-Gm-Message-State: APzg51A6fm0xn4fi6mlZ2xppX2OUVvKHh3wlgXkonRu5gHi4nWMGhZWQ
        d4pb1WB071amJTsGMjkYRWuT68noOP4XRI+klDIU1w==
X-Google-Smtp-Source: ANB0Vdaam8Qqwbc+m6bnqoB1DhNYAuNnxCSaLGNzHKHQP+pFS/1yxL4L8Rs0kUWReVhDAEwMpJfrAw3UVVgVILSiVZU=
X-Received: by 2002:a6b:be83:: with SMTP id o125-v6mr9608389iof.173.1535646181018;
 Thu, 30 Aug 2018 09:23:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:ac05:0:0:0:0:0 with HTTP; Thu, 30 Aug 2018 09:23:00
 -0700 (PDT)
In-Reply-To: <CAOesGMho8CfT7iDXadmkB5=7DoOi6n8qXcS9X643vf+Y0BbD6w@mail.gmail.com>
References: <1535563287-24803-1-git-send-email-scott.branden@broadcom.com>
 <CAOesGMhjcJ1p3QcEYb9fsx3fMXAOsgR2njOq=VKgEbWGwJi36g@mail.gmail.com>
 <fb07b89d-d427-5e59-9f17-b12df26284ec@broadcom.com> <CAKv+Gu-R7eX=aj=O2-gpzmp0K4t0T4s536UiqJZs0WuxRjkYwQ@mail.gmail.com>
 <CAOesGMho8CfT7iDXadmkB5=7DoOi6n8qXcS9X643vf+Y0BbD6w@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 30 Aug 2018 18:23:00 +0200
Message-ID: <CAKv+Gu_mKU+RdPgg2Dfezy4-L+KDEEBx02R49ObomRhEkJJ6Mw@mail.gmail.com>
Subject: Re: [PATCH] arm64: defconfig: enable EFI_ARMSTUB_DTB_LOADER
To:     Olof Johansson <olof@lixom.net>
Cc:     Scott Branden <scott.branden@broadcom.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 August 2018 at 17:06, Olof Johansson <olof@lixom.net> wrote:
> On Wed, Aug 29, 2018 at 10:54 PM, Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
>> On 29 August 2018 at 20:59, Scott Branden <scott.branden@broadcom.com> wrote:
>>> Hi Olof,
>>>
>>>
>>> On 18-08-29 11:44 AM, Olof Johansson wrote:
>>>>
>>>> Hi,
>>>>
>>>> On Wed, Aug 29, 2018 at 10:21 AM, Scott Branden
>>>> <scott.branden@broadcom.com> wrote:
>>>>>
>>>>> Enable EFI_ARMSTUB_DTB_LOADER to add support for the dtb= command line
>>>>> parameter to function with efi loader.
>>>>>
>>>>> Required to boot on existing bootloaders that do not support devicetree
>>>>> provided by the platform or by the bootloader.
>>>>>
>>>>> Fixes: 3d7ee348aa41 ("efi/libstub/arm: Add opt-in Kconfig option for the
>>>>> DTB loader")
>>>>> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
>>>>
>>>> Why did Ard create an option for this if it's just going be turned on
>>>> in default configs? Doesn't make sense to me.
>>>>
>>>> It would help to know what firmware still is crippled and how common
>>>> it is, since it's been a few years that this has been a requirement by
>>>> now.
>>>
>>> Broadcom NS2 and Stingray in current development and production need this
>>> option in the kernel enabled in order to boot.
>>
>> And these production systems run mainline kernels in a defconfig configuration?
>>
>> The simply reality is that the DTB loader has been deprecated for a
>> good reason: it was only ever intended as a development hack anyway,
>> and if we need to treat the EFI stub provided DTB as a first class
>> citizen, there are things we need to fix to make things works as
>> expected. For instance, GRUB will put a property in the /chosen node
>> for the initramfs which will get dropped if you boot with dtb=.
>>
>> Don't be surprised if some future enhancements of the EFI stub code
>> depend on !EFI_ARMSTUB_DTB_LOADER. On UEFI systems, DTBs [or ACPI
>> tables] are used by the firmware to describe itself and the underlying
>> platform to the OS, and the practice of booting with DTB file images
>> (taken from the kernel build as well) conflicts with that view. Note
>> that GRUB still permits you to load DTBs from files (and supports more
>> sources than just the file system the kernel Image was loaded from).
>
> Ard,
>
> Maybe a WARN() splat would be more useful as a phasing-out method than
> removing functionality for them that needs to be reinstated through
> changing the config?
>

We don't have any of that in the stub, and inventing new ways to pass
such information between the stub and the kernel proper seems like a
cart-before-horse kind of thing to me. The EFI stub diagnostic
messages you get on the serial console are not recorded in the kernel
log buffer, so they only appear if you actually look at the serial
output.

> Once the stub and the boot method is there, it's hard to undo as we
> can see here. Being loud and warn might be more useful, and set a
> timeline for hard removal (12 months?).
>

The dtb= handling is still there, it is just not enabled by default.
We can keep it around if people are still using it. But as I pointed
out, we may decide to make new functionality available only if it is
disabled, and at that point, we'll have to choose between one or the
other in defconfig, which is annoying.

> Scott; an alternative for you is to do a boot wrapper that bundles a
> DT and kernel, and boot that instead of the kernel image (outside of
> the kernel tree). Some 32-bit platforms from Marvell use that. That
> way the kernel will just see it as a normally passed in DT.
>

Or use GRUB. It comes wired up in all the distros, and let's you load
a DT binary from anywhere you can imagine, as opposed to the EFI stub
which can only load it if it happens to reside in the same file system
(or even directory - I can't remember) as the kernel image. Note that
the same reservations apply to doing that - the firmware is no longer
able to describe itself to the OS via the DT, which is really the only
conduit it has available on an arm64 system..
