Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20788C4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 18:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEA53217BB
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 18:35:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="ow0Etn14"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEA53217BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbeHDUhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 16:37:00 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42611 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728054AbeHDUhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 16:37:00 -0400
Received: by mail-lf1-f68.google.com with SMTP id u202-v6so6323336lff.9
        for <linux-kernel@vger.kernel.org>; Sat, 04 Aug 2018 11:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=w0B+vwkFZzidIzFZWW1UG56Av0zMA9drkDzlRaXwj4M=;
        b=ow0Etn14xwD1QfRP3JQChs74zAvmIkfQ9126CzwVX+GuXuYlL7xr8zmGlnxpSgML2O
         e04uQ57ak/u3AsWuZUkfKy/AOEieRb7SrLyrnuT/1Ip8WOTLsHo3dI+LL5RgKq1sLinR
         BNQMjvNI9OPlBspYR1ioU5MiamhukAKAFOP1igr/sJZq22BtpKWvV+4v38AsZFrTCoa7
         Q0pi3jrQ92B0Ng/fuCPWMNrELiBhsLeDOSa5zwE+Svv0vAGLUdmluXIkEcyGY9/WGOkk
         x5Y0E509RvR8xAwI08N4OxZFcOaZElamCwhQN16HskaKOzobL3Kbu6BVsSIL4BH70SwY
         e3uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w0B+vwkFZzidIzFZWW1UG56Av0zMA9drkDzlRaXwj4M=;
        b=bnS/yX5tD/vsbup9X0INQgLaGfOZ5FB9WxyL9mKudRZWThLqiLkDr3IFYQjoxkpF50
         30CYTYwDTmLFUK+IHgyyr3kLNmTs0rN/A/Qycc0NDkrF87keMBFZjKKKz2Cc1l+wBHUi
         4gZGoXoSW9hTjMSaecjcgVa2NavYloBdfGEbp/n6KR6Os97ByPn6U/NNzHh47JAwzOkO
         CLZ5hEJ0zsVYUbw6/1R32CAo+rKbV2k5tDXKEi67orgKC+91b06ifgucnWdVQoXQZ+4V
         QNQHzlIPW33PrgqJHZiFYdPcmB0RPgHNGivEWiOKcVM5moc3pJLCAL5qa6CEsiqbubGk
         cABg==
X-Gm-Message-State: AOUpUlEBvZDMhQDQ9oXZYPHISQqLAkATZEvnmEf2nNo/bwaJq/iXrK9u
        LHP38yrNq6zMrc9rVJofCsGcsg==
X-Google-Smtp-Source: AAOMgpdBQ22vlA/80vIxOcqcXdNLwxSKfUN/1sRr+pRmzS1MVG4MjNk6YV92eecn4Zs5pYgkLwQsOw==
X-Received: by 2002:a19:a417:: with SMTP id q23-v6mr7280101lfc.59.1533407725616;
        Sat, 04 Aug 2018 11:35:25 -0700 (PDT)
Received: from [192.168.0.10] (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.googlemail.com with ESMTPSA id x65-v6sm1291053lfb.60.2018.08.04.11.35.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Aug 2018 11:35:24 -0700 (PDT)
Subject: Re: [PATCH V2] lightnvm: pblk: take write semaphore on metadata
To:     javier@javigon.com
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, javier@cnexlabs.com
References: <1533303011-2855-1-git-send-email-javier@cnexlabs.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <17e4f9c3-856a-9e7b-8d36-e93ebc7dbf0b@lightnvm.io>
Date:   Sat, 4 Aug 2018 20:35:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1533303011-2855-1-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2018 03:30 PM, Javier González wrote:
> # Changes singe V1:
>    - Fix double I/O on the read path (by Matias)
>    - Improve commit message (by Jens)
> 
> pblk guarantees write ordering at a chunk level through a per open chunk
> semaphore. At this point, since we only have an open I/O stream for both
> user and GC data, the semaphore is per parallel unit.
> 
> Since metadata I/O is synchronous, the semaphore is not needed as
> ordering is guaranteed. However, if the metadata scheme changes or
> multiple streams are open, this guarantee might not be preserved.
> 
> This patch makes sure that all writes go through the semaphore, even for
> synchronous I/O. This is consistent with pblk's write I/O model. It also
> simplifies maintenance since changes in the metdatada scheme could cause
> ordering issues.
> 
> Signed-off-by: Javier González <javier@cnexlabs.com>
> ---
>   drivers/lightnvm/pblk-core.c | 18 ++++++++++++++++--
>   drivers/lightnvm/pblk.h      |  1 +
>   2 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
> index 00984b486fea..6432faf5b19c 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -493,6 +493,20 @@ int pblk_submit_io_sync(struct pblk *pblk, struct nvm_rq *rqd)
>   	return nvm_submit_io_sync(dev, rqd);
>   }
>   
> +int pblk_submit_io_sync_sem(struct pblk *pblk, struct nvm_rq *rqd)

Nitpicking a bit. It looks to me that a function that has semaphore in 
its name, should take the semaphore in all cases unless it returns an 
error. When it only does it on writes, it creates confusion.

Maybe this would be one of the cases where it is okay to have the logic 
it in the caller function, or do such that it takes a flag if it should 
take the semaphore. That'll make it explicit when it is done.
