Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B614C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 13:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6BE9265EF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 13:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="r2bF86Af"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6BE9265EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934381AbeF0N6d (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 09:58:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:49892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754546AbeF0N6b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 09:58:31 -0400
Received: from mail-it0-f50.google.com (mail-it0-f50.google.com [209.85.214.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28753265EF;
        Wed, 27 Jun 2018 13:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530107911;
        bh=xERWcpP6zM34lRZ19g6GJyCDtSfzvxoFbvt9ACzPHjg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=r2bF86AfKtIwVXjwRk+R11EK6aNbIOMaaDPWaYTpIIQ4YWwZq2AeEwAV037TJV8zY
         74BQ0YSD9GjhOn1+A8LiuWzGrhNeg5/IlsP/eOkEr3i6E2nHjC0KK9L7EziwNjuMG+
         zYt/biOgZzEH8l1yyW+WPC9TQ46AMvRsgA36YPlI=
Received: by mail-it0-f50.google.com with SMTP id u4-v6so7687823itg.0;
        Wed, 27 Jun 2018 06:58:31 -0700 (PDT)
X-Gm-Message-State: APt69E1wXDLsibrJLSgKhm8ercXkS/AiTksw88Lwa/FUx+8lKghbYOvb
        +aLklk2/PiBXpbaU0dqFrqvQRCE7bShz/V+mYA==
X-Google-Smtp-Source: AAOMgpeB441o+hQCV5KBP2lGAeJ4OoAix9CnlcMWeAcKzadmUVk/XM7zlEYjwTBM59j4Ow9/5tx3VwkNoRsVL3Mv9oQ=
X-Received: by 2002:a24:798f:: with SMTP id z137-v6mr4744921itc.19.1530107910578;
 Wed, 27 Jun 2018 06:58:30 -0700 (PDT)
MIME-Version: 1.0
References: <20180625140754.GB29102@dhcp22.suse.cz> <CABGGisyVpfYCz7-5AGB-3Ld9hcuikPVk=19xPc1AwffjhsV+kg@mail.gmail.com>
 <20180627101144.GC4291@rapoport-lnx>
In-Reply-To: <20180627101144.GC4291@rapoport-lnx>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 27 Jun 2018 07:58:19 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+evsgh9Qi6FfG4vUZWtpC0UrFjTWSrzukMxY==TD_mrg@mail.gmail.com>
Message-ID: <CAL_Jsq+evsgh9Qi6FfG4vUZWtpC0UrFjTWSrzukMxY==TD_mrg@mail.gmail.com>
Subject: Re: why do we still need bootmem allocator?
To:     rppt@linux.vnet.ibm.com
Cc:     mhocko@kernel.org, linux-mm@kvack.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 4:11 AM Mike Rapoport <rppt@linux.vnet.ibm.com> wrote:
>
> On Mon, Jun 25, 2018 at 10:09:41AM -0600, Rob Herring wrote:
> > On Mon, Jun 25, 2018 at 8:08 AM Michal Hocko <mhocko@kernel.org> wrote:
> > >
> > > Hi,
> > > I am wondering why do we still keep mm/bootmem.c when most architectures
> > > already moved to nobootmem. Is there any fundamental reason why others
> > > cannot or this is just a matter of work?
> >
> > Just because no one has done the work. I did a couple of arches
> > recently (sh, microblaze, and h8300) mainly because I broke them with
> > some DT changes.
>
> I have a patch for alpha nearly ready.
> That leaves m68k and ia64

And c6x, hexagon, mips, nios2, unicore32. Those are all the platforms
which don't select NO_BOOTMEM.

Rob
