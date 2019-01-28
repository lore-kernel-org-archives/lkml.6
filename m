Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A6A2C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C7132177E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548691476;
	bh=o5v/JgT+D//nZat7bjldBs9f0YIVjDM+hABBN11HGwE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uHDAc+5w3s8+kyvK2a1lnwZZN5qUH00JCZlp08KI4bcjOLQesodAZJ/2RLYcnUWWj
	 zDOI17s7NVe/HBzktYXXWW0vjeAg6UIg9s+duJdjUbY+6kF4sL0DocG5ihjcyGt3oO
	 45w/RkcK3znv162OaOHxVXZ/6DcEbMNcIGHvDB0c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731609AbfA1QEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:04:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:50132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730106AbfA1QEb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:04:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F2C42147A;
        Mon, 28 Jan 2019 16:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691471;
        bh=o5v/JgT+D//nZat7bjldBs9f0YIVjDM+hABBN11HGwE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IfbjA5qOpdxVzwkdL73Eixl1VTOcW38+vmwTfxbgL3VuYQN/DO/t/BW2QOhdr+HUB
         h3p+4Cv/xXYNpj0LGFMloeyOaAZChSciMNID5SaYGbrimvDSdhxHA/lLujO7PoTDks
         A8zwnqDw5XmFigOObuOmxFUyrVNwJ1AJeLE2jrdg=
Date:   Mon, 28 Jan 2019 17:04:28 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Gary R Hook <ghook@amd.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 2/2] debugfs: return error values, not NULL
Message-ID: <20190128160428.GA29379@kroah.com>
References: <20190123102702.GA17123@kroah.com>
 <20190123102814.GB17123@kroah.com>
 <20190124112652.f31fc4b8dd9892f0d2f84790@kernel.org>
 <20190128225513.6511badcfcd93c3b6d7b453c@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128225513.6511badcfcd93c3b6d7b453c@kernel.org>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 10:55:13PM +0900, Masami Hiramatsu wrote:
> Hi Greg,
> 
> On Thu, 24 Jan 2019 11:26:52 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > On Wed, 23 Jan 2019 11:28:14 +0100
> > Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > 
> > > When an error happens, debugfs should return an error pointer value, not
> > > NULL.  This will prevent the totally theoretical error where a debugfs
> > > call fails due to lack of memory, returning NULL, and that dentry value
> > > is then passed to another debugfs call, which would end up succeeding,
> > > creating a file at the root of the debugfs tree, but would then be
> > > impossible to remove (because you can not remove the directory NULL).
> > > 
> > > So, to make everyone happy, always return errors, this makes the users
> > > of debugfs much simpler (they do not have to ever check the return
> > > value), and everyone can rest easy.
> > 
> > With Greg's return check removal patches, I'm OK for this change.
> > 
> > Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
> > 
> > Thank you,
> > 
> > > 
> > > Reported-by: Masami Hiramatsu <mhiramat@kernel.org>
> > > Reported-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > Reported-by: Gary R Hook <ghook@amd.com>
> > > Reported-by: Heiko Carstens <heiko.carstens@de.ibm.com>
> > > Cc: stable <stable@vger.kernel.org>
> 
> BTW, would you really think it should go to stable? It seems an improvement
> instead of a bugfix...

See later in the thread, I decided that was not the correct thing to do
:)

thanks,

greg k-h
