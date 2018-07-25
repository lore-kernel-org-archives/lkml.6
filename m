Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C4FEC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 15:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCEB920891
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 15:16:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCEB920891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbeGYQ2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 12:28:49 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40500 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728573AbeGYQ2t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 12:28:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E60A618A;
        Wed, 25 Jul 2018 08:16:41 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B2BF53F575;
        Wed, 25 Jul 2018 08:16:41 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id A691E1AE0A03; Wed, 25 Jul 2018 16:16:41 +0100 (BST)
Date:   Wed, 25 Jul 2018 16:16:41 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     =?iso-8859-1?Q?J=2E_Agust=EDn_Vega-Fr=EDas?= 
        <agustin.vega.frias@gmail.com>
Cc:     Agustin Vega-Frias <agustinv@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-acpi@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Phani Pabba <pabba@codeaurora.org>,
        Richard Ruigrok <rruigrok@codeaurora.org>,
        Vijaya Kilari <vkilari@codeaurora.org>,
        Jeff Hugo <jhugo@codeaurora.org>,
        Rahul Ramasubramanian <rahulr@codeaurora.org>
Subject: Re: [RFC V4 0/3] arm_pmu: acpi: variant support and QCOM Falkor
 extensions
Message-ID: <20180725151641.GC6866@arm.com>
References: <1530822201-5890-1-git-send-email-agustinv@codeaurora.org>
 <20180713153318.GB3049@arm.com>
 <CAGbRU0QLSpNEtcryuPPZE98zAo7peEmcDqcQiLi1zO6cfKML2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGbRU0QLSpNEtcryuPPZE98zAo7peEmcDqcQiLi1zO6cfKML2A@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 15, 2018 at 03:35:45PM -0500, J. Agustín Vega-Frías wrote:
> On Fri, Jul 13, 2018 at 10:33 AM, Will Deacon <will.deacon@arm.com> wrote:
> > I'm mostly ok with this approach, but I have a concern with the way in which
> > the sysfs interface for carving up the config fields is implemented. If this
> > is intended to be a strict extension to the armv8 pmu architecture, then I
> > don't think you should be overriding the attr_groups entirely. Rather, you
> > should be taking the attr_groups from pmuv3 and then extending them in a way
> > which avoids overlapping field allocations by construction.
> >
> > As it stands, you already have an overlap between the pcc bit and the
> > chained counter bit which Suzuki has implemented and it will be very easy to
> > introduce API breakage if we don't enforce this as part of the design.
> >
> > Will
> 
> FYI, I left Qualcomm on July 6, one of my former colleagues will submit
> new iterations of this series. I will continue to comment on this and future
> patchsets as a courtesy to my former colleagues and the community.
> 
> Thanks for pointing out the sysfs issue. My suggestion on how to address it is:
> 
> 1. Reserve config and config1 for architectural format attributes and
>    config2 for extension format attributes.
> 2. Add a struct attribute ** parameter to the extension init function so
>    extensions can return the new attributes.
> 3. The extension framework code in arm_pmu_acpi.c can then allocate a new
>    attribute array to contain the base and extension attributes and ensure
>    all the new attributes are on config2.
> 
> Though a more elaborate approach can be implemented to find conflicts in
> bit usage within config fields, it would require much more code for a
> relatively simple problem. Thoughts?

As long as you're happy to live inside config2, that sounds sensible to me.

Will
