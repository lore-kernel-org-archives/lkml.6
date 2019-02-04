Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86AA4C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 21:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 515312077B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 21:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTswcdC6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbfBDVst (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 16:48:49 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44555 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbfBDVss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 16:48:48 -0500
Received: by mail-pf1-f194.google.com with SMTP id u6so530993pfh.11;
        Mon, 04 Feb 2019 13:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xrDrtDjmSgM/JE7vhiDI/5CmjPFYV3NVxpdEEVkx02U=;
        b=VTswcdC65kjVQLNpC1Rcpf/mk7gXVy+QpxiiGLySsTnh7HEbyD9C09fajC+OE3j/zh
         rBnHRkUvuTKTUk7j5gdLmLGFWz3NyTWNq62C74I9Pnv0U16UZ9CrO7LGLPsgxN1XE6te
         hiJxH7zZs6oD3LYNJvVUo7eM2ERdOG45qwaYW16cPWI5qLGwwktRPMk0Be9p1xRx7RWT
         iXK9+nHscLq4OP5hef7VfRea2XaWx6kuGjkYLh1syVRMB64VHOqHSVa1IdVOTiKCsc0y
         wQrNFFVPuDVWPTMgB61U9VW39THDLPwgc9HqLJVOtHFUfVyB9sB2tALhj6AdaFWfywKq
         nWAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=xrDrtDjmSgM/JE7vhiDI/5CmjPFYV3NVxpdEEVkx02U=;
        b=cGinsg4Q1K2w52CyRdxSaDpp9EsTrZr5ytusrkRFImGLyOQ1LC2kZNuj2L8vRC7bDl
         ny2N/rhIyI+xoWCx2jWGYIlOdxfOkSNubpjCkHT5DBeukr9bpaXmsuXeMvneia1krS76
         8u+yTbpm609wevgSOCgpbmEqS8Ep+GltxXWj/kaBhZjF6WsaTrdZQykFXk+pmm2DyzEJ
         oZQF5W0kVvueDPtfQT5ZDQ6+1LNrpVGooFKx0dEirKilglVXZ12HaoRnElaQy7epEFn9
         qCmSYfeLLlGz3ucndWS0C6lF3urZH4bwBHQX3mPSlx0uZ0MkeSiKQy4Ildt2BwmhGYxc
         J0gg==
X-Gm-Message-State: AHQUAuYcHjgOi6vEsIUzhL1P+/djLkZxj9ercDAAXeHMxZhL4b7PNeKT
        hE+AM1gJgSunyKP2ZfBG1P0=
X-Google-Smtp-Source: AHgI3IZlg+lOOmOEtgnblklH9CVu00vLuQEt2OzFCUc7T1sBkGYwug+PAe5F12r57vv6oFfbG3wWeg==
X-Received: by 2002:a63:9348:: with SMTP id w8mr864299pgm.198.1549316928418;
        Mon, 04 Feb 2019 13:48:48 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t3sm1223174pgp.5.2019.02.04.13.48.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 13:48:47 -0800 (PST)
Date:   Mon, 4 Feb 2019 13:48:46 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/30] 4.9.155-stable review
Message-ID: <20190204214846.GC18895@roeck-us.net>
References: <20190204103605.271746870@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204103605.271746870@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 11:36:38AM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.155 release.
> There are 30 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Feb  6 10:35:37 UTC 2019.
> Anything received after that time might be too late.
> 

Build results:
	total: 172 pass: 172 fail: 0
Qemu test results:
	total: 315 pass: 315 fail: 0

Guenter
