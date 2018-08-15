Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 921C9C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 15:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9128821527
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 15:44:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dpz9fbP1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9128821527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729448AbeHOSg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 14:36:59 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:43180 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729249AbeHOSg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 14:36:58 -0400
Received: by mail-io0-f195.google.com with SMTP id y10-v6so1321432ioa.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 08:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RohGbH8seZcsG3pv6IdJlL+KAjjQ0uUKPvz8LXg6wy4=;
        b=dpz9fbP1J/Yd2KICaHJJurtFxNkU5KHaeF2Q9rUw6duBpNg8s2vkMc3JGrHXT3ugkG
         McDKbRcdvamB2yI99pATS+yMsLXmeqANqxgbsEOKprHUmfNWXGI4jRR8xQI2AO0feFV8
         0+Al2I0WE0A5shr5tMo+TGvvHK7nqeZHRQYS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RohGbH8seZcsG3pv6IdJlL+KAjjQ0uUKPvz8LXg6wy4=;
        b=EBTGHRsAsNYK0GviY06ldMwX2Sob5ZElcUrCQUWxKb52FV8Fx//ueSikFlL4woUCpG
         XqWbmREMs7A6KX578cKxED9H+IWviZ8keWtwkdVdLHp6g/j4mmiFSUUa/EkzBZUnCx+v
         YVEPXC//Z9ZaXNjTVvBu7luOb8L1aqHe9ys+aGFfyOiXacRlMTqN/dSgxyebR5zwcKpr
         WUUq4LDrs1K7wvdUOzAMQSQq+BGN86Dt3jwVGNBqyRpjMbs8WXghJ/4p1F9QPr3f1QFm
         Q2EASou1iyRV70WVckMs5T6jegoC1ovMQDB2JXmGrGmgxEvvVsNZZZDzfdaAP4wrFuVi
         qRpA==
X-Gm-Message-State: AOUpUlF7B7C9UurVE8gQl/PrNDwx3HGVZWd2co1ZfCvGyAJSaB95S2e9
        JXAtwQSSXPD0/vEMh1UIpGxSSnhHj9YgZmQO6Ao=
X-Google-Smtp-Source: AA+uWPxEJM/ZI61qnR45AIH95fVQRFrn1KOdulBVhgoJBekCmY6kBxDaFLz0KVLhuhn04ZwZlswO598ZSuvCd2LVTy8=
X-Received: by 2002:a6b:f815:: with SMTP id o21-v6mr9685895ioh.203.1534347858736;
 Wed, 15 Aug 2018 08:44:18 -0700 (PDT)
MIME-Version: 1.0
References: <20180814170904.GA12768@roeck-us.net> <aa4bedb7b1af45c59ff4e61f3f199287@AcuMS.aculab.com>
In-Reply-To: <aa4bedb7b1af45c59ff4e61f3f199287@AcuMS.aculab.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 Aug 2018 08:44:07 -0700
Message-ID: <CA+55aFyeW7rqgGqOusZSz-jFP-CMH=hcyVGKhxyLxNeyBgLbqw@mail.gmail.com>
Subject: Re: Build failures with gcc 4.5 and older
To:     David Laight <David.Laight@aculab.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Mike Galbraith <efault@gmx.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 5:38 AM David Laight <David.Laight@aculab.com> wrote:
>
> Never mind the version of gcc, the x86 kernel doesn't build with the
> default kernel options because the ORC unwinder hits a bug in libelf
> (in objtool) that was only fixed late last year.
>
> It isn't even obvious from the build log what has gone wrong.

Can you give more details? We should try to work around it.

It's one thing to care about a compiler that is almost a decade old.
At some point we just have to let it go.

But some libelf bug that is less than a year old is likely to bite people.

                     Linus
