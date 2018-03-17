Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753629AbeCQSBg (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 14:01:36 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:51044 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753388AbeCQSBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 14:01:33 -0400
Date: Sat, 17 Mar 2018 18:01:31 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: what the hell is compat_sys_x86_waitpid() for?
Message-ID: <20180317180131.GO30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You have
COMPAT_SYSCALL_DEFINE3(x86_waitpid, compat_pid_t, pid, unsigned int __user *,
                       stat_addr, int, options)
{
        return compat_sys_wait4(pid, stat_addr, options, NULL);
}
with
COMPAT_SYSCALL_DEFINE4(wait4,
        compat_pid_t, pid,
        compat_uint_t __user *, stat_addr,
        int, options,
        struct compat_rusage __user *, ru)
{
        struct rusage r;
        long err = kernel_wait4(pid, stat_addr, options, ru ? &r : NULL);
        if (err > 0) {
                if (ru && put_compat_rusage(&r, ru))
                        return -EFAULT;
        }
        return err;
}

so that turns into
	return kernel_wait4(pid, stat_addr, options, NULL);

Now, look at
SYSCALL_DEFINE3(waitpid, pid_t, pid, int __user *, stat_addr, int, options)
{
        return sys_wait4(pid, stat_addr, options, NULL);
}
and
SYSCALL_DEFINE4(wait4, pid_t, upid, int __user *, stat_addr,
                int, options, struct rusage __user *, ru)
{
        struct rusage r;
        long err = kernel_wait4(upid, stat_addr, options, ru ? &r : NULL);

        if (err > 0) {
                if (ru && copy_to_user(ru, &r, sizeof(struct rusage)))
                        return -EFAULT;
        }
        return err;
}

and tell me what is the difference between those.  In other words, the problem
with sys32_waitpid() was not that it didn't use proper wrappers - it's that
it was (and always had been) 100% pointless.

For fsck sake, look at the arguments.  waitpid(2) takes pid_t, pointer to int
and an int.  How the hell could it possibly have required a compat wrapper?

Let's get rid of the junk rather than covering it with more layers of crap...
