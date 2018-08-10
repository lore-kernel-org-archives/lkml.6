Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A900C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 13:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAC51223AF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 13:43:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAC51223AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbeHJQNC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 12:13:02 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:21473
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727624AbeHJQNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 12:13:01 -0400
X-IronPort-AV: E=Sophos;i="5.53,219,1531778400"; 
   d="scan'208";a="275506813"
Received: from vaio-julia.rsr.lip6.fr ([132.227.76.33])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Aug 2018 15:43:01 +0200
Date:   Fri, 10 Aug 2018 15:42:54 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Denis Efremov <efremov@linux.com>
cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Subject: Re: [PATCH] coccicheck: return proper error code on check fail
In-Reply-To: <20180810133636.8340-1-efremov@linux.com>
Message-ID: <alpine.DEB.2.20.1808101541270.3390@hadrien>
References: <20180810133636.8340-1-efremov@linux.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 10 Aug 2018, efremov@linux.com wrote:

> If coccicheck finds errors,

What do you mean by finds errors?  Do you mean that there is an error in
the behavior of coccicheck or that coccicheck finds an error in the source
code?

To put it another way, can you give an example of the kind of error you
are concerned about?

thanks,
julia

> it should return an error code
> distinct from zero. Current code instead of exiting with an
> error code of coccinelle returns error code of
> 'echo "coccicheck failed"' which is almost always equals to zero,
> thus failing original intention of alerting about errors.
> This patch fixes the problem.
>
> Found by Linux Driver Verification project (linuxtesting.org).
>
> Signed-off-by: Denis Efremov <efremov@linux.com>
> ---
>  scripts/coccicheck | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/coccicheck b/scripts/coccicheck
> index 9fedca611b7f..e04d328210ac 100755
> --- a/scripts/coccicheck
> +++ b/scripts/coccicheck
> @@ -128,9 +128,10 @@ run_cmd_parmap() {
>  	fi
>  	echo $@ >>$DEBUG_FILE
>  	$@ 2>>$DEBUG_FILE
> -	if [[ $? -ne 0 ]]; then
> +	err=$?
> +	if [[ $err -ne 0 ]]; then
>  		echo "coccicheck failed"
> -		exit $?
> +		exit $err
>  	fi
>  }
>
> --
> 2.17.1
>
>
