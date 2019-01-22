Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E61C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FDB5217D6
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548171066;
	bh=QWmPCLsAkia+oQqebJi8gP1YsfCIOmfCX44H46A+Akg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=APdeSBshufG47I+hFDLeT3scj1qQHDHbWy2WnQaqmcSsUKT2T7ycwvnRKfp8/sBVO
	 5V+KXpl9xDU9urNAk2FpIiLPjn7Kcmlnksub3CG445qzTc+49fZuX1KS/XlzkpJG8E
	 JHQQNmnRqehuVP/jJISl8YJVIG6rD7WsooeY0Beo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729382AbfAVPbE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:31:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:33888 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728829AbfAVPbE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:31:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5650FB017;
        Tue, 22 Jan 2019 15:31:03 +0000 (UTC)
Date:   Tue, 22 Jan 2019 16:31:02 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        Laura Abbott <labbott@redhat.com>, linux-mm@kvack.org
Subject: Re: [PATCH] mm: no need to check return value of debugfs_create
 functions
Message-ID: <20190122153102.GJ4087@dhcp22.suse.cz>
References: <20190122152151.16139-14-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122152151.16139-14-gregkh@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 22-01-19 16:21:13, Greg KH wrote:
[...]
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 022d4cbb3618..18ee657fb918 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -1998,8 +1998,7 @@ DEFINE_SHOW_ATTRIBUTE(memblock_debug);
>  static int __init memblock_init_debugfs(void)
>  {
>  	struct dentry *root = debugfs_create_dir("memblock", NULL);
> -	if (!root)
> -		return -ENXIO;
> +
>  	debugfs_create_file("memory", 0444, root,
>  			    &memblock.memory, &memblock_debug_fops);
>  	debugfs_create_file("reserved", 0444, root,

I haven't really read the whole patch but this has just hit my eyes. Is
this a correct behavior?

Documentations says:
 * @parent: a pointer to the parent dentry for this file.  This should be a
 *          directory dentry if set.  If this parameter is NULL, then the
 *          file will be created in the root of the debugfs filesystem.

so in case of failure we would get those debugfs files outside of their
intended scope. I believe it is much more correct to simply not create
anything, no?
-- 
Michal Hocko
SUSE Labs
