Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D7FDC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 18:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1111320862
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 18:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="ZYLG7AZ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1111320862
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=digitalocean.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbeK0Fab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 00:30:31 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43963 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbeK0Fab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 00:30:31 -0500
Received: by mail-qk1-f195.google.com with SMTP id r71so12908910qkr.10
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 10:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=SDfbembJttLCvQaB/uw2uJ64x8/kRWuSrqsc/W7wU8s=;
        b=ZYLG7AZ1hPxXsx9mmzQtaFK3h/+vGycj8AbJGGbWq5sLZY0obthI8PJ9TTG+Mx7IiL
         673AozXGa2nofwyQDxaSaBZ+0o64YLtViwp3Tv37HKnriWnXu7Jvzbxz6WUDviQCvhX9
         xMu4AiZ3NYmzq+GpkgFsQk90E8X1Tim+V3xwc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=SDfbembJttLCvQaB/uw2uJ64x8/kRWuSrqsc/W7wU8s=;
        b=AvS8PUZCF43OlcvQ/cdhrk7sYF2DVZMsY9qR3MZawGcT21evLP1FSkz0u81fv+wCR5
         iyqUT9iuZOJw+w81V/CaEd9mv782IqPv1w4mYzTOEqn7DxlPvKcDHZV26W0X3cpXamsV
         oSU3C8hzj/Cxqu4sySqhbuyHVnbChchrf6TO4KueR8tpPytf5NxUuSy94vM1Ok55YhIb
         aL/9UPQ54fI/rowjciTPevsO6wjdjCBCeq9zmPyu/oQPkvt8atuo4yr6LR9QpcmfyJy8
         wM1cdpwEcMpfersAUVOjnN1uhy0QBfc4fK2tXdOeKmokJ5VruyVaLHzbdQExevTc8yvJ
         Q76g==
X-Gm-Message-State: AA+aEWYDY8wE42KncvjIud/LQkxPDpICqjuNlOFo3avvSEtoIFN0JqhW
        4Ncb96fcPCPVLBgA4CgfUe3shQ==
X-Google-Smtp-Source: AFSGD/VylmPBHwA13AzJ/MpeUpgQGtj8ImtaebRt9iDrT74ogO6Gfc5NUTdQmfT4AB3/Pew6zvVkpQ==
X-Received: by 2002:a37:4b44:: with SMTP id y65mr25421147qka.316.1543257332941;
        Mon, 26 Nov 2018 10:35:32 -0800 (PST)
Received: from [192.168.86.60] (c-24-147-95-226.hsd1.vt.comcast.net. [24.147.95.226])
        by smtp.gmail.com with ESMTPSA id r142sm642876qke.27.2018.11.26.10.35.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 10:35:31 -0800 (PST)
Subject: Re: [PATCH v2] mm: prototype: rid swapoff of quadratic complexity
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Kelley Nielsen <kelleynnn@gmail.com>,
        Rik van Riel <riel@surriel.com>
References: <20181126165521.19777-1-vpillai@digitalocean.com>
 <20181126172255.GK3065@bombadil.infradead.org>
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
Message-ID: <21acdf55-dbcb-1c8f-4783-9bb496dcbca3@digitalocean.com>
Date:   Mon, 26 Nov 2018 13:35:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181126172255.GK3065@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathew,


Thanks for your response!

On 11/26/18 12:22 PM, Matthew Wilcox wrote:
> On Mon, Nov 26, 2018 at 04:55:21PM +0000, Vineeth Remanan Pillai wrote:
>> +	do {
>> +		XA_STATE(xas, &mapping->i_pages, start);
>> +		int i;
>> +		int entries = 0;
>> +		struct page *page;
>> +		pgoff_t indices[PAGEVEC_SIZE];
>> +		unsigned long end = start + PAGEVEC_SIZE;
>>   
>> +		rcu_read_lock();
>> +		xas_for_each(&xas, page, end) {
> I think this is a mistake.  You should probably specify ULONG_MAX for the
> end.  Otherwise if there are no swap entries in the first 60kB of the file,
> you'll just exit.  That does mean you'll need to check 'entries' for
> hitting PAGEVEC_SIZE.

Thanks for pointing this out. I shall fix this in the next version.

> This seems terribly complicated.  You run through i_pages, record the
> indices of the swap entries, then go back and look them up again by
> calling shmem_getpage() which calls the incredibly complex 300 line
> shmem_getpage_gfp().
>
> Can we refactor shmem_getpage_gfp() to skip some of the checks which
> aren't necessary when called from this path, and turn this into a nice
> simple xas_for_each() loop which works one entry at a time?

I shall investigate this and make this simpler as you suggested.

>> +	list_for_each_safe(p, next, &shmem_swaplist) {
>> +		info = list_entry(p, struct shmem_inode_info, swaplist);
> This could use list_for_each_entry_safe(), right?

Yes, you are right. Will fix.


Thanks,

Vineeth

>
