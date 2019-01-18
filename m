Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB8FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 300C120855
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b="NQSnxbmG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbfAROJO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 09:09:14 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37807 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbfAROJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 09:09:13 -0500
Received: by mail-qt1-f196.google.com with SMTP id t33so15268343qtt.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 06:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Gd3awAKR+YWHc5QPx8WSxjzY4pO2zBFlyhC7ss7SG1s=;
        b=NQSnxbmG+VqsbiM2GTgHEsngew/N8D2F7zXpuR6vEwb96LIWv1CL/jwuGuqnThLuj5
         Hy7STPEnkgtceNa8ATM3/oz9UgmpGXws3S2zS88mNOc1WajWrc46buWqQ2XfzqQFRBpA
         DQG5XGtEQmu6zff+B5Kx3khd5gJQfqxA1r2Jo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Gd3awAKR+YWHc5QPx8WSxjzY4pO2zBFlyhC7ss7SG1s=;
        b=jm+M37v+J8jHvCoB4XbwBulxHizpEF6kjvb73AmByq06JDIkjEee2WeTmFKhuEYXW+
         eludq3F1A3MaKHJjtxXkgvqNdDBbZtugyDP/qsjBtbes192ViMJjIyPYTiF5mYQG6Kz2
         12LlyZnP7d/Txi93E5GPtw4DZYk2a0ylbfQrmkBvuADg0+nny8zjN+HfgMhFSz/HrlfX
         yufKOSQnW2nAlKYbRLeQBN4yNlsJy3g2tYs2dY3lea91VekQq5S3AX/7zJiRL+hvQeBv
         4RsaT8BCmNOKrc2BckFVgi/LSn9iIQHslYTbShOAgiOiytuye9hBAiQzxu6nxYjx4oNw
         40Iw==
X-Gm-Message-State: AJcUukeMXg0TiMxfGT/VkAD71svkDguoMoZZyZb0geBWo7GOZK371/vR
        2Ma127lb1PkH5nC/qYhWGtBvSA==
X-Google-Smtp-Source: ALg8bN7EH5ngOEmbDUVvsENTCbNn5/K8OKrFCjL7oZuaqzDUrF1ts97JxhoPWRFH3zggHg7wa69gPA==
X-Received: by 2002:a0c:d6c2:: with SMTP id l2mr15329726qvi.97.1547820552310;
        Fri, 18 Jan 2019 06:09:12 -0800 (PST)
Received: from macbook-air (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id h35sm61383650qth.59.2019.01.18.06.09.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Jan 2019 06:09:11 -0800 (PST)
From:   Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date:   Fri, 18 Jan 2019 09:09:04 -0500 (EST)
X-X-Sender: vince@macbook-air
To:     Peter Zijlstra <peterz@infradead.org>
cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: perf: rdpmc bug when viewing all procs on remote cpu
In-Reply-To: <20190118120149.GC27931@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1901180905090.5762@macbook-air>
References: <alpine.DEB.2.21.1901101229010.3358@macbook-air> <alpine.DEB.2.21.1901101246340.3358@macbook-air> <alpine.DEB.2.21.1901101500030.3717@macbook-air> <alpine.DEB.2.21.1901111649580.6487@macbook-air>
 <20190118120149.GC27931@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jan 2019, Peter Zijlstra wrote:

> On Fri, Jan 11, 2019 at 04:52:22PM -0500, Vince Weaver wrote:
> > On Thu, 10 Jan 2019, Vince Weaver wrote:
> > 
> > > On Thu, 10 Jan 2019, Vince Weaver wrote:
> > > 
> > > > On Thu, 10 Jan 2019, Vince Weaver wrote:
> > > > 
> > > > > However if you create an all-process attached to CPU event:
> > > > > 	perf_event_open(attr, -1, X, -1, 0);
> > > > > the mmap event index is set as if this were a valid event and so the rdpmc
> > > > > succeeds even though it shouldn't (we're trying to read an event value
> > > > > on a remote cpu with a local rdpmc).
> > 
> > so on further looking at the code, it doesn't appear that rdpmc events are 
> > explicitly marked as unavailable in the attach-cpu or attach-pid case, 
> > it's just by luck the check for PERF_EVENT_STATE_ACTIVE catches most of 
> > the cases?
> > 
> > should an explicit check be added to zero out userpg->index in cases where 
> > the event being measured is running on a different core?
> 
> And how would we konw? We don't know what CPU will be observing the
> mmap().
> 
> RDPMC fundamentally only makes sense on 'self' (either task or CPU).

so is this a "don't do that then" thing and I should have PAPI 
userspace avoid using rdpmc() whenever a proc/cpu was attached to?

Or is there a way to have the kernel indicate this?  Does the kernel track 
current CPU and original CPU of the mmap and could zero out the index 
field in this case?  Or would that add too much overhead?

Vince
