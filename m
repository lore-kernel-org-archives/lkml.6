Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF91C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 15:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 576EA20C01
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 15:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbfBYPi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 10:38:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:48658 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727505AbfBYPi3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 10:38:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 49567AFBC;
        Mon, 25 Feb 2019 15:38:28 +0000 (UTC)
Date:   Mon, 25 Feb 2019 16:38:27 +0100
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Max Gurtovoy <maxg@mellanox.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvmet: disable direct I/O when unavailable
Message-ID: <20190225153827.GA17442@linux-x5ow.site>
References: <20190221182234.22345-1-jthumshirn@suse.de>
 <SN6PR04MB4527A810D247541AA7C4A512867F0@SN6PR04MB4527.namprd04.prod.outlook.com>
 <6c3fa30a-d516-a453-a001-1014202ff9ce@suse.de>
 <9d8e96de-d68d-8961-21e8-4cb8e79b4a08@mellanox.com>
 <2185e4e5-086a-d0c2-0fee-a7a5c98267bb@suse.de>
 <a85e85d6-6a06-7663-3a12-710b6467dedd@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a85e85d6-6a06-7663-3a12-710b6467dedd@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 06:49:04AM -0800, Bart Van Assche wrote:
> On 2/25/19 1:37 AM, Johannes Thumshirn wrote:
> > On 24/02/2019 11:54, Max Gurtovoy wrote:
> > > What is the status of iSCSI/SRP targets in this case ?
> > 
> > iSCSI/SRP passes in the following:
> > 
> >   /*
> >    * Use O_DSYNC by default instead of O_SYNC to forgo syncing
> >    * of pure timestamp updates.
> >    */
> >   flags = O_RDWR | O_CREAT | O_LARGEFILE | O_DSYNC;
> 
> That code fragment comes from the LIO file backend. There is no requirement
> for a SCSI target core file backend to use O_DSYNC. SCST allows users to
> choose whether or not O_DSYNC should be used:

Yes, LIO file backend is the in-tree equivalent to NVMe's file backend. That's
why I copied it here.


> 
> 	if (virt_dev->wt_flag && !virt_dev->nv_cache)
> 		open_flags |= O_DSYNC;
> 

OK. Do your open_flags include O_DIRECT per default as well?

Byte,
	Johannes
-- 
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
