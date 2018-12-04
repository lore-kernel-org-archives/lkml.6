Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08DE6C04EB9
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 00:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF12F20851
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 00:54:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF12F20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbeLDAyq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 19:54:46 -0500
Received: from mga11.intel.com ([192.55.52.93]:6889 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725976AbeLDAyq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 19:54:46 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Dec 2018 16:54:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,312,1539673200"; 
   d="scan'208";a="107028735"
Received: from awsossav-mobl.amr.corp.intel.com (HELO localhost) ([10.254.201.151])
  by orsmga003.jf.intel.com with ESMTP; 03 Dec 2018 16:54:44 -0800
Date:   Mon, 3 Dec 2018 16:54:43 -0800
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, luto@kernel.org,
        peterz@infradead.org
Subject: Re: [PATCH] x86/mpx: pass 'mm' to kernel_managing_mpx_tables() in
 mpx_notify_unmap()
Message-ID: <20181204005443.GA5164@linux.intel.com>
References: <20181203204357.26209-1-jarkko.sakkinen@linux.intel.com>
 <933b60c9-ad26-a377-f4e2-a7dca4fdae30@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <933b60c9-ad26-a377-f4e2-a7dca4fdae30@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 12:49:44PM -0800, Dave Hansen wrote:
> On 12/3/18 12:43 PM, Jarkko Sakkinen wrote:
> > If mm is not the same as current->mm, mpx_notify_unmap() will yield
> > invalid results and at worst will lead to a crash if it gets called by
> > a kthread.
> 
> It's also worth noting that this does not fix any actual,
> end-user-visible bug today.  It really only prepares the code for the
> case where it is called for a different mm than current->mm.
> 
> > --- a/arch/x86/mm/mpx.c
> > +++ b/arch/x86/mm/mpx.c
> > @@ -882,7 +882,7 @@ static int mpx_unmap_tables(struct mm_struct *mm,
> >   * necessary, and the 'vma' is the first vma in this range (start -> end).
> >   */
> >  void mpx_notify_unmap(struct mm_struct *mm, struct vm_area_struct *vma,
> > -		unsigned long start, unsigned long end)
> > +		      unsigned long start, unsigned long end)
> >  {
> >  	int ret;
> 
> Please leave superfluous whitespace changes out of these things.
> 
> But, otherwise, this looks fine.
> 
> > Fixes: 1de4fa14ee25 ("x86, mpx: Cleanup unused bound tables")
> 
> FWIW, I'm not sure you should be submitting this separately from your
> SGX series.  The deferred unmapping is really the thing that requires
> the code to be changed.

Thank you for the feedback. I'll include this to the next revision of the
SGX patch set and explain why the change is needed.

/Jarkko
