Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937143AbeE1K2Q (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:28:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:47448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937098AbeE1K2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:28:01 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, mulhern <amulhern@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 040/329] dm thin: fix documentation relative to low water mark threshold
Date: Mon, 28 May 2018 11:59:29 +0200
Message-Id: <20180528100245.797727320@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100241.796630982@linuxfoundation.org>
References: <20180528100241.796630982@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: mulhern <amulhern@redhat.com>

[ Upstream commit 9b28a1102efc75d81298198166ead87d643a29ce ]

Fixes:
1. The use of "exceeds" when the opposite of exceeds, falls below,
was meant.
2. Properly speaking, a table can not exceed a threshold.

It emphasizes the important point, which is that it is the userspace
daemon's responsibility to check for low free space when a device
is resumed, since it won't get a special event indicating low free
space in that situation.

Signed-off-by: mulhern <amulhern@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/device-mapper/thin-provisioning.txt |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/Documentation/device-mapper/thin-provisioning.txt
+++ b/Documentation/device-mapper/thin-provisioning.txt
@@ -112,9 +112,11 @@ $low_water_mark is expressed in blocks o
 free space on the data device drops below this level then a dm event
 will be triggered which a userspace daemon should catch allowing it to
 extend the pool device.  Only one such event will be sent.
-Resuming a device with a new table itself triggers an event so the
-userspace daemon can use this to detect a situation where a new table
-already exceeds the threshold.
+
+No special event is triggered if a just resumed device's free space is below
+the low water mark. However, resuming a device always triggers an
+event; a userspace daemon should verify that free space exceeds the low
+water mark when handling this event.
 
 A low water mark for the metadata device is maintained in the kernel and
 will trigger a dm event if free space on the metadata device drops below
