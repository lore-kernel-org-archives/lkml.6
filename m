Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D6CDC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 17:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCABB20C0D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 17:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yzZazvHP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCABB20C0D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390048AbeGKRMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 13:12:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:58616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389992AbeGKRMR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 13:12:17 -0400
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB5C920C51
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 17:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531328822;
        bh=9gyKV9vHCNyDoP3pLznaETU8anFK912ao1NFzOzEhdA=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=yzZazvHP/FuEu/qDM0mBMxHs1JHDgsZbjZoCM/uEumdc7SIKGyFric3c2ZtkLQ4Ch
         ZVms6bcq4dHVD+jnckrMfKCcqnNWubKnaUaIJ7j93/iGmb2JAB6dc33n7yEXv+Ocd6
         pHImQ/UOySPpUbVF4sV+1q7YW/+wsXRKW2SISyYs=
Received: by mail-wr1-f45.google.com with SMTP id h9-v6so18919880wro.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 10:07:01 -0700 (PDT)
X-Gm-Message-State: APt69E00LhEjM5INODpMosSOuCoQT2/2xftHhrjb+tDmIFhSBBjG1stX
        myXmkIBmCAp07vM9vI1d1Aup/jVsGrelDeLdm2xf8Q==
X-Google-Smtp-Source: AAOMgpfADkStEkfbudne4oGa4iFbWPBhCMFirefbhPnAwVQ2RcFGs/7A/rekmW+0JkyiIcyvnHKw9kVHCZcxp8GX0o4=
X-Received: by 2002:adf:e0cc:: with SMTP id e12-v6mr21096020wri.199.1531328820431;
 Wed, 11 Jul 2018 10:07:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:d548:0:0:0:0:0 with HTTP; Wed, 11 Jul 2018 10:06:39
 -0700 (PDT)
In-Reply-To: <22370.1531293761@warthog.procyon.org.uk>
References: <153126248868.14533.9751473662727327569.stgit@warthog.procyon.org.uk>
 <153126264966.14533.3388004240803696769.stgit@warthog.procyon.org.uk>
 <686E805C-81F3-43D0-A096-50C644C57EE3@amacapital.net> <22370.1531293761@warthog.procyon.org.uk>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 11 Jul 2018 10:06:39 -0700
X-Gmail-Original-Message-ID: <CALCETrU3kbh-ZRHDj7-Asq+OH-35dQ2p_erpHpYUvN5+BdAoVQ@mail.gmail.com>
Message-ID: <CALCETrU3kbh-ZRHDj7-Asq+OH-35dQ2p_erpHpYUvN5+BdAoVQ@mail.gmail.com>
Subject: Re: [PATCH 24/32] vfs: syscall: Add fsopen() to prepare for
 superblock creation [ver #9]
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Jul 11, 2018, at 12:22 AM, David Howells <dhowells@redhat.com> wrote:
>
> Andy Lutomirski <luto@amacapital.net> wrote:
>
>>>   sfd =3D fsopen("ext4", FSOPEN_CLOEXEC);
>>>   write(sfd, "s /dev/sdb1"); // note I'm ignoring write's length arg
>>
>> Imagine some malicious program passes sfd as stdout to a setuid
>> program. That program gets persuaded to write "s /etc/shadow".  What
>> happens?  You=E2=80=99re okay as long as *every single fs* gets it right=
, but that=E2=80=99s
>> asking a lot.
>
> Do note that you must already have CAP_SYS_ADMIN to be able to call fsope=
n().

If you=E2=80=99re not allowing it already, someone will want user namespace
root to be able to use this very, very soon.
