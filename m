Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11201ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 09:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8DFF20856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 09:34:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8DFF20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388409AbeGXKkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 06:40:14 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:46815 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388236AbeGXKkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 06:40:14 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue102 [212.227.15.145]) with ESMTPA (Nemesis) id
 0M2v1a-1fxdsb0Dhe-00sdHZ; Tue, 24 Jul 2018 11:34:35 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] fsi: master-ast-cf: use correct format string for size_t
Date:   Tue, 24 Jul 2018 11:34:16 +0200
Message-Id: <20180724093433.1623525-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:zLOTnETzJvCqIvVnyvBFNfJmu6irgFTX1fB7iM/ucDjU4/oDZdl
 EBY0g7WtK/QKdhCt+DOUHPSZoMnVzI7d7hRnzRz92XjASnAy6BmYJT+X9cQNTk4yWf31UZW
 d3Bnl4AGl0iQ+frL18AaxJpCyACLuwM/5cS3Q2ugSUJpQ3lSndfU7LSTIxTElHbFKmwoTBt
 CfVtmHkpXv2HWJRedIz3g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:aGGtW58ZOSM=:tnTVArzJci4gaKlVdO9jtP
 vhKVP22gReGj+tP2/W+6kTk1PkwG3o90mA2Nt7eSVthrOw7zCxunMiEcWyAMsApCvGuXzsuW0
 7ogBvfyGMjhox6MiIvD6q9vGk+ywPO9ubhITNhvsjYxRDDBFu5MgOXiC0XeUA0QHZPl3JrenE
 9QOEiqY3KNiq6jis3D/1nBHR2s/Z26jbcoaB0GGxookwDPh7oEiSr6RXYxmGyG5gGAfxp5zTH
 eUrsxadSIo8fWLSbAxvLyKZudnrahKmpQmwWzyKDy+wLusRCIYsnzKYcZZmEIosraI4QErN/B
 tLAlTXlbvynNEk6rfyUjYkQ/fMDH9DSTcF9MstVTEkXhzq0dravlOPGDlQnWM9Y+ofgMjsGqM
 9xkuir/j5khVdCek9fNLFJ/hN3uCWxdms+Z3++ykiHBtuAA4cfhxjsZY3oR/HMlLtfx9RU9kD
 z+PmPtSCph3XSjyU5QhX4tjdd8x37Lgt7KKxl9e8W6aiyE4bEbGSUr5yZNF6QqLEWeRh57nbv
 mKG5jTABt5PNowU/A+x+dQnUJYedSxWfJU8nU+n716WrcSOyka+ESqF5IpnMSg5mqy0RWHC4Q
 QfkQX7/VTRAlc8pBk1CfOFD1+KBs3IIgukoNc7fsY7vJMhTkEbj7e/VEkn5KKhs/YVR+jGn2p
 Kq0ybTAdb9E+0nbC4QIwhvhXOGfgSeZvFw5dztE8gLr9ZaD2caVScVYWBffHaPf+Bhq4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 32-bit targets, size_t is often 'unsigned int', so printing it as %lu
causes a warning:

drivers/fsi/fsi-master-ast-cf.c: In function 'fsi_master_acf_read':
drivers/fsi/fsi-master-ast-cf.c:609:23: error: format '%u' expects argument of type 'unsigned int', but argument 6 has type 'size_t' {aka 'long unsigned int'} [-Werror=format=]
  dev_dbg(master->dev, "read id %d addr %x size %ud\n", id, addr, size);
drivers/fsi/fsi-master-ast-cf.c: In function 'fsi_master_acf_write':
drivers/fsi/fsi-master-ast-cf.c:634:23: error: format '%u' expects argument of type 'unsigned int', but argument 6 has type 'size_t' {aka 'long unsigned int'} [-Werror=format=]

The correct format string is %zu.

Fixes: 6a794a27daca ("fsi: master-ast-cf: Add new FSI master using Aspeed ColdFire")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/fsi/fsi-master-ast-cf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/fsi/fsi-master-ast-cf.c b/drivers/fsi/fsi-master-ast-cf.c
index 57afaae0b691..d1bbdf8b8343 100644
--- a/drivers/fsi/fsi-master-ast-cf.c
+++ b/drivers/fsi/fsi-master-ast-cf.c
@@ -606,7 +606,7 @@ static int fsi_master_acf_read(struct fsi_master *_master, int link,
 		return -ENODEV;
 
 	mutex_lock(&master->lock);
-	dev_dbg(master->dev, "read id %d addr %x size %ud\n", id, addr, size);
+	dev_dbg(master->dev, "read id %d addr %x size %zu\n", id, addr, size);
 	build_ar_command(master, &cmd, id, addr, size, NULL);
 	rc = fsi_master_acf_xfer(master, id, &cmd, size, val);
 	last_address_update(master, id, rc == 0, addr);
@@ -631,7 +631,7 @@ static int fsi_master_acf_write(struct fsi_master *_master, int link,
 
 	mutex_lock(&master->lock);
 	build_ar_command(master, &cmd, id, addr, size, val);
-	dev_dbg(master->dev, "write id %d addr %x size %ud raw_data: %08x\n",
+	dev_dbg(master->dev, "write id %d addr %x size %zu raw_data: %08x\n",
 		id, addr, size, *(uint32_t *)val);
 	rc = fsi_master_acf_xfer(master, id, &cmd, 0, NULL);
 	last_address_update(master, id, rc == 0, addr);
-- 
2.18.0

