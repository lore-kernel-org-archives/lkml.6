Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB463C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 20:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADA942081C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 20:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IT/gyBPb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADA942081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbeLGUaw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 15:30:52 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44467 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbeLGUaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 15:30:52 -0500
Received: by mail-pf1-f194.google.com with SMTP id u6so2447276pfh.11;
        Fri, 07 Dec 2018 12:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4F50EdQJU/n8qcX4QRoDjQ1rR/A0b8RjEUOUJQYlWQo=;
        b=IT/gyBPb4xCCSUfeQXPet4denzX4hgZMPahNoJ4UbOyvRVljPB0mwkM2DApLOOmYvX
         jV5QV4f0wGmUKCU0VUG+tbk+JNOsNAdmSOo53azS5VHY9nyhuGltHUQjd21PZOW+l8nq
         5UCtbL93iK8dzhusCNFLDoxXBfJ9Hn3V+sCJlAVHswamwN4Z9IncDBZhh7BAspi/hNM5
         +Y03BwBQbBOed0uSTeL566n7OLnxISH5wPndnbHnLyM5QN4kAjl8Ujrd/9DPD+rG9DxY
         TYjwKiHc4HR3p8qLDOBEeIsdnH6MxLKjRrLAUlGGY9iiK8DhUdvzLaUXQbysHU01bTYC
         yZFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=4F50EdQJU/n8qcX4QRoDjQ1rR/A0b8RjEUOUJQYlWQo=;
        b=pGcm91t3tFAvwMhumq0EwG6wRqiJbgdvGlcthD6C24LnWOWVq/HP9an0TVkpBQn3HX
         lJEw+JULHKXibcRdjBuqyNT3C3FjFYVrMrXRK4CZkSt3nZRZWmluibVtA8gMCv75RySN
         DYPcS2dMnraxd+4Ii+OnJSgEK0V6iSM4gQOV7nQomHneCOoqIOY32JjZzted38GYC+Ch
         HCXOQsY9sAvDtMlQuDUeGdXw0HM5AcKAJI+OcWVjBIjkJHHw0wl3jbsH1i0aTRitaIqe
         k6ALVsH78wBJNWMdC9yBdDneVQ3psQuZD9tF7DrIWxeBs5IeNzuqxcqWtkIi1KzOxKqT
         6z/g==
X-Gm-Message-State: AA+aEWao0COFwEV5ol2pCz0T7GTLSoJNuSGW8cJfGdEEA8LXR69lUqoE
        dN0MvvCbApsbM2kAoSi8SeB1fCCO
X-Google-Smtp-Source: AFSGD/WOp4J0T+7C27y83QpOD7RT+4vrx/zWgF9OQVwaH8E8re/dujhLdxkgcrC2hb59FwxSKsSg8A==
X-Received: by 2002:a63:1560:: with SMTP id 32mr3130597pgv.383.1544214651558;
        Fri, 07 Dec 2018 12:30:51 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p67sm7515595pfg.44.2018.12.07.12.30.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 12:30:50 -0800 (PST)
Date:   Fri, 7 Dec 2018 12:30:49 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.14 00/55] 4.14.87-stable review
Message-ID: <20181207203049.GA16551@roeck-us.net>
References: <20181206143001.749982936@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181206143001.749982936@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 03:38:34PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.87 release.
> There are 55 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Dec  8 14:29:38 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 171 pass: 171 fail: 0
Qemu test results:
	total: 322 pass: 322 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter
