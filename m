Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47CE4C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 22:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F360E214FF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 22:59:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F360E214FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387652AbeHGBKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 21:10:47 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45780 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731200AbeHGBKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 21:10:47 -0400
Received: from localhost.localdomain (c-24-4-125-7.hsd1.ca.comcast.net [24.4.125.7])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D9F37EC3;
        Mon,  6 Aug 2018 22:59:28 +0000 (UTC)
Date:   Mon, 6 Aug 2018 15:59:27 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Chengguang Xu <cgxu519@gmx.com>, mgorman@techsingularity.net,
        jlayton@redhat.com, ak@linux.intel.com, mawilcox@microsoft.com,
        tim.c.chen@linux.intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH] mm: adjust max read count in
 generic_file_buffered_read()
Message-Id: <20180806155927.4740babd057df9d5078281b1@linux-foundation.org>
In-Reply-To: <20180806102203.hmobd26cujmlfcsw@quack2.suse.cz>
References: <20180719081726.3341-1-cgxu519@gmx.com>
        <20180719085812.sjup2odrjyuigt3l@quack2.suse.cz>
        <20180720161429.d63dccb9f66799dc0ff74dba@linux-foundation.org>
        <20180806102203.hmobd26cujmlfcsw@quack2.suse.cz>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Aug 2018 12:22:03 +0200 Jan Kara <jack@suse.cz> wrote:

> On Fri 20-07-18 16:14:29, Andrew Morton wrote:
> > On Thu, 19 Jul 2018 10:58:12 +0200 Jan Kara <jack@suse.cz> wrote:
> > 
> > > On Thu 19-07-18 16:17:26, Chengguang Xu wrote:
> > > > When we try to truncate read count in generic_file_buffered_read(),
> > > > should deliver (sb->s_maxbytes - offset) as maximum count not
> > > > sb->s_maxbytes itself.
> > > > 
> > > > Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
> > > 
> > > Looks good to me. You can add:
> > > 
> > > Reviewed-by: Jan Kara <jack@suse.cz>
> > 
> > Yup.
> > 
> > What are the runtime effects of this bug?
> 
> Good question. I think ->readpage() could be called for index beyond
> maximum file size supported by the filesystem leading to weird filesystem
> behavior due to overflows in internal calculations.
> 

Sure.  But is it possible for userspace to trigger this behaviour? 
Possibly all callers have already sanitized the arguments by this stage
in which case the statement is arguably redundant.

I guess I'll put a cc:stable on it and send it in for 4.19-rc1, so we
get a bit more time to poke at it.  But we should have a better
understanding of the userspace impact.
