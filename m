Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC65BC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 19:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C8A7206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 19:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbfBWTrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 14:47:39 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:55088 "EHLO
        hera.aquilenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbfBWTri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 14:47:38 -0500
X-Greylist: delayed 584 seconds by postgrey-1.27 at vger.kernel.org; Sat, 23 Feb 2019 14:47:37 EST
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id A17264A51;
        Sat, 23 Feb 2019 20:42:21 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id SzFUbgQzeP26; Sat, 23 Feb 2019 20:42:20 +0100 (CET)
Received: from function (dhcp-97-171.dsi-ext.ens-lyon.fr [140.77.97.171])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id B8A4F4A4B;
        Sat, 23 Feb 2019 20:42:20 +0100 (CET)
Received: from samy by function with local (Exim 4.92-RC6)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1gxdBj-0004d8-Rf; Sat, 23 Feb 2019 20:42:19 +0100
Date:   Sat, 23 Feb 2019 20:42:19 +0100
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     w.d.hubbs@gmail.com, chris@the-brannons.com, kirk@reisers.ca,
        gregkh@linuxfoundation.org, speakup@linux-speakup.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: Note that simple_strtoul can't simply be replaced
 by kstrtoul
Message-ID: <20190223194219.qxvi7cwfp3etqdfi@function>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        w.d.hubbs@gmail.com, chris@the-brannons.com, kirk@reisers.ca,
        gregkh@linuxfoundation.org, speakup@linux-speakup.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: I am not organized
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We often receive patches which erroneously try to use kstrtoul in these
places.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 drivers/staging/speakup/kobjects.c    |    2 ++
 drivers/staging/speakup/main.c        |    1 +
 drivers/staging/speakup/varhandlers.c |    1 +
 3 files changed, 4 insertions(+)

--- a/drivers/staging/speakup/kobjects.c
+++ b/drivers/staging/speakup/kobjects.c
@@ -154,6 +154,7 @@ static ssize_t chars_chartab_store(struc
 			continue;
 		}
 
+		/* Do not replace with kstrtoul: here we need temp to be updated */
 		index = simple_strtoul(cp, &temp, 10);
 		if (index > 255) {
 			rejected++;
@@ -787,6 +788,7 @@ static ssize_t message_store_helper(cons
 			continue;
 		}
 
+		/* Do not replace with kstrtoul: here we need temp to be updated */
 		index = simple_strtoul(cp, &temp, 10);
 
 		while ((temp < linefeed) && (*temp == ' ' || *temp == '\t'))
--- a/drivers/staging/speakup/main.c
+++ b/drivers/staging/speakup/main.c
@@ -1979,6 +1979,7 @@ oops:
 		return 1;
 	}
 
+	/* Do not replace with kstrtoul: here we need cp to be updated */
 	goto_pos = simple_strtoul(goto_buf, &cp, 10);
 
 	if (*cp == 'x') {
--- a/drivers/staging/speakup/varhandlers.c
+++ b/drivers/staging/speakup/varhandlers.c
@@ -328,6 +328,7 @@ char *spk_s2uchar(char *start, char *des
 {
 	int val;
 
+	/* Do not replace with kstrtoul: here we need start to be updated */
 	val = simple_strtoul(skip_spaces(start), &start, 10);
 	if (*start == ',')
 		start++;
