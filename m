Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5EA4C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC3C32084A
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="m2im7FiF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC3C32084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731581AbeKCEE1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:04:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:60494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726051AbeKCEE1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:04:27 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A671D2084A;
        Fri,  2 Nov 2018 18:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184970;
        bh=QTIe4oj4JjKN6hFajRxpIDNmBdXCBPWa+1IzpbJtY/I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m2im7FiFbRr6UolmV1MoLsVE2s98/j5C5Jz/uvSeRXAd990CmLjzk3L8q5+FjXgyi
         0vOhau8qW6JpT+an+Ocigq2CVPstRPXh5kCdFbyoPIYds0A4IrYVRreIbksHsSw7kI
         RzUx31vh5mzf3hk9CtbXgkkU5ELgRRwbW8rMdfEw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrey Konovalov <andreyknvl@google.com>,
        Takashi Iwai <tiwai@suse.de>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 111/143] ALSA: usx2y: Fix invalid stream URBs
Date:   Fri,  2 Nov 2018 19:34:56 +0100
Message-Id: <20181102182906.708873574@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182857.064326086@linuxfoundation.org>
References: <20181102182857.064326086@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

commit f9a1c372299fed53d4b72bb601f7f3bfe6f9999c upstream

The us122l driver creates URBs per the fixed endpoints, and this may
end up with URBs with inconsistent pipes when a fuzzer or a malicious
program deals with the manipulated endpoints.  It ends up with a
kernel warning like:

  usb 1-1: BOGUS urb xfer, pipe 0 != type 3
  ------------[ cut here ]------------
  WARNING: CPU: 0 PID: 24 at drivers/usb/core/urb.c:471
  usb_submit_urb+0x113e/0x1400
  Call Trace:
   usb_stream_start+0x48a/0x9f0 sound/usb/usx2y/usb_stream.c:690
   us122l_start+0x116/0x290 sound/usb/usx2y/us122l.c:365
   us122l_create_card sound/usb/usx2y/us122l.c:502
   us122l_usb_probe sound/usb/usx2y/us122l.c:588
   ....

For avoiding the bad access, this patch adds a few sanity checks of
the validity of created URBs like previous similar fixes using the new
usb_urb_ep_type_check() helper function.

Reported-by: Andrey Konovalov <andreyknvl@google.com>
Tested-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/usx2y/usb_stream.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/sound/usb/usx2y/usb_stream.c b/sound/usb/usx2y/usb_stream.c
index e229abd21652..b0f8979ff2d2 100644
--- a/sound/usb/usx2y/usb_stream.c
+++ b/sound/usb/usx2y/usb_stream.c
@@ -56,7 +56,7 @@ static void playback_prep_freqn(struct usb_stream_kernel *sk, struct urb *urb)
 		    lb, s->period_size);
 }
 
-static void init_pipe_urbs(struct usb_stream_kernel *sk, unsigned use_packsize,
+static int init_pipe_urbs(struct usb_stream_kernel *sk, unsigned use_packsize,
 			   struct urb **urbs, char *transfer,
 			   struct usb_device *dev, int pipe)
 {
@@ -77,6 +77,8 @@ static void init_pipe_urbs(struct usb_stream_kernel *sk, unsigned use_packsize,
 		urb->interval = 1;
 		if (usb_pipeout(pipe))
 			continue;
+		if (usb_urb_ep_type_check(urb))
+			return -EINVAL;
 
 		urb->transfer_buffer_length = transfer_length;
 		desc = urb->iso_frame_desc;
@@ -87,9 +89,11 @@ static void init_pipe_urbs(struct usb_stream_kernel *sk, unsigned use_packsize,
 			desc[p].length = maxpacket;
 		}
 	}
+
+	return 0;
 }
 
-static void init_urbs(struct usb_stream_kernel *sk, unsigned use_packsize,
+static int init_urbs(struct usb_stream_kernel *sk, unsigned use_packsize,
 		      struct usb_device *dev, int in_pipe, int out_pipe)
 {
 	struct usb_stream	*s = sk->s;
@@ -103,9 +107,12 @@ static void init_urbs(struct usb_stream_kernel *sk, unsigned use_packsize,
 		sk->outurb[u] = usb_alloc_urb(sk->n_o_ps, GFP_KERNEL);
 	}
 
-	init_pipe_urbs(sk, use_packsize, sk->inurb, indata, dev, in_pipe);
-	init_pipe_urbs(sk, use_packsize, sk->outurb, sk->write_page, dev,
-		       out_pipe);
+	if (init_pipe_urbs(sk, use_packsize, sk->inurb, indata, dev, in_pipe) ||
+	    init_pipe_urbs(sk, use_packsize, sk->outurb, sk->write_page, dev,
+			   out_pipe))
+		return -EINVAL;
+
+	return 0;
 }
 
 
@@ -226,7 +233,11 @@ struct usb_stream *usb_stream_new(struct usb_stream_kernel *sk,
 	else
 		sk->freqn = get_usb_high_speed_rate(sample_rate);
 
-	init_urbs(sk, use_packsize, dev, in_pipe, out_pipe);
+	if (init_urbs(sk, use_packsize, dev, in_pipe, out_pipe) < 0) {
+		usb_stream_free(sk);
+		return NULL;
+	}
+
 	sk->s->state = usb_stream_stopped;
 out:
 	return sk->s;
-- 
2.17.1



