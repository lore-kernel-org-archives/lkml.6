Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EFA6C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D376220850
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PWmHurCQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbfARQUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 11:20:13 -0500
Received: from merlin.infradead.org ([205.233.59.134]:33984 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727707AbfARQUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 11:20:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xpKMkJb9W0ZAPps1pnRiR6Soxmr0tt+w6MkmCGfQp7E=; b=PWmHurCQr7NfqfAERvYUCuqLx
        2h71SIKO2kj+KdnlGqJPCYdGJ774k7vDtuP0XVUe/soZn12dNk091W5Zl4oodTJLY5GejlImME/+h
        gmiprxVkqkydKLzzRv9ZDgWLgsycSg/aOmFnrzHOe9DEiqi1lCd4tbzwijHZw171O83hT5FW9LZUl
        /vG491lw6XeNMpRMYxvcp2Vx4pKGsoVSO4Xd1JEgk23pwFB4EGdiTn5RWNf1ZZHYt6WtF0zNbAar/
        JgaV6kIRgI5D4Ju9CLyZuRMVqNIdeLCsk8FWSwUgPhGrIrFPNY2GJv0QnSRBTSKkkTUOiSmoAGUn7
        CcEbVtFYg==;
Received: from [89.200.44.227] (helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gkWsE-00049t-Jo; Fri, 18 Jan 2019 16:20:02 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id DBEC6983816; Fri, 18 Jan 2019 17:19:59 +0100 (CET)
Date:   Fri, 18 Jan 2019 17:19:59 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Clark Williams <williams@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Networking Development Mailing List 
        <netdev@vger.kernel.org>
Subject: Re: [PATCH/RFC] Make perf_event_open() propagate errors for use in
 bpf_perf_event_open()
Message-ID: <20190118161959.GI14054@worktop.programming.kicks-ass.net>
References: <20190111155538.GX22483@kernel.org>
 <20190118145237.GD27931@hirez.programming.kicks-ass.net>
 <20190118150938.GN5823@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190118150938.GN5823@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 12:09:38PM -0300, Arnaldo Carvalho de Melo wrote:
> commit 1b3b3dee572d0b77a316ab6715091201be6832de
> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date:   Fri Jan 11 13:20:20 2019 -0300
> 
>     perf: Make perf_event_output() propagate the output() return
>     
>     For the original mode of operation it isn't needed, since we report back
>     errors via PERF_RECORD_LOST records in the ring buffer, but for use in
>     bpf_perf_event_output() it is convenient to return the errors, basically
>     -ENOSPC.
>     
>     Currently bpf_perf_event_output() returns an error indication, the last
>     thing it does, which is to push it to the ring buffer is that can fail
>     and if so, this failure won't be reported back to its users, fix it.
>     
>     Reported-by: Jamal Hadi Salim <jhs@mojatatu.com>
>     Tested-by: Jamal Hadi Salim <jhs@mojatatu.com>
>     Cc: Adrian Hunter <adrian.hunter@intel.com>
>     Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
>     Cc: Daniel Borkmann <daniel@iogearbox.net>
>     Cc: Jiri Olsa <jolsa@kernel.org>
>     Cc: Namhyung Kim <namhyung@kernel.org>
>     Cc: Peter Zijlstra <peterz@infradead.org>
>     Link: https://lkml.kernel.org/r/20190111155538.GX22483@kernel.org
>     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

/me hates on git-format :-)

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

