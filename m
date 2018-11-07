Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA81C32789
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 00:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B5A520827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 00:22:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B5A520827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731126AbeKGJuh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 04:50:37 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44649 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730885AbeKGJuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 04:50:37 -0500
Received: by mail-pg1-f193.google.com with SMTP id w3-v6so6543110pgs.11;
        Tue, 06 Nov 2018 16:22:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wklpSVaVfPCUd5odhNs9ZWmpEecGTQ0l6x0FI+lLs4k=;
        b=R6Wv4r7IbyRVZ7S6+yjBc1e29b7L+7YdyDraipXIjqoSppWTeag1Zg3Vd9M6R0KJDs
         QYRc+aYVOJknC2kkWtXBosAFoNNGcJAmdPbW6bqyqwXImSvtDIOBZvqwAle7oVczwVX6
         YZSut1z76R3mTy3SECUUiEHmKpMqUUxCz5VDnWr+sboYHV5IPw0b9PL0ATvu0iuTfwrg
         qPKmxEsY+ELHVGLnGN3biGYA/8EGpvVsEwgVxKZ11fNCTtw3rLiNjT+v/y+0yQvuPg6h
         tGnFQL1iqiIlV9fWpUj+fyb/7AFrGRsMymmD5mjOHeOJ9z/sPoIbzTS6XBu0WFKfoYO2
         xS8A==
X-Gm-Message-State: AGRZ1gKyS+UyQ6fBtEvoDzsMDq2PSXTONqGlKF6CRj6RdR6Bb02RZrqj
        6ciJINYUZi/FVzUNaRYUXyk=
X-Google-Smtp-Source: AJdET5fWKgXfhIXqu/1ceyg19QO8mPc9i+bRdIq63rmb9ZJL94henlkYbHrXl2xyGyqpxx+NyejcZg==
X-Received: by 2002:a63:6a42:: with SMTP id f63-v6mr26275972pgc.48.1541550164903;
        Tue, 06 Nov 2018 16:22:44 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id z8sm10211279pgz.53.2018.11.06.16.22.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Nov 2018 16:22:44 -0800 (PST)
Message-ID: <1541550162.196084.199.camel@acm.org>
Subject: Re: [driver-core PATCH v5 6/9] driver core: Probe devices
 asynchronously instead of the driver
From:   Bart Van Assche <bvanassche@acm.org>
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     linux-nvdimm@lists.01.org, tj@kernel.org,
        akpm@linux-foundation.org, linux-pm@vger.kernel.org,
        jiangshanlai@gmail.com, rafael@kernel.org, len.brown@intel.com,
        pavel@ucw.cz, zwisler@kernel.org, dan.j.williams@intel.com,
        dave.jiang@intel.com
Date:   Tue, 06 Nov 2018 16:22:42 -0800
In-Reply-To: <154145232994.29224.4383053368766089653.stgit@ahduyck-desk1.jf.intel.com>
References: <154145223352.29224.8912797012647157172.stgit@ahduyck-desk1.jf.intel.com>
         <154145232994.29224.4383053368766089653.stgit@ahduyck-desk1.jf.intel.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-11-05 at 13:12 -0800, Alexander Duyck wrote:
+AD4 diff --git a/include/linux/device.h b/include/linux/device.h
+AD4 index fc7091d436c2..4d9a39769081 100644
+AD4 --- a/include/linux/device.h
+AD4 +-+-+- b/include/linux/device.h
+AD4 +AFs ... +AF0
+AD4 +-static inline struct device+AF8-driver +ACo-dev+AF8-get+AF8-drv+AF8-async(const struct device +ACo-dev)
+AD4 +-+AHs
+AD4 +-	return dev-+AD4-async+AF8-probe ? dev-+AD4-driver+AF8-data : NULL+ADs
+AD4 +-+AH0
+AD4 +-
+AD4 +-static inline void dev+AF8-set+AF8-drv+AF8-async(struct device +ACo-dev,
+AD4 +-				     struct device+AF8-driver +ACo-drv)
+AD4 +-+AHs
+AD4 +-	/+ACo
+AD4 +-	 +ACo Set async+AF8-probe to true indicating we are waiting for this data to be
+AD4 +-	 +ACo loaded as a potential driver.
+AD4 +-	 +ACo-/
+AD4 +-	dev-+AD4-driver+AF8-data +AD0 drv+ADs
+AD4 +-	dev-+AD4-async+AF8-probe +AD0 true+ADs
+AD4 +-+AH0

Since these two new functions are only used in the driver core please move
their definition into the driver core.

Thanks,

Bart.
