Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BCACECE562
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 01:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 085522087E
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 01:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="f3Cz/ez9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 085522087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbeIPHIo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 03:08:44 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:39624 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726848AbeIPHIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 03:08:44 -0400
Received: by mail-yw1-f65.google.com with SMTP id m62-v6so4158494ywd.6
        for <linux-kernel@vger.kernel.org>; Sat, 15 Sep 2018 18:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4D4fvnp3QPX9Q4pNR4VeHpaUXUgOJTpCfrPxcjYJ84I=;
        b=f3Cz/ez9xgFjWuLm5aHtZVCmYdQeV6TgDZ7qMHKDhnVmpm5pfgBcHDvCoSYffRg9m/
         9KTOljtgEcAVl1T+bpaHZjeDNMIW/Lx3LwEpbiqKMU/y1umUHOVBWKs37lmDO1pcF/ye
         G08/lCLRl+/GaIYA4ozSo8VjmM6IGPeiXf7tY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4D4fvnp3QPX9Q4pNR4VeHpaUXUgOJTpCfrPxcjYJ84I=;
        b=sZ6LO/PmnX86rH3DzLHqNMD77DBPdbDCln6rUFxtUGYstecSrkBEnDvkXv9+SbOHM+
         d1gOExs5tf1N4XS1FcBRNSKJryQ+PCzdPL6NPltwujWq4Zi96XJ6vZNjc+ATzZ+ol7/R
         SO5eG7iKIL7N+bZ9YnCAIez73+NF0HJ4eSgK4AFFcnXGuOctmfi7uGL4cM86xObhw9et
         bOebG7VhBEB+5vk97PVq1pFwDdpXtHmMN+WRJ5jMby49WMzhkO6p9p327XoMdIXJQ7ri
         c0J01MCpwxUie5LGAjEmaW2ySXuSA+iQGVpQWvN8yOkr1wuZLO0EZUY4CNt2APUnuK57
         whxw==
X-Gm-Message-State: APzg51Cm0Qbpe/Ehncv+4VeOhEjbfF//kg7WL522Ko/K1Avm7hRggSmp
        BbhDOp9ALRTu9J6narQtUCPQ9X56caw=
X-Google-Smtp-Source: ANB0VdaxrcV2tnpbCfQHxS5ZQC6bRLkHoQ1Gmt0CAbVzCn7ixBLF9yrJBiazJIRhU59mWo1xGh3aLQ==
X-Received: by 2002:a81:5155:: with SMTP id f82-v6mr7659032ywb.30.1537062453887;
        Sat, 15 Sep 2018 18:47:33 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id v18-v6sm4624194ywv.9.2018.09.15.18.47.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Sep 2018 18:47:31 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id o63-v6so723270yba.2
        for <linux-kernel@vger.kernel.org>; Sat, 15 Sep 2018 18:47:31 -0700 (PDT)
X-Received: by 2002:a25:5c87:: with SMTP id q129-v6mr8312837ybb.403.1537062450735;
 Sat, 15 Sep 2018 18:47:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Sat, 15 Sep 2018 18:47:30
 -0700 (PDT)
In-Reply-To: <CAG48ez1TPsz30WebxQPkZbjfPTyT2ui7L+4ZQ94FStCkWcJ0VA@mail.gmail.com>
References: <20180916003059.1046-1-keescook@chromium.org> <20180916003059.1046-12-keescook@chromium.org>
 <CAG48ez1TPsz30WebxQPkZbjfPTyT2ui7L+4ZQ94FStCkWcJ0VA@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Sat, 15 Sep 2018 18:47:30 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKYqxZpRjct6zcUgh27bZDrEYPhejRzdCXc8fmLHX_Y=g@mail.gmail.com>
Message-ID: <CAGXu5jKYqxZpRjct6zcUgh27bZDrEYPhejRzdCXc8fmLHX_Y=g@mail.gmail.com>
Subject: Re: [PATCH 11/18] LSM: Lift LSM selection out of individual LSMs
To:     Jann Horn <jannh@google.com>
Cc:     James Morris <jmorris@namei.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Casey Schaufler <casey.schaufler@intel.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 15, 2018 at 6:32 PM, Jann Horn <jannh@google.com> wrote:
> On Sun, Sep 16, 2018 at 3:14 AM Kees Cook <keescook@chromium.org> wrote:
>> In order to adjust LSM selection logic in the future, this moves the
>> selection logic up out of the individual LSMs, making their init functions
>> only run when actually enabled.
> [...]
>> +/* Is an LSM allowed to be enabled? */
>> +static bool __init lsm_enabled(struct lsm_info *lsm)
>> +{
>> +       /* Report explicit disabling. */
>> +       if (lsm->enabled && !*lsm->enabled) {
>> +               pr_info("%s disabled with boot parameter\n", lsm->name);
>> +               return false;
>> +       }
>> +
>> +       /* If LSM isn't exclusive, ignore exclusive LSM selection rules. */
>> +       if (lsm->type != LSM_TYPE_EXCLUSIVE)
>> +               return true;
>> +
>> +       /* Disabled if another exclusive LSM already selected. */
>> +       if (exclusive)
>> +               return false;
>
> What is this check for, given that you have the strcmp() just below
> here? From a quick look, it (together with everything else that
> touches the "exclusive" variable) seems superfluous to me, unless
> there are two LSMs with the same name (which really shouldn't happen,
> right?).
>
>> +       /* Disabled if this LSM isn't the chosen one. */
>> +       if (strcmp(lsm->name, chosen_lsm) != 0)
>> +               return false;
>> +
>> +       return true;
>> +}

Mainly it's for composition with later patches where the name check is
moved. It seemed easier to explain the logical progression with the
hunk here.

-Kees

-- 
Kees Cook
Pixel Security
