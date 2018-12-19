Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48AEAC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 07:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15A6A21852
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 07:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545203469;
	bh=LIlrEOL2fiXT3Hyb1BuH3YNBtVjNvYNHAcx9tvvzyec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Zs6sl3lAu2Q9lqysAqucwuHMkV0jE/aOr4jjavyelqKUGXaQpTdZI0rb6qykARYdR
	 KqUYoh6yykUGUUbDT9WNSEpk/G9CnNwMBLxR0Wt8QYmcJKt6VVGwVK9qNGZffURLDM
	 M7dZBU1s51KlRi2bnGB5/F2ZhIQk9y9Cpb75eFac=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbeLSHLI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 02:11:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:37118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727717AbeLSHLI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 02:11:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D32C721841;
        Wed, 19 Dec 2018 07:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545203467;
        bh=LIlrEOL2fiXT3Hyb1BuH3YNBtVjNvYNHAcx9tvvzyec=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UWrsF6gSuXKcAIf9wBGbm1o3zcqPhP5PvCexDT9TCV6QLfU6q6z2RJhiVlPS2WQcC
         RTWGHtMlmgCDm1XgOukpJleglDwFyOEDor0Holu1vC77FjZj3Xswm2SGMvgRXANP/l
         0n3gQ9goy07K471KHKB819kYJNEJxJngo06LPH9U=
Date:   Wed, 19 Dec 2018 08:11:04 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Omer Tripp <trippo@google.com>
Cc:     ghackmann@android.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Hackmann <ghackmann@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH] fs: fix possible Spectre V1 indexing in __close_fd()
Message-ID: <20181219071104.GA25037@kroah.com>
References: <20180924181500.125257-1-ghackmann@google.com>
 <20180924183911.GB9122@kroah.com>
 <20181015133708.GB10221@kroah.com>
 <CALTzUognuG-N4M5w9xugxF7KZjUxF_9O32fKoUt2v7st70ppmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALTzUognuG-N4M5w9xugxF7KZjUxF_9O32fKoUt2v7st70ppmw@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 06:54:31AM -0700, Omer Tripp wrote:
> Hi Greg and all,
> 
> Here is my analysis of the complete gadget, and looking forward to your
> corrections/feedback if there are any inaccuracies:
> 
> 
>    1.
> 
>    __close_fd() is reachable via the close() syscall with a user-controlled
>    fd.
>    2.
> 
>    If said bounds check is mispredicted, then a user-controlled address
>    fdt->fd[fd] is obtained then dereferenced, and the value of a
>    user-controlled address is loaded into the local variable file.
>    3.
> 
>    file is then passed as an argument to filp_close, where the cache
> lines secret
>    + offsetof(f_op) and secret + offsetof(f_mode) are hot and vulnerable to
>    a timing channel attack.
> 
> 
> The mitigation proposed by Greg Hackmann blocks this gadget.

What ever happened to this patch?  Did it get reposted?  If not, can
someone please do so with this text in the changelog?

thanks,

greg k-h
