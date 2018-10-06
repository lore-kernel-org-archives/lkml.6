Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7229CC64EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 03:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3259A213A2
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 03:12:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3259A213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729425AbeJFKOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 06:14:08 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34453 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726919AbeJFKOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 06:14:07 -0400
Received: by mail-pf1-f196.google.com with SMTP id k19-v6so5915837pfi.1;
        Fri, 05 Oct 2018 20:12:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CrlANVbBXs5JGvkHTjl/dhpKTstM6Ljvh1WcfzwIkTk=;
        b=jPijW4ZLfQpngUp3ViwsD2Y8Fu+m4u6uxxGf9Mozv/l4kANqOO4zh2X4BS5iAfVAXE
         bK3oZYPAQYiT+1vwNDNloSq3+J4onG+jP5oIpkYExnURRM1IQsVt0JP5+xi6iYZRimwr
         pqROzU8uNxIh44Lvw/Nq+dVTkDUnJYHKOsLNkBGYcFyfF8cN3ojjrznGjJzzKGTOnbtu
         Zz2dcJK2JAe57cYzwfYYbnlmwhJ2h2TrYtgIpvD6THswwoOVxcNQ2Gw4HH524M1EGAw5
         u6gM0RR3w9085BaXYKnulmkF7IC5VO7tW84h/l6lS0K0rOoJ5mOqUjmUc1RexDWMWBwO
         K/Ng==
X-Gm-Message-State: ABuFfogY+OFUiP+iRIPol/ACNs9grHPbuUnBj9n4vtY+3mF6592NyLM9
        Zaab4+l5tjqo/p2XzqcusFgupEHWH5EkPQ==
X-Google-Smtp-Source: ACcGV60vt0thEFT/IFJdCdaI1179ELHPkMVl8AHFxlKNeTArKWZHrDZwIYs5MgfQNWZDFZ+k+uyGHw==
X-Received: by 2002:a63:4107:: with SMTP id o7-v6mr12673225pga.256.1538795550196;
        Fri, 05 Oct 2018 20:12:30 -0700 (PDT)
Received: from asus.site ([2601:647:4601:42b4:3842:3e31:3bb6:cf62])
        by smtp.gmail.com with ESMTPSA id 84-v6sm20127910pfs.108.2018.10.05.20.12.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 20:12:29 -0700 (PDT)
Subject: Re: [PATCH] block: BFQ default for single queue devices
To:     Jan Kara <jack@suse.cz>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
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
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <20bfa679-3131-e0af-f69d-2fbec32fbced@acm.org>
Date:   Fri, 5 Oct 2018 20:12:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181005091626.GA9686@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/18 2:16 AM, Jan Kara wrote:
> On Thu 04-10-18 15:42:52, Bart Van Assche wrote:
>> What I think is missing is measurement results for BFQ on a system with
>> multiple CPU sockets and against a fast storage medium. Eliminating
>> the host lock from the SCSI core yielded a significant performance
>> improvement for such storage devices. Since the BFQ scheduler locks and
>> unlocks bfqd->lock for every dispatch operation it is very likely that BFQ
>> will slow down I/O for fast storage devices, even if their driver only
>> creates a single hardware queue.
> 
> Well, I'm not sure why that is missing. I don't think anyone proposed to
> default to BFQ for such setup? Neither was anyone claiming that BFQ is
> better in such situation... The proposal has been: Default to BFQ for slow
> storage, leave it to deadline-mq otherwise.

Hi Jan,

How do you define slow storage? The proposal at the start of this thread 
was to make BFQ the default for all block devices that create a single 
hardware queue. That includes all SATA storage since scsi-mq only 
creates a single hardware queue when using the SATA protocol. The 
proposal to make BFQ the default for systems with a single hard disk 
probably makes sense but I am not sure that making BFQ the default for 
systems equipped with one or more (SATA) SSDs is also a good idea. 
Especially for multi-socket systems since BFQ reintroduces a queue-wide 
lock. As you know no queue-wide locking happens during I/O in the 
scsi-mq core nor in the blk-mq core.

Bart.
