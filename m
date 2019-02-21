Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3628AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 00:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3BBB20855
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 00:16:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfBUAQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 19:16:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34860 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726120AbfBUAQB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 19:16:01 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 066AAC03BD4B;
        Thu, 21 Feb 2019 00:16:01 +0000 (UTC)
Received: from redhat.com (ovpn-120-249.rdu2.redhat.com [10.10.120.249])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E41B65D9D4;
        Thu, 21 Feb 2019 00:15:59 +0000 (UTC)
Date:   Wed, 20 Feb 2019 19:15:57 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Ralph Campbell <rcampbell@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 01/10] mm/hmm: use reference counting for HMM struct
Message-ID: <20190221001557.GA24489@redhat.com>
References: <20190129165428.3931-1-jglisse@redhat.com>
 <20190129165428.3931-2-jglisse@redhat.com>
 <1373673d-721e-a7a2-166f-244c16f236a3@nvidia.com>
 <20190220235933.GD11325@redhat.com>
 <dd448c6f-5ed7-ceb4-ca5e-c7650473a47c@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dd448c6f-5ed7-ceb4-ca5e-c7650473a47c@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Thu, 21 Feb 2019 00:16:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 04:06:50PM -0800, John Hubbard wrote:
> On 2/20/19 3:59 PM, Jerome Glisse wrote:
> > On Wed, Feb 20, 2019 at 03:47:50PM -0800, John Hubbard wrote:
> > > On 1/29/19 8:54 AM, jglisse@redhat.com wrote:
> > > > From: Jérôme Glisse <jglisse@redhat.com>
> > > > 
> > > > Every time i read the code to check that the HMM structure does not
> > > > vanish before it should thanks to the many lock protecting its removal
> > > > i get a headache. Switch to reference counting instead it is much
> > > > easier to follow and harder to break. This also remove some code that
> > > > is no longer needed with refcounting.
> > > 
> > > Hi Jerome,
> > > 
> > > That is an excellent idea. Some review comments below:
> > > 
> > > [snip]
> > > 
> > > >    static int hmm_invalidate_range_start(struct mmu_notifier *mn,
> > > >    			const struct mmu_notifier_range *range)
> > > >    {
> > > >    	struct hmm_update update;
> > > > -	struct hmm *hmm = range->mm->hmm;
> > > > +	struct hmm *hmm = hmm_get(range->mm);
> > > > +	int ret;
> > > >    	VM_BUG_ON(!hmm);
> > > > +	/* Check if hmm_mm_destroy() was call. */
> > > > +	if (hmm->mm == NULL)
> > > > +		return 0;
> > > 
> > > Let's delete that NULL check. It can't provide true protection. If there
> > > is a way for that to race, we need to take another look at refcounting.
> > 
> > I will do a patch to delete the NULL check so that it is easier for
> > Andrew. No need to respin.
> 
> (Did you miss my request to make hmm_get/hmm_put symmetric, though?)

Went over my mail i do not see anything about symmetric, what do you
mean ?

Cheers,
Jérôme
