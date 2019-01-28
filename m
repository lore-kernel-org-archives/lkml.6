Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66023C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35F652171F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548701132;
	bh=WrqO6s9Ccz9GnAnAllrU0hw82Ucxzvk+k2PIKBCOzJM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wt9LzssWLC4z2STMrFhfKFQBXMGdWHjVWq2nZDYtCqh9BaOGAzrO4Tf7XoR2WHlR1
	 buiWdxevvOBBYTeUOoH1WOlUFI7jvqhn0GFHpx2JuBIc0E5b8GW3CuM+v0myBiCLJE
	 XT6bFMpV8f+qUY7cOKSr3xsnntvUVs+zou0AF6lg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbfA1Spa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 13:45:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:56776 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726694AbfA1Spa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 13:45:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3FFE7B00C;
        Mon, 28 Jan 2019 18:45:29 +0000 (UTC)
Date:   Mon, 28 Jan 2019 19:45:28 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mikhail Zaslonko <zaslonko@linux.ibm.com>,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        gerald.schaefer@de.ibm.com, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] mm, memory_hotplug: fix uninitialized pages fallouts.
Message-ID: <20190128184528.GU18811@dhcp22.suse.cz>
References: <20190128144506.15603-1-mhocko@kernel.org>
 <20190128095054.4103093dec81f1c904df7929@linux-foundation.org>
 <20190128184139.GR18811@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128184139.GR18811@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 28-01-19 19:41:39, Michal Hocko wrote:
> On Mon 28-01-19 09:50:54, Andrew Morton wrote:
> > On Mon, 28 Jan 2019 15:45:04 +0100 Michal Hocko <mhocko@kernel.org> wrote:
> > 
> > > Mikhail has posted fixes for the two bugs quite some time ago [1]. I
> > > have pushed back on those fixes because I believed that it is much
> > > better to plug the problem at the initialization time rather than play
> > > whack-a-mole all over the hotplug code and find all the places which
> > > expect the full memory section to be initialized. We have ended up with
> > > 2830bf6f05fb ("mm, memory_hotplug: initialize struct pages for the full
> > > memory section") merged and cause a regression [2][3]. The reason is
> > > that there might be memory layouts when two NUMA nodes share the same
> > > memory section so the merged fix is simply incorrect.
> > > 
> > > In order to plug this hole we really have to be zone range aware in
> > > those handlers. I have split up the original patch into two. One is
> > > unchanged (patch 2) and I took a different approach for `removable'
> > > crash. It would be great if Mikhail could test it still works for his
> > > memory layout.
> > > 
> > > [1] http://lkml.kernel.org/r/20181105150401.97287-2-zaslonko@linux.ibm.com
> > > [2] https://bugzilla.redhat.com/show_bug.cgi?id=1666948
> > > [3] http://lkml.kernel.org/r/20190125163938.GA20411@dhcp22.suse.cz
> > 
> > Any thoughts on which kernel version(s) need these patches?
> 
> My remark in 2830bf6f05fb still holds
>     : This has alwways been problem AFAIU.  It just went unnoticed because we
>     : have zeroed memmaps during allocation before f7f99100d8d9 ("mm: stop
>     : zeroing memory during allocation in vmemmap") and so the above test
>     : would simply skip these ranges as belonging to zone 0 or provided a
>     : garbage.
>     :
>     : So I guess we do care for post f7f99100d8d9 kernels mostly and
>     : therefore Fixes: f7f99100d8d9 ("mm: stop zeroing memory during
>     : allocation in vmemmap")
> 
> But, please let's wait for the patch 1 to be confirmed to fix the issue.

Also the revert [1] should be applied first. I thought Linus would pick
it up but he hasn't done so yet.

[1] http://lkml.kernel.org/r/20190125181549.GE20411@dhcp22.suse.cz
-- 
Michal Hocko
SUSE Labs
