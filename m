Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BE5C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 502172184A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbeLSIqj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 03:46:39 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:51700 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbeLSIqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 03:46:38 -0500
Received: from mail-pf1-f197.google.com ([209.85.210.197])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1gZXUy-0002QE-BM
        for linux-kernel@vger.kernel.org; Wed, 19 Dec 2018 08:46:36 +0000
Received: by mail-pf1-f197.google.com with SMTP id p15so17775125pfk.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 00:46:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=R+s0ZJrtCTroWZ+TTt9370eEptOy+9YmOhZV3N4oPe4=;
        b=QMzTQgme7pf6C/EW7bODonw3tlpKkcRVuj1IUvSLB96R8C+hlG+gbKKDQoQbX9C4at
         v5eHw6+4Fa4VIXwOz1bxvTIqNVff8WsrgFqJ1kyqopdU3ZBvojRWhP3P/nUfVZ0C0o/c
         T7Gr+fWB5HwdrqJs0p3pC1NzNvhtYYF38H5szij6TIyz2f27EVPTrDPqzYLnchKsKYdT
         ocdmfaIlilD8aA4oxuNRV/3Qo0GyyNf/k88XFqub28yYECY2khH9zGAILoihGqxE9pBX
         LRzEesPkmE7z1waiBKcZ3NJLbE9rLJuRSG2qi7/AmKBNWKL1NW6WM/WI/hKHcizLRhMM
         9qoA==
X-Gm-Message-State: AA+aEWbQri8S+Sc3WkViBVaAf+2uYczqz7feTFx1kTeHBUwSw0iMGIuN
        rIToIVNvECrvmvj8mKuvoWXfaKQS8u4mto5KUUfRk7Wkw1CoZMX3McF2VnSbqyNWR14eKAZ5XSF
        8TqhiEResuofCQMpQhS8AEqzLdkuasfl8xQkmKOghkw==
X-Received: by 2002:a63:5455:: with SMTP id e21mr18875183pgm.316.1545209194804;
        Wed, 19 Dec 2018 00:46:34 -0800 (PST)
X-Google-Smtp-Source: AFSGD/UCXDslT4bbt8AQ7KgvtpkugeGtLqJw5ZM6OvIQ5PRK8+4Fdwo6Dr7rXv4xJ0HEOg+B/aerLQ==
X-Received: by 2002:a63:5455:: with SMTP id e21mr18875169pgm.316.1545209194559;
        Wed, 19 Dec 2018 00:46:34 -0800 (PST)
Received: from 2001-b011-380f-3f3d-24a1-2b86-50bd-218d.dynamic-ip6.hinet.net (2001-b011-380f-3f3d-24a1-2b86-50bd-218d.dynamic-ip6.hinet.net. [2001:b011:380f:3f3d:24a1:2b86:50bd:218d])
        by smtp.gmail.com with ESMTPSA id n186sm24460277pfn.137.2018.12.19.00.46.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 00:46:33 -0800 (PST)
From:   Kai Heng Feng <kai.heng.feng@canonical.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: BUG_ON() hit in drivers/md/raid5.c
Message-Id: <BFD51561-092F-4791-A42E-72F1373AEB50@canonical.com>
Date:   Wed, 19 Dec 2018 16:46:31 +0800
Cc:     Steve Kowalik <steven@wedontsleep.org>, linux-raid@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
To:     dan.j.williams@intel.com
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

There are two different BUG_ON() incidents get recently reported on Launchpad [1].

The first one is BUG_ON(dev->written) in ops_run_biodrain().
The second one (comment #23) is BUG_ON(!test_bit(R5_UPTODATE, &dev->flags)) in handle_parity_checks5().

I am not familiar with raid 5 so I am not sure these BUG_ON() are expected to be hit.

[1] https://bugs.launchpad.net/bugs/1780628

Kai-Heng
