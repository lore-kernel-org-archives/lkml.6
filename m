Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD73C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 16:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D7F620827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 16:10:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D7F620827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731346AbeKHBlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 20:41:22 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33090 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727372AbeKHBlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 20:41:21 -0500
Received: by mail-pf1-f194.google.com with SMTP id v68-v6so4298713pfk.0;
        Wed, 07 Nov 2018 08:10:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F93yraaBxR8bH1RUbZYCy9A7Acu2BwCuS5nwvWvfNCQ=;
        b=ZcrtP4Sxq4maE7Es6i4Z4rdYMOZXQu6CflDoHyX1b4jMXNhTCNecywp0PFuq0jLiSa
         BeCtGJ8hGEF1lnhtB1T2DuvafBBT6CjudKwoJm8rVF8ghkLIp8ywpU5s8CIo+rCsC6++
         ne1TXp9/3gWnRJ1zaJMgr9Fc+mQgI1imr+ytrQW1V2EYfQVpiWyaODUxi5gXYJU5gga5
         aEc4OoueiyFuyZuF2/FF0sTZmpmzR7vFwbKKUV+9mQcEMQH+YGHPp2nKCecKj6lkcSeG
         BTb4X9S/2IJOwXlNc9bir9M3Q5P6FtSPBfB9fJGqyGT4OD3dEuvSEIi82NK7bYXF3CHg
         nqFg==
X-Gm-Message-State: AGRZ1gKvbvjYiFePad5eu/PEzwH+8YDKf25wtfTx7sbCrvFkzKiQ5Ft+
        IN4K2ZqT2P9MRsmZaBCGlhw=
X-Google-Smtp-Source: AJdET5doQHjcKizDKRc3Zwj3v9BRVcPxpPIiIRki6IduSOqohRN+3C+vhNqBuz0GwNQpbCF0Kvbj9w==
X-Received: by 2002:a62:6bc8:: with SMTP id g191-v6mr847474pfc.134.1541607021238;
        Wed, 07 Nov 2018 08:10:21 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id g21-v6sm1040349pgh.82.2018.11.07.08.10.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Nov 2018 08:10:20 -0800 (PST)
Message-ID: <1541607019.196084.210.camel@acm.org>
Subject: Re: [PATCH] block: respect virtual boundary mask in bvecs
From:   Bart Van Assche <bvanassche@acm.org>
To:     Sagi Grimberg <sagi@grimberg.me>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Jens Axboe <axboe@fb.com>
Cc:     Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>
Date:   Wed, 07 Nov 2018 08:10:19 -0800
In-Reply-To: <950a7996-e0f7-ff34-04da-47581a9496f0@grimberg.me>
References: <20181105102301.9752-1-jthumshirn@suse.de>
         <a97f3d77-d23b-b418-abce-2d93ed725bdb@acm.org>
         <c15244a4-9085-5255-edea-b92a9ed1307c@suse.de>
         <950a7996-e0f7-ff34-04da-47581a9496f0@grimberg.me>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-11-06 at 19:30 -0800, Sagi Grimberg wrote:
+AD4 +AD4 +AD4 How about changing that expression into the following to make it easier
+AD4 +AD4 +AD4 for the compiler to optimize this code?
+AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 (offset +AHw (bprv-+AD4-bv+AF8-offset +- bprv-+AD4-bv+AF8-len)) +ACY queue+AF8-virt+AF8-boundary(q)
+AD4 +AD4 
+AD4 +AD4 Uhm I have to admit I'm not really able to parse the above expression.
+AD4 +AD4 Sure GCC will do it but I think it's less readable (at least for me).
+AD4 +AD4 Let's see what other's think.
+AD4 
+AD4 I personally not a huge fan of decoding complicated expressions. But if
+AD4 others are fine with it then I am too...

What I proposed is not a new pattern. It is a pattern that is already used
elsewhere in the Linux kernel. A few examples:

From dmabounce.c:

		/+ACo Figure out if we need to bounce from the DMA mask. +ACo-/
		if ((dma+AF8-addr +AHw (dma+AF8-addr +- size - 1)) +ACY +AH4-mask)
			return 1+ADs

From dma-direct.h:

	if ((addr +AHw (addr +- size - 1)) +ACY +AH4-mask)
		return 0+ADs

Bart.
