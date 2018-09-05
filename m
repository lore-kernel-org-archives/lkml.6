Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E280C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 17:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF4352075E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 17:25:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF4352075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cs.cmu.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbeIEV4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 17:56:20 -0400
Received: from hurricane.elijah.cs.cmu.edu ([128.2.209.191]:60246 "EHLO
        hurricane.elijah.cs.cmu.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727397AbeIEV4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 17:56:20 -0400
X-Greylist: delayed 1828 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Sep 2018 17:56:19 EDT
Received: from [127.0.0.1] (helo=cs.cmu.edu)
        by hurricane.elijah.cs.cmu.edu with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.91)
        (envelope-from <jaharkes@cs.cmu.edu>)
        id 1fxb4q-00074u-Sb; Wed, 05 Sep 2018 12:54:48 -0400
Date:   Wed, 5 Sep 2018 12:54:47 -0400
From:   Jan Harkes <jaharkes@cs.cmu.edu>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-api@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/11] UAPI: coda: Don't use internal kernel structs in
 UAPI
Message-ID: <20180905165447.gnjcc2xbgaem3ue3@cs.cmu.edu>
Mail-Followup-To: David Howells <dhowells@redhat.com>,
        linux-api@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <153616286704.23468.584491117180383924.stgit@warthog.procyon.org.uk>
 <153616291029.23468.16421004714304578585.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153616291029.23468.16421004714304578585.stgit@warthog.procyon.org.uk>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 04:55:10PM +0100, David Howells wrote:
> The size and layout of internal kernel structures may not be relied upon
> outside of the kernel and may even change in a containerised environment if
> a container image is frozen and shifted to another machine.
> 
> Excise these from Coda's upc_req struct.

Argh, that won't work.

I still have to look at where this structure is used exactly, but...

Either this structure is used by the messages that the kernel sends to
userspace, in which case we don't want the kernel to pack the larger
structure that includes a list_head and a wait_queue_head_t in the
message while userspace reads as if it was a smaller structure without
those.

But my gut feeling is that this is not part of the upcall request
messages and never gets to userspace and as such shouldn't be in uapi to
begin with.

Jan

