Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A10C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FA5A217D8
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:32:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tVSeAEbR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731039AbeLTPcm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 10:32:42 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41601 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbeLTPcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 10:32:41 -0500
Received: by mail-ed1-f68.google.com with SMTP id g19so2089295edy.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 07:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yZ2aiobkLaX1mj7/iX/Gog/lPO+/IY+yMX/S2ugNC9k=;
        b=tVSeAEbR6wdF6eXzUZjOktzwYsSBXMTdg11DaYOZYq3nb4vHWnUwbt73LstDAnlPw6
         xK4m+4TgRM59kSQz7akyoirOcHpEcsUHLmP66v8lx/2MVps+aS/Cfuk1/1wHYFg2H7Rg
         2SO4xaJzXDzxynY20Q23n+LKYGTQVMdq8J5qjKz/cTPWnG+NLWC+xkcy7b7T2ea9Aq54
         Z9IEPclP3ZZ/SCfEW8xqzDhoAqIOHLJ9y8J8572E18XIlY+pN91CWaIO/LJzVVjcCa2v
         XA2bN7ZnqTX7XUtKMwxUTbI51LEOlDC5TrKjIEGPDoboaa+gqfeO6P2uNb51mb8pXJrl
         RcOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=yZ2aiobkLaX1mj7/iX/Gog/lPO+/IY+yMX/S2ugNC9k=;
        b=UlEJ7uvp8ucEmhTVE+f8GvgU9eJtq7DiAPMZngEugH9QjKNw09MagkJSX/AAcd0X9I
         SyMnGDUrLbqa1EnwBpWubgrEAK8j3W68tgJdvAmCjNLAFaglusI1iLh+feKY6x3L5Dr2
         rK9cbPGaQTjaxx4Zzk12UmX5bbR1Eg0vDxswc9Klw4JODZTXa5X/UOKSSfuCwViQxIB5
         GTA/U53QPeXNIhB2OK6w8hIqV+G9Q4O5+o99YhO8ErwVwIrUODA3dsgpuirGpP/8Rp0a
         ndCDaEgBz/Im/Ux4C3cGTwaVWK7B7Pb39My8YqeXBa6jQxxBLDnJvKiqQUOc2hAG54kT
         pl+Q==
X-Gm-Message-State: AA+aEWYXY0crLX/g9t2m+ekrCkoWjo8Ll7HncIvqMFt1sJi+tUrx7Uv7
        HNvasu+OTtKm11JwP8uoZr8=
X-Google-Smtp-Source: AFSGD/WLLklun1d9aghpKwSfLr9Gz+dO8aM+97QJvy3AJnYcZHagAFnVRLbugZ5hv61/v65aESaubg==
X-Received: by 2002:a50:880d:: with SMTP id b13mr23562775edb.68.1545319958930;
        Thu, 20 Dec 2018 07:32:38 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id i46sm6148860ede.62.2018.12.20.07.32.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 07:32:38 -0800 (PST)
Date:   Thu, 20 Dec 2018 15:32:37 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Wei Yang <richard.weiyang@gmail.com>,
        akpm@linux-foundation.org, vbabka@suse.cz,
        pavel.tatashin@microsoft.com, rppt@linux.vnet.ibm.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm, page_alloc: Fix has_unmovable_pages for HugePages
Message-ID: <20181220153237.bhepsqw27mjmc4g5@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20181217225113.17864-1-osalvador@suse.de>
 <20181219142528.yx6ravdyzcqp5wtd@master>
 <20181219233914.2fxe26pih26ifvmt@d104.suse.de>
 <20181220091228.GB14234@dhcp22.suse.cz>
 <20181220124925.itwuuacgztpgsk7s@d104.suse.de>
 <20181220130606.GG9104@dhcp22.suse.cz>
 <20181220134132.6ynretwlndmyupml@d104.suse.de>
 <20181220142124.r34fnuv6b33luj5a@d104.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181220142124.r34fnuv6b33luj5a@d104.suse.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 03:21:27PM +0100, Oscar Salvador wrote:
>On Thu, Dec 20, 2018 at 02:41:32PM +0100, Oscar Salvador wrote:
>> On Thu, Dec 20, 2018 at 02:06:06PM +0100, Michal Hocko wrote:
>> > You did want iter += skip_pages - 1 here right?
>> 
>> Bleh, yeah.
>> I am taking vacation today so my brain has left me hours ago, sorry.
>> Should be:
>> 
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 4812287e56a0..0634fbdef078 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -8094,7 +8094,7 @@ bool has_unmovable_pages(struct zone *zone, struct page *page, int count,
>>                                 goto unmovable;
>>  
>>                         skip_pages = (1 << compound_order(head)) - (page - head);
>> -                       iter = round_up(iter + 1, skip_pages) - 1;
>> +                       iter += skip_pages - 1;
>>                         continue;
>>                 }
>
>On a second thought, I think it should not really matter.
>
>AFAICS, we can have these scenarios:
>
>1) the head page is the first page in the pabeblock
>2) first page in the pageblock is not a head but part of a hugepage
>3) the head is somewhere within the pageblock
>
>For cases 1) and 3), iter will just get the right value and we will
>break the loop afterwards.
>
>In case 2), iter will be set to a value to skip over the remaining pages.
>
>I am assuming that hugepages are allocated and packed together.
>
>Note that I am not against the change, but I just wanted to see if there is
>something I am missing.

I have another way of classification.

First is three cases of expected new_iter.

             1          2                        3
             v          v                        v
 HugePage    +-----------------------------------+
                                                  ^
                                                  |
                                               new_iter

From this char, we may have three cases:

  1) iter is the head page 
  2) iter is the middle page
  2) iter is the tail page

No matter which case iter starts, new_iter should be point to tail + 1.

Second is the relationship between the new_iter and the pageblock, only
two cases:

  1) new_iter is still in current pageblock
  2) new_iter is out of current pageblock

For both cases, current loop handles it well.

Now let's go back to see how to calculate new_iter. From the chart
above, we can see this formula stands for all three cases:

    new_iter = round_up(iter + 1, page_size(HugePage))

So it looks the first version is correct.

>-- 
>Oscar Salvador
>SUSE L3

-- 
Wei Yang
Help you, Help me
