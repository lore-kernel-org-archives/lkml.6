Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795B1C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 16:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17C6024563
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 16:33:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17C6024563
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934996AbeF0Qdq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 12:33:46 -0400
Received: from mga14.intel.com ([192.55.52.115]:20315 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934318AbeF0Qdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 12:33:44 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jun 2018 09:33:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,279,1526367600"; 
   d="scan'208";a="50992590"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.44])
  by fmsmga008.fm.intel.com with ESMTP; 27 Jun 2018 09:33:40 -0700
Date:   Wed, 27 Jun 2018 10:37:06 -0600
From:   Keith Busch <keith.busch@linux.intel.com>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <keith.busch@intel.com>,
        James Smart <james.smart@broadcom.com>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v5 2/2] nvme: trace: add disk name to tracepoints
Message-ID: <20180627163706.GA9361@localhost.localdomain>
References: <20180627125324.22064-1-jthumshirn@suse.de>
 <20180627125324.22064-3-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627125324.22064-3-jthumshirn@suse.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 02:53:24PM +0200, Johannes Thumshirn wrote:
>  	    TP_fast_assign(
> -		    __entry->qid = qid;
> +		    __assign_str(name, disk_name);
> +		    __entry->ctrl_id = nvme_req(req)->ctrl->cntlid;
> +		    __entry->qid = req->q->id;
>  		    __entry->opcode = cmd->common.opcode;
>  		    __entry->flags = cmd->common.flags;
>  		    __entry->cid = cmd->common.command_id;
> @@ -122,10 +130,10 @@ TRACE_EVENT(nvme_setup_nvm_cmd,
>  		    memcpy(__entry->cdw10, cmd->common.cdw10,
>  			   sizeof(__entry->cdw10));
>  	    ),
> -	    TP_printk("qid=%d, nsid=%u, cmdid=%u, flags=0x%x, meta=0x%llx, cmd=(%s %s)",
> -		      __entry->qid, __entry->nsid, __entry->cid,
> -		      __entry->flags, __entry->metadata,
> -		      show_opcode_name(__entry->opcode),
> +	    TP_printk("nvme%d: disk=%s, qid=%d, nsid=%u, cmdid=%u, flags=0x%x, meta=0x%llx, cmd=(%s %s)",
> +		      __entry->ctrl_id, __get_str(name), __entry->qid,
> +		      __entry->nsid, __entry->cid, __entry->flags,
> +		      __entry->metadata, show_opcode_name(__entry->opcode),
>  		      __parse_nvme_cmd(__entry->opcode, __entry->cdw10))
>  );

This looks a bit confusing to me. The ctrl->cntlid you're using in
__entry->ctrl_id isn't a unique value across subsystems, and it will
typically be 0 for all controllers that are the only controller in
their subsystem.

It looks like you want the # assigned to /dev/nvme<#>. Do you want to
use ctrl->instance here instead?
