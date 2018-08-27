Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77DDC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 14:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73FB52087A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 14:54:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="AEjhaUPS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73FB52087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbeH0SlA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 14:41:00 -0400
Received: from imap.thunk.org ([74.207.234.97]:48554 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727005AbeH0SlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 14:41:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=qjM3kO2OydruLKPNdWoFUDH4AIjaw56WQT90mO97ayM=; b=AEjhaUPSPfNiu6EYlA+t0ccQLM
        o6aoKfKwPSfT+xiArrv7k1u8A5DKqX8/MnwwsJtfdoL26JtR7g8jU7wB45uqR3bETJ0idtHtbdWuw
        Ad93YJpfK3LucnOgZ86/aGn1jnNqliQUymVumsM8LF9tK2HAi24dksxNm2ctz2R2s+Ps=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1fuItt-0005u7-Ug; Mon, 27 Aug 2018 14:53:54 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id BA1237A4B74; Mon, 27 Aug 2018 10:53:52 -0400 (EDT)
Date:   Mon, 27 Aug 2018 10:53:52 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        will.deacon@arm.com, catalin.marinas@arm.com,
        herbert@gondor.apana.org.au, ebiggers@google.com,
        suzuki.poulose@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] arm64: wire CRC32 instructions into core crc32
 routines
Message-ID: <20180827145352.GF2311@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        will.deacon@arm.com, catalin.marinas@arm.com,
        herbert@gondor.apana.org.au, ebiggers@google.com,
        suzuki.poulose@arm.com, linux-kernel@vger.kernel.org
References: <20180827110245.14812-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180827110245.14812-1-ard.biesheuvel@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 01:02:41PM +0200, Ard Biesheuvel wrote:
> While this is not known to cause performance issues, calling a table based
> time variant implementation with a non-negligible D-cache footprint (8 KB)
> is wasteful in any case, and now that the crc32 instructions have been made
> mandatory in the architecture, let's wire them up into the core crc routines.

Stupid question --- are there any arm64 SOC's out there which do *not*
have the crc32 instructions?  Presumably there won't be in the future,
because it's now mandatory --- but where there any in the past?

	     	 	       	   	 - Ted
