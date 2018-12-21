Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E008CC43612
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 17:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE08921903
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 17:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="fTYEw8ta"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389901AbeLURDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 12:03:12 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:50202 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730879AbeLURDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 12:03:12 -0500
Received: by mail-it1-f195.google.com with SMTP id z7so7809770iti.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 09:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Hf5qZoOeGEo9ju4n7h/sv9g8Q8I5xApPDnIUfUGruv0=;
        b=fTYEw8taRKtOBatcK/jmE/yizYPBUjdGSjQInlMmVcXEuyiKDKYYLsBl3WgGK16JeS
         yMRZIQs3O8Smncp3zJzLi88+kNqCm/S4qlL4tEWoGNOpcgwJDXub83YOQOMjBYOmVGDu
         ni6o3r4w2bHsiXzAXzfbyC+CynGiGu31bMa7Ih8kkcGg/hYQFgeJh9GAa1YKMVT+50iM
         aS+8brYsAoSMbZzikfObGIYrDymaltYy+uE1K54k3+SEKqmFwqIx7PZh8aCfqzN9AWQW
         9xJVpKQfzVBQ6n7LRzoLXN1EyyueuJ+/J+XT1/caKywnk02dchzhUfb8tWmdfYt3X8+x
         XR2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Hf5qZoOeGEo9ju4n7h/sv9g8Q8I5xApPDnIUfUGruv0=;
        b=YaBIsrA2MnFPGjMWX6DIq5xht6DCLvk4OVeW3z2aNEZjNaZhvD1QCad+zV/rzJHV8x
         hfxclEWx8/cEdabqhnWtfLzqW1oMl4xFJgCMpUeFFDWeD6L25lUuYSqGkfimvd/5ZDpD
         MLOBE6lJpUPXbfscexODQ2eIx4x/z+cnbbyXiwb78PQkL5UkkTE7KQ+1Rn5ieJvOFUgz
         2gKEYkE80qHdM3aYfR0j7PMur/0THDvwOKs50QPn9eHS9M84DeZWj1n2KDixdlvqCply
         C0BongHfW417qyYYKAeyptcKOQw2VCdsZg9sHX4bEjUmIj91lJS6x5rw2YJTdDgCszbf
         Tfqg==
X-Gm-Message-State: AA+aEWZPYSeI5BeZE/xo5TP5Ae17wnqZor/z4wgULRCxUGu/dmXsO3Ys
        eX0sJMWcvQXnzCkDIEKzfNj32+wCQWm+6w==
X-Google-Smtp-Source: AFSGD/XUWF+XpqsQlMTCsV0UOEGMObT2VAkzPKQF9isNZR7GMMQAXgb7/nWBzug+qSePGrfiJwX+VA==
X-Received: by 2002:a02:97fd:: with SMTP id v58mr2157219jaj.115.1545411791057;
        Fri, 21 Dec 2018 09:03:11 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id 195sm6430371itm.2.2018.12.21.09.03.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 09:03:10 -0800 (PST)
Subject: Re: [PATCH] blkcg: add rcu lock to bio_clone_blkg_association()
To:     Dennis Zhou <dennis@kernel.org>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20181221145441.13814-1-dennis@kernel.org>
 <f1dacd9e-7c3d-44e5-aff1-923d9e7a374c@kernel.dk>
 <20181221170243.GA17140@dennisz-mbp>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <af9fe74e-b5cd-96d8-b3d6-f8ee01f98121@kernel.dk>
Date:   Fri, 21 Dec 2018 10:03:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181221170243.GA17140@dennisz-mbp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/21/18 10:02 AM, Dennis Zhou wrote:
> On Fri, Dec 21, 2018 at 08:26:02AM -0700, Jens Axboe wrote:
>> On 12/21/18 7:54 AM, Dennis Zhou wrote:
>>> I cleaned up blkg_tryget_closest() to require rcu_read_lock() earlier.
>>> However, this was a subtle case too which clearly was too subtle for me.
>>> The idea was the src bio should be holding a ref to the blkg so rcu
>>> wasn't technically needed. If it doesn't hold a ref, it should be %NULL
>>> and the blkg->parent pointers are unused.
>>>
>>> This adds the appropriate read lock in bio_clone_blkg_association().
>>
>> Shall I just fold this with the previous? I staged it in a
>> later-in-merge-cycle branch, so that's not an issue to amend.
>>
> 
> Yeah that would be great!

Done

-- 
Jens Axboe

