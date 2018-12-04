Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC401C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7651C20834
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SsBlkpgR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7651C20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbeLDWtJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 17:49:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:34866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbeLDWtI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 17:49:08 -0500
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C565F21536
        for <linux-kernel@vger.kernel.org>; Tue,  4 Dec 2018 22:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543963748;
        bh=ztUp3EinOQeSraOdY6FGlSvGGk56x+vAUQ9gFEYbNu0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SsBlkpgRQ7nJpHa/Gbe7xyx1JrBWDZp2flvM3DDXptyc3HS/R7tirutJURCnsb/EI
         7szZZ6Tt7KN4I36iaTxIfZxWrSX2iPfkbbsul36C9NeCWMkXvtUFrsrEf5KAdSuJYU
         GUeXPlMSJTcizl7VpRY9uJSz8aZHx+cGqELTFe4U=
Received: by mail-wm1-f44.google.com with SMTP id y1so11244080wmi.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 14:49:07 -0800 (PST)
X-Gm-Message-State: AA+aEWZfVpa2bidgH3CLAyGTGc1CtjjVpX9O5m/Mw2h/Ouy8yne8uC4U
        KftL4kH1HrYADVGTxFGp4pwD335mUPgTUctv10xJtQ==
X-Google-Smtp-Source: AFSGD/UKm5rpcjYihabSMG/vtIjd2VriejlvW2WRnFhHV2ao2kSuKPafy/o2igrrxSdJ62Q9Yc2FAnx3CG+iZcy8eAI=
X-Received: by 2002:a1c:864f:: with SMTP id i76mr10013452wmd.83.1543963746212;
 Tue, 04 Dec 2018 14:49:06 -0800 (PST)
MIME-Version: 1.0
References: <20181204212600.28090-1-sean.j.christopherson@intel.com> <20181204212600.28090-2-sean.j.christopherson@intel.com>
In-Reply-To: <20181204212600.28090-2-sean.j.christopherson@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 4 Dec 2018 14:48:54 -0800
X-Gmail-Original-Message-ID: <CALCETrVZraOwkdjtVLdOk4+t4Z0i6ThcWzjK5pjee1djS8CD9w@mail.gmail.com>
Message-ID: <CALCETrVZraOwkdjtVLdOk4+t4Z0i6ThcWzjK5pjee1djS8CD9w@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] x86/vdso: Remove obsolete "fake section table" reservation
To:     "Christopherson, Sean J" <sean.j.christopherson@intel.com>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 4, 2018 at 1:26 PM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> At one point the vDSO image was manually stripped down by vdso2c in an
> attempt to minimize the size of the image mapped into userspace.  Part
> of that stripping process involved building a fake section table so as
> not to break userspace processes that parse the section table.  Memory
> for the fake section table was reserved in the .rodata section so that
> vdso2c could simply copy the entire PT_LOAD segment into the userspace
> image after building the fake table.
>
> Eventually, the entire fake section table approach was dropped in favor
> of stripping the vdso "the old fashioned way", i.e. via objdump -S.
> But, the reservation in .rodata for the fake table was left behind.
> Remove the reserveration along with a few other related defines and
> section entries.
>
> Removing the fake section table placeholder zaps a whopping 0x340 bytes
> from the 64-bit vDSO image, which drops the current image's size to
> under 4k, i.e. reduces the effective size of the userspace vDSO mapping
> by a full page.

Acked-by: Andy Lutomirski <luto@kernel.org>
