Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F29BECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C7C720883
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:49:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C7C720883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbeIQVRg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 17:17:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48992 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727691AbeIQVRf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 17:17:35 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0281C5F7AC;
        Mon, 17 Sep 2018 15:49:41 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.34.27.30])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9B74F7EB8F;
        Mon, 17 Sep 2018 15:49:39 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 17 Sep 2018 17:49:40 +0200 (CEST)
Date:   Mon, 17 Sep 2018 17:49:38 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Jeff Layton <jlayton@kernel.org>, viro@zeniv.linux.org.uk,
        berrange@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 1/3] exec: Move unshare_files down to avoid locks
 being dropped on exec.
Message-ID: <20180917154938.GC25173@redhat.com>
References: <20180914105310.6454-1-jlayton@kernel.org>
 <87a7ohs5ow.fsf@xmission.com>
 <874leps5n9.fsf_-_@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874leps5n9.fsf_-_@xmission.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Mon, 17 Sep 2018 15:49:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/16, Eric W. Biederman wrote:
>
> @@ -1291,6 +1292,12 @@ int flush_old_exec(struct linux_binprm * bprm)
>  	flush_thread();
>  	current->personality &= ~bprm->per_clear;
>
> +	retval = unshare_files(&displaced);

I was going to sugget basically the same changes, please feel free to add
my reviewed-by to 1-3.


Just for record. If we should really worry about unshare_files() failure
after de_thread() (imo we shouldn't), we can do another change:

	__do_execve_file:

		unshare_fd(CLONE_FILES, &bprm->unshared_copy);
		...


	flush_old_exec:

		de_thread();

		if (bprm->unshared_copy) {
			// now that we killed sub-threads recheck
			if (current->files->count > 1) {
				put_files_struct(current->files);
				current->files = bprm->unshared_copy;
			} else {
				put_files_struct(bprm->unshared_copy);
			}
				
		}

but again, I think your series is fine.

Oleg.

