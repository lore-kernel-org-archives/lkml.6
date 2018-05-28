Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424394AbeE1LkY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:40:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:59968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932380AbeE1LMJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:12:09 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bob Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 152/272] ACPICA: Fix memory leak on unusual memory leak
Date: Mon, 28 May 2018 12:03:05 +0200
Message-Id: <20180528100253.697395161@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bob Moore <robert.moore@intel.com>

[ Upstream commit 1c29c372b2d1d2415601041532745ce859f24126 ]

Fixes a single-object memory leak on a store-to-reference method
invocation. ACPICA BZ 1439.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/acpi/acpica/psargs.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/acpi/acpica/psargs.c
+++ b/drivers/acpi/acpica/psargs.c
@@ -890,6 +890,10 @@ acpi_ps_get_next_arg(struct acpi_walk_st
 						      ACPI_POSSIBLE_METHOD_CALL);
 
 			if (arg->common.aml_opcode == AML_INT_METHODCALL_OP) {
+
+				/* Free method call op and corresponding namestring sub-ob */
+
+				acpi_ps_free_op(arg->common.value.arg);
 				acpi_ps_free_op(arg);
 				arg = NULL;
 				walk_state->arg_count = 1;
