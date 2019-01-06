Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABEAC43444
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 14:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD3FC20868
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 14:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="BAUPshj0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbfAFOF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 09:05:57 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40746 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfAFOF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 09:05:56 -0500
Received: by mail-ed1-f66.google.com with SMTP id g22so35566408edr.7
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jan 2019 06:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e6QU/PQs0l/OA4RivYh/2wtM4nZle2KqgbuMss390lU=;
        b=BAUPshj0imVqk6hZ42tteGX2xX3G0/5p78ACQY/cbxuNF1WPPP7jFgpLA1x13XbTrL
         //sX8QbY/i1SUfDR+CyHP1wTG8RkCvdpEF6dwZTDggtwM2Hvj8VTpD3ivPDF/CtEWnYo
         eJrxxiJ2mhJLKECyRNbMguX63JF1fQqCt6TDxwgPoWTo2kkZp4H7U08cwvlvMo6o2fis
         dLZRtu0OK8l+6UHivYFJk5rSXc8VEr5xtpCoIzqk7g6eZyNYaNhilBNepbiXf4i0bjAw
         6L0Mx89fUwtJKCAXaQn2DH+7J4VoNEcj67Ug0KJg9PqrLiXkf6Jtpi+1YFFAFFLFVVwU
         rXkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e6QU/PQs0l/OA4RivYh/2wtM4nZle2KqgbuMss390lU=;
        b=Fp6Hl9oTGpOEgnA3SHWOvZofzyCEGRmula1VqNd5ursAiD+F7kWfr4iduO5GGPK/zl
         kJrDuDR6WgYxSpSdLv4UQ7L3+G4lDKgBv37fixkuVGeLL/JUvrnXDWNBkDj/6gwm/Mw5
         +TySkPsm8Km5Ve/Q4L8oUBX6yKe9KQpFHm6HQgNx9q7P6Km4uhbnU3WUy4orPiltNGJJ
         z9CVi2QWGM5C12rzxzl7xPhvrKqHhjN6vdFUO93rknNFbEsYzecqMX1IUPGHxiIs5S4+
         IaOX/H++QuYXyrDxm4kHpSMUDK1qTAKpvZV179SnUoixneQRY8QEMlRou78oCaJDRNsp
         zkDg==
X-Gm-Message-State: AA+aEWZkntLIqSmB2cIXBcEkHc3ltNkDmd5LVZrXtcLCvnh1UhDEoxZ8
        n+x59BycceOcDzf3jRWHN65jRw==
X-Google-Smtp-Source: AFSGD/U1lTpq1vwM4nVcLPdAJePzIt+IAjzh656854huUez77KtcTTxoYF5tFlgLesaiHnv1Q4j9Fw==
X-Received: by 2002:a50:c2d9:: with SMTP id u25mr53458989edf.280.1546783554913;
        Sun, 06 Jan 2019 06:05:54 -0800 (PST)
Received: from localhost.localdomain ([2a02:8109:b6c0:d6c:9810:663f:f898:8929])
        by smtp.gmail.com with ESMTPSA id m13sm26984984edd.2.2019.01.06.06.05.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Jan 2019 06:05:53 -0800 (PST)
From:   Christian Brauner <christian@brauner.io>
To:     gregkh@linuxfoundation.org, tkjos@android.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     arve@android.com, maco@android.com, joel@joelfernandes.org,
        tkjos@google.com, Christian Brauner <christian@brauner.io>
Subject: [PATCH 0/2] binderfs: fixes
Date:   Sun,  6 Jan 2019 15:05:39 +0100
Message-Id: <20190106140541.16442-1-christian@brauner.io>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

This small series deals with two fix/improvements for binderfs. And both
actually allows us to remove code. *Yay!*

The first patch removes an unneeded and conceptually wrong kern_mount()
call for binderfs. I think this even might have been pointed out at some
point by Greg. I'm not sure right now.

The second patch makes each mount of binderfs - similar to kdbusfs - a
new instance. This mainly allows users to get private binderfs instances
in the same ipc namespace which has been requested recently and makes
the whole implementation more intuitive and simple for various reaons.

More details can be found in the commit message for each patch.

Thanks!
Christian

Christian Brauner (2):
  binderfs: remove wrong kern_mount() call
  binderfs: make each binderfs mount a new instance

 drivers/android/binderfs.c | 51 ++------------------------------------
 1 file changed, 2 insertions(+), 49 deletions(-)

-- 
2.19.1

