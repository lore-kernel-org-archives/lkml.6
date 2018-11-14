Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD984C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 07:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96DB72086B
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 07:32:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96DB72086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731947AbeKNRee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 12:34:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:46270 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726927AbeKNRee (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 12:34:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 13F17AC15;
        Wed, 14 Nov 2018 07:32:31 +0000 (UTC)
Date:   Wed, 14 Nov 2018 08:32:29 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Borislav Petkov <bp@suse.de>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH] l1tf: drop the swap storage limit restriction when
 l1tf=off
Message-ID: <20181114073229.GC23419@dhcp22.suse.cz>
References: <20181113184910.26697-1-mhocko@kernel.org>
 <nycvar.YFH.7.76.1811132054521.19754@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.1811132054521.19754@cbobk.fhfr.pm>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 13-11-18 20:56:54, Jiri Kosina wrote:
> On Tue, 13 Nov 2018, Michal Hocko wrote:
> 
> > From: Michal Hocko <mhocko@suse.com>
> > 
> > Swap storage is restricted to max_swapfile_size (~16TB on x86_64)
> > whenever the system is deemed affected by L1TF vulnerability. Even
> > though the limit is quite high for most deployments it seems to be
> > too restrictive for deployments which are willing to live with the
> > mitigation disabled.
> > 
> > We have a customer to deploy 8x 6,4TB PCIe/NVMe SSD swap devices
> > which is clearly out of the limit.
> > 
> > Drop the swap restriction when l1tf=off is specified. It also doesn't
> > make much sense to warn about too much memory for the l1tf mitigation
> > when it is forcefully disabled by the administrator.
> > 
> > Signed-off-by: Michal Hocko <mhocko@suse.com>
> > ---
> >  Documentation/admin-guide/kernel-parameters.txt | 2 ++
> >  Documentation/admin-guide/l1tf.rst              | 5 ++++-
> >  arch/x86/kernel/cpu/bugs.c                      | 3 ++-
> >  arch/x86/mm/init.c                              | 2 +-
> >  4 files changed, 9 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 81d1d5a74728..a54f2bd39e77 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -2095,6 +2095,8 @@
> >  			off
> >  				Disables hypervisor mitigations and doesn't
> >  				emit any warnings.
> > +				It also drops the swap size and available
> > +				RAM limit restriction.
> 
> Minor nit: I think this should explicitly mention that those two things 
> are related to bare metal mitigation, to avoid any confusion (as otherwise 
> the l1tf cmdline parameter is purely about hypervisor mitigations).

Do you have any specific wording in mind?

It also drops the swap size and available RAM limit restrictions on both
hypervisor and bare metal.

Sounds better?

> With that
> 
> 	Acked-by: Jiri Kosina <jkosina@suse.cz>

Thanks!
-- 
Michal Hocko
SUSE Labs
