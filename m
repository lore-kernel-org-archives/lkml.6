Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14887C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7F2820870
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549030137;
	bh=7OA25qfVAzON20jJeSkueO6MKWbryxP7uroPyszcNng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=unyMho0gYDdE7nWWKIdqDxKfNJYbXl9dfgSBn4ZHs8ZzJjiuCJqhKXqvxABBPKJwA
	 M+LUnUKwGdnrku9ZM8Rgz5tjnGxcNl+qz0fcVZj9cMM17ujtxu32Cz5FnzTFrYIJzW
	 v5PO/GDSOBTSyLFMCMepmsXfUj3fCz86Z2YZKdRA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729768AbfBAOI4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 09:08:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:33162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727454AbfBAOIz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 09:08:55 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DF7C2086C;
        Fri,  1 Feb 2019 14:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549030135;
        bh=7OA25qfVAzON20jJeSkueO6MKWbryxP7uroPyszcNng=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I/eo1TizT9liXKVn64sYAgcmLCpaPPB9fX8itTO/tdAr4lvsqfpiYIAPKu0qmlY2N
         HEpiOZsjdpo8+WmXxAMI2sizcilH8m9q5hDDB3UJxwYqoXGUQ8enzZAb9kCtt5bb9p
         qAvIXpBl/0ERMjnhzMssaQ3ADIq9ou84GJH6tVZg=
Date:   Fri, 1 Feb 2019 15:08:52 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jann Horn <jannh@google.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 095/103] bpf: prevent out of bounds speculation on
 pointer arithmetic
Message-ID: <20190201140852.GA20335@kroah.com>
References: <20190129113159.567154026@linuxfoundation.org>
 <20190129113207.223846678@linuxfoundation.org>
 <CAG48ez2KSRFkRCHdvOhZSsNkdWw=jq8yu9OvUPswsA3i6mq73g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez2KSRFkRCHdvOhZSsNkdWw=jq8yu9OvUPswsA3i6mq73g@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2019 at 03:00:18PM +0100, Jann Horn wrote:
> On Tue, Jan 29, 2019 at 12:47 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > 4.19-stable review patch.  If anyone has any objections, please let me know.
> >
> > ------------------
> >
> > [ commit 979d63d50c0c0f7bc537bf821e056cc9fe5abd38 upstream ]
> >
> > Jann reported that the original commit back in b2157399cc98
> > ("bpf: prevent out-of-bounds speculation") was not sufficient
> > to stop CPU from speculating out of bounds memory access:
> > While b2157399cc98 only focussed on masking array map access
> > for unprivileged users for tail calls and data access such
> > that the user provided index gets sanitized from BPF program
> > and syscall side, there is still a more generic form affected
> > from BPF programs that applies to most maps that hold user
> > data in relation to dynamic map access when dealing with
> > unknown scalars or "slow" known scalars as access offset, for
> > example:
> 
> Is this also going into 4.14 and 4.9? I don't see anything related in
> the stable queue or in stable-rc.

Ah, the original submitter did not send backported patches, but you are
right, it should go further back.  I'll see how hard it would be to do
the backport, thanks for letting me know.

greg k-h
