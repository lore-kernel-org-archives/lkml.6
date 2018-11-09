Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ECABC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 19:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33C2A20883
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 19:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DapKmyiO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33C2A20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbeKJFXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 00:23:12 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34307 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725758AbeKJFXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 00:23:11 -0500
Received: by mail-pl1-f196.google.com with SMTP id f12-v6so1390170plo.1;
        Fri, 09 Nov 2018 11:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GovyK9yR8XjgfCWh5sqiWh/IN79hIrC7lkic+56x3q4=;
        b=DapKmyiOHOZIy0XlObjD7wKXH5fZhGc6QCqONqCDqmHVO5Dfatl1091QAkI5S3/FDg
         SpAkgb0tOFTNSu6Cr+ModTOx5mErmKldOZk3tPohucKp4qsfudWRTGZ8Lu/OylVzNQpu
         ZXWKk9ufyqdrcTU8ltqoppIjB/dvr/iwo2qj4TbYmhwWqNyAhAYUayAru1/4sf3U/0Hi
         asKs0KNfoQ+VAXr3IJqXsoQDQwSPwTSvBEKRnTJa4YgfT9CqYtmeAt7+By/HAiTSYy8D
         l6neI2loaZaKzAlM238mJAb3AUfNw3/jNyqi/z2n4mCnaXbGFJxw4t2s/kEn9AaIuMy6
         6fPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=GovyK9yR8XjgfCWh5sqiWh/IN79hIrC7lkic+56x3q4=;
        b=Qlaj799tNrp9CqWN0NX1pud30f+VXetwZK5qB6J2NHppCLim9U3ni90hfNmN1uRdLZ
         AjEWb2BUpmFPZaDRt+gTvntm80Chs4BsokXOtUzg5uKLdL8hIuTrcm6C5UPVSuynG+BW
         jwBcf4z9AMBTm1m/Euww3hs3qiR4R7dgrdZqLzjOHEoesmbOLRSG1hlP2CuqRJtPzNIV
         N2Hp5vRmdRTf46e+0/TrtVTpF9ullKrvbpZj5JDN9UX1bkiN29Qrr3zd3ilGNFFfiI3H
         /ADeFy6PYTbpYObBTQcqKVQkKy3qwYzu8bno6rU9UR1OK9O4roJSBOKaHX4mH26RChnI
         sm0w==
X-Gm-Message-State: AGRZ1gI8MD0vLPsUNtqf0Idm4ND8BPfWV1KHTaJfW7AMnGGFdq6V+aKu
        3et/SkIuhw7lHgPY4ifhsDY=
X-Google-Smtp-Source: AJdET5dcZAic9TBfrJDAP7en5wxiGJjrrkh3GUBA6Fy5cm3ovYXWXl5EGgrz9vZ05HWc+HcVGhqrLQ==
X-Received: by 2002:a17:902:2943:: with SMTP id g61-v6mr10294573plb.82.1541792469930;
        Fri, 09 Nov 2018 11:41:09 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r1-v6sm10420494pfb.41.2018.11.09.11.41.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 11:41:09 -0800 (PST)
Date:   Fri, 9 Nov 2018 11:41:08 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.14 00/31] 4.14.80-stable review
Message-ID: <20181109194108.GC27564@roeck-us.net>
References: <20181108215129.641434673@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181108215129.641434673@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 01:52:24PM -0800, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.80 release.
> There are 31 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Nov 10 21:51:09 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 150 pass: 150 fail: 0
Qemu test results:
	total: 292 pass: 292 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter
