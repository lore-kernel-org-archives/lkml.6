Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755444AbeDYSEg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 14:04:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:38556 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750935AbeDYSEe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 14:04:34 -0400
Subject: Re: [RFC] [PATCH 0/5] procfs: reduce duplication by using symlinks
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
References: <20180424022106.16952-1-jeffm@suse.com>
 <20180424061700.GA3689@avx2>
From: Jeff Mahoney <jeffm@suse.com>
Openpgp: preference=signencrypt
Message-ID: <43fd713e-1ebf-7250-5ddb-e0326e0c3376@suse.com>
Date: Wed, 25 Apr 2018 14:04:30 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180424061700.GA3689@avx2>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/18 2:17 AM, Alexey Dobriyan wrote:
> On Mon, Apr 23, 2018 at 10:21:01PM -0400, jeffm@suse.com wrote:
>> Memory pressure isn't really an issue on this machine, so we
>> end up using well over 100GB for proc files.
> 
> Text files at scale!
> 
>> With these patches applied, running the same testcase, the proc_inode
>> cache only gets to about 600k objects, which is about 99.7% fewer.  I
>> get that procfs isn't supposed to be scalable, but this is kind of
>> extreme. :)>
> Easy stuff:
> * all ->get_link hooks are broken in RCU lookup (use GFP_KERNEL),

It's a pretty common pattern in the kernel, but it's just as easy to set
inode->i_link during instantiation and keep RCU lookup.  There aren't so
many of these to make it a real burden on memory.

> * "%.*s" for dentry names is probably unnecessary,
>   they're always NUL terminated

Ack.

> * kasprintf() does printing twice, since we're kind of care about /proc
>   performance, allocate for the worst case.

Ack, integrated with ->get_link fix.

> * "int nlinks = nlink_tgid;"
>   Unsigned police.

Ack.  nlink_t{,g}id are both u8, but it's easy to make it consistent.

> * (inode->i_mode & S_IFLNK)
> 	this is sketchy, S_ISLNK exists.
> 

Ack.

Notes of my own:

proc_task_count_links also had the logic backward.  It would add an
extra link to the count for the symlink rather than the dir.

proc_pid_files_revalidate only needs to check if the tasks share files
since it won't be called if it's not a symlink.

Thanks for the review,

-Jeff

-- 
Jeff Mahoney
SUSE Labs
