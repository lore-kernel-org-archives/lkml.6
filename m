Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBDCEC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D77B2444F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:01:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D77B2444F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933572AbeFVPBU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 11:01:20 -0400
Received: from verein.lst.de ([213.95.11.211]:57019 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932950AbeFVPBS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 11:01:18 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id F400268E45; Fri, 22 Jun 2018 17:10:43 +0200 (CEST)
Date:   Fri, 22 Jun 2018 17:10:43 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>, axboe@kernel.dk,
        martin.petersen@oracle.com, josef@toxicpanda.com,
        ulf.hansson@linaro.org, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5]stop normal completion path entering a timeout req
Message-ID: <20180622151043.GA13470@lst.de>
References: <1529500964-28429-1-git-send-email-jianchao.w.wang@oracle.com> <20180620181601.GA24145@localhost.localdomain> <e87f5946-bb21-942e-2dcc-b24cee1ad23c@oracle.com> <20180621081900.GA5183@lst.de> <a68ad043-26a1-d3d8-2009-504ba4230e0f@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a68ad043-26a1-d3d8-2009-504ba4230e0f@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 04:22:22PM +0800, jianchao.wang wrote:
> > Trace, please.  With the latest kernel.  I'm not saying that there
> > is nothing to fix, but the mode of never completing once timeout
> > requests as currently done is SCSI is clearly broken.
> > 
> 
> I didn't find the existing method to simulate this.
> So I modified the scsi-debug as following patch as install it as following:
> modprobe scsi-debug delay=-1 ndelay=-1
> Both 4.17-rc1 and 4.18-rc1 with this patch set could survive from the test.

What tree is this against?  I can't apply it to either current Linus'
tree or 4.17 for that matter.

Also I'm not sure this blk_abort_request call is representative
of the real world.  Drivers do drain their queues before calling
it in general, e.g. take a look at ata_eh_set_pending for the
probably most common user.
