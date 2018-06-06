Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mv/aolbS"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 62F8560764
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932318AbeFFP0w (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 11:26:52 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50553 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752244AbeFFP0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 11:26:49 -0400
X-Google-Smtp-Source: ADUXVKLNDty37duccG8vwaNGfGQS2ct5L94IGvrho0tbqSDTySkajoMwntXWjE8WWu+FIRVTb6KxMA==
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH] ksys_mount: check for permissions before resource
 allocation
From: Ilya Matveychikov <matvejchikov@gmail.com>
In-Reply-To: <87muw8805z.fsf@xmission.com>
Date: Wed, 6 Jun 2018 19:26:44 +0400
Cc: linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <B844AFD6-B3A1-4C57-996E-00835552008C@gmail.com>
References: <D2317950-0DB0-4311-ADB1-FF677B676E04@gmail.com>
 <BD48252B-65D7-4238-BDA2-71BAC1CEA855@gmail.com>
 <87o9gpatxs.fsf@xmission.com>
 <64021AF2-81EE-439C-91D4-9A33AB0D08F7@gmail.com>
 <87muw8805z.fsf@xmission.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
X-Mailer: Apple Mail (2.3445.6.18)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 6, 2018, at 6:22 PM, Eric W. Biederman <ebiederm@xmission.com> =
wrote:
>=20
> Ilya Matveychikov <matvejchikov@gmail.com> writes:
>=20
>>> On Jun 5, 2018, at 11:56 PM, Eric W. Biederman =
<ebiederm@xmission.com> wrote:
>>>=20
>>> Ilya Matveychikov <matvejchikov@gmail.com> writes:
>>>=20
>>>> Just CC=E2=80=99ed to some of maintainers.
>>>>=20
>>>> $ perl scripts/get_maintainer.pl =
fs/0001-ksys_mount-check-for-permissions-before-resource-all.patch
>>>> Alexander Viro <viro@zeniv.linux.org.uk> (maintainer:FILESYSTEMS =
(VFS and infrastructure))
>>>> linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and =
infrastructure))
>>>> linux-kernel@vger.kernel.org (open list)
>>>>=20
>>>>> On Jun 5, 2018, at 6:00 AM, Ilya Matveychikov =
<matvejchikov@gmail.com> wrote:
>>>>>=20
>>>>> Early check for mount permissions prevents possible allocation of =
3
>>>>> pages from kmalloc() pool by unpriveledged user which can be used =
for
>>>>> spraying the kernel heap.
>>>=20
>>> *Snort*
>>>=20
>>> You clearly have not read may_mount.  Your modified code still
>>> let's unprivileged users in.  So even if all of Al's good objections
>>> were not applicable this change would still be buggy and wrong.
>>>=20
>>> Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>
>>=20
>>=20
>> Don=E2=80=99t get me wrong but may_mount() is:
>>=20
>> static inline bool may_mount(void)
>> {
>>        return ns_capable(current->nsproxy->mnt_ns->user_ns, =
CAP_SYS_ADMIN);
>> }
>>=20
>> What do you mean by "You clearly have not read may_mount=E2=80=9D? =
The only thing that
>> can affect may_mount result (as mentioned earlier) is that task=E2=80=99=
s NS capability
>> might be changed by security_sb_mount() hook.
>>=20
>> So, do you think that is=E2=80=99s possible to NOT have CAP_SYS_ADMIN =
while entering to
>> ksys_mount() but getting it with the security_sb_mount() hook?
>=20
> I mean it works for unprivileged users.
>=20
> You can try "unshare -Urm" on a reasonably recent kernel and it will
> work and you can then mount and unmount things.
>=20
> Strictly speaking it only works if you have the appropriate set of
> capabilities in your user namespace.  But that does not imply you are =
a
> privileged user in the broader sense.
>=20
> Any user can create a user namespace, and become the root user
> in a user namespace.  The root user in a user namespace can create
> a mount namespace.  The root user in a user namespace can mount
> and unmount filesystems in their namespace.
>=20
> Or in net anyone can call mount and get past the may_mount test.
>=20
> Without reducing who can cause the kernel allocation moving the test =
is
> pointless.
>=20

Ok, now I see. No reason to make change as it doesn=E2=80=99t really =
prevents users
of doing mount() using they own namespaces.

Thank you for the explanation.
