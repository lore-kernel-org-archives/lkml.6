Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5011C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 18:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 609EF20665
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 18:50:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PWSrGUOb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 609EF20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbeJXDPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 23:15:03 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:43372 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728282AbeJXDPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 23:15:03 -0400
Received: by mail-yw1-f66.google.com with SMTP id j75-v6so986563ywj.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 11:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MLwe1V3+WJhm5IZOKBCWNwMrf6D/NJnM+bO9U6nJ9WI=;
        b=PWSrGUObF5SXc5Gy1kASJRkZcqkf5AaV68TJcvLo9+ZpDzbkyyQnt7RGDTsvNkUIpl
         YXGOhnMSilor+kLqcNu0xBBwrk77xeqXIoILYfus1H/+A1kA2ZAXED3/5QYkaKeHU3hA
         MNRhWWUFNF65xWLVx0vrJke+PykxNIFOanEZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MLwe1V3+WJhm5IZOKBCWNwMrf6D/NJnM+bO9U6nJ9WI=;
        b=RW/8gMg7LEgxLWsAOOiHpkrua5jWGNfo7oM3MuSq473XdtqVznsydOZUgy8O0XJ42B
         tEhEz5Ey6bynAERrFxoUBJKqVhezlJ6HIhGrG/2356nahW4sa9p9v4UJCPGjL0/Kymy1
         iEiAiEX3uBsPNc4LyGYYaEZkUw4kfUMQRn15/ruXoUMQ/A//w7bIZo6l2hL8E4mwE9TT
         z3Tagap5xbIAV7ZVplJN4KgqNSdhGCKTAh/z9O03S72LjK9d+pMwa66QA4D8DlA1USXE
         Ui75OWlHXDbWY1OrIZQ62oEpjhL/uWQ15NlKcZBNOjZhax7skLKeaRIcYTIeXuQ+N++S
         6MQQ==
X-Gm-Message-State: ABuFfogOsNvIRAsRnPyMTfof4P+f6sixSn8DQa3QmzUWEppkrOQOQPV+
        GgdfYz5p2RCqvXc8RyNISoxF7y91FVQ=
X-Google-Smtp-Source: ACcGV62vccQIvfVFD0cQ43ABRG9GxZKuutN1Efxr6m7ijfja9EGO24KeDwhO3jsKWqjU63fHdrYskg==
X-Received: by 2002:a81:7506:: with SMTP id q6-v6mr6098418ywc.51.1540320625123;
        Tue, 23 Oct 2018 11:50:25 -0700 (PDT)
Received: from mail-yw1-f43.google.com (mail-yw1-f43.google.com. [209.85.161.43])
        by smtp.gmail.com with ESMTPSA id c129-v6sm473992ywe.84.2018.10.23.11.50.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 11:50:23 -0700 (PDT)
Received: by mail-yw1-f43.google.com with SMTP id v77-v6so992007ywc.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 11:50:22 -0700 (PDT)
X-Received: by 2002:a81:9b83:: with SMTP id s125-v6mr36333374ywg.47.1540320621970;
 Tue, 23 Oct 2018 11:50:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:3990:0:0:0:0:0 with HTTP; Tue, 23 Oct 2018 11:50:21
 -0700 (PDT)
In-Reply-To: <96e92224-aedf-5026-d6dd-b29121b4dc0d@schaufler-ca.com>
References: <20181011001846.30964-1-keescook@chromium.org> <CAGXu5jLBaHj5MhXaK-8zdu6Rgo2B6rEq+at17xZ1Puct+YUajQ@mail.gmail.com>
 <ZhaXhoElmWQlsxHmgFHpB2xSWzJYFZWBasrSKQNjGj4_T2A4AY2F9v1rP9LkUfilUbZ0ExWXX9koLNjUM8S6baX6xfSSMPXY_CpihbCetVc=@protonmail.ch>
 <CAGXu5j+kekUdcE2EhUu__8MXJ1O+D=-zTXLGNCRVa_VyDxePpw@mail.gmail.com>
 <f68e5f4b-6360-a9e7-597f-89d1d3ca73c1@canonical.com> <32stV62RmME8Dj5jKB8Z03zPe_Et72kMo71D8SpgSOHUo6SaROc8DomMWdk5jDGpyqVd8T63NIIK2NdDw95clpF8Uj47Wca2FBFItXDRh7E=@protonmail.ch>
 <38dde301-d77e-35fd-88d4-5cdc5b570ee8@canonical.com> <_CkJnKYmEZ4ZF0JtsSYuahAd9sgnX9OtcstjXaeqb8wn5uxfimc6S4jomly7If9VqnOXqXwaiCbJ9ttS6NiqE7n6cQUlwLvfO53paLmacvU=@protonmail.ch>
 <8251564f-ba7a-1777-a606-dec472b32f35@canonical.com> <CAGXu5j+2yVZ5DQHyqvJKnSYYqRCzeMtEabBwYFOWkTcwMUWhEw@mail.gmail.com>
 <96e92224-aedf-5026-d6dd-b29121b4dc0d@schaufler-ca.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 23 Oct 2018 11:50:21 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKFqtV_NFRaXPKVgNQt3F1pwFqopDLp1ZQJDGM_Bdid6Q@mail.gmail.com>
Message-ID: <CAGXu5jKFqtV_NFRaXPKVgNQt3F1pwFqopDLp1ZQJDGM_Bdid6Q@mail.gmail.com>
Subject: Re: [PATCH security-next v5 00/30] LSM: Explict ordering
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     John Johansen <john.johansen@canonical.com>,
        Jordan Glover <Golden_Miller83@protonmail.ch>,
        James Morris <jmorris@namei.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Paul Moore <paul@paul-moore.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        LSM <linux-security-module@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 9:48 AM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 10/12/2018 12:01 PM, Kees Cook wrote:
>> On Friday, October 12, 2018 3:19 AM, John Johansen
>> <john.johansen@canonical.com> wrote:
>>> It isn't perfect but it manages consistency across distros as best as
>>> can be achieved atm.
>> Yeah, this is why I'm okay with the current series: it provides as
>> consistent a view as possible, but leaves room for future improvements
>> (like adding "+" or "!" or "all" or whatever).
>>
>> I'm curious to see what SELinux folks think of v5, though. I *think* I
>> addressed all the concerns there, even Paul's "I want my distro
>> default to not have extreme stacking" case too.
>>
>> -Kees
>
> Looks like I should go on vacation more often. :)
>
> I am generally opposed to fancy specification languages.
> I support the explicit lsm= list specification because you
> don't have to know any context to create a boot line that
> will work, and be as close to what you've specified as possible
> for the kernel configuration. One need look no further than
> the mechanisms for setting POSIX ACLs for an example of
> how to ensure a feature isn't used.
>
> Had we the foresight to make security= take a list of
> modules when Yama was added we might have avoided some of
> this brouhaha, but there was no reason to expect that stacking
> was ever going to happen back then.

This sounds like an "Ack" for you? :) I'll harass everyone in person
in a couple days.

Did you poke around at my combined series?
https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=lsm/ordering-v6-blob-sharing

-Kees

-- 
Kees Cook
Pixel Security
