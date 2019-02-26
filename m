Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B666C10F0B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2AF3217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="onoJ/vCG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbfBZR3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 12:29:43 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42269 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbfBZR3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 12:29:43 -0500
Received: by mail-pl1-f196.google.com with SMTP id v11so1138614plg.9;
        Tue, 26 Feb 2019 09:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ErDPlaQGq/KyJSBbnRvefmYH+9cDB3Xl9voT6nBz7O4=;
        b=onoJ/vCGzg9pn0NY247j1RGnwOHTgCbwb9yR6ucrOr28BR/84knBQGtb8A2q9kvDGL
         v9g+xGfnQQ2U+dvr62oYZsd0eRZszfn7X+956YlseSXfMTtzl+C5StR9EKmiCThOrODi
         0zh3sAdPxuivjxPs10GcPKMddW8LEjhOClbkybeg2skuDk3bFLKVMLQ2hjKkkpGEGasi
         5tKQFiD2jMs6P4Dl3gzsJ/X2UjE7EkLJtUAnp20Bx/JGmE0siDgktFa5BXYXKeL5qKJj
         FU0mqsCmibuk1mOcByz9mWXEZIwwOh4NAKpgKpnpeaJ3z/GvXydlkgK8n2XcvECG4Zql
         acow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ErDPlaQGq/KyJSBbnRvefmYH+9cDB3Xl9voT6nBz7O4=;
        b=AJWAiTnqVjgRlXmBygaOor5pJMMc2g1rcDyRatJFcguwVPu/c9Ztl5KfAZQxvFqMhD
         4aXYyBXXDilKyr17YLNgwLTbQM66VmLYvMgdDi4kP0u2mkuR04MU10oCvrYnlHZQYtyv
         GbD9gZcNzzx86Bcf5wMzemyu736xRjX0nwMYvu260tflIs68ijhuyyzJX0mESt3RmIiU
         sLEEMMgbaZLxosNX2jfqfzf+DVOugJpZNnbKvfrhZAbAAQkUUg9067q8fPcGs165ryUs
         CWqDhNK7Usip74RcXBNp4bDnIri47g55k4vpmw7xMiNyLp0wBhz9Ok7pQYWC+CHtrLWP
         ICow==
X-Gm-Message-State: AHQUAuZyBkC4fXjoGwcwH9UKwqU4zmCMVWqcBHPEccu82zWKs5s8Rrf4
        CBFEtlpC8rtBMOtFVf68T18=
X-Google-Smtp-Source: AHgI3IbSb57pdk1/wmInNXY9euFPl4x0r01ZJMXdXnQnQauTNQRwAogPlESD6Ibqnzzg1E4JnyfTxg==
X-Received: by 2002:a17:902:5e3:: with SMTP id f90mr891450plf.287.1551202182645;
        Tue, 26 Feb 2019 09:29:42 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i72sm35376959pfj.147.2019.02.26.09.29.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 09:29:41 -0800 (PST)
Date:   Tue, 26 Feb 2019 09:29:40 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.20 000/183] 4.20.13-stable review
Message-ID: <20190226172940.GA7933@roeck-us.net>
References: <20190225195054.748060397@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 10:09:33PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.20.13 release.
> There are 183 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Feb 27 19:49:59 UTC 2019.
> Anything received after that time might be too late.
> 

Build results:
	total: 171 pass: 169 fail: 2
Failed builds: 
	powerpc:ppc6xx_defconfig 
	powerpc:86xx/sbc8641d_defconfig
Qemu test results:
	total: 291 pass: 291 fail: 0

The build failure is:

In file included from arch/powerpc/kernel/ptrace.c:24:
In function ‘user_regset_copyin’,
    inlined from ‘vr_set’ at arch/powerpc/kernel/ptrace.c:490:9:
include/linux/regset.h:258:4: error:
	‘memcpy’ offset [-527, -529] is out of the bounds [0, 16] of object ‘vrsave’ with type ‘union <anonymous>’ 

The problem is not new. It is seen now because I switched to use
gcc 8.3.0. The problem is fixed in linux-next.

Guenter
