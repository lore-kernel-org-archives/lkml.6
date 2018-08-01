Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5934C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 13:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54FF420844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 13:19:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pGSVWCqJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54FF420844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389366AbeHAPFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 11:05:01 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38911 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389256AbeHAPFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 11:05:01 -0400
Received: by mail-pg1-f193.google.com with SMTP id k3-v6so10826550pgq.5;
        Wed, 01 Aug 2018 06:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4jbFMngSjVavgEQuRIw0J2zz5iNb4+wfdPYJLbWgQNw=;
        b=pGSVWCqJtVNKzK4Pr5EnApV9uzfblmooRONZyen+ET5uvZvjzkQMxDZNsfX4b2NBD4
         V8Zwvjdhb0M9qN6z7baNE0e6IuW2t63sod1vHog4ybDw2jfVyPd3HP7dAp2TqGZbqi3A
         Ht5swESi3LGF4H9y7IMIV4MMuF9WjTaFMPwKiY+X8x3n1d3XFiw1k/yZNBScb37qLiTp
         dFp5r79LP+CvY8L3ImiZ6tV3nipgK8znpdBVsFF+WSzq0y+xMistCE/Dtdulgsco6Jz+
         Mjkev7SMaSQo+b5odcRQmrLkZOS3Wimt/rm80gnT9sAlPIteEo/3IeeD80M2Rr+zLZWP
         dYSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4jbFMngSjVavgEQuRIw0J2zz5iNb4+wfdPYJLbWgQNw=;
        b=EjYLJntyWPsFFqDfcy371WP4810eq8i9inuNlnZj0W2PLad2t78nj8vnVqar3f2MIt
         dt4DS9m4MfxgzK0ztxqV6IwoidzbvnVtj+I5ECLSwvfO0BKA32YBhrGA13n/D6zEZCzq
         3iOOvubRCPEzovFNyO0GqfgyNWxjM8WmWgnUrdQdLNcq+xKXaohJC33U9Lyj40eidyLa
         SjNJOynJL7OWBDdAhEuNyqKUCTxQQOzwSZZevMzlHvlLF8QD6/DL5VaNXXYRN+/Z97fx
         2GdIqE6/BXe39NCw3vby6quVQaVeS5bY4ajjXRpjoBRX6BbooJwapv6rPlP5tT6RWHb4
         T+9w==
X-Gm-Message-State: AOUpUlG3ZsA6qJXZtSoiHSroRTp+cfsjkC4pmqf9gmjc3ynStLCFs2nK
        m92JkgRldh9nNL4Emyh3t1Pqn/Uw
X-Google-Smtp-Source: AAOMgpe8U3l61p9X4kyadJtJx51X/4wCW7jG1Yn8uycs/MAruatVYCaeFbFeA29vdngLMc8RqkzIqw==
X-Received: by 2002:a63:dd09:: with SMTP id t9-v6mr24842074pgg.370.1533129555952;
        Wed, 01 Aug 2018 06:19:15 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id 16-v6sm25308670pfp.6.2018.08.01.06.19.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 06:19:14 -0700 (PDT)
Subject: Re: arm64: pstore: printk causing hang during boot in __memcpy_toio
 with pstore enabled
To:     Ivid Suvarna <ivid.suvarna@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jason Baron <jbaron@redhat.com>
Cc:     Kernel development list <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>, linux-arm-msm@vger.kernel.org
References: <CABXF_AAVhadw=+rtcD-L06-zBTMb3v7C2QqvN-6vcx5w2T0sYg@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <8ab731b4-2929-e92e-6536-35096ee66baa@roeck-us.net>
Date:   Wed, 1 Aug 2018 06:19:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CABXF_AAVhadw=+rtcD-L06-zBTMb3v7C2QqvN-6vcx5w2T0sYg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/01/2018 05:35 AM, Ivid Suvarna wrote:
> Hi,
> 
> When pstore is enabled and a *pr_info(any printk) in
> __memcpy_toio(arch/arm64/kernel/io.c)* is added, kernel wont boot and
> just hangs.
> 
> The path where __memcpy_toio is called is below:
> 
> ->persistent_ram_update
>    -> memcpy_toio
>      -> __memcpy_toio
> 
> I tried with trace_printk and kernel boots fine. I understand that
> printk has overhead, but is this expected when we use some printk
> statement in __memcpy_toio?
> 

I think the problem may be that the printk() output is copied to pstore.
Since pstore calls memcpy_toio(), you get a nice recursion if you add a
printk() call to it.

Guenter
