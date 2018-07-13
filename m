Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006D1ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 15:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B16A52087C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 15:32:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B16A52087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731560AbeGMPrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 11:47:43 -0400
Received: from foss.arm.com ([217.140.101.70]:37102 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729770AbeGMPrn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 11:47:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1202C80D;
        Fri, 13 Jul 2018 08:32:37 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D6BBD3F589;
        Fri, 13 Jul 2018 08:32:36 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 532221AE4D0E; Fri, 13 Jul 2018 16:33:19 +0100 (BST)
Date:   Fri, 13 Jul 2018 16:33:19 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Agustin Vega-Frias <agustinv@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
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
        Rahul Ramasubramanian <rahulr@codeaurora.org>,
        Agustin Vega-Frias <agustin.vega.frias@gmail.com>
Subject: Re: [RFC V4 0/3] arm_pmu: acpi: variant support and QCOM Falkor
 extensions
Message-ID: <20180713153318.GB3049@arm.com>
References: <1530822201-5890-1-git-send-email-agustinv@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530822201-5890-1-git-send-email-agustinv@codeaurora.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Agustin,

On Thu, Jul 05, 2018 at 04:23:17PM -0400, Agustin Vega-Frias wrote:
> This series is a complete re-design of V1 of the QCOM Falkor extensions [1],
> it introduces a probe table based on the HID of a device nested under the CPU
> device to allow variant detection and arm_pmu customization.
> 
> The first patch adds an additional section at the end of each ACPI probe table.
> This allows probe tables to be sentinel-delimited and better accommodate some
> APIs that require such tables.
> 
> The second patch adds the PMUv3 ACPI probe table and plumbing to allow drivers
> to plug into the ACPI PMUv3 probe sequence.
> 
> The third patch adds the PC capture extension applicable to Falkor and Saphira
> CPUs. This shows how an extension that uses sampling events hooks. A similar
> approach can be used to add RBB support and populate the sample branch stack
> from it.
> 
> The fourth patch adds the matrix-based events extension applicable to Falkor
> only.
> 
> If this found to be a reasonable extension approach other patches will be
> added to the series to build on the base QCOM extensions.

I'm mostly ok with this approach, but I have a concern with the way in which
the sysfs interface for carving up the config fields is implemented. If this
is intended to be a strict extension to the armv8 pmu architecture, then I
don't think you should be overriding the attr_groups entirely. Rather, you
should be taking the attr_groups from pmuv3 and then extending them in a way
which avoids overlapping field allocations by construction.

As it stands, you already have an overlap between the pcc bit and the
chained counter bit which Suzuki has implemented and it will be very easy to
introduce API breakage if we don't enforce this as part of the design.

Will
