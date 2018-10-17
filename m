Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 427B2ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EA7E21526
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:07:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EA7E21526
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbeJQXDV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:03:21 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37759 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727182AbeJQXDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 19:03:20 -0400
Received: by mail-qt1-f193.google.com with SMTP id d14-v6so30379070qto.4;
        Wed, 17 Oct 2018 08:07:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Uu7F1FIUy6q8tufwKSn/3QcWQYkNMcDoUKVw5bIPkR4=;
        b=hq2fSfz6vTYTdxrm7oQdO5LETKLPDU54dHZe07fym6pb5FTEVU2Z35rTHXX0UaOsc1
         NteyBwiVqdTxlQHZoseGi7PnTZO0DJUWldNOih8PNN8slz+EI5UpD2tvcoD8pqJOtROe
         Ew2Ec/hLQ8UlL2R1DIU87cnSe+xduKexRwlEgAU4wX1hgApYp+xUMciIrqqUp9z+7aMK
         P3P8B3YtkR5h9hnFHEWEpuvAWoUB0Tr8U2vNsB1608t8wHpL1nVL0f4De2Rm/sUzTTrE
         ubu8Y3Ab6hNfh9BW1ltQK6RsdkEAgi3X98hsKf5pz8zke840IQcvM1eu5AqasvBcNN/N
         KiXg==
X-Gm-Message-State: ABuFfogHGMKFNbKKbgMwCDrePDcGaPx7CU0zDcE3Waey9JgynMVqtUWA
        zy+B2IHJ1lsOzARtk7nHg/8DTXw3T3AuQcL7rqg=
X-Google-Smtp-Source: ACcGV60OMR3cImgZRXR0FheJqtTQ3XLPKYlH1e35mZgygEWU1gzFbTQOn+59ahu+yDlYA0yvcGt9H6iRe/3jTIcVIHo=
X-Received: by 2002:a0c:881c:: with SMTP id 28mr25572809qvl.40.1539788833205;
 Wed, 17 Oct 2018 08:07:13 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1539655731.git.ren_guo@c-sky.com> <783a90d35138634a1cb899e2c551c96f3b5178af.1539655731.git.ren_guo@c-sky.com>
In-Reply-To: <783a90d35138634a1cb899e2c551c96f3b5178af.1539655731.git.ren_guo@c-sky.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 17 Oct 2018 17:06:56 +0200
Message-ID: <CAK8P3a1ME=1Gb1d_q_+9zP4bLr9wJC7hmEv4KGCt5GN6dG5F8g@mail.gmail.com>
Subject: Re: [PATCH V9 07/21] csky: MMU and page table management
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Miller <davem@davemloft.net>,
        gregkh <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, c-sky_gcc_upstream@c-sky.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 5:01 AM Guo Ren <ren_guo@c-sky.com> wrote:
>
> This patch adds files related to memory management and here is our
> memory-layout:
>
>    Fixmap       : 0xffc02000 – 0xfffff000       (4 MB - 12KB)
>    Pkmap        : 0xff800000 – 0xffc00000       (4 MB)
>    Vmalloc      : 0xf0200000 – 0xff000000       (238 MB)
>    Lowmem       : 0x80000000 – 0xc0000000       (1GB)
>
> abiv1 CPU (CK610) is VIPT cache and it doesn't support highmem.
> abiv2 CPUs are all PIPT cache and they could support highmem.
>
> Lowmem is directly mapped by msa0 & msa1 reg, and we needn't setup
> memory page table for it.
>
> Link:https://lore.kernel.org/lkml/20180518215548.GH17671@n2100.armlinux.org.uk/
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Christoph had all the useful comments on this one, I just checked that I didn't
spot anything beyond that.

      Arnd
