Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46CA3C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 08:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A8F420865
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 08:20:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A8F420865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbeIKNSq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 09:18:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41640 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726529AbeIKNSq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 09:18:46 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7EE404002248;
        Tue, 11 Sep 2018 08:20:35 +0000 (UTC)
Received: from ming.t460p (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1193C94650;
        Tue, 11 Sep 2018 08:20:29 +0000 (UTC)
Date:   Tue, 11 Sep 2018 16:20:24 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc:     linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] percpu-refcount: relax limit on percpu_ref_reinit()
Message-ID: <20180911082023.GA5360@ming.t460p>
References: <20180909125824.9150-1-ming.lei@redhat.com>
 <d4fb5fcc-305e-b3a7-0124-9c7b75042f01@oracle.com>
 <20180910161135.GA27430@ming.t460p>
 <e91ee38e-3ea2-a003-2aac-8a8cc5c8f04a@oracle.com>
 <20180911040323.GC30977@ming.t460p>
 <771fa1eb-85d3-2ff2-6070-207874da85b6@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <771fa1eb-85d3-2ff2-6070-207874da85b6@oracle.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 11 Sep 2018 08:20:35 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 11 Sep 2018 08:20:35 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'ming.lei@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 12:40:36PM +0800, jianchao.wang wrote:
> Hi Ming
> 
> On 09/11/2018 12:03 PM, Ming Lei wrote:
> > After the refcount is switched to atomic mode, the whole counting is
> > done on the atomic part. Then if the refcount need to switch to percpu mode
> > again, all percpu part of the counter is re-initialized as zero simply. This
> > is invariant with/without this patch.
> 
> Does the "whole counting" here means ?
> 
> (long)(sum (every cpu's refcounter)) + atomic refcounter

No.

We only check the 'whole counting' at atomic mode, so it is the atomic
part('ref->count'), please see percpu_ref_put_many(), in which ref->release()
is only called at atomic mode.

At percpu mode, the ref-count is only decreased/increased on the local CPU.

> 
> and when switch to atomic mode, there could be value left in atomic refcounter.
> then the unsigned long percpu refcounter cound be decreased from 0.
> 	
> From another angle, one request could be ended on a different cpu from the one where
> it is issued.

Right.

But,

In the fast path(either completion or issue path), the .q_usage_counter is only
increased/decreased, which can be done in either atomic or percpu mode.

And when we want to check the queued/inflight requests, the .q_usage_counter has
to be killed first by switching to atomic mode, such as in all kinds of
uses of blk_freeze_queue_start().


Thanks,
Ming
