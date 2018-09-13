Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 311FBC04AB8
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 21:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D44132086C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 21:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jfgETlFD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D44132086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbeINCYI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 22:24:08 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:32952 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728135AbeINCYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 22:24:08 -0400
Received: by mail-yb1-f195.google.com with SMTP id m123-v6so3924477ybm.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 14:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=B8RjlVE67xRxPCIwpfQfMOS0PLBGWmaIwWz5AqPOoQs=;
        b=jfgETlFDog9JiF6SAOhtxhFHyQIbO/P6lDbUe1UZ/mrOP96zps95IWdOGkYwppYVe+
         MluxdckKnRxqYwwp4brSpTC38ABcQ9EcuwFDDA8K0znnRWaas0VJQyVhj255QwFOjMGe
         QvIkqu/Lt48dlwJmefoWmZ3/lo3xm2MPoONjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=B8RjlVE67xRxPCIwpfQfMOS0PLBGWmaIwWz5AqPOoQs=;
        b=NH+G31RskiPb2BQhiZH/6JH1M96sScENrXrwpRQBez7w6aTBo/Og7BUg8k3WlGCLpE
         TIXpcGiVPVAQM9aaEIT6Jz9Un24vFTi2Z3Sbw7sQa/oE0nVL+Zm3EnVZMZ17+XxP1yJr
         f1uQ2XGGUzmJ1b4WMJgsQaYFl35w4AuJF2PaOqJ7pxTKwdR+p7IamjkGcD826JWqHUyl
         e36YO0HoLjho4yLEW7OIyjL6w0k7j0kzwCh+fGQgu9iWgNQb4jVsbJcOTycmd3dnb6wE
         D60R+PqHU/JXBPc4i+pkEJi1Q2ztUYuvXLMHeeSlJnDyQit63QCSVxqR+TDMZEHkRzd2
         M/6w==
X-Gm-Message-State: APzg51DezNE1Ur4LlhhVdDHM/WhCy2omlANdtq2AKg3YtoNWCdk/tq7H
        /2VURPsAK1SRMTnUs1pdPHJMcssW2xQ=
X-Google-Smtp-Source: ANB0VdbBUhxvToois2Ret7tgjznd+HfKNYPGTYXzjRwE0Qhln39zkAvZXFUGC2d81caHDaHGA0MZxg==
X-Received: by 2002:a25:84d2:: with SMTP id x18-v6mr4326245ybm.93.1536873173129;
        Thu, 13 Sep 2018 14:12:53 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id q127-v6sm1873868ywq.83.2018.09.13.14.12.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 14:12:51 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id m123-v6so3924433ybm.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 14:12:51 -0700 (PDT)
X-Received: by 2002:a25:e5c3:: with SMTP id c186-v6mr4352418ybh.209.1536873171042;
 Thu, 13 Sep 2018 14:12:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Thu, 13 Sep 2018 14:12:50
 -0700 (PDT)
In-Reply-To: <5a17beeb-c83c-ce8e-162c-1fbeb74aaae8@schaufler-ca.com>
References: <cbf848ae-a1ac-c5ab-f23b-bc9217fceebe@schaufler-ca.com>
 <d92f5457-c7b0-a768-2411-5a5528f88fc8@schaufler-ca.com> <CAGXu5jLxnmyNzWV2VV0tq-ikAnMAPfebfqxSWvHPUVDZ_xYsyg@mail.gmail.com>
 <5a17beeb-c83c-ce8e-162c-1fbeb74aaae8@schaufler-ca.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 13 Sep 2018 14:12:50 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+apDE-E-FM-55pE7hPQbuKV+x22XK0QrO4qyGnq-6T3A@mail.gmail.com>
Message-ID: <CAGXu5j+apDE-E-FM-55pE7hPQbuKV+x22XK0QrO4qyGnq-6T3A@mail.gmail.com>
Subject: Re: [PATCH 04/10] LSM: Infrastructure management of the cred security blob
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     LSM <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        LKLM <linux-kernel@vger.kernel.org>,
        SE Linux <selinux@tycho.nsa.gov>,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Schaufler, Casey" <casey.schaufler@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 12:01 PM, Casey Schaufler
<casey@schaufler-ca.com> wrote:
> On 9/12/2018 4:53 PM, Kees Cook wrote:
>> On Tue, Sep 11, 2018 at 9:41 AM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>>> Move management of the cred security blob out of the
>>> security modules and into the security infrastructure.
>>> Instead of allocating and freeing space the security
>>> modules tell the infrastructure how much space they
>>> require.
>> There's a lot of changes here that I think deserve some longer
>> discussion in the changelog. Notably, now we run _two_ cycles of init
>> calls? That seems... odd. Notes below...
>
> The first pass adds up the blob sizes. This has to be done because
> some modules allocate blobs during the init phase. I have investigated
> alternatives, including blobs that include information about what they
> contain, but they're all significantly more complicated.

