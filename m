Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A99C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60255222A7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549897680;
	bh=3qsVDULR+zGHfc5w3wDVCZ2ruuQxDkIafWw+Zz75UuI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W4qNOo8i+2VFSLPa8oHHpP6PR0fkXuYQa+n6DG4BwYX5nDrr+LLmCWBj8kvyjZQDn
	 g/5prE4/WrUqw9vfBHyWMpeDrTvrfX3GP9Ost627YTXJ2d1QK80Q2Pj69SunfAp3Ov
	 BUBOC264COHd9PAXU1YUX6eHldcFtDhqNGUIdRQk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391045AbfBKPH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:07:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:57764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391018AbfBKPH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:07:56 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFD59217D9;
        Mon, 11 Feb 2019 15:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549897675;
        bh=3qsVDULR+zGHfc5w3wDVCZ2ruuQxDkIafWw+Zz75UuI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s64t68s2iXK0nTpARt2NGrmFV4ijR4voutb0TQt7Vu6M+uvb6oZigSzKQWPbgighX
         /fDpxc9klYOm72yVrJaRh1cfwXvV25yfhTr7FwcJFNfCL4KJ1ILZPTP40y1fA/Qqd0
         xcMqUEasx000vovsOVKO86H+zLjRnX4aq9fjdxjE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 076/137] fbdev: fbcon: Fix unregister crash when more than one framebuffer
Date:   Mon, 11 Feb 2019 15:19:17 +0100
Message-Id: <20190211141819.062783588@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141811.964925535@linuxfoundation.org>
References: <20190211141811.964925535@linuxfoundation.org>
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

[ Upstream commit 2122b40580dd9d0620398739c773d07a7b7939d0 ]

When unregistering fbdev using unregister_framebuffer(), any bound
console will unbind automatically. This is working fine if this is the
only framebuffer, resulting in a switch to the dummy console. However if
there is a fb0 and I unregister fb1 having a bound console, I eventually
get a crash. The fastest way for me to trigger the crash is to do a
reboot, resulting in this splat:

[   76.478825] WARNING: CPU: 0 PID: 527 at linux/kernel/workqueue.c:1442 __queue_work+0x2d4/0x41c
[   76.478849] Modules linked in: raspberrypi_hwmon gpio_backlight backlight bcm2835_rng rng_core [last unloaded: tinydrm]
[   76.478916] CPU: 0 PID: 527 Comm: systemd-udevd Not tainted 4.20.0-rc4+ #4
[   76.478933] Hardware name: BCM2835
[   76.478949] Backtrace:
[   76.478995] [<c010d388>] (dump_backtrace) from [<c010d670>] (show_stack+0x20/0x24)
[   76.479022]  r6:00000000 r5:c0bc73be r4:00000000 r3:6fb5bf81
[   76.479060] [<c010d650>] (show_stack) from [<c08e82f4>] (dump_stack+0x20/0x28)
[   76.479102] [<c08e82d4>] (dump_stack) from [<c0120070>] (__warn+0xec/0x12c)
[   76.479134] [<c011ff84>] (__warn) from [<c01201e4>] (warn_slowpath_null+0x4c/0x58)
[   76.479165]  r9:c0eb6944 r8:00000001 r7:c0e927f8 r6:c0bc73be r5:000005a2 r4:c0139e84
[   76.479197] [<c0120198>] (warn_slowpath_null) from [<c0139e84>] (__queue_work+0x2d4/0x41c)
[   76.479222]  r6:d7666a00 r5:c0e918ee r4:dbc4e700
[   76.479251] [<c0139bb0>] (__queue_work) from [<c013a02c>] (queue_work_on+0x60/0x88)
[   76.479281]  r10:c0496bf8 r9:00000100 r8:c0e92ae0 r7:00000001 r6:d9403700 r5:d7666a00
[   76.479298]  r4:20000113
[   76.479348] [<c0139fcc>] (queue_work_on) from [<c0496c28>] (cursor_timer_handler+0x30/0x54)
[   76.479374]  r7:d8a8fabc r6:c0e08088 r5:d8afdc5c r4:d8a8fabc
[   76.479413] [<c0496bf8>] (cursor_timer_handler) from [<c0178744>] (call_timer_fn+0x100/0x230)
[   76.479435]  r4:c0e9192f r3:d758a340
[   76.479465] [<c0178644>] (call_timer_fn) from [<c0178980>] (expire_timers+0x10c/0x12c)
[   76.479495]  r10:40000000 r9:c0e9192f r8:c0e92ae0 r7:d8afdccc r6:c0e19280 r5:c0496bf8
[   76.479513]  r4:d8a8fabc
[   76.479541] [<c0178874>] (expire_timers) from [<c0179630>] (run_timer_softirq+0xa8/0x184)
[   76.479570]  r9:00000001 r8:c0e19280 r7:00000000 r6:c0e08088 r5:c0e1a3e0 r4:c0e19280
[   76.479603] [<c0179588>] (run_timer_softirq) from [<c0102404>] (__do_softirq+0x1ac/0x3fc)
[   76.479632]  r10:c0e91680 r9:d8afc020 r8:0000000a r7:00000100 r6:00000001 r5:00000002
[   76.479650]  r4:c0eb65ec
[   76.479686] [<c0102258>] (__do_softirq) from [<c0124d10>] (irq_exit+0xe8/0x168)
[   76.479716]  r10:d8d1a9b0 r9:d8afc000 r8:00000001 r7:d949c000 r6:00000000 r5:c0e8b3f0
[   76.479734]  r4:00000000
[   76.479764] [<c0124c28>] (irq_exit) from [<c016b72c>] (__handle_domain_irq+0x94/0xb0)
[   76.479793] [<c016b698>] (__handle_domain_irq) from [<c01021dc>] (bcm2835_handle_irq+0x3c/0x48)
[   76.479823]  r8:d8afdebc r7:d8afddfc r6:ffffffff r5:c0e089f8 r4:d8afddc8 r3:d8afddc8
[   76.479851] [<c01021a0>] (bcm2835_handle_irq) from [<c01019f0>] (__irq_svc+0x70/0x98)

The problem is in the console rebinding in fbcon_fb_unbind(). It uses the
virtual console index as the new framebuffer index to bind the console(s)
to. The correct way is to use the con2fb_map lookup table to find the
framebuffer index.

Fixes: cfafca8067c6 ("fbdev: fbcon: console unregistration from unregister_framebuffer")
Signed-off-by: Noralf Trønnes <noralf@tronnes.org>
Reviewed-by: Mikulas Patocka <mpatocka@redhat.com>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/console/fbcon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index 4db10d7990c9..178b507a6fe0 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -3030,7 +3030,7 @@ static int fbcon_fb_unbind(int idx)
 	for (i = first_fb_vc; i <= last_fb_vc; i++) {
 		if (con2fb_map[i] != idx &&
 		    con2fb_map[i] != -1) {
-			new_idx = i;
+			new_idx = con2fb_map[i];
 			break;
 		}
 	}
-- 
2.19.1



