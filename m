Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85482C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 20:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 364CD2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 20:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EMIBqPpV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbfBUUhy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 15:37:54 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43672 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbfBUUhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 15:37:54 -0500
Received: by mail-wr1-f66.google.com with SMTP id d17so17657223wre.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 12:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HnzmDPtcjURgD+hzdrXywp23cP62YS0zTCKW3aPwYK0=;
        b=EMIBqPpVQua2nngFRnz0MXgL6SxhwaDVMqqojf5RlWJKf7+v6/AXQIln0b/XnA9FtF
         SPfnXFzlQytXdS2/qWWvL9TkVVtdQ7oX++VE+2uAaBdv0x376uK9F7tSdt6rYT3QcC15
         CyWUl9+z+FSN94zhyt/Vqj6vFJCYDrwZdQDYnggLbyrymfgQuXexqZZ4FOHgJZrWxnzc
         +vMdaNp5lVE3bOYTCd4y1RIBFEVjXK4Eu71F/PTo44o58NHZtnihXa3hjaKoLyhOKAh+
         GGGvqzTWMfkEcmgp0vceQ6sCBM4YkL76XFGXUGfDmCi9XNLnA6ZEcBzgHvH+VwE6C3eY
         xcFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HnzmDPtcjURgD+hzdrXywp23cP62YS0zTCKW3aPwYK0=;
        b=IMEv+rhjEtjHdliu0Pk9UyTw5bUMPkrI1+MUv/1Wk6032oU+RaA/ud5ZpJY9Vm0duQ
         GIRGQsGAUxVmmx66SjifnCJl5+KsbErhRHrpKVSb+rPwncYcNVO+4tGvd90WqWqZt4vu
         Ez2CFzcjZ3cqMQt/Ly5H2Jj8jxfyxzv7JcGGePm6iBYDCWs06xCZyez1KcV20o2pXfke
         nKpMUg07RKYGgSSWfsbC83Hr3jPKlsBgdGUYdguGub82bbERuh20vYihi5cAlSaFbdsP
         /bWZ/KL/LsMagcudFpu/9ghUhY5h3bpsFlHbeJNUWmsrOSCZro1YrS2NiCka+aceiZp+
         pjSA==
X-Gm-Message-State: AHQUAuZoL64CO9/7ZIQb3z02P0oMUr4a0COSjb+OO2HC5JSCZxZhuhxi
        nzleyt1nqkntnWYx6LqixDQ=
X-Google-Smtp-Source: AHgI3IaYP+wiUv/ELukbHODp5sJdW4priyGKWC0sp9nsJiG5DjDwyelbm9tb62OI3VMCTIrBm8TuwA==
X-Received: by 2002:adf:d845:: with SMTP id k5mr258445wrl.145.1550781472729;
        Thu, 21 Feb 2019 12:37:52 -0800 (PST)
Received: from Red.localdomain ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id l129sm6056714wml.42.2019.02.21.12.37.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 12:37:52 -0800 (PST)
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     bp@alien8.de, hpa@zytor.com, mingo@redhat.com, tglx@linutronix.de,
        x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, graysky@archlinux.us,
        Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: [PATCH RFC 0/1] x86: adds additional CPU options
Date:   Thu, 21 Feb 2019 21:32:08 +0100
Message-Id: <20190221203209.16224-1-clabbe.montjoie@gmail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

This patchset is a try to mainline a patch that lay around in
gentoo-kernel for at least 4 years.

The original work could be found at https://github.com/graysky2/kernel_gcc_patch

So I have worked on cleaning and removing unwanted additionnal changes from the
original intent.

Regards

Corentin Labbe (1):
  x86: adds additional CPU options

 arch/x86/Kconfig.cpu          | 172 ++++++++++++++++++++++++++++++++--
 arch/x86/Makefile             |  21 +++++
 arch/x86/Makefile_32.cpu      |  21 +++++
 arch/x86/include/asm/module.h |  42 +++++++++
 4 files changed, 250 insertions(+), 6 deletions(-)

-- 
2.19.2

