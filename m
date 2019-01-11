Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3070FC43612
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2E3C2133F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547216947;
	bh=rAC1GLbHPM54+IRdk1ypLAcc9ZtQ/GYR/YNvW0QHbHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GIq1cEZhjpNKAlhYs8jANxTGyhXgE1GCJ4hqkeR5A70U36G5Ce30rEV0yWOv7hhsR
	 GmAVOaE03AUztlf/3csTmDTe9T3ldTCXNiZBHjIfp8cbhOmWNjhICN3iczZwUxOs71
	 ZHlIHkkmZKtD1BMezhuQt61ko/uY618AlJ9VNaiw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388653AbfAKO3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:29:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:47886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388637AbfAKO3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:29:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38EC12063F;
        Fri, 11 Jan 2019 14:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547216941;
        bh=rAC1GLbHPM54+IRdk1ypLAcc9ZtQ/GYR/YNvW0QHbHc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BzPwZLxTzOr3xp1aRDApU2X31CMOp+emPZDgOtNzljJrzXP9y/q4JihSIO6CcW4lo
         pTG5WfPSpKbRVQ1FaR6AeMtmifs7GaiUDeXEfEkaPcZ9k5g3hwuMbo1VN6Pd73OvlN
         Tk0Ag/tdpo8EKpxFuBg2rgW/FgzjRczNuzztrEZU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hui Peng <benquike@163.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.9 47/63] ALSA: usb-audio: Fix an out-of-bound read in create_composite_quirks
Date:   Fri, 11 Jan 2019 15:14:50 +0100
Message-Id: <20190111131053.317407681@linuxfoundation.org>
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
 sound/usb/quirks-table.h |    3 +++
 1 file changed, 3 insertions(+)

--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -3321,6 +3321,9 @@ AU0828_DEVICE(0x2040, 0x7270, "Hauppauge
 					}
 				}
 			},
+			{
+				.ifnum = -1
+			},
 		}
 	}
 },


