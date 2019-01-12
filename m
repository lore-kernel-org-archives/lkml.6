Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BB3C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 00:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84D2F20878
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 00:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="oo6aJiz3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbfALAS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 19:18:59 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40609 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbfALAS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 19:18:59 -0500
Received: by mail-qt1-f196.google.com with SMTP id k12so20822337qtf.7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 16:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YcxAErV1U/iSFnvnjndqKzdnyRSgCv9WjzVOePUJ7Go=;
        b=oo6aJiz3h263NQLeeI9FyS3icAq/ksHG/XfI5kvJo7oPvdcYF38kUhaYUrgYKU8jv2
         afVSOl/Z/Q87FKsh1wymwaK+dgQbug3Vj1v16B85npWyrnrquq2Va27utHt7E5aOdqH8
         Q49viHFFoHRAsMEf92FXYyJulbMHaJ2prims5WOSxCEgRprxycj6thX4P7N1eBMc2a6A
         78whBLC+ailYZmIMgE+3Dd49DDrx6o7tnJZ9fW3ZGTZ1Z4dwHqE7M/NFSSFF/QH3/Da6
         RmjAlItVOusGbpusRKKagKfA+Hjug2nbxKsS7pU5bTwHbRjg/8e0X9VNFJyyc4Q0EhsZ
         mvPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YcxAErV1U/iSFnvnjndqKzdnyRSgCv9WjzVOePUJ7Go=;
        b=RCB5KWRcSRs/Kms5UNvUh+G77Y8VsUQfKP6sqMqOpmutc4XoLZ63gsx74BzOttOqCY
         mU/t8HKE1qjgTUxOzC6Tju41qSEsAB/YCFtw9/8HPE05Gk0ng2SWZXp8ykjH8lVr6EIh
         jh8j+6q6PXXPOpiUgSa4w40z6Ls3wKXZQO4DxfUanXmXmUCbhyGn9Nu0+gSRunkiCF0z
         NCcYN6I54/Np1SUWLcMEttpsBDoG07uSZcNV7D+MOmB8kGkRfzvaZ18Ydv2VeNYD9VzT
         zaGQuVRQYTz15CKTI6wg0JDxDyA/RlR+/aWO+Wbar7sHIKOe2Qbv6eTc1IpY6EWCLGma
         J0cQ==
X-Gm-Message-State: AJcUuke6hUYLRYEJPPdqyO5a/Fa0aQUyCRnwcvHpHErwbvlrUypqNirK
        na6RKll1xOVJLmILz/jwsWQd1sUaju4O0w==
X-Google-Smtp-Source: ALg8bN6rez0o/+iZG9/mYcoC5HIHE03UWWKU1fNSgRaerbMEnb1w+eJxizWSlYgaCOrfFMV1KSsMrA==
X-Received: by 2002:aed:39e8:: with SMTP id m95mr15591688qte.317.1547252337705;
        Fri, 11 Jan 2019 16:18:57 -0800 (PST)
Received: from ovpn-120-55.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id q184sm33640910qkb.23.2019.01.11.16.18.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 16:18:57 -0800 (PST)
Subject: Re: [PATCH v2] rbtree: fix the red root
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, esploit@protonmail.ch,
        jejb@linux.ibm.com, dgilbert@interlog.com,
        martin.petersen@oracle.com, joeypabalinas@gmail.com,
        walken@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20190111181600.GJ6310@bombadil.infradead.org>
 <20190111205843.25761-1-cai@lca.pw>
 <20190111231652.GN6310@bombadil.infradead.org>
From:   Qian Cai <cai@lca.pw>
Message-ID: <463fa1f6-4ee6-ef4d-431c-3c392c827792@lca.pw>
Date:   Fri, 11 Jan 2019 19:18:55 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190111231652.GN6310@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/11/19 6:16 PM, Matthew Wilcox wrote:
> On Fri, Jan 11, 2019 at 03:58:43PM -0500, Qian Cai wrote:
>> diff --git a/lib/rbtree_test.c b/lib/rbtree_test.c
>> index b7055b2a07d3..afad0213a117 100644
>> --- a/lib/rbtree_test.c
>> +++ b/lib/rbtree_test.c
>> @@ -345,6 +345,17 @@ static int __init rbtree_test_init(void)
>>  		check(0);
>>  	}
>>  
>> +	/*
>> +	 * a little regression test to catch a bug may be introduced by
>> +	 * 6d58452dc06 (rbtree: adjust root color in rb_insert_color() only when
>> +	 * necessary)
>> +	 */
>> +	insert(nodes, &root);
>> +	nodes->rb.__rb_parent_color = RB_RED;
>> +	insert(nodes + 1, &root);
>> +	erase(nodes + 1, &root);
>> +	erase(nodes, &root);
> 
> That's not a fair test!  You're poking around in the data structure to
> create the situation.  This test would have failed before 6d58452dc06 too.
> How do we create a tree that has a red parent at root, only using insert()
> and erase()?
> 

If only I knew how to reproduce this myself, I might be able to figure out how
it ends up with the red root in the first place.
