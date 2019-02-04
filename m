Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD18C169C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 00:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55C7A2083B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 00:41:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbfBDAkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 19:40:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:47654 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727526AbfBDAkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 19:40:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B64B5AC3E;
        Mon,  4 Feb 2019 00:40:50 +0000 (UTC)
Date:   Mon, 4 Feb 2019 01:40:48 +0100
From:   David Disseldorp <ddiss@suse.de>
To:     Laura Abbott <labbott@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lee Duncan <lduncan@suse.com>
Subject: Re: Userspace regression with 6baca7601bde ("scsi: target: drop
 unused pi_prot_format attribute storage")
Message-ID: <20190204014048.1cf91326@suse.de>
In-Reply-To: <57120b72-2ab9-bfa5-f69c-31aee78d5936@redhat.com>
References: <57120b72-2ab9-bfa5-f69c-31aee78d5936@redhat.com>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laura,

Thanks for the report...

On Sun, 3 Feb 2019 17:56:00 +0100, Laura Abbott wrote:

> Fedora got a bug report of a new permission denied error with 5.0-rc2:
> 
> >   File "/usr/lib/python3.7/site-packages/rtslib_fb/utils.py", line 100, in fread
> >     with open(path, 'r') as file_fd:
> > PermissionError: [Errno 13] Permission denied: '/sys/kernel/config/target/core/fileio_28/xxx/attrib/pi_prot_format'  
> 
> This looks like an intentional behavior change with
> 
> commit 6baca7601bdee2e57f20c45d63eb53b89b33e816
> Author: David Disseldorp <ddiss@suse.de>
> Date:   Fri Nov 23 18:36:11 2018 +0100
> 
>      scsi: target: drop unused pi_prot_format attribute storage
>      
>      On write, the pi_prot_format configfs attribute invokes the device
>      format_prot() callback if present. Read dumps the contents of
>      se_dev_attrib.pi_prot_format which is always zero.  Make the configfs
>      attribute write-only, and drop the always zero se_dev_attrib.pi_prot_format
>      storage.
>      
>      Signed-off-by: David Disseldorp <ddiss@suse.de>
>      Reviewed-by: Christoph Hellwig <hch@lst.de>
>      Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
> 
> 
> Unfortunately, existing code that's opening with read permissions is now broken.
> Can this be reverted? Full bug at https://bugzilla.redhat.com/show_bug.cgi?id=1667505

Lee (cc'ed) pinged me a couple of days ago about the same issue.
My preference would be to add back a dummy read handler without the
corresponding (unused) se_dev_attrib.pi_prot_format member.
I'll prepare something tomorrow with this, but if it's urgent then I'd
also be okay with a straight revert.

Cheers, David
