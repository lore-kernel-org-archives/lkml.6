Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60DF5ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 010BA20671
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:28:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 010BA20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbeIQU4K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 16:56:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51156 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728361AbeIQU4J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 16:56:09 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 35FD4308427D;
        Mon, 17 Sep 2018 15:28:20 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.34.27.30])
        by smtp.corp.redhat.com (Postfix) with SMTP id AA22B1799F;
        Mon, 17 Sep 2018 15:28:18 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 17 Sep 2018 17:28:19 +0200 (CEST)
Date:   Mon, 17 Sep 2018 17:28:17 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Jeff Layton <jlayton@kernel.org>, viro@zeniv.linux.org.uk,
        berrange@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 3/3] exec: do unshare_files after de_thread
Message-ID: <20180917152817.GB25173@redhat.com>
References: <20180914105310.6454-1-jlayton@kernel.org>
 <20180914105310.6454-4-jlayton@kernel.org>
 <20180915163704.GA31693@redhat.com>
 <87efdttmjm.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87efdttmjm.fsf@xmission.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Mon, 17 Sep 2018 15:28:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/16, Eric W. Biederman wrote:
>
> Oleg Nesterov <oleg@redhat.com> writes:
>
> > IOW. Lets ignore do_close_on_exec(), lets ignore the fact that unshare_fd()
> > can fail and thus it makes sense to call it before point-of-no-return.
> >
> > Any other reason why we can't simply call unshare_files() at the end of
> > __do_execve_file() on success?
>
> The reason we call we call unshare_files is in case the files are shared
> with another process.  AKA old style linux threads, or someone being
> clever.  In that case we need a private copy of files for close on exec
> because we should not close the files of the other process that has not
> called exec.

This is clear,

> The only reason for calling unshare_files before the point of no return
> is so that we can get a good error message to the calling process if
> unshare_files fails.

OK, so you too think there are no other reasons.

> AKA it would be reasonable to move unshare_files to just above
> do_close_on_exec in flush_old_exec.  We could further make the
> unshare_files not return displaced and just drop it.

Yes, this is exactly what I had in mind.

Oleg.

