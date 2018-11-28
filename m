Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C988AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F2DA20832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:16:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F2DA20832
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbeK2BRt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 20:17:49 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:49665 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727823AbeK2BRt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 20:17:49 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id wASEFlgJ020544;
        Wed, 28 Nov 2018 15:15:47 +0100
Date:   Wed, 28 Nov 2018 15:15:47 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     dsterba@suse.cz, Yueyi Li <liyueyi@live.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "donb@securitymouse.com" <donb@securitymouse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        markus@oberhumer.com
Subject: Re: [PATCH v2] lzo: fix ip overrun during compress.
Message-ID: <20181128141547.GD20409@1wt.eu>
References: <BLUPR13MB0289EFEB79833470EE62F48EDFD10@BLUPR13MB0289.namprd13.prod.outlook.com>
 <20181128135242.gy3avmbp2pdmjaka@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128135242.gy3avmbp2pdmjaka@twin.jikos.cz>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Wed, Nov 28, 2018 at 02:52:42PM +0100, David Sterba wrote:
> The fix is adding a few branches to code that's supposed to be as fast
> as possible. The branches would be evaluated all the time while
> protecting against one signle bad page address. This does not look like
> a good performance tradeoff.

That was my concern as well, though the simplified test should be cheaper
especially since the branch is (almost) never taken and easily predicted.

> > +#define OVERFLOW_ADD_CHECK(a, b)  \
> > +		(((a) + (b)) < (a))
> 
> I'm not sure if this is generally safe overflow check (never not
> optimized out). Here it depends on the types of 'a' and 'b' that are
> pointer (ip) and size_t (m_len). GCC has __builtin_add_overflow_p so
> that one should be used where possible.

Sure but that one came with gcc 7 which is not exactly a reasonable
prerequisite especially when it comes to stable kernels. However I'm
now seeing that we have include/linux/overflow.h which provides this.
I have not checked what versions support it though, but 4.14 already
doesn't have it. Thus a fallback will be needed anyway and maintaining
two versions is not exactly the best thing to have to do :-/

Willy
