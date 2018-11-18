Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C299CC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 18:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E5DD20869
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 18:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ErI5NExB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E5DD20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbeKSEgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 23:36:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:52368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726741AbeKSEgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 23:36:22 -0500
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30ABF20869
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 18:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542564925;
        bh=yfcFrIAFT4scKWN9bupr6FohMuwkTM1qu3KEAjvYSB4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ErI5NExB83UB8S5rPWj9i1HtnaUHmOJTgM7/uk4gHsKEtzxLdX2DttM0QTKS3t+E7
         D9j25+9DuectQI1aKJ3X2HsUcqGsR4EEyPNXqXowX6YedPlXYr9lYHxqUb93EAQ/6e
         rTH+QPaErdGU0QGsxxL7YB+GhIWNbrDLGGqrVoBY=
Received: by mail-wm1-f53.google.com with SMTP id u13-v6so3118897wmc.4
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 10:15:25 -0800 (PST)
X-Gm-Message-State: AA+aEWb977eb0l4hM8K4w++Y1azX2LhEB3fALunABvDxstAwB0XXRrzd
        i9Zha/88Px1eiMuay7T9RMkLhmqaqPmFCU/IQ3qnMw==
X-Google-Smtp-Source: AJdET5fB7uTWghIEqFHvtizOyhA4dMSedrfgfAi0gP6rJtzA4ZYHlvIPlmz5jJaYXChQ9FHEBU5vZvr3M2aBh2qpWUA=
X-Received: by 2002:a7b:ce11:: with SMTP id m17mr5081690wmc.74.1542564923629;
 Sun, 18 Nov 2018 10:15:23 -0800 (PST)
MIME-Version: 1.0
References: <20181118111751.6142-1-christian@brauner.io> <CAKOZuet3s0WxxPgrtrNkq8YiOWhYAiK6yEio6PKVV9J_H4_TSA@mail.gmail.com>
 <CALCETrUd2Y2MmO8Qx8aUvQDOTNiyj35Y7bctPBZe0p2i1EUiLw@mail.gmail.com>
 <20181118174148.nvkc4ox2uorfatbm@brauner.io> <CAKOZueto1CmUSWFKjOkazcDcZH6CiXXCr4U=ghewLh8GjE2-=A@mail.gmail.com>
In-Reply-To: <CAKOZueto1CmUSWFKjOkazcDcZH6CiXXCr4U=ghewLh8GjE2-=A@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 18 Nov 2018 10:15:11 -0800
X-Gmail-Original-Message-ID: <CALCETrUb8MSPPBLLz5Md9Fzaq3Kd9HtG8R5JFwWuy21jOuzbUA@mail.gmail.com>
Message-ID: <CALCETrUb8MSPPBLLz5Md9Fzaq3Kd9HtG8R5JFwWuy21jOuzbUA@mail.gmail.com>
Subject: Re: [PATCH] proc: allow killing processes via file descriptors
To:     Daniel Colascione <dancol@google.com>
Cc:     Christian Brauner <christian@brauner.io>,
        Andrew Lutomirski <luto@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Kees Cook <keescook@chromium.org>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 18, 2018 at 10:07 AM Daniel Colascione <dancol@google.com> wrote:
> Next, I want to merge my exithand proposal, or something like it. It's
> likewise a simple change that, in a minimal way, addresses a
> longstanding API deficiency. I'm very strongly against the
> POLLERR-on-directory variant of the idea.

Can you explain why you don't like POLLERR-on-a-directory?  I'm not
saying that POLLERR-on-a-directory is fantastic, but I'd like to
understand what your objection is.
