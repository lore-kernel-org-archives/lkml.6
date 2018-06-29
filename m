Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5320AC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 02:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAB8527AE1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 02:22:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAB8527AE1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030674AbeF2CWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 22:22:02 -0400
Received: from gate.crashing.org ([63.228.1.57]:51735 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030492AbeF2CWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 22:22:00 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w5T2LpSb022154;
        Thu, 28 Jun 2018 21:21:52 -0500
Message-ID: <828fb935c0cd04e74a09b8ed2b78aca405d7c5b2.camel@kernel.crashing.org>
Subject: [PATCH 1/2] drivers: core: Don't try to use a dead glue_dir
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Joel Stanley <joel@jms.id.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Fri, 29 Jun 2018 12:21:51 +1000
In-Reply-To: <CA+55aFxR0qg0yY-NWnH0DDruVWw8qRqp8=CRLq13p=TyxosJKw@mail.gmail.com>
References: <c40fe912fe008b1b531a3867e8784ed79d68023e.camel@kernel.crashing.org>
         <CA+55aFxR0qg0yY-NWnH0DDruVWw8qRqp8=CRLq13p=TyxosJKw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.3 (3.28.3-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Under some circumstances (such as when using kobject debugging)
a gluedir whose kref is 0 might remain in the class kset for
a long time. The reason is that we don't actively remove glue
dirs when they become empty, but instead rely on the implicit
removal done by kobject_release(), which can happen some amount
of time after the last kobject_put().

Using such a dead object is a bad idea and will lead to warnings
and crashes.

Unfortunately that can happen in get_device_parent() if the
last child of a glue dir was removed and a new one added
before the glue dir gets fully released().

This prevents this by making get_device_parent() only "find"
a glue dir whose refcount is non-0.

While this fixes the crash, it doesn't fully fix the problem,
instead the race will now result in an error attempting to
use a duplicate file name in sysfs. A fix for that will come
separately.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

(Adding lkml, I just realized I completely forgot to CC it in
the first place on this whole conversation, blame the 1am debugging
session)

 drivers/base/core.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index b610816eb887..e9eff2099896 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1517,11 +1517,13 @@ static struct kobject *get_device_parent(struct device *dev,
 
 		/* find our class-directory at the parent and reference it */
 		spin_lock(&dev->class->p->glue_dirs.list_lock);
-		list_for_each_entry(k, &dev->class->p->glue_dirs.list, entry)
+		list_for_each_entry(k, &dev->class->p->glue_dirs.list, entry) {
 			if (k->parent == parent_kobj) {
-				kobj = kobject_get(k);
-				break;
+				kobj = kobject_get_unless_zero(k);
+				if (kobj)
+					break;
 			}
+		}
 		spin_unlock(&dev->class->p->glue_dirs.list_lock);
 		if (kobj) {
 			mutex_unlock(&gdp_mutex);

