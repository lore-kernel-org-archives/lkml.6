Return-Path: <SRS0=itv6=LI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0740C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 06:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9947E208D4
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 06:12:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9947E208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbeHYJuI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Aug 2018 05:50:08 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:47050 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbeHYJuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Aug 2018 05:50:08 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1ftRnw-0005y1-2F; Sat, 25 Aug 2018 14:12:12 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1ftRnp-0002vD-HM; Sat, 25 Aug 2018 14:12:05 +0800
Date:   Sat, 25 Aug 2018 14:12:05 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jeffrey Lien <Jeff.Lien@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        David Darrington <david.darrington@wdc.com>,
        Jeff Furlong <jeff.furlong@wdc.com>
Subject: Re: [PATCH] Performance Improvement in CRC16 Calculations.
Message-ID: <20180825061205.ygrjjazkooqghrqy@gondor.apana.org.au>
References: <1533928331-21303-1-git-send-email-jeff.lien@wdc.com>
 <yq1in4gq5jf.fsf@oracle.com>
 <yq1lg8zb2lp.fsf@oracle.com>
 <20180822062016.GA10356@infradead.org>
 <SN1PR04MB18241CBDC8E4CA5275EE4424EA360@SN1PR04MB1824.namprd04.prod.outlook.com>
 <CAKv+Gu-RwCrdgW69NVpyRLwGPGPCZx+ksTBM7NZk7v0-dzczGg@mail.gmail.com>
 <yq1a7pb9196.fsf@oracle.com>
 <CAKv+Gu8Y7YmyB5rmxaj-SGB7q03in7ijv2cOifwYnhP5CNastw@mail.gmail.com>
 <yq1tvnj780o.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1tvnj780o.fsf@oracle.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 05:46:15PM -0400, Martin K. Petersen wrote:
>
> +#ifdef CONFIG_MODULES
> +	struct module *mod = data;
> +
> +	if (val != MODULE_STATE_LIVE ||
> +	    strncmp(mod->name, "crct10dif", strlen("crct10dif")))
> +		return 0;
> +
> +	/* Fall back to library function while we replace the tfm */
> +	static_key_slow_inc(&crct10dif_fallback);
> +
> +	crypto_free_shash(crct10dif_tfm);
> +	crct10dif_tfm = crypto_alloc_shash("crct10dif", 0, 0);
> +	if (IS_ERR(crct10dif_tfm)) {
> +		crct10dif_tfm = NULL;
> +		goto out;
> +	}
> +
> +	static_key_slow_dec(&crct10dif_fallback);

I don't think this is safe unless you do some kind of locking
which would slow down the data path.  The easiest fix would be
to keep the old tfm around forever, or use RCU if RCU read locking
is acceptable to your use-case.

We already have a notifier mechanism in the crypto API for algorithm
registration events.  However, it currently only notifies for untested
algorithms.  So we need to add an event for tested algorithms and also
export this for use outside of the crypto API.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
