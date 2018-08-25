Return-Path: <SRS0=itv6=LI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3AC5C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 03:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ED6920693
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 03:46:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="D3qiR4aa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ED6920693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbeHYHXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Aug 2018 03:23:23 -0400
Received: from imap.thunk.org ([74.207.234.97]:43910 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbeHYHXX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Aug 2018 03:23:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=lpXl9X0ZtSaAWYW6meMs1UyaWkc3cpM8oDXiYjyLPl8=; b=D3qiR4aa0lRRaZD8VOe90yVyAp
        wWT7c8ZqgR9o+jDNUgru8s24TT9zsddIEY0nJuW94WJCe0r5q/ET+ByxsVMOu7hZL1IaQJ3obVmKl
        CPlErVzCjIv/p+BHtoGruVm7lGcQhyd+PVD2Mt+4gBDo+XI1ZQCZTSpfGjnEaBEvjj+8=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1ftPWF-0007Vl-2C; Sat, 25 Aug 2018 03:45:47 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 452027A57A9; Fri, 24 Aug 2018 23:45:44 -0400 (EDT)
Date:   Fri, 24 Aug 2018 23:45:44 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Michael Halcrow <mhalcrow@google.com>,
        linux-kernel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Victor Hsieh <victorhsieh@google.com>
Subject: Re: [f2fs-dev] [RFC PATCH 02/10] fs-verity: add data verification
 hooks for ->readpages()
Message-ID: <20180825034544.GA5281@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Gao Xiang <gaoxiang25@huawei.com>,
        Eric Biggers <ebiggers@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Michael Halcrow <mhalcrow@google.com>, linux-kernel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Victor Hsieh <victorhsieh@google.com>
References: <20180824161642.1144-1-ebiggers@kernel.org>
 <20180824161642.1144-3-ebiggers@kernel.org>
 <2f2382c3-e5e9-f0da-dc89-42dfc7b2b636@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f2382c3-e5e9-f0da-dc89-42dfc7b2b636@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 25, 2018 at 10:29:26AM +0800, Gao Xiang wrote:
> 
> My first question is that 'Is there any way to skip to verify pages in a bio?'
> I am thinking about
> If metadata and data page are mixed in a filesystem of such kind, they could submit together in a bio, but metadata could be unsuitable for such kind of verification.
> 
> The second question is related to the first question --- 'Is there any way to verify a partial page?'
> Take scalability into consideration, some files could be totally inlined or partially inlined in metadata.
> Is there any way to deal with them in per-file approach? at least --- support for the interface?

A requirement of both fscrypt and fsverity is that is that block size
== page size, and that all data is stored in blocks.  Inline data is
not supported.

The files that are intended for use with fsverity are large files
(such as APK files), so optimizing for files smaller than a block was
not a design goal.

					- Ted
