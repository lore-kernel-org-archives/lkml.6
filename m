Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C8AC004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 17:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C10DB2075E
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 17:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EkBHRItn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C10DB2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbeJAADE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 20:03:04 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45447 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727470AbeJAADE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 20:03:04 -0400
Received: by mail-pg1-f195.google.com with SMTP id t70-v6so7777265pgd.12
        for <linux-kernel@vger.kernel.org>; Sun, 30 Sep 2018 10:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=WAunyad2hYiPm7SBDo+DgQ5AAUxOp3yK2rGHBDbdf8g=;
        b=EkBHRItnAyD6QM7othlKdg2ufXLB4fh1n7Rfb1kqnodqX6Y4ZF2DRkXGAFdejriypO
         8gEXLYwFHwDU6cyfEdwiFc3e/K2Tgj4brd4vcSitAF9Ssad9/lWDWDkxEVEOtMy7OyDF
         D0Th6NoLhWM4HPNMN0q20m1TsgHOOGG9U1qI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=WAunyad2hYiPm7SBDo+DgQ5AAUxOp3yK2rGHBDbdf8g=;
        b=EH9Q0N2sx5bvyM8Ap7hQEM7/xEdCfLmthryEuuf9MnsAvSKZCRgNyvyDRke8fcQLMf
         Fo/kVkqH7/93jcyczI3dcOFug2ls+tVQfjlt4al0xuXleEeCPqRTf2ln3Jd5aLxm1h0p
         qL8TGEjPCppyCMnkgiUIOcKsKJ0LdYXCpxh+aBFRSKbOzAQYKXQt9qPcQu177B5za6AG
         f24DrRTmvmdI/XpWsQPJ9ZVDyNFNMjr/QrxSLKoxBrfkBegB7Y5QTTv0HnBbucn7GPwA
         fvMPrMj/JxpEJ1p6M2yR7m3hjV8wk+36JI+UowArqNb+tuA40VEWVbc7oe5y+KAVGiRC
         sh1g==
X-Gm-Message-State: ABuFfog1eoBVbrnXuy+AFjQnDn10dIIkjCumO/O/OOhrExmbZ7DmmNqP
        hyYo36yRnLtoUtOO6Xr9r+erhg==
X-Google-Smtp-Source: ACcGV60We3eTvXbPkV7cOF9bz076qFqoWimCEj/aHrYOkAZt7IYmh8f3ZkPRae7HOG17mYDKe0gTSQ==
X-Received: by 2002:a62:fd06:: with SMTP id p6-v6mr7782906pfh.167.1538328550183;
        Sun, 30 Sep 2018 10:29:10 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id d18-v6sm22741833pfk.163.2018.09.30.10.29.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 30 Sep 2018 10:29:08 -0700 (PDT)
Date:   Sun, 30 Sep 2018 10:29:07 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Geliang Tang <geliangtang@gmail.com>,
        Joel Fernandes <joelaf@google.com>,
        nixiaoming <nixiaoming@huawei.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [GIT PULL] pstore fix for v4.19-rc7
Message-ID: <20180930172907.GA3543@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Please pull this pstore fix for v4.19-rc7.

Thanks!

-Kees

The following changes since commit 831b624df1b420c8f9281ed1307a8db23afb72df:

  pstore: Fix incorrect persistent ram buffer mapping (2018-09-13 09:14:57 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v4.19-rc7

for you to fetch changes up to bac6f6cda206ad7cbe0c73c35e494377ce9c4749:

  pstore/ram: Fix failure-path memory leak in ramoops_init (2018-09-30 10:15:41 -0700)

----------------------------------------------------------------
Fixes for v4.19-rc7

- Fix failure-path memory leak in ramoops_init (nixiaoming)

----------------------------------------------------------------
Kees Cook (1):
      pstore/ram: Fix failure-path memory leak in ramoops_init

 fs/pstore/ram.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

-- 
Kees Cook
Pixel Security
