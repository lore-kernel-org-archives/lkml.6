Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C02AC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 04:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43C43217D8
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 04:10:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbeLREKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 23:10:07 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:38006 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbeLREKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 23:10:07 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.91 #2 (Red Hat Linux))
        id 1gZ6hm-00078N-85; Tue, 18 Dec 2018 04:10:02 +0000
Date:   Tue, 18 Dec 2018 04:10:02 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Paul Moore <paul@paul-moore.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: Re: linux-next: manual merge of the selinux tree with the vfs tree
Message-ID: <20181218041001.GU2217@ZenIV.linux.org.uk>
References: <20181218144858.58d8d1f8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218144858.58d8d1f8@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 02:48:58PM +1100, Stephen Rothwell wrote:
> Hi Paul,
> 
> Today's linux-next merge of the selinux tree got a conflict in:
> 
>   security/selinux/hooks.c
> 
> between commit:
> 
>   2b8073b14c19 ("LSM: split ->sb_set_mnt_opts() out of ->sb_kern_mount()")
> 
> from the vfs tree and commit:
> 
>   2cbdcb882f97 ("selinux: always allow mounting submounts")
> 
> from the selinux tree.
> 
> I fixed it up (I used the vfs tree version, plus added the following
> patch but I am not sure if it is correct as the latter patch only affected
> selinux) and can carry the fix as necessary. This is now fixed as far as
> linux-next is concerned, but any non trivial conflicts should be mentioned
> to your upstream maintainer when your tree is submitted for merging.
> You may also want to consider cooperating with the maintainer of the
> conflicting tree to minimise any particularly complex conflicts.
 
> -	if (!(fc->sb_flags & MS_KERNMOUNT)) {
> +	if (!(fc->sb_flags & (MS_KERNMOUNT | MS_SUBMOUNT))) {

It is correct, but the long-term fix is to lift the conditional part out
of vfs_get_tree() into the callers (as discussed a couple of weeks ago).
I have it in a local branch, need to ripple it into the current main series...
