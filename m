Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC3ABC43444
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 05:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5CE820840
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 05:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbfAPFHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 00:07:51 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:62245 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726098AbfAPFHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 00:07:51 -0500
X-UUID: 68876a9224414edaa0599104b6fee120-20190116
X-UUID: 68876a9224414edaa0599104b6fee120-20190116
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 338028225; Wed, 16 Jan 2019 13:07:24 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 16 Jan 2019 13:07:22 +0800
Received: from mtkslt305.mediatek.inc (10.21.14.140) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 16 Jan 2019 13:07:22 +0800
From:   CK Hu <ck.hu@mediatek.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Houlong Wei <houlong.wei@mediatek.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <srv_heupstream@mediatek.com>
Subject: [PATCH 0/3] Remove self-implemented queue of Mediatek cmdq
Date:   Wed, 16 Jan 2019 13:04:32 +0800
Message-ID: <20190116050435.11624-1-ck.hu@mediatek.com>
X-Mailer: git-send-email 2.18.1
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 40BE542FA8CC37D07A572001D38682359D0C9AD5F26DB401626979ACFB8570DA2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mediatek mailbox controller implement its own data queue rather than using
mailbox framework's queue. This series let the framework provide abort
function and Mediatek mailbox controller implement the abort-function, so
it could use framework's queue.

The reason that Mediatek mailbox controller has to implement its own queue:
One client of Mediatek mailbox controller is display driver. When a cursor
is moving, display continuously update the register related to the cursor.
Display hardware has a limitation that register should be updated in the
vblank period which is a small interval. In tradition, display hardware
would trigger an interrupt when vblank start, and driver could update
register in this irq handler. But the interrupt handler has the risk that
it could be delayed by some reason so the handler may be postponed out of
this vblank interval. In order to reduce the risk, display driver use GCE
hardware to write register. If a cursor move 3 times before vblank,
display driver would send 3 messages sequentially to mailbox controller.
If the controller use framework's queue, controller just receive the
first message and the others is queued in framework. The first message
could be executed exactly in vblank interval but the other messages are
sent to controller when controller notify framework tx_done in interrupt
handler. The interrupt may be postponed by some reason this is what we
worried. So Mediatek mailbox controller has to implement its own queue to
make sure that all message execute in vblank interval.

The reason that abort-function could let Mediatek mailbox controller use
framework's queue:
The primary concept is to let display driver send at most one message to
mailbox controller. When it need to send the second message before the
first message is done, it should abort the first message and then send the
second message which should merge the first message. For other client
driver, it could still send multiple messages into framework's queue.

CK Hu (3):
  mailbox: Add ability for clients to abort data in channel
  mailbox: mediatek: Implement abort_data function.
  mailbox: mediatek: Remove busylist

 drivers/mailbox/mailbox.c          |  23 +++
 drivers/mailbox/mtk-cmdq-mailbox.c | 281 +++++++----------------------
 include/linux/mailbox_client.h     |   1 +
 include/linux/mailbox_controller.h |   4 +
 4 files changed, 90 insertions(+), 219 deletions(-)

-- 
2.18.0

