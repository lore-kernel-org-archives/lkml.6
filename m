Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750878AbeBPVw6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 16:52:58 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:52702 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750734AbeBPVw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 16:52:56 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: Dongsu Park <dongsu@kinvolk.io>, lkml <linux-kernel@vger.kernel.org>,
        containers@lists.linux-foundation.org, Alban Crequy <alban@kinvolk.io>,
        Seth Forshee <seth.forshee@canonical.com>,
        Sargun Dhillon <sargun@sargun.me>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <cover.1512741134.git.dongsu@kinvolk.io>
        <c85c293e19a478353aba8e6e3ee39e5914f798d5.1512041070.git.dongsu@kinvolk.io>
        <CAOssrKd6vkMDwRT=QQofKCufzQczzQ7dXoVbVfVax-0HqD986w@mail.gmail.com>
        <87lgfy5fpd.fsf@xmission.com>
        <CAOssrKcKz8p9YQJLf2W_NCBo+12auxir5jFwXGbANdWdgavpsw@mail.gmail.com>
Date: Fri, 16 Feb 2018 15:52:32 -0600
In-Reply-To: <CAOssrKcKz8p9YQJLf2W_NCBo+12auxir5jFwXGbANdWdgavpsw@mail.gmail.com>
        (Miklos Szeredi's message of "Tue, 13 Feb 2018 11:20:07 +0100")
Message-ID: <87606wtxen.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1emnw5-0007Yr-Jg;;;mid=<87606wtxen.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=174.19.85.160;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19qkFrOHU5yT51NxJEoQOLrc61PwKHN7bQ=
X-SA-Exim-Connect-IP: 174.19.85.160
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Miklos Szeredi <mszeredi@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 955 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 3.1 (0.3%), b_tie_ro: 2.1 (0.2%), parse: 1.49 (0.2%),
        extract_message_metadata: 37 (3.9%), get_uri_detail_list: 6 (0.7%),
        tests_pri_-1000: 20 (2.1%), tests_pri_-950: 2.1 (0.2%), tests_pri_-900: 1.81
        (0.2%), tests_pri_-400: 46 (4.8%), check_bayes: 43 (4.5%), b_tokenize: 18
        (1.8%), b_tok_get_all: 12 (1.2%), b_comp_prob: 7 (0.7%), b_tok_touch_all: 2.6
        (0.3%), b_finish: 0.81 (0.1%), tests_pri_0: 828 (86.7%),
        check_dkim_signature: 0.99 (0.1%), check_dkim_adsp: 5 (0.5%), tests_pri_500:
        10 (1.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 08/11] fuse: Support fuse filesystems outside of init_user_ns
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi <mszeredi@redhat.com> writes:

> On Mon, Feb 12, 2018 at 5:35 PM, Eric W. Biederman
> <ebiederm@xmission.com> wrote:
>> Miklos Szeredi <mszeredi@redhat.com> writes:
>>
>>> On Fri, Dec 22, 2017 at 3:32 PM, Dongsu Park <dongsu@kinvolk.io> wrote:
>>>> From: Seth Forshee <seth.forshee@canonical.com>
>>>>
>>>> In order to support mounts from namespaces other than
>>>> init_user_ns, fuse must translate uids and gids to/from the
>>>> userns of the process servicing requests on /dev/fuse. This
>>>> patch does that, with a couple of restrictions on the namespace:
>>>>
>>>>  - The userns for the fuse connection is fixed to the namespace
>>>>    from which /dev/fuse is opened.
>>>>
>>>>  - The namespace must be the same as s_user_ns.
>>>>
>>>> These restrictions simplify the implementation by avoiding the
>>>> need to pass around userns references and by allowing fuse to
>>>> rely on the checks in inode_change_ok for ownership changes.
>>>> Either restriction could be relaxed in the future if needed.
>>>
>>> Can we not introduce potential userspace interface regressions?
>>>
>>> The issue with pid namespaces fixed in commit 5d6d3a301c4e ("fuse:
>>> allow server to run in different pid_ns") will probably bite us here
>>> as well.
>>
>> Maybe, but unlike the pid namespace no one has been able to mount
>> fuse outside of init_user_ns so we are much less exposed.  I agree we
>> should be careful.
>
> Have to wrap my head around all the rules here.
>
> There's the may_mount() one:
>
>     ns_capable(current->nsproxy->mnt_ns->user_ns, CAP_SYS_ADMIN)
>
> Um, first of all, why isn't it checking current->cred->user_ns?
>
> Ah, there it is in sget():
>
>     ns_capable(user_ns, CAP_SYS_ADMIN)
>
> I get the plain capable(CAP_SYS_ADMIN) check in sget_userns() if fs
> doesn't have FS_USERNS_MOUNT.  This is the one that prevents fuse
> mounts from being created when (current->cred->user_ns !=
> &init_user_ns).
>
> Maybe there's a logic to this web of namespaces, but I don't yet see
> it.  Is it documented somewhere?

I think this is a bit simpler than the fiddly details in the
implementation might make it look.

The fundamental idea is that permission to have full control over
a mount namespace, is different than permission to have full control
over an instance of a filesystem.

Implementing that separation of permission checks gets a little bit
fiddly.  The first challenge is that there are several filesystems like
sysfs and proc whose internal mount is created outside of a process.
Then there are the file systems like nfs and afs that have ``referral
points'' that transition you to other instances of those filesystems
when you transition over them.  That is the reason why there are
exceptions for SB_KERNMOUNT and SB_SUBMOUNT.

may_mount is just the permission check for the mount namespace.  It
checks that the current process has CAP_SYS_ADMIN in the user namespace
that owns the current mount namespace.  AKA is the process allowed to
change the mount namespace.

sget is just the permission check for mounting a filesystem.  It checks
that the mounter has CAP_SYS_ADMIN over the user namespace that will own
the newly mounted filesystem.

By the time execition gets to to sget_userns in general all of the
permission checks have all been made.  But if the filesystem is not one
that supports mounting within a user namespace the code checks
capable(CAP_SYS_ADMIN).

That is more convoluted than I would like but the checks derive from the
definition of what we are doing.

>
>>> We basically need two modes of operation:
>>>
>>> a) old, backward compatible (not introducing any new failure mores),
>>> created with privileged mount
>>> b) new, non-backward compatible, created with unprivileged mount
>>>
>>> Technically there would still be a risk from breaking userspace, since
>>> we are using the same entry point for both, but let's hope that no
>>> practical problems come from that.
>>
>> Answering from a 10,000 foot perspective:
>>
>> There are two cases.  Requests to read/write the filesystem from outside
>> of s_user_ns.  These run no risk of breaking userspace as this mode has
>> not been implemented before.
>
> This comes from the fact that (s_user_ns == &init_user_ns) and all
> user namespaces are "inside" init_user_ns, right?

Yes.

> One question: why does current code use the from_[ug]id_munged()
> variant, when the conversion can never fail.  Or can it?

There is always at least (uid_t)-1 that can fail if it shows up on a
filesystem.  As far as I can tell no one was using it for a uid, there
were already uses of (uid_t)-1 as a special case, and I just grabbed it
to become INVALID_UID.

In practice the mapping can't fail unless someone malicious starts using
that id.

I believe I picked the _munged variant so in case that version hits
we are guaranteed to return the 16bit nobody user.

Eric
