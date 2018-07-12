Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA6B0ECDFB0
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 20:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 891C721477
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 20:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVeqoA1z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 891C721477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732517AbeGLUOw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 16:14:52 -0400
Received: from mail-qk0-f175.google.com ([209.85.220.175]:45468 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732403AbeGLUOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 16:14:52 -0400
Received: by mail-qk0-f175.google.com with SMTP id c192-v6so16095510qkg.12;
        Thu, 12 Jul 2018 13:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hzEPkYnkLGt2VsfQI84NR4VVA/wQ02yw2BpKe8t09Jk=;
        b=UVeqoA1zYjTPyXV3FsxW8ikihfiClaGOEB742kb/MBjCzWrAxJylS49pQV8FTJIN6D
         2khrCGS23t9N6yWV+U66aVjJN0u35RTPuOtYeeqG6ys0x38zNju5B09T9M/HAKLSYmMw
         JX5EsgySkUc/R/lOECBI7ORhBZ+TwOKKi7e3ybXeCXbDRpdFaiNlTPO2pTOwg7yki/8p
         M2jKwFck8bvUHPDDhQ/Kv0QWWVi9nCM8ZkoPmlo6vKulwspf9LYbfb3XqvFnLtOmG8+T
         kCDxSKIhXnaTEuQqgqPmX5I238CZUqu3b0AXK1aaVWvQge24KA0YzYm1dEc1YCR5jLu5
         Lzvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=hzEPkYnkLGt2VsfQI84NR4VVA/wQ02yw2BpKe8t09Jk=;
        b=mx8MEtgBe6BkFZtPYEZt86kejaYGiHzJmTh81jcvVAFnyR/buAS8lq10UqIwwHlTKC
         zTvetKJ/zGf6DCqGfQagnHfnsdLNRiKZu17G2s5IZC9Ipz0joh42K6foXWj74YY/Q8kD
         XlWxtsHjb3z5BWGwScR2Dud49NZqkAa4Kumie+B2Udg/Ply1FA8JT/EiHpTgDi6GS1Y+
         BdeTwvX9mCCRgFLmzFrM/gRmS2J27+aLiX5bRt10FuIbxqq1S023loRC6vUamXUoaJCi
         QEw8gjjPEFexJ1tlAzEAsys4sqsguh/YZSUO+2RJxWQN5NsLnT3KNScZf/9daQcYL760
         0rOA==
X-Gm-Message-State: AOUpUlEQ1NkqVmX1kPLeoFUCapfblpT6wDupLon6Ggwk7PevhljP0xI9
        w4DNGMxqx81Y20F21h3Cl5o=
X-Google-Smtp-Source: AAOMgpcuxiJVFTIW2KD2qPPlN+OSHrQuuEhxZmxnSrrfa6hUfvXp8zxsabkTDe9J29N+MnBtcdtaBQ==
X-Received: by 2002:a37:cc8d:: with SMTP id n13-v6mr3086660qkl.223.1531425826385;
        Thu, 12 Jul 2018 13:03:46 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::1:a01e])
        by smtp.gmail.com with ESMTPSA id n84-v6sm1115548qke.68.2018.07.12.13.03.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 13:03:45 -0700 (PDT)
Date:   Thu, 12 Jul 2018 13:03:43 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     hdegoede@redhat.com, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] ata: ahci_platform: minor fixes
Message-ID: <20180712200343.GK72677@devbig577.frc2.facebook.com>
References: <1531395691-4653-1-git-send-email-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531395691-4653-1-git-send-email-clabbe@baylibre.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 11:41:28AM +0000, Corentin Labbe wrote:
> Hello
> 
> This patchset fixes some minor problem found when working on supporting
> allwinner R40 AHCI.
> 
> Regards
> 
> Corentin Labbe (3):
>   ata: ahci_platform: correct parameter documentation for
>     ahci_platform_shutdown
>   ata: ahci_platform: convert kzallloc to kcalloc
>   ata: ahci_platform: convert kcalloc to devm_kcalloc

Applied all three to libata/for-4.19 with Hans's ack added.

Thanks.

-- 
tejun
