Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0571C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 22:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97C5620989
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 22:51:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQoW4lE9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97C5620989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbeK1JvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 04:51:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:41620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726068AbeK1JvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 04:51:10 -0500
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB6B120873;
        Tue, 27 Nov 2018 22:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543359105;
        bh=7ks0Z5a4qG0YPKLmL7FSHpy6vSPf16HXs/hKveqSqkc=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=fQoW4lE99X61DGhmCOKkVMg/xvx9+nGvubQUGKmxuGVBQsAwadW+QzcSzv7/Dgi6p
         KJgc6QqITLd/1jAkQuK6iIjGZ3iuXSTe1s0B72V65pUaKglFhL1JZL7Yi4HM39DNel
         b+pihFX9GcidOHZJXhqgWnJzpRtywbndqWiolgwc=
Date:   Tue, 27 Nov 2018 14:51:42 -0800 (PST)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-X260
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
cc:     Stefano Stabellini <sstabellini@kernel.org>,
        PanBian <bianpan2016@163.com>, Juergen Gross <jgross@suse.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Subject: Re: [Xen-devel] [PATCH] pvcalls-front: fixes incorrect error
 handling
In-Reply-To: <f4835c65-33f9-9076-1d36-9aad7cd39885@oracle.com>
Message-ID: <alpine.DEB.2.10.1811271451140.4577@sstabellini-ThinkPad-X260>
References: <1542852432-30019-1-git-send-email-bianpan2016@163.com> <1f765e81-ed89-d110-74b1-cc8029a4555f@oracle.com> <20181127005823.GB125510@bp> <alpine.DEB.2.10.1811271233550.4577@sstabellini-ThinkPad-X260> <0af126ad-1a74-e4c7-d74f-658a46757b9d@oracle.com>
 <alpine.DEB.2.10.1811271307020.4577@sstabellini-ThinkPad-X260> <f4835c65-33f9-9076-1d36-9aad7cd39885@oracle.com>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Nov 2018, Boris Ostrovsky wrote:
> On 11/27/18 4:08 PM, Stefano Stabellini wrote:
> > On Tue, 27 Nov 2018, Boris Ostrovsky wrote:
> >> On 11/27/18 3:37 PM, Stefano Stabellini wrote:
> >>> On Tue, 27 Nov 2018, PanBian wrote:
> >>>> On Mon, Nov 26, 2018 at 03:31:39PM -0500, Boris Ostrovsky wrote:
> >>>>> On 11/21/18 9:07 PM, Pan Bian wrote:
> >>>>>> kfree() is incorrectly used to release the pages allocated by
> >>>>>> __get_free_page() and __get_free_pages(). Use the matching deallocators
> >>>>>> i.e., free_page() and free_pages(), respectively.
> >>>>>>
> >>>>>> Signed-off-by: Pan Bian <bianpan2016@163.com>
> >>>>>> ---
> >>>>>>  drivers/xen/pvcalls-front.c | 4 ++--
> >>>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>>>>>
> >>>>>> diff --git a/drivers/xen/pvcalls-front.c b/drivers/xen/pvcalls-front.c
> >>>>>> index 2f11ca7..77224d8 100644
> >>>>>> --- a/drivers/xen/pvcalls-front.c
> >>>>>> +++ b/drivers/xen/pvcalls-front.c
> >>>>>> @@ -385,8 +385,8 @@ static int create_active(struct sock_mapping *map, int *evtchn)
> >>>>>>  out_error:
> >>>>>>  	if (*evtchn >= 0)
> >>>>>>  		xenbus_free_evtchn(pvcalls_front_dev, *evtchn);
> >>>>>> -	kfree(map->active.data.in);
> >>>>>> -	kfree(map->active.ring);
> >>>>>> +	free_pages((unsigned long)map->active.data.in, PVCALLS_RING_ORDER);
> >>>>> Is map->active.data.in guaranteed to be NULL when entering this routine?
> >>>> I am not sure yet. Sorry for that. I observed the mismatches between
> >>>> __get_free_page and kfree, and submitted the patch.
> >>>>
> >>>> But I think your consideration is reasonable. A better solution is to
> >>>> directly free bytes, a local variable that holds __get_free_pages return
> >>>> value. If you agree, I will rewrite the patch.
> >>> Like Boris said, map->active.ring and map->active.data.in are not
> >>> guaranteed to be NULL or != NULL here. For instance,map->active.ring can
> >>> be != NULL and map->active.data.in can be NULL. However, free_pages and
> >>> free_page should be able to cope with it, the same way that kfree is
> >>> able to cope with it?
> >> If map->active.data.in can be non-NULL on entry to this routine then I
> >> think this has been a problem all along. Pan's suggestion to use bytes
> >> for freeing is going to solve this (assuming bytes will be initialized
> >> to NULL).
> > Why is it a problem? map->active.data.in and map->active.ring are only
> > != NULL if they need to be freed. Otherwise, they are NULL. 
> 
> That was my question --- I wasn't sure about it, and I read your
> previous message as if it was possible to be calling create_active()
> with map->active.data.in pointing somewhere non-NULL.
> 
> If it is NULL *upon entry* to calling_create() then Pan's original patch
> is fine.

Right, I think it is fine too.

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>

 
> > All structs
> > are always initialized to zero. I don't think there are any issues.
> 
