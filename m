Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A69C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 18:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AB3A2152B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 18:32:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AB3A2152B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbeHOVZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 17:25:07 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:35390 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbeHOVZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 17:25:07 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id B00FA80675; Wed, 15 Aug 2018 20:31:49 +0200 (CEST)
Date:   Wed, 15 Aug 2018 20:31:34 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jeff Lien <jeff.lien@wdc.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        herbert@gondor.apana.org.au, tim.c.chen@linux.intel.com,
        martin.petersen@oracle.com, david.darrington@wdc.com,
        jeff.furlong@wdc.com
Subject: Re: [PATCH] Performance Improvement in CRC16 Calculations.
Message-ID: <20180815182538.GB9709@xo-6d-61-c0.localdomain>
References: <1533928331-21303-1-git-send-email-jeff.lien@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533928331-21303-1-git-send-email-jeff.lien@wdc.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This patch provides a performance improvement for the CRC16 calculations done in read/write
> workloads using the T10 Type 1/2/3 guard field.  For example, today with sequential write
> workloads (one thread/CPU of IO) we consume 100% of the CPU because of the CRC16 computation
> bottleneck.  Today's block devices are considerably faster, but the CRC16 calculation prevents
> folks from utilizing the throughput of such devices.  To speed up this calculation and expose
> the block device throughput, we slice the old single byte for loop into a 16 byte for loop,
> with a larger CRC table to match.  The result has shown 5x performance improvements on various
> big endian and little endian systems running the 4.18.0 kernel version.

Well, 8K table fits in cache easily, and when running benchmark, table will be cached so it is
a win... Is it also win on non-benchmark workloads and smaller systems?

											Pavel
