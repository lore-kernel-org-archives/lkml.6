Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B2FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31F4C2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nci0wZ8e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31F4C2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729857AbeKTB4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 20:56:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:57416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729762AbeKTB4n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 20:56:43 -0500
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 554A92146D
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 15:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542641566;
        bh=sHwkhBNkvftHJBS1ehPM4ASXBhRQU8qt95++KWUYPpQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nci0wZ8eHuR+UqxtTGNohjioV+zwGyTDpvvw3HtWdE/lfB0maBtfmneJ/gGwWClJE
         2uolBazKzL1/ONYTpuaOFwyk6juwAmO2cIYUpe90jvEAIJwwiEnA9S5sZm567LYpeB
         6VkJ1KrlK+1e9ule5m/Skwty8xKIz9S33CADxI+g=
Received: by mail-wr1-f45.google.com with SMTP id u5-v6so27239602wrn.9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 07:32:46 -0800 (PST)
X-Gm-Message-State: AA+aEWatc7+uTeH3SgX58z7H0c19FiZ6nWK5pBC/cOBrIiiwHVXaSfMa
        roMPiqX1iFmna74mrj7aZRR/+DkgOx2qXSw9qahqdw==
X-Google-Smtp-Source: AFSGD/Xjyo1Vcnoxr384p+bLGZ1AhVN9PJ1vh8IkSKB30XQ2ERP7qTT+BcS2FfUlYOs7qajp/O9aaDDuy2EuJBgUszk=
X-Received: by 2002:adf:ea81:: with SMTP id s1mr216821wrm.309.1542641564760;
 Mon, 19 Nov 2018 07:32:44 -0800 (PST)
MIME-Version: 1.0
References: <20181119103241.5229-1-christian@brauner.io> <20181119103241.5229-2-christian@brauner.io>
In-Reply-To: <20181119103241.5229-2-christian@brauner.io>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 19 Nov 2018 07:32:33 -0800
X-Gmail-Original-Message-ID: <CALCETrVvHu2dSJs1dpA-2ozGhZGxbGrnYbUuh98rkCdsz42rfg@mail.gmail.com>
Message-ID: <CALCETrVvHu2dSJs1dpA-2ozGhZGxbGrnYbUuh98rkCdsz42rfg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] proc: get process file descriptor from /proc/<pid>
To:     Christian Brauner <christian@brauner.io>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Daniel Colascione <dancol@google.com>,
        Tim Murray <timmurray@google.com>,
        linux-man <linux-man@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 2:33 AM Christian Brauner <christian@brauner.io> wrote:
>
> With this patch an open() call on /proc/<pid> will give userspace a handle
> to struct pid of the process associated with /proc/<pid>. This allows to
> maintain a stable handle on a process.
> I have been discussing various approaches extensively during technical
> conferences this year culminating in a long argument with Eric at Linux
> Plumbers. The general consensus was that having a handle on a process
> should be something that is very simple and easy to maintain with the
> option of being extensible via a more advanced api if the need arises. I
> believe that this patch is the most simple, dumb, and therefore
> maintainable solution.

How does the mechanism you're adding here differ from proc_pid()?
