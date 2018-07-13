Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B019ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 23:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2D09208A6
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 23:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="baKdAZjM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2D09208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731402AbeGMXfr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 19:35:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:37538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729214AbeGMXfr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 19:35:47 -0400
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14D5C208D5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 23:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531523942;
        bh=IP8NI/xlTn59PxQeQnaZtXoIztecsi8G0JHpjRadcsw=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=baKdAZjMZXzKh1lwztVNdCFASeuc80mDQs52l57g27zdSirz/TrRoc0WSXXCU3KZY
         WQl/rs10E6xYZpfekWevPtjICtF7N01D+IaFMs/CX0WPgCQmS6Cr7GwkOX2bcIoTgF
         w2SbNoZy5p1rQwuiuuMCjD+u87V16fo6Q/xdp0NM=
Received: by mail-wr1-f52.google.com with SMTP id h10-v6so26533409wre.6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 16:19:02 -0700 (PDT)
X-Gm-Message-State: AOUpUlFCOotAfX3jcdle+kKN8m0C6xrLFfCtBPNjVQU9VsccvSzft+dI
        qojTWujWc3uvNdk7wT8CK5NHg/BDmR6d8cJF2+dVIQ==
X-Google-Smtp-Source: AAOMgpeO0Zgs1u7MZqNIZTGxEP9VTjwPrkjlUxo48Qhyy0CRR2pVe2hTfXpN00IIuzjaoO4LD/BldVRdFrikFqXPezA=
X-Received: by 2002:adf:8062:: with SMTP id 89-v6mr5758643wrk.221.1531523940599;
 Fri, 13 Jul 2018 16:19:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:d548:0:0:0:0:0 with HTTP; Fri, 13 Jul 2018 16:18:40
 -0700 (PDT)
In-Reply-To: <1531308586-29340-36-git-send-email-joro@8bytes.org>
References: <1531308586-29340-1-git-send-email-joro@8bytes.org> <1531308586-29340-36-git-send-email-joro@8bytes.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 13 Jul 2018 16:18:40 -0700
X-Gmail-Original-Message-ID: <CALCETrWfA_PBmb1V3H5=4vd-w5qPpSpfR+FvgFc+naH7e3u=1g@mail.gmail.com>
Message-ID: <CALCETrWfA_PBmb1V3H5=4vd-w5qPpSpfR+FvgFc+naH7e3u=1g@mail.gmail.com>
Subject: Re: [PATCH 35/39] x86/ldt: Split out sanity check in map_ldt_struct()
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Brian Gerst <brgerst@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Eduardo Valentin <eduval@amazon.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>,
        "Liguori, Anthony" <aliguori@amazon.com>,
        Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
        Hugh Dickins <hughd@google.com>,
        Kees Cook <keescook@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        "David H . Gutteridge" <dhgutteridge@sympatico.ca>,
        Joerg Roedel <jroedel@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 4:29 AM, Joerg Roedel <joro@8bytes.org> wrote:
> From: Joerg Roedel <jroedel@suse.de>
>
> This splits out the mapping sanity check and the actual
> mapping of the LDT to user-space from the map_ldt_struct()
> function in a way so that it is re-usable for PAE paging.
>

Reviewed-by: Andy Lutomirski <luto@kernel.org>
