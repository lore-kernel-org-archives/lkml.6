Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A34C04AB8
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 01:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC09620861
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 01:53:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC09620861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbeINHFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 03:05:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34238 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726771AbeINHFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 03:05:03 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 30B6B83F4C;
        Fri, 14 Sep 2018 01:52:57 +0000 (UTC)
Received: from ming.t460p (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5FD6760BE0;
        Fri, 14 Sep 2018 01:52:42 +0000 (UTC)
Date:   Fri, 14 Sep 2018 09:52:38 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <Bart.VanAssche@wdc.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stanislav Nijnikov <stanislav.nijnikov@wdc.com>,
        Evan Green <evgreen@chromium.org>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        Janek Kotas <jank@cadence.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        Sayali Lokhande <sayalil@codeaurora.org>,
        Li Wei <liwei213@huawei.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Alex Lemberg <Alex.Lemberg@sandisk.com>
Subject: Re: [PATCH RFC] scsi: ufs: Disable blk-mq for now
Message-ID: <20180914015237.GC11059@ming.t460p>
References: <20180913112848.7807-1-adrian.hunter@intel.com>
 <20180913120459.GA4965@ming.t460p>
 <e4d0c716-006a-72cb-0240-4ae5749b21b8@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4d0c716-006a-72cb-0240-4ae5749b21b8@intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Fri, 14 Sep 2018 01:52:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 03:15:39PM +0300, Adrian Hunter wrote:
> On 13/09/18 15:05, Ming Lei wrote:
> > On Thu, Sep 13, 2018 at 02:28:48PM +0300, Adrian Hunter wrote:
> >> blk-mq does not support runtime pm, so disable blk-mq support for now.
> > 
> > So could you describe a bit what the issue you are trying to fix?
> 
> UFS is a low-power solution, so we must be able to runtime suspend.
> 
> > 
> > This is host level runtime PM you are trying to address, and if blk-mq
> > runtime isn't enabled, I guess the host won't be runtime suspended at all
> > because some of its descendant are always active.
> > 
> > So seems we need to do nothing for preventing the host controller from
> > entering runtime suspend.
> 
> We don't want to prevent the host controller from runtime suspending, quite
> the opposite.

OK, got it.

However, in previous discussion, it is strongly objected to use
per-driver/device .use_blk_mq switch, so not sure if this way can
be accepted.

BTW, I just posted the runtime PM enablement patches[1] for blk-mq,
and I verified that it works fine and passed blktests & xfstest & my
other sanity tests, could you try it on UFS?

[1] https://marc.info/?l=linux-block&m=153684095523409&w=2

Thanks,
Ming
