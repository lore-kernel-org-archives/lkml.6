Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08647C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBCDF21486
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:14:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBCDF21486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbeJSBQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 21:16:17 -0400
Received: from smtprelay0188.hostedemail.com ([216.40.44.188]:35741 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727567AbeJSBQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 21:16:17 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id A2334100E86CB;
        Thu, 18 Oct 2018 17:14:21 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: anger21_7d31c57346d5f
X-Filterd-Recvd-Size: 1759
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Thu, 18 Oct 2018 17:14:20 +0000 (UTC)
Message-ID: <10d9618bf794d6e07b537455344b30238d5f4e80.camel@perches.com>
Subject: Re: [PATCH] pstore: Refactor compression initialization
From:   Joe Perches <joe@perches.com>
To:     Kees Cook <keescook@chromium.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org
Date:   Thu, 18 Oct 2018 10:14:19 -0700
In-Reply-To: <20181017214124.GA8239@beast>
References: <20181017214124.GA8239@beast>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-10-17 at 14:41 -0700, Kees Cook wrote:
> With compression initialization now separated from pstore_register(),
> there is no longer a good reason to do compression method selection
> during fs init. Instead, merge everything together into the late init.
> Additionally cleans up the reporting to be more clear.
[]
> diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
[]
> @@ -274,36 +274,56 @@ static int pstore_decompress(void *in, void *out,
[]
> -	big_oops_buf = kmalloc(big_oops_buf_sz, GFP_KERNEL);
> -	if (!big_oops_buf) {
> -		pr_err("allocate compression buffer error!\n");
> +	buf = kmalloc(size, GFP_KERNEL);
> +	if (!buf) {
> +		pr_err("Failed %d byte compression buffer allocation for: %s\n",
> +		       size, zbackend->name);

Given that there is a generic OOM message emitted on
kmalloc failures, rather than expanding the unnecessary
alloc failure message, how about just deleting it instead?


