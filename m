Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E77C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 20:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D93221850
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 20:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dZzjk32b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbfBZUJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 15:09:04 -0500
Received: from mail-pf1-f179.google.com ([209.85.210.179]:34472 "EHLO
        mail-pf1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727823AbfBZUJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 15:09:03 -0500
Received: by mail-pf1-f179.google.com with SMTP id u9so6768334pfn.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 12:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nvbgkBTzE6DW3B27GZ2U1P+7u2ZflsVz7nzJQehfxaw=;
        b=dZzjk32boKQzxt+8iYwyNhLx0GbuhTQlarOSfabMsUX4HLnCnd3/uNGmTlgwEzIU91
         q1qVgAH79q2yEbWaLjHzx3DypYDfcF+B9PEVCHr6fx/3ckkkvpGzPhuElls4rjxpxJn4
         Y2B0q5cxkuzF93XIQdunp9Q9qhKXxf1Y6xgos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nvbgkBTzE6DW3B27GZ2U1P+7u2ZflsVz7nzJQehfxaw=;
        b=AZ+DrGMMD4G3OrerzjONLGXlbHwhDRnTp1uNngkeY5WXicuyt/rySmrfckWO5Jqmjn
         8P1WwULLF3kpW7NIGVKY2Fdk5wxkQCmctiiD9vT5Ov1yNpBJ2LPYMuQdHUUzcmNAPeyg
         R6/OvIT3NUGKL9sS/tkyw5rBK9wRPiinYicCNkOky2/SB9ZnS30erocWkmTpnQHZn0d0
         jX/++zSi8ukPw0CAUSQd5F0zAjB0I4kerclSW2YiD75I4ck5M9U6S7OHTFnKSBF7lk3Z
         dqweQOQQUYxXq6SOUwXMKD+GW83g+rfsvYI5wGRr3do9Uhf0atoal+vejTF7RA4UiAPe
         ZfYQ==
X-Gm-Message-State: AHQUAuYjG2/1eARs8TnwGxLl6BhUVM8GDTl/idzKLeCIy0Vkgrau322l
        O67SDmPIvTXgSylYcYkZP5E2LA==
X-Google-Smtp-Source: AHgI3IaPcJW0xwH4ofnUwAazfJy53tdc2IvIYiCIrLYPmuHBQQftilvfFjHor3ogxZQYAOXNg2rRGQ==
X-Received: by 2002:aa7:8459:: with SMTP id r25mr25740935pfn.65.1551211743044;
        Tue, 26 Feb 2019 12:09:03 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id l5sm7637328pfi.97.2019.02.26.12.09.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 12:09:02 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Hemantg <hemantg@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 0/2] Reduce delay after sending baudrate request for WCN3990
Date:   Tue, 26 Feb 2019 12:08:46 -0800
Message-Id: <20190226200848.154216-1-mka@chromium.org>
X-Mailer: git-send-email 2.21.0.rc2.261.ga7da99ff1b-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current 300ms delay after a baudrate change is extremely long.
For WCM3990 it is sufficient to wait 10ms after the baudrate change
request has been sent over the wire.

Also use msleep() instead of a set_current_state() / schedule_timeout()
combo.

Matthias Kaehlcke (2):
  hci_qca: Use msleep() instead of open coding it
  hci_qca: Reduce delay after sending baudrate request for WCN3990

 drivers/bluetooth/hci_qca.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

-- 
2.21.0.rc2.261.ga7da99ff1b-goog

