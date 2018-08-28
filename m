Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BC2C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 11:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D51542087D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 11:30:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="bne9cCuv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D51542087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727293AbeH1PVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 11:21:12 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:36358 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbeH1PVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 11:21:12 -0400
Received: from localhost.localdomain (unknown [46.140.72.82])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 5EF915C2110;
        Tue, 28 Aug 2018 13:29:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1535455797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:content-type:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bZhK+GfD510TALc8szBmN9zu36vjs5HsQbSD9tYS/Gs=;
        b=bne9cCuvY9t1WUdedsLaanYjcgBXutORGbpnDlFI2ATYPNhtCwUv0Mw2qzD5iDIUqwLvOq
        PERKowJWKvC+IIfaPR7kJQGf3a6kxTi1MEwXJRQFJCvUcKvY7lla9GO9KzdT6MgERvvuwr
        p2rZzcf4FWbbUq5LmM3gLuSFfPsP2I8=
From:   Stefan Agner <stefan@agner.ch>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>, stable@vger.kernel.org
Subject: [PATCH] HID: input: fix leaking custom input node name
Date:   Tue, 28 Aug 2018 13:29:55 +0200
Message-Id: <20180828112955.11318-2-stefan@agner.ch>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180828112955.11318-1-stefan@agner.ch>
References: <20180828112955.11318-1-stefan@agner.ch>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure to free the custom input node name on disconnect.

Cc: stable@vger.kernel.org # v4.18+
Fixes: c554bb045511 ("HID: input: append a suffix matching the application")
Signed-off-by: Stefan Agner <stefan@agner.ch>
---
Found with kmemleak, after unplugging a Logitech Unifying receiver:

unreferenced object 0xc2345b80 (size 64):
  comm "kworker/0:1", pid 20, jiffies 4294955181 (age 320.740s)
  hex dump (first 32 bytes):
    4c 6f 67 69 74 65 63 68 20 55 53 42 20 52 65 63  Logitech USB Rec
    65 69 76 65 72 20 53 79 73 74 65 6d 20 43 6f 6e  eiver System Con
  backtrace:
    [<8fec5a71>] __kmalloc_track_caller+0x1dc/0x300
    [<5b926275>] kvasprintf+0x60/0xcc
    [<21fc360f>] kasprintf+0x38/0x54
    [<3b6ce9f0>] hidinput_connect+0x23a8/0x4c60
    [<deaab707>] hid_connect+0x30c/0x38c
    [<5a28f7c9>] hid_hw_start+0x44/0x64
    [<267d70e8>] hid_generic_probe+0x34/0x38
    [<d68c31b1>] hid_device_probe+0xdc/0x13c
    [<09414e91>] really_probe+0x1d8/0x2c4
    [<f9d7157f>] driver_probe_device+0x68/0x184
    [<1def17c8>] __device_attach_driver+0xa0/0xd4
    [<d3b2081b>] bus_for_each_drv+0x60/0xc0
    [<379d02f8>] __device_attach+0xdc/0x144
    [<7026ace5>] device_initial_probe+0x14/0x18
    [<44527d01>] bus_probe_device+0x90/0x98
    [<cf58bf2f>] device_add+0x424/0x62c

 drivers/hid/hid-input.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 4e94ea3e280a..ac201817a2dd 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -1815,6 +1815,7 @@ void hidinput_disconnect(struct hid_device *hid)
 			input_unregister_device(hidinput->input);
 		else
 			input_free_device(hidinput->input);
+		kfree(hidinput->name);
 		kfree(hidinput);
 	}
 
-- 
2.18.0

