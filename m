Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06207C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5798208B4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:58:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5798208B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbeH0XqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 19:46:08 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:53547 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbeH0XqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 19:46:07 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue103 [212.227.15.145]) with ESMTPA (Nemesis) id
 0LvhpU-1frAcS1Kyi-017Ual; Mon, 27 Aug 2018 21:57:48 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-media@vger.kernel.org
Cc:     y2038@lists.linaro.org, awalls@md.metrocast.net,
        hans.verkuil@cisco.com, mchehab@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/5] media: cec: move compat_ioctl handling to cec-api.c
Date:   Mon, 27 Aug 2018 21:56:23 +0200
Message-Id: <20180827195649.4170969-3-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180827195649.4170969-1-arnd@arndb.de>
References: <20180827195649.4170969-1-arnd@arndb.de>
X-Provags-ID: V03:K1:/0iNC4cnGPCle1odQAbs0mrIC1/OQGCfCsm/8n+B3StjPExvtlz
 eP6xpslKXsoTBmV1oGPUoXZ54KJtEsBSf1mU2ToNfG1jRIDY6IywLrfAaxWDW5g/bbk3ML1
 VxrzKXVplT0znJa1giAUfiVWgJKwvDUgRGWjyYy0mOWo0ahINHQbi+fFVIsk2sy2FAyC5B9
 vIhTyYHcwmeMHhOpOPayQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:L/QihZtH7rk=:fTjOl6Xr9HFl+q1frMpSKZ
 uME5psjSb8/clsVj6Rdw2oXwbEs2bt+6eoZloHbAdMQYlM1je2ZhAhpfuvV/AJ0mhuEbHIrHN
 8hafgFMNLZvNrwWJ4YHj8/ySKcDLq/7YYameA6EHYSVTP3IoFvpCDQhKbcFXBlBBFzYnJujKK
 Odd/8/L6jbavYvn3z/J5rvgd5PcAqA2s8VJvZWE+8s/SGUVwzrwNIZ33I6X8d/MJEG2xgIgE1
 K0DcklQ/Q9VrZGPu7x/8+k02ES+p/nI2opMSO8EDd37qYeQopORVI+rJOxo/+SZocngO5teAm
 1XPI1u3D5G56xkWyi1MO2uPJXJSRcDNI84ckwtn2AY920+eaJZYDWqAV7bZqqsKAmieredFhA
 AELlPOh+es2B6clgMuvMo8Uz8vX23xo/Gd1s60MSWo67LogWGcBRWDTQ3Sl8X/jkDEYT12Iop
 gFgmDRnPL+fVlpls6A5GCIk87h3X/SWOkon+izuAxJfmLM6zijsJ0/+dEMWJZoLNPxZ7hPsM0
 vuZngtbC0PPgyDgVtCc9FhWi2J92AuGwxhNI3kj8PWlOArwawpuLDp+tq4Hh8GG3dbl/ulV3l
 nBTlY69DhGkYEXB1204aPiZsQEPgs2iLz7dsbETzp7PZFTf1FTpKBHUlr2KpNXh7VPI9M0JPA
 yitNSK9GVjETd63DaiKTD1ZDIPwyY+8+ZHcGQplZHvrPOpJ0W1T7EItmlzDj9uFXOmbQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the CEC ioctls are compatible, and they are only implemented
in one driver, so we can simply let this driver handle them
natively.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/media/cec/cec-api.c |  1 +
 fs/compat_ioctl.c           | 12 ------------
 2 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/media/cec/cec-api.c b/drivers/media/cec/cec-api.c
index b6536bbad530..9067728feb60 100644
--- a/drivers/media/cec/cec-api.c
+++ b/drivers/media/cec/cec-api.c
@@ -665,6 +665,7 @@ const struct file_operations cec_devnode_fops = {
 	.owner = THIS_MODULE,
 	.open = cec_open,
 	.unlocked_ioctl = cec_ioctl,
+	.compat_ioctl = cec_ioctl,
 	.release = cec_release,
 	.poll = cec_poll,
 	.llseek = no_llseek,
diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index e38e6c785459..33f48933a865 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -1195,18 +1195,6 @@ COMPATIBLE_IOCTL(VIDEO_CLEAR_BUFFER)
 COMPATIBLE_IOCTL(VIDEO_SET_STREAMTYPE)
 COMPATIBLE_IOCTL(VIDEO_SET_FORMAT)
 COMPATIBLE_IOCTL(VIDEO_GET_SIZE)
-/* cec */
-COMPATIBLE_IOCTL(CEC_ADAP_G_CAPS)
-COMPATIBLE_IOCTL(CEC_ADAP_G_LOG_ADDRS)
-COMPATIBLE_IOCTL(CEC_ADAP_S_LOG_ADDRS)
-COMPATIBLE_IOCTL(CEC_ADAP_G_PHYS_ADDR)
-COMPATIBLE_IOCTL(CEC_ADAP_S_PHYS_ADDR)
-COMPATIBLE_IOCTL(CEC_G_MODE)
-COMPATIBLE_IOCTL(CEC_S_MODE)
-COMPATIBLE_IOCTL(CEC_TRANSMIT)
-COMPATIBLE_IOCTL(CEC_RECEIVE)
-COMPATIBLE_IOCTL(CEC_DQEVENT)
-
 /* joystick */
 COMPATIBLE_IOCTL(JSIOCGVERSION)
 COMPATIBLE_IOCTL(JSIOCGAXES)
-- 
2.18.0

