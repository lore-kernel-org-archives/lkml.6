Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 5BBEEC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 04:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07A4E20693
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 04:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HsmxY+a2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07A4E20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754481AbeFMExD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 00:53:03 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:44421 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754327AbeFMExC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 00:53:02 -0400
Received: by mail-io0-f171.google.com with SMTP id g7-v6so2023594ioh.11;
        Tue, 12 Jun 2018 21:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YVhLBNR2SQaQHLca/dEjGjH/lW4oBwf9TStHsN6oRu0=;
        b=HsmxY+a2dMhssSQNNDt4e+7zu9e04sAz0V7Dj9fbQivfd18iLk8iQqv8uCN94HnV+V
         vtAtEq4M3wZXR87/7BgbIo5rmyjjm+4x6uG6Itn/J2EHfUV9FjMYfSFsFioUODN6T8z+
         vIFYa92hYiKhbrJhUEMDj9oE3H2XyaYaoPf5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YVhLBNR2SQaQHLca/dEjGjH/lW4oBwf9TStHsN6oRu0=;
        b=Enm8pPaZS/sEw3sDrUVyEQiQJN/5x9FCQ6LlRK0Gr4H0FqUaE1gXITYSSvxgzU9AqQ
         +0/418zhFNds7t8i/0k1pm1Qk1JuV1t+gDVHc9gTCbnermmomUBT6DpDw9wFVU+QcWfW
         Fix1O6gsQtCNvYaRTsmbvYgxuIqKexk1z5gRKYRWGWGxGAeefFHdWVf8Tmt5/joYSEAM
         4qXoCndR5NyDEGwmYFaJ1ZtkyXJKDaPvPij9dwhYMXVdmXoHhDbP6v2MWuMBvHB11RVY
         woX9E28pIA8afNRIzJ/gWSszPw6TzTWD/SOhxaQnC3RNuUxdGLDpvtCZz8Q/Q4lFlaCO
         4QEw==
X-Gm-Message-State: APt69E3nM0vPZ6lGXavsB2yKh7D8GOKg3w7VTXrHwBMsr2uwUU0PG45r
        r588H5HKmjQgbNvGNKbJHiqdldQQ9gz8DcWYA6w=
X-Google-Smtp-Source: ADUXVKLz12qQ15jN2Qvf0EFKLtV8ROiM3fBM3yC3YHog+7LTKdizHTiDosA5Zxb63q06SvSAzuphLjO3R8niELnH/Z8=
X-Received: by 2002:a6b:f90b:: with SMTP id j11-v6mr3410845iog.238.1528865581422;
 Tue, 12 Jun 2018 21:53:01 -0700 (PDT)
MIME-Version: 1.0
References: <1528812229-53043-1-git-send-email-pbonzini@redhat.com>
 <CA+55aFwvE5G7MV7AV4naAXdbFoszc4JNKEj_QtYqpLFfa2RXtA@mail.gmail.com>
 <CA+55aFza9udpsCY=_YuBoshgVoXSce-Ja-nsqRbm5eJ6MgXK1g@mail.gmail.com>
 <CANRm+Cx194zWU0TwoiCaiTy+3tuHp4Ki1mk2VUfv5-z00j23jA@mail.gmail.com>
 <CA+55aFywZ0aX6u-JO8=GciDm9stwXOmXU4oG-u0K8i+o3qLwvg@mail.gmail.com>
 <CA+55aFxZNyHoytCNV89tPP0TWEiR_-nOja-HA5i4zY446VFCVA@mail.gmail.com>
 <CA+55aFw3a1j1GCTtf2C2bDML13G9aZ=bT2ysmXY7=fnHJups2w@mail.gmail.com> <20180613044840.GA669@kroah.com>
In-Reply-To: <20180613044840.GA669@kroah.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 12 Jun 2018 21:52:50 -0700
Message-ID: <CA+55aFxogs_+6E-1HWr8L6Go4j0rQPK2Sk7qkSCMnq_18g-+2A@mail.gmail.com>
Subject: Re: [GIT PULL] KVM changes for 4.18 merge window
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Wanpeng Li <kernellwp@gmail.com>,
        Thomas-Mich Richter <tmricht@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KVM list <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 9:49 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> The revert is fine, I'll work on the kvm debugfs file stuff for 4.19.

Yeah,  I did two fairly brute-force fixes for two different issues
(the only common thread was kvm - testing the first fix was what then
got me to the debugfs revert).

I'm going to be start traveling towards Japan and China tomorrow
morning, so I wanted to just get the problems I noticed out of my
tree. Both of the two top commits in my tree probably have better more
targeted fixes eventually.

            Linus
