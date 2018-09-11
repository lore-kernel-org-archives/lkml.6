Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04EC5C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 05:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9EE7206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 05:29:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9EE7206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbeIKK1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 06:27:20 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:51213 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726816AbeIKK1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 06:27:20 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 81E9BBBAA45ED;
        Tue, 11 Sep 2018 13:29:43 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.206) with Microsoft SMTP Server (TLS) id 14.3.399.0; Tue, 11 Sep
 2018 13:29:37 +0800
Subject: Re: [RFC PATCH v2 2/2] fscrypt: enable RCU-walk path for
 .d_revalidate
To:     Eric Biggers <ebiggers@kernel.org>
CC:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        <linux-fscrypt@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Chao Yu <yuchao0@huawei.com>, Miao Xie <miaoxie@huawei.com>,
        <weidu.du@huawei.com>
References: <1536584468-15695-2-git-send-email-gaoxiang25@huawei.com>
 <1536584937-16960-1-git-send-email-gaoxiang25@huawei.com>
 <20180910232007.GA19951@gmail.com>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <f10986d8-1edf-3834-2daf-1a0115484f97@huawei.com>
Date:   Tue, 11 Sep 2018 13:29:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180910232007.GA19951@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On 2018/9/11 7:20, Eric Biggers wrote:
> Hi Gao,
> 
> On Mon, Sep 10, 2018 at 09:08:57PM +0800, Gao Xiang wrote:
>> This patch attempts to enable RCU-walk for fscrypt.
>> It looks harmless at glance and could have better
>> performance than do ref-walk only.
>>
>> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
>> ---
>> change log v2:
>> 	- READ_ONCE(dir->d_parent) -> READ_ONCE(dentry->d_parent)
>>
>>  fs/crypto/crypto.c | 22 +++++++++++++---------
>>  1 file changed, 13 insertions(+), 9 deletions(-)
>>
>> diff --git a/fs/crypto/crypto.c b/fs/crypto/crypto.c
>> index b38c574..9bd21c0 100644
>> --- a/fs/crypto/crypto.c
>> +++ b/fs/crypto/crypto.c
>> @@ -319,20 +319,24 @@ static int fscrypt_d_revalidate(struct dentry *dentry, unsigned int flags)
>>  {
>>  	struct dentry *dir;
>>  	int dir_has_key, cached_with_key;
>> -
>> -	if (flags & LOOKUP_RCU)
>> -		return -ECHILD;
>> -
>> -	dir = dget_parent(dentry);
>> -	if (!IS_ENCRYPTED(d_inode(dir))) {
>> -		dput(dir);
>> +	struct inode *dir_inode;
>> +
>> +	rcu_read_lock();
>> +repeat:
>> +	dir = READ_ONCE(dentry->d_parent);
>> +	dir_inode = d_inode_rcu(dir);
>> +	if (!IS_ENCRYPTED(dir_inode)) {
>> +		rcu_read_unlock();
>>  		return 0;
>>  	}
>> +	dir_has_key = (dir_inode->i_crypt_info != NULL);
>> +	if (unlikely(READ_ONCE(dir->d_lockref.count) < 0 ||
>> +		READ_ONCE(dentry->d_parent) != dir))
>>
>>
>> +	rcu_read_unlock();
>>  
>>  	cached_with_key = READ_ONCE(dentry->d_flags) &
>>  		DCACHE_ENCRYPTED_WITH_KEY;
>> -	dir_has_key = (d_inode(dir)->i_crypt_info != NULL);
>> -	dput(dir);
>>  
> 
> I think you're right that we don't have to drop out of RCU mode here, but can
> you please Cc linux-fsdevel so that people more knowledgeable about path lookup
> can review this too?  This kind of stuff is very tricky.  Please resend both
> patches.
> 
> Also please indent properly:
> 
> 	if (unlikely(READ_ONCE(dir->d_lockref.count) < 0 ||
>                      READ_ONCE(dentry->d_parent) != dir))
> 		goto repeat;
> 
> Why read d_lockref.count directly instead of using __lockref_is_dead()?

will be fixed in the next version, thanks.

> 
> Also since there's no longer any reference to the parent dentry taken, how do
> you know it's still positive (non-NULL d_inode), i.e. that the directory hasn't
> been removed and turned into a negative dentry (NULL d_inode)?

I think you are right. I saw this fscrypt piece of code when I was locating a
problem related to fscrypt (I am still taking part in it since the problem is urgent).
It seems that it could be turned into a negative dentry by d_delete() etc.

I will rethink this flow more, make the next patch later and Cc linux-devel
the next time.

> 
> I'm also wondering whether the retry loop is actually needed.  Can you explain
> your thoughts more?  But if it is needed, in principle you'd actually need to
> wait until after the loop before taking any action based on dir_inode, right?
> That would mean the 'rcu_read_unlock(); return 0;' is in the wrong place.
What I thought was that I guess it needs to be more strict to claim the dentry is
still valid than other cases (therefore IS_ENCRYPTED is not so strict, that is
my personal thought tho.)

If the parent dentry just sampled is invalid, since the dentry and inode are
protected by rcu, so there is no way to READ_ONCE(dentry->d_parent) == dir.

Therefore I sampled (IS_ENCRYPTED, dir_has_key) and do a final basic validity
check at last --- currently dentry itself (maybe inode later), and I tend to
try again especially for ref-walk case (which not governed by d_seq) since it is
more lightweight (like a seqlock) than taking & releasing d_lock (or even
return 0 to do real lookup again) I think.

That is my personal thought, could not be accurate, and I am trying to learn
more about the fscrypt due to the urgent problem.

If any error, please kindly point out, thanks...

Thanks,
Gao Xiang

> 
> Thanks,
> 
> - Eric
> 
