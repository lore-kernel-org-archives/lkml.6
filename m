Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52885ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 17:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E89D20870
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 17:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMTmUXy+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E89D20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728945AbeGPSJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 14:09:50 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35781 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727479AbeGPSJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 14:09:50 -0400
Received: by mail-wr1-f68.google.com with SMTP id a3-v6so23536285wrt.2;
        Mon, 16 Jul 2018 10:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wX3klOAhaUyPAlhcin/0pgE4AcbUtKmM5LNyo82N8P4=;
        b=LMTmUXy+nZXeoNm+XH4oF6ZOvuc5pqjBGzPqpe948TGAZVRq4e1OXkdZdrITyOZwa4
         UK8ZPn/b69tBDhLhbEOWdxAvnKvNQ04yHu1mX6hnmzCRdSWglHS999MJwXfelDWcsDkY
         F++wZmbgJIpHfo8V47ebQ0bA1xxtC83ckKBuMA3O/O5zgtFmf/BeFBdFGuUe48szkq0D
         GXiPrVPSNRNa24gr1oPY58HG9udpq8doQ0KXbtfPo1ygKL5WUA3Aj8QsSFvruIMNYPEU
         z7FgGVhR8bUW6obSGtcuwTWxfdJ+1qpj6g3qdxBRhkzN1EdhCs5vMAhda0xCC1znMmLM
         jBWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=wX3klOAhaUyPAlhcin/0pgE4AcbUtKmM5LNyo82N8P4=;
        b=kXCLykjgW7xO4RR9ep4CwWqiIIUFzMCFH9X32LphBhtYrM+F1kftjEFhYC4rnAjGqk
         A05puX7E18a/kYgOZwODGrFlyDB94FLQf9ZpxF1yzM1eTeX5xwkFsygEDmF8WksHuUVx
         kBSdU4ch7RbuCo9kXnaz5JX1+RtagE7tav2HA29dMpCtOYDxv7qmQNhxWiecjmjzDm9R
         zvuMsj5kgvhxHycBIMXdNnU6br8QF4FtX1yl575+oAIW9+9p6sgZNC7Yiixw0XZSMP24
         fVRfYg76MVLQ0R4nlB9iTvpNX4vmBQeytXqAOizPKwiz19xTUQrMSUd9zdfd5Lil6vT5
         8hTA==
X-Gm-Message-State: AOUpUlGNm4Bo//jnYGQ5gANnSZAS13dz6zTZgCrOoiSvz/641MfOsUyR
        8hWlWo94VUEicG8dC7vkhRg=
X-Google-Smtp-Source: AAOMgpfiT9PG60TchG0B4ORWoH6tChiGo8tEs70mPfxBRV/bIQ7KFLYf6XQctRTtAxer2gHs243K1Q==
X-Received: by 2002:adf:862b:: with SMTP id 40-v6mr6841591wrv.255.1531762882421;
        Mon, 16 Jul 2018 10:41:22 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id w9-v6sm37855645wrr.77.2018.07.16.10.41.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 10:41:21 -0700 (PDT)
Date:   Mon, 16 Jul 2018 19:41:19 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     xlpang@linux.alibaba.com, tglx@linutronix.de, frederic@kernel.org,
        lcapitulino@redhat.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com, tj@kernel.org,
        linux-tip-commits@vger.kernel.org
Subject: Re: [tip:sched/core] sched/cputime: Ensure accurate utime and stime
 ratio in cputime_adjust()
Message-ID: <20180716174119.GA4514@gmail.com>
References: <20180709145843.126583-1-xlpang@linux.alibaba.com>
 <tip-8d4c00dc38a8aa30dae8402955e55e7b34e74bc8@git.kernel.org>
 <20180716133751.GC2494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716133751.GC2494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Sun, Jul 15, 2018 at 04:36:17PM -0700, tip-bot for Xunlei Pang wrote:
> > Commit-ID:  8d4c00dc38a8aa30dae8402955e55e7b34e74bc8
> > Gitweb:     https://git.kernel.org/tip/8d4c00dc38a8aa30dae8402955e55e7b34e74bc8
> > Author:     Xunlei Pang <xlpang@linux.alibaba.com>
> > AuthorDate: Mon, 9 Jul 2018 22:58:43 +0800
> > Committer:  Ingo Molnar <mingo@kernel.org>
> > CommitDate: Mon, 16 Jul 2018 00:28:31 +0200
> > 
> > sched/cputime: Ensure accurate utime and stime ratio in cputime_adjust()
> > 
> > If users access "/proc/pid/stat", the utime and stime ratio in the
> > current SAMPLE period are excepted, but currently cputime_adjust()
> > always calculates with the ratio of the WHOLE lifetime of the process.
> > 
> > This results in inaccurate utime and stime in "/proc/pid/stat". For
> > example,  a process runs for a while with "50% usr, 0% sys", then
> > followed by "100% sys". For later while, the following is excepted:
> > 
> >   0.0 usr,  100.0 sys
> > 
> > but we get:
> > 
> >   10.0 usr,  90.0 sys
> > 
> > This patch uses the accurate ratio in cputime_adjust() to address the
> > issue. A new 'task_cputime' type field is added in prev_cputime to record
> > previous 'task_cputime' so that we can get the elapsed times as the accurate
> > ratio.
> 
> Ingo, please make this one go away.

Sure, I've removed it from sched/core.

Thanks,

	Ingo
