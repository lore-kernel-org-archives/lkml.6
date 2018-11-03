Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A6F8C0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 15:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2831E20833
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 15:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uNXUYHKi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2831E20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbeKDAQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 20:16:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:51340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726849AbeKDAQL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 20:16:11 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41CB72082E;
        Sat,  3 Nov 2018 15:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541257476;
        bh=gPIlTwg9RB5GGwuY04YVg9oKl7EuH0MGCaum5GNJIn8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uNXUYHKiGE1NEt3SyHEFVi2yYF2kE2OqSCj5g4mmoHv81bltou3kt7hd6DXaRYSW4
         dfHFMM9FP/n8qkqeQVqVVSDdZ9H34PF21jscwcTb3CrlNhyON2fL5GVIeLQCQTs0si
         HQkYze+xiGTxiznU7qnytUTL4/8xEgning00af/U=
Date:   Sat, 3 Nov 2018 16:04:34 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.14 000/143] 4.14.79-stable review
Message-ID: <20181103150434.GA24235@kroah.com>
References: <20181102182857.064326086@linuxfoundation.org>
 <34e8a999-20e1-5e7d-863b-b0585a24e83b@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <34e8a999-20e1-5e7d-863b-b0585a24e83b@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 03, 2018 at 07:31:42AM -0700, Guenter Roeck wrote:
> On 11/2/18 11:33 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.14.79 release.
> > There are 143 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sun Nov  4 18:27:59 UTC 2018.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 150 pass: 149 fail: 1
> Failed builds:
> 	xtensa:allmodconfig
> Qemu test results:
> 	total: 318 pass: 318 fail: 0\
> 
> Build failure:
> 
> In file included from include/linux/mlx5/port.h:36:0,
>                  from include/linux/mlx5/driver.h: In function ‘mlx5_get_vector_affinity_hint’:
> include/linux/mlx5/driver.h:1208:13: error:
> 	‘struct irq_desc’ has no member named ‘affinity_hint’
> 
> Caused by commit 19b743c448db ("net/mlx5: Fix mlx5_get_vector_affinity function").

Odd, this should be fixed by a later patch in the same queue, as 0 day
also reported this.

Yes, e3ca34880652 ("net/mlx5: Fix build break when CONFIG_SMP=n") in the
4.14 tree should resolve this.  Ah, Sasha added it at the "last minute"
after I did the -rc1 release.  So this should be resolved now, I'll push
out a -rc2 so that it can be verified...

thanks,

greg k-h
