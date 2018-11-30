Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA68C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D3B720863
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T8cYYMUz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D3B720863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbeLAJkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 04:40:35 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46892 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbeLAJkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 04:40:35 -0500
Received: by mail-pf1-f194.google.com with SMTP id c73so3453865pfe.13;
        Fri, 30 Nov 2018 14:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3jmpHh/77GZlq5zpKIXTVo+VXq7xTZt3tgk5xQU831A=;
        b=T8cYYMUzqJ1a2UR9hFUHoSANSgG0KUWA9NjUbi+flR6UuRlBX3peUt+e6wHG7RMOBT
         ZImALhmyxfn5rLXpbqS+gxeL3itdmHSDN5/LFYDE7pR2xt5T7DJjJIrCAMvoIERf2Vlb
         zVIVABpgykUuvaB2eIddU+ucE+GPVhY7lBUb1jc3sw75tdl8XrPKq5G+btogVDHBD2Nm
         gsqZDtUEwsyx/PUlUA90V3buXfapkoKRNsOegQPPQdAfWjxaYbf3w88ecFs6fxugp9iR
         Tb+TtNluTNR2sxvp2cAVL/Ghwb2nAhXs2mw94xG5eJdM1VL4vDYV/pFRjFt927EWF+vJ
         C9GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=3jmpHh/77GZlq5zpKIXTVo+VXq7xTZt3tgk5xQU831A=;
        b=lr4r3CqU9Qh+ywKlGWGPRqTNZjfF42oH2eOUqg/YhvJw+pguCq3cnkc7X0j3SO8bRU
         Har6QVnjsgk5DCYfjpWZyPBpivYI8p+NLvktBZBCjP1J7ueHtNP3MUS8HE13GWdWVU6p
         /bh4zb7C6QM+SZy6LgaMXCeSQ/27CQCau2TUC/gK7UVO2OBqQQiX+FSf/rfoljphS6R1
         GilT4vv797Io88r6G9kUoLJGJyFZiOCnrbHKdb1yto+B6cvU8onIUGDZZTufvrsbkV60
         4MEih9Z3ospfwy5R/ozUTq8PdpEV30UXodS5sCl9so6AC5PNOPATOyFx8pBGtySoTwzK
         lAQw==
X-Gm-Message-State: AA+aEWbcaIYIokK1v08kPPTkY1wr8//bTgEbYkVmz0A0vKdwW/qYtDSd
        LaEF+qxfJk2Akgi1BAtViYU=
X-Google-Smtp-Source: AFSGD/UwtFDv7r4y+75jjyTVGARRrJ1yoWnB/HnJwyXwEvYdYAvQ/WlH3805uIfgobqlQC0uzVg0hw==
X-Received: by 2002:a62:8d4f:: with SMTP id z76mr7580514pfd.2.1543616987074;
        Fri, 30 Nov 2018 14:29:47 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k24sm8451809pfj.13.2018.11.30.14.29.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 14:29:46 -0800 (PST)
Date:   Fri, 30 Nov 2018 14:29:45 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.19 000/110] 4.19.6-stable review
Message-ID: <20181130222945.GE13361@roeck-us.net>
References: <20181129135921.231283053@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129135921.231283053@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 03:11:31PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.6 release.
> There are 110 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Dec  1 13:58:54 UTC 2018.
> Anything received after that time might be too late.
> 

For v4.19.5-107-g048192f:

Build results:
	total: 159 pass: 159 fail: 0
Qemu test results:
	total: 337 pass: 337 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter
