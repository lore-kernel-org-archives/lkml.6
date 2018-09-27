Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1AC2C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 01:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91BD72152C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 01:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=percona.com header.i=@percona.com header.b="Qm3h6ujT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91BD72152C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=percona.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbeI0IKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 04:10:48 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]:53520 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726682AbeI0IKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 04:10:47 -0400
Received: by mail-wm1-f49.google.com with SMTP id b19-v6so4160649wme.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 18:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=percona.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=HtFwSgkt9CKuBUebBKgqIYLsAOr5rmipZPaYeSVEkUQ=;
        b=Qm3h6ujTuUCLE1SbPAXI4Yv4YntrKHS85T43KJCmpFoY9N/HPYeDcvtTVxtynYQghr
         +QAt7UTG6LnT7u+kXJjqPDp4nFNydWv1RiICZxsRgFqyyspSZ2tW0XaIUsLvzppo41Dd
         ASglSWXHpKaqhE5/yVkqebhqhOo2ZGz+BN1Ew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=HtFwSgkt9CKuBUebBKgqIYLsAOr5rmipZPaYeSVEkUQ=;
        b=gfSln3Rw3GNPaPrpjfRKPdeaB/AyO9QCZpsLfg1sMB29dWuDGzuMRl70I4cPAy58T2
         lRGhwApxi4sh98eI6NkzwdLBjOIceP5e5YRPPmuxS9ONebTzUxRdqIca1wwSpHIm4BVS
         CFG2TDe3MpIohgOGlm5He57fDkNJDPYT2tF/tGjA709Hit3l1Jtye9SkSvZcEtqPZvk3
         xsjr68FHiBRCtG2ItmhqL15yqp6Ej4LhfA9ICzlrYZRZZyI8FLK47NVpiz7fkkG81Yr6
         4yn0SeROZQUmduzBinnYR/2aCix5XGJXXctOixKfQowK7YGHX+Fr75PrjUZkCtDuQRWI
         i87A==
X-Gm-Message-State: ABuFfoiwFzMJT440DzbxjkR0YNCDbVwedBAVY7cwCTMFCU5g1zLUhoaV
        40FPjuSfrnMO8i5TQExoeZvDtYgu9L6Pa92lBpZ0kshd
X-Google-Smtp-Source: ACcGV63M67DrNbbN2qZ5qzOS5OAwj1FJGHZHw2jvobXzIr29c9+K+5RLGc4wZg/PTnffAe4l9vmXYWY43LEM7jIk9rE=
X-Received: by 2002:a1c:bc86:: with SMTP id m128-v6mr6090985wmf.147.1538013295800;
 Wed, 26 Sep 2018 18:54:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:1444:0:0:0:0:0 with HTTP; Wed, 26 Sep 2018 18:54:15
 -0700 (PDT)
In-Reply-To: <CAGQTitMPcrHRhFVLfApe21T7hYyeX05ffuSJj452+f+ZksmQqg@mail.gmail.com>
References: <CAGQTitMPcrHRhFVLfApe21T7hYyeX05ffuSJj452+f+ZksmQqg@mail.gmail.com>
From:   Roel Van de Paar <roel.vandepaar@percona.com>
Date:   Thu, 27 Sep 2018 11:54:15 +1000
Message-ID: <CAGQTitONf2L_p9JQ7oMac+Sw2wdJZg_z2MHucpdf87vvBBgF0g@mail.gmail.com>
Subject: Re: Bug: getcwd: cannot access parent directories
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping :)

On 21 September 2018 at 18:16, Roel Van de Paar
<roel.vandepaar@percona.com> wrote:
>
> [1.] One line summary of the problem:
>
> "cd: error retrieving current directory: getcwd: cannot access parent
> directories: No such file or directory" on move of directories to
> another volume
>
> [2.] Full description of the problem/report:
>
> Example output (testcase below):
>
> /tmp/1/2$ cd ..
> cd: error retrieving current directory: getcwd: cannot access parent
> directories: No such file or directory
> /tmp/1/2/..$ cd ..
> cd: error retrieving current directory: getcwd: cannot access parent
> directories: No such file or directory
> /tmp/1/2/../..$ cd ..
> cd: error retrieving current directory: getcwd: cannot access parent
> directories: No such file or directory
> /tmp/1/2/../../..$ cd ..
> cd: error retrieving current directory: getcwd: cannot access parent
> directories: No such file or directory
> /tmp/1/2/../../../..$ cd ..
> cd: error retrieving current directory: getcwd: cannot access parent
> directories: No such file or directory
> /tmp/1/2/../../../../..$ cd ..
> cd: error retrieving current directory: getcwd: cannot access parent
> directories: No such file or directory
> /tmp/1/2/../../../../../..$ cd ..
> /tmp$
>
> - The number of ".." required is not correct
> - The number of ".." matches the number of subdirs (see below)
>
> [4.] Kernel information
>
> Tested on latest updates of:
> * Ubuntu Xenial
> * Ubuntu Bionic
> * Centos 7
>
> [7.] A small shell script or example program which triggers the
> problem (if possible)
>
> In session 1
>   cd /tmp
>   mkdir -p 1/2
>   cd 1/2
>
> In session 2 (another terminal session)
>   cd /tmp
>   mkdir -p 3/4/5/6/7
>   mv 1 3/4/5/6/7
>   mv 3 /dev/shm   # where /dev/shm is some other disk. /dev/shm
> reproduction works too. If the disk is the same, the issue will not
> show.
>
> Back to session 1
>   cd ..   # fail
>   cd ..   # fail
>   cd ..   # fail
>   cd ..   # fail
>   cd ..   # fail
>   cd ..   # fail
>   cd ..   # works, but to completely incorrect directory given the
> many 'cd ..'```
>
> The problem is made more clear here by using 3/4/5/6/7 but you can
> also just use a single subdir to see it

Roel Van de Paar, Technical Director - Quality Assurance, Percona
