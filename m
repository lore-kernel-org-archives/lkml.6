Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB0DFC65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 17:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FC2D20833
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 17:16:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="clNZEu/n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FC2D20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbeKCCYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 22:24:09 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40339 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbeKCCYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 22:24:08 -0400
Received: by mail-lj1-f194.google.com with SMTP id t22-v6so2382215lji.7
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 10:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/EPNbrnaHwJ4uFJWUC2whqZKjg08R55iZ2JtbT1y1Xc=;
        b=clNZEu/n3BV3Obn+3KyzimQQveaWTgiSeUFAX5HKy0lv3fGG4FraZUObAl+q4q+VAb
         M2COavm4PWDDr6SHBVRMfQ3xYEiPq+579pCn/l9xlFZz9FeVwdfh6JLBTyZWOeODZcXm
         Tgu22GH69EhLxzYG820tS48KlS30+XhFmcVKM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/EPNbrnaHwJ4uFJWUC2whqZKjg08R55iZ2JtbT1y1Xc=;
        b=ET5JKPYsPM3ajqpJm5Y9g6dF7mVudc/YAWiTAicGzSHWKCi02xoSyYvTkTvsZirwsf
         P3iMW5OssESg5y/AolJCELhjeFB3ODq9XCwQKwBZyFNa4SFYbdTYO0U0v84LPeVdNI7z
         1vV9sSzCvAAJTzt0undnrolj02ss/e92LOySCfbG2KvLlLcWg3RfdnVFb9MiEoS3qgep
         SHpXwa1Ak+15gcRKAdouXbW2tP6Vyc5NWiYvuGA6/AN3EiyMpDO4LVvG1ZLsr9mbbhSc
         5G3mWdygrP24vcebv0sq/kizs2W+TH7MEWVUVRK15wUyHlwQAPO7iOjI5aCDD0dafJp6
         ZQRg==
X-Gm-Message-State: AGRZ1gK3cp54OgGbljUredLfq23Ymjo+4IMuKWHJ07wIez1W/q2kh7Nj
        k+lkKQntl4zCYqH8nXMKuiMGlfF0TfZCnQ==
X-Google-Smtp-Source: AJdET5cmopGbqnpe9992bPtqIv25HVfUx7g04kfn7U4cYxmIRW/7IwmYayiuVrxF4HqCMTox9r7U1A==
X-Received: by 2002:a2e:568b:: with SMTP id k11-v6mr8371133lje.105.1541178974569;
        Fri, 02 Nov 2018 10:16:14 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id v10-v6sm2435621ljh.72.2018.11.02.10.16.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 10:16:13 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id x3-v6so2360502lji.13
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 10:16:13 -0700 (PDT)
X-Received: by 2002:a2e:874e:: with SMTP id q14-v6mr5568003ljj.120.1541178972739;
 Fri, 02 Nov 2018 10:16:12 -0700 (PDT)
MIME-Version: 1.0
References: <20181101171938-mutt-send-email-mst@kernel.org>
 <CAGXu5jJ0HgV2qN=wohEgro6ixqXHOHBTsvS5a9Dcpz8gxVo3bA@mail.gmail.com>
 <CAHk-=wicvws38JqzVF6oNEZ0jGzP6RecR6yAGtyzX3AkoJ321g@mail.gmail.com>
 <20181102114635.hi3q53kzmz4qljsf@lakrids.cambridge.arm.com>
 <20181102083018-mutt-send-email-mst@kernel.org> <CAHk-=wh_bQK5zs+CwQ5eyodq4sQT0eOPp60qzvVL2_EtgETP-g@mail.gmail.com>
 <20181102122937-mutt-send-email-mst@kernel.org> <CAHk-=wibzqo7C+mS+BgZxRbgdWe2w5F39EhuFUhZUxvotoGLuA@mail.gmail.com>
In-Reply-To: <CAHk-=wibzqo7C+mS+BgZxRbgdWe2w5F39EhuFUhZUxvotoGLuA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 2 Nov 2018 10:15:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj5ZnqmpDuXBCcND8nMNitNyRf_4KQSzSUfQvX2-wOYsg@mail.gmail.com>
Message-ID: <CAHk-=wj5ZnqmpDuXBCcND8nMNitNyRf_4KQSzSUfQvX2-wOYsg@mail.gmail.com>
Subject: Re: [PULL] vhost: cleanups and fixes
To:     mst@redhat.com, Al Viro <viro@zeniv.linux.org.uk>
Cc:     mark.rutland@arm.com, Kees Cook <keescook@chromium.org>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        bijan.mottahedeh@oracle.com, gedwards@ddn.com, joe@perches.com,
        lenaic@lhuard.fr, liang.z.li@intel.com, mhocko@kernel.org,
        mhocko@suse.com, stefanha@redhat.com, wei.w.wang@intel.com,
        jasowang@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 2, 2018 at 10:10 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Don't you take over the VM with "use_mm()" when you do the copies? So
> yes, it's a kernel thread, but it has a user VM, and though that
> should have the user limits.

Oooh. *Just* as I sent this, I realized that "use_mm()" doesn't update
the thread addr_limit.

That actually looks like a bug to me - although one that you've
apparently been aware of and worked around.

Wouldn't it be nicer to just make "use_mm()" do

        set_fs(USER_DS);

instead? And undo it on unuse_mm()?

And, in fact, maybe we should default kernel threads to have a zero
address limit, so that they can't do any user accesses at all without
doing this?

Adding Al to the cc, because I think he's been looking at set_fs() in general.

                  Linus
