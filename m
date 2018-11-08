Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42749C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 02:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E99B320857
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 02:50:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E99B320857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbeKHMX6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 07:23:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42514 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728346AbeKHMX6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 07:23:58 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 43909461D0;
        Thu,  8 Nov 2018 02:50:43 +0000 (UTC)
Received: from redhat.com (ovpn-120-200.rdu2.redhat.com [10.10.120.200])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D1A69106A790;
        Thu,  8 Nov 2018 02:50:42 +0000 (UTC)
Date:   Wed, 7 Nov 2018 21:50:42 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Wei Wang <wei.w.wang@intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: virtio-balloon: VIRTIO_BALLOON_F_PAGE_POISON discussion
Message-ID: <20181107214929-mutt-send-email-mst@kernel.org>
References: <286AC319A985734F985F78AFA26841F73DE40B6C@shsmsx102.ccr.corp.intel.com>
 <20181107102538-mutt-send-email-mst@kernel.org>
 <5BE3A430.7030505@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5BE3A430.7030505@intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 08 Nov 2018 02:50:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 10:49:20AM +0800, Wei Wang wrote:
> On 11/07/2018 11:27 PM, Michael S. Tsirkin wrote:
> 
> + LKML
> 
> > On Wed, Nov 07, 2018 at 02:29:02PM +0000, Wang, Wei W wrote:
> > > Hi Michael,
> > > 
> > > 
> > > Thanks again for reviewing so many versions of patches, and I learnt a lot from
> > > your comments.
> > > 
> > > 
> > > While I’m writing the virtio-balloon spec patches, I’m thinking probably we
> > > don’t need VIRTIO_BALLOON_F_PAGE_POISON to limit
> > > VIRTIO_BALLOON_F_FREE_PAGE_HINT, because now the guest frees the allocated
> > > pages after the migration is done (that is, the skipped free pages will be
> > > poisoned when the guest is already on the destination machine).
> > The concern was this:
> > 
> > guest poisons the page by writing a non-0 pattern there
> > guest sends page to host
> > VM is migrated, page is unmapped
> > guest reads page, zero page is mapped
> 
> Not sure about this one: I think guest wouldn't read the page,
> since they are held by balloon (balloon itself will also
> not read it, the page just stays on a list waiting to be freed).
> Please see the below example.
> 
> > guest sees 0 in page and detects it as use after free
> 
>  - balloon collects (i.e. alloc) a free page X (now it
>    has 0xaa poison value) and reports X to host to be skipped in
>    migration;
>  -  Now VM is migrated to the destination, and on the destination
>     side, X is not mapped initially.
>  -  Nobody will access X since it has been taken by balloon
>     and stays on a list waiting to be freed. So the first chance
>     that will get X mapped will be the moment that balloon
>     returns X to mm via free(), as free() writes the
>     poison value to X.
> 
> 
> Best,
> Wei


Oh I see, that was with the previous design where we bypassed alloc.
I think you are right, but better stress-test it.

-- 
MST
