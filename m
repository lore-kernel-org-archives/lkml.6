Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id BCD45C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D4CE208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:35:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D4CE208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755170AbeFNLfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 07:35:04 -0400
Received: from muru.com ([72.249.23.125]:47132 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754810AbeFNLfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 07:35:03 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 3BC3B80AE;
        Thu, 14 Jun 2018 11:37:39 +0000 (UTC)
Date:   Thu, 14 Jun 2018 04:34:59 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     John Stultz <john.stultz@linaro.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Kalle Valo <kvalo@codeaurora.org>, Eyal Reizer <eyalr@ti.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ryan Grachek <ryan@edited.us>
Subject: Re: REGRESSION: "wlcore: sdio: allow pm to handle sdio power" breaks
 wifi on HiKey960
Message-ID: <20180614113459.GD112168@atomide.com>
References: <CALAqxLW=nrX-S9eibsTc+S_4YsZ166OJgZGj_1TZRWZ2ut7aFQ@mail.gmail.com>
 <20180613041319.GA112168@atomide.com>
 <1fc9a078-160d-b9ee-4eaa-9fb970520606@arm.com>
 <CALAqxLWuqns5Reo68xeGRdo3+s5Nf0rYNqHRiFG2WbQC_b_LHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALAqxLWuqns5Reo68xeGRdo3+s5Nf0rYNqHRiFG2WbQC_b_LHA@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* John Stultz <john.stultz@linaro.org> [180613 17:17]:
> On Wed, Jun 13, 2018 at 7:42 AM, Valentin Schneider
> <valentin.schneider@arm.com> wrote:
> > On 13/06/18 05:13, Tony Lindgren wrote:
> >> * John Stultz <john.stultz@linaro.org> [180612 22:15]:
> >>> Hey Folks,
> >>>   I noticed with linus/master wifi wasn't coming up on HiKey960. I
> >>> bisected it down and it seems to be due to:
> >>>
> >>> 60f36637bbbd ("wlcore: sdio: allow pm to handle sdio power")  and
> >>> 728a9dc61f13 ("wlcore: sdio: Fix flakey SDIO runtime PM handling")
> >>>
> >>> When wifi fails to load, the only useful error message I see is:
> >>> [    8.466097] wl1271_sdio mmc1:0001:2: wl12xx_sdio_power_on: failed
> >>> to get_sync(-13)
> >>
> >> Sorry to hear about that.
> >>
> >>> Reverting those two changes gets wifi working again for me:
> >>> [    8.754953] wlcore: wl18xx HW: 183x or 180x, PG 2.2 (ROM 0x11)
> >>> [    8.761778] random: crng init done
> >>> [    8.765185] random: 7 urandom warning(s) missed due to ratelimiting
> >>> [    8.779149] wlcore: loaded
> >>> ...
> >>> [   12.945903] wlcore: PHY firmware version: Rev 8.2.0.0.237
> >>> [   13.058077] wlcore: firmware booted (Rev 8.9.0.0.70)
> >>>
> >>>
> >>> Any suggestions how to resolve this w/o a revert?
> >>
> >> Sounds like we need to ignore also -EACCES if runtime PM is
> >> disabled for MMC. Care to try and see if the patch below
> >> helps?
> >>
> >
> > I don't use wifi with my board (I have an USB ethernet adapter), but I do
> > get the same error message as John.
> >
> > Reverting the patches works and I do see wlan0 being brought up. Sadly,
> > applying your patch doesn't seem to fix the issue - and actually it seems
> > to freeze my board on first boot with this error:
> >
> > [   11.169127] wlcore: ERROR timeout waiting for the hardware to complete initialization
> >
> > On second boot it finally comes to life, but issuing ifconfig freezes it again.
> >
> > $ dmesg | grep wl
> > [    5.922661] wl18xx_driver wl18xx.0.auto: Direct firmware load for ti-connectivity/wl18xx-conf.bin failed with error -2
> > [    5.933904] wlcore: ERROR could not get configuration binary ti-connectivity/wl18xx-conf.bin: -2
> > [    5.949158] wlcore: WARNING falling back to default config
> > [    6.199806] wlcore: wl18xx HW: 183x or 180x, PG 2.2 (ROM 0x11)
> > [    6.210738] wlcore: WARNING Detected unconfigured mac address in nvs, derive from fuse instead.
> > [    6.221644] wlcore: WARNING This default nvs file can be removed from the file system
> > [    6.235180] wlcore: loaded
> > [    6.820146] IPv6: ADDRCONF(NETDEV_UP): wlan0: link is not ready
> > [    7.280611] wlcore: PHY firmware version: Rev 8.2.0.0.236
> > [    7.388339] wlcore: firmware booted (Rev 8.9.0.0.69)
> > [    7.409610] IPv6: ADDRCONF(NETDEV_UP): wlan0: link is not ready
> > [    7.417815] wlcore: down
> > [   10.628867] wlcore: ERROR timeout waiting for the hardware to complete initialization
> >
> >
> > Seems like it's not getting powered on, which might be why those mmc_power_*
> > calls were in there originally ?
> 
> Ryan Grachek came up with a different solution. I still need to
> validate it, but it seems promising:
>   https://lkml.org/lkml/2018/6/13/481

Oh OK good to hear. Yeah that makes sense to me now.

Regards,

Tony
