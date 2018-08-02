Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A6AC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 17:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56A8221535
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 17:17:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56A8221535
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732271AbeHBTJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 15:09:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41508 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726938AbeHBTJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 15:09:43 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 570224219DB4;
        Thu,  2 Aug 2018 17:17:40 +0000 (UTC)
Received: from ming.t460p (ovpn-12-120.pek2.redhat.com [10.72.12.120])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 95F1810CD7D5;
        Thu,  2 Aug 2018 17:17:29 +0000 (UTC)
Date:   Fri, 3 Aug 2018 01:17:24 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <Bart.VanAssche@wdc.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [RFC] blk-mq: clean up the hctx restart
Message-ID: <20180802171723.GD8928@ming.t460p>
References: <1533009735-2221-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180731045805.GE15701@ming.t460p>
 <8a3383e6-2926-6858-d8f2-671f3cb9e460@oracle.com>
 <20180731061616.GF15701@ming.t460p>
 <42371198-2a4b-1062-3564-411645ffba98@oracle.com>
 <20180801085841.GA27962@ming.t460p>
 <9feaa41702ef6fcc00ce1b8aa19bbe179edf4e3f.camel@wdc.com>
 <20180802165831.GB8928@ming.t460p>
 <7c933e7e60831f985297d8cc5a540171fc921f44.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c933e7e60831f985297d8cc5a540171fc921f44.camel@wdc.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 02 Aug 2018 17:17:40 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 02 Aug 2018 17:17:40 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'ming.lei@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2018 at 05:08:55PM +0000, Bart Van Assche wrote:
> On Fri, 2018-08-03 at 00:58 +0800, Ming Lei wrote:
> > And about the situations you mentioned, no any special as normal cases
> > or thousands of LUNs. Just a batch of queues are waken up from one
> > single wait queue(sbq_wait_state), and inside each wait queue, queues
> > are handled actually in FIFO order.
> > 
> > Or what is your expected ideal behaviour about fairness?
> 
> Hello Ming,
> 
> What I expect is if the number of LUNs is really large that all LUNs are treated
> equally. Unless someone can set up a test that demonstrates that this is still

Some of idle LUNs shouldn't be treated equally as other LUNs which need
to serve.  

Also as I mentioned, the original RR style isn't better than the new
way actually, since now we handle queues in sort of FIFO style, thanks
wait queue.

Not mentioning big CPU utilization is consumed unnecessarily for iterating
over all queues even though there is only one active queue, is this fair from
system view?

Thanks,
Ming
