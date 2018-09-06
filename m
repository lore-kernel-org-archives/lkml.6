Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A852C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 15:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5BA920861
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 15:13:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5BA920861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730238AbeIFTth (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 15:49:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:33078 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727501AbeIFTth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 15:49:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 84219AE4D;
        Thu,  6 Sep 2018 15:13:37 +0000 (UTC)
Date:   Thu, 6 Sep 2018 17:13:36 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Alexander Duyck <alexander.duyck@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, alexander.h.duyck@intel.com,
        pavel.tatashin@microsoft.com, akpm@linux-foundation.org,
        mingo@kernel.org, kirill.shutemov@linux.intel.com
Subject: Re: [PATCH v2 1/2] mm: Move page struct poisoning to
 CONFIG_DEBUG_VM_PAGE_INIT_POISON
Message-ID: <20180906151336.GD14951@dhcp22.suse.cz>
References: <20180905211041.3286.19083.stgit@localhost.localdomain>
 <20180905211328.3286.71674.stgit@localhost.localdomain>
 <20180906054735.GJ14951@dhcp22.suse.cz>
 <0c1c36f7-f45a-8fe9-dd52-0f60b42064a9@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c1c36f7-f45a-8fe9-dd52-0f60b42064a9@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 06-09-18 07:59:03, Dave Hansen wrote:
> On 09/05/2018 10:47 PM, Michal Hocko wrote:
> > why do you have to keep DEBUG_VM enabled for workloads where the boot
> > time matters so much that few seconds matter?
> 
> There are a number of distributions that run with it enabled in the
> default build.  Fedora, for one.  We've basically assumed for a while
> that we have to live with it in production environments.
> 
> So, where does leave us?  I think we either need a _generic_ debug
> option like:
> 
> 	CONFIG_DEBUG_VM_SLOW_AS_HECK
> 
> under which we can put this an other really slow VM debugging.  Or, we
> need some kind of boot-time parameter to trigger the extra checking
> instead of a new CONFIG option.

I strongly suspect nobody will ever enable such a scary looking config
TBH. Besides I am not sure what should go under that config option.
Something that takes few cycles but it is called often or one time stuff
that takes quite a long but less than aggregated overhead of the former?

Just consider this particular case. It basically re-adds an overhead
that has always been there before the struct page init optimization
went it. The poisoning just returns it in a different form to catch
potential left overs. And we would like to have as many people willing
to running in debug mode to test for those paths because they are
basically impossible to review by the code inspection. More importantnly
the major overhead is boot time so my question still stands. Is this
worth a separate config option almost nobody is going to enable?

Enabling DEBUG_VM by Fedora and others serves us a very good testing
coverage and I appreciate that because it has generated some useful bug
reports. Those people are paying quite a lot of overhead in runtime
which can aggregate over time is it so much to ask about one time boot
overhead?

-- 
Michal Hocko
SUSE Labs
