Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD3FC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 22:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1934321720
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 22:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ns3j1nXf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390163AbeLTWcb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 17:32:31 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41678 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732764AbeLTWca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 17:32:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6HH0K2GHtVA1ltr1jtvXARdk0PBmXgv2+TS2cMvXO2Y=; b=ns3j1nXftVyae8OUBzf63+uh1
        HHQUrbVb+JZrpNwCIQMGDhvybi3Bj1f6itkhiqsnh09msZy0n/ed37BX3GfTAUowPLVTbuKpyODWL
        iZh2H/FF1paO+dw5cDOXExkQu4xL+aWy1lSvtPfVRGOtWggUlQfnhVyQK0HFuEBYYcC8knEneLVmB
        xcaPxmlx2RQEU+0xMz7m8vPxnGl8ogaa34jS5uiBAEXAJQiMyvfndbtlMy29+ZXdy/ts5fbVdRTWC
        LXeWw+N/KVjQ2OP8toj7veDk1IEAq0rWwB8lKoH+9MtsT5jpuc7aLPe9q4k9RLkVn99IEC36+IvTt
        Z+4nWARTQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ga6rX-0002yC-8n; Thu, 20 Dec 2018 22:32:15 +0000
Subject: Re: [RFC 0/7] Slab object migration for xarray V2
To:     Christoph Lameter <cl@linux.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Pekka Enberg <penberg@cs.helsinki.fi>,
        akpm@linux-foundation.org, Mel Gorman <mel@skynet.ie>,
        andi@firstfloor.org, Rik van Riel <riel@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
References: <01000167cd1130c8-c9bebcb9-1f95-4f7c-b24a-90600d56c62f-000000@email.amazonses.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e7a2e0a5-d5b7-a158-52a1-6aa230501a94@infradead.org>
Date:   Thu, 20 Dec 2018 14:32:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <01000167cd1130c8-c9bebcb9-1f95-4f7c-b24a-90600d56c62f-000000@email.amazonses.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/20/18 11:21 AM, Christoph Lameter wrote:
> To test apply this patchset and run a workload that uses lots of radix tree objects
> 
> 
> Then go to
> 
> /sys/kernel/slab/radix_tree_node
> 
> Inspect the number of total objects that the slab can handle
> 
> 	cat total_objects

	cat objects # ???

(as below) (just checking :)


> 
> qmdr:/sys/kernel/slab/radix_tree_node# cat objects
> 868 N0=448 N1=168 N2=56 N3=196
> 
> And the number of slab pages used for those
> 
> 	cat slabs
> 
> qmdr:/sys/kernel/slab/radix_tree_node# cat slabs
> 31 N0=16 N1=6 N2=2 N3=7
> 
> 
> Perform a cache shrink operation
> 
> 	echo 1 >shrink
> 
> 
> Now see how the slab has changed:
> 
> qmdr:/sys/kernel/slab/radix_tree_node# cat slabs
> 30 N0=15 N1=6 N2=2 N3=7
> qmdr:/sys/kernel/slab/radix_tree_node# cat objects
> 713 N0=349 N1=141 N2=52 N3=171


-- 
~Randy
