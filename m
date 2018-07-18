Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E5A7ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 22:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9FA82084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 22:00:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="amPbMbni"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9FA82084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729309AbeGRWkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 18:40:22 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:35219 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbeGRWkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 18:40:22 -0400
Received: by mail-yb0-f193.google.com with SMTP id x15-v6so2475965ybm.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 15:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=R+3dIiRyHP1fioKsYuh/dXRSLNmOYtxcUdsY0xfFPLo=;
        b=amPbMbni5KHTRvpPS5NjL05oE2UvGrywukrjUnj2kEd1CfT5OTDljNtSSvCfP39OrS
         O4sbirpnCMUqYoU8wJY8VLnmXdSGyaUyaSMTTJcXwdAp2WHXplAv2sdsmocf7252eDnF
         SoWrKGLI7Q0ru8aGPL06iXNRLMd8c3GtKvrKFvFMuMKY8JYWog6UDSEW/juvJ+8PP6Jr
         9e0TxBrVWZQtgcQ/853DK51pdsVde684uEXBSt6GYuY+1cMcnLAMCukDPLbJk+26fqCd
         vretef6I9vYmh6e1wi09Ef6DufqmFzbg2MzYFIx90It9aMVasokYwyA2zP1WkHgmlYkT
         nCkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=R+3dIiRyHP1fioKsYuh/dXRSLNmOYtxcUdsY0xfFPLo=;
        b=duDKfhJ8EUVKyeCl9Wq3+liwJfXnswHEh1z6hX8zqKAwyuW0DjcVpNZVDYqQYbGxXS
         t1saEeH/eqWeFfsyNgjHstp7e2FDGCH9eWW4vjTD29q6N+E2vuyMQ1sDJmZvvwVRGwiD
         0v7gc0lZk5fMMPhqoeA8WBB+evg7TxPWGYTja4QAhp7BrhY93djU7E4YXuQNqjQRptb2
         aCweM8n26DO1H4lJ0Fi+f5tNhQoMFG5pU4rElMgVgK6+7Cr6zF2pIcbkQM7mB0/MdjSM
         e3kZokHmNUkHxDpevVA9DxuT0e2/vmpvzIZco6QdwkqePsMeWvF9YZIEZfYEXOMon9K/
         Zotg==
X-Gm-Message-State: AOUpUlERqJdU4BWqbOmIOzjV/7iYIaMohvzhtd1peZavNShmreZzKwNK
        wU4nrgyilht9+XSjjzkfhMo83g==
X-Google-Smtp-Source: AAOMgpdjbOHIwAr/Pr8DA6strpZXU69wGu7UrrIgSb3ZKVaJHiyz+/azT8Z40uXGLK9TFl+nk116Xw==
X-Received: by 2002:a25:35c4:: with SMTP id c187-v6mr4150126yba.283.1531951224802;
        Wed, 18 Jul 2018 15:00:24 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::2:7eca])
        by smtp.gmail.com with ESMTPSA id x7-v6sm5095464ywd.43.2018.07.18.15.00.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Jul 2018 15:00:23 -0700 (PDT)
Date:   Wed, 18 Jul 2018 18:03:10 -0400
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
Message-ID: <20180718220310.GD2838@cmpxchg.org>
References: <20180712172942.10094-1-hannes@cmpxchg.org>
 <20180712172942.10094-9-hannes@cmpxchg.org>
 <20180717142157.GF2494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180717142157.GF2494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 04:21:57PM +0200, Peter Zijlstra wrote:
> On Thu, Jul 12, 2018 at 01:29:40PM -0400, Johannes Weiner wrote:
> > diff --git a/include/linux/sched/stat.h b/include/linux/sched/stat.h
> > index 04f1321d14c4..ac39435d1521 100644
> > --- a/include/linux/sched/stat.h
> > +++ b/include/linux/sched/stat.h
> > @@ -28,10 +28,14 @@ static inline int sched_info_on(void)
> >  	return 1;
> >  #elif defined(CONFIG_TASK_DELAY_ACCT)
> >  	extern int delayacct_on;
> > +	if (delayacct_on)
> > +		return 1;
> > +#elif defined(CONFIG_PSI)
> > +	extern int psi_disabled;
> > +	if (!psi_disabled)
> > +		return 1;
> >  #endif
> > +	return 0;
> >  }
> 
> Doesn't that want to be something like:
> 
> static inline bool sched_info_on(void)
> {
> #ifdef CONFIG_SCHEDSTAT
> 	return true;
> #else /* !SCHEDSTAT */
> #ifdef CONFIG_TASK_DELAY_ACCT
> 	extern int delayacct_on;
> 	if (delayacct_on)
> 		return true;
> #endif /* DELAYACCT */
> #ifdef CONFIG_PSI
> 	extern int psi_disabled;
> 	if (!psi_disabled)
> 		return true;
> #endif
> 	return false;
> #endif /* !SCHEDSTATE */
> }
> 
> Such that if you build a TASK_DELAY_ACCT && PSI kernel, and boot with
> nodelayacct, you still get sched_info_on().

You're right, that was a brainfart on my end. But as you point out in
the other email, the SCHED_INFO dependency is artificial, so I'll
rework this entire part.
