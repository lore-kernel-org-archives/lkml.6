Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50EF4C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 13:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00966208B6
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 13:42:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00966208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbeH0R3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 13:29:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60510 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726934AbeH0R3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 13:29:16 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 783BF83221;
        Mon, 27 Aug 2018 13:42:34 +0000 (UTC)
Received: from redhat.com (ovpn-125-115.rdu2.redhat.com [10.10.125.115])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C13912026D6B;
        Mon, 27 Aug 2018 13:42:33 +0000 (UTC)
Date:   Mon, 27 Aug 2018 09:42:32 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 2/3] mm, mmu_notifier: be explicit about range invalition
 non-blocking mode
Message-ID: <20180827134231.GA3930@redhat.com>
References: <20180827112623.8992-1-mhocko@kernel.org>
 <20180827112623.8992-3-mhocko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180827112623.8992-3-mhocko@kernel.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 27 Aug 2018 13:42:34 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 27 Aug 2018 13:42:34 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jglisse@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 01:26:22PM +0200, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
> 
> If invalidate_range_start is called for !blocking mode then all
> callbacks have to guarantee they will no block/sleep. The same obviously
> applies to invalidate_range_end because this operation pairs with the
> former and they are called from the same context. Make sure this is
> appropriately documented.
> 
> Signed-off-by: Michal Hocko <mhocko@suse.com>

Reviewed-by: Jerome Glisse <jglisse@redhat.com>


> ---
>  include/linux/mmu_notifier.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
> index 133ba78820ee..698e371aafe3 100644
> --- a/include/linux/mmu_notifier.h
> +++ b/include/linux/mmu_notifier.h
> @@ -153,7 +153,9 @@ struct mmu_notifier_ops {
>  	 *
>  	 * If blockable argument is set to false then the callback cannot
>  	 * sleep and has to return with -EAGAIN. 0 should be returned
> -	 * otherwise.
> +	 * otherwise. Please note that if invalidate_range_start approves
> +	 * a non-blocking behavior then the same applies to
> +	 * invalidate_range_end.
>  	 *
>  	 */
>  	int (*invalidate_range_start)(struct mmu_notifier *mn,
> -- 
> 2.18.0
> 
