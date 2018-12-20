Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E5C1C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6014520989
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="e1CUoWD7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732815AbeLTQVu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 11:21:50 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:58926 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731228AbeLTQVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 11:21:49 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181220162148euoutp017ed4637abca1c8ce825a41236427c783~yFv9pbR_m1769617696euoutp018
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 16:21:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181220162148euoutp017ed4637abca1c8ce825a41236427c783~yFv9pbR_m1769617696euoutp018
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1545322908;
        bh=GcIiR189QgHyaK2S0JAtiEw/GhKl3xmxZyyPMqscAxQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=e1CUoWD7YHoHpW1NxoX9AvPSmygOjjnDdv+MClHAqRmGK/l/F8Kzlpmref73GlkCF
         aqsJMIrkksvZvAfxZjFQ8oJbbFafLBqzD74OLPzF62B+/G+Xs+uSzkYq3lp/arFwNj
         RK+RFgUrB1Qp5+PfYIDEsk2uTOcFmtoNdiLAmcrs=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181220162148eucas1p2a3f14cc8ec4fda24bff14358b6a44170~yFv9WPpjc1233812338eucas1p2O;
        Thu, 20 Dec 2018 16:21:48 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 9A.B9.04441.B91CB1C5; Thu, 20
        Dec 2018 16:21:47 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181220162147eucas1p130510bba852ba0c51f2968b7615dc8a3~yFv8ch4i_1144211442eucas1p1g;
        Thu, 20 Dec 2018 16:21:47 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181220162146eusmtrp2ff200422f139d145bf0119e458b50948~yFv8OY__i2379523795eusmtrp2U;
        Thu, 20 Dec 2018 16:21:46 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-f1-5c1bc19b7c05
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 8E.A5.04284.A91CB1C5; Thu, 20
        Dec 2018 16:21:46 +0000 (GMT)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181220162146eusmtip288d22fae3cea131b30c64c4fc0869caa~yFv8AGPIo3106531065eusmtip2B;
        Thu, 20 Dec 2018 16:21:46 +0000 (GMT)
