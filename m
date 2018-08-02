Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC827C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 22:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D0DB2150A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 22:04:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D0DB2150A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732069AbeHBX5G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 19:57:06 -0400
Received: from nautica.notk.org ([91.121.71.147]:35840 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727122AbeHBX5G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 19:57:06 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id B3098C009; Fri,  3 Aug 2018 00:03:58 +0200 (CEST)
Date:   Fri, 3 Aug 2018 00:03:43 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Greg Kurz <groug@kaod.org>
Cc:     v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dominique Martinet <dominique.martinet@cea.fr>,
        Matthew Wilcox <willy@infradead.org>,
        Jun Piao <piaojun@huawei.com>
Subject: Re: [PATCH v2 1/2] net/9p: embed fcall in req to round down buffer
 allocs
Message-ID: <20180802220343.GB14773@nautica>
References: <1532943263-24378-1-git-send-email-asmadeus@codewreck.org>
 <1533177452-2165-1-git-send-email-asmadeus@codewreck.org>
 <20180802112301.6b581f1c@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180802112301.6b581f1c@bahia.lan>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kurz wrote on Thu, Aug 02, 2018:
> > @@ -443,9 +444,9 @@ static int rdma_request(struct p9_client *client, struct p9_req_t *req)
> >  	 **/
> >  	if (unlikely(atomic_read(&rdma->excess_rc) > 0)) {
> >  		if ((atomic_sub_return(1, &rdma->excess_rc) >= 0)) {
> > -			/* Got one ! */
> > -			kfree(req->rc);
> > -			req->rc = NULL;
> > +			/* Got one! */
> > +			kfree(req->rc.sdata);
> 
> Shouldn't this be p9_fcall_fini(&req->rc) ?

Right, I failed at bookkeeping, I changed that in the next patch but it
should have been done now.
Will add p9_fcall_fini to headers/export in this patch instead of the
next

> The rest looks good, so, with that fixed, you can add:
> 
> Reviewed-by: Greg Kurz <groug@kaod.org>

Thanks!

-- 
Dominique
