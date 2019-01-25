Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11067C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4B48218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSBdKJ7c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729460AbfAYXRm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 18:17:42 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46455 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfAYXRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 18:17:41 -0500
Received: by mail-pf1-f194.google.com with SMTP id c73so5394694pfe.13;
        Fri, 25 Jan 2019 15:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p7Ji1u/i3fBXwm+yo9HWL4dXm7HKiG6TFF+tY6y3qoM=;
        b=aSBdKJ7cgPeLdmdFH/yyZQDlvVmpac/lErfA9oidqB88YsVixwZdUAOhopv9TfJ3xY
         0afEsiMhvaKa34gLOalo4MXjDfMTjQNHzNKm51MgHz+Sq/76F81l7juDiJNelxX5dECz
         g328tBRz4Utf781hLUGJCmg6qdp+0Mdms9IQHfAs0LV7QN0amRml/PS1Sw6BFtIFnRs1
         c/SSooSkS4s9aR5+xuNcn7LEJNoIdpeeRKDnb/dppxRpM6ef5OtmYCCcM4C7dfuVczjf
         F205TPrv9Iu1hct9iY5ZrZhLI6xbHTuexDS9JQmD8qQsUGJsn/qqfoj86zVagoFCb4Nh
         M34w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=p7Ji1u/i3fBXwm+yo9HWL4dXm7HKiG6TFF+tY6y3qoM=;
        b=Iu6UJi+1Yq5Ejt+cTeo2ijPCHXjVQA2xuzhcAKMHkO9FsEOqM279IzDyMz82XVEXkB
         GLjrBBpel0rp8nFLRDb7OidmnnEoaFt+F8mrs96WpzVya2kMAoBQpLnIDN78U4My6BO6
         cBmUEbJOb68/TRgeIoXhmAK6f55VJ/Ynv/fHJ5+9NAaHQWBKnpIld6FiQ6oNBv/XDfti
         FNf6SR10vDDk1CtxNmgV2lOOmaWv1fBp7lsd4hKpv/5a5P+7fcNH0Wyte64FXYUhHUVd
         GWhCpOnZ9Z9pZCfA9q9Tqn7Ai1gsfmGNOJdVr9AAK4ogvuHY5wglGF+uhwpZMJKCrubs
         E2/A==
X-Gm-Message-State: AJcUukdfoQcEk/7wYAHKYrRj3RnKWBT7zVXV035qiY6HsvmtFXW21qkE
        QJA0v200WpMxvYxFQYcUtr8=
X-Google-Smtp-Source: ALg8bN73xGBvzNg/YYnq65acWymLmoQI8pDifepBFgN3E+AQol+c7bA7KmYschNq1mgy4OruZyoLWw==
X-Received: by 2002:a63:3287:: with SMTP id y129mr11707972pgy.337.1548458261146;
        Fri, 25 Jan 2019 15:17:41 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t24sm49232920pfm.127.2019.01.25.15.17.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 15:17:40 -0800 (PST)
Date:   Fri, 25 Jan 2019 15:17:39 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/39] 4.9.153-stable review
Message-ID: <20190125231739.GC27619@roeck-us.net>
References: <20190124190448.232316246@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124190448.232316246@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 08:20:03PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.153 release.
> There are 39 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Jan 26 19:04:38 UTC 2019.
> Anything received after that time might be too late.
> 

Build results:
	total: 172 pass: 172 fail: 0
Qemu test results:
	total: 315 pass: 315 fail: 0

Guenter
