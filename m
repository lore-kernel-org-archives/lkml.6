Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56716C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 040C321A29
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:36:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 040C321A29
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729728AbeHFPp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 11:45:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58924 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727582AbeHFPp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 11:45:57 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DA99A8198B03;
        Mon,  6 Aug 2018 13:36:47 +0000 (UTC)
Received: from redhat.com (unknown [10.36.118.7])
        by smtp.corp.redhat.com (Postfix) with SMTP id 29A49101041D;
        Mon,  6 Aug 2018 13:36:44 +0000 (UTC)
Date:   Mon, 6 Aug 2018 16:36:43 +0300
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>, robh@kernel.org,
        srikar@linux.vnet.ibm.com, aik@ozlabs.ru,
        Jason Wang <jasowang@redhat.com>, linuxram@us.ibm.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, hch@infradead.org,
        paulus@samba.org, joe@perches.com, david@gibson.dropbear.id.au,
        linuxppc-dev@lists.ozlabs.org, elfring@users.sourceforge.net,
        haren@linux.vnet.ibm.com
Subject: Re: [RFC 0/4] Virtio uses DMA API for all devices
Message-ID: <20180806163440-mutt-send-email-mst@kernel.org>
References: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
 <20180802235332-mutt-send-email-mst@kernel.org>
 <b31d2162-884c-0ed4-00df-e7debe0cc0e7@redhat.com>
 <20180803220812-mutt-send-email-mst@kernel.org>
 <01c74680c4b3aa25d9b4375a9ab5e10046b7c71b.camel@kernel.crashing.org>
 <20180805032355-mutt-send-email-mst@kernel.org>
 <74a1e1b8-81e0-84db-6d0d-d8bd9caebb4a@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74a1e1b8-81e0-84db-6d0d-d8bd9caebb4a@linux.vnet.ibm.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 06 Aug 2018 13:36:48 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 06 Aug 2018 13:36:48 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mst@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2018 at 02:32:28PM +0530, Anshuman Khandual wrote:
> On 08/05/2018 05:54 AM, Michael S. Tsirkin wrote:
> > On Fri, Aug 03, 2018 at 08:21:26PM -0500, Benjamin Herrenschmidt wrote:
> >> On Fri, 2018-08-03 at 22:08 +0300, Michael S. Tsirkin wrote:
> >>>>>> Please go through these patches and review whether this approach broadly
> >>>>>> makes sense. I will appreciate suggestions, inputs, comments regarding
> >>>>>> the patches or the approach in general. Thank you.
> >>>>>
> >>>>> Jason did some work on profiling this. Unfortunately he reports
> >>>>> about 4% extra overhead from this switch on x86 with no vIOMMU.
> >>>>
> >>>> The test is rather simple, just run pktgen (pktgen_sample01_simple.sh) in
> >>>> guest and measure PPS on tap on host.
> >>>>
> >>>> Thanks
> >>>
> >>> Could you supply host configuration involved please?
> >>
> >> I wonder how much of that could be caused by Spectre mitigations
> >> blowing up indirect function calls...
> >>
> >> Cheers,
> >> Ben.
> > 
> > I won't be surprised. If yes I suggested a way to mitigate the overhead.
> 
> Did we get better results (lower regression due to indirect calls) with
> the suggested mitigation ? Just curious.

I'm referring to this:
	I wonder whether we can support map_sg and friends being NULL, then use
	that when mapping is an identity. A conditional branch there is likely
	very cheap.

I don't think anyone tried implementing this yes.

-- 
MST
