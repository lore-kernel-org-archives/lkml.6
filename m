Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F7FC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7D2220833
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6ruaWAV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7D2220833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbeIZC4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 22:56:48 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38572 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbeIZC4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 22:56:48 -0400
Received: by mail-pf1-f196.google.com with SMTP id x17-v6so12025720pfh.5;
        Tue, 25 Sep 2018 13:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8wZByR3KLEEIbnrxzyabBDduheQV9A/l/xl2mQAj2V8=;
        b=a6ruaWAVdtQxrbp539Cv90YvGYyvj4ps594qYldgoEJu0R3bAX7NsurG83oNSHLjno
         jkz+WYdsDUJew2RCEjGlEiFyXuPdtAuDIYMg8BDlM3R2wrOy3NcdYF020DE98c5jW6h3
         9d7PJDMSNxOJv6Gc+RiElAnjhdnRezRvDu5CMPxK5x8nQKvcgoPi3sTSvWvDKBo+AmFR
         g2lKBOf+O5God1sU98b344vy8uO2tHqm8mlPJlqm3JgCLoSuG+TTmi60wBGS+tp14YBN
         FU/+pUeI6dgOFIJG1ZEKMd4/a9x6Jv2lalbWtQpumbILgqdJ3SEq/KiR+tW21J4AdRC/
         1xsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=8wZByR3KLEEIbnrxzyabBDduheQV9A/l/xl2mQAj2V8=;
        b=njzyjMjL6OtDSvyGUciZa8TU2FZxgeI6G8i69nRNwrcFzERDtigs+fR+QBjoxmCc8f
         y5tSDHctYMKXT4ipGarFRvK+T7+H/FnfqV7dtuULY6Vk62En07p1aQ/cdO89kilpomMB
         qWlfUbN0bgGBQ1iaROkKuk3U22hgNSlv4aFyxpM3rZ6aj0IlK11YajXnO4Q+GMnjf90v
         Chjj92mZ76/Fp8EZ0640CRsfEZ2PocNWSeyb2/OSVL5ZXnr11k6K1lVqL6trs56OZaqq
         gg8bDcnXEqFG3lLl3ruHY6ib3qSteQyOQDEPHiTinqRRP7TOilRBwsa+CBWVfnNhVp56
         ogCg==
X-Gm-Message-State: ABuFfohdOT+DX7+7qLcw6dVUXyQCPjVjZNHYYiEzvpUZrUYlaTr482EH
        GXvVlWs847oAzD0hTmxXwyA=
X-Google-Smtp-Source: ACcGV63R+I7qf+nRZ0Q7nS64E/7Q9A//dNqbRHG8vTyJ2yHX9rrMizcJGiAQecO2YrXPH2oYifTM5g==
X-Received: by 2002:a17:902:2d24:: with SMTP id o33-v6mr2730432plb.211.1537908444944;
        Tue, 25 Sep 2018 13:47:24 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id c2-v6sm4726671pfo.107.2018.09.25.13.47.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 13:47:24 -0700 (PDT)
Date:   Tue, 25 Sep 2018 13:47:23 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.14 000/173] 4.14.72-stable review
Message-ID: <20180925204723.GC13170@roeck-us.net>
References: <20180924113114.334025954@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180924113114.334025954@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 01:50:34PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.72 release.
> There are 173 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Sep 26 11:30:10 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 151 pass: 151 fail: 0
Qemu test results:
	total: 315 pass: 312 fail: 3
Failed tests: 
	powerpc:g3beige:ppc_book3s_defconfig:nosmp:ide:rootfs
	i386:pc:EPYC:defconfig:smp:efi32:scsi[MEGASAS]:rootfs 
	i386:pc:Westmere:defconfig:pae:smp:efi32:usb:rootfs

The failed powerpc test is the result of a crash in devicetree unittest code. 
It affects all branches. Nothing to worry about; fix is being worked on.

The failed i386 qemu boot tests are spurious and happen during reboot;
the system shuts down early. This deserves some analysis, but is nothing
to worry about at this time.

Several of the qemu test results show runtime warnings not previously seen.
This is because I enabled various debug options. I'll analyze and report
those separately. This affects all releases.

Details are available at https://kerneltests.org/builders/.

Guenter
