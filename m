Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA824C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75CA021738
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547062454;
	bh=JxZjdzxU9dPfH8Izpe7tH+yiYoEsJ0jMaB3DYoHF/RM=;
	h=Subject:From:To:Cc:Date:List-ID:From;
	b=kerI1aJns1vJ/Jt8IjWECQjHYDL4mV2O0ryU3xxKTMFycXpETrNQhiLE1XTNFJs1x
	 XTP0NkYOC+Hp76RzkiOX9aIC5+lofkBc9dtR1KgQUSwOpX31pX9cZXeidsuVyRaIP8
	 Vg4N4bdGyIgFgODRUwLnfSANNpI1qKW5gHRytNec=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbfAITeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 14:34:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:38240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727770AbfAITeN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 14:34:13 -0500
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5374A206BA;
        Wed,  9 Jan 2019 19:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547062452;
        bh=JxZjdzxU9dPfH8Izpe7tH+yiYoEsJ0jMaB3DYoHF/RM=;
        h=Subject:From:To:Cc:Date:From;
        b=CV8KGQ4fyjP/FLPyR62vxFQUx6M7unXolKoe4t2mKMkkhmFVm08EAU0fu1qGZ0UrW
         fO+492InpVCo8z8dBlROa9yQPMn2a6oFlk+NxWF/Ko1QDVUxn6rbmKQHgdjvUtDoY8
         aFcHMnLnj2yPeDxngd0lHmeHaID5TZOJOOCM8Vx8=
Message-ID: <1547062451.6258.7.camel@kernel.org>
Subject: [PATCH] tracing: Use str_has_prefix() in synth_event_create()
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 09 Jan 2019 13:34:11 -0600
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we now have a str_has_prefix() that returns the length, we can
use that instead of explicitly calculating it.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/trace_events_hist.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 449d90cfa151..625725ae262f 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1200,8 +1200,7 @@ static int synth_event_create(int argc, const char **argv)
 
 	/* This interface accepts group name prefix */
 	if (strchr(name, '/')) {
-		len = sizeof(SYNTH_SYSTEM "/") - 1;
-		if (strncmp(name, SYNTH_SYSTEM "/", len))
+		if ((len = str_has_prefix(name, SYNTH_SYSTEM "/")) == 0)
 			return -EINVAL;
 		name += len;
 	}
-- 
2.14.1

