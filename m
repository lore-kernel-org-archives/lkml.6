Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB62C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 04:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E0BA20843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 04:11:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E0BA20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbeGYFVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 01:21:41 -0400
Received: from nautica.notk.org ([91.121.71.147]:50871 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726773AbeGYFVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 01:21:41 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id B7657C009; Wed, 25 Jul 2018 06:11:54 +0200 (CEST)
Date:   Wed, 25 Jul 2018 06:11:39 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Tomas Bortoli <tomasbortoli@gmail.com>
Cc:     davem@davemloft.net, v9fs-developer@lists.sourceforge.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller@googlegroups.com
Subject: Re: [PATCH] 9p: validate PDU length
Message-ID: <20180725041139.GB11041@nautica>
References: <20180723154404.2406-1-tomasbortoli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180723154404.2406-1-tomasbortoli@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tomas Bortoli wrote on Mon, Jul 23, 2018:
> diff --git a/net/9p/client.c b/net/9p/client.c
> index 18c5271910dc..92240ccf476b 100644
> --- a/net/9p/client.c
> +++ b/net/9p/client.c
> @@ -524,6 +525,12 @@ static int p9_check_errors(struct p9_client *c, struct p9_req_t *req)
>  	int ecode;
>  
>  	err = p9_parse_header(req->rc, NULL, &type, NULL, 0);
> +	if (req->rc->size >= c->msize) {

I was looking at this again, I think it's more appropriate to use
req->rc->capacity at this point like you did in the first version of the
patch.

I had suggested msize in the common p9_parse_header function because
that'd let us accept zc requests where the size in the pdu could be
bigger than capacity, but this isn't the case in p9_check_errors.

If you're ok with this I'll edit your commit directly, this is less work
for me than having to check a new patch.

Thanks,
-- 
Dominique
