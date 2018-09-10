Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2214C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5EEE20870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:11:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5EEE20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbeIJVGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 17:06:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45242 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727674AbeIJVGf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 17:06:35 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B89ED9BA9A;
        Mon, 10 Sep 2018 16:11:46 +0000 (UTC)
Received: from ming.t460p (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 55A3B2027EA4;
        Mon, 10 Sep 2018 16:11:40 +0000 (UTC)
Date:   Tue, 11 Sep 2018 00:11:36 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc:     linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] percpu-refcount: relax limit on percpu_ref_reinit()
Message-ID: <20180910161135.GA27430@ming.t460p>
References: <20180909125824.9150-1-ming.lei@redhat.com>
 <d4fb5fcc-305e-b3a7-0124-9c7b75042f01@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4fb5fcc-305e-b3a7-0124-9c7b75042f01@oracle.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 10 Sep 2018 16:11:46 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 10 Sep 2018 16:11:46 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'ming.lei@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jianchao,

On Mon, Sep 10, 2018 at 09:40:35AM +0800, jianchao.wang wrote:
> Hi Ming
> 
> On 09/09/2018 08:58 PM, Ming Lei wrote:
> > Now percpu_ref_reinit() can only be done on one percpu refcounter
> > when it drops zero. And the limit shouldn't be so strict, and it
> > is quite straightforward that percpu_ref_reinit() can be done when
> > this counter is at atomic mode.
> 
> As we know, when the percpu_ref is switched to atomic mode, the values
> of the per cpu will be sumed up to the atomic conter in percpu_ref_switch_to_atomic_rcu.

Right.

> 
> However, the tricky part is:
> when we switch back to percpu mode, how can we know the exact value of the value of every cpu ?

The exact value of each CPU is zero at the exact time:

1) when percpu mode is switched from atomic mode

percpu_ref_switch_to_atomic_rcu() is the point where no any percpu inc/dec
can happen any more. And in this function the percpu count is sumed up to
the atomic counter, meantime this patch clears the percpu value. It means
once the refcount is switched to atomic mode, the percpu value is always
zero, doesn't it?

2) when the percpu-refcount is initialized at percpu mode

the percpu value is zero too.

> 
> Draining the percpu refcounter to zero before switch it back to percpu mode should be relatively
> easy to implement. And also, this is the initial intention of percpu refcounter, only switch

No, I don't think so, we can extend the percpu-refcount implementation to
cover the NVMe timeout case easily. Then no necessary to reinvent a new wheel
to address that issue.

> to atomic mode when want to drain the refcounter. 


Thanks,
Ming
