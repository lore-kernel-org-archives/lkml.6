Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E9C19C5CFC0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 21:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DFCE208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 21:54:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DFCE208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755552AbeFNVyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 17:54:08 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:59889 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755410AbeFNVyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 17:54:07 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fTaBu-0005Mu-7v; Thu, 14 Jun 2018 15:54:03 -0600
Received: from 97-119-124-205.omah.qwest.net ([97.119.124.205] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fTaBt-0002vn-D2; Thu, 14 Jun 2018 15:54:02 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     Matthew Helsley <matt.helsley@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        lkml <linux-kernel@vger.kernel.org>,
        containers@lists.linux-foundation.org,
        Oleg Nesterov <oleg@redhat.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Tyler Hicks <tyhicks@canonical.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andy Lutomirski <luto@amacapital.net>,
        "Tobin C . Harding" <me@tobin.cc>
References: <20180531144949.24995-1-tycho@tycho.ws>
        <20180531144949.24995-2-tycho@tycho.ws>
        <CA+RrjuW98m2coL+TOKq5cL0QhAb=HYxo2DpNoqMzdiwjqhc2BA@mail.gmail.com>
        <20180612231610.GA3837@cisco>
        <CA+RrjuUtYoXfbH3cTbSY=QzXcxJsJOa0BL628ADy9N3bTO4=Mw@mail.gmail.com>
        <20180614210325.GA5673@cisco>
Date:   Thu, 14 Jun 2018 16:53:51 -0500
In-Reply-To: <20180614210325.GA5673@cisco> (Tycho Andersen's message of "Thu,
        14 Jun 2018 14:03:25 -0700")
Message-ID: <87in6lt4pc.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fTaBt-0002vn-D2;;;mid=<87in6lt4pc.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.124.205;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+yeewEhpFj7IEJOuCmfmepZdvwdZnssv8=
X-SA-Exim-Connect-IP: 97.119.124.205
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v3 1/4] seccomp: add a return code to trap to userspace
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tycho Andersen <tycho@tycho.ws> writes:

> On Thu, Jun 14, 2018 at 12:44:21PM -0700, Matthew Helsley wrote:
>> On Tue, Jun 12, 2018 at 4:16 PM, Tycho Andersen <tycho@tycho.ws> wrote:
>> 
>> > Hi Matthew,
>> >
>> > On Tue, Jun 12, 2018 at 02:39:03PM -0700, Matthew Helsley wrote:
>> > > On Thu, May 31, 2018 at 7:49 AM, Tycho Andersen <tycho@tycho.ws> wrote:
>> > >
>> > > <snip>
>> > >
>> > >
>> > > > +struct seccomp_notif {
>> > > > +       __u64 id;
>> > > > +       pid_t pid;
>> > > > +       struct seccomp_data data;
>> > > > +};
>> > > >
>> > >
>> > > Since it's part of the UAPI I think it would be good to add documentation
>> > > to this patch series. Part of that documentation should talk about which
>> > > pid namespaces this pid value is relevant in. This is especially
>> > important
>> > > since the feature is designed for use by things like container/sandbox
>> > > managers.
>> >
>> > Yes, at least Documentation/userspace-api/seccomp_filter.txt should be
>> > updated. I'll add that for the next series.
>> >
>> 
>> Are there some relevant man pages too that should be updated too?
>
> Yes, but since those are in a separate tree, I usually send the sets
> separately.
>
>> > > > +static void seccomp_do_user_notification(int this_syscall,
>> > > > +                                        struct seccomp_filter *match,
>> > > > +                                        const struct seccomp_data *sd)
>> > > > +{
>> > > > +       int err;
>> > > > +       long ret = 0;
>> > > > +       struct seccomp_knotif n = {};
>> > > > +
>> > > > +       mutex_lock(&match->notify_lock);
>> > > > +       err = -ENOSYS;
>> > > > +       if (!match->has_listener)
>> > > > +               goto out;
>> > > > +
>> > > > +       n.pid = current->pid;
>> > > >
>> > >
>> > > How have you tested this code for correctness? I don't see many
>> > > combinations being tested below nor here:
>> > > https://github.com/tych0/kernel-utils/blob/master/
>> > seccomp/notify_stress.c
>> > >
>> > > What about processes in different pid namespaces? Make tests that vary
>> > key
>> > > parameters like these between the task generating the notifications and
>> > the
>> > > task interested in processing the notifications. Make tests that try to
>> > > kill them at interesting times too. etc. Make tests that pass the
>> > > notification fd around and see how they work (or not).
>> > >
>> > > I ask about testing because you're effectively returning a pid value to
>> > > userspace here but not using the proper macros to access the task's
>> > struct
>> > > pid for that purpose. That will work so long as both processes are in the
>> > > same pid namespace but breaks otherwise.
>> > >
>> > > Furthermore, a pid value is not the best solution for the queueing of
>> > these
>> > > notifications because a single pid value is not meaningful/correct
>> > outside
>> > > current's pid namespace and the seccomp notification file descriptor
>> > could
>> > > be passed on to processes in another pid namespaces; this pid value will
>> > > almost always not be relevant or correct there hence taking a reference
>> > to
>> >
>> > Well, it *has* to be relevant in some cases: if you want to access
>> > some of the task's memory to e.g. read the args to the syscall, you
>> > need to ptrace or map_files to access the memory. So we do need to
>> > pass it, but,
>> >
>> > > the struct pid is useful. Then, during read(), the code would use the
>> > > proper macro to turn the struct pid reference into a pid value relevant
>> > in
>> > > the *reader's* pid namespace *or* return something obviously bogus if the
>> > > reader is in a pid namespace that can't see that pid. This could prevent
>> > > management processes from being tricked into clobbering the wrong
>> > process,
>> > > feeding the wrong process sensitive information via syscall results, etc.
>> >
>> > Yes, this makes sense. Seems like we need to do some magic about
>> > passing the tracee's task struct to the listener, so it can do
>> > task_pid_vnr(). We could perhaps require the listener to be in the
>> > init_pid_ns case, but I think things like socket() might still be
>> > useful even if you can't read the tracee's memory.
>> 
>> 
>> You could take a reference to the pid rather than the task
>> then use pid_vnr(). In that case the changes should result in something
>> like:
>> 
>> 
>> struct seccomp_knotif {
>>        /* The pid whose filter triggered the notification */
>>        struct pid *pid;
>> ...
>> 
>> static void seccomp_do_user_notification(...)
>> {
>>     ...
>>     n.pid = get_task_pid(current, PIDTYPE_PID);
>>     ...
>> remove_list:
>>     list_del(&n.list);
>>     put_pid(n.pid);
>>     ...
>> }
>> ...
>> static ssize_t seccomp_notify_read(...)
>> {
>>     ...
>>     unotif.pid = pid_vnr(knotif->pid);
>>     ...
>> }
>> 
>> I like holding the pid reference because it's what we do elsewhere when pid
>> namespaces
>> are a concern and it more precisely specifies what the knotif content needs
>> to convey.
>> Otherwise I don't think it makes a difference.
>
> Great, thanks, I'll do this. I guess we need a put_pid() here too.

A)  We know that the task is stopped.  Unless there is something
    like SIGKILL that can make the task move you don't need to
    take a reference to anything.

B)  pid_vnr is the wrong answer.  When you create the struct file
    and intialize the filter you need to capture the calling processes
    pid namespace.  The you can use "pid_nr_ns(knotif->pid, filter->pid_ns);".
    That will work consistently even if the file descriptor is passed
    between processes.

Eric
