Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C087C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F285121B18
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731706AbfBKRe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 12:34:26 -0500
Received: from mga01.intel.com ([192.55.52.88]:49856 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727393AbfBKRe0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 12:34:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2019 09:34:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,359,1544515200"; 
   d="scan'208";a="117035838"
Received: from ahduyck-desk1.jf.intel.com ([10.7.198.76])
  by orsmga008.jf.intel.com with ESMTP; 11 Feb 2019 09:34:25 -0800
Message-ID: <96285ed154dbb92686ca0068e21f5e0500bb1ce7.camel@linux.intel.com>
Subject: Re: [RFC PATCH 2/4] kvm: Add host side support for free memory hints
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Alexander Duyck <alexander.duyck@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, rkrcmar@redhat.com, x86@kernel.org,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, pbonzini@redhat.com,
        tglx@linutronix.de, akpm@linux-foundation.org
Date:   Mon, 11 Feb 2019 09:34:25 -0800
In-Reply-To: <20190209194108-mutt-send-email-mst@kernel.org>
References: <20190204181118.12095.38300.stgit@localhost.localdomain>
         <20190204181546.12095.81356.stgit@localhost.localdomain>
         <20190209194108-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-02-09 at 19:44 -0500, Michael S. Tsirkin wrote:
> On Mon, Feb 04, 2019 at 10:15:46AM -0800, Alexander Duyck wrote:
> > From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > 
> > Add the host side of the KVM memory hinting support. With this we expose a
> > feature bit indicating that the host will pass the messages along to the
> > new madvise function.
> > 
> > This functionality is mutually exclusive with device assignment. If a
> > device is assigned we will disable the functionality as it could lead to a
> > potential memory corruption if a device writes to a page after KVM has
> > flagged it as not being used.
> 
> I really dislike this kind of tie-in.
> 
> Yes right now assignment is not smart enough but generally
> you can protect the unused page in the IOMMU and that's it,
> it's safe.
> 
> So the policy should not leak into host/guest interface.
> Instead it is better to just keep the pages pinned and
> ignore the hint for now.

Okay, I can do that. It also gives me a means of benchmarking just the
hypercall cost versus the extra page faults and zeroing.

