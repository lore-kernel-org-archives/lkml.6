Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1166082AbeE1PMf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 11:12:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:42992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033291AbeE1KXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:23:38 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kamlakant Patel <kamlakant.patel@cavium.com>,
        Corey Minyard <cminyard@mvista.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 212/268] ipmi_ssif: Fix kernel panic at msg_done_handler
Date: Mon, 28 May 2018 12:03:06 +0200
Message-Id: <20180528100226.166139233@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100202.045206534@linuxfoundation.org>
References: <20180528100202.045206534@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kamlakant Patel <kamlakant.patel@cavium.com>

[ Upstream commit f002612b9d86613bc6fde0a444e0095225f6053e ]

This happens when BMC doesn't return any data and the code is trying
to print the value of data[2].

Getting following crash:
[  484.728410] Unable to handle kernel NULL pointer dereference at virtual address 00000002
[  484.736496] pgd = ffff0000094a2000
[  484.739885] [00000002] *pgd=00000047fcffe003, *pud=00000047fcffd003, *pmd=0000000000000000
[  484.748158] Internal error: Oops: 96000005 [#1] SMP
[...]
[  485.101451] Call trace:
[...]
[  485.188473] [<ffff000000a46e68>] msg_done_handler+0x668/0x700 [ipmi_ssif]
[  485.195249] [<ffff000000a456b8>] ipmi_ssif_thread+0x110/0x128 [ipmi_ssif]
[  485.202038] [<ffff0000080f1430>] kthread+0x108/0x138
[  485.206994] [<ffff0000080838e0>] ret_from_fork+0x10/0x30
[  485.212294] Code: aa1903e1 aa1803e0 b900227f 95fef6a5 (39400aa3)

Adding a check to validate the data len before printing data[2] to fix this issue.

Signed-off-by: Kamlakant Patel <kamlakant.patel@cavium.com>
Signed-off-by: Corey Minyard <cminyard@mvista.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/ipmi/ipmi_ssif.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -757,7 +757,7 @@ static void msg_done_handler(struct ssif
 			ssif_info->ssif_state = SSIF_NORMAL;
 			ipmi_ssif_unlock_cond(ssif_info, flags);
 			pr_warn(PFX "Error getting flags: %d %d, %x\n",
-			       result, len, data[2]);
+			       result, len, (len >= 3) ? data[2] : 0);
 		} else if (data[0] != (IPMI_NETFN_APP_REQUEST | 1) << 2
 			   || data[1] != IPMI_GET_MSG_FLAGS_CMD) {
 			/*
@@ -779,7 +779,7 @@ static void msg_done_handler(struct ssif
 		if ((result < 0) || (len < 3) || (data[2] != 0)) {
 			/* Error clearing flags */
 			pr_warn(PFX "Error clearing flags: %d %d, %x\n",
-			       result, len, data[2]);
+			       result, len, (len >= 3) ? data[2] : 0);
 		} else if (data[0] != (IPMI_NETFN_APP_REQUEST | 1) << 2
 			   || data[1] != IPMI_CLEAR_MSG_FLAGS_CMD) {
 			pr_warn(PFX "Invalid response clearing flags: %x %x\n",
