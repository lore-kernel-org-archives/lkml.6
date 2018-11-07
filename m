Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E966EC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 16:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A1C020827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 16:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="syMXAEnA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A1C020827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731359AbeKHBnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 20:43:22 -0500
Received: from twosheds.infradead.org ([90.155.92.209]:53968 "EHLO
        twosheds.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727561AbeKHBnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 20:43:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=twosheds.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Cc:To:From:Subject:Date:References:In-Reply-To:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+gSgxp/jjGVdroAmX8r6L3OWD2gV13WJGTrp3WbPx/w=; b=syMXAEnALL3PQtA+zOs/PPf73
        Fiar523bjH4t2/0Fdgh9dXyq0xCQ/WGMPyUOTGV/ycDG0vUo9yFDagq1plzk2+qOXBU3W3X/8n02n
        TJGxIe/UXEXP3prj53Kq4S5MirvdGaNIjzmCfpjrKhAd4vXn8+c5NQHZeadlrtN5K9qq1NbwMV30n
        KbIs/rmwcnoa8GKFKNlLQw8F3k6lfGHKnbf70CV/QiX7gq5hi+1213WHudsUROxDd3rLnsClD+EsA
        XZ7pbTEGzhEd3Yt6+hDYwRyQaOZMzXIew98c9A7lHg5YZu2FEwr5HXH0qxZcmu58a8Ano9DGPao39
        Nv3FoM6JA==;
Received: from localhost ([127.0.0.1] helo=twosheds.infradead.org)
        by twosheds.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gKQRC-00AZqQ-DV; Wed, 07 Nov 2018 16:12:14 +0000
Received: from 213.205.242.122
        (SquirrelMail authenticated user dwmw2)
        by twosheds.infradead.org with HTTP;
        Wed, 7 Nov 2018 16:12:14 -0000
Message-ID: <8b08e8b992093453bb2b9caff8cff08c.squirrel@twosheds.infradead.org>
In-Reply-To: <1e4c066d1896e2a0b8b146253d34d05cc4f9ab36.camel@infinera.com>
References: <20181106214928.40020-1-nkela@cisco.com>
    <921b0f78cf67d7307a0555e1fd6f2c2976310adc.camel@infradead.org>
    <1e4c066d1896e2a0b8b146253d34d05cc4f9ab36.camel@infinera.com>
Date:   Wed, 7 Nov 2018 16:12:14 -0000
Subject: Re: [PATCH] jffs2: implement mount option to configure endianness
From:   "David Woodhouse" <dwmw2@infradead.org>
To:     "Joakim Tjernlund" <Joakim.Tjernlund@infinera.com>
Cc:     "nkela@cisco.com" <nkela@cisco.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "xe-linux-external@cisco.com" <xe-linux-external@cisco.com>
User-Agent: SquirrelMail/1.4.22-21.fc27
MIME-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by twosheds.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Yes, this may slow things down. I am not sure I agree with the impl.
> either.
> Could one not make cpu_to_je_X/jeX_to_cpu a function ptr which is set to
> a func. with the correct endian?

On x86 retpoline would make that quite slow.

-- 
dwmw2

