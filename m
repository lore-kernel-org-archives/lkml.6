Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B6CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E699D206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217669;
	bh=r3jDPh0auvm0GqBzyvC1jkQC8P49X0D9usHH4orWBfw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=izAjDHIH3zvjGrVTpD+8IuIvZv6I45CsQy3HCPcgxzWnmstjX4jM0bgP3NBpVP+/Y
	 k7So6aQ93fOKrTq3bAvTskkmVidI4cGog9QVO2ztGx6zFdddPoxCPrPvf47RbTPoQp
	 jKhKRnIDzqMGc/vBWPL+rlUocsM0903Lai2wETq0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403976AbfAKOlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:41:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:33750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403925AbfAKOlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:41:03 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B4D22063F;
        Fri, 11 Jan 2019 14:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217663;
        bh=r3jDPh0auvm0GqBzyvC1jkQC8P49X0D9usHH4orWBfw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MK3K1A2K//L44bLa7rxPE15cwN60vCbCaUnJA4HmWvc6l6ydCPZT1XODfTZ/ySAit
         QOeCoVkkk4qYMARhXTRuihIPvVm4e4kC+iwFZBICrYUtyRx9C+iJXidfKUoEsqZvV9
         pzRXgSSkANlOBSXZSkq0M80D1CcEnF1Yez0AHH/E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hui Peng <benquike@163.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 107/148] ALSA: usb-audio: Fix an out-of-bound read in create_composite_quirks
Date:   Fri, 11 Jan 2019 15:14:45 +0100
Message-Id: <20190111131118.494747737@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131114.337122649@linuxfoundation.org>
References: <20190111131114.337122649@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hui Peng <benquike@163.com>

commit cbb2ebf70daf7f7d97d3811a2ff8e39655b8c184 upstream.

In `create_composite_quirk`, the terminating condition of for loops is
`quirk->ifnum < 0`. So any composite quirks should end with `struct
snd_usb_audio_quirk` object with ifnum < 0.

    for (quirk = quirk_comp->data; quirk->ifnum >= 0; ++quirk) {

    	.....
    }

the data field of Bower's & Wilkins PX headphones usb device device quirks
do not end with {.ifnum = -1}, wihch may result in out-of-bound read.

This Patch fix the bug by adding an ending quirk object.

Fixes: 240a8af929c7 ("ALSA: usb-audio: Add a quirck for B&W PX headphones")
Signed-off-by: Hui Peng <benquike@163.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/usb/quirks-table.h |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -3326,6 +3326,9 @@ AU0828_DEVICE(0x2040, 0x7270, "Hauppauge
 					}
 				}
 			},
+			{
+				.ifnum = -1
+			},
 		}
 	}
 },
@@ -3374,6 +3377,9 @@ AU0828_DEVICE(0x2040, 0x7270, "Hauppauge
 					}
 				}
 			},
+			{
+				.ifnum = -1
+			},
 		}
 	}
 },


