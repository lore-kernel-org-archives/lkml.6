Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C21C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 15:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E81A21A53
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 15:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UgTKrWMa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E81A21A53
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732798AbeHFRds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 13:33:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36550 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729697AbeHFRds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 13:33:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=JZ6dhqCURmkBHO5OW8EF+5TQpTi64JLNMS7WB9UErDA=; b=UgTKrWMafVoE8544+zAl9AQ7Z
        VddcyMk4+euzyXQLfXZL5IRrEy8+CuGnzntAjaqnxocFmK2fju4nljLzwbNu0cJtLBYyxqRWp8u9V
        ZwAb7mli0a9lq9uSpEULiPbNiwcFIbFzJYN+oWsdOZ+PMgPt+fHHTC2fM5eiBSxUJODpGYpONn6U/
        HpMREghflwHXq/+WUr6zT43m67BvVdVlxTW5x8wqYTT+SmlowArRh9lqPq/kZyPtxqxso2whUc8p2
        1vSJzqAQN4d3A/Smi4ejlN93H45JDkDeOX17tN1O/FdTDywL19B3mar7//I8KmQEUfvWpO+8dktId
        fdlQs6hUQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fmhMc-0007bs-Lk; Mon, 06 Aug 2018 15:24:06 +0000
Date:   Mon, 6 Aug 2018 08:24:06 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        robh@kernel.org, srikar@linux.vnet.ibm.com, aik@ozlabs.ru,
        Jason Wang <jasowang@redhat.com>, linuxram@us.ibm.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, hch@infradead.org,
        paulus@samba.org, joe@perches.com, david@gibson.dropbear.id.au,
        linuxppc-dev@lists.ozlabs.org, elfring@users.sourceforge.net,
        haren@linux.vnet.ibm.com
Subject: Re: [RFC 0/4] Virtio uses DMA API for all devices
Message-ID: <20180806152406.GA29020@infradead.org>
References: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
 <20180802235332-mutt-send-email-mst@kernel.org>
 <b31d2162-884c-0ed4-00df-e7debe0cc0e7@redhat.com>
 <20180803220812-mutt-send-email-mst@kernel.org>
 <01c74680c4b3aa25d9b4375a9ab5e10046b7c71b.camel@kernel.crashing.org>
 <20180805032355-mutt-send-email-mst@kernel.org>
 <74a1e1b8-81e0-84db-6d0d-d8bd9caebb4a@linux.vnet.ibm.com>
 <20180806163440-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180806163440-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2018 at 04:36:43PM +0300, Michael S. Tsirkin wrote:
> On Mon, Aug 06, 2018 at 02:32:28PM +0530, Anshuman Khandual wrote:
> > On 08/05/2018 05:54 AM, Michael S. Tsirkin wrote:
> > > On Fri, Aug 03, 2018 at 08:21:26PM -0500, Benjamin Herrenschmidt wrote:
> > >> On Fri, 2018-08-03 at 22:08 +0300, Michael S. Tsirkin wrote:
> > >>>>>> Please go through these patches and review whether this approach broadly
> > >>>>>> makes sense. I will appreciate suggestions, inputs, comments regarding
> > >>>>>> the patches or the approach in general. Thank you.
> > >>>>>
> > >>>>> Jason did some work on profiling this. Unfortunately he reports
> > >>>>> about 4% extra overhead from this switch on x86 with no vIOMMU.
> > >>>>
> > >>>> The test is rather simple, just run pktgen (pktgen_sample01_simple.sh) in
> > >>>> guest and measure PPS on tap on host.
> > >>>>
> > >>>> Thanks
> > >>>
> > >>> Could you supply host configuration involved please?
> > >>
> > >> I wonder how much of that could be caused by Spectre mitigations
> > >> blowing up indirect function calls...
> > >>
> > >> Cheers,
> > >> Ben.
> > > 
> > > I won't be surprised. If yes I suggested a way to mitigate the overhead.
> > 
> > Did we get better results (lower regression due to indirect calls) with
> > the suggested mitigation ? Just curious.
> 
> I'm referring to this:
> 	I wonder whether we can support map_sg and friends being NULL, then use
> 	that when mapping is an identity. A conditional branch there is likely
> 	very cheap.
> 
> I don't think anyone tried implementing this yes.

I've done something very similar in the thread I posted a few years
ago. I plan to get a version of that upstream for 4.20, but it won't
cover the virtio case, just the real direct mapping.
