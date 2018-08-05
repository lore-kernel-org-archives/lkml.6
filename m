Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D848C46471
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 21:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34FA9219A6
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 21:29:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n77eaP5F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34FA9219A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727625AbeHEXfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 19:35:31 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:45423 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbeHEXfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 19:35:31 -0400
Received: by mail-qt0-f193.google.com with SMTP id y5-v6so11745503qti.12
        for <linux-kernel@vger.kernel.org>; Sun, 05 Aug 2018 14:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=qy3gWjRvhFb858yp0ktt9V/e2qF0xABcPEnwzy4UkQM=;
        b=n77eaP5FfuvsZmAda9ePKocJmpfK2hwtjWEEg0WakYf4Tmn1gVcmi96Qq+YhFrJtM/
         a28L10ryaYPactIHVA7XEybSrwRV2AyjWJcMs5KKE0AiBLKtCtyhcvyRTdsa2s949WC6
         JMZuXv6o1beAtfdUeplNAWMAj4AdnyRulIS51eDGu8gc2MewVQO3naj79EPs3rxkSTKZ
         JceF4yt4ycGqsLZkq0UUSxOJqrqvEqaYoo5mANTfxk6tfVcctHz5VHTb8ydhs9v8Xx95
         fJQOWq7xUxRdCi54+EEetIGW0BGlaHlZF3VMysPj5vOp2nC5QZZoBfBHyLz3fNHpN1eY
         QGjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=qy3gWjRvhFb858yp0ktt9V/e2qF0xABcPEnwzy4UkQM=;
        b=LTV5R7m/SfPiH9hJTAFjQS927MlkYaigh/A9s7WRwAuJU5yI2tk2qQi8RIfs2+9u1P
         Mq5yuhmtsP7j9nOJM89B2+w65h6kdd0gYEWAbdAodaGe0iJf453l/vcrU1VRjEgwgbfo
         IWqtRS7ixxxG4TfqJEF2TwUJ01uI1JhVD9amrlzk2/lsI2Oz7O62rVYh0pTF6FaHRxse
         hI6Mg+MSgXOZr90n/NVCw6GsVT2F+z9sN9+AVb+yOFr9kltE3ZRENEWzGloVcj1GlVjC
         niqK7TKmqj5ETuwEoPq7QEPypjumrAxbgaHftRfnApYnK+w4TmCO1GHBMPMgwXRDUfeY
         EsaA==
X-Gm-Message-State: AOUpUlEKwdt/X6LaKvDKobPErEyhmtdbxZpLXKedxUZJ9l3EYdrx8QiQ
        YMs13CijW07R5ZcQUIF9CBN/Nhi9g2i/xocnMfQ=
X-Google-Smtp-Source: AAOMgpeiT5OOHiE1nrRrH3x1TzJaD6te29mEoNfC27tCYCp58fRBJWmc4w6NQHAwUj+uqNVZqSWz9ef2zW8gtVzxIIg=
X-Received: by 2002:a0c:adf8:: with SMTP id x53-v6mr10962632qvc.19.1533504571136;
 Sun, 05 Aug 2018 14:29:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:967d:0:0:0:0:0 with HTTP; Sun, 5 Aug 2018 14:29:30 -0700 (PDT)
In-Reply-To: <20180803073916.GA19580@infradead.org>
References: <20180707054247.19802-4-deepa.kernel@gmail.com>
 <mhng-ca3e24c4-d59b-491d-a9c5-c8466168b638@palmer-si-x1c4> <20180803073916.GA19580@infradead.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 5 Aug 2018 23:29:30 +0200
X-Google-Sender-Auth: euUnvB5rV_ZI3-TAKftL30KPB8E
Message-ID: <CAK8P3a2i2Por7Xy_7GQEbdOx_CW4jF69MW3VXqc8AnxFjEd4BQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] riscv: Delete asm/compat.h
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Zong Li <zongbox@gmail.com>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-riscv@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 3, 2018 at 9:39 AM, Christoph Hellwig <hch@infradead.org> wrote:
> On Thu, Aug 02, 2018 at 06:26:58PM -0700, Palmer Dabbelt wrote:
>> I thought we were using this to make uname print "riscv64" (or "riscv32")
>> instead of just "riscv"?  Is there another mechanism to do that?
>
> That is set in the UTS_MACHINE variable in arch/riscv/Makefile
> and doesn't involve compat.h at all except when actually implementing
> 32-bit compat on 64 bit, which RISC-V doesn't (at least yet).

Note that the logic was also wrong, if we had an implementation of
CONFIG_COMPAT for arch/riscv, it would always result in the
"riscv64" string for both PER_LINUX and PER_LINUX32, when
it should be "riscv32" for the PER_LINUX32 personaliy.

      Arnd
