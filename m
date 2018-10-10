Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32472C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 17:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD7322075B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 17:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FjbTA0bC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD7322075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbeJKBMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 21:12:40 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41365 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbeJKBMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 21:12:40 -0400
Received: by mail-qt1-f193.google.com with SMTP id l41-v6so6666952qtl.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 10:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=nrQM7gD125wuE95kTqDbi4f/2bVNu42QG8B8d3KR0Zo=;
        b=FjbTA0bC16JTUkqpG6mVzAuo8ulChDRQnUahiSOsgWP408ynFucSWiwaWWeZ1fc+5O
         9UzFstUF0gl9StUqVjqwni+ias/mIovUKKem471fauxwWyUFsCFYpocRJmWGOouT742y
         1DKfCQLNLj7uFGYMePMj4Rmiumh0+foIpM36e6o40JTBnvmegrUfAEB5Fmbd3PmO/1vJ
         tWKI7hvrhgQoCOBPvPDJdDuJ7DSp/c9Ca4c5rgzRoD1/K2XJt+gga/17WMCyKSguiptC
         5cV/RSUJP8WEYUaA8+kHzI5PqIJSJyeizAk0+QfR1FaJpg9vfjT97lmjTJ4VAUCWPnQo
         aLkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=nrQM7gD125wuE95kTqDbi4f/2bVNu42QG8B8d3KR0Zo=;
        b=jyvF1BgzSbnMssZN3DDNFKdaxZ+VFo/Fh3Y+XcPdRrDkk3IhMxny3WQpnr5X/0jZ0p
         5ZXAUmtkfPGyWkohE2DxHt5dbkwAkac820/umvixMabXKL2gs45zge0F4suLQHGNcuor
         nxzSTDOtPHzljiqregQVmXwkFu5bY4NvjLCRQ4i5PufIIZ87nCfr/y/3Xs5FpmQj1Zpq
         7+z5DStPgutW+yLfZakjIy9UUogY5uFkupqnOeQ7YneOaNYq0Jm1RoEWRKhdz3dbCa1C
         OUvLiUuOaxH9D9G30svvUqAMeUbTisR9F1IX94Hmsnt6+sihHHNCNYBG+jyFYLAxMYDP
         +ZBg==
X-Gm-Message-State: ABuFfohzF1foiNkcTnOhJK8NjpPBJ7zBRsCQ/UdwvizUETgq18C95QvW
        UQ3p6pfxK6CEfMAoCNUXApzowDHt
X-Google-Smtp-Source: ACcGV60bBjQ2k4tAwO0N1Gs5Ggeo4TBv5eNSLBbg2KawoTvowsGKrFr3p29E2+XGiFVlC1/AI9PrAA==
X-Received: by 2002:ac8:1a95:: with SMTP id x21-v6mr28037045qtj.44.1539193766575;
        Wed, 10 Oct 2018 10:49:26 -0700 (PDT)
Received: from connor-Z97X-Gaming-7 ([2605:a000:1316:4273:f812:c27a:7560:4d6a])
        by smtp.gmail.com with ESMTPSA id d43-v6sm15653162qtd.69.2018.10.10.10.49.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 10:49:25 -0700 (PDT)
Date:   Wed, 10 Oct 2018 13:49:23 -0400
From:   Connor McAdams <conmanx360@gmail.com>
To:     linux-firmware@kernel.org
Cc:     tiwai@suse.de, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Additional firmware files for CA0132 HD-audio codec
Message-ID: <20181010174923.GA29921@connor-Z97X-Gaming-7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit c6b6265d718d118e28e1ce8f91769aa886b54c94:

  Merge tag 'iwlwifi-fw-2018-10-03' of git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/linux-firmware (2018-10-08 09:23:53 -0400)

are available in the git repository at:

  git@github.com:Conmanx360/linux-firmware.git 

for you to fetch changes up to cd8899323352e772c5989230f35b1c494e0ab196:

  linux-firmware: Add new firmware for Creative CA0132 HD-Audio Codec (2018-10-09 14:41:12 -0400)

----------------------------------------------------------------
These are additional firmware files for CA0132 based sound cards.

Creative has given me permission through email to send these to the 
linux-firmware repository under the same license as the previous ca0132 
firmware. I asked my contact if they would sign-off on it, but they said 
to go ahead and submit it and that if there was any issue to contact 
them. 

If you need to contact them, or if there's more info needed, let me know
and I can get see what I can do.
----------------------------------------------------------------
Connor McAdams (1):
      linux-firmware: Add new firmware for Creative CA0132 HD-Audio Codec

 WHENCE            |   2 ++
 ctefx-desktop.bin | Bin 0 -> 655856 bytes
 ctefx-r3di.bin    | Bin 0 -> 655816 bytes
 3 files changed, 2 insertions(+)
 create mode 100644 ctefx-desktop.bin
 create mode 100644 ctefx-r3di.bin
