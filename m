Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7133DC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 19:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3544E26EAB
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 19:11:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3544E26EAB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755101AbeFZTLe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 15:11:34 -0400
Received: from mga03.intel.com ([134.134.136.65]:46039 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752676AbeFZTLb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 15:11:31 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2018 12:11:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,275,1526367600"; 
   d="scan'208";a="53099568"
Received: from theros.lm.intel.com (HELO linux.intel.com) ([10.232.112.164])
  by orsmga006.jf.intel.com with ESMTP; 26 Jun 2018 12:11:29 -0700
Date:   Tue, 26 Jun 2018 13:11:29 -0600
From:   Ross Zwisler <ross.zwisler@linux.intel.com>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Toshi Kani <toshi.kani@hpe.com>,
        device-mapper development <dm-devel@redhat.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] pmem: only set QUEUE_FLAG_DAX for fsdax mode
Message-ID: <20180626191129.GA18273@linux.intel.com>
Mail-Followup-To: Ross Zwisler <ross.zwisler@linux.intel.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Toshi Kani <toshi.kani@hpe.com>,
        device-mapper development <dm-devel@redhat.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <20180626175932.8899-1-ross.zwisler@linux.intel.com>
 <20180626175932.8899-2-ross.zwisler@linux.intel.com>
 <CAPcyv4iWgPnHmBKhUvhManC6UL9CkLqN_d8vBo6KmcPJdPzuUw@mail.gmail.com>
 <20180626185830.GA7171@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626185830.GA7171@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 02:58:30PM -0400, Mike Snitzer wrote:
> On Tue, Jun 26 2018 at  2:52pm -0400,
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > On Tue, Jun 26, 2018 at 10:59 AM, Ross Zwisler
> > <ross.zwisler@linux.intel.com> wrote:
> > > QUEUE_FLAG_DAX is an indication that a given block device supports
> > > filesystem DAX and should not be set for PMEM namespaces which are in "raw"
> > > or "sector" modes.  These namespaces lack struct page and are prevented
> > > from participating in filesystem DAX.
> > >
> > > Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
> > > Suggested-by: Mike Snitzer <snitzer@redhat.com>
> > > Cc: stable@vger.kernel.org
> > 
> > Why is this cc: stable? What is the user visible impact of this change
> > especially given the requirement to validate QUEUE_FLAG_DAX with
> > bdev_dax_supported()? Patch looks good, but it's just a cosmetic fixup
> > afaics.
> 
> This isn't cosmetic when you consider that stacking up a DM device is
> looking at this flag to determine whether a table does or does _not_
> support DAX.
> 
> So this patch, in conjunction with the other changes in the series, is
> certainly something I'd consider appropriate for stable.
> 
> Mike

Because in patch 3 of this series we now use the full bdev_dax_supported()
instead of just checking the queue flag in device_supports_dax(), I agree that
this isn't strictly necessary for stable.  device_supports_dax() will still
notice that the raw/sector namespaces don't support DAX because
bdev_dax_supported() will fail, and we'll end up doing the right thing and not
setting QUEUE_FLAG_DAX on the DM device.

I think maybe it's good to have in stable for completeness (and it's a very
small change), but if we drop it from stable the code will still do the right
thing AFAICT.
