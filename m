Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A66C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AB6721EA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="sVQQ1Gwb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AB6721EA2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732427AbeHIR45 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 13:56:57 -0400
Received: from mail-yw1-f44.google.com ([209.85.161.44]:46935 "EHLO
        mail-yw1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732298AbeHIR45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 13:56:57 -0400
Received: by mail-yw1-f44.google.com with SMTP id e23-v6so4735285ywe.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 08:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q+ybpDce2iHfmfRedVYwQZPbXrq5puum25iLpbPcm+k=;
        b=sVQQ1GwbtgjJHMZdFMjdB2wIZHwdFpyHLMH4v4500uAedUyKe/FwD/qhp04Qmb/ymE
         ULUIhXrY/8Duu2bau/6FG0rT9I4LyNU0SVlGeoxf+h3+estv2Ms0PR9OBjAep8djwraH
         TOL1Nih/PSn3RcS7HY9mAPWai3/QA81UIMW9jEUS27RvjcBGY4XKNEazM2555SD6A3Qo
         9XEeqHu6FquupXx9bKRsjCuq4VT6Y3UKgB0IL9cySuPgSAc/Tbb+ViNo3M8OJ2fH4grz
         KHgFYo/jjCA2CX1hyApiknC3Xjn5mj2HUltXlRLvygNnNbIItrieiaXht6tcBnI4TgWq
         DDBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q+ybpDce2iHfmfRedVYwQZPbXrq5puum25iLpbPcm+k=;
        b=HH8gOhi+fSur60WY06HVY+HDpmBC4+Y2PQcis76H6CjKA0xitceUqdkuQmNWeoS/VW
         azaFHR7dDBfM/3eNGeR9agpFWlWeHiBzHtP7s1AJ8eBZPzXaCYdkNFADrEk/Lr/NmShI
         5wpgupdxWVmpBqcI7u2iusfyPcfIG7GJRN1VXfz0BnAhZgR/e55KnLIo5g9paJ10qzuq
         v9uXUDgVU4/bX6LjUfG3Nl7k6Sh0CQIDCiC4zRcThECD1IRxXkYZPE1swbPbaljRp6AG
         eJ4OIHmxzA+DByCtW0ffWLiFihe4bmjCVrVxbDmTxKGo/cmX3T1ckt9leK26nY0g3hjN
         vDBA==
X-Gm-Message-State: AOUpUlEqXnActRbxkduCrd6tKdCvaTHN4nHAoTsORByoczn6b3Pw1Kxj
        8scsZUfGuIy+VxvF53SoRpHW4w==
X-Google-Smtp-Source: AA+uWPyTSeHsuZMsHAJnhaZxlW7MK9Ca9trFrV/SUGrzpEz8Ens3sLnjGhArLeD/yWTYjSoiF1boEA==
X-Received: by 2002:a25:e905:: with SMTP id n5-v6mr1364769ybd.516.1533828691597;
        Thu, 09 Aug 2018 08:31:31 -0700 (PDT)
Received: from localhost ([2620:10d:c091:180::1:7b61])
        by smtp.gmail.com with ESMTPSA id 141-v6sm3575958ywj.65.2018.08.09.08.31.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 08:31:30 -0700 (PDT)
Date:   Thu, 9 Aug 2018 11:34:30 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     mhocko@kernel.org, Vladimir Davydov <vdavydov@virtuozzo.com>,
        Oleg Nesterov <oleg@redhat.com>,
        David Rientjes <rientjes@google.com>,
        syzbot <syzbot+bab151e82a4e973fa325@syzkaller.appspotmail.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: WARNING in try_charge
Message-ID: <20180809153430.GA17445@cmpxchg.org>
References: <0000000000005e979605729c1564@google.com>
 <e2869136-9f59-9ce8-8b9f-f75b157ee31d@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2869136-9f59-9ce8-8b9f-f75b157ee31d@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2018 at 10:57:43PM +0900, Tetsuo Handa wrote:
> From b1f38168f14397c7af9c122cd8207663d96e02ec Mon Sep 17 00:00:00 2001
> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Date: Thu, 9 Aug 2018 22:49:40 +0900
> Subject: [PATCH] mm, oom: task_will_free_mem(current) should retry until
>  memory reserve fails
> 
> Commit 696453e66630ad45 ("mm, oom: task_will_free_mem should skip
> oom_reaped tasks") changed to select next OOM victim as soon as
> MMF_OOM_SKIP is set. But we don't need to select next OOM victim as
> long as ALLOC_OOM allocation can succeed. And syzbot is hitting WARN(1)
> caused by this race window [1].

Huh? That's the memcg path, it has nothing to do with ALLOC_OOM.

> Since memcg OOM case uses forced charge if current thread is killed,
> out_of_memory() can return true without selecting next OOM victim.
> Therefore, this patch changes task_will_free_mem(current) to ignore
> MMF_OOM_SKIP unless ALLOC_OOM allocation failed.

I have no idea how the first and the second half of this paragraph go
together. They're completely independent code paths.
