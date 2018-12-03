Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A03C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2FAC20850
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kdExBnv7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2FAC20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbeLCXog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 18:44:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:47932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbeLCXog (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 18:44:36 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9890E20850;
        Mon,  3 Dec 2018 23:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543880675;
        bh=k6IV5X1FMttmA6FmFILLZKEr4yOHIPBWREsqLvg9w2o=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=kdExBnv7MqEg63TMyYNlSZeqdXjepqCJRyMFGr8w9mrznCDOpHCRtjcGqUhKQLFv2
         xWAS1UUmieAQzUkZWoivDWGY8SpXH+904mu4lTXm/a/M6i+HS5kgkYc8Qc3H3YKXhM
         2B5Mwh+WbdE3HnYKvTHiiN2hjGvnw+vFWpd6EVyk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Vivek Gautam <vivek.gautam@codeaurora.org>,
        Will Deacon <will.deacon@arm.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <CAFp+6iH-T3KsUH8SDoLDfmJ6x_iHxtHGDySuKib0L_u46G6h6w@mail.gmail.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>, robh+dt <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        open list <linux-kernel@vger.kernel.org>,
        alex.williamson@redhat.com,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>
References: <20181127101145.7682-1-vivek.gautam@codeaurora.org>
 <20181127101145.7682-2-vivek.gautam@codeaurora.org>
 <154342225921.88331.14467967828250776155@swboyd.mtv.corp.google.com>
 <0d76b669-6c4f-7c3b-50a1-084201f2c07a@arm.com>
 <CAFp+6iEC8hobAdVF5nLdhQdCUqbi1xa4Vi-NLugGshV=dg+h1A@mail.gmail.com>
 <20181130181536.GA15274@arm.com>
 <CAFp+6iH-T3KsUH8SDoLDfmJ6x_iHxtHGDySuKib0L_u46G6h6w@mail.gmail.com>
Message-ID: <154388067496.88331.314679235652159449@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v18 1/5] iommu/arm-smmu: Add pm_runtime/sleep ops
Date:   Mon, 03 Dec 2018 15:44:34 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vivek Gautam (2018-12-02 22:43:38)
> On Fri, Nov 30, 2018 at 11:45 PM Will Deacon <will.deacon@arm.com> wrote:
> >
> > On Thu, Nov 29, 2018 at 08:25:20PM +0530, Vivek Gautam wrote:
> > > clk_bulk_get_all() seems like going only the OF way.
> > > Is there another way here to have something common between ACPI
> > > and OF, and then do the clk_bulk_get?
> >
> > I'd say just go with clk_bulk_get_all() and if somebody really wants to
> > mess with the SMMU clocks on a system booted via ACPI, then it's their
> > problem to solve. My understanding is that the design of IORT makes this
> > next to impossible to solve anyway, because a static table is used and
> > therefore we're unable to run whatever ASL methods need to be invoked to
> > mess with the clocks.
> =

> Sure then. I will respin this patch-series.
> =


Right. The idea is to add non-OF support to clk_bulk_get_all() if/when
we get the requirement. Sounds like we can keep waiting a little longer
for that to happen.

