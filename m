Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6EABC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 09:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE8CE2184E
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 09:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729224AbeL2JwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 04:52:24 -0500
Received: from relay.sw.ru ([185.231.240.75]:56738 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726989AbeL2JwY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 04:52:24 -0500
Received: from [172.16.25.169]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1gdBI3-0000Se-PX; Sat, 29 Dec 2018 12:52:19 +0300
Subject: Re: Re: [PATCH] netfilter: account ebt_table_info to kmemcg
To:     Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        syzbot+7713f3aa67be76b1552c@syzkaller.appspotmail.com
References: <20181229015524.222741-1-shakeelb@google.com>
 <20181229073325.GZ16738@dhcp22.suse.cz>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <7c0fa75f-df2f-668e-ebc2-3d3e9831030f@virtuozzo.com>
Date:   Sat, 29 Dec 2018 12:52:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181229073325.GZ16738@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Michal!

On 29.12.2018 10:33, Michal Hocko wrote:
> On Fri 28-12-18 17:55:24, Shakeel Butt wrote:
>> The [ip,ip6,arp]_tables use x_tables_info internally and the underlying
>> memory is already accounted to kmemcg. Do the same for ebtables. The
>> syzbot, by using setsockopt(EBT_SO_SET_ENTRIES), was able to OOM the
>> whole system from a restricted memcg, a potential DoS.
> 
> What is the lifetime of these objects? Are they bound to any process?

These are list of ebtables rules, which may be displayed with $ebtables-save command.
In case of we do not account them, a low priority container may eat all the memory
and OOM killer in berserk mode will kill all the processes on machine. They are not bound
to any process, but they are bound to network namespace.

OOM killer does not analyze such the memory cgroup-related allocations, since it
is task-aware only. Maybe we should do it namespace-aware too...

Kirill

>> Reported-by: syzbot+7713f3aa67be76b1552c@syzkaller.appspotmail.com
>> Signed-off-by: Shakeel Butt <shakeelb@google.com>
>> ---
>>  net/bridge/netfilter/ebtables.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebtables.c
>> index 491828713e0b..5e55cef0cec3 100644
>> --- a/net/bridge/netfilter/ebtables.c
>> +++ b/net/bridge/netfilter/ebtables.c
>> @@ -1137,14 +1137,16 @@ static int do_replace(struct net *net, const void __user *user,
>>  	tmp.name[sizeof(tmp.name) - 1] = 0;
>>  
>>  	countersize = COUNTER_OFFSET(tmp.nentries) * nr_cpu_ids;
>> -	newinfo = vmalloc(sizeof(*newinfo) + countersize);
>> +	newinfo = __vmalloc(sizeof(*newinfo) + countersize, GFP_KERNEL_ACCOUNT,
>> +			    PAGE_KERNEL);
>>  	if (!newinfo)
>>  		return -ENOMEM;
>>  
>>  	if (countersize)
>>  		memset(newinfo->counters, 0, countersize);
>>  
>> -	newinfo->entries = vmalloc(tmp.entries_size);
>> +	newinfo->entries = __vmalloc(tmp.entries_size, GFP_KERNEL_ACCOUNT,
>> +				     PAGE_KERNEL);
>>  	if (!newinfo->entries) {
>>  		ret = -ENOMEM;
>>  		goto free_newinfo;
>> -- 
>> 2.20.1.415.g653613c723-goog
>>
> 
