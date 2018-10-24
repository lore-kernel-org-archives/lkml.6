Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34010C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 13:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB7B12064A
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 13:02:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="CHM/48P3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB7B12064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbeJXVaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 17:30:17 -0400
Received: from imap.thunk.org ([74.207.234.97]:52602 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbeJXVaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 17:30:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ZKq6R/LjWHWPDMY1JM86dHiNsTbAIvbVtkgVr5qT1Mo=; b=CHM/48P3LFuo8TdMuO2vTRmZxM
        +DZ+kceZRtu8r4U/rRVMTJQ4lN7dkk293cGpSZEijI5YNy/PSMiUEsgPG+8txPFHR8rXosFXuQegO
        44t+jW0YV2fL+15euGKtUAeHHvl4a6Xv7lgUlhVx38ISL8YKFlfHTqe1ouUa6tAwaA7Y=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1gFInc-0007nf-CK; Wed, 24 Oct 2018 13:02:12 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 4DAF17A56C1; Wed, 24 Oct 2018 09:02:06 -0400 (EDT)
Date:   Wed, 24 Oct 2018 09:02:06 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        amir73il@gmail.com, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC][PATCH v3 01/10] fs: common implementation of file type
Message-ID: <20181024130206.GC11606@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Phillip Potter <phil@philpotter.co.uk>, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, amir73il@gmail.com,
        linux-fsdevel@vger.kernel.org
References: <20181023201953.GA15687@pathfinder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181023201953.GA15687@pathfinder>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 09:19:53PM +0100, Phillip Potter wrote:
> diff --git a/include/linux/file_type.h b/include/linux/file_type.h

Shouldn't this be in include/uapi/linux/fs_types.h?

One of things which must be made crystal clear is these definitions
MUST NOT ever change.  It would break the Userspace ABI, and would
break file systems on-disk format.

It might also be useful to be clear *why* we are making this change in
the first place.  Code refactorization is good from a code maintenance
perspective (either to fix bugs, although this code is pretty
trivial), or to make it easier to make changes in a single central
place (which MUST NOT) happen, or to make the compiled code more
compact.

So some documentation of how much text is actually saved might be
worthwhile.

						- Ted
