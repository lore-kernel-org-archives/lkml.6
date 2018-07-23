Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0870ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67B0720854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="QPuBUgr8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67B0720854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388376AbeGWWwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 18:52:06 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37366 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388134AbeGWWwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 18:52:03 -0400
Received: by mail-wr1-f66.google.com with SMTP id q10-v6so2112439wrd.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 14:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=J58rjo75INmScNxSBcLVzkD3GR29wldtMyHwOGq3XWg=;
        b=QPuBUgr8Vyi7T+70WuxDe0WonfPSL9OhqSSSPuxgiE/FowLbIiP7CU/aOPNErMjZux
         anANCEtM22XQI9yhZiTOsX4hSuA12VESzVpeR3L5y8BffB8E1F0VLHXOVIzuttZRZYOH
         /xZIIckGJfGUJPb4Hc5crzeHguci0ovRdwQ4pdBVMmbYSRs9kiPylUcYlwu4iWNIIct8
         zPrRoh0qarS5CCOn6vmmvnEi4eknGR7RTdGFIgZXleg9J+oTLJbGMFXOMWZXDMqZLqpy
         KR+PivHI8VKQbyY7ZCJGE5+uoZAXjVD+5poaTKqTouZ3bdhD/C3bOH1ySomStWCVukSX
         +uZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J58rjo75INmScNxSBcLVzkD3GR29wldtMyHwOGq3XWg=;
        b=niU9co4Zr+2CtYtptbhHsmNMeRbRpFW3WsG/7I+ZGsv790iLXNwyNrlmkQ6HJVPXhZ
         F1ntKz6R4vCUjoBeASdIVVFmgczfLnAUK/dPsHn7qu3Ym9B2PvuF/mR0tw//5+iSqR9b
         HA3Kr3N6J8elrQhauxp9hFSSjokza2zC5FHrm2xV/Y3V/PjOXk6PK32g3uf2WimhM0/c
         PDaaf9B2czvvXeJpnWW4sMsC2+n6/ufP7XZ4wOjswai4RIq7rIPjPVRShYApb75kzQdV
         x8LRaj1XuaSVAZ9tkaZfdu6L+lyHuwkaAFlZW8NTHihNFdN0ZEjKDWRe9u+ejY96D7VC
         Da+g==
X-Gm-Message-State: AOUpUlEQQrH4l8GpQ2mM5muGkD9mi5905O/+O6KqqKrDcAYQGa0qm8dH
        eTtNmFXfeRfnGWEp87rurHpjUCeuA+XOYQ==
X-Google-Smtp-Source: AAOMgpd/b5H18olgeaKzWhadTzRw7JTbCUWA3L9QgmqbCcQRTFCTtWqxuYiSbp1whLefBlDOQSUvsg==
X-Received: by 2002:adf:c383:: with SMTP id p3-v6mr9803632wrf.68.1532382530799;
        Mon, 23 Jul 2018 14:48:50 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id g204-v6sm18746253wmd.26.2018.07.23.14.48.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 14:48:50 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.86_2)
        (envelope-from <jgg@ziepe.ca>)
        id 1fhihC-0007ma-Tg; Mon, 23 Jul 2018 15:48:46 -0600
Date:   Mon, 23 Jul 2018 15:48:46 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Tadeusz Struk <tadeusz.struk@intel.com>
Cc:     jarkko.sakkinen@linux.intel.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: add support for partial reads
Message-ID: <20180723214846.GG532@ziepe.ca>
References: <153201555276.20155.1352499992826895966.stgit@tstruk-mobl1.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153201555276.20155.1352499992826895966.stgit@tstruk-mobl1.jf.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 08:52:32AM -0700, Tadeusz Struk wrote:
> Currently to read a response from the TPM device an application needs
> provide "big enough" buffer for the whole response and read it in one go.
> The application doesn't know how big the response it beforehand so it
> always needs to maintain a 4K buffer and read the max (4K).
> In case if the user of the TSS library doesn't provide big enough buffer
> the TCTI spec says that the library should set the required size and return
> TSS2_TCTI_RC_INSUFFICIENT_BUFFER error code so that the application could
> allocate a bigger buffer and call receive again.
> To make it possible in the TSS library this requires being able to do
> partial reads from the driver.
> The library would read the header first to get the actual size of the
> response from the header and then read the rest of the response.
> This patch adds support for partial reads.

You should solve this in user space, the kernel API requires a full
sized buffer here, the tss library should always provide such an
internal buffer and then implement whatever scheme TSS wants by
memcpying from that buffer..

Jason
