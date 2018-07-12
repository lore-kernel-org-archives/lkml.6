Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2110AC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 07:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D40D221479
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 07:01:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D40D221479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbeGLHJv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 03:09:51 -0400
Received: from nautica.notk.org ([91.121.71.147]:37391 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbeGLHJv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 03:09:51 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 3C547C009; Thu, 12 Jul 2018 09:01:37 +0200 (CEST)
Date:   Thu, 12 Jul 2018 09:01:22 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     piaojun <piaojun@huawei.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        ericvh@gmail.com, rminnich@sandia.gov, lucho@ionkov.net,
        v9fs-developer@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [V9fs-developer] [PATCH] net/9p/client.c: fix misuse of
 spin_lock_irqsave for p9_client lock
Message-ID: <20180712070122.GB7639@nautica>
References: <5B46F5AD.50200@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5B46F5AD.50200@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

piaojun wrote on Thu, Jul 12, 2018:
> In p9_read_work(), we use spin_lock for client->lock, but misuse
> spin_lock_irqsave for it in p9_fid_create(). As p9_client lock won't be
> locked in irq context, so spin_lock is enough. And that will improve the
> performance.

Agreed on principle, see remark below

> Signed-off-by: Jun Piao <piaojun@huawei.com>
> ---
>  net/9p/client.c   | 17 +++++++----------
>  net/9p/trans_fd.c |  7 +++----
>  2 files changed, 10 insertions(+), 14 deletions(-)
> 
> diff --git a/net/9p/client.c b/net/9p/client.c
> index 8bc8b3e..b05cbfc 100644
> --- a/net/9p/client.c
> +++ b/net/9p/client.c
> @@ -260,7 +260,6 @@ static struct p9_fcall *p9_fcall_alloc(int alloc_msize)
>  static struct p9_req_t *
>  p9_tag_alloc(struct p9_client *c, u16 tag, unsigned int max_size)
>  {
> -	unsigned long flags;
>  	int row, col;
>  	struct p9_req_t *req;
>  	int alloc_msize = min(c->msize, max_size);
> @@ -270,7 +269,7 @@ static struct p9_fcall *p9_fcall_alloc(int alloc_msize)
>  	tag++;
> 
>  	if (tag >= c->max_tag) {
> -		spin_lock_irqsave(&c->lock, flags);
> +		spin_lock(&c->lock);

This code doesn't exist anymore with Matthew's idr rework, could you
submit that patch based on top of my 9p-next branch?
(unless you really want Andrew to take this for the next 4.18-rc, but
I'm not convinced this qualifies)

Please see my "Current 9P patches - test branch" for details:
https://sourceforge.net/p/v9fs/mailman/message/36365359/

-- 
Dominique Martinet
