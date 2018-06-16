Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F7EC433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 13:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5177F208AF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 13:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xWaVBw0S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5177F208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754145AbeFPNui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 09:50:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:35142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751886AbeFPNug (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 09:50:36 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B64B420891;
        Sat, 16 Jun 2018 13:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529157035;
        bh=MQlqaUIDmGDehBXQNKo6NW3diC4pF+fa5Scm7LcZAxA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xWaVBw0S5AgSygX2OQ2/5m18rb3Mf8ttWS1M0MTU1qI05Chp65q9ZZ/K0Dsez11s9
         dWjg3VhGvY7Va3PeNFWp7Z5j0zT54++sWwDenFEDZGLCmILrePV3fP4wV8D93u6Zk7
         AsXZAMG/8WqWHZJFGUqg/ggD8y/2Mbj+Bh2JZduA=
Date:   Sat, 16 Jun 2018 22:50:32 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     oleg@redhat.com, srikar@linux.vnet.ibm.com, rostedt@goodmis.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, ananth@linux.vnet.ibm.com,
        alexis.berlemont@gmail.com, naveen.n.rao@linux.vnet.ibm.com
Subject: Re: [PATCH 0/7] Uprobes: Support SDT markers having reference count
 (semaphore)
Message-Id: <20180616225032.3fc9a027dca76926ff198ff8@kernel.org>
In-Reply-To: <6225481e-fa00-a242-2b57-223559e3c488@linux.ibm.com>
References: <20180606083344.31320-1-ravi.bangoria@linux.ibm.com>
        <20180608101023.cbf20db485026213d490cb7c@kernel.org>
        <0d487b32-3141-ec30-6cca-eba7159d70b0@linux.ibm.com>
        <20180608141431.c0196a2c80a8d4701bc9db58@kernel.org>
        <71f19b63-a641-1705-f087-a39b8b81c4be@linux.ibm.com>
        <20180609004549.ea7b1854772217598bb1cdfd@kernel.org>
        <6225481e-fa00-a242-2b57-223559e3c488@linux.ibm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ravi,

Sorry for replying later.

On Mon, 11 Jun 2018 10:01:58 +0530
Ravi Bangoria <ravi.bangoria@linux.ibm.com> wrote:

> Hi Masami,
> 
> >>> Hmm, it sounds simple... maybe we can increment refctr in install_breakpoint/
> >>> remove_breakpoint?
> >>
> >> Not really, it would be simpler if I can put it inside install_breakpoint().
> >> Consider an mmap() case. Probed instruction resides in the text section whereas
> >> reference counter resides in the data section. These sections gets mapped using
> >> separate mmap() calls. So, when process mmaps the text section we will change the
> >> instruction, but section holding the reference counter may not have been mapped
> >> yet in the virtual memory. If so, we will fail to update the reference counter.
> > 
> > Got it. 
> > In such case, maybe we can hook the target page mmapped and do install_breakpoint()
> > at that point. Since the instruction is protected by a refctr, unless mmap the
> > page on where the refctr is, the program doesn't reach the tracepoint. Is that right?
> > 
> 
> You mean, when mmap(text) happens, save the target page somewhere and when
> mmap(data) happens, update both instruction and ref_ctr?

Yes. I think you can just clone the target(text) page but not install
breakpoint, and if mmap(data) happens, update both.

> 
> This sounds feasible. Let me think on it.

Thanks!

> 
> Thanks for suggestion,
> Ravi
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
