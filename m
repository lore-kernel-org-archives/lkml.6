Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91EE0C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 17:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B6E42075E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 17:28:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Eehfu6WE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B6E42075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbeIEV7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 17:59:09 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34154 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727629AbeIEV7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 17:59:09 -0400
Received: by mail-qk1-f195.google.com with SMTP id d15-v6so5435908qkc.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 10:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=WtednLBCYi/JKtzhl8JcGANt2+iJhfuTfwmB5akQbPM=;
        b=Eehfu6WE0Y/Jw/s10H7OokSVBu5obrFGq3eN5QbqvygveRSK44PuOOpaSC4QXGQ2ag
         icwCeii/W1bvsImsTRRF2wMMDg1dvZ1n0tiHm/UVGXNlL4aP9kEN8pmuamf56Xwd5n/h
         giZrFZ+QWwmGdscDQ1i8kzlg9ehyzWxIyzi+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=WtednLBCYi/JKtzhl8JcGANt2+iJhfuTfwmB5akQbPM=;
        b=nymzdrHR1iEKQR+FSmDXFOGkB93y4VCxtsr+uKyz5fwPZqw611pPEHg266DFo6IHKY
         HKjMeAY3WXwhU7ylLf/EX/Fmu1k32U9IpgNzD91s4K9UMsDraWlCZ6Nqr+e5HiLUlly4
         fvc0PS1m62JawaBEXTpgY/uZq9MmfMXfurum1Vq+GicD/QxgKF3XcBM2VwmnZ0bg5OZ7
         Hr+ZSRMgg5HGy/5s0TFUBOLbq2ze5BsmjM4oS93dIjMbO5mhFdYFbpEyLQMylHRpSebZ
         dwL41iIZXSVqbL6HJrjR4VW0noei25Caofj0tHAQotJRDITjsAU3yZmRuXOq2uLTBdqb
         CTwA==
X-Gm-Message-State: APzg51C0OWZ+lWbrrzsPx4bE+RMpEHO07mnxB+Kt5uy2rqGTP7FnBEm8
        QBQWa1/h1V0hVvwhFWET0kgSHQ==
X-Google-Smtp-Source: ANB0Vdadz23UAkF8zCZHJCkN35LrxU0iyJTPiace5ilMGgDGkcR/r9buIJADxfclK+yEbFd3qws1XQ==
X-Received: by 2002:a37:2821:: with SMTP id o33-v6mr33429936qkh.83.1536168479544;
        Wed, 05 Sep 2018 10:27:59 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id w12-v6sm1522275qtj.93.2018.09.05.10.27.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 10:27:58 -0700 (PDT)
Subject: Re: [PATCH] arm64: defconfig: enable EFI_ARMSTUB_DTB_LOADER
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Grant Likely <grant.likely@secretlab.ca>,
        Olof Johansson <olof@lixom.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Leif Lindholm <leif.lindholm@linaro.org>,
        Alexander Graf <agraf@suse.de>
References: <1535563287-24803-1-git-send-email-scott.branden@broadcom.com>
 <CAOesGMhjcJ1p3QcEYb9fsx3fMXAOsgR2njOq=VKgEbWGwJi36g@mail.gmail.com>
 <fb07b89d-d427-5e59-9f17-b12df26284ec@broadcom.com>
 <CAKv+Gu-R7eX=aj=O2-gpzmp0K4t0T4s536UiqJZs0WuxRjkYwQ@mail.gmail.com>
 <CAOesGMho8CfT7iDXadmkB5=7DoOi6n8qXcS9X643vf+Y0BbD6w@mail.gmail.com>
 <CAKv+Gu_mKU+RdPgg2Dfezy4-L+KDEEBx02R49ObomRhEkJJ6Mw@mail.gmail.com>
 <CAOesGMgLHx3+j1bWEsMWsN-yjGNZyLOpAjLg0Jut8gG=ADE25g@mail.gmail.com>
 <CAKv+Gu_x=bS4xJcD_LuEnnN=Lx4Jc87uK8J_ACdA9EeUqtM3Yg@mail.gmail.com>
 <CACxGe6uK+N5XUqZhH7gAQXoq+QXMvFPHF_i4WqivrufTU=0cog@mail.gmail.com>
 <bf917897-1697-a6c4-7f77-8dfa74dddc8a@broadcom.com>
 <CAKv+Gu8FK9K0G-GJygdpkwqKYzjvpDDj8TyGTC2u0SRxK3ez_w@mail.gmail.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <1f8095f1-1f0c-0791-31c4-c7b986c4ce1f@broadcom.com>
Date:   Wed, 5 Sep 2018 10:27:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu8FK9K0G-GJygdpkwqKYzjvpDDj8TyGTC2u0SRxK3ez_w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18-09-05 02:40 AM, Ard Biesheuvel wrote:
> On 4 September 2018 at 19:19, Scott Branden <scott.branden@broadcom.com> wrote:
>> Rather than introduce EFI_ARMSTUB_DTB_LOADER, why not have
>> the efistub use CONFIG_OF to determine whether it supports dtb= or not?
>>
>> That way ACPI-only distros disable devicetree support entirely.
>>
> Unfortunately, CONFIG_OF cannot be disabled on arm64 even on ACPI-only builds.
OF shouldn't be automatically selected in the arm64/Kconfig.  It should 
have a config
parmaeter like other archs as mips and arm.  I can submit a patch so it 
functions the
same way as other archs so it is not always selected.  It will be good 
to add a USE_OF
config options like the other archs (or simply remove the select from 
the Kconfig and choose OF directly in the defconfig.
This will have the added benefit of doing away with OF support when its 
not needed on an ARM64 platform.  ACPI is already not automatically 
selected for all ARM64 platforms, nor should devicetree.

