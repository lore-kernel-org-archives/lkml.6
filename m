Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E32C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 00:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E79CB208E7
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 00:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="bV71GiCI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E79CB208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbeK0Lyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 06:54:41 -0500
Received: from m12-13.163.com ([220.181.12.13]:51077 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727456AbeK0Lyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 06:54:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=yNuIu
        RMSYL/aoMcojHqluyNNc4n3j+uR47c8cisLZmE=; b=bV71GiCIwlrW/qUeRT8XO
        TeXCqf5dTgIdeALB9lecvl4SJUepncKSmMcf+lqPdJzq256J2NLAoceqUSlie0YT
        ToPzn8aycz4vBWgtXvvGB1kKKacbRVQM5m7hQ2Nscivn7f07P/OfCKrLQ+YjL6oe
        VXnW8zGbp0/GuzAFsNnj9I=
Received: from bp (unknown [106.120.213.96])
        by smtp9 (Coremail) with SMTP id DcCowADHIsWulvxbHu37Bw--.23962S2;
        Tue, 27 Nov 2018 08:58:22 +0800 (CST)
Date:   Tue, 27 Nov 2018 08:58:23 +0800
From:   PanBian <bianpan2016@163.com>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Subject: Re: [Xen-devel] [PATCH] pvcalls-front: fixes incorrect error handling
Message-ID: <20181127005823.GB125510@bp>
Reply-To: PanBian <bianpan2016@163.com>
References: <1542852432-30019-1-git-send-email-bianpan2016@163.com>
 <1f765e81-ed89-d110-74b1-cc8029a4555f@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f765e81-ed89-d110-74b1-cc8029a4555f@oracle.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CM-TRANSID: DcCowADHIsWulvxbHu37Bw--.23962S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WrW3ur1DXw45tFy3GF1UGFg_yoW8XrWrpF
        s7JF1jyF48tasayrZFqa1Yvry5Za1Iq348Wry2kan0kr13CFy8tFyFk34v9w4v9r4rGF1f
        Zw4jqFy7CFsxA37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j_hL8UUUUU=
X-Originating-IP: [106.120.213.96]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/1tbiDg8MclXlpnQALgAAsz
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 03:31:39PM -0500, Boris Ostrovsky wrote:
> On 11/21/18 9:07 PM, Pan Bian wrote:
> > kfree() is incorrectly used to release the pages allocated by
> > __get_free_page() and __get_free_pages(). Use the matching deallocators
> > i.e., free_page() and free_pages(), respectively.
> >
> > Signed-off-by: Pan Bian <bianpan2016@163.com>
> > ---
> >  drivers/xen/pvcalls-front.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/xen/pvcalls-front.c b/drivers/xen/pvcalls-front.c
> > index 2f11ca7..77224d8 100644
> > --- a/drivers/xen/pvcalls-front.c
> > +++ b/drivers/xen/pvcalls-front.c
> > @@ -385,8 +385,8 @@ static int create_active(struct sock_mapping *map, int *evtchn)
> >  out_error:
> >  	if (*evtchn >= 0)
> >  		xenbus_free_evtchn(pvcalls_front_dev, *evtchn);
> > -	kfree(map->active.data.in);
> > -	kfree(map->active.ring);
> > +	free_pages((unsigned long)map->active.data.in, PVCALLS_RING_ORDER);
> 
> Is map->active.data.in guaranteed to be NULL when entering this routine?

I am not sure yet. Sorry for that. I observed the mismatches between
__get_free_page and kfree, and submitted the patch.

But I think your consideration is reasonable. A better solution is to
directly free bytes, a local variable that holds __get_free_pages return
value. If you agree, I will rewrite the patch.

Thanks,
Pan

> 
> -boris
> 
> > +	free_page((unsigned long)map->active.ring);
> >  	return ret;
> >  }
> >  
> 

