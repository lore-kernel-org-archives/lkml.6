Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D06C6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 22:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 212742098A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 22:27:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 212742098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbeJMGCV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 02:02:21 -0400
Received: from mga04.intel.com ([192.55.52.120]:24036 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725918AbeJMGCU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 02:02:20 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Oct 2018 15:27:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,374,1534834800"; 
   d="scan'208";a="99807650"
Received: from ssarabia-mobl7.amr.corp.intel.com ([10.7.189.87])
  by orsmga002.jf.intel.com with ESMTP; 12 Oct 2018 15:27:47 -0700
Date:   Fri, 12 Oct 2018 15:27:44 -0700
From:   Solio Sarabia <solio.sarabia@intel.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        len.brown@intel.com
Cc:     solio.sarabia@intel.com, shiny.sebastian@intel.com
Subject: Re: turbostat-17.06.23 floating point exception
Message-ID: <20181012222743.GA14100@ssarabia-MOBL7.amr.corp.intel.com>
References: <20181012182630.GA13352@ssarabia-MOBL7.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181012182630.GA13352@ssarabia-MOBL7.amr.corp.intel.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 11:26:30AM -0700, Solio Sarabia wrote:
> Hi --
> 
> turbostat 17.06.23 is throwing an exception on a custom linux-4.16.12
> kernel, on Xeon E5-2699 v4 Broadwell EP, 2S, 22C/S, 44C total, HT off,
> VTx off.
> 
> Initially the system had 4.4.0-137. Then I built and installed
> linux-4.16.12-default.  turbostat works fine for these two versions.
> After building linux-4.16.12 for a second time, the older kernel is
> renamed and now `ls -l /boot/` (I'm using version without .old suffix):
> 
> 	vmlinuz-4.16.12-default+
> 	vmlinuz-4.16.12-default+.old
> 
> grep -i 'turbostat' /var/log/kern.log
> 
> kernel: [  159.140836] capability: warning: `turbostat' uses 32-bit
> 	capabilities (legacy support in use)
> kernel: [  164.149264] traps: turbostat[1801] trap divide error
> 	ip:407625 sp:7ffe4b0df000 error:0 in turbostat[400000+17000]
> 
> (gdb)
> cpu22: MSR_PKGC3_IRTL: 0x00000000 (NOTvalid, 0 ns)
> cpu22: MSR_PKGC6_IRTL: 0x00000000 (NOTvalid, 0 ns)
> cpu22: MSR_PKGC7_IRTL: 0x00000000 (NOTvalid, 0 ns)
> 
> Program received signal SIGFPE, Arithmetic exception.
> 0x0000000000407625 in compute_average (t=0x61a3b0, c=0x61a3d0, p=0x61a480) at turbostat.c:1378
> 1378            average.threads.tsc /= topo.num_cpus;
> 
Why would the cpu topology report 0 cpus?  I added a debug entry to
cpu_usage_stat and /proc/stat showed it as an extra column.  Then
fscanf parsing in for_all_cpus() failed, causing the SIGFPE.

This is not an issue. Thanks.

> Let me know if you need more details.
> 
> Thanks,
> -SS
