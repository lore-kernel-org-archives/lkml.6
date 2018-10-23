Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BEFCC67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 19:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5075820671
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 19:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqaiSjv4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5075820671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbeJXEXo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 00:23:44 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:46307 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725740AbeJXEXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 00:23:44 -0400
Received: by mail-yw1-f65.google.com with SMTP id j202-v6so1070701ywa.13;
        Tue, 23 Oct 2018 12:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gdSq9bF0nedG9Ber+aOH1to6mh30wA2VJb0a3wsWazw=;
        b=nqaiSjv40eEZfi2hLDuh+E0hMknzXjzR3nElOJYcdjE7GLcbrhJTsAXifLlqGi5Z/O
         WVfxCKSV2x4CfGZqUw7BQd6b8Kfk7PLQR5X9rNIno+SWjg91tBV/WyNJBcX+HuvLE5UZ
         SPUHkXstZtcE7UExcHviwr39MGKM2T8bZiXmITfFeLAVN2sOuHhR1M8CQjTyGmtIZWLS
         n5tqJpkw24cQMGg+g6ohFIi2Oz+zfe/spdwj4shrq8/ohevq9ecSBh4WUpDrlXFxTpo1
         eeUiGUTlrFVF/2wNFwmjQa7RvAkt6eYHIZpczABgZe7+e2gvrLGUaSo5RToGURIVBJ10
         ogbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=gdSq9bF0nedG9Ber+aOH1to6mh30wA2VJb0a3wsWazw=;
        b=BfQBBDoY7qmGZSlulN+0NQxp9SQCXyLpROlvNdUNK82b/r9EcmNm1NmInYq3Z7g7VX
         9iKOWDe+ug/+rvLAU/K341zZKkKq4W73qs2N5060Dsgt8Vm/rzefB68edOY1qSMhYpnN
         ItaRhOVqDM46LfBpk9kJvdURAhGo8vkTG/+mkkVsVN2QgUXR6uut2M/flAlqyRc4LUtc
         0YtAzvTiHLwVlQ9SQIxK0wNbscRWRbDWAF5tqXiW7M1/SBvIFqJ/O1FISd9GBRSImZ9w
         rZycT+Nsnbi/laU7HJmOpHJmhdgi6POb8Mkll/kQs2vM4OyZ+LYR6KwbrNXpKI/iYsaB
         X5EA==
X-Gm-Message-State: ABuFfoisExXFDGIkw+KPlraRhOdyTbZwKTVXUDhWrYdckEGJ+U7J73Rv
        A1beShSv9P8+i9T0o4kbOmQ=
X-Google-Smtp-Source: ACcGV63XAvBMtpgMSK+JKA7OFDeb8E9GexggZvQ5vUg7oyO+IWw+PpVYwziT3KZJJT1CeURTGWmSAA==
X-Received: by 2002:a0d:f546:: with SMTP id e67-v6mr36951858ywf.304.1540324731577;
        Tue, 23 Oct 2018 12:58:51 -0700 (PDT)
Received: from localhost ([2620:10d:c091:180::1:c0bc])
        by smtp.gmail.com with ESMTPSA id 80-v6sm1162072ywh.55.2018.10.23.12.58.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 12:58:50 -0700 (PDT)
Date:   Tue, 23 Oct 2018 12:58:48 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [RFC PATCH] cgroup, netclassid: add a preemption point to
 write_classid
Message-ID: <20181023195848.GC4182586@devbig004.ftw2.facebook.com>
References: <20181018085617.28456-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181018085617.28456-1-mhocko@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 10:56:17AM +0200, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
> 
> We have seen a customer complaining about soft lockups on !PREEMPT
> kernel config with 4.4 based kernel
...
> If a cgroup has many tasks with many open file descriptors then we would
> end up in a large loop without any rescheduling point throught the
> operation. Add cond_resched once per task.
> 
> Signed-off-by: Michal Hocko <mhocko@suse.com>

Applied to cgroup/for-4.20.

Thanks.

-- 
tejun
