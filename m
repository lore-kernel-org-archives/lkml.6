Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA9BC6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B597D21486
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789854;
	bh=SdV9NNZS/m+XbuYDw5ETSaaa7EmM82UzFlVTH+NeHns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BgrThm4yWkF+FT9DpbE1BTgIyl4NFkma0lYI9OhtyWI2hyAjTJqW+xkjdazSleD/4
	 Zk+ROvPsa0YAp36ScLmkGW3BmDxTcnJIEYO+Tau3su47Y6QfybYgrs3+Ai5YWG4wnX
	 KzYP29e7+Y9SLnu/x7Ad3kcNRCCKry1UGCnffFdc=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B597D21486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732689AbeLNMRd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:17:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:37548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732045AbeLNMRN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:17:13 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E37362148E;
        Fri, 14 Dec 2018 12:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789832;
        bh=SdV9NNZS/m+XbuYDw5ETSaaa7EmM82UzFlVTH+NeHns=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A7ZuOH/8aLMHvVaRo7NuQLaY3akmzNBiJb7BNFn4+w+wh6f4vkHJ+Spdazo5FOC7q
         tgza184V9UgOq5HKUlUbpC4QuAvauJlh7EUQfy89XdjKlE3tjcCkXd/1er8XXDq8cV
         +wgj11gRvWfqwQ1x+IZarM9NiT8/ESrnRs7dxnMs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: [PATCH 4.4 86/88] staging: speakup: Replace strncpy with memcpy
Date:   Fri, 14 Dec 2018 13:01:00 +0100
Message-Id: <20181214115709.412770798@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115702.151309521@linuxfoundation.org>
References: <20181214115702.151309521@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guenter Roeck <linux@roeck-us.net>

commit fd29edc7232bc19f969e8f463138afc5472b3d5f upstream.

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
Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/speakup/kobjects.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/staging/speakup/kobjects.c
+++ b/drivers/staging/speakup/kobjects.c
@@ -387,7 +387,7 @@ static ssize_t synth_store(struct kobjec
 	len = strlen(buf);
 	if (len < 2 || len > 9)
 		return -EINVAL;
-	strncpy(new_synth_name, buf, len);
+	memcpy(new_synth_name, buf, len);
 	if (new_synth_name[len - 1] == '\n')
 		len--;
 	new_synth_name[len] = '\0';
@@ -514,7 +514,7 @@ static ssize_t punc_store(struct kobject
 		return -EINVAL;
 	}
 
-	strncpy(punc_buf, buf, x);
+	memcpy(punc_buf, buf, x);
 
 	while (x && punc_buf[x - 1] == '\n')
 		x--;


