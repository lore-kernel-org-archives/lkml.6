Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA8BAC28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 22:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 581E920883
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 22:38:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCISPptz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 581E920883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388827AbeGXXrT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 19:47:19 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34336 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388506AbeGXXrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 19:47:19 -0400
Received: by mail-ed1-f68.google.com with SMTP id h1-v6so5470142eds.1;
        Tue, 24 Jul 2018 15:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AGwM+b4ByJc3z7IVVWCb7kuYSh5j+h0iU5jrcUqG+tY=;
        b=GCISPptzyBcoEKyiqZ97mT4EJah1N/LqVoLgJI43ohizP2NohfMQEPjRBvs1j7lpja
         1TdAcifL11CTiTiC8RbI/tDPAOv66CNbQ/rOPMnTd4HCkzFqxK2Urv97c4FSp8/o2NJN
         rV/A5/HyDJpZ6x1RGv4fP/rKtVO6mnol/dBHM8cYggufRXz44v7zYG57d1jnCv9UrltG
         aa/2Vx8xkW0e2CI034ZC881GGPMC7Neu+l7IKVeCfn2QQnpIxrc2tk6WfGzjQf7PjaP6
         EJjBPOwi2c5ftSNZG+Do+E6hOjKKDfSQNA9xzWipaF3w9RMB6CaGGHyc5FdBqot5eUoy
         LQUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AGwM+b4ByJc3z7IVVWCb7kuYSh5j+h0iU5jrcUqG+tY=;
        b=WR6hAzYlaIgVQ3qznHIUv5Fwoq/HnWAsAzn3MMfN2htfZemaf0acI/A/LXeOWBcdUg
         HFvd1g4RbWdwoiN1EEECCvbyL7/+U9DHG66fQWprA4B1Ai5thtXKFJLbOMmEylXT6gbk
         M/tjFN2mMSX+qe3k6d15Id/rxKo2Fi5EbyXjyMT+oyWxSkXlCHZvOEICkeCjZdKHmbnS
         PJXUs/+iO9svbJHpMPZBPNyyZxRUiDIara2+Y1jaKJTvPMr5RA2etERXlRj8IrLmVpu7
         VpDrJ3yZSWJuQNhvzMGnojjCg7rWc0dVirFXD3n5/a7ME9b+/TeW7ojbZ/i3cAVeVzIT
         6/fA==
X-Gm-Message-State: AOUpUlHHVYMIrYlcf8YVBSeSE3cahaEtr7lHesVIbaoJvVB5Ts83ZIL7
        TPWhHd0KIoAesz/9zVaIha+mTS+H
X-Google-Smtp-Source: AAOMgpdv4YjiYcGlPPrg3sLdDNGt7MzXyderLNwF9fIM1nZ46iwZoKkkxv+4e93bIk2SxKozr6y4hg==
X-Received: by 2002:a50:b084:: with SMTP id j4-v6mr20514531edd.172.1532471919349;
        Tue, 24 Jul 2018 15:38:39 -0700 (PDT)
Received: from dimapc.localnet (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id j34-v6sm7659774edb.50.2018.07.24.15.38.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 15:38:38 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-tegra@vger.kernel.org, linux-media@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] media: staging: tegra-vde: Replace debug messages with trace points
Date:   Wed, 25 Jul 2018 01:38:37 +0300
Message-ID: <3929419.8vW2TRoUPb@dimapc>
In-Reply-To: <20180724190652.2befcaf6@coco.lan>
References: <20180707162049.20407-1-digetx@gmail.com> <20180724190652.2befcaf6@coco.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 25 July 2018 01:06:52 MSK Mauro Carvalho Chehab wrote:
> Em Sat,  7 Jul 2018 19:20:49 +0300
> 
> Dmitry Osipenko <digetx@gmail.com> escreveu:
> > Trace points are much more efficient than debug messages for extensive
> > tracing and could be conveniently enabled / disabled dynamically, hence
> > let's replace debug messages with the trace points.
> 
> This patch require some work:
> 
> $ make ARCH=i386  CF=-D__CHECK_ENDIAN__ CONFIG_DEBUG_SECTION_MISMATCH=y C=1
> W=1 CHECK='compile_checks' M=drivers/staging/media
> 
> ./include/linux/slab.h:631:13: error: undefined identifier
> '__builtin_mul_overflow' ./include/linux/slab.h:631:13: warning: call with
> no type!
> fixdep: error opening file: drivers/staging/media/tegra-vde/trace.h: No such
> file or directory

  CHECK   drivers/staging/media/tegra-vde/tegra-vde.c
/bin/sh: compile_checks: command not found

Upstream kernel doesn't have "compile_checks" script and I can't find it 
anywhere else.



