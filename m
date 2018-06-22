Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECBFEC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E671243F8
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nKc4nGlv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E671243F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933594AbeFVOt2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 10:49:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:47328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932819AbeFVOt1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 10:49:27 -0400
Received: from mail-wr0-f182.google.com (mail-wr0-f182.google.com [209.85.128.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8A87243FA
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 14:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529678967;
        bh=hFHhAZjn3CDgO2D1TP231BOAJv/5b3dIUwD4Po92XIA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nKc4nGlvtYDd8v2iXoUpGtp6SNg21XOCXodRguE9d/07KbvG+JvH6/AqmpQsVjtbC
         rmhbxCtld7AUw/VCt2BnuKDBAX+gaFqBIY1lwU/+sAD0SbN1wgwGiSCN1T4eHY5LCT
         /Vr7zVAvI699e5188cta2zBRfx9JjJuRhHup4sHE=
Received: by mail-wr0-f182.google.com with SMTP id l14-v6so1915591wrq.13
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 07:49:26 -0700 (PDT)
X-Gm-Message-State: APt69E1qP0rB8DX8qO4njveHwkLFD3LP5eHQAnnGKXV7FuTY1DsBV4vd
        rEX9b4VN5vkgObxZonJGrFx/wEuAnTCRnNffUEdHgA==
X-Google-Smtp-Source: AAOMgpfAbrF9odZ94siL9qnU2H+LyDWRegx5d1K9x6N2AhDdoj2CUqMpJgXnA9781kjFPCSLcRtHir521KyJPyw2qao=
X-Received: by 2002:adf:b1c2:: with SMTP id r2-v6mr1750804wra.221.1529678965320;
 Fri, 22 Jun 2018 07:49:25 -0700 (PDT)
MIME-Version: 1.0
References: <20180621211754.12757-1-h.peter.anvin@intel.com> <20180621211754.12757-8-h.peter.anvin@intel.com>
In-Reply-To: <20180621211754.12757-8-h.peter.anvin@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 22 Jun 2018 07:49:13 -0700
X-Gmail-Original-Message-ID: <CALCETrVNGjdLv4zde=qz6kJW55yZxXvLqoHxbRpQCr==gW6gBQ@mail.gmail.com>
Message-ID: <CALCETrVNGjdLv4zde=qz6kJW55yZxXvLqoHxbRpQCr==gW6gBQ@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] x86/ldt,ptrace: provide regset access to the LDT
To:     "H. Peter Anvin" <h.peter.anvin@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Lutomirski <luto@kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 2:18 PM H. Peter Anvin, Intel
<h.peter.anvin@intel.com> wrote:
>
> From: "H. Peter Anvin" <hpa@linux.intel.com>
>
> Provide ptrace/regset access to the LDT, if one exists.  This
> interface provides both read and write access. The write code is
> unified with modify_ldt(); the read code doesn't have enough
> similarity so it has been kept made separate.

For this and for the GDT, you've chosen to use struct user_desc as
your format instead of using a native hardware descriptor format.  Any
particular reason why?  If nothing else, it will bloat core files a
bit more than needed.
