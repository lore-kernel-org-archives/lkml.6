Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2934EC43612
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 000C9214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbfAJKMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 05:12:37 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:40087 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727653AbfAJKMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 05:12:37 -0500
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1ghXKF-0003ib-6H; Thu, 10 Jan 2019 11:12:35 +0100
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.91)
        (envelope-from <ore@pengutronix.de>)
        id 1ghXKD-0002Tz-V9; Thu, 10 Jan 2019 11:12:33 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/3] reduce tty latency 
Date:   Thu, 10 Jan 2019 11:12:29 +0100
Message-Id: <20190110101232.9398-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set is reducing latency on tty path.
For testing I used hackbench running on all cores of 4 core system and
high prioritized application sending and receiving packets over tty interface
with loop-back adapter.

Results without this patches:
        latency histogram:
            0 ... <     250 usec : 1933104 transmissions
          250 ... <     500 usec : 21339 transmissions
          500 ... <     750 usec : 8952 transmissions
          750 ... <    1000 usec : 6226 transmissions
         1000 ... <    1500 usec : 7688 transmissions
         1500 ... <    2000 usec : 5236 transmissions
         2000 ... <    5000 usec : 11724 transmissions
         5000 ... <   10000 usec : 3588 transmissions
        10000 ... <   50000 usec : 2123 transmissions
        50000 ... < 1000000 usec : 20 transmissions
                 >= 1000000 usec : 0 transmissions

Test results after this patches:
        min latency: 0 sec : 75 usec
        max latency: 0 sec : 125 usec
        average latency: 81 usec
        latency measure cycles overall: 79000000
        latency histogram:
            0 ... <     250 usec : 79000000 transmissions
          250 ... <     500 usec : 0 transmissions
          500 ... <     750 usec : 0 transmissions
          750 ... <    1000 usec : 0 transmissions
         1000 ... <    1500 usec : 0 transmissions
         1500 ... <    2000 usec : 0 transmissions
         2000 ... <    5000 usec : 0 transmissions
         5000 ... <   10000 usec : 0 transmissions
        10000 ... <   50000 usec : 0 transmissions
        50000 ... < 1000000 usec : 0 transmissions
                 >= 1000000 usec : 0 transmissions
        average no. of read calls to assemble the packet: 1 

Usage of real-time patches makes no difference for test case.

Oleksij Rempel (1):
  drivers/tty: increase priority for tty_buffer_worker

Steven Walter (2):
  drivers/tty: refactor functions for flushing/queuing work
  drivers/tty: convert tty_port to use kthread_worker

 drivers/tty/tty_buffer.c | 39 +++++++++++++++++++++++++++++++--------
 drivers/tty/tty_io.c     |  1 +
 include/linux/tty.h      |  8 +++++---
 3 files changed, 37 insertions(+), 11 deletions(-)

-- 
2.19.1

