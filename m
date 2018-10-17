Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA65ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB441205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TY6WQW7u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB441205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbeJQWUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 18:20:42 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41255 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbeJQWUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 18:20:42 -0400
Received: by mail-pl1-f195.google.com with SMTP id q17-v6so12780816plr.8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 07:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2m3tQ2jgp3Y3GTzokyylwNVaTTLXaIK5EVimYQaLVcE=;
        b=TY6WQW7upw9SIYkjNCTKZwTlxickWxWUNm7rB+eRnBvq+lvPwJ7wl+LPN+KddZ/JUG
         JGB4q9A5X5bZsLE2yCKGW8NaoYWvaFkA2eLoTHqf86eK8uEJUSPDqtEPN7Y12HPMBcqR
         PAWP9iSQAR2RFfRMNlGkWIbXz4q3HgaGs+oEaZW+FRDABM3VGzjqdtpgGTJrvBzyfNIW
         pMSoUW3Jswb6I+iyPLNGCbuNP3F7wSVKNA3X0ertZbQcqbPkjHCYxNBJYxIsgcmF8qiY
         AEv6oviqqcrjda6P0NhO1Vbn2Cr4n2Mjcj/tHmCZ6Sd6nKEPepoIUX/dcCohuP6nhmDR
         200w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2m3tQ2jgp3Y3GTzokyylwNVaTTLXaIK5EVimYQaLVcE=;
        b=FAuDFzuo1WVNHpo6i6ygAjSiqle4odS0zcG8g93CoFydfoZcGMHVzELSaAKs6ua1Gr
         y3P/QRSw8IOReL5fUZt9INKC15lQohSzjRwgnfiT4JLL7RR5HIwfDwhxa1zpfyNWpD9U
         tq8DdM7IDjRJqIPlHZebnBMOFe1KiPFrgaHHVPqywjv7yTNO2xplAJL+szedUGc3dsuj
         8xGcyjH4a5IIEYF9i70nwsebr87MAnDOLadl++b6qrFazs8pSym0KBSYUXHWEm07AtYM
         bhle/9eO2jbTBp22e0japcJCDTjzzTb5CYiaiUt0mQKmbw3gAz1+yK2FDAlVl+j6nuXV
         UmrA==
X-Gm-Message-State: ABuFfohgAvrSy4hKC8GNoO0s1PLa+RaGa41skIOGOL7aF+UOImuS1YAU
        yUme3mRAyRPgdWXwduUGgMo=
X-Google-Smtp-Source: ACcGV60szTXOH09YxtritUAaf30+f81QbABf3QWghBqBPpZ1rt8WDSd1q8HxbjRxFFiUfjMYFxoyCQ==
X-Received: by 2002:a17:902:9:: with SMTP id 9-v6mr26115438pla.293.1539786286440;
        Wed, 17 Oct 2018 07:24:46 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:6001:4ff6:5400:1ff:feb7:a195])
        by smtp.gmail.com with ESMTPSA id x23-v6sm20440442pfh.56.2018.10.17.07.24.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 07:24:45 -0700 (PDT)
From:   Du Changbin <changbin.du@gmail.com>
To:     jan.kiszka@siemens.com, kbingham@kernel.org
Cc:     linux-kernel@vger.kernel.org, Du Changbin <changbin.du@gmail.com>
Subject: [PATCH v3] scripts/gdb: fix lx-version
Date:   Wed, 17 Oct 2018 14:24:42 +0000
Message-Id: <20181017142442.7818-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For current gdb version (has tested with 7.3 and 8.1), 'lx-version'
only prints one character.
(gdb) lx-version
L(gdb)

This can be fixed by casting 'linux_banner' as (char *).
(gdb) lx-version
Linux version 4.19.0-rc1+ (changbin@acer) (gcc version 7.3.0 (Ubuntu 7.3.0-16ubuntu3)) #21 SMP Sat Sep 1 21:43:30 CST 2018

Signed-off-by: Du Changbin <changbin.du@gmail.com>
---
 scripts/gdb/linux/proc.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/gdb/linux/proc.py b/scripts/gdb/linux/proc.py
index 086d27223c0c..0aebd7565b03 100644
--- a/scripts/gdb/linux/proc.py
+++ b/scripts/gdb/linux/proc.py
@@ -41,7 +41,7 @@ class LxVersion(gdb.Command):
 
     def invoke(self, arg, from_tty):
         # linux_banner should contain a newline
-        gdb.write(gdb.parse_and_eval("linux_banner").string())
+        gdb.write(gdb.parse_and_eval("(char *)linux_banner").string())
 
 LxVersion()
 
-- 
2.17.1

