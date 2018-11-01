Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225B8C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 13:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C157C2081B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 13:56:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C157C2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbeKAW7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 18:59:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55493 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728500AbeKAW7n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 18:59:43 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 043B27F3FF;
        Thu,  1 Nov 2018 13:56:39 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.31])
        by smtp.corp.redhat.com (Postfix) with SMTP id 64D365D6B5;
        Thu,  1 Nov 2018 13:56:36 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu,  1 Nov 2018 14:56:37 +0100 (CET)
Date:   Thu, 1 Nov 2018 14:56:34 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian@brauner.io>,
        Tyler Hicks <tyhicks@canonical.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Aleksa Sarai <asarai@suse.de>, linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v8 1/2] seccomp: add a return code to trap to userspace
Message-ID: <20181101135633.GB23232@redhat.com>
References: <20181029224031.29809-1-tycho@tycho.ws>
 <20181029224031.29809-2-tycho@tycho.ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181029224031.29809-2-tycho@tycho.ws>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 01 Nov 2018 13:56:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/29, Tycho Andersen wrote:
>
> +static int seccomp_notify_release(struct inode *inode, struct file *file)
> +{
> +	struct seccomp_filter *filter = file->private_data;
> +	struct seccomp_knotif *knotif;
> +
> +	mutex_lock(&filter->notify_lock);
> +
> +	/*
> +	 * If this file is being closed because e.g. the task who owned it
> +	 * died, let's wake everyone up who was waiting on us.
> +	 */
> +	list_for_each_entry(knotif, &filter->notif->notifications, list) {
> +		if (knotif->state == SECCOMP_NOTIFY_REPLIED)
> +			continue;
> +
> +		knotif->state = SECCOMP_NOTIFY_REPLIED;
> +		knotif->error = -ENOSYS;
> +		knotif->val = 0;
> +
> +		complete(&knotif->ready);
> +	}
> +
> +	wake_up_all(&filter->notif->wqh);

Why? __fput() is not possible if there is another user of this file sleeping
in seccomp_notify_poll().

> +	kfree(filter->notif);

Hmm, this looks wrong... we can't kfree ->notif if its ->notifications list
is not empty, otherwise seccomp_do_user_notification()->list_del(&n.list)
can write to the freed memory.

I think _release() should do list_for_each_entry_safe() + list_del_init()
and seccomp_do_user_notification() should use list_del_init() too.

Or, simpler, seccomp_do_user_notification() should do

	if (!match->notif)
		goto out;

instead of "goto remove_list".

Oleg.

