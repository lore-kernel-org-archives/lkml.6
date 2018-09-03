Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33744C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 07:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0A5020856
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 07:31:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0A5020856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbeICLuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 07:50:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38968 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725869AbeICLuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 07:50:12 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A41F88575B;
        Mon,  3 Sep 2018 07:31:19 +0000 (UTC)
Received: from krava (unknown [10.43.17.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B573763A7E;
        Mon,  3 Sep 2018 07:31:18 +0000 (UTC)
Date:   Mon, 3 Sep 2018 09:31:18 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Kim Phillips <kim.phillips@arm.com>
Cc:     Andi Kleen <andi@firstfloor.org>, acme@kernel.org,
        jolsa@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Make perf script easier to use for itrace
Message-ID: <20180903073117.GC24575@krava>
References: <20180831220206.28351-1-andi@firstfloor.org>
 <20180831175453.7378c5dd74d498b6d9002512@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180831175453.7378c5dd74d498b6d9002512@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Mon, 03 Sep 2018 07:31:19 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Mon, 03 Sep 2018 07:31:19 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 05:54:53PM -0500, Kim Phillips wrote:
> On Fri, 31 Aug 2018 15:01:56 -0700
> Andi Kleen <andi@firstfloor.org> wrote:
> 
> > Also available in
> > git://git.kernel.org/pub/scm/linux/kernel/git/ak/linux-misc.git pt/easy-script-2
> > 
> > v1: Initial post
> > v2: Address review comments. Minor fixes to descriptions. Now builds everywhere.
> 
> OK, I grabbed the pt/easy-script-2 branch (commit 4c69fd388e17), and
> see build failures for a 'make -C perf' build using gcc version 7.3.0
> (Ubuntu 18.04):
> 
> builtin-script.c: In function ‘parse_output_fields’:
> builtin-script.c:2571:22: error: array subscript is above array bounds [-Werror=array-bounds]
>      output[j].fields &= ~all_output_options[i].field;
>                       ^~
> builtin-script.c:2571:22: error: array subscript is above array bounds [-Werror=array-bounds]
>      output[j].fields &= ~all_output_options[i].field;
>      ~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> builtin-script.c:2574:10: error: array subscript is above array bounds [-Werror=array-bounds]
>     output[j].user_set = true;
>     ~~~~~~^~~
> builtin-script.c:2575:10: error: array subscript is above array bounds [-Werror=array-bounds]
>     output[j].wildcard_set = true;
>     ~~~~~~^~~
> ...
> util/cs-etm.c: In function ‘cs_etm__process_auxtrace_info’:
> util/cs-etm.c:1436:14: error: ‘struct perf_session’ has no member named ‘itrace_synth’; did you mean ‘itrace_synth_opts’?
>      session->itrace_synth.default_no_sample);
>               ^~~~~~~~~~~~
>               itrace_synth_opts

I think Andi has the new changes in pt/easy-script-3 branch,
just did not update the changelog

jirka
