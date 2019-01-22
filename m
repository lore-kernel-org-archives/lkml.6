Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69784C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A89221721
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:48:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbfAVOsb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 09:48:31 -0500
Received: from mga17.intel.com ([192.55.52.151]:15858 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728708AbfAVOsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 09:48:31 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jan 2019 06:48:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,506,1539673200"; 
   d="scan'208";a="120376201"
Received: from jlahtine-desk.ger.corp.intel.com (HELO localhost) ([10.251.82.181])
  by orsmga003.jf.intel.com with ESMTP; 22 Jan 2019 06:48:27 -0800
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Daniel Vetter <daniel@ffwll.ch>, Joerg Roedel <joro@8bytes.org>
From:   Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
In-Reply-To: <20190122110109.x3zoynemdl3ysbsn@8bytes.org>
Cc:     Eric Wong <e@80x24.org>, David Woodhouse <dwmw2@infradead.org>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20181227114948.ev4b3jte3ubsc5us@dcvr>
 <154642214920.6261.102817444136744919@jlahtine-desk.ger.corp.intel.com>
 <20190104010626.e6yqdqkmdcqjepke@dcvr>
 <154659116310.4596.13613897418163029789@jlahtine-desk.ger.corp.intel.com>
 <20190118121705.a4usvhnskyblooja@dcvr>
 <20190122103914.msboylvkor5sb5lq@8bytes.org>
 <CAKMK7uEX1T6_yXoq_d4Fs2LiWC_tDaEEXv-hTL=S-_4HEeya7A@mail.gmail.com>
 <20190122110109.x3zoynemdl3ysbsn@8bytes.org>
Message-ID: <154816850584.8871.13562920355478587539@jlahtine-desk.ger.corp.intel.com>
User-Agent: alot/0.6
Subject: Re: [PATCH] iommu/intel: quirk to disable DMAR for QM57 igfx
Date:   Tue, 22 Jan 2019 16:48:26 +0200
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Joerg Roedel (2019-01-22 13:01:09)
> Hi Daniel,
> 
> On Tue, Jan 22, 2019 at 11:46:39AM +0100, Daniel Vetter wrote:
> > Note that the string of platforms which have various issues with iommu
> > and igfx is very long, thus far we only disabled it where there's no
> > workaround to stop it from hanging the box, but otherwise left it
> > enabled. So if we make a policy change to also disable it anywhere
> > where it doesn't work well (instead of not at all), there's a pile
> > more platforms to switch.
> 
> I think its best to just disable iommu for the igfx devices on these
> platforms. Can you pick up Eric's patch and extend it with the list of
> affected platforms?

We've been discussing this again more actively since a few months ago,
and the discussion is still ongoing internally.

According to our IOMMU folks there exists some desire to be able to assign
the iGFX device aka have intel_iommu=on instead of intel_iommu=igfx_off
due to how the devices might be grouped in IOMMU groups. Even when you
would not be using the iGFX device.

So for some uses, the fact that the device (group) is assignable seems
to be more important than the iGFX device to be working. I'm afraid
that retroactively disabling the assignment for such an old platform
might break those usage scenarios. By my quick reading of the code,
there's no way for user to turn the iGFX DMAR on once the quirk
disables it.

I guess one solution would be to default to intel_iommu=igfx_off for
platforms that are older than certain threshold. But still allow
user to enable. But that then requires duplicating the PCI ID database
into iommu code.

I don't really have winning moves to present, but I'm open to hearing
how we can avoid more damage than starting to default to intel_iommu=on
did already.

Regards, Joonas

> 
> Thanks,
> 
>         Joerg
