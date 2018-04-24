Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933677AbeDXOPo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 10:15:44 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:36100 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933333AbeDXOPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 10:15:41 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: jeffm@suse.com
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>, Oleg Nesterov <oleg@redhat.com>
References: <20180424022106.16952-1-jeffm@suse.com>
Date: Tue, 24 Apr 2018 09:14:13 -0500
In-Reply-To: <20180424022106.16952-1-jeffm@suse.com> (jeffm@suse.com's message
        of "Mon, 23 Apr 2018 22:21:01 -0400")
Message-ID: <87in8ghetm.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fAyjK-0001LT-5k;;;mid=<87in8ghetm.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+i6uvejULYxOrmtJgkI+rHB8kZuX0WitA=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4462]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;jeffm@suse.com
X-Spam-Relay-Country: 
X-Spam-Timing: total 973 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 3.2 (0.3%), b_tie_ro: 2.2 (0.2%), parse: 1.36 (0.1%),
        extract_message_metadata: 29 (3.0%), get_uri_detail_list: 6 (0.6%),
        tests_pri_-1000: 10 (1.0%), tests_pri_-950: 2.00 (0.2%), tests_pri_-900: 1.64
        (0.2%), tests_pri_-400: 50 (5.1%), check_bayes: 47 (4.9%), b_tokenize: 20
        (2.0%), b_tok_get_all: 12 (1.3%), b_comp_prob: 8 (0.8%), b_tok_touch_all: 3.4
        (0.4%), b_finish: 0.75 (0.1%), tests_pri_0: 864 (88.8%),
        check_dkim_signature: 0.87 (0.1%), check_dkim_adsp: 4.1 (0.4%),
        tests_pri_500: 6 (0.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC] [PATCH 0/5] procfs: reduce duplication by using symlinks
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

jeffm@suse.com writes:

> From: Jeff Mahoney <jeffm@suse.com>
>
> Hi all -
>
> I recently encountered a customer issue where, on a machine with many TiB
> of memory and a few hundred cores, after a task with a few thousand threads
> and hundreds of files open exited, the system would softlockup.  That
> issue was (is still) being addressed by Nik Borisov's patch to add a
> cond_resched call to shrink_dentry_list.  The underlying issue is still
> there, though.  We just don't complain as loudly.  When a huge task
> exits, now the system is more or less unresponsive for about eight
> minutes.  All CPUs are pinned and every one of them is going through
> dentry and inode eviction for the procfs files associated with each
> thread.  It's made worse by every CPU contending on the super's
> inode list lock.
>
> The numbers get big.  My test case was 4096 threads with 16384 files
> open.  It's a contrived example, but not that far off from the actual
> customer case.  In this case, a simple "find /proc" would create around
> 300 million dentry/inode pairs.  More practically, lsof(1) does it too,
> it just takes longer.  On smaller systems, memory pressure starts pushing
> them out. Memory pressure isn't really an issue on this machine, so we
> end up using well over 100GB for proc files.  It's the combination of
> the wasted CPU cycles in teardown and the wasted memory at runtime that
> pushed me to take this approach.
>
> The biggest culprit is the "fd" and "fdinfo" directories, but those are
> made worse by there being multiple copies of them even for the same
> task without threads getting involved:
>
> - /proc/pid/fd and /proc/pid/task/pid/fd are identical but share no
>   resources.
>
> - Every /proc/pid/task/*/fd directory in a thread group has identical
>   contents (unless unshare(CLONE_FILES) was called), but share no
>   resources.
>
> - If we do a lookup like /proc/pid/fd on a member of a thread group,
>   we'll get a valid directory.  Inside, there will be a complete
>   copy of /proc/pid/task/* just like in /proc/tgid/task.  Again,
>   nothing is shared.
>
> This patch set reduces some (most) of the duplication by conditionally
> replacing some of the directories with symbolic links to copies that are
> identical.
>
> 1) Eliminate the duplication of the task directories between threads.
>    The task directory belongs to the thread leader and the threads
>    link to it: e.g. /proc/915/task -> ../910/task  This mainly
>    reduces duplication when individual threads are looked up directly
>    at the tgid level.  The impact varies based on the number of threads.
>    The user has to go out of their way in order to mess up their system
>    in this way.  But if they were so inclined, they could create ~550
>    billion inodes and dentries using the test case.
>
> 2) Eliminate the duplication of directories that are created identically
>    between the tgid-level pid directory and its task directory: fd,
>    fdinfo, ns, net, attr.  There is obviously more duplication between
>    the two directories, but replacing a file with a symbolic link
>    doesn't get us anything.  This reduces the number of files associated
>    with fd and fdinfo by half if threads aren't involved.
>
> 3) Eliminate the duplication of fd and fdinfo directories among threads
>    that share a files_struct.  We check at directory creation time if
>    the task is a group leader and if not, whether it shares ->files with
>    the group leader.  If so, we create a symbolic link to ../tgid/fd*.
>    We use a d_revalidate callback to check whether the thread has called
>    unshare(CLONE_FILES) and, if so, fail the revalidation for the symlink.
>    Upon re-lookup, a directory will be created in its place.  This is
>    pretty simple, so if the thread group leader calls unshare, all threads
>    get directories.
>
> With these patches applied, running the same testcase, the proc_inode
> cache only gets to about 600k objects, which is about 99.7% fewer.  I
> get that procfs isn't supposed to be scalable, but this is kind of
> extreme. :)
>
> Finally, I'm not a procfs expert.  I'm posting this as an RFC for folks
> with more knowledge of the details to pick it apart.  The biggest is that
> I'm not sure if any tools depend on any of these things being directories
> instead of symlinks.  I'd hope not, but I don't have the answer.  I'm
> sure there are corner cases I'm missing.  Hopefully, it's not just flat
> out broken since this is a problem that does need solving.
>
> Now I'll go put on the fireproof suit.

This needs to be tested against at least apparmor to see if this breaks
common policies.  Changing files to symlinks in proc has a bad habit of
either breaking apparmor policies or userspace assumptions.   Symbolic
links are unfortunately visible to userspace.

Further the proc structure is tgid/task/tid where the leaf directories
are per thread.

We more likely could get away with some magic symlinks (that would not
be user visible) rather than actual symlinks.

So I think you are probably on the right track to reduce the memory
usage but I think some more work will be needed to make it transparently
backwards compatible.

Eric
