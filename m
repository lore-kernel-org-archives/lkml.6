Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 068C8C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 04:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A66C820865
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 04:03:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A66C820865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbeIKJAy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 05:00:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56082 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726301AbeIKJAy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 05:00:54 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 93B3985779;
        Tue, 11 Sep 2018 04:03:35 +0000 (UTC)
Received: from ming.t460p (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AFCF510CD63A;
        Tue, 11 Sep 2018 04:03:29 +0000 (UTC)
Date:   Tue, 11 Sep 2018 12:03:24 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc:     linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] percpu-refcount: relax limit on percpu_ref_reinit()
Message-ID: <20180911040323.GC30977@ming.t460p>
References: <20180909125824.9150-1-ming.lei@redhat.com>
 <d4fb5fcc-305e-b3a7-0124-9c7b75042f01@oracle.com>
 <20180910161135.GA27430@ming.t460p>
 <e91ee38e-3ea2-a003-2aac-8a8cc5c8f04a@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e91ee38e-3ea2-a003-2aac-8a8cc5c8f04a@oracle.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Tue, 11 Sep 2018 04:03:35 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Tue, 11 Sep 2018 04:03:35 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'ming.lei@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 09:48:15AM +0800, jianchao.wang wrote:
> Hi Ming
> 
> On 09/11/2018 12:11 AM, Ming Lei wrote:
> > Hi Jianchao,
> > 
> > On Mon, Sep 10, 2018 at 09:40:35AM +0800, jianchao.wang wrote:
> >> Hi Ming
> >>
> >> On 09/09/2018 08:58 PM, Ming Lei wrote:
> >>> Now percpu_ref_reinit() can only be done on one percpu refcounter
> >>> when it drops zero. And the limit shouldn't be so strict, and it
> >>> is quite straightforward that percpu_ref_reinit() can be done when
> >>> this counter is at atomic mode.
> >>
> >> As we know, when the percpu_ref is switched to atomic mode, the values
> >> of the per cpu will be sumed up to the atomic conter in percpu_ref_switch_to_atomic_rcu.
> > 
> > Right.
> > 
> >>
> >> However, the tricky part is:
> >> when we switch back to percpu mode, how can we know the exact value of the value of every cpu ?
> > 
> > The exact value of each CPU is zero at the exact time:
> > 
> > 1) when percpu mode is switched from atomic mode
> > 
> > percpu_ref_switch_to_atomic_rcu() is the point where no any percpu inc/dec
> > can happen any more. And in this function the percpu count is sumed up to
> > the atomic counter, meantime this patch clears the percpu value. It means
> > once the refcount is switched to atomic mode, the percpu value is always
> > zero, doesn't it?
> > 
> > 2) when the percpu-refcount is initialized at percpu mode
> > 
> > the percpu value is zero too.
> 
> What we want to get is to switch the percpu refcounter to percpu mode from atomic mode when
> the refcounter has _not_ been drained to zero, instead of just to discard the warning, right ?

Right, it does work in this way as I explained.

The idea is simple, atomic mode is one easy mode to switch to percpu
mode, and we don't have to wait until the whole ref-count(at atomic mode)
drops zero for the switching.

> 
> When we have sumed the values of every cpu's refcounter to a global atomic counter, how can
> we give the values back to the refcounter of every cpu ?

Who will use percpu-refcounter in this way? From user's view, only the
whole counting matters.

After the refcount is switched to atomic mode, the whole counting is
done on the atomic part. Then if the refcount need to switch to percpu mode
again, all percpu part of the counter is re-initialized as zero simply. This
is invariant with/without this patch.

Thanks,
Ming
