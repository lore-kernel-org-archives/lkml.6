Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51DDC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 15:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B459F206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 15:27:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B459F206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbeK2C3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 21:29:06 -0500
Received: from mail5.windriver.com ([192.103.53.11]:55298 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727726AbeK2C3G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 21:29:06 -0500
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id wASFOtPQ006687
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Wed, 28 Nov 2018 07:25:10 -0800
Received: from yow-pgortmak-d1.corp.ad.wrs.com (128.224.56.57) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.408.0; Wed, 28 Nov 2018 07:24:46 -0800
Received: by yow-pgortmak-d1.corp.ad.wrs.com (Postfix, from userid 1000)        id
 D82D52E130B; Wed, 28 Nov 2018 10:24:45 -0500 (EST)
Date:   Wed, 28 Nov 2018 10:24:45 -0500
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Robin Murphy <robin.murphy@arm.com>
CC:     Joerg Roedel <joro@8bytes.org>, <iommu@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, Will Deacon <will.deacon@arm.com>,
        Nate Watterson <nwatters@codeaurora.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 8/9] iommu: arm-smmu: make it explicitly non-modular
Message-ID: <20181128152445.GH14659@windriver.com>
References: <1543271498-28966-1-git-send-email-paul.gortmaker@windriver.com>
 <1543271498-28966-9-git-send-email-paul.gortmaker@windriver.com>
 <755c95d7-882c-0dec-207e-20bf8f22b159@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <755c95d7-882c-0dec-207e-20bf8f22b159@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Re: [PATCH 8/9] iommu: arm-smmu: make it explicitly non-modular] On 28/11/2018 (Wed 12:42) Robin Murphy wrote:

> Hi Paul,
> 
> On 26/11/2018 22:31, Paul Gortmaker wrote:

[...]

> >We add a moduleparam.h include since the file does actually declare
> >some module parameters, and leaving them as such is the easiest way
> >currently to remain backwards compatible with existing use cases.

[...]


> Is it worth introducing builtin_param() and friends for this sort of thing,
> to echo the *_platform_driver() helpers? It seems like that could be
> justifiable under the motivation described in the cover letter.

I've definitely gone back and looked at this a few times when coming
across the few corner cases like these, to remind myself why I didn't do
it already.

We'd not want to replicate all the module_param stuff as an instance of
builtin_param() because we already have setup() and setup_param() in
init.h -- however they don't do the file name in the param - hence the
reason it isn't a direct swap in replacement.

So, it would become some more complex refactoring of moduleparam.h into
say bootparam.h - to reduce code/macro duplication, while at the same
time being aware of existing setup_param stuff and making something like
a new setup_param_named() that is consistent with existing setup fcns.

And based on past experience, there will be reviewers who don't see the
value in the distinction and simply reply with two words "why bother?".

Not impossible, but not as simple as the builtin_platform_driver and
similar wrappers that I've already added to mainline.  You've made we
want to go have another look at it again, but in the meantime we can do
what I've done here, and circle around later to update the few instances
of moduleparam in non-modules once/if the refactoring I describe above
works out and is accepted in mainline.

> 
> Otherwise, the changes look reasonable. I still hold out hope that one day
> we'll be able to make IOMMU drivers modular (it can work with minimal hacks
> today, but it's far from robust in general), but for now I agree this makes
> sense (and it'll be easy enough to revert for playing with further hacks).

I totally agree - I've had similar discussions with the DMA maintainers,
and if being modular can be made to work and has a use case - great!

But it should be a conscious decision, since nobody writes a new driver
from scratch; they copy one that is "close" as a template and then go
from there.  Which leads to a good percentage of drivers having hints
of modular stuff when there is no intent of them ever being modular.

> With the title fixed up as Joerg asked,
> 
> Acked-by: Robin Murphy <robin.murphy@arm.com>

Thanks for the feedback/review.  Will re-send with updated titles before
the week is finished and a good chance for additional feedback has elapsed.

Paul.
--

> 
> >  module_param(force_stage, int, S_IRUGO);
> >  MODULE_PARM_DESC(force_stage,
> >  	"Force SMMU mappings to be installed at a particular stage of translation. A value of '1' or '2' forces the corresponding stage. All other values are ignored (i.e. no stage is forced). Note that selecting a specific stage will disable support for nested translation.");
