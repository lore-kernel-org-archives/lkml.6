Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA07C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE9662087F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:25:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE9662087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754548AbeGIOZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 10:25:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43752 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752112AbeGIOZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 10:25:11 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AE46C40201A2;
        Mon,  9 Jul 2018 14:25:10 +0000 (UTC)
Received: from krava (ovpn-204-174.brq.redhat.com [10.40.204.174])
        by smtp.corp.redhat.com (Postfix) with SMTP id 7A37D2026D6B;
        Mon,  9 Jul 2018 14:25:08 +0000 (UTC)
Date:   Mon, 9 Jul 2018 16:25:07 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Sandipan Das <sandipan@linux.ibm.com>,
        Milian Wolff <milian.wolff@kdab.com>
Cc:     acme@kernel.org, linux-kernel@vger.kernel.org, namhyung@kernel.org,
        ravi.bangoria@linux.ibm.com, naveen.n.rao@linux.vnet.ibm.com
Subject: Re: [PATCH] perf script: Show correct offsets for DWARF-based
 unwinding
Message-ID: <20180709142507.GA7917@krava>
References: <20180703120555.32971-1-sandipan@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703120555.32971-1-sandipan@linux.ibm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Mon, 09 Jul 2018 14:25:10 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Mon, 09 Jul 2018 14:25:10 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 05:35:55PM +0530, Sandipan Das wrote:

SNIP

> 
> After:
> 
>   # perf report --stdio --no-children -s sym,srcline -g address
> 
>   # Samples: 1  of event 'probe_libc:inet_pton'
>   # Event count (approx.): 1
>   #
>   # Overhead  Symbol                Source:Line
>   # ........  ....................  ...........
>   #
>      100.00%  [.] __GI___inet_pton  inet_pton.c
>               |
>               ---gaih_inet.constprop.7 getaddrinfo.c:537
>                  getaddrinfo getaddrinfo.c:2304
>                  main ping.c:519
>                  generic_start_main.isra.0 libc-start.c:308
>                  __libc_start_main libc-start.c:102
>   ...
> 
>   # perf script -F comm,ip,sym,symoff,srcline,dso
> 
>   ping
>               7fffb38aaf28 __GI___inet_pton+0x8 (/usr/lib64/libc-2.26.so)
>     inet_pton.c:68
>               7fffb385fa53 gaih_inet.constprop.7+0xf43 (/usr/lib64/libc-2.26.so)
>     getaddrinfo.c:537
>               7fffb38605b3 getaddrinfo+0x163 (/usr/lib64/libc-2.26.so)
>     getaddrinfo.c:2304
>                  130782d6f main+0x3df (/usr/bin/ping)
>     ping.c:519
>               7fffb377369f generic_start_main.isra.0+0x13f (/usr/lib64/libc-2.26.so)
>     libc-start.c:308
>               7fffb3773897 __libc_start_main+0xb7 (/usr/lib64/libc-2.26.so)
>     libc-start.c:102
> 
> Fixes: 67540759151a ("perf unwind: Use addr_location::addr instead of ip for entries")
> Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>

looks good to me, Milian?

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka
