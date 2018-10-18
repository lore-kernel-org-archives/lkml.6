Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD3CECDE44
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 15:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7587921473
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 15:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="siZ2aYQt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7587921473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbeJRXbT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 19:31:19 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45511 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbeJRXbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 19:31:16 -0400
Received: by mail-pg1-f195.google.com with SMTP id s3-v6so1136543pga.12;
        Thu, 18 Oct 2018 08:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=epaOL4uh+0jP5+eEJbbSmv1y9ZWo3nh4hRogVt+eKjk=;
        b=siZ2aYQtifyeYiHGVoVJ7lJVnEYt1UsLfiHnPmNXzW2OqlJISpafs0kGTi65KJjk86
         BphfVJ5WCyGxIwbf3ms2Hqs6IjRyWE5heKJcCed2kfWSqgMSnuDUaxPZEhGSb3rbhOb6
         mSeK18vQTBdmb5fsPQYmUCh4jwaOOXWPUyxETMS5nVp73nJTIjSGcGAKCH7A7+SGux4V
         aOMwzeRd3JvJClvSrOEiOsESS/StoC+aC/mGruzOrsxhXquMwuW4ZyuMd9ee2rEJVmmy
         5vhroMlYixKYbKyfWfjOD2S3oxRHeRnvqAD105C/DPVgYheWIWOOseKV5yxpxqOfjcE4
         zrOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=epaOL4uh+0jP5+eEJbbSmv1y9ZWo3nh4hRogVt+eKjk=;
        b=tInGMnuisS7BHiBqZuRHuIAn7dWdzWsuxjn8Ajmq2lZIvIEBRXOJgjOEszhpOWZFSb
         D0vxeHa1bTbKti5DgfQDmgKO3yzZY0dCXQO2XM3dzJMiNux7+YhyIPh0WC9pZJwKUqP4
         3yNe2IKk/plrP6UAf4WjJG6y8JC3QN4Od0Qjb1P8YH7hPj7AupGGGInMOx+B2zshmucb
         rExiRgjCusVVELa4dJTMndDZnHPnnchGuJN20ocHhkIrPvdJLKDQsnmAdFuJxUN6HvKy
         Zm/LLQEhGBIuNE+LZbeEBN21T86U2c3FM+Mxfy04aVwy8CSxov8uqYUhi5qEH2PGhlXq
         lWRg==
X-Gm-Message-State: ABuFfoirnDNdObze8A9CHg3QTcXUqu+q++apfwYY0f7TTmtuqcudvPUy
        9NZ1gf93PxHqL3wuBtPlbq87IEdD
X-Google-Smtp-Source: ACcGV61MekrPYpziSwk/ZviIW/Dej3Cc8J05myJy19XAwrQdoxTSPdZxx3MTxrgqqMG/voTM4hqxmA==
X-Received: by 2002:a63:3ec3:: with SMTP id l186-v6mr1780183pga.96.1539876584456;
        Thu, 18 Oct 2018 08:29:44 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id i2-v6sm20139861pgq.35.2018.10.18.08.29.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 08:29:43 -0700 (PDT)
Date:   Thu, 18 Oct 2018 08:29:42 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Hannes Reinecke <hare@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: linux-next: Tree for Oct 18
Message-ID: <20181018152942.GA5540@roeck-us.net>
References: <20181018180216.25e6fb79@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181018180216.25e6fb79@canb.auug.org.au>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 06:02:16PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> News: I will not be doing linux-next releases next week.  Unfortunately
> this will probably be the first week of the merge window. :-(
> 

Note: Every individual on Cc: might want to have a look. Either one of
your patches or one you approved causes at least one of the problems.

Build results:
	total: 135 pass: 120 fail: 15
Failed builds: 
	alpha:allmodconfig 
	arm:allmodconfig 
	arm64:allmodconfig 
	i386:allyesconfig 
	i386:allmodconfig 
	m68k:allmodconfig 
	mips:allmodconfig 
	nds32:allmodconfig 
	parisc:allmodconfig 
	powerpc:allmodconfig 
	powerpc:ppc6xx_defconfig
	s390:allmodconfig 
	sh:dreamcast_defconfig 
	sparc64:allmodconfig 
	xtensa:allmodconfig 
Qemu test results:
	total: 318 pass: 318 fail: 0

Build failures:

allmodconfig for all architectures:

fs/pstore/platform.o: In function `pstore_compression_late_init':
fs/pstore/.tmp_platform.o:(.init.text+0x0): multiple definition of `init_module'
fs/pstore/inode.o:(.init.text+0x0): first defined here

i386 (and probably other 32-bit builds):

ERROR: "__udivdi3" [drivers/scsi/myrs.ko] undefined!

powerpc:ppc6xx_defconfig:

net/sunrpc/auth_gss/gss_krb5_seal.c: In function 'gss_seq_send64_fetch_and_inc':
net/sunrpc/auth_gss/gss_krb5_seal.c:144:14: error: implicit declaration of function 'cmpxchg64'

sh:dreamcast_defconfig:

drivers/cdrom/gdrom.c: In function 'probe_gdrom':
drivers/cdrom/gdrom.c:797:3: error: 'rc' undeclared

Guenter
