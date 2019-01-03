Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F380C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 17:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70AA6208E3
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 17:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="McPRLS3X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730932AbfACRjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 12:39:02 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45234 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbfACRjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 12:39:01 -0500
Received: by mail-qt1-f196.google.com with SMTP id e5so37658740qtr.12
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 09:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=t587UVBNuyCfC65rluFxhGYOCOvc+9jmgCEFxsusKXE=;
        b=McPRLS3X3VCsSiua7V2KNrMtoTLz2XY/nkWYn05efOWTVGTdJ7tHUrjZv9pWlNCgT4
         as0frn8IctYNU765sYCblwGTIuy5Dnf0AIzwZePPb9d058WRTIrSdaE+4PoXnuZLQrJk
         ZtsEn9af29HBPNHGWx818plJZDOlfmaBA3vHNDpeiZacMk35WsNU/XG7ZD9Tc04P9WK/
         bvivzhwa08dYek0EWTh/uLRhSW3nzXuZAG/gdQ+SwCOZYMIJdl4rO8JOAbJnFSBvdAAt
         hxCaUVPF7lUP530h47/XC/E0wCerfIkqk/Je862NTldcsMXl3lgxoIsPz77hGjoVrZIW
         UY8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t587UVBNuyCfC65rluFxhGYOCOvc+9jmgCEFxsusKXE=;
        b=Bp00HGr4kqWoqnMfmDJLFFqjhvK/0E/tG7KeswP0ObBJe6kO3vs2LORXfAqEEvxLSg
         07znFiGuiPLWTxd1Xe75iSaP8yRTIRpTg6r98mQhVqWc5HXdno70GsaYliji7uI5zU8s
         D5AvcH3w+r9srbioQ4ZWiWrJJvyg0yq+3yL6gQisn5MGS1J8+g3eUXh+1ApNh2vpGMAX
         JSaN/89N2GK8ksRLEX5fMGJbz20RhTNHVjw5+EHvfNATZ9D1qVoO8pcvcCSTuzkOOljF
         +V/4EvHaNGrtcRV3o/YJ0Vo/CXgAW+c0hAaY0ZFnxUTHGpyJYgIhnb7Oapxyycjvh65B
         KHyA==
X-Gm-Message-State: AA+aEWadYeqE6YTwMzZx1YvXDQpGqEd5iXpqnp57cR5ncPPwqKjlzTJJ
        S7Mt0ac0TXjN7SMSaXCAy8mWb5W+mFxYZw==
X-Google-Smtp-Source: ALg8bN4QYUT+Ovq5tSP422xDXuAb7BdTcIDF0hn2xhGxa1SH2NpZTDTNsmUu9bEfmoW1CTqFRXVzMQ==
X-Received: by 2002:ac8:7518:: with SMTP id u24mr47525948qtq.75.1546537140440;
        Thu, 03 Jan 2019 09:39:00 -0800 (PST)
Received: from ovpn-120-55.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id s46sm28228803qtc.63.2019.01.03.09.38.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Jan 2019 09:39:00 -0800 (PST)
Subject: Re: [PATCH v3] mm/page_owner: fix for deferred struct page init
To:     Michal Hocko <mhocko@kernel.org>
Cc:     akpm@linux-foundation.org, Pavel.Tatashin@microsoft.com,
        mingo@kernel.org, hpa@zytor.com, mgorman@techsingularity.net,
        iamjoonsoo.kim@lge.com, yang.shi@linaro.org, tglx@linutronix.de,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20181220185031.43146-1-cai@lca.pw>
 <20181220203156.43441-1-cai@lca.pw> <20190103115114.GL31793@dhcp22.suse.cz>
 <e3ff1455-06cc-063e-24f0-3b525c345b84@lca.pw>
 <20190103165927.GU31793@dhcp22.suse.cz>
From:   Qian Cai <cai@lca.pw>
Message-ID: <5d8f3a98-a954-c8ab-83d9-2f94c614f268@lca.pw>
Date:   Thu, 3 Jan 2019 12:38:59 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190103165927.GU31793@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/3/19 11:59 AM, Michal Hocko wrote:
>> As mentioned above, "If deselected DEFERRED_STRUCT_PAGE_INIT, it is still better
>> to call page_ext_init() earlier, so page owner could catch more early page
>> allocation call sites."
> 
> Do you have any numbers to show how many allocation are we losing that
> way? In other words, do we care enough to create an ugly code?

Well, I don't have any numbers, but I read that Joonsoo did not really like to
defer page_ext_init() unconditionally.

"because deferring page_ext_init() would make page owner which uses page_ext
miss some early page allocation callsites. Although it already miss some early
page allocation callsites, we don't need to miss more."

https://lore.kernel.org/lkml/20160524053714.GB32186@js1304-P5Q-DELUXE/

>>>> diff --git a/mm/page_ext.c b/mm/page_ext.c
>>>> index ae44f7adbe07..d76fd51e312a 100644
>>>> --- a/mm/page_ext.c
>>>> +++ b/mm/page_ext.c
>>>> @@ -399,9 +399,8 @@ void __init page_ext_init(void)
>>>>  			 * -------------pfn-------------->
>>>>  			 * N0 | N1 | N2 | N0 | N1 | N2|....
>>>>  			 *
>>>> -			 * Take into account DEFERRED_STRUCT_PAGE_INIT.
>>>>  			 */
>>>> -			if (early_pfn_to_nid(pfn) != nid)
>>>> +			if (pfn_to_nid(pfn) != nid)
>>>>  				continue;
>>>>  			if (init_section_page_ext(pfn, nid))
>>>>  				goto oom;
>>>
>>> Also this doesn't seem to be related, right?
>>
>> No, it is related. Because of this patch, page_ext_init() is called after all
>> the memory has already been initialized,
>> so no longer necessary to call early_pfn_to_nid().
> 
> Yes, but it looks like a follow up cleanup/optimization to me.

That early_pfn_to_nid() was introduced in fe53ca54270 (mm: use early_pfn_to_nid
in page_ext_init) which also messed up the order of page_ext_init() in
start_kernel(), so this patch basically revert that commit.
