Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA08C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 20:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 229FF258D4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 20:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.b="vJ2ly/2/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 229FF258D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752733AbeGAU5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 16:57:32 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:53836 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752535AbeGAU52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 16:57:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Message-Id:Date:Subject:Cc:To:From:Sender:
        Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=vL0zSIuefsr+axgAw6y4nES0Np/wsCitjF58yF9hvNU=; b=vJ2ly/2/1u13bRipPFnLO9jl9W
        YLG9HomvGmLZtgijO4/iI07fe5EQP1vm2ci+XZZppr9zz+97mWWtf0fy4TjyWlV0XeFev88O2vkQ1
        Fh46tNuccOFzuMqnJtxhZYOeAz7UncVTNkwkGQ6IBqCnLiQgM8s4LxdnPy9noCb9pr3QJ5EYONSEw
        YInqa2nI2nCw4memcdttrM826AO8YAFLae5EtcAkMhj0aVK2AaN4hc1rIhHp88YdZANruAsTrvCby
        72lor3osUOT4f1Iw0jsTSVB0+2Ii2zXONiCyDl/77ZSwXdoPyvOBFfR9dvxHoM5GT6sO/+eq/5jh/
        zMiO116A==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:48692 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.89)
        (envelope-from <linux@roeck-us.net>)
        id 1fZjPS-007eCp-NC; Sun, 01 Jul 2018 20:57:27 +0000
From:   Guenter Roeck <linux@roeck-us.net>
To:     Chris Brannon <chris@the-brannons.com>
Cc:     devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kirk Reiser <kirk@reisers.ca>, linux-kernel@vger.kernel.org,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        speakup@linux-speakup.org, William Hubbs <w.d.hubbs@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] staging: speakup: Replace strncpy with memcpy
Date:   Sun,  1 Jul 2018 13:57:24 -0700
Message-Id: <1530478644-16857-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc 8.1.0 generates the following warnings.

drivers/staging/speakup/kobjects.c: In function 'punc_store':
drivers/staging/speakup/kobjects.c:522:2: warning:
	'strncpy' output truncated before terminating nul
	copying as many bytes from a string as its length
drivers/staging/speakup/kobjects.c:504:6: note: length computed here

drivers/staging/speakup/kobjects.c: In function 'synth_store':
drivers/staging/speakup/kobjects.c:391:2: warning:
	'strncpy' output truncated before terminating nul
	copying as many bytes from a string as its length
drivers/staging/speakup/kobjects.c:388:8: note: length computed here

Using strncpy() is indeed less than perfect since the length of data to
be copied has already been determined with strlen(). Replace strncpy()
with memcpy() to address the warning and optimize the code a little.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/staging/speakup/kobjects.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/speakup/kobjects.c b/drivers/staging/speakup/kobjects.c
index f1f90222186b..08f11cc17371 100644
--- a/drivers/staging/speakup/kobjects.c
+++ b/drivers/staging/speakup/kobjects.c
@@ -388,7 +388,7 @@ static ssize_t synth_store(struct kobject *kobj, struct kobj_attribute *attr,
 	len = strlen(buf);
 	if (len < 2 || len > 9)
 		return -EINVAL;
-	strncpy(new_synth_name, buf, len);
+	memcpy(new_synth_name, buf, len);
 	if (new_synth_name[len - 1] == '\n')
 		len--;
 	new_synth_name[len] = '\0';
@@ -519,7 +519,7 @@ static ssize_t punc_store(struct kobject *kobj, struct kobj_attribute *attr,
 		return -EINVAL;
 	}
 
-	strncpy(punc_buf, buf, x);
+	memcpy(punc_buf, buf, x);
 
 	while (x && punc_buf[x - 1] == '\n')
 		x--;
-- 
2.7.4

