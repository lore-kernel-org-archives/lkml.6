Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A47A8C6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 18:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C83D20671
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 18:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="eV/jU3bV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C83D20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730440AbeGVTEK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 15:04:10 -0400
Received: from imap.thunk.org ([74.207.234.97]:43272 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730191AbeGVTEK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 15:04:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=oL5m2rY3awniYw4t/zciEU/5hqQsFAQS5pd2eQ1D32w=; b=eV/jU3bVKhF4OJhE3EmDRFQKb9
        aluX1nph2ZmG5pNT4TPaYrcyjTaCWBZwW0kEUgE+dzTLHZPETBbnY5b9BuBnmMef9kFY9aNWrgrPo
        aIh3EQ+Puct1dqNcXbIx5S4XCpoOfFT3aroOI4panPDBHF6XABHfff+84UVOgIrjROsQ=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1fhIke-0003sK-LE; Sun, 22 Jul 2018 18:06:37 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id E57717A44CC; Sun, 22 Jul 2018 14:06:33 -0400 (EDT)
Date:   Sun, 22 Jul 2018 14:06:33 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     adilger.kernel@dilger.ca, jack@suse.cz, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, sirmy15@gmail.com,
        stable@vger.kernel.org, tgnottingham@gmail.com,
        y2038@lists.linaro.org
Subject: Re: [PATCH v2 2/6] ext4: use 64-bit timestamps for mmp_time
Message-ID: <20180722180633.GC6685@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Arnd Bergmann <arnd@arndb.de>, adilger.kernel@dilger.ca,
        jack@suse.cz, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, sirmy15@gmail.com,
        stable@vger.kernel.org, tgnottingham@gmail.com,
        y2038@lists.linaro.org
References: <20180711091414.1494843-1-arnd@arndb.de>
 <20180711091414.1494843-2-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711091414.1494843-2-arnd@arndb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 11:14:10AM +0200, Arnd Bergmann wrote:
> The mmp_time field is 64 bits wide, which is good, but calling
> get_seconds() results in a 32-bit value on 32-bit architectures. Using
> ktime_get_real_seconds() instead returns 64 bits everywhere.
> 
> Reviewed-by: Andreas Dilger <adilger@dilger.ca>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks, applied.

					- Ted
