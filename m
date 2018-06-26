Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD08C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 14:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 499B226CB0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 14:57:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 499B226CB0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751503AbeFZO5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 10:57:44 -0400
Received: from mga18.intel.com ([134.134.136.126]:62714 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751428AbeFZO5n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 10:57:43 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2018 07:57:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,274,1526367600"; 
   d="scan'208";a="62326894"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.44])
  by orsmga003.jf.intel.com with ESMTP; 26 Jun 2018 07:57:42 -0700
Date:   Tue, 26 Jun 2018 09:01:06 -0600
From:   Keith Busch <keith.busch@linux.intel.com>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <keith.busch@intel.com>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme: trace: add disk name to tracepoints
Message-ID: <20180626150106.GB6628@localhost.localdomain>
References: <20180626135141.14088-1-jthumshirn@suse.de>
 <20180626135141.14088-3-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626135141.14088-3-jthumshirn@suse.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 03:51:41PM +0200, Johannes Thumshirn wrote:
> @@ -655,9 +655,9 @@ blk_status_t nvme_setup_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
>  	cmd->common.command_id = req->tag;
>  	nvme_req(req)->ctrl = ctrl;
>  	if (ns)
> -		trace_nvme_setup_nvm_cmd(req->q->id, cmd);
> +		trace_nvme_setup_nvm_cmd(req, cmd, ns->disk->disk_name);

Not related to your patch, but I did notice that the req->q->id isn't
really useful here since that's not the hardware context identifier.
That's just some ida assigned software identifier. For the admin command
completion trace, it's actually a little confusing to see the qid in the
trace.
