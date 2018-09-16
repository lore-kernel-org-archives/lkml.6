Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19465ECE562
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 01:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B95702087E
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 01:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fGG2ziMb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B95702087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbeIPHKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 03:10:21 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:35413 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727558AbeIPHKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 03:10:21 -0400
Received: by mail-yb1-f194.google.com with SMTP id o63-v6so723974yba.2
        for <linux-kernel@vger.kernel.org>; Sat, 15 Sep 2018 18:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7WV0jhMUC27fh3+VW50Y1h/lDTvtprDUDIBUaTd9iu8=;
        b=fGG2ziMbUXw8yHyRuLEeFd1Hq+z4HXiPOCKzM+TRvX6P/hjXVVh4xcQVtEp95fJqzD
         3RYJqiAhpU8XMIIWbqywfb7tXW+ky7r5DR4c4NyKRsn9AUrabSKAfe1B2Fp4AH/YQWRH
         RVsY0lIKfQqaZAWixu+Td40ljdfXPPZ+hUxU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7WV0jhMUC27fh3+VW50Y1h/lDTvtprDUDIBUaTd9iu8=;
        b=BbMh1yT7h7U7r6R0t1FVns6WkwKJs3PB1/NcvuxBu3DnJIm2P5MMehe7DWcs0OTZ9o
         ixK8i3qF5y1dIMly2jrcS5RX295oPnptc16dfLlD8Z6ukRvwBEGN2dlmsLowj+ej5OoH
         czEWHyUCv4dpA68cygQ3wYgrhwX25bqqq0m26vl+VhqR3pPFQJLDpOOpDS4qnlOQacL1
         vxM0B3JsmyUGBafnpxr23z+iL2AbheVyi4ZUKAbNXrrRFNl8x2tdtrRrlYguoPrAVNbK
         cWd7GFHc+G54N/kgzzrxHZ/nFkUW7TtVj6ilHKV5RFNaBrkMZNwTedQURBh1oJw81lAj
         rDBA==
X-Gm-Message-State: APzg51DKQfiCQld3KP4r+cM5olO/tj2SlC0JGDOuJf4JymLlH/Xni2R8
        mDhdyPejcdPrIb+SjWCsiBy8EwVwiNs=
X-Google-Smtp-Source: ANB0VdY8K6uT9xNsEIao5KORlHAtGDvvMPoA3Xevumo6NEQYq7LvkHPBUsJY7b0MWPEwZJez0czWlg==
X-Received: by 2002:a25:c186:: with SMTP id r128-v6mr7901146ybf.3.1537062551021;
        Sat, 15 Sep 2018 18:49:11 -0700 (PDT)
Received: from mail-yw1-f43.google.com (mail-yw1-f43.google.com. [209.85.161.43])
        by smtp.gmail.com with ESMTPSA id d70-v6sm8071298ywe.97.2018.09.15.18.49.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Sep 2018 18:49:08 -0700 (PDT)
Received: by mail-yw1-f43.google.com with SMTP id z143-v6so4153697ywa.7
        for <linux-kernel@vger.kernel.org>; Sat, 15 Sep 2018 18:49:08 -0700 (PDT)
X-Received: by 2002:a81:9b85:: with SMTP id s127-v6mr7854568ywg.47.1537062547816;
 Sat, 15 Sep 2018 18:49:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Sat, 15 Sep 2018 18:49:07
 -0700 (PDT)
In-Reply-To: <CAG48ez3aU5XtQxUzWE3N3f4JyCz0jFchC=CAnHTZkGZaryWFxQ@mail.gmail.com>
References: <20180916003059.1046-1-keescook@chromium.org> <20180916003059.1046-8-keescook@chromium.org>
 <CAG48ez3aU5XtQxUzWE3N3f4JyCz0jFchC=CAnHTZkGZaryWFxQ@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Sat, 15 Sep 2018 18:49:07 -0700
X-Gmail-Original-Message-ID: <CAGXu5jK6wPLQRte4S3cnSgDZ7LoVugtTytK5iW5c_XYRq7HA5w@mail.gmail.com>
Message-ID: <CAGXu5jK6wPLQRte4S3cnSgDZ7LoVugtTytK5iW5c_XYRq7HA5w@mail.gmail.com>
Subject: Re: [PATCH 07/18] LSM: Add minor LSM initialization loop
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

On Sat, Sep 15, 2018 at 6:27 PM, Jann Horn <jannh@google.com> wrote:
> On Sun, Sep 16, 2018 at 3:11 AM Kees Cook <keescook@chromium.org> wrote:
>> Split initialization loop into two phases: "exclusive" LSMs and "minor"
>> LSMs.
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>>  include/linux/lsm_hooks.h | 6 ++++++
>>  security/security.c       | 8 +++++---
>>  2 files changed, 11 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
>> index f8e618e2bdd2..ec3419b9b16f 100644
>> --- a/include/linux/lsm_hooks.h
>> +++ b/include/linux/lsm_hooks.h
>> @@ -2039,7 +2039,13 @@ extern char *lsm_names;
>>  extern void security_add_hooks(struct security_hook_list *hooks, int count,
>>                                 char *lsm);
>>
>> +enum lsm_type {
>> +       LSM_TYPE_EXCLUSIVE = 0,
>> +       LSM_TYPE_MINOR,
>> +};
>
> Is the intent of this explicit zero assignment that LSM_TYPE_EXCLUSIVE
> should be the default? If so, perhaps a comment "/* default */", or
> something like that, might be helpful.

You cut the patch quote off where I do exactly that:

>> +       enum lsm_type type;     /* Optional: default is LSM_TYPE_EXCLUSIVE */

:)

-Kees

-- 
Kees Cook
Pixel Security
