Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0791CC433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 00:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DD4D2084C
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 00:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BsbuMufJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DD4D2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbeIAEpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 00:45:13 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38319 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbeIAEpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 00:45:13 -0400
Received: by mail-pf1-f193.google.com with SMTP id x17-v6so6212720pfh.5;
        Fri, 31 Aug 2018 17:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KSYqO/7kLlYe8MN733EJtGY7cjl/cnw+tgVUdvuckTQ=;
        b=BsbuMufJxIsRMXpj9XFw2HJnBuLDt4UOdQk51T3VJRgZC9TNYc5DJnvUTKn1g6Wlje
         NwuZ15tvdagzj7fNPq1/ZvunhR4ClEwUSd7du2gc2iTPyDwBwBMneAp/Fglf1o4ulu96
         qdajnd39WK6Tf8+iFaYPc/IwTc8jFd/56oAkzzYEpk8BX+yVlLYmT0WobC8PLnme2uN5
         MucL8h8FJFvezVBZ0XICWfUeAqcelb+shkzp/ooHMDbdPCFiciqtc1wx2ru25NTsuHkO
         A+zN66aLgxgIayQAyl6heVVaWaDTv5nTbmTtvBZJPfw9JICBCdkXq0faG8xhNkCF3kSr
         4K6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=KSYqO/7kLlYe8MN733EJtGY7cjl/cnw+tgVUdvuckTQ=;
        b=UgfdiBMJyEFTBXJFdn4DS+VsDIEyJ3wTRg4wudzFAhsSDjkSNntQQE+sYPURTcZa59
         od4rDB9aDYff+tLUc3xsZg7/owjHVPUgynKvhJXD2G9szwOWvcohTTTFvrfPve4YUcai
         0trqSfkIJybv4Fg8jafFvcfeHJOWiHd+CJITVVhgoeXxeNLHACYYwB5PHO+yPNicguG7
         w7yWXEkhYQZ2GPnBv/mpOCex9VoCR7zRL9l7KAFAL9LmxMLl1BlWzRykcBhbHpR9ki6T
         d+Y763pkaA6bILZw8s15+DAkbat9AUiW8C/uphym5vm0ShBX3wHWEK7XGH8kvtmU8nBQ
         KZpA==
X-Gm-Message-State: APzg51D3bs6S/F+BBIFgFXTI81J/dIELMgEpGfHRpi0oJMUHa7mCY+yN
        rN9MHWqWUPb7HvlYn5/8R3M=
X-Google-Smtp-Source: ANB0VdaU7rvGetxoPawxOuTwRQYsIi+RcXmQ6/8EAd3PcviN4AilBudf95GgoMQuWTQDRcnQFP8Hsw==
X-Received: by 2002:a62:7983:: with SMTP id u125-v6mr18288022pfc.177.1535762114165;
        Fri, 31 Aug 2018 17:35:14 -0700 (PDT)
Received: from localhost ([2620:10d:c090:180::1:a245])
        by smtp.gmail.com with ESMTPSA id z5-v6sm16375570pfh.83.2018.08.31.17.35.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 17:35:13 -0700 (PDT)
Date:   Fri, 31 Aug 2018 17:35:10 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Dennis Zhou <dennisszhou@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/15] blkcg ref count refactor/cleanup + blkcg avg_lat
Message-ID: <20180901003510.GM1488037@devbig004.ftw2.facebook.com>
References: <20180831015356.69796-1-dennisszhou@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180831015356.69796-1-dennisszhou@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Aug 30, 2018 at 09:53:41PM -0400, Dennis Zhou wrote:
> This is a fairly lengthy patchset that aims to cleanup reference
> counting for blkcgs and blkgs. There are 4 problems that this patchset
> tries to address:
>   1. fix blkcg destruction
>   2. always associate a bio with a blkg
>   3. remove the extra css ref held by bios and utilize the blkg ref
>   4. add average latency tracking to blkcg core in io.stat.

1 is already merged.  Reviewed 2, 3 parts.  Generally looks great.
Let's try to address the found issues and get these two parts merged
first.

Thanks.

-- 
tejun
