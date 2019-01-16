Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD61C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B07420657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:32:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405695AbfAPQcf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 11:32:35 -0500
Received: from ms.lwn.net ([45.79.88.28]:51036 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726593AbfAPQcf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 11:32:35 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 6A469300;
        Wed, 16 Jan 2019 16:32:34 +0000 (UTC)
Date:   Wed, 16 Jan 2019 09:32:33 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        ravi.bangoria@linux.ibm.com
Subject: Re: [PATCH] perf scripts python: Add Python 3 support to
 mem-phys-addr.py
Message-ID: <20190116093233.4873b784@lwn.net>
In-Reply-To: <1547655825-28754-8-git-send-email-s1seetee@linux.vnet.ibm.com>
References: <1547655825-28754-1-git-send-email-s1seetee@linux.vnet.ibm.com>
        <1547655825-28754-8-git-send-email-s1seetee@linux.vnet.ibm.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jan 2019 21:53:36 +0530
Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com> wrote:

> Support both Python 2 and Python 3 in mem-phys-addr.py. ``print`` is now a
> function rather than a statement. This should have no functional change.
> 
> Fix lambda syntax error.

So, I just picked one of these at random....

> Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
> Reviewed-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> ---
>  tools/perf/scripts/python/mem-phys-addr.py | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/scripts/python/mem-phys-addr.py b/tools/perf/scripts/python/mem-phys-addr.py
> index ebee2c5..52fe9bd 100644
> --- a/tools/perf/scripts/python/mem-phys-addr.py
> +++ b/tools/perf/scripts/python/mem-phys-addr.py
> @@ -38,14 +38,14 @@ def parse_iomem():
>  			pmem.append(long(m[1], 16))
>  
>  def print_memory_type():
> -	print "Event: %s" % (event_name)
> -	print "%-40s  %10s  %10s\n" % ("Memory type", "count", "percentage"),
> -	print "%-40s  %10s  %10s\n" % ("----------------------------------------", \
> -					"-----------", "-----------"),
> +	print("Event: %s" % (event_name))
> +	print("%-40s  %10s  %10s\n" % ("Memory type", "count", "percentage")),
> +	print("%-40s  %10s  %10s\n" % ("----------------------------------------", \
> +					"-----------", "-----------")),

You have not added "from __future__ import print_function", so you're
relying on a Python 2 parsing oddity to make this work.  If anybody ever
adds a second parameter, things will break.  I think that if you really
want to support both versions (which seems like the right goal) you should
add the import and do it properly.

Thanks,

jon
