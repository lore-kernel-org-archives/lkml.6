Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D781C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 21:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD64C20870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 21:58:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD64C20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbeLMV6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 16:58:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35080 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726435AbeLMV6H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 16:58:07 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 12464307EAA1;
        Thu, 13 Dec 2018 21:58:07 +0000 (UTC)
Received: from redhat.com (ovpn-121-220.rdu2.redhat.com [10.10.121.220])
        by smtp.corp.redhat.com (Postfix) with SMTP id AB99761B77;
        Thu, 13 Dec 2018 21:58:05 +0000 (UTC)
Date:   Thu, 13 Dec 2018 16:58:04 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/3] vhost: access vq metadata through kernel
 virtual address
Message-ID: <20181213165731-mutt-send-email-mst@kernel.org>
References: <20181213101022.12475-1-jasowang@redhat.com>
 <20181213101022.12475-4-jasowang@redhat.com>
 <20181213102713-mutt-send-email-mst@kernel.org>
 <20181213211840.GC18692@char.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213211840.GC18692@char.us.oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Thu, 13 Dec 2018 21:58:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 04:18:40PM -0500, Konrad Rzeszutek Wilk wrote:
> .giant snip..
> > > +	npinned = get_user_pages_fast(uaddr, npages, write, pages);
> > > +	if (npinned != npages)
> > > +		goto err;
> > > +
> > 
> > As I said I have doubts about the whole approach, but this
> > implementation in particular isn't a good idea
> > as it keeps the page around forever.
> > So no THP, no NUMA rebalancing, userspace-controlled
> > amount of memory locked up and not accounted for.
> > 
> > Don't get me wrong it's a great patch in an ideal world.
> > But then in an ideal world no barriers smap etc are necessary at all.
> 
> So .. suggestions on how this could be accepted? As in other ways
> where we still get vmap and the issues you mentioned are not troubling you?
> 
> Thanks!

I'd suggest leave vmap alone and find ways to speed up accesses
that can fault.

-- 
MST
