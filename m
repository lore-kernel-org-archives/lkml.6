Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CEA9C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 17:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B38220866
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 17:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GYMSZYLW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B38220866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729904AbeKFCY4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 21:24:56 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:44893 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729692AbeKFCY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 21:24:56 -0500
Received: by mail-yw1-f67.google.com with SMTP id k6-v6so3928538ywa.11
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 09:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hRoZ+kzOnBGfRkKjLexuTFXVrg3YwVJKB0u8D7I0/4U=;
        b=GYMSZYLWEq38jFxMlSgfIX0UOurbTp8XArE8Fs/zbl2S0mc0YIF1b94m2GlUFQmQsR
         VWbgm7IXb1HKRz9h9kkMJGFqPqLBotqJ3kuAfDgB2rYyBko0022l5svC3Vl6QlgapsNl
         RlduPXAI4lCRSvLgeVIKiNs3jtP+nmt3xvqZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hRoZ+kzOnBGfRkKjLexuTFXVrg3YwVJKB0u8D7I0/4U=;
        b=F42uPNM9aaKVFQGYY0wRKyvcQr0hZ/mx5NMVBI+mKOeehKCz7sclxyGcRpSoJ29qxK
         iMjiUB2BvM+g1EKILqoNZmddqTaBzn90RL/VEfemSCFFlAxZPWk5limYHIWfN4FUGCmm
         6xxVijtxkxJAWqGrEjQwAbUSfMDOnzuMLgcYr1TpZhvmgINiH6r7yEIqdHGJLQkAh23L
         n8B9251h9I/I5deeV/7+J/K9sVUqbPVdo+MAFyd0g2zYb8z8ha5jgZ8CcyO6f3RS3y4a
         O+TmI+3jZVg6DDbIL3C3pku4pRM3tiCT0rNx/JW5qkTve3aPJwwihRB5uo4nXcTCpdyZ
         StRA==
X-Gm-Message-State: AGRZ1gLIEopYJ3tYA7sMsrT9Ls9XsxHvSRTalIiztEYzfTZ9hn7QdGm3
        1VkT4KoxF7cnhOjEWunfNLhJ84icriI=
X-Google-Smtp-Source: AJdET5fTrSCX6/X4FGuom85qhCzivpxWiQU23Zqbn1CnSAiXW+rZK3hrSlnmGLihlmHWzQwfdhtlvA==
X-Received: by 2002:a81:8103:: with SMTP id r3-v6mr2500656ywf.403.1541437457630;
        Mon, 05 Nov 2018 09:04:17 -0800 (PST)
Received: from mail-yw1-f46.google.com (mail-yw1-f46.google.com. [209.85.161.46])
        by smtp.gmail.com with ESMTPSA id e20-v6sm5342544ywe.32.2018.11.05.09.04.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 09:04:15 -0800 (PST)
Received: by mail-yw1-f46.google.com with SMTP id l2-v6so3937475ywb.9
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 09:04:15 -0800 (PST)
X-Received: by 2002:a0d:fec6:: with SMTP id o189-v6mr22383870ywf.237.1541437455114;
 Mon, 05 Nov 2018 09:04:15 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:b906:0:0:0:0:0 with HTTP; Mon, 5 Nov 2018 09:04:13 -0800 (PST)
In-Reply-To: <20181105044217.GB56850@google.com>
References: <20181101235200.28584-1-keescook@chromium.org> <20181101235200.28584-9-keescook@chromium.org>
 <20181102180111.GA14942@google.com> <CAGXu5jLcawCKQL9i6poyJu3v3Ru6VcAXqwa5dxKWQL1Bp+Ai_w@mail.gmail.com>
 <20181105044217.GB56850@google.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 5 Nov 2018 09:04:13 -0800
X-Gmail-Original-Message-ID: <CAGXu5jJzszbMOZAj_K0tfBV-3Rs67_gedHd+RwSXvzY38Fu3dA@mail.gmail.com>
Message-ID: <CAGXu5jJzszbMOZAj_K0tfBV-3Rs67_gedHd+RwSXvzY38Fu3dA@mail.gmail.com>
Subject: Re: [PATCH 8/8] pstore/ram: Correctly calculate usable PRZ bytes
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 4, 2018 at 8:42 PM, Joel Fernandes <joel@joelfernandes.org> wrote:
> Dumping the magic bytes of the non decompressable .enc.z files, I get this
> which shows a valid zlib compressed header:
>
> Something like:
> 48 89 85 54 4d 6f 1a 31
>
> The 0b1000 in the first byte means it is "deflate". The file tool indeed
> successfully shows "zlib compressed data" and I did the math for the header
> and it is indeed valid. So I don't think the data is insane. The buffer has
> enough room because even the very small dumps are not decompressable.

Interesting. So the kernel wouldn't decompress it even though it's the
right algo and untruncated? That seems worth fixing.

> At this point we can park this issue I guess, but a scenario that is still
> broken is:
> Say someone crashes the system on compress algo X and then recompiles with
> compress algo Y, then the decompress would fail no?
>
> One way to fix that is to store the comrpession method in buffer as well,
> then initialize all algorithms at boot and choose the right one in the
> buffer ideally. Otherwise atleast we should print a message saying "buffer is
> encoded with algo X but compression selected is Y" or something. But I agree
> its a very low priority "doctor it hurts if I do this" kind of issue :)

Right, this is fine: if algos change across a kernel version, I'm fine
with it failing. pstore isn't expected to work sanely outside of a
pretty narrow set of use-cases.

-Kees

-- 
Kees Cook
