Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D705AC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 12:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 765FA2084E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 12:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="blFIzjLL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 765FA2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731596AbeGSNaw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 09:30:52 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:42210 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730053AbeGSNaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 09:30:52 -0400
Received: by mail-qt0-f195.google.com with SMTP id z8-v6so7005432qto.9
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 05:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9EV0y4Jq/QZWXMWnQmu4hP1A9LHDHt4yfnVQqzpTXvI=;
        b=blFIzjLLctoonekQuJXp2TJgQC+b+PNfwwsKVsSmYRf3xi1PPOUWe+zKGiZ+8DaCdV
         tARumXHM4rnwZi0vepiQPLT1YLOXYMQAYuqcN6G4x7pP/KmYPjzwHVdp39v/OCAPcel3
         qXCgOqfvpW8BEHKFRD1ld9nQhQun6PR1/GpTnDySObdAsJ8ApSEDAG2uivEi3wm+/+O+
         WUnOufedvOB0rAxpEBGTHn15qo+8QMxNAL4+PwWVQtD/RQrJBvu6TPIGTjo77mD7ZTJq
         qmy4p9BIg0EhR3puAUKDDns+NR9M3qM4V0XUFWcncKoicbhU+mVqZUJxz/nko+SXN5QZ
         0V9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9EV0y4Jq/QZWXMWnQmu4hP1A9LHDHt4yfnVQqzpTXvI=;
        b=rj27CwtmTma4e50JkOU8edpJEK580k2HWvxIVSgymEsA+MuAffhXT/XH9yuJZ0SYVK
         gcnB5y+I0FKhITnH/fOL4Qi0gVSRGeqsWsQVdRJ40TxJNnYmn9awNobuquyeN9GJr4hE
         WScN8y8UMMmJTIYg7/2lCeDzR8ZXaXLbBPMvtMT9MiD3nchI5PU2oY3JA+m8dD0HdKNN
         4pUROhb5EZGkrEfh3i3jnEdbt50cN4qr8Qn1BlBOciKEzitsCmBjFDooDKh9ZkTOGt8S
         WTuKbyuWWheT8nQ5i9JZXaovWP6G0YlODpTZyrKAJhWpWvOR8vQd+fErW1ZOBJeIMLcp
         7q/Q==
X-Gm-Message-State: AOUpUlE5r35fyPTkD3c4JMkhlU7teQ7lHBZ569ZFmMpDor3fVpEG4JUj
        AvNLndiRA368HUQue5e5A1wz7A==
X-Google-Smtp-Source: AAOMgpefWKHFdu3CVa5JjNNTvP0FXBnKfOklLvDZ7rySgg2dcRIoNu+qOQV93bZfXKqGtP9sypIz3w==
X-Received: by 2002:a0c:d683:: with SMTP id k3-v6mr10534516qvi.154.1532004472024;
        Thu, 19 Jul 2018 05:47:52 -0700 (PDT)
Received: from localhost (pool-96-246-38-36.nycmny.fios.verizon.net. [96.246.38.36])
        by smtp.gmail.com with ESMTPSA id w79-v6sm5798205qkw.35.2018.07.19.05.47.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Jul 2018 05:47:50 -0700 (PDT)
Date:   Thu, 19 Jul 2018 08:50:38 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Christopher Lameter <cl@linux.com>,
        Mike Galbraith <efault@gmx.de>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 08/10] psi: pressure stall information for CPU, memory,
 and IO
Message-ID: <20180719125038.GB13799@cmpxchg.org>
References: <20180712172942.10094-1-hannes@cmpxchg.org>
 <20180712172942.10094-9-hannes@cmpxchg.org>
 <20180718120318.GC2476@hirez.programming.kicks-ass.net>
 <20180719092614.GY2512@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180719092614.GY2512@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 11:26:14AM +0200, Peter Zijlstra wrote:
> On Wed, Jul 18, 2018 at 02:03:18PM +0200, Peter Zijlstra wrote:
> 
> > Leaving us just 5 bytes short of needing a single cacheline :/
> > 
> > struct ponies {
> >         unsigned int               tasks[3];                                             /*     0    12 */
> >         unsigned int               cpu_state:2;                                          /*    12:30  4 */
> >         unsigned int               io_state:2;                                           /*    12:28  4 */
> >         unsigned int               mem_state:2;                                          /*    12:26  4 */
> > 
> >         /* XXX 26 bits hole, try to pack */
> > 
> >         /* typedef u64 */ long long unsigned int     last_time;                          /*    16     8 */
> >         /* typedef u64 */ long long unsigned int     some_time[3];                       /*    24    24 */
> >         /* typedef u64 */ long long unsigned int     full_time[2];                       /*    48    16 */
> >         /* --- cacheline 1 boundary (64 bytes) --- */
> >         /* typedef u64 */ long long unsigned int     nonidle_time;                       /*    64     8 */
> > 
> >         /* size: 72, cachelines: 2, members: 8 */
> >         /* bit holes: 1, sum bit holes: 26 bits */
> >         /* last cacheline: 8 bytes */
> > };
> > 
> > ARGGH!
> 
> It _might_ be possible to use curr->se.exec_start for last_time if you
> very carefully audit and place the hooks. I've not gone through it in
> detail, but it might just work.

Hnngg, and chop off an entire cacheline...

But don't we flush that delta out and update the timestamp on every
tick? entity_tick() does update_curr(). That might be too expensive :(
