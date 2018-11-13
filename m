Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_SBL,
	URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F3CC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 00:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED581224E0
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 00:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mm6CSmsL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED581224E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730787AbeKMKyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 05:54:08 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44188 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbeKMKyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 05:54:08 -0500
Received: by mail-pg1-f195.google.com with SMTP id w3-v6so4823500pgs.11;
        Mon, 12 Nov 2018 16:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+qyaamFXjA0kFl7kvWIRhxY/7lRxkqcMTrLNXfuuCG0=;
        b=Mm6CSmsLshWf4dNWFSSP72BichEe6HlFMdlxeMT8qQ1VCSNyxsbbftPIaJ2V6dd4Ms
         sRVuniwgNiGfruJSTFaeyMZXve49tGJNsUElHQGkAW5csIzhscDyihPsnunAIdcE5sV7
         HShM/NV/5cjJAtmiVyMjhuYcNmnWCH1T3yRNvc+hYThgRo+kH6t3H84kVz5gw4Ngceo6
         /o93ak65CNCx5US2BKYST0/3UPMWPhBYnW2O5rPSbOXzdYBINR/hVtQ5SSVrnYtjGkRq
         0D6M+EU8F/XogRs12A1C4qGhQk3IuwialWye5nJHTsvHlnFg5Ioad+0a4GcDU5IgarXX
         mePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=+qyaamFXjA0kFl7kvWIRhxY/7lRxkqcMTrLNXfuuCG0=;
        b=WXh0UOZDqKPOiWZ1Cp/WouiM5UKtZ3To05ycVMOfOVjSGWSUZ7RXQKz5eawRcKxrlf
         cZV6aIv50eXX8qkC/XRRrzL9y5kMolNZE5ss4Duny2GsasTmhBufYsfdPqdTXf3qeNSU
         CXEaHZLZ1pf0oL8GYAed2A840pIZuzYp3rwczAb+6DS+a6iIq6270HD7f/Ykxm/2+VtZ
         L+Q/c1vcv0bUdkW+HowP50iXnAa2JSZBQLHwOu99MfQphA0NHtmn+mTA+wJs9x5yFbb8
         0B2Lcb524wkad57qTYJTlCgutfmXOLR5KJpLwVYpOWvAUO9+e4qxMpT8F5gtDmokF4bA
         Gb+Q==
X-Gm-Message-State: AGRZ1gJLsIaHvD93Oyq+B+IDR9yNoUlYcs2QGz9wSVZ+eQKvvW6UcN4A
        gI9iKzoptI0N4cFbo+GOqXo=
X-Google-Smtp-Source: AJdET5eJGnf9LlNfU459qWMNjPgmk9n/0Mmx4x9TEMh0Z+OYo5RhDoWYLq7OgxsSPGW02in1hgXXig==
X-Received: by 2002:a65:5a05:: with SMTP id y5-v6mr2798193pgs.161.1542070709605;
        Mon, 12 Nov 2018 16:58:29 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m3sm26353782pgl.69.2018.11.12.16.58.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 16:58:28 -0800 (PST)
Date:   Mon, 12 Nov 2018 16:58:28 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.19 000/361] 4.19.2-stable review
Message-ID: <20181113005828.GD2997@roeck-us.net>
References: <20181111221619.915519183@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2018 at 02:15:47PM -0800, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.2 release.
> There are 361 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue Nov 13 22:14:55 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 135 pass: 135 fail: 0
Qemu test results:
	total: 291 pass: 291 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter
