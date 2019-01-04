Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51EE6C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 08:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29B14217F5
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 08:39:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfADIja convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 03:39:30 -0500
Received: from mga06.intel.com ([134.134.136.31]:22552 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbfADIj2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 03:39:28 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jan 2019 00:39:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,437,1539673200"; 
   d="scan'208";a="123233546"
Received: from jlahtine-desk.ger.corp.intel.com (HELO localhost) ([10.252.6.61])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Jan 2019 00:39:24 -0800
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Eric Wong <e@80x24.org>
From:   Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
In-Reply-To: <20190104010626.e6yqdqkmdcqjepke@dcvr>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        David Woodhouse <dwmw2@infradead.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        iommu@lists.linux-foundation.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20181227114948.ev4b3jte3ubsc5us@dcvr>
 <154642214920.6261.102817444136744919@jlahtine-desk.ger.corp.intel.com>
 <20190104010626.e6yqdqkmdcqjepke@dcvr>
Message-ID: <154659116310.4596.13613897418163029789@jlahtine-desk.ger.corp.intel.com>
User-Agent: alot/0.6
Subject: Re: iommu_intel or i915 regression in 4.18, 4.19.12 and drm-tip
Date:   Fri, 04 Jan 2019 10:39:23 +0200
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Eric Wong (2019-01-04 03:06:26)
> Joonas Lahtinen <joonas.lahtinen@linux.intel.com> wrote:
> > Quoting Eric Wong (2018-12-27 13:49:48)
> > > I just got a used Thinkpad X201 (Core i5 M 520, Intel QM57
> > > chipset) and hit some kernel panics while trying to view
> > > image/animation-intensive stuff in Firefox (X11) unless I use
> > > "iommu_intel=igfx_off".
> > > 
> > > With Debian stable backport kernels, "linux-image-4.17.0-0.bpo.3-amd64"
> > > (4.17.17-1~bpo9+1) has no problems.  But "linux-image-4.18.0-0.bpo.3-amd64"
> > > (4.18.20-2~bpo9+1) gives a blank screen before I can login via agetty
> > > and run startx.
> 
> > Most confusing about this is that 4.17 would have worked to begin with,
> > without intel_iommu=igfx_off (unless it was the default for older
> > kernel?)
> 
> Yeah, so the Debian bpo 4.17(.17) kernel did not set
> CONFIG_INTEL_IOMMU_DEFAULT_ON, so I didn't encounter problems.
> My self-built kernels all set CONFIG_INTEL_IOMMU_DEFAULT_ON.

So it's the case that IOMMU never worked on your machine.

My recommendation would be to simply use intel_iommu=igfx_off if you
need IOMMU.

Old hardware is known to have issues with IOMMU, and retroactively
enabling IOMMU on those machines just brings them up :/

Regards, Joonas

> Booting the Debian 4.17 kernel with "intel_iommu=on" gives the
> same hanging problem I hit with self-built 4.19.{12,13} kernels.
> 
> I'm not sure how far back the problem goes (maybe forever),
> since I only got this hardware.  Not sure what's the problem
> with Debian 4.18, either; but (self-built) 4.19.13 is fine w/o
> CONFIG_INTEL_IOMMU_DEFAULT_ON.
> 
> Debian backports doesn't have kernels for 4.19 or 4.20, yet.
> 
> > Did you maybe update other parts of the system while updating the
> > kernel?
> 
> Definitely not; just the kernel + headers ("make bindeb-pkg)".
> 
> > If you could attach full boot dmesg from working and non-working kernel +
> > have config file of both kernel's in Bugzilla. That'd be a good start!
> 
> Sorry, I get anxiety attacks when it comes to logins and forms.
> Anyways, I managed to get the Debian kernel dmesg output uploaded
> with and without iommu_intel=on:
> https://bugs.freedesktop.org/attachment.cgi?bugid=109219
