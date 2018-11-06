Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79535C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 23:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4108D20830
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 23:51:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4108D20830
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388267AbeKGJTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 04:19:02 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37069 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727292AbeKGJTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 04:19:02 -0500
Received: by mail-pl1-f196.google.com with SMTP id p6-v6so6965924pll.4;
        Tue, 06 Nov 2018 15:51:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ObI3CJHT4+qfxaS+sxMsk8xcwtZviQomE/vRfyYtx6w=;
        b=MEUuvA/USJlD2B9MQjNPtDv7yIqfl4FLi837GywcwPlks1Nb2e6kgLta90C3bvUZhv
         TQq0uwvrOcodjf+c0Lbv+a4Y0nA5lmA9w6R9u9zX0xfB08ri9g86JZHduIljRUX2BRtk
         fBp7QRlykaM9bIHnDoNZWl1VuHdHxB5ALVDv+hkLT8qR3jhysXga6gL7HC3XJMKljVjR
         faQ162ueOV0GzKoH+Ki2MY5DLR2zvP4AFRUr3FIko4vFoVVyBzBxtFQEyMM1ZU++lqbo
         QZSb3Gd5x3vOFp8qM3CE9CqjFBt4j12dkd1RODUL4yD+4Hxy7DDMukewSkx/neaUIYMO
         8/VQ==
X-Gm-Message-State: AGRZ1gIrBu8CT992OyGGPSKakWQ1b4jOJrr9b5agUl1MiM7DmpJ6bHCo
        EUYQuFgDVUVRjxgzcRaJxAnF+GsYFfk=
X-Google-Smtp-Source: AJdET5f6S3o6ReBGUTaUwlQPj4dXU8419PrEjRwGtteoRwcRZE2tTrhtd0VPqWsGsCyGN8G+Q62e4g==
X-Received: by 2002:a17:902:1026:: with SMTP id b35-v6mr28942496pla.283.1541548276544;
        Tue, 06 Nov 2018 15:51:16 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id d68-v6sm10163179pfa.80.2018.11.06.15.51.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Nov 2018 15:51:15 -0800 (PST)
Message-ID: <1541548274.196084.197.camel@acm.org>
Subject: Re: [driver-core PATCH v5 5/9] driver core: Establish clear order
 of operations for deferred probe and remove
From:   Bart Van Assche <bvanassche@acm.org>
To:     kbuild test robot <lkp@intel.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, linux-nvdimm@lists.01.org,
        tj@kernel.org, akpm@linux-foundation.org, linux-pm@vger.kernel.org,
        jiangshanlai@gmail.com, rafael@kernel.org, len.brown@intel.com,
        pavel@ucw.cz, zwisler@kernel.org, dan.j.williams@intel.com,
        dave.jiang@intel.com
Date:   Tue, 06 Nov 2018 15:51:14 -0800
In-Reply-To: <201811061228.iteFLO2p%fengguang.wu@intel.com>
References: <154145232484.29224.1635232599636954462.stgit@ahduyck-desk1.jf.intel.com>
         <201811061228.iteFLO2p%fengguang.wu@intel.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-11-06 at 12:10 +-0800, kbuild test robot wrote:
+AD4 Hi Alexander,
+AD4 
+AD4 Thank you for the patch+ACE Perhaps something to improve:
+AD4 
+AD4 +AFs-auto build test WARNING on driver-core/master+AF0
+AD4 
+AD4 url:    https://github.com/0day-ci/linux/commits/Alexander-Duyck/Add-NUMA-aware-async+AF8-schedule-calls/20181106-093800
+AD4 reproduce: make htmldocs
+AD4 
+AD4 All warnings (new ones prefixed by +AD4APg):
+AD4 
+AD4    include/net/mac80211.h:1001: warning: Function parameter or member 'status.is+AF8-valid+AF8-ack+AF8-signal' not described in 'ieee80211+AF8-tx+AF8-info'
+AD4 +AFs ... +AF0

There are plenty of references in this report to header files not touched
by patch 5/9 in this series. I assume that this report indicates a bug in
the 0-day testing infrastructure?

Bart.
