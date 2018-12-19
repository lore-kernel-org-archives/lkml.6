Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55704C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2667A2184A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbeLSJ2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 04:28:51 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:52153 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727673AbeLSJ2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 04:28:51 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gZY9p-00045s-Lf; Wed, 19 Dec 2018 02:28:49 -0700
Received: from ip68-227-174-240.om.om.cox.net ([68.227.174.240] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gZY9n-0003vW-0c; Wed, 19 Dec 2018 02:28:49 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Gargi Sharma <gs051095@gmail.com>, Rik van Riel <riel@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org
References: <20181218215321.GW10600@bombadil.infradead.org>
Date:   Wed, 19 Dec 2018 03:28:41 -0600
In-Reply-To: <20181218215321.GW10600@bombadil.infradead.org> (Matthew Wilcox's
        message of "Tue, 18 Dec 2018 13:53:21 -0800")
Message-ID: <87woo5c1bq.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1gZY9n-0003vW-0c;;;mid=<87woo5c1bq.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.240;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/m8OjRhX6IA0X3pmhttj8qfcBPmRGz8HQ=
X-SA-Exim-Connect-IP: 68.227.174.240
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [RFC] Fix failure path in alloc_pid()
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> writes:

> The failure path removes the allocated PIDs from the wrong namespace.
> I believe this is correct, but have not tested it.  Spotted by inspection,
> do we have a test suite for PID namespaces?  Some error injection,
> perhaps?
>
> Fixes: 95846ecf9dac ("pid: replace pid bitmap implementation with IDR API")
>
Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

> diff --git a/kernel/pid.c b/kernel/pid.c
> index b2f6c506035da..75264e0d1e71d 100644
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
> +	}
>  
>  	/* On failure to allocate the first pid, reset the state */
>  	if (ns->pid_allocated == PIDNS_ADDING)
