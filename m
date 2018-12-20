Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E56F4C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C034420811
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:18:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732961AbeLTQSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 11:18:34 -0500
Received: from verein.lst.de ([213.95.11.211]:54003 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732881AbeLTQSe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 11:18:34 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id DF2A568AA6; Thu, 20 Dec 2018 17:18:32 +0100 (CET)
Date:   Thu, 20 Dec 2018 17:18:32 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        kernel test robot <lkp@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>, lkp@01.org,
        linux-ide@vger.kernel.org
Subject: Re: [ide] ec7d9c9ce8:
 WARNING:at_fs/proc/generic.c:#remove_proc_entry
Message-ID: <20181220161832.GA19486@lst.de>
References: <20181220091931.zcibvplow3oxzacs@inn2.lkp.intel.com> <CAHk-=wjvxCn2uYp7USY5bbVuffJcugusxHc-RU7u5H1=ubMyPw@mail.gmail.com> <bd9cad88-08c6-ee65-abef-eaa8a4540019@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd9cad88-08c6-ee65-abef-eaa8a4540019@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 09:14:50AM -0700, Jens Axboe wrote:
> Maybe the the tiny subset of IDE users don't actually have the proc
> stuff enabled? A few months ago I did plenty of IDE testing with the
> MQ conversion, but I never saw anything like this. I'm guessing that
> I, too, did not have IDE_PROC_FS enabled.

Or the tiny subset of ide users basically doesn't exist and the
few platforms that use ide are basically bitrotting?

> Christoph, do you want to post the one-liner fix for this one?

See below:

--
From c3550c617ffc48079fe6364a4fa3c7f75a09028b Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Thu, 20 Dec 2018 17:16:53 +0100
Subject: ide: fix a typo in the settings proc file name

Fixes: ec7d9c9ce8 ("ide: replace ->proc_fops with ->proc_show")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/ide/ide-proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ide/ide-proc.c b/drivers/ide/ide-proc.c
index 45c997430332..0e51803de0e7 100644
--- a/drivers/ide/ide-proc.c
+++ b/drivers/ide/ide-proc.c
@@ -544,7 +544,7 @@ void ide_proc_port_register_devices(ide_hwif_t *hwif)
 		drive->proc = proc_mkdir(drive->name, parent);
 		if (drive->proc) {
 			ide_add_proc_entries(drive->proc, generic_drive_entries, drive);
-			proc_create_data("setting", S_IFREG|S_IRUSR|S_IWUSR,
+			proc_create_data("settings", S_IFREG|S_IRUSR|S_IWUSR,
 					drive->proc, &ide_settings_proc_fops,
 					drive);
 		}
-- 
2.19.2

