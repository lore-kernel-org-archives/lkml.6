Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78474C4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 15:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F116217CE
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 15:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CvvY/pM4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F116217CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728983AbeHDRFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 13:05:53 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35164 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbeHDRFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 13:05:52 -0400
Received: by mail-pg1-f193.google.com with SMTP id e6-v6so4232854pgv.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 Aug 2018 08:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=PUzmStxQVh3GuD1nWMsR8PqaxGgEFgEUHWgPmJ1e1j8=;
        b=CvvY/pM4z+W8XnpVIGpjhpTZLhftOCBotjPyPkjVyefh2rD0qS/5OMlPg/6bYBH+g2
         9zWoVPBNx7B0h80n5uerf0GBFDA2fvBq6AKUSqsRAbXYlJm5za/3zjnE3AOW5veN7Swh
         EjQU5/X3ah7eFucZpqaYKQ5dOwUiQOAYwON88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=PUzmStxQVh3GuD1nWMsR8PqaxGgEFgEUHWgPmJ1e1j8=;
        b=Fg7AlhlOEhDkCdllwZXbo68HgsKpCWVYtn2QZJ7V3EMCEMD5muS0G0JMdTi5vqjkKj
         lKyPVMm3sU6tr0fJoTToYbTWVgtYj19DrLeUIyWRPe2J/vnhac5wjGPNRc1CSzKPCm2p
         8J627Gzl6tGMTXnQSl5qxOGXvcFR88xXY9PX2OE0GbVnX8a5Ik7IzUdi30xKy+NeOdQS
         iG5lgEmFfXhckJPOlzoHm8y1p6rP7pwl3i0DGFuZ6vWB85mVvL9q8pQqYIEr1O1cev4y
         mOwXJvolAxtLZJD8mb52V5+bRafyi4AN+wOKrCjNli0U6Ehn/0rFV3kD3SGW6hVqIjAF
         CUbQ==
X-Gm-Message-State: AOUpUlEaa2Xz/GxAyzL7Y5Rkol/MeCSa/ZtcJYwofQZ23/rCdeaZzcDc
        aKyfpQBlHaFRfXSJaofznQLh3g==
X-Google-Smtp-Source: AAOMgpd4ULIsLjrSBsIEItfYVOOjGBzTK53OcRmxdrVXgboPoDUN1lAxBRxjb9ALQRFpiMtoNwDBJg==
X-Received: by 2002:a62:ea05:: with SMTP id t5-v6mr9373793pfh.228.1533395093846;
        Sat, 04 Aug 2018 08:04:53 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id v23-v6sm10027030pfm.80.2018.08.04.08.04.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 Aug 2018 08:04:52 -0700 (PDT)
Date:   Sat, 4 Aug 2018 08:04:51 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Bart Massey <bart.massey@gmail.com>,
        Dave Kleikamp <shaggy@kernel.org>,
        jfs-discussion@lists.sourceforge.net,
        Kees Cook <keescook@chromium.org>, stable@vger.kernel.org
Subject: [GIT PULL] usercopy fix for v4.18-rc8
Message-ID: <20180804150451.GA31926@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Please pull this usercopy fix for v4.18-rc8. Bart Massey discovered that
the usercopy whitelist for JFS was incomplete: the inline inode data may
intentionally "overflow" into the neighboring "extended area", so the
size of the whitelist needed to be raised to include the neighboring
field.

Thanks!

-Kees

The following changes since commit 7daf201d7fe8334e2d2364d4e8ed3394ec9af819:

  Linux 4.18-rc2 (2018-06-24 20:54:29 +0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/usercopy-fix-v4.18-rc8

for you to fetch changes up to 961b33c244e5ba1543ae26270a1ba29f29c2db83:

  jfs: Fix usercopy whitelist for inline inode data (2018-08-04 07:53:46 -0700)

----------------------------------------------------------------
- Fix JFS usercopy whitelist (it needed to cover neighboring field too) for
  "overflow" inline inode data.

----------------------------------------------------------------
Kees Cook (1):
      jfs: Fix usercopy whitelist for inline inode data

 fs/jfs/jfs_dinode.h | 7 +++++++
 fs/jfs/jfs_incore.h | 1 +
 fs/jfs/super.c      | 3 +--
 3 files changed, 9 insertions(+), 2 deletions(-)

-- 
Kees Cook
Pixel Security
