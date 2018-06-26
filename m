Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E0FC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 18:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6B1F26E82
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 18:58:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6B1F26E82
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752135AbeFZS6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 14:58:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49932 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750969AbeFZS6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 14:58:33 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A41A07A7E8;
        Tue, 26 Jun 2018 18:58:32 +0000 (UTC)
Received: from localhost (unknown [10.18.25.149])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D8B95111763E;
        Tue, 26 Jun 2018 18:58:30 +0000 (UTC)
Date:   Tue, 26 Jun 2018 14:58:30 -0400
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
Message-ID: <20180626185830.GA7171@redhat.com>
References: <20180626175932.8899-1-ross.zwisler@linux.intel.com>
 <20180626175932.8899-2-ross.zwisler@linux.intel.com>
 <CAPcyv4iWgPnHmBKhUvhManC6UL9CkLqN_d8vBo6KmcPJdPzuUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4iWgPnHmBKhUvhManC6UL9CkLqN_d8vBo6KmcPJdPzuUw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Tue, 26 Jun 2018 18:58:32 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Tue, 26 Jun 2018 18:58:32 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'msnitzer@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26 2018 at  2:52pm -0400,
Dan Williams <dan.j.williams@intel.com> wrote:

> On Tue, Jun 26, 2018 at 10:59 AM, Ross Zwisler
> <ross.zwisler@linux.intel.com> wrote:
> > QUEUE_FLAG_DAX is an indication that a given block device supports
> > filesystem DAX and should not be set for PMEM namespaces which are in "raw"
> > or "sector" modes.  These namespaces lack struct page and are prevented
> > from participating in filesystem DAX.
> >
> > Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
> > Suggested-by: Mike Snitzer <snitzer@redhat.com>
> > Cc: stable@vger.kernel.org
> 
> Why is this cc: stable? What is the user visible impact of this change
> especially given the requirement to validate QUEUE_FLAG_DAX with
> bdev_dax_supported()? Patch looks good, but it's just a cosmetic fixup
> afaics.

This isn't cosmetic when you consider that stacking up a DM device is
looking at this flag to determine whether a table does or does _not_
support DAX.

So this patch, in conjunction with the other changes in the series, is
certainly something I'd consider appropriate for stable.

Mike
