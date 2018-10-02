Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43926C64EBD
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 23:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08188206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 23:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="uhw1AhTs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08188206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbeJCG0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 02:26:38 -0400
Received: from imap.thunk.org ([74.207.234.97]:48444 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725198AbeJCG0i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 02:26:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=GfC3Lyv+bxJ55Ur2LIsRWDjgP1Y4L4aB2JULTtefsS8=; b=uhw1AhTs5Eq3FZ/DegQwxorb9x
        Cq8EhSRXH1fR7bAciSvRJhdDflw/6AcrXaRefe6cLEEnuM4ESdZxaZ3qvXJ/ja5nCwgU+2pzR1NFt
        /SF61PoqrTWHAhFkhq9DFLGal55hQ5DTrrY5lMSldVoamqQ2kS+xPwdUHwVans20q+wM=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1g7UHS-0001GC-K3; Tue, 02 Oct 2018 23:40:42 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id E2AAA7A5186; Tue,  2 Oct 2018 19:40:41 -0400 (EDT)
Date:   Tue, 2 Oct 2018 19:40:41 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     syzbot <syzbot+e81ccd4744c6c4f71354@syzkaller.appspotmail.com>
Cc:     dmitry.kasatkin@gmail.com, jlayton@kernel.org, jmorris@namei.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, mjg59@google.com,
        serge@hallyn.com, sudeep.holla@arm.com,
        syzkaller-bugs@googlegroups.com, zohar@linux.vnet.ibm.com
Subject: Re: general protection fault in rb_erase
Message-ID: <20181002234041.GC2483@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        syzbot <syzbot+e81ccd4744c6c4f71354@syzkaller.appspotmail.com>,
        dmitry.kasatkin@gmail.com, jlayton@kernel.org, jmorris@namei.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
        mjg59@google.com, serge@hallyn.com, sudeep.holla@arm.com,
        syzkaller-bugs@googlegroups.com, zohar@linux.vnet.ibm.com
References: <00000000000041b4c20576baae46@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000041b4c20576baae46@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 04:44:03PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    846e8dd47c26 Merge tag 'scsi-fixes' of git://git.kernel.or..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=15c874a1400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=dfb440e26f0a6f6f
> dashboard link: https://syzkaller.appspot.com/bug?extid=e81ccd4744c6c4f71354
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15bddd2a400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1293d3fa400000

Fixed with this patch:

	http://patchwork.ozlabs.org/patch/978083/
