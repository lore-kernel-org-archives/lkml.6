Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B249C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 20:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ABF62083F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 20:22:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ABF62083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbeIAAb6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 20:31:58 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52492 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727228AbeIAAb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 20:31:58 -0400
Received: from localhost (unknown [72.28.92.217])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6F4E2D23;
        Fri, 31 Aug 2018 20:22:52 +0000 (UTC)
Date:   Fri, 31 Aug 2018 13:22:50 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Greg Hackmann <ghackmann@google.com>
Cc:     Greg Hackmann <ghackmann@android.com>,
        linux-kernel@vger.kernel.org, Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        devel@driverdev.osuosl.org, kernel-team@android.com,
        stable@vger.kernel.org
Subject: Re: [PATCH] staging: android: ion: fix ION_IOC_{MAP,SHARE}
 use-after-free
Message-ID: <20180831202250.GB30176@kroah.com>
References: <20180831200627.59712-1-ghackmann@google.com>
 <20180831201232.GA23559@kroah.com>
 <c41f1a53-7aa1-e0e3-58eb-8c1f3d34e14d@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c41f1a53-7aa1-e0e3-58eb-8c1f3d34e14d@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 01:17:20PM -0700, Greg Hackmann wrote:
> On 08/31/2018 01:12 PM, Greg Kroah-Hartman wrote:
> > On Fri, Aug 31, 2018 at 01:06:27PM -0700, Greg Hackmann wrote:
> >> The ION_IOC_{MAP,SHARE} ioctls drop and reacquire client->lock several
> >> times while operating on one of the client's ion_handles.  This creates
> >> windows where userspace can call ION_IOC_FREE on the same client with
> >> the same handle, and effectively make the kernel drop its own reference.
> >> For example:
> >>
> >> - thread A: ION_IOC_ALLOC creates an ion_handle with refcount 1
> >> - thread A: starts ION_IOC_MAP and increments the refcount to 2
> >> - thread B: ION_IOC_FREE decrements the refcount to 1
> >> - thread B: ION_IOC_FREE decrements the refcount to 0 and frees the
> >>             handle
> >> - thread A: continues ION_IOC_MAP with a dangling ion_handle * to
> >>             freed memory
> >>
> >> Fix this by holding client->lock for the duration of
> >> ION_IOC_{MAP,SHARE}, preventing the concurrent ION_IOC_FREE.  Also
> >> remove ion_handle_get_by_id(), since there's literally no way to use it
> >> safely.
> >>
> >> This patch is applied on top of 4.9.y.  Kernels 4.12 and later are
> >> unaffected, since all the underlying ion_handle infrastructure has been
> >> ripped out.
> > 
> > Does 4.4.y or older also need this?  If so, can you send backports, as
> > this one does not apply there.
> > 
> > thanks,
> > 
> > greg k-h
> > 
> 
> Yes, 4.4.y and older will need this.  If there are no objections to this
> patch, I'll send backports ASAP.

None from me, thanks!

greg k-h
