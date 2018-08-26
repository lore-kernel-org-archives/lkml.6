Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 023ADC433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 17:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A16CA2086B
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 17:49:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A16CA2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbeHZVdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 17:33:01 -0400
Received: from mout.web.de ([212.227.17.12]:41403 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726714AbeHZVdB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 17:33:01 -0400
Received: from [192.168.1.10] ([95.157.57.47]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lr2VT-1fOnPw3YCx-00egOh; Sun, 26
 Aug 2018 19:49:35 +0200
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        linux-serial <linux-serial@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Allen Yan <yanwei@marvell.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Marc Zyngier <marc.zyngier@arm.com>
From:   Jan Kiszka <jan.kiszka@web.de>
Subject: [PATCH] serial: mvebu-uart: Fix reporting of effective CSIZE to
 userspace
Message-ID: <69ad54af-8732-b78a-7e0b-482bfcd6d25f@web.de>
Date:   Sun, 26 Aug 2018 19:49:32 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); de; rv:1.8.1.12)
 Gecko/20080226 SUSE/2.0.0.12-1.1 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:/1wzGfA1m8BFalUCSPUAJIFTrKtd06TEoXt9X1tkLOUSfKSUQEG
 bO8Z6uZ0O2Jqv9f0RSHBwK6PG+mca9tew/MRbdI6E2jtEceKaNSav70LWEVojnZuicSeJcD
 jqxDcJsGhByP4wlpKZZbtMnwo4Ro/CyaTh+5VoaqCKnzLq7l4pJDBxEYK6dBHvCKepePSpo
 MfsHw9J1Tas/BVx/ggCSQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kTIMRJ48ViQ=:Jkf2QRpK6NU/XXOiFP78a9
 YdBaMbXxk5Zz2iBnNq24j2N1cG601iC7iqSBMoWvI8E/+GsWOvvcGjzTl8Ho6zgQHtzNjbEWF
 Mpjdpd1sLUgu7nmZtRAUKKKYGMGK5urg7gPZvANrjSoDhgVQ8fNTV27hTOgupI11ytIS2XwE0
 N+T7bJlw9r02n+HXRQShzN5hVmnbJ+hZdBW5EKmVXXSfrhJB5b1+NAFz5Aw5FoTkcth8Utenz
 58l7mGFNU5AkBrl6L+gVLIVz/RCUQagkuM8YtRfQTQG3HR77QjZHW4NtaO2Mi7FHioSqeWQSv
 5XQOt7SkIn7hkIlOYgDnnph8LNRnwoErF/hPq8F05CsyhL3hnxROSPbC2dziorRL7Rbv9e/Jb
 GZBzdOEQArRMT4p4CHV2Y5lzprUDNGcmttEnWrXmLFsMO0+QlZE608jd+Dy21SpYO07F/h+0X
 pytKj9p05fIzN1kvEBwALY5HhKCbiXE9qBGpTBaJDgxU/MEZnJh3JgjyzcqJ9Y1KzoXRwPwWI
 KrOw/zlrmxzXB5+v0CIdXvSPFBv3kgi+o0UUELbRahPVuBBcaW8EkVoBd0hDb9TgmHPAFYjO6
 Ucey32SMnMAjlY+1tkjnBYLBY47Vse9oKrlP26yXFncoFzcdgKSdVrM5LH+R3yd96HgkN4u5C
 q41wl1lJYaf7L1RDb3fAXjPijdY/SpDojogpkuu05jbFa7R+xEaNrwZwnKJ1JzJySh5Q5rp9G
 kXu1t1f3+NWecyzlWgTkkn7fh1PBLfThlMDlf3o9VJes/fS28FSannloFfICOvWWJili5kchn
 lumTztA
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kiszka <jan.kiszka@siemens.com>

Apparently, this driver (or the hardware) does not support character
length settings. It's apparently running in 8-bit mode, but it makes
userspace believe it's in 5-bit mode. That makes tcsetattr with CS8
incorrectly fail, breaking e.g. getty from busybox, thus the login shell
on ttyMVx.

Fix by hard-wiring CS8 into c_cflag.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

It's a bit of a shame that still maturing drivers can break userspace
that easily and subtly. I had to debug my way from old but working
buildroot to busybox, libc (tcsetattr) and then finally this driver.
This wasn't the first bug of this kind, and maybe it's not the last (I
didn't check all that termio flags). Could the kernel help in some way
with sanity checks or sane defaults driver have to make insane
willingly?

 drivers/tty/serial/mvebu-uart.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
index d04b5eeea3c6..170e446a2f62 100644
--- a/drivers/tty/serial/mvebu-uart.c
+++ b/drivers/tty/serial/mvebu-uart.c
@@ -511,6 +511,7 @@ static void mvebu_uart_set_termios(struct uart_port *port,
 		termios->c_iflag |= old->c_iflag & ~(INPCK | IGNPAR);
 		termios->c_cflag &= CREAD | CBAUD;
 		termios->c_cflag |= old->c_cflag & ~(CREAD | CBAUD);
+		termios->c_cflag |= CS8;
 	}
 
 	spin_unlock_irqrestore(&port->lock, flags);
