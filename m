Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BBEEC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 18:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DA792146E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 18:55:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qn6bWL6H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DA792146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbeHOVtQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 17:49:16 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36068 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbeHOVtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 17:49:16 -0400
Received: by mail-pf1-f196.google.com with SMTP id b11-v6so881587pfo.3;
        Wed, 15 Aug 2018 11:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0YuzPNLSd9fstpm+lyeZAYg3X3xitl817KhzNJVDcwU=;
        b=Qn6bWL6HQw8nm7v+ZCoxF0jnkNNSLHJ1SU8ERQzaRcD15T7tJO647NmobframsIvTR
         V3D7TFWkTJyljundI8TcIzSwVCDYa9EQ+3FkaOtdqcy5tmcxTcglTFQsdr98WQqnn4ml
         Tk9r+bkV4efFkNHCNItdNQ4QnSsZ3pzTIJ9Nbvoz2m39CWp2p3J/oXThKZazPg+V2wE5
         0+Ik2N+ocgclR3esvRSn2jdRWB5zoijym/5/oSU2TDlXd76YmOCYfFgWPdL9f7CdbU8y
         WR9QgXGUUfzqfXYpn73n85w88/7QEvxYy5CSsD5KzvtAdUU8CEzXrrgHnWvzNzbyWNmQ
         RQkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=0YuzPNLSd9fstpm+lyeZAYg3X3xitl817KhzNJVDcwU=;
        b=JSj8EU3LrKDdai2FIQCCvTy/vG8XCNtuNbAHOe6Njo+FIszDEAU0yW3XaF1d4eitzK
         p0C/XM0sytQAb8jdC5cm3i9+MFK+XuwQj/BM/pcAS8DyyFkT63YwfXLksqU9G2F7QXEN
         u2wMU/T2JjJCVcRcqzgmIB94WwJH63meDknRgoqdh+/WjJivmMdy5X6iYV1Mw/Sd2hV7
         OIaCJC2IjVop3WEnLpywiDt8UviyopFN9Po1woJZbUMCTsDYWiUqhLEXfbtqHDVHulY9
         v6y90invrLTtpt35K71OyxwVHZTXOIyJv9JwKBDYeNDB6jQlNHrObBtq43jJUXbIza3d
         K6dQ==
X-Gm-Message-State: AOUpUlGMdPbmInqnClljwMZ7K159+NqX94elPnKO27/chpgTbcMIomsh
        K/KQ+riv8Qbz2WQCDxEaJ8c=
X-Google-Smtp-Source: AA+uWPy2tllaMeujxgMHErZF9qpQPXeSTlyvZv0XAq1NJfMlmKwc3nPKzqoiJS3zEJXmNYx08AxQiw==
X-Received: by 2002:a63:555:: with SMTP id 82-v6mr26779003pgf.25.1534359355226;
        Wed, 15 Aug 2018 11:55:55 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id g11-v6sm59528766pgi.90.2018.08.15.11.55.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Aug 2018 11:55:54 -0700 (PDT)
Date:   Wed, 15 Aug 2018 11:55:53 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Sebastian Gottschall <s.gottschall@dd-wrt.com>
Cc:     Sven Joachim <svenjoac@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 000/107] 4.9.120-stable review
Message-ID: <20180815185553.GA18219@roeck-us.net>
References: <20180814171520.883143803@linuxfoundation.org>
 <6272e062-6cfc-0669-bebf-ebb039da051a@dd-wrt.com>
 <87k1orms9i.fsf@turtle.gmx.de>
 <55df6754-ce8c-520a-13f9-c610ac498173@dd-wrt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55df6754-ce8c-520a-13f9-c610ac498173@dd-wrt.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 08:27:00PM +0200, Sebastian Gottschall wrote:
> if i fix the other error (can be reproduced with disable smp on standard
> i386 build)
> 
> another raises up again related to smp. to be serious. this patchset of x86
> patches is absolutelly broken and put together without any care. not a
> simple compile test has been done
> 
> sorry for beeing a little bit upset. i'm sure i will find other bugs if i go
> deeper
> 

It might possibly help if you would consider to publish your configuration(s).

As for "not a simple compile test has been done", please have a look
at http://kerneltests.org/builders. I guess those compile (and boot)
tests don't count as "simple". I assume the same applies to all the
builds done by 0day and all the other test builders.

Guenter
