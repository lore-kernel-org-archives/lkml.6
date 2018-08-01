Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE4BC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90EA520840
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:50:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90EA520840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732518AbeHAXiN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 19:38:13 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56910 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbeHAXiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 19:38:13 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2EA1CD3C;
        Wed,  1 Aug 2018 21:50:21 +0000 (UTC)
Date:   Wed, 1 Aug 2018 14:50:20 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     linux-mm@kvack.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, mhocko@suse.com,
        vbabka@suse.cz, Punit.Agrawal@arm.com, Lorenzo.Pieralisi@arm.com,
        linux-arm-kernel@lists.infradead.org, bhelgaas@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 0/2] harden alloc_pages against bogus nid
Message-Id: <20180801145020.8c76a490c1bf9bef5f87078a@linux-foundation.org>
In-Reply-To: <20180801200418.1325826-1-jeremy.linton@arm.com>
References: <20180801200418.1325826-1-jeremy.linton@arm.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  1 Aug 2018 15:04:16 -0500 Jeremy Linton <jeremy.linton@arm.com> wrote:

> The thread "avoid alloc memory on offline node"
> 
> https://lkml.org/lkml/2018/6/7/251
> 
> Asked at one point why the kzalloc_node was crashing rather than
> returning memory from a valid node. The thread ended up fixing
> the immediate causes of the crash but left open the case of bad
> proximity values being in DSDT tables without corrisponding
> SRAT/SLIT entries as is happening on another machine.
> 
> Its also easy to fix that, but we should also harden the allocator
> sufficiently that it doesn't crash when passed an invalid node id.
> There are a couple possible ways to do this, and i've attached two
> separate patches which individually fix that problem.
> 
> The first detects the offline node before calling
> the new_slab code path when it becomes apparent that the allocation isn't
> going to succeed. The second actually hardens node_zonelist() and
> prepare_alloc_pages() in the face of NODE_DATA(nid) returning a NULL
> zonelist. This latter case happens if the node has never been initialized
> or is possibly out of range. There are other places (NODE_DATA &
> online_node) which should be checking if the node id's are > MAX_NUMNODES.
> 

What is it that leads to a caller requesting memory from an invalid
node?  A race against offlining?  If so then that's a lack of
appropriate locking, isn't it?

I don't see a problem with emitting a warning and then selecting a
different node so we can keep running.  But we do want that warning, so
we can understand the root cause and fix it?

