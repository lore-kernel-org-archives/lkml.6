Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2AB2C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 11:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E56121019
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 11:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548244540;
	bh=QcJD0ly2gRkoCFnAmdg9PIx3OJLhjFd3dG+J6dN/ReY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xxpxT/vLz2qGCXDXyufk2cduAWBw4gyPVBBPW5/lcyxqsJTyMqJY7pSSIC4A7a8bg
	 MWIhvYqRtuzky5isZ0WNc9cRrNg0jKS29VVtyT5rc9GQ4Lri+u1t/Ufpazxvx7B9Bq
	 hRZ3YVs/GlyUhQ8DawXLU41Fh7F/FozYucrGaTpk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbfAWLzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 06:55:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:39144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbfAWLzi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 06:55:38 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0590321019;
        Wed, 23 Jan 2019 11:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548244537;
        bh=QcJD0ly2gRkoCFnAmdg9PIx3OJLhjFd3dG+J6dN/ReY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ArIfGxsIZgHPRtG1HJGWyheU4q5nym/bX84vO/q6cBRx1gg+bGOgoTBN8TVOBxs5p
         C+u8M0e+ZNX6m74fyOwe5XHss1ALMDtPDBctGlhfHnJSiuP/TDHL0C4knwMGgC7hyv
         s5z0O+O34s/iGQQPp96HeUvQTUc8UR1I6gf0KboA=
Date:   Wed, 23 Jan 2019 12:55:35 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Gary R Hook <ghook@amd.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 2/2] debugfs: return error values, not NULL
Message-ID: <20190123115535.GA31237@kroah.com>
References: <20190123102702.GA17123@kroah.com>
 <20190123102814.GB17123@kroah.com>
 <20190123110628.GV4087@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190123110628.GV4087@dhcp22.suse.cz>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 12:06:28PM +0100, Michal Hocko wrote:
> On Wed 23-01-19 11:28:14, Greg KH wrote:
> > When an error happens, debugfs should return an error pointer value, not
> > NULL.  This will prevent the totally theoretical error where a debugfs
> > call fails due to lack of memory, returning NULL, and that dentry value
> > is then passed to another debugfs call, which would end up succeeding,
> > creating a file at the root of the debugfs tree, but would then be
> > impossible to remove (because you can not remove the directory NULL).
> > 
> > So, to make everyone happy, always return errors, this makes the users
> > of debugfs much simpler (they do not have to ever check the return
> > value), and everyone can rest easy.
> 
> How come this is safe at all? Say you are creating a directory by
> debugfs_create_dir and then feed the return value to debugfs_create_files
> as a parent. In case of error you are giving it an invalid pointer and
> likely blow up unless I miss something.

debugfs_create_files checks for invalid parents and will just refuse to
create the file.  It's always done that.

> I do agree that reporting errors is better than a simple catch all NULL
> but this should have been done when introduced rather than now when most
> callers simply check for NULL as a failure.

I'm fixing up all the "NULL is a failure" callsites in the kernel, see
lkml for the first round of those patches.

thanks,

greg k-h
