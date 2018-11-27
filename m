Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD49C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 17:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1082320817
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 17:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nxXUEc6v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1082320817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730213AbeK1ECA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 23:02:00 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:41658 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbeK1EB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 23:01:59 -0500
Received: by mail-yb1-f195.google.com with SMTP id t13-v6so9351159ybb.8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 09:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pCmeLuXJSDXfNzUsGzoSyKWtmeU8tplKcwFZMo1YlKg=;
        b=nxXUEc6vWaU6mNMECZJ1fXTnroIfnEApi6zht7wz6n+D22WRtLOW3r9UWOoPF2EkVG
         xyCPV8ik8VhY4FR2RtfkaE8AJgUUu/a3gHm90PsFqlSUP55g3URcVMK4tbc97Mxw4FEd
         6mO3GttmYPW/VPrDYh338BYNwsu++VultqYpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pCmeLuXJSDXfNzUsGzoSyKWtmeU8tplKcwFZMo1YlKg=;
        b=XpNKUokeyWgXRZTF1qVSpHUPaAoIX7RE9wKV7bSx14QujvOqJ7JeaXSN8frpk/ODK/
         KkzYr43nFRMOsL51C7j3xCFcY4F5GJRczgTKJ0dmzSBbEzXkgSBPsbw90dUjXlskRpJv
         RbQh4AoLd/Mmf5ZEPyfmXnUlbpDkKgoKEXgg9mgESjzfOlqOx6dHrJh7yha0jmutxE3i
         4w9s572ygrnbFNKZlK1R/5844cGVW8lQfzovp1eoAVS8HMYNy7SSaMftjsZRYG0MmRR2
         rc6ChFIs1p7V+fesLNXXagvjvUVbunA+yZ+wHmgwf9VjgY8IoL4q07fBXs6bh7wv8lqN
         p8YA==
X-Gm-Message-State: AA+aEWYy8kOymcn6JdLZw1qMUP63bKAI/XXFGGmHkp3oBD8N/mf/vqkY
        1PLcYsAIfw91nMcLAlA6oHJdGMISui0=
X-Google-Smtp-Source: AFSGD/UlInu8KVLlXTI/RnnkDFF3LEVmPdXZTs2um74vcAfeGxsGSkiqLVvllrizXAgHzICzCH4Shg==
X-Received: by 2002:a25:af84:: with SMTP id g4-v6mr34094671ybh.370.1543338206636;
        Tue, 27 Nov 2018 09:03:26 -0800 (PST)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id i2sm1610416ywc.59.2018.11.27.09.03.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 09:03:26 -0800 (PST)
Received: by mail-yb1-f171.google.com with SMTP id g9-v6so9349943ybh.7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 09:03:24 -0800 (PST)
X-Received: by 2002:a25:a445:: with SMTP id f63-v6mr32715170ybi.171.1543338204257;
 Tue, 27 Nov 2018 09:03:24 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:b906:0:0:0:0:0 with HTTP; Tue, 27 Nov 2018 09:03:23
 -0800 (PST)
In-Reply-To: <8daf27d0-0f58-2dd6-c1bb-7b634494212a@c-s.fr>
References: <ca27a073c872e243be1d17a89afb4b4aeb9a298b.1541714054.git.christophe.leroy@c-s.fr>
 <20181127074316.GC13965@kroah.com> <8daf27d0-0f58-2dd6-c1bb-7b634494212a@c-s.fr>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 27 Nov 2018 09:03:23 -0800
X-Gmail-Original-Message-ID: <CAGXu5jLcur2cL8xvpmYOzQ-FZJk35_LSaOhv-ony5sFj6mcGVQ@mail.gmail.com>
Message-ID: <CAGXu5jLcur2cL8xvpmYOzQ-FZJk35_LSaOhv-ony5sFj6mcGVQ@mail.gmail.com>
Subject: Re: [PATCH] lkdtm: do not depend on CONFIG_BLOCK
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 7:59 AM, Christophe Leroy
<christophe.leroy@c-s.fr> wrote:
>
>
> On 11/27/2018 07:43 AM, Greg Kroah-Hartman wrote:
>>
>> On Fri, Nov 09, 2018 at 07:05:51AM +0000, Christophe Leroy wrote:
>>>
>>> Most parts of lkdtm don't require CONFIG_BLOCK.
>>>
>>> This patch limits dependency to CONFIG_BLOCK in order to give embedded
>>> platforms which don't select CONFIG_BLOCK the opportunity to use LKDTM.
>>>
>>> Fixes: fddd9cf82c9f ("make LKDTM depend on BLOCK")
>>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Actually, I don't think any of this is needed, actually. The switch to
kprobes from jprobes meant that the symbols are resolved at runtime
now, so there's no need for the headers at all (nor the Kconfig line).
I'll spin something and send it out...

-- 
Kees Cook
