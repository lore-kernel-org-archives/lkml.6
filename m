Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 199CAC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 16:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A16B1208D5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 16:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="phuNN0F4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A16B1208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbeH0U12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 16:27:28 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:39877 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726995AbeH0U12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 16:27:28 -0400
Received: by mail-yb0-f195.google.com with SMTP id c4-v6so6255087ybl.6;
        Mon, 27 Aug 2018 09:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UvrArh45BLr7dWBLMCweGOwgpp4+m2LYlxRRHm51Jzo=;
        b=phuNN0F4ps2C5485v2LFVyv4QPgAcc44HNZUyH4veVibq87+zzQadCt9vn8UKN6j/A
         OeyOWgOQpiXbHIW7L2BZKgWoJAyJk5rRk8LkWO+19ZcIVTM42n8b4if3hTHaDwN91/qD
         zDFuyAeTJGV/SyfGym+mWhE//yaBjxFU+ochk6dWNwgWljA65lgKcfQ61FMCsVxTbHnc
         YmxnxfyautknIUs+TKlNOA8CDByHcgR0FBfAeHD9yt5Yw8Adr9pAg36pFAg0RlstopCK
         q/TzU5Kw+QwRLyahiKaE8dlz0kM3NPXbwqtEIWGqWzSBhpaTo5haNublN9L0L7/bls5A
         7J9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=UvrArh45BLr7dWBLMCweGOwgpp4+m2LYlxRRHm51Jzo=;
        b=ew+TFc2oqusK0isa4HrPe0PnNdTPRul33HIraE4+DJQVG2MPqlCoA+IT8kHXfb6tYx
         kLl7EDzuOWwGe1qBaXnqkDq7jNjSfAGFZecYR/m+Xl2+lX4yWoqGPaWYG+wIWwW8lKFX
         3DAo7RysEwqYH4JR4t2DfH1IndnUDdSz7koGrYwImNhSgx7f6x0+FXO3WTCKcUU7RqNi
         pdY3OtH4B7DlXL0CFYR2Sqe6ftHAshB7H3cp8kraUUY3eeKwFaDnNwQZkZEZfy7spADf
         Fejwvt5b4rM3SEYo438igQWmcGHZzCelJVCixUoDfDuRG/7bs3tCCS9tX7FxlXoNApxd
         QC1w==
X-Gm-Message-State: APzg51DrmOJsluf5M41+t1lvazVgtjXRKkCutJ7EmPZXOABnm90/l+Re
        TbGYAoKelXrNxg1/oh9ZibE=
X-Google-Smtp-Source: ANB0VdbibjDDSiTJtPTXELmox5dMNF+0enhdXx07txC9yphFPfdP3E3aIZPs/3tt+A6wt80uNopuLg==
X-Received: by 2002:a25:b4b:: with SMTP id 72-v6mr7341982ybl.415.1535388007399;
        Mon, 27 Aug 2018 09:40:07 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::1:2a0f])
        by smtp.gmail.com with ESMTPSA id 138-v6sm6697388ywj.30.2018.08.27.09.40.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 09:40:06 -0700 (PDT)
Date:   Mon, 27 Aug 2018 09:40:04 -0700
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
Subject: Re: [PATCH v12 9/9] cpuset: Support forced turning off of partition
 flag
Message-ID: <20180827164004.GE3978217@devbig004.ftw2.facebook.com>
References: <1535380884-31308-1-git-send-email-longman@redhat.com>
 <1535380884-31308-10-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535380884-31308-10-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Waiman.

On Mon, Aug 27, 2018 at 10:41:24AM -0400, Waiman Long wrote:
> Cpuset allows arbitrary modification of cpu list in "cpuset.cpus"
> even if the requested CPUs won't be granted in "cpuset.cpus.effective"
> as restricted by its parent. However, the validate_change() function
> will inhibit removal of CPUs that have been used in child cpusets.
> 
> Being a partition root, however, limits the kind of cpu list
> modification that is allowed. Adding CPUs is not allowed if the new
> CPUs are not in the parent's effective cpu list that can be put into
> "cpuset.cpus.reserved". In addition, a child partition cannot exhaust
> all the parent's effective CPUs.
> 
> Because of the implicit cpu exclusive nature of the partition root,
> cpu changes that break that cpu exclusivity will not be allowed. Other
> changes that break the conditions of being a partition root is generally
> allowed. However, the partition flag of the cpuset as well those of
> the descendant partitions will be forcefully turned off.

First of all, thanks a lot for your persistence.  I'm not necessarily
against the flag being forced off but wonder whether the same
config/effective approach can be used as in .cpus and .mems.  Can you
elaborate a bit on the choice here?

Thank you.

-- 
tejun
