Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09ED6C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE4CE20839
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:27:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE4CE20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbeIFB7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 21:59:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43670 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727257AbeIFB7Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 21:59:16 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6246640216F7;
        Wed,  5 Sep 2018 21:27:14 +0000 (UTC)
Received: from ming.t460p (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 210D52027EA0;
        Wed,  5 Sep 2018 21:27:05 +0000 (UTC)
Date:   Thu, 6 Sep 2018 05:27:00 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jianchao Wang <jianchao.w.wang@oracle.com>
Cc:     axboe@kernel.dk, bart.vanassche@wdc.com, sagi@grimberg.me,
        keith.busch@intel.com, jthumshirn@suse.de, jsmart2021@gmail.com,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 0/3] Introduce a light-weight queue close feature
Message-ID: <20180905212659.GB21352@ming.t460p>
References: <1536120586-3378-1-git-send-email-jianchao.w.wang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536120586-3378-1-git-send-email-jianchao.w.wang@oracle.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 05 Sep 2018 21:27:14 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 05 Sep 2018 21:27:14 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'ming.lei@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 12:09:43PM +0800, Jianchao Wang wrote:
> Dear all
> 
> As we know, queue freeze is used to stop new IO comming in and drain
> the request queue. And the draining queue here is necessary, because
> queue freeze kills the percpu-ref q_usage_counter and need to drain
> the q_usage_counter before switch it back to percpu mode. This could
> be a trouble when we just want to prevent new IO.
> 
> In nvme-pci, nvme_dev_disable freezes queues to prevent new IO.
> nvme_reset_work will unfreeze and wait to drain the queues. However,
> if IO timeout at the moment, no body could do recovery as nvme_reset_work
> is waiting. We will encounter IO hang.

As we discussed this nvme time issue before, I have pointed out that
this is because of blk_mq_unfreeze_queue()'s limit which requires that
unfreeze can only be done when this queue ref counter drops to zero.

For this nvme timeout case, we may relax the limit, for example,
introducing another API of blk_freeze_queue_stop() as counter-pair of
blk_freeze_queue_start(), and simply switch the percpu-ref to percpu mode
from atomic mode inside the new API.

> 
> So introduce a light-weight queue close feature in this patch set
> which could prevent new IO and needn't drain the queue.

Frankly speaking, IMO, it may not be an good idea to mess up the fast path
just for handling the extremely unusual timeout event. The same is true
for doing the preemp only stuff, as you saw I have posted patchset for
killing it.

Thanks,
Ming
