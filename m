Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A244C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 16:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7519620A8B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 16:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dzI92Lxc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7519620A8B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbeHWUAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 16:00:53 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33056 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbeHWUAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 16:00:52 -0400
Received: by mail-pf1-f193.google.com with SMTP id d4-v6so3034803pfn.0;
        Thu, 23 Aug 2018 09:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=edTxwMLO35/eQgJlbMYfEgrnnCSr57cMZzGPGYhzlMA=;
        b=dzI92LxcE8HFyHJclPpwRAZKCNMHonnFTSwVDwnZJT1zaXhZTdsihjRCt9KDl0VWty
         ztr4UXkQdglTzsp6hJR1jzCpO3hGbD4oV0rVDGivjTPHD476Gx0xX31VWHze5ysaIwtG
         /j2Tboq/5SyjVEjZYa7hkYIBxGWIg0zh+GYaYyXpFmFjRYBJRjY90yXN0J15e7wFJJzD
         rNVjgWvgIuPGBeIWbRHFugjpjdlyVLvweJtUTF2JWUOnW5F9K6p7FgYBWOEL6oHEwbzc
         3U4rWJtUg6PALz0lHyEXSWGeDubwSUT+gACFdckedvWkJqg6qIn5UwPO2G2NRGmzd5Zw
         zdBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=edTxwMLO35/eQgJlbMYfEgrnnCSr57cMZzGPGYhzlMA=;
        b=W+f3ntzuBGKk1DLHZ4Fjs1jriwruP5cfm2IKFurFiPDt8ObZbskQpFzJywF+g4DdsR
         Sr48M3RZlqb4PmQ0l8XwoMPQ//0iIZBnwcCCjfj6FbdEr73xgQcUVqss0ICluVXcBfsa
         qyx24GN9qv0NbI9jjalODVZIjzYNJaHP7dKYqOXfVshSzBVFhwE8PKaZuB6oiZ1cop4f
         Pxjs76dunYuxFPlXdckibAFM36W4JBkiyd/YTAZzw1R+5Qc/DdHNuDV1VcWUa7oxTkhq
         vcmov6OqFqe+1UnLxUOUiI9sIOVxT0El4lnQEirVCLWBPjLhOv/3P/k9FaX7szfaLckm
         Bcaw==
X-Gm-Message-State: AOUpUlEqkdNZa1KncuGG3JYvfgXpRp3Yvl2Q02TS1MptTJuvceq285KK
        taUYvotixN+6GjXJZu7+SJU=
X-Google-Smtp-Source: AA+uWPwKkSPhO7SzLllpc6wniTaybF7AV70jVLa5Uco0tWEKaEL2frJai8cLZ3ELyVlKB/kRS033HQ==
X-Received: by 2002:a63:26c5:: with SMTP id m188-v6mr21923394pgm.200.1535041823321;
        Thu, 23 Aug 2018 09:30:23 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id e26-v6sm6260004pfi.70.2018.08.23.09.30.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Aug 2018 09:30:22 -0700 (PDT)
Date:   Thu, 23 Aug 2018 09:30:21 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/79] 4.4.152-stable review
Message-ID: <20180823163021.GA8669@roeck-us.net>
References: <20180823074918.641878835@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180823074918.641878835@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 09:52:36AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.152 release.
> There are 79 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Aug 25 07:48:51 UTC 2018.
> Anything received after that time might be too late.
> 

Early feedback:

Building i386:tools/perf ... failed
Building x86_64:tools/perf ... failed
--------------
Error log:
  PERF_VERSION = 4.4.151.g6d0c34
tests/parse-events.c: In function ‘test_event’:
tests/parse-events.c:1629:3: error: implicit declaration of function ‘parse_events_print_error’
