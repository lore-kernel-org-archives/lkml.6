Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34780C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A840B2084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="hSRqRsze"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A840B2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731676AbeGSPFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 11:05:17 -0400
Received: from imap.thunk.org ([74.207.234.97]:33674 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727575AbeGSPFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 11:05:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=aO9pp5UDhzp+MnmYgQF+FElc/xFcpj+54fndI7BnxDU=; b=hSRqRsze6T3UnLZGOKgGZquv4V
        Gw6nDQ0RphS8WLVJ6EJn/MbcsmuwreIewzMI1NsB+fGtCLvwGDxA5J9pTWpNjEf5XEFHFurLF+a+2
        xqoPUWgevGCWrXcDWp8Dj/wMCQFMYmbdiY5ZOTClN0S8nX80fWojQ0kVQdG4tn6egMcA=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1fg9oV-0005LD-MJ; Thu, 19 Jul 2018 14:21:51 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id B5CBA7A6413; Thu, 19 Jul 2018 10:21:48 -0400 (EDT)
Date:   Thu, 19 Jul 2018 10:21:48 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Sandy Harris <sandyinchina@gmail.com>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Developers List <linux-kernel@vger.kernel.org>,
        labbott@redhat.com
Subject: Re: [PATCH] random: addu a config option to trust the CPU's hwrng
Message-ID: <20180719142148.GH30706@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Sandy Harris <sandyinchina@gmail.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Developers List <linux-kernel@vger.kernel.org>,
        labbott@redhat.com
References: <20180718014344.1309-1-tytso@mit.edu>
 <20180718015154.GE3489@thunk.org>
 <CACXcFmk7D5t9yg9VxhKZgMvqK-LmFF0d7Dh9A3hsoGTfzzeM8A@mail.gmail.com>
 <20180718173621.GC30706@thunk.org>
 <CACXcFm=URq_UnqdeEUAV0i6DSkvhE8VZW0KYcgQ=7601q_5NnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACXcFm=URq_UnqdeEUAV0i6DSkvhE8VZW0KYcgQ=7601q_5NnQ@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 04:22:35PM -0400, Sandy Harris wrote:
> 
> Yes & one of those can also solve any difficulty with random(4) at
> startup. Another alternative, perhaps easier on some systems, is
> Denker's Turbid trng:
> https://www.av8n.com/turbid/paper/turbid.htm

In the link above I saw breadboards with resistors plugged in,
alligator clips to TRG plugs, shield boxes with aluminum foil, and
doing calibrations using voltmeters.  While that induced a pleasant
flashback to my junior high days when I experimented with electronics,
I'm not entirely sure most sysadmins would call that "easy".  :-)

    		      	   	     	   	- Ted
