Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E4C7C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 18:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0E572150D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 18:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C/1PbCt8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0E572150D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728221AbeI0A7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 20:59:42 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:38042 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbeI0A7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 20:59:42 -0400
Received: by mail-yw1-f65.google.com with SMTP id d126-v6so4572417ywa.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 11:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BL8NtOowrD3ZGSlvwngGkiFNkbG66vD4gGTEIJ/9mcA=;
        b=C/1PbCt8m92Us+i9aPFo3Veho1sog2g0+FpDDI+5DZzxUFMytyKKCWtR2sGCG/9W3l
         oX071tUDiPCLFiArs7WleOFRlfMx1ML6ci4eXwH3zcGhdzrB7eDuzvs9RDm8fdjKjHFK
         83Sz21c7EFLC8a24dhhq8VPodVRN9J5IfeSWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BL8NtOowrD3ZGSlvwngGkiFNkbG66vD4gGTEIJ/9mcA=;
        b=RSXRiF0aYhPDlbVBzgleaBwlmd0aOKULikWn+eOUlAlEybhltyV3tDgErNIqWy+uIZ
         N4/pmH+hR0q9RifmxMYCBferOwV8Ecasg4kQN8r9gBW3Z0BEA23IOONnQvTCND8vH9Nb
         NOoXF+RdXt3FCoM+7yLh66I+KwcBgTPnsjjw6cho6Cvg3cMaKP+jEKEGPZsEMDS5YxWG
         4gdLNP3W1j0yNVqLdY5vf3A0VltDhU7PzBuzDLowvza1Zgfv2h33u/oTQUtvb4AMrChT
         42U2ec0qhQKDg+W1ixt89LLLhfPKZ7MylTMFQCfDR0q36Th+Wo/2EfteLjy1N5XgNuVj
         +/Vw==
X-Gm-Message-State: ABuFfoifppjqbFSBrTsT8WHmQ7UOC6qS9S1DJsKUnGJ29ovXKliqxKVQ
        4535Jp88VZiYiGG7dsSEobBjU3XlW/A=
X-Google-Smtp-Source: ACcGV63Rpb1+l3tn/7zbwDw0GbEUHtR21YE2l2xEWON7Geq7QIdpsvU/F2kXnC7YvqF0OuRacFKckg==
X-Received: by 2002:a81:1ecf:: with SMTP id e198-v6mr3860613ywe.197.1537987523219;
        Wed, 26 Sep 2018 11:45:23 -0700 (PDT)
Received: from mail-yw1-f44.google.com (mail-yw1-f44.google.com. [209.85.161.44])
        by smtp.gmail.com with ESMTPSA id j8-v6sm3350760ywj.6.2018.09.26.11.45.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 11:45:21 -0700 (PDT)
Received: by mail-yw1-f44.google.com with SMTP id v1-v6so4438043ywv.6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 11:45:20 -0700 (PDT)
X-Received: by 2002:a0d:fec6:: with SMTP id o189-v6mr3281833ywf.237.1537987520322;
 Wed, 26 Sep 2018 11:45:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:ab0a:0:0:0:0:0 with HTTP; Wed, 26 Sep 2018 11:45:19
 -0700 (PDT)
In-Reply-To: <20180926184259.GB14797@kroah.com>
References: <1535220989-27645-1-git-send-email-yamada.masahiro@socionext.com>
 <84cf6ae0-97c8-6b73-ca86-b3d3b3daba5b@pobox.com> <CAKwvOdm7RrGpwk4LMFhsKx=5QMDoFAF8JX=RMZ9YXwOptDfhCg@mail.gmail.com>
 <8d5cf8c6-556a-96a1-610d-c92355783a9f@pobox.com> <CAKwvOdkD0cmF5373LRS92U--ptRvikSrG_oKyE-AiaybCQYMBg@mail.gmail.com>
 <CAKwvOdnyA=Y_+KnJrDc5mu7twTAEOMXvb8cAZhwzsXTi7a9sEA@mail.gmail.com>
 <20180926180019.GD22824@google.com> <CAKwvOd=xYG+r4KU+QurUTyaxkPB2AMane4YfWxuvKtONvVtLxQ@mail.gmail.com>
 <CAGXu5jLBz1YanL5X4HFZjhb8NZe5QK=Q1ySfBkBDNWqEg4hs5g@mail.gmail.com> <20180926184259.GB14797@kroah.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 26 Sep 2018 11:45:19 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJaJ+1Sg3uwaZ8hzw3wFbiLrftpZDO8vdjY9_tB+P-HPQ@mail.gmail.com>
Message-ID: <CAGXu5jJaJ+1Sg3uwaZ8hzw3wFbiLrftpZDO8vdjY9_tB+P-HPQ@mail.gmail.com>
Subject: Re: [PATCH v2] compiler.h: give up __compiletime_assert_fallback()
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Christopher Li <sparse@chrisli.org>,
        Sparse Mailing-list <linux-sparse@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Santos <daniel.santos@pobox.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Jani Nikula <jani.nikula@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 11:42 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
> I'm not digging up a compiler.h patch from a web site and adding it to
> the tree this late in the release cycle.  Especially given that it
> hasn't had any testing anywhere...

Good point about it not living in -next.

Who should be carrying these sorts of patches? In the past it's been
Andrew or Masahiro, yes? For linux-next, maybe it can go via -mm?

-Kees

-- 
Kees Cook
Pixel Security
