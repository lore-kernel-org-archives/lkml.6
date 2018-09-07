Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B6B7C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 13:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E645C20869
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 13:39:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E645C20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729453AbeIGSUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 14:20:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35410 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726129AbeIGSUN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 14:20:13 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F3B308576D;
        Fri,  7 Sep 2018 13:39:11 +0000 (UTC)
Received: from treble (ovpn-125-2.rdu2.redhat.com [10.10.125.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 246B110073B1;
        Fri,  7 Sep 2018 13:39:11 +0000 (UTC)
Date:   Fri, 7 Sep 2018 08:39:08 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v4 1/2] x86/speculation: apply IBPB more strictly to
 avoid cross-process data leak
Message-ID: <20180907133908.dbcqz3mnaneluvtk@treble>
References: <nycvar.YFH.7.76.1809061013160.15880@cbobk.fhfr.pm>
 <alpine.LRH.2.00.1809061029030.3446@gjva.wvxbf.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.00.1809061029030.3446@gjva.wvxbf.pm>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 07 Sep 2018 13:39:12 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 07 Sep 2018 13:39:12 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jpoimboe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 10:32:38AM +0200, Jiri Kosina wrote:
> From: Jiri Kosina <jkosina@suse.cz>
> 
> Currently, we are issuing IBPB only in cases when switching into a non-dumpable
> process, the rationale being to protect such 'important and security sensitive'
> processess (such as GPG) from data leak into a different userspace process via
> spectre v2.
> 
> This is however completely insufficient to provide proper userspace-to-userpace
> spectrev2 protection, as any process can poison branch buffers before being
> scheduled out, and the newly scheduled process immediately becomes spectrev2

"becomes a"

> victim.
> 
> In order to minimize the performance impact (for usecases that do require
> spectrev2 protection), issue the barrier only in cases when switching between
> processess where the victim can't be ptraced by the potential attacker (as in

"processes"

> such cases, the attacker doesn't have to bother with branch buffers at all).
> 
> Fixes: 18bf3c3ea8 ("x86/speculation: Use Indirect Branch Prediction Barrier in context switch")
> Originally-by: Tim Chen <tim.c.chen@linux.intel.com>
> Signed-off-by: Jiri Kosina <jkosina@suse.cz>

Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh
