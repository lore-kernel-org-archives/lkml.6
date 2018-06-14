Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id C8EBBC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 08:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76027208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 08:43:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76027208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754730AbeFNInY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 04:43:24 -0400
Received: from smtp.eu.citrix.com ([185.25.65.24]:9125 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752824AbeFNInW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 04:43:22 -0400
X-IronPort-AV: E=Sophos;i="5.51,222,1526342400"; 
   d="scan'208";a="74641745"
Date:   Thu, 14 Jun 2018 10:43:13 +0200
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Anchal Agarwal <anchalag@amazon.com>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <x86@kernel.org>, <boris.ostrovsky@oracle.com>,
        <konrad.wilk@oracle.com>, <netdev@vger.kernel.org>,
        <jgross@suse.com>, <xen-devel@lists.xenproject.org>,
        <linux-kernel@vger.kernel.org>, <kamatam@amazon.com>,
        <eduval@amazon.com>, <vallish@amazon.com>, <fllinden@amazon.com>,
        <guruanb@amazon.com>, <rjw@rjwysocki.net>, <pavel@ucw.cz>,
        <len.brown@intel.com>, <linux-pm@vger.kernel.org>,
        <cyberax@amazon.com>
Subject: Re: [RFC PATCH 06/12] xen-blkfront: add callbacks for PM suspend and
 hibernation
Message-ID: <20180614084313.43njg3hbhqoptlqc@mac>
References: <20180612205619.28156-1-anchalag@amazon.com>
 <20180612205619.28156-7-anchalag@amazon.com>
 <20180613082428.bjdko4k6cnq6eid3@mac>
 <20180613222048.GB33296@kaos-source-ops-60001.pdx1.amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180613222048.GB33296@kaos-source-ops-60001.pdx1.amazon.com>
User-Agent: NeoMutt/20180512
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please try to avoid top posting.

On Wed, Jun 13, 2018 at 10:20:48PM +0000, Anchal Agarwal wrote:
> Hi Roger,
> To answer your question, due to the lack of mentioned commit
> (commit 12ea729645ac ("xen/blkback: unmap all persistent grants when
> frontend gets disconnected") in the older dom0 kernels(<3.2),resume from

This fix that you mention is only present in kernels >= 3.18 AFAICT,
and persistent grants where introduced in 3.8 (0a8704a51f38), so
anything < 3.8 should work fine. Not sure why you mention 3.2 here.

> hibernation can fail on guest side. In the absence of the commit,
> Persistant Grants are not unmapped immediately when frontend is 
> disconnected from backend and hence leave the block device in an 
> inconsistent state. To avoid this unstability and work with larger set 
> of kernel versions, this approach had been used. Once you don't have 
> any pending req/resp it is safer for guest to resume from hibernation.

I think the fix should be backported (if it hasn't been done yet) to
kernels between 3.8 and 3.18. I don't like to add all this code just
to work around a Linux backend kernel bug.

AFAICT if persistent grants work as expected you could use almost the
same path that's used for migration, greatly reducing the amount of
code that you need to add.

Thanks, Roger.
