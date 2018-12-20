Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDCBC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 19:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAC13218FD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 19:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p7hE4BDF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731391AbeLTT17 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 14:27:59 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52958 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729721AbeLTT17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 14:27:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8I7T4f+n6L3Wjg4lbpVX56XHJOL1Cvwoq4XgeQJGfHk=; b=p7hE4BDF7/Jlh4w8tSdepkr2O
        rhKokZ1nRsyCUDfkgtU2p3mahXZfnBsD9p8cOOsuGohPigzWH9zlGYEln+vdUfGr1YpduTt+KGqmX
        k/yDOzVTAmq8qen0sUzGAIM9pktuNKwZ5hMZ5IUTr1b7cyFXNP3c1bUimLqWiORJNRE7dkf/kBIyh
        eD77F2trw8Hjgcj14lYqfYONxjha2dDy+r9CgIp5CcaxOUFfBTlQWmjSbA8RMHhrrm+yFfW9mlZrs
        nl2XheEg0hlBqfQTVuMH37owMhQMCydysBz1eqxEKBUJ1KTDYSCTSczJ0WrNN5U/o42rhX2ohGV7T
        gjjsqetHQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ga3z7-0000Ti-RX; Thu, 20 Dec 2018 19:27:53 +0000
Date:   Thu, 20 Dec 2018 11:27:53 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Igor Stoppa <igor.stoppa@gmail.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>, igor.stoppa@huawei.com,
        Nadav Amit <nadav.amit@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        linux-integrity@vger.kernel.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/12] __wr_after_init: x86_64: __wr_op
Message-ID: <20181220192753.GZ10600@bombadil.infradead.org>
References: <20181219213338.26619-1-igor.stoppa@huawei.com>
 <20181219213338.26619-5-igor.stoppa@huawei.com>
 <20181220184917.GY10600@bombadil.infradead.org>
 <d5e8523a-3afd-d992-1af3-b329985c5ed5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5e8523a-3afd-d992-1af3-b329985c5ed5@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 09:19:15PM +0200, Igor Stoppa wrote:
> On 20/12/2018 20:49, Matthew Wilcox wrote:
> > I think you're causing yourself more headaches by implementing this "op"
> > function.
> 
> I probably misinterpreted the initial criticism on my first patchset, about
> duplication. Somehow, I'm still thinking to the endgame of having
> higher-level functions, like list management.
> 
> > Here's some generic code:
> 
> thank you, I have one question, below
> 
> > void *wr_memcpy(void *dst, void *src, unsigned int len)
> > {
> > 	wr_state_t wr_state;
> > 	void *wr_poking_addr = __wr_addr(dst);
> > 
> > 	local_irq_disable();
> > 	wr_enable(&wr_state);
> > 	__wr_memcpy(wr_poking_addr, src, len);
> 
> Is __wraddr() invoked inside wm_memcpy() instead of being invoked privately
> within __wr_memcpy() because the code is generic, or is there some other
> reason?

I was assuming that __wr_addr() might be costly, and we were trying to
minimise the number of instructions executed while write-rare was enabled.

