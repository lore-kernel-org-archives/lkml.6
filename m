Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D8ECC43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 20:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDA7D2083A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 20:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ivKCmQao"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDA7D2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933395AbeFTUuL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 16:50:11 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35730 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933154AbeFTUuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 16:50:09 -0400
Received: by mail-wr0-f193.google.com with SMTP id l8-v6so860445wrr.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 13:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ChEnIbOwGkKMzyw5slbj/UgB02Q0aIEQpruY+BOwZ3g=;
        b=ivKCmQaoYOLrsumVaTvZ/PvN1ZZ2UATptOEdGIsXE83lSTj6g8hUey6mdsky9pbrqM
         GxDnYOoEEBjGYYzVXaJMNVPolUUcoTa1DczAU3tIiupukcEfsB9fDvXP17iniOjz36fW
         LC/QJH/OGtZNsBfe90F3e2DTIXPwdvrFkzdJ9oKZrrjyZ2h88nqnfRnj0FISuhvOhI3X
         TE3WvnkrD2It+x77Sn5wvdPGKY+TrO6X7BGTGB45u/WvwpouNZnWVdmvX5HZuBdP+6ha
         C4NUomCl9odVvogEmi+exAyUBTSXNBCitJaY3GV92iFHuTJPvAKDyFaOvM31fY+idF88
         aF9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ChEnIbOwGkKMzyw5slbj/UgB02Q0aIEQpruY+BOwZ3g=;
        b=U2SCx7l5DI8fajBEgkzmd63YTlxTi0SdDWn/iDH07O5xH3aoitzla/WXTd0kKNzWw5
         XBwIg2aUSX+jRk4GePqup/xGd6B1WVYQ3bXsT5UOrqzcyTJW9gdT/jTPFS6wGMULUCw7
         k/IA7jNpJ6ZRnGai5YBzGD1FshJ6kYERTAeqRWWEXc60p9vCNWGN77U3K399+u01l3Lz
         nge+dNPuSCB2koIl8if4yjfMnSUXgrJZ4C7BrDZWcwzmnSXGVD3VDPesfm2j9RKApSXb
         3IGTLD80B9izsGCgMzbO0LccqMkijE5qOX43RMMN3cnzgWnxJ2kMzO1XyN4enfvYAT9L
         N2wA==
X-Gm-Message-State: APt69E2NZcgkPpo1CT1CT7a8ltOuL/xr3xDbdImeYZFB0ixwvOEg/mqH
        UxzJxQO4wjnLakdLt4+cOlNZFw==
X-Google-Smtp-Source: ADUXVKKaj7z83c5nytpLimhgZJMZv77uXEdW62pE/SfX+pRum6G23XCmVZAyLsD4HzlACZx2BLtMZA==
X-Received: by 2002:adf:8f23:: with SMTP id p32-v6mr18654574wrb.193.1529527808536;
        Wed, 20 Jun 2018 13:50:08 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id b15-v6sm6217799wri.14.2018.06.20.13.50.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 13:50:07 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.86_2)
        (envelope-from <jgg@ziepe.ca>)
        id 1fVk3I-00014h-4y; Wed, 20 Jun 2018 14:50:04 -0600
Date:   Wed, 20 Jun 2018 14:50:04 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     linux-integrity@vger.kernel.org, jarkko.sakkinen@linux.intel.com,
        zohar@linux.vnet.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] tpm: Implement tpm_chip_find() and tpm_chip_put()
 for other subsystems
Message-ID: <20180620205004.GG27445@ziepe.ca>
References: <20180620204236.1572523-1-stefanb@linux.vnet.ibm.com>
 <20180620204236.1572523-2-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180620204236.1572523-2-stefanb@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 04:42:33PM -0400, Stefan Berger wrote:
> Implement tpm_chip_find() for other subsystems to find a TPM chip and
> get a reference to that chip. Once done with using the chip, the reference
> is released using tpm_chip_put().
> 
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
>  drivers/char/tpm/tpm-chip.c | 37 +++++++++++++++++++++++++++++++++++++
>  include/linux/tpm.h         |  9 +++++++++
>  2 files changed, 46 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index 0a62c19937b6..eaaf41ce73d8 100644
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -81,6 +81,43 @@ void tpm_put_ops(struct tpm_chip *chip)
>  EXPORT_SYMBOL_GPL(tpm_put_ops);
>  
>  /**
> + * tpm_chip_put() - Release a ref to the tpm_chip
> + * @chip: Chip to put
> + */
> +void tpm_chip_put(struct tpm_chip *chip)
> +{
> +	if (chip)
> +		put_device(&chip->dev);

Rarely like to see those if's inside a put function.. Does it actually
help anything?

Jason
