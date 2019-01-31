Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C9CC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41FB920863
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EEuWphwL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbfAaPP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 10:15:56 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37461 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbfAaPP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 10:15:56 -0500
Received: by mail-pl1-f193.google.com with SMTP id b5so1614093plr.4;
        Thu, 31 Jan 2019 07:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oTwwCo0HfzAnEhBsPRwUHRSIopGz31NRb8hCyw43RM8=;
        b=EEuWphwL/36vLGL3FIv8fT5kYFAVQYv1yR85/3xp5a3zpbTWvgMO4RviXhWFXkzJ5q
         HRQhjvrgExF2f+IdzhslJtPdhcTVoSChUxFufTgvs2ULXKQiEasEg1vfL+kkWjilawLW
         oL5zWahkc08koy7rYiwflx419QZYtQeJR+2sK53PwAhmQ+WxnT8ofHykwkabA50g6dfV
         T+TP1u0OiVku/i5s30zAIpJh4DR8Ni6hIIAMuWNSYKvm89GmqMCSSEeeQRmLRDi44Rtx
         ACoCJ+Ull1JYxdo0nkkNU8shNXWq4Svqzi0dzvGMJ7BYWGWs1UfN1LCWLjPB/dr5evm4
         j6PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oTwwCo0HfzAnEhBsPRwUHRSIopGz31NRb8hCyw43RM8=;
        b=hCtdah5KuPEbkdUmWu58IsuztIsoCETcLHvTlq7ft1VkZntblrB0mG4FEIFE7ih7AM
         vT/w1ozWoY+1u662YYS4oJvX82apMdc6TfmlhvqGM67QNMO64u1HEUcAsqYdJ0Rtxgze
         JqcM+L6hDch3rDeF0MNYCAG9txQNWlv+NoWsWida7dZo5hNKfDmhyxoaNAS0p356YI8F
         MqdlIQJmMqK+L0nKv6VvsUxrhu/Ze5yar3uOB7okqSV6jN0O07fboBeE0pZfFC35+75s
         7Wka3oDG9pWsvyDwpbl0vvvFU/4myxZEXGkLilJJbQ3IN1tgtH1gflKTc+sVEoZO7S7o
         aFEw==
X-Gm-Message-State: AJcUukc5EKkwL9Cs8lXdXK9kstB4qv3anNQe0al3HmBqv2LjgMHrLraZ
        ixWdz5XqLRwSuxOcRRKSFT6CYHA9
X-Google-Smtp-Source: ALg8bN5NfYwj+WW+gUywrTzycE5MYu6AFVHziEt6KECTS+f0lqcsOHakmDBQPlzgLiIGfRATVs7YgA==
X-Received: by 2002:a17:902:2bc5:: with SMTP id l63mr35787493plb.107.1548947755458;
        Thu, 31 Jan 2019 07:15:55 -0800 (PST)
Received: from ?IPv6:2620:15c:2c1:200:55c7:81e6:c7d8:94b? ([2620:15c:2c1:200:55c7:81e6:c7d8:94b])
        by smtp.gmail.com with ESMTPSA id w128sm7893873pfw.79.2019.01.31.07.15.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 07:15:54 -0800 (PST)
Subject: Re: [PATCH] net: check negative value for signed refcnt
To:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        alexandre.besnard@softathome.com, davem@davemloft.net,
        ecree@solarflare.com, jiri@mellanox.com, petrm@mellanox.com,
        alexander.h.duyck@intel.com, amritha.nambiar@intel.com,
        lirongqing@baidu.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190131132008.23161-1-alexandre.besnard@softathome.com>
 <8b654b17-f8b4-0c89-26b5-311aeb703f6d@virtuozzo.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <7bc31b61-8852-88a7-12bf-494c0e54574b@gmail.com>
Date:   Thu, 31 Jan 2019 07:15:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <8b654b17-f8b4-0c89-26b5-311aeb703f6d@virtuozzo.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/31/2019 05:49 AM, Kirill Tkhai wrote:
> 
> 2)Not related to your patch -- it looks like we have problem in existing
> code with this netdev_refcnt_read(). It does not imply a memory ordering
> or some guarantees about reading percpu values. For example, in generic
> code struct percpu_ref switches a counter into atomic mode before it checks
> for the last reference. But there is nothing in netdev_refcnt_read().

Well, if we read an old value here, after a full and expensive synchronize_net(),
then we would have lot more problems than simply having a second round in
netdev_wait_allrefs()
 
