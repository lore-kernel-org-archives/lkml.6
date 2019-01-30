Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB7DC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CEA521473
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="G71dg7fP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731494AbfA3PyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 10:54:13 -0500
Received: from mail-it1-f181.google.com ([209.85.166.181]:56261 "EHLO
        mail-it1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730879AbfA3PyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 10:54:12 -0500
Received: by mail-it1-f181.google.com with SMTP id m62so10903927ith.5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 07:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UFXl6eSt7YREHuSXVl+VGiJiGCCG/lipfkwNUV78+c0=;
        b=G71dg7fPN2FM6D5c2wd1HeUSkUy6tkDT1v2JDJG5Ga82gFxy3ZoQqDvZ04qScXPZwM
         ViF1ZrvyM72uB/gyGNlEePzCT+M7DRgZdMQRa2hzpeha6N1ccn65nmRMlTJqPc5Io086
         DaLuAqxhT9AWMTvaxKcfwK21X3wbMkwe8I106Cx1GqEAxSVoHsCwq+SgP9Qx7A5q+pt4
         3+w2sJ7N+/bxUx8a/vK4C5CuKsP+oX1b3Gl5mbFhS7c2nf34Oc/1QUVhpwcU/t2nP1W2
         /e2ZDD9Uedhyp3+a5YjOs9+rDY3XiDLTz9jvcknnl36a+/9AAG5qVt5HZ88QDWmKvsGS
         3eMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UFXl6eSt7YREHuSXVl+VGiJiGCCG/lipfkwNUV78+c0=;
        b=d1da8oiqgoEhLS6u073dtdMKRSgqu5q5YgUeOQQQF12pw02JrNE1EBZew5m54q0dG/
         l0khOKoNfbf1oWXEfzfZBIV/tujFfZShyXPLNbUt1JbOBJBRkRWi5voqHvF3r3oZ+6c1
         7/np3RAywPbVbWqQAYVNilJhatyWui6bSeOyJW8HC39LrA/LoFOPGNJaX+RxhayyLzq8
         wsJNSrDPm3nBFVDq0U+iBFTrI9Nult0GEOlP+tbYymb6uIYxdFsoSzHHtTb8NxYL7i23
         o3bWOUVN4BH/DV8aSqp5A8AxtVu18FCPTQfQgDuOvcK/Pu8X5pA9nLsjACQntRWrbyMU
         eSLA==
X-Gm-Message-State: AHQUAubh7f1W5FTK66Ve5ZuZPSUHkg0vCngTH8C8+l7y+06x7PM+EZOP
        /Eom+4NyRhMG3jjEpT3g/puPP7jPGHM=
X-Google-Smtp-Source: AHgI3IY2oQrIgeRKkOH5l1gUeyCviox90H926k55DRaeK3pXxE6nNaSv4CjJAsTBLgEMDSrcwhsx3Q==
X-Received: by 2002:a24:be0b:: with SMTP id i11mr6503334itf.0.1548863651077;
        Wed, 30 Jan 2019 07:54:11 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id h14sm800356ior.41.2019.01.30.07.54.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 07:54:10 -0800 (PST)
Subject: Re: [PATCH] blk-mq: fix a hung issue when fsync
To:     Jianchao Wang <jianchao.w.wang@oracle.com>
Cc:     m19@florianstecker.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1548838916-25051-1-git-send-email-jianchao.w.wang@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <319fffef-2fa8-afff-8f93-1ce8fd721581@kernel.dk>
Date:   Wed, 30 Jan 2019 08:54:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1548838916-25051-1-git-send-email-jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/30/19 2:01 AM, Jianchao Wang wrote:
> Florian reported a io hung issue when fsync(). It should be
> triggered by following race condition.
> 
> data + post flush         a flush
> 
> blk_flush_complete_seq
>   case REQ_FSEQ_DATA
>     blk_flush_queue_rq
>     issued to driver      blk_mq_dispatch_rq_list
>                             try to issue a flush req
>                             failed due to NON-NCQ command
>                             .queue_rq return BLK_STS_DEV_RESOURCE
> 
> request completion
>   req->end_io // doesn't check RESTART
>   mq_flush_data_end_io
>     case REQ_FSEQ_POSTFLUSH
>       blk_kick_flush
>         do nothing because previous flush
>         has not been completed
>      blk_mq_run_hw_queue
>                               insert rq to hctx->dispatch
>                               due to RESTART is still set, do nothing
> 
> To fix this, replace the blk_mq_run_hw_queue in mq_flush_data_end_io
> with blk_mq_sched_restart to check and clear the RESTART flag.

Applied, thanks.

-- 
Jens Axboe

