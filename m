Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D6E08C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 08:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96A3020891
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 08:25:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96A3020891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934635AbeFMIZr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 04:25:47 -0400
Received: from smtp.eu.citrix.com ([185.25.65.24]:27873 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934388AbeFMIZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 04:25:45 -0400
X-IronPort-AV: E=Sophos;i="5.51,218,1526342400"; 
   d="scan'208";a="74572845"
Date:   Wed, 13 Jun 2018 10:24:28 +0200
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Anchal Agarwal <anchalag@amazon.com>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <x86@kernel.org>, <boris.ostrovsky@oracle.com>,
        <konrad.wilk@oracle.com>, <netdev@vger.kernel.org>,
        <jgross@suse.com>, <xen-devel@lists.xenproject.org>,
        <linux-kernel@vger.kernel.org>, <kamatam@amazon.com>,
        <fllinden@amazon.com>, <vallish@amazon.com>, <guruanb@amazon.com>,
        <eduval@amazon.com>, <rjw@rjwysocki.net>, <pavel@ucw.cz>,
        <len.brown@intel.com>, <linux-pm@vger.kernel.org>,
        <cyberax@amazon.com>
Subject: Re: [RFC PATCH 06/12] xen-blkfront: add callbacks for PM suspend and
 hibernation
Message-ID: <20180613082428.bjdko4k6cnq6eid3@mac>
References: <20180612205619.28156-1-anchalag@amazon.com>
 <20180612205619.28156-7-anchalag@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180612205619.28156-7-anchalag@amazon.com>
User-Agent: NeoMutt/20180512
X-ClientProxiedBy: AMSPEX02CAS01.citrite.net (10.69.22.112) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 08:56:13PM +0000, Anchal Agarwal wrote:
> From: Munehisa Kamata <kamatam@amazon.com>
> 
> Add freeze and restore callbacks for PM suspend and hibernation support.
> The freeze handler stops a block-layer queue and disconnect the frontend
> from the backend while freeing ring_info and associated resources. The
> restore handler re-allocates ring_info and re-connect to the backedend,
> so the rest of the kernel can continue to use the block device
> transparently.Also, the handlers are used for both PM
> suspend and hibernation so that we can keep the existing suspend/resume
> callbacks for Xen suspend without modification.
> If a backend doesn't have commit 12ea729645ac ("xen/blkback: unmap all
> persistent grants when frontend gets disconnected"), the frontend may see
> massive amount of grant table warning when freeing resources.
> 
>  [   36.852659] deferring g.e. 0xf9 (pfn 0xffffffffffffffff)
>  [   36.855089] xen:grant_table: WARNING: g.e. 0x112 still in use!
> 
> In this case, persistent grants would need to be disabled.
> 
> Ensure no reqs/rsps in rings before disconnecting. When disconnecting
> the frontend from the backend in blkfront_freeze(), there still may be
> unconsumed requests or responses in the rings, especially when the
> backend is backed by network-based device. If the frontend gets
> disconnected with such reqs/rsps remaining there, it can cause
> grant warnings and/or losing reqs/rsps by freeing pages afterward.

I'm not sure why having pending requests can cause grant warnings or
lose of requests. If handled properly this shouldn't be an issue.
Linux blkfront already does live migration (which also involves a
reconnection of the frontend) with pending requests and that doesn't
seem to be an issue.

> This can lead resumed kernel into unrecoverable state like unexpected
> freeing of grant page and/or hung task due to the lost reqs or rsps.
> Therefore we have to ensure that there is no unconsumed requests or
> responses before disconnecting.

Given that we have multiqueue, plus multipage rings, I'm not sure
waiting for the requests on the rings to complete is a good idea.

Why can't you just disconnect the frontend and requeue all the
requests in flight? When the frontend connects on resume those
requests will be queued again.

Thanks, Roger.
