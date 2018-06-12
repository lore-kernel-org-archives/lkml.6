Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 9379DC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4766520891
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:11:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kbQFDk2y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4766520891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934039AbeFLULo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 16:11:44 -0400
Received: from merlin.infradead.org ([205.233.59.134]:57862 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932768AbeFLULn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 16:11:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6Iu/EpOVdAzvxBQSPO9hjvb9m3X5e0VC+6eHFalIkes=; b=kbQFDk2y3lay1p2O9VqjdLwMr
        JpJJ/9FkzWmgAGh9QSM0guUHpEU3JLaZSlHP8UHYzlZkRmWcJ1xjrg10D5TVjbpR23NF0pDQRmzv0
        k24WRrL6xTGQg/K7K9Nt/gd7CpfY9TtLD6yNyFDhA1HKIQ2TuyfZsBeqnwGpykbzIUFD9ed//E5fs
        6nyEhCd54rFewY9lM7AWM4mXXvtMXmBee1/sza5QB/IkfQEpeonnbLCWcTC9EBUcv3B7N7oiHpnet
        K08V4C3A8oTyKEsHp8dSukghV3yhYk+tbSu+3zOKECosndW5eoIVeS0gXfZP3OcVpzzFO/u8RyMrS
        kVRXdKEow==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fSpda-0006PP-Bv; Tue, 12 Jun 2018 20:11:30 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7C439201EA7A3; Tue, 12 Jun 2018 22:11:27 +0200 (CEST)
Date:   Tue, 12 Jun 2018 22:11:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org, jolsa@redhat.com
Subject: Re: [PATCH v1 1/6] perf: Disable PMU around address filter adjustment
Message-ID: <20180612201127.GW12217@hirez.programming.kicks-ass.net>
References: <20180612075117.65420-1-alexander.shishkin@linux.intel.com>
 <20180612075117.65420-2-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180612075117.65420-2-alexander.shishkin@linux.intel.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 10:51:12AM +0300, Alexander Shishkin wrote:
> If the PMU is used for AUX data sampling, the hardware event that triggers
> it may come in during a critical section of address filters adjustment (if
> it's delivered as NMI) and in turn call the address filter sync code,
> causing a spinlock recursion.

Can you detail that a little more? How can sampling _ever_ get down that
path?
