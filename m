Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965574AbeCAC6x (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 21:58:53 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:5690 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965531AbeCAC6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 21:58:52 -0500
Subject: Re: [PATCH v4] Revert "f2fs crypto: avoid unneeded memory allocation
 in ->readdir"
To: Jaegeuk Kim <jaegeuk@kernel.org>
CC: Yunlong Song <yunlong.song@huawei.com>, <chao@kernel.org>,
        <yunlong.song@icloud.com>, <miaoxie@huawei.com>,
        <bintian.wang@huawei.com>, <shengyong1@huawei.com>,
        <heyunlei@huawei.com>, <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <1519463698-60555-1-git-send-email-yunlong.song@huawei.com>
 <1519787857-107910-1-git-send-email-yunlong.song@huawei.com>
 <20180228054810.GB86647@jaegeuk-macbookpro.roam.corp.google.com>
 <c36a6024-209c-b660-ba61-e681a98e6f3b@huawei.com>
 <20180301025009.GC18665@jaegeuk-macbookpro.roam.corp.google.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <7836e341-f2ad-0037-6efc-9927a82e51dd@huawei.com>
Date: Thu, 1 Mar 2018 11:02:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180301025009.GC18665@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/3/1 10:50, Jaegeuk Kim wrote:
> On 02/28, Chao Yu wrote:
>> Hi Jaegeuk,
>>
>> On 2018/2/28 13:48, Jaegeuk Kim wrote:
>>> Hi Yunlong,
>>>
>>> As Eric pointed out, how do you think using nohighmem for directory likewise
>>
>> I'd like to ask, at the beginning, why we choose to use highmem for dentry page?
>> any history reason there?
> 
> There was no huge preference on it based on performance. I just wanted not to
> abuse lowmem.

Got you, thanks for explanation.

Thanks,

> 
> Thanks,
> 
>>
>>> ext4, which looks like more efficient? Actually, we don't need to do this in
>>> most of recent kernels, right?
>>
>> It's OK to me to keep a line with ext4.
>>
>> Thanks,
>>
>>>
>>> Thanks,
>>>
>>> On 02/28, Yunlong Song wrote:
>>>> This reverts commit e06f86e61d7a67fe6e826010f57aa39c674f4b1b.
>>>>
>>>> Conflicts:
>>>> 	fs/f2fs/dir.c
>>>>
>>>> In some platforms (such as arm), high memory is used, then the
>>>> decrypting filename will cause panic, the reason see commit
>>>> 569cf1876a32e574ba8a7fb825cd91bafd003882 ("f2fs crypto: allocate buffer
>>>> for decrypting filename"):
>>>>
>>>>  We got dentry pages from high_mem, and its address space directly goes into the
>>>>  decryption path via f2fs_fname_disk_to_usr.
>>>>  But, sg_init_one assumes the address is not from high_mem, so we can get this
>>>>  panic since it doesn't call kmap_high but kunmap_high is triggered at the end.
>>>>
>>>>  kernel BUG at ../../../../../../kernel/mm/highmem.c:290!
>>>>  Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
>>>>  ...
>>>>   (kunmap_high+0xb0/0xb8) from [<c0114534>] (__kunmap_atomic+0xa0/0xa4)
>>>>   (__kunmap_atomic+0xa0/0xa4) from [<c035f028>] (blkcipher_walk_done+0x128/0x1ec)
>>>>   (blkcipher_walk_done+0x128/0x1ec) from [<c0366c24>] (crypto_cbc_decrypt+0xc0/0x170)
>>>>   (crypto_cbc_decrypt+0xc0/0x170) from [<c0367148>] (crypto_cts_decrypt+0xc0/0x114)
>>>>   (crypto_cts_decrypt+0xc0/0x114) from [<c035ea98>] (async_decrypt+0x40/0x48)
>>>>   (async_decrypt+0x40/0x48) from [<c032ca34>] (f2fs_fname_disk_to_usr+0x124/0x304)
>>>>   (f2fs_fname_disk_to_usr+0x124/0x304) from [<c03056fc>] (f2fs_fill_dentries+0xac/0x188)
>>>>   (f2fs_fill_dentries+0xac/0x188) from [<c03059c8>] (f2fs_readdir+0x1f0/0x300)
>>>>   (f2fs_readdir+0x1f0/0x300) from [<c0218054>] (vfs_readdir+0x90/0xb4)
>>>>   (vfs_readdir+0x90/0xb4) from [<c0218418>] (SyS_getdents64+0x64/0xcc)
>>>>   (SyS_getdents64+0x64/0xcc) from [<c0105ba0>] (ret_fast_syscall+0x0/0x30)
>>>>
>>>> Howerver, later patch:
>>>> commit e06f86e61d7a ("f2fs crypto: avoid unneeded memory allocation in ->readdir")
>>>> reverts the codes, which causes panic again in arm, so fix it back to the old version.
>>>>
>>>> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
>>>> Reviewed-by: Chao Yu <yuchao0@huawei.com>
>>>> ---
>>>>  fs/f2fs/dir.c | 7 +++++++
>>>>  1 file changed, 7 insertions(+)
>>>>
>>>> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
>>>> index f00b5ed..de2e295 100644
>>>> --- a/fs/f2fs/dir.c
>>>> +++ b/fs/f2fs/dir.c
>>>> @@ -825,9 +825,16 @@ int f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
>>>>  			int save_len = fstr->len;
>>>>  			int err;
>>>>  
>>>> +			de_name.name = f2fs_kmalloc(sbi, de_name.len, GFP_NOFS);
>>>> +			if (!de_name.name)
>>>> +				return -ENOMEM;
>>>> +
>>>> +			memcpy(de_name.name, d->filename[bit_pos], de_name.len);
>>>> +
>>>>  			err = fscrypt_fname_disk_to_usr(d->inode,
>>>>  						(u32)de->hash_code, 0,
>>>>  						&de_name, fstr);
>>>> +			kfree(de_name.name);
>>>>  			if (err)
>>>>  				return err;
>>>>  
>>>> -- 
>>>> 1.8.5.2
>>>
>>> .
>>>
> 
> .
> 
