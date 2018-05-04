Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751803AbeEDIHS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 04:07:18 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7651 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751339AbeEDIHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 04:07:16 -0400
Subject: Re: [PATCH] jffs2: safely remove obsolete dirent from the f->dents
 list
To: David Woodhouse <dwmw2@infradead.org>
CC: <Joakim.Tjernlund@infinera.com>, <viro@zeniv.linux.org.uk>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20180329120023.33169-1-yuyufen@huawei.com>
 <1524867762.18504.89.camel@infradead.org>
From: yuyufen <yuyufen@huawei.com>
Message-ID: <223f07c9-f07d-f434-6478-274990fbdf54@huawei.com>
Date: Fri, 4 May 2018 16:06:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1524867762.18504.89.camel@infradead.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.177.219.49]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2018/4/28 6:22, David Woodhouse wrote:
> This looks a lot better than the first iteration; thank you for getting
> it to this point. One last thing, I hope...
> On Thu, 2018-03-29 at 20:00 +0800, Yufen Yu wrote:
>> --- a/fs/jffs2/jffs2_fs_i.h
>> +++ b/fs/jffs2/jffs2_fs_i.h
>> @@ -42,6 +42,12 @@ struct jffs2_inode_info {
>>          /* Directory entries */
>>          struct jffs2_full_dirent *dents;
>>   
>> +       /* Directory open refcount */
>> +       atomic_t nr_dir_opening;
>> +
>> +       /* obsolete dirent count in the list of 'dents' */
>> +       unsigned int obsolete_count;
>> +
>>          /* The target path if this is the inode of a symlink */
>>          unsigned char *target;
>>   
> You've made JFFS2_INVALID_LIMIT 64, which is reasonable enough
> (although it's a bit of a weird name and possibly wants to be more
> specific — invalid *what*?).
Thansk a lot for your suggestions.

Yes, it is really a bad name. How about JFFS2_OBS_DIRENT_LIMIT?  I am 
not sure.

>
> So the maximum interesting value of ->obsolete_count is 64. Which means
> it might as well be a uint8_t and sit in the padding after the
> 'usercompr' field.
>
> It might be useful to look at putting the mutually exclusive fields in
> struct jffs2_inode_info into a union, and then we don't need the
> additional space of the atomic_t either; we'll never need that *and*
> the fragtree at the same time... will we?
You are right, thanks. But, obsolete_count may be large. So, I apply to 
use uint16_t and
it also sits in the padding after the 'usercompr' field.

Thanks,
Yufen
