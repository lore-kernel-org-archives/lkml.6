Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC376C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9197C21486
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789209;
	bh=N0CWDW7V7bhu2+zhcIYgw915OzEQrA/J/7TLfYClBA0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E2Vaors5QyruVh42i7KRhHa+5eHPRIcS85CkVvFvnmxZXmKdHbGGYb2y46YkmvLSx
	 BvO6wFrTAbP45hz1OLDms7wBjC8ZlNN/kY4r3GR8BpAV3aIkUW4onrhvpH5by5mSqX
	 zpz/KXJvXTnW0hHZRw6ocTws4xP2FYPIIBIwKP38=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9197C21486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730989AbeLNMGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:06:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:51890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730977AbeLNMGp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:06:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1C3621486;
        Fri, 14 Dec 2018 12:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789204;
        bh=N0CWDW7V7bhu2+zhcIYgw915OzEQrA/J/7TLfYClBA0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wVsaZ3vch4l/AywxpNfHbgRqdS/kY8qtQQeAKJexZ/ucxRxhs76iJJO1pljyMXbDX
         lZB5/Qz7qP+U4XddBKVBLKa4nDeqEYJUOQUzHalV7MX7i6goZlh6LIckwfzJSY5VEi
         Vp9uTv1GOA2mne8R+pikHG92H7uYTpsozw/Oqi2c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 135/142] ALSA: fireface: fix reference to wrong register for clock configuration
Date:   Fri, 14 Dec 2018 13:00:20 +0100
Message-Id: <20181214115752.433931882@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115747.053633987@linuxfoundation.org>
References: <20181214115747.053633987@linuxfoundation.org>
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

From: Takashi Sakamoto <o-takashi@sakamocchi.jp>

commit fa9c98e4b975bb3192ed6af09d9fa282ed3cd8a0 upstream.

In an initial commit, 'SYNC_STATUS' register is referred to get
clock configuration, however this is wrong, according to my local
note at hand for reverse-engineering about packet dump. It should
be 'CLOCK_CONFIG' register. Actually, ff400_dump_clock_config()
is correctly programmed.

This commit fixes the bug.

Cc: <stable@vger.kernel.org> # v4.12+
Fixes: 76fdb3a9e13a ('ALSA: fireface: add support for Fireface 400')
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/firewire/fireface/ff-protocol-ff400.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/firewire/fireface/ff-protocol-ff400.c
+++ b/sound/firewire/fireface/ff-protocol-ff400.c
@@ -30,7 +30,7 @@ static int ff400_get_clock(struct snd_ff
 	int err;
 
 	err = snd_fw_transaction(ff->unit, TCODE_READ_QUADLET_REQUEST,
-				 FF400_SYNC_STATUS, &reg, sizeof(reg), 0);
+				 FF400_CLOCK_CONFIG, &reg, sizeof(reg), 0);
 	if (err < 0)
 		return err;
 	data = le32_to_cpu(reg);


