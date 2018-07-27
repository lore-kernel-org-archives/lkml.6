Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3526C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B94820894
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqtMiMK2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B94820894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388930AbeG0Sve (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 14:51:34 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:37355 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388701AbeG0Svd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 14:51:33 -0400
Received: by mail-pl0-f67.google.com with SMTP id 31-v6so2602899plc.4;
        Fri, 27 Jul 2018 10:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=o0kN9xWB8ejFX+pY6HcNmtkGeh+FigQggTIgG/hx6kE=;
        b=dqtMiMK29d3wmZ60/bk7zqwyeJJl4O6ZlHh+w/PvlceDSGalvjowOVLbV2xT3tX1N8
         W/ntH1d4YH/hUDnegfgDsmTCl7ipZbc1jon0VYdQ8n+OTXZPxro0b8F9Eo7lEOAWcOd/
         W8vX4jhqCzgekUXpMTW5aGkrbk1BvNtSIPwTopjfzLqixs15bJmiGNdc5mFi6LMiTAtF
         8N7U2NA6o9nS7dnmjrEnPIFo2Q9zj6b69IEgTauh/NIxT46YHPOf5j3n+nyPZ8/VeLaz
         UnlvEy9whbSQIw4Ur2T+hzeS/ReWXJUY7UQC9VSCitgmOQl9Jbp/+PnAKFM5wdP/BqQY
         Mo6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=o0kN9xWB8ejFX+pY6HcNmtkGeh+FigQggTIgG/hx6kE=;
        b=PrTthp+9asuoH8Q8kzcJTlCzou4gT4SO8OD8/w+fPk4DyzclM/IOMRcc2WiIdy0gMG
         MM1LYt7phSrsTGPDajl1AHAKN+k8esPcmMjhFLAHrxtBzrXDCWj2+Sa6nCL6LWP7UDOx
         Rogfc2KCJOts34LWT4z6U/oOyJHvKBsP3aJyx9NPx4RwAaGUO0IgRajXnq0Uhi8nBtYD
         6PsVjmxuNwzWWzzO8DC2/uRgTCUBBy+GZWhVnKjHm2kzhzrH+1tyxM6BrKJGBzOiYG2z
         rWRexjn1zZE2nSdQZ17mnO6WYvBcLh8y9a5cRLWg06IpErUWh7/XR3Q4luDlfzzZyBvg
         ABxw==
X-Gm-Message-State: AOUpUlHLgCPYc0MP413wIPVqYTWfgOH5FHeq+W+Gb7Wqqfe7Y5Mqs+zV
        zfRiYnLH0GQTb5mmTFOqvM8=
X-Google-Smtp-Source: AAOMgpftXFvnDiAl3MeBFS6AoJ9Hs/iPwxsWGbPccuOQ+F/09/JIKetx8MfwOZNJJ+ibU7TjT2UmZQ==
X-Received: by 2002:a17:902:6802:: with SMTP id h2-v6mr6793681plk.113.1532712521968;
        Fri, 27 Jul 2018 10:28:41 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id r71-v6sm7726168pfg.43.2018.07.27.10.28.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 10:28:41 -0700 (PDT)
Date:   Fri, 27 Jul 2018 10:28:40 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/23] 4.4.145-stable review
Message-ID: <20180727172840.GB4564@roeck-us.net>
References: <20180727100845.054377089@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180727100845.054377089@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 12:09:01PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.145 release.
> There are 23 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Jul 29 10:08:37 UTC 2018.
> Anything received after that time might be too late.
> 

For v4.4.144-24-g7022b47:

Build results:
	total: 148 pass: 148 fail: 0
Qemu test results:
	total: 149 pass: 149 fail: 0

Details are available at http://kerneltests.org/builders/.

Guenter
