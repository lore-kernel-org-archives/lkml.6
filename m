Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D607C0044C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 00:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20D042083D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 00:42:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20D042083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728930AbeKFKE6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 05:04:58 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34211 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbeKFKE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 05:04:58 -0500
Received: by mail-pf1-f194.google.com with SMTP id y18-v6so2861244pfn.1;
        Mon, 05 Nov 2018 16:42:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yFNtUHQWTCOuWOyoF6QB8BvnWcjUGzql68iEePedwEk=;
        b=tXJgdnbBPzqtk1ExAWKMHJLmdnuuaNhHu39Vd4rI1CuK06MebuP0tgmhzSSCEjByZc
         SdJ8J86a8nyZPIJhqBbUoZ+svbtBWTKd1lwKV22ROFaZqcfobRhthJiZx88APv7tpZgC
         SpgdtvCafInxQRGyLnppk+zQl4XPy62rtI786fz3fQqCIpUjlvtLoGt/0uQQibqsocZ4
         CpT5AOiOM8GUDxhCZm8bHIfiCYs5XnyKFsdPY2ZxnRH/DTc5e7iAclLGSDPL/CQDX6Op
         WdA0HX2cr8BocZK1wdAXIV9t8nEP74cvrl05CoCfOnDpoTkaeQkSndsmNj0tC/zRCFhs
         +xeg==
X-Gm-Message-State: AGRZ1gIAgPbvR3ezD/s91a/SIfynNcv52/gZK+s03BzMS0wSsNTLBd7d
        hXAbWVwXzBWvQgVSU0ksZqs=
X-Google-Smtp-Source: AJdET5eP8gAsO1VRxmelm73Sitjari6SAO/sDd5Ia4Hi+dDG5tDiZqVNTM5C6QgT2wHIyCQDMuD/+w==
X-Received: by 2002:a65:620f:: with SMTP id d15-v6mr22621420pgv.120.1541464950400;
        Mon, 05 Nov 2018 16:42:30 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id c7-v6sm47820177pfh.25.2018.11.05.16.42.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 16:42:29 -0800 (PST)
Message-ID: <1541464948.196084.168.camel@acm.org>
Subject: Re: [driver-core PATCH v5 1/9] workqueue: Provide queue_work_node
 to queue work near a given NUMA node
From:   Bart Van Assche <bvanassche@acm.org>
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     linux-nvdimm@lists.01.org, tj@kernel.org,
        akpm@linux-foundation.org, linux-pm@vger.kernel.org,
        jiangshanlai@gmail.com, rafael@kernel.org, len.brown@intel.com,
        pavel@ucw.cz, zwisler@kernel.org, dan.j.williams@intel.com,
        dave.jiang@intel.com
Date:   Mon, 05 Nov 2018 16:42:28 -0800
In-Reply-To: <154145230445.29224.14651284855380723028.stgit@ahduyck-desk1.jf.intel.com>
References: <154145223352.29224.8912797012647157172.stgit@ahduyck-desk1.jf.intel.com>
         <154145230445.29224.14651284855380723028.stgit@ahduyck-desk1.jf.intel.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-11-05 at 13:11 -0800, Alexander Duyck wrote:
+AD4 +-/+ACoAKg
+AD4 +- +ACo workqueue+AF8-select+AF8-cpu+AF8-near - Select a CPU based on NUMA node
+AD4 +- +ACo +AEA-node: NUMA node ID that we want to bind a CPU from
                                          +AF4AXgBeAF4
                                          select?
+AD4 +-	/+ACo If CPU is valid return that, otherwise just defer +ACo-/
+AD4 +-	return (cpu +ADw nr+AF8-cpu+AF8-ids) ? cpu : WORK+AF8-CPU+AF8-UNBOUND+ADs

Please leave out the superfluous parentheses if this patch series would have to
be reposted.

Anyway:

Reviewed-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4


