Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A75C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 02:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E678208B7
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 02:41:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E678208B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbeH1Gat convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 02:30:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:56416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725796AbeH1Gat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 02:30:49 -0400
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 980B2208B4;
        Tue, 28 Aug 2018 02:41:23 +0000 (UTC)
Date:   Mon, 27 Aug 2018 22:41:21 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Bernhard Landauer <oberon@manjaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Philip =?UTF-8?B?TcO8bGxlcg==?= <philm@manjaro.org>
Subject: Re: [ANNOUNCE] 4.14.63-rt40
Message-ID: <20180827224121.2dc55b30@vmware.local.home>
In-Reply-To: <20180824121751.606659c9@gandalf.local.home>
References: <20180822141458.0b6b6af7@gandalf.local.home>
        <7e1b2b0a-2e52-8f0d-2e17-c3ba9232f8b7@manjaro.org>
        <20180824121751.606659c9@gandalf.local.home>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Aug 2018 12:17:51 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 24 Aug 2018 18:14:43 +0200
> Bernhard Landauer <oberon@manjaro.org> wrote:
> 
> > Hello everyone,
> > 
> > for some reason I am not able to build 4.14.63-rt40 for Manjarolinux.
> > Even after removing all our custom patches build fails at
> > 
> >   LD [M]  drivers/gpu/drm/drm.o
> >   AR      drivers/gpu/built-in.o
> > make: *** [Makefile:1035: drivers] Error 2
> > 
> > My config can be found here for information:
> > https://gitlab.manjaro.org/packages/community/realtime-kernels/linux414-rt/raw/master/config.rt
> > 
> > Thank you for any advice!
> >  
> 
> Thanks for the report, I'll take a look.
> 

This appears to fix it:

-- Steve

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index cedf225d4182..7df4cced6ac0 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -35,6 +35,7 @@
 #include <linux/clockchips.h>
 #include <linux/cpu.h>
 #include <linux/sched/task_stack.h>
+#include <linux/irq.h>
 
 #include <asm/hyperv.h>
 #include <asm/hypervisor.h>
