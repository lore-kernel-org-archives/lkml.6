Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A15FC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 06:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3DE520839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 06:23:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3DE520839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=guarana.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbeILL0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 07:26:20 -0400
Received: from aws.guarana.org ([13.237.110.252]:48694 "EHLO aws.guarana.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725910AbeILL0U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 07:26:20 -0400
X-Greylist: delayed 526 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Sep 2018 07:26:19 EDT
Received: by aws.guarana.org (Postfix, from userid 1006)
        id 76624A1454; Wed, 12 Sep 2018 06:14:33 +0000 (UTC)
Date:   Wed, 12 Sep 2018 06:14:33 +0000
From:   Kevin Easton <kevin@guarana.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Samuel Neves <sneves@dei.uc.pt>, linux-arch@vger.kernel.org
Subject: Re: [PATCH net-next v3 01/17] asm: simd context helper API
Message-ID: <20180912061433.GA8484@ip-172-31-15-78>
References: <20180911010838.8818-1-Jason@zx2c4.com>
 <20180911010838.8818-2-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180911010838.8818-2-Jason@zx2c4.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 07:08:21PM -0600, Jason A. Donenfeld wrote:
> Sometimes it's useful to amortize calls to XSAVE/XRSTOR and the related
> FPU/SIMD functions over a number of calls, because FPU restoration is
> quite expensive. This adds a simple header for carrying out this pattern:
> 
>     simd_context_t simd_context = simd_get();
>     while ((item = get_item_from_queue()) != NULL) {
>         encrypt_item(item, simd_context);
>         simd_context = simd_relax(simd_context);
>     }
>     simd_put(simd_context);
> 
> The relaxation step ensures that we don't trample over preemption, and
> the get/put API should be a familiar paradigm in the kernel.

Given that it's always supposed to be used like that, mightn't it be
better if simd_relax() took a pointer to the context, so the call is
just

    simd_relax(&simd_context);

?

The inlining means that there won't actually be a pointer dereference in
the emitted code.

If simd_put() also took a pointer then it could set the context back to
HAVE_NO_SIMD as well?

    - Kevin

