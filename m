Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56438ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 06:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17ED0208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 06:43:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17ED0208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729735AbeGMG4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 02:56:39 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38935 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729636AbeGMG4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 02:56:39 -0400
Received: by mail-wm0-f68.google.com with SMTP id h20-v6so8207987wmb.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 23:43:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=nHl0c1dCbc3oSZnpPOIyeNM8akonKzhPR9HAP9MixdQ=;
        b=NL3F6fpm8atE0YxrLv8mVqV3pwDfC9962/DcqKRSm7kABJlJ6+xcMGZjchOxpmQHkP
         ZhR/A3o7YjX0IhJ2qsQWQIM3I7vgvl0Dl8QjFvGvTW7bc3ybRPc5hbwZA/GLUdSgwxbF
         u5VwvG1/JTqzy3GkVYFKbo7RbVUvnsBL2RVwpFH3HBpCZ8XXPZ+jI0HYrBrpw0O/dDJn
         XF98JnA7TKRQNbsyTy+OfggvnhWod/DOjHygG93svM7IiUYMa6TUof+LoKrUY1TnfRjf
         y4Bpjury0wulD4bDuI2yO+T42DGQ0ikJ2kz2vmCEj+HV4JBBj2WOMMUsMqtXuoTsCvGt
         9mQw==
X-Gm-Message-State: AOUpUlEH8X3JJIo+GZSoq4Qaw3RiKFyBGU0/XG+miiY0b6r7Uh0MtF6x
        SdiI/Q1d7H0XaxspOEP0TRpT2g==
X-Google-Smtp-Source: AAOMgpfUwryQ1Sr2Z7qATMGaQLsDDw+Gk48Gi5n7iLwqAIoBjX4dOvBcls7UhUBAATT12jV8XgXVRQ==
X-Received: by 2002:a1c:3a8f:: with SMTP id h137-v6mr3328335wma.41.1531464205577;
        Thu, 12 Jul 2018 23:43:25 -0700 (PDT)
Received: from odin.usersys.redhat.com (ip-86-49-61-71.net.upcbroadband.cz. [86.49.61.71])
        by smtp.gmail.com with ESMTPSA id h61-v6sm9851993wrh.18.2018.07.12.23.43.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Jul 2018 23:43:24 -0700 (PDT)
Date:   Fri, 13 Jul 2018 08:43:22 +0200
From:   Carlos Maiolino <cmaiolino@redhat.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     viro@ZenIV.linux.org.uk, dhowells@redhat.com, willy@infradead.org,
        andres@anarazel.de, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] vfs: track per-sb writeback errors and report
 them via fsinfo()
Message-ID: <20180713064322.5ehxjwixdl34o5bo@odin.usersys.redhat.com>
Mail-Followup-To: Carlos Maiolino <cmaiolino@redhat.com>,
        Jeff Layton <jlayton@kernel.org>, viro@ZenIV.linux.org.uk,
        dhowells@redhat.com, willy@infradead.org, andres@anarazel.de,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20180710140127.20739-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710140127.20739-1-jlayton@kernel.org>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 10:01:23AM -0400, Jeff Layton wrote:
> v2: drop buffer.c patch to record wb errors when underlying blockdev
> flush fails. We may eventually want that, but at this point I don't have
> a clear way to test it to determine its efficacy.
> 
> At LSF/MM this year, the PostgreSQL developers mentioned that they'd
> like to have some mechanism to check whether there have been any
> writeback errors on a filesystem, without necessarily flushing any of
> the cached data first.
> 
> Given that we have a new fsinfo syscall being introduced, we may as well
> use it to report writeback errors on a per superblock basis. This allows
> us to provide the info that the PostgreSQL developers wanted, without
> needing to change an existing interface.
> 
> This seems to do the right thing when tested by hand, but I don't yet
> have an xfstest for it, since the syscall is still quite new. Once that
> goes in and we get fsinfo support in xfs_io, it should be rather
> trivial to roll a testcase for this.
> 

Whole patch sounds fine, you can add:

Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>

Cheers

> Al, if this looks ok, could you pull this into the branch where you
> have David's fsinfo patches queued up?
> 
> Thanks,
> Jeff
> 
> Jeff Layton (4):
>   vfs: track per-sb writeback errors
>   errseq: add a new errseq_scrape function
>   vfs: allow fsinfo to fetch the current state of s_wb_err
>   samples: extend test-fsinfo to access error_state
> 
>  fs/statfs.c                 |  9 +++++++++
>  include/linux/errseq.h      |  1 +
>  include/linux/fs.h          |  3 +++
>  include/linux/pagemap.h     |  5 ++++-
>  include/uapi/linux/fsinfo.h | 11 +++++++++++
>  lib/errseq.c                | 33 +++++++++++++++++++++++++++++++--
>  samples/statx/test-fsinfo.c | 13 +++++++++++++
>  7 files changed, 72 insertions(+), 3 deletions(-)
> 
> -- 
> 2.17.1
> 

-- 
Carlos
