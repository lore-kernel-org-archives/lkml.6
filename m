Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7155EC282C5
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 19:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4429621872
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 19:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="P1Evooh0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfAWTSF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 14:18:05 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42446 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbfAWTSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 14:18:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9TxsPBM3jjXfVOkRBw/Td/M3gJ46TOrrJlMH4ZHJ0Lc=; b=P1Evooh0cZ31Vg3yJPMvCI5MF
        CC4YBr/I1nCsU/rqUkDI1fV8Fvg4YGT43qI7wCHMpuOgMf5qtqld9gwF6JfYnCnFyVXQIJBqZqxKf
        +bXh52Xuy8K9WkZlAHjLkFnoR0xSu90bX6HTDIw0irhqObr4H6eqbtd9kXiAye23pHVJO/RKrVfJm
        wNphHaylDyKMeEoKt11LT9KvYUcIlkJ+556RxfH9Qpm4xmKK7vzyStJCyhZGt5UbGBf76tLO7MXgw
        ofEKY62IMmhGnvY/zNmeOv+oxFFrJlpF+/pDa+gmT7EiT+uBtsSwuxI3eWvobtIa9Y2+jQCIFGt9g
        vqukkVMFw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gmO2E-0001t7-R4; Wed, 23 Jan 2019 19:18:02 +0000
Date:   Wed, 23 Jan 2019 11:18:02 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, dev@openvswitch.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        netdev@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org,
        kernel-hardening@lists.openwall.com,
        intel-wired-lan@lists.osuosl.org, linux-fsdevel@vger.kernel.org,
        xen-devel@lists.xenproject.org, Laura Abbott <labbott@redhat.com>,
        linux-kbuild@vger.kernel.org,
        Alexander Popov <alex.popov@linux.com>
Subject: Re: [Intel-gfx] [PATCH 1/3] treewide: Lift switch variables out of
 switches
Message-ID: <20190123191802.GB15311@bombadil.infradead.org>
References: <20190123110349.35882-1-keescook@chromium.org>
 <20190123110349.35882-2-keescook@chromium.org>
 <20190123115829.GA31385@kroah.com>
 <874l9z31c5.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874l9z31c5.fsf@intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 04:17:30PM +0200, Jani Nikula wrote:
> Can't have:
> 
> 	switch (i) {
> 		int j;
> 	case 0:
>         	/* ... */
> 	}
> 
> because it can't be turned into:
> 
> 	switch (i) {
> 		int j = 0; /* not valid C */
> 	case 0:
>         	/* ... */
> 	}
> 
> but can have e.g.:
> 
> 	switch (i) {
> 	case 0:
> 		{
> 			int j = 0;
> 	        	/* ... */
> 		}
> 	}
> 
> I think Kees' approach of moving such variable declarations to the
> enclosing block scope is better than adding another nesting block.

Another nesting level would be bad, but I think this is OK:

	switch (i) {
	case 0: {
		int j = 0;
        	/* ... */
	}
	case 1: {
		void *p = q;
		/* ... */
	}
	}

I can imagine Kees' patch might have a bad effect on stack consumption,
unless GCC can be relied on to be smart enough to notice the
non-overlapping liveness of the vriables and use the same stack slots
for both.
