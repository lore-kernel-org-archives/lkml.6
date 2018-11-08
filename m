Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D591FC32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 07:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E19D20827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 07:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="K3i2Oayh";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="AnxX7Fx4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E19D20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbeKHQ5n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 11:57:43 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:47108 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbeKHQ5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 11:57:43 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2D87360AD8; Thu,  8 Nov 2018 07:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541661815;
        bh=tU7zIMPAGIs0RFODrreQRQFlajuUePBThjAa9iv5R4c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=K3i2Oayh25W2ejwN6lICrHogVCewQF51B4FMvCOhaRKN0Dq6BfK/lRSWG9YUzbPpF
         HFksuKcuZxUjRgRPRBx+HMaAc74sIKS6nZyQwD5bJqa673HyIJn5dJugqQWuaNPkEL
         CzX6lfgt6hbkTIbxFM/b/k4LXrJcDqC7xxOriK1U=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 6AB5660791;
        Thu,  8 Nov 2018 07:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541661813;
        bh=tU7zIMPAGIs0RFODrreQRQFlajuUePBThjAa9iv5R4c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AnxX7Fx4qRASUDf0yW0P7L/BVTpsVV60ZBYoML25XRtX2GvX6SrGZHmuD3M17Jx7w
         0WitnpSh4cLMbStTig/quPV4tdNRh7lItTE8bavXpfCmJpzrth5fihI9+oXFIY7PiS
         E0vUx81gVzP/cXFT223fJI7HCAWCkMO7lZDJsGgA=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 08 Nov 2018 12:53:33 +0530
From:   Arun KS <arunks@codeaurora.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     akpm@linux-foundation.org, keescook@chromium.org,
        khlebnikov@yandex-team.ru, minchan@kernel.org, mhocko@kernel.org,
        osalvador@suse.de, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, getarunks@gmail.com
Subject: Re: [PATCH v2 3/4] mm: convert totalram_pages and totalhigh_pages
 variables to atomic
In-Reply-To: <5edc432c-b475-5d2e-6a87-700c32a8fad9@suse.cz>
References: <1541521310-28739-1-git-send-email-arunks@codeaurora.org>
 <1541521310-28739-4-git-send-email-arunks@codeaurora.org>
 <5edc432c-b475-5d2e-6a87-700c32a8fad9@suse.cz>
Message-ID: <7376dee0b5a62fe847c347e615abf868@codeaurora.org>
X-Sender: arunks@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-11-07 14:34, Vlastimil Babka wrote:
> On 11/6/18 5:21 PM, Arun KS wrote:
>> totalram_pages and totalhigh_pages are made static inline function.
>> 
>> Suggested-by: Michal Hocko <mhocko@suse.com>
>> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
>> Signed-off-by: Arun KS <arunks@codeaurora.org>
>> Reviewed-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
>> Acked-by: Michal Hocko <mhocko@suse.com>
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> 
> One bug (probably) below:
> 
>> diff --git a/mm/highmem.c b/mm/highmem.c
>> index 59db322..02a9a4b 100644
>> --- a/mm/highmem.c
>> +++ b/mm/highmem.c
>> @@ -105,9 +105,7 @@ static inline wait_queue_head_t 
>> *get_pkmap_wait_queue_head(unsigned int color)
>>  }
>>  #endif
>> 
>> -unsigned long totalhigh_pages __read_mostly;
>> -EXPORT_SYMBOL(totalhigh_pages);
> 
> I think you still need to export _totalhigh_pages so that modules can
> use the inline accessors.

Thanks for pointing this. I missed that. Will do the same for 
_totalram_pages.

Regards,
Arun

> 
>> -
>> +atomic_long_t _totalhigh_pages __read_mostly;
>> 
>>  EXPORT_PER_CPU_SYMBOL(__kmap_atomic_idx);
>> 
