Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CEF0C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 04:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4893C2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 04:43:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4893C2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbeH2Iic (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 04:38:32 -0400
Received: from nautica.notk.org ([91.121.71.147]:53529 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726857AbeH2Iic (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 04:38:32 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 1DCE6C009; Wed, 29 Aug 2018 06:43:31 +0200 (CEST)
Date:   Wed, 29 Aug 2018 06:43:16 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Tomas Bortoli <tomasbortoli@gmail.com>
Cc:     lucho@ionkov.net, Dominique Martinet <dominique.martinet@cea.fr>,
        ericvh@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller@googlegroups.com,
        v9fs-developer@lists.sourceforge.net, rminnich@sandia.gov,
        davem@davemloft.net
Subject: Re: [V9fs-developer] [PATCH v2 2/2] 9p: Add refcount to p9_req_t
Message-ID: <20180829044316.GA11169@nautica>
References: <20180814174342.11068-1-tomasbortoli@gmail.com>
 <20180814174342.11068-2-tomasbortoli@gmail.com>
 <20180827230954.GA21513@nautica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180827230954.GA21513@nautica>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dominique Martinet wrote on Tue, Aug 28, 2018:
> I think I've found why (see below), so I'll push a fixed version after
> some more testing and another thorough read -- at some point today, but
> this hasn't been 'approved' explicitely so please review! :)

While the issue I pointed at was real, it wasn't what was causing the
refcount leak I was observing -- the problem is that we didn't drop a
ref when the request was successfully cancelled (e.g. the reply to the
flush came and the original request didn't get replied to)

The reason for this was that there were multiple versions of the patch
which alternated between doing the put in client.c after the cancelled
callback inconditionally, and doing the put in each transport's
cancelled() function, but virtio does not have this callback so that
didn't get added in the final version (codeveloping is hard); so I've
added an else() close to just issue a put if there is no callback.

(In the end, it felt better to have the req_put in the transport because
trans_fd is making refcounting difficult with its list handling, and
separating the put from the list removal would be more confusing than is
gained by sharing code)



Anyway, that's starting to be quite different from the v2 so I'll send a
v3 keeping Tomas as the author -- please check my edits are alright with
you, Tomas.

Meanwhile I'll keep running tests, I'm now confident about virtio but
want to spend more time on other transports again, so delaying the push
to linux-next for a few more days...

-- 
Dominique

