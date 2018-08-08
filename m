Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F61C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D140E2175F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ureV4Da8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D140E2175F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbeHHSZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 14:25:49 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42966 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727081AbeHHSZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 14:25:49 -0400
Received: by mail-pf1-f193.google.com with SMTP id l9-v6so1356591pff.9;
        Wed, 08 Aug 2018 09:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ekrnW1OoMJI9DS3Gt1QcFmblNTOBnHIJPdWrMP6lHvw=;
        b=ureV4Da8KbNlq2zfGF6cAK2VLYJRJp2dibiCYIQSmGRdxNTtx6oRiNKKO9wmeutoxR
         hNFojPQpntGwYwQY34BuNRwQgwi5RFZ1/Qs61PxRdRuef8XG6p3jJhQBHdlRUp7AkZJv
         kEl9YDqYIryzuPcNH0fZ84a92+fb5+XeBAZsQ12Dl5vgLY1IplSfYb8VlMQ2STGRh3ak
         ls5ZvemYznk58mMyHyC16vCqT5oo699LTL0vhh7slx6nFxCyRCOVajVjGO7agSWnb5wU
         OcsKiGGkUxcZHTsV0oGN/B/FrVZwQh5ryXfYh4sd7A8PNWvihvsAkY7turPlvpkXgUB2
         qfEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ekrnW1OoMJI9DS3Gt1QcFmblNTOBnHIJPdWrMP6lHvw=;
        b=O59nK7S4ImuXAogeLgvhHsheF87jIxSR2MYzLkaeX17/8WE/zR68AsxSnnBPJ1//At
         DiGhz2O8bMB24E/Q18udJnpJ9qE2pcTzlWmeJswla/2SukAedc/2bPWjth33SnnXPMoH
         oGm1xffM2yXXGppD/jbXKXU/9n4aQ4S0Uw79QEbgvOLpp+I0/t4zRGS4PzfjLdBZ525a
         YC7DZfMaE/UJ2eB/AXZEP/17iHody9ciWSr807429W6jJOWBa6ankkMEd2KvtDAcr/Wg
         um42WvA81COM0KNCLQidakPuNDU5ock4m+N/Wy27MEuQnQ6QILfGzfaA6dcLMhjXbRvJ
         Nrxw==
X-Gm-Message-State: AOUpUlFPa8YCDHWYGO+jvQQQwCueLkKIs+upojgiRcb8GmVQJYWD1VZm
        c9sSqkrZml4YkpzTW2pjQr8=
X-Google-Smtp-Source: AA+uWPztdsFbM/nB6SPVukhhR36LJEDHvc+m86zAldfzZTOeXp1mXK/A4TrGOYyOXNWa+EbIIvDLPQ==
X-Received: by 2002:a63:4a61:: with SMTP id j33-v6mr3178747pgl.436.1533744330033;
        Wed, 08 Aug 2018 09:05:30 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id w16-v6sm11383918pfi.101.2018.08.08.09.05.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 09:05:29 -0700 (PDT)
Date:   Wed, 8 Aug 2018 09:05:27 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 3.18 00/85] 3.18.118-stable review
Message-ID: <20180808160527.GE5368@roeck-us.net>
References: <20180807172357.357252052@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180807172357.357252052@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 08:51:02PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 3.18.118 release.
> There are 85 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Aug  9 17:23:43 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 138 pass: 138 fail: 0
Qemu test results:
	total: 198 pass: 198 fail: 0

Details are available at http://kerneltests.org/builders/.

Guenter
