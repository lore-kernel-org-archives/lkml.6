Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65DCFC43142
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 01:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 002CD20851
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 01:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JbFEwak9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 002CD20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732995AbeHADm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 23:42:56 -0400
Received: from merlin.infradead.org ([205.233.59.134]:35262 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732964AbeHADm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 23:42:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=277Iy+4sPJfeRzYPhWfAd6nAGH5xjEwOq/0TOhFii7k=; b=JbFEwak9xs7Pu758Kbu95KDPcd
        6rh1ablVjTP/cxM5Ncmo460Rl1Begj0C1frf9lfCdbtckW94lSFsWYw8t826EHn6iCry+cNo7CHt0
        kx+oSKHjISufvlqB/ZkyyQ7SZ0mw5f+c8n/qrdAGe3SlSVDCUER0aZjpMIzMZFjnt4EwZcyLzo9WY
        WsDp61qQT5iY3mSDf+kaRCxyqUze67XGPuqhqRdUXtBub7u6+03vQSsQpnNgN3cr5WnhyZjwNPWL/
        VX+RoY6jLQcD/T4H/smobsJaf0zUzWOhhx2N7hfKvGPld95sBlI+a0Qz+dfJqaOGPLA6vAZNXtn4c
        HBdAUmmg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fkgQS-0001OB-5z; Wed, 01 Aug 2018 01:59:44 +0000
Subject: Re: [PATCH v2 1/3] overflow.h: Add arithmetic shift helper
To:     Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Bart Van Assche <Bart.VanAssche@wdc.com>,
        Doug Ledford <dledford@redhat.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180801000039.44314-1-keescook@chromium.org>
 <20180801000039.44314-2-keescook@chromium.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <6ce83c62-ef7a-7548-b61f-825a28bffb95@infradead.org>
Date:   Tue, 31 Jul 2018 18:59:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180801000039.44314-2-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/31/2018 05:00 PM, Kees Cook wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
> 
> Add shift_overflow() helper to assist driver authors in ensuring that
> shift operations don't cause overflows or other odd conditions.
> 
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> [kees: tweaked comments and commit log, dropped unneeded assignment]
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/linux/overflow.h | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> index 8712ff70995f..69fc366ce865 100644
> --- a/include/linux/overflow.h
> +++ b/include/linux/overflow.h
> @@ -202,6 +202,37 @@
>  
>  #endif /* COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW */
>  
> +/** check_shift_overflow() - Calculate a left-shifted value and check overflow
> + *
> + * @a: Value to be shifted
> + * @b: How many bits left to shift
> + * @d: Pointer to where to store the result
> + *
> + * Computes *@d = (@a << @s)

                            @b)

> + *
> + * Returns true if '*d' cannot hold the result or when 'a << s' doesn't
> + * make sense. Example conditions:
> + * - 'a << s' causes bits to be lost when stored in *d.
> + * - 's' is garbage (e.g. negative) or so large that the result of
> + *   'a << s' is guaranteed to be 0.
> + * - 'a' is negative.
> + * - 'a << s' sets the sign bit, if any, in '*d'.
> + *
> + * '*d' will hold the results of the attempted shift, but is not
> + * considered "safe for use" if false is returned.
> + */
> +#define check_shift_overflow(a, s, d) ({				\
> +	typeof(a) _a = a;						\
> +	typeof(s) _s = s;						\
> +	typeof(d) _d = d;						\
> +	u64 _a_full = _a;						\
> +	unsigned int _to_shift =					\
> +		_s >= 0 && _s < 8 * sizeof(*d) ? _s : 0;		\
> +	*_d = (_a_full << _to_shift);					\
> +	(_to_shift != _s || *_d < 0 || _a < 0 ||			\
> +		(*_d >> _to_shift) != _a);				\
> +})
> +
>  /**
>   * array_size() - Calculate size of 2-dimensional array.
>   *
> 


-- 
~Randy
