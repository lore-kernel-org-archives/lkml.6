Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B2AFC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 18:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C92CC21780
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 18:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GmpnnkqB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C92CC21780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388701AbeKPEcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 23:32:25 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39209 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbeKPEcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 23:32:24 -0500
Received: by mail-lf1-f68.google.com with SMTP id n18so14813134lfh.6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 10:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z0VqKWmCzbvP6EBNUCEdZNyVBzTuGAXjpwZ0H8orjDk=;
        b=GmpnnkqBTDRCVjkaJT9mKaWgwtQ6F5gNATMR5VTOF/BiaRkWt4crEQfKzbwSic8loV
         yhSAabR9ofrp6wupcyAZ6KyOlMmGx3BKBaFXN93mF8IhdepFGr87pYa1DGQV65XNUTWJ
         Bd6hcVkCnl6PpxYxI5PfzUBn30OcungX2jGRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z0VqKWmCzbvP6EBNUCEdZNyVBzTuGAXjpwZ0H8orjDk=;
        b=MC3tI662Fe46lX1o6fAWmCCrHpILXIHS9gedu6o6f27AQjVcc8mYwLtQ0JfwL9ztyy
         eklLMjRhKf4QGc/Dx7kzARrSYgj9XtgAIc89rDHB/KyXa+dJd6wMx4mU2iSH32iODXqT
         6gZTzd0q5QwU5MCjg0opEiof3v9t3jr41tL4rN3TWwyut4dmTuyxBhB1qe/RdXUJtnH/
         YFbK8Tb5sDkikffPXPUacG0Gyfo4+pw2gfE3d+oRvuItGFQB0XG1VvVv0Bnp79EYWKMG
         1wgCHqKpflbC4ftV5vUYIS5GA6t1gq8v5SMfcE6lC1fN8gBhPaBdruxPdGAYee1NEFfD
         9BNw==
X-Gm-Message-State: AGRZ1gJRxvqlHm9iRq+m+9BlLCQd0Ar6jXAR0lUw/bJ6qrKzRFeW+fY9
        LNLcbd8NcyhDSiw475oM2jtTltZdzkk=
X-Google-Smtp-Source: AJdET5ereYairpbV1ETWoJmgvhOoUbP3JUFX/aXNSTSJUoabPglBjaKosQsPdAGbhPIo3VPKCoKZcg==
X-Received: by 2002:a19:f20:: with SMTP id e32mr4155634lfi.51.1542306209034;
        Thu, 15 Nov 2018 10:23:29 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id y1-v6sm4342712ljh.39.2018.11.15.10.23.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 10:23:28 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id z80-v6so18076481ljb.8
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 10:23:27 -0800 (PST)
X-Received: by 2002:a2e:9819:: with SMTP id a25-v6mr4700269ljj.6.1542306207417;
 Thu, 15 Nov 2018 10:23:27 -0800 (PST)
MIME-Version: 1.0
References: <CAHc6FU6P0HdDWGMmsjyArQ746N7RBE3qMVq3aZgkfGjb153yJw@mail.gmail.com>
 <CAHk-=wi1f2tTnHe_DoMBsoj7v38G746Kk=tpouGg0_Y3fUFqKA@mail.gmail.com> <CAHc6FU5vaPLF8kcTAnHGHPkJQMf7GwMOX3YOg=DC=XFHrYPmdg@mail.gmail.com>
In-Reply-To: <CAHc6FU5vaPLF8kcTAnHGHPkJQMf7GwMOX3YOg=DC=XFHrYPmdg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 15 Nov 2018 12:23:09 -0600
X-Gmail-Original-Message-ID: <CAHk-=wgxioabke99QwPvMJ0YJ8of0vyAT4Rxw3zoNvgjn0Y_kg@mail.gmail.com>
Message-ID: <CAHk-=wgxioabke99QwPvMJ0YJ8of0vyAT4Rxw3zoNvgjn0Y_kg@mail.gmail.com>
Subject: Re: [GIT PULL] gfs2: 4.20 fixes
To:     agruenba@redhat.com
Cc:     cluster-devel@redhat.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 12:20 PM Andreas Gruenbacher
<agruenba@redhat.com> wrote:
>
> I guess rebasing the for-next branch onto something more recent to
> avoid the back-merge in the first place will be best, resulting in a
> cleaner history.

Rebases aren't really any better at all.

If you have a real *reason* for a merge, do the merge. But then the
reason should be clearly stated in the merge commit. Not just some
random undocumented merge message. Tell why some other branch was
relevant to your fix and needed to be pulled in.

Better yet, don't do either merges or rebases.

             Linus
