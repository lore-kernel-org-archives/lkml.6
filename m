Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D38C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 13:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99E0F218D9
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 13:01:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbfAYNBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 08:01:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53842 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726108AbfAYNBR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 08:01:17 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1CD857EBC8;
        Fri, 25 Jan 2019 13:01:17 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.163])
        by smtp.corp.redhat.com (Postfix) with SMTP id 916EC5D70A;
        Fri, 25 Jan 2019 13:01:15 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 25 Jan 2019 14:01:16 +0100 (CET)
Date:   Fri, 25 Jan 2019 14:01:14 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Vladis Dronov <vdronov@redhat.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] HID: debug: fix the ring buffer implementation
Message-ID: <20190125130113.GA18589@redhat.com>
References: <20190125095744.3813-1-vdronov@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190125095744.3813-1-vdronov@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Fri, 25 Jan 2019 13:01:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/25, Vladis Dronov wrote:
>
> Ring buffer implementation in hid_debug_event() and hid_debug_events_read()
> is strange allowing lost or corrupted data. After commit 717adfdaf147
> ("HID: debug: check length before copy_to_user()") it is possible to enter
> an infinite loop in hid_debug_events_read() by providing 0 as count, this
> locks up a system. Fix this by rewriting the ring buffer implementation
> with kfifo and simplify the code.
>
> This fixes CVE-2019-3819.

To me this looks like a good cleanup even if we forget about bugfix. Cosmetic
nits, feel free to ignore...

> +	if (kfifo_is_empty(&list->hid_debug_fifo)) {
> +		add_wait_queue(&list->hdev->debug_wait, &wait);
> +		set_current_state(TASK_INTERRUPTIBLE);
> +
> +		while (kfifo_is_empty(&list->hid_debug_fifo)) {
> +			if (file->f_flags & O_NONBLOCK) {
> +				ret = -EAGAIN;
> +				break;
> +			}
> +
> +			if (signal_pending(current)) {
> +				ret = -ERESTARTSYS;
> +				break;
> +			}
> +
> +			if (!list->hdev || !list->hdev->debug) {
> +				ret = -EIO;
> +				set_current_state(TASK_RUNNING);
> +				goto out;

Can't resist... Yes, this is what the current code does. But you know that it looks
suspicious ;) if you add a comment the patch will be even better.

> +			}
> +
> +			/* allow O_NONBLOCK from other threads */
> +			mutex_unlock(&list->read_mutex);
> +			schedule();
> +			mutex_lock(&list->read_mutex);
> +			set_current_state(TASK_INTERRUPTIBLE);
> +		}
> +
> +		set_current_state(TASK_RUNNING);

you can use __set_current_state() here, mb() is not needed.

> +		remove_wait_queue(&list->hdev->debug_wait, &wait);
> +	}
> +
> +	if (ret)
> +		goto out;
> +

perhaps it make sense to move this check into the "if (kfifo_is_empty())" block.

> +	if (kfifo_is_empty(&list->hid_debug_fifo))
> +		goto out;

is kfifo_is_empty() == T really possible here?

Oleg.

