Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D0FEC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 06:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A09AC2075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 06:51:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A09AC2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbeIGLa4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 07:30:56 -0400
Received: from prv1-mh.provo.novell.com ([137.65.248.33]:56369 "EHLO
        prv1-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbeIGLaz (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:5:1>);
        Fri, 7 Sep 2018 07:30:55 -0400
Received: from INET-PRV1-MTA by prv1-mh.provo.novell.com
        with Novell_GroupWise; Fri, 07 Sep 2018 00:51:27 -0600
Message-Id: <5B921FEE02000078001E6258@prv1-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.0.2 
Date:   Fri, 07 Sep 2018 00:51:26 -0600
From:   "Jan Beulich" <JBeulich@suse.com>
To:     "Marek Marczykowski" <marmarek@invisiblethingslab.com>
Cc:     "xen-devel" <xen-devel@lists.xenproject.org>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
        "Juergen Gross" <jgross@suse.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [Xen-devel] [PATCH] xen/balloon: add runtime control for
 scrubbing ballooned out pages
References: <20180906153355.25363-1-marmarek@invisiblethingslab.com>
In-Reply-To: <20180906153355.25363-1-marmarek@invisiblethingslab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> On 06.09.18 at 17:33, <marmarek@invisiblethingslab.com> wrote:
> --- a/include/xen/mem-reservation.h
> +++ b/include/xen/mem-reservation.h
> @@ -17,12 +17,17 @@
>  
>  #include <xen/page.h>
>  
> +#ifdef CONFIG_XEN_SCRUB_PAGES
> +extern bool xen_scrub_pages;
> +
>  static inline void xenmem_reservation_scrub_page(struct page *page)
>  {
> -#ifdef CONFIG_XEN_SCRUB_PAGES
> -	clear_highpage(page);
> -#endif
> +	if (xen_scrub_pages)
> +		clear_highpage(page);
>  }
> +#else
> +static inline void xenmem_reservation_scrub_page(struct page *page) { }
> +#endif

Wouldn't CONFIG_XEN_SCRUB_PAGES then better become
CONFIG_XEN_SCRUB_PAGES_DEFAULT, with the value used as
initializer of xen_scrub_pages?

Jan


