Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AECB6C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AC1F21B68
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OP84B78S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438337AbfBNTRO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 14:17:14 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41666 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388100AbfBNTRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 14:17:12 -0500
Received: by mail-pl1-f193.google.com with SMTP id k15so3639904pls.8;
        Thu, 14 Feb 2019 11:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oIQRNGf/7OReEmKw12p15YDKimammGN2plLc7LEyjSU=;
        b=OP84B78SXsEWAyyX6nRiaM+dAmM+RUbN5QawlHKTH2YFm1dgemcPvg2G5jII6LW76T
         L9pDB5lkQ6UG6DbHv/7BG7mOE98a2qtwhhbxS78IjgR8hGw0aNvnuHcC/3Rlu+bgwfpX
         Pe0V9VXWjBhp+odd3tC5bzN9ekPROtCfIXH7NX8Q/gAtVAqdgeDbwp1Mk96A+85LPCQq
         2GBbTWwSJwciTb7rjGoqTnPRnziD50dfjvEqmR25GPOMrQFF6MH8HMsI58acE7Uf/WCP
         jKbVOYDHtwH8zMJjvcRAkPAc59xXQbZ28oerCA658EauTw8RsehTw0tQew4g9GxAmeZ4
         jJtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=oIQRNGf/7OReEmKw12p15YDKimammGN2plLc7LEyjSU=;
        b=AWflvxsS6vSMLqgtGX50piV1RsQZWre/Dn0S5nqnsByPExBY0TOEQ9yNNh56lR8VUj
         oCAO++6FwoItnwyscr1SZ3Zf/xh4ksFjnMzhE/Av8IuTBg0AHNvZt+lGb8te7EDg1oVX
         lBTKN4Ed4UzfUVxPFFRc7XN1JRytvbsYCQeCB/4AdieD5vZoHNPGeKypGo484HY4xr/D
         PUF1gx6mCf0bZaUu6QDfI8qDmSXKodn91NvUCPRBFY37bJLVAn+w2NYdzfn8gfsWDHe1
         BcMjaADhy80BaCmZo4QGk+Iho0K4PgVZFp3W7QIQ17N2u2Sj2M9E/PrMNDCG2FfH2KL6
         Pl6A==
X-Gm-Message-State: AHQUAub/dQMSwqJ7RN4hXv00LcKT733W6/aVETH0i1FlvsW1idWLG9Se
        mfeVN6LEKmCpSpmiUhxpse4=
X-Google-Smtp-Source: AHgI3IaydHX2DQ510IeDTCDmYi+WVo8yZnS6b4RjJoE22aKOODzo1LPnk2/Six784jHn+8mWEpzhxA==
X-Received: by 2002:a17:902:1486:: with SMTP id k6mr5990926pla.49.1550171832366;
        Thu, 14 Feb 2019 11:17:12 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x2sm5432013pfx.78.2019.02.14.11.17.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 11:17:11 -0800 (PST)
Date:   Thu, 14 Feb 2019 11:17:10 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.14 00/35] 4.14.100-stable review
Message-ID: <20190214191710.GB29429@roeck-us.net>
References: <20190213183706.176685027@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213183706.176685027@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 07:37:55PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.100 release.
> There are 35 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri Feb 15 18:36:47 UTC 2019.
> Anything received after that time might be too late.
> 

Build results:
	total: 172 pass: 172 fail: 0
Qemu test results:
	total: 328 pass: 328 fail: 0

Guenter
