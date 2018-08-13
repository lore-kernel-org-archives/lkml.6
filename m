Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB09C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 17:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 756692171F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 17:46:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 756692171F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730505AbeHMU35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 16:29:57 -0400
Received: from foss.arm.com ([217.140.101.70]:34566 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730439AbeHMU35 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 16:29:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 995407A9;
        Mon, 13 Aug 2018 10:46:44 -0700 (PDT)
Received: from dupont (dupont.austin.arm.com [10.118.16.87])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BFBCE3F73C;
        Mon, 13 Aug 2018 10:46:43 -0700 (PDT)
Date:   Mon, 13 Aug 2018 12:46:42 -0500
From:   Kim Phillips <kim.phillips@arm.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     peterz@infradead.org, acme@kernel.org, mingo@redhat.com,
        tglx@linutronix.de, alexander.shishkin@linux.intel.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        will.deacon@arm.com, mark.rutland@arm.com, jolsa@redhat.com,
        namhyung@kernel.org, adrian.hunter@intel.com, ast@kernel.org,
        gregkh@linuxfoundation.org, hpa@zytor.com, suzuki.poulosi@arm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 0/7] perf: Add ioctl for PMU driver configuration
Message-Id: <20180813124642.3d49c082a95fc294d926016e@arm.com>
In-Reply-To: <1531950487-24554-1-git-send-email-mathieu.poirier@linaro.org>
References: <1531950487-24554-1-git-send-email-mathieu.poirier@linaro.org>
Organization: Arm
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jul 2018 15:48:00 -0600
Mathieu Poirier <mathieu.poirier@linaro.org> wrote:

> This set adds the capability to communiate event specific configuration
> to the PMU kernel driver using an ioctl().  The functionatlity is made
> generic enough for anyone to use but is targeted at the identification
> of CoreSight sinks when operating in CPU-wide trace scenarios.
> 
> ---
> Changes for V3:
> . Return an error for CPU-wide scenarios while the feature is being
>   implemented (Kim)

Hi, I'm giving this series a short test-drive on Juno.

It yields success for the --per-thread case..:

$ sudo taskset -c 0 ./perf record -e cs_etm/@20010000.etf/ --per-thread uname -a
Linux juno 4.18.0-rc8-00011-gb82af52c4b35-dirty #147 SMP PREEMPT Thu Aug 9 11:20:37 CDT 2018 aarch64 GNU/Linux
[ perf record: Woken up 0 times to write data ]
Warning:
AUX data lost 1 times out of 2!

[ perf record: Captured and wrote 0.067 MB perf.data ]
$ 

..but not for CPU-wide?:

$ sudo taskset -c 0 ./perf record -e cs_etm/@20010000.etf/ uname -a
failed to mmap with 12 (Cannot allocate memory)
$ sudo taskset -c 0 ./perf record -e cs_etm/@20010000.etf/ -C 0 uname -a
failed to mmap with 12 (Cannot allocate memory)
$ 

Thanks,

Kim
