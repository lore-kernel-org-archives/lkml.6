Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5626FC282C6
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 08:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1178020870
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 08:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548405626;
	bh=x9ixiTmVDU76XRD7HVCS3rT0gY0s8L0TiVE0JQyRBdA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DcGZ6s+xoGXDKRY512VjUpold9sOtZlEb/N3M2+wtR9KshnBRLehg+xCB+EK9veuI
	 MQj1+WM6QtksbhBg/Ae4eJO6V0cKogvjYrVNqzmnkCRPXYjHzB/bAIw3v763TNC68I
	 GvBvVQqDiUIuypMfJEj6/Bl3L34lvqvByZyaXZ0I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbfAYIkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 03:40:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:35760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726441AbfAYIkY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 03:40:24 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2B4420870;
        Fri, 25 Jan 2019 08:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548405623;
        bh=x9ixiTmVDU76XRD7HVCS3rT0gY0s8L0TiVE0JQyRBdA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OCDokKr1PGrfPY15KxmCZGKBcQCo4P83wyiZCz+MhjQFbECQ9UmlCylQ1OIPZfatG
         AWKVyCyrlkscZBvfXcVWGDY4b3IEbCbdT7GBAQ5nsgusqAwAfaBGuvqyXTXiP3jliT
         D6+qzODCwG/tFs7jYu3Ea/Kmu1CAPE63p/mfkgtk=
Date:   Fri, 25 Jan 2019 09:40:20 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Geliang Tang <geliangtang@gmail.com>
Cc:     Phillip Lougher <phillip@squashfs.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>, Coly Li <colyli@suse.de>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] squashfs: Add posix acl support
Message-ID: <20190125084020.GA10018@kroah.com>
References: <cover.1548403955.git.geliangtang@gmail.com>
 <15428d5047390927114ad49d7721b3da2bdf40ef.1548403955.git.geliangtang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15428d5047390927114ad49d7721b3da2bdf40ef.1548403955.git.geliangtang@gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 04:27:47PM +0800, Geliang Tang wrote:
> --- /dev/null
> +++ b/fs/squashfs/acl.c
> @@ -0,0 +1,69 @@
> +/*
> + * Squashfs - a compressed read only filesystem for Linux

No SPDX line?

> + *
> + * Copyright (c) 2018
> + * Phillip Lougher <phillip@squashfs.org.uk>

Did Phillip write this file, or did you?

> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2,
> + * or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.

No need for any of that header stuff, if you put in the proper SPDX
line.

> --- /dev/null
> +++ b/fs/squashfs/acl.h
> @@ -0,0 +1,31 @@
> +/*
> + * Squashfs - a compressed read only filesystem for Linux

<snip>

Same comments here about this file.


thanks,

greg k-h
