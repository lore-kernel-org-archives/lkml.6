Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC227C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B99720874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547219194;
	bh=66/xdMQJyrDEpBVJjKZHZYothFDNEDvRfMNrEb6UFkE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RQydbtaamTwdzU/li2eaHj6qISu306pRfwuP9C0eI56u7qxuqgJ5XN+IRd0QKkqrL
	 ZPBtQ9eN9US15u5KlaS+xwe+XynXIffXy+UAC5Ws4PmKnJoIj9z5evwClJnmpou9kW
	 wNESTzussMofP10249ovrjBc7tEVq5065/TK4B4U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389093AbfAKPGc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 10:06:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:47796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388611AbfAKO24 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:28:56 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C8032133F;
        Fri, 11 Jan 2019 14:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547216935;
        bh=66/xdMQJyrDEpBVJjKZHZYothFDNEDvRfMNrEb6UFkE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lfpL7d90AyYhDo9ud320XsvZqCWt0KxZY0zo8VHBj3nw5Hbkjs9EUlOXd4i7sLlHM
         saITeqtu4+ICC8DBTkQ/2MZTAuROG8VnmitzkHFCSLRk74Iv7rqpVvrQ1emPlCW/UH
         xJBhzaXeoE2oFbhCNEIXu7HQ3zh6UM9xXcoHfJN8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Yavuz, Tuba" <tuba@ece.ufl.edu>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.9 45/63] ALSA: cs46xx: Potential NULL dereference in probe
Date:   Fri, 11 Jan 2019 15:14:48 +0100
Message-Id: <20190111131053.075718019@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131046.387528003@linuxfoundation.org>
References: <20190111131046.387528003@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@oracle.com>

commit 1524f4e47f90b27a3ac84efbdd94c63172246a6f upstream.

The "chip->dsp_spos_instance" can be NULL on some of the ealier error
paths in snd_cs46xx_create().

Reported-by: "Yavuz, Tuba" <tuba@ece.ufl.edu>
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/cs46xx/dsp_spos.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/sound/pci/cs46xx/dsp_spos.c
+++ b/sound/pci/cs46xx/dsp_spos.c
@@ -899,6 +899,9 @@ int cs46xx_dsp_proc_done (struct snd_cs4
 	struct dsp_spos_instance * ins = chip->dsp_spos_instance;
 	int i;
 
+	if (!ins)
+		return 0;
+
 	snd_info_free_entry(ins->proc_sym_info_entry);
 	ins->proc_sym_info_entry = NULL;
 


