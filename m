Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B3FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 19:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 532942186A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 19:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YyhTHM7V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728817AbfBZTFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 14:05:17 -0500
Received: from merlin.infradead.org ([205.233.59.134]:56110 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727196AbfBZTFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 14:05:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zOWBJpIsy9QtShrVdXONNOLJHqDFXBJC7zoVe+QQZ68=; b=YyhTHM7VozikhyVfDrrZAzJVv
        P4x65bpdViflwWKjKWxgr7sLuZsv9luPBfyaAS1J9ptVOk2eOqFc7g+4HXfyz1i5TePPmLN/7gIzV
        aCLQID6qomeP1Px+fPGu1JNl9/tm6VuJwJEttZvvytXKXRonHmiK3f1lQZKmcet0cGI0KSDQJt5nv
        puadI38TuvruSL2EjnvT8+OMEpDjBrruFlcVCskq9jkRr+BxSMIAGefP87VYza9LhmgnMbc3Z1ahR
        lXPkzxHzcdlDcIEL3Tinr8ygbDe1RxQdxy6AWtEwIu3XDSNuZ++9MaVdoYLwjh9HXnsXasepoVuku
        puZ0rfA7Q==;
Received: from [188.207.104.89] (helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gyi2V-0008ER-Gb; Tue, 26 Feb 2019 19:05:16 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id D3B25984351; Tue, 26 Feb 2019 20:05:12 +0100 (CET)
Date:   Tue, 26 Feb 2019 20:05:12 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Len Brown <lenb@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/14] v2 multi-die/package topology support
Message-ID: <20190226190512.GR2861@worktop.programming.kicks-ass.net>
References: <20190226062012.23746-1-lenb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190226062012.23746-1-lenb@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 01:19:58AM -0500, Len Brown wrote:
>  Documentation/cputopology.txt                | 72 ++++++++++++++---------
>  Documentation/x86/topology.txt               |  6 +-
>  arch/x86/include/asm/processor.h             |  5 +-
>  arch/x86/include/asm/smp.h                   |  1 +
>  arch/x86/include/asm/topology.h              |  5 ++
>  arch/x86/kernel/cpu/topology.c               | 85 +++++++++++++++++++++-------
>  arch/x86/kernel/smpboot.c                    | 73 +++++++++++++++++++++++-
>  arch/x86/xen/smp_pv.c                        |  1 +
>  drivers/base/topology.c                      | 22 +++++++
>  drivers/hwmon/coretemp.c                     |  9 +--
>  drivers/powercap/intel_rapl.c                | 75 +++++++++++++-----------
>  drivers/thermal/intel/x86_pkg_temp_thermal.c |  9 +--
>  include/linux/topology.h                     |  6 ++
>  13 files changed, 276 insertions(+), 93 deletions(-)

Should we not also have changes to
arch/x86/kernel/cpu/proc.c:show_cpuinfo_cores() ?
