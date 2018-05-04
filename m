Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751855AbeEDJ2H (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 05:28:07 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:54009 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751823AbeEDJ2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 05:28:06 -0400
Subject: Re: [PATCH] jffs2: safely remove obsolete dirent from the f->dents
 list
To: David Woodhouse <dwmw2@infradead.org>
CC: <Joakim.Tjernlund@infinera.com>, <viro@zeniv.linux.org.uk>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20180329120023.33169-1-yuyufen@huawei.com>
 <1524867762.18504.89.camel@infradead.org>
 <223f07c9-f07d-f434-6478-274990fbdf54@huawei.com>
 <1525421898.9367.116.camel@infradead.org>
From: yuyufen <yuyufen@huawei.com>
Message-ID: <012cd157-0c85-34a2-b42a-d9b3f6434c49@huawei.com>
Date: Fri, 4 May 2018 17:27:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1525421898.9367.116.camel@infradead.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.177.219.49]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, David.
On 2018/5/4 16:18, David Woodhouse wrote:
>
> On Fri, 2018-05-04 at 16:06 +0800, yuyufen wrote:
>>> You've made JFFS2_INVALID_LIMIT 64, which is reasonable enough
>>> (although it's a bit of a weird name and possibly wants to be more
>>> specific — invalid *what*?).
>> Thansk a lot for your suggestions.
>>
>> Yes, it is really a bad name. How about JFFS2_OBS_DIRENT_LIMIT?  I am
>> not sure.
> That'll do; at least it's a hint in the right direction :)
>
>>> So the maximum interesting value of ->obsolete_count is 64. Which means
>>> it might as well be a uint8_t and sit in the padding after the
>>> 'usercompr' field.
>>>
>>> It might be useful to look at putting the mutually exclusive fields in
>>> struct jffs2_inode_info into a union, and then we don't need the
>>> additional space of the atomic_t either; we'll never need that *and*
>>> the fragtree at the same time... will we?
>> You are right, thanks. But, obsolete_count may be large. So, I apply to
>> use uint16_t and it also sits in the padding after the 'usercompr'
>> field.
> You can always just cap it. Once it reaches 64 it never changes again,
> until you actually harvest them. Without that, a uint16_t could
> overflow too.

I think 'JFFS2_OBS_DIRENT_LIMIT' may cause misunderstanding. Sorry for that.
In my patch, it just means a threshold value. when ->nr_dir_opening is 
'0' and
  ->obsolete_count is bigger than the value, it can trigger removing 
operations.

If ->nr_dir_opening is not '0', obsolete_count may continuously increase 
and can
exceed 64.

+static int jffs2_dir_release(struct inode *dir_i, struct file *filp)
+{
+#ifndef CONFIG_JFFS2_SUMMARY
+       struct jffs2_inode_info *dir_f = JFFS2_INODE_INFO(dir_i);
+
+       BUG_ON(atomic_read(&dir_f->nr_dir_opening) <= 0);
+
+       mutex_lock(&dir_f->sem);
+       /* jffs2_dir_open may increase nr_dir_opening after
+        * atomic_dec_and_test() returning true.
+        * However, it cannot traverse the list until hold
+        * mutex dir_f->sem lock, so that we can go on
+{
+#ifndef CONFIG_JFFS2_SUMMARY
+       struct jffs2_inode_info *dir_f = JFFS2_INODE_INFO(dir_i);
+
+       BUG_ON(atomic_read(&dir_f->nr_dir_opening) <= 0);
+
+       mutex_lock(&dir_f->sem);
+       /* jffs2_dir_open may increase nr_dir_opening after
+        * atomic_dec_and_test() returning true.
+        * However, it cannot traverse the list until hold
+        * mutex dir_f->sem lock, so that we can go on
+        * removing.*/
+       if (atomic_dec_and_test(&dir_f->nr_dir_opening) &&
+                       dir_f->obsolete_count > JFFS2_OBS_DIRENT_LIMIT) {
+               struct jffs2_full_dirent **prev = &dir_f->dents;
+
+               /* remove all obsolete dirent from the list, which
+                * can save memory space and reduce CPU time for
+                * traverse the list */
+               while((*prev) && (dir_f->obsolete_count--)) {
+                       if ((*prev)->raw == NULL && (*prev)->ino == 0) {
+                               struct jffs2_full_dirent *this = *prev;
+                               *prev = this->next;
+                               jffs2_free_full_dirent(this);
+                       } else
+                               prev = &((*prev)->next);
+               }
+       }
+       mutex_unlock(&dir_f->sem);
+#endif
+
+       return 0;
+}

Thanks,
Yufen
