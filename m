Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18447C46465
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 09:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD34B2081C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 09:06:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD34B2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbeKHSju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 13:39:50 -0500
Received: from relay.sw.ru ([185.231.240.75]:36762 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726630AbeKHSjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 13:39:48 -0500
Received: from [172.16.25.169] (helo=localhost.localdomain)
        by relay.sw.ru with esmtp (Exim 4.90_1)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1gKgFW-00062G-UO; Thu, 08 Nov 2018 12:05:15 +0300
Content-Transfer-Encoding: 7bit
Subject: [PATCH v2 0/5] fuse: Interrupt-related optimizations and
 improvements
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     miklos@szeredi.hu, ktkhai@virtuozzo.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 08 Nov 2018 12:05:14 +0300
Message-ID: <154166765576.10655.15178401490817622677.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2: Changes in [1-2,5] patches. The biggest change is in [5],
    where repeater FR_INTERRUPTED assignment is removed.

This patchset consists of several parts. Patches [1-2] optimize
likely case of request_end(), and make this function to take
fiq->waitq.lock only, when it is really needed. This improves
performance of this function completes.

Patch 3 makes request_end() to call wake_up() only for not
background requests (background requests never wait answer),
and this optimizes this function a bit more

Patches [4-5] makes code to check userspace requests correct
interrupt id to requeue (whether we've sent this interrupt).

---

Kirill Tkhai (5):
      fuse: Kill fasync only if interrupt is queued in queue_interrupt()
      fuse: Optimize request_end() by not taking fiq->waitq.lock
      fuse: Wake up req->waitq of only not background requests in request_end()
      fuse: Do some refactoring in fuse_dev_do_write()
      fuse: Verify userspace asks to requeue interrupt that we really sent


 fs/fuse/dev.c |   57 ++++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 38 insertions(+), 19 deletions(-)

--
Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
