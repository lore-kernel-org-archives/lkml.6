Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA14C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 17:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDB7721A31
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 17:17:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MV06CdF0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDB7721A31
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbeHQUVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 16:21:22 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:40108 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726888AbeHQUVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 16:21:22 -0400
Received: by mail-pl0-f67.google.com with SMTP id s17-v6so4003259plp.7;
        Fri, 17 Aug 2018 10:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lmpUPK7rCqAjohqRn9wrZ1aOpmU8eB7i7mdjKV4Mr4E=;
        b=MV06CdF0Kc+J+SzxYIutdYp5OZtgsj+MOc+BkvkZMDea5U7wGTymhjgP7YdWy5Nt8c
         5JU69n7jbthibPqdAHd5r12dtpb4+BdtLP8SKsz4KIG/R7s63bBe/y++uENSmMu59qgq
         rvuTHspBOPPwkNjn3qNGf/OhKzNG+GZbhG8MNzGhOmvqzGaUq/XVOKL3y4Tt6kp663e7
         32JUBHMSH/b14OiTvdo/PMvXf7WdLx4tulRCuAn0GHbX56YCci5inf56ohY9lMCoPzwB
         4a8W/f6kAKCQ7rcnkyJGNkhr4gkyb6iPAXmVrzdA/jqiPwh4i87fSWHqmqNSwgXIyPVe
         cJnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=lmpUPK7rCqAjohqRn9wrZ1aOpmU8eB7i7mdjKV4Mr4E=;
        b=na9pyU6hVeCCwzKlLQvrQMGC/M5TSfteMpZ8N7fMc3iHPAKcoMzu24ompeQXZ13lD7
         KP90NtbXhxbA8o4QqVGlQRsLaDAvyIyzFcHcNj/5wtNlttuTGtetnBhGVJ/GjeVOGY9E
         3oF1OGlhnt2CPRIljGcrq4UGn1HopSKiHuDLNq7baGab/mvU/rWsuQrWWaBAZ7Mg7gop
         cKiNcPmQOoC8aHcLIpE0erxLiHXln4cmipIP1CXsg0qQoJ+y1diYL6d7hne3UTkmEN80
         Dmo5OsrQG7nTXYTG7haQQDw5lTYj1K+h5JOqa88dsczK8Vnwaqpu1iaTJ7nDocmn3yML
         4gzw==
X-Gm-Message-State: AOUpUlGz9z/9TS6MrODcSSghK+RUTTJjabyPladg6tKR1Sx73RnSaxyV
        eBR0TFFhpLVHKEN8p+nT+8k=
X-Google-Smtp-Source: AA+uWPwBor6t0exGNAYMYaHgDvamoQDd8ChdrKcsuAlhjn1q36MGfeQwtc8GwzaZnlFi5+QVcnkH0Q==
X-Received: by 2002:a17:902:76c5:: with SMTP id j5-v6mr34253090plt.296.1534526231565;
        Fri, 17 Aug 2018 10:17:11 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id n24-v6sm4274406pfi.161.2018.08.17.10.17.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Aug 2018 10:17:11 -0700 (PDT)
Date:   Fri, 17 Aug 2018 10:17:10 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/13] 4.4.149-stable review
Message-ID: <20180817171710.GB11442@roeck-us.net>
References: <20180816171628.554317013@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180816171628.554317013@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 08:41:47PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.149 release.
> There are 13 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Aug 18 17:16:16 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 148 pass: 148 fail: 0
Qemu test results:
	total: 269 pass: 269 fail: 0

Details are available at http://kerneltests.org/builders/.

Guenter
