Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7503C46465
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 20:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0183720851
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 20:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLewP1XD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0183720851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbeKUHJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 02:09:32 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46290 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbeKUHJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 02:09:32 -0500
Received: by mail-pl1-f195.google.com with SMTP id t13so1970439ply.13;
        Tue, 20 Nov 2018 12:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7RvT5NlEpFNwg9ZOUCaAZRFR+WPC/Te+S3wChub+1kQ=;
        b=JLewP1XDBCuoANrMVGyC7Pj13WSjlVIhoGoNZ7j41yhuKGwg7hX3oOVQalMAQOTw49
         fPhdQiOXEY0+bJeVbxcDoMG3tkvOsW+Ub/Gq0aGpHgIIgyx3XXTaPanw4mnw/ynTQtKt
         8HRGJwsipYIuV5jsEpK9LaHMHXA0GH8EsYdOWLaEQ2XphnAPWCVtZL0yX5MZCWFtReAO
         to5br3/kxjhcXSos2+0M5lWwKtustItJcCojg912JCOpNZWVmbr1NRE3Dnz2DQ3YOCr4
         M3ICsWauPBGn+YsZrM994N8TJcTP0qyOPJXeSGAfCHVSlYEdfOggWETxPm9mtw7348I0
         X7Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=7RvT5NlEpFNwg9ZOUCaAZRFR+WPC/Te+S3wChub+1kQ=;
        b=PmKroFyPOAEam22xhGZSjfG65xBWUUobKuf9+Bfgk32AUR9NBbhnHSYjvlgbkqt+NF
         QXMbuXDoDUnh9pbul+Y0Z/9eYy998sowr7ppxHu/nWlCv9x/TN+2svRZYUUsSmWefQ8X
         Da5hvg0hAk7fg25jJODe/1BRqNAgRIedspWqsH3SwPahOt8qHjNCnY1J4SLHVdT3Ghj8
         H5eovdp9rY33xQECIDbZo6pnoyPOrQxrbIzX1pPzjAp6ggpsmr/5LMrKqWUi2R2hXFRq
         vRKCA3TCYIH2KUITgPv4QCy++nDbyoqPbN4v+djKff2ty+suJ9jmEkzfCa/Uw9ZYMbkH
         UVFw==
X-Gm-Message-State: AGRZ1gLTM38M8C2cBA9qZOmy4P1RP1eDD053nTHkNKJhTFgfM6EybMmL
        w6OSCVquqwO85wwhfFARQbg=
X-Google-Smtp-Source: AJdET5fD7u9sNbjlu41h/Re462gGEK0Is173EEyzeo4yCqaxk21+dPFujppaftXANGcz2Jq78AsJmQ==
X-Received: by 2002:a62:2b17:: with SMTP id r23-v6mr3802427pfr.251.1542746312223;
        Tue, 20 Nov 2018 12:38:32 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 78sm31996860pft.184.2018.11.20.12.38.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 12:38:31 -0800 (PST)
Date:   Tue, 20 Nov 2018 12:38:29 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 3.18 00/90] 3.18.126-stable review
Message-ID: <20181120203829.GA19385@roeck-us.net>
References: <20181119162620.585061184@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Build results:
	total: 138 pass: 134 fail: 4
Failed builds: 
	i386:allyesconfig 
	i386:allmodconfig 
	sparc64:allmodconfig 
	sparc64:defconfig 
Qemu test results:
	total: 221 pass: 209 fail: 12
Failed tests: 
	sparc64:sun4u:smp:initrd 
	sparc64:sun4u:smp:ata:rootfs 
	sparc64:sun4u:smp:mmc:rootfs 
	sparc64:sun4u:smp:nvme:rootfs 
	sparc64:sun4u:smp:scsi[MEGASAS]:rootfs
	sparc64:sun4u:smp:usb-xhci:rootfs 
	sparc64:sun4u:smp:usb-uas-xhci:rootfs 
	sparc64:sun4u:smp:virtio-pci:rootfs 
	sparc64:sun4v:smp:ata:rootfs 
	sparc64:sun4v:smp:nvme:rootfs 
	sparc64:sun4u:nosmp:ata:rootfs 
	sparc64:sun4v:nosmp:ata:rootfs

Details are available at https://kerneltests.org/builders/.

Guenter
