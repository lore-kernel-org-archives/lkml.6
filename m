Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2413C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 19:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CCA82089D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 19:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hENaXsz5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CCA82089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbeJICcn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:32:43 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34027 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbeJICcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:32:42 -0400
Received: by mail-wr1-f67.google.com with SMTP id z4-v6so22014765wrb.1;
        Mon, 08 Oct 2018 12:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=iPTRjkroA9UcnU8hyWVSVT6bjQcx4Fc4C7CkWqK6PJs=;
        b=hENaXsz5W45l1odQKKJQlt+nduxx+mUuf9CNHFV6OA0h7pkzSTvNDOTGxu4BWQPnE2
         pLcVX/gfXjsaoy4zIfx5Z1OwgQ32l8XMDveRhKZvuBkKNib0ilTBYHFK7GbYuPo+THB9
         flnb9Jm1b9uXIxl5lLVuavmnEE/jPIDY2+6/7dYOuAWjgZApBDTi/l08b/G7okbcEj4Q
         8tvFJi7cCf5lppaFo8O1zWZKrBoYU78LIQNw9TE/lwXW5IgaVgmL0Z5OCQBppBcHOjSH
         1JNHDPotQQmvUBbFDCLo9IMWpDOo94aulQ7ppjLNLRM3hKBBlzZaPSkbxfRTg+ihMajx
         ukNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iPTRjkroA9UcnU8hyWVSVT6bjQcx4Fc4C7CkWqK6PJs=;
        b=r+NzNWHizS5QNv/2cgi8lhRHBJQJTfGj5ZsHXh2xOG5E5Ergmd2sX2d69b3M1rAOth
         fzv3ZamI+0iRDHNWCvimvLTVCCUKMhzFCrBxm6bt1XrrCek69EyCLEVvMfGX2L/VT8nf
         JZ+Xx7Aas/ay9uJoJDcSoy8UszGSbvUZR98GUWb7rJUTfobjhzpadxo08ZwhJvcJM66E
         KaoitOXBlsybEwY/1hVAmIuplROAtX6YGY+o+JTja6yvxYfx9ydJUG0doWnEt9Y/7j+T
         3GcRrdqTWj1TkONiejCA5Sw5v1xtJZA2dHZRPRyo0ovsa4kAeroDz4QN7vFSUeTkiZkb
         JOaQ==
X-Gm-Message-State: ABuFfoi1OSFC6SWaXqc/9VbRrmXpy9ci8SkJ5fd3TEnw0R+Q3cp0o2QM
        +sYe//Vfa87nZAFXgdGbX04=
X-Google-Smtp-Source: ACcGV62fR+Q+f2tFSA738RzG/B50gsVmYKmwvAtgT9MD7Q9c+TCZC66iHYOWDPZ3Gfg3a3exFTXSkQ==
X-Received: by 2002:adf:f5c6:: with SMTP id k6-v6mr17564202wrp.59.1539026365184;
        Mon, 08 Oct 2018 12:19:25 -0700 (PDT)
Received: from localhost.localdomain (cpc101300-bagu16-2-0-cust362.1-3.cable.virginm.net. [86.21.41.107])
        by smtp.gmail.com with ESMTPSA id t24-v6sm29292904wra.5.2018.10.08.12.19.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 12:19:24 -0700 (PDT)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
X-Google-Original-From: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
To:     Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        syzbot+600b03e0cf1b73bb23c4@syzkaller.appspotmail.com,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        stable <stable@vger.kernel.org>
Subject: [PATCH] usbip: vhci_hcd: check port number before using
Date:   Mon,  8 Oct 2018 20:19:13 +0100
Message-Id: <20181008191913.11527-1-sudip.mukherjee@codethink.co.uk>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>

The port number is checked and it just prints an error message but it
still continues to use the invalid port. And as a result it accesses
memory which is not its resulting in  BUG report from KASAN.

Reported-by: syzbot+600b03e0cf1b73bb23c4@syzkaller.appspotmail.com
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/usb/usbip/vhci_hcd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index d11f3f8dad40..71883aa788ac 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -334,8 +334,10 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 	usbip_dbg_vhci_rh("typeReq %x wValue %x wIndex %x\n", typeReq, wValue,
 			  wIndex);
 
-	if (wIndex > VHCI_HC_PORTS)
+	if (wIndex > VHCI_HC_PORTS) {
 		pr_err("invalid port number %d\n", wIndex);
+		return -ENODEV;
+	}
 	rhport = wIndex - 1;
 
 	vhci_hcd = hcd_to_vhci_hcd(hcd);
-- 
2.11.0

