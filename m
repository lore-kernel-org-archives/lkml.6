Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B5ECC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18C202186A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732769AbeLTQUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 11:20:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:20160 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730241AbeLTQUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 11:20:53 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3D5F7C0A1984;
        Thu, 20 Dec 2018 16:20:53 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.131])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6D2F61019633;
        Thu, 20 Dec 2018 16:20:49 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 20 Dec 2018 17:20:52 +0100 (CET)
Date:   Thu, 20 Dec 2018 17:20:48 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Gargi Sharma <gs051095@gmail.com>,
        Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Fix failure path in alloc_pid()
Message-ID: <20181220162048.GB31865@redhat.com>
References: <20181218215321.GW10600@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218215321.GW10600@bombadil.infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Thu, 20 Dec 2018 16:20:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/18, Matthew Wilcox wrote:
>
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -233,8 +233,11 @@ struct pid *alloc_pid(struct pid_namespace *ns)
>  
>  out_free:
>  	spin_lock_irq(&pidmap_lock);
> -	while (++i <= ns->level)
> -		idr_remove(&ns->idr, (pid->numbers + i)->nr);
> +	upid = pid->numbers + i;
> +	while (++i <= ns->level) {
> +		upid++;
> +		idr_remove(&upid->ns->idr, upid->nr);

can't resist...

	while (++i <= ns->level) {
		upid = pid->numbers + i;
		idr_remove(&upid->ns->idr, upid->nr);
	}

looks a bit more clean to me, but this is cosmetic and subjective.

Reviewed-by: Oleg Nesterov <oleg@redhat.com>

