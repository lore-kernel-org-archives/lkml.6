Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D547ECE562
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 01:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3563B2087E
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 01:56:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="Uu5b7hpI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3563B2087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbeIPHSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 03:18:04 -0400
Received: from imap.thunk.org ([74.207.234.97]:37038 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727010AbeIPHSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 03:18:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ZRZey9k/g86dmJcUvFgMQkjynu5uwjcPmQtdAA6OaKA=; b=Uu5b7hpIab68I6KW6yX7H7u6dP
        Lmi72GRtod/WQJsyMwxlQkfoG9NolQd94iGBNkzj88EzMZ+BenNq7IOpU0dgFaGR7WykugXXGJCzg
        Ncy0b09xf+x8/sBRF71mBueGw/Nqe5XscUxiWPsO5yQ6gtV1O8ezqcfkvVh4X9JxVcKo=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1g1MIp-0005m6-V5; Sun, 16 Sep 2018 01:56:48 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id A66DF7A585D; Sat, 15 Sep 2018 21:56:46 -0400 (EDT)
Date:   Sat, 15 Sep 2018 21:56:46 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Toshi Kani <toshi.kani@hpe.com>
Cc:     jack@suse.cz, dan.j.williams@intel.com, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/3] ext4, dax: set ext4_dax_aops for dax files
Message-ID: <20180916015646.GE8652@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Toshi Kani <toshi.kani@hpe.com>, jack@suse.cz,
        dan.j.williams@intel.com, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20180914145114.11122-1-toshi.kani@hpe.com>
 <20180914145114.11122-3-toshi.kani@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180914145114.11122-3-toshi.kani@hpe.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 08:51:13AM -0600, Toshi Kani wrote:
> Sync syscall to DAX file needs to flush processor cache, but it
> currently does not flush to existing DAX files.  This is because
> 'ext4_da_aops' is set to address_space_operations of existing DAX
> files, instead of 'ext4_dax_aops', since S_DAX flag is set after
> ext4_set_aops() in the open path.
> 
>   New file
>   --------
>   lookup_open
>     ext4_create
>       __ext4_new_inode
>         ext4_set_inode_flags   // Set S_DAX flag
>       ext4_set_aops            // Set aops to ext4_dax_aops
> 
>   Existing file
>   -------------
>   lookup_open
>     ext4_lookup
>       ext4_iget
>         ext4_set_aops          // Set aops to ext4_da_aops
>         ext4_set_inode_flags   // Set S_DAX flag
> 
> Change ext4_iget() to initialize i_flags before ext4_set_aops().
> 
> Fixes: 5f0663bb4a64 ("ext4, dax: introduce ext4_dax_aops")
> Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
> Suggested-by: Jan Kara <jack@suse.cz>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: "Theodore Ts'o" <tytso@mit.edu>
> Cc: Andreas Dilger <adilger.kernel@dilger.ca>
> Cc: <stable@vger.kernel.org>

Thanks, applied.

					- Ted
