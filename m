Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 671AEC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 10:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 139BE219CF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 10:22:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 139BE219CF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729718AbeHFMa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 08:30:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:38312 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726901AbeHFMa2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 08:30:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 755CBAECB;
        Mon,  6 Aug 2018 10:22:04 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 9EFBC1E0501; Mon,  6 Aug 2018 12:22:03 +0200 (CEST)
Date:   Mon, 6 Aug 2018 12:22:03 +0200
From:   Jan Kara <jack@suse.cz>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jan Kara <jack@suse.cz>, Chengguang Xu <cgxu519@gmx.com>,
        mgorman@techsingularity.net, jlayton@redhat.com,
        ak@linux.intel.com, mawilcox@microsoft.com,
        tim.c.chen@linux.intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH] mm: adjust max read count in generic_file_buffered_read()
Message-ID: <20180806102203.hmobd26cujmlfcsw@quack2.suse.cz>
References: <20180719081726.3341-1-cgxu519@gmx.com>
 <20180719085812.sjup2odrjyuigt3l@quack2.suse.cz>
 <20180720161429.d63dccb9f66799dc0ff74dba@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180720161429.d63dccb9f66799dc0ff74dba@linux-foundation.org>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 20-07-18 16:14:29, Andrew Morton wrote:
> On Thu, 19 Jul 2018 10:58:12 +0200 Jan Kara <jack@suse.cz> wrote:
> 
> > On Thu 19-07-18 16:17:26, Chengguang Xu wrote:
> > > When we try to truncate read count in generic_file_buffered_read(),
> > > should deliver (sb->s_maxbytes - offset) as maximum count not
> > > sb->s_maxbytes itself.
> > > 
> > > Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
> > 
> > Looks good to me. You can add:
> > 
> > Reviewed-by: Jan Kara <jack@suse.cz>
> 
> Yup.
> 
> What are the runtime effects of this bug?

Good question. I think ->readpage() could be called for index beyond
maximum file size supported by the filesystem leading to weird filesystem
behavior due to overflows in internal calculations.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
