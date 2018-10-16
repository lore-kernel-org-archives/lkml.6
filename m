Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A50C5ACCC
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 21:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AA7321477
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 21:26:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IfoqLxG8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AA7321477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbeJQFSr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 01:18:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:49256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725960AbeJQFSq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 01:18:46 -0400
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC3E221477
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 21:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539725189;
        bh=SV2ucstaU1kT2KfMFBNTFXmVizWHrfsz1Fwp5hfbAiM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IfoqLxG8N6RYIML7ot4EDvCqMHdzYi9RfMeVTLf0QsAXZubs4B/6AwnvP8U3khn1M
         b1TVimp9sXsm2YIlwMfDmlVQy9BqbkdH7BJ/omkq2sc8vI53unV+iRp8H2ZsDmmls9
         4mcVL25z5jO7MnYo1OEtwaNgm0ElsuSUvwYRuGlY=
Received: by mail-wr1-f53.google.com with SMTP id l6-v6so26827288wrt.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 14:26:28 -0700 (PDT)
X-Gm-Message-State: ABuFfojAjBUGiG5BgG4OUTuB+tiHrzRKpybzs73FcobNTx9HCAGCTRd9
        FYw8LcogO2KL0FqjeMhXzhtVL5R741nKB23asDl3bA==
X-Google-Smtp-Source: ACcGV61jxBLWlEvRieXOdhVTd66ryvVHaoI1PSQWR3+eVhyUIIuCfPNALyVyCEPtWPJqtZcA/cO5xVAAMFLIVBY0GAQ=
X-Received: by 2002:adf:82e3:: with SMTP id 90-v6mr19457753wrc.131.1539725187159;
 Tue, 16 Oct 2018 14:26:27 -0700 (PDT)
MIME-Version: 1.0
References: <20181016202525.29437-1-bigeasy@linutronix.de> <20181016202525.29437-3-bigeasy@linutronix.de>
In-Reply-To: <20181016202525.29437-3-bigeasy@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 16 Oct 2018 14:26:15 -0700
X-Gmail-Original-Message-ID: <CALCETrV7AjPM3+ROcQYTrGDUDzKp56fJVe_bHJUj1Es7xpn5NA@mail.gmail.com>
Message-ID: <CALCETrV7AjPM3+ROcQYTrGDUDzKp56fJVe_bHJUj1Es7xpn5NA@mail.gmail.com>
Subject: Re: [PATCH 2/3] x86/fpu: Remove second definition of fpu in __fpu__restore_sig()
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 1:25 PM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> Commit c5bedc6847c3b ("x86/fpu: Get rid of PF_USED_MATH usage, convert
> it to fpu->fpstate_active") introduced the `fpu' variable at top of
> __restore_xstate_sig() which now shadows the other definition:

Reviewed-by: Andy Lutomirski <luto@kernel.org>
