Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9683C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 12:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BB62208E9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 12:32:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BB62208E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732431AbeGLMmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 08:42:16 -0400
Received: from 17.mo4.mail-out.ovh.net ([46.105.41.16]:56994 "EHLO
        17.mo4.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbeGLMmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 08:42:16 -0400
X-Greylist: delayed 1808 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Jul 2018 08:42:15 EDT
Received: from player750.ha.ovh.net (unknown [10.109.122.41])
        by mo4.mail-out.ovh.net (Postfix) with ESMTP id B6AC118969D
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 13:56:24 +0200 (CEST)
Received: from bahia.lan (lns-bzn-46-82-253-208-248.adsl.proxad.net [82.253.208.248])
        (Authenticated sender: groug@kaod.org)
        by player750.ha.ovh.net (Postfix) with ESMTPSA id 4AAF51800DE;
        Thu, 12 Jul 2018 13:56:17 +0200 (CEST)
Date:   Thu, 12 Jul 2018 13:56:16 +0200
From:   Greg Kurz <groug@kaod.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Dominique Martinet <asmadeus@codewreck.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        linux-kernel@vger.kernel.org, Ron Minnich <rminnich@sandia.gov>,
        linux-fsdevel@vger.kernel.org, v9fs-developer@lists.sourceforge.net
Subject: Re: [V9fs-developer] [PATCH v2 2/6] 9p: Change p9_fid_create
 calling convention
Message-ID: <20180712135616.6667a7a8@bahia.lan>
In-Reply-To: <20180711210225.19730-3-willy@infradead.org>
References: <20180711210225.19730-1-willy@infradead.org>
        <20180711210225.19730-3-willy@infradead.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 4749045810902309189
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtiedrgeekgdegjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jul 2018 14:02:21 -0700
Matthew Wilcox <willy@infradead.org> wrote:

> Return NULL instead of ERR_PTR when we can't allocate a FID.  The ENOSPC
> return value was getting all the way back to userspace, and that's
> confusing for a userspace program which isn't expecting read() to tell it
> there's no space left on the filesystem.  The best error we can return to
> indicate a temporary failure caused by lack of client resources is ENOMEM.
> 
> Maybe it would be better to sleep until a FID is available, but that's
> not a change I'm comfortable making.
> 
> Signed-off-by: Matthew Wilcox <willy@infradead.org>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  net/9p/client.c | 23 +++++++++--------------
>  1 file changed, 9 insertions(+), 14 deletions(-)
> 
> diff --git a/net/9p/client.c b/net/9p/client.c
> index 999eceb8af98..389a2904b7b3 100644
> --- a/net/9p/client.c
> +++ b/net/9p/client.c
> @@ -913,13 +913,11 @@ static struct p9_fid *p9_fid_create(struct p9_client *clnt)
>  	p9_debug(P9_DEBUG_FID, "clnt %p\n", clnt);
>  	fid = kmalloc(sizeof(struct p9_fid), GFP_KERNEL);
>  	if (!fid)
> -		return ERR_PTR(-ENOMEM);
> +		return NULL;
>  
>  	ret = p9_idpool_get(clnt->fidpool);
> -	if (ret < 0) {
> -		ret = -ENOSPC;
> +	if (ret < 0)
>  		goto error;
> -	}
>  	fid->fid = ret;
>  
>  	memset(&fid->qid, 0, sizeof(struct p9_qid));
> @@ -935,7 +933,7 @@ static struct p9_fid *p9_fid_create(struct p9_client *clnt)
>  
>  error:
>  	kfree(fid);
> -	return ERR_PTR(ret);
> +	return NULL;
>  }
>  
>  static void p9_fid_destroy(struct p9_fid *fid)
> @@ -1137,9 +1135,8 @@ struct p9_fid *p9_client_attach(struct p9_client *clnt, struct p9_fid *afid,
>  	p9_debug(P9_DEBUG_9P, ">>> TATTACH afid %d uname %s aname %s\n",
>  		 afid ? afid->fid : -1, uname, aname);
>  	fid = p9_fid_create(clnt);
> -	if (IS_ERR(fid)) {
> -		err = PTR_ERR(fid);
> -		fid = NULL;
> +	if (!fid) {
> +		err = -ENOMEM;
>  		goto error;
>  	}
>  	fid->uid = n_uname;
> @@ -1188,9 +1185,8 @@ struct p9_fid *p9_client_walk(struct p9_fid *oldfid, uint16_t nwname,
>  	clnt = oldfid->clnt;
>  	if (clone) {
>  		fid = p9_fid_create(clnt);
> -		if (IS_ERR(fid)) {
> -			err = PTR_ERR(fid);
> -			fid = NULL;
> +		if (!fid) {
> +			err = -ENOMEM;
>  			goto error;
>  		}
>  
> @@ -2018,9 +2014,8 @@ struct p9_fid *p9_client_xattrwalk(struct p9_fid *file_fid,
>  	err = 0;
>  	clnt = file_fid->clnt;
>  	attr_fid = p9_fid_create(clnt);
> -	if (IS_ERR(attr_fid)) {
> -		err = PTR_ERR(attr_fid);
> -		attr_fid = NULL;
> +	if (!attr_fid) {
> +		err = -ENOMEM;
>  		goto error;
>  	}
>  	p9_debug(P9_DEBUG_9P,

