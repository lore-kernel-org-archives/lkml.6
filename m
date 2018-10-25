Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C78F2C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 23:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B99A20834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 23:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gAgHE6W4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B99A20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbeJZIGL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 04:06:11 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39531 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727487AbeJZIGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 04:06:11 -0400
Received: by mail-lf1-f65.google.com with SMTP id p11-v6so8099789lfc.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 16:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yGqyb+mbavX105TSA1uDZY2XfkRuyiQ52+Ad7XUqfEc=;
        b=gAgHE6W4y0izmaWpJaxyP960z1gpPE9lsR0o9+EgZhR3v2A+MoHlAEys9Dg0VRbeDq
         Amey1B5mUStZb16sYc223Cly9uMYiLAhfZLsRdfI5QxXHiOTA3aPcngVp5iIrBn+6Amw
         C14oWJPDehamc/tRMBai+WHmpBZCHeP1mezDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yGqyb+mbavX105TSA1uDZY2XfkRuyiQ52+Ad7XUqfEc=;
        b=Bkp1fkXbWn+vfBFR6HNwCjn5RrXIjak8ye0ZW5A8Ay6RzAVWOvyC2HnfnjmtDHjgzB
         4DmBtk/3a9A8kd34DiZi75G4y2Avme7leJ1V/L7/UMdEeXbK0cdBLT7pTNIemmbRwnZ7
         A7wUNffak+0ap5YTDjW82he5qFDk0Gc8eloPDmqizr6m/qmaWnmHqH/gqnlu8mNYiWDx
         Z/OTaPCi0ZS2z0nTruu4D+Z/yO74XZd99GdqxdFkilPw4dxwZCCCLLcYgsjLkv/SsEyb
         oXggLVBurXqS93QQz/LXVm7GZeBiTFyLnrrqdyEE1FOWCvfxtMcJfYZoReTuYmRV9Shw
         KR2g==
X-Gm-Message-State: AGRZ1gJ/ttrFW2/+0wcnp0WOCP9ovxCRTkTn73271Tx8fI5Mlgv+EZIZ
        QpnNcZMhXEEm9p1iZlr5IqXnDpYMhB6nwg==
X-Google-Smtp-Source: AJdET5c9ndbFJRclSDS7s9sPD3UvjF6MEuQyzbS7jJs778k6PcfjBUqvnNmbjLAAhdbPKqPjGolpZA==
X-Received: by 2002:a19:1019:: with SMTP id f25mr698213lfi.54.1540510291354;
        Thu, 25 Oct 2018 16:31:31 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id p1-v6sm1308090ljc.85.2018.10.25.16.31.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 16:31:30 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id n3-v6so8117825lfe.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 16:31:30 -0700 (PDT)
X-Received: by 2002:a19:288c:: with SMTP id o134-v6mr760019lfo.124.1540510289737;
 Thu, 25 Oct 2018 16:31:29 -0700 (PDT)
MIME-Version: 1.0
References: <20181023184234.14025-1-chang.seok.bae@intel.com>
 <20181023184234.14025-4-chang.seok.bae@intel.com> <CALCETrWWBYgaJfPykTpJ9=TsptVL_ieOR3JdYVVW02=O9CM17Q@mail.gmail.com>
 <20181024192137.GI6218@tassilo.jf.intel.com> <CALCETrUmD0jAzVMAUJ=9Vpih56Q4t9U5DJLnUxQdeMwZ3RAECA@mail.gmail.com>
In-Reply-To: <CALCETrUmD0jAzVMAUJ=9Vpih56Q4t9U5DJLnUxQdeMwZ3RAECA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 25 Oct 2018 16:31:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjHs_wff==pT=auhC4dzNYu1e+DfgN7WGWpr-Vsfv-d8w@mail.gmail.com>
Message-ID: <CAHk-=wjHs_wff==pT=auhC4dzNYu1e+DfgN7WGWpr-Vsfv-d8w@mail.gmail.com>
Subject: Re: [v3 03/12] x86/fsgsbase/64: Add intrinsics/macros for FSGSBASE instructions
To:     luto@kernel.org
Cc:     ak@linux.intel.com, chang.seok.bae@intel.com,
        Ingo Molnar <mingo@kernel.org>, tglx@linutronix.de,
        Peter Anvin <hpa@zytor.com>, dave.hansen@linux.intel.com,
        markus.t.metzger@intel.com, ravi.v.shankar@intel.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 4:14 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> On Wed, Oct 24, 2018 at 12:21 PM Andi Kleen <ak@linux.intel.com> wrote:
> >
> > BTW the other option would be to update the min-binutils requirement
> > to 2.21 (currently it is 2.20) and then write it directly without .byte.
> > I believe 2.21 added support for these instructions.
> >
> > (It's only a binutils requirement, don't need gcc support)
>
> I'd personally be fine with this.  Linus? Thomas? Ingo?

I always vote for "require modern tools" as long as it doesn't cause problems.

binutils-2.21 is something like seven years old by now, but the real
issue would be what versions distros are actually shipping. I don't
want people to have to build their own binutils just to build a
kernel.

It's usually some ancient enterprise distro that is stuck on old
versions. Anybody have any idea?

                 Linus
