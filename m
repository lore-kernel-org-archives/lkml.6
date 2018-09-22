Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF7CECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 02:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 234EB21569
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 02:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hREW/Ll2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 234EB21569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbeIVIsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 04:48:15 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:40114 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbeIVIsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 04:48:15 -0400
Received: by mail-yw1-f66.google.com with SMTP id z143-v6so5974364ywa.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 19:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fqtmSX+sw2Gw5cwP9H4XIT+A4pBxM7+TarOUk6KMXt0=;
        b=hREW/Ll2mRpvNq8w0SvCgMmE30mCBdCTp06J7r2cPh2AZ1s9Ss3aGZcfXyd4xxJC12
         rMae314wfDebPOyIRp0ObUDW5+8ARApxmACY4owL26Fxd+U0+y/mcYEldXA/yuBXPfn4
         KWXmSJ+LEoZeVwECkqZ0yHW/X7jemuJ9sO/kg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fqtmSX+sw2Gw5cwP9H4XIT+A4pBxM7+TarOUk6KMXt0=;
        b=MbJh0zCVaIia8pokO3CqFk/4+wtO0YX/0gLvnEPkBL3q5PgtFoY3OenL9PHwXD1a7V
         jv8qA8t9bmJIC9YZYMn5bvB1N8bvlm6sYMF7hwviwrAMiaiPbtQGRnY94L6q6vlTfsb/
         F0OOKJTqMrhFhwXJIaZ+8Umz4jEIR+im15ElvLXjJdy3e2KTHTjVrgmYN1vNbO1IUzFa
         NRTP8fIWHHDlgkHv3raoIUvLSj0w0ib0wxTif2jdfw3yhfLTIIggy2ORrVBINsQuZHJJ
         NvXbntN4tRa6Blmwg1LIdyegLWq1ZQG5giSBe6pPq2qIYqTjUgohEBlemaozxk0TPqm0
         I3aA==
X-Gm-Message-State: APzg51A1TNUiHRKXw45Hmbdot5wk+q69lcNZsCOjLWvnAEkc+EL9NNHK
        v/TnO7Ew/w5d3pnzQkaOCHKnQa2CUEY=
X-Google-Smtp-Source: ANB0Vda3Dv/zEoVhmFsh4NEBH8mXbUAISMAk+rAl0Hsoz1xNlz/TURTcIQp1tk46MUiyDm+pkuH6gg==
X-Received: by 2002:a81:a014:: with SMTP id x20-v6mr216006ywg.468.1537584983138;
        Fri, 21 Sep 2018 19:56:23 -0700 (PDT)
Received: from mail-yw1-f41.google.com (mail-yw1-f41.google.com. [209.85.161.41])
        by smtp.gmail.com with ESMTPSA id f5-v6sm5001842ywa.39.2018.09.21.19.56.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 19:56:22 -0700 (PDT)
Received: by mail-yw1-f41.google.com with SMTP id q129-v6so5977377ywg.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 19:56:21 -0700 (PDT)
X-Received: by 2002:a0d:d347:: with SMTP id v68-v6mr221326ywd.124.1537584981439;
 Fri, 21 Sep 2018 19:56:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Fri, 21 Sep 2018 19:56:20
 -0700 (PDT)
In-Reply-To: <c3a54353-6208-d234-038b-f538acf2bee5@schaufler-ca.com>
References: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com> <c3a54353-6208-d234-038b-f538acf2bee5@schaufler-ca.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 21 Sep 2018 19:56:20 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLdBRp2vBNxZby6=J4CRU=8jJsUxjGBXj-DLCfZ+Oao6A@mail.gmail.com>
Message-ID: <CAGXu5jLdBRp2vBNxZby6=J4CRU=8jJsUxjGBXj-DLCfZ+Oao6A@mail.gmail.com>
Subject: Re: [PATCH v4 15/19] LSM: Infrastructure management of the task security
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     LSM <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        SE Linux <selinux@tycho.nsa.gov>,
        LKLM <linux-kernel@vger.kernel.org>,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 5:19 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> Move management of the task_struct->security blob out
> of the individual security modules and into the security
> infrastructure. Instead of allocating the blobs from within
> the modules the modules tell the infrastructure how much
> space is required, and the space is allocated there.
> The only user of this blob is AppArmor. The AppArmor use
> is abstracted to avoid future conflict.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
