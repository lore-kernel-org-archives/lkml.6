Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937217AbeE1K2l (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:28:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:47956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932390AbeE1K2e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:28:34 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Silvan Jegen <s.jegen@gmail.com>, Jiri Kosina <jkosina@suse.cz>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 054/329] HID: roccat: prevent an out of bounds read in kovaplus_profile_activated()
Date: Mon, 28 May 2018 11:59:43 +0200
Message-Id: <20180528100247.101023372@linuxfoundation.org>
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

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 7ad81482cad67cbe1ec808490d1ddfc420c42008 ]

We get the "new_profile_index" value from the mouse device when we're
handling raw events.  Smatch taints it as untrusted data and complains
that we need a bounds check.  This seems like a reasonable warning
otherwise there is a small read beyond the end of the array.

Fixes: 0e70f97f257e ("HID: roccat: Add support for Kova[+] mouse")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Silvan Jegen <s.jegen@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hid/hid-roccat-kovaplus.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/hid/hid-roccat-kovaplus.c
+++ b/drivers/hid/hid-roccat-kovaplus.c
@@ -37,6 +37,8 @@ static uint kovaplus_convert_event_cpi(u
 static void kovaplus_profile_activated(struct kovaplus_device *kovaplus,
 		uint new_profile_index)
 {
+	if (new_profile_index >= ARRAY_SIZE(kovaplus->profile_settings))
+		return;
 	kovaplus->actual_profile = new_profile_index;
 	kovaplus->actual_cpi = kovaplus->profile_settings[new_profile_index].cpi_startup_level;
 	kovaplus->actual_x_sensitivity = kovaplus->profile_settings[new_profile_index].sensitivity_x;
