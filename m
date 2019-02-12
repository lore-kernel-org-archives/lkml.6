Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A5BC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B33920675
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549961338;
	bh=UAJDprAmUxSF4d6r+opZ3U08q7nFOQU82RNdpKvf9aI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=z7eFxPL8qPbSkb+FHcFXgLoUlwSuaOqf69/KUE4wAvazzaLkPZLiZ0TP5RK0QzLBm
	 MOKn0sXBqYQXsWb/tx46d+I/OvXqaYw4W4x7MwIjkVbWUas4kUhjgGycL+vdFQuusW
	 jTf9Cb3ta1VF2Sckb2qohd0faptwUu6N1W0Aggb4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbfBLIs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 03:48:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:42652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728410AbfBLIs4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 03:48:56 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4458D21773;
        Tue, 12 Feb 2019 08:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549961335;
        bh=UAJDprAmUxSF4d6r+opZ3U08q7nFOQU82RNdpKvf9aI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=huFYGz4+DC4H80pbzBrsJwZ2xkSUV+6V6uHVMm+15ugQDjVAtpqzdFExErQnd4dgd
         QgassdDOTpWuHimaRnSf6bYaUtKV2BS/gou+EIGu9M8ub3YtzUPYIbBncq+eus9M+t
         qWjHjlaWqLN7jVsuRBXxaA6Eaime+oovP/mmyocE=
Date:   Tue, 12 Feb 2019 09:48:52 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Benjamin Gordon <bmgordon@google.com>,
        John Stultz <john.stultz@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Oren Laadan <orenl@cellrox.com>,
        Ruchi Kandoi <kandoiruchi@google.com>,
        Rom Lemarchand <romlem@android.com>,
        Todd Kjos <tkjos@google.com>, Colin Cross <ccross@android.com>,
        Nick Kralevich <nnk@google.com>,
        Dmitry Shmidt <dimitrysh@google.com>,
        Elliott Hughes <enh@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.20 282/352] fs/proc/base.c: use ns_capable instead of
 capable for timerslack_ns
Message-ID: <20190212084852.GA31657@kroah.com>
References: <20190211141846.543045703@linuxfoundation.org>
 <20190211141904.885459037@linuxfoundation.org>
 <87tvh9es4x.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tvh9es4x.fsf@xmission.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 07:02:06PM -0600, Eric W. Biederman wrote:
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> 
> > 4.20-stable review patch.  If anyone has any objections, please let me
> > know.
> 
> No objection.  But I think of this as a feature addition rather than a
> fix for something.  As a feature that we now allow something we
> previously did not does this qualify for a backport to stable?
> 
> It is probably no more harmful in this instance than adding PCI IDs to a
> driver.  So I am not worried.  I am curious the current guidelines
> are.
> 
> In most cases a small relaxation of permissions like this requires a lot
> of bug fixing as typically code protected by capable(CAP_XXX) has been
> written and tested assuming a trusted root user.  Those bug fixes are
> many times too large for a stable backport.

Fair enough, patch is now dropped, thanks for the review.

greg k-h
