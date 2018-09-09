Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6063C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 02:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7077F2064D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 02:28:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7077F2064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbeIJHTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 03:19:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60524 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725889AbeIJHTi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 03:19:38 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D871D8011462;
        Sun,  9 Sep 2018 23:59:54 +0000 (UTC)
Received: from ming.t460p (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BD3172026D66;
        Sun,  9 Sep 2018 23:59:48 +0000 (UTC)
Date:   Mon, 10 Sep 2018 07:59:43 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] percpu-refcount: relax limit on percpu_ref_reinit()
Message-ID: <20180909235942.GA31391@ming.t460p>
References: <20180909125824.9150-1-ming.lei@redhat.com>
 <1536518780.23536.3.camel@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536518780.23536.3.camel@acm.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Sun, 09 Sep 2018 23:59:54 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Sun, 09 Sep 2018 23:59:54 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'ming.lei@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 09, 2018 at 11:46:20AM -0700, Bart Van Assche wrote:
> On Sun, 2018-09-09 at 20:58 +0800, Ming Lei wrote:
> > Now percpu_ref_reinit() can only be done on one percpu refcounter
> > when it drops zero. And the limit shouldn't be so strict, and it
> > is quite straightforward that percpu_ref_reinit() can be done when
> > this counter is at atomic mode.
> > 
> > This patch relaxes the limit, so we may avoid extra change[1] for NVMe
> > timeout's requirement.
> > 
> > [1] https://marc.info/?l=linux-kernel&m=153612052611020&w=2
> 
> Is the NVMe driver the only block driver that hangs if it is attempted to
> freeze its request queue when a request times out? If so, can this hang be
> fixed by modifying the NVMe driver instead of by modifying the percpu
> refcount implementation?

IMO, this patch is quite simple and it should be much simpler than
solving this issue in block layer or NVMe, could we focus on the
technical correctness of this patch first?

However if anyone has better/simpler solution for this issue on any
change, I am open to them too.

Thanks,
Ming