Subject: Re: [PATCH] fbcon: use kvmalloc() for scrollback buffer
To:     Konstantin Khorenko <khorenko@virtuozzo.com>
Cc:     linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <a7f6bf30-5094-b669-126d-e4751c17dcbb@samsung.com>
Date:   Thu, 20 Dec 2018 17:21:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20181126100253.3299-1-khorenko@virtuozzo.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjleLIzCtJLcpLzFFi42LZduzned3ZB6VjDN7/0Le48vU9m8XjnS9Z
        LU70fWC1uLxrDpsDi8f97uNMHp83yXm83n+IMYA5issmJTUnsyy1SN8ugSvjU28/e0EjT8XB
        G/+ZGhiXcnYxcnJICJhIXG34zdLFyMUhJLCCUWLixPssIAkhgS+MEmu/FUEkPjNKLHt3ggWm
        Y97dpWwQieWMEgtvLWCCcN4zSrz8MJsRpEpYwEHi/82FYLaIgIHEg/19rCA2s0CCxP/zO5lA
        bDYBK4mJ7avAangF7CQ+nOgHs1kEVCWePmoDquHgEBWIkOg/ow5RIihxcuYTsCM4Bawlenq2
        MUKMNJA4smgO1Hh5ie1v5zCD3CMh8JtNYvP/M8wQV7tIfPp6AsoWlnh1fAs7hC0j8X/nfCaI
        humMEm9+LWWBcNYzSqw5c4wJospa4vDxi6wQtqPE7Rm7WEGukxDgk7jxVhBiM5/EpG3TmSHC
        vBIdbUIQ1WoSG5ZtYIPZ1bVzJVSJh8S+3oAJjIqzkLw2C8k7s5C8s4CReRWjeGppcW56arFh
        Xmq5XnFibnFpXrpecn7uJkZg6jj97/inHYxfLyUdYhTgYFTi4b2wXTpGiDWxrLgy9xCjBAez
        kghv4j6gEG9KYmVValF+fFFpTmrxIUZpDhYlcd5qhgfRQgLpiSWp2ampBalFMFkmDk6pBsZJ
        U4RiFr1a6NQZ/ltKNOzuV+1Hhb78QRdEPXSYWsTtXKvXOQpLl2Zfstc/xuIhtnIt+7e2+1tv
        b9irseCo7fp2rfZ9t5lNYh9a8Smtdk7rnlavWPdeR8TzrTRvgg27kXRfllD5iTCLyCcdN45b
        G9nt3bFiy7eY3UUzt2lOXXfL6+XaCtkoZyWW4oxEQy3mouJEADN6j2AZAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphkeLIzCtJLcpLzFFi42I5/e/4Pd1ZB6VjDL5tMra48vU9m8XjnS9Z
        LU70fWC1uLxrDpsDi8f97uNMHp83yXm83n+IMYA5Ss+mKL+0JFUhI7+4xFYp2tDCSM/Q0kLP
        yMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS/jU28/e0EjT8XBG/+ZGhiXcnYxcnJICJhIzLu7
        lK2LkYtDSGApo0THlpfsXYwcQAkZiePryyBqhCX+XOuCqnnLKHF81jt2kISwgIPE/5sLGUFs
        EQEDiQf7+1ghivqAis59YANJMAskSGxe2cgMYrMJWElMbF8F1sArYCfx4UQ/mM0ioCrx9FEb
        E4gtKhAhcethBwtEjaDEyZlPwGxOAWuJnp5tjBAz9SR2XP/FCmHLS2x/O4d5AqPgLCQts5CU
        zUJStoCReRWjSGppcW56brGhXnFibnFpXrpecn7uJkZgTGw79nPzDsZLG4MPMQpwMCrx8Grs
        ko4RYk0sK67MPcQowcGsJMKbuA8oxJuSWFmVWpQfX1Sak1p8iNEU6ImJzFKiyfnAeM0riTc0
        NTS3sDQ0NzY3NrNQEuc9b1AZJSSQnliSmp2aWpBaBNPHxMEp1cAolPj6E2Or545tjSYpx9WS
        bygvMzI4XbPd68aEqlW+sxz6M4XFd2Z9631cMDFl23nRoIuN/LfyI3QmvIxo4RN6UPvmoWb3
        wjXqzwTCjy+9ekzHXiG2vCiXYXPFtYUel5we7s32/r2c2Xy9256g+3tnPTjeq3KzdoKfpaLS
        whkuvTY3zqts136kxFKckWioxVxUnAgAgAQdop8CAAA=
X-CMS-MailID: 20181220162147eucas1p130510bba852ba0c51f2968b7615dc8a3
X-Msg-Generator: CA
X-RootMTR: 20181126100342epcas3p12a1e6505ff4b73375ac3fcf5d0355d3f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181126100342epcas3p12a1e6505ff4b73375ac3fcf5d0355d3f
References: <CGME20181126100342epcas3p12a1e6505ff4b73375ac3fcf5d0355d3f@epcas3p1.samsung.com>
        <20181126100253.3299-1-khorenko@virtuozzo.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On 11/26/2018 11:02 AM, Konstantin Khorenko wrote:
> Scrollback frame buffer is rather big - 32K,
> so it requires 3rd order page, so let's use kvmalloc() instead of
> ordinary kmalloc() for it.

Is it actually safe to use non-contiguous memory for softback_buf?

> Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
> ---
>  drivers/video/fbdev/core/fbcon.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
> index 8958ccc8b1ac..2b1a34d3f5e2 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -992,7 +992,7 @@ static const char *fbcon_startup(void)
>  			if (!softback_buf) {
>  				softback_buf =
>  				    (unsigned long)
> -				    kmalloc(fbcon_softback_size,
> +				    kvmalloc(fbcon_softback_size,
>  					    GFP_KERNEL);
>  				if (!softback_buf) {
>  					fbcon_softback_size = 0;
> @@ -1001,7 +1001,7 @@ static const char *fbcon_startup(void)
>  			}
>  		} else {
>  			if (softback_buf) {
> -				kfree((void *) softback_buf);
> +				kvfree((void *) softback_buf);
>  				softback_buf = 0;
>  				softback_top = 0;
>  			}
> @@ -3665,7 +3665,7 @@ static void fbcon_exit(void)
>  	}
>  #endif
>  
> -	kfree((void *)softback_buf);
> +	kvfree((void *)softback_buf);
>  	softback_buf = 0UL;
>  
>  	for_each_registered_fb(i) {

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
