Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8202C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B7242089F
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="qfSY7qTo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B7242089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbeKSXLh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 18:11:37 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:52527 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728701AbeKSXLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 18:11:37 -0500
Received: by mail-it1-f194.google.com with SMTP id i7so1812492iti.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 04:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CzNXpwAdtR3iY+9G5RVr+vp0LqD/ot2WLW+qRGPev38=;
        b=qfSY7qTo0h0WfNwN2LLHPHzPsbzTOc8+h0SYADApOviZ46Swusf3iBsyvF+JofJTdZ
         8EEg97VoaLM44uwMZrHOC9AW6oAcBixYUTRY5aMmbEJwNClYxHED/33xMvSyLHetiPLR
         6fJzFdG6xxteVCZlmNpu4WgrKab9Mo7vbMcD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CzNXpwAdtR3iY+9G5RVr+vp0LqD/ot2WLW+qRGPev38=;
        b=H0FK10eNbVkOjLPf5OFqDbiIqdlh3TXWLY5v/J5ntQm30Ym3fn8699brLNyDu4S6FV
         ysCH29EstfD3AhN0kGe5Po4BAmgpycRCfFrXiWF1I52tOLGKUKNrYf4TVe/3aZDtowJo
         2l1vBsazSVJkLoeZUkU4MQspeLJLJMuifzyMG/9Iqt7+BTAginVs7AL/Kte4WisyJ08I
         2Dk9vcyVMUrOZLA01Qucy4Vl23slrysXd7d093erYP2CLpqQFw57Vrt+sKY9tWhuWScW
         E4Vb+fzzMnAWCMLbzWvUA0CvwQNWI+shRcFWJpmpl42lEAfX8VWv9oeqt9QSqd5oVESS
         McLQ==
X-Gm-Message-State: AA+aEWYZdoxoLdPENvAM+RtDi1CPWZH38uiH08lUNpMnbtPrNey+IV+N
        M65g7BpV+MlDk/EJJk6QxhkBwBZUjU4PzU/H0ldncw==
X-Google-Smtp-Source: AFSGD/WoN00Bqk8F1hA5z2dcpDX1h9XxIJd2f0J4PqvDi/ntAuJ4x5Izoe7RA/RkARyn+2Z15YAZdglcfQfyrjRYfso=
X-Received: by 2002:a24:a08a:: with SMTP id o132mr8295536ite.1.1542631685319;
 Mon, 19 Nov 2018 04:48:05 -0800 (PST)
MIME-Version: 1.0
References: <cover.1542149969.git.rgb@redhat.com> <218e806e61cd5ae2fd38f9d546f953f86c763b58.1542149969.git.rgb@redhat.com>
In-Reply-To: <218e806e61cd5ae2fd38f9d546f953f86c763b58.1542149969.git.rgb@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 19 Nov 2018 13:47:53 +0100
Message-ID: <CAJfpegtA74ULckL+PXoM9_pynV78EKOpQ603iZrp=hfR0z0z7w@mail.gmail.com>
Subject: Re: [RFC PATCH ghak100 V1 1/2] audit: avoid fcaps on MNT_FORCE
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-audit@redhat.com,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>, sgrubb@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 6:34 PM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> Don't fetch fcaps when umount2 is called with MNT_FORCE to avoid a
> process hang while it waits for the missing resource to (possibly never)
> re-appear.

The patch would be pretty good if the dependence on MNT_FORCE wasn't
added.   As it is, it's buggy in more ways than one:

 - It does the opposite of the above (i.e. skips fcaps *unless*
MNT_FORCE is set)
 - sets LOOKUP_NO_REVAL from caller of path lookup, which is invalid
(LOOKUP_NO_REVAL is used only internally by path lookup)
 - the fact that *_path_mountpoint_at() shouldn't touch the mount root
is independent of MNT_FORCE

I still don't quite understand what audit is trying to do here, but
apparently it's okay to skip getxattr in the MNT_FORCE case.  So why
is it not okay to skip it in the non-MNT_FORCE case?

Thanks,
Miklos
