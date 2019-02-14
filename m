Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 140DFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 12:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7A02222D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 12:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550148260;
	bh=ZnGQcL6GzK4LDWsaHASWt27zgKRC2BORrK4vuFLDWe8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FSj4j3ox/bP/QqF8bxJC1QMU9lE80lUmOwVLUTRNpbjh8hwALVBYkexM/Shn0iCBt
	 kY7pBdNEfjiG+rBDqxsE3vQ6piEwBzKlShrWCSh51sv2KCdouRSK9gtK9O9+FEZtqH
	 34404rU+yigL8UMNTFFr4b0pnRIaZx4oVlXnSmIU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392568AbfBNMoS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 07:44:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:38360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394381AbfBNMoP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 07:44:15 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03A38218FF;
        Thu, 14 Feb 2019 12:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550148254;
        bh=ZnGQcL6GzK4LDWsaHASWt27zgKRC2BORrK4vuFLDWe8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=muNvwodX5ZUErvrrn46d4wFgT3i27uwxxyFReCrH8fjpZLFL9AmECjCoR4L0eVzNv
         HjeFuJZuOlG7cN+AvnpvfIwdzLovLA/+ZihNUH3Ekk3pQ8/K2KLUMlcobbZqQleY6Y
         xl6Vos9Snl90tuzpW8BYAhdgX3wF8cn74GHdTfD4=
Date:   Thu, 14 Feb 2019 13:44:12 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nicholas Mc Guire <hofrat@osadl.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] sysfs.txt: add note on available attribute macros
Message-ID: <20190214124412.GC17978@kroah.com>
References: <1550143310-17463-1-git-send-email-hofrat@osadl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550143310-17463-1-git-send-email-hofrat@osadl.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 12:21:50PM +0100, Nicholas Mc Guire wrote:
> The common cases of attributes should probably be using the __ATTR_XXX
> macros to make code more concise and readable but the current sysfs.txt
> does not point developers to those convenience macros. Further there is
> no note in sysfs.txt currently explaining why trying to set a sysfs file
> to mode 0666 will fail.
> 
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> ---
> 
> Note quite sure if this is the right place to place the note on mode 0666 
> but it should be somewhere as any attempt to set 0666 will be reverted 
> to 0664.
> 
>  Documentation/filesystems/sysfs.txt | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/Documentation/filesystems/sysfs.txt b/Documentation/filesystems/sysfs.txt
> index 41411b0..c246142 100644
> --- a/Documentation/filesystems/sysfs.txt
> +++ b/Documentation/filesystems/sysfs.txt
> @@ -116,6 +116,22 @@ static struct device_attribute dev_attr_foo = {
>  	.store = store_foo,
>  };
>  
> +Note as stated in include/linux/kernel.h "OTHER_WRITABLE?  Generally
> +considered a bad idea." so trying to set a sysfs file writable for
> +everyone will fail reverting to mode 0664.
> +
> +For this common cases sysfs.h provides convenience macros to
> +make defining attributes easier as well as making code more
> +concise and readable. The above case could be shortened to:
> +
> +static struct device_attribute dev_attr_foo = __ATTR_RW(foo);
> +
> +the list of helpers available is:
> +__ATTR_RO(name): same as above with mode 0444
> +__ATTR_WO(name): same as above with mode 0200
> +__ATTR_RO_MODE(name, mode): allowing to pass in a specific mode
> +__ATTR_RW(name): setting mode to 0644
> +__ATTR_NULL: which sets the name to NULL

__ATTR_NULL is used to end a list of attributes, no one should actually
try to use it :)

And really, all the current users of it should be converted to use the
groups api instead, as it should not be needed.

__ATTR_RO_MODE() needs a bit more description as well.

So the idea of documenting these is great, just needs a bit of tweaking.

thanks,

greg k-h
