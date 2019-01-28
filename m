Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE1BC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 20:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F00652177E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 20:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="JvuLOphC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbfA1UIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 15:08:25 -0500
Received: from a9-92.smtp-out.amazonses.com ([54.240.9.92]:58322 "EHLO
        a9-92.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726661AbfA1UIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 15:08:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1548706103;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=1NG3+0lQa0q2Lu/ZORmD6juh0aS+X9Cwa2FxEX8RMho=;
        b=JvuLOphCesaanzYNk2yM9XIrCg8OE4Qh4sCo18E9Z0kGk7JsPqj0bkQIJ2M/Ci7n
        ujgpayRrjhDy93POKRUV/LxnIrm6AqQvzzItZPceVL2P9YvWKR5t8S4XLX2Ynw2/a4j
        hFPE9hRjARLr1mq6WcwXquSeFwonhBqoN7teIcz0=
Date:   Mon, 28 Jan 2019 20:08:23 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Kees Cook <keescook@chromium.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] mm: Prevent mapping slab pages to userspace
In-Reply-To: <CAGXu5jJkf4pKr0WVUcFitZnnUbq3annautZxzYPC0TQaB5HaGA@mail.gmail.com>
Message-ID: <010001689613c1b5-6539225d-b74e-4248-8d8f-5b801c1a333b-000000@email.amazonses.com>
References: <20190125173827.2658-1-willy@infradead.org> <20190128102055.5b0790549542891c4dca47a3@linux-foundation.org> <CAGXu5jJkf4pKr0WVUcFitZnnUbq3annautZxzYPC0TQaB5HaGA@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.01.28-54.240.9.92
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jan 2019, Kees Cook wrote:

> It seems like a fatal condition to me? There's nothing to check that
> such a page wouldn't get freed by the slab while still mapped to
> userspace, right?

Lets just fail the code.  Currently this may work with SLUB. But SLAB and
SLOB overlay fields with mapcount. So you would have a corrupted page
struct if you mapped a slab page to user space.
