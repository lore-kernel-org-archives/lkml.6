Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E0AC10F0B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 386402173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="VpnHDEnE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbfBZOQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 09:16:34 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:32821 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfBZOQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 09:16:33 -0500
Received: by mail-qt1-f194.google.com with SMTP id z39so15011564qtz.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 06:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1VOsHpqNa6LTsxo2nkxb4h40F31APusw6iNn5tYasUU=;
        b=VpnHDEnE169AhLVJM0OL/pdD5WNAdf7Z5iZGZ6Lryup9dB6oqqy0DobWbMhOAn6Wub
         KE3UNHnAW317nAshfjaHsJGH7wFVeKDEtuKAKWmmD3zvU8hD5Md66y89ce0JZcYhNZfS
         Itd8ytY4ciWf9T3fxUp3aFQNtJNzn4csfJE6XXsmXd6VOGFakrOdYVCh1u4x9cJaDyHJ
         UY7yml1X3iQxnW6R/+XUIIVV8HRZixbg3etXjrGsvEOCavTJYuyccwu3oRmsKb6MFPQ/
         rGXesSqSzVAJQs4KYfVSo2BHcMHAEPhW+dZdBxS24XRrFV9U3DIoIJPbpNaWRzEHhMl5
         gQZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1VOsHpqNa6LTsxo2nkxb4h40F31APusw6iNn5tYasUU=;
        b=qDW6Ha6eJvhHk/3aswgZXs2+icmOu/imoXOkRBU/Vgv9AVGNQS2rhJ0l/LxM5S3Wif
         3xXDk/9eZA8y8vn43p8QfGvteWQMqO1kL3kT8q4SlD7DZn/qI9etFr1RFGTvudssuRR5
         vu7e03hDx0UN20wsIw8tgFJ1EbNKqBjeJNvkBZ/OSRwbcx9HEDdJJBvlsuj54TGSe5zP
         Z59DS36tEyYN7iTQGvy2Hrt8ROQFMrixSbWPtTiAGKpMG8QO2sn/mirUJaNi815RW0eX
         Kxry2EpYz7wnGq0YhI14/hxqlII16sj72gvqKXID9aTqcZ6WBUZKOtDezrXaPNL2P4XQ
         k0Ug==
X-Gm-Message-State: AHQUAuZXmi7Th86BHwQWhztqZpIArNFLpol0xTEDe2tkWEe45yRWF65Z
        O7uC30iddlbEjzH2mNOmYCWx/knCi3o=
X-Google-Smtp-Source: AHgI3Ia/vYitV8v90DyK+0qhpC+uDfIAsBuwHdIzuer4PHfEHeCppu5XT0rghK9/VqR/H+eExjFffw==
X-Received: by 2002:ac8:33bc:: with SMTP id c57mr19051000qtb.63.1551190592171;
        Tue, 26 Feb 2019 06:16:32 -0800 (PST)
Received: from ovpn-120-150.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id e184sm14174372qka.31.2019.02.26.06.16.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 06:16:31 -0800 (PST)
Subject: Re: [PATCH] mm/hotplug: fix an imbalance with DEBUG_PAGEALLOC
To:     Michal Hocko <mhocko@kernel.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20190225191710.48131-1-cai@lca.pw>
 <20190226123521.GZ10588@dhcp22.suse.cz>
From:   Qian Cai <cai@lca.pw>
Message-ID: <4d4d3140-6d83-6d22-efdb-370351023aea@lca.pw>
Date:   Tue, 26 Feb 2019 09:16:30 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190226123521.GZ10588@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/26/19 7:35 AM, Michal Hocko wrote:
> On Mon 25-02-19 14:17:10, Qian Cai wrote:
>> When onlining memory pages, it calls kernel_unmap_linear_page(),
>> However, it does not call kernel_map_linear_page() while offlining
>> memory pages. As the result, it triggers a panic below while onlining on
>> ppc64le as it checks if the pages are mapped before unmapping,
>> Therefore, let it call kernel_map_linear_page() when setting all pages
>> as reserved.
> 
> This really begs for much more explanation. All the pages should be
> unmapped as they get freed AFAIR. So why do we need a special handing
> here when this path only offlines free pages?
> 

It sounds like this is exact the point to explain the imbalance. When offlining,
every page has already been unmapped and marked reserved. When onlining, it
tries to free those reserved pages via __online_page_free(). Since those pages
are order 0, it goes free_unref_page() which in-turn call
kernel_unmap_linear_page() again without been mapped first.
