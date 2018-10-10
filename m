Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 546A3C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 05:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F043A20841
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 05:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NmGFC3c7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F043A20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbeJJMtk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 08:49:40 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42381 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbeJJMtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 08:49:40 -0400
Received: by mail-pl1-f195.google.com with SMTP id c8-v6so1929576plo.9
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 22:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yJFVrvf+cQkTsAF1Rr3EythDJUmZa+judaXCLXCjERY=;
        b=NmGFC3c7UcjWCR1H80F/F6A8GPdnUUTfjsrjZmQWnSP5Xpt+i5p2UFOAMZykyzcIYf
         0lfBRaN11f7cOzlgzorEwbcjcscDz+ZWf/WPjqYZ0A1N30K49ck5vCWTjsDzhY8ZlPCN
         5rmtXUCSoG+4EcCDlJBhg/0iKhPK+Wb1f2OMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yJFVrvf+cQkTsAF1Rr3EythDJUmZa+judaXCLXCjERY=;
        b=BDvPmMwfaBQqscBGHL+Z5Ubsqqlsc+zgo1RJt65UxzYu0qRGllIhd7/i5XdJTZC8zN
         ks5JnpCI2ybmUnJ/t6+JM/OurzkCCgsxh73lgnJVHowrFlROvp0eahigOM4quTVldS5Y
         rBMcy/hgisz+PjZcvmauSDM+CsVWEfxuWx/4GegvurrKoKVvFKGhY058lZzdl++3N/FI
         CkV9CDS2tSYLavV84sw1pud6YEnNVdg8TcW+wcpGCbM86sMuEC52v9TD7O0PnF16d/8c
         oqT8hVT6YNBOkQRaEStm/mKMu4L6XXf46pRD/0nQf/H0rF5HGoUMjBZO1uEAjoJxpmnf
         0xIw==
X-Gm-Message-State: ABuFfoimL3jsylbXBVQVZWYktAG6EZe4+iDpDtsbHMb6flKaJztzBDpz
        grEOcNdfzbE3NQnNJ9Li9jLEuQ==
X-Google-Smtp-Source: ACcGV624BRYMlZuKePAtZHYglz92xb8PGX8GVL+uSOaExa6ARK+rF8yq/S//jqr6g8UENbFCPGxkMA==
X-Received: by 2002:a17:902:3041:: with SMTP id u59-v6mr30990779plb.99.1539149354029;
        Tue, 09 Oct 2018 22:29:14 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id g17-v6sm36942871pfe.37.2018.10.09.22.29.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 22:29:13 -0700 (PDT)
Date:   Tue, 9 Oct 2018 22:32:06 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Loic Pallardy <loic.pallardy@st.com>
Cc:     ohad@wizery.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnaud.pouliquen@st.com,
        benjamin.gaignard@linaro.org, s-anna@ti.com
Subject: Re: [PATCH v4 12/17] remoteproc: modify vring allocation to rely on
 centralized carveout allocator
Message-ID: <20181010053206.GA20016@builder>
References: <1532697292-14272-1-git-send-email-loic.pallardy@st.com>
 <1532697292-14272-13-git-send-email-loic.pallardy@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532697292-14272-13-git-send-email-loic.pallardy@st.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 27 Jul 06:14 PDT 2018, Loic Pallardy wrote:
>  int rproc_fw_sanity_check(struct rproc *rproc, const struct firmware *fw)
> diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
[..]
> @@ -114,6 +122,10 @@ static struct virtqueue *rp_find_vq(struct virtio_device *vdev,
>  	rvring->vq = vq;
>  	vq->priv = rvring;
>  
> +	/* Update vring in resource table */
> +	rsc = (void *)rproc->table_ptr + rvdev->rsc_offset;
> +	rsc->vring[id].da = mem->da;
> +

This would now happen after we've started the remoteproc. Don't we need
to do this in-between allocating the carveouts and booting the
remoteproc?

Regards,
Bjorn
