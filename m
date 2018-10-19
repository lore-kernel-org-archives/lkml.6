Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_SBL,
	URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E64ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 19:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96E812087A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 19:50:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NaDoqWh0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96E812087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbeJTD55 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 23:57:57 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34730 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727767AbeJTD55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 23:57:57 -0400
Received: by mail-pf1-f194.google.com with SMTP id f78-v6so11164834pfe.1;
        Fri, 19 Oct 2018 12:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Iur8hPsukETw6y4JXqu78UhYQAM+pNXERbH5P7QLFfI=;
        b=NaDoqWh0exJaWToqIodJ1NMmncESpGcxepVyvRsP3bmILPytVtOUx4kVfn415CgYBj
         OGila7/rhW1srktYawt4PIw8e+PwJYt1jEtkIV8q/6MM0Lq1DHeCmJi6nuWpTDiQfDnM
         7EkqvvPD6BTNIpbOryL2IPEQFTkRu1gBKlOCbfJH0eU9RK+++z4ONGvjkhZYRYqC5Cdx
         weNU1DfNo9jg27RZ731qh34lfyDH2u9c95bSmyvzcHYwDX5UnzzOF6CGy3MFi0YJFN6f
         kAdxXVGE0lGDlDiS0U839NE8gblBAi9yFp+gNrLDNMCQ+p27f4sCtOtuKRZNc96lD7lC
         p95A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Iur8hPsukETw6y4JXqu78UhYQAM+pNXERbH5P7QLFfI=;
        b=mKQP/3uo0fZTn2z6ziAy1mwGiyN/W7mPJ7Yz/vrS30QVrx2F7NUuPEFN9IRff/1EYE
         mg5z6AhXJcz8e0yk2MmR6N592J2ckXqzuCZG0UEy0rl89/xvjRFW0zlrdDY9NFtYwWq1
         gJDcAmPowldsu0Sa0WqV36wWm2bteDQPrDDhztQfdgsvDtdSN9QzMB2h4WBodIDJRUDj
         NtxiBwCk5zu5nS/WCb9ZuL21M4o/fgizGoobs66wwpwvwzjKG80+0CjfcLL4QOX8iYHM
         X37X3HmRxC+YE7zPSe/aXk0TSJHGV5nXZvpdR1UVsnlBi+oo2o309S/3gSTmAv50Kmuj
         PDSw==
X-Gm-Message-State: ABuFfojXi56unNnsolriGZ+IgmzGWr7dcGyt/+2/TKSm6XGF0mv6jZLW
        WEUyBwIogdSv2/FLLFKPa5m5khcK
X-Google-Smtp-Source: ACcGV61O2q6wxySpfUfio83Q+TytfESV5x2AC2s9+fo6GyWpKX2At6eZXt9T8EwmmVAh9RGq7IehpQ==
X-Received: by 2002:a63:5b14:: with SMTP id p20-v6mr33522563pgb.56.1539978625536;
        Fri, 19 Oct 2018 12:50:25 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id 84-v6sm30275472pfv.33.2018.10.19.12.50.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 12:50:24 -0700 (PDT)
Date:   Fri, 19 Oct 2018 12:50:23 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/48] 4.4.162-stable review
Message-ID: <20181019195023.GA13552@roeck-us.net>
References: <20181018175427.133690306@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181018175427.133690306@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 07:54:35PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.162 release.
> There are 48 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Oct 20 17:54:03 UTC 2018.
> Anything received after that time might be too late.
> 

For v4.4.161-49-g3918330:

Build results:
	total: 150 pass: 150 fail: 0
Qemu test results:
	total: 285 pass: 285 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter
