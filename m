Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99CC8C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 12:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6058120840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 12:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rc7XUyjd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6058120840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbeKIVlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 16:41:36 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40261 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727702AbeKIVlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 16:41:35 -0500
Received: by mail-qk1-f195.google.com with SMTP id y16so1042085qki.7
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 04:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:from:to:cc:mime-version:content-transfer-encoding:date
         :in-reply-to:references:subject;
        bh=NV+/SXEBfl7RjWkh+y3lvEgqwSK2niVcd1xCe/YMDIs=;
        b=Rc7XUyjdf7m8WFdGD570Itxdhy2B5D2R5MPxFEk8OW33fCfhPJ1nKa7rudBABwOUSv
         oTtZYL5mbyInJkBxPj1CMpRsKIR/THRjL9XFS+sWwry9EhLRk86qL+srJ15SX7WnaZ2P
         CCDCWIO39piWfwJ4p7vhY3HMmcYJ4gXWOSAQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:to:cc:mime-version
         :content-transfer-encoding:date:in-reply-to:references:subject;
        bh=NV+/SXEBfl7RjWkh+y3lvEgqwSK2niVcd1xCe/YMDIs=;
        b=AfY9xOUWrB8JtBtj1bNyAewiVTL1OHDYPLdDpiWu3n1T/WsQPJoFWKM18NqaHHgwBA
         fXog/k/BHw/k4U6Z8HkUGq0vRjM/KjuSo37+uIKQVpMQll5YDIetk7zZs+lDKjxPxnuD
         U/IcSz1r4HOQJavjvwIHlMUgtwACn0E5vRpcyabcgiA8fhcHAD/PCGw4TFH0r/xy501v
         8IpeoxzfarfVugkff5L1Vi+boOnvl3iHdgjc3TSdxIWGyjyGz1g3pT6ifIsCVxiCzhQm
         CmkPEuDbYjsZxbP+MRj8a/a1uj9CZ3ynabRG57NIyVo6SIVH6u6Z7ycl/LIXbnL0eLRd
         S3ag==
X-Gm-Message-State: AGRZ1gIGXFohXneD1rjIxAfwJE5Wu7Gg7ljzFpuwrKVCHF3K9SfL/XVp
        /yY0xcJAOaSVqP+5JF78BftCcFR23kM=
X-Google-Smtp-Source: AJdET5dkrd/tBswnvpkp0rZbvl82O1qneFGfWgATp1QbRf/gnbstiNY5ym64K96llpPR5q5c+BBIxQ==
X-Received: by 2002:a37:b782:: with SMTP id h124-v6mr7746182qkf.340.1541764875699;
        Fri, 09 Nov 2018 04:01:15 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id h25-v6sm5127206qta.89.2018.11.09.04.01.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 04:01:14 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailauth.nyi.internal (Postfix) with ESMTP id 8F53822291;
        Fri,  9 Nov 2018 07:01:13 -0500 (EST)
Received: from web3 ([10.202.2.213])
  by compute1.internal (MEProxy); Fri, 09 Nov 2018 07:01:13 -0500
X-ME-Sender: <xms:CXflW-rsCB8jGAOTrdo_1C6haBM0lVlG8r5aRcT1nhvwV_YSYlSpXQ>
X-ME-Proxy: <xmx:CXflWzD6zxoIg2CR1_i8A-Ripoac62D7otS8igwJbSit7QHpyUs14A>
    <xmx:CXflW0N_OqyA1rA5zWkMUeuz1TkWHoBwD_pOjtOQebh6JHxMXq60Gw>
    <xmx:CXflW1MUwlvEBM5aAoKIXTsPw3GdajcvsOZ9-lFcnL0gjK7O6wB30A>
    <xmx:CXflWwvVkcN5xFBQtknA32sApgW2cLYCA7q6Ov0fwlGvjUad1Pwmyw>
    <xmx:CXflWy-3QoX_y7eBirPVCCE4Z86m1DQV76355ew4qVF_7ZU-4ZGOyw>
    <xmx:CXflW6LmjUIiuzK7wMWVln2jP0Qe1IKjKN5XeRsv292reWDYdz3DMeTpobmma_oh>
Received: by mailuser.nyi.internal (Postfix, from userid 99)
        id 3E81A9E49A; Fri,  9 Nov 2018 07:01:13 -0500 (EST)
Message-Id: <1541764873.3286172.1571234624.727F6284@webmail.messagingengine.com>
From:   Rafael David Tinoco <rafael.tinoco@linaro.org>
To:     Cyrill Gorcunov <gorcunov@gmail.com>
Cc:     adobriyan@gmail.com, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Mailer: MessagingEngine.com Webmail Interface - ajax-c0552f07
Date:   Fri, 09 Nov 2018 10:01:13 -0200
In-Reply-To: <20181109114850.GL13195@uranus.lan>
References: <20181108111105.GC13195@uranus.lan>
 <20181109113036.21512-1-rafael.tinoco@linaro.org>
 <20181109114123.GK13195@uranus.lan>
 <1541763936.3280758.1571224480.76F1EF1C@webmail.messagingengine.com>
 <20181109114850.GL13195@uranus.lan>
Subject: Re: [PATCH] proc: fix and merge proc-self-map-file tests
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 9, 2018, at 9:48 AM, Cyrill Gorcunov wrote:
> On Fri, Nov 09, 2018 at 09:45:36AM -0200, Rafael David Tinoco wrote:
> ...
> > > today evening or tomorrow. I think this way everybody will be
> > > happy: procfs get passed on arm32 and x86 will still have first
> > > page testing.
> > 
> > Ohh, my understanding was that this was going to be addressed in some other test,
> > like what you said.. I did not understand you wanted me to create a test for
> > it altogether, my bad. I can do it if you want, let me know, pls.
> 
> :-) I'll be able to create patch and test in about 10 hours, so
> feel free to beat me if you have time meanwhile.

Alright, I'm fixing membarrier_test before, so.. I guess we have a competition.. =o)
