Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA10C04ABB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 01:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE47D20866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 01:53:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE47D20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbeILGzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 02:55:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39232 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726686AbeILGzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 02:55:03 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1F65A7DAC5;
        Wed, 12 Sep 2018 01:52:59 +0000 (UTC)
Received: from ming.t460p (ovpn-8-29.pek2.redhat.com [10.72.8.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3B1D01010413;
        Wed, 12 Sep 2018 01:52:52 +0000 (UTC)
Date:   Wed, 12 Sep 2018 09:52:48 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] percpu-refcount: relax limit on percpu_ref_reinit()
Message-ID: <20180912015247.GA12475@ming.t460p>
References: <20180909125824.9150-1-ming.lei@redhat.com>
 <20180910164920.GE1100574@devbig004.ftw2.facebook.com>
 <20180911000049.GB30977@ming.t460p>
 <20180911134836.GG1100574@devbig004.ftw2.facebook.com>
 <20180911154540.GA10082@ming.t460p>
 <20180911154959.GI1100574@devbig004.ftw2.facebook.com>
 <20180911160532.GB10082@ming.t460p>
 <20180911163032.GA2966370@devbig004.ftw2.facebook.com>
 <20180911163443.GD10082@ming.t460p>
 <20180911163856.GB2966370@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180911163856.GB2966370@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 12 Sep 2018 01:52:59 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 12 Sep 2018 01:52:59 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'ming.lei@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 09:38:56AM -0700, Tejun Heo wrote:
> Hello, Ming.
> 
> On Wed, Sep 12, 2018 at 12:34:44AM +0800, Ming Lei wrote:
> > > Why aren't switch_to_atomic/percpu enough?
> > 
> > The blk-mq's use case is this _reinit is done on one refcount which was
> > killed via percpu_ref_kill(), so the DEAD flag has to be cleared.
> 
> If you killed and waited until kill finished, you should be able to
> re-init.  Is it that you want to kill but abort killing in some cases?

Yes, it can be re-init, just with the warning of WARN_ON_ONCE(!percpu_ref_is_zero(ref)).

> How do you then handle the race against release?  Can you please

The .release is only called at atomic mode, and once we switch to
percpu mode, .release can't be called at all. Or I may not follow you,
could you explain a bit the race with release?

> describe the exact usage you have on mind?

Let me explain the use case:

1) nvme timeout comes

2) all pending requests are canceled, but won't be completed because
they have to be retried after the controller is recovered

3) meantime, the queue has to be frozen for avoiding new request, so
the refcount is killed via percpu_ref_kill().

4) after the queue is recovered(or the controller is reset successfully), it
isn't necessary to wait until the refcount drops zero, since it is fine to
reinit it by clearing DEAD and switching back to percpu mode from atomic mode.
And waiting for the refcount dropping to zero in the reset handler may trigger
IO hang if IO timeout happens again during reset.


So what I am trying to propose is the following usage:

1) percpu_ref_kill() on .q_usage_counter before recovering the controller for
preventing new requests from entering queue

2) controller is recovered

3) percpu_ref_reinit() on .q_usage_counter, and do not wait for
.q_usage_counter dropping to zero, then we needn't to wait in NVMe reset
handler which can be thought as single thread, and avoid IO hang when
new timeout is triggered during the waiting.

Thanks,
Ming
