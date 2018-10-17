Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3195EECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02CB92150F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:48:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02CB92150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbeJQXoV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:44:21 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43122 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727271AbeJQXoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 19:44:20 -0400
Received: by mail-qt1-f195.google.com with SMTP id q41-v6so30543985qtq.10;
        Wed, 17 Oct 2018 08:48:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jC1YbsIU8B67ApoDDHkD4QR01dIeaSjNNEoL5uw39Ag=;
        b=o36dHCrVTxWsorKSBuVMZa3S8jULpjex3JIkhLZRGcscdoJdpyXQV7NbqLK3e+/yOe
         FWl6+QBLkvdiW0jcwI+kqzAdkFrtBOqKxBAhUSJTuPWlay2hHGPVhG0gQ70TfxldWdOW
         gnhQ331lV2VE0lVo0Gb2eh8hEoP6jpeqtvk0SKGz07GofpDrJg9EwHu+/NR2daIgngns
         Xq/kIjXwGvtU9Pm9IgY3BrMlIgNP1MAKB1pcaH8cwMQICteOU+OZT1jStNOOiVj9THxp
         o/LNnpdEG0MrwOFwHOmvOGWz7Fz2pcZuu064334MN6drQJ0Vhb8AsWNMRGyKSFwGa9Z/
         DXew==
X-Gm-Message-State: ABuFfojyRmHhxJNRaIpF1Z5IAN3U7z1pM8Kjb/dqBCxcipEC30dp4y7i
        z3XpvCPN0nOw2CU1NechBeVPJbPmPAswzh58ohk=
X-Google-Smtp-Source: ACcGV61BE+XTrTI9kH3AsSthZ4dqiye5qsMKTTXUTKPkcnDWjjD5f+SgJ+AQeP2ltb4YuI+visJleAw3+mO6wA9TByc=
X-Received: by 2002:a0c:9e6e:: with SMTP id z46mr19969583qve.180.1539791282110;
 Wed, 17 Oct 2018 08:48:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1539655731.git.ren_guo@c-sky.com> <4fca35ebfae9208ed6117bbe41c863a33730681e.1539655732.git.ren_guo@c-sky.com>
In-Reply-To: <4fca35ebfae9208ed6117bbe41c863a33730681e.1539655732.git.ren_guo@c-sky.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 17 Oct 2018 17:47:46 +0200
Message-ID: <CAK8P3a3nnFP_=u7Z-WeBr0kE07BCsaD=mVtG3Qm2zzPpH4RCqQ@mail.gmail.com>
Subject: Re: [PATCH V9 16/21] csky: SMP support
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 5:09 AM Guo Ren <ren_guo@c-sky.com> wrote:
>
> This patch adds boot, ipi, hotplug codes for SMP.
>
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
