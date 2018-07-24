Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C500C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 13:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7E3E20875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 13:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wYlvz9Ry"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7E3E20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388438AbeGXOwc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 10:52:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:57752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388361AbeGXOwc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 10:52:32 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 275A520874;
        Tue, 24 Jul 2018 13:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532439958;
        bh=WSgl6aXDaO5SDBFWp5HYa0Ro3PNOEbv16kZcP85nHVo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wYlvz9RyfsAfUoY2V7xBQ1HIFFV0nXgswvPJJc8tGd+9qd22k98MEUvkrthoJuoWT
         R70rujTV1+zNM5B10UN/jt+jbnB232lOhWtEG/2Bf6Pgy4dFrA22V/oBPi0+se9PVc
         gj4PmpJxJ+mhqzPCm9nokotXrJTDOkb5SUNVwi/g=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 3DAD0140260; Tue, 24 Jul 2018 10:45:54 -0300 (-03)
Date:   Tue, 24 Jul 2018 10:45:54 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Stefan Liebler <stli@linux.ibm.com>
Cc:     linux-perf-users@vger.kernel.org,
        Thomas-Mich Richter <tmricht@linux.ibm.com>,
        Stefan Liebler <stli@linux.vnet.ibm.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Wang Nan <wangnan0@huawei.com>, Jiri Olsa <jolsa@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Include file bpf.h in directory /usr/lib/include/perf/bpf/bpf.h
Message-ID: <20180724134554.GA5630@kernel.org>
References: <e6e3b74d-5a36-e6ac-a576-0c39c03cbc64@linux.ibm.com>
 <20180723141912.GA5804@kernel.org>
 <6a78dbf0-bd6a-17de-4bd4-b4b9faad94d1@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a78dbf0-bd6a-17de-4bd4-b4b9faad94d1@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jul 24, 2018 at 12:49:43PM +0200, Stefan Liebler escreveu:
> In each case, the introduction of the subdirectory /usr/lib/include leads to
> the regression that one can't build the glibc RPM for s390 anymore as gcc
> can't find headers like stdbool.h.
 
> Should bpf.h be moved to /usr/lib/perf/include/bpf/bpf.h?

Thanks for the report, yes, I agree with your analysis, breaking the
assumptions of existing setups like that is not good, can you send a
patch, including this analysis so that this gets documented in the
project's git changeset history?

I wonder if we even shouldn't go one extra step and have it in:

/usr/lib/perf/bpf/include/bpf/bpf.h?

That extra /bpf/ is to make it sure that everything below
/usr/lib/perf/bpf/ is to be used in generating eBPF objects to be loaded
via sys_bpf(), of which the "include/bpf" subdir and bpf.h are for basic
BPF aspects such as the definition of maps, etc, while include/fmt/
(below /usr/lib/perf/bpf/) could be C inline functions to be used in .c
files to generate eBPF ELF objects, and other function "libraries" could
live in different directories in this hierarchy.

One can think about /usr/lib/perf/something-else-that-requires-c-headers/
like if we decide to create shared objects to process tracepoint events
obtained from the kernel in a pretty format by just using the tracefs
metadata, where we would transform a .c file into something other than
a eBPF ELF file.

But yeah, to fix the problem you described we have to have it all under
/usr/lib/perf/

- Arnaldo
