Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755931AbeBOVKQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 16:10:16 -0500
Received: from mail-bl2nam02on0077.outbound.protection.outlook.com ([104.47.38.77]:8944
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752361AbeBOVKL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 16:10:11 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
From: Yazen Ghannam <Yazen.Ghannam@amd.com>
To: linux-edac@vger.kernel.org
Cc: Yazen Ghannam <Yazen.Ghannam@amd.com>, linux-kernel@vger.kernel.org,
        bp@suse.de, tony.luck@intel.com, x86@kernel.org
Subject: [PATCH v2 3/4] x86/MCE/AMD: Get address from already initialized block
Date: Thu, 15 Feb 2018 15:09:42 -0600
Message-Id: <20180215210943.11530-3-Yazen.Ghannam@amd.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180215210943.11530-1-Yazen.Ghannam@amd.com>
References: <20180215210943.11530-1-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: BN6PR21CA0011.namprd21.prod.outlook.com
 (2603:10b6:404:8e::21) To MWHPR12MB1917.namprd12.prod.outlook.com
 (2603:10b6:300:114::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a0693baf-26d7-408d-ba20-08d574b87dc2
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:MWHPR12MB1917;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1917;3:dgG0SL/4kIHZIx0543EjpgM74n3JYs8c6uU5vsGiVHK7vt51tuAvS0tUS77BnMGcV13cqO+nAUlIiZIWxprjT1VLojH0NJb+VNFM+tuFQZ9MCAkPWq85TPzR8GXFlLClA7rHZlwyvieqpm1D42UdiZeRNcMaqXb+P2+VlTP2bmZMjXmDSywaCIkJ6ahBhScEOvxym6bXny3QduaLl378E4s5tOtz1zmZFcCLU+cATak4IDcvyD3HitW32FC1mliP;25:Y+XTdWb6kWToLIUtflQAS+9GqhTKld6Z9UXNJprnnJ+Fj34UozQpzwE8ipnw3i1hhyVbxQe1YCfXjLlhhjcWq6G62CtJuIkZDXNSUtXpfZXGQjLTFaf5sC4yj5ksNpJLlMkfB23ANM6x7EEa1/EKLRXUQ+gAp7XmZzntctNbPUfDfDWlrFwOFlcl3f/BIQnlF5AH1usOrlNGV3NSgNklOzWafwlbk8z4zu23P1oeLO+CdW/Hn/BbVmqetQ5dlo5UkO2tFglINqKhGnTmuf3TSpi3MkDx01mDVgYsSNGB1z5DhvBCBCH8C4/FjdKo3KTU0o9sRXAHfGuANILYOSMb/A==;31:3ZlO4sDI8CCcC4HDFmjTP1u00K/VYQgTiczjoy2PyO1WVR0xzId/U0rFwVz/bUPrC9tVbswhTZwpWfuZAaA+5DHECGG2HSXK+p0LmpUqB1PsA8tlNTGbI9iqh4rlKTdrvVnxlPfgcwHvG7Ivp6n5pSxtDoZtDgp5hCisunRP+l5moi/8y2mAujxIvJBwDZqFjb8slUK+ff5bEedssNPJa6b/cGxoUjuTgmjLsHakUmk=
X-MS-TrafficTypeDiagnostic: MWHPR12MB1917:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1917;20:l754n6Yob2BZWhqcqRiR6TE4h/pTzqgFhCHCYpfPqp/HCcdHvpRBDEGtRx7B6vu9pPgM0wIsiTjqx/7yEvY8Y9R03WjACvL5tfxwvv/zfDtdJVhe5Iwk+q2cWZ3xcA81Vcfnki0O0s5B1mV+x/Gl+oqTs6VM9VkZGgKyIDjw9X3gFKkOgVSdL5ZR5Qu80GHtvHW+LCTvIWxc3tqj6/oYioJJPXrwDmfMFYAbm5OnYKa9mt6iBDu4AMFQnXN0BWIARJs71XdVzTqvYasOk3LuxPSgJax8UPFSXnYeWMTEa0oL8SoPEzGNWnSCWp8uoN3Pcp++cdP8bJUaE6YBh+idCVOTWrmOjSA4cOxqQVmb5TzTqu8/Z5yr10u8INEd76ZHhmyWT6D1GU9YKnEcsX4vLuZAskREcIuWmkP8uZEl011/2ZjNIGZEFTWfS5K7ZyRdadq6PquLVXkhSKiwBkiy4SGVnly418oWYHY7udOvhdRHVXnvHx46Y/QKAP+uQwdY;4:IDkepkZGdmh3TFxZKmsVav66u5nckHQyX1ajaEukSpRaA7oectvaLHHBj3e8ehRntfmJQ63dyYSkFAEsGtFHQ19BWtULdsZpLia3KMcNZNnWZEFNZ5Oht7F1Dz0ujUOk0w5dpSYZTUpVZKUZfH6sDvSq/arq5SKQ/OkNnWBC89lQcBuKcItFXbFBAGNJw/83W1oHmVO4aITPZQKdkG4sNfGNhk2bIdFJw+zGAhuNuY20U5kaBTfC3Jf9BOLmgmmU443LTCD/HBS7vxgVqz+wVM1myNmF0D7h9tSEOeAeknOsLkGP55kAx1wLGC22waoSpnNaW5slQNl5RN7vYKIS4k7GIdoDUI4CxXdxw0AtYhJ9oKN6Zldbz6vPeXp0M1Vb
X-Microsoft-Antispam-PRVS: <MWHPR12MB1917C74826A257BF4138F1A3F8F40@MWHPR12MB1917.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(767451399110)(42068640409301);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3231101)(944501161)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:MWHPR12MB1917;BCL:0;PCL:0;RULEID:;SRVR:MWHPR12MB1917;
X-Forefront-PRVS: 058441C12A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(396003)(346002)(376002)(39380400002)(39860400002)(189003)(199004)(76176011)(50466002)(5660300001)(2361001)(97736004)(6306002)(48376002)(53416004)(6666003)(305945005)(2950100002)(6486002)(2906002)(4326008)(1076002)(53936002)(966005)(6116002)(7736002)(3846002)(2351001)(106356001)(16586007)(66066001)(47776003)(86362001)(316002)(575784001)(478600001)(7696005)(51416003)(50226002)(386003)(72206003)(6916009)(105586002)(26005)(8936002)(8676002)(81166006)(186003)(52116002)(81156014)(68736007)(59450400001)(16526019)(25786009)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1917;H:yaz-diesel.amd.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR12MB1917;23:UZEtRTTGDxuJBUz2Zi6WPmkXrtvCL0MjZLh80ARKE?=
 =?us-ascii?Q?URIh5CBBG441YaKzf8qbOzDAHKNZVWcxd5A7ehOMp4RkHiet18ogd7a5Joti?=
 =?us-ascii?Q?SqQoiadeYwzo9mw7hFfmH9My7AAl0cdDbYBOfIm6ejPmBxhBP/DrxhmYd9mB?=
 =?us-ascii?Q?ExmSQjCgqT5qCw6fbekYdL2WKHFb8R95iwj2a9rayhBpDgMtu31pwGw67Qs3?=
 =?us-ascii?Q?Dh1Z9p/PiMPuEzeSMrDis/19/btPf+wd0fY286WLmYcGOFgTiwucE3DAtILl?=
 =?us-ascii?Q?B5NNbASuX+ve1f1+somU9QDDIr5FERxjR0vOQ/B+nFapXz49JwO0xf3C797a?=
 =?us-ascii?Q?iY2UQ57KpyY1Xixu5yvWo8e1FC6HBu9XMJXiqCtpgxYuF1SBNeyZQ7qZSNT1?=
 =?us-ascii?Q?hy4lQ5yTacAdvzmro7kxCAa0fDFbqNqAUugvCWRohj4WPpKcD0Xjj628UaxR?=
 =?us-ascii?Q?OyYtqxHnFb+gDXwj7obA5xtAFDC7yrnsrb9CUN3xscQgp5D2rsH8cA47Ff/p?=
 =?us-ascii?Q?cTsgEEfOF5O3EnFXO9MymOIHjaageVbjcsMl+zksBJYc9/3E1SX2l9mVV9XH?=
 =?us-ascii?Q?yHd/JNWbnQopXTG8MyftaeEWTVwcRPRArwWH1AV1p51f1EIM7FtQ6rmPuuT+?=
 =?us-ascii?Q?A/zwc+Z2mv0JS6JljVpEHS8zXobv+zcLTNBs6dLsSdLSCW88QPy1KSZZuJag?=
 =?us-ascii?Q?/B7+DZsoOQCOyUVnA5EiycS4ml0TCSpzPp/z9PS0WzIuan9VAqj33xnipqpM?=
 =?us-ascii?Q?9nuw2bcyiuCFGiwJKNdhPIcuu5E/CZ/lDgfvOhJ4BDqw1XS2o7bRoQvX0flb?=
 =?us-ascii?Q?MSMFmr8Yr3350CDZAWpzFb6xYZS/jj1eav5t88l0QT0fLBdkFVpDPZFoWkcn?=
 =?us-ascii?Q?Kb11Pq8bzdy/Ii22tBTn3RKdO2umjO66flI5s0Mhb2kgV7mWrAF0UnMU1h+U?=
 =?us-ascii?Q?jQntbYJ7ihTIya9nfyHXbkbC6X9PJG+QNUXpSncT7wCOs8toVRgiRy9GjfjS?=
 =?us-ascii?Q?/8blCqti6o9GFMBfMC0gsjqtnKnw6SN4zFSgFazFblyEq008iWqfjtvIgZBM?=
 =?us-ascii?Q?TVnsh/uaR+yHP37fwDFTYuxItHMRJPCjo4tOEfS5XH1Ko1RCISrWCagoO8BE?=
 =?us-ascii?Q?d9UvZOMC3mN1vPkqjtrQGSAiPR1sYK1Trj8t4EZVCnBgN9lSYGNafgW7+xAu?=
 =?us-ascii?Q?wUZ8gzbS5oLUpgwGzz6b/xq6E2MXIrWwBIKIzV2Y+Aw7GGHln95KuCcMwZTe?=
 =?us-ascii?Q?GfT4Cm2fhfd04nwqGbmtMv3U3Ru74O9nw8NOdj3?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1917;6:vo8h+2+ZrMtd141AqvnfFGWUZgkL2nElKP7e4MFYHNULNylZXE7CHtWoYQ45FkzEpdvBUuv9ATJh0OAo4zapmmsF5jR9KPfASUBpgCcqRDIFIIOd1vcQ3xWEBk1ODZGyh+ubyEaGq0nAdIe0xqoW3LqTqd/o6/+TEjYyKUItut7mpUBr2wXYXbM7tqfQwM92mS1Uknwt0lbMXGhjby1PUplkcnVyrRCoHgHrdRMmLAv//TxlNKxFeNm/k0cFa/zGK4y8fymLX4PrnQDOJx0CZvU76zYn1AE/JBKapNVJJk8OyT5kE2Pry3mcRSBwsN42GMcEdCgR/AbiPJgZ9GrHSkDmxdKDjCXEXo79ZBwsBhc=;5:J0mQAbUC42oGmfMPjEBLhd7WfGKiRMaungZhafXXO1pUd9sS1JCgabRayFKXaSmZZdaum1Rhwv8OBKtAE2jqDln9cnxaxiuJnIW1ZWAFM8Zqq9FgneoeOSLHH9e3sEp0elx3RzUx+uYir8u6Est8ZSvp1vD/FAQ0HUM6p7hgwAQ=;24:VctTInuXRH3CGigyGWaPQdCjxYDpfh0FHjWTN+BB0x+rVS2HYB6gY/O8hRxiG9dVFnWVGfQxs4s70aBrwi7FWGo9aeUGad98N4vdNqQZESQ=;7:hwLWLSqBCpaG0awbYdbYzdoZK9FKCnFVyMvmiFS7uMZheNGe/gJqJesOU/B+Mlvqi1BleS0nfYgj8KTgZkV1sly9FdidN5SwQfzfebICqzD8K1LHYG23Pq7Zp1I+JHs0DpFaam/nB1G8XsMKAlU05dH2qp22spurRuvRYoVDIUPGpAnSMNtpTgSSzV+YrXAOFw4QOT/tCoFEy/JYgh+3I9lTi/IDMj+xDeO2aORU4IWzuulQby/K8SYD0NG1JTCO
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1917;20:cgklrYUtJDV/0Un17BarS8wamo50ZY1HbcTRFiIu2b/sWhrxSMt69VHibVf0vF4m0kWxMcTkoiiWDK6AC3O7kGNbweAC9FRL6g+3znGgYPPZIHHUnJEFY+lcEJVEqfrrfKMv9flstM/ZqvIMqoFBVctMRD4LSWwU/kuw7OGSTiCTyEHCkwmxIUeO4Zxd0A/Dwqg7Ajc6hUKzTIinkf1bTTITCfWWjjuPfFSpViYlIywmgZIm+FbD3o5yuHtlJjYF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2018 21:10:06.5511 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0693baf-26d7-408d-ba20-08d574b87dc2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1917
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

The block address is saved after the block is initialized when
threshold_init_device() is called.

Use the saved block address, if available, rather than trying to
rediscover it.

This will avoid a call trace, when resuming from suspend, due to the
rdmsr_safe_on_cpu() call in get_block_address(). The rdmsr_safe_on_cpu()
call issues an IPI but we're running with interrupts disabled.
This triggers:

    WARNING: CPU: 0 PID: 11523 at kernel/smp.c:291
    smp_call_function_single+0xdc/0xe0

Cc: <stable@vger.kernel.org> # 4.14.x
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20180201184813.82253-3-Yazen.Ghannam@amd.com

v1->v2:
* Give more detail on call trace issue.

 arch/x86/kernel/cpu/mcheck/mce_amd.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/x86/kernel/cpu/mcheck/mce_amd.c b/arch/x86/kernel/cpu/mcheck/mce_amd.c
index d8ba9d0c3f01..12bc2863a4d6 100644
--- a/arch/x86/kernel/cpu/mcheck/mce_amd.c
+++ b/arch/x86/kernel/cpu/mcheck/mce_amd.c
@@ -436,6 +436,21 @@ static u32 get_block_address(unsigned int cpu, u32 current_addr, u32 low, u32 hi
 {
 	u32 addr = 0, offset = 0;
 
+	if ((bank >= mca_cfg.banks) || (block >= NR_BLOCKS))
+		return addr;
+
+	/* Get address from already initialized block. */
+	if (per_cpu(threshold_banks, cpu)) {
+		struct threshold_bank *bankp = per_cpu(threshold_banks, cpu)[bank];
+
+		if (bankp && bankp->blocks) {
+			struct threshold_block *blockp = &bankp->blocks[block];
+
+			if (blockp)
+				return blockp->address;
+		}
+	}
+
 	if (mce_flags.smca) {
 		if (smca_get_bank_type(bank) == SMCA_RESERVED)
 			return addr;
-- 
2.14.1
