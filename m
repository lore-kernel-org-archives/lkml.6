Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33EFCC64EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 07:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0080208E7
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 07:50:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SNJMH9Gt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0080208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbeJFOwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 10:52:38 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39318 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727588AbeJFOwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 10:52:38 -0400
Received: by mail-lf1-f68.google.com with SMTP id w21-v6so10854882lff.6
        for <linux-kernel@vger.kernel.org>; Sat, 06 Oct 2018 00:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WTOYmd5AgS5XLIdUuV4WJcdPN9WTM8YF8DHf2OEN+eg=;
        b=SNJMH9Gtz4wR7/jRzfs++V5jSBpWL82F/T55dVDUDkx5PRc0tKpqxK1TnZqqnbE/4X
         Uigb/CIPXwX+HQnioqVDSaXwGPmHKHkP2RDQIqrXrXcC43kUy9XN8J18WunNpudpTP2Z
         6jS2X3NHcAxaO/I6h/BiAQOiHAsz4gXVXUP1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WTOYmd5AgS5XLIdUuV4WJcdPN9WTM8YF8DHf2OEN+eg=;
        b=t9qHQ3NBwhZx2mmjAcPwfQETLiGABU51JFriTtsAh3oI5egb8hshmOEBssH1OACwg/
         exO2VpycB41LJyTOW3qVOg4AxEq072QtR9K51cTIkKzHmbFrYk9hhCiMuBMgJAEiUfGv
         6+36hdz7H2sjMyHTASPn+hNYqTOmSBGv+29OmgdNL5LbxMyRK1087n2wIH9v+Nex+NVz
         96CWKHjMrHkNxbmpTE7jIlaP4N9keDqS/ghgLBBr5afvJ/dKBQbVjWpXCSr6bvifjBrL
         1Uuk3Q2s8dNUSeGHf+W3JeBHsKyuYBvU8tjDdIX4uKijEcj0lmAtFgevuk98dt/HOSeI
         /WDg==
X-Gm-Message-State: ABuFfoh464+iOnGC11mE35nMQNfGjS29qcz5zFReP5oSwrUNYz/We7A+
        31mNZ81PkB5o8/RRnMnraYr92jrCbCIxA5rWRsiO5Q==
X-Google-Smtp-Source: ACcGV63W8dIKKFc7MdO/nT/fOr430i9Eeu459+sq6KDWye9lo9cedwlk4XjUfMDcByMopQkiEDDEMcEs1s8HYDCdfVg=
X-Received: by 2002:a19:735d:: with SMTP id o90-v6mr8730585lfc.45.1538812217785;
 Sat, 06 Oct 2018 00:50:17 -0700 (PDT)
MIME-Version: 1.0
References: <20181005161722.904274-1-arnd@arndb.de>
In-Reply-To: <20181005161722.904274-1-arnd@arndb.de>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 6 Oct 2018 00:50:05 -0700
Message-ID: <CA+G9fYs-z-CQ+HgFcosYsNphAmU2rG56PTFqO48T-pZ_63Ujuw@mail.gmail.com>
Subject: Re: [PATCH] hugetlb: fix ARM 3level page tables
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>, alex@ghiti.fr,
        lcapitulino@redhat.com, mike.kravetz@oracle.com,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-arm-kernel@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd,

On Fri, 5 Oct 2018 at 09:17, Arnd Bergmann <arnd@arndb.de> wrote:
>
> The check for __HAVE_ARCH_HUGE_PTEP_GET comes before the definition,
> leading to an extraneous definition of huge_ptep_get:
>
> In file included from arch/arm/include/asm/hugetlb.h:28,
>                  from include/linux/hugetlb.h:456,
>                  from arch/arm/kvm/../../../virt/kvm/arm/mmu.c:22:
> arch/arm/include/asm/hugetlb-3level.h:33:21: error: redefinition of 'huge_ptep_get'
>  static inline pte_t huge_ptep_get(pte_t *ptep)
>
> Change the header file inclusions to be in the correct order for
> this to work.
>
> Fixes: bb1d18ffc7ae ("hugetlb: introduce generic version of huge_ptep_get")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I have noticed this build error on linux next tree for arm32 build.
Thanks for the fix.

- Naresh
