Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F84EC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 08:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9C4F2174C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 08:27:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9C4F2174C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731311AbeHCKWz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 06:22:55 -0400
Received: from nautica.notk.org ([91.121.71.147]:58203 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728129AbeHCKWz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 06:22:55 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 7EB3AC009; Fri,  3 Aug 2018 10:27:40 +0200 (CEST)
Date:   Fri, 3 Aug 2018 10:27:25 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     jiangyiwen <jiangyiwen@huawei.com>
Cc:     Eric Van Hensbergen <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        v9fs-developer@lists.sourceforge.net, netdev@vger.kernel.org
Subject: Re: [V9fs-developer] [PATCH] net/9p: avoid request size exceed to
 the virtqueue number in the zero copy
Message-ID: <20180803082725.GA8655@nautica>
References: <5B63FB4D.1050703@huawei.com>
 <20180803073240.GA26848@nautica>
 <5B640FCC.3000704@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5B640FCC.3000704@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

jiangyiwen wrote on Fri, Aug 03, 2018:
> On 2018/8/3 15:32, Dominique Martinet wrote:
> > jiangyiwen wrote on Fri, Aug 03, 2018:
> >> Unfortunately, when the address(input and response headers) are not
> >> at page boundary, it will need two extra entry in the zero copy, or
> >> else it will cause sg array out of bounds.
> >>
> >> To avoid the problem, we should subtract two pages for maxsize.
> > 
> > Good catch, that must have been painful to figure.
> > 
> > Given we know how big the headers are (something like 11 or 23 bytes
> > depending on the op/direction, it's capped by P9_IOHDRSZ at 24),
> > couldn't we just cheat and not use the start of the buffer if we detect
> > it's overlapping?
> 
> Actually, generally the P9_IOHDRSZ will not cause the problem, because
> 24 bytes is too small, but P9_ZC_HDR_SZ(4096 bytes) often cause two pages.
> 
> So I have a question about why we need to use P9_ZC_HDR_SZ, actually we
> may use P9_IOHDRSZ instead.

The reason is historical (for non-dotl versions of 9P), but the reply if
error could be longer than P9_IOHDRSZ in this case - see the code in
p9_check_zc_errors that copies the end of the string back from the zc
buffer to the 4k buffer

I don't see much other reason, though... But I don't understand how that
is a problem - we don't actually put the full P9_ZC_HDR_SZ in chan->sg
for headers, but these:
        out = pack_sg_list(chan->sg, 0,
                           VIRTQUEUE_NUM, req->tc.sdata, req->tc.size);
        in = pack_sg_list(chan->sg, out,
                          VIRTQUEUE_NUM, req->rc.sdata, in_hdr_len);

req->tc.size is the size of the header up till that point and in_hdr_len
is the size expected from the header.
That's why I suggested that if these are on a page boundary, we could
just memcpy that data further within the P9_ZC_HDR_SZ-sized buffer and
use that for the header (then move it back to the start of the buffer
for the reply header)

-- 
Dominique
