Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC855C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C45721773
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549984309;
	bh=PsO/wedHNVhz8Ek55cpXhzZW6mgcbqgYCZ1jz0XQC1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EOZQ9wb4QqJvqN11mDcsFD93q3aRbsbMHFyl71BKj6fw8RC0rSVZ0Pcm8dJgok9kx
	 DiegYA9BL+rRVxRYlBqy/fcHgwemOxQ8TKBSA1n+rdoikxBieaE6UA4ZMb5UqmayUR
	 uZ1KeLMy2m9dmZ8hwFa9+a7lilDmBJ7rcTik+FPE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729770AbfBLPLs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 10:11:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:50588 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728165AbfBLPLr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 10:11:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B8A77ACEA;
        Tue, 12 Feb 2019 15:11:46 +0000 (UTC)
Date:   Tue, 12 Feb 2019 16:11:46 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        akpm@linux-foundation.org, osalvador@suse.de
Subject: Re: [PATCH v2] mm/memory-hotplug: Add sysfs hot-remove trigger
Message-ID: <20190212151146.GA15609@dhcp22.suse.cz>
References: <49ef5e6c12f5ede189419d4dcced5dc04957c34d.1549906631.git.robin.murphy@arm.com>
 <20190212083310.GM15609@dhcp22.suse.cz>
 <faca65d7-6d4b-7e4f-5b36-4fdf3710b0e3@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <faca65d7-6d4b-7e4f-5b36-4fdf3710b0e3@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 12-02-19 14:54:36, Robin Murphy wrote:
> On 12/02/2019 08:33, Michal Hocko wrote:
> > On Mon 11-02-19 17:50:46, Robin Murphy wrote:
> > > ARCH_MEMORY_PROBE is a useful thing for testing and debugging hotplug,
> > > but being able to exercise the (arguably trickier) hot-remove path would
> > > be even more useful. Extend the feature to allow removal of offline
> > > sections to be triggered manually to aid development.
> > > 
> > > Since process dictates the new sysfs entry be documented, let's also
> > > document the existing probe entry to match - better 13-and-a-half years
> > > late than never, as they say...
> > 
> > The probe sysfs is quite dubious already TBH. Apart from testing, is
> > anybody using it for something real? Do we need to keep an API for
> > something testing only? Why isn't a customer testing module enough for
> > such a purpose?
> 
> From the arm64 angle, beyond "conventional" servers where we can hopefully
> assume ACPI, I can imagine there being embedded/HPC setups (not all as
> esoteric as that distributed-memory dRedBox thing), as well as virtual
> machines, that are DT-based with minimal runtime firmware. I'm none too keen
> on the idea either, but if such systems want to support physical hotplug
> then driving it from userspace might be the only reasonable approach. I'm
> just loath to actually document it as anything other than a developer
> feature so as not to give the impression that I consider it anything other
> than a last resort for production use.

This doesn't sound convicing to add an user API.

> I do note that my x86 distro kernel
> has ARCH_MEMORY_PROBE enabled despite it being "for testing".

Yeah, there have been mistakes done in the API land & hotplug in the
past.

> > In other words, why do we have to add an API that has to be maintained
> > for ever for a testing only purpose?
> 
> There's already half the API being maintained, though, so adding the
> corresponding other half alongside it doesn't seem like that great an
> overhead, regardless of how it ends up getting used.

As already said above. The hotplug user API is not something to follow
for the future development. So no, we are half broken let's continue is
not a reasonable argument.

> Ultimately, though,
> it's a patch I wrote because I needed it, and if everyone else is adamant
> that it's not useful enough then fair enough - it's at least in the list
> archives now so I can sleep happy that I've done my "contributing back" bit
> as best I could :)

I am not saing this is not useful. It is. But I do not think we want to
make it an official api without a strong usecase. And then we should
think twice to make the api both useable and reasonable. A kernel module
for playing sounds like more than sufficient.
-- 
Michal Hocko
SUSE Labs
