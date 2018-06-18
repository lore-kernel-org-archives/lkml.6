Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8A1C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB244208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:54:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB244208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967875AbeFRIyK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:54:10 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35880 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967762AbeFRIex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:34:53 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4075DC49;
        Mon, 18 Jun 2018 08:34:52 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Helge Deller <deller@gmx.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 104/189] parisc: drivers.c: Fix section mismatches
Date:   Mon, 18 Jun 2018 10:13:20 +0200
Message-Id: <20180618081213.454407889@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618081209.254234434@linuxfoundation.org>
References: <20180618081209.254234434@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Helge Deller <deller@gmx.de>

[ Upstream commit b819439fea305a0bfd6ca23a7994fd1a8847c0d8 ]

Fix two section mismatches in drivers.c:
1) Section mismatch in reference from the function alloc_tree_node() to
   the function .init.text:create_tree_node().
2) Section mismatch in reference from the function walk_native_bus() to
   the function .init.text:alloc_pa_dev().

Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/parisc/kernel/drivers.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/arch/parisc/kernel/drivers.c
+++ b/arch/parisc/kernel/drivers.c
@@ -448,7 +448,8 @@ static int match_by_id(struct device * d
  * Checks all the children of @parent for a matching @id.  If none
  * found, it allocates a new device and returns it.
  */
-static struct parisc_device * alloc_tree_node(struct device *parent, char id)
+static struct parisc_device * __init alloc_tree_node(
+			struct device *parent, char id)
 {
 	struct match_id_data d = {
 		.id = id,
@@ -825,8 +826,8 @@ void walk_lower_bus(struct parisc_device
  * devices which are not physically connected (such as extra serial &
  * keyboard ports).  This problem is not yet solved.
  */
-static void walk_native_bus(unsigned long io_io_low, unsigned long io_io_high,
-                            struct device *parent)
+static void __init walk_native_bus(unsigned long io_io_low,
+	unsigned long io_io_high, struct device *parent)
 {
 	int i, devices_found = 0;
 	unsigned long hpa = io_io_low;


