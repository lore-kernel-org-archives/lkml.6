Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C3EC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 20:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB79B2086B
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 20:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZujcvJZi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB79B2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389030AbeKPGqQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 01:46:16 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39978 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbeKPGqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 01:46:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=z44zp6fjVwrRNouicmXdGiJQxBKI/b9XXLBnKzU+gdc=; b=ZujcvJZipupo1NNnNeMkZUAmN
        ZduQsITXsYYcEe7XcD+C0sNdDhzDpBE6vjkyyoHEOcyX1toDJ8QgB8j2RsdBBW4ez2+0LreQJX07b
        xyF+k+o8ffqiAwOPMaL9vw4ay7XQi4dq6Ysq5TRG9HgPy30jr3h2KcVtZd7Bl5om+eLQgZKoB6oC5
        I2rb7Ef0rurVyx+HCAMhBzbQEdo2vV71YN47Eg5fnXkb3kcnVrTsDHJOZpd7fj3u3sfjwHEFb/ScO
        YT4bnDyFpPok/Q5kAakg2z3n5fnH8oIA4kW5DXgaoNdeS/W+7NSaG24t6E2k7ue5hPlPpeZ4fatQ9
        LwD60H9Gw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gNONi-0003TG-KV; Thu, 15 Nov 2018 20:36:54 +0000
Date:   Thu, 15 Nov 2018 12:36:54 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Keith Busch <keith.busch@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-mm@kvack.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 1/7] node: Link memory nodes to their compute nodes
Message-ID: <20181115203654.GA28246@bombadil.infradead.org>
References: <20181114224921.12123-2-keith.busch@intel.com>
 <20181115135710.GD19286@bombadil.infradead.org>
 <20181115145920.GG11416@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181115145920.GG11416@localhost.localdomain>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 07:59:20AM -0700, Keith Busch wrote:
> On Thu, Nov 15, 2018 at 05:57:10AM -0800, Matthew Wilcox wrote:
> > On Wed, Nov 14, 2018 at 03:49:14PM -0700, Keith Busch wrote:
> > > Memory-only nodes will often have affinity to a compute node, and
> > > platforms have ways to express that locality relationship.
> > > 
> > > A node containing CPUs or other DMA devices that can initiate memory
> > > access are referred to as "memory iniators". A "memory target" is a
> > > node that provides at least one phyiscal address range accessible to a
> > > memory initiator.
> > 
> > I think I may be confused here.  If there is _no_ link from node X to
> > node Y, does that mean that node X's CPUs cannot access the memory on
> > node Y?  In my mind, all nodes can access all memory in the system,
> > just not with uniform bandwidth/latency.
> 
> The link is just about which nodes are "local". It's like how nodes have
> a cpulist. Other CPUs not in the node's list can acces that node's memory,
> but the ones in the mask are local, and provide useful optimization hints.

So ... let's imagine a hypothetical system (I've never seen one built like
this, but it doesn't seem too implausible).  Connect four CPU sockets in
a square, each of which has some regular DIMMs attached to it.  CPU A is
0 hops to Memory A, one hop to Memory B and Memory C, and two hops from
Memory D (each CPU only has two "QPI" links).  Then maybe there's some
special memory extender device attached on the PCIe bus.  Now there's
Memory B1 and B2 that's attached to CPU B and it's local to CPU B, but
not as local as Memory B is ... and we'd probably _prefer_ to allocate
memory for CPU A from Memory B1 than from Memory D.  But ... *mumble*,
this seems hard.

I understand you're trying to reflect what the HMAT table is telling you,
I'm just really fuzzy on who's ultimately consuming this information
and what decisions they're trying to drive from it.

> Would a node mask would be prefered to symlinks?

I don't have a strong opinion here, but what Dan says makes sense.

