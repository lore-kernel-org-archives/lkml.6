Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E60C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 21:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F317720823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 21:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z47ZkF43"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbfBDVt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 16:49:59 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39130 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbfBDVt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 16:49:58 -0500
Received: by mail-pg1-f196.google.com with SMTP id r11so514369pgp.6;
        Mon, 04 Feb 2019 13:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LmabwM3aDZsYedNLAqRvDhGUacQFcbmdvq2d3bX0bfc=;
        b=Z47ZkF43FpAN8V5h4IqMiC96C/RtYKbVLEMxWMQ7wlK2eEchNxxn3XYhGiStrnY9dL
         5dp+3QjimEk6n9xPNTBcPvmMOYXbQjNsJXvLw/JD7kIN6Du+NEpZwsdK+BY68t7vf+Pj
         /mcbXrTJiaQXUwSQ5jxUyrjpiq/pWrv21K5tueSQ7tNaH37E/N/1YQ0TBO1mojx3pVRN
         wqnYAGdVOEzJY4YrHTc8BpuTo8xmRyW6wRBcVVaQcFuqkF+opnUKgw2fuCnR1+iIf2Pu
         aF+TFqHad2c4znRiIRk5leuUQMPgN2sz7hiWP7EPrreeDjXcjDTcta/YrmFTxYt11Hy5
         cnzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=LmabwM3aDZsYedNLAqRvDhGUacQFcbmdvq2d3bX0bfc=;
        b=RWDGUVKa8SbE3DvGpmiVu0RJG+QKGEEw0sRmRKcbBc0ql+DIaDC3o/Fvv02bhM28Dr
         bkJe/UQXkEDVAiUdyC6WjFV4yB0zGyBV2wTRQoxuzBFXa/aChdI0hrOciDGW++p4t1xz
         OhObj9QFR4VsAXvH2wegIaWNDpR5RsSJhstTJnjcUim95bVIWhzhbQaUxuHri7xxkCrF
         5cqmV4ZhFfCl94FIMJfTkCKKjgTcubtRtCI9gyH8m67xkAgS9x1DxaxKL+J5gw/fnseD
         6xcEsUImQebis6f9RHVw86gre5LWHOuzb4sG4WjRZ9ySw0tDT0p0GjFZDcxoYzrrCdiI
         HxzQ==
X-Gm-Message-State: AHQUAubXuMAcE76j3kcScb+9ki12r0vp8a/FigSlnw4BlLLoNKnm7QZk
        t5EGSruKmxxM5xxqw3qb3wE=
X-Google-Smtp-Source: AHgI3IZQ/eRvhR6HW0AWN7zenN6lAjJvXNDL/bz2z5PWauxpIE5M4URSLCaMVWtB0zwY2cf1vrgeKQ==
X-Received: by 2002:a62:5dd1:: with SMTP id n78mr1508406pfj.58.1549316997610;
        Mon, 04 Feb 2019 13:49:57 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d25sm1620115pfe.40.2019.02.04.13.49.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 13:49:57 -0800 (PST)
Date:   Mon, 4 Feb 2019 13:49:56 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.20 00/80] 4.20.7-stable review
Message-ID: <20190204214956.GF18895@roeck-us.net>
References: <20190204103620.287366543@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204103620.287366543@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 11:36:20AM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.20.7 release.
> There are 80 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Feb  6 10:35:33 UTC 2019.
> Anything received after that time might be too late.
> 

Build results:
	total: 159 pass: 159 fail: 0
Qemu test results:
	total: 343 pass: 343 fail: 0

Guenter
