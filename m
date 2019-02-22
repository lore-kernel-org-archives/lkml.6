Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DFDBC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E42F82070D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I+Jc0aHe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbfBVXb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 18:31:56 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44061 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbfBVXb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 18:31:56 -0500
Received: by mail-pf1-f196.google.com with SMTP id a3so1758690pff.11;
        Fri, 22 Feb 2019 15:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3JT/0JCC4QGNw2v9FJZwC3bjIoju4sGaPJN7iw01RNE=;
        b=I+Jc0aHeCHKUcKn9y6mYQbU2tc2fFnbve3gQ3korLzWPxYp/TKPH9vESK3RIJchedC
         khxehQK7d154+2eEbrKr1e7siukLZsC+M1lWqaR9winZ7WCi/mxwCT1E8sKgBURECzJb
         ungyKIcFMzmgZR9d+K9Az4oud4iwkXyFw49nSQWlBDXsuTZ9wtu9b3ZLRqO5Rnu5xi7X
         Tkb9L/dlf2Hh24N3Qt3O8tPJf53pDWgko0he+QhejXtJSDsq8zLIGPYaXQ8vX642e5AY
         xQFEljKW5s58FtfGcylegsi6LVitzt7S9h73cxTlc9IzGVcIemj8GgzrheZElPFWSIKS
         LkxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=3JT/0JCC4QGNw2v9FJZwC3bjIoju4sGaPJN7iw01RNE=;
        b=nVgerC8nsXcwiZfWuvkVAO9DltGgFANROXLoa1ywLq7jssay94qDqA9aX7F6NbO01Q
         9P7HsJsi/N10kZg3wNQysd19dZZl5QOx7NKGa8zY/2Za9WsKuF3NR79XqQ1DVXoq6vfF
         j7Y2/d6lyLnMFpdGrTB8E25fxzuoP4DDWPqQJVScIsBUrkvshvFr8/YYw/6uWyFrlj9u
         Jg3F1WNAOe53cKjKqS6Nd1H3LVU0z1vqwWQJdfSTy+wNLHa+F/S3qtdatM/RrNUJBDJx
         rB3OsUWPNINPivf2iAHWmsJhUSMkDmD01Rwi68jsX6sOoi/sXY7EoT4skI7TMvZLqUDo
         51fg==
X-Gm-Message-State: AHQUAuapnjcoiaDihdO8ctSulNcqBl/3cgq6RcV5j44qWXSauxSNvq9C
        XtRSKALiq4fK1waRwF9uphA=
X-Google-Smtp-Source: AHgI3Ib4eiDtlTmFEfGWH5Mis4HX9viaNivnNheIYmXmcZIdcm23iih1ov/Hy1Dqy1ARvnJD5zPFVQ==
X-Received: by 2002:a65:6553:: with SMTP id a19mr6358370pgw.267.1550878315667;
        Fri, 22 Feb 2019 15:31:55 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e26sm1762903pfd.124.2019.02.22.15.31.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 15:31:54 -0800 (PST)
Date:   Fri, 22 Feb 2019 15:31:54 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.19 00/30] 4.19.25-stable review
Message-ID: <20190222233154.GE25975@roeck-us.net>
References: <20190221125250.543158526@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221125250.543158526@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 03:35:42PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.25 release.
> There are 30 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Feb 23 12:52:29 UTC 2019.
> Anything received after that time might be too late.
> 
Build results:
	total: 156 pass: 156 fail: 0
Qemu test results:
	total: 343 pass: 343 fail: 0

Guenter
