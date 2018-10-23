Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 609ABC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 18:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 125D920813
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 18:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hD5l0apg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 125D920813
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbeJXC5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 22:57:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:39164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728052AbeJXC5m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 22:57:42 -0400
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D346220831;
        Tue, 23 Oct 2018 18:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540319589;
        bh=vQwS10vd0zr83qVSpClYGcvnr7q8sZo2AZtAFLobAIU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hD5l0apgV/cDPkg1mx7SJPwR8gldcVvBXPxPY175ggH5JXnhSluvB8MS1QsqUmBJx
         nHZuyDoRRqf3aAI+YwgHfdqsK8/4i8dTNzSQNkIjuGpg10dExNyHPGXc1dH4et3g7L
         aZNhYPAd3h2biy4/NEvGhCCYnujyWhhbzb+GK0ZA=
Received: by mail-qk1-f179.google.com with SMTP id x8-v6so1497523qka.4;
        Tue, 23 Oct 2018 11:33:08 -0700 (PDT)
X-Gm-Message-State: ABuFfogSmI8lwMG2FbRTW79zRirJUAeqopAxrpJfSN1V7GKrpfU0YyrB
        kBmVzsT3Q3cC3FdY406o7I6COzpp6/9/Nk3E/w==
X-Google-Smtp-Source: ACcGV60Xa43VO3ppxSb17be6/nXauN3woBR52QHRMpumo0L6hKdTIwDwVMLCvVPh5UdooZMYOsq/8iMLRQxaQyth30U=
X-Received: by 2002:a37:ddcf:: with SMTP id u76-v6mr46675895qku.184.1540319587953;
 Tue, 23 Oct 2018 11:33:07 -0700 (PDT)
MIME-Version: 1.0
References: <20180827082153.22537-1-johan@kernel.org> <20180904130557.GT28861@localhost>
 <20181023091951.GC20058@localhost>
In-Reply-To: <20181023091951.GC20058@localhost>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 23 Oct 2018 13:32:56 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+eX0Zr46UT6_+OKhfxLhc315Un5MZkHHAWhK0tt4OvzA@mail.gmail.com>
Message-ID: <CAL_Jsq+eX0Zr46UT6_+OKhfxLhc315Un5MZkHHAWhK0tt4OvzA@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] of: fix compatible-child-node lookups
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        CK Hu <ck.hu@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Josh Wu <rainyfeeling@outlook.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        David Miller <davem@davemloft.net>,
        Giuseppe CAVALLARO <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        joabreu@synopsys.com, Samuel Ortiz <sameo@linux.intel.com>,
        Sebastian Reichel <sre@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 4:21 AM Johan Hovold <johan@kernel.org> wrote:
>
> Hi Rob,
>
> On Tue, Sep 04, 2018 at 03:05:57PM +0200, Johan Hovold wrote:
> > Hi all,
> >
> > On Mon, Aug 27, 2018 at 10:21:44AM +0200, Johan Hovold wrote:
> > > Several drivers currently use of_find_compatible_node() to lookup child
> > > nodes while failing to notice that the of_find_ functions search the
> > > entire tree depth-first (from a given start node) and therefore can
> > > match unrelated nodes.
> > >
> > > The fact that these functions also drop a reference to the node they
> > > start searching from (e.g. the parent node) is typically also
> > > overlooked, something which can lead to use-after-free bugs (e.g. after
> > > probe deferrals).
> > >
> > > This series adds a new helper, similar to of_get_child_by_name(),
> > > that can be used to lookup compatible child nodes, and uses the new
> > > helper to fix child-node lookups throughout the tree.
> > >
> > > This is related to the fixes I posted about a year ago, which addressed
> > > a similar anti-pattern when looking up child nodes by name. Since it
> > > took me more than a year to get all those fixes into Linus' tree (one
> > > fix is still pending), and as these fixes depend on the new helper, I'm
> > > suggesting that these all go in through Rob's or Greg's trees.
> > >
> > > Alternatively, the helper could go into to -rc2, and I'll be pinging
> > > submaintainers for the coming year as well. ;)
> >
> > Rob has gotten the helper into -rc2 now:
> >
> >         36156f9241cb of: add helper to lookup compatible child node
> >
> > so feel free to pick these fixes up directly for 4.19-rc or -next,
> > whichever you prefer. I've been able to trigger crashes after probe
> > deferrals due to the use-after-free, but this seems unlikely to be
> > exploitable.
> >
> > I think Rob will be picking up any patches that remain by the end of the
> > release cycle for 4.20.
>
> So far only Ulf has picked up the mmc patch below directly, so if you
> could take the rest through your tree for -rc1 that would be great.

Thanks for the reminder, though before the merge window opened would
have been better. I've applied all but the mtd patch.

Rob
