Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98CB4C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52EFA21A0E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:57:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52EFA21A0E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933208AbeGFO5e (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 10:57:34 -0400
Received: from foss.arm.com ([217.140.101.70]:38254 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932718AbeGFO5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 10:57:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C6E37ED1;
        Fri,  6 Jul 2018 07:57:32 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 959B13F2EA;
        Fri,  6 Jul 2018 07:57:31 -0700 (PDT)
Date:   Fri, 6 Jul 2018 15:57:29 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        "David S . Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        netdev@vger.kernel.org
Subject: Re: [PATCH] ipv4: fib: avoid NULL dereference
Message-ID: <20180706145728.57utqqrjzq7iupnh@lakrids.cambridge.arm.com>
References: <20180706142836.1822-1-mark.rutland@arm.com>
 <3ad39534-400a-8d4e-ac50-94eb5655e565@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ad39534-400a-8d4e-ac50-94eb5655e565@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 07:47:04AM -0700, Eric Dumazet wrote:
> 
> 
> On 07/06/2018 07:28 AM, Mark Rutland wrote:
> > In tnode_free() we iterate over a callback_head list with a while loop.
> > At the start of the loop body we generate the next head pointer, and at
> > the end of the loop body we generate the tn pointer for the next
> > iteration of the loop by using container_of() on the head pointer to
> > find the tnode, and deriving the kv pointer from this.
> > 
> > In the final iteration of the loop, this means that we derive a pointer
> > from NULL, which is undefined behaviour, which UBSAN detects:
> 
> There is no dereference, your patch title is misleading.
> 
> UBSAN might be fooled, not the C compiler.

I'm happy to change the title to "avoid undefined behaviour".

Thanks,
Mark.
