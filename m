Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88380C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 02:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 525DE2084D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 02:40:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dLZ3YKCT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbfBLCkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 21:40:01 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50950 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727231AbfBLCkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 21:40:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=A4uV7OxwwlFjvs3auauasxWHYI8sc0UwMreHo8r1FQ8=; b=dLZ3YKCTVAmmJgA0OWYL3TZix
        OyJNL4vPuZLORMjtNHRZbhe5pf5Os3LJ9RGgyAsJ2EvcdT9wRO/a4KjxCqFsuHn+QtCep+ZYZ7QNZ
        MyjJaK/L778ktCQlYqY1wVphX6wGIxwxq+Tb7Pup8hIIFcokg5J3zdlRhNPEoRWK0YNlabtH2E+/I
        1jGsPYqSYmDhgWDsBtcJzkXNmFlrpTV48VRqy6HuWG8l8Vudy/CFPXfqcXAxK0wXDyhMB5Xx3N4LH
        Rw47FZ2vYK4g1S+opcWPmc90V0Gv8y1qfZtig1fjDJ7VwSXvzxOWczW7gRuwdDA2lKuiTvaXk4bGR
        oL34pWb+g==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtNzE-0000DQ-KM; Tue, 12 Feb 2019 02:39:52 +0000
Date:   Mon, 11 Feb 2019 18:39:52 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Igor Stoppa <igor.stoppa@gmail.com>
Cc:     Igor Stoppa <igor.stoppa@huawei.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Nadav Amit <nadav.amit@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ahmed Soliman <ahmedsoliman@mena.vt.edu>,
        linux-integrity@vger.kernel.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v4 01/12] __wr_after_init: Core and default arch
Message-ID: <20190212023952.GK12668@bombadil.infradead.org>
References: <cover.1549927666.git.igor.stoppa@huawei.com>
 <9d03ef9d09446da2dd92c357aa39af6cd071d7c4.1549927666.git.igor.stoppa@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d03ef9d09446da2dd92c357aa39af6cd071d7c4.1549927666.git.igor.stoppa@huawei.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 01:27:38AM +0200, Igor Stoppa wrote:
> +#ifndef CONFIG_PRMEM
[...]
> +#else
> +
> +#include <linux/mm.h>

It's a mistake to do conditional includes like this.  That way you see
include loops with some configs and not others.  Our headers are already
so messy, better to just include mm.h unconditionally.

