Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B3E1C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 00:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49D8920862
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 00:14:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49D8920862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731362AbeHBCCi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 22:02:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50906 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbeHBCCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 22:02:37 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 62208910;
        Thu,  2 Aug 2018 00:14:15 +0000 (UTC)
Date:   Wed, 1 Aug 2018 17:14:14 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     linux-mm@kvack.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, mhocko@suse.com,
        vbabka@suse.cz, Punit.Agrawal@arm.com, Lorenzo.Pieralisi@arm.com,
        linux-arm-kernel@lists.infradead.org, bhelgaas@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 0/2] harden alloc_pages against bogus nid
Message-Id: <20180801171414.30e54a106733ccaaa566388d@linux-foundation.org>
In-Reply-To: <d9f8e9d1-2fb8-6016-5081-7e3213b23ed4@arm.com>
References: <20180801200418.1325826-1-jeremy.linton@arm.com>
        <20180801145020.8c76a490c1bf9bef5f87078a@linux-foundation.org>
        <d9f8e9d1-2fb8-6016-5081-7e3213b23ed4@arm.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Aug 2018 17:56:46 -0500 Jeremy Linton <jeremy.linton@arm.com> wrote:

> Hi,
> 
> On 08/01/2018 04:50 PM, Andrew Morton wrote:
> > On Wed,  1 Aug 2018 15:04:16 -0500 Jeremy Linton <jeremy.linton@arm.com> wrote:
> > 
> >> The thread "avoid alloc memory on offline node"
> >>
> >> https://lkml.org/lkml/2018/6/7/251
> >>
> >> Asked at one point why the kzalloc_node was crashing rather than
> >> returning memory from a valid node. The thread ended up fixing
> >> the immediate causes of the crash but left open the case of bad
> >> proximity values being in DSDT tables without corrisponding
> >> SRAT/SLIT entries as is happening on another machine.
> >>
> >> Its also easy to fix that, but we should also harden the allocator
> >> sufficiently that it doesn't crash when passed an invalid node id.
> >> There are a couple possible ways to do this, and i've attached two
> >> separate patches which individually fix that problem.
> >>
> >> The first detects the offline node before calling
> >> the new_slab code path when it becomes apparent that the allocation isn't
> >> going to succeed. The second actually hardens node_zonelist() and
> >> prepare_alloc_pages() in the face of NODE_DATA(nid) returning a NULL
> >> zonelist. This latter case happens if the node has never been initialized
> >> or is possibly out of range. There are other places (NODE_DATA &
> >> online_node) which should be checking if the node id's are > MAX_NUMNODES.
> >>
> > 
> > What is it that leads to a caller requesting memory from an invalid
> > node?  A race against offlining?  If so then that's a lack of
> > appropriate locking, isn't it?
> 
> There were a couple unrelated cases, both having to do with the PXN 
> associated with a PCI port. The first case AFAIK, the domain wasn't 
> really invalid if the entire SRAT was parsed and nodes created even when 
> there weren't associated CPUs. The second case (a different machine) is 
> simply a PXN value that is completely invalid (no associated 
> SLIT/SRAT/etc entries) due to firmware making a mistake when a socket 
> isn't populated.
> 
> There have been a few other suggested or merged patches for the 
> individual problems above, this set is just an attempt at avoiding a 
> full crash if/when another similar problem happens.

Please add the above info to the changelog.

> 
> > 
> > I don't see a problem with emitting a warning and then selecting a
> > different node so we can keep running.  But we do want that warning, so
> > we can understand the root cause and fix it?
> 
> Yes, we do want to know when an invalid id is passed, i will add the 
> VM_WARN in the first one.
> 
> The second one I wasn't sure about as failing prepare_alloc_pages() 
> generates a couple of error messages, but the system then continues 
> operation.
> 
> I guess my question though is which method (or both/something else?) is 
> the preferred way to harden this up?

The first patch looked neater.  Can we get a WARN_ON in there as well?
