Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126EBC46460
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 12:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFFE92083E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 12:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IMzWYPaa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFFE92083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729269AbeHOPUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 11:20:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:41108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728810AbeHOPUe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 11:20:34 -0400
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8160920936;
        Wed, 15 Aug 2018 12:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534336114;
        bh=WB25Zy96CI7tsNORR1LIWT3BRQef+J5nxOwbhdmadYQ=;
        h=From:Date:Subject:To:Cc:From;
        b=IMzWYPaaV/Y+mh8GFHo3MeMzbeiboGijzdobFmYGIa5XpbqRswhnIRZFexHIV6R1C
         553B5wkeOAHdg70zLmk6ZEkWZuyvXgRRNwpXpYw1Pa+BB+AE3HqX/rHyjaA8sPYzQu
         TFDBYZgxq9rvfRJP3OSMjb3WJdHMBSrwD76PQNeQ=
Received: by mail-wr1-f54.google.com with SMTP id b15-v6so970425wrv.10;
        Wed, 15 Aug 2018 05:28:34 -0700 (PDT)
X-Gm-Message-State: AOUpUlE/ZGMkRoNoviLg3zPIEkxe1EGdykncfjmJiX/wL9GJyrp7oOp8
        YEQCGDdhREzseBqLBdD3SKGiODFWjCAKprKwL+s=
X-Google-Smtp-Source: AA+uWPx6oxoay4Wwnkdp9B3uf/6Stp9wNiB6cKu3WPi+/tm/vT9R1AjyUwmVcBdNti5TIVbjrDa/DClJLNRkoGMQSA8=
X-Received: by 2002:adf:cd0e:: with SMTP id w14-v6mr15835930wrm.226.1534336113032;
 Wed, 15 Aug 2018 05:28:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9141:0:0:0:0:0 with HTTP; Wed, 15 Aug 2018 05:28:32
 -0700 (PDT)
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 15 Aug 2018 14:28:32 +0200
X-Gmail-Original-Message-ID: <CAJKOXPc2cb1OK3tmRCO2p+docdXY=PoU1MEBa-VDyEM4mG1eSw@mail.gmail.com>
Message-ID: <CAJKOXPc2cb1OK3tmRCO2p+docdXY=PoU1MEBa-VDyEM4mG1eSw@mail.gmail.com>
Subject: [BUG][BISECT] NFSv4 root failures after "fs/locks: allow a lock
 request to block other requests."
To:     NeilBrown <neilb@suse.com>, Jeff Layton <jlayton@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Bisect pointed commit ce3147990450a68b3f549088b30f087742a08b5d
("fs/locks: allow a lock request to block other requests.") to failure
boot of NFSv4 with root on several boards.

Log is here:
https://krzk.eu/#/builders/21/builds/836/steps/12/logs/serial0

With several errors:
kernel BUG at ../fs/locks.c:336!
Unable to handle kernel NULL pointer dereference at virtual address 00000004

Configuration:
1. exynos_defconfig
2. Arch ARM Linux
3. Boards:
a. Odroid family (ARMv7, octa-core (Cortex-A7+A15), Exynos5422 SoC)
b. Toradex Colibri VF50 (ARMv7, UP, Cortex-A5)
4. Systemd: v236, 238
5. All boards boot from TFTP with NFS root (NFSv4)

On Colibri VF50 I got slightly different errors:
[   11.663204] Internal error: Oops - undefined instruction: 0 [#1] ARM
[   12.455273] Unable to handle kernel NULL pointer dereference at
virtual address 00000004
and only with some specific GCC (v6.3) or with other conditions which
I did not bisect yet. Maybe Colibri's failure is unrelated to that
commit.

Best regards,
Krzysztof
