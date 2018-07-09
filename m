Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47480C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E48322089D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:55:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E48322089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933275AbeGIOzH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 10:55:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47746 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932654AbeGIOzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 10:55:05 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 57F6D808255B;
        Mon,  9 Jul 2018 14:55:05 +0000 (UTC)
Received: from krava (ovpn-204-174.brq.redhat.com [10.40.204.174])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5110E2026D6B;
        Mon,  9 Jul 2018 14:55:03 +0000 (UTC)
Date:   Mon, 9 Jul 2018 16:55:02 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Janne Huttunen <janne.huttunen@nokia.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jaroslav =?utf-8?B?xaBrYXJ2YWRh?= <jskarvad@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2] perf script python: Fix dict reference counting
Message-ID: <20180709145502.GB7917@krava>
References: <20180709094159.GA7615@krava>
 <1531133990-17485-1-git-send-email-janne.huttunen@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531133990-17485-1-git-send-email-janne.huttunen@nokia.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 09 Jul 2018 14:55:05 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 09 Jul 2018 14:55:05 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 01:59:50PM +0300, Janne Huttunen wrote:
> The dictionaries are attached to the parameter tuple that steals
> the references and takes care of releasing them when appropriate.
> The code should not decrement the reference counts explicitly.
> E.g. if libpython has been built with reference debugging enabled,
> the superfluous DECREFs will trigger this error when running perf
> script:
> 
>   Fatal Python error: Objects/tupleobject.c:238 object at
>   0x7f10f2041b40 has negative ref count -1
>   Aborted (core dumped)
> 
> If the reference debugging is not enabled, the superfluous DECREFs
> might cause the dict objects to be silently released while they are
> still in use. This may trigger various other assertions or just
> cause perf crashes and/or weird and unexpected data changes in the
> stored Python objects.
> 
> Signed-off-by: Janne Huttunen <janne.huttunen@nokia.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka
