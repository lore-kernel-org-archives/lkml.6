Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D34C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 02:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 104B821569
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 02:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ilb5hjfm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 104B821569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbeIVIme (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 04:42:34 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:43238 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbeIVImd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 04:42:33 -0400
Received: by mail-yb1-f196.google.com with SMTP id w80-v6so6252469ybe.10
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 19:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6JN7d/SMzu67DdMLPQmJGaOpRSTNfEGeZFFEvlRPld0=;
        b=Ilb5hjfmHl0jluT91r5MLDcZyf3GyiltbXXEcC1Id9/o4plH40KoMcu2aHIH0i1RRU
         gtUtKcScW1O/DFIOtJEOAef2cCyxRzDJxUeJzJnfJbvpRBEJtrlmbMgzKIRwZWNrnxVK
         x3coxJxhQm2Y4hEhbh9Jyi45jvICigFbGEquw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6JN7d/SMzu67DdMLPQmJGaOpRSTNfEGeZFFEvlRPld0=;
        b=YDMhD8xED/ijPllE/4OTzRtdG+guozJUCZS+QRX83itSD0oiQF8XZgaVyKSzLZ7UI6
         ufPu+oph+hoJRv/EiQePlsKRgDu1F4JlJP3oJlyJb/jJARWqQy1BbdLW6FV23byMcOfm
         QNtX3oVtWPtSEKOoSUMoeQzdmo1G3TBRNLVUvck9Ob99BqhgUch/gF8uTQWQueiEkaK1
         NI7raT14Btc/rMa4PGqZSQdVDCUoSlKloVCUcMIbwLYHlicSlZ6LcRZzZXKMt8oEF9TM
         SAmOPrJKmtYlsV9aIiG4wv3Pa26qGjpA3wdBN4gkuVgx/JjfS90rlNStIl0t7WCaVNMp
         fPzA==
X-Gm-Message-State: ABuFfojSt4VNiFlBPQl1V2HfR1yENSDfxLg0R1GU8FccRtiNLgA52+Zp
        IdTXQAfbpPeGyVrh1vQhG/BovnTqhm8=
X-Google-Smtp-Source: ACcGV62JbvV5+N8Fa8Rh/ngIehkypkUpb/Ua6ShkgFhAEdKPl7sLaDc7DtGy+rrSQoJxp8c0Wx98+w==
X-Received: by 2002:a25:c201:: with SMTP id s1-v6mr198786ybf.251.1537584643142;
        Fri, 21 Sep 2018 19:50:43 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id b6-v6sm2671094ywe.71.2018.09.21.19.50.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 19:50:40 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id 5-v6so6261089ybf.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 19:50:40 -0700 (PDT)
X-Received: by 2002:a25:238d:: with SMTP id j135-v6mr200848ybj.137.1537584640036;
 Fri, 21 Sep 2018 19:50:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Fri, 21 Sep 2018 19:50:39
 -0700 (PDT)
In-Reply-To: <f08b4c79-f283-3625-f461-71a4628655ef@schaufler-ca.com>
References: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com> <f08b4c79-f283-3625-f461-71a4628655ef@schaufler-ca.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 21 Sep 2018 19:50:39 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLKMG15hex6ko=E-YCMRRsmd22KdjzrRXH_FRMqwmchkw@mail.gmail.com>
Message-ID: <CAGXu5jLKMG15hex6ko=E-YCMRRsmd22KdjzrRXH_FRMqwmchkw@mail.gmail.com>
Subject: Re: [PATCH v4 08/19] Infrastructure management of the cred security blob
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

On Fri, Sep 21, 2018 at 5:18 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> Move management of the cred security blob out of the
> security modules and into the security infrastructre.
> Instead of allocating and freeing space the security
> modules tell the infrastructure how much space they
> require.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

When combined with my series, this gets slightly simpler:
- the double init call and the "finished" stuff goes away
- debugging output is controlled by "lsm.debug" param instead of a CONFIG

Regardless, for the overall logic, calculating the sizes, etc:

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
