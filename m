Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CABC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0213B2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:30:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="iaEmYd4l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0213B2087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbeH1FTY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 01:19:24 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:36314 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbeH1FTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 01:19:23 -0400
Received: by mail-it0-f68.google.com with SMTP id u13-v6so347369iti.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 18:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=k3aBFlsD/CdhjGraLQD8fxqQ4hCkP10o1wi2X/LhgWU=;
        b=iaEmYd4l/Ngc5EbXbtcGjO/XYzDmyuaURFMH4m3COJ9JnK7trx0v4l/2x0h2ZQk/i3
         ggCHBYiaxkVzE+xX8Le1+kslyGwz2dzQCYV8+7naIXOGRSm6qUICdJGK0XawW5aKHQ5s
         QiuZCTwuc+EZB1iqbXMFj30JQlfw8XE7A/qSnoGpZrd0wU3WC3OTJDyitNV31J5n7Lno
         JHUvmtNwHV6IaUPfJDaH+76yxRE+oTnhMM5dj2zKYZN5jQ0rBxJVpcx4PUxv8VkibEi0
         hzfp5Py5P+IQCEs4n2Oc++dL54M978HDtWWapYKRuQwjVX/u7vm96hVtZseI7DnFBxI7
         W7ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=k3aBFlsD/CdhjGraLQD8fxqQ4hCkP10o1wi2X/LhgWU=;
        b=s/PTNivylTGn2vyft+CX/snP57vwrX06tH9Y9nii/3Bn6t5vFE8t6p754wpYwNWgEA
         Ct3wjdb3HAMiBuh5Si/tuyyORav46FP5KMFq40FMMoUgbUJqekvGKPbjhzxGe4TNwmVm
         v+dG6LPKIJ7kvhAzxSeFz1xC/kf0y0luaRxRvasYyRcVh6lq1SuD29uqKxNivTsfO0ti
         ut1v5Aa6BQ3QpoFWHb8oHP3Q0sGfbm7apmyu+6TKJarIJh6NCQ+S21gmXphMGGQdAhz2
         jADsMUC62UkCoZkQvdt0cXR1MD0SwbE/S2U4jdCY7xnowrIFJPLHF066eMFb+Iue6J8Y
         rl0w==
X-Gm-Message-State: APzg51D02QwwOqg+a5rovog4a/3pS3dwS3sHkIhDhizNNoBIZj+uzgLi
        9gxUbPfW6qNIfmmbn6xAvPy2QvAObAc=
X-Google-Smtp-Source: ANB0VdbEvALOXv7FMEwzsknqo3UgiIKow/7wWhH4/KNiaOWD7iMloMMy3udDSONhKSgblpPqZ8opaQ==
X-Received: by 2002:a02:1cd:: with SMTP id 74-v6mr12547790jak.83.1535419812458;
        Mon, 27 Aug 2018 18:30:12 -0700 (PDT)
Received: from [192.168.1.212] (107.191.0.22.static.utbb.net. [107.191.0.22])
        by smtp.gmail.com with ESMTPSA id 14-v6sm368239itu.20.2018.08.27.18.30.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 18:30:11 -0700 (PDT)
Subject: Re: linux-next: new maintainer/tree for the libata tree?
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Tejun Heo <tj@kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180828071944.02b13db4@canb.auug.org.au>
 <27ef8afc-c490-5984-5a18-1ee5ce51d556@kernel.dk>
 <20180828112851.19c64e80@canb.auug.org.au>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0ee8b9e0-1576-c8c1-ed22-dd76a8d378ba@kernel.dk>
Date:   Mon, 27 Aug 2018 19:30:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180828112851.19c64e80@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/18 7:28 PM, Stephen Rothwell wrote:
> Hi Jens,
> 
> On Mon, 27 Aug 2018 19:15:23 -0600 Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 8/27/18 3:20 PM, Stephen Rothwell wrote:
>>>
>>> I noticed the maintaership change - so what shuld I sues for linux-next,
>>> now?
>>>
>>> I currently have
>>>
>>> git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git#for-next  
>>
>> I'll merge into my for-next branch on the block tree, I'm don't plan on
>> doing separate trees for this, just separate branches. And everything I
>> queue up for the next version will end up in my for-next branch.
> 
> So I'll just drop the libata tree from linux-next, then?

Yeah, that should be all that's needed.

-- 
Jens Axboe

