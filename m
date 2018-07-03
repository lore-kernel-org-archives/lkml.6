Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2EEDC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 13:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92834242BC
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 13:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=chronox.de header.i=@chronox.de header.b="WFCM6l2Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92834242BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chronox.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753348AbeGCN22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 09:28:28 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.167]:24843 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752423AbeGCN21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 09:28:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1530624503;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=NEtxyOBXKZ4euSiZxfEPR1WUwyaRYF1kz5NqQULE+Rk=;
        b=WFCM6l2Zm+zrvxr3pPyn+QVh+XttnBiz5g0WJGB4JqLwN/0ZLh0rCOYHn+KwVfkDrX
        EVwPbQSbO6aIpW+NVTCVOfCui6xmy2xI1rwU+xEXKhH2Ov9BH+IrU0HARNgG1Uh7yD/U
        wUQJxyGL/4urxYRkF3la/MRbb6y50/BYVuAU3cJJl4LLkz9stMcS79aROoQmo6K2d0Gi
        ooM9/mah4eiXs8CYZQ7wp8JoG1og6Jt37GWj5TmmSKT9Rg3y1sTWCtMhAQa/OwgimhwW
        8UAVg0+Rim0F1WDldU5n5x8hXwSO5wytMlvLrrcAK594oPOjbmwEJO//nJmv3NB/cXne
        Ybig==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9zT8DNpa83PTIPmPqerTA7HZWXNBW+90Md7W6RUMSSWpe5PilBm4="
X-RZG-CLASS-ID: mo00
Received: from tauon.chronox.de
        by smtp.strato.de (RZmta 43.10 AUTH)
        with ESMTPSA id V0a65fu63DS5lFs
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Tue, 3 Jul 2018 15:28:05 +0200 (CEST)
From:   Stephan Mueller <smueller@chronox.de>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v3 3/6] crypto: Add Qcom prng driver
Date:   Tue, 03 Jul 2018 15:28:04 +0200
Message-ID: <2990655.vKmMgW600W@tauon.chronox.de>
In-Reply-To: <20180703060434.19293-4-vkoul@kernel.org>
References: <20180703060434.19293-1-vkoul@kernel.org> <20180703060434.19293-4-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 3. Juli 2018, 08:04:31 CEST schrieb Vinod Koul:

Hi Vinod,

> +static int qcom_rng_read(struct qcom_rng *rng, void *data, size_t max)
> +{
> +	size_t currsize = 0;
> +	u32 *retdata = data;

How can you be sure that this cast is appropriate? I.e. how is it guaranteed 
that data is 4-byte aligned?

Also, the data variable in qcom_rng_generate is a u8 -- shouldn't this type be 
used instead of a void?


Ciao
Stephan


