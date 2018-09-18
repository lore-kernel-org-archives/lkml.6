Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 770ACECE562
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BCA7214FA
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jhBaTkav"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BCA7214FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbeIRFaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 01:30:14 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:33905 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727202AbeIRFaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 01:30:13 -0400
Received: by mail-yb1-f195.google.com with SMTP id 184-v6so65361ybg.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 17:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=luO0nQ+3xqFQg3voVwwTWVvTsXm5T5Dk3RaYZ5wO1tQ=;
        b=jhBaTkavzHbacMbgBvf4Tv9rL3ac6uEXPd4JrW6k8d8wxQaPuonY4OvE3V2qG3aeTG
         ZmIyqGqgpIODRC1oYuxfjL7KjhA/lgatvqF07Q+0+IJjvwifC6egnKHdxffW/+kml+Ta
         uFMTvweOD2M6X4gyIwzeQ4lSOD0lLDJR5pMuo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=luO0nQ+3xqFQg3voVwwTWVvTsXm5T5Dk3RaYZ5wO1tQ=;
        b=fMJYkszMARJBR1ththP7N3P5F49xwZowbHQCS0f40H6fZVybFSVW0OTmoxHYfdMti0
         jZy6hHd45vAnrCVYUX1qh/ZKha+8QOIWNdjNMKmTA6nEJorSDwVz8QT3ZI9guCvfF1zS
         oaUWwQFIUllVMM6Z3JLMZ2pAKxdPwjPKQMuBwBus/MqW893FcNeBS5zZ9I+lvaHWlVlf
         Fu1dDfmug/NkHGWolA9MXqu5wvTd88jXWRHNdtCStVoUw9ur8uVAFCGX5uF+wEi/bMwC
         PhrcxxJ1nS7SXVUICmNIiXyqybZAeGx8+dTOUsiNdNsP5fuoyAgM6/kgGPFJyVamn8Bw
         GMNw==
X-Gm-Message-State: APzg51DYfUdjFYnR5IlJaxfgFdX0KFuQ+lWP/xZZLp8CRSSiRbAeUixv
        30xfZI3uat07X4T1JdA7c9zAnKtXXS0=
X-Google-Smtp-Source: ANB0VdbwOsqgfi4bfGczl8pPjIYMl94tqNcyyXFtKPk7YsNAfRd+O5C0L3/gwgUoYsKe7kl4ChDqaA==
X-Received: by 2002:a25:bb8c:: with SMTP id y12-v6mr11411032ybg.283.1537228829130;
        Mon, 17 Sep 2018 17:00:29 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id d21-v6sm257370ywb.16.2018.09.17.17.00.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 17:00:27 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id g79-v6so59099ybf.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 17:00:27 -0700 (PDT)
X-Received: by 2002:a25:3617:: with SMTP id d23-v6mr4743590yba.141.1537228826954;
 Mon, 17 Sep 2018 17:00:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Mon, 17 Sep 2018 17:00:25
 -0700 (PDT)
In-Reply-To: <e9292d89-12bd-2c4a-9ca2-5758de790f2f@canonical.com>
References: <20180916003059.1046-1-keescook@chromium.org> <20180916003059.1046-17-keescook@chromium.org>
 <84e1a5a8-8997-829f-cf09-1d29895a3f99@schaufler-ca.com> <CAGXu5jK5CzXUii97q_yk3KzBTw0SOmoc=-zcm+3jAqEHe76AgQ@mail.gmail.com>
 <35b0af5b-e37e-e192-73b5-0d0b37d9e37f@schaufler-ca.com> <CAGXu5jJ71RLGh0nDgOaN3vCXFGE0poXFU2Gb9o+20aO+AEdOvw@mail.gmail.com>
 <8f0bd39b-29a6-325d-4558-d9f484249c22@schaufler-ca.com> <CAGXu5jLeTfwEXAZLz_H1PCx0ySWZcRhXQMfnE14TG8BvxY46JA@mail.gmail.com>
 <53377892-695f-6336-8574-54c7aa0a4201@schaufler-ca.com> <7ecfffc3-d2a4-3ff7-4bf5-db3029d73c59@canonical.com>
 <fbdc2a75-8364-c743-f9c3-9dcd2570c569@schaufler-ca.com> <e9292d89-12bd-2c4a-9ca2-5758de790f2f@canonical.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 17 Sep 2018 17:00:25 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKhZTcz_+uQpNRh6Mg34pP2+aNSo9cV=c8pC0r=oJBJog@mail.gmail.com>
