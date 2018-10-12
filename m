Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_SBL,
	URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD65C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D57892075B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pEOQq7tB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D57892075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729232AbeJLXRD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 19:17:03 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34608 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729069AbeJLXRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 19:17:03 -0400
Received: by mail-pf1-f195.google.com with SMTP id f78-v6so626593pfe.1;
        Fri, 12 Oct 2018 08:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bUZuo1gP6TErFWbVdCIQ8xdLbvYD18chsuGsK6YVOlo=;
        b=pEOQq7tB3c2OfSQB2qBTSz1ksAWakQhWDISJpuKY57sqJo3Zpo5CPcP7lehQwtjnIF
         8YI/V+QnccpC3aqEG0M/90eu41L6CqVkrQJiFuOWEWq/+lgLvTcTxRsH1w7jRNBNlsMI
         VYOJAiGrhiItuwPC5NslMu+lArtUrs2aztI3AuhGW5nc9SONo+ST2MWJCeVRn1IgnRej
         OvxnjSdSZJqXSKZgTBrqOK7Wiah7CDSurm3MUjVb3A52/id0xsOsFtUeZY9vFyGN7yyw
         TXdBYwih16FrXacYHPz9vvRkR6JLDO4g9Yw7Agk29o9fD5bdP45pDk/0TOlew9UgyrjH
         6bJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=bUZuo1gP6TErFWbVdCIQ8xdLbvYD18chsuGsK6YVOlo=;
        b=e1jh7QqfYps4BA817gRJoYyvDEWsexMZqYDjIq13UPb2WJLzsa5Wke/N5gRf+t5cvs
         K2GC9ycyPez5+S1oC9bMJw6vgtx+o5EVp6Ex2dIg8u3hb/Yi/ff4MPjurdFSoMUaBtKq
         rzvR3UCUuBb81zF+FGxpMSo6NBmdJLgnlEFHQMeByPwhzMukaF+Q4fOh8NofLjIOFvu+
         L211UQ0Ez86+9p+SznUXnx0YWXoyk+6poVQwZGL6ZTx7Sz8Y80BPzIT2+WAHKNAXnj4a
         X9LHsm4cmkZC8NMs0YfwKpVHYUJYFYiDdsXUb0FZdFXRzt5OiSSybupRbiWqURHzH9Zn
         Xbbg==
X-Gm-Message-State: ABuFfojRzCb+axFDyXnG5aFM3ar7eV8FSN8AAgAD+3R841TwnnNYRFq4
        PtIy49j+QDHfXPRB/tF7CWY=
X-Google-Smtp-Source: ACcGV61xKSSi/6sfTjDU3iy29TA/Wt30tpGgO+4fwtY38pK2i9p3OjCZ8TnBeonrjoT+dBPoRilQQw==
X-Received: by 2002:a63:5a0d:: with SMTP id o13-v6mr6001681pgb.267.1539359039284;
        Fri, 12 Oct 2018 08:43:59 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id k12-v6sm1864709pgo.34.2018.10.12.08.43.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 08:43:58 -0700 (PDT)
Date:   Fri, 12 Oct 2018 08:43:57 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.18 00/44] 4.18.14-stable review
Message-ID: <20181012154357.GC13377@roeck-us.net>
References: <20181011152452.571669983@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181011152452.571669983@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 05:39:38PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.18.14 release.
> There are 44 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Oct 13 15:24:36 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 136 pass: 136 fail: 0
Qemu test results:
	total: 321 pass: 321 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter
