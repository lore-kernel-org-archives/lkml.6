Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB0D0C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 704C72075C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="upPRvd23"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 704C72075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbeJIXGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 19:06:40 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35923 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeJIXGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 19:06:40 -0400
Received: by mail-wr1-f66.google.com with SMTP id y16so2382836wrw.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 08:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PYT7ztns/U3L8IYxdX/dLIMJfYFsd+gUlcvVbyL0sP0=;
        b=upPRvd23IlyvG2jlocu89zJPhA/HT0dLHBLwYlvxni1rzoT1uFQsFHCRdi81FcVrJR
         vq1A0kRGmHkdZylnPSAEyOQyNsmCPtuvkbWdA6imlg/BrDQjXqYzIFYS1UDNtG9GS8ns
         bG9Lli+eUu/tIOTIYuj49D0I9QN8P1+wCwNnNWewYoCaqQKgelN7ofPLy5ZIrMr4VsuV
         Zxw1SB2bRgFTTwYcCebn/1gWglcAAVySVsZ6iuqO89/hatZ9mjgIIlh9X0OETBf2n1yz
         KIqhjodigQD6n4R2mCz086lYYvgg0eohIKmr8+jAcncR6V2dW/nVpexdR1ohVsE12ndL
         eZeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PYT7ztns/U3L8IYxdX/dLIMJfYFsd+gUlcvVbyL0sP0=;
        b=TbxtDQWFaxERFpLsNvlsVAsPmDYnp8ZGrP+pyIhBEctQ47xF8ND1xe2CU1xxK3z3eZ
         y8gJ8610AHRlwH5GXyX9ny9WdryPM8W34IerfeQdwy4Leh2MN6QFAJ5y4vsfriAGo+tS
         t9vgyi3GXUIPppNSQm0F1acGhCvyLd9SXU2J1ZO2YR1zv5E4bamoSw3OW6iH3DghGIPF
         AXeb7/4pwPlhelV+iZjlVPr/DEf+tkieEJa1Pu7sbjeRm9vocHTa6pClIgiV1fljObPk
         L9iYwhogmC1SM9ECZTq0gDf1RdL22m973LNtdolgLd5ZzFMg8qtG+YUJRWJ7XJFfajdJ
         jlMQ==
X-Gm-Message-State: ABuFfojL3cGjdCB7BISK3wKZtj2iw8TYkBjAzBokZvogqrJuXY92OIEy
        aNHUNDuy69Ti00iZrTxYPwusdMw+
X-Google-Smtp-Source: ACcGV621c/lwrZ4AV4gRSgSVJv/ANN4jtxSBgtJBQtHS7dfEPrzinyJ2vdj3nROt09BTEKenjAysug==
X-Received: by 2002:a5d:44ce:: with SMTP id z14-v6mr16817596wrr.286.1539100145760;
        Tue, 09 Oct 2018 08:49:05 -0700 (PDT)
Received: from localhost.localdomain (ip1f12fa83.dynamic.kabel-deutschland.de. [31.18.250.131])
        by smtp.gmail.com with ESMTPSA id o130-v6sm10907338wmd.11.2018.10.09.08.49.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 08:49:05 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/4] staging: rtl8188eu: cleanup style issues in xmit_linux.c
Date:   Tue,  9 Oct 2018 17:48:50 +0200
Message-Id: <20181009154854.9054-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series clears most of the remaining style/checkpatch issues
in the file os_dep/xmit_linux.c.

Michael Straube (4):
  staging: rtl8188eu: use __func__ instead of hardcoded name - style
  staging: rtl8188eu: add spaces around operators - style
  staging: rtl8188eu: cleanup lines over 80 characters - style
  staging: rtl8188eu: remove whitespace - style

 drivers/staging/rtl8188eu/os_dep/xmit_linux.c | 45 ++++++++++++-------
 1 file changed, 28 insertions(+), 17 deletions(-)

-- 
2.19.1