Message-ID: <CAGXu5jKhZTcz_+uQpNRh6Mg34pP2+aNSo9cV=c8pC0r=oJBJog@mail.gmail.com>
Subject: Re: [PATCH 16/18] LSM: Allow arbitrary LSM ordering
To:     John Johansen <john.johansen@canonical.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>,
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

On Mon, Sep 17, 2018 at 3:36 PM, John Johansen
<john.johansen@canonical.com> wrote:
> On 09/17/2018 02:57 PM, Casey Schaufler wrote:
>> Modules not listed may go anywhere there is a "*" in the order.
>> An lsm.order= without a "*" is an error, and ignored.
>> If a module is specified in lsm.order but not built in it is ignored.
>> If a module is specified but disabled it is ignored.
>> The capability module goes first regardless.
>
> I don't mind using lsm.order if we must but really do not like the '*'
> idea. It makes this way more complicated than it needs to be

Having the "*" means that _not_ having it in "lsm.order=" is an
implicit form of LSM disabling. And I think we've gotten to the point
where we agree on the enable/disable logic, so I don't want to mess
that up again.

For enable/disable, I think we're agreed on:

    lsm.enable=$lsm
    lsm.disable=$lsm

lsm.disable takes precedent for disabling. (e.g. "lsm.disable=apparmor
apparmor.enable=1" will leave apparmor disabled)
lsm.enable will allow per-LSM enable/disable to operate. (e.g.
"lsm.enable=apparmor apparmor.enable=0" will leave apparmor disabled)

lsm.enable/disable ordering will be "last match": "lsm.disable=smack
lsm.enable=smack" will leave smack enabled. The legacy per-LSM
enable/disable ordering is the same, but ordering between
lsm.enable/disable and the per-LSM options is NOT ordered. i.e. the
precedent mentioned in the prior paragraph.

To support "security=", we'll still have some kind of legacy
LSM_FLAG_MAJOR to perform implicit disabling of the non-operational
other "major" LSMs. This means "security=$foo" will be a short-hand
for "lsm.disable=all-LSM_FLAG_MAJOR-who-are-not-$foo". This will
exactly match current behavior (i.e. "security=smack" and if smack
fails initialization, we do not then fall back to another major).


I think we have to support runtime ordering for the reasons John
specifies. Additionally, I have the sense that anything we can
configure in Kconfig ultimately ends up being expressed at runtime
too, so better to just make sure the design includes it now.

What we have now:

"first" then "order-doesn't-matter-minors" then "exclusive-major"

- we can't change first.
- exclusivity-ordering only matters in the face of enable/disable
which we have solved now (?)

so, ordering can be totally arbitrary after "first" (but before some
future "last"). We must not allow a token for "everything else" since
that overlaps with enable/disable, so "everything else" stay implicit
(I would argue a trailing implicit ordering).

The one complication I see with ordering, then, is that if we change
the exclusivity over time, we change what may be present on the
system. For example, right now tomoyo is exclusive. Once we have
blob-sharing, it doesn't need to be.

so: lsm.order=tomoyo  after this series means
"capability,tomoyo,yama,loadpin,integrity", but when tomoyo becomes
non-exclusive, suddenly we get
"capability,tomoyo,yama,loadpin,{selinux,smack,apparmor},integrity".
(i.e. if selinux is disabled then move on to trying smack, then
apparmor, etc.)

I would argue that this is a design feature (LSMs aren't left behind),
and order of enabled exclusive LSMs "wins" the choice for the
exclusivity (instead of operating "by name" the way "security="
works).

-Kees

-- 
Kees Cook
Pixel Security
