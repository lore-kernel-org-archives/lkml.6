Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7153BC6778C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DF2D24EA5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MhsWNS0B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DF2D24EA5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935614AbeF2SK4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 14:10:56 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:50427 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935178AbeF2SKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 14:10:55 -0400
Received: by mail-wm0-f43.google.com with SMTP id v25-v6so2084333wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 11:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=D9BluGmC3QDyQ72zz5xsYtX8ttzaa54autRrxRZ2oh4=;
        b=MhsWNS0B2ShFO6nbz73xpNwpQWmW2qKv2G8T6c5FR0Y7IJbSTcK0LaErJA6Xs9HUUG
         ZXd4Bedwhfu5mPtwa1KgDvKaJ+zkzaWRIM0AxzOJHxQRFYyQ4lwDebXyJq0oR3PZyJrV
         xGz6Gm+EVKe0DubKixvW7vK7ALNYy58F7q6XYyxa1mf/xmJfcF0b3Oi9vX/GthRC7gLJ
         AT1ipougmQDl0guTzL0yAVMYAROEwT8uJoUpJHn0JQTZV8PerCpkR/OFXR/GVLXqc2Qc
         eWqLeaMkBWIL6zIIGJ9af9lncuDqt4vRGOi1L3iX6xmjmdKFDcwy6SAtaNAZIGc1RmNG
         rBpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=D9BluGmC3QDyQ72zz5xsYtX8ttzaa54autRrxRZ2oh4=;
        b=WNvzw9BMNmN+KT3a+dGgiZmRUZ3CIasXgsW8iSx1eqH/QX4ldziM/3bFMrjw27gq/x
         5JUEpt58MDS0NCiUKZhR3yu8TARSh3PheDG2/vBOpwglXK3tMBsGt9uCkGSGdZSx3+QN
         ljJp3ycn3AG4DsUoco/hN7g0QX8e49WnGXRhqLGKKlbSjk4cum0WGetLyShbfIidfGv2
         zwdiM8fUp+ltx0NCGQQ2PmJ7YBlm7qJArHRKOVDCBud0F2ahaVSuG8+9hTpwDySp0/wL
         q51bQ9eFZ2VD4s3ktna0hZC7cKemn0s4zIITk0vqbyn9UwWxkXhtOTVCYaI1WOrwLRQ5
         I5/A==
X-Gm-Message-State: APt69E0vH+Lu0G5JEekIta3nAoRuozsUUSgbWk1YBJ3o8c5jq7wQwn2K
        QqzMD1LF0XPf6UE2JN7aeYc=
X-Google-Smtp-Source: AAOMgpchROOlBuo4PGb91Gpz9/0LmD+DZWoSm0LFEOlU+LYKMWn3NluLcaEBF+jD1V3a3Og3LcB97g==
X-Received: by 2002:a1c:e3d5:: with SMTP id a204-v6mr2442651wmh.20.1530295854455;
        Fri, 29 Jun 2018 11:10:54 -0700 (PDT)
Received: from localhost.localdomain (host81-152-164-58.range81-152.btcentralplus.com. [81.152.164.58])
        by smtp.gmail.com with ESMTPSA id t10-v6sm11071491wrq.74.2018.06.29.11.10.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jun 2018 11:10:53 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     devel@driverdev.osuosl.org
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org
Subject: staging: rtl8192u: RFC - harmonisation of rtl819x_HT.h ?
Date:   Fri, 29 Jun 2018 19:10:04 +0100
Message-Id: <20180629181007.18071-1-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set includes two fairly trivial patches but the third patch is
possibly controversial.

There are two files called rtl819x_HT.h

$ find -name rtl819x_HT.h -print
./drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
./drivers/staging/rtl8192e/rtl819x_HT.h

The two files are very similar but the rtl8192u file includes more, and I think
unused, definitions definitions. My, possibly flawed, thinking is that it
might be easier to maintain a single file if the two could be merged into a
single include file.

As a first step towards this my third patch comments out unused
definitions, from ./drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h

At this point I have compiled all c files under ./drivers/staging/rtl8192u and
all still compile. I may well have missed something, but I assume that no
source file outside that sub tree should be including header files from that
subtree.



