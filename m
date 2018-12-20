Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA555C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 13:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7156621741
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 13:09:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VgC+ots+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732943AbeLTNJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 08:09:02 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40076 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730526AbeLTNJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 08:09:02 -0500
Received: by mail-ed1-f68.google.com with SMTP id g22so1680904edr.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 05:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QE1hGNye3NyJwWEBXrscsu1nNVxI1i6vduJfzWWgiO0=;
        b=VgC+ots+pyiAM8qTnx3LQaKyojQIH6txasK4VpFNlSsf3KEB83qpwitvg+5BimYRlR
         WWFPYWIq6a6BdwU5kBRSrGlbUtF9LyZ7FclCBjESSVWyS3s0+th7jB7ot4725JoBs9RU
         kYv7NRJdRbUTkPFeOjCJ6YVKGBlPd+WEHLgbE9GSQ890jyPbrTmgdIhAaFqBkD6pvh/6
         xp0+aat88GHtw+PuACnOH9TkX+oaZY5nxvWKG0e0oZPliEGyq9y4YB0DbH2tnKwUQ1Z3
         aPHZlNbb6c7tEkJArWeGYaOtiW4iYAghMBqN0nqFiiN30SjrGpdeG1cJWciTn+/USPhZ
         VSpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=QE1hGNye3NyJwWEBXrscsu1nNVxI1i6vduJfzWWgiO0=;
        b=fzfapo5TUHNuQY+krjZv+b2LKIqXE8Lm6oe9yTUlzpeQe0KbotoobbVTx6iRmoCilK
         AB48gEtKhQTlSBDxuosZooKaIfI68cHGMOUR3hjpALUFSyCl7hCwneKyHf1oZ9bStzhx
         2HAFqeQIjOHI4oCyJXMxdt5SWaaTNLeS282oekr0G7KzTx3hNaBShA3chPvgn4RukckF
         +d//8OIX5rlHTct0M91cy/os57fYrmU3RM21H6BIQP/RPBsDIzaHYEZ6MJLO7C4twhu0
         wusIaVaLuhCj8lktcwc67/kx4nLTzNJWYp/FwUM7X/H8qkEmCR+lFRwbPAXtgXfdeMxW
         2nVQ==
X-Gm-Message-State: AA+aEWZf4pe+sxmGXY5im/5hblO9il+Q19lHCMaeo0LXFkBeq635vJr/
        hpk5IX5VYehkUfTGjcE7300=
X-Google-Smtp-Source: AFSGD/VqdyZJgwvZgYE5FSm0A/dEb2feEMojJ0e/Vpf5WxsUkv+tB8DjkJCmMxISAyTnkOWvkXNUIw==
X-Received: by 2002:a17:906:d191:: with SMTP id c17-v6mr19426835ejz.27.1545311339186;
        Thu, 20 Dec 2018 05:08:59 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id t9sm6039963edd.25.2018.12.20.05.08.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 05:08:58 -0800 (PST)
Date:   Thu, 20 Dec 2018 13:08:57 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Wei Yang <richard.weiyang@gmail.com>,
        akpm@linux-foundation.org, vbabka@suse.cz,
        pavel.tatashin@microsoft.com, rppt@linux.vnet.ibm.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm, page_alloc: Fix has_unmovable_pages for HugePages
Message-ID: <20181220130857.yrzv5wzmiw7jbycb@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20181217225113.17864-1-osalvador@suse.de>
 <20181219142528.yx6ravdyzcqp5wtd@master>
 <20181219233914.2fxe26pih26ifvmt@d104.suse.de>
 <20181220091228.GB14234@dhcp22.suse.cz>
 <20181220124925.itwuuacgztpgsk7s@d104.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181220124925.itwuuacgztpgsk7s@d104.suse.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 01:49:28PM +0100, Oscar Salvador wrote:
>On Thu, Dec 20, 2018 at 10:12:28AM +0100, Michal Hocko wrote:
>> > <--
>> > skip_pages = (1 << compound_order(head)) - (page - head);
>> > iter = skip_pages - 1;
>> > --
>> > 
>> > which looks more simple IMHO.
>> 
>> Agreed!
>
>Andrew, can you please apply the next diff chunk on top of the patch:
>
>diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>index 4812287e56a0..978576d93783 100644
>--- a/mm/page_alloc.c
>+++ b/mm/page_alloc.c
>@@ -8094,7 +8094,7 @@ bool has_unmovable_pages(struct zone *zone, struct page *page, int count,
> 				goto unmovable;
> 
> 			skip_pages = (1 << compound_order(head)) - (page - head);
>-			iter = round_up(iter + 1, skip_pages) - 1;
>+			iter = skip_pages - 1;

This complicated the calculation. 

The original code is correct.

iter = round_up(iter + 1, 1<<compound_order(head)) - 1;

> 			continue;
> 		}
>
>Thanks!
>-- 
>Oscar Salvador
>SUSE L3

-- 
Wei Yang
Help you, Help me
