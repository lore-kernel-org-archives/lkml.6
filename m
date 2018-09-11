Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6529CC6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 16:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B7DA2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 16:05:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B7DA2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbeIKVFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 17:05:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39166 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727419AbeIKVFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 17:05:43 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 95C0D400C3C1;
        Tue, 11 Sep 2018 16:05:44 +0000 (UTC)
Received: from ming.t460p (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E2C491102E26;
        Tue, 11 Sep 2018 16:05:38 +0000 (UTC)
Date:   Wed, 12 Sep 2018 00:05:33 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] percpu-refcount: relax limit on percpu_ref_reinit()
Message-ID: <20180911160532.GB10082@ming.t460p>
References: <20180909125824.9150-1-ming.lei@redhat.com>
 <20180910164920.GE1100574@devbig004.ftw2.facebook.com>
 <20180911000049.GB30977@ming.t460p>
 <20180911134836.GG1100574@devbig004.ftw2.facebook.com>
 <20180911154540.GA10082@ming.t460p>
 <20180911154959.GI1100574@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180911154959.GI1100574@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Tue, 11 Sep 2018 16:05:44 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Tue, 11 Sep 2018 16:05:44 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'ming.lei@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 08:49:59AM -0700, Tejun Heo wrote:
> On Tue, Sep 11, 2018 at 11:45:41PM +0800, Ming Lei wrote:
> > > So, this part seems wrong.  The function is called percpu_ref_reinit()
> > > - the refcnt is expected to be in its initial state with just the base
> > > ref once this function returns.  If you're removing the restriction on
> > 
> > But the comment says that 'Re-initialize @ref so that it's in the same
> > state as when it finished', and this invariant isn't changed with this
> > patch.
> 
> The comment goes "when perpcu_ref_init() finished".  The function is
> called re _init_.  It should put the ref in the initial state, right?

OK, I am fine to keep the behaviour for this API, will introduce a new helper
for NVMe.

However, it is doable to switch to percpu mode from atomic mode when it
doesn't drop to zero, looks like sort of perpcu_ref_reinit(inherit_old_refcount).

Thanks,
Ming
