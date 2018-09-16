Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F87ECE563
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 00:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B54E3208AE
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 00:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="R0kN7fOX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B54E3208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbeIPFup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 01:50:45 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:39389 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbeIPFuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 01:50:44 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id a230ffda;
        Sun, 16 Sep 2018 00:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=tUGq1FJQbaDHxpOkGCLVmXUptsI=; b=R0kN7f
        OXQqvo99bW9+KtzPUuVuLYeIaxtYFmlq/XFzkFi8UAoSWC2eNByXQnrM3hFuQ16M
        RnY+Lp68ZQEDIrT0S5jrViuWveWDUAUmx/LYfId41F6zOqpaeQh2r1BqpaIjOtVk
        ikpFLcoXW39oSpnVCyYET5SS8I/zsZfwx7571qbx08O8SO5O9ia0ezN295evpNwp
        7bWnb6y7stRsvI14pPAXGgOQBq/nb2FpkVXMZ1s6BumoScoHRDjwUh/AGT7nCjCe
        6meT5iN3vlN5y/MuHCy90ujlpisBqKgWTawc0dHHYAAlVY+BHpOpH7QmH6wgi5wZ
        I/dPDVWgDDb5yVWg==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ae1a11ab (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Sun, 16 Sep 2018 00:12:33 +0000 (UTC)
Received: by mail-oi0-f54.google.com with SMTP id l82-v6so15944748oih.11;
        Sat, 15 Sep 2018 17:29:47 -0700 (PDT)
X-Gm-Message-State: APzg51BKkJus63OSNkW9X/FqXIjKt0V2+B42BpuJFp3SaAZgcR1QFfuZ
        yyyn6BoBhJE6xpMASxfgEawNL3Pz+wwsGXamWKQ=
X-Google-Smtp-Source: ANB0VdbwsAzrb2AfFFHzun8t8vCJX/yoZDIE7jZVFXJjYitTAbyJ0nZcoMbeYF7KJ5vLNAW1x/Xbn6ea/7kgb927IVw=
X-Received: by 2002:aca:e795:: with SMTP id e143-v6mr13838169oih.252.1537057786269;
 Sat, 15 Sep 2018 17:29:46 -0700 (PDT)
MIME-Version: 1.0
References: <20180914162240.7925-20-Jason@zx2c4.com> <201809160738.Z71qdjGu%fengguang.wu@intel.com>
In-Reply-To: <201809160738.Z71qdjGu%fengguang.wu@intel.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sun, 16 Sep 2018 02:29:35 +0200
X-Gmail-Original-Message-ID: <CAHmME9pjQroUEq3ORMSiQaS5acMTDOOcvDiOP6EAtABVkRZkVA@mail.gmail.com>
Message-ID: <CAHmME9pjQroUEq3ORMSiQaS5acMTDOOcvDiOP6EAtABVkRZkVA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 19/20] security/keys: rewrite big_key crypto
 to use Zinc
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andrew Lutomirski <luto@kernel.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Eric Biggers <ebiggers3@gmail.com>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey again Ro,

> 32bbe22e Jason A. Donenfeld 2018-09-14  49      imply KERNEL_MODE_NEON if CPU_V7

This shouldn't have ever been there anyway. Fixed now for v5.

Thanks,
Jason
