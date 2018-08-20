Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8BA8C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 00:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82D172146E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 00:02:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="EsivCMF2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82D172146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbeHTDPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 23:15:41 -0400
Received: from imap.thunk.org ([74.207.234.97]:54660 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726486AbeHTDPk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 23:15:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=/2ijYlux+YbKK4Pgbo7v9AAZVjfOv2k2GoIBwaOV/jE=; b=EsivCMF2EBft3W/BfmnDEQcgNO
        Wz+9FFygXdh7of3qIru9GHLEtPP+3L6U3DZAb6dtBX24EOMhr+yB5EyAKB/nORJ+yPZvSNVD1oqQs
        T1ALrcvYW9hhF/QMWqTwH9zoquAB15dLYQw33SIyCcYE1Mdmnw9D659pjc1+zEPSiUEI=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1frXeG-0004Ow-3V; Mon, 20 Aug 2018 00:02:20 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 4B78F7A57A8; Sun, 19 Aug 2018 20:02:18 -0400 (EDT)
Date:   Sun, 19 Aug 2018 20:02:18 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build warnings from Linus' tree
Message-ID: <20180820000218.GE19200@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180820081323.23a47af3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180820081323.23a47af3@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2018 at 08:13:23AM +1000, Stephen Rothwell wrote:
> fs/ext4/super.c: In function '__save_error_info':
> fs/ext4/super.c:344:2: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]
>   strncpy(es->s_last_error_func, func, sizeof(es->s_last_error_func));
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> fs/ext4/super.c:349:3: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]
>    strncpy(es->s_first_error_func, func,
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     sizeof(es->s_first_error_func));
>     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

All of ext4 superblock char[] fields are not necessarily null
terminated, so this is a false positive.  I suppose we could do
something like this:

inline char *
strncpy_I_solemnly_swear_I_know_what_I_am_doing(char *dest,
			const char *src, size_t n)
{
#if __GNUC_PREREQ (8, 2)
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wstringop-truncate"
#endif
	return strncpy(dest, src, n);
#if __GNUC_PREREQ (8, 2)
#pragma GCC diagnostic pop
#endif
}

(if we really think this warning is worthwhile enough that we don't
just want to globally disable it, of course)

       		      	       - Ted

P.S.  It's really, really too bad there isn't a simpler way to shut up
gcc.  You need the #ifdef __GNUC_PREREQ nonsense because otherwise
older versions of gcc that don't understand the particular warning
you're trying to suppress will complain loudly.  (Ask me how I
know....)
