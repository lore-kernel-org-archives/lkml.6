Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97515ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 556DC2081D
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="CRkvQKyn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 556DC2081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbeKIAaY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 19:30:24 -0500
Received: from imap.thunk.org ([74.207.234.97]:54324 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbeKIAaY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 19:30:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=4eNQaYl+Bvq4EwJ6ScMXyJFtmkmXBC9lp9Ce4bkfQyU=; b=CRkvQKynKDTo7+54Ts5wkmijGk
        VFDd5Enmyb8JPLdXMsMjYXHdNH6MKAo0TLrtDX8INge5xXSyG785G/tD0mGJcyuU7EbYUo5CLm5MQ
        d2pF9bATEo7Xsnm+4vYRGmjLWvsb7ze36KhTyEkqh14LpYTDZw4/DfR+w6Jgyh0JMU8w=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1gKlhX-0006Kj-6F; Thu, 08 Nov 2018 14:54:31 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id EF6467A7D2B; Thu,  8 Nov 2018 09:54:29 -0500 (EST)
Date:   Thu, 8 Nov 2018 09:54:29 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ext4: missing !bh check in ext4_xattr_inode_write()
Message-ID: <20181108145429.GE22459@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Vasily Averin <vvs@virtuozzo.com>, linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-kernel@vger.kernel.org
References: <20181107163346.GH9919@thunk.org>
 <a3f1e28c-fba0-2b07-b710-c559fab555b8@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3f1e28c-fba0-2b07-b710-c559fab555b8@virtuozzo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 09:46:30AM +0300, Vasily Averin wrote:
> diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> index 0b9688683526..415f73d4c9e6 100644
> --- a/fs/ext4/xattr.c
> +++ b/fs/ext4/xattr.c
> @@ -1384,6 +1384,12 @@ static int ext4_xattr_inode_write(handle_t *handle, struct inode *ea_inode,
>  		bh = ext4_getblk(handle, ea_inode, block, 0);
>  		if (IS_ERR(bh))
>  			return PTR_ERR(bh);
> +		if (!bh) {
> +			WARN_ON_ONCE(1);
> +			__ext4_error_inode(ea_inode, __func__, __LINE__, 0,
> +					   "ext4_getblk() return bh = NULL");

You should use EXT4_ERROR_INODE(), defined in ext4.h, not
__ext4_error_inode().  That way you don't need to explicitly specify
__func__ and __LINE__, and we the compiler will correctly do printf
format checking even when CONFIG_PRINTK is not set.

						- Ted
