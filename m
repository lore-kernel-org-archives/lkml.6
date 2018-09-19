Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DEC8C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 01:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E97DB214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 01:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tyYIA4Mc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E97DB214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730780AbeISGul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 02:50:41 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40159 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728188AbeISGul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 02:50:41 -0400
Received: by mail-pg1-f194.google.com with SMTP id l63-v6so1876884pga.7;
        Tue, 18 Sep 2018 18:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1pa4EslELnW/fHClHiqqZxKoPWUsD49HULo60IWjC5A=;
        b=tyYIA4McBXbjKx7XfoHCjk34jjrXq2Rc26kYnu3hOUD2gyoZ1qqGmt9Z62hVg8mxAY
         oUMUDxiNADnQ0NcIdQZ/e126XSc4YjpTXLXD/HiQVlqaURVB5rMudek3ECZH1wZLjKSj
         CNeAGiXtx2oripahYd0RNPZgitiB7SbzJH9Vy1XJ3rrPXaL3sh1Ko70C9TOsHxfguo9h
         hhOvLFdaCzL+/Wb7TSSNXoeqY3Gw5lZCFETu3U++TFuIQmPbn09nIIB5ySjGXtYMGYAx
         SnRN+j0u2GPG7Ds20gW4b+xigBD1S0IGI/EEn42YMNbsggHsRbK7reXIhek1d1Qfw3aP
         P2lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1pa4EslELnW/fHClHiqqZxKoPWUsD49HULo60IWjC5A=;
        b=kbvCUNkZE+ffftTlFtUQ26LUA4HZbzeELTcaibAEw+8MuTqI4EDG3ZgoH2hK+tudhG
         vI4fE3N2MdRFbjY5CjSt3XxawHLRiCj7TiG/bpslR1sLPxp55IOZ0ENRhroZj4VtnMsf
         OkL72JMCJ6jnjMjNsHKKOKrgC6GKIO2VK2MDM+vT26/PpOYW2z5A/X0HXdL+60VTm3HU
         igJeEH/zU7FZXvOqjtbgBrkFipmm29qQcO4VJHSl0jxtnoDpvYDABLPpfQ/mgGKUmdYu
         TtseE+IYvshACZyU1cvs3FsbxLBplk9cvAxueegrQ3Me9jN3x0PrB3CB1ebGIQB+ARsA
         izEA==
X-Gm-Message-State: APzg51APiH+mbL/8wh3qnmxy2TtElZSRC+q6TEMI5rj9vRMq5pf46qbB
        hIT3qb16KhC8R6ao/2qcOCw=
X-Google-Smtp-Source: ANB0Vdbh6WLcQzjcDrW0ZC5ZypJWkf9AJjNKJ045p+cLYhYJpwPR1CmLSmwNdFJSeshKHC7aeD9iGw==
X-Received: by 2002:a65:40cd:: with SMTP id u13-v6mr29745084pgp.334.1537319724230;
        Tue, 18 Sep 2018 18:15:24 -0700 (PDT)
Received: from localhost ([175.223.11.230])
        by smtp.gmail.com with ESMTPSA id p4-v6sm25754384pfb.180.2018.09.18.18.15.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Sep 2018 18:15:23 -0700 (PDT)
Date:   Wed, 19 Sep 2018 10:15:19 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>, viro@zeniv.linux.org.uk,
        torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 14/33] vfs: Implement a filesystem superblock
 creation/configuration context [ver #11]
Message-ID: <20180919011519.GB407@jagdpanzerIV>
References: <20180918090722.GA463@jagdpanzerIV>
 <20180911220743.GA13208@roeck-us.net>
 <20180911174641.GA15149@roeck-us.net>
 <153313703562.13253.5766498657900728120.stgit@warthog.procyon.org.uk>
 <153313714181.13253.304098108512966976.stgit@warthog.procyon.org.uk>
 <27113.1536702746@warthog.procyon.org.uk>
 <32382.1536707855@warthog.procyon.org.uk>
 <20180911235403.GA10107@roeck-us.net>
 <27019.1537288742@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27019.1537288742@warthog.procyon.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (09/18/18 17:39), David Howells wrote:
[..]
> -static int legacy_init_fs_context(struct fs_context *fc, struct dentry *dentry)
> +int legacy_init_fs_context(struct fs_context *fc, struct dentry *dentry)
>  {
> +	switch (fc->purpose) {
> +	default:
> +		fc->fs_private = kzalloc(sizeof(struct legacy_fs_context),
> +					 GFP_KERNEL);
> +		if (!fc->fs_private)
> +			return -ENOMEM;

ops->reconfigure() invoked for FS_CONTEXT_FOR_UMOUNT or
FS_CONTEXT_FOR_EMERGENCY_RO will never access fc->fs_private?

> +		break;
>  
> -	fc->fs_private = kzalloc(sizeof(struct legacy_fs_context), GFP_KERNEL);
> -	if (!fc->fs_private)
> -		return -ENOMEM;
> +	case FS_CONTEXT_FOR_UMOUNT:
> +	case FS_CONTEXT_FOR_EMERGENCY_RO:
> +		break;
> +	}

So `fc' can either be zeroed-out, when it comes from fc = kzalloc(),
or contain some garbage otherwise. Would it make sense to zero-out `fc'
regardless of its origin?

>  	down_write(&sb->s_umount);
> -	if (!sb_rdonly(sb))
> -		/* Might want to call ->init_fs_context(). */
> -		ret = reconfigure_super(&fc);
> +	if (!sb_rdonly(sb)) {
> +		int ret;
> +
> +		if (fc.fs_type->init_fs_context)
> +			ret = fc.fs_type->init_fs_context(&fc, NULL);
> +		else
> +			ret = legacy_init_fs_context(&fc, NULL);
> +
> +		if (ret == 0) {
> +			ret = reconfigure_super(&fc);
> +			fc.ops->free(&fc);
			^^^^^^^
Is ops->free() always !NULL?

	-ss
