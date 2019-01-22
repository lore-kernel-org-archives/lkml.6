Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52755C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DAE620844
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:45:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbfAVKo6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 05:44:58 -0500
Received: from 8bytes.org ([81.169.241.247]:58774 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726530AbfAVKo6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 05:44:58 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 021EB672; Tue, 22 Jan 2019 11:44:55 +0100 (CET)
Date:   Tue, 22 Jan 2019 11:44:54 +0100
From:   "joro@8bytes.org" <joro@8bytes.org>
To:     "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "Singh, Brijesh" <brijesh.singh@amd.com>
Subject: Re: [PATCH] iommu/amd: Fix IOMMU page flush when detach all devices
 from a domain
Message-ID: <20190122104454.nke2knuyqiswfh5w@8bytes.org>
References: <20190116041546.3541-1-Suravee.Suthikulpanit@amd.com>
 <20190116132648.i5n3hz3k7d2wxbrx@8bytes.org>
 <60c24182-c58e-0575-b085-c7eebc00c49b@amd.com>
 <20190116170852.GD4681@8bytes.org>
 <0a61c07d-edfe-2738-380d-33d39e40fc0a@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a61c07d-edfe-2738-380d-33d39e40fc0a@amd.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suravee,

On Thu, Jan 17, 2019 at 08:44:36AM +0000, Suthikulpanit, Suravee wrote:
> Then, in __domain_flush_pages, we issue command when the dev_iommu[] >= 0.
> This should preserve previous behavior, and only add flushing condition to
> the specific IOMMU in detached state. Please let me know what you think.

I think the whole point why VFIO is detaching all devices first and then
goes into unmapping pages is that there are no flushes needed anymore
when devices are detached.

But when we follow your proposal we would still do IOTLB flushes even
when no devices are attached anymore. So I'd like to avoid this, given
the implications on unmapping performance. We should just flush the
IOMMU TLB at detach time and be done with it.

Makes sense?

Regards,

	Joerg
