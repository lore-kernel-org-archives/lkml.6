Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 945CCC5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 18:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50107208DA
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 18:15:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HsgTJoAQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50107208DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756554AbeFOSPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 14:15:09 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:40493 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756444AbeFOSPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 14:15:05 -0400
Received: by mail-lf0-f68.google.com with SMTP id q11-v6so15897390lfc.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 11:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EX/ew5KqMmTJ2l62+rFeYqOgZLuRFFZxzZDpJ/EkTAY=;
        b=HsgTJoAQICMxmvkVyHXxWBXoPfO1KlAG7rN6MtKcq6NCE5aMTjrXTSmV8qxrt7DOCn
         frEy6WA2FDSwQ72KTKHQjAi96QWt3u57aq0MkBtwGLRr/pJ0iwPiehEjlI2rDTjRWvpq
         O1h9hN3IZM2gbDDDLmACH3Tx6vbl0Imxf8md8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=EX/ew5KqMmTJ2l62+rFeYqOgZLuRFFZxzZDpJ/EkTAY=;
        b=D4Bs40bAEvVgwPA2RHBDPo6vCMdKZS+sGdvdNCXXTjZt/rJv8/VR9VeDfB1FGHl30e
         8G5O2ZEBcj6BBs3Lmx7+xgafI0zGyigQDsfDtDL48dkB4csMsBNIDHCBa0BX+TjMrIFU
         PuZ66H86Tc9mWSljZY4EHVAkW2Uy8YN3N5eVWVtf115HekNKm0hKKOeRDq3pUQUbeYRy
         Zebh8wCONKUjj/Q/EIRiCxzTyDXC6fIDMMVyvFqyb9IkQySRAgePt798lZ2FZpnKmHz/
         V1pM7GmJa6bb6UubSX3LGaPFwRp9AtTsHiHJOKDdAMM93RX50Z6OxhcWO6a6hGUAdybP
         3kfQ==
X-Gm-Message-State: APt69E1fl9jnRxBvcFteTtIxklUUyKTTdAYwYBLilGSiH1PcTdFnBCBN
        A6FTdRyASCbFc9uNgb3jdu2k0w==
X-Google-Smtp-Source: ADUXVKJdFYWwNql4rBHRf0Jq5GDcFyObYU03PcFF1nn6tuDvY9EvDhUzlqX8cYVOk+m4rgvteeV5BA==
X-Received: by 2002:a2e:4dcc:: with SMTP id c73-v6mr1931671ljd.135.1529086504161;
        Fri, 15 Jun 2018 11:15:04 -0700 (PDT)
Received: from khorivan (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id w1-v6sm1586278lfk.59.2018.06.15.11.15.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Jun 2018 11:15:03 -0700 (PDT)
Date:   Fri, 15 Jun 2018 21:15:01 +0300
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc:     grygorii.strashko@ti.com, davem@davemloft.net, corbet@lwn.net,
        akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, vinicius.gomes@intel.com,
        henrik@austad.us, jesus.sanchez-palencia@intel.com, p-varis@ti.com,
        spatton@ti.com, francois.ozog@linaro.org, yogeshs@ti.com,
        nsekhar@ti.com, andrew@lunn.ch
Subject: Re: [PATCH v2 net-next 4/6] net: ethernet: ti: cpsw: add CBS Qdisc
 offload
Message-ID: <20180615181500.GA2332@khorivan>
Mail-Followup-To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        grygorii.strashko@ti.com, davem@davemloft.net, corbet@lwn.net,
        akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, vinicius.gomes@intel.com,
        henrik@austad.us, jesus.sanchez-palencia@intel.com, p-varis@ti.com,
        spatton@ti.com, francois.ozog@linaro.org, yogeshs@ti.com,
        nsekhar@ti.com, andrew@lunn.ch
References: <20180614073650.29659-1-ivan.khoronzhuk@linaro.org>
 <20180614073650.29659-5-ivan.khoronzhuk@linaro.org>
 <20180614080902.GA8377@apalos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180614080902.GA8377@apalos>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 11:09:02AM +0300, Ilias Apalodimas wrote:
[...]

>> +				 "Speed was changed, CBS sahper speeds are changed!");
>typo here, should be shaper

Corrected in v3

-- 
Regards,
Ivan Khoronzhuk
