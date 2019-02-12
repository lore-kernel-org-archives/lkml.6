Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D9FFC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6F00218A3
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549963747;
	bh=7KPgEae8NuzgqM4QBhof7ZyaLH5S80CGzFD8+aCtXXY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WjyfqbmJBET5taeXTlno8DaAuYyusaR7jRDl0ukmx0S35GJMtdsIIYvej5kl5YQKe
	 C/mkvzloLH81bBJTRVLHP/BBMDoQQp21+QFTsp9dHKs+omz2xQCAuzHcQz/VOnZIjV
	 hZA2mq3hueVLjvyhHO4OpL614uj3HHjb/okPVMRY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbfBLJ3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 04:29:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:35122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726040AbfBLJ3E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 04:29:04 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03B6821773;
        Tue, 12 Feb 2019 09:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549963744;
        bh=7KPgEae8NuzgqM4QBhof7ZyaLH5S80CGzFD8+aCtXXY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PZC9jMEuS/eogngwxO6BEdRXuIu4QrVKyzZuMuIuHBzyX6QhI0V0UexcLOd4Gs0Eh
         zEBl0zR+/Mj91Rlgczx7Nssy/m/aRYEsrWRXvYETjdBogLovA54mo5HH85eFQBJXbQ
         eZrNiHiuPEAPUG8xuvGovDpsXh/0Vr0nG3Xh2Ozw=
Date:   Tue, 12 Feb 2019 10:29:02 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Chengguang Xu <cgxu519@gmx.com>
Cc:     tomas.winkler@intel.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mei: expand minor range when registering chrdev region
Message-ID: <20190212092902.GD27450@kroah.com>
References: <20190212060252.8948-1-cgxu519@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212060252.8948-1-cgxu519@gmx.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 02:02:52PM +0800, Chengguang Xu wrote:
> Actually, total amount of available minor number
> for a single major is MINORMARK + 1. So expand
> minor range when registering chrdev region.
> 
> Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
> ---
>  drivers/misc/mei/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/mei/main.c b/drivers/misc/mei/main.c
> index 87281b3695e6..3df54f1e1a8b 100644
> --- a/drivers/misc/mei/main.c
> +++ b/drivers/misc/mei/main.c
> @@ -869,7 +869,7 @@ static const struct file_operations mei_fops = {
>  
>  static struct class *mei_class;
>  static dev_t mei_devt;
> -#define MEI_MAX_DEVS  MINORMASK
> +#define MEI_MAX_DEVS  (MINORMASK + 1)

Why is this needed?  Have you really run out of that many minor nodes
for this driver?

thanks,

greg k-h
