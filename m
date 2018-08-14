Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B6A1C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 19:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0006321727
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 19:51:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0006321727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729267AbeHNWki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 18:40:38 -0400
Received: from mga02.intel.com ([134.134.136.20]:40043 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727982AbeHNWki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 18:40:38 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Aug 2018 12:51:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,239,1531810800"; 
   d="scan'208";a="80279867"
Received: from ssarabia-mobl7.amr.corp.intel.com ([10.24.10.183])
  by fmsmga004.fm.intel.com with ESMTP; 14 Aug 2018 12:51:52 -0700
Date:   Tue, 14 Aug 2018 12:51:52 -0700
From:   Solio Sarabia <solio.sarabia@intel.com>
To:     mingo@kernel.org, peterz@infradead.org, frederick@kernel.org,
        tj@kernel.org, wanpeng.li@hotmail.com
Cc:     linux-kernel@vger.kernel.org, ak@linux.intel.com,
        shiny.sebastian@intel.com, amy.l.leeland@intel.com,
        jun.nakajima@intel.com, sainath.grandhi@intel.com
Subject: Time accounting difference under high IO interrupts
Message-ID: <20180814195102.GA8568@ssarabia-MOBL7.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Under high IO activity (storage or network), the kernel is not
accounting some cpu cycles, comparing sar vs emon (tool that accesses hw
pmu directly). The difference is higher on cores that spend most time on
idle state and are constantly waking up to handle interrupts. It happens
even with fine IRQ time accounting enabled (CONFIG_IRQ_TIME_ACCOUNTING).

After playing with timer subsytem options (periodick ticks, idle
tickless, full tickless), time and stats accounting, and jiffie values,
the issue persists. Cycles lost are not accounted on other cores as
'extra' util. Example with linux 4.15.18 baremetal, xeon v4 broadwell,
driving network traffic:

           sar    emon   emon-sar   intrs/sec
core12    5.00   11.70   6.70       29,302
core17   19.07   23.16   4.09       17,345
core20   19.41   23.11   3.70       16,578

Based on how kernel accounts time:
Do you have an idea why a high number of intrs affect time accounting?

Thanks,
-Solio
