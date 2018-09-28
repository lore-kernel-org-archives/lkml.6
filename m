Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1DB4C004D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71605206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QW8N75DY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71605206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbeI2EaK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 00:30:10 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42168 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbeI2EaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 00:30:10 -0400
Received: by mail-ot1-f68.google.com with SMTP id h26-v6so7459541otl.9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 15:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UZxjDdnYRn7p4x7OGb/hhFGye4/7ZiLeMyVj0Bnlkr4=;
        b=QW8N75DY2GvNWonOXAzgBPNhOcef3CSbBL5QBtMNER3Zkx/Hl7vrgKef+87jI0qOFb
         O8wOf89S4wtKIvWmB9DL2hoySjpHsN9bc1/7vrvQuoGfqG0i2AO6o1QJuRzIgSkIBXyV
         rnq1HnFcRfLr91N+s02A7rVBuGWlaZ51DTlGeobVVf4qtftmqr1PC/k4B2f3DZmt3d2L
         NKdAHlnY/Q1K14kEMpX4tYVUPCO1tSj3SFoEREPXmx1Y8uItbtAS5SKI/BhHKUDmCPta
         +NQ9ltg3qD4PVuuvPoDTWzxpcq36tXtiYut3Jdstf8eumq+toB/vDbKefzAzNGBKaNKt
         3xLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UZxjDdnYRn7p4x7OGb/hhFGye4/7ZiLeMyVj0Bnlkr4=;
        b=Pw92UrKIWGWoLXjr/5vz3vXT05aoRMH3LoANHYV3gBNzfkdpZJiwWDkJcnXnCx+Wy8
         JM2JgTpAZ7q3T79ritwc74mDL35lZbekPhryySWwBtvuQmyImga5HMuwangFVe6vVkZf
         nJgXcsO8EhLjCqD4/N8GxLnLaGuvMLeXH7xyAkTFZY56XqRLElFJE1HRK0fkpoRQxID8
         RrCgAhuvoTuF3SFy286CxMAoEoY5IobV6XSYpJ5TYnWFb/WeASW8tYVkTi9EzoeHm9cb
         cu3Lk8YbhEqpz5sHmxecWNvRdCCc03GxK27XJzWqmtpn0dwIbs/037MPTnMX7PlyIzMb
         EYVA==
X-Gm-Message-State: ABuFfojEPtigKk0qMtiAyKDcPpfUJ7zEvy5oxqjRR0owN6yjMzd4/Rw6
        GR7Myje42NgClG5VlvbiAEzcmXJ122gWrIPOL42HIg==
X-Google-Smtp-Source: ACcGV63KOoqK9k5NUWeKW6scQJ4ydqAUf9TRNVr2sujx+8c96S/kyd5Pk5bGuDSDhFFmaVUcfDQKE3GlLwSsPd3fkBQ=
X-Received: by 2002:a9d:2843:: with SMTP id h3-v6mr382472otd.230.1538172264539;
 Fri, 28 Sep 2018 15:04:24 -0700 (PDT)
MIME-Version: 1.0
References: <20180928215117.28711-1-joe@perches.com>
In-Reply-To: <20180928215117.28711-1-joe@perches.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 28 Sep 2018 15:04:13 -0700
Message-ID: <CAFd5g45HZOA3CGd+g81DDEMw4B67kMbvkC3gkA-ewxhBMtUDcw@mail.gmail.com>
Subject: Re: Bad MAINTAINERS pattern in section 'ARM/NUVOTON NPCM ARCHITECTURE'
To:     joe@perches.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 2:51 PM Joe Perches <joe@perches.com> wrote:
>
> Please fix this defect appropriately.
>
> linux-next MAINTAINERS section:
>
>         1781    ARM/NUVOTON NPCM ARCHITECTURE
>         1782    M:      Avi Fishman <avifishman70@gmail.com>
>         1783    M:      Tomer Maimon <tmaimon77@gmail.com>
>         1784    R:      Patrick Venture <venture@google.com>
>         1785    R:      Nancy Yuen <yuenn@google.com>
>         1786    R:      Brendan Higgins <brendanhiggins@google.com>
>         1787    L:      openbmc@lists.ozlabs.org (moderated for non-subscribers)
>         1788    S:      Supported
>         1789    F:      arch/arm/mach-npcm/
>         1790    F:      arch/arm/boot/dts/nuvoton-npcm*
> -->     1791    F:      include/dt-bindings/clock/nuvoton,npcm7xx-clks.h
>         1792    F:      drivers/*/*npcm*
>         1793    F:      Documentation/devicetree/bindings/*/*npcm*
>         1794    F:      Documentation/devicetree/bindings/*/*/*npcm*
>
> Commit that introduced this:
>
> commit 6a498e06ba22872d3a27cc0dae77b9314b1de48b
>  Author: Brendan Higgins <brendanhiggins@google.com>
>  Date:   Thu Aug 17 09:44:32 2017 -0700
>
>      MAINTAINERS: Add entry for the Nuvoton NPCM architecture
>
>      Add maintainers and reviewers for the Nuvoton NPCM architecture.
>
>      Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
>      Reviewed-by: Tomer Maimon <tmaimon77@gmail.com>
>      Reviewed-by: Avi Fishman <avifishman70@gmail.com>
>      Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
>   MAINTAINERS | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
>
> No commit with include/dt-bindings/clock/nuvoton,npcm7xx-clks.h found

Ah, looks like it should actually be
include/dt-bindings/clock/nuvoton,npcm7xx-clock.h. We probably changed
it in one of the revisions and forgot to update it.

>
