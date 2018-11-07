Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96937C32789
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 03:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5917B20827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 03:14:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5917B20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731019AbeKGMmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 07:42:52 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37744 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727315AbeKGMmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 07:42:52 -0500
Received: by mail-oi1-f195.google.com with SMTP id w66-v6so12692274oiw.4;
        Tue, 06 Nov 2018 19:14:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IBkm5TQkuBdN3RU5v2en//G1yJVEbNdafwIuACP78yM=;
        b=TIfg0iqRVisKlJz5PgxvGNRxSo+B5B+P9huiTx8PE7+5bLS62bI+PLGErrDJsXZPkG
         sSR368Dv7UYByyUBrZ8dNZcQCrKqBeo+D0thmmB3PHmkHj4Ttujpi471Brf2EmzmNV8t
         Ago+hylV2X1wVfVT4DvwJpD+ADq/M5BCMxm4xWzqhs8bV7q4FuNsDqG60ff/FiquRxO/
         +Ac7YrftgUFoZ3cnPPYHYPg4ZLVp7Au98lFufPog7lifeh9eQeB6HRX5++F2v9Ja4Gez
         iNTnLvo4LF32bF4Roqr8uh/7TnA3jFC2xjvuH8JwVaaMgzPex+BKPbHGn8Szgr9yEIPt
         K/eA==
X-Gm-Message-State: AGRZ1gJfwLA9bFIcX7J6Q1keXQe3j7WM0zxScqP1hVyjGvVv5TjzESda
        BJwd+eL3Dda7XZrBk39Qkx8=
X-Google-Smtp-Source: AJdET5cXPyQ2Jqwmreas/xGFbfjQ87R8VCrVyy+2+2MrfIp9BHDEcu2ifeT3G/MY+9vHtO+wcX5S8Q==
X-Received: by 2002:aca:b256:: with SMTP id b83-v6mr77931oif.310.1541560464831;
        Tue, 06 Nov 2018 19:14:24 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id d140-v6sm9230064oig.7.2018.11.06.19.14.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 19:14:24 -0800 (PST)
Subject: Re: [PATCH] block: respect virtual boundary mask in bvecs
To:     Ming Lei <tom.leiming@gmail.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@fb.com>,
        linux-block <linux-block@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>
References: <20181105102301.9752-1-jthumshirn@suse.de>
 <20181105105548.GC12367@ming.t460p>
 <7c649b43-f952-cf94-93d6-44fb153acced@suse.de>
 <20181105120153.GD12367@ming.t460p>
 <3c3dd9c2-4240-7bb5-c0ff-af6f2e479c31@suse.de>
 <CACVXFVNOAc1HEPmfu9n8vMjqY2hK8fVqe4Em-g+dvSRLavpO8w@mail.gmail.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <f670cdbd-ece6-9051-e6f8-0814a44fe82b@grimberg.me>
Date:   Tue, 6 Nov 2018 19:14:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CACVXFVNOAc1HEPmfu9n8vMjqY2hK8fVqe4Em-g+dvSRLavpO8w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> blktrace won't help on this issue because .bv_offset isn't recorded.
> 
> This patch makes sense on >4KB PAGE_SIZE. If your issue happens on
> ARCH with 4K PAGE_SIZE, maybe you should root cause why it makes a
> difference on iSer. And it is highly possible there is bug somewhere.

I don't suspect that this is the case. unless all the vec elements
happen to have an offset but if that is the case I don't think that
this patch would've solved this.

It can't really be an iser issue because iser does not control bio
splitting/merging... it can only ask the block layer to obay the
virt_boundary.
