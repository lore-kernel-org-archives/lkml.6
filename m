Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 680EBC07E85
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 02:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3359120892
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 02:04:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3359120892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbeLHCEl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 21:04:41 -0500
Received: from mga18.intel.com ([134.134.136.126]:52044 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726077AbeLHCEk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 21:04:40 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Dec 2018 18:04:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,328,1539673200"; 
   d="scan'208";a="116640570"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga002.jf.intel.com with ESMTP; 07 Dec 2018 18:04:39 -0800
Date:   Fri, 7 Dec 2018 19:02:01 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Jaesoo Lee <jalee@purestorage.com>, axboe@fb.com, hch@lst.de,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Prabhath Sajeepa <psajeepa@purestorage.com>,
        Roland Dreier <roland@purestorage.com>,
        Ashish Karkare <ashishk@purestorage.com>
Subject: Re: [PATCH] nvme-rdma: complete requests from ->timeout
Message-ID: <20181208020201.GD21523@localhost.localdomain>
References: <1543535954-28073-1-git-send-email-jalee@purestorage.com>
 <cc7cbad6-0e7d-8328-c602-61d659c3a7de@grimberg.me>
 <CAJX3CtiBs6YOjkP5xGb5yPShvOdmhuD7kx-kBAVL7+YsyEGMyw@mail.gmail.com>
 <CAJX3CthC6KxH7ZtpSzEGGQTVUgKO6UVkjiMMBV6=OG__UVF43Q@mail.gmail.com>
 <2055d5b5-2c27-b5a2-e3a0-75146c7bd227@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2055d5b5-2c27-b5a2-e3a0-75146c7bd227@grimberg.me>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2018 at 12:05:37PM -0800, Sagi Grimberg wrote:
> 
> > Could you please take a look at this bug and code review?
> > 
> > We are seeing more instances of this bug and found that reconnect_work
> > could hang as well, as can be seen from below stacktrace.
> > 
> >   Workqueue: nvme-wq nvme_rdma_reconnect_ctrl_work [nvme_rdma]
> >   Call Trace:
> >   __schedule+0x2ab/0x880
> >   schedule+0x36/0x80
> >   schedule_timeout+0x161/0x300
> >   ? __next_timer_interrupt+0xe0/0xe0
> >   io_schedule_timeout+0x1e/0x50
> >   wait_for_completion_io_timeout+0x130/0x1a0
> >   ? wake_up_q+0x80/0x80
> >   blk_execute_rq+0x6e/0xa0
> >   __nvme_submit_sync_cmd+0x6e/0xe0
> >   nvmf_connect_admin_queue+0x128/0x190 [nvme_fabrics]
> >   ? wait_for_completion_interruptible_timeout+0x157/0x1b0
> >   nvme_rdma_start_queue+0x5e/0x90 [nvme_rdma]
> >   nvme_rdma_setup_ctrl+0x1b4/0x730 [nvme_rdma]
> >   nvme_rdma_reconnect_ctrl_work+0x27/0x70 [nvme_rdma]
> >   process_one_work+0x179/0x390
> >   worker_thread+0x4f/0x3e0
> >   kthread+0x105/0x140
> >   ? max_active_store+0x80/0x80
> >   ? kthread_bind+0x20/0x20
> > 
> > This bug is produced by setting MTU of RoCE interface to '568' for
> > test while running I/O traffics.
> 
> I think that with the latest changes from Keith we can no longer rely
> on blk-mq to barrier racing completions. We will probably need
> to barrier ourselves in nvme-rdma...

You really need to do that anyway. If you were relying on blk-mq to save
you from double completions by ending a request in the nvme driver while
the lower half can still complete the same one, the only thing preventing
data corruption is the probability the request wasn't reallocated for a
new command.
