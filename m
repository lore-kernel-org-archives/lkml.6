Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E45EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 09:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26FB7214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 09:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbfAJJsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 04:48:22 -0500
Received: from relay.sw.ru ([185.231.240.75]:55706 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727892AbfAJJsW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 04:48:22 -0500
Received: from [172.16.25.169]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1ghWwk-0003FI-9b; Thu, 10 Jan 2019 12:48:18 +0300
Subject: Re: [PATCH v2] netfilter: account ebt_table_info to kmemcg
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Florian Westphal <fw@strlen.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        syzbot+7713f3aa67be76b1552c@syzkaller.appspotmail.com,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        bridge@lists.linux-foundation.org
References: <20190103031431.247970-1-shakeelb@google.com>
 <5cc8efad-9d3d-3136-3ddc-1f8a640cb1f8@virtuozzo.com>
 <2d8f28cb-8620-be05-21bc-dcf3009b2774@virtuozzo.com>
 <20190110094142.GI31793@dhcp22.suse.cz>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <4c8051dd-2214-49eb-a342-5ee2171665d1@virtuozzo.com>
Date:   Thu, 10 Jan 2019 12:48:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20190110094142.GI31793@dhcp22.suse.cz>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.01.2019 12:41, Michal Hocko wrote:
> On Thu 10-01-19 12:22:09, Kirill Tkhai wrote:
> [...]
>>>> diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebtables.c
>>>> index 491828713e0b..5e55cef0cec3 100644
>>>> --- a/net/bridge/netfilter/ebtables.c
>>>> +++ b/net/bridge/netfilter/ebtables.c
>>>> @@ -1137,14 +1137,16 @@ static int do_replace(struct net *net, const void __user *user,
>>>>  	tmp.name[sizeof(tmp.name) - 1] = 0;
>>>>  
>>>>  	countersize = COUNTER_OFFSET(tmp.nentries) * nr_cpu_ids;
>>>> -	newinfo = vmalloc(sizeof(*newinfo) + countersize);
>>>> +	newinfo = __vmalloc(sizeof(*newinfo) + countersize, GFP_KERNEL_ACCOUNT,
>>>> +			    PAGE_KERNEL);
>>
>> Do we need GFP_HIGHMEM here?
> 
> No. vmalloc adds __GPF_HIGHMEM implicitly (see __vmalloc_area_node).

Then OK, thanks for the explanation.

Kirill
