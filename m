Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D4DC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BE422082D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:03:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BE422082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbeJ3X4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 19:56:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50100 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726135AbeJ3X4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 19:56:47 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 82429312E9DB;
        Tue, 30 Oct 2018 15:02:58 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.31])
        by smtp.corp.redhat.com (Postfix) with SMTP id ED281194AB;
        Tue, 30 Oct 2018 15:02:55 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 30 Oct 2018 16:02:57 +0100 (CET)
Date:   Tue, 30 Oct 2018 16:02:54 +0100
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
Message-ID: <20181030150254.GB3385@redhat.com>
References: <20181029224031.29809-1-tycho@tycho.ws>
 <20181029224031.29809-2-tycho@tycho.ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181029224031.29809-2-tycho@tycho.ws>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Tue, 30 Oct 2018 15:02:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/29, Tycho Andersen wrote:
>
> +static long seccomp_notify_recv(struct seccomp_filter *filter,
> +				void __user *buf)
> +{
> +	struct seccomp_knotif *knotif = NULL, *cur;
> +	struct seccomp_notif unotif;
> +	ssize_t ret;
> +
> +	memset(&unotif, 0, sizeof(unotif));
> +
> +	ret = down_interruptible(&filter->notif->request);
> +	if (ret < 0)
> +		return ret;
> +
> +	mutex_lock(&filter->notify_lock);
> +	list_for_each_entry(cur, &filter->notif->notifications, list) {
> +		if (cur->state == SECCOMP_NOTIFY_INIT) {
> +			knotif = cur;
> +			break;
> +		}
> +	}
> +
> +	/*
> +	 * If we didn't find a notification, it could be that the task was
> +	 * interrupted by a fatal signal between the time we were woken and
> +	 * when we were able to acquire the rw lock.
> +	 *
> +	 * This is the place where we handle the extra high semaphore count
> +	 * mentioned in seccomp_do_user_notification().
> +	 */
> +	if (!knotif) {
> +		ret = -ENOENT;
> +		goto out;
> +	}
> +
> +	unotif.id = knotif->id;
> +	unotif.pid = task_pid_vnr(knotif->task);
> +	if (knotif->signaled)
> +		unotif.flags |= SECCOMP_NOTIF_FLAG_SIGNALED;
> +	unotif.data = *(knotif->data);

Tycho, I forgot everything about seccomp, most probably I am wrong but let me
ask anyway.

__seccomp_filter(SECCOMP_RET_TRACE) does

		/*
		 * Recheck the syscall, since it may have changed. This
		 * intentionally uses a NULL struct seccomp_data to force
		 * a reload of all registers. This does not goto skip since
		 * a skip would have already been reported.
		 */
		if (__seccomp_filter(this_syscall, NULL, true))
			return -1;

and the next seccomp_run_filters() can return SECCOMP_RET_USER_NOTIF, right?
seccomp_do_user_notification() doesn't check recheck_after_trace and it simply
does n.data = sd.

Doesn't this mean that "unotif.data = *(knotif->data)" can hit NULL ?

seccomp_run_filters() does populate_seccomp_data() in this case, but this
won't affect "seccomp_data *sd" passed to seccomp_do_user_notification().

Oleg.

