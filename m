Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16553ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFA98206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:24:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFA98206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbeIQUwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 16:52:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58846 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726885AbeIQUwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 16:52:17 -0400
Received: from smtp.corp.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 32BAF80461;
        Mon, 17 Sep 2018 15:24:28 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.34.27.30])
        by smtp.corp.redhat.com (Postfix) with SMTP id A419C60900;
        Mon, 17 Sep 2018 15:24:25 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 17 Sep 2018 17:24:27 +0200 (CEST)
Date:   Mon, 17 Sep 2018 17:24:24 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Jeff Layton <jlayton@kernel.org>, viro@zeniv.linux.org.uk,
        berrange@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 1/3] exec: separate thread_count for files_struct
Message-ID: <20180917152424.GA25173@redhat.com>
References: <20180914105310.6454-1-jlayton@kernel.org>
 <20180914105310.6454-2-jlayton@kernel.org>
 <20180915160423.GA31461@redhat.com>
 <87o9cxv2wh.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o9cxv2wh.fsf@xmission.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.27
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Mon, 17 Sep 2018 15:24:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/16, Eric W. Biederman wrote:
>
> Oleg Nesterov <oleg@redhat.com> writes:
>
> > As for binder.c, in this case we probably actually want to unshare ->files
> > on exec so we can ignore it?
>
> Looking at the binder case it only captures ->files on mmap.  Exec
> ditches the mmap.  So if the order of operations are correct than
> the dropping of the old mm will also drop the count on files_struct
> held by binder.
>
> So semantically binder should not effect locks on exec,

Agreed, but it does.

Before your "[PATCH 0/3] exec: Moving unshare_files_struct" unshare_files()
is called before exec_mmap().

And even with this series we can have another CLONE_VM process.

Howver, I think this doesn't really matter. binder does __fd_install(files),
so if it actually has a reference to execing_task->files, I think it should
be unshared anyway.

> In short as long as we get the oder of operations correct we should be
> able to safely ignore binder, and not have binder affect the results of
> this code.

Agreed.

Oleg.

