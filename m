Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753257AbeDSShk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 14:37:40 -0400
Received: from mail-ua0-f172.google.com ([209.85.217.172]:39170 "EHLO
        mail-ua0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753074AbeDSShi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 14:37:38 -0400
X-Google-Smtp-Source: AIpwx49QsSxaD//aHX9p44AbTEdq50x0n4eioqrOHQQsIEUesjpbRl3xRkDVMt7SbbdS7S/NIF9cOylxmlHUqb7QIE4=
MIME-Version: 1.0
In-Reply-To: <188a05bc-de07-c048-6a8a-63dc899cce6d@virtuozzo.com>
References: <CAOHTApjPwWDxHmGrfMwFvszWubfjJ7YfBgZL-DQ0mdv00UtQEQ@mail.gmail.com>
 <ef45eb94-4480-0683-ccc0-eb1efaf7e96c@virtuozzo.com> <d6e6f694-1bd9-7f3e-eaa8-1947c47f523f@virtuozzo.com>
 <20180419153447.GH30522@ZenIV.linux.org.uk> <20180419164424.GI30522@ZenIV.linux.org.uk>
 <188a05bc-de07-c048-6a8a-63dc899cce6d@virtuozzo.com>
From: Alexander Aring <aring@mojatatu.com>
Date: Thu, 19 Apr 2018 14:37:37 -0400
Message-ID: <CAOHTApj+43Oz=uX0gn6siwOEYUDb1HfEJq8CH2QpArFyncZ0tw@mail.gmail.com>
Subject: Re: [bisected] Stack overflow after fs: "switch the IO-triggering
 parts of umount to fs_pin" (was net namespaces kernel stack overflow)
To: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Apr 19, 2018 at 12:56 PM, Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> On 19.04.2018 19:44, Al Viro wrote:
>> On Thu, Apr 19, 2018 at 04:34:48PM +0100, Al Viro wrote:
>>
>>> IOW, we only get there if our vfsmount was an MNT_INTERNAL one.
>>> So we have mnt->mnt_umount of some MNT_INTERNAL mount found in
>>> ->mnt_pins of some other mount.  Which, AFAICS, means that
>>> it used to be mounted on that other mount.  How the hell can
>>> that happen?
>>>
>>> It looks like you somehow get a long chain of MNT_INTERNAL mounts
>>> stacked on top of each other, which ought to be prevented by
>>>         mnt_flags &= ~MNT_INTERNAL_FLAGS;
>>> in do_add_mount().  Nuts...
>>
>> Arrrrrgh...  Nuts is right - clone_mnt() preserves the sodding
>> MNT_INTERNAL, with obvious results.
>>
>> netns is related to the problem, by exposing MNT_INTERNAL mounts
>> (in /proc/*/ns/*) for mount --bind to copy and attach to the
>> tree.  AFAICS, the minimal reproducer is
>>
>> touch /tmp/a
>> unshare -m sh -c 'for i in `seq 10000`; do mount --bind /proc/1/ns/net /tmp/a; done'
>>
>> (and it can be anything in /proc/*/ns/*, really)
>>
>> I think the fix should be along the lines of the following:
>>
>> Don't leak MNT_INTERNAL away from internal mounts
>>
>> We want it only for the stuff created by SB_KERNMOUNT mounts, *not* for
>> their copies.
>>
>> Cc: stable@kernel.org
>> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
>
> Flawless victory! Thanks.
>

Thanks to all.

Also thanks to Kirill for helping me here and doing the main part by
bisecting this issue.

Finally, my testing stuff which produced this bug also works well now.

Tested-by: Alexander Aring <aring@mojatatu.com>

- Alex
