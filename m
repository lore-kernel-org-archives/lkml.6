Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0CACC677E8
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 16:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABD65208E7
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 16:21:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABD65208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbeJFXYh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 19:24:37 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34622 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725266AbeJFXYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 19:24:37 -0400
Received: by mail-pf1-f196.google.com with SMTP id k19-v6so6476108pfi.1;
        Sat, 06 Oct 2018 09:20:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JBqo3Tigp6DrtN5FjWh5ypYxgjKNLr6+l7/PhoYCzh8=;
        b=hdsEzOmwFG5Xj3EXuQdTL9KYDZ2TB+zQpSHvvKvJbVqGVKDWaYoKaNNmYlC16WTIiM
         eDSAmuWVhYdmcLfubflDLnVhXHp0ZQVuH5T9DHzhuXCD5cAARjKbkpUvo2Pbed0AVriT
         5tLBvJD9VLQMZjyT5ZvWLmmDVcZPaZXqS9z/ITM9yoaz25pjYQBKVQm4+t1P0T1bTrM0
         uPMga5TxyMe5AIV8jAy2NZTerM9eboAU0zcNSwBIhOIY2zlyvzpgKNqu4WkA/P9XPix/
         0YFVsJSkvP1VD8gYDWZ4rlNwhSpycWeDEbRdJoKHHP6taQLMuxubuopt1cX0R7SL8Ia1
         McYw==
X-Gm-Message-State: ABuFfoiHRJoBXwd9MN+rEqugiK33MMcbu/Feqqod+6LhkFy3dMcoaYTE
        VbhQDPRUVZEp9TQg3mJwyBIqxlQBHHXSww==
X-Google-Smtp-Source: ACcGV63OAs8X0d2qzhpIefz2rYsmMDM4Wf9/RqoOFbHQNjJplD04IjgNYQlmQvx97JrJ24KRh8O5lw==
X-Received: by 2002:a62:210:: with SMTP id 16-v6mr17838256pfc.100.1538842839318;
        Sat, 06 Oct 2018 09:20:39 -0700 (PDT)
Received: from asus.site ([2601:647:4601:42b4:3842:3e31:3bb6:cf62])
        by smtp.gmail.com with ESMTPSA id y24-v6sm1391463pfn.123.2018.10.06.09.20.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Oct 2018 09:20:38 -0700 (PDT)
Subject: Re: [PATCH] block: BFQ default for single queue devices
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Jan Kara <jack@suse.cz>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-mtd@lists.infradead.org, Pavel Machek <pavel@ucw.cz>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andreas Herrmann <aherrmann@suse.com>,
        Mel Gorman <mgorman@suse.com>,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20181002124329.21248-1-linus.walleij@linaro.org>
 <05fdbe23-ec01-895f-e67e-abff85c1ece2@kernel.dk>
 <B5321A64-8A1A-42FF-A337-F4524BDA179B@linaro.org>
 <1538582091.205649.20.camel@acm.org> <20181004202553.71c2599c@alans-desktop>
 <1538683746.230807.9.camel@acm.org>
 <A017CAC7-41E6-4BB3-AC31-5EB524276138@linaro.org>
 <1538692972.8223.7.camel@acm.org> <20181005091626.GA9686@quack2.suse.cz>
 <20bfa679-3131-e0af-f69d-2fbec32fbced@acm.org>
 <A6518C7A-C7DF-48A6-A57A-F4B4162DC16E@linaro.org>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <bb934140-ef97-05b3-2bfc-d82be4766578@acm.org>
Date:   Sat, 6 Oct 2018 09:20:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <A6518C7A-C7DF-48A6-A57A-F4B4162DC16E@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/18 11:46 PM, Paolo Valente wrote:
>> Il giorno 06 ott 2018, alle ore 05:12, Bart Van Assche <bvanassche@acm.org> ha scritto:
>> On 10/5/18 2:16 AM, Jan Kara wrote:
>>> On Thu 04-10-18 15:42:52, Bart Van Assche wrote:
>>>> What I think is missing is measurement results for BFQ on a system with
>>>> multiple CPU sockets and against a fast storage medium. Eliminating
>>>> the host lock from the SCSI core yielded a significant performance
>>>> improvement for such storage devices. Since the BFQ scheduler locks and
>>>> unlocks bfqd->lock for every dispatch operation it is very likely that BFQ
>>>> will slow down I/O for fast storage devices, even if their driver only
>>>> creates a single hardware queue.
>>> Well, I'm not sure why that is missing. I don't think anyone proposed to
>>> default to BFQ for such setup? Neither was anyone claiming that BFQ is
>>> better in such situation... The proposal has been: Default to BFQ for slow
>>> storage, leave it to deadline-mq otherwise.
>>
>> How do you define slow storage? The proposal at the start of this thread
>> was to make BFQ the default for all block devices that create a single
>> hardware queue. That includes all SATA storage since scsi-mq only creates
>> a single hardware queue when using the SATA protocol. The proposal to make >> BFQ the default for systems with a single hard disk probably makes sense
>> but I am not sure that making BFQ the default for systems equipped with
>> one or more (SATA) SSDs is also a good idea. Especially for multi-socket
>> systems since BFQ reintroduces a queue-wide lock.
> 
> No, BFQ has no queue-wide lock.  The very first change made to BFQ for
> porting it to blk-mq was to remove the queue lock.  Guided by Jens, I
> replaced that lock with the exact, same scheduler lock used in
> mq-deadline.

It's easy to see that both mq-deadline and BFQ define a queue-wide lock. 
For mq-deadline its deadline_data.lock. For BFQ it's bfq_data.lock. That 
last lock serializes all bfq_dispatch_request() calls and hence reduces 
concurrency while processing I/O requests. From bfq_dispatch_request():

static struct request *bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
{
	struct bfq_data *bfqd = hctx->queue->elevator->elevator_data;
	[ ... ]
	spin_lock_irq(&bfqd->lock);
	[ ... ]
}

I think the above makes it very clear that bfqd->lock is queue-wide.

It is easy to understand why both I/O schedulers need a queue-wide lock: 
the only way to avoid race conditions when considering all pending I/O 
requests for scheduling decisions is to use a lock that covers all 
pending requests and hence that is queue-wide.

Bart.
