Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E6756C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 13:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A33CD208B2
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 13:04:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A33CD208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933612AbeFLNEp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 09:04:45 -0400
Received: from mga03.intel.com ([134.134.136.65]:59949 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932565AbeFLNEo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 09:04:44 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2018 06:04:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,214,1526367600"; 
   d="scan'208";a="62477248"
Received: from shbuild888.sh.intel.com (HELO localhost) ([10.239.146.239])
  by fmsmga004.fm.intel.com with ESMTP; 12 Jun 2018 06:04:41 -0700
Date:   Tue, 12 Jun 2018 21:06:40 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Shawn Lin <shawn.lin@rock-chips.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: Move the mmc driver init earlier
Message-ID: <20180612130640.yzuifhrlfs3lefuc@shbuild888>
References: <20180608095154.22413-1-feng.tang@intel.com>
 <CAPDyKFrs3ngkVVQaq34V9qzV3KoFdy=B+UbLnzR=fHKsOco=tg@mail.gmail.com>
 <20180612084234.gjzq66xsqblryrkm@shbuild888>
 <CAPDyKFq8WZhQQ9EBjfuVvu=YHB9AdwvMHwyKOY5Wxku1V5PtmA@mail.gmail.com>
 <03aa85b4-74cf-621c-08cf-271b4c0d8e8c@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03aa85b4-74cf-621c-08cf-271b4c0d8e8c@rock-chips.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 08:05:25PM +0800, Shawn Lin wrote:
> On 2018/6/12 18:29, Ulf Hansson wrote:
> > On 12 June 2018 at 10:42, Feng Tang <feng.tang@intel.com> wrote:
> > > Hi Ulf,
> > > 
> > > Thanks for the review.
> > > 
> > > On Tue, Jun 12, 2018 at 08:25:44AM +0200, Ulf Hansson wrote:
> > > > On 8 June 2018 at 11:51, Feng Tang <feng.tang@intel.com> wrote:
> > > > > When doing some boot time optimization for an eMMC rootfs NUCs,
> > > > > we found the rootfs may spend around 100 microseconds waiting
> > > > > for eMMC card to be initialized, then the rootfs could be
> > > > > mounted.
> > > > >          [    1.216561] Waiting for root device /dev/mmcblk1p1...
> > > > >          [    1.289262] mmc1: new HS400 MMC card at address 0001
> > > > >          [    1.289667] mmcblk1: mmc1:0001 R1J56L 14.7 GiB
> > > > >          [    1.289772] mmcblk1boot0: mmc1:0001 R1J56L partition 1 8.00 MiB
> > > > >          [    1.289869] mmcblk1boot1: mmc1:0001 R1J56L partition 2 8.00 MiB
> > > > >          [    1.289967] mmcblk1rpmb: mmc1:0001 R1J56L partition 3 4.00 MiB
> > > > >          [    1.292798]  mmcblk1: p1 p2 p3
> > > > >          [    1.300576] EXT4-fs (mmcblk1p1): couldn't mount as ext3 due to feature incompatibilities
> > > > >          [    1.300912] EXT4-fs (mmcblk1p1): couldn't mount as ext2 due to feature incompatibilities
> > > > > 
> > > > > And this is a common problem for smartphones, tablets, embedded
> > > > > devices and automotive products. This patch will make the eMMC/SD
> > > > > card  start initializing earlier, by changing its order in drivers/Makefile.
> > > > > 
> > > > > On our platform, the waiting for eMMC card is almost eliminated with the patch,
> > > > > which is critical to boot time.
> > > > 
> > > > I am wondering what kernel version you are running here. There have
> > > > been some changes to the mmc initialization path, which perhaps can
> > > > help.
> > > These logs in commit msg are based on kernel 4.14, and the patch is generated
> > > against kernel 4.17.
> > 
> > Right. So it's quite recent, even if lot's of changes have been made
> > to the mmc core since then.
> > 
> > A few things (old/new) that is important.
> > 1) Check if your mmc host driver support MMC_CAP_WAIT_WHILE_BUSY. That
> > should have some effect, avoiding unnecessary polling.
> > 
> > 2) Since 4.18 rc1, you will be able to configure an over estimated
> > "power on" delay (via DT as well). Look at commit
> > 6d796c68cd15234a33a4bd2ef7231125fea2dc6c.
> 
> Sorry to chime in. We could also reduce the "power on" delay via hosts'
> ->set_ios() callback.
> 
> > 
> > 3) If you use a DT based platform, I think what people do is to
> > re-organize the order of device nodes, such that as many as possible
> > -EPROBE_DEFER is avoided to be returned by drivers. This is also not a
> > good solution, but the best we have at this moment.
> 
> Also DT based platform is allowed to add no-sd and no-sdio for the eMMC
> node, which could slighly help reduce the boot time.
> You could refer to Documentation/devicetree/bindings/mmc/mmc.txt for
> details.

Thanks Shawn for your tips, we did simliar thing :) for no-sd and no-sdio, 
and even disabled SDHCI controller that has nothing connected.

- Feng
