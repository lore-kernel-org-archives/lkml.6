Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161527AbeBNRp5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 12:45:57 -0500
Received: from www62.your-server.de ([213.133.104.62]:51223 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161455AbeBNRpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 12:45:39 -0500
Subject: Re: [PATCH net] bpf: cpumap: use GFP_KERNEL instead of GFP_ATOMIC in
 __cpu_map_entry_alloc()
To: "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Cc: ast@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>, Matthew Wilcox <willy@infradead.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>, akpm@linux-foundation.org,
        dhowells@redhat.com, hannes@cmpxchg.org
References: <1518617854-4486-1-git-send-email-jasowang@redhat.com>
 <20180214190311-mutt-send-email-mst@kernel.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <ddb3e66a-85e4-9a31-2720-a22b9cb976d4@iogearbox.net>
Date: Wed, 14 Feb 2018 18:45:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180214190311-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/14/2018 06:04 PM, Michael S. Tsirkin wrote:
> On Wed, Feb 14, 2018 at 10:17:34PM +0800, Jason Wang wrote:
>> There're several implications after commit 0bf7800f1799 ("ptr_ring:
>> try vmalloc() when kmalloc() fails") with the using of vmalloc() since
>> can't allow GFP_ATOMIC but mandate GFP_KERNEL. This will lead a WARN
>> since cpumap try to call with GFP_ATOMIC. Fortunately, entry
>> allocation of cpumap can only be done through syscall path which means
>> GFP_ATOMIC is not necessary, so fixing this by replacing GFP_ATOMIC
>> with GFP_KERNEL.
>>
>> Reported-by: syzbot+1a240cdb1f4cc88819df@syzkaller.appspotmail.com
>> Fixes: 0bf7800f1799 ("ptr_ring: try vmalloc() when kmalloc() fails")
>> Cc: Michal Hocko <mhocko@kernel.org>
>> Cc: Daniel Borkmann <daniel@iogearbox.net>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Cc: Jesper Dangaard Brouer <brouer@redhat.com>
>> Cc: akpm@linux-foundation.org
>> Cc: dhowells@redhat.com
>> Cc: hannes@cmpxchg.org
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
> 
> Frankly I'd start with the revert. The original patch was rushed
> into net without enough justification IMHO, and we just seem to keep
> piling up these things. How about deferring all these ideas
> to net-next?

It's up to you if you think a revert is needed. The below is fine and
small enough in any case for cpumap, imho.

>>  kernel/bpf/cpumap.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
>> index fbfdada6..a4bb0b3 100644
>> --- a/kernel/bpf/cpumap.c
>> +++ b/kernel/bpf/cpumap.c
>> @@ -334,7 +334,7 @@ static int cpu_map_kthread_run(void *data)
>>  static struct bpf_cpu_map_entry *__cpu_map_entry_alloc(u32 qsize, u32 cpu,
>>  						       int map_id)
>>  {
>> -	gfp_t gfp = GFP_ATOMIC|__GFP_NOWARN;
>> +	gfp_t gfp = GFP_KERNEL | __GFP_NOWARN;
>>  	struct bpf_cpu_map_entry *rcpu;
>>  	int numa, err;
>>  
>> -- 
>> 2.7.4
