Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 783DAECDFB8
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 18:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A1A320671
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 18:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="oKGxTHvA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A1A320671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730524AbeGVTFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 15:05:00 -0400
Received: from imap.thunk.org ([74.207.234.97]:43296 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730216AbeGVTFA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 15:05:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=uiQwpiPipQNn00Hc6E3FaJo8GjzLGwYRN6+PlJzJQnA=; b=oKGxTHvAMQvsBQEfMGo2MSyASZ
        AnNehA26o3FR3ecIeIjD5uity8y29OBJk99QQ9bg/H3Qwnf269OpWj6bjgFo42zWFNF0uONs/xpuU
        KY+ZnYE5oXL++nUUuHsSm5OFmwx2ovwd5dM0NNKjnT8Xb6iVYND9Jh9u8QsB6nHYHFMg=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1fhIlT-0003t0-BB; Sun, 22 Jul 2018 18:07:27 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id DD47F7A44CC; Sun, 22 Jul 2018 14:07:24 -0400 (EDT)
Date:   Sun, 22 Jul 2018 14:07:24 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     adilger.kernel@dilger.ca, jack@suse.cz, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, sirmy15@gmail.com,
        stable@vger.kernel.org, tgnottingham@gmail.com,
        y2038@lists.linaro.org
Subject: Re: [PATCH v2 3/6] ext4: use ktime_get_real_seconds for i_dtime
Message-ID: <20180722180724.GD6685@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Arnd Bergmann <arnd@arndb.de>, adilger.kernel@dilger.ca,
        jack@suse.cz, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, sirmy15@gmail.com,
        stable@vger.kernel.org, tgnottingham@gmail.com,
        y2038@lists.linaro.org
References: <20180711091414.1494843-1-arnd@arndb.de>
 <20180711091414.1494843-3-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711091414.1494843-3-arnd@arndb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 11:14:11AM +0200, Arnd Bergmann wrote:
> We only care about the low 32-bit for i_dtime as explained in commit
> b5f515735bea ("ext4: avoid Y2038 overflow in recently_deleted()"), so
> the use of get_seconds() is correct here, but that function is getting
> removed in the process of the y2038 fixes, so let's use the modern
> ktime_get_real_seconds() here.
> 
> Reviewed-by: Andreas Dilger <adilger@dilger.ca>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks, applied.

					- Ted
