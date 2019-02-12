Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 787E1C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AA8F222BE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UMnLqt3y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730837AbfBLSxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 13:53:38 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:49423 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727348AbfBLSxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 13:53:38 -0500
Received: by mail-pl1-f202.google.com with SMTP id w20so2828977ply.16
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 10:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=HJwoHH5upbv2k0JUlQRVkigDDTF/W2TuTsyV+nURors=;
        b=UMnLqt3yWYpqF9G1mhnJKpE9rpwQWYhpwrug9kt6e3nbE+srY0w+8Tb7e5gIpoJHJ4
         6G4fP/ezEL8bAEVuxssgc+tIQWviWGj0UZKlV9HvCDXJWmTheVc18OzlQW3ks1ENRBiW
         l6wyEJuvszteGAF8+VK60doB9p8xDAODJdAsk9oxAJIZNS82btQsGQyo/ufRpV5jZzwy
         1ZoCcsmXU/Noqgdx6qhuI5QaFDWF6o5JcPkm52gp5v2kZDbPvRLemkv7yCk8wzCbCTZB
         tGGmVy+InzfZ/LX/ye97jjPjmvlhUAL9jm/b9MyJ6RDqXhvz2dgB3nP5prad9eC+gIIG
         Vszg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=HJwoHH5upbv2k0JUlQRVkigDDTF/W2TuTsyV+nURors=;
        b=B3WihPc6l/CTzN356rKOgQ4ujhv0uOKLbtMg0nsYFPoN0X2BZ68BFT2vajAsrwSHsF
         cNv/BWtq2BxaW6CVRXfwwN5APZvhJRDouOynK1KzdfO/KbEhxLsjW155rEH7O6FLQv86
         IUsmM45tWdiN8JCGgbd1XN1VRFEat3WnWKiEl+NlntNMiGcIv1P6ovI94Csljtspzx4p
         lbOKKIfoQziWP/JWa5/TcgTpr2DFFILddFFq+pGd+5Hmzsb7CjCD4neuzfY7xqNodtck
         7QUqQQy6ptu+eiXaRKrn0y0O6GDxOQj6hDrYHmfpZupDUEPSb1MqNyg51hLWlh+PymPS
         pMTg==
X-Gm-Message-State: AHQUAubkyPjffNAoeDm5IB2ZD3aBh9/j9tGZ22bnfMAegdYeWgfffMeN
        SnbVdPmYeanZ+tWkC6wRociogAM6acIIhTGWgd5bgw==
X-Google-Smtp-Source: AHgI3IaiKXGbWYcmyoW9dSJ6dsLDxiyC4e7C6xLCZK69nCXS3ZspHLzPqNANqNu9SCyhSXeR8f6EzmmtoutXKTC6Pnwyiw==
X-Received: by 2002:aa7:8d54:: with SMTP id s20mr1881454pfe.78.1549997617696;
 Tue, 12 Feb 2019 10:53:37 -0800 (PST)
Date:   Tue, 12 Feb 2019 10:53:04 -0800
Message-Id: <20190212185305.112847-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.20.1.791.gb4d0f1c61a-goog
Subject: [PATCH v1 0/1] of: unittest: unflatten device tree on UML when testing
From:   Brendan Higgins <brendanhiggins@google.com>
To:     robh+dt@kernel.org, frowand.list@gmail.com, mcgrof@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set unflattens device trees when running DT's unittest. It is
a follow up to
https://www.spinics.net/lists/linux-kselftest/msg05454.html part of the
KUnit RFC v3 thread
(https://www.spinics.net/lists/linux-kselftest/msg05431.html). Rob asked
me to submit this patch separately along with some modifications.

-- 
2.20.1.791.gb4d0f1c61a-goog