Agreed: I liked the idea of not burdening each LSM with a state
machine, but I guess it's not much. Note that "finished" then should
be __initdata.

>>> -       if (selinux_is_enabled() && cred->security) {
>>> -               if ((unsigned long) cred->security < PAGE_SIZE)
>>> -                       return true;
>>> -               if ((*(u32 *)cred->security & 0xffffff00) ==
>>> -                   (POISON_FREE << 24 | POISON_FREE << 16 | POISON_FREE << 8))
>>> -                       return true;
>> These aren't unreasonable checks -- can we add them back in later?
>> (They don't need to be selinux specific, in fact: the LSM could do the
>> poison...)
>
> I had asked the maintainers about the value of these checks, and
> they said that they were primarily there for debugging during the
> original cred breakout development. I'd have not problem making them
> infrastructure managed if there's a strong desire to keep them.

Since it was only SELinux doing this, and it was from old debugging,
then I concur: drop it. It would be easy to restore (and for all LSMs)
in the future.

>>> +static inline void set_cred_label(const struct cred *cred,
>>> +                                 struct aa_label *label)
>>> +{
>>> +       struct aa_label **blob = cred->security;
>>> +
>>> +       AA_BUG(!blob);
>>> +       *blob = label;
>>> +}
>> This feels like it should be a separate patch? Shouldn't AA not be
>> playing with cred->security directly before we get to this "sizing and
>> allocation" patch?
>
> You're correct. This is a harmless patch break-up mistake. The end
> result of the set is correct, and the interim state works as intended,
> albeit with unnecessary code.

I much prefer lots of small easy-to-understand patches than trying to
piece together many separate things. Let's please break out each LSM's
changes and any refactoring into separate patches. Complexity is
harder to review than quantity, IMO.

>>> + */
>>> +void lsm_early_cred(struct cred *cred)
>>> +{
>>> +       int rc;
>>> +
>>> +       if (cred == NULL)
>>> +               panic("%s: NULL cred.\n", __func__);
>> I have been given strongly worded advice to never BUG nor panic. I would:
>>
>> if (WARN_ON(!cred || !cred->security))
>>        return;
>>
>>> +       if (cred->security != NULL)
>>> +               return;
>>> +       rc = lsm_cred_alloc(cred, GFP_KERNEL);
>>> +       if (rc)
>>> +               panic("%s: Early cred alloc failed.\n", __func__);
>> And:
>>
>> WARN_ON(lsm_cred_alloc(cred, GFP_KERNEL));
>
> This duplicates the previous behavior from the SELinux and Smack code.
> A WARN_ON will result in an immediate panic when the calling code tries
> to dereference the blob.

I guess what I'm trying to say is, if you have a patch that does:

+ .... panic()

or

+ .... BUG()

and it has "security" anywhere in the topic, you run an extremely high
risk of Linus NAKing the entire series.

>>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>>> index 9d6cdd21acb6..9b49698754a7 100644
>>> --- a/security/selinux/hooks.c
>>> +++ b/security/selinux/hooks.c
>>> @@ -213,12 +213,9 @@ static void cred_init_security(void)
>>>         struct cred *cred = (struct cred *) current->real_cred;
>>>         struct task_security_struct *tsec;
>>>
>>> -       tsec = kzalloc(sizeof(struct task_security_struct), GFP_KERNEL);
>>> -       if (!tsec)
>>> -               panic("SELinux:  Failed to initialize initial task.\n");
>>> -
>>> +       lsm_early_cred(cred);
>>> +       tsec = selinux_cred(cred);
>> Perhaps leave the existing panic() as-is?
>
> Moving the panic into lsm_early_cred() reduces the panic count
> and avoids code duplication here and in the Smack equivalent.

Agreed: but it means intentionally adding a machine-stop condition
which Linus is very opposed to.

>> Shouldn't this Tomoyo cred handling get split out?
>
> Yeah. Again, it's the patch size/count balance.

I really do like lots of little patches. SO much easier. The main
brain-drain on large patches is that things end up out of order due to
filename ordering, etc, so a lot more needs to be kept in your head as
you're reading a long patch. Much prefer lots of small patches.

-Kees

-- 
Kees Cook
Pixel Security
