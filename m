Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754061AbeDYXgL convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 19:36:11 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:7961 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752958AbeDYXgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 19:36:08 -0400
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 25 Apr 2018 16:36:06 -0700
From: Rohit Khanna <rokhanna@nvidia.com>
To: "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Thierry Reding" <treding@nvidia.com>,
        Alexander Van Brunt <avanbrunt@nvidia.com>, "Bo Yan" <byan@nvidia.com>,
        Jason Sequeira <jsequeira@nvidia.com>
Subject: Re: [PATCH] arm64: skip cpu nodes marked as disabled in DT
Thread-Topic: [PATCH] arm64: skip cpu nodes marked as disabled in DT
Thread-Index: AQHT3OpPpC2oxqlzZUeaW3pC5uzQlqQSIj0r
Date: Wed, 25 Apr 2018 23:36:06 +0000
Message-ID: <1524699380207.85374@nvidia.com>
References: <1524697712-20208-1-git-send-email-rokhanna@nvidia.com>
In-Reply-To: <1524697712-20208-1-git-send-email-rokhanna@nvidia.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.17.136.184]
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding few other folks.

Thanks
Rohit
________________________________________
From: Rohit Khanna
Sent: Wednesday, April 25, 2018 4:08 PM
To: catalin.marinas@arm.com; will.deacon@arm.com
Cc: linux-kernel@vger.kernel.org; Rohit Khanna
Subject: [PATCH] arm64: skip cpu nodes marked as disabled in DT

Skip the CPU nodes that are marked as disabled in DT.

Bug 1828570

Signed-off-by: Rohit Khanna <rokhanna@nvidia.com>
Reviewed-on: http://git-master/r/1245333
Reviewed-by: Alexander Van Brunt <avanbrunt@nvidia.com>
---
 arch/arm64/kernel/smp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index f3e2e3aec0b0..2b4371b0948d 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -578,6 +578,10 @@ static void __init of_parse_and_init_cpus(void)
        for_each_node_by_type(dn, "cpu") {
                u64 hwid = of_get_cpu_mpidr(dn);

+               /* Check to see if the cpu is disabled */
+               if (!of_device_is_available(dn))
+                       goto next;
+
                if (hwid == INVALID_HWID)
                        goto next;

--
2.1.4
