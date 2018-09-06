Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B56AC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AD6720844
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:07:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AD6720844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbeIFRmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:42:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43330 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728679AbeIFRmz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:42:55 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 82F98402277F;
        Thu,  6 Sep 2018 13:07:29 +0000 (UTC)
Received: from ming.t460p (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B329C2027EA0;
        Thu,  6 Sep 2018 13:07:21 +0000 (UTC)
Date:   Thu, 6 Sep 2018 21:07:16 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, jsmart2021@gmail.com,
        sagi@grimberg.me, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, keith.busch@intel.com,
        jthumshirn@suse.de, bart.vanassche@wdc.com
Subject: Re: [PATCH 3/3] nvme-pci: use queue close instead of queue freeze
Message-ID: <20180906130715.GB31250@ming.t460p>
References: <1536120586-3378-1-git-send-email-jianchao.w.wang@oracle.com>
 <1536120586-3378-4-git-send-email-jianchao.w.wang@oracle.com>
 <20180905220910.GC21352@ming.t460p>
 <8ba97c77-0c3b-75df-0259-3c97ef7b774e@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ba97c77-0c3b-75df-0259-3c97ef7b774e@oracle.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 06 Sep 2018 13:07:29 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 06 Sep 2018 13:07:29 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'ming.lei@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 09:28:46AM +0800, jianchao.wang wrote:
> Hi Ming
> 
> On 09/06/2018 06:09 AM, Ming Lei wrote:
> > nvme_dev_add() still may call freeze & unfreeze queue, so your patch
> > can't avoid draining queue completely here.
> 
> Yes, I know this. We still need to freeze queue when update nr_hw_queues.
> But we move forward a step at least. :)
> We don't need to drain request queue in normal case of nvme_reset_work.

It is hard to say who is the normal case. In case of CPU hotplug, it is quite
easy to trigger updating nr_hw_queues.

> 
> As for updating nr_hw_queues, we could try some other method on it next.

The thing is that draining queue may be inevitable inside reset work
function because of updating nr_hw_queues, that means the approach in
this patchset is just a partial solution

Or it may not make sense to do that because we may never remove the draining
queue in the code path of updating nr_hw_queues.

Given they belong to same issue, I suggest to solve them all.

Thanks,
Ming
