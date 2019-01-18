Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F86BC61CE4
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 03:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC8B720850
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 03:15:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730440AbfASDPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 22:15:30 -0500
Received: from outbound1mad.lav.puc.rediris.es ([130.206.19.138]:20956 "EHLO
        mx01.puc.rediris.es" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730389AbfASDP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 22:15:29 -0500
X-Greylist: delayed 10138 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Jan 2019 22:15:26 EST
Received: from sim.rediris.es (mta-out04.sim.rediris.es [130.206.24.46])
        (user=smtp-out_iram mech=LOGIN bits=0)
        by mx01.puc.rediris.es  with ESMTP id x0IHIvZD032248-x0IHIvZF032248
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 18 Jan 2019 18:18:57 +0100
Received: from sim.rediris.es (localhost.localdomain [127.0.0.1])
        by sim.rediris.es (Postfix) with ESMTPS id 2AC0A3957F;
        Fri, 18 Jan 2019 18:18:50 +0100 (CET)
Received: from sim.rediris.es (localhost.localdomain [127.0.0.1])
        by sim.rediris.es (Postfix) with ESMTPS id 0AF0F39581;
        Fri, 18 Jan 2019 18:18:46 +0100 (CET)
Received: from lt-gp.iram.es (46.246.223.87.dynamic.jazztel.es [87.223.246.46])
        by sim.rediris.es (Postfix) with ESMTPA id 7728C3957F;
        Fri, 18 Jan 2019 18:18:37 +0100 (CET)
Date:   Fri, 18 Jan 2019 18:18:30 +0100
From:   Gabriel Paubert <paubert@iram.es>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     y2038@lists.linaro.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        dalias@libc.org, linux-ia64@vger.kernel.org,
        linux-sh@vger.kernel.org, catalin.marinas@arm.com,
        will.deacon@arm.com, jcmvbkbc@gmail.com, deepa.kernel@gmail.com,
        hpa@zytor.com, sparclinux@vger.kernel.org,
        linux-s390@vger.kernel.org, deller@gmx.de, x86@kernel.org,
        linux@armlinux.org.uk, mingo@redhat.com, geert@linux-m68k.org,
        firoz.khan@linaro.org, mattst88@gmail.com, fenghua.yu@intel.com,
        heiko.carstens@de.ibm.com, linux-fsdevel@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, luto@kernel.org,
        tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
        monstr@monstr.eu, tony.luck@intel.com,
        linux-parisc@vger.kernel.org, netdev@vger.kernel.org,
        linux-mips@vger.kernel.org, paul.burton@mips.com,
        ebiederm@xmission.com, linux-alpha@vger.kernel.org,
        schwidefsky@de.ibm.com, akpm@linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
Subject: Re: [PATCH v2 13/29] arch: add split IPC system calls where needed
Message-ID: <20190118171830.quvvwdgbuhq2nqrh@lt-gp.iram.es>
References: <20190118161835.2259170-1-arnd@arndb.de>
 <20190118161835.2259170-14-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190118161835.2259170-14-arnd@arndb.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-FEAS-AUTH-USER: smtp-out_iram
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 05:18:19PM +0100, Arnd Bergmann wrote:
> The IPC system call handling is highly inconsistent across architectures,
> some use sys_ipc, some use separate calls, and some use both.  We also
> have some architectures that require passing IPC_64 in the flags, and
> others that set it implicitly.
> 
> For the additon of a y2083 safe semtimedop() system call, I chose to only

It's not critical, but there are two typos in that line: 
additon -> addition
2083 -> 2038

	Gabriel

> support the separate entry points, but that requires first supporting
> the regular ones with their own syscall numbers.
> 
> The IPC_64 is now implied by the new semctl/shmctl/msgctl system
> calls even on the architectures that require passing it with the ipc()
> multiplexer.
> 
> I'm not adding the new semtimedop() or semop() on 32-bit architectures,
> those will get implemented using the new semtimedop_time64() version
> that gets added along with the other time64 calls.
> Three 64-bit architectures (powerpc, s390 and sparc) get semtimedop().
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
