Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D09DC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 06:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0D3A20862
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 06:16:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0D3A20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730038AbeGaHzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 03:55:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41146 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726824AbeGaHzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 03:55:12 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9D37C4021701;
        Tue, 31 Jul 2018 06:16:33 +0000 (UTC)
Received: from ming.t460p (ovpn-12-76.pek2.redhat.com [10.72.12.76])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 869B511301E8;
        Tue, 31 Jul 2018 06:16:23 +0000 (UTC)
Date:   Tue, 31 Jul 2018 14:16:18 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc:     axboe@kernel.dk, bart.vanassche@wdc.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] blk-mq: clean up the hctx restart
Message-ID: <20180731061616.GF15701@ming.t460p>
References: <1533009735-2221-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180731045805.GE15701@ming.t460p>
 <8a3383e6-2926-6858-d8f2-671f3cb9e460@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a3383e6-2926-6858-d8f2-671f3cb9e460@oracle.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Tue, 31 Jul 2018 06:16:33 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Tue, 31 Jul 2018 06:16:33 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'ming.lei@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 01:19:42PM +0800, jianchao.wang wrote:
> Hi Ming
> 
> On 07/31/2018 12:58 PM, Ming Lei wrote:
> > On Tue, Jul 31, 2018 at 12:02:15PM +0800, Jianchao Wang wrote:
> >> Currently, we will always set SCHED_RESTART whenever there are
> >> requests in hctx->dispatch, then when request is completed and
> >> freed the hctx queues will be restarted to avoid IO hang. This
> >> is unnecessary most of time. Especially when there are lots of
> >> LUNs attached to one host, the RR restart loop could be very
> >> expensive.
> > 
> > The big RR restart loop has been killed in the following commit:
> > 
> > commit 97889f9ac24f8d2fc8e703ea7f80c162bab10d4d
> > Author: Ming Lei <ming.lei@redhat.com>
> > Date:   Mon Jun 25 19:31:48 2018 +0800
> > 
> >     blk-mq: remove synchronize_rcu() from blk_mq_del_queue_tag_set()
> > 
> > 
> 
> Oh, sorry, I didn't look into this patch due to its title when iterated the mail list,
> therefore I didn't realize the RR restart loop has already been killed. :)
> 
> The RR restart loop could ensure the fairness of sharing some LLDD resource,
> not just avoid IO hung. Is it OK to kill it totally ?

Yeah, it is, also the fairness might be improved a bit by the way in
commit 97889f9ac24f8d2fc, especially inside driver tag allocation
algorithem.

Thanks,
Ming
