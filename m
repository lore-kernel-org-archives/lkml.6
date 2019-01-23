Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C1A9C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3848521019
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548239375;
	bh=9IJGizD5zm4rnNklHMrj94YmvaFgTtD+h+oOWbuLSc0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=q7bqPaV4g6GdRqxkIwpEo71PNbzsQ3g4zEjXgXLHUikNKex1sIXZlFrXK2j9J7kq2
	 lw9x9ErfliovLJBCF6vcDuR1DgZUinV66XA1gZHu6xUB24w+wlo2jeAYH7ULQQ4oCR
	 W1R/05hs6gks6WGAVMsSsmvI+PW7wFP8Oinum+fw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbfAWK3d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 05:29:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:60912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726207AbfAWK3d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 05:29:33 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71E3320861;
        Wed, 23 Jan 2019 10:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548239372;
        bh=9IJGizD5zm4rnNklHMrj94YmvaFgTtD+h+oOWbuLSc0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EEYy+flSRwlN37cr5N08H+WnTV/vHtegUWFTlLAFBYiDJxoJFEqUOd3epNur2U7id
         Bvd3l6rKyzQomDXrt5OdcSpoABw00cLmUr+NYXGiPFwFXGKTD0YSf99VqI/FrBvRiF
         FLTk6ZULIUNrdtAllCAe1DTA6DWItWpgOYXVYanQ=
Date:   Wed, 23 Jan 2019 11:29:30 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Gary R Hook <ghook@amd.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 2/2] debugfs: return error values, not NULL
Message-ID: <20190123102930.GC17123@kroah.com>
References: <20190123102702.GA17123@kroah.com>
 <20190123102814.GB17123@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190123102814.GB17123@kroah.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 11:28:14AM +0100, Greg Kroah-Hartman wrote:
> When an error happens, debugfs should return an error pointer value, not
> NULL.  This will prevent the totally theoretical error where a debugfs
> call fails due to lack of memory, returning NULL, and that dentry value
> is then passed to another debugfs call, which would end up succeeding,
> creating a file at the root of the debugfs tree, but would then be
> impossible to remove (because you can not remove the directory NULL).
> 
> So, to make everyone happy, always return errors, this makes the users
> of debugfs much simpler (they do not have to ever check the return
> value), and everyone can rest easy.
> 
> Reported-by: Masami Hiramatsu <mhiramat@kernel.org>
> Reported-by: Ulf Hansson <ulf.hansson@linaro.org>
> Reported-by: Gary R Hook <ghook@amd.com>
> Reported-by: Heiko Carstens <heiko.carstens@de.ibm.com>

Oops, also reported by:
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>

I'll go fix that up when I merge this.

greg k-h
