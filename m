Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C583AC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 22:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 712E62086E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 22:04:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 712E62086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbeIZENr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 00:13:47 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47596 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725732AbeIZENr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 00:13:47 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id EAFD0E8A;
        Tue, 25 Sep 2018 22:04:07 +0000 (UTC)
Date:   Tue, 25 Sep 2018 15:04:06 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Michal Hocko <mhocko@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org
Subject: Re: [patch v2] mm, thp: always specify ineligible vmas as nh in
 smaps
Message-Id: <20180925150406.872aab9f4f945193e5915d69@linux-foundation.org>
In-Reply-To: <alpine.DEB.2.21.1809251440001.94921@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1809241054050.224429@chino.kir.corp.google.com>
        <e2f159f3-5373-dda4-5904-ed24d029de3c@suse.cz>
        <alpine.DEB.2.21.1809241215170.239142@chino.kir.corp.google.com>
        <alpine.DEB.2.21.1809241227370.241621@chino.kir.corp.google.com>
        <20180924195603.GJ18685@dhcp22.suse.cz>
        <20180924200258.GK18685@dhcp22.suse.cz>
        <0aa3eb55-82c0-eba3-b12c-2ba22e052a8e@suse.cz>
        <alpine.DEB.2.21.1809251248450.50347@chino.kir.corp.google.com>
        <20180925202959.GY18685@dhcp22.suse.cz>
        <alpine.DEB.2.21.1809251440001.94921@chino.kir.corp.google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Sep 2018 14:45:19 -0700 (PDT) David Rientjes <rientjes@google.com> wrote:

> > > It is also used in 
> > > automated testing to ensure that vmas get disabled for thp appropriately 
> > > and we used "nh" since that is how PR_SET_THP_DISABLE previously enforced 
> > > this, and those tests now break.
> > 
> > This sounds like a bit of an abuse to me. It shows how an internal
> > implementation detail leaks out to the userspace which is something we
> > should try to avoid.
> > 
> 
> Well, it's already how this has worked for years before commit 
> 1860033237d4 broke it.  Changing the implementation in the kernel is fine 
> as long as you don't break userspace who relies on what is exported to it 
> and is the only way to determine if MADV_NOHUGEPAGE is preventing it from 
> being backed by hugepages.

1860033237d4 was over a year ago so perhaps we don't need to be
too worried about restoring the old interface.  In which case
we have an opportunity to make improvements such as that suggested
by Michal?
