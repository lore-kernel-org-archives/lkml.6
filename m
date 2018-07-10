Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD86C5CFEB
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 02:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC6912089D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 02:38:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC6912089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933115AbeGJCiM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 22:38:12 -0400
Received: from nautica.notk.org ([91.121.71.147]:49922 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932797AbeGJCiH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 22:38:07 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 8C0E8C009; Tue, 10 Jul 2018 04:28:34 +0200 (CEST)
Date:   Tue, 10 Jul 2018 04:28:19 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Tomas Bortoli <tomasbortoli@gmail.com>
Cc:     ericvh@gmail.com, rminnich@sandia.gov, lucho@ionkov.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller@googlegroups.com, v9fs-developer@lists.sourceforge.net,
        davem@davemloft.net, Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [V9fs-developer]  [PATCH] p9_check_errors() validate PDU length
Message-ID: <20180710022819.GA19285@nautica>
References: <20180709224323.20597-1-tomasbortoli@gmail.com>
 <20180709235403.GB19917@nautica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180709235403.GB19917@nautica>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Tomas Bortoli wrote on Tue, Jul 10, 2018:
> As suggested by Dominique:
> https://lkml.org/lkml/2018/7/9/688
> Such check is not enough as it will prevent to read more than how it has
> been allocated but it won't prevent to read more than how it has been read
> So this patch will require some more changes to prevent bad sizes.

Sorry, I'm the one who suggested to put a note after the commit message
and I didn't see it.

Let's get the proper fix right away, it's not much further.


> Also, they really need to check against the actual read size, not just
> capacity.
> For virtio/rdma, something like this ought to fix pdu->size, then
> p9_parse_header can just never overwrite it (untested but it's useless
> on its own, I'll test the full patch with the parse header change)

I actually took the time to test a bit; I had only suggested something
for virtio/rdma because I had assumed trans_fd (the socket transport
actually used by syzbot) was setting the length in the fcall, but I read
that code too fast this morning and it is not (it only sets the size in
its private struct)

Something like that ought to work for trans_fd:
diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index 588bf88c3305..9f3ce370c685 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -369,6 +370,7 @@ static void p9_read_work(struct work_struct *work)
 	 */
 	if ((m->req) && (m->rc.offset == m->rc.capacity)) {
 		p9_debug(P9_DEBUG_TRANS, "got new packet\n");
+		m->req->rc->size = m->rc.offset;
 		spin_lock(&m->client->lock);
 		if (m->req->status != REQ_STATUS_ERROR)
 			status = REQ_STATUS_RCVD;
---

This however gets more complicated once you start factoring in that
change I suggested about p9_parse_header not setting size (and checking
size) because trans_fd relies on it; so I'm not sure how we should
proceed.

Do you have a working 9p tcp server to test changes are valid, or are
you only working off the syzbot reproducer?
In the first place, are you willing to take the time to do that bigger
fix?

At this point I can either help you get a working setup and let you do
the rest, or just finish the bigger patch myself and add you as whatever
tag you feel comfortable with (persumably Signed-off-by)

Thanks again for starting this,
-- 
Dominique Martinet | Asmadeus
