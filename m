Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 536E3C64EB4
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 10:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23D98206B7
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 10:47:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23D98206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=strongswan.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725828AbeLBKrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 05:47:47 -0500
Received: from sitav-80046.hsr.ch ([152.96.80.46]:47538 "EHLO
        mail.strongswan.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbeLBKrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 05:47:47 -0500
Received: from book (unknown [IPv6:2a01:2a8:8506:9001:6fd1:b471:395b:f578])
        by mail.strongswan.org (Postfix) with ESMTPSA id 5B28D40403;
        Sun,  2 Dec 2018 11:47:42 +0100 (CET)
Message-ID: <acad781e9981c49b83b6dfdc8cefed6246df469a.camel@strongswan.org>
Subject: Re: [PATCH v2 3/6] crypto: x86/chacha20 - limit the
 preemption-disabled section
From:   Martin Willi <martin@strongswan.org>
To:     Eric Biggers <ebiggers@kernel.org>, linux-crypto@vger.kernel.org
Cc:     Paul Crowley <paulcrowley@google.com>,
        Milan Broz <gmazyland@gmail.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org
Date:   Sun, 02 Dec 2018 11:47:42 +0100
In-Reply-To: <20181129230217.158038-4-ebiggers@kernel.org>
References: <20181129230217.158038-1-ebiggers@kernel.org>
         <20181129230217.158038-4-ebiggers@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> To improve responsiveness, disable preemption for each step of the
> walk (which is at most PAGE_SIZE) rather than for the entire
> encryption/decryption operation.

It seems that it is not that uncommon for IPsec to get small inputs
scattered over multiple blocks. Doing FPU context saving for each walk
step then can slow down things.

An alternative approach could be to re-enable preemption not based on
the walk steps, but on the amount of bytes processed. This would
satisfy both users, I guess.

In the long run we probably need a better approach for FPU context
saving, as this really hurts performance-wise. For IPsec we should find
a way to avoid the (multiple) per-packet FPU save/restores in softirq
context, but I guess this requires support from process context
switching.

Best regards
Martin

