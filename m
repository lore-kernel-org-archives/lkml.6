Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F29ECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 08:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFAB8208A3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 08:01:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFAB8208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730952AbeISNh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 09:37:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59394 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726527AbeISNhz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 09:37:55 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A638F3082DD0;
        Wed, 19 Sep 2018 08:01:11 +0000 (UTC)
Received: from ming.t460p (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A0E257E4DF;
        Wed, 19 Sep 2018 08:01:05 +0000 (UTC)
Date:   Wed, 19 Sep 2018 16:01:01 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc:     linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 2/4] lib/percpu-refcount: introduce percpu_ref_resurge()
Message-ID: <20180919080059.GB23172@ming.t460p>
References: <20180918101946.13329-1-ming.lei@redhat.com>
 <20180918101946.13329-3-ming.lei@redhat.com>
 <242969d0-1370-b342-025d-a11b7f59d28f@oracle.com>
 <20180919075506.GA23172@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180919075506.GA23172@ming.t460p>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Wed, 19 Sep 2018 08:01:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 03:55:07PM +0800, Ming Lei wrote:
> On Wed, Sep 19, 2018 at 01:19:10PM +0800, jianchao.wang wrote:
> > Hi Ming
> > 
> > On 09/18/2018 06:19 PM, Ming Lei wrote:
> > > +		unsigned long __percpu *percpu_count;
> > > +
> > > +		WARN_ON_ONCE(__ref_is_percpu(ref, &percpu_count));
> > > +
> > > +		/* get one extra ref for avoiding race with .release */
> > > +		rcu_read_lock_sched();
> > > +		atomic_long_add(1, &ref->count);
> > > +		rcu_read_unlock_sched();
> > > +	}
> > 
> > The rcu_read_lock_sched here is redundant. We have been in the critical section
> > of a spin_lock_irqsave.
> 
> Right.
> 
> > 
> > The atomic_long_add(1, &ref->count) may have two result.
> > 1. ref->count > 1
> >    it will not drop to zero any more.
> > 2. ref->count == 1
> >    it has dropped to zero and .release may be running.
> 
> IMO, both the two cases are fine and supported, or do you have other
> concern about this way?

It is too quick, :-)

Yeah, the .release() may be running.

For blk-mq/NVMe's use case, it won't be an issue. We may comment on this
race and let user handle it if it is a problem.


thanks,
Ming
