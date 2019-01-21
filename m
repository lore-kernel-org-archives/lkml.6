Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127A0C3712F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 22:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C99D02089F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 22:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="GuRKALKV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbfAUWCi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 17:02:38 -0500
Received: from a9-34.smtp-out.amazonses.com ([54.240.9.34]:51214 "EHLO
        a9-34.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725993AbfAUWCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 17:02:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1548108156;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=OJCgqsaZ+wmR6x0X309IC98tvTtpLA7MmmS/XOpDQfc=;
        b=GuRKALKV2VCcr4jAbByx0u0oiNeiB4CSPat1WTFMtNriM8UmrZ/OntXWBFDYRvMe
        elpi405dUNq+OuDa8zhLri7SlJ3XFdTVKrMt1Z8CWIRgEu8L6W2+Q8ypTqiG8N7yfcN
        EESFVbiUwIJPQprgTCvW5t0Ar0FRiBrf/RmXa1ik=
Date:   Mon, 21 Jan 2019 22:02:36 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Miles Chen <miles.chen@mediatek.com>
cc:     Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] mm/slub: use WARN_ON() for some slab errors
In-Reply-To: <1548063490-545-1-git-send-email-miles.chen@mediatek.com>
Message-ID: <01000168726fcf15-81d8feb3-26f0-44d6-bbd8-62aa149118b5-000000@email.amazonses.com>
References: <1548063490-545-1-git-send-email-miles.chen@mediatek.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.01.21-54.240.9.34
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jan 2019, miles.chen@mediatek.com wrote:

> From: Miles Chen <miles.chen@mediatek.com>
>
> When debugging with slub.c, sometimes we have to trigger a panic in
> order to get the coredump file. To do that, we have to modify slub.c and
> rebuild kernel. To make debugging easier, use WARN_ON() for these slab
> errors so we can dump stack trace by default or set panic_on_warn to
> trigger a panic.

These locations really should dump stack and not terminate. There is
subsequent processing that should be done.

Slub terminates by default. The messages you are modifying are only
enabled if the user specified that special debugging should be one
(typically via a kernel parameter slub_debug).

It does not make sense to terminate the process here.
