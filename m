Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7DBBC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 00:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B3EA21536
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 00:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MNfKiA6N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B3EA21536
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388857AbeIUG0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 02:26:16 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:35901 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbeIUG0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 02:26:16 -0400
Received: by mail-yb1-f193.google.com with SMTP id 5-v6so4746413ybf.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 17:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SwccCbkUX+HHUBGdWYMks7d98ul3uAqb/zyYWmMv+PQ=;
        b=MNfKiA6Nli4ZGb2UDRvpFWgab/5Ql74SKHXBn49Pf076YnZwIGfY5dLmoueoUGT6D8
         R4saBLjMH79HFud92AUVVkwOf50ItQOGaN8upC4FoOzyxoKgz++S0RB/iU1UfwPvXc5d
         xvjhOvqp0Konvjb9DJA3hjkSKxFkmY3+zKkj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SwccCbkUX+HHUBGdWYMks7d98ul3uAqb/zyYWmMv+PQ=;
        b=DE+yvF1b+/0HBvSW3FNMuUeLD0lRXGCnkMhNeQ5AjmmU90RhfoD7yp+jTuMvb7wBnp
         9gLNcG+MrxcgQkXhzpT+CXTtREfB+Vq2zldFcDH66tIpym3Hn/ZuJ4t0xa56C0hCCgnO
         QjWNZoexnc9BOGxyqqS03IsivblMp2kotGnMHeHFMKC5W2gfRHtqva3/rO1Ln6t3etOn
         GpSzDAb5lEep+WPM/NPzXba6IX4v3gR2K04IRINt+6V7Vbr3Jnb29RhT8G/k7lkytKAx
         eo3vcwCOwqP2+qbh0PPWFD2N5Hx4ZWihEmX+hM4MZnomBIfP16X2TUc/5oBPDJ8+tvbf
         Pngg==
X-Gm-Message-State: APzg51Cv6Fl0RO81IiHjSM56bZSgcFq8ZkzUKR3Sb2J5rt7jlj/LTAVC
        eXNfBuU25b4Pnlmqn6A2XohV3hRrJ+k=
X-Google-Smtp-Source: ANB0VdZNYvdJQjV36oKIrpXUO/q6CvOpSw3RSjtrlwKjrMUKHJP83OiUV3t9ZTUhqhmfdKGTI+GnNQ==
X-Received: by 2002:a25:bacf:: with SMTP id a15-v6mr19807402ybk.305.1537490403966;
        Thu, 20 Sep 2018 17:40:03 -0700 (PDT)
Received: from mail-yw1-f41.google.com (mail-yw1-f41.google.com. [209.85.161.41])
        by smtp.gmail.com with ESMTPSA id j8-v6sm5719908ywj.6.2018.09.20.17.40.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 17:40:02 -0700 (PDT)
Received: by mail-yw1-f41.google.com with SMTP id j131-v6so4526746ywc.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 17:40:02 -0700 (PDT)
X-Received: by 2002:a0d:fe87:: with SMTP id o129-v6mr2415541ywf.237.1537490401910;
 Thu, 20 Sep 2018 17:40:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Thu, 20 Sep 2018 17:40:01
 -0700 (PDT)
In-Reply-To: <71f833b8-40cb-83f8-6803-7df26e8fa460@schaufler-ca.com>
References: <20180920162338.21060-1-keescook@chromium.org> <20180920162338.21060-21-keescook@chromium.org>
 <71f833b8-40cb-83f8-6803-7df26e8fa460@schaufler-ca.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 20 Sep 2018 17:40:01 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLn_=pOTcnAo3m2h5i8yEhwf29qSqbv6N9LPcqdUntKQw@mail.gmail.com>
Message-ID: <CAGXu5jLn_=pOTcnAo3m2h5i8yEhwf29qSqbv6N9LPcqdUntKQw@mail.gmail.com>
Subject: Re: [PATCH security-next v2 20/26] LSM: Introduce "lsm.order=" for
 boottime ordering
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     James Morris <jmorris@namei.org>,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        LSM <linux-security-module@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 5:12 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 9/20/2018 9:23 AM, Kees Cook wrote:
>> Provide a way to reorder LSM initialization using the new "lsm.order="
>> comma-separated list of LSMs. Any LSMs not listed will be added in builtin
>> order.
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>>  Documentation/admin-guide/kernel-parameters.txt |  5 +++++
>>  security/security.c                             | 15 ++++++++++++++-
>>  2 files changed, 19 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index 32d323ee9218..5ac4c1056ffa 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -2276,6 +2276,11 @@
>>
>>       lsm.debug       [SECURITY] Enable LSM initialization debugging output.
>>
>> +     lsm.order=lsm1,...,lsmN
>> +                     [SECURITY] Choose order of LSM initialization. Any
>> +                     builtin LSMs not listed here will be implicitly
>> +                     added to the list in builtin order.
>
> Added at the end of the list, or beginning of the list?

Whoops, I had an earlier version that was more clear. I meant to say
"appended" instead of "added" here. Fixed for the next version.

-Kees

-- 
Kees Cook
Pixel Security
