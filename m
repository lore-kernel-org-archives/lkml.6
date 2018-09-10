Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B0AAC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9B5C20645
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TuKGfndL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9B5C20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbeIJVgI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 17:36:08 -0400
Received: from mail-yb1-f171.google.com ([209.85.219.171]:35141 "EHLO
        mail-yb1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727810AbeIJVgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 17:36:07 -0400
Received: by mail-yb1-f171.google.com with SMTP id o17-v6so8199151yba.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 09:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qwS2Bjd5kgKp2AzzG5DnN1lcFEwdAsxRLQWTNDDfDZY=;
        b=TuKGfndL1x07T+CKVF6tpQ9j3lkNobOTOiZzWmzvg+jreQIQxJsjkWhbLb8o729TvE
         KvI3W30vlrLSWpAnAzLWaq70kGFqiazacKAd9l3H08dbbm2xx3lDdJ5/B1n24DrXQgdc
         aAJzOv3zcXw3sGjZXXrgFXuXoAGQ4DkoGL6Ks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qwS2Bjd5kgKp2AzzG5DnN1lcFEwdAsxRLQWTNDDfDZY=;
        b=h3N2PqGnI5JCrzc+eUE1oE26tCBiPLKYvq+o1dPhxnSfQ93KguSFrLzxSHrik9cCWr
         +XqD53hTF56w2ktiv/1K2F0EKRWOcWyjERnLKcuTIOPsIR1sBeRoYHx467C3XxkHLnjt
         eL4sWsuxSxttE5FIkzLj/t2S1hn6rGWboMRTD+k3sZDpd8AHoxy2mHBQt+rqWoPnNhbr
         SoAisxJPBLdZATmH91on5vCJuLKVRVvYhECLSScvwPFb5r/A2NnsH26kJei8Z8SpDo17
         XY2jaA+PTnOtdCgY8LvCdtpcWZXQ4KbzYU6zqQPc4XDE8A4PeIDtAG+/+E1PFsGSRGXY
         eoyg==
X-Gm-Message-State: APzg51B6XHU1FyjIf3cNOHKIS6yv4qBBePWcGvO7i3Obot5+aa7WWSeh
        uQnjvIbH44i6ZzHE7nxb1+fFSGFe6mE=
X-Google-Smtp-Source: ANB0VdY4nTOZysm7gsrMMpNqlcy36hD3lEGupCnWEslwxO9auiFb8LCg3Ytz+eAqLIBbCdx0Y+e5tA==
X-Received: by 2002:a25:15ca:: with SMTP id 193-v6mr10260208ybv.484.1536597671133;
        Mon, 10 Sep 2018 09:41:11 -0700 (PDT)
Received: from mail-yw1-f49.google.com (mail-yw1-f49.google.com. [209.85.161.49])
        by smtp.gmail.com with ESMTPSA id d21-v6sm7225503ywb.16.2018.09.10.09.41.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 09:41:10 -0700 (PDT)
Received: by mail-yw1-f49.google.com with SMTP id m62-v6so8089600ywd.6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 09:41:09 -0700 (PDT)
X-Received: by 2002:a81:9fd6:: with SMTP id w205-v6mr10976774ywg.288.1536597669257;
 Mon, 10 Sep 2018 09:41:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Mon, 10 Sep 2018 09:41:08
 -0700 (PDT)
In-Reply-To: <20180910122907.GA23963@redhat.com>
References: <20180910122907.GA23963@redhat.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 10 Sep 2018 09:41:08 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKYVAfWkd3WTM4EkVHWGoUY9BtSGKMLb1RAKhUfgCVxfA@mail.gmail.com>
Message-ID: <CAGXu5jKYVAfWkd3WTM4EkVHWGoUY9BtSGKMLb1RAKhUfgCVxfA@mail.gmail.com>
Subject: Re: get_arg_page() && ptr_size accounting
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Rik van Riel <riel@redhat.com>, Michal Hocko <mhocko@suse.com>,
        Stanislav Kozina <skozina@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 5:29 AM, Oleg Nesterov <oleg@redhat.com> wrote:
> Hi Kees,
>
> I was thinking about backporting the commit 98da7d08850fb8bde
> ("fs/exec.c: account for argv/envp pointers"), but I am not sure
> I understand it...
>
> So get_arg_page() does
>
>                 /*
>                  * Since the stack will hold pointers to the strings, we
>                  * must account for them as well.
>                  *
>                  * The size calculation is the entire vma while each arg page is
>                  * built, so each time we get here it's calculating how far it
>                  * is currently (rather than each call being just the newly
>                  * added size from the arg page).  As a result, we need to
>                  * always add the entire size of the pointers, so that on the
>                  * last call to get_arg_page() we'll actually have the entire
>                  * correct size.
>                  */
>                 ptr_size = (bprm->argc + bprm->envc) * sizeof(void *);
>                 if (ptr_size > ULONG_MAX - size)
>                         goto fail;
>                 size += ptr_size;
>
> OK, but
>                 acct_arg_size(bprm, size / PAGE_SIZE);
>
> after that doesn't look exactly right. This additional space will be used later
> when the process already uses bprm->mm, right? so it shouldn't be accounted by
> acct_arg_size().

My understanding (based on the comment about acct_arg_size()) is that
before exec_mmap() happens, the memory used to build the new arguments
copy memory area gets accounted to the MM_ANONPAGES resource limit of
the execing process. I couldn't find any place where the argc/envc
pointers were being included in the count, so I believe this needs to
stay as-is otherwise it's a resource limit bypass.

> Not to mention that ptr_size/PAGE_SIZE doesn't look right in any case...

Hm? acct_arg_size() takes pages, not bytes. I think this is correct?
What doesn't look right to you?

> In short. Am I totally confused or the patch below makes sense? This way we do
> not need the fat comment.

Even if I'm wrong about acct_arg_size(), we need to keep the comment
because it still applies to "size" and the following ARG_MAX test and
the _STK_LIM test. I think it's very non-obvious that we need to
always keep the full argc/envc count each time we go through these
calculations.

-Kees

-- 
Kees Cook
Pixel Security
