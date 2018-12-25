Return-Path: <SRS0=Ytqw=PC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19899C64E75
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 02:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCB17218D0
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 02:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UH1iRaRq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725845AbeLYCmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 21:42:46 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41176 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbeLYCmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 21:42:46 -0500
Received: by mail-ot1-f66.google.com with SMTP id u16so11796593otk.8;
        Mon, 24 Dec 2018 18:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=pcSeBoJKf9vbWPoXvTB8aQzFMIBxM3DvCYZd4/an87g=;
        b=UH1iRaRqGjbBbdZnFoIEEd8Zi1GJN51g9NghzTzDoeAHN6LEFRaTCn+oafztZVEQyM
         /3An2YAUnq91H3iNYjffvSt3oR5+g39v3p7aP218jppw885+tiIx2rWihPt+Z+sG+hlA
         8B1HCwTmchTEuc2gqI6P3ApJIyFsT08LbMLb+Y3G/UlpaU4UdthVif4fz3I3oxDibUJb
         APDabx1YdtfafT5Yn1VQhu8ykLFEI8227dBZhB/+hR9S2EZ3Ut8RuUXSV/rhKdOa8Zag
         cXJ9decw9rzBua/3Htb+5hiHOqIIDbYIPvsiw0Y4E6zEh2GqZ6Ea2VUsagj+QvcJiBtp
         q00g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=pcSeBoJKf9vbWPoXvTB8aQzFMIBxM3DvCYZd4/an87g=;
        b=uZ0NxqX13TTvdBTCCxTlrcwuxgy11c+IPcMs6Q6L5AHtQJ/h60D9Gjs57j8Ssq3nOS
         YVfd6DKRLnCwknX6C9qt8+f9e6dCtDZYpzVSKdVfrPdnpsQJ7iWZOYC326AWaUNnO3Q0
         6ZE0UXsGzai7uoicYy3lYrQepvaAwaro8Xg6KYwblBphFn/guD6tjmro+kOqgquI9ezt
         EYmGXEOHr4Ra2DIYlpZQ0LFf+o3oWfaekVbdANetXlVZgu8YNQGkzlsKFZKfTj+vRBWp
         2UcBZA/9tCt5KCMs62UiE4X+l6Q4l2lC2+hlhCOYOniBmXE7OVAo5tZcs0MPBx18f7Oc
         uZsQ==
X-Gm-Message-State: AJcUukc7kyRCAaBiuY5S1pKVQpPhvqV25HfKpm326+Ns9FivE8Tlxf/P
        OdFYIYzbqW2Iti9TppqGNoZ0Av1Dbp4=
X-Google-Smtp-Source: ALg8bN6UPcCJrcdFmC+mDccJfuzn6aVN1LGh3Fn4rjS2PIP5ca7AYHIXujk8tSxIajI/ScWEf9F30Q==
X-Received: by 2002:a9d:282:: with SMTP id 2mr10044081otl.287.1545705763699;
        Mon, 24 Dec 2018 18:42:43 -0800 (PST)
Received: from [0.0.0.0] (104.194.84.186.16clouds.com. [104.194.84.186])
        by smtp.gmail.com with ESMTPSA id v68sm15973267oie.16.2018.12.24.18.42.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Dec 2018 18:42:42 -0800 (PST)
Subject: Re: [PATCH] ubifs: Get/put page when changing PG_private
To:     Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hsiangkao@mail.ru, kirill.shutemov@linux.intel.com,
        stable@vger.kernel.org
References: <20181215150130.19381-1-richard@nod.at>
 <386368225.TvJUPtmGVW@blindfold>
From:   zhangjun <openzhangj@gmail.com>
Message-ID: <b9def265-5e93-a451-0f7b-91c0edac0b00@gmail.com>
Date:   Tue, 25 Dec 2018 10:42:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <386368225.TvJUPtmGVW@blindfold>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/12/21 下午4:56, Richard Weinberger wrote:
> Am Samstag, 15. Dezember 2018, 16:01:30 CET schrieb Richard Weinberger:
>> The page migration code assumes that a page with PG_private
>> set has its page count elevated by 1.
>> UBIFS never did this and therefore the migration code was unable
>> to migrate some pages owned by UBIFS.
>> The lead to situations where the CMA memory allocator failed to
>> allocate memory.
>>
>> Fix this by using get/put_page when changing PG_private.
>>
>> Cc: <stable@vger.kernel.org>
>> Cc: zhangjun <openzhangj@gmail.com>
>> Fixes: 4ac1c17b2044 ("UBIFS: Implement ->migratepage()")
>> Reported-by: zhangjun <openzhangj@gmail.com>
>> Signed-off-by: Richard Weinberger <richard@nod.at>
> FYI, on the XFS side a similar change caused a regression.
> https://marc.info/?l=linux-fsdevel&m=154530861202448&w=2
>
> Until this regression is not fully understood, including the implications
> for UBIFS, I'll not merge this patch.
>
> Thanks,
> //richard
>
>
Hello,richard


Before fully understanding this regression, in order to fix the bug of 
cma_alloc(),
submit a conservative patch that modifies count in iomap_migrate_page().
Can you consider merging first?

https://marc.info/?l=linux-kernel&m=154473132332661&w=2


Thanks
//zhangjun

