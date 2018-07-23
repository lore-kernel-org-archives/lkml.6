Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B083ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 19:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F61820852
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 19:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7H93GQY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F61820852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388139AbeGWUEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 16:04:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:47886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387970AbeGWUEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 16:04:00 -0400
Received: from jouet.infradead.org (unknown [177.79.81.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 584FD20852;
        Mon, 23 Jul 2018 19:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532372485;
        bh=WAOPmkV/r7p97CdXB89beVQGMBRehOKwVUABmvcMNZI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h7H93GQY+pAgO4H51b6TXY6x279UBWmVwZE1BD+/tHjtyBsM+iY0P/xUgBZkIRO/w
         RrJtLrzYqbO+TWx/cukC3EheCPwsprRMBXDqv+heGllhBK3kueDLhP0O73Ti3FL64R
         mCtyHEM+rDSFnwh18OtveOnbBpUqCovc5ELHeKWQ=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 0EF09140260; Mon, 23 Jul 2018 16:01:21 -0300 (-03)
Date:   Mon, 23 Jul 2018 16:01:21 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Kim Phillips <kim.phillips@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] perf arm64: Generate system call table from
 asm/unistd.h
Message-ID: <20180723190121.GB13220@kernel.org>
References: <20180706163443.22626f5e9e10e5bab5e5c662@arm.com>
 <20180718155752.GA1814@kernel.org>
 <20180720150653.GD4329@kernel.org>
 <20180723185905.GA13220@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180723185905.GA13220@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jul 23, 2018 at 03:59:05PM -0300, Arnaldo Carvalho de Melo escreveu:
> A quick hack is to do this instead:

I'm going with this quick hack applied so that I can pass all tests,
feel free to provide an alternative patch that makes
tools/include/uapi/asm-generic/unistd.h be used when included by
tools/arch/arm64/include/uapi/asm/unistd.h, that I haven't tried to do
and looks the right fix.

- Arnaldo
 
> diff --git a/tools/perf/arch/arm64/Makefile b/tools/perf/arch/arm64/Makefile
> index 85fdf4949db3..f013b115dc86 100644
> --- a/tools/perf/arch/arm64/Makefile
> +++ b/tools/perf/arch/arm64/Makefile
> @@ -11,7 +11,7 @@ PERF_HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET := 1
>  
>  out    := $(OUTPUT)arch/arm64/include/generated/asm
>  header := $(out)/syscalls.c
> -sysdef := $(srctree)/tools/arch/arm64/include/uapi/asm/unistd.h
> +sysdef := $(srctree)/tools/include/uapi/asm-generic/unistd.h
>  sysprf := $(srctree)/tools/perf/arch/arm64/entry/syscalls/
>  systbl := $(sysprf)/mksyscalltbl
>  
> diff --git a/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl b/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
> index c21023509960..52e197317d3e 100755
> --- a/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
> +++ b/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
> @@ -28,6 +28,7 @@ create_table_from_c()
>  
>  	cat <<-_EoHEADER
>  		#include <stdio.h>
> +		#define __ARCH_WANT_RENAMEAT
>  		#include "$input"
>  		int main(int argc, char *argv[])
>  		{
