Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDED5C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C4AD20881
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Jk0fptbw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbfA2Kow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 05:44:52 -0500
Received: from merlin.infradead.org ([205.233.59.134]:57220 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbfA2Kow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 05:44:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/DYnSP8wwfkVagxlcXdbh9VOXn6NyWlZWTa5ybGjpLI=; b=Jk0fptbwefzDq9+8zgftkY20d
        8S0HjEYx3W+J+CiaW3yCBRQi0gRLhDpQapl661tD+UD51GNxqwhk4DCEsUZTZO0URngSGCK5T59xD
        JtGj8ZWFL4Jt8tnkbUuNnyncF4lIH7sm7URnzzp9WO0be1AhK4U0uo8lmZy3mtvJPMwV9Rutb50Sv
        DVZ2ZTggkXUTqp2XPUldmoZJG04oFmB+wx66t18Imh0r+agjQTCJ0aK0nGIgFR9aCVHnHx969KoX0
        bG7U89mBgq3HA5cZqmkgbLkeTbk2UYHcFEhwAAs7mfqs7H41qw4fuQGDYKzQ+KPu/p4uasxvQIGQh
        D0KFbAGpQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1goQsa-0000Kv-H3; Tue, 29 Jan 2019 10:44:32 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4EECB201EC171; Tue, 29 Jan 2019 11:44:31 +0100 (CET)
Date:   Tue, 29 Jan 2019 11:44:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     gregkh@linuxfoundation.org, tj@kernel.org, lizefan@huawei.com,
        hannes@cmpxchg.org, axboe@kernel.dk, dennis@kernel.org,
        dennisszhou@gmail.com, mingo@redhat.com, akpm@linux-foundation.org,
        corbet@lwn.net, cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v3 5/5] psi: introduce psi monitor
Message-ID: <20190129104431.GJ28467@hirez.programming.kicks-ass.net>
References: <20190124211518.244221-1-surenb@google.com>
 <20190124211518.244221-6-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124211518.244221-6-surenb@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 01:15:18PM -0800, Suren Baghdasaryan wrote:
>  static void psi_update_work(struct work_struct *work)
>  {
>  	struct delayed_work *dwork;
>  	struct psi_group *group;
> +	bool first_pass = true;
> +	u64 next_update;
> +	u32 change_mask;
> +	int polling;
>  	bool nonidle;
> +	u64 now;
>  
>  	dwork = to_delayed_work(work);
>  	group = container_of(dwork, struct psi_group, clock_work);
>  
> +	now = sched_clock();
> +
> +	mutex_lock(&group->update_lock);

actually acquiring a mutex can take a fairly long while; would it not
make more sense to take the @now timestanp _after_ it, instead of
before?
