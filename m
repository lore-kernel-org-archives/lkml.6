Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA16FC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 665D720989
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Wo4WoFgX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 665D720989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbeK3Kk4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 05:40:56 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:45883 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeK3Kk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 05:40:56 -0500
Received: by mail-yw1-f66.google.com with SMTP id d190so1519988ywd.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 15:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=icwD0A11Km8vCxTd+qOpF0mw9hR+DOxnr+3u8qTyQzY=;
        b=Wo4WoFgXSkgIWbJCafjKxpiFoZ0gaLTfP9vYOVtSXYhwynboTnLBNGo43tJ8xMZ4WW
         yQAoHLL+T0FMoCMKK7zxjy+aZ0vaF+x6ECeSB/Hbz4XQ/qJEbLz1tVlMxwq9/+87jJv6
         dfQZSTncHUAgji1pnfT6uTnolUTBylk1ZXYRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=icwD0A11Km8vCxTd+qOpF0mw9hR+DOxnr+3u8qTyQzY=;
        b=MzLtH1qncYkMElHzvgDnoJz5+ItQSLpna94ZdFetIZgcKzU6pzATLsxLbAgWWHpbPe
         qo+7l2+4hgAPnmSwcRYWvtD4d/TbFyLl7Ggv6BCy3OmKHzDfOW/fRScxSrtj6INDbGLJ
         9LJ0UKkYaWyxAFMwdFAq9iK5SK+b9ErMcbZNMCBeYJylCd2aAY8dVltplzdPjYcPA3TN
         fVh+/HhsY8LsQtr+sF51mvBbOG/D8PgmRq3q3OsiuGNcjwovkVRibMSSY2k6ti2WirA1
         AGJCzwD43+Zbr7wHuTL18AvqAOgPNTL1H5pNUiljb+XlSM5+Ts1f6qlIYY1aeHY5yD+z
         fi4Q==
X-Gm-Message-State: AA+aEWYitPoArdY1dLTTdSy8OHf8Kf+g8g/ryNP+8Pj15JnD1MI3A3DE
        kg+nh1+EMERR22+DNcc5EQo9imLrPVE=
X-Google-Smtp-Source: AFSGD/V45YjgBSn6uEjC9XSST9SUIonBbeTN2Uh4ShbEZrqzlawSN25sPwrNpU1RomJMUnFEYNoq4g==
X-Received: by 2002:a81:1b09:: with SMTP id b9-v6mr3511933ywb.248.1543534421803;
        Thu, 29 Nov 2018 15:33:41 -0800 (PST)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id h145sm985982ywc.72.2018.11.29.15.33.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 15:33:40 -0800 (PST)
Received: by mail-yb1-f177.google.com with SMTP id d18-v6so1499020yba.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 15:33:40 -0800 (PST)
X-Received: by 2002:a25:2349:: with SMTP id j70-v6mr3442478ybj.137.1543534419615;
 Thu, 29 Nov 2018 15:33:39 -0800 (PST)
MIME-Version: 1.0
References: <1488160439-7140-1-git-send-email-nobuhiro.iwamatsu.kw@hitachi.com>
In-Reply-To: <1488160439-7140-1-git-send-email-nobuhiro.iwamatsu.kw@hitachi.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 29 Nov 2018 15:33:28 -0800
X-Gmail-Original-Message-ID: <CAGXu5jLEU2n8jUjXhCiOAqfonMKov6rTv5-3KWSt4EmOEUn5Bg@mail.gmail.com>
Message-ID: <CAGXu5jLEU2n8jUjXhCiOAqfonMKov6rTv5-3KWSt4EmOEUn5Bg@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] pstore: ramoops: support multiple pmsg instances
To:     Nobuhiro Iwamatsu <nobuhiro.iwamatsu.kw@hitachi.com>
Cc:     Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 26, 2017 at 5:54 PM Nobuhiro Iwamatsu
<nobuhiro.iwamatsu.kw@hitachi.com> wrote:
> The following series implements multiple pmsg. This feature allows userspace
> program to control individual content aging or priority.

I'd like to take a look at this series again, if you're still
interested in upstreaming it. :) There were a lot of things that
needed refactoring in pstore to sanely deal with this, and I think
we're there now. Is this still desired?

Thanks,

-Kees

>
> If a pstore backend module(e.g. ramoops) requires the multiple pmsg instances
> when registering itself to pstore, multiple /dev/pmsg[ID] are created. Writes
> to each /dev/pmsg[ID] are isolated each other. After reboot, the contents are
> available in /sys/fs/pstore/pmsg-[backend]-[ID].
>
> In addition, we add multiple pmsg support for ramoops. We can specify multiple
> pmsg area size by its module parameter as follows.
>
>  pmsg_size=0x1000,0x2000,...
>
> I did check the operation of this feature on CycloneV (socfpga) Helio board.
>
> v5:
>   Add commit: "pstore: Change parameter of ramoops_free_przs()"
>     - I forgot addition to previous patch series.
>   Update commit: "pstore: support multiple pmsg instances"
>     - Fix comment.
>     - Fix initialization of num_pmsg.
>
> v4:
>   Rebase to 4.10-rc5
>   The following patches have been removed from this series as similar functions
>   were modified by other commit.
>      - pstore: Replace four kzalloc() calls by kcalloc() in ramoops_init_przs()
>      - pstore: Change parameter of ramoops_free_przs()
>      - pstore: Rename 'przs' to 'dprzs' in struct ramoops_context
>      - ramoops: Rename ramoops_init_prz() to ramoops_init_dprzs()
>
> v3:
>   Rebase to v4.8.
>   Split patch.
>   merged device_create().
>   Remove Blank lines.
>   Update documentiation of DT binding.
>   Update parsing function of ramoops_pmsg_size, add NULL termination.
>   Update module parameters for pmsg_size list.
>
> Hiraku Toyooka (2):
>   pstore: support multiple pmsg instances
>   selftests/pstore: add testcases for multiple pmsg instances
>
> Nobuhiro Iwamatsu (3):
>   pstore: Change parameter of ramoops_free_przs()
>   ramoops: Add __ramoops_init_prz() as generic function
>   ramoops: support multiple pmsg instances
>
>  Documentation/admin-guide/ramoops.rst              |  22 ++
>  .../bindings/reserved-memory/ramoops.txt           |   6 +-
>  fs/pstore/pmsg.c                                   |  23 +-
>  fs/pstore/ram.c                                    | 317 ++++++++++++++++-----
>  include/linux/pstore.h                             |   1 +
>  include/linux/pstore_ram.h                         |   8 +-
>  tools/testing/selftests/pstore/common_tests        |  21 +-
>  .../selftests/pstore/pstore_post_reboot_tests      |  27 +-
>  tools/testing/selftests/pstore/pstore_tests        |  14 +-
>  9 files changed, 342 insertions(+), 97 deletions(-)
>
> --
> 2.11.0
>


-- 
Kees Cook
