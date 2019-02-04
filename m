Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01506C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C79BA20823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549277717;
	bh=nFt49ELyqv6mVEfP9QYdFfkhA2bmLrA+aTgRS9JZ8ps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Kq1FNpCiReBw37CPtNg8/nfCgExm4gQGnKgbQApMeniuv12qH1qs0uYPfPV6tpXOk
	 wSVr+mdlF7fhsKp8IoMRdq3GLQbYzweWv7tEfgvEDDOGIXq31N/GBs9lH39wROISyC
	 LkEQDqsA/H8nnfTmOop/uVl9Z4ubgh+ShfpE2zOM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732865AbfBDKyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:54:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:51670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732847AbfBDKx5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:53:57 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7107E2082E;
        Mon,  4 Feb 2019 10:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277636;
        bh=nFt49ELyqv6mVEfP9QYdFfkhA2bmLrA+aTgRS9JZ8ps=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nvOgKTrkCBAa1gWPPiV7QbFo7ZV45pwgc70HEULv/eX78jTmCLwHwcN9vq7YRNYjd
         7IuujqS+HuoJbQozvE3NLeOpdSIFkBDHAsJCurppIjZvOk0WYXoHLSiz/ixbBY3TWR
         le3O9RSkaKa2wZLkVUIj8negmvYWEGC7E764ZQ+E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+fbe0496f92a0ce7b786c@syzkaller.appspotmail.com,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.20 59/80] ALSA: pcm: Fix tight loop of OSS capture stream
Date:   Mon,  4 Feb 2019 11:37:19 +0100
Message-Id: <20190204103628.406445495@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103620.287366543@linuxfoundation.org>
References: <20190204103620.287366543@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit e190161f96b88ffae870405fd6c3fdd1d2e7f98d upstream.

When the trigger=off is passed for a PCM OSS stream, it sets the
start_threshold of the given substream to the boundary size, so that
it won't be automatically started.  This can be problematic for a
capture stream, unfortunately, as detected by syzkaller.  The scenario
is like the following:

- In __snd_pcm_lib_xfer() that is invoked from snd_pcm_oss_read()
  loop, we have a check whether the stream was already started or the
  stream can be auto-started.
- The function at this check returns 0 with trigger=off since we
  explicitly disable the auto-start.
- The loop continues and repeats calling __snd_pcm_lib_xfer() tightly,
  which may lead to an RCU stall.

This patch fixes the bug by simply allowing the wait for non-started
stream in the case of OSS capture.  For native usages, it's supposed
to be done by the caller side (which is user-space), hence it returns
zero like before.

(In theory, __snd_pcm_lib_xfer() could wait even for the native API
 usage cases, too; but I'd like to stay in a safer side for not
 breaking the existing stuff for now.)

Reported-by: syzbot+fbe0496f92a0ce7b786c@syzkaller.appspotmail.com
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/core/pcm_lib.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -2112,6 +2112,13 @@ int pcm_lib_apply_appl_ptr(struct snd_pc
 	return 0;
 }
 
+/* allow waiting for a capture stream that hasn't been started */
+#if IS_ENABLED(CONFIG_SND_PCM_OSS)
+#define wait_capture_start(substream)	((substream)->oss.oss)
+#else
+#define wait_capture_start(substream)	false
+#endif
+
 /* the common loop for read/write data */
 snd_pcm_sframes_t __snd_pcm_lib_xfer(struct snd_pcm_substream *substream,
 				     void *data, bool interleaved,
@@ -2182,7 +2189,7 @@ snd_pcm_sframes_t __snd_pcm_lib_xfer(str
 			err = snd_pcm_start(substream);
 			if (err < 0)
 				goto _end_unlock;
-		} else {
+		} else if (!wait_capture_start(substream)) {
 			/* nothing to do */
 			err = 0;
 			goto _end_unlock;


