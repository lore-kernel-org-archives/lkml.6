Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98EFEC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 512AB2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MCXBtDfd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 512AB2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729726AbeIRSgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 14:36:00 -0400
Received: from merlin.infradead.org ([205.233.59.134]:52934 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbeIRSgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 14:36:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bXESdo+U0yN1p4Mnr66KvDvCAQhfwgkW1pRFsysOWIc=; b=MCXBtDfdPvQQcEHuYTGjq9gm8
        CpAvqOIKxW4VF80TRtlkLsFMJ1bDTJVG7cVRCntGVLZRJEKbWEMvrPH2xXahSmui8cIYkiL72sKci
        G9qw3+wTMZsJom2KKb4451NvMcg5yA+zK9xBiw9O7Jcz8WfKcgl6ufSP9FFURYEVh8M1HDKLQ1t/A
        o3xOsuVzYP8yZz/XhbPf8iOV8T4aZv7OZ1gx8sVunHMitpO+ZHJEEbzPsnpABm178f7MO3NmqDzql
        BI+2gP5LVx59x4BmlQ26K8qwxAO/emP5dqXO8w4U0N2ZfHvNRNLJ9FwNKV/1prqnhmrFkQt9BQWrd
        YiDPIc4WA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g2Few-0002kz-M9; Tue, 18 Sep 2018 13:03:19 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7B90E202C1A09; Tue, 18 Sep 2018 15:03:16 +0200 (CEST)
Date:   Tue, 18 Sep 2018 15:03:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Zhenzhong Duan <zhenzhong.duan@oracle.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        konrad.wilk@oracle.com, x86@kernel.org, dwmw@amazon.co.uk,
        tglx@linutronix.de, Srinivas REDDY Eeda <srinivas.eeda@oracle.com>,
        bp@suse.de, hpa@zytor.com, dhaval.giani@oracle.com
Subject: Re: [PATCH] x86/speculation: Use AMD specific retpoline for inline
 asm on AMD
Message-ID: <20180918130316.GP24142@hirez.programming.kicks-ass.net>
References: <87411705-893f-46d3-b899-b09ed9fa8d1b@default>
 <20180918095015.GE19234@hirez.programming.kicks-ass.net>
 <3fcc1453-1618-9a79-71c9-5eede0023775@oracle.com>
 <20180918105939.GK24106@hirez.programming.kicks-ass.net>
 <1c6ca05f-094e-03e9-b21a-866aaf80cebb@oracle.com>
 <20180918130058.GM24106@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180918130058.GM24106@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > In original code, it will go to "call *%[thunk_target]\n" while
> > we have set SPECTRE_V2_RETPOLINE_MINIMAL or
> > SPECTRE_V2_RETPOLINE_MINIMAL_AMD. Is this expected?
> 
> Yes, that is exactly right -- it does that with or without your change
> though.

Soryr, I wrote that before I noticed the CONFIG_RETPOLINE vs RETPOLINE
thing.

In any case, since retpoline capable compilers are widely available, I'm
all for making CONFIG_RETPOLINE hard depend on it. That minimal stuff
really is quite silly.
