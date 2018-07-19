Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC29C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 17:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C6F620671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 17:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMxux7mt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C6F620671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732093AbeGSSKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 14:10:03 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:43857 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731751AbeGSSKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 14:10:03 -0400
Received: by mail-yw0-f194.google.com with SMTP id l189-v6so3354756ywb.10;
        Thu, 19 Jul 2018 10:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hkpwUBwM3Y5AyhzYYuS8+vNKG4CoFqS7MqCRsCqif6A=;
        b=dMxux7mtw7eZXdGQRMepih1kYfgQuOlxDNm+/j62pQ1/WfoQjkEsOlhiMAox/kNEnQ
         359CsA8FfwlyNzP70XKopSkIo2sbxY1+OZyzN3nwa65DKtUiE5qDA6cxGSNWWIW9WTN3
         Qu8DyEL8d1ibyvAOytf/29zvoasZkTmm0EIdH4CddXPXq7WfOGQVKWG1VKQpFtHNivmk
         AFCezOkeZscvCvcwQShkSko4x0CovKFvCDA+K4+JYz7tsS2Fo9PYQHtv9KXBk1t/uNko
         yiYwcqjVa3qm48Ijt8nFrhE2ey4Hhqn/Tn0dSHDGvTFcc4I6deLPl7hJEHifW2ywxKL1
         spEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=hkpwUBwM3Y5AyhzYYuS8+vNKG4CoFqS7MqCRsCqif6A=;
        b=fZFfjMRPpbGtwM1UZBN8kancIgAJ6bsOd0jo8zck09SRY73vY810yreUyu3t1otL9P
         qsom7C0GxS75ixYkVu5khtrIQi/cza9nn+/AVedEuZP708qSsXrDtSn+PQbiAsT/Acah
         hNGsGFZVJvAf3Vu/EZV9QL8jmzBCmCAu06EbfpAxTFZ+xZU2cGKHCiHp5k5IESsu+bWI
         qrAkgMhaeBULrUJF+oU67pU2WKfGIxX5YKYQWlolPbjAF+yDM3KbT29V0HRvJueQHQEe
         Euf5DBYMuU6yDttWDskV9OF7uCPZ8V+CR2uDX0I7kz1aB4JzNHMfo3Zcn19DUzf6OM2o
         8qFg==
X-Gm-Message-State: AOUpUlHeToS+k34hBazTnwAEo99e0h/dynCbnvHa5BfVL6dU69wZtBm8
        tx3kqFa2oxQ0qwt26JtvAP+TCX2u
X-Google-Smtp-Source: AAOMgpdxgR2MadYgS35cwg8g1GGCqkYMsqUxMjeUfWzP7pxPMMXXbvJwJ17U0+Y2k0xDZRDsMVexbw==
X-Received: by 2002:a81:3b0d:: with SMTP id i13-v6mr5769654ywa.465.1532021153660;
        Thu, 19 Jul 2018 10:25:53 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::1d36])
        by smtp.gmail.com with ESMTPSA id j4-v6sm2788130ywe.36.2018.07.19.10.25.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 10:25:52 -0700 (PDT)
Date:   Thu, 19 Jul 2018 10:25:51 -0700
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
Message-ID: <20180719172551.GW72677@devbig577.frc2.facebook.com>
References: <1529825440-9574-8-git-send-email-longman@redhat.com>
 <20180702165322.GI533219@devbig577.frc2.facebook.com>
 <bc59aa0a-70fd-583f-452d-9a947757cb69@redhat.com>
 <20180703155823.GS533219@devbig577.frc2.facebook.com>
 <20180719135224.GE2494@hirez.programming.kicks-ass.net>
 <1107494a-9667-df58-dcac-9366e969dc3a@redhat.com>
 <20180719153045.GT72677@devbig577.frc2.facebook.com>
 <de6f931d-613a-3e6a-2a4d-0e49b3bfe2e5@redhat.com>
 <20180719165201.GU72677@devbig577.frc2.facebook.com>
 <69903192-8711-6a1e-0cd0-fbb249a4204b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69903192-8711-6a1e-0cd0-fbb249a4204b@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Waiman.

On Thu, Jul 19, 2018 at 01:22:36PM -0400, Waiman Long wrote:
...
> Do you want a way at the parent level to take CPUs away from child
> partitions? The "cpus.subpart" file can probably be used also for this
> purpose, but we have to decide what taking CPUs away from child
> partition means. Does that mean automatically turn off the partition
> flag in the children if there is no CPU left in the partition? There are

Yeah, I think so.  That's what we do when cpuset.cpus or mems go empty
- ignoring the config.

> some implementation details that need to be fleshed out. I would prefer
> not doing this as this will complicate the code without too much benefit
> that I can see.

So, given how long this has been dragging along and it isn't yet super
clear to me why this needs to be fully hierarchical, I'd actually
prefer just restricting it to the first level children.

Thanks.

-- 
tejun
