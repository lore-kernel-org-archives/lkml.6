Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08243C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACFB120661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:36:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACFB120661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030221AbeFSQgp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 12:36:45 -0400
Received: from mga09.intel.com ([134.134.136.24]:36110 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966956AbeFSQgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 12:36:44 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jun 2018 09:36:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,243,1526367600"; 
   d="scan'208";a="64539481"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.44])
  by fmsmga004.fm.intel.com with ESMTP; 19 Jun 2018 09:36:42 -0700
Date:   Tue, 19 Jun 2018 10:39:52 -0600
From:   Keith Busch <keith.busch@linux.intel.com>
To:     Jianchao Wang <jianchao.w.wang@oracle.com>
Cc:     keith.busch@intel.com, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-pci: not invoke nvme_remove_dead_ctrl when change
 state fails
Message-ID: <20180619163952.GE19922@localhost.localdomain>
References: <1529397050-7524-1-git-send-email-jianchao.w.wang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529397050-7524-1-git-send-email-jianchao.w.wang@oracle.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 04:30:50PM +0800, Jianchao Wang wrote:
> There is race between nvme_remove and nvme_reset_work that can
> lead to io hang.
> 
> nvme_remove                    nvme_reset_work
> -> change state to DELETING
>                                -> fail to change state to LIVE
>                                -> nvme_remove_dead_ctrl
>                                  -> nvme_dev_disable
>                                    -> quiesce request_queue
>                                  -> queue remove_work
> -> cancel_work_sync reset_work
> -> nvme_remove_namespaces
>   -> splice ctrl->namespaces
>                                nvme_remove_dead_ctrl_work
>                                -> nvme_kill_queues
>   -> nvme_ns_remove               do nothing
>     -> blk_cleanup_queue
>       -> blk_freeze_queue
> Finally, the request_queue is quiesced state when wait freeze,
> we will get io hang here.
> 
> In fact, when fails to change state in nvme_reset_work, the only
> reason is someone has changed state to DELETING. So it is not
> necessary to invoke nvme_remove_dead_ctrl in that case.
> 
> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>

Good catch. I think the fix should either have the nvme_dev_disable set
shutdown to true to indicate the controller isn't coming back online, or
move the nvme_kill_queues inside nvme_remove_dead_ctrl.
