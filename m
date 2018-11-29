Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB01C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 11:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDF8B206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 11:33:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDF8B206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbeK2Wii (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 17:38:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48402 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726736AbeK2Wih (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 17:38:37 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 58A609FDDE;
        Thu, 29 Nov 2018 11:33:34 +0000 (UTC)
Received: from krava (unknown [10.43.17.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 59B5A6012C;
        Thu, 29 Nov 2018 11:33:32 +0000 (UTC)
Date:   Thu, 29 Nov 2018 12:33:30 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v4 0/4] perf report/annotate: Support average IPC and IPC
 coverage for function
Message-ID: <20181129113330.GE25884@krava>
References: <1543505978-19808-1-git-send-email-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1543505978-19808-1-git-send-email-yao.jin@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 29 Nov 2018 11:33:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 11:39:34PM +0800, Jin Yao wrote:
> Add supporting of displaying the average IPC and IPC coverage
> percentage per function.
> 
> For example,
> 
> $ perf record -b ...
> $ perf report -s symbol or
>   perf report -s symbol --stdio
> 
> Overhead  Symbol                           IPC   [IPC Coverage]
>   39.60%  [.] __random                     2.30  [ 54.8%]
>   18.02%  [.] main                         0.43  [ 54.3%]
>   14.21%  [.] compute_flag                 2.29  [100.0%]
>   14.16%  [.] rand                         0.36  [100.0%]
>    7.06%  [.] __random_r                   2.57  [ 70.5%]
>    6.85%  [.] rand@plt                     0.00  [  0.0%]
>   ...
> 
> $ perf annotate --stdio2
> 
> Percent  IPC Cycle (Average IPC: 2.30, IPC Coverage: 54.8%)
> 
>                         Disassembly of section .text:
> 
>                         000000000003aac0 <random@@GLIBC_2.2.5>:
>   8.32  3.28              sub    $0x18,%rsp
>         3.28              mov    $0x1,%esi
>         3.28              xor    %eax,%eax
>         3.28              cmpl   $0x0,argp_program_version_hook@@GLIBC_2.2.5+0x1e0
>  11.57  3.28     1      ↓ je     20
>                           lock   cmpxchg %esi,__abort_msg@@GLIBC_PRIVATE+0x8a0
>                         ↓ jne    29
>                         ↓ jmp    43
>  11.57  1.10        20:   cmpxchg %esi,__abort_msg@@GLIBC_PRIVATE+0x8a0
>  ...
> 
> v4:
> ---
>     Add a new patch "perf report: Documentation average IPC and IPC coverage"
>     to explain the new columns "IPC" and "IPC Coverage".
> 
>     Other patches are not changed.
> 
> v3:
> ---
>     Remove the sortkey "ipc" from command-line. The columns "IPC"
>     and "[IPC Coverage]" are automatically enabled when "symbol"
>     is specified.
> 
>     Patch "perf report: Display average IPC and IPC coverage per symbol"
>     is impacted.
> 
> v2:
> ---
>   1. Merge in Jiri's patch to support stdio mode
> 
>   2. Add a new patch "perf annotate: Create a annotate2 flag
>      in struct symbol" which records if the symbol has been
>      annotated yet.
> 
>   3. Minor update such as adding { } for multiline code in 'if'
>      condition.
> 
> Jin Yao (4):
>   perf annotate: Compute average IPC and IPC coverage per symbol
>   perf annotate: Create a annotate2 flag in struct symbol
>   perf report: Display average IPC and IPC coverage per symbol
>   perf report: Documentation average IPC and IPC coverage

Reviewed-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka
