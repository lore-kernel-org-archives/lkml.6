Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A215C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 05:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17A532089E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 05:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eCTnNaa+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17A532089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbeHIIVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 04:21:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53786 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727686AbeHIIVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 04:21:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WYSGnL8hWx2htObt47U4psfp1sAmIErfRguMuv2hmVU=; b=eCTnNaa+Iz6djwcAm+OlaQQge
        YVlhvyLrFWMS8DQyDGsyhEUP+/nzXlhLfXyKnJhzp9QNVOciXVPx0HKd6OhKYQKYEtna7QELm7g/n
        EbZZJw7uiqojPaIXcJQ//Lcy86ddHSd+ivx51wzvs2CZnaAKrIyfkHHzRgdu4vj1giFAABGu2iIlY
        8wNZ6MFs/Nb3PiHoDi0YRuYtHHgHhKRD5gsv+ERRtLhNvKBJMIh9eWiF7wRNHG2rXHWroV8DmkFiv
        rNJEhy7qQPNdr5GP9hrPEuU+ljyoDTfFMFugwVGaSDm0eY4HIEHTizsbUXBgLjS1BPQKGQ6nPnGtQ
        n6WZvn5KQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fndxu-0004cC-Qb; Thu, 09 Aug 2018 05:58:30 +0000
Date:   Wed, 8 Aug 2018 22:58:30 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     linux-riscv@lists.infradead.org,
        Christoph Hellwig <hch@infradead.org>, aou@eecs.berkeley.edu,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        tklauser@distanz.ch, Marcus Comstedt <marcus@mc.pp.se>
Subject: Re: [PATCH v2] RISC-V: Don't use a global include guard for
 uapi/asm/syscalls.h
Message-ID: <20180809055830.GA17533@infradead.org>
References: <20180804085438.GA15840@infradead.org>
 <20180806204258.22280-1-palmer@sifive.com>
 <20180806204258.22280-2-palmer@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180806204258.22280-2-palmer@sifive.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This actually seems to break the compilation for me in for-next:

hch@carbon:~/work/linux$ make ARCH=riscv
  CALL    scripts/checksyscalls.sh
<stdin>:1335:2: warning: #warning syscall rseq not implemented [-Wcpp]
  CHK     include/generated/compile.h
  CC      arch/riscv/kernel/syscall_table.o
./arch/riscv/include/uapi/asm/syscalls.h:29:36: error: 'sys_riscv_flush_icache' undeclared here (not in a function); did you mean '__NR_riscv_flush_icache'?
 __SYSCALL(__NR_riscv_flush_icache, sys_riscv_flush_icache)
                                    ^
arch/riscv/kernel/syscall_table.c:21:37: note: in definition of macro '__SYSCALL'
 #define __SYSCALL(nr, call) [nr] = (call),
                                     ^~~~
make[1]: *** [scripts/Makefile.build:318: arch/riscv/kernel/syscall_table.o] Error 1
make: *** [Makefile:1029: arch/riscv/kernel] Error 2

Reverting it for now, but I guess this might hit others too..
