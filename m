Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A44D7C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DFAD2084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:05:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DFAD2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbeJDT6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 15:58:45 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:40441 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727336AbeJDT6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 15:58:45 -0400
Received: by mail-vs1-f67.google.com with SMTP id z130-v6so5297735vsc.7
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 06:05:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fgAFcsqmUdDZPswJ7PWWrvK7N/zPPnmFVWzJCMfQHpM=;
        b=n9qBeSEDOQBR2rEmAuAyWnYNZ93HhCAOWZvlzAoRZ2O6P+KPoej0dNkRoUNd83vt0R
         slqq7yo1FfyBMYyevLY13+O8Gzg6LUC8mgApVFyfWjuAzeoAM2NBh2G6akHr8RiTcUcz
         CJvibECBOyzbn8HJRjryHAxahSPz9BMVM6ZNEf+sjMIho6f72dXB+ZAp3aY2723abAiX
         /uiSXRD/7tj0pJqqj5D5qN87PPZe68B84tqeANYlWeIseJu81mwwZPytdireF9I33Au6
         aq+D6BW+I4+bCyfcgnCjxFVp1QDRrrKEZ5hJm4yIn7mHRaP/zC+BfRY7ZvFFNCq5Ql0J
         uWzQ==
X-Gm-Message-State: ABuFfohCSQBH6QGl3w16uU0YYvRDiI0hAkFeLPUfK50P9bxiBDY/GuBz
        BK93bEAQdL+myvOxfnt8dO6qGTKupiH/emQUdHs=
X-Google-Smtp-Source: ACcGV63AnI4JW5Cf6kDcAd4RwIpjDmNoCi4IQwQKFeGQFzF53APjsEzOkmFMVo2R5NI4r9gXyGSzAmS9VBDu7oK3KQE=
X-Received: by 2002:a67:f3cc:: with SMTP id j12mr1820590vsn.96.1538658332130;
 Thu, 04 Oct 2018 06:05:32 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1536709753.git.fthain@telegraphics.com.au> <7a0748d8cd97964a99879a0b9f1c0243c677c7c3.1536709753.git.fthain@telegraphics.com.au>
In-Reply-To: <7a0748d8cd97964a99879a0b9f1c0243c677c7c3.1536709753.git.fthain@telegraphics.com.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 4 Oct 2018 15:05:20 +0200
Message-ID: <CAMuHMdVRgo7LCubwXUtv9s8e4U8ROdOWqSWeaKigS9QLPtYX8A@mail.gmail.com>
Subject: Re: [PATCH 1/7] macintosh: Use common code to access RTC
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 2:18 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> Now that the 68k Mac port has adopted the via-pmu driver, the same RTC
> code can be shared between m68k and powerpc. Replace duplicated code in
> arch/powerpc and arch/m68k with common RTC accessors for Cuda and PMU.
>
> Drop the problematic WARN_ON which was introduced in commit 22db552b50fa
> ("powerpc/powermac: Fix rtc read/write functions").
>
> Tested-by: Stan Johnson <userm57@yahoo.com>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
