Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01838C07E85
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 01:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF13E20857
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 01:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ro/zkONN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF13E20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbeLHBrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 20:47:46 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42764 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbeLHBrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 20:47:46 -0500
Received: by mail-qk1-f195.google.com with SMTP id w12so3542994qkb.9
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 17:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t7b8Bxr5QJZOiP+IDW2Va/rBX7gIBbm/bGGiSnBC59Y=;
        b=Ro/zkONNewGlKFqJ3nKD2cTxysPzgCkeTxJQHFzek9HLvC8+2T9wjsgsKue69zAQIO
         P2bWLkgWo2Y+8BXdNOXMWgq19FszUIySDF7d+G5cNSDwEm7+5OplQb5jucq9ILjClnjU
         GMlh3dLM3VxKs9q6a5jr4n+Qqxl2BHSpW+U9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t7b8Bxr5QJZOiP+IDW2Va/rBX7gIBbm/bGGiSnBC59Y=;
        b=X/oPimDPahPhnq1SBtHx4xrAXAPJ+X6Bq28hV5kny9K0xyJAf3iwsVLdPIhjS9DcJb
         R3+dRyot0idhTlnj+p6RZERs0KwlcwdyjrU7NXRyCNNJDpC2OlZkqwa12gE7mcZWiApv
         kD46RuYvxp8DgmeYf9oIjkPnsIQiFF+eXJVPXxaR2WAbSIJ88iKK33qB9LqPLjIT9Quc
         93vnQSrGZf/ka3b14akdtCeBMomvrQzja34UzAeBpzBVt61tFf1ohZ6C8cc2m0VRaMU3
         eKKXgv9asa3mqcaSYQTK85xVUHNhwHZg3V9wB9LOmxjIhWEzzE6+Rh5ZQqH30Iv87p2U
         DTIA==
X-Gm-Message-State: AA+aEWYkmPUyi0OhTyljTdnaSX2xvkglnoJPa0Ya+fU/ZGUsLic+K9fK
        mVb//9swEXOxB//fLWjnMnzkBIXkjcggpA==
X-Google-Smtp-Source: AFSGD/XHunHnwN1iktxHOzt6cTHsZT8nCUCXH5vUSDpgzSe+WS1iSt2Aisnc2yfDZACpxl+HU+PQPw==
X-Received: by 2002:a37:cf9b:: with SMTP id v27mr3819439qkl.160.1544233664272;
        Fri, 07 Dec 2018 17:47:44 -0800 (PST)
Received: from kdgwill07.nyc.corp.google.com ([2620:0:1003:510:59af:10e9:2d49:6b0a])
        by smtp.googlemail.com with ESMTPSA id 94sm5604597qks.8.2018.12.07.17.47.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 17:47:43 -0800 (PST)
From:   Kyle Williams <kdgwill@chromium.org>
X-Google-Original-From: Kyle Williams <kdgwill@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     kdgwill@chromium.org, Kyle Williams <kdgwill@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Jon Flatley <jflat@chromium.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        linux-usb@vger.kernel.org
Subject: [PATCH v3 0/2] Disable LPM by matching interface
Date:   Fri,  7 Dec 2018 20:47:20 -0500
Message-Id: <20181208014724.951-1-kdgwill@google.com>
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
In-Reply-To: <20181205093902.GA18633@kroah.com>
References: <20181205093902.GA18633@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v3:
- seperated work to allow matched interfaces to use the
USB_QUIRK_NO_LPM quirk to affect a broader range of devices instead of
setting each device individually

Kyle Williams (2):
  USB: quirks: Check device interface LPM capability
  USB: quirks: Disable LPM for Logitech UVC devices

 drivers/usb/core/hub.c    | 87 +++++++++++++++++++++------------------
 drivers/usb/core/quirks.c |  2 +-
 2 files changed, 49 insertions(+), 40 deletions(-)

-- 
2.20.0.rc2.403.gdbc3b29805-goog

