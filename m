Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 27A9EC5CFC0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 03:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D523520891
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 03:41:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D523520891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965534AbeFODlg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 23:41:36 -0400
Received: from mga09.intel.com ([134.134.136.24]:36518 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964995AbeFODlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 23:41:35 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2018 20:41:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,225,1526367600"; 
   d="scan'208";a="237618899"
Received: from nelizabe-mobl.amr.corp.intel.com (HELO ssarabia-MOBL7.amr.corp.intel.com) ([10.254.79.241])
  by fmsmga006.fm.intel.com with ESMTP; 14 Jun 2018 20:41:34 -0700
Date:   Thu, 14 Jun 2018 20:41:33 -0700
From:   Solio Sarabia <solio.sarabia@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-perf-users@vger.kernel.org, kys@microsoft.com,
        stephen@networkplumber.org, shiny.sebastian@intel.com,
        amy.l.leeland@intel.com, solio.sarabia@intel.com
Subject: Differences in cpu utilization reported by sar, emon
Message-ID: <20180615034133.GA5932@ssarabia-MOBL7.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello --

I'm running into an issue where sar, mpstat, top, and other tools show
less cpu utilization compared to emon [1]. Sar uses /proc/stat as its
source, and was configured to collect in 1s intervals. Emon reads
hardware counter MSRs in the PMU in timer intervals, 0.1s for this
scenario.

The platform is based on Xeon E5-2699 v3 (Haswell) 2.3GHz, 2_sockets,
18_cores/socket, 36_cores in total, running Ubuntu 16.04, Linux
4.4.0-128-generic. A network micro workload, ntttcp-for-linux [2],
sends packets from client to server, through a 40GbE direct link.
Numbers below are from server side.

                 total %util
           CPU11    CPU21    CPU22    CPU25
emon       99.99    15.90    36.22    36.82
sar        99.99     0.06     0.36     0.35

                 interrupts/sec
           CPU11    CPU21    CPU22    CPU25
intrs/sec    846    28923    12844     6304
    Contributors to /proc/interrupts:
    CPU11: Local timer interrupts and Rescheduling interrupts
    CPU21-CPU25: PCI MSI vector from network driver

                 softirqs/sec
           CPU11    CPU21    CPU22    CPU25
TIMER        198        1        2        1
NET_RX         1    28889    23553    18546
TASKLET        0    28889    11676     6249


Somehow hardware irqs and softirqs do not have an effect on the core's
utilization. Another observation is that as more cores are used to
process packets, the emon/sar gap increases.

Kernels used default HZ=250. I also tried HZ=1000, which helped improve
throughput, but difference in util is still there. Same for newer
kernels 4.13, 4.15. I would appreciate pointers to debug this, or
insights as what could cause this behavior.

[1] https://software.intel.com/en-us/download/emon-users-guide
[2] https://github.com/simonxiaoss/ntttcp-for-linux

Thanks,
-Solio
