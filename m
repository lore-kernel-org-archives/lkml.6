Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C14C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02CEF218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vNWpGfAj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729496AbfAYXQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 18:16:08 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33384 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbfAYXQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 18:16:08 -0500
Received: by mail-pg1-f193.google.com with SMTP id z11so4818913pgu.0;
        Fri, 25 Jan 2019 15:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=J4qwnAq+iEw/StH89e2B6bA1CQGJWLSxJAzpVB05qmY=;
        b=vNWpGfAjnr2Mj/wx1vYP49rhXVdKFpVodQhUUwCe/AafBaNytn4XMEN8xVBRAjEc3Z
         JRHuwa0crLd/4nMMwiiHEJPMObGo+6rjV/ttIjg6KoASr7Trv+kxhdnBUx1ULyCnpkQp
         sTAsUVx/BETRsTER5aGfRgeuFIFPT1BNlXtYQf7qGrHquMtdMdc9oFNzZTf/Nsf6vNjs
         ceNvmCe4SXxgx+wFBfQujX9gr5Q80jU2pWB/GFf+5z9tYGW+5LIx7+RkAdDboxeUWCl8
         hT+WtWg5CYkn7qWqKopNsXbTaYjAliprG+MC3+Q0QPt2FLwaDlCXmb5ipjRirTp93Nxc
         Urog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=J4qwnAq+iEw/StH89e2B6bA1CQGJWLSxJAzpVB05qmY=;
        b=X3HoLHzv21cYR+AjkutR2lqIPmubzhCwzfV1OiOw8ibIkmmtNECmVA6H8MPtBVFFa8
         ovzBNSTiCCBp3/qPziTjV70ZYqBthc8HUqoTMNZGVgbUKMJqrfGTaHwAwO1lBciDxh+F
         WKl5n+1kp85AFqnggvRGr5sythzfkFxyqMDYF0ioZBmUOFZOS81+89FeKNPwRv6PGhtO
         fFydS4VMaK6S/qKR2BSEbpYTY0939icKHZ3AACSTE8Gmm+m83AweQXF/4QecolafWfUJ
         xa0WQprglI0BDl1yXrfWIvCFSJ3h0ICP6/1BeEPrdxNUorAabOKtz3zurECM1lTsgNPQ
         p4GQ==
X-Gm-Message-State: AJcUukcjVsyj9Od3NsdEtQUhbVHBCMea/kjiFJ6Gdt+zadarw/EpLP0I
        TwVpkvRXd5u9yQwX+eAj7CI=
X-Google-Smtp-Source: ALg8bN4Q3hQFQvWVPLHSflRwMZW4ted0F4sdXlCm4EMPCWzEGLigvO8xW7YapjbN8aFqRHPGt1rt/Q==
X-Received: by 2002:a63:3e05:: with SMTP id l5mr4816562pga.96.1548458167290;
        Fri, 25 Jan 2019 15:16:07 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c72sm50239007pfb.107.2019.01.25.15.16.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 15:16:06 -0800 (PST)
Date:   Fri, 25 Jan 2019 15:16:04 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 3.18 00/52] 3.18.133-stable review
Message-ID: <20190125231604.GA27619@roeck-us.net>
References: <20190124190140.879495253@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124190140.879495253@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 08:19:24PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 3.18.133 release.
> There are 52 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Jan 26 19:01:07 UTC 2019.
> Anything received after that time might be too late.
> 

Build results:
	total: 155 pass: 155 fail: 0
Qemu test results:
	total: 226 pass: 226 fail: 0

Guenter
