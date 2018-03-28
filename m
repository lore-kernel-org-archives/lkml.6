Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752811AbeC1BO0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 21:14:26 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6706 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752594AbeC1BOZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 21:14:25 -0400
Subject: Re: [V9fs-developer] [PATCH] fs/9p: don't set SB_NOATIME by default
To: Andrew Morton <akpm@linux-foundation.org>
References: <5AB9A377.6080906@huawei.com>
 <20180327161529.f7d22a36ffc92dc1a3e15d92@linux-foundation.org>
CC: Eric Van Hensbergen <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>, Latchesar Ionkov <lucho@ionkov.net>,
        <linux-kernel@vger.kernel.org>, <v9fs-developer@lists.sourceforge.net>,
        Greg Kurz <groug@kaod.org>
From: jiangyiwen <jiangyiwen@huawei.com>
Message-ID: <5ABAEC64.1060003@huawei.com>
Date: Wed, 28 Mar 2018 09:14:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20180327161529.f7d22a36ffc92dc1a3e15d92@linux-foundation.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.16.168]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/3/28 7:15, Andrew Morton wrote:
> On Tue, 27 Mar 2018 09:50:47 +0800 jiangyiwen <jiangyiwen@huawei.com> wrote:
> 
>> User use some syscall, for example mmap(v9fs_file_mmap), it will not
>> update atime even if user's mnt_flags without MNT_NOATIME, because
>> v9fs default set SB_NOATIME in v9fs_set_super.
>>
>> For supporting access time is updated when user mount with relatime,
>> we should not set SB_NOATIME by default.
>>
>> ...
>>
>> --- a/fs/9p/vfs_super.c
>> +++ b/fs/9p/vfs_super.c
>> @@ -94,7 +94,7 @@ static int v9fs_set_super(struct super_block *s, void *data)
>>  	if (v9ses->cache)
>>  		sb->s_bdi->ra_pages = (VM_MAX_READAHEAD * 1024)/PAGE_SIZE;
>>
>> -	sb->s_flags |= SB_ACTIVE | SB_DIRSYNC | SB_NOATIME;
>> +	sb->s_flags |= SB_ACTIVE | SB_DIRSYNC;
>>  	if (!v9ses->cache)
>>  		sb->s_flags |= SB_SYNCHRONOUS;
>>
> 
> So strictly speaking, this is a non-backward-compatible change, yes?
> 
> Please describe the circumstances under which an existing user might be
> harmed by this.  I *think* such harm will occur if the user was already
> using 'mount -o relatime', yes?  They previously weren't getting
> relatime treatment, but now they will, and things will be a little slower.
> 

Yes, after using this change, if user was already using 'mount -o relatime',
their atime will be changed, and some operations will result in slower
performance, but I think user should use 'noatime' option if they hope
their file's atime is not updated and user should not depend on the
internal implement.

> If correct, that sounds acceptable.
> 
> .
> 
