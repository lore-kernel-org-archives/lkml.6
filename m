Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B0DC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 14:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D73021523
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 14:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="MT+i9QeY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D73021523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbeHXS37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 14:29:59 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41067 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbeHXS36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 14:29:58 -0400
Received: by mail-pl1-f196.google.com with SMTP id p4-v6so1204764pll.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 07:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=+a5qJusAt9SBUxtVUfIdlnx3x47ICXKLvKpe8OnnbSg=;
        b=MT+i9QeYhIFybKVMsnO828uGSNGOwmggM1dnns5bFFsBS7jShVilpN7fyaaUXU4iCm
         ys5xsoAc/QbXNI6SbvEJBeZ/l07lSa0rydYAZUZsV9RJL5bxJWCYb6hu4QSpPC0g5Mrw
         5KhDCEfFJ5oI86KKVr7IcMwcK19QrXBPyMg1ruyRmOWN8gacbg0OXMXIJyglj2xJbXtg
         y8lwT2V3Z+rzeomk1bDNoH0FtNzz3sVMD2PRiVkRK/UOIbQCKQkUaU4xGB1aAmcwVzcY
         TV0elySWFY83cMMUOSsWxoi1YT4Z6oPvCuhMGBZbXVbT/VwTDIzGc3BfjmQMPbsW37ZK
         zm0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=+a5qJusAt9SBUxtVUfIdlnx3x47ICXKLvKpe8OnnbSg=;
        b=SIDV5uY05q0L8PCYT+3t9d1i+IJ17+XiBxSLP85qjsh5y3F6ReSeDs1x+iPMTLckBX
         K6AckG0oDcheTxAgdL7kSugyKiizi54s7RStbUCA8qPumZyYQqbNVHTsHjAEqwiYtmi1
         nkx3h3aUSxFpl1db4UivhUPAbhp+AyFj+HBuR/qziao3CQxOZCEbD/RTpHOZobWrSaYB
         J6kOrozaPQctSt+HpecWDgCEUHoI3+9FAz2tnBK6+QyxOm6s6blDDv5b63PjnyKl0dlm
         pT+RWfPUIGHzSWp6XTGV34i84W762SS8fVJ328dYq9yzkUj9VFEBqARy4/D0ZrSVxqQC
         /uCg==
X-Gm-Message-State: APzg51Dn969lzGp3xhhcSUG0Iz8AO/LGDLNSh0tPSCOo53a97Z3FmXIi
        V5by5RrNLwJ4NzesNV6QY2MvUA==
X-Google-Smtp-Source: ANB0VdbOHRicn+4qcY8My91lNpJkF/V1i5RglmYp8LEvN86HrmxLvD/1cq4TmGR0/s8S0Wks0bzRrQ==
X-Received: by 2002:a17:902:24a5:: with SMTP id w34-v6mr1988633pla.122.1535122498753;
        Fri, 24 Aug 2018 07:54:58 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:7429:1817:4b35:1894:1f41? ([2601:646:c200:7429:1817:4b35:1894:1f41])
        by smtp.gmail.com with ESMTPSA id s27-v6sm11501116pfk.133.2018.08.24.07.54.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Aug 2018 07:54:57 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 30/33] vfs: syscall: Add fspick() to select a superblock for reconfiguration [ver #11]
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15G77)
In-Reply-To: <CAELBmZCv3uAmXiSEk3vdYEy8wn_mP8Rs6qzMqSa56_kPsb_=aA@mail.gmail.com>
Date:   Fri, 24 Aug 2018 07:54:57 -0700
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux API <linux-api@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FAB6FB68-5B65-41D1-BD5B-78D8553BA601@amacapital.net>
References: <153313703562.13253.5766498657900728120.stgit@warthog.procyon.org.uk> <153313724861.13253.3837522702693613670.stgit@warthog.procyon.org.uk> <CAELBmZCv3uAmXiSEk3vdYEy8wn_mP8Rs6qzMqSa56_kPsb_=aA@mail.gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 24, 2018, at 7:51 AM, Miklos Szeredi <miklos@szeredi.hu> wrote:
>=20
>> On Wed, Aug 1, 2018 at 5:29 PM David Howells <dhowells@redhat.com> wrote:=

>>=20
>> --- a/include/uapi/linux/fs.h
>> +++ b/include/uapi/linux/fs.h
>> @@ -351,6 +351,11 @@ typedef int __bitwise __kernel_rwf_t;
>>=20
>> #define FSMOUNT_CLOEXEC                0x00000001
>>=20
>> +#define FSPICK_CLOEXEC         0x00000001
>> +#define FSPICK_SYMLINK_NOFOLLOW        0x00000002
>> +#define FSPICK_NO_AUTOMOUNT    0x00000004
>> +#define FSPICK_EMPTY_PATH      0x00000008
>=20
> This caught my eye:  why aren't we using the AT_ constants?  Adding an
> AT_CLOEXEC sounds less horrible than duplicating all the lookup
> related flags for FSPICK...

For a totally new API, is there any need to support !CLOEXEC?  A caller can s=
afely remove the CLOEXEC bit without races.=
