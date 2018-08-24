Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1371C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 20:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F80121523
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 20:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="arUUkACm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F80121523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbeHXXu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 19:50:26 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:34042 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbeHXXu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 19:50:26 -0400
Received: by mail-it0-f65.google.com with SMTP id x79-v6so6149490ita.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 13:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rbBEAO3XSnzwVOgGNyIT6iir8KKYRCVKkvMMhdlRCzw=;
        b=arUUkACmbXBPBeaO6wp0id4mJ7MesD5IkYIPEaa1yIhbFnFEWADUqIQ24lV5xVRMcv
         2tLDYGn/rPf9FxrgSi+IKboiVFpJsCj9ewKBxv2SnK0vbG9hSpPbdBFG4Ra3oXtkTIn4
         rA87mZdj8+b8V7uDQEIShJvtHjg8+y6bfevLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rbBEAO3XSnzwVOgGNyIT6iir8KKYRCVKkvMMhdlRCzw=;
        b=VolgQM34A1x2m780oVYHGGablRMi6O5sq7UPlPYI+pijwkfxt7K5OoH4RgBFHcWXjq
         FnZcvxep+kbBipCnjyc7dDEMh46Tp+KlsKPN0LnLcOUMDD7yaOtIwPs8X0dNRm2z/Q38
         cErUy92lez2d/0VIDSfA/lq5yh0Vsn1Np2t7JP+dlp1Oih4vdLUkSZdkj4XU1etv8GPN
         hOFKegHwfpb9lgFbOR9b8h9EXxdw+TCLxyMn/wlck1bKYvsLas8wARAvRqw6qqpgAJMu
         AZW2GNozC5/Sxj5s2LgEiEtmp7MHnh/P0rIa8r6Hu3ik4C4qQwKAjxbAWywacISJgChH
         hU1g==
X-Gm-Message-State: APzg51Bq6oNrBFapJlq4C45awxchLAf8xucXY87RduRKDauzNU3QIbIJ
        M0YVHHRs+MlchQUxWpJLbCYg/OWCuIn6tsOJkKg19oji
X-Google-Smtp-Source: ANB0VdYkkpDcPBA4YJ2l44kII+zUvkmPP/IoKeQHJ0s2VDHiVl92/14vyWNsvuxEqYd82Tf3ZhFRqJkqcFt2R/R6Gs8=
X-Received: by 2002:a24:8309:: with SMTP id d9-v6mr2591602ite.123.1535141658054;
 Fri, 24 Aug 2018 13:14:18 -0700 (PDT)
MIME-Version: 1.0
References: <20180824130120.lwv5bklvv64hjsde@8bytes.org>
In-Reply-To: <20180824130120.lwv5bklvv64hjsde@8bytes.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 24 Aug 2018 13:14:07 -0700
Message-ID: <CA+55aFz08bncAD=Q_1NO87YO_z9rTkUShSZ0V2wCMRSNY_WH4w@mail.gmail.com>
Subject: Re: [git pull] IOMMU Updates for Linux v4.19
To:     Joerg Roedel <joro@8bytes.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Simon Horman <horms+renesas@verge.net.au>,
        Magnus Damm <damm+renesas@opensource.se>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 6:01 AM Joerg Roedel <joro@8bytes.org> wrote:
>
> note that this time there is a trivial conflict when merging this into
> your tree. The conflict is in drivers/iommu/ipmmu-vmsa.c, apparently
> some other tree also added DT matching entries there.

No, the IOMMU_OF_DECLARE() thing went away entirely, so my merge
removes the entries your branch added..

They should be unnecessary, but I obviously can't test that driver, so
people should check that out.

           Linus
