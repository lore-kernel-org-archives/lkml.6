Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8A8C04EBC
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 19:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6D0B20869
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 19:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="UI1iMfCs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6D0B20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbeKSGMR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 01:12:17 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35186 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbeKSGMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 01:12:17 -0500
Received: by mail-pg1-f194.google.com with SMTP id 32-v6so12836814pgu.2
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 11:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zryOOO3i4G0RZadk3n1mevBtzkULwPPOtthGH+PBm4I=;
        b=UI1iMfCsIpKNUEaClrP4qxd6jGpkNrtTSvORNpl8ffq7HhsLpNZV2pWhvtEGrasle4
         CvlX8PcVhFFpJ7MU0KJkuze7X8n+UR4PL8Sup2xfRBO5zYrslrkVMLqHAlWhMZwfWApG
         L8jplictiZaVWuzjnCNzZolaYaMDX8zbzbn3nR55gHah0wtYzf0d8hay1QnJGc/oiSR3
         XyGoLZu3zHg9+610HWp3pDWmaBhVph/sZN5qq4WYaaJrwEnUwLEVH9x5cric16LT9He4
         wBMTm8ufWJUZ0TENc2+6G8dLpWS5enrAU/VVZ5/qdmpDm2n7aclUyJ61ezh7TRIJHnWw
         6dJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zryOOO3i4G0RZadk3n1mevBtzkULwPPOtthGH+PBm4I=;
        b=EES0sZMHNttrwFMokuapsUQkIQQ+hWvfkwbQF1xbR/aCKCvvPVU7BM13L9aVgo2LeH
         QykO+UG3hmSGANo8U6RQWARyy8yL4oqNqs9Um4DStuTpX0WpG3eq+K31He8AAE1iA/20
         CxoF6JnxQxf8CrCGR1JpS/YCbQc9dlOq7GCmcTWAMcMcx0dvMpmms1IALp3rBcm5H/AV
         unM/nvwLPPmDlDpoBjctqdHcdXFdEvTjzO+etbgqkBwwExX/0BkEyW7D3iVoIwAMKRei
         z3oOG8YoQ51cWY710S1QI6QiHpPGEFhR/li+o5Sd6x6O3Y0JRJAeE3RFpehZ/7Qfqjoh
         yC1g==
X-Gm-Message-State: AGRZ1gIC1M1aCBhZEJ1g7DjuHwzFhmnCoeEtw4s9gPByDlebBhc8fYUH
        9zGcgeC9Sh5Xz2TQ3wuBc7be9Q==
X-Google-Smtp-Source: AJdET5cScuGLusCTrcjOlh+d6pQJq7oSLEBkBFsEWOUNHVsM43CU8rW9MP9i196MHHxaHKu5x3x9nQ==
X-Received: by 2002:a63:1f4e:: with SMTP id q14mr16883743pgm.88.1542570666384;
        Sun, 18 Nov 2018 11:51:06 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id s86-v6sm76663915pfa.137.2018.11.18.11.51.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 18 Nov 2018 11:51:05 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gOT60-0005sC-O6; Sun, 18 Nov 2018 12:51:04 -0700
Date:   Sun, 18 Nov 2018 12:51:04 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Peter Huewe <peterhuewe@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 14/17] tpm: remove TPM_TRANSMIT_UNLOCKED flag
Message-ID: <20181118195104.GA21938@ziepe.ca>
References: <20181118124753.18613-1-jarkko.sakkinen@linux.intel.com>
 <20181118124753.18613-15-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181118124753.18613-15-jarkko.sakkinen@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 18, 2018 at 02:47:47PM +0200, Jarkko Sakkinen wrote:
> Added locking as part of tpm_try_get_ops() and tpm_put_ops() as they are
> anyway used in most of the call sites except in tpmrm_release() where we
> take the locks manually.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  drivers/char/tpm/tpm-chip.c       |  2 ++
>  drivers/char/tpm/tpm-dev-common.c |  4 +---
>  drivers/char/tpm/tpm-interface.c  |  8 --------
>  drivers/char/tpm/tpm.h            |  8 ++------
>  drivers/char/tpm/tpm2-cmd.c       | 13 ++++---------
>  drivers/char/tpm/tpm2-space.c     | 15 ++++++---------
>  6 files changed, 15 insertions(+), 35 deletions(-)
 
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index 32db84683c40..157505b0f755 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -58,6 +58,7 @@ int tpm_try_get_ops(struct tpm_chip *chip)
>  	if (!chip->ops)
>  		goto out_lock;
>  
> +	mutex_lock(&chip->tpm_mutex);
>  	return 0;

It really isn't appropriate for something called 'get' to be exclusive
like this.. Call it tpm_try_lock_ops() ?

> diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
> index c7dc54930576..582caefcf19b 100644
> --- a/drivers/char/tpm/tpm-dev-common.c
> +++ b/drivers/char/tpm/tpm-dev-common.c
> @@ -33,7 +33,6 @@ static ssize_t tpm_dev_transmit(struct tpm_chip *chip, struct tpm_space *space,
>  	struct tpm_header *header = (void *)buf;
>  	ssize_t ret, len;
>  
> -	mutex_lock(&chip->tpm_mutex);

The now implicit locking should be tested for using lockdep calls in
all places that assume the lock is held by the caller.

Jason
