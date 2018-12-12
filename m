Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EFFDC6783B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 02:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21F072086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 02:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FmEAbqg4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21F072086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbeLLCZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 21:25:15 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38812 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbeLLCZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 21:25:14 -0500
Received: by mail-pl1-f195.google.com with SMTP id e5so7843045plb.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 18:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gkM2LMK28Hlq7v76XW47vhgFUN/+gf7kIn3PtgabErI=;
        b=FmEAbqg4KNQLQeByZDCvzsT6ut2o5AZsmYaQ9FMbXhhZGH+5l7P4fH2UShyF7o+AVV
         g2dRivHygzpSbg3F4U/TquhpUN9or81zP+5J41j9TETRGc5d846AF++qlbKy/WCHx9P3
         bgM6M4dfr0XBq5KjCQOlyOdFa6fBFIDBTcatQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gkM2LMK28Hlq7v76XW47vhgFUN/+gf7kIn3PtgabErI=;
        b=HkWOcnp38o4mn98afbnnS/U129/fzPsxZsXCe2cdLC6DXdXStu0vrZs+MWJUPwZBLh
         +n5rGfezJqh6t8WpRQDK68xvnJ5R7lOpQrEJAcBw24b/iiue8tzo+i86E8eZohYvGWAD
         FyDKn9kvNsnvFKBpNsyqk9CCqL0qHO58mA13PlMNowjfsm3l2+1QEvpKMV1CYSaN8EJK
         BnJNSVN/1Y+aehoPT2tYZgxAvhWifXVV8lveNXpzZxn/JP6pCfba0xWB4iwmiKe91iZG
         1143vbm+7VD7OqfhCVFBuDqOX1MbARpD46aPPwka8h/2weR3W5BE7JAnveRfFD7lGhWf
         Uufw==
X-Gm-Message-State: AA+aEWarrypW4SNIcLIXmlg+IZWJfIErzAAsnSxvH9T0M0lxcUUr9xbN
        WSCPQTSW30b0cUZwbwc9WaHB5w==
X-Google-Smtp-Source: AFSGD/UAfDHtvi8tufhxzGnl2O4w7gDxpxMY3kx007mZWxPaUVEq7VA1NY+CbYoa4lhiT4t9uN3N7A==
X-Received: by 2002:a17:902:e085:: with SMTP id cb5mr17996885plb.24.1544581514151;
        Tue, 11 Dec 2018 18:25:14 -0800 (PST)
Received: from exogeni.mtv.corp.google.com ([2620:15c:202:1:db8d:8e3f:2514:5db8])
        by smtp.gmail.com with ESMTPSA id f6sm27334649pfg.188.2018.12.11.18.25.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 18:25:13 -0800 (PST)
From:   Derek Basehore <dbasehore@chromium.org>
To:     peterz@infradead.org
Cc:     mingo@redhat.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org,
        Derek Basehore <dbasehore@chromium.org>
Subject: RFC [PATCH 0/1] Fix lockdep false positive
Date:   Tue, 11 Dec 2018 18:25:05 -0800
Message-Id: <20181212022506.171936-1-dbasehore@chromium.org>
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not sure if I'm breaking any detection with this patch since I
haven't looked at that lockdep code before. I do know that the unlock
order for locks with a nest lock should not matter, though.
Specifically, you should be able to unlock the nest lock followed by
all the locks nested underneath it.

Derek Basehore (1):
  locking/lockdep: Fix nest lock warning on unlock

 kernel/locking/lockdep.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

-- 
2.20.0.rc2.403.gdbc3b29805-goog

