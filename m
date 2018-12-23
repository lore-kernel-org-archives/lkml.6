Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 499A9C43444
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 04:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03E5021917
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 04:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2IXd4ec"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725786AbeLWE6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 23:58:12 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:36872 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbeLWE6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 23:58:11 -0500
Received: by mail-it1-f196.google.com with SMTP id b5so11948611iti.2;
        Sat, 22 Dec 2018 20:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hdF8ugqool5/7m6T7Ru9/LvgWvMiths0KxMCiJxQh18=;
        b=T2IXd4ec316bMaxZrMZylztEvbIWSZwGaqqD8hau+vaEDcZWA5cNTXkYLfTOJECljB
         ymOj4ZbwZuM5+JbzAhYphzG/Fkx+F7NkWmLsNvw0R3tdTEw3wxtt8bgWTiWwgv7xfoZh
         ATgf1wjLbabJeQChwTvEOIiWscAa0eCw9zAtIhVET5U8AseDLPf9k9/oFESTKJLe48On
         CspXiA9CMzK1NRyeXF8mSdWG9kRWZUYAhRw7IKSnwhV0qpkBTJSDf9mwHlG4d/wPe4bw
         toj6WRVLE8MOyKnns9ASCKi+VXW7XO1cNkpmdKzMCL1nLTSQCTp6rcuxu4ZBdd4ihTTh
         VFWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hdF8ugqool5/7m6T7Ru9/LvgWvMiths0KxMCiJxQh18=;
        b=d4u7+T7ZP5h2M9T+wdzCC/hDCS40mykHOuWjvz7a5Vp9qjonLDxSX6VFyajYORtJHC
         Wyt53rw7EwpZD8bGsb1yquO69s93nWTBE/RIMzSXjDjGoatiVYevdCrcP1+ldDhaZIPu
         MXZNUiuDQKi2TfiUbeNEILqu35D19945YnjbZ2f1d+ui7+zu2wpzfHiMdTveaWhD+XOp
         1YHfaaMH8Y27DSh34+0NDOt0Vbr3hmDUhMLT1i1UTT3IiTPyTGSEAFG89rKf/FLIia1c
         uW7jdHVZMIUc8siIFYo5gLEqXoLekxUXaIlSUOEifFe8pnjrQtAa4HsYO3f5bFIAOkww
         f1Hg==
X-Gm-Message-State: AA+aEWa4653sNTBWDOBqrUUoA6ZRol4Sh6RR6gV9ITexiYg/rkTn1Iff
        YAoDSJ52o0SXoHiWxOqPiuc=
X-Google-Smtp-Source: AFSGD/UiE85174qgRU8jfccvRUWf7Dk0DHduRGrk2cJyVfgR4YG/ZVpI2Ag9lWX1C4mmI8tY+1AdEw==
X-Received: by 2002:a02:1217:: with SMTP id i23mr5772148jad.53.1545541091089;
        Sat, 22 Dec 2018 20:58:11 -0800 (PST)
Received: from r2700x.localdomain (c-75-70-96-103.hsd1.co.comcast.net. [75.70.96.103])
        by smtp.gmail.com with ESMTPSA id 15sm8435378itv.11.2018.12.22.20.58.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Dec 2018 20:58:10 -0800 (PST)
From:   Jeremy Fertic <jeremyfertic@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Jeremy Fertic <jeremyfertic@gmail.com>
Subject: [PATCH v2 0/4] staging: iio: adt7316: dac fixes
Date:   Sat, 22 Dec 2018 21:57:39 -0700
Message-Id: <20181223045743.10716-1-jeremyfertic@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v2:
 - Patches 1-2: reworded commit messages and added Fixes tags
 - Patches 3-4: added Fixes tags

Jeremy Fertic (4):
  staging: iio: adt7316: fix dac_bits assignment
  staging: iio: adt7316: fix handling of dac high resolution option
  staging: iio: adt7316: fix the dac read calculation
  staging: iio: adt7316: fix the dac write calculation

 drivers/staging/iio/addac/adt7316.c | 46 ++++++++++++++++++-----------
 1 file changed, 28 insertions(+), 18 deletions(-)

-- 
2.19.1

