Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E5AC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 20:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CC2821EFB
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 20:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="kDPpli3q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CC2821EFB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbeHIXZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 19:25:17 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37989 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbeHIXZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 19:25:16 -0400
Received: by mail-pf1-f195.google.com with SMTP id x17-v6so3415048pfh.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 13:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=Al8PqDjR/Dxz6exMSr/Ob2ELHruKwhtYKfTB/zFyOdM=;
        b=kDPpli3qT1cQggmt/BT/KBcDmwjv8tPZEx391VxHDU9ffVDSaeQ4VeA8TDW7rV9E8/
         kjBt9xmgML7jeJdhOCRJEx+cynbqszAcSwfNDkYM5gwM/SCU33ApDc696ZxM2OFYWhE4
         gkHuzmKhnVib1Vtr4+CuC9plgA233NNy4lk37rgkood24pj2m+HCMxf4RgDgLNMTeX6w
         nXKICuJ3VRKOg7kJ3wv+v7142X2fW9XbJNC8HNIec7maTyvP0CHwhlyntkgyoP0a4eBM
         +G22zO9n2TC+qK8Mw+/NGUD7c9vdz+1/CHagWgHdNo8fzdK5S+V+GD0mWC5X0K43+ltk
         KZhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=Al8PqDjR/Dxz6exMSr/Ob2ELHruKwhtYKfTB/zFyOdM=;
        b=YmbKgSWyg6etEDs4TEcXhdiuiLWVvq57qohpHUvNQjHWu05i8MiHYAJhLYJgPIv84G
         bmTbxOh7wt3fVKOCSDOFnwQzEvvD08fbIwSkMM8XwtDcFlkJTKIz8sfOB5OBxCSL6qzb
         sm2kMziKLBupFcdU6fhKUYnK/B8qXIG0cjgtb83hNxT0qpzeF7cAI7CbnLKh35wDjBnB
         mAihZYlBqCOO9zcUqPm/d4uPLOFEQ0n45r9/DlLzH3dJFt0eFwMiSmFB2j7eQ9aw6L3I
         227qB149QcTpcyr2SIClOps7cFxQgPEwpQMeXt7+Od5hDew5n2JXW9XJaawmAuf7ulkn
         eYMw==
X-Gm-Message-State: AOUpUlEZgPPIp+NA/nj+3D6ULLlZdiXHS/dLo06EM90gJfIyf5/5snLt
        yXoZ+NGC3R+Bfsbn+4uR1Td9OA==
X-Google-Smtp-Source: AA+uWPytd7G66HPas0id16A+N6t05hbT6hVTZf7OSYrJyajZ4QdHeAUexMxRQr9f7iKMqR1s02dWdQ==
X-Received: by 2002:a63:b91a:: with SMTP id z26-v6mr3626092pge.22.1533848322097;
        Thu, 09 Aug 2018 13:58:42 -0700 (PDT)
Received: from localhost ([96.76.210.210])
        by smtp.gmail.com with ESMTPSA id w81-v6sm18857302pfk.92.2018.08.09.13.58.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 13:58:41 -0700 (PDT)
Date:   Thu, 09 Aug 2018 13:58:41 -0700 (PDT)
X-Google-Original-Date: Thu, 09 Aug 2018 13:44:57 PDT (-0700)
Subject:     Re: [PATCH v2] RISC-V: Don't use a global include guard for uapi/asm/syscalls.h
In-Reply-To: <20180809055830.GA17533@infradead.org>
CC:     linux-riscv@lists.infradead.org,
        Christoph Hellwig <hch@infradead.org>, aou@eecs.berkeley.edu,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        tklauser@distanz.ch, marcus@mc.pp.se
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Christoph Hellwig <hch@infradead.org>
Message-ID: <mhng-b4f7b491-136a-474a-8d8b-0ab6ee218f09@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Aug 2018 22:58:30 PDT (-0700), Christoph Hellwig wrote:
> This actually seems to break the compilation for me in for-next:
>
> hch@carbon:~/work/linux$ make ARCH=riscv
>   CALL    scripts/checksyscalls.sh
> <stdin>:1335:2: warning: #warning syscall rseq not implemented [-Wcpp]
>   CHK     include/generated/compile.h
>   CC      arch/riscv/kernel/syscall_table.o
> ./arch/riscv/include/uapi/asm/syscalls.h:29:36: error: 'sys_riscv_flush_icache' undeclared here (not in a function); did you mean '__NR_riscv_flush_icache'?
>  __SYSCALL(__NR_riscv_flush_icache, sys_riscv_flush_icache)
>                                     ^
> arch/riscv/kernel/syscall_table.c:21:37: note: in definition of macro '__SYSCALL'
>  #define __SYSCALL(nr, call) [nr] = (call),
>                                      ^~~~
> make[1]: *** [scripts/Makefile.build:318: arch/riscv/kernel/syscall_table.o] Error 1
> make: *** [Makefile:1029: arch/riscv/kernel] Error 2
>
> Reverting it for now, but I guess this might hit others too..

Thanks.  I dropped this from for-next and just sent out a replacement.
