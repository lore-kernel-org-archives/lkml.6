Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755189AbeDZVDZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 17:03:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:49372 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753000AbeDZVDX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 17:03:23 -0400
Subject: Re: [RFC] [PATCH 0/5] procfs: reduce duplication by using symlinks
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>, Oleg Nesterov <oleg@redhat.com>
References: <20180424022106.16952-1-jeffm@suse.com>
 <87in8ghetm.fsf@xmission.com>
From: Jeff Mahoney <jeffm@suse.com>
Openpgp: preference=signencrypt
Message-ID: <07eaa5d0-2dc3-16b7-34b4-2672f0cc6c24@suse.com>
Date: Thu, 26 Apr 2018 17:03:18 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <87in8ghetm.fsf@xmission.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/18 10:14 AM, Eric W. Biederman wrote:
> jeffm@suse.com writes:
> 
>> From: Jeff Mahoney <jeffm@suse.com>
>>
>> Hi all -
>>
>> I recently encountered a customer issue where, on a machine with many TiB
>> of memory and a few hundred cores, after a task with a few thousand threads
>> and hundreds of files open exited, the system would softlockup.  That
>> issue was (is still) being addressed by Nik Borisov's patch to add a
>> cond_resched call to shrink_dentry_list.  The underlying issue is still
>> there, though.  We just don't complain as loudly.  When a huge task
>> exits, now the system is more or less unresponsive for about eight
>> minutes.  All CPUs are pinned and every one of them is going through
>> dentry and inode eviction for the procfs files associated with each
>> thread.  It's made worse by every CPU contending on the super's
>> inode list lock.
>>
>> The numbers get big.  My test case was 4096 threads with 16384 files
>> open.  It's a contrived example, but not that far off from the actual
>> customer case.  In this case, a simple "find /proc" would create around
>> 300 million dentry/inode pairs.  More practically, lsof(1) does it too,
>> it just takes longer.  On smaller systems, memory pressure starts pushing
>> them out. Memory pressure isn't really an issue on this machine, so we
>> end up using well over 100GB for proc files.  It's the combination of
>> the wasted CPU cycles in teardown and the wasted memory at runtime that
>> pushed me to take this approach.
>>
>> The biggest culprit is the "fd" and "fdinfo" directories, but those are
>> made worse by there being multiple copies of them even for the same
>> task without threads getting involved:
>>
>> - /proc/pid/fd and /proc/pid/task/pid/fd are identical but share no
>>   resources.
>>
>> - Every /proc/pid/task/*/fd directory in a thread group has identical
>>   contents (unless unshare(CLONE_FILES) was called), but share no
>>   resources.
>>
>> - If we do a lookup like /proc/pid/fd on a member of a thread group,
>>   we'll get a valid directory.  Inside, there will be a complete
>>   copy of /proc/pid/task/* just like in /proc/tgid/task.  Again,
>>   nothing is shared.
>>
>> This patch set reduces some (most) of the duplication by conditionally
>> replacing some of the directories with symbolic links to copies that are
>> identical.
>>
>> 1) Eliminate the duplication of the task directories between threads.
>>    The task directory belongs to the thread leader and the threads
>>    link to it: e.g. /proc/915/task -> ../910/task  This mainly
>>    reduces duplication when individual threads are looked up directly
>>    at the tgid level.  The impact varies based on the number of threads.
>>    The user has to go out of their way in order to mess up their system
>>    in this way.  But if they were so inclined, they could create ~550
>>    billion inodes and dentries using the test case.
>>
>> 2) Eliminate the duplication of directories that are created identically
>>    between the tgid-level pid directory and its task directory: fd,
>>    fdinfo, ns, net, attr.  There is obviously more duplication between
>>    the two directories, but replacing a file with a symbolic link
>>    doesn't get us anything.  This reduces the number of files associated
>>    with fd and fdinfo by half if threads aren't involved.
>>
>> 3) Eliminate the duplication of fd and fdinfo directories among threads
>>    that share a files_struct.  We check at directory creation time if
>>    the task is a group leader and if not, whether it shares ->files with
>>    the group leader.  If so, we create a symbolic link to ../tgid/fd*.
>>    We use a d_revalidate callback to check whether the thread has called
>>    unshare(CLONE_FILES) and, if so, fail the revalidation for the symlink.
>>    Upon re-lookup, a directory will be created in its place.  This is
>>    pretty simple, so if the thread group leader calls unshare, all threads
>>    get directories.
>>
>> With these patches applied, running the same testcase, the proc_inode
>> cache only gets to about 600k objects, which is about 99.7% fewer.  I
>> get that procfs isn't supposed to be scalable, but this is kind of
>> extreme. :)
>>
>> Finally, I'm not a procfs expert.  I'm posting this as an RFC for folks
>> with more knowledge of the details to pick it apart.  The biggest is that
>> I'm not sure if any tools depend on any of these things being directories
>> instead of symlinks.  I'd hope not, but I don't have the answer.  I'm
>> sure there are corner cases I'm missing.  Hopefully, it's not just flat
>> out broken since this is a problem that does need solving.
>>
>> Now I'll go put on the fireproof suit.
> 
> This needs to be tested against at least apparmor to see if this breaks
> common policies.  Changing files to symlinks in proc has a bad habit of
> either breaking apparmor policies or userspace assumptions.   Symbolic
> links are unfortunately visible to userspace.

That's my biggest concern as well.

> Further the proc structure is tgid/task/tid where the leaf directories
> are per thread.
> 
> We more likely could get away with some magic symlinks (that would not
> be user visible) rather than actual symlinks.

I'd considered that, but we'll need to instantiate other portions of the
tree in order to use those dentries as magic symlink targets.  That
seemed like it might not fly, so I went with the regular symlink approach.

> So I think you are probably on the right track to reduce the memory
> usage but I think some more work will be needed to make it transparently
> backwards compatible.

Thanks for the review,

-Jeff

-- 
Jeff Mahoney
SUSE Labs
