Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE05C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 631942088E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jHDzzR9/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 631942088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbeH1VAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 17:00:17 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:42539 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbeH1VAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 17:00:17 -0400
Received: by mail-qk0-f195.google.com with SMTP id g13-v6so1475029qki.9;
        Tue, 28 Aug 2018 10:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I+hfl8A7XAf2dcQF6lGsrdzsiarpU7+OZ7DnngWMqSg=;
        b=jHDzzR9/Na2VFCYZpsjkQduRXqrcNDrK6s+243E4Q2gXPE5UCOaTV6EgxzEjb1oREm
         7BwcY/9tykVhtfHeJHZZRqHqRMLcJNHGL811eXxd+7lN5nQb8Zp8zAMyr3md0RBSdgqi
         LqlXbJDPU44QT5OjOJmc0w8S7rD36Syh+AN/wpbEotPU0Otkodjb9ZJ2MyWK3oqZrbiB
         fqpVbxckf0vZ19jwClJ0JW+HQ4GyE0l0PGlFXXN2uyWgTO4E4Eur5ig5TZSUYjI0yFmT
         pYtt+vocVdT3FJZ1u194K6QpZ7WR1jvU+qd/y+p8nQZxrgjdrnG3g+pauRVQ1+9uFUpK
         5B7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I+hfl8A7XAf2dcQF6lGsrdzsiarpU7+OZ7DnngWMqSg=;
        b=M308zQ/Q/5BX9qgBvcU3o/DrxTxurfzhv0ZjHkFyc1Vjachs7M6PFmm41ztI7tS4mV
         fssqzC1j8hamp+YtUtBolnua9a7B9e3L/li0JFU92ByuGPy2xUjZGeS5MhjQ5evpodff
         3NcJL4phJqfx8GYQt0rmETGWxBg+rgySu9fNLdw1nUPujaq6ovPiI+f1zydXNB5n8Wzd
         Pbzcga0CHfVWWyIjnaTGWdRTvCtQF4hR58UVZqefTO0sbxHzPUseNk2N/JTc52agfpjQ
         pBDZ3ycYeSaeCsDH0Ca+G6dC1cwSSNKp2fnSlXXsU6KXYAy3urJ7niF8cfk0L+aEv4ws
         M3dg==
X-Gm-Message-State: APzg51CVHL+XHBCjx3I5Lrj0uId3sfy/jkvNkF5vJDLCgo6ghYfhxynx
        o85wMrJZZWDgX2eLnHEqD1f2S0AzF5mTv3E1dZ4=
X-Google-Smtp-Source: ANB0VdZGSOJjwxa+PFktZI8WQ6vp8+b195gBJ8kjNTUCwsE58zc/ZTksFKFEuKbFtYicU+DRDJtBu7jFwZP70UFDDDc=
X-Received: by 2002:ae9:e50d:: with SMTP id w13-v6mr2538128qkf.137.1535476061640;
 Tue, 28 Aug 2018 10:07:41 -0700 (PDT)
MIME-Version: 1.0
References: <20180828142421.15335-1-semen.protsenko@linaro.org>
 <20180828142421.15335-2-semen.protsenko@linaro.org> <CAHp75VdiRH_J8QUALDNufdWh0eNnKsTmp5q+RGBassFdMcpEmw@mail.gmail.com>
In-Reply-To: <CAHp75VdiRH_J8QUALDNufdWh0eNnKsTmp5q+RGBassFdMcpEmw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 28 Aug 2018 20:07:30 +0300
Message-ID: <CAHp75Vfa0Hmv+22gC4AZ18r=fehv2eV9wJsvXG+2imsbMdkOHA@mail.gmail.com>
Subject: Re: [PATCH 1/2] codafs: Fix build using bare-metal toolchain
To:     Sam Protsenko <semen.protsenko@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        codalist@coda.cs.cmu.edu, coda@cs.cmu.edu, jaharkes@cs.cmu.edu,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Praneeth Bajjuri <praneeth@ti.com>, paul.sokolovsky@linaro.org,
        mszeredi@suse.cz, sumit.semwal@linaro.org,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 8:03 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:

> P.S. Actually it's the only header which uses KERNEL in UAPI.
> Definitely it should be fixed first.

Okay, it seems I missed __ parts. So, my statement above is wrong.

-- 
With Best Regards,
Andy Shevchenko
