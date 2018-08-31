Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA16C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 23:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DE4920841
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 23:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQSxv0Y1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DE4920841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbeIADZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 23:25:59 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44254 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727175AbeIADZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 23:25:59 -0400
Received: by mail-pl1-f193.google.com with SMTP id ba4-v6so6081955plb.11;
        Fri, 31 Aug 2018 16:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Moh6buiZCtTFeGgHIcC8OSQ92HOZv/0w4cMeUXtqmzs=;
        b=iQSxv0Y1e3DmCCrD4sxrZWOOEUAOG7StK+aypzLseICivO2susNwVm73cUSjz6GGvZ
         d4TOkh814oO4AZfSR8VPzq9QZx/LLWufmnCAaIIdI98qMelhQ1qYXwo4INJiMzxV+f2E
         wVvSI39hUOtjuFZQlMcBMJyon2UD6k8+M3DCkPuesYnC7EQfSw5J3CbOZuXCR/dmhaKv
         4Eex++//NNg8xer4fjsNze+ZxlujIJsyPZZ+1RNMb9VLVbxux7X3feVF7u6OR8f7cKv9
         KDKFFeQfVPRk8jly3M5DAOR3WlUksxACSefCCxf67Hd443fbYw6Q/A7FukmShiHpHxjj
         5oVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Moh6buiZCtTFeGgHIcC8OSQ92HOZv/0w4cMeUXtqmzs=;
        b=XxT96ud4lp3Dhf2veRbw9WeBziQzRoA3HjtqYo69/bZxvhuhD8lb4YlL7SfmPmnY1F
         UHuOqLH84cifC/wsgvD9e3CJbSwbVZ5NX10zPSkW4uRq68KirnqZdd2uq8mjrKv3KL5l
         9nWW7NfgEg0Nh6IbROIsN8GSzwAXZs2yBRb00cQdLh/AZ+EDYh5oiJ1xBa+JX33K84do
         c0x0/6ETIWd8UFBW4FbocxWaKQchqq2VbDywrXjJIqoniOF2MRElPnFTg4Y/LoX/j8kW
         jUgMSgUEF5L4J0B6PXDl9sLzQxZCyS0mwRkzxZv1JAGrgIi6w0nQl3stF8B1gmMxIvpf
         gIog==
X-Gm-Message-State: APzg51CrFlT0twXNlTfiE0b8zl3jbzLtXXvcqvuIWgS/3xrn3o/lTOop
        r3j1/Qj2uGBdMc/amnbBCPo=
X-Google-Smtp-Source: ANB0VdZRQ1NMYKSqDi5odelWN4/DhCcO21fI9ayhnUF3+NdTRV0M6GwvyMx8+c8aam0TWmMjQ/wkTw==
X-Received: by 2002:a17:902:42a5:: with SMTP id h34-v6mr18018795pld.228.1535757374610;
        Fri, 31 Aug 2018 16:16:14 -0700 (PDT)
Received: from localhost ([2620:10d:c090:180::1:a245])
        by smtp.gmail.com with ESMTPSA id b6-v6sm9951453pfh.182.2018.08.31.16.16.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 16:16:13 -0700 (PDT)
Date:   Fri, 31 Aug 2018 16:16:09 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Dennis Zhou <dennisszhou@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/15] blkcg: always associate a bio with a blkg
Message-ID: <20180831231609.GD1488037@devbig004.ftw2.facebook.com>
References: <20180831015356.69796-1-dennisszhou@gmail.com>
 <20180831015356.69796-7-dennisszhou@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180831015356.69796-7-dennisszhou@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Aug 30, 2018 at 09:53:47PM -0400, Dennis Zhou wrote:
> From: "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
> 
> Previously, blkg's were only assigned as needed by blk-iolatency and
> blk-throttle. bio->css was also always being associated while blkg was
> being looked up and then thrown away in blkcg_bio_issue_check.
> 
> This patch beings the cleanup of bio->css and bio->bi_blkg by always
             ^
	     begins

> +int bio_associate_create_blkg(struct request_queue *q, struct bio *bio)
> +{
> +	struct blkcg *blkcg;
> +	struct blkcg_gq *blkg;
> +	int ret = 0;
> +
> +	/* someone has already associated this bio with a blkg */
> +	if (bio->bi_blkg)
> +		return ret;
> +
> +	rcu_read_lock();
> +
> +	bio_associate_blkcg(bio, NULL);
> +	blkcg = bio_blkcg(bio);
> +
> +	if (!blkcg->css.parent) {
> +		ret = bio_associate_blkg(bio, q->root_blkg);
> +		goto assoc_out;
> +	}
> +
> +	blkg = blkg_lookup_create(blkcg, q);
> +	if (IS_ERR(blkg))
> +		blkg = q->root_blkg;
> +
> +	ret = bio_associate_blkg(bio, blkg);
> +assoc_out:

Maybe if/else instead of goto?

Other than that,

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
