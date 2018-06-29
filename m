Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5FEFC6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A12C224E6D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="HywGay0v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A12C224E6D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935046AbeF2SKC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 14:10:02 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53934 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934321AbeF2SJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 14:09:59 -0400
Received: by mail-wm0-f66.google.com with SMTP id b188-v6so3077314wme.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 11:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Wrkm8aqhZ/8HVnWaVqXqyfbv1fFDW8BYMTxe05NtmrM=;
        b=HywGay0vU6lwnrzNXhV6aKPCBactF2i1wiP1cd4+yiFchoArBikAVp2WTKX/OOkT+J
         65Ef/nyy+Rto+aeKAyT0tfTG4FSICF1mMkYQbTbfMxlPtHcvCG7BB7KqGWJsmoSE9u49
         ng4lnB6GfjK5I7i+htQzyG4JZi58vDHG7CD2H2reTh4uTbGl+E5lgaOyBhY/Nmv5HYtC
         kwwbqHwEmxNowxQOu6pks24bqAni05zgZzZ5NS8QKBx/lqXBttRSwLEfs+S7DL7Lw3n7
         cRvWbKgUbuggZIiZWQDstVX9CZNTKaT984cPUrMlJLoKrTAzbIXPluqhcav1nANPPl43
         x9qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Wrkm8aqhZ/8HVnWaVqXqyfbv1fFDW8BYMTxe05NtmrM=;
        b=Hk7RMTJ6ckxITzMoxoe1ZcwzjqP/h1oPjUJxi9J68QAxuV0I9PKYyelY2SFtsWAvbB
         /P+egDJB2aKKwqzQsPIDWdOHSA0fXeX4p+YelLRS2cZXo5z0p2sAxZDI3Yl70PbcXq8M
         UUzB8TU9D4U2FhqdtGA6JJ1iyQY/4vK2WNwI3zPfsyKPzRWtGXfxLSH8cpepDS1O61mV
         pxW4Xtvmv6R7+nwf862SZ59jznVe+R2aydhXi70ZjTByo/XfE5TDWIYWcAWBUPzk9GkF
         kSETvWZ3eVJ0QZghrw7JkiPUzudD1uO2lK7sGT4yCEajYnMsdcrW+vNPRyKesx9xkx/e
         0Thw==
X-Gm-Message-State: APt69E0iJfIYUNuhkvuzT/s6qJ1rxbBU0NIeSnESSTGzFinrtz2B4J33
        73Dqz0SQm90nu/KpL5glyVl53Q==
X-Google-Smtp-Source: AAOMgpfQlo73P2/fbQjKdvY0i0odylu/j/sELGCS1UTqE0FBmqDs5zslbR6AkRyG07sJUJ5zU8bwgA==
X-Received: by 2002:a1c:ce0a:: with SMTP id e10-v6mr2312164wmg.135.1530295798479;
        Fri, 29 Jun 2018 11:09:58 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id j18-v6sm1348756wmh.15.2018.06.29.11.09.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jun 2018 11:09:57 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.86_2)
        (envelope-from <jgg@ziepe.ca>)
        id 1fYxqD-0001Ri-I0; Fri, 29 Jun 2018 12:09:53 -0600
Date:   Fri, 29 Jun 2018 12:09:53 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Winkler, Tomas" <tomas.winkler@intel.com>,
        Azhar Shaikh <azhar.shaikh@intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: require to compile as part of the kernel
Message-ID: <20180629180953.GG379@ziepe.ca>
References: <20180629151005.10899-1-jarkko.sakkinen@linux.intel.com>
 <20180629153141.GE379@ziepe.ca>
 <20180629174743.GC4060@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180629174743.GC4060@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 08:47:43PM +0300, Jarkko Sakkinen wrote:
> On Fri, Jun 29, 2018 at 09:31:41AM -0600, Jason Gunthorpe wrote:
> > > -#if defined(CONFIG_TCG_TPM) || defined(CONFIG_TCG_TPM_MODULE)
> > > -
> > > +#if defined(CONFIG_TCG_TPM)
> > 
> > Huh. This new version is certainly right
> 
> Hmm...
> 
> If the option is kept as tristate, shouldn't this be actually:
> 
> #if defined(CONFIG_TCG_TPM) && !defined(CONFIG_TCG_TPM_MODULE)
> 
> ?

Er, yes, it should be writte as

#if IS_ENABLED(CONFIG_TCG_TPM)

these days

Jason
