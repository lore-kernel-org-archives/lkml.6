Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D5DC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 20:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 934E1206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 20:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KlZlhrvO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732747AbfAPUiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 15:38:12 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38821 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732705AbfAPUiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 15:38:10 -0500
Received: by mail-pf1-f196.google.com with SMTP id q1so3626100pfi.5;
        Wed, 16 Jan 2019 12:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pf9uR/ojB8yVNy0SLrERQnq2uYubUdgCKWSr0z5o4a8=;
        b=KlZlhrvO2kT+82H92/Fl4qP+TNGfcupfsK+oYB1M2yEEygAuqSKoBbIfcbE5sD9WSI
         YR+tr28ej/3KJ5sKdElti6KxHEaLYk5DR2YSLOjgrQPG1P8Ut6iNJ0gD0+ojE7e3XlGv
         7ic+hD3D+6ljXXNCB67vptkHbaG9zDfGcrC1MFdoGjo7qh3SY5OVmOAe0ZrEEhETSKVP
         pXD91VdTkDWLABX3xejiWZp9GrQeI8iWkqoNIZ41dtbK9AxHGMIY075+McQaRgOhYY/A
         kZREVJ0FHfRqJuIQH2LA4bynqwbE8QMJkejzZqWqJ1dq85x27DbaVXHy0qunW51qwOL8
         99aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=pf9uR/ojB8yVNy0SLrERQnq2uYubUdgCKWSr0z5o4a8=;
        b=IQK2LAWUJfaOxsGrq+/44p32FCDSKZNrG3o9wSxY9LzNLLmsnsSMYLPeI1E7hoJT49
         l9UybuHNFkbQsg2yEYZTX4+ZmRPMTtlK8HbSVXkiv/nSmnbHwZYTGTDUeZM03wBjGLHq
         aoU4QGe3bCjMFp3/BP/4ENtDiic+tpaGt69eIAdgk9nTw/RC2xPJH92VhLiejl2usR76
         HKKMUJL+0gE/NSXWS0xb/U/+OeW7X3ArW07BTwjeUSl9OnozNY+YRW2gDhOjY9GARE9R
         scOysd3zqrw+dUlH0CJ5zsXtAxaEN3KutLw5VlFDi0uZOzd5tqLsRUsUJCr2Kmx/DxpS
         iCPg==
X-Gm-Message-State: AJcUukdO1dywjm7CEtKxBvtDlMt6/J0aKeSkaoxOHRd/JoP3CI+tUVIz
        H/4rIXwGWYzXDFCC6rC/sXI=
X-Google-Smtp-Source: ALg8bN5KlAxjfsC0X2TdFADYVJ4pmy4qYd90ziuPHXAOlv3+vfHf6I51ftWuViZQVL0lh2MP6BFdNw==
X-Received: by 2002:a65:4784:: with SMTP id e4mr10468358pgs.12.1547671089494;
        Wed, 16 Jan 2019 12:38:09 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 186sm14031050pga.36.2019.01.16.12.38.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 12:38:09 -0800 (PST)
Date:   Wed, 16 Jan 2019 12:38:08 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.19 00/50] 4.19.16-stable review
Message-ID: <20190116203808.GD1302@roeck-us.net>
References: <20190115154909.933241945@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115154909.933241945@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 05:35:36PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.16 release.
> There are 50 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Jan 17 15:48:36 UTC 2019.
> Anything received after that time might be too late.
> 

Build results:
	total: 156 pass: 156 fail: 0
Qemu test results:
	total: 343 pass: 343 fail: 0

Guenter
