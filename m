Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E39EC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E096820838
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:42:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E096820838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbeLGRml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 12:42:41 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50392 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726072AbeLGRml (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 12:42:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 51E77EBD;
        Fri,  7 Dec 2018 09:42:40 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.113])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BCE943F5AF;
        Fri,  7 Dec 2018 09:42:34 -0800 (PST)
Date:   Fri, 7 Dec 2018 17:42:32 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Michal Hocko <mhocko@suse.com>, linux-sh@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Rich Felker <dalias@libc.org>,
        Paul Mackerras <paulus@samba.org>,
        "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-hexagon@vger.kernel.org, x86@kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        James Hogan <jhogan@kernel.org>,
        linux-snps-arc@lists.infradead.org,
        Huang Ying <ying.huang@intel.com>, linux-mips@vger.kernel.org,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Vineet Gupta <vgupta@synopsys.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Richard Kuo <rkuo@codeaurora.org>,
        Paul Burton <paul.burton@mips.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [REPOST PATCH v6 0/4] kgdb: Fix kgdb_roundup_cpus()
Message-ID: <20181207174231.GD11961@arrakis.emea.arm.com>
References: <20181205033828.6156-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181205033828.6156-1-dianders@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 07:38:24PM -0800, Douglas Anderson wrote:
> Douglas Anderson (4):
>   kgdb: Remove irq flags from roundup
>   kgdb: Fix kgdb_roundup_cpus() for arches who used smp_call_function()
>   kgdb: Don't round up a CPU that failed rounding up before
>   kdb: Don't back trace on a cpu that didn't round up

FWIW, trying these on arm64 (ThunderX2) with CONFIG_KGDB_TESTS_ON_BOOT=y
on top of 4.20-rc5 doesn't boot. It looks like they leave interrupts
disabled when they shouldn't and it trips over the BUG at
mm/vmalloc.c:1380 (called via do_fork -> copy_process).

Now, I don't think these patches make things worse on arm64 since prior
to them the kgdb boot tests on arm64 were stuck in a loop (RUN
singlestep).

-- 
Catalin
