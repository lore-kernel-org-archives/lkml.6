Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C00DDC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 21:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83A5420831
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 21:46:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83A5420831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbeLIVqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 16:46:02 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:38816 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbeLIVqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:46:02 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.91 #2 (Red Hat Linux))
        id 1gW6tk-0000fV-G1; Sun, 09 Dec 2018 21:46:00 +0000
Date:   Sun, 9 Dec 2018 21:46:00 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     linux-sparse@vger.kernel.org, kernel-hardening@lists.openwall.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC v1] copy_{to,from}_user(): only inline when !__CHECKER__
Message-ID: <20181209214600.GC2217@ZenIV.linux.org.uk>
References: <20181209204449.18906-1-tycho@tycho.ws>
 <20181209210220.GB2217@ZenIV.linux.org.uk>
 <20181209212523.GE30796@cisco>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181209212523.GE30796@cisco>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 09, 2018 at 02:25:23PM -0700, Tycho Andersen wrote:

> > Which sparse checks do not trigger?  Explain, please - as it is, I had been
> > unable to guess what could "specifically looks for a call instruction" refer
> > to.
> 
> In sparse.c there's check_call_instruction(), which is triggered when
> there's an instruction of OP_CALL type in the basic block. This simply
> compares against the name of the call target to determine whether or
> not to call check_ctu().

Oh, that Linus' experiment with "look for huge constant size argument
to memcpy() et.al."?  Frankly, it's not only the wrong place to put the
checks, but breaking inlining loses the _real_ "known constant size"
checks in there.

I don't know if the check_ctu thing has ever caught a bug...  What kind of
checks do you want to add?  Because this place is almost certainly wrong
for anything useful...

If anything, I would suggest simulating this behaviour with something like
	if (__builtin_constant_p(size) && size > something)
		/* something that would trigger a warning */
_inside_ copy_from_user()/copy_to_user() and to hell with name-recognizing
magic...
