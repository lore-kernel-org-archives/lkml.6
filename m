Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7173CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 09:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BA4421906
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 09:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OwR3PmAj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731536AbeLUJQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 04:16:49 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35899 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729004AbeLUJQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 04:16:48 -0500
Received: by mail-lj1-f195.google.com with SMTP id g11-v6so4088988ljk.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 01:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=UevE5/iaMm48obDIZb9YpxtvcEdiUo3XhiGz/7TD7BQ=;
        b=OwR3PmAj0AhuH5lbkRp8mGrzzydZSmffv3kvKG1JHH1flaWLn2mknPhhdVCKWZC/WZ
         98i0/ptHj91ULBNdMNbpGn9Bcv9Jw/0mLi4afe+uASTuwmk90UU5Fz4+5dpTWUj6VyNn
         0fs6YSZktNyfQgvcHDn9PyMkzeDzM/mgKQ6YVJR/q5ZmbAwUZmZeBwNddHEciYye5Sde
         WI0O1UiZ8QWmxZRB5i4pvvUaKDGNugu+hohZ3mTxVRkxV4aT3b1cih8Bfh5BOP6eMneD
         08iUmY6nWqq/ceHLnw0zAwEFg4iVH90YCi1V97kTOuVjhDdokQ1bzO0o+8pHmU5Bhvbc
         eGbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=UevE5/iaMm48obDIZb9YpxtvcEdiUo3XhiGz/7TD7BQ=;
        b=nDieai+f6Wp3kf6Qu9pueBuea1fgpOn9za2wrrUfWJPBRYhss1yhWCAirJ7jg39HPD
         vJnre7EiIi3FiRr1tJqlN9k7ASb722143Lutk6buJMIxDZ8ik5cDz5RowSNdrVS+9UTN
         HbPSrFMqohv6hOj+cps9sqSRWAuSWAk8fGbh4EYWA2WOPNFTMrCgCP7cZtJWoXlxw6IV
         NUDPWvWEg+11gyJVyxYM7CKtsv+9W85WO0ISndjVODsL23+TtzMDl590DiY0k1IaUOfy
         XovIgWAiGBFJJBaziJrTwlOX2Rr/M/QkVEltGBOKPIdN4cbSX8vlwxfGBpLLtHrCdAbK
         F0Dg==
X-Gm-Message-State: AA+aEWb0wUuY152C4FJ73/AtVzigAaoZP7IOGrviDvUEyHh1VxEORPbd
        WopvG219MMVBLt3EP5qo0PU=
X-Google-Smtp-Source: AFSGD/VBnEPd2kMYYHIbgF9LJn76Li5xDgXKof2wP8AwcDR9EHkP6wsurfYabbQOidS6SRbPHMSP1A==
X-Received: by 2002:a2e:5816:: with SMTP id m22-v6mr973508ljb.177.1545383806088;
        Fri, 21 Dec 2018 01:16:46 -0800 (PST)
Received: from [10.17.182.20] (ll-22.209.223.85.sovam.net.ua. [85.223.209.22])
        by smtp.gmail.com with ESMTPSA id x204sm4799804lfa.5.2018.12.21.01.16.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 01:16:45 -0800 (PST)
Subject: Re: [PATCH] drm/xen-front: Make shmem backed display buffer coherent
To:     Christoph Hellwig <hch@infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Juergen Gross <jgross@suse.com>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
References: <20181127103252.20994-1-andr2000@gmail.com>
 <17640791-5306-f7e4-8588-dd39c14e975b@tronnes.org>
 <20181220153646.GA22997@infradead.org>
 <f2cfadc7-2e0b-b63d-d094-d5339b0c85fe@gmail.com>
 <20181220173950.GA19641@infradead.org>
 <CAKMK7uF8hmO=z4jy+1b1z5ELLWpjcZpqmLoRiP2BJvwnNpOFeg@mail.gmail.com>
 <20181220183311.GA30801@infradead.org>
 <CAKMK7uFxU9Q5u9TxxHqAgFZuQFCFDvxWHDtRLiQf+3hu_4jPcQ@mail.gmail.com>
 <20181220183851.GA27025@infradead.org>
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <83a4be07-a06f-5585-66f6-4973f80dbfba@gmail.com>
Date:   Fri, 21 Dec 2018 11:16:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181220183851.GA27025@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/20/18 8:38 PM, Christoph Hellwig wrote:
> On Thu, Dec 20, 2018 at 07:35:15PM +0100, Daniel Vetter wrote:
>>> Err, with streaming DMA buffer sharing is trivial.  The coherent DMA
>>> allocator is what causes all kinds of horrible hacks that can't actually
>>> work on various platforms.
>> Hm, I thought the streaming dma api is the one that causes bounce
>> buffers and all that fun. If you're unlucky at least.
> Yes it may.  But even if that happens everything will actually work,
> just slower.  While the dma coherent API is simply broken.
>
> But if you don't want bounce buffering you need to use the dma
> noncoherent allocator as proposed here:
>
> 	https://lists.linuxfoundation.org/pipermail/iommu/2018-December/031982.html
>
> which combines allocating memory that doesn't need to be bounce
> buffered with a sharing scheme that can actually work.
So, the bottom line will be: I can use DMA API for what I need, but:
1. I need to remove GFP_USER
2. No need for DMA32 (so no chance for bouncing to step in)
3. I may need to check if mapping and unmapping of the buffer
at once will also help, e.g. no need to have the buffer mapped until
it is destroyed
Did I get it all right?

Thank you,
Oleksandr
