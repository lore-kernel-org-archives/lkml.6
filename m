Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FAFBC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 08:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F123521653
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 08:57:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F123521653
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbeHHLQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 07:16:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:39498 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727083AbeHHLQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 07:16:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CB8ABACD0;
        Wed,  8 Aug 2018 08:57:47 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 383CC1E065A; Wed,  8 Aug 2018 10:57:47 +0200 (CEST)
Date:   Wed, 8 Aug 2018 10:57:47 +0200
From:   Jan Kara <jack@suse.cz>
To:     cgxu519 <cgxu519@gmx.com>
Cc:     Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
        mgorman@techsingularity.net, jlayton@redhat.com,
        ak@linux.intel.com, mawilcox@microsoft.com,
        tim.c.chen@linux.intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] mm: adjust max read count in generic_file_buffered_read()
Message-ID: <20180808085747.GE15413@quack2.suse.cz>
References: <20180719081726.3341-1-cgxu519@gmx.com>
 <20180719085812.sjup2odrjyuigt3l@quack2.suse.cz>
 <20180720161429.d63dccb9f66799dc0ff74dba@linux-foundation.org>
 <20180806102203.hmobd26cujmlfcsw@quack2.suse.cz>
 <20180806155927.4740babd057df9d5078281b1@linux-foundation.org>
 <20180807135453.nhatdtw25wa6dtzm@quack2.suse.cz>
 <7be05929-a5d0-e0b0-9d48-705c3840ee95@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7be05929-a5d0-e0b0-9d48-705c3840ee95@gmx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 08-08-18 08:57:13, cgxu519 wrote:
> On 08/07/2018 09:54 PM, Jan Kara wrote:
> > On Mon 06-08-18 15:59:27, Andrew Morton wrote:
> > > On Mon, 6 Aug 2018 12:22:03 +0200 Jan Kara <jack@suse.cz> wrote:
> > > 
> > > > On Fri 20-07-18 16:14:29, Andrew Morton wrote:
> > > > > On Thu, 19 Jul 2018 10:58:12 +0200 Jan Kara <jack@suse.cz> wrote:
> > > > > 
> > > > > > On Thu 19-07-18 16:17:26, Chengguang Xu wrote:
> > > > > > > When we try to truncate read count in generic_file_buffered_read(),
> > > > > > > should deliver (sb->s_maxbytes - offset) as maximum count not
> > > > > > > sb->s_maxbytes itself.
> > > > > > > 
> > > > > > > Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
> > > > > > Looks good to me. You can add:
> > > > > > 
> > > > > > Reviewed-by: Jan Kara <jack@suse.cz>
> > > > > Yup.
> > > > > 
> > > > > What are the runtime effects of this bug?
> > > > Good question. I think ->readpage() could be called for index beyond
> > > > maximum file size supported by the filesystem leading to weird filesystem
> > > > behavior due to overflows in internal calculations.
> > > > 
> > > Sure.  But is it possible for userspace to trigger this behaviour?
> > > Possibly all callers have already sanitized the arguments by this stage
> > > in which case the statement is arguably redundant.
> > So I don't think there's any sanitization going on before
> > generic_file_buffered_read(). E.g. I don't see any s_maxbytes check on
> > ksys_read() -> vfs_read() -> __vfs_read() -> new_sync_read() ->
> > call_read_iter() -> generic_file_read_iter() ->
> > generic_file_buffered_read() path... However now thinking about this again:
> > We are guaranteed i_size is within s_maxbytes (places modifying i_size
> > are checking for this) and generic_file_buffered_read() stops when it
> > should read beyond i_size. So in the end I don't think there's any breakage
> > possible and the patch is not necessary?
> > 
> I think most of time i_size is within s_maxbytes in local filesystem,
> but consider network filesystem, write big file in 64bit client and
> read in 32bit client, in this case maybe generic_file_buffered_read()
> can read more than s_maxbytes, right?

I'd consider this an internal problem in the implementation of the
networking filesystem. Not something VFS should care about. It's similar to
a normal filesystem loading corrupted file size from disk...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
