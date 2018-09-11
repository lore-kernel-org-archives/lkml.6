Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F3FC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 06:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAEAC20645
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 06:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BpvGhEVi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAEAC20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbeIKLeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 07:34:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:47112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726429AbeIKLeW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 07:34:22 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1033020645;
        Tue, 11 Sep 2018 06:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536647796;
        bh=+RBLHjh3NWEnWVfoMOo2cDRXxVM5zu/NeXDa4HIGUtE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BpvGhEViyJJbLCMNAoG6QzUj/z5E/pTlXpxzy3XrAadG7nwD4S6uoh0oITVKHJbnH
         44k7jgA0Lx6Fd2GHliROed74tufCIEs0YWtvHIi0XvcDXwBs5+QTixDvA0deHkrqTL
         jczZkA8LD9gOH0JMH8qOWG/uhzI0LoRbRLwqq2Qs=
Date:   Tue, 11 Sep 2018 15:36:32 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -tip 5/5] kprobes: Don't call BUG_ON if there is a
 kprobe in use on free list
Message-Id: <20180911153632.c58041dc77dde51806730f2e@kernel.org>
In-Reply-To: <20180910122356.GA70908@gmail.com>
References: <153484425558.5385.1484910606397784412.stgit@devbox>
        <153484439807.5385.8446592533176849097.stgit@devbox>
        <20180910122356.GA70908@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Sep 2018 14:23:56 +0200
Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Instead of calling BUG_ON, if we find a kprobe in use on free kprobe
> > list, just remove it from the list and keep it on kprobe hash list
> > as same as other in-use kprobes.
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >  kernel/kprobes.c |    8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> > index 63c342e5e6c3..e3420364b415 100644
> > --- a/kernel/kprobes.c
> > +++ b/kernel/kprobes.c
> > @@ -546,8 +546,14 @@ static void do_free_cleaned_kprobes(void)
> >  	struct optimized_kprobe *op, *tmp;
> >  
> >  	list_for_each_entry_safe(op, tmp, &freeing_list, list) {
> > -		BUG_ON(!kprobe_unused(&op->kp));
> >  		list_del_init(&op->list);
> > +		if (!kprobe_unused(&op->kp)) {
> > +			/*
> > +			 * This must not happen, but if there is a kprobe
> > +			 * still in use, keep it on kprobes hash list.
> > +			 */
> > +			continue;
> 
> If this is an 'impossible' code path then I think it would make sense to add a WARN_ON_ONCE() 
> here.

I agree. This means something goes wrong. That is enough reason to warn user.

Thank you!

> 
> Thanks,
> 
> 	Ingo


-- 
Masami Hiramatsu <mhiramat@kernel.org>
