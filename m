Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4420FC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 06:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF45521747
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 06:36:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF45521747
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731405AbeHNJVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 05:21:52 -0400
Received: from mga05.intel.com ([192.55.52.43]:28316 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730395AbeHNJVv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 05:21:51 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Aug 2018 23:36:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,237,1531810800"; 
   d="scan'208";a="62233232"
Received: from shbuild888.sh.intel.com (HELO localhost) ([10.239.146.239])
  by fmsmga007.fm.intel.com with ESMTP; 13 Aug 2018 23:36:04 -0700
Date:   Tue, 14 Aug 2018 14:39:59 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>, arjan@linux.intel.com,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] mmc: Move the mmc driver init earlier
Message-ID: <20180814063959.45bddz42ytz3e4jb@shbuild888>
References: <20180608095154.22413-1-feng.tang@intel.com>
 <CAPDyKFrs3ngkVVQaq34V9qzV3KoFdy=B+UbLnzR=fHKsOco=tg@mail.gmail.com>
 <20180612084234.gjzq66xsqblryrkm@shbuild888>
 <CAPDyKFq8WZhQQ9EBjfuVvu=YHB9AdwvMHwyKOY5Wxku1V5PtmA@mail.gmail.com>
 <20180802091539.m5k7cdoad6hfkdfy@shbuild888>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180802091539.m5k7cdoad6hfkdfy@shbuild888>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg, Ulf

Could you help to review this? many thanks!

- Feng

On Thu, Aug 02, 2018 at 05:15:39PM +0800, Feng Tang wrote:
> Hi Ulf,
> 
> On Tue, Jun 12, 2018 at 12:29:50PM +0200, Ulf Hansson wrote:
> > On 12 June 2018 at 10:42, Feng Tang <feng.tang@intel.com> wrote:
> > > Hi Ulf,
> > >
> > > Thanks for the review.
> > >
> > > On Tue, Jun 12, 2018 at 08:25:44AM +0200, Ulf Hansson wrote:
> > >> On 8 June 2018 at 11:51, Feng Tang <feng.tang@intel.com> wrote:
> > >> > When doing some boot time optimization for an eMMC rootfs NUCs,
> > >> > we found the rootfs may spend around 100 microseconds waiting
> > >> > for eMMC card to be initialized, then the rootfs could be
> > >> > mounted.
> > >> >         [    1.216561] Waiting for root device /dev/mmcblk1p1...
> > >> >         [    1.289262] mmc1: new HS400 MMC card at address 0001
> > >> >         [    1.289667] mmcblk1: mmc1:0001 R1J56L 14.7 GiB
> > >> >         [    1.289772] mmcblk1boot0: mmc1:0001 R1J56L partition 1 8.00 MiB
> > >> >         [    1.289869] mmcblk1boot1: mmc1:0001 R1J56L partition 2 8.00 MiB
> > >> >         [    1.289967] mmcblk1rpmb: mmc1:0001 R1J56L partition 3 4.00 MiB
> > >> >         [    1.292798]  mmcblk1: p1 p2 p3
> > >> >         [    1.300576] EXT4-fs (mmcblk1p1): couldn't mount as ext3 due to feature incompatibilities
> > >> >         [    1.300912] EXT4-fs (mmcblk1p1): couldn't mount as ext2 due to feature incompatibilities
> > >> >
> > >> > And this is a common problem for smartphones, tablets, embedded
> > >> > devices and automotive products. This patch will make the eMMC/SD
> > >> > card  start initializing earlier, by changing its order in drivers/Makefile.
> > >> >
> > >> > On our platform, the waiting for eMMC card is almost eliminated with the patch,
> > >> > which is critical to boot time.
> > >>
> > >> I am wondering what kernel version you are running here. There have
> > >> been some changes to the mmc initialization path, which perhaps can
> > >> help.
> > > These logs in commit msg are based on kernel 4.14, and the patch is generated
> > > against kernel 4.17.
> > 
> > Right. So it's quite recent, even if lot's of changes have been made
> > to the mmc core since then.
> > 
> > A few things (old/new) that is important.
> > 1) Check if your mmc host driver support MMC_CAP_WAIT_WHILE_BUSY. That
> > should have some effect, avoiding unnecessary polling.
> 
> I've followed your suggestion to try 4.18-rc4 kernel, and there is around
> 15% reduction in the rootfs mount's waiting for eMMC storage. And our
> SDHCI pci controller does support MMC_CAP_WAIT_WHILE_BUSY.
> 
> > 
> > 2) Since 4.18 rc1, you will be able to configure an over estimated
> > "power on" delay (via DT as well). Look at commit
> > 6d796c68cd15234a33a4bd2ef7231125fea2dc6c.
> > 
> > 3) If you use a DT based platform, I think what people do is to
> > re-organize the order of device nodes, such that as many as possible
> > -EPROBE_DEFER is avoided to be returned by drivers. This is also not a
> > good solution, but the best we have at this moment.
> 
> Our platform is NUC with Celeron processors, whose most IO controllers
> are PCI device.
> 
> > 
> > >
> > >>
> > >> >
> > >> > Signed-off-by: Feng Tang <feng.tang@intel.com>
> > >> > ---
> > >> >  drivers/Makefile | 4 +++-
> > >> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >> >
> > >> > diff --git a/drivers/Makefile b/drivers/Makefile
> > >> > index 24cd47014657..c473afd3c688 100644
> > >> > --- a/drivers/Makefile
> > >> > +++ b/drivers/Makefile
> > >> > @@ -50,6 +50,9 @@ obj-$(CONFIG_REGULATOR)               += regulator/
> > >> >  # reset controllers early, since gpu drivers might rely on them to initialize
> > >> >  obj-$(CONFIG_RESET_CONTROLLER) += reset/
> > >> >
> > >> > +# put mmc early as many morden devices use emm/sd card as rootfs storage
> > >> > +obj-y                          += mmc/
> > >> > +
> > >>
> > >> Your suggested approach isn't really a solution, as it may work for
> > >> your particular case but not for everybody else.
> > >
> > > Do you mean the patch may break some platforms? Yes, I only tested on
> > > some IA based NUCs, and I did think about other architectures, things
> > > that may affect MMC are gpio/clk/pinctrl, and those are still earlier
> > > than mmc after change.
> > 
> > I don't know if it breaks things, potentially it could, if drivers
> > don't implement support for -EPROBE_DEFER properly.
> > 
> > However, more importantly, it's not real fix to the problem, just
> > something that seems to work for you.
> 
> IMHO I don't think the 100ms waiting is a problem of mmc core or SDHCI
> host controller :), complex HWs' initializations take time, like the
> SATA disk, the GFX.
> 
> Currently the mmc folder is too late in the drivers/Makefile, and network
> device, thermal, spi, usb and many other controllers get initialized 
> before mmc (which is the common rootfs storage for smartphones and 
> embedded devices), which triggers the not necessary "Waiting for rootfs
> device" (like the 100ms extra boot time in our platform).
> 
> That's why I propose the leap the mmc subsystem earlier to avoid it.
> 
> Thanks,
> Feng
> 
> 
> 
> 
> 
