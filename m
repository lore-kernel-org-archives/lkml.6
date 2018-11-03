Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB474C0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 13:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1D6D20833
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 13:00:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eroBnljk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1D6D20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbeKCWLe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 18:11:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:43238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727658AbeKCWLe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 18:11:34 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAB952081D;
        Sat,  3 Nov 2018 13:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541250017;
        bh=RDauV+NAnIZ1z++791qv+a8po41ID1/JFFCThntouls=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eroBnljkhNSjUsITF/cZidAslPLJ2ppXxa4t+K8vA7rKPpwIYqSjODrcIrRWjb+4V
         Rr9tp5Vjkntf+7iqs4BJWRlnDCvkiMHDFWSVSFBCR+sFGVU0i/KtCbVr7ZRZZa9Ayf
         I9BwxV7Umj9YeisGzZ7EQUUFinUZKD4kSFFR4EBw=
Date:   Sat, 3 Nov 2018 22:00:12 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Brendan Gregg <bgregg@netflix.com>,
        Christian Brauner <christian@brauner.io>,
        Aleksa Sarai <asarai@suse.de>, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 1/2] kretprobe: produce sane stack traces
Message-Id: <20181103220012.55ecd97e671c43e4959c8b62@kernel.org>
In-Reply-To: <20181102121307.32e99414@gandalf.local.home>
References: <20181101083551.3805-1-cyphar@cyphar.com>
        <20181101083551.3805-2-cyphar@cyphar.com>
        <20181101204720.6ed3fe37@vmware.local.home>
        <20181102050509.tw3dhvj5urudvtjl@yavin>
        <20181102065932.bdt4pubbrkvql4mp@yavin>
        <20181102091658.1bc979a4@gandalf.local.home>
        <20181102154325.bt6xoysl4xdl33wd@treble>
        <20181102121307.32e99414@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Nov 2018 12:13:07 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 2 Nov 2018 10:43:26 -0500
> Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> 
> > > I'll hopefully have a prototype ready by plumbers.  
> > 
> > Why do we need multiple users?  It would be a lot simpler if we could
> > just enforce a single user per fgraphed/kretprobed function (and return
> > -EBUSY if it's already being traced/probed).
> 
> Because that means if function graph tracer is active, then you can't
> do a kretprobe, and vice versa. I'd really like to have it working for
> multiple users, then we could trace different graph functions and store
> them in different buffers. It would also allow for perf to use function
> graph tracer too.

Steve, how woul you allow multiple users on it? Something like this?

ret_trampoline_multiple(){
   list_for_each(handler, &shadow_entry[i].handlers, list)
	handler(shadow_entry[i]);
   restore_retval_and_jump_to(shadow_entry[i].orig);
}


> > > And this too will require each architecture to probably change. As a
> > > side project to this, I'm going to try to consolidate the function
> > > graph code among all the architectures as well. Not an easy task.  
> > 
> > Do you mean implementing HAVE_FUNCTION_GRAPH_RET_ADDR_PTR for all the
> > arches?  If so, I think have an old crusty patch which attempted to
> > that.  I could try to dig it up if you're interested.
> > 
> 
> I'd like to have that, but it still requires some work. But I'd just
> the truly architecture dependent code be in the architecture (basically
> the asm code), and have the ability to move most of the duplicate code
> out of the archs.

I will also do that for kretprobe handlers.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
