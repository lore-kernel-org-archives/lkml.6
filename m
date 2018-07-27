Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D76C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DC132064D
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:46:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DC132064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389054AbeG0TJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 15:09:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42038 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388909AbeG0TJy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 15:09:54 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AB5C740216E5;
        Fri, 27 Jul 2018 17:46:56 +0000 (UTC)
Received: from treble (ovpn-120-105.rdu2.redhat.com [10.10.120.105])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 475A12026D6B;
        Fri, 27 Jul 2018 17:46:56 +0000 (UTC)
Date:   Fri, 27 Jul 2018 12:46:54 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Jeremy Cline <jcline@redhat.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/3] ext4: super: Fix spectre gadget in ext4_quota_on
Message-ID: <20180727174654.bnooz26puuo7456w@treble>
References: <20180727162357.30801-1-jcline@redhat.com>
 <20180727162357.30801-2-jcline@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180727162357.30801-2-jcline@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 27 Jul 2018 17:46:56 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 27 Jul 2018 17:46:56 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jpoimboe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 04:23:55PM +0000, Jeremy Cline wrote:
> 'type' is a user-controlled value used to index into 's_qf_names', which
> can be used in a Spectre v1 attack. Clamp 'type' to the size of the
> array to avoid a speculative out-of-bounds read.
> 
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Jeremy Cline <jcline@redhat.com>
> ---
>  fs/ext4/super.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 6480e763080f..c04a09b51742 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -40,6 +40,7 @@
>  #include <linux/crc16.h>
>  #include <linux/dax.h>
>  #include <linux/cleancache.h>
> +#include <linux/nospec.h>
>  #include <linux/uaccess.h>
>  #include <linux/iversion.h>
>  
> @@ -5559,6 +5560,7 @@ static int ext4_quota_on(struct super_block *sb, int type, int format_id,
>  	if (path->dentry->d_sb != sb)
>  		return -EXDEV;
>  	/* Journaling quota? */
> +	type = array_index_nospec(type, EXT4_MAXQUOTAS);
>  	if (EXT4_SB(sb)->s_qf_names[type]) {
>  		/* Quotafile not in fs root? */
>  		if (path->dentry->d_parent != sb->s_root)

Generally we try to put the array_index_nospec() close to the bounds
check for which it's trying to prevent speculation past.

In this case, I'd expect the EXT4_MAXQUOTAS bounds check to be in
do_quotactl(), but it seems to be missing:

	if (type >= (XQM_COMMAND(cmd) ? XQM_MAXQUOTAS : MAXQUOTAS))
		return -EINVAL;

Also it looks like XQM_MAXQUOTAS, MAXQUOTAS, and EXT4_MAXQUOTAS all have
the same value (3).  Maybe they can be consolidated to just use
MAXQUOTAS everywhere?  Then the nospec would be simple:

	if (type >= MAXQUOTAS)
		return -EINVAL;
	type = array_index_nospec(type, MAXQUOTAS);

Otherwise I think we may need to disperse the array_index_nospec calls
deeper in the callchain.

-- 
Josh
