Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42803ECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 19:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D447320881
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 19:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Foi8Si0J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D447320881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbeIOAlw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 20:41:52 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42055 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbeIOAlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 20:41:52 -0400
Received: by mail-qk1-f194.google.com with SMTP id g13-v6so5774231qki.9;
        Fri, 14 Sep 2018 12:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=13iQW9tFAewDBjPPZfTZw/IlkIXBPEdmNnt5X6qQIzw=;
        b=Foi8Si0J+3yh8h3UUiK7mSdGGxVRVk5tPM4fNUWjKPs+eIFJZ56fq6nzHfEuf/ZP0H
         aiKqOB2+lNf1ATC0ENRNfI65c9aoFgcG1+k+6lRfB+c32I1DootRRpQrGDlnG4zfe5Xj
         d/evgGo9uqOiCZta8XbO70aZkEM9Sq6MkpgRcOYFCvCOlLuHn18c5kBcDZfREhKPOTTJ
         Is2FNVGkIAAk0CJkhMgZYE+2snD8xFhz3NxeWX+ZInDgc+0fWKLkVBuOhrVwqsfGSsi+
         oOs+WFREqQ7piXKaEnq5K+dw2d3hQXijeVrnFc04QoTrC1auSN4KU0bq0oB+vvsl+BP0
         YFHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=13iQW9tFAewDBjPPZfTZw/IlkIXBPEdmNnt5X6qQIzw=;
        b=JlfNJGpEQL0NwyJUXIKF1bANTlC5x2olAhD3pDOr8xrjlb0XzfxvIIQl413bN0yZlD
         Rv0DOSLydgPRNKdG+taR/Ydb1pVAlynKXHepRGBa0Ixc/oEAKnjNHQU93NEptKLt/e5E
         7ycu+g0eZdBullIAPiqHxlp6KD+YbrJCea6Z39F4PkNEt3T8PKzq6PVJX0sl3MsvpqJz
         sFrh0uIQ5Jwt7/OlTwV+p4W1tX1vIdll/u8yQAn9FFBn5JXYCoMgmJ4Us57suBGwzaF8
         jzhKqRAAuxc4F5A7fE2Luda4YfbvJRYVq1JVGPY94lngxkJKjC64HTaaWhRcgyiBbQ7k
         vZ7Q==
X-Gm-Message-State: APzg51DpnOiMK3WYnjMUTR7kaH20A/qLSDvlfuDZQu/qwq5NR6VDcNoi
        o1n7v8dPH87Qg3bVu+Eyn6ffriqPKm4YBDkHv4XrRJo=
X-Google-Smtp-Source: ANB0Vdbrh23kti29KpgPl8CeEiHLKUQGYvQgRb8/RMty2P0RpP433qHUYR88wDhtmM+yXHmxdNkTHhYtaxf7QrDtqqA=
X-Received: by 2002:a37:bec4:: with SMTP id o187-v6mr9547676qkf.326.1536953159802;
 Fri, 14 Sep 2018 12:25:59 -0700 (PDT)
MIME-Version: 1.0
From:   Rob Herring <robherring2@gmail.com>
Date:   Fri, 14 Sep 2018 14:25:48 -0500
Message-ID: <CAL_JsqJmyiAOAvEhWxBy11xw==m5kqg_V90CCLPV1PqGDuHD7w@mail.gmail.com>
Subject: [GIT PULL] Devicetree fix for 4.19-rc
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull. One regression for a 20 year old PowerMac.

Rob

The following changes since commit 0413bedabc886c3a56804d1c80a58e99077b1d91:

  of: Add device_type access helper functions (2018-08-31 08:30:42 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
tags/devicetree-fixes-for-4.19-2

for you to fetch changes up to e54192b48da75f025ae4b277925eaf6aca1d13bd:

  of: fix phandle cache creation for DTs with no phandles (2018-09-11
11:28:40 -0500)

----------------------------------------------------------------
Devicetree fixes for 4.19, part 2:

- Fix a regression on systems having a DT without any phandles which
  happens on a PowerMac G3.

----------------------------------------------------------------
Rob Herring (1):
      of: fix phandle cache creation for DTs with no phandles

 drivers/of/base.c | 3 +++
 1 file changed, 3 insertions(+)
