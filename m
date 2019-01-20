Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C74C7113D
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 16:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE8212085A
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 16:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=appneta.com header.i=@appneta.com header.b="Xbt718To"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfATQDT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 11:03:19 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41754 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfATQDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 11:03:18 -0500
Received: by mail-pf1-f194.google.com with SMTP id b7so8938506pfi.8
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jan 2019 08:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=appneta.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=73Dd9IDkWCGiW5JIKs3Sq3hJTdYKxShmv0lLRLRNtLA=;
        b=Xbt718ToqztL2cTBxMdTXGCbYO2JwVL+oC4KcOQowPG3dxWrKL6EnDzUO+uENWi4dV
         e2IEc9zabqONv7bGPqumAUDqQjT8TLQmBs69t26CSj0Vu4soArUDmhGtUbAuAmtnC2in
         s5G1IqLX+d06yBF2YcnRR/mLvCln+GvWhdxrA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=73Dd9IDkWCGiW5JIKs3Sq3hJTdYKxShmv0lLRLRNtLA=;
        b=OdKuNETezwI46UokNFWaLUCI8jMjGGFldD1UvVmSJEK+NUYH7Dwk9tbxPLCPZHBUos
         IHDf9qvtu5mvSvEpb8+IE4N92t1nxUGuMYmtnN0hBXTAgmInTZsIUCTr/wRDhxT9S+2O
         fN77LlZOdOxsbfvChDJfO8XLcCg3otJ/I/c+qImbs9moT9r+TiiU0yuhif2UzLbhScAz
         qneL9TgQnLzx9j9PIK87kZvvp8SPYD+6OC1JQ8sS7ilYdNqKgoquWQfb6GasME4iwajh
         8c/BvqiPLEw6ocLeQBNeysWRgd9ydHjZsMyTEwiEXgdStqWS5StRZLSxrrx80dSqvXUh
         +j6Q==
X-Gm-Message-State: AJcUuke+2WJMBO5+yZX8p0/K1fCajvFkvjpSLTn633wowsZzJt4wr1Eb
        WJhJTGPWaZnY9p/gdW1d90so9w==
X-Google-Smtp-Source: ALg8bN72bvZMYJMsVXiKsMM7tMsKY9kcaZ7QtB3a/HS58keHKE3K+tJyB9vwYwzxtjtFaWLPTM23hg==
X-Received: by 2002:a62:7e13:: with SMTP id z19mr26558245pfc.94.1548000198023;
        Sun, 20 Jan 2019 08:03:18 -0800 (PST)
Received: from [10.0.1.12] (S010620c9d00fc332.vf.shawcable.net. [70.71.167.160])
        by smtp.gmail.com with ESMTPSA id j197sm13886514pgc.76.2019.01.20.08.03.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Jan 2019 08:03:17 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v2] ipmi: Prevent use-after-free in deliver_response
From:   Fred Klassen <fklassen@appneta.com>
In-Reply-To: <3f6be669-0a5f-5b82-aa68-14c97c7df52a@acm.org>
Date:   Sun, 20 Jan 2019 08:03:15 -0800
Cc:     "Arnd Bergmann (supporter:CHAR and MISC DRIVERS)" <arnd@arndb.de>,
        "Greg Kroah-Hartman (supporter:CHAR and MISC DRIVERS)" 
        <gregkh@linuxfoundation.org>,
        "moderated list:IPMI SUBSYSTEM" 
        <openipmi-developer@lists.sourceforge.net>,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <7957E337-A273-4460-9B9D-B165CDDE284F@appneta.com>
References: <A305B9C6-87C8-406A-9A9A-623BE0768FFB@appneta.com>
 <3f6be669-0a5f-5b82-aa68-14c97c7df52a@acm.org>
To:     "Corey Minyard (supporter:IPMI SUBSYSTEM)" <minyard@acm.org>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct, targeting 5.0.

> On Jan 19, 2019, at 5:30 PM, Corey Minyard <minyard@acm.org> wrote:
> 
> I assume you want this for 5.0., right?

