Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E430C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31CDD20651
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394436AbfAPRIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 12:08:54 -0500
Received: from 8bytes.org ([81.169.241.247]:58030 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731892AbfAPRIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 12:08:54 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id EDF57396; Wed, 16 Jan 2019 18:08:52 +0100 (CET)
Date:   Wed, 16 Jan 2019 18:08:52 +0100
From:   "joro@8bytes.org" <joro@8bytes.org>
To:     "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "Singh, Brijesh" <brijesh.singh@amd.com>
Subject: Re: [PATCH] iommu/amd: Fix IOMMU page flush when detach all devices
 from a domain
Message-ID: <20190116170852.GD4681@8bytes.org>
References: <20190116041546.3541-1-Suravee.Suthikulpanit@amd.com>
 <20190116132648.i5n3hz3k7d2wxbrx@8bytes.org>
 <60c24182-c58e-0575-b085-c7eebc00c49b@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60c24182-c58e-0575-b085-c7eebc00c49b@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 02:08:55PM +0000, Suthikulpanit, Suravee wrote:
> Actually, I am not sure how we would be missing the flush on the last device.
> In my test, I am seeing the flush command being issued correctly during
> vfio_unmap_unpin(), which is after all devices are detached.
> Although, I might be missing your point here. Could you please elaborate?

Okay, you are right, the patch effectivly adds an unconditional flush of
the domain on all iommus when the last device is detached. So it is
correct in that regard. But that code path is also used in the
iommu_unmap() path.

The problem now is, that with your change we send flush commands to all
IOMMUs in the unmap path when no device is attached to the domain.
This will hurt performance there, no?

Regards,

	Joerg

