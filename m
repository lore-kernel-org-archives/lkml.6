Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A39C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 08:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 387622083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 08:55:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 387622083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbeGZKLr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 06:11:47 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:46618 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728899AbeGZKLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 06:11:46 -0400
Received: from 79.184.255.17.ipv4.supernova.orange.pl (79.184.255.17) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id 5f9fdadb2a921dc6; Thu, 26 Jul 2018 10:55:53 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Eduardo Valentin <eduval@amazon.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>,
        Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "mike.travis@hpe.com" <mike.travis@hpe.com>,
        Rajvi Jingar <rajvi.jingar@intel.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] x86: tsc: avoid system instability in hibernation
Date:   Thu, 26 Jul 2018 10:54:06 +0200
Message-ID: <1698243.s70xJfMujH@aspire.rjw.lan>
In-Reply-To: <20180725181846.1817-1-eduval@amazon.com>
References: <20180725181846.1817-1-eduval@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eduardo,

On Wednesday, July 25, 2018 8:18:46 PM CEST Eduardo Valentin wrote:
> System instability are seen during resume from hibernation when system
> is under heavy CPU load. This is due to the lack of update of sched
> clock data, and the scheduler would then think that heavy CPU hog
> tasks need more time in CPU, causing the system to freeze
> during the unfreezing of tasks. For example, threaded irqs,
> and kernel processes servicing network interface may be delayed
> for several tens of seconds, causing the system to be unreachable.
> 
> Situation like this can be reported by using lockup detectors
> such as workqueue lockup detectors:
> 
> Message from syslogd@ip-172-31-67-114 at May  7 18:23:21 ...
>  kernel:BUG: workqueue lockup - pool cpus=0 node=0 flags=0x0 nice=0 stuck for 57s!
> 
> Message from syslogd@ip-172-31-67-114 at May  7 18:23:21 ...
>  kernel:BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=0 stuck for 57s!
> 
> Message from syslogd@ip-172-31-67-114 at May  7 18:23:21 ...
>  kernel:BUG: workqueue lockup - pool cpus=3 node=0 flags=0x1 nice=0 stuck for 57s!
> 
> Message from syslogd@ip-172-31-67-114 at May  7 18:29:06 ...
>  kernel:BUG: workqueue lockup - pool cpus=3 node=0 flags=0x1 nice=0 stuck for 403s!
> 
> The fix for this situation is to mark the sched clock as unstable
> as early as possible in the resume path, leaving it unstable
> for the duration of the resume process. This will force the
> scheduler to attempt to align the sched clock across CPUs using
> the delta with time of day, updating sched clock data. In a post
> hibernation event, we can then mark the sched clock as stable
> again, avoiding unnecessary syncs with time of day on systems
> in which TSC is reliable.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Dou Liyang <douly.fnst@cn.fujitsu.com>
> Cc: Len Brown <len.brown@intel.com>
> Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> Cc: Eduardo Valentin <eduval@amazon.com>
> Cc: "mike.travis@hpe.com" <mike.travis@hpe.com>
> Cc: Rajvi Jingar <rajvi.jingar@intel.com>
> Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
> Cc: Philippe Ombredanne <pombredanne@nexb.com>
> Cc: Kate Stewart <kstewart@linuxfoundation.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: x86@kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Eduardo Valentin <eduval@amazon.com>

Can you please resend this with a CC to linux-pm?

Cheers,
Rafael

