Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B71FEECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 18:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B7B4214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 18:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZL2X8FHS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B7B4214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbeIQXnA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 19:43:00 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:42794 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727375AbeIQXnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 19:43:00 -0400
Received: by mail-yb1-f195.google.com with SMTP id 13-v6so1112326ybn.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 11:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HXtRx65xnut6moP0t+ri3eSmXEgDeA261sRL3GHF/oU=;
        b=ZL2X8FHSgU7ebwvrrcSTR+njIBMNjr0HYmAtCzPRdLZm/6NcdkGftzDO3WyjiENDE3
         rwNCfzAduCCj2vP+fxVXqYo6RxsywstnCXElyHWEZGFBgpam/HRWvuHHpnQBpPpvB4y/
         bcF0P+F4kzPw2BFl/aBSFO7qsxF5qLOScH2SU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HXtRx65xnut6moP0t+ri3eSmXEgDeA261sRL3GHF/oU=;
        b=hPt5G3oj3L6uGkEwDW2kRwhxcvgo/qGvZ59Uv75Ahox63wnkHtqmSbHLAennJx1rx6
         9c9UxeZ1p/bqG05fAa9lHTfSbARC+2EKzOZhwXmZFXG9RGv3KtUjPCNkK4kLXVYi2xU6
         TlrvM1EHyCYz09vlZSzdBhRbVWTCBwJvUIxQ6X2Jbg0ODXpkpTO1F9siq2xpB3LMib8C
         QspLPyVKLcTpeGxKjTY4KySl1a2rFdsOx4FX3Kugl+KP0WBq5u1GzpFcsBkr4MmVsa95
         KYfy8UlMZMKX4aBVWaHwtFbBE1WV7Y994NeulbeIhHzuBjgEaQNQ/Lsl2CkHVMApa/sE
         wvDQ==
X-Gm-Message-State: APzg51CUga5bXWGzXyJqS0rcjXoTd7XnL3PaNcpSLUnC8k4DT1y5tNuj
        HPiiUdEz0ZmLCxA5OGn08CUNChbeyMc=
X-Google-Smtp-Source: ANB0VdaQ7CMCvJLLBDEGFxPbTNB97Dqk6LUpoFeDM3FvAN+zTxfbW45p2zoI9SgoBGxgw6XH+IZncg==
X-Received: by 2002:a25:8104:: with SMTP id o4-v6mr11143355ybk.516.1537208069428;
        Mon, 17 Sep 2018 11:14:29 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id 189-v6sm7855559ywf.4.2018.09.17.11.14.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 11:14:27 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id y9-v6so4153515ybh.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 11:14:27 -0700 (PDT)
X-Received: by 2002:a25:2c3:: with SMTP id 186-v6mr6669864ybc.421.1537208067100;
 Mon, 17 Sep 2018 11:14:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Mon, 17 Sep 2018 11:14:26
 -0700 (PDT)
In-Reply-To: <8f0bd39b-29a6-325d-4558-d9f484249c22@schaufler-ca.com>
References: <20180916003059.1046-1-keescook@chromium.org> <20180916003059.1046-17-keescook@chromium.org>
 <84e1a5a8-8997-829f-cf09-1d29895a3f99@schaufler-ca.com> <CAGXu5jK5CzXUii97q_yk3KzBTw0SOmoc=-zcm+3jAqEHe76AgQ@mail.gmail.com>
 <35b0af5b-e37e-e192-73b5-0d0b37d9e37f@schaufler-ca.com> <CAGXu5jJ71RLGh0nDgOaN3vCXFGE0poXFU2Gb9o+20aO+AEdOvw@mail.gmail.com>
 <8f0bd39b-29a6-325d-4558-d9f484249c22@schaufler-ca.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 17 Sep 2018 11:14:26 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLeTfwEXAZLz_H1PCx0ySWZcRhXQMfnE14TG8BvxY46JA@mail.gmail.com>
Message-ID: <CAGXu5jLeTfwEXAZLz_H1PCx0ySWZcRhXQMfnE14TG8BvxY46JA@mail.gmail.com>
Subject: Re: [PATCH 16/18] LSM: Allow arbitrary LSM ordering
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     James Morris <jmorris@namei.org>,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        LSM <linux-security-module@vger.kernel.org>,
        LKLM <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 10:13 AM, Casey Schaufler
<casey@schaufler-ca.com> wrote:
> TOMOYO uses the cred blob pointer. When the blob is shared TOMOYO
> has to be allocated a pointer size chunk to store the pointer in.
> Smack has the same behavior on file blobs.

Oh dang, yes, I got confused over secid and other "extreme" shared things.

So one change of my series would be to declare tomoyo as "exclusive" too.

> Today the distinction is based on how the module registers hooks.
> Modules that use blobs (including TOMOYO) use security_module_enable()
> and those that don't just use security_add_hooks(). The "pick one"
> policy is enforced in security_module_enable(), which is why you can
> have as many non-blob users as you like. You could easily have a
> non-blob using module that was exclusive simply by using
> security_module_enable().

True. With my removal of security_module_enable(), yes, it makes sense
to mark all LSMs that were calling it before as exclusive, rather than
focusing on whether they would be exclusive under the blob-sharing
situation.

> Keep security=$lsm with the existing exclusive behavior.
> Add lsm=$lsm1,...,$lsmN which requires a full list of modules
>
> If you want to be fancy (I don't!) you could add
>
> lsm.add=$lsm1,...,$lsmN which adds the modules to the stack
> lsm.delete=$lsm1,...,$lsmN which deletes modules from the stack

We've got two issues: ordering and enablement. It's been strongly
suggested that we should move away from per-LSM enable/disable flags
(to which I agree). If ordering should be separate from enablement (to
avoid the "booted kernel with new LSM built in, but my lsm="..." line
didn't include it so it's disabled case), then I think we need to
split the logic (otherwise we just reinvented "security=" with similar
problems).

Should "lsm=" allow arbitrary ordering? (I think yes.)

Should "lsm=" imply implicit enable/disable? (I think no: unlisted
LSMs are implicitly auto-appended to the explicit list)

So then we could have "lsm.enable=..." and "lsm.disable=...".

If builtin list was:
capability,yama,loadpin,integrity,{selinux,smack,tomoyo,apparmor}
then:

    lsm.disable=loadpin lsm=smack

becomes

    capability,smack,yama,integrity

and

    CONFIG_SECURITY_LOADPIN_DEFAULT_ENABLED=n
    selinux.enable=0 lsm.add=loadpin lsm.disable=smack,tomoyo lsm=integrity

becomes

    capability,integrity,yama,loadpin,apparmor


If "lsm=" _does_ imply enablement, then how does it interact with
per-LSM disabling? i.e. what does "apparmor.enabled=0
lsm=yama,apparmor" mean? If it means "turn on apparmor" how do I turn
on a CONFIG-default-off LSM without specifying all the other LSMs too?

-Kees

-- 
Kees Cook
Pixel Security
