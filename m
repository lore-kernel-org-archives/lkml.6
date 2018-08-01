Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBEC6C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 14:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8141E20894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 14:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="pLP4kiMj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8141E20894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389626AbeHAQYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 12:24:50 -0400
Received: from imap.thunk.org ([74.207.234.97]:52154 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389570AbeHAQYu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 12:24:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=V7AgvdFhdcdH16GxQTZNOMcpT9FeHt7cu/SJsSPIzno=; b=pLP4kiMjZableyUi9m0GmiKMlg
        y9oZbQTUIchIOH5KyRlfjrgqlvihHfiB27yAzAwzmKy+XNCWbZYLLi+JEg+L1UvYNMsxaw7DVPxaw
        vUNPUX01d/OgffcqCnnkEHp/4TdgCtvaagcG8M3lZfhqu4KUNMeodzcGj47lF2XPNgzM=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1fksGm-0003Bo-5q; Wed, 01 Aug 2018 14:38:32 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id CE0F27A614D; Wed,  1 Aug 2018 10:38:30 -0400 (EDT)
Date:   Wed, 1 Aug 2018 10:38:30 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>, adilger.kernel@dilger.ca,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Eric Biggers <ebiggers@google.com>,
        Greg KH <gregkh@linuxfoundation.org>, kemi.wang@intel.com,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: Convert int to vm_fault_t type
Message-ID: <20180801143830.GB10761@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, adilger.kernel@dilger.ca,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Eric Biggers <ebiggers@google.com>,
        Greg KH <gregkh@linuxfoundation.org>, kemi.wang@intel.com,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180728085000.GA9136@jordon-HP-15-Notebook-PC>
 <20180801125512.GA10761@thunk.org>
 <CAFqt6zbxpj5DS=ONUGTJ9zaeH5k=qZpQYy-J+08tr9y0gOsCAg@mail.gmail.com>
 <20180801131330.GA4734@bombadil.infradead.org>
 <CAFqt6zYJv7SdkntY7KOBvNyfk-9MRaXBMmkbsc4J7P-tq616DA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqt6zYJv7SdkntY7KOBvNyfk-9MRaXBMmkbsc4J7P-tq616DA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2018 at 06:56:39PM +0530, Souptick Joarder wrote:
> As caller of block_page_mkwrite() are -
> fs/ext4/inode.c
> fs/nilfs2/file.c
> 
> I will merge both changes in a single patch and send it.

Note that it's *important* for ext4 that we know what kind of error
was returned by the helper function passed into block_page_write() and
called by it.  In particular, whether the error was ENOSPC or not.

That's why this change should have raised all sorts of alarums:

 	ext4_journal_stop(handle);
-	if (ret == -ENOSPC && ext4_should_retry_alloc(inode->i_sb, &retries))
+	if (ret == VM_FAULT_SIGBUS &&
+		ext4_should_retry_alloc(inode->i_sb, &retries))
 		goto retry_alloc;

Note the ret == -ENOSPC --- you blindly changed it to return
VM_FAULT_SIGBUS!!!

You need to understand *why* the code does what it does, and not just
make blind mechanical replacements.

In this particular case, it probably means that if you insist on
making block_page_mkwrite() return vmfault_t, it will probably need to
take an optional "int *err" parameter, so the error can be returned to
the caller if the caller needs it.

I'm going to drop the whole ext4 changes for vm_fault_t for this
cycle, and I'll let you try to fix it up properly for the next cycle.

Regards,

						- Ted
