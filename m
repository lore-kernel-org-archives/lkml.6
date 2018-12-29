Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA46FC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 02:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84C72217F9
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 02:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KYtU7c1f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbeL2CKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 21:10:21 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37552 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbeL2CKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 21:10:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+ctffec70KMtQOCQyWTisLwXzB1Mnwufk4G3TY2x9kc=; b=KYtU7c1f2iiO0/44mL2odGz2I
        bvtpriuFDGQktOIICJAXRwJNwcSHk7KZ2dTnwBMbEw68gBxPCE5NVleNP1iFXEwS7jeJpyRaOW1Zb
        3je/F/95OjVnMjALjxp/Qh2hqi3wm/rkT6l92/Ro+AreCRMWpCSAOlNGAotSumUw6oLxVMyPyJiFf
        h/fXKCFHEE0bezTI/QLf1MLmRSEO+/4LIpMGTfbSAdojVl7M4o0RHFIM+VnxjuF9+vYPV9KRkEYCg
        qe4mmV3McvK80Uz+yNgu7YyUKLdhSup17os5PICNrOuwuPDk/5ZHc26oC2gdurJShmpTbs+XfU5i7
        0shIL8y/g==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gd44w-0001gI-W8; Sat, 29 Dec 2018 02:10:19 +0000
Subject: Re: [PATCH v3 treewide] headers: separate linux/mod_devicetable.h
 from linux/platform_device.h
To:     NeilBrown <neil@brown.name>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kbuild test robot <lkp@intel.com>
References: <7baed3cc-cb9c-66d2-b179-517877324407@infradead.org>
 <20180707155306.GA23729@kroah.com> <871s61azip.fsf@notabene.neil.brown.name>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <da6a3598-6238-d555-477f-e2dfe2be8b76@infradead.org>
Date:   Fri, 28 Dec 2018 18:10:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <871s61azip.fsf@notabene.neil.brown.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/28/18 5:32 PM, NeilBrown wrote:
> On Sat, Jul 07 2018, Greg Kroah-Hartman wrote:
> 
>> On Tue, Jun 19, 2018 at 10:47:28PM -0700, Randy Dunlap wrote:
>>> From: Randy Dunlap <rdunlap@infradead.org>
>>>
>>> At over 4000 #includes, <linux/platform_device.h> is the 9th most
>>> #included header file in the Linux kernel.  It does not need
>>> <linux/mod_devicetable.h>, so drop that header and explicitly add
>>> <linux/mod_devicetable.h> to source files that need it.
>>>
>>>    4146 #include <linux/platform_device.h>
>>>
>>> After this patch, there are 225 files that use <linux/mod_devicetable.h>,
>>> for a reduction of around 3900 times that <linux/mod_devicetable.h>
>>> does not have to be read & parsed.
>>>
>>>     225 #include <linux/mod_devicetable.h>
>>>
>>> This patch was build-tested on 20 different arch-es.
>>>
>>> It also makes these drivers SubmitChecklist#1 compliant.
>>>
>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>>> Reported-by: kbuild test robot <lkp@intel.com> # drivers/media/platform/vimc/
>>> Reported-by: kbuild test robot <lkp@intel.com> # drivers/pinctrl/pinctrl-u300.c
>>> ---
>>> v3: add fix for drivers/pinctrl/pinctrl-u300.c
>>> v2: add fixes for drivers/media/platform/vimc/
>>
>> I've queued this up now, let's see what else breaks!  :)
> 
> Some MIPS watchdog drivers break, at least.
> 
> NeilBrown
> 
> From: NeilBrown <neil@brown.name>
> Subject: [PATCH] Fix compilation problem for mt7621_wdt.c and rt2880_wdt.c
> 
> These files need
>    #include <linux/mod_devicetable.h>
> to compile correctly.
> 
> Fixes: ac3167257b9f ("headers: separate linux/mod_devicetable.h from linux/platform_device.h")
> Signed-off-by: NeilBrown <neil@brown.name>

Thanks, NeilBrown.

> ---
>  drivers/watchdog/mt7621_wdt.c | 1 +
>  drivers/watchdog/rt2880_wdt.c | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/watchdog/mt7621_wdt.c b/drivers/watchdog/mt7621_wdt.c
> index 5c4a764717c4..81208cd3f4ec 100644
> --- a/drivers/watchdog/mt7621_wdt.c
> +++ b/drivers/watchdog/mt7621_wdt.c
> @@ -17,6 +17,7 @@
>  #include <linux/watchdog.h>
>  #include <linux/moduleparam.h>
>  #include <linux/platform_device.h>
> +#include <linux/mod_devicetable.h>
>  
>  #include <asm/mach-ralink/ralink_regs.h>
>  
> diff --git a/drivers/watchdog/rt2880_wdt.c b/drivers/watchdog/rt2880_wdt.c
> index 98967f0a7d10..db7c57d82cfd 100644
> --- a/drivers/watchdog/rt2880_wdt.c
> +++ b/drivers/watchdog/rt2880_wdt.c
> @@ -18,6 +18,7 @@
>  #include <linux/watchdog.h>
>  #include <linux/moduleparam.h>
>  #include <linux/platform_device.h>
> +#include <linux/mod_devicetable.h>
>  
>  #include <asm/mach-ralink/ralink_regs.h>
>  
> 


-- 
~Randy
