Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8F8C282D7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 989D0222A0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731920AbfBKRg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 12:36:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39634 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726243AbfBKRg6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 12:36:58 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2159DB650;
        Mon, 11 Feb 2019 17:36:58 +0000 (UTC)
Received: from redhat.com (ovpn-120-40.rdu2.redhat.com [10.10.120.40])
        by smtp.corp.redhat.com (Postfix) with SMTP id 163AE1850E;
        Mon, 11 Feb 2019 17:36:55 +0000 (UTC)
Date:   Mon, 11 Feb 2019 12:36:55 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc:     Alexander Duyck <alexander.duyck@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        rkrcmar@redhat.com, x86@kernel.org, mingo@redhat.com, bp@alien8.de,
        hpa@zytor.com, pbonzini@redhat.com, tglx@linutronix.de,
        akpm@linux-foundation.org
Subject: Re: [RFC PATCH 2/4] kvm: Add host side support for free memory hints
Message-ID: <20190211123638-mutt-send-email-mst@kernel.org>
References: <20190204181118.12095.38300.stgit@localhost.localdomain>
 <20190204181546.12095.81356.stgit@localhost.localdomain>
 <20190209194108-mutt-send-email-mst@kernel.org>
 <96285ed154dbb92686ca0068e21f5e0500bb1ce7.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96285ed154dbb92686ca0068e21f5e0500bb1ce7.camel@linux.intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Mon, 11 Feb 2019 17:36:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 09:34:25AM -0800, Alexander Duyck wrote:
> On Sat, 2019-02-09 at 19:44 -0500, Michael S. Tsirkin wrote:
> > On Mon, Feb 04, 2019 at 10:15:46AM -0800, Alexander Duyck wrote:
> > > From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > > 
> > > Add the host side of the KVM memory hinting support. With this we expose a
> > > feature bit indicating that the host will pass the messages along to the
> > > new madvise function.
> > > 
> > > This functionality is mutually exclusive with device assignment. If a
> > > device is assigned we will disable the functionality as it could lead to a
> > > potential memory corruption if a device writes to a page after KVM has
> > > flagged it as not being used.
> > 
> > I really dislike this kind of tie-in.
> > 
> > Yes right now assignment is not smart enough but generally
> > you can protect the unused page in the IOMMU and that's it,
> > it's safe.
> > 
> > So the policy should not leak into host/guest interface.
> > Instead it is better to just keep the pages pinned and
> > ignore the hint for now.
> 
> Okay, I can do that. It also gives me a means of benchmarking just the
> hypercall cost versus the extra page faults and zeroing.

Good point. Same goes for poisoning :)
