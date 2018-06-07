Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id nqnzJh03GVs4YwAAmS7hNA
	; Thu, 07 Jun 2018 13:46:05 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 80B216089E; Thu,  7 Jun 2018 13:46:05 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+xxUOGD"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 8F348602FC;
	Thu,  7 Jun 2018 13:46:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8F348602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932681AbeFGNp7 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 09:45:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:57660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753088AbeFGNp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 09:45:57 -0400
Received: from jouet.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA79C2086E;
        Thu,  7 Jun 2018 13:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528379157;
        bh=9+UR/Djv9T1yG9zK+kmVcweUbtZOLEhk5tcf2Fsf9MM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U+xxUOGD5m550saYjWFcRBlnaMHF4DiAsmMGi8ql58+I9N1oBNAyHZ+hwe3a6+EFV
         5iw59CGQW6ARWdqxmlQHzhjcSy6ZIDP7JghnUWffDY8Aq3Q96itruiAUFVJxipKfg/
         st/ZHPJhCz3xsz1oSPeiEkWDnYpOo2aKh9z22afg=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 4930E1468B9; Thu,  7 Jun 2018 10:45:54 -0300 (-03)
Date: Thu, 7 Jun 2018 10:45:54 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Paul Clarke <pc@us.ibm.com>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Namhyung Kim <namhyung@kernel.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH 42/46] perf script powerpc: Python script for hypervisor
 call statistics
Message-ID: <20180607134554.GD30317@kernel.org>
References: <20180605175030.32549-1-acme@kernel.org>
 <20180605175030.32549-43-acme@kernel.org>
 <c58ba06a-2a1b-a981-b9a5-27708ea2479a@us.ibm.com>
 <5856a13c-7a34-f4f4-d5f2-100f626a213f@linux.ibm.com>
 <d4b791e1-28ca-cd19-467b-a59e28a14f99@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4b791e1-28ca-cd19-467b-a59e28a14f99@us.ibm.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jun 07, 2018 at 08:41:46AM -0500, Paul Clarke escreveu:
> On 06/07/2018 12:34 AM, Ravi Bangoria wrote:
> > On 06/06/2018 08:23 PM, Paul Clarke wrote:
> >> On 06/05/2018 12:50 PM, Arnaldo Carvalho de Melo wrote:
> >>> From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> >>>
> >>> Add python script to show hypervisor call statistics. Ex,
> >>>
> >>>   # perf record -a -e "{powerpc:hcall_entry,powerpc:hcall_exit}"
> >>>   # perf script -s scripts/python/powerpc-hcalls.py
> >>>     hcall                            count   min(ns)   max(ns)   avg(ns)
> >>>     --------------------------------------------------------------------
> >>>     H_RANDOM                            82       838      1164       904
> >>>     H_PUT_TCE                           47      1078      5928      2003
> >>>     H_EOI                              266      1336      3546      1654
> >>>     H_ENTER                             28      1646      4038      1952
> >>>     H_PUT_TCE_INDIRECT                 230      2166     18168      6109
> >>>     H_IPI                              238      1072      3232      1688
> >>>     H_SEND_LOGICAL_LAN                  42      5488     21366      7694
> >>>     H_STUFF_TCE                        294       986      6210      3591
> >>>     H_XIRR                             266      2286      6990      3783
> >>>     H_PROTECT                           10      2196      3556      2555
> >>>     H_VIO_SIGNAL                       294      1028      2784      1311
> >>>     H_ADD_LOGICAL_LAN_BUFFER            53      1978      3450      2600
> >>>     H_SEND_CRQ                          77      1762      7240      2447
> >>
> >> This translation from HCALL code to mnemonic is more generally useful.  Is there a good way to make the "hcall_table_lookup" function more generally available, like "syscall_name" in scripts/python/Perf-Trace-Util/lib/Perf/Trace/Util.py ?  It's even simpler than the syscall ID-to-name mapping, because the HCALL codes are constant, unlike syscall IDs which vary between arches.
> >>
> > 
> > Right, but I don't see any other python script for hcalls. So, I thought
> > to add it in the script itself. Let me know if you are planning to add
> > any :) We will move it in a generic module.
 
> We're already doing the same thing in an external script.
> (https://github.com/open-power-sdk/curt/blob/master/curt.py#L264
> revision 107c97c3aadba3177bc8cf35b06ba165e6ac557f.)
 
> ...which reminds me that I should consider sending that script to
> linux-perf-users to see if it's interesting enough to be included
> upstream.

If you don't have any restriction, then its interesting to have it
included, I think, this way we can find these kinds of needed common
infrastructure more easily, and also when doing changes take into
account existing scripts.

- Arnaldo
