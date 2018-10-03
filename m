Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB8BBC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 13:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 897362064E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 13:20:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 897362064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbeJCUJG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 16:09:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51898 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726679AbeJCUJG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 16:09:06 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3CA8580F6C;
        Wed,  3 Oct 2018 13:20:44 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.43.2.58])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A30101AC1A;
        Wed,  3 Oct 2018 13:20:42 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Lance Roy <ldr709@gmail.com>, linux-kernel@vger.kernel.org
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Lance Roy <ldr709@gmail.com>, devel@linuxdriverproject.org
Subject: Re: [PATCH 02/16] hv_balloon: Replace spin_is_locked() with lockdep
In-Reply-To: <20181003053902.6910-3-ldr709@gmail.com>
References: <20181003053902.6910-1-ldr709@gmail.com> <20181003053902.6910-3-ldr709@gmail.com>
Date:   Wed, 03 Oct 2018 15:20:40 +0200
Message-ID: <875zyjdv4n.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Wed, 03 Oct 2018 13:20:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lance Roy <ldr709@gmail.com> writes:

> lockdep_assert_held() is better suited to checking locking requirements,
> since it won't get confused when someone else holds the lock. This is
> also a step towards possibly removing spin_is_locked().
>
> Signed-off-by: Lance Roy <ldr709@gmail.com>
> Cc: "K. Y. Srinivasan" <kys@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> Cc: <devel@linuxdriverproject.org>
> ---
>  drivers/hv/hv_balloon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
> index b1b788082793..41631512ae97 100644
> --- a/drivers/hv/hv_balloon.c
> +++ b/drivers/hv/hv_balloon.c
> @@ -689,7 +689,7 @@ static void hv_page_online_one(struct hv_hotadd_state *has, struct page *pg)
>  	__online_page_increment_counters(pg);
>  	__online_page_free(pg);
>  
> -	WARN_ON_ONCE(!spin_is_locked(&dm_device.ha_lock));
> +	lockdep_assert_held(&dm_device.ha_lock);
>  	dm_device.num_pages_onlined++;
>  }

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

However,

lockdep_assert_held() is a no-op when !CONFIG_LOCKDEP but this doesn't
really matter: hv_page_online_one() is static and it has only two call
sites, both taking the dm_device.ha_lock lock - so the warning may just
go away.

-- 
Vitaly
