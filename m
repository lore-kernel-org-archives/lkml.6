Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F8E2C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 16:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03B6721534
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 16:58:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03B6721534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732177AbeHBSuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 14:50:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40576 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726938AbeHBSuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 14:50:44 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 75F434075172;
        Thu,  2 Aug 2018 16:58:45 +0000 (UTC)
Received: from ming.t460p (ovpn-12-120.pek2.redhat.com [10.72.12.120])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E523A213ED6A;
        Thu,  2 Aug 2018 16:58:36 +0000 (UTC)
Date:   Fri, 3 Aug 2018 00:58:32 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <Bart.VanAssche@wdc.com>
Cc:     "jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [RFC] blk-mq: clean up the hctx restart
Message-ID: <20180802165831.GB8928@ming.t460p>
References: <1533009735-2221-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180731045805.GE15701@ming.t460p>
 <8a3383e6-2926-6858-d8f2-671f3cb9e460@oracle.com>
 <20180731061616.GF15701@ming.t460p>
 <42371198-2a4b-1062-3564-411645ffba98@oracle.com>
 <20180801085841.GA27962@ming.t460p>
 <9feaa41702ef6fcc00ce1b8aa19bbe179edf4e3f.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9feaa41702ef6fcc00ce1b8aa19bbe179edf4e3f.camel@wdc.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 02 Aug 2018 16:58:45 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 02 Aug 2018 16:58:45 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'ming.lei@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2018 at 03:52:00PM +0000, Bart Van Assche wrote:
> On Wed, 2018-08-01 at 16:58 +0800, Ming Lei wrote:
> > On Wed, Aug 01, 2018 at 10:17:30AM +0800, jianchao.wang wrote:
> > > However, due to the limits in hctx_may_queue, q_b still cannot get the
> > > tags. The RR restart also will not wake up q_a.
> > > This is unfair for q_a.
> > > 
> > > When we remove RR restart fashion, at least, the q_a will be waked up by
> > > the hctx restart.
> > > Is this the improvement of fairness you said in driver tag allocation ?
> > 
> > I mean the fairness is totally covered by the general tag allocation
> > algorithm now, which is sort of FIFO style because of waitqueue, but RR
> > restart wakes up queue in the order of request queue.
> 
> From sbitmap.h:
> 
> #define SBQ_WAIT_QUEUES 8
> 
> What do you think is the effect of your patch if more than eight LUNs are
> active and the SCSI queue is full?

Jens introduces multiple wait queues for scattering atomic operation on
multiple counters, in theory, the way is understood easily if you just
treat it as one whole queue in concept.

And about the situations you mentioned, no any special as normal cases
or thousands of LUNs. Just a batch of queues are waken up from one
single wait queue(sbq_wait_state), and inside each wait queue, queues
are handled actually in FIFO order.

Or what is your expected ideal behaviour about fairness?

thanks, 
Ming
