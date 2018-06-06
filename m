Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u0NIsyKQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7A22B60764
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932535AbeFFJcT (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 05:32:19 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37212 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932395AbeFFJcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 05:32:17 -0400
X-Google-Smtp-Source: ADUXVKK9lwKwVUQZgCrhKfrYr+8rHfXvrssg+JB1mb8GzdqvPtTi11NdzQYuROrtTUPN2jsf6m1CEA==
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH] ksys_mount: check for permissions before resource
 allocation
From: Ilya Matveychikov <matvejchikov@gmail.com>
In-Reply-To: <87o9gpatxs.fsf@xmission.com>
Date: Wed, 6 Jun 2018 13:32:12 +0400
Cc: linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <64021AF2-81EE-439C-91D4-9A33AB0D08F7@gmail.com>
References: <D2317950-0DB0-4311-ADB1-FF677B676E04@gmail.com>
 <BD48252B-65D7-4238-BDA2-71BAC1CEA855@gmail.com>
 <87o9gpatxs.fsf@xmission.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
X-Mailer: Apple Mail (2.3445.6.18)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 5, 2018, at 11:56 PM, Eric W. Biederman <ebiederm@xmission.com> =
wrote:
>=20
> Ilya Matveychikov <matvejchikov@gmail.com> writes:
>=20
>> Just CC=E2=80=99ed to some of maintainers.
>>=20
>> $ perl scripts/get_maintainer.pl =
fs/0001-ksys_mount-check-for-permissions-before-resource-all.patch
>> Alexander Viro <viro@zeniv.linux.org.uk> (maintainer:FILESYSTEMS (VFS =
and infrastructure))
>> linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and =
infrastructure))
>> linux-kernel@vger.kernel.org (open list)
>>=20
>>> On Jun 5, 2018, at 6:00 AM, Ilya Matveychikov =
<matvejchikov@gmail.com> wrote:
>>>=20
>>> Early check for mount permissions prevents possible allocation of 3
>>> pages from kmalloc() pool by unpriveledged user which can be used =
for
>>> spraying the kernel heap.
>=20
> *Snort*
>=20
> You clearly have not read may_mount.  Your modified code still
> let's unprivileged users in.  So even if all of Al's good objections
> were not applicable this change would still be buggy and wrong.
>=20
> Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>


Don=E2=80=99t get me wrong but may_mount() is:

static inline bool may_mount(void)
{
        return ns_capable(current->nsproxy->mnt_ns->user_ns, =
CAP_SYS_ADMIN);
}

What do you mean by "You clearly have not read may_mount=E2=80=9D? The =
only thing that
can affect may_mount result (as mentioned earlier) is that task=E2=80=99s =
NS capability
might be changed by security_sb_mount() hook.

So, do you think that is=E2=80=99s possible to NOT have CAP_SYS_ADMIN =
while entering to
ksys_mount() but getting it with the security_sb_mount() hook?

This is the only case I see that using may_mount() before =
security_sb_mount()
is wrong. This was the point?
