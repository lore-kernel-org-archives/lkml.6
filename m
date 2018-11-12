Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1ECAC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 08:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9883021780
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 08:34:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GIpMGyLL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9883021780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbeKLS0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 13:26:41 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56876 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbeKLS0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 13:26:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hea4acmQYKQ9UCf7pQpSFlVSFZHEgw++yRr9gR3Wsx8=; b=GIpMGyLL03NJwTKzzLViKWJGm
        CMKXn3JquRNiYo32Jp4mGZmPK+IXVdXG7g3T9/TLP6+T2ATuNR48SII3lcW5lIdihRKY0y210UO8Y
        VDd3tfQwa1JOlqGxstruP4ZUcq+aLlwlzJVhQo+0att+VgSunnddaUbYViCEeX2XZBPp4hLr5weo/
        yTR7iwaFnC9j29uHxiAiFN/qbB++y4Zqvb4iFaar5EwNLrnfyOGfybduvdueGk77QebnNORbUNK8J
        a5x8dHHfCIgxtoS+7ffUZG+60KyupnQdGLgwSvCkC6ukGpev/6Cr4DEPrIlzt9+vVF+RkHUv1QeCR
        utxej7LVw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gM7fr-0007Ci-15; Mon, 12 Nov 2018 08:34:23 +0000
Date:   Mon, 12 Nov 2018 00:34:22 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen N Chivers <schivers@csc.com.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 01/13] arm: Fix mutual exclusion in arch_gettimeoffset
Message-ID: <20181112083422.GA19695@infradead.org>
References: <cover.1541995959.git.fthain@telegraphics.com.au>
 <d1559db8eddb5b06747b152ae69b63c3aa66ed09.1541995959.git.fthain@telegraphics.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1559db8eddb5b06747b152ae69b63c3aa66ed09.1541995959.git.fthain@telegraphics.com.au>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 03:12:39PM +1100, Finn Thain wrote:
> Implementations of arch_gettimeoffset are generally not re-entrant
> and assume that interrupts have been disabled. Unfortunately this
> pre-condition got broken in v2.6.32.
> 
> Fixes: 5cfc8ee0bb51 ("ARM: convert arm to arch_gettimeoffset()")
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

This looks like a sensible fix for -stable backporting.  But with m68k
converted over it might be time for these two arm platforms to either
be converted to the clocksource API or to be dropped..
