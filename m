Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 154C9C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 12:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9C4120857
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 12:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546086232;
	bh=XlqaSizrAjVRPBeRlYMix2/Eicvk8BIZXcBX/Wz1kIo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vPN0TH13NvWa1gM+lqFTA8KFRcxZmZQRRsWwpt78s9notxsb3vSVXexEM5f5ismzW
	 bujxMXekIb+HWBrWBugtdMgsAei5+6FjQ7pLlycQVL7sTqOKIJU3TD+qiK82os+pqc
	 0sQIbNj6FnbCnQkZw6YvbXBlkkU87w+hIpwCdQaI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbeL2MXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 07:23:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:47124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726191AbeL2MXv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 07:23:51 -0500
Received: from localhost (83-68-17-109.ip.xs4all.nl [83.68.17.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00D6D20836;
        Sat, 29 Dec 2018 12:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546086230;
        bh=XlqaSizrAjVRPBeRlYMix2/Eicvk8BIZXcBX/Wz1kIo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YUot7qiztOqIw3xndeNSacyAPd14YszdskI5/3+Yikosb6+LYDruhKnQL/JKqHrrL
         fF8QVXMgzDK6CaA43PaEcEij9tPnjp2E7xkJNRuNNlOKd/pHSKxUJrQ2+/g5mwfYB/
         YBNaaBRf+SXIKZONpZpZokmUy9cngYdqYJXrJk3s=
Date:   Sat, 29 Dec 2018 13:23:47 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     NeilBrown <neil@brown.name>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v3 treewide] headers: separate linux/mod_devicetable.h
 from linux/platform_device.h
Message-ID: <20181229122347.GA24413@kroah.com>
References: <7baed3cc-cb9c-66d2-b179-517877324407@infradead.org>
 <20180707155306.GA23729@kroah.com>
 <871s61azip.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871s61azip.fsf@notabene.neil.brown.name>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 29, 2018 at 12:32:30PM +1100, NeilBrown wrote:
> On Sat, Jul 07 2018, Greg Kroah-Hartman wrote:
> 
> > On Tue, Jun 19, 2018 at 10:47:28PM -0700, Randy Dunlap wrote:
> >> From: Randy Dunlap <rdunlap@infradead.org>
> >> 
> >> At over 4000 #includes, <linux/platform_device.h> is the 9th most
> >> #included header file in the Linux kernel.  It does not need
> >> <linux/mod_devicetable.h>, so drop that header and explicitly add
> >> <linux/mod_devicetable.h> to source files that need it.
> >> 
> >>    4146 #include <linux/platform_device.h>
> >> 
> >> After this patch, there are 225 files that use <linux/mod_devicetable.h>,
> >> for a reduction of around 3900 times that <linux/mod_devicetable.h>
> >> does not have to be read & parsed.
> >> 
> >>     225 #include <linux/mod_devicetable.h>
> >> 
> >> This patch was build-tested on 20 different arch-es.
> >> 
> >> It also makes these drivers SubmitChecklist#1 compliant.
> >> 
> >> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> >> Reported-by: kbuild test robot <lkp@intel.com> # drivers/media/platform/vimc/
> >> Reported-by: kbuild test robot <lkp@intel.com> # drivers/pinctrl/pinctrl-u300.c
> >> ---
> >> v3: add fix for drivers/pinctrl/pinctrl-u300.c
> >> v2: add fixes for drivers/media/platform/vimc/
> >
> > I've queued this up now, let's see what else breaks!  :)
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
> ---
>  drivers/watchdog/mt7621_wdt.c | 1 +
>  drivers/watchdog/rt2880_wdt.c | 1 +
>  2 files changed, 2 insertions(+)

Great, can you send these to the watchdog maintainer to queue up?

thanks,

greg k-h
