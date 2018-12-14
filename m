Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DBF1C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 260FB21486
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789225;
	bh=+kQ//yTwFiP4gPfSmKY2AA4OmHDf9R2TflKlrrRQfho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RkRJS6IX0f0DHR/QCtf9CjZbj1+1NfRv3LtIJalOawsHR0JuexOv9bbOhgtZ7uBg/
	 xT8fo6XrppS7aB+jy1qgzje9UOMikcvRR8q9AAMi0BBA/ttyHyIgwySqnX5VSFUG2h
	 93MxJNA1uvM5fcigjYG/TmFiwchVMZ1AkyMOsSac=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 260FB21486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731038AbeLNMHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:07:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:52130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731021AbeLNMHA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:07:00 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 473D121479;
        Fri, 14 Dec 2018 12:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789219;
        bh=+kQ//yTwFiP4gPfSmKY2AA4OmHDf9R2TflKlrrRQfho=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ad5p3y7eY9FS4ZS5/kfXMLEqUvWaSwJdFc2bcRi4W+Dqj95fmZ/WDdrZBMyjsijoe
         3tzg5EC1ic/YVOmsHdfWx245TUsGZ8YZL84ETaRbT2rUaCQjujUUVtf9qOb5wJbzhd
         /8BA60e4Yb/RbGWDGB0Is3elmCckfvjcwHC1J1dE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hui Wang <hui.wang@canonical.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 140/142] ALSA: hda/realtek - Fix the mute LED regresion on Lenovo X1 Carbon
Date:   Fri, 14 Dec 2018 13:00:25 +0100
Message-Id: <20181214115752.634467032@linuxfoundation.org>
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

From: Hui Wang <hui.wang@canonical.com>

commit 6ba189c5c1a4bda70dc1e4826c58b0246068bb8d upstream.

Users reported a mute LED regression on Lenovo X1 Carbon, the root
cause is we applied the fixup of ALC285_FIXUP_LENOVO_HEADPHONE_NOISE
to this machine, then the machine can't apply the fixup of
ALC269_FIXUP_THINKPAD_ACPI anymore. To fix it, we chain two fixup
together.

Fixes: c4cfcf6f4297 ("ALSA: hda/realtek - fix the pop noise on headphone for lenovo laptops")
Cc: <stable@vger.kernel.org>
Signed-off-by: Hui Wang <hui.wang@canonical.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6395,6 +6395,8 @@ static const struct hda_fixup alc269_fix
 	[ALC285_FIXUP_LENOVO_HEADPHONE_NOISE] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc285_fixup_invalidate_dacs,
+		.chained = true,
+		.chain_id = ALC269_FIXUP_THINKPAD_ACPI
 	},
 	[ALC295_FIXUP_HP_AUTO_MUTE] = {
 		.type = HDA_FIXUP_FUNC,


