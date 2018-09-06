Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F8EC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E1D52075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:16:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E1D52075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cs.cmu.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbeIFQvl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 12:51:41 -0400
Received: from hurricane.elijah.cs.cmu.edu ([128.2.209.191]:37082 "EHLO
        hurricane.elijah.cs.cmu.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727126AbeIFQvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 12:51:41 -0400
Received: from [127.0.0.1] (helo=cs.cmu.edu)
        by hurricane.elijah.cs.cmu.edu with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.91)
        (envelope-from <jaharkes@cs.cmu.edu>)
        id 1fxtCz-0000yO-49; Thu, 06 Sep 2018 08:16:25 -0400
Date:   Thu, 6 Sep 2018 08:16:24 -0400
From:   Jan Harkes <jaharkes@cs.cmu.edu>
To:     Yann Droneaud <ydroneaud@opteya.com>
Cc:     David Howells <dhowells@redhat.com>, linux-api@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/11] UAPI: coda: Don't use internal kernel structs in
 UAPI
Message-ID: <20180906121623.6lrt6lajqstdymtx@cs.cmu.edu>
Mail-Followup-To: Yann Droneaud <ydroneaud@opteya.com>,
        David Howells <dhowells@redhat.com>, linux-api@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1c57005277ac723ebb670a1dc847a205f0529d53.camel@opteya.com>
 <153616286704.23468.584491117180383924.stgit@warthog.procyon.org.uk>
 <153616291029.23468.16421004714304578585.stgit@warthog.procyon.org.uk>
 <9916.1536218032@warthog.procyon.org.uk>
 <2e337313415a1ede1fb7a777902a0de7cb7c2602.camel@opteya.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2e337313415a1ede1fb7a777902a0de7cb7c2602.camel@opteya.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 01:52:29PM +0200, Yann Droneaud wrote:
> Hi,
> 
> Le jeudi 06 septembre 2018 à 08:13 +0100, David Howells a écrit :
> > Yann Droneaud <ydroneaud@opteya.com> wrote:
> > 
> > > This structure should not have been exposed to userspace in the
> > > first
> > > place: it's unusable by userspace as it is. It was incorrect to
> > > have it
> > > outside of #ifdef __KERNEL__ before commit 607ca46e97a1b ... 
> > > ...
> > > All CODA_REQ_* defines internals to kernel side and not exchanged
> > > with
> > > userspace.
> > > 
> > > Please move them back to <linux/coda_psdev.h>
> > 
> > Is there any reason coda_psdev.h needs to be in include/linux/ rather
> > than fs/coda/?
> > 
> 
> It's a valid concern.
> 
> At first I thought the first lines (see below) could have been useful
> for userspace:
> 
>   #define CODA_PSDEV_MAJOR 67
>   #define MAX_CODADEVS  5    /* how many do we allow */

Nope, userspace just tries to open /dev/cfs0, or a manually configured
alternative. We have only used linux/coda.h, and actually carry our own
copy of that file which is kept in sync manually, which is why there are
all those ifdefs for different systems in there. This all originates
from the time of the 2.1.x kernels when Coda was built externally.

> But the file was unsuable for a long long time so we can assume it's
> usage by userspace is deprecated, then we could remove it from UAPI,
> and moves its content back to include/linux.
> 
> As one could see include/linux/coda_psdev.h is not used outside of
> fs/coda, moving the header here as you suggests seems to be the correct
> solution.

Agreed.

Jan
