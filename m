Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21136C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD4F0208A3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B05LDMxX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD4F0208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389868AbeHARgV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 13:36:21 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:38098 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389557AbeHARgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 13:36:21 -0400
Received: by mail-yw0-f195.google.com with SMTP id r3-v6so7364614ywc.5;
        Wed, 01 Aug 2018 08:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MPNWcKhR9kEfAC1T/LYad4ecIG6j4g+V/GFDmFpdeQA=;
        b=B05LDMxXIIMTg0tM3cmrL4rPmASb98sMBLwg7UXNRh4eIaf0tydM9FEEQq4Aeq3kP5
         ZnkT8TzLdejuXtJGnP9CDZqrCNkv9bun16l+f9rYMVzb/Rkc7veMAYlExBzqfvWsYwaq
         RLsiLHfRDdQ0HLxBWsi6zgNkG6cwq1yX4LJzFv+j7G1/llt8ERqSQ+M3Xq2E8t7fm8FU
         zMKc+3vUd/1i8e/IUob9+6aWyYsDFBnQBLYXs9JLVRH6byt2HHz9w5lFYUlf0siKgwdg
         4gDC516ZNWtKKjhXLfGdDVxXCNUTOxlrZco5LzNRW8452P7UvPvujjqWPnwCw/yOyRf+
         RgJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=MPNWcKhR9kEfAC1T/LYad4ecIG6j4g+V/GFDmFpdeQA=;
        b=cyQJt8QzMqU9v8sDfxP4yOcuMpC4sAda6Cp6j+pGDgfAftE6BIdPpDCcOPiyzm7wJd
         T+vaCxIn5w1d+9+0kVNBN1ra8DSPp9uzExVqQ4e5yfsIhflutjbOVBQVAgs6UcZeQSZ5
         GKKAm4GqNTc1EYjicDk45S+exF9SJja9nynYiXZxLDc/t6laCAfMA9W1cZi7WaxLxKX4
         c+1+3B1+DkIApwWl1OcOKxyW7at5qlWSaXJVzi6ciY0Wu6qAs79AHVrq3r/vQRlp+AVV
         Oad4zEkGeL+YTPISxoaSg0OLOqC+iUD9FWdczlR6J5gO0cfZcvTedrBCdzGRnya+q+kl
         RG6A==
X-Gm-Message-State: AOUpUlGM2vxxvmZ8H13tZaP/NVv+8xw8OQp/S+fXQ7hufdv8oUCgGH12
        CmZwT0srdkMwcJqROuvMMRI=
X-Google-Smtp-Source: AAOMgpcZAk+dr1qHvbpjPe0UAN5stzxIu8CQMiwydXAoCqLZ2TBtszgIS/MSlUf5sBFRwFJ9qWsoHw==
X-Received: by 2002:a81:8:: with SMTP id 8-v6mr13714108ywa.176.1533138601030;
        Wed, 01 Aug 2018 08:50:01 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::2:d2a6])
        by smtp.gmail.com with ESMTPSA id y188-v6sm4423438ywe.2.2018.08.01.08.49.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 08:50:00 -0700 (PDT)
Date:   Wed, 1 Aug 2018 08:49:58 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Dennis Zhou <dennisszhou@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <jbacik@fb.com>,
        kernel-team@fb.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH v2] block: make iolatency avg_lat exponentially decay
Message-ID: <20180801154958.GP1206094@devbig004.ftw2.facebook.com>
References: <20180801002559.36261-1-dennisszhou@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180801002559.36261-1-dennisszhou@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Jul 31, 2018 at 05:25:59PM -0700, Dennis Zhou wrote:
...
> +	/*
> +	 * CALC_LOAD takes in a number stored in fixed point representation.
> +	 * Because we are using this for IO time in ns, the values stored
> +	 * are significantly larger than the FIXED_1 denominator (2048).
> +	 * Therefore, rounding errors in the calculation are negligible and
> +	 * can be ignored.
> +	 */
> +	exp_idx = min_t(int, BLKIOLATENCY_NR_EXP_FACTORS - 1,
> +			iolat->cur_win_nsec / BLKIOLATENCY_EXP_BUCKET_SIZE);

Build bot is complaining about naked 64bit div.  Should use one of the
div64*() helpers.

Looks good to me.  Once Johannes's concerns are addressed, please feel
free to add

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
