Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BEC6C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E47BC20850
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="RxoFhi5R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E47BC20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=digitalocean.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbeLCOgr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 09:36:47 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39636 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbeLCOgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 09:36:46 -0500
Received: by mail-qk1-f193.google.com with SMTP id q70so7426229qkh.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 06:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=kwJ49FC5FWtRYQ1LqcYvEh+IfdElL4oabQVLUlgQWc0=;
        b=RxoFhi5R+eqiwEt3WWyFBsMQqTD9g9/lN5v6law9ZYAtuApWuOr0u1SXqsdqn6n29d
         b9slAXYIr1JXL8c+Z1vGmrXS2cc/CcrIigXzvXzKN4Z2A9hKGfc+rUZDrbM0+DOm9zlf
         lRsbFTU1o45vf3qgQSlOkOZ/PUyS6mkhaWhXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=kwJ49FC5FWtRYQ1LqcYvEh+IfdElL4oabQVLUlgQWc0=;
        b=neXYK+2oY2kA5u6u2Sk0h32prXmpgs1l2jljiB78AahnSz6YF0ACj5i+I/JO7FyfEH
         +RluTc4Hzkp0azLQJx2S3kkGN6nn+avghNbz+eBCsaoyBddFeA32DbU0QQz3gNZjjjvz
         uYVC5MFFl0EXmBNhwqOOLUZtLzaSpO/DrkYhAtX2M6wH746mdAl8E36hEdEz0wIXUjFZ
         oW9+gepCNOqvHXdukQ0TUHVvTUfaGFpTQsTH6C/cNKdp125hc7Yk4kUALT/V1DkbhH5+
         K6uXIF+rqmtsJQS5FePkqPPO4CIyhdGZKmW22UtpCoCcW2ZccXQV19I8chxzAdwzNyiC
         cvJA==
X-Gm-Message-State: AA+aEWYRjsAWQxL/t6MB8IJw0TyHv1wNXsuPk7d5wCch8rgdeAWPBPf/
        Uvel0CS6ECMY7aL3tE2qBMEOnQ==
X-Google-Smtp-Source: AFSGD/WB0d/5SwKvCuWwnBAeWo3Qz2DyUW9AvDDgNq/N6DoNNXYbuUCWp4L3uEQNdPsB7ZxQdpNRZA==
X-Received: by 2002:a37:8107:: with SMTP id c7mr14366785qkd.77.1543847731440;
        Mon, 03 Dec 2018 06:35:31 -0800 (PST)
Received: from [192.168.86.60] (c-24-147-95-226.hsd1.vt.comcast.net. [24.147.95.226])
        by smtp.gmail.com with ESMTPSA id w15sm8858531qta.16.2018.12.03.06.35.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 06:35:30 -0800 (PST)
Subject: Re: [PATCH v2] mm: prototype: rid swapoff of quadratic complexity
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Kelley Nielsen <kelleynnn@gmail.com>,
        Rik van Riel <riel@surriel.com>
References: <20181126165521.19777-1-vpillai@digitalocean.com>
 <20181126172255.GK3065@bombadil.infradead.org>
 <21acdf55-dbcb-1c8f-4783-9bb496dcbca3@digitalocean.com>
Message-ID: <8ec7fc5f-3c14-5faa-541e-45f5b980a98d@digitalocean.com>
Date:   Mon, 3 Dec 2018 09:35:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <21acdf55-dbcb-1c8f-4783-9bb496dcbca3@digitalocean.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew,


>> This seems terribly complicated.  You run through i_pages, record the
>> indices of the swap entries, then go back and look them up again by
>> calling shmem_getpage() which calls the incredibly complex 300 line
>> shmem_getpage_gfp().
>>
>> Can we refactor shmem_getpage_gfp() to skip some of the checks which
>> aren't necessary when called from this path, and turn this into a nice
>> simple xas_for_each() loop which works one entry at a time?
>
> I shall investigate this and make this simpler as you suggested.

I have looked into this deeper. I think it would be very difficult to 
consolidate the whole logic into a single xas_for_each() loop because, 
we do disk io and might sleep. I have refactored the code such that it 
much more readable now and I am using the same format used by 
find_get_entries.

Will send out the next revision later today.


Thanks,

Vineeth

