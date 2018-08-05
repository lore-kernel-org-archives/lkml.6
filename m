Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A269C4646D
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 00:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F7C5217CE
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 00:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="sHJQyFvw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F7C5217CE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730281AbeHECbf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 22:31:35 -0400
Received: from imap.thunk.org ([74.207.234.97]:38164 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726961AbeHECbe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 22:31:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=0zFRMgVx8te6q6ClXPlkrAMTeax4v8gAm1+qcmOr14Y=; b=sHJQyFvwUCeU5DjSiLl3rueZ/H
        Q1/5jocBA1CEtHisIUvyEToeyKct9f8KnphA0xpcaL0Rrz4pJSpJ0TwYOkwZUzphmgc2nggZH1zs8
        +ozANyOqAZbRB/pMgikbTNeG1B5Uw8/N9COwmpI/bhZfMJzUK4BcF6trzC1unTLX86T8=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1fm6uq-0003Q5-4S; Sun, 05 Aug 2018 00:29:00 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 3FC927A64C9; Sat,  4 Aug 2018 20:28:59 -0400 (EDT)
Date:   Sat, 4 Aug 2018 20:28:59 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Pavel Machek <pavel@ucw.cz>, Yann Droneaud <ydroneaud@opteya.com>,
        linux-crypto@vger.kernel.org,
        Linux Kernel Developers List <linux-kernel@vger.kernel.org>,
        labbott@redhat.com
Subject: Re: [PATCH] random: add a config option to trust the CPU's hwrng
Message-ID: <20180805002859.GG4461@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Pavel Machek <pavel@ucw.cz>, Yann Droneaud <ydroneaud@opteya.com>,
        linux-crypto@vger.kernel.org,
        Linux Kernel Developers List <linux-kernel@vger.kernel.org>,
        labbott@redhat.com
References: <20180718014344.1309-1-tytso@mit.edu>
 <37046662f2b38f98854abfa1b5868a27c3fa0888.camel@opteya.com>
 <20180718142625.GA5942@thunk.org>
 <20180804215209.GA3201@localhost>
 <20180805002514.GF4461@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180805002514.GF4461@thunk.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 04, 2018 at 08:25:14PM -0400, Theodore Y. Ts'o wrote:
> Depending on your hardware, no mouse motion might be necessary at all.
> On my laptop (a Dell XPS 13 model 9370) using an dm-crypt protected
> root disk, and running a Debian testing userspace, with a 4.18-rc6
> based kernel, the "CRNG is initialized" message is printed *before*
> the root file system is mounted.

Sorry, correction.  It's printed *before* the root file system is
remounted read/write.  (Which means before we can generate long-term
public keys and save them to the file system.)

						- Ted
