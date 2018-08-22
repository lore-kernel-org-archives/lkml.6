Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0050C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 16:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DAA02147A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 16:23:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DAA02147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbeHVTt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 15:49:29 -0400
Received: from g2t2352.austin.hpe.com ([15.233.44.25]:37025 "EHLO
        g2t2352.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbeHVTt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 15:49:29 -0400
X-Greylist: delayed 65563 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 Aug 2018 15:49:29 EDT
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2352.austin.hpe.com (Postfix) with ESMTP id D4A82A1;
        Wed, 22 Aug 2018 16:23:56 +0000 (UTC)
Received: from linux-tqvx (linux-tqvx.americas.hpqcorp.net [10.34.51.15])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id 4B39137;
        Wed, 22 Aug 2018 16:23:56 +0000 (UTC)
Date:   Wed, 22 Aug 2018 11:23:54 -0500
From:   Andrew Banman <abanman@hpe.com>
To:     Corey Minyard <minyard@acm.org>
Cc:     Andrew Banman <abanman@hpe.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        justin.ernst@hpe.com, rja@hpe.com, frank.ramsay@hpe.com,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] IPMI state machine regression
Message-ID: <20180822162352.q7qc2udqabbqxdya@linux-tqvx>
References: <20180821221443.hhgcnzw6xttaih3i@linux-tqvx.americas.hpqcorp.net>
 <a72a169e-ce1b-500c-7910-b400c7842033@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a72a169e-ce1b-500c-7910-b400c7842033@acm.org>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 11:14:52AM -0500, Corey Minyard wrote:
> On 08/21/2018 05:14 PM, Andrew Banman wrote:
> > Dear IPMI supporters,
> > 
> > We observe a window in IPMI BT's opportunistic get capabilities request,
> > wherein GET_DEVICE_GUID and GET_DEVICE_ID requests may start while the BT state
> > machine is in WR_CONSUME. Following this, the 0xD5 error code is forced in
> > bt_start_transaction, IPMI fails to initialize, and the interface is torn down.
> > There is no mechanism to retry bringing up the interface in open() /dev/ipmi.
> > This leaves IPMI hosed until you reload modules. Looks to happen after we call
> > schedule().
> 
> When was the latest kernel where this worked properly?  Also, what hardware
> is this?

This is UV4.

First known bad commit, but I am not sure if the timing issue predates
it:

commit aa9c9ab2443e3b9562c6c7cfc245a9e43b557d14
Author: Jeremy Kerr <jk@ozlabs.org>
Date:   Fri Aug 25 15:47:24 2017 +0800

    ipmi: allow dynamic BMC version information

Hits less frequently with older kernels so I didn't see it until
recently when it became more frequent.

> 
> BTW, you can use the "hotmod" capability of the IPMI driver to add the
> device
> dynamically.
> 
> -corey
