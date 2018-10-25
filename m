Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C9AC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 20:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C4122054F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 20:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EpkZecDS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C4122054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbeJZFHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 01:07:20 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39075 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbeJZFHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 01:07:20 -0400
Received: by mail-lf1-f67.google.com with SMTP id p11-v6so7816729lfc.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 13:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M3F1HmxSHrZUW1vm0fTyKVjpWBWe8A501fSMloOg8qQ=;
        b=EpkZecDSFQ+JZNVSHb3xyzdcKuwr7rlMkF0wv4M5YXLF2SbogKgBwJp4R4+cr3qbuz
         fDrd/l8PpRHkJ1SWvukmKtC46JBpqXyLd0GRpkijfgqlGDfQLQNI7EoefkrepUUTXERG
         1y1IP496C+bD6pjpMHEXdJ5B4yb1ZK9ml1zzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M3F1HmxSHrZUW1vm0fTyKVjpWBWe8A501fSMloOg8qQ=;
        b=G+EJZM3hDVFAJhlXjBhecvFNKrTLBm7phD57+4eNCwzRkCorEU4xgz86UhOtFWo7Sw
         Pm2sNSo8VScRG/AMmZeX5jD0r0eP3rWGvUnXr7UpI82Gd9eaYCW1iOTt1tOn6Deop+Bt
         L/LDBzuGJty6xKAdqphajkPT+9RHoDsdvoyRc9+grmVRDTn9i+ixSwOMCJYBriDNu8Th
         5te2BtRMn7YSTgvCi9coO6/gsoy7XAiIxXZ2TSBqck+00jAhJv2v9+8EFDpRikvjN/Kx
         YzWevi8fpTsxpOD41JcQBY9woO/Tdxom/hs0loZIehzGSdWQ+e2nv+IY2qm3HLGwo/uR
         eKvQ==
X-Gm-Message-State: AGRZ1gJit7vxX5du817ZVr2D+EiLnsXc9CBbwrZReMeRncqlBpTVUYP4
        jTc0+r5AapdlVEgpj9JFHVJtnWA5VajJQQ==
X-Google-Smtp-Source: AJdET5eY6xNuOpaSa9RWg5n4rczf1r+i/Z3zsAqibNP/meATkAoJVFOzzYLhjr543ele2FCkNo0+rw==
X-Received: by 2002:a19:c650:: with SMTP id w77mr458868lff.56.1540499584680;
        Thu, 25 Oct 2018 13:33:04 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id h21sm544245lfk.41.2018.10.25.13.33.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 13:33:04 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id c4-v6so9495878lja.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 13:33:03 -0700 (PDT)
X-Received: by 2002:a2e:95c6:: with SMTP id y6-v6mr445405ljh.59.1540499583375;
 Thu, 25 Oct 2018 13:33:03 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.21.1810252038150.30470@namei.org>
In-Reply-To: <alpine.LRH.2.21.1810252038150.30470@namei.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 25 Oct 2018 13:32:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgaCGkKadx3+C8RVRdA33kRMPH+7DYSm1VcetBc47CJ7g@mail.gmail.com>
Message-ID: <CAHk-=wgaCGkKadx3+C8RVRdA33kRMPH+7DYSm1VcetBc47CJ7g@mail.gmail.com>
Subject: Re: [GIT PULL] security: LoadPin changes for v4.20
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 2:39 AM James Morris <jmorris@namei.org> wrote:
>
> From Kees: "This is a small reporting improvement and the param change
> needed for the ordering series (but since the loadpin change is desired
> and separable, I'm putting it here)."

Pulled,

                Linus
