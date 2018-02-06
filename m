Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752789AbeBFSEs convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 13:04:48 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:47560 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752481AbeBFSEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 13:04:41 -0500
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Ville =?ISO-8859-1?Q?Syrj=E4l=E4?=
        <ville.syrjala@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        x86 <x86@kernel.org>, Jiri Koshina <jikos@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86: PM: Make APM idle driver initialize polling state
Date: Tue, 06 Feb 2018 19:02:58 +0100
Message-ID: <1862424.1bTBpgPzTf@aspire.rjw.lan>
In-Reply-To: <20180206163134.GO5453@intel.com>
References: <20180122162747.19103-1-ville.syrjala@linux.intel.com> <36158666.hf5grRdGNf@aspire.rjw.lan> <20180206163134.GO5453@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Update the APM driver overlooked by commit 1b39e3f813b4 (cpuidle: Make
drivers initialize polling state) to initialize the polling state like
the other cpuidle drivers modified by that commit to prevent cpuidle
from crashing.

Fixes: 1b39e3f813b4 (cpuidle: Make drivers initialize polling state)
Reported-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Tested-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 arch/x86/kernel/apm_32.c |    1 +
 1 file changed, 1 insertion(+)

Index: linux-pm/arch/x86/kernel/apm_32.c
===================================================================
--- linux-pm.orig/arch/x86/kernel/apm_32.c
+++ linux-pm/arch/x86/kernel/apm_32.c
@@ -2389,6 +2389,7 @@ static int __init apm_init(void)
 	if (HZ != 100)
 		idle_period = (idle_period * HZ) / 100;
 	if (idle_threshold < 100) {
+		cpuidle_poll_state_init(&apm_idle_driver);
 		if (!cpuidle_register_driver(&apm_idle_driver))
 			if (cpuidle_register_device(&apm_cpuidle_device))
 				cpuidle_unregister_driver(&apm_idle_driver);
