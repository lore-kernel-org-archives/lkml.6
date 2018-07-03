Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D94C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 23:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 845DA20855
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 23:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="kEsU3w3B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 845DA20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753575AbeGCXwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 19:52:22 -0400
Received: from imap.thunk.org ([74.207.234.97]:58076 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752387AbeGCXwU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 19:52:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=D0vmJX6pr8Re/OQ0o1Rxv1k0HO2j5XjukO7OcPGQm8E=; b=kEsU3w3B+W1SiPaH7fDYVyB8NS
        FeGWr5r4uaES5n+274Pc30mMqs1Dz7O2fXp2mOp+Bavh/KAh/meaoJ0kFLtxTysgo3xcLafPoqa01
        BQZX9+XzeLLAJAW4O4ULAOdvtShvtTo+9R6xPAYoJ7zXpjIuibSDrEhyGLDq4GzLEAQw=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1faV5h-0007wq-Cm; Tue, 03 Jul 2018 23:52:13 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 9C4ED7A01EE; Tue,  3 Jul 2018 19:43:31 -0400 (EDT)
Date:   Tue, 3 Jul 2018 19:43:31 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     mgorman@techsingularity.net, adilger.kernel@dilger.ca,
        darrick.wong@oracle.com, dchinner@redhat.com,
        akpm@linux-foundation.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] fs: ext4: use BUG_ON if writepage call comes from
 direct reclaim
Message-ID: <20180703234331.GA5104@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Yang Shi <yang.shi@linux.alibaba.com>, mgorman@techsingularity.net,
        adilger.kernel@dilger.ca, darrick.wong@oracle.com,
        dchinner@redhat.com, akpm@linux-foundation.org,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1530591079-33813-1-git-send-email-yang.shi@linux.alibaba.com>
 <20180703103948.GB27426@thunk.org>
 <6c305241-d502-b8ea-a187-54c33e4ca692@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c305241-d502-b8ea-a187-54c33e4ca692@linux.alibaba.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 10:05:04AM -0700, Yang Shi wrote:
> I'm not sure if it is a good choice to let filesystem handle such vital VM
> regression. IMHO, writing out filesystem page from direct reclaim context is
> a vital VM bug. It means something is definitely wrong in VM. It should
> never happen.

If it does happen, it should happen reliably; this isn't the sort of
thing where some linked list had gotten corrupted.  This would be a
structural problem in the VM code.

So presumably, if the WARN_ON triggered, it should be be noticed by VM
developers, and they should fix it.

In general, though, BUG_ON's should be avoided unless there really is
no way to recover.

> It sounds ok to have filesystem throw out warning and handle it, but I'm not
> sure if someone will just ignore the warning, but it should *never* be
> ignored.

If a kernel develper (a VM developer in this case) ignores a warning,
that's just simply professional malpractice.  In general WARN_ON's
should only be used as a sign of a kernel bug.  So they should never
be ignored.

						- Ted
