Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DDDEC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 22:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51A7B20824
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 22:01:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51A7B20824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lio96.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407773AbeKWImn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 03:42:43 -0500
Received: from er-systems.de ([148.251.68.21]:50634 "EHLO er-systems.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730054AbeKWImn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 03:42:43 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
        by er-systems.de (Postfix) with ESMTP id 24C25D6006F;
        Thu, 22 Nov 2018 23:01:19 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by er-systems.de (Postfix) with ESMTPS id 06655D6006C;
        Thu, 22 Nov 2018 23:01:19 +0100 (CET)
Date:   Thu, 22 Nov 2018 23:01:18 +0100 (CET)
From:   Thomas Voegtle <tv@lio96.de>
X-X-Sender: thomas@er-systems.de
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org,
        Chris Wilson <chris@chris-wilson.co.uk>
Subject: Re: [PATCH 4.19 00/42] 4.19.4-stable review
In-Reply-To: <alpine.LSU.2.21.1811222148260.12239@er-systems.de>
Message-ID: <alpine.LSU.2.21.1811222259160.22493@er-systems.de>
References: <20181121183147.869199006@linuxfoundation.org> <alpine.LSU.2.21.1811222148260.12239@er-systems.de>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-74181308-616663799-1542924079=:22493"
X-Virus-Status: No
X-Virus-Checker-Version: clamassassin 1.2.4 with clamdscan / ClamAV 0.100.2/25143/Thu Nov 22 15:14:45 2018 signatures 58.
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---74181308-616663799-1542924079=:22493
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 22 Nov 2018, Thomas Voegtle wrote:

>
> Doesn't compile for me on OpenSuSE 15.0 (gcc 7.3.1):
>
>   CALL    scripts/checksyscalls.sh
>   DESCEND  objtool
>   CHK     include/generated/compile.h
>   CC [M]  drivers/gpu/drm/i915/i915_gem_gtt.o
> drivers/gpu/drm/i915/i915_gem_gtt.c: In function ‘gen6_dump_ppgtt’:
> drivers/gpu/drm/i915/i915_gem_gtt.c:1771:41: error: format ‘%llx’ expects
> argument of type ‘long long unsigned int’, but argument 5 has type ‘long
> unsigned int’ [-Werror=format=]
>    seq_printf(m, "\t\t(%03d, %04d) %08llx: ",
>                                    ~~~~~ ^
>                                    %08lx
> cc1: all warnings being treated as errors
> make[4]: *** [scripts/Makefile.build:306:
> drivers/gpu/drm/i915/i915_gem_gtt.o] Error 1
> make[3]: *** [scripts/Makefile.build:546: drivers/gpu/drm/i915] Error 2
> make[2]: *** [scripts/Makefile.build:546: drivers/gpu/drm] Error 2
> make[1]: *** [scripts/Makefile.build:546: drivers/gpu] Error 2
> make: *** [Makefile:1052: drivers] Error 2
>
>
>
> 4.19.3 is broken for me, too. 4.19.2 is works.
> 4.20-rc tree works.
>
> Config attached.


quick bisect shows problem is:

commit 1a25e1a1be71a49ee7f34fb14b5a26191e6cf501
Author: Chris Wilson <chris@chris-wilson.co.uk>
Date:   Thu Oct 25 10:18:22 2018 +0100

     drm/i915: Mark up GTT sizes as u64

     commit c58281056a8b26d5d9dc15c19859a7880835ef44 upstream.


reverted on 4.19.4-rc1 it compiles for me. I guess something is missing 
here?


    Thomas

---74181308-616663799-1542924079=:22493--

