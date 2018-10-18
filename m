Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C65ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 11:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4242620645
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 11:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="SkkdHVVW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4242620645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbeJRTu5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 15:50:57 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35480 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727510AbeJRTu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 15:50:57 -0400
Received: by mail-ed1-f66.google.com with SMTP id y19-v6so27941585edd.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 04:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=0/6Vyo1g3saa4jN+EGk4pZ9PCjBMj47nRR0799DVnJU=;
        b=SkkdHVVWhLavR92HwefmddUuqacJu6tYLcDZTi2me+Yjd/C4Bti4yqvaCA1PAHju4I
         LV3BAvFYY5fol2pUE/zAbAsxtriU2Lcp5mf0cCb6OyOnVHgbvVsDM8uiixMth+IT8pO2
         ky2WlpK2auRrenIZUPlk9AdGa5FqPeVcXogNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=0/6Vyo1g3saa4jN+EGk4pZ9PCjBMj47nRR0799DVnJU=;
        b=DP1dcmRFgSrf1s+T869Bye9j9erN6mWIJnP2yXLo56RFEWn2y+0jUkZ0AEXriw2fqa
         xXklf1HsUZSlfHgXHQavtUEUZdscftJOZujjOCO/e3ADB9fYswk8VoX+AOy8W0j0XkUC
         YmCfkJ/wwPOKGvKmoHuKvfZ1Mhy/pHN9K9rFFA1t6dbnqGEVKxYofAILBAgMZUD8ik3h
         5VGA7cKRN6H5xy+2L+lV8tXkogpRAPHeoEs9fARYw+9eroUzK4cG1jf8jNI8iMPfS+ne
         WbRoqY9vyIFGG0CcbGXBun8xfC3i3k2OVGyHdylSAq6t8zkEwsEaxogf55gDIiYG90hs
         Pa2w==
X-Gm-Message-State: ABuFfohzuB6/hWI7vygPj3+Arhx31bg8b5+D0zDXjvGHVaPfNxiy7/Zf
        TDGuGGOAb1SJ0xo1e2DpDBH/7A==
X-Google-Smtp-Source: ACcGV63MLa7pjGR889HrfrnXS0U9UTuILyz0YrAZ2sRyQ2kX2uOf1SatxDFuUyJVqnQK6oOh/qvwrA==
X-Received: by 2002:aa7:d142:: with SMTP id r2-v6mr3346073edo.65.1539863416906;
        Thu, 18 Oct 2018 04:50:16 -0700 (PDT)
Received: from andrea (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id a40-v6sm8482865edd.61.2018.10.18.04.50.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 04:50:16 -0700 (PDT)
Date:   Thu, 18 Oct 2018 13:50:09 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Shuah Khan <shuah@kernel.org>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KVM <kvm@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: manual merge of the kselftest tree with the kvm tree
Message-ID: <20181018115009.GA6819@andrea>
References: <20181018155030.1d75c506@canb.auug.org.au>
 <2e7090d2-5c80-7fcf-6e50-7155280b998a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2e7090d2-5c80-7fcf-6e50-7155280b998a@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Shuah, I think it's best if in the future the
> tools/testing/selftests/kvm/ changes go through my tree, unless they
> affect many selftests subdirectories.

Would the patch below make sense ?

(It wasn't the case of my patch, but you never know... ;D)

Output of get_maintainer.pl on tools/testing/selftests/kvm/:

Before:

Shuah Khan <shuah@kernel.org> (maintainer:KERNEL SELFTEST FRAMEWORK,commit_signer:5/23=22%)
Paolo Bonzini <pbonzini@redhat.com> (commit_signer:20/23=87%,authored:10/23=43%)
Peter Xu <peterx@redhat.com> (commit_signer:4/23=17%,authored:4/23=17%)
Anders Roxell <anders.roxell@linaro.org> (commit_signer:3/23=13%,authored:3/23=13%)
Ken Hofsass <hofsass@google.com> (commit_signer:2/23=9%)
linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
linux-kernel@vger.kernel.org (open list)

After:

Paolo Bonzini <pbonzini@redhat.com> (supporter:KERNEL VIRTUAL MACHINE (KVM))
"Radim Krčmář" <rkrcmar@redhat.com> (supporter:KERNEL VIRTUAL MACHINE (KVM))
Shuah Khan <shuah@kernel.org> (maintainer:KERNEL SELFTEST FRAMEWORK)
kvm@vger.kernel.org (open list:KERNEL VIRTUAL MACHINE (KVM))
linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
linux-kernel@vger.kernel.org (open list)

Cheers,
  Andrea

---
commit 59fc1af0d7d0ae0c1ec9400bfbacaadce11e5f50
Author: Andrea Parri <andrea.parri@amarulasolutions.com>
Date:   Thu Oct 18 13:11:09 2018 +0200

    MAINTAINERS: Add selftests to the KVM entry
    
    Should ensure that Joe random dev will Cc: the KVM maintainers.
    
    Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
    Cc: Paolo Bonzini <pbonzini@redhat.com>
    Cc: "Radim Krčmář" <rkrcmar@redhat.com>
    Cc: Shuah Khan <shuah@kernel.org>

diff --git a/MAINTAINERS b/MAINTAINERS
index 6ac000cc006d1..25755bf6365ee 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7997,6 +7997,7 @@ F:	include/linux/kvm*
 F:	include/kvm/iodev.h
 F:	virt/kvm/*
 F:	tools/kvm/
+F:	tools/testing/selftests/kvm/
 
 KERNEL VIRTUAL MACHINE FOR AMD-V (KVM/amd)
 M:	Joerg Roedel <joro@8bytes.org>
---

> 
> Thanks,
> 
> Paolo
> 



