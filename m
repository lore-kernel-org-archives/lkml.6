Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30212C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08B0020660
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:51:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729280AbfAJOvh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 09:51:37 -0500
Received: from mga02.intel.com ([134.134.136.20]:42685 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729033AbfAJOvh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 09:51:37 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2019 06:51:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,461,1539673200"; 
   d="scan'208";a="117075565"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga003.jf.intel.com with ESMTP; 10 Jan 2019 06:51:35 -0800
Date:   Thu, 10 Jan 2019 07:50:08 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Yao HongBo <yaohongbo@huawei.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "wangxiongfeng2@huawei.com" <wangxiongfeng2@huawei.com>,
        "guohanjun@huawei.com" <guohanjun@huawei.com>,
        "huawei.libin@huawei.com" <huawei.libin@huawei.com>,
        "thunder.leizhen@huawei.com" <thunder.leizhen@huawei.com>,
        "tanxiaojun@huawei.com" <tanxiaojun@huawei.com>,
        "xiexiuqi@huawei.com" <xiexiuqi@huawei.com>,
        "yangyingliang@huawei.com" <yangyingliang@huawei.com>,
        "cj.chengjian@huawei.com" <cj.chengjian@huawei.com>,
        "wxf.wang@hisilicon.com" <wxf.wang@hisilicon.com>,
        "axboe@fb.com" <axboe@fb.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvme: fix out of bounds access in nvme_cqe_pending
Message-ID: <20190110145008.GA21095@localhost.localdomain>
References: <1546827727-49635-1-git-send-email-yaohongbo@huawei.com>
 <20190109183920.GA22070@lst.de>
 <991b5090-adf7-78e1-ae19-0df94566c212@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <991b5090-adf7-78e1-ae19-0df94566c212@huawei.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 05:54:59PM -0800, Yao HongBo wrote:
> On 1/10/2019 2:39 AM, Christoph Hellwig wrote:
> > On Mon, Jan 07, 2019 at 10:22:07AM +0800, Hongbo Yao wrote:
> >> There is an out of bounds array access in nvme_cqe_peding().
> >>
> >> When enable irq_thread for nvme interrupt, there is racing between the
> >> nvmeq->cq_head updating and reading.
> > 
> > Just curious: why did you enable this option?  Do you have a workload
> > where it matters?
> 
> Yes, there were a lot of hard interrupts reported when reading the nvme disk,
> the OS can not schedule and result in the soft lockup.so i enabled the irq_thread.

That seems a little unusual. We should be able to handle as many
interrupts as an nvme drive can send.
