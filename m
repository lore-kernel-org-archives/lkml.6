Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E72DC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 04:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFAD2208C3
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 04:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="CoSs6Q4V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFAD2208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbeHBFzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 01:55:21 -0400
Received: from imap.thunk.org ([74.207.234.97]:56434 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725954AbeHBFzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 01:55:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=LCCfssrd3CeWdkpKxHDAHOJ6cjkdIVLcqZC2rT8pLYA=; b=CoSs6Q4VFm+I0zPZq/XSxi7mO+
        l3TIHw+uUIA8ZSW76AmcaSozIE5Reo4dSlu9lfvCQrT5aNrevnnW9Kdf/myzCwAgmwXboTKCorwp6
        SESzKpko+yj1YZMxBqy0oPqEAnH4Z04cMigGv5Ns9lY0yHM8TkmAMxNj3rorbD1hcLGA=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1fl4sM-0001vS-G9; Thu, 02 Aug 2018 04:06:10 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 5F2607A614F; Thu,  2 Aug 2018 00:06:09 -0400 (EDT)
Date:   Thu, 2 Aug 2018 00:06:09 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jeremy Cline <jcline@redhat.com>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2] ext4: mballoc: Fix spectre gadget in
 ext4_mb_regular_allocator
Message-ID: <20180802040609.GD9187@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jeremy Cline <jcline@redhat.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>, stable@vger.kernel.org
References: <20180730180747.25200-1-jcline@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730180747.25200-1-jcline@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 06:07:47PM +0000, Jeremy Cline wrote:
> 'ac->ac_g_ex.fe_len' is a user-controlled value which is used in the
> derivation of 'ac->ac_2order'. 'ac->ac_2order', in turn, is used to
> index arrays which makes it a potential spectre gadget. Fix this by
> sanitizing the value assigned to 'ac->ac2_order'.  This covers the
> following accesses found with the help of smatch:
> 
> * fs/ext4/mballoc.c:1896 ext4_mb_simple_scan_group() warn: potential
>   spectre issue 'grp->bb_counters' [w] (local cap)
> 
> * fs/ext4/mballoc.c:445 mb_find_buddy() warn: potential spectre issue
>   'EXT4_SB(e4b->bd_sb)->s_mb_offsets' [r] (local cap)
> 
> * fs/ext4/mballoc.c:446 mb_find_buddy() warn: potential spectre issue
>   'EXT4_SB(e4b->bd_sb)->s_mb_maxs' [r] (local cap)
> 
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: stable@vger.kernel.org
> Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Signed-off-by: Jeremy Cline <jcline@redhat.com>

Thanks, applied.

					- Ted
