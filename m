Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC96FECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 15:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1442204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 15:14:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1442204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733128AbeGTQC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 12:02:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50092 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731035AbeGTQC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 12:02:56 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BC9CC407723B;
        Fri, 20 Jul 2018 15:14:12 +0000 (UTC)
Received: from krava (ovpn-204-117.brq.redhat.com [10.40.204.117])
        by smtp.corp.redhat.com (Postfix) with SMTP id AD0B51C5BC;
        Fri, 20 Jul 2018 15:14:10 +0000 (UTC)
Date:   Fri, 20 Jul 2018 17:14:09 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH 4/4] perf tools: Move syscall_64.tbl check into
 check-headers.sh
Message-ID: <20180720151409.GB27176@krava>
References: <20180720110036.32251-1-jolsa@kernel.org>
 <20180720110036.32251-4-jolsa@kernel.org>
 <20180720150354.GC4329@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180720150354.GC4329@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 20 Jul 2018 15:14:12 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 20 Jul 2018 15:14:12 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 12:03:54PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Fri, Jul 20, 2018 at 01:00:36PM +0200, Jiri Olsa escreveu:
> > Probably leftover from the time we introducd the check-headers.sh script.
> 
> So, with your patch:
> 
> [acme@jouet perf]$ git diff
> diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
> index f0b1709a5ffb..cfc1b0949bb1 100644
> --- a/arch/x86/entry/syscalls/syscall_64.tbl
> +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> @@ -343,6 +343,7 @@
>  332    common  statx                   __x64_sys_statx
>  333    common  io_pgetevents           __x64_sys_io_pgetevents
>  334    common  rseq                    __x64_sys_rseq
> +335    common  krava                   __x64_sys_krava
>  
>  #
>  # x32-specific system call numbers start at 512 to avoid cache impact
> [acme@jouet perf]$
> 
> 
> It doesn't warn about that new cool syscall, without your patch:
> 
> Warning: Kernel ABI header at 'tools/perf/arch/x86/entry/syscalls/syscall_64.tbl' differs from latest version at 'arch/x86/entry/syscalls/syscall_64.tbl'
> 
> Can you check this?

hum, did you have the previous patch applied?
without it it displays misleading output 

will check

jirka
