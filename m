Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C375C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09574206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="cs1re/c8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbfAITcu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 14:32:50 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:33524 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbfAITct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 14:32:49 -0500
Received: by mail-yb1-f195.google.com with SMTP id o73so3473661ybc.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 11:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O4SjDf2Eom+NqkhpwSG754n944E1besDDQFOgs46hQE=;
        b=cs1re/c8RvAwJqtuGDRVoNJe4HHvoCurdGO3uPqQVDEHSfalvvbtXbDPKAWsTSwlQE
         ugQMvr9yCyatf6rFM6s2kPiQ1ljFw5+AvELUf9r/HhUcv4MFIatTFCKgLGOB5BT//UMX
         tMxQFhSJd76DJR2CP8uTF2Akb8bz9WcyNYuF06wwL4yCnJkj1m5sl8AzwpUqcOvcVPzc
         Kd7baE9YZrTERSgPP2xU0dod9repNpcD1akfqDqiS6dZ/0uc8PGz561m5pBEIxxdYaco
         Qrf0fGe5n1OaDgQBYYVej1Y9SVjdwGAubpNCcv66ogyNxSZM2EjzBXFVR91IoI4+6rFj
         Xe5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O4SjDf2Eom+NqkhpwSG754n944E1besDDQFOgs46hQE=;
        b=YVo6hJc880olCrepn2Mc8GhjrB01IjCTyFRgqIR/296VB5kWQr3HnxP1q4ty3Ub9r8
         CYKvl/WSod8E1MhZ7XuDzPVyw8gyraXuQL7DjPfrKQ87kJ7Z9uBom8zO1qjx6UNc/Hw0
         NAVoEBaGtlwMZnsPYyo+GE60em/O+XghSnKMUV3RcTWtw0bUplEOkw7XHDokuQWCL/e7
         hKD1AgCLRyrf0s1t3AB3mOZjDacK2fgJ21UekHuExALpZLw6YhAC4pcQ72vrfHZzMhz7
         UTpulXyPwfQgaTzytDPB86k+1pg9ZGW4gFu3L6ypgWE+6i2Oje5SC03KWU51uYvzdAEB
         oLKw==
X-Gm-Message-State: AJcUukeCLbuUPbpbQjeUE7xj1+98zaS5aotAQBX4ClnoTylFG6mc0al2
        G2w99fYl8Fce0BYHaZbM5VBWUA==
X-Google-Smtp-Source: ALg8bN6RocS19BzsjiS4YBiJk29e92PIWI06J7k0C6v5wkZdZXgcfyKSrivwme20e7dS1zMk1jCvAA==
X-Received: by 2002:a5b:383:: with SMTP id k3mr6762374ybp.438.1547062368821;
        Wed, 09 Jan 2019 11:32:48 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::7:f15b])
        by smtp.gmail.com with ESMTPSA id c140sm45825851ywa.74.2019.01.09.11.32.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jan 2019 11:32:48 -0800 (PST)
Date:   Wed, 9 Jan 2019 14:32:47 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     mhocko@suse.com, shakeelb@google.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC v3 PATCH 0/5] mm: memcontrol: do memory reclaim when
 offlining
Message-ID: <20190109193247.GA16319@cmpxchg.org>
References: <1547061285-100329-1-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547061285-100329-1-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 03:14:40AM +0800, Yang Shi wrote:
> 
> We have some usecases which create and remove memcgs very frequently,
> and the tasks in the memcg may just access the files which are unlikely
> accessed by anyone else.  So, we prefer force_empty the memcg before
> rmdir'ing it to reclaim the page cache so that they don't get
> accumulated to incur unnecessary memory pressure.  Since the memory
> pressure may incur direct reclaim to harm some latency sensitive
> applications.

We have kswapd for exactly this purpose. Can you lay out more details
on why that is not good enough, especially in conjunction with tuning
the watermark_scale_factor etc.?

We've been pretty adamant that users shouldn't use drop_caches for
performance for example, and that the need to do this usually is
indicative of a problem or suboptimal tuning in the VM subsystem.

How is this different?
