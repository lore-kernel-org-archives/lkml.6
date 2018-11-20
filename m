Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D91DFC32789
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A11E320684
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBIQLTIN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A11E320684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbeKUD2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 22:28:19 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35540 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbeKUD2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 22:28:19 -0500
Received: by mail-pf1-f196.google.com with SMTP id z9so1281304pfi.2;
        Tue, 20 Nov 2018 08:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=/81WvMxWZav6Xol/dWveFAVJiWMNXMGoOoE7ZAdHPdQ=;
        b=JBIQLTINLb3/70jVXNonwPAc73g9GtoW65sYv7UZOc4oDiMp4Vb2RPgrbhIzLdQqWg
         LU93WbMTYq1jhbtMvpiCYCh34yvh/YvsRYaz1U/QkkS9f+vtZjt9JYuDrLfcbOd25DqS
         yrm7g5Jcb4NiKocPN8IFwJOVGfwbvqm2tWkOco5XzjDFk3ipzfKzTFIGCzQgFMHii56F
         Wx/sUoFVNNiQekrJJAE4ReT4YaD2gOFqFsq/puAlzhi2UdzYAUqWZBJFqlX2OCUjqzPT
         P3Tv0g1EPjKc00ziHINOzYVOBY2RddHKZaigCwhEFMnyD5cupKdVAJ4Jkc2HDh/2filx
         bWZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=/81WvMxWZav6Xol/dWveFAVJiWMNXMGoOoE7ZAdHPdQ=;
        b=indmfE1fkD3FBZvMVShgeFzGjSK3MzplOJagz5A9OytnWgWbZBFxgkTPfelxZM8hf0
         2l2NSHN1A5cjlP5ygWF/SNvtzQv5NBOYsBmCWv0tZY+33clHZE04VEo7ukKJFYKuxuq4
         Ol9OXViZmaJgv7ZmTB8qRhMjIAxVVrhzW1MnJm0cTyE3hY0roDxF4RYBMXeyxJ5w1t++
         Or3t0y+YkiGWQtUjtr+d9y3lDGjARuLpPMGX7d4camxhijhjGVqkOsC31oVqCuGk50/7
         ZBsaH4Qvynx3SMaxuFCo/eGoj2Lb7skthD4EyCbWRBIIb/XW8WbM93jS870BoQ3UL83z
         bhgw==
X-Gm-Message-State: AA+aEWZ2MbqqfXYzT4wVH8yyY3SrWT4uLexGscbwvZ5gn9jxMIqUYK1G
        5iP27Z2z9qssqTMllo5CRZU=
X-Google-Smtp-Source: AFSGD/XUCtOKqFiczGqS8atnc+u2BKhzV/XbNqYEpdJMc4RjT+gkl+mkFZoyzxhyV1sLdNrhRFye9w==
X-Received: by 2002:a63:df13:: with SMTP id u19mr2604226pgg.294.1542733091711;
        Tue, 20 Nov 2018 08:58:11 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 62sm44855180pgc.61.2018.11.20.08.58.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 08:58:11 -0800 (PST)
Date:   Tue, 20 Nov 2018 08:58:09 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 3.18 00/90] 3.18.126-stable review
Message-ID: <20181120165809.GB32433@roeck-us.net>
References: <20181119162620.585061184@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181119162620.585061184@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 05:28:42PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 3.18.126 release.
> There are 90 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Nov 21 16:25:28 UTC 2018.
> Anything received after that time might be too late.
> 

[preliminary]

Build results:
	total: 138 pass: 134 fail: 4
Failed builds: 
	i386:allyesconfig 
	i386:allmodconfig 
	sparc64:allmodconfig 
	sparc64:defconfig 

arch/x86/platform/olpc/olpc-xo1-rtc.c: In function ‘xo1_rtc_init’:
arch/x86/platform/olpc/olpc-xo1-rtc.c:79:14: error:
	‘struct x86_platform_ops’ has no member named ‘legacy’

arch/sparc/kernel/perf_event.c:26:31: fatal error:
	linux/sched/clock.h: No such file or directory

Guenter
