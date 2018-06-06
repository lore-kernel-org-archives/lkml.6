Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5C5E4601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752273AbeFFOWq convert rfc822-to-8bit (ORCPT
        <rfc822;monsieuricon@codeaurora.org> + 25 others);
        Wed, 6 Jun 2018 10:22:46 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:36836 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752136AbeFFOWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 10:22:44 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Ilya Matveychikov <matvejchikov@gmail.com>
Cc: linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
References: <D2317950-0DB0-4311-ADB1-FF677B676E04@gmail.com>
        <BD48252B-65D7-4238-BDA2-71BAC1CEA855@gmail.com>
        <87o9gpatxs.fsf@xmission.com>
        <64021AF2-81EE-439C-91D4-9A33AB0D08F7@gmail.com>
Date: Wed, 06 Jun 2018 09:22:32 -0500
In-Reply-To: <64021AF2-81EE-439C-91D4-9A33AB0D08F7@gmail.com> (Ilya
        Matveychikov's message of "Wed, 6 Jun 2018 13:32:12 +0400")
Message-ID: <87muw8805z.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1fQZKj-0000Ff-Hq;;;mid=<87muw8805z.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.124.205;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19DJFTbzHmDjkwT3ggQOr8YHd60cDyP+Qs=
X-SA-Exim-Connect-IP: 97.119.124.205
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH] ksys_mount: check for permissions before resource allocation
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ilya Matveychikov <matvejchikov@gmail.com> writes:

>> On Jun 5, 2018, at 11:56 PM, Eric W. Biederman <ebiederm@xmission.com> wrote:
>> 
>> Ilya Matveychikov <matvejchikov@gmail.com> writes:
>> 
>>> Just CC’ed to some of maintainers.
>>> 
>>> $ perl scripts/get_maintainer.pl fs/0001-ksys_mount-check-for-permissions-before-resource-all.patch
>>> Alexander Viro <viro@zeniv.linux.org.uk> (maintainer:FILESYSTEMS (VFS and infrastructure))
>>> linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and infrastructure))
>>> linux-kernel@vger.kernel.org (open list)
>>> 
>>>> On Jun 5, 2018, at 6:00 AM, Ilya Matveychikov <matvejchikov@gmail.com> wrote:
>>>> 
>>>> Early check for mount permissions prevents possible allocation of 3
>>>> pages from kmalloc() pool by unpriveledged user which can be used for
>>>> spraying the kernel heap.
>> 
>> *Snort*
>> 
>> You clearly have not read may_mount.  Your modified code still
>> let's unprivileged users in.  So even if all of Al's good objections
>> were not applicable this change would still be buggy and wrong.
>> 
>> Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>
>
>
> Don’t get me wrong but may_mount() is:
>
> static inline bool may_mount(void)
> {
>         return ns_capable(current->nsproxy->mnt_ns->user_ns, CAP_SYS_ADMIN);
> }
>
> What do you mean by "You clearly have not read may_mount”? The only thing that
> can affect may_mount result (as mentioned earlier) is that task’s NS capability
> might be changed by security_sb_mount() hook.
>
> So, do you think that is’s possible to NOT have CAP_SYS_ADMIN while entering to
> ksys_mount() but getting it with the security_sb_mount() hook?

I mean it works for unprivileged users.

You can try "unshare -Urm" on a reasonably recent kernel and it will
work and you can then mount and unmount things.

Strictly speaking it only works if you have the appropriate set of
capabilities in your user namespace.  But that does not imply you are a
privileged user in the broader sense.

Any user can create a user namespace, and become the root user
in a user namespace.  The root user in a user namespace can create
a mount namespace.  The root user in a user namespace can mount
and unmount filesystems in their namespace.

Or in net anyone can call mount and get past the may_mount test.

Without reducing who can cause the kernel allocation moving the test is
pointless.

Eric
