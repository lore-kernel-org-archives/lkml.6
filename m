Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D1F8C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 08:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C89520652
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 08:56:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C89520652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbeJAPdH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 11:33:07 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:46973 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728804AbeJAPdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 11:33:06 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g6tzx-0001pl-U8; Mon, 01 Oct 2018 02:56:13 -0600
Received: from [105.184.227.67] (helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g6tzv-0003dB-VG; Mon, 01 Oct 2018 02:56:13 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Laurent Vivier <laurent@vivier.eu>
Cc:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux API <linux-api@vger.kernel.org>,
        Dmitry Safonov <dima@arista.com>,
        Andrey Vagin <avagin@openvz.org>,
        Linux Containers <containers@lists.linux-foundation.org>
References: <20180930234628.25528-1-laurent@vivier.eu>
        <CALCETrWcQtLTVJU14ytWxu_gqoLuAYZJpyAvRsKwwgYZz7FEFg@mail.gmail.com>
        <874le63zei.fsf@xmission.com>
        <5b4f0798-eb22-2684-775c-c038c104e190@vivier.eu>
Date:   Mon, 01 Oct 2018 10:56:03 +0200
In-Reply-To: <5b4f0798-eb22-2684-775c-c038c104e190@vivier.eu> (Laurent
        Vivier's message of "Mon, 1 Oct 2018 10:45:36 +0200")
Message-ID: <87k1n2yrj0.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1g6tzv-0003dB-VG;;;mid=<87k1n2yrj0.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=105.184.227.67;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19CRb4b8SUTag7XhkNMivKXZSY9M3WzYEU=
X-SA-Exim-Connect-IP: 105.184.227.67
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [RFC 0/2] ns: introduce binfmt_misc namespace
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Laurent Vivier <laurent@vivier.eu> writes:

> Le 01/10/2018 à 09:21, Eric W. Biederman a écrit :
>> Andy Lutomirski <luto@kernel.org> writes:
>> 
>>> On Sun, Sep 30, 2018 at 4:47 PM Laurent Vivier <laurent@vivier.eu> wrote:
>>>>
>>>> This series introduces a new namespace for binfmt_misc.
>>>>
>>>
>>> This seems conceptually quite reasonable, but I'm wondering if the
>>> number of namespace types is getting out of hand given the current
>>> API.  Should we be considering whether we need a new set of namespace
>>> creation APIs that scale better to larger numbers of namespace types?
>> 
>> I would rather encourage a way to make this part of an existing
>> namespace or find a way to make a mount of binfmt_misc control this.
>> 
>> Hmm.  This looks like something that can be very straight forwardly be
>> made part of the user namespace.  If you ever mount binfmt_misc in the
>> user namespace you get the new behavior.  Otherwise you get the existing
>> behavior.
>
> Thank you. I'll do that.
>
>> A user namespace will definitely be required, as otherwise you run the
>> risk of confusing root (and suid root exectuables0 by being able to
>> change the behavior of executables.
>> 
>> What is the motivation for this?  My impression is that very few people
>> tweak binfmt_misc.
>
> I think more and more people are using an interpreter like qemu
> linux-usermode to have a cross-compilation environment: they bootstrap a
> distro filesystems (with something like debootstrap), and then use
> binfmt_misc to run the compiler inside this environment (see for
> instance [1] [2] [3] or [4] [5]). This is interesting because you have
> more than a cross-compiler with that: you have also all the libraries of
> the target system, you can select exactly which target release you want
> to build to, with the exact same compiler and libraries versions (and
> you can re-use it you want to do maintenance on your project 10 years
> later...)
>
> The problem with this is you need to be root:
> 1- to chroot
> 2- to configure binfmt_misc
>
> We already can use "unshare --map-root-user chroot" to address the point
> 1, and this series tries to address the point 2.
>
> I think it's also interesting to have a per container configuration for
> binfmt_misc when the server administrator configures it and don't want
> to share each user configuration with all the other user ones (in
> something like docker or a cloud application).

OK.  So it sounds like you are already needing a user namespace for
this.   If this is your use case then my proposed method above seems to
fit rather well.  James Bottomley was doing something similar that
connected to personality(2).  That might be worth a look to see if there
is some synergy there.

>> I also don't think this raises to the level where it makes sense to
>> create a new namespace for this.
>
> OK.
>
> Thanks,
> Laurent
>
> [1] https://wiki.debian.org/Arm64Qemu
> [2] https://wiki.debian.org/M68k/sbuildQEMU
> [3] https://wiki.debian.org/RISC-V#Manual_qemu-user_installation
> [4] https://kbeckmann.github.io/2017/05/26/QEMU-instead-of-cross-compiling/
> [5] https://wiki.gentoo.org/wiki/Crossdev_qemu-static-user-chroot
