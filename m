Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1445DC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E11AF214AE
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:22:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbeLZWWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:22:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48396 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727586AbeLZWWj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:22:39 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 62F7E155E4;
        Wed, 26 Dec 2018 22:22:39 +0000 (UTC)
Received: from redhat.com (ovpn-120-211.rdu2.redhat.com [10.10.120.211])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 92119608E2;
        Wed, 26 Dec 2018 22:22:38 +0000 (UTC)
Date:   Wed, 26 Dec 2018 17:22:36 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hmm: Warn on devres_release failure
Message-ID: <20181226222236.GA4931@redhat.com>
References: <20181226180904.8193-1-pakki001@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181226180904.8193-1-pakki001@umn.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 26 Dec 2018 22:22:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 26, 2018 at 12:09:04PM -0600, Aditya Pakki wrote:
> devres_release can return -ENOENT if the device is not freed. The fix
> throws a warning consistent with other invocations.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>

Reviewed-by: Jérôme Glisse <jglisse@redhat.com>

> ---
>  mm/hmm.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/hmm.c b/mm/hmm.c
> index 90c34f3d1243..b06e3f092fbf 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -1183,8 +1183,12 @@ static int hmm_devmem_match(struct device *dev, void *data, void *match_data)
>  
>  static void hmm_devmem_pages_remove(struct hmm_devmem *devmem)
>  {
> -	devres_release(devmem->device, &hmm_devmem_release,
> -		       &hmm_devmem_match, devmem->resource);
> +	int rc;
> +
> +	rc = devres_release(devmem->device, &hmm_devmem_release,
> +				&hmm_devmem_match, devmem->resource);
> +	if (rc)
> +		WARN_ON(rc);
>  }
>  
>  /*
> -- 
> 2.17.1
> 
