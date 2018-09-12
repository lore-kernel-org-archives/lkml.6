Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E9FC4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 10:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 785E4206BB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 10:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GLVcqxsL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 785E4206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbeILPsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 11:48:10 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51714 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbeILPsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 11:48:10 -0400
Received: by mail-wm0-f67.google.com with SMTP id y2-v6so1856725wma.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 03:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=sVIJavO/rnX9lSK2+edzsc2r/jFBPjQS+LrliEEsm14=;
        b=GLVcqxsLcG5wtxv/sUKShKBhEhAk99nEY4/yy0+NOilxVD1yYUf01vs+/9d0nyzGFr
         DaDUq0uX5MhkSd7M48HTbL2bud/MqbqZ1q4Ck2IzAJi6ALYcsAcjonmIg2JPHh5OYLJS
         l+tESmf+6EOI50HX9fI8X1qRo7TDudUANivoI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=sVIJavO/rnX9lSK2+edzsc2r/jFBPjQS+LrliEEsm14=;
        b=k0CM04Q4cRUKc2mdddSvfLFXFNCnuBWFeiuyAcz5EY/VnaeuE7ev5LQcfE4zxJqo31
         1iBXa5e6TYaE6QnZpjVuzlxYJj6oGAO1QITuWEQj+aeXaOCV1O4ZHji0Lnl4eIdT3/+X
         1EHtKx5acQmc7pkQqsewN50Bm8BngE0skSMD3hvKjpma6Zh+cRN0TfqZ/n1Jm+CqDN/F
         q691VG5c52qiSqtY9yRetz625sqAcRozcc7AI5Z/D8rsMdEwcYSd8dAn0fefORdPXwGn
         WQq1u1MFWBZXs+Bf2Cdz2ApeUY71q3bZlc/Hrhz7mDWOu+gs3Wr4coIPLkgoL2cHUST5
         4oEw==
X-Gm-Message-State: APzg51Cz5VLhK/hQjS+PggL4/AsllgMgH6hdi9vdWZ0rguOaB2Lr/dgO
        df5uA+JJRl+txbOCq+lJH0uh0SzzacDiBYBR
X-Google-Smtp-Source: ANB0VdZU6C2qEKPwBiz+tAqluXb53f0mxe4UdB1PzswJzizNRexmttK8s0999dZFSvojx/R78w2RMA==
X-Received: by 2002:a1c:e54:: with SMTP id 81-v6mr1198689wmo.84.1536749050729;
        Wed, 12 Sep 2018 03:44:10 -0700 (PDT)
Received: from dell ([2.27.167.7])
        by smtp.gmail.com with ESMTPSA id w18-v6sm1763640wrc.38.2018.09.12.03.44.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 03:44:09 -0700 (PDT)
Date:   Wed, 12 Sep 2018 11:44:08 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        robh+dt@kernel.org, mark.rutland@arm.com, lgirdwood@gmail.com,
        mazziesaccount@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, heikki.haikola@fi.rohmeurope.com,
        mikko.mutanen@fi.rohmeurope.com
Subject: Re: [PATCH 1/8] regulator: bd71837: Disable voltage monitoring for
 LDO3/4
Message-ID: <20180912104408.GQ4185@dell>
References: <cover.1535545377.git.matti.vaittinen@fi.rohmeurope.com>
 <cad2e7baeb7af2d6efbc6afba831b0513087d832.1535545377.git.matti.vaittinen@fi.rohmeurope.com>
 <20180911124029.GO4185@dell>
 <20180912074745.GD2381@localhost.localdomain>
 <20180912084251.GO4185@dell>
 <20180912085315.GE2381@localhost.localdomain>
 <20180912102316.GC6062@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180912102316.GC6062@sirena.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Sep 2018, Mark Brown wrote:

> On Wed, Sep 12, 2018 at 11:53:15AM +0300, Matti Vaittinen wrote:
> > On Wed, Sep 12, 2018 at 09:42:51AM +0100, Lee Jones wrote:
> > > On Wed, 12 Sep 2018, Matti Vaittinen wrote:
> 
> > > > I m not sure if it is relevant but I think this was already applied to
> > > > Mark's regulator tree.
> 
> > > Where is Mark's acceptance email?
> 
> > https://lkml.org/lkml/2018/8/29/644
> 
> Yeah, sorry about not saying something explict there - IIRC when I
> applied it I knew you were on vacation and it's a stable fix.

No worries.  I know now.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
