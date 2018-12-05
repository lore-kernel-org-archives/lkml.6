Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08817C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C490B20879
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SDVRmLJo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C490B20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbeLERcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 12:32:04 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48150 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727475AbeLERcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 12:32:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RdrY3P1cNmaV9ItIQ4yjB9qAqpkVJ/dzzD9kY8jmt5c=; b=SDVRmLJotdymrXNnDKMsNc3TZ
        aILEa+7Dn/LsKJz2L8u+TeGH3qaM9XHE85ijGedcmvmC4UvYmkNs+aGM91FbEpfWmVonSkLeWZxHD
        5DhlHwsLLJ2FnzM/jbr/LIS/4uuxvrlKsWQaBf/sojsW9vphIyoCS/DUBuNIMDg1z0N0gZnp9fG/J
        zcAR/q3jM+D3P6PzFTGgB6wNf6VgkFs1mhRKPbiCbytkMQSB0DoN85a2BPUUrbuVTc8pFtKPVFH72
        +nQ409q6abyprryoQ4m8DqmcDS1WhrYIsQhGk10/0j/El7cHOKapqQvmJxu8eCNSx8vdJ1BPBrCS3
        ybCbzuULw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gUb1l-00088G-HT; Wed, 05 Dec 2018 17:32:01 +0000
Date:   Wed, 5 Dec 2018 09:32:01 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        Miles Chen <miles.chen@mediatek.com>,
        yi.z.zhang@linux.intel.com, Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH RFC 7/7] mm: better document PG_reserved
Message-ID: <20181205173201.GA11646@bombadil.infradead.org>
References: <20181205122851.5891-1-david@redhat.com>
 <20181205122851.5891-8-david@redhat.com>
 <20181205143510.GA17232@bombadil.infradead.org>
 <46d0e90f-f0bb-815e-7a5b-4429de1c502a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46d0e90f-f0bb-815e-7a5b-4429de1c502a@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 04:05:12PM +0100, David Hildenbrand wrote:
> On 05.12.18 15:35, Matthew Wilcox wrote:
> > On Wed, Dec 05, 2018 at 01:28:51PM +0100, David Hildenbrand wrote:
> >> I don't see a reason why we have to document "Some of them might not even
> >> exist". If there is a user, we should document it. E.g. for balloon
> >> drivers we now use PG_offline to indicate that a page might currently
> >> not be backed by memory in the hypervisor. And that is independent from
> >> PG_reserved.
> > 
> > I think you're confused by the meaning of "some of them might not even
> > exist".  What this means is that there might not be memory there; maybe
> > writes to that memory will be discarded, or maybe they'll cause a machine
> > check.  Maybe reads will return ~0, or 0, or cause a machine check.
> > We just don't know what's there, and we shouldn't try touching the memory.
> 
> If there are users, let's document it. And I need more details for that :)
> 
> 1. machine check: if there is a HW error, we set PG_hwpoison (except
> ia64 MCA, see the list)
> 
> 2. Writes to that memory will be discarded
> 
> Who is the user of that? When will we have such pages right now?
> 
> 3. Reads will return ~0, / 0?
> 
> I think this is a special case of e.g. x86? But where do we have that,
> are there any user?

When there are gaps in the physical memory.  As in, if you put that
physical address on the bus (or in a packet), no device will respond
to it.  Look:

00000000-00000fff : Reserved
00001000-00057fff : System RAM
00058000-00058fff : Reserved
00059000-0009dfff : System RAM
0009e000-000fffff : Reserved

Those examples I gave are examples of how various different architectures
respond to "no device responded to this memory access".

