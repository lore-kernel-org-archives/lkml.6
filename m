Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D32C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E1E622B72
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMbjnSkb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E1E622B72
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753522AbeGCP63 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:58:29 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:41461 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752905AbeGCP60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:58:26 -0400
Received: by mail-yw0-f195.google.com with SMTP id j5-v6so866657ywe.8;
        Tue, 03 Jul 2018 08:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nii9mXkoQMCWlubnGZW1vSGDl4mWcQn5io/dub3SdCo=;
        b=mMbjnSkb1YTbJVSZVMLSG2YYrNCxAdx1Th+DNOidqVgr8ZZITfQUxADeFDB7Sw/mNI
         Pr0b4XxNNSbnAtkVidmJhSvW5DFMA/BSXYaNJtCMU53e0B1+dter1johTak6nunifBmr
         /y+BZ6B7mmWKMb/EImvgLSYbYYMMmKIP52bqz6Mf9ZtX0Fial94ds9EjyhhDyMRY6IbN
         rAg8qTyF1Vl0az2qAFD8J3C3rVJJWpo1xO1Dwo8edpa535aWDf28loucOsoBeOGtb7Oc
         L3PwqTtwSTUc0Ax1T5QP4a56OVVsasRXJKFTQqv/lOkdvSbuzlsop6yssDW9IeoBNpIQ
         Op6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=nii9mXkoQMCWlubnGZW1vSGDl4mWcQn5io/dub3SdCo=;
        b=pnh35WmJMXJD0RNev7v7BNM1b5j+HUDvMk0BwsE1KeU4d2i+0kHM50G1yvO/uiKEHU
         erFxcq//uSCPaLGMSmRvtFIq1ABqC/D+8C8+R0gkNSEPVlvfJR9gRAzLLDiaclBslv21
         NdaqrpEEl08XikreRhyIeKhcZgqIDtlx8sOIreySlyMW5kuW/i0zeur7h0ZlYQPoccls
         xIBLUD0D2fEcWMHtBOHEhA7MZjKQ8LOrYPhvsp5bSH5/kFOSPO2VxN1C9aUnWJQIpYiz
         o5jAxxqSjs91FWLHl4K86vqvdfOw3LQSBRck1vj3cp5SYPgjVsW0m/6Q/aT17pTpiAzS
         4H8w==
X-Gm-Message-State: APt69E3J7tyhuV1mEfBIJEs86dI1fZh9fYsZb9NNiIk4H1tmeF/cGFz9
        wTLsY0wFlb2BKfWozB9vdp5S28qQ
X-Google-Smtp-Source: AAOMgpcL5R/P/QvVWEvuFkOaXLP0YafGFNUzMukmRD601cH1dFBGT1d27YuXwhIWeEgzWeQ8RpFUJA==
X-Received: by 2002:a81:a692:: with SMTP id d140-v6mr2883465ywh.50.1530633506055;
        Tue, 03 Jul 2018 08:58:26 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::3:a4be])
        by smtp.gmail.com with ESMTPSA id l3-v6sm449477ywm.103.2018.07.03.08.58.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 08:58:25 -0700 (PDT)
Date:   Tue, 3 Jul 2018 08:58:23 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kernel-team@fb.com, pjt@google.com, luto@amacapital.net,
        Mike Galbraith <efault@gmx.de>, torvalds@linux-foundation.org,
        Roman Gushchin <guro@fb.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH v11 7/9] cpuset: Expose cpus.effective and mems.effective
 on cgroup v2 root
Message-ID: <20180703155823.GS533219@devbig577.frc2.facebook.com>
References: <1529825440-9574-1-git-send-email-longman@redhat.com>
 <1529825440-9574-8-git-send-email-longman@redhat.com>
 <20180702165322.GI533219@devbig577.frc2.facebook.com>
 <bc59aa0a-70fd-583f-452d-9a947757cb69@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc59aa0a-70fd-583f-452d-9a947757cb69@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Waiman.

On Tue, Jul 03, 2018 at 08:41:31AM +0800, Waiman Long wrote:
> > So, effective changing when enabling partition on a child feels wrong
> > to me.  It's supposed to contain what's actually allowed to the cgroup
> > from its parent and that shouldn't change regardless of how those
> > resources are used.  It's still given to the cgroup from its parent.
> 
> Another way to work around this issue is to expose the reserved_cpus in
> the parent for holding CPUs that can taken by a chid partition. That
> will require adding one more cpuset file for those cgroups that are
> partition roots.

Yeah, that should work.

> I don't mind restricting that to the first level children for now. That
> does restrict where we can put the container root if we want a separate
> partition for a container. Let's hear if others have any objection about
> that.

As currently implemented, partioning locks away the cpus which should
be a system level decision, not container level, so it makes sense to
me that it is only available to system root.

Thanks.

-- 
tejun
