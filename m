Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20D2ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 976512084E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:30:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWMBkxfe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 976512084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732154AbeGSQOb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 12:14:31 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:35648 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730899AbeGSQOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 12:14:31 -0400
Received: by mail-yb0-f196.google.com with SMTP id x15-v6so3420405ybm.2;
        Thu, 19 Jul 2018 08:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=g4Zr28DVOj84QY7szq3yRIAxlimqHglCuCxjWlH9YW0=;
        b=YWMBkxfelbOQ+qIePoSMIS0ClcZXhErnpXQJcKCxs+GJ3zKUkIaFrP+OkGff2hF+yV
         DhLkJCLXllK4yRhyKJ8i0zyzYgmm56r9gYQezioRNuhqwr7zYAjCfhV0iwYPL/MLXDAx
         6epXNN2p5sZrnKS2wt1SU83Mp6jpuYNyaqcmv+shflalBkRaCU0PMInb9ffeXRbBiHYp
         7cvhH+ccy1PxpKAhmyKdEijC/X01jn3NfBJBilXjrypKN5SmyURb2o4Qa05Itj3K0qIf
         u4IqgBHCsCXLHA0QCQ1fIrE9MwZXS0J192mG1RbGTfgbvXppttUtdHkxFrtdfUi3gvXj
         zZug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=g4Zr28DVOj84QY7szq3yRIAxlimqHglCuCxjWlH9YW0=;
        b=o/284FQOhoceNP7XUgDSy0VDlfRAjHKK/Hgu4HHq+IFDCuTlLkd1qAvKRIC6D/+0Zh
         RLHoCTrvM83jFpfAd569ev14W+5LkDzYSfcgGVnd/pYb+CAKAk0hy7aD1+3RiNJag8VQ
         gPzbwhr6BNS8mjS4iVcc/eWivA3/i5IlnWqBVSiYuRXCIbAEFnLTRXcKuSdQeEY02/WH
         S+Zyw8LWzu5a8voVPr/PTz1MqjaBc4Exu3VXSeDUZuiq0ZSJ+6sFCiuvr7ksW9lO9gam
         wpP7u6fBbb4oBHsYzmsXbImn7fw7o9LOsxHIu5VwuQTtpf53oHy/0GtBU3AVV9m3J3E4
         PD4g==
X-Gm-Message-State: AOUpUlFKUtz8RTu8ETnVw/ODlqkRfla5yUo9hOrk1A/56T/5Um3jW1cb
        /xltazwpn+Nq7aBoWK1/PrUO62kF
X-Google-Smtp-Source: AAOMgpfGd3vnL8EMa50fxU3v1fnmLQ71jzSE4a8nWuFZOXWBtcO9DVyFsEdD1dBXvT/jec4T/KEj7g==
X-Received: by 2002:a25:3604:: with SMTP id d4-v6mr5719007yba.106.1532014248517;
        Thu, 19 Jul 2018 08:30:48 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::1:7eec])
        by smtp.gmail.com with ESMTPSA id f137-v6sm7781895ywb.52.2018.07.19.08.30.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 08:30:47 -0700 (PDT)
Date:   Thu, 19 Jul 2018 08:30:45 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kernel-team@fb.com, pjt@google.com, luto@amacapital.net,
        Mike Galbraith <efault@gmx.de>, torvalds@linux-foundation.org,
        Roman Gushchin <guro@fb.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH v11 7/9] cpuset: Expose cpus.effective and mems.effective
 on cgroup v2 root
Message-ID: <20180719153045.GT72677@devbig577.frc2.facebook.com>
References: <1529825440-9574-1-git-send-email-longman@redhat.com>
 <1529825440-9574-8-git-send-email-longman@redhat.com>
 <20180702165322.GI533219@devbig577.frc2.facebook.com>
 <bc59aa0a-70fd-583f-452d-9a947757cb69@redhat.com>
 <20180703155823.GS533219@devbig577.frc2.facebook.com>
 <20180719135224.GE2494@hirez.programming.kicks-ass.net>
 <1107494a-9667-df58-dcac-9366e969dc3a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1107494a-9667-df58-dcac-9366e969dc3a@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Jul 19, 2018 at 10:04:54AM -0400, Waiman Long wrote:
> > Why would a container not be allowed to create partitions for its
> > various RT workloads?
> 
> As far as I understand, Tejun has some concern about the way that
> partitioning works is inconsistent with how other resources are being
> managed by cgroup v2 controllers. I adds an incremental patch to
> temporarily disable the creation of partition below the first level
> children to buy us time so that we can reach a compromise later on what
> to do. We can always add features, but taking away features after they
> are made available will be hard.
> 
> I am fine either way. It is up to you and Tejun to figure out what
> should be made available to the users.

So, the main thing is that putting a cpu into a partition locks away
the cpu from its ancestors.  That's a system level operation which
isn't delegatable.  If we want to allow partitioning in subtrees, the
parent still be able to take away partitioned cpus too even if that
means ignoring descendants' configurations, which btw is exactly what
cpuset does for non-partition configs.

I don't think this would be technically too challenging to implement,
but unless there are immediate use cases for it, we can start simpler
& restricted.

Thanks.

-- 
tejun
