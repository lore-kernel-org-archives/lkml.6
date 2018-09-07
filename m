Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42237C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0C0D20844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qdtROdG6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0C0D20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbeIGVdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 17:33:55 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:35094 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbeIGVdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 17:33:54 -0400
Received: by mail-yb1-f194.google.com with SMTP id o17-v6so5694413yba.2;
        Fri, 07 Sep 2018 09:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AYh0rsaO0mmz5DzqRm/SBc9j8B8bdzOEyVdu2zac50c=;
        b=qdtROdG6MlI2jCeC8xPFJSCUsMb7JD7bxiKFKFDmA/o2LEJVqp737ya+RlQoKKsJvp
         lz0s8SDgxQptPm1+xTE3ZO2Bba1zBpbyvi0qepNCWwTC6H1EO/bLWIZE7YWTLPa+l4sy
         K1waJ9082Ka+RN68p0kVmJ2Y6Inb80QDcs3PbgMK+dV5zJY2hxzxGwsa2Xdj5yjLru7a
         sC/ZwVAqywy3UIgQuGcPxbEO57VuTG8keXI9n6clbrcWSFlvZkS+tkXBDJFg+QxiIU1S
         2xymJ7ATjJzGENiDHS68iDIsmDDkgTvoTBwAHX3KbnUyzGY2Wt5qx+jSUMNHh/0+4tje
         GxVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=AYh0rsaO0mmz5DzqRm/SBc9j8B8bdzOEyVdu2zac50c=;
        b=bUU7hHCOgOXB7kj2rR3ho2Zfvc8a1dFYCtJ4FMbHoTjNUHUo88HJ3XlOpzMfH3e+7c
         5emed4HzdJCMMUyTLDj9T1/Bzg+Ary+oI48t8Kf8bqWlHgnCL2qtTp6JH2fv4LhRf3Wu
         snDK7Fm0qUXbSK0+m5lhsRrY5G77KaFwnuNCC3wpRPkjL2ZDO1c9o4B+WyOlmZw3n8/Q
         B5oNdAOgH9sLUo/zhPAQN/PCmTfjwyR81lB/LO4UAeApBcxpwuw7dCZqQYNyncVjKWza
         h86qBL5KwADsxW7HI/CmoxHe/3ftgKj8qJT1wY/U1deACnVPJXm3MF4xTrNDUVx+UO5u
         2h2A==
X-Gm-Message-State: APzg51Aa7w0pTSIkk19tJdVAPFzcMBNq7Cx5AhQrVbCwRW3152BIOZbm
        wIDYz1li5JsFtBVGhYXYcKg=
X-Google-Smtp-Source: ANB0VdZ/p0WcGd/k7iQjQbU9LpuuQVmDOQRYx/T52iXkehXhl4xGfh41/ePaQfQ39XPIvq3m75nlyQ==
X-Received: by 2002:a25:1fc1:: with SMTP id f184-v6mr4415450ybf.164.1536339127116;
        Fri, 07 Sep 2018 09:52:07 -0700 (PDT)
Received: from localhost ([2620:10d:c091:180::1:70a9])
        by smtp.gmail.com with ESMTPSA id x131-v6sm2864348ywd.81.2018.09.07.09.52.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 09:52:06 -0700 (PDT)
Date:   Fri, 7 Sep 2018 09:52:03 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Dennis Zhou <dennisszhou@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/12] blkcg: fix ref count issue with bio_blkcg using
 task_css
Message-ID: <20180907165203.GA1100574@devbig004.ftw2.facebook.com>
References: <20180906211045.29055-1-dennisszhou@gmail.com>
 <20180906211045.29055-2-dennisszhou@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180906211045.29055-2-dennisszhou@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 05:10:34PM -0400, Dennis Zhou wrote:
> From: "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
> 
> The accessor function bio_blkcg either returns the blkcg associated with
> the bio or finds one in the current context. This can cause an issue
> when trying to associate a bio with a blkcg. Particularly, it's the
> third case that is problematic:
> 
> 	return css_to_blkcg(task_css(current, io_cgrp_id));
> 
> As the above may race against task migration and the cgroup exiting, it
> is not always ok to take a reference on the blkcg returned from
> bio_blkcg.
> 
> This patch adds association ahead of calling bio_blkcg rather than
> after. This makes association a required and explicit step along the
> code paths for calling bio_blkcg. blk_get_rl is modified as well to get
> a reference to the blkcg it may use and blk_put_rl will always put the
> reference back. Association is also moved above the bio_blkcg call to
> ensure it will not return NULL in blk-iolatency.
> 
> BFQ and CFQ utilize this flaw, but due to the complexity, I do not want
> to address this in this series. I've created a private version of the
> function with notes not to use it describing the flaw. Hopefully soon,
> that code can be cleaned up.
> 
> Signed-off-by: Dennis Zhou <dennisszhou@gmail.com>

Acked-by: Tejun Heo <tj@kernel.org>

-- 
tejun
