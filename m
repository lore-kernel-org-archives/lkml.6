Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68475C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 21:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35515217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 21:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yvj2ODp6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbeL1V2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 16:28:05 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40972 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbeL1V2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 16:28:04 -0500
Received: by mail-pg1-f196.google.com with SMTP id m1so10491059pgq.8;
        Fri, 28 Dec 2018 13:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=W16N4IgOTCNan/Pu7fXQd9AFcZKK1brumlBq45i9eCU=;
        b=Yvj2ODp60xbo4u/m1kFWG8IL3PGaH41x5QE9jCs27WOov0rBO4g0o+9VYBHgwwkZgU
         GWKlNrViqX69zLK4LHYNnJBz7WNpm7VlW+QjfD+2afGFTNCB62bxv4Ndv4JmY2zG0y+G
         Ah5TO0HL4jsgnA6cGoxHNa+7jFrQiKbyukicNUlZ/u/p+PFU/splyZAmqGxH/Y/CNDJU
         uUEBQIqkC0uPuHRB19vpnutwPPE08nU40b8B9r8YbyYEesn0muYpqCliIj+FAEbMZTqr
         qg9Q5yJry0UkHJp5h39kXPKjSomq/lfDx4zMZP6h3ov6qk0prl0541upJqhZHtwNwa+7
         5dOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=W16N4IgOTCNan/Pu7fXQd9AFcZKK1brumlBq45i9eCU=;
        b=i7B4/ikjYvNZWn5gy4+N9ZcurIz7hClWIzFCyftt0Ba+O+qWmBWvV4L55gmmSgClRz
         opuSr3FNUgMjk9Me5IcMlMljiO8SAX6s3DcHNLlQar/RmsYDfiaQ6qO2Q0bxSF5B1+TU
         m8Gz0bTDVE7XPLouavpkCxzFvZFnSIDGnCKRkCe0wABGYNqbnVuYw2A2MqHNh83vzXDu
         SePtXFVHLDDTg7cgxVHFlpwLjA+OP0MzAfW1euxA/xIHd+FbCYIk1kyo1QD14mxT57f/
         fxp/Wxs0JvgGQ5ii/XH3oM2Y6rLRiKUMYXiElObY2TQr/GR1Wp0u3F+j1F08Oi3Jp7HN
         x+sw==
X-Gm-Message-State: AJcUukcCfEcjd8w+iyF/KWt+mELMblY3CsKd1GWJxHJNKghyO5nZXtx4
        u4kJRFo712zuUA9F8PKzE8M=
X-Google-Smtp-Source: ALg8bN7u4kyz+dPWVJJXfTMamfaVv8A9WP3V1TCmxTBz4vrzTMUEUfm6SfG26wjM73yOnwttG/bw5g==
X-Received: by 2002:a63:e001:: with SMTP id e1mr27997744pgh.39.1546032484314;
        Fri, 28 Dec 2018 13:28:04 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e9sm53094846pff.5.2018.12.28.13.28.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Dec 2018 13:28:03 -0800 (PST)
Date:   Fri, 28 Dec 2018 13:28:02 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.14 00/36] 4.14.91-stable review
Message-ID: <20181228212802.GB32706@roeck-us.net>
References: <20181228113126.526729877@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181228113126.526729877@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2018 at 12:52:16PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.91 release.
> There are 36 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Dec 30 11:30:54 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 171 pass: 171 fail: 0
Qemu test results:
	total: 317 pass: 317 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter
