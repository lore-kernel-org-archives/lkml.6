Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA22C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 17:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5BE7205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 17:11:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5BE7205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbeH2VJD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 17:09:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46540 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728286AbeH2VJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 17:09:03 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 83FF6B5CA;
        Wed, 29 Aug 2018 17:11:09 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-8.bos.redhat.com [10.18.17.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 580002026D6D;
        Wed, 29 Aug 2018 17:11:08 +0000 (UTC)
Subject: Re: [PATCH 1/2] fs/dcache: Track & report number of negative dentries
To:     Dave Chinner <david@fromorbit.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Kara <jack@suse.cz>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Larry Woodman <lwoodman@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        "Wangkai (Kevin C)" <wangkai86@huawei.com>,
        Michal Hocko <mhocko@kernel.org>
References: <1535476780-5773-1-git-send-email-longman@redhat.com>
 <1535476780-5773-2-git-send-email-longman@redhat.com>
 <20180829001153.GD1572@dastard>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <e084f670-b279-0f85-404c-9506e329f633@redhat.com>
Date:   Wed, 29 Aug 2018 13:11:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180829001153.GD1572@dastard>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Wed, 29 Aug 2018 17:11:09 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Wed, 29 Aug 2018 17:11:09 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'longman@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/28/2018 08:11 PM, Dave Chinner wrote:
> On Tue, Aug 28, 2018 at 01:19:39PM -0400, Waiman Long wrote:
>> The current dentry number tracking code doesn't distinguish between
>> positive & negative dentries. It just reports the total number of
>> dentries in the LRU lists.
>>
>> As excessive number of negative dentries can have an impact on system
>> performance, it will be wise to track the number of positive and
>> negative dentries separately.
>>
>> This patch adds tracking for the total number of negative dentries in
>> the system LRU lists and reports it in the /proc/sys/fs/dentry-state
>> file. The number, however, does not include negative dentries that are
>> in flight but not in the LRU yet.
>>
>> The number of positive dentries in the LRU lists can be roughly found
>> by subtracting the number of negative dentries from the total.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>  Documentation/sysctl/fs.txt | 19 +++++++++++++------
>>  fs/dcache.c                 | 45 +++++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/dcache.h      |  7 ++++---
>>  3 files changed, 62 insertions(+), 9 deletions(-)
>>
>> diff --git a/Documentation/sysctl/fs.txt b/Documentation/sysctl/fs.txt
>> index 819caf8..118bb93 100644
>> --- a/Documentation/sysctl/fs.txt
>> +++ b/Documentation/sysctl/fs.txt
>> @@ -63,19 +63,26 @@ struct {
>>          int nr_unused;
>>          int age_limit;         /* age in seconds */
>>          int want_pages;        /* pages requested by system */
>> -        int dummy[2];
>> +        int nr_negative;       /* # of unused negative dentries */
>> +        int dummy;
>>  } dentry_stat = {0, 0, 45, 0,};
> That's not a backwards compatible ABI change. Those dummy fields
> used to represent some metric we no longer calculate, and there are
> probably still monitoring apps out there that think they still have
> the old meaning. i.e. they are still visible to userspace:
>
> $ cat /proc/sys/fs/dentry-state 
> 83090	67661	45	0	0	0
> $
>
> IOWs, you can add new fields for new metrics to the end of the
> structure, but you can't re-use existing fields even if they
> aren't calculated anymore.
>
> [....]

I looked up the git history and the state of the dentry_stat structure
hadn't changed since it was first put into git in 2.6.12-rc2 on Apr 16,
2005. That was over 13 years ago. Even adding an extra argument can have
the potential of breaking old applications depending on how the parsing
code was written.

Given that systems that are still using some very old tools are not
likely to upgrade to the latest kernel anyway. I don't see that as a big
problem.

>> @@ -214,6 +226,28 @@ static inline int dentry_string_cmp(const unsigned char *cs, const unsigned char
>>  
>>  #endif
>>  
>> +static inline void __neg_dentry_dec(struct dentry *dentry)
>> +{
>> +	this_cpu_dec(nr_dentry_neg);
>> +}
>> +
>> +static inline void neg_dentry_dec(struct dentry *dentry)
>> +{
>> +	if (unlikely(d_is_negative(dentry)))
>> +		__neg_dentry_dec(dentry);
> unlikely() considered harmful.
>
> The workload you are trying to optimise is whe negative dentries are
> the common case. IOWs, static branch prediction hints like this will
> be wrong exactly when we want the branch to be predicted correctly
> by the hardware.

You are right. I will remove the branch hints.

>> +}
>> +
>> +static inline void __neg_dentry_inc(struct dentry *dentry)
>> +{
>> +	this_cpu_inc(nr_dentry_neg);
>> +}
>> +
>> +static inline void neg_dentry_inc(struct dentry *dentry)
>> +{
>> +	if (unlikely(d_is_negative(dentry)))
>> +		__neg_dentry_inc(dentry);
>> +}
> These wrappers obfuscate the code - they do not do what the
> name suggests and instead are conditional on dentry state.
>
> I'd just open code this stuff - the code is much better without
> the wrappers.

Sure. I will open code the counter updates.

>> +
>>  static inline int dentry_cmp(const struct dentry *dentry, const unsigned char *ct, unsigned tcount)
>>  {
>>  	/*
>> @@ -331,6 +365,8 @@ static inline void __d_clear_type_and_inode(struct dentry *dentry)
>>  	flags &= ~(DCACHE_ENTRY_TYPE | DCACHE_FALLTHRU);
>>  	WRITE_ONCE(dentry->d_flags, flags);
>>  	dentry->d_inode = NULL;
>> +	if (dentry->d_flags & DCACHE_LRU_LIST)
>> +		__neg_dentry_inc(dentry);
>>  }
>>  
>>  static void dentry_free(struct dentry *dentry)
>> @@ -395,6 +431,7 @@ static void d_lru_add(struct dentry *dentry)
>>  	dentry->d_flags |= DCACHE_LRU_LIST;
>>  	this_cpu_inc(nr_dentry_unused);
>>  	WARN_ON_ONCE(!list_lru_add(&dentry->d_sb->s_dentry_lru, &dentry->d_lru));
>> +	neg_dentry_inc(dentry);
> Like this - why on earth would we increment the negative dentry
> count for every dentry that is added to LRU? Open coding
>
>  	this_cpu_inc(nr_dentry_unused);
> +	if (d_is_negative(dentry))
> +		this_cpu_inc(nr_dentry_neg);
>  	WARN_ON_ONCE(!list_lru_add(&dentry->d_sb->s_dentry_lru, &dentry->d_lru));
>
> That's obvious to the reader what we are doing, and it aggregates
> all the accounting in a single location. Same for the rest of the
> code.
>
> Cheers,
>
> Dave.

Cheers,
Longman


