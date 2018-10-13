Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F36A3C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 06:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C524520895
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 06:06:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C524520895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbeJMNmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 09:42:16 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:46706 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbeJMNmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 09:42:16 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gBD47-0003iJ-4q; Sat, 13 Oct 2018 06:06:19 +0000
Date:   Sat, 13 Oct 2018 07:06:19 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     David Howells <dhowells@redhat.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Alan Jenkins <alan.christopher.jenkins@gmail.com>,
        torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mszeredi@redhat.com
Subject: Re: [PATCH 03/34] teach move_mount(2) to work with OPEN_TREE_CLONE
 [ver #12]
Message-ID: <20181013060618.GQ32577@ZenIV.linux.org.uk>
References: <87sh1cqqfs.fsf@xmission.com>
 <5c6f3d62-4cec-2aea-4693-62928611c526@gmail.com>
 <153754740781.17872.7869536526927736855.stgit@warthog.procyon.org.uk>
 <153754743491.17872.12115848333103740766.stgit@warthog.procyon.org.uk>
 <de050902-f3d0-b2db-2627-983a36c87b3c@gmail.com>
 <862e36a2-2a6f-4e26-3228-8cab4b4cf230@gmail.com>
 <17405.1539272035@warthog.procyon.org.uk>
 <15324.1539289074@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15324.1539289074@warthog.procyon.org.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 09:17:54PM +0100, David Howells wrote:
> +/*
> + * Object if there are any nsfs mounts in the specified subtree.  These can act
> + * as pins for mount namespaces that aren't checked by the mount-cycle checking
> + * code, thereby allowing cycles to be made.
> + */
> +static bool check_for_nsfs_mounts(struct mount *subtree)
> +{
> +	struct mount *p;
> +	bool ret = false;
> +
> +	lock_mount_hash();
> +	for (p = subtree; p; p = next_mnt(p, subtree))
> +		if (mnt_ns_loop(p->mnt.mnt_root))
> +			goto out;
> +
> +	ret = true;
> +out:
> +	unlock_mount_hash();
> +	return ret;
> +}

Umm...  The comment doesn't match the behaviour - you are
accepting references to later namespaces.  Behaviour is
not a problem, the comment is.
