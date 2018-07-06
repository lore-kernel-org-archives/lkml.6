Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76D4C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 23:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CE2D22B4B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 23:38:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CE2D22B4B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933241AbeGFXir (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 19:38:47 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43936 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932774AbeGFXiq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 19:38:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB10180D;
        Fri,  6 Jul 2018 16:38:45 -0700 (PDT)
Received: from dupont (dupont.austin.arm.com [10.118.16.87])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 199FF3F2EA;
        Fri,  6 Jul 2018 16:38:45 -0700 (PDT)
Date:   Fri, 6 Jul 2018 18:38:44 -0500
From:   Kim Phillips <kim.phillips@arm.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     peterz@infradead.org, acme@kernel.org, mingo@redhat.com,
        tglx@linutronix.de, alexander.shishkin@linux.intel.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        will.deacon@arm.com, mark.rutland@arm.com, jolsa@redhat.com,
        namhyung@kernel.org, adrian.hunter@intel.com, ast@kernel.org,
        gregkh@linuxfoundation.org, hpa@zytor.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/7] perf: Add ioctl for PMU driver configuration
Message-Id: <20180706183844.9de52f1d45e1775b51790e8e@arm.com>
In-Reply-To: <1530828827-11604-1-git-send-email-mathieu.poirier@linaro.org>
References: <1530828827-11604-1-git-send-email-mathieu.poirier@linaro.org>
Organization: Arm
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  5 Jul 2018 16:13:40 -0600
Mathieu Poirier <mathieu.poirier@linaro.org> wrote:

> This set adds the capability to communiate event specific configuration
> to the PMU kernel driver using an ioctl().  The functionatlity is made
> generic enough for anyone to use but is targeted at the identification
> of CoreSight sinks when operating in CPU-wide trace scenarios.

With this series, a --per-thread -less invocation looks like it
succeeds (instead of giving a "failed to mmap with 12 (Cannot allocate
memory)" error):

# perf record -e /cs_etm/@20010000.etf/ sleep 1
[ perf record: Woken up 3 times to write data ]
Warning:
AUX data lost 2 times out of 3!

[ perf record: Captured and wrote 0.182 MB perf.data ]
# 

but now perf report - built with libopencsd - is unable to process the
perf.data file:

# perf report --stdio 
0x3a0 [0x60]: failed to process type: 1
Error:
failed to process sample
# To display the perf.data header info, please use --header/--header-only options.
#

Also, a "record -a" invocation also acts like it's working, but Juno
has a hardware limitation where it can't record all cpus concurrently,
right?  So, shouldn't record commands that exceed the h/w's
capabilities error out instead?

Thanks,

Kim
