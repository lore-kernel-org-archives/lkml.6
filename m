Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE92BC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 15:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6396321527
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 15:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CVvR3mFO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6396321527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388072AbeHBRvI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 13:51:08 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:44303 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387645AbeHBRvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 13:51:07 -0400
Received: by mail-yb0-f193.google.com with SMTP id l16-v6so1245172ybk.11;
        Thu, 02 Aug 2018 08:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M3klYL2uA16Rv+kKtnJ/HBA6++FkoRU9kQl21iYfCSs=;
        b=CVvR3mFO0wOCKbKWq6Af8u2IrlQSMCkVvymGPyFNadJ7XT6EfXgmGrTSO2rEHGKBTt
         vipRCJS+ReokgEev3gIhPXKWwss8ue+pyEz9hLW+GvXnNA2FI165OuE+cWs6A8W2HsdA
         t8gCpIBTnkz1DY4l28OICu0sbzUBp30GgdoBIAgTgNwcdPm3jP5xoWIjooPNVoRXYlag
         7eKjzlZ1yGM/ZF+k5X/rCjrPMdDTY+wjkp1gh30Jsn1DBvyhB0q2EpDbucU0w2Ht/Yjc
         PhpKGrQEoDLR44kxM1UjHTGfXJLZYyqcxyFBFPJePWVEP5L0zIy5+Q+zE1J4dGWTQrsB
         t5Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=M3klYL2uA16Rv+kKtnJ/HBA6++FkoRU9kQl21iYfCSs=;
        b=bAiXb4NGkEvT0IC/EICCSttbKxf0vt0lG45PMXVhVKQ29Dko3FzwX34h6QKCSaDrLu
         7e8MjMLY8iFvwqWjqpE0EM+6BRzZy9Jkx8Mf6kJI2eSP+paGHPED159uPdpXUp9dz5LN
         XQFqjKYDe8lCHNiPUYNYH75YpnZo89AzGY+VNWqE1fgQX8gCySOGGBArZMv7yC7o3TDx
         bu6xa7/XwvBqPaQvS2f95Dkmhnuc2JzUkimZk+tQ0Nbol1BOmU+npR6Qz2aXKIGvXFOd
         o8ED2vGa3zKl9bGlJfLwHAb6A8NnmA1Hbz1axeUsAz/CZ4cwAP5H6HRx8cfxrvUSShv0
         Motg==
X-Gm-Message-State: AOUpUlE5s0JGXuvhJakB3FHCkfSJEH4XRFNuIgoZc15LXqNb7MLzbOlv
        K7sqmHL28mtEgSwAViFlLP4=
X-Google-Smtp-Source: AAOMgpfGw+QQhjO1eisvcJ8IVmC3NVwwMRWln4V1YAnjSWxspuAGf4yopXuDSRqxu9xYNrgWloo5Xw==
X-Received: by 2002:a81:8947:: with SMTP id z68-v6mr39234ywf.310.1533225560213;
        Thu, 02 Aug 2018 08:59:20 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::3:c239])
        by smtp.gmail.com with ESMTPSA id m19-v6sm977638ywd.90.2018.08.02.08.59.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 08:59:19 -0700 (PDT)
Date:   Thu, 2 Aug 2018 08:59:17 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Dennis Zhou <dennisszhou@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <jbacik@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>, kernel-team@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] block: make iolatency avg_lat exponentially decay
Message-ID: <20180802155917.GT1206094@devbig004.ftw2.facebook.com>
References: <20180802061541.49173-1-dennisszhou@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180802061541.49173-1-dennisszhou@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Dennis.

On Wed, Aug 01, 2018 at 11:15:41PM -0700, Dennis Zhou wrote:
> From: "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
> 
> Currently, avg_lat is calculated by accumulating the mean of every
> window in a long running cumulative average. As time goes on, the metric
> becomes less and less useful due to the accumulated history.
> 
> This patch reuses the same calculation done in load averages to make the
> avg_lat metric more lively. Unlike load averages, the avg only advances
> when a window elapses (due to an io). Idle periods extend the most
> recent window. Bucketing is used to limit the history of avg_lat by
> binding it to the window size. So, the window range for 1/exp (decay
> rate) is [1 min, 2.5 min) when windows elapse immediately.
> 
> The current sample window size is exposed in the debug info to enable
> calculation of the window range.
> 
> Signed-off-by: Dennis Zhou <dennisszhou@gmail.com>
> Acked-by: Tejun Heo <tj@kernel.org>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Acked-by: Josef Bacik <josef@toxicpanda.com>

Heh, sorry about not thinking this up from the beginning but I think
it'd be great to move this to blkcg core so that the stat is always
available regardless of blk-iolatency.  It's a really important metric
and can be used for both monitoring and policy implementation.

Thanks!

-- 
tejun
