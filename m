Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DEDEC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 18:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4079D2087A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 18:36:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4079D2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390279AbeKQEtx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 23:49:53 -0500
Received: from mga04.intel.com ([192.55.52.120]:24601 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727710AbeKQEtx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 23:49:53 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Nov 2018 10:36:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,241,1539673200"; 
   d="scan'208";a="274608130"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga005.jf.intel.com with ESMTP; 16 Nov 2018 10:36:17 -0800
Date:   Fri, 16 Nov 2018 11:32:54 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-mm@kvack.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 1/7] node: Link memory nodes to their compute nodes
Message-ID: <20181116183254.GD14630@localhost.localdomain>
References: <20181114224921.12123-2-keith.busch@intel.com>
 <20181115135710.GD19286@bombadil.infradead.org>
 <20181115145920.GG11416@localhost.localdomain>
 <20181115203654.GA28246@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181115203654.GA28246@bombadil.infradead.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 12:36:54PM -0800, Matthew Wilcox wrote:
> On Thu, Nov 15, 2018 at 07:59:20AM -0700, Keith Busch wrote:
> > On Thu, Nov 15, 2018 at 05:57:10AM -0800, Matthew Wilcox wrote:
> > > On Wed, Nov 14, 2018 at 03:49:14PM -0700, Keith Busch wrote:
> > > > Memory-only nodes will often have affinity to a compute node, and
> > > > platforms have ways to express that locality relationship.
> > > > 
> > > > A node containing CPUs or other DMA devices that can initiate memory
> > > > access are referred to as "memory iniators". A "memory target" is a
> > > > node that provides at least one phyiscal address range accessible to a
> > > > memory initiator.
> > > 
> > > I think I may be confused here.  If there is _no_ link from node X to
> > > node Y, does that mean that node X's CPUs cannot access the memory on
> > > node Y?  In my mind, all nodes can access all memory in the system,
> > > just not with uniform bandwidth/latency.
> > 
> > The link is just about which nodes are "local". It's like how nodes have
> > a cpulist. Other CPUs not in the node's list can acces that node's memory,
> > but the ones in the mask are local, and provide useful optimization hints.
> 
> So ... let's imagine a hypothetical system (I've never seen one built like
> this, but it doesn't seem too implausible).  Connect four CPU sockets in
> a square, each of which has some regular DIMMs attached to it.  CPU A is
> 0 hops to Memory A, one hop to Memory B and Memory C, and two hops from
> Memory D (each CPU only has two "QPI" links).  Then maybe there's some
> special memory extender device attached on the PCIe bus.  Now there's
> Memory B1 and B2 that's attached to CPU B and it's local to CPU B, but
> not as local as Memory B is ... and we'd probably _prefer_ to allocate
> memory for CPU A from Memory B1 than from Memory D.  But ... *mumble*,
> this seems hard.

Indeed, that particular example is out of scope for this series. The
first objective is to aid a process running in node B's CPUs to allocate
memory in B1. Anything that crosses QPI are their own.

> I understand you're trying to reflect what the HMAT table is telling you,
> I'm just really fuzzy on who's ultimately consuming this information
> and what decisions they're trying to drive from it.

Intended consumers include processes using numa_alloc_onnode() and mbind().

Consider a system with faster DRAM and slower persistent memory. Such
a system may group the DRAM in a different proximity domain than the
persistent memory, and both are local to yet another proximity domain
that contains the CPUs. HMAT provides a way to express that relationship,
and this patch provides a user facing abstraction for that information.
