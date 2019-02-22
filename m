Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2168DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 07:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E835820823
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 07:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbfBVHbl convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 02:31:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56168 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725824AbfBVHbl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 02:31:41 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C0D203082A51;
        Fri, 22 Feb 2019 07:31:40 +0000 (UTC)
Received: from carbon (ovpn-200-42.brq.redhat.com [10.40.200.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6F51B5D9D4;
        Fri, 22 Feb 2019 07:31:32 +0000 (UTC)
Date:   Fri, 22 Feb 2019 08:31:31 +0100
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        brouer@redhat.com
Subject: Re: [PATCH] x86, retpolines: raise limit for generating indirect
 calls from switch-case
Message-ID: <20190222083131.5a141e23@carbon>
In-Reply-To: <20190221221941.29358-1-daniel@iogearbox.net>
References: <20190221221941.29358-1-daniel@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Fri, 22 Feb 2019 07:31:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Feb 2019 23:19:41 +0100
Daniel Borkmann <daniel@iogearbox.net> wrote:

> Recent work on XDP from Björn and Magnus additionally found that
> manually transforming the XDP return code switch statement with
> more than 5 cases into if-else combination would result in a
> considerable speedup in XDP layer due to avoidance of indirect
> calls in CONFIG_RETPOLINE enabled builds. On i40e driver with
> XDP prog attached, a 20-26% speedup has been observed [0]. Aside
> from XDP, there are many other places later in the networking
> stack's critical path with similar switch-case processing. Rather
> than fixing every XDP-enabled driver and locations in stack by
> hand, it would be good to instead raise the limit where gcc would
> emit expensive indirect calls from the switch under retpolines

I'm very happy to see this.  Thanks to Björn for finding, analyzing and
providing hand-coded-if-else code that demonstrated the performance
issue for XDP.  But I do think this GCC case-values-threshold param is
a better and more generic solution to the issue we observed and
measured in XDP land. And hopefully other parts of the network stack
and kernel will also benefit.

Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>

Thanks for following up on this Daniel,
-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer
