Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C77C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 12:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54D492175C
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 12:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="ZhOwE0yL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54D492175C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729850AbeHMPgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 11:36:13 -0400
Received: from mail-oi0-f47.google.com ([209.85.218.47]:33040 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729764AbeHMPgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 11:36:13 -0400
Received: by mail-oi0-f47.google.com with SMTP id 8-v6so27048490oip.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 05:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zHPm9ENqpRL5SUv/M4L/XhK5ZNN5AtWTxqBNwdbXolU=;
        b=ZhOwE0yLROyEjVqOLQVR23N5/aAulWoKXf+MA+uyTxI1HS9N1G8sqk3r6WHPChVxWx
         14btbueYpTYApZLBjt3PPou49qK8TOsrhY8v4HQHclT3Qz7I44PnmxnuGcYkOdSkk7cT
         iHrxDrFn7g4iVSHGAVquFT+uqcRrQeo8Ui9Ds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zHPm9ENqpRL5SUv/M4L/XhK5ZNN5AtWTxqBNwdbXolU=;
        b=qK/G5YPh86i6ekKGK5XGF/lcxM+TSEGOPsUJkWwB9vWTzXPCO+uDacc5Jte2kX33Dh
         0dvEL/Ky7ySiIijG4HPhAo3+Yapw2WXCqSH8Jhk6mnZ7hfT44h4ap7QeR5IrAZLfrIth
         PKXVrGScQycPl7jUxWIV/QpqphLq2et/Y7N47RaHJbIoQMEsLMCsYfJV2+dy5PhbWO+v
         bFrZlityCN49HzxrQFR1AjhDdjeT9qn41oZTYpbTUNgNiXxkDwc24XF2r8ZzMz83P08K
         EriM71QxOjdVd1htmCEFE/ieMcPItDI+D7aJGQwiRMAzkQvEkpVUbQQpG8mC1H4z51Jd
         Q3dQ==
X-Gm-Message-State: AOUpUlEC4m/SvEnbc5yh0rufai20uXW2bwTcIohIpSArdAa/ZVM99AQ1
        qeds1J09aMS4AU7z9pV8p9MHQVyD9jOOl/HbaaaFMQ==
X-Google-Smtp-Source: AA+uWPyWpcDGR8A1itOvrkrijaIcOVA3mXbvEXuCZz3ZOKACgn1UDwVySAsRnQ62UCScrWHqfHZa5yXOQ419tBAewv0=
X-Received: by 2002:aca:e350:: with SMTP id a77-v6mr18994238oih.250.1534164843442;
 Mon, 13 Aug 2018 05:54:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:113c:0:0:0:0:0 with HTTP; Mon, 13 Aug 2018 05:54:02
 -0700 (PDT)
X-Originating-IP: [212.96.48.140]
In-Reply-To: <20180811015815.GD6515@ZenIV.linux.org.uk>
References: <153313703562.13253.5766498657900728120.stgit@warthog.procyon.org.uk>
 <87d0uqpba5.fsf@xmission.com> <20180810151606.GA6515@ZenIV.linux.org.uk>
 <87pnypiufr.fsf@xmission.com> <20180811015815.GD6515@ZenIV.linux.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 13 Aug 2018 14:54:02 +0200
Message-ID: <CAJfpegtuf7=sEMJhaiQj8e31uvFzckRSHH4Bf9nTNn4gxV10Ow@mail.gmail.com>
Subject: Re: BUG: Mount ignores mount options
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        David Howells <dhowells@redhat.com>,
        John Johansen <john.johansen@canonical.com>,
        Tejun Heo <tj@kernel.org>, selinux@tycho.nsa.gov,
        Paul Moore <paul@paul-moore.com>,
        Li Zefan <lizefan@huawei.com>,
        Linux API <linux-api@vger.kernel.org>,
        apparmor@lists.ubuntu.com,
        Casey Schaufler <casey@schaufler-ca.com>, fenghua.yu@intel.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Eric Biggers <ebiggers@google.com>,
        LSM <linux-security-module@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        tomoyo-dev-en@lists.sourceforge.jp, cgroups@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Theodore Y. Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 11, 2018 at 3:58 AM, Al Viro <viro@zeniv.linux.org.uk> wrote:

>  What I'm saying is that the entire superblock-creating
> machinery - all of it - is nothing but library helpers.  With the
> decision of when/how/if they are to be used being down to filesystem
> driver.  Your "first mount"/"additional mount" simply do not map
> to anything universally applicable.

Why so?   (Note: using the "mount" terminology here is fundamentally
broken to start with, mounts have nothing to do with this...
Filesystem instance is better word.)

You bring up NFS as an example, but creating and/or reusing an nfs
client instance connected to a certain server is certainly a clear and
well defined concept.

The question becomes:  does it make  sense to generalize this concept
and export it to userspace with the new API?

You know the Plan 9 fs interface much better, but to me it looks like
there's a separate namespace for filesystem instances, and the mount
command just refers to such an instance.  So there's no comparing of
options or any such horror, just the need to explicitly instantiate a
new instance when necessary.  Doesn't sound very difficult to
implement in the new API.

Thanks,
Miklos
