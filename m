Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD76C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 19:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D09D226A69
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 19:13:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D09D226A69
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753065AbeFZTNv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 15:13:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51894 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751155AbeFZTNt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 15:13:49 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E67D368800;
        Tue, 26 Jun 2018 19:13:48 +0000 (UTC)
Received: from localhost (unknown [10.18.25.149])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C28DC1C661;
        Tue, 26 Jun 2018 19:13:46 +0000 (UTC)
Date:   Tue, 26 Jun 2018 15:13:46 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ross Zwisler <ross.zwisler@linux.intel.com>,
        Toshi Kani <toshi.kani@hpe.com>,
        device-mapper development <dm-devel@redhat.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] pmem: only set QUEUE_FLAG_DAX for fsdax mode
Message-ID: <20180626191346.GA7233@redhat.com>
References: <20180626175932.8899-1-ross.zwisler@linux.intel.com>
 <20180626175932.8899-2-ross.zwisler@linux.intel.com>
 <CAPcyv4iWgPnHmBKhUvhManC6UL9CkLqN_d8vBo6KmcPJdPzuUw@mail.gmail.com>
 <20180626185830.GA7171@redhat.com>
 <CAPcyv4h6HO6fs6k7QMD77jkz2djCeWCtWomCdNb0-1Q4VKanqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4h6HO6fs6k7QMD77jkz2djCeWCtWomCdNb0-1Q4VKanqw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 26 Jun 2018 19:13:49 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 26 Jun 2018 19:13:49 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'msnitzer@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26 2018 at  3:07pm -0400,
Dan Williams <dan.j.williams@intel.com> wrote:

> On Tue, Jun 26, 2018 at 11:58 AM, Mike Snitzer <snitzer@redhat.com> wrote:
> > On Tue, Jun 26 2018 at  2:52pm -0400,
> > Dan Williams <dan.j.williams@intel.com> wrote:
> >
> >> On Tue, Jun 26, 2018 at 10:59 AM, Ross Zwisler
> >> <ross.zwisler@linux.intel.com> wrote:
> >> > QUEUE_FLAG_DAX is an indication that a given block device supports
> >> > filesystem DAX and should not be set for PMEM namespaces which are in "raw"
> >> > or "sector" modes.  These namespaces lack struct page and are prevented
> >> > from participating in filesystem DAX.
> >> >
> >> > Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
> >> > Suggested-by: Mike Snitzer <snitzer@redhat.com>
> >> > Cc: stable@vger.kernel.org
> >>
> >> Why is this cc: stable? What is the user visible impact of this change
> >> especially given the requirement to validate QUEUE_FLAG_DAX with
> >> bdev_dax_supported()? Patch looks good, but it's just a cosmetic fixup
> >> afaics.
> >
> > This isn't cosmetic when you consider that stacking up a DM device is
> > looking at this flag to determine whether a table does or does _not_
> > support DAX.
> >
> > So this patch, in conjunction with the other changes in the series, is
> > certainly something I'd consider appropriate for stable.
> 
> I think this classifies as something that never worked correctly and
> is not a regression. It does not identify which commit it is repairing
> or the user visible failure mode.

So you're taking issue with making stacked dax configs work in older
kernels?  That's fine.  We can drop the stable cc if you like.

But I mean we intended for this to work.. so the Fixes commit references
can easily be added, e.g.: 545ed20e6df68a4d2584a29a2a28ee8b2f7e9547
("dm: add infrastructure for DAX support")
