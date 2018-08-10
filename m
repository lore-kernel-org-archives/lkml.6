Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F691C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 20:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5786721E17
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 20:31:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5786721E17
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbeHJXDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 19:03:12 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:10986 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726834AbeHJXDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 19:03:12 -0400
X-IronPort-AV: E=Sophos;i="5.53,221,1531778400"; 
   d="scan'208";a="342083293"
Received: from abo-214-111-68.mrs.modulonet.fr (HELO [192.168.0.15]) ([85.68.111.214])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Aug 2018 22:31:42 +0200
Date:   Fri, 10 Aug 2018 22:31:41 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Denis Efremov <efremov@linux.com>
cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Subject: Re: [PATCH v2] coccicheck: return proper error code on fail
In-Reply-To: <20180810202555.11034-1-efremov@linux.com>
Message-ID: <alpine.DEB.2.20.1808102230410.2806@hadrien>
References: <20180810133636.8340-1-efremov@linux.com> <20180810202555.11034-1-efremov@linux.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 10 Aug 2018, efremov@linux.com wrote:

> From: Denis Efremov <efremov@linux.com>
>
> If coccicheck fails, it should return an error code distinct from zero
> to signal about an internal problem. Current code instead of exiting with
> the tool's error code returns the error code of 'echo "coccicheck failed"'
> which is almost always equals to zero, thus failing the original intention
> of alerting about a problem. This patch fixes the code.
>
> Found by Linux Driver Verification project (linuxtesting.org).
>
> Signed-off-by: Denis Efremov <efremov@linux.com>

OK, I get it now.  Thanks.

Acked-by: Julia Lawall <julia.lawall@lip6.fr>

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
