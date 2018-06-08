Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id PmvWKLEyGltfUAAAmS7hNA
	; Fri, 08 Jun 2018 07:41:05 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 6C72E607E4; Fri,  8 Jun 2018 07:41:05 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id F161C6074D;
	Fri,  8 Jun 2018 07:41:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F161C6074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752626AbeFHHlD (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 03:41:03 -0400
Received: from outbound-smtp16.blacknight.com ([46.22.139.233]:37478 "EHLO
        outbound-smtp16.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751140AbeFHHk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 03:40:59 -0400
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp16.blacknight.com (Postfix) with ESMTPS id 32B981C1647
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jun 2018 08:40:58 +0100 (IST)
Received: (qmail 32150 invoked from network); 8 Jun 2018 07:40:58 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.237.171])
  by 81.17.254.9 with ESMTPSA (DHE-RSA-AES256-SHA encrypted, authenticated); 8 Jun 2018 07:40:58 -0000
Date: Fri, 8 Jun 2018 08:40:57 +0100
From: Mel Gorman <mgorman@techsingularity.net>
To: Jirka Hladky <jhladky@redhat.com>
Cc: Jakub Racek <jracek@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Subject: Re: [4.17 regression] Performance drop on kernel-4.17 visible on
 Stream, Linpack and NAS parallel benchmarks
Message-ID: <20180608074057.jtxczsw3jwx6boti@techsingularity.net>
References: <20180606122731.GB27707@jra-laptop.brq.redhat.com>
 <20180607123915.avrqbpp4adgj7ck4@techsingularity.net>
 <CAE4VaGBAZ0HCy-M2rC3ce9ePOBhE6H-LDVBuJDJMNFf40j70Aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAE4VaGBAZ0HCy-M2rC3ce9ePOBhE6H-LDVBuJDJMNFf40j70Aw@mail.gmail.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 08, 2018 at 07:49:37AM +0200, Jirka Hladky wrote:
> Hi Mel,
> 
> we will do the bisection today and report the results back.
> 

The most likely outcome is 2c83362734dad8e48ccc0710b5cd2436a0323893
which is a patch that restricts newly forked processes from selecting a
remote node when the local node is similarly loaded. The upside is that
an almost idle node will not queue that task on a remote node. The
downside is that there are cases that the newly forked task allocates a
lot of memory and then the idle balancer spreads it anyway. It'll be a
classic case of "win some, lose some".

That would match this pattern

> > > * all processes are started at NODE #1

So at fork time, the local node is almost idle and is used

> > > * memory is also allocated on NODE #1

Early in the lifetime of the task

> > > * roughly half of the processes are moved to the NODE #0 very quickly. *

Idle balancer kicks in

> > > however, memory is not moved to NODE #0 and stays allocated on NODE #1
> > >

automatic NUMA balancing doesn't run long enough to migrate all the
memory. That would definitely be the case for STREAM. It's less clear
for NAS where, depending on the parallelisation, wake_affine can keep a
task away from its memory or it's cross-node migrating a lot. As before,
I've no idea about linpack.

-- 
Mel Gorman
SUSE Labs
