Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A02C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A879B208B4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:57:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A879B208B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbeH0Xpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 19:45:34 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:48751 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbeH0Xpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 19:45:34 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue103 [212.227.15.145]) with ESMTPA (Nemesis) id
 0MYtjH-1gPwsS1p6x-00VgKm; Mon, 27 Aug 2018 21:57:23 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-media@vger.kernel.org
Cc:     y2038@lists.linaro.org, awalls@md.metrocast.net,
        hans.verkuil@cisco.com, mchehab@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/5] media: dvb: dmxdev: move compat_ioctl handling to dmxdev.c
Date:   Mon, 27 Aug 2018 21:56:22 +0200
Message-Id: <20180827195649.4170969-2-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180827195649.4170969-1-arnd@arndb.de>
References: <20180827195649.4170969-1-arnd@arndb.de>
X-Provags-ID: V03:K1:yTkrd/yrjsF6qtZdVKa/vLv63bnVKSH1NuE9jpO3NEH7s1zpvS7
 u2e1jccmxFmgrH3egH+2ieGwATqsEsoyBfgs+obMnr0LDH0EEWKk0bMFlTfahG1aWZjaKE+
 9YRHqv0N2+Qe67nyXso4EuFRSC809cVMPBoDJcdScA649ObAGkLWNe5OpTzC/TXPLikgWH9
 a7bKUyHu8+qJf9yaxE8VQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7zi6iiAcuBM=:oqJE6+6IuJyI7LJucSvC+d
 81o5oURdZIDYptMOHo4MvX9FwCoOSUMF8CJYIsgwpLFM3jsCpQ+cLCHR1O9IvggtzgdjJrQEE
 vR7s0fFID7RSlZAIky8LCZCuXrvZ5dyJl153xEVrlEASgsh4JpTdI5d6p5BK0CaIBmul+QRjV
 NLP9uxDQ1mtFpFoHHwjlRAtC62I3dvQvbVoOKyrAINaCXyQBwY2KDVWC5nB4R7U+TpQOwnJaP
 6N/vnFuKN32oYgEJVS6lqazonAr2+YepxWgTXoZkAXJmLOeKV3dElZoxRPp/DU1+0IoshyYxb
 SJht8zgbmIDlaYpIxjpSSUsvc0UmtSU/L+SxC47mby5TGiabQ+3RCxkXwvlDgypOxgCdd+7NR
 t535hc3mv+aEyY8Bp4iu4+4dFRtVtnOvxEypmKIO3HuN0NZ3fv1hU9ccOJz3TonfxY9Rw3+sX
 60haI1U2PkjmAeNqYKgZFrEJfK99xdtB+o468ChRKNNy3zijdqafnCOMQ4KcrpjSpEnznOCe7
 eJ3uXMd030T3w/HJFVQAOfv1T6YYBTzSOoQERhF/2BjDmpnv5r1HPODCUDv9EUeT0owwXp4lF
 +QYlw1HXE0DRiNVNJkD5YnFXAvOy75yoosK34Yblic3GomIafpCwJoSzGVEjsxOKo7haZ9g+t
 80UkcjvH36L8HuP6dYwOIhcqR0Si/E8yOPuWyxNs0IBI5abcnBNrdQX6ZhC3cxSZa1H4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All dmx ioctls are compatible, and they are only implemented
in one file, so we can replace the list of commands in
fs/compat_ioctl.c with a single line in dmxdev.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/media/dvb-core/dmxdev.c |  1 +
 fs/compat_ioctl.c               | 12 ------------
 2 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/media/dvb-core/dmxdev.c b/drivers/media/dvb-core/dmxdev.c
index d548f98c7a67..1544e8cef564 100644
--- a/drivers/media/dvb-core/dmxdev.c
+++ b/drivers/media/dvb-core/dmxdev.c
@@ -1265,6 +1265,7 @@ static const struct file_operations dvb_demux_fops = {
 	.owner = THIS_MODULE,
 	.read = dvb_demux_read,
 	.unlocked_ioctl = dvb_demux_ioctl,
+	.compat_ioctl = dvb_demux_ioctl,
 	.open = dvb_demux_open,
 	.release = dvb_demux_release,
 	.poll = dvb_demux_poll,
diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index 0c46ce224590..e38e6c785459 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -1180,18 +1180,6 @@ COMPATIBLE_IOCTL(AUDIO_CLEAR_BUFFER)
 COMPATIBLE_IOCTL(AUDIO_SET_ID)
 COMPATIBLE_IOCTL(AUDIO_SET_MIXER)
 COMPATIBLE_IOCTL(AUDIO_SET_STREAMTYPE)
-COMPATIBLE_IOCTL(DMX_START)
-COMPATIBLE_IOCTL(DMX_STOP)
-COMPATIBLE_IOCTL(DMX_SET_FILTER)
-COMPATIBLE_IOCTL(DMX_SET_PES_FILTER)
-COMPATIBLE_IOCTL(DMX_SET_BUFFER_SIZE)
-COMPATIBLE_IOCTL(DMX_GET_PES_PIDS)
-COMPATIBLE_IOCTL(DMX_GET_STC)
-COMPATIBLE_IOCTL(DMX_REQBUFS)
-COMPATIBLE_IOCTL(DMX_QUERYBUF)
-COMPATIBLE_IOCTL(DMX_EXPBUF)
-COMPATIBLE_IOCTL(DMX_QBUF)
-COMPATIBLE_IOCTL(DMX_DQBUF)
 COMPATIBLE_IOCTL(VIDEO_STOP)
 COMPATIBLE_IOCTL(VIDEO_PLAY)
 COMPATIBLE_IOCTL(VIDEO_FREEZE)
-- 
2.18.0

