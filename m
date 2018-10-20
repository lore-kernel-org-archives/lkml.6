Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F6AC67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 05:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA31F21502
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 05:05:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA31F21502
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbeJTNOd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 09:14:33 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:46106 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbeJTNOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 09:14:33 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gDjRy-0006SV-1A; Sat, 20 Oct 2018 05:05:22 +0000
Date:   Sat, 20 Oct 2018 06:05:22 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/24] iov_iter: Add I/O discard iterator
Message-ID: <20181020050521.GJ32577@ZenIV.linux.org.uk>
References: <153999783767.866.7957078562330181644.stgit@warthog.procyon.org.uk>
 <153999785961.866.5674146318200239679.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153999785961.866.5674146318200239679.stgit@warthog.procyon.org.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 20, 2018 at 02:10:59AM +0100, David Howells wrote:

> @@ -1060,6 +1074,9 @@ void iov_iter_revert(struct iov_iter *i, size_t unroll)
>  	}
>  	unroll -= i->iov_offset;
>  	switch (iov_iter_type(i)) {
> +	case ITER_DISCARD:
> +		i->iov_offset = 0;
> +		return;

... the hell?  That makes no sense whatsoever; what, besides this and immediately
preceding part of iov_iter_revert() so much as looks at ->iov_offset for those?
Just have it bugger off before the
        if (unroll <= i->iov_offset) {
                i->iov_offset -= unroll;
                return;
        }
bit...
