Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C34C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 09:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10A4E21916
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 09:31:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbfBHJbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 04:31:53 -0500
Received: from smtprelay0096.hostedemail.com ([216.40.44.96]:43672 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725998AbfBHJbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 04:31:52 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 698A518020B0A;
        Fri,  8 Feb 2019 09:31:51 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: bag15_2d3764ca31525
X-Filterd-Recvd-Size: 1811
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Fri,  8 Feb 2019 09:31:50 +0000 (UTC)
Message-ID: <061655a972b4037b5bf245a65aed937967410e61.camel@perches.com>
Subject: Re: [PATCH] lib/string.c: make strncmp() smaller
From:   Joe Perches <joe@perches.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Date:   Fri, 08 Feb 2019 01:31:49 -0800
In-Reply-To: <20190208073403.GA19734@avx2>
References: <20190208073403.GA19734@avx2>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-02-08 at 10:34 +0300, Alexey Dobriyan wrote:
> Space savings on x86_64:
> 
> 	add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-29 (-29)
> 	Function                                     old     new   delta
> 	strncmp                                       67      38     -29
> 
> Space savings on arm:
> 
> 	add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-60 (-60)
> 	Function                                     old     new   delta
> 	strncmp                                      116      56     -60
[]
> --- a/lib/string.c
> +++ b/lib/string.c
> @@ -344,16 +344,14 @@ EXPORT_SYMBOL(strcmp);
>   */
>  int strncmp(const char *cs, const char *ct, size_t count)
>  {
> -	unsigned char c1, c2;
> +	while (count--) {
> +		unsigned int c1 = *(unsigned char *)cs++;
> +		unsigned int c2 = *(unsigned char *)ct++;
>  
> -	while (count) {
> -		c1 = *cs++;
> -		c2 = *ct++;
>  		if (c1 != c2)
> -			return c1 < c2 ? -1 : 1;
> +			return c1 - c2;

This does change the return value for most comparisons.

Wasn't there a specific reason for -1 and 1?


