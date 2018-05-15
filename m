Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753929AbeEOQFj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 12:05:39 -0400
Received: from mail-he1eur01on0054.outbound.protection.outlook.com ([104.47.0.54]:19657
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752015AbeEOQEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 12:04:39 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com;
From: Ayan Kumar Halder <ayan.halder@arm.com>
To: ayan.halder@arm.com, liviu.dudau@arm.com, brian.starkey@arm.com,
        malidp@foss.arm.com, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: nd@arm.com,
        Alexandru-Cosmin Gheorghe <Alexandru-Cosmin.Gheorghe@arm.com>
Subject: [PATCH v3 3/5] drm/arm/malidp: Enable/disable interrupts in runtime pm
Date: Tue, 15 May 2018 17:04:17 +0100
Message-Id: <1526400259-7573-4-git-send-email-ayan.halder@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526400259-7573-1-git-send-email-ayan.halder@arm.com>
References: <1526400259-7573-1-git-send-email-ayan.halder@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [217.140.96.140]
X-ClientProxiedBy: LNXP265CA0095.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::35) To AM6PR08MB3029.eurprd08.prod.outlook.com
 (2603:10a6:209:45::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM6PR08MB3029;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3029;3:zsWwKikE44D4JuVRe9UHUG9f6hz0F1P0EYD7dfvVLHB+5RevNw6N+K8kr3wq6GU/SZ3hwd3VcqfxWy/X0wydi3nPKsWB4yoUDVAYFe7Oamd7FU7FgdJ8Z/uVpfkCKYJS3WG8rNTq2IC6ZAzhloLmGrIpLvAUXy2sFf/Z/G7IrMCUZArB+t88spOOUVHZbaM80z4vXp1c1xyfbUlkODFJayZRQSue6gl3SvxEtC7LRftWzRsRFB39sNmuUdbztnM7;25:b0HqRQOQkjm55mQXRBa3Ws1lCRMhzTuTo5MD6jKNrckM6BWLXZc/1HB/lXBEJ+mn7KN52hXAv4ZyYe+tDAlMxV73dzNGb6lYb9j20QLdaAc6NDID1nkb/Ejn7IpwXBzsFiU4WVFl3eu0O/iSh4KFi/dgT2phGXiKCKFF2JbnP7F0hkTcrzKOFC9DDex3hnaEDQ/qE/PX4Fufm0DwfDOWfD5vaEfC+cLqHi6fjqF/EFI7FzCc9iOWEK2G1rqK8MfDPgvw6zB9YfaMKtLwDuHJn+5cRbVjRw2NAUqeSFm3BE0GiulG54oOXdkO0Q2FpEcXx9PtoLVJ8E0YVMB72OrIyg==;31:B3b/mnv/IApUAaunXwQnUl6aDox9nbm9EUKsA5ZHcV4ObyVcBpSdYbNBXpMXONh4p8OoBNpqaL2lAdVJepIBOyIekyP2vC+ExAubc1firhBuuJ+zxSlsS4b17mDEdCDm3sRAkOn93C47pDgG7oKL6GxRf1iGTgWLRxaGBA33oVYvWmCErZDXeFaxCtJWK9Pr/J4feg4uj/2+bqwuaNUthc9Xn7Q+8o2H5in6/2vuuVo=
X-MS-TrafficTypeDiagnostic: AM6PR08MB3029:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3029;20:/bKl96O2qN8fbfOPZQOycMIQjdj3MkZEY61zlJa3nMxuVxC/wdypQ1igJwwRsx44uajaSCs7ZQuAVcSSyI1PaNHyAJCFYJjHEU8ayHmCvzqOTuemJa22FEH4FADxdzGx8hjBcKrxnKUp0vXBzqrL0rXx9IBME1/EjvcZO75fS41zN5TKGYZAahXuWA46cOm+1i7EsiVKubwtsVHyCVtuPg7Qp3onwW3GtozrDhxbY5LEdKSV369tPv1P8/0SRSVC;4:9LrbRoO7QmFWnOTsyIXPNZNkoBJwiPm3LSpcAMq5vaINgDKnyefTAKj64H1eEegdB67yLBHmbTM+tsOapTcme3HJqZDBun+GUojvwihXnE7hW6HRQtXA2iKY7T7CYvY+2NuePXInwNKNiSh3d1a6tkowHRK243XxTwLtrgQJ1UUNv1UKg/vWIxaEAWk5kGpN+bGJGeEF9UqjiKyX85Bp/iMLN4Q2EiOiblvfL62XDy7Ku0EIkb5Z7s/7367lRXtt+ojlDkHdEhlatjR1Fre9S4fWyFoqREOiEnLWmjvJpXLweImORmw7OaClc07+zaNB
X-Microsoft-Antispam-PRVS: <AM6PR08MB30299389B51A5719D40A2749E4930@AM6PR08MB3029.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:AM6PR08MB3029;BCL:0;PCL:0;RULEID:;SRVR:AM6PR08MB3029;
X-Forefront-PRVS: 0673F5BE31
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(376002)(39860400002)(396003)(346002)(366004)(23433003)(199004)(189003)(5890100001)(3846002)(16526019)(68736007)(53936002)(5660300001)(6306002)(8936002)(2906002)(50226002)(59450400001)(86362001)(76176011)(52116002)(26005)(7696005)(51416003)(6116002)(386003)(446003)(2616005)(316002)(476003)(16586007)(81156014)(106356001)(105586002)(97736004)(81166006)(6666003)(11346002)(956004)(486006)(478600001)(966005)(50466002)(6486002)(305945005)(48376002)(4326008)(7736002)(25786009)(47776003)(66066001)(36756003)(72206003)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB3029;H:e113505-lin.cambridge.arm.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR08MB3029;23:pjCG87mnWmRE4ROUctVFq0uds26WcQs6fmTFMNJHB?=
 =?us-ascii?Q?B1BxZjZqEf9d5h/4XzLfM97OF46S9Hwtj51XuHRdhjXnTaVJiPCMvZPL1675?=
 =?us-ascii?Q?T7m3Wfd9IG58owjD+tbnD2+sSoCt2MgPJRZjp1iebFrhWf9dZYmwVCJG32mH?=
 =?us-ascii?Q?8keDtYigHI58P1eJSsPff6xOt9IYXIS1jaqQiufQGHPZP8/pf2LmqkNnDYkx?=
 =?us-ascii?Q?y6TojF3MKOb2U6DzWCxzE+agQ+xw0aLTg9qxaDXF0gY+1ce860dnurrIDL/X?=
 =?us-ascii?Q?2c/1BdVGYkoekL5QNFAUxATu4+Im7rnj/f47iwnUhMB1iNS2DTRx3NVAVvJS?=
 =?us-ascii?Q?ceeIH9BjnvJaCRlGC3cFd9asqr+F4ilafE/UcyGUBLpezqiNvQVZnbeVhqE/?=
 =?us-ascii?Q?WZQVPSAcGS/uwwkTBTniOO5YOTqD13VvevUauCaqRBLiLkQDW2Rf4iXM99pq?=
 =?us-ascii?Q?JB689UbgjUK/3vopyldb7MzTrXLvYFEJiWnYG54n+Hcrf+cJga37tE7qh2tD?=
 =?us-ascii?Q?GSz5XW+5aHNR+ecQRby7LsN+i5KPrl5KxgtWl8yPpcifzNkJxjcQqIt7QuiD?=
 =?us-ascii?Q?RNTn48G7c5OvlzKB3dbuxLwUtyJplNh+cIOsuOoWFSlBWkJjmGfbPeDcRGOy?=
 =?us-ascii?Q?3qngxIvnmmQQZYsNYFCKDDa6cDXfTmGPi+clvN1+WKdTUlsNEyj8E3X9r5ZQ?=
 =?us-ascii?Q?3WfPng6REVIaMMdovrYVCLflKtrCxPnH6mj3QsK3J952XJ58WLGvtR0qZ/BA?=
 =?us-ascii?Q?qhvMFgdDqY9mOyn1bzgJ9ND6Utm30sYOcvo4OSPcCRwwro2bjZZ6FoRmx+9i?=
 =?us-ascii?Q?cPcrJOTHA7xmFitxw7LENNuOht0h12x/5+Xu3a1Ep1Mf1GbooP9QgQMLNPG0?=
 =?us-ascii?Q?cSJrCGkYyJVHOpqE/wIWFp2JcfsspAJpWT3gP6dXk3UU5Ukgx3LMMGga3fv2?=
 =?us-ascii?Q?2+mZItJ7BE/NyWWHlTPJXJ/bBzXcNNEwKCmYl5hRuULuKaBX66JGA/lLn2gh?=
 =?us-ascii?Q?g9RaIepVS6URS0/XS0ni1eeeXD9n6nd3GESYkL0p4FS6g0cjmNFcAJZwfEg0?=
 =?us-ascii?Q?8R8RheaOILlqCsULAZ1ambWkSIQlM3KDyHoyFN0zCuLn49rgpAuMpNbL7K0Z?=
 =?us-ascii?Q?zJMAZqJfR9UcdPVnn49twyAVmPNCbWis6Stj5ycwVP3fQo+XrvHMHjmAqT1S?=
 =?us-ascii?Q?4y8fU/IKbpt4K/MgbcyfgNIUTEu/uRrHUrTe198GVkKZ8eEhXjkv0W+IRh6N?=
 =?us-ascii?Q?2pv21UZ7beI77bDbhs=3D?=
X-Microsoft-Antispam-Message-Info: XoRNBKar4t9jm5lsBMVpgOiPIDrPQRoqQjPFRu9hP8rdEt3Li6vhXBQGXo92aw9CExbANt8KMPfrIKYusLeSoUmUY+hGrZ+zAYnw0wo3RFNF3sHOmYype76nezuIAwwi8TovHLBGwnfFPi6tkLNi2vWPIPovGgcEBaJKt1Z8wgV2eeAbhxbHbSE4j3dMxNNO
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3029;6:kLMVLMLyqNnJtPSy6k46e9v0CTA1kzgY2r7eCW5+YjwN/Aa1rNf8dO+uZoa/01rVOViVM1eA6JBvXpA/pcWpjExloipnJAVMYpCP3Y8nS/JFdkbd73C/Ur+BEiZm0FpLFa0X/7euYQkRYn0HGfoiC4fAxSqlpRnEaYjkucJultBoNm04jtpJxD0+Vo3TMz7jxRZt4dLd8KcV/k9YeLK7AVYIYi9to90h23u0cnjaxHbMleikKhjDS2Jwbcxz7mFosZ5JBSrmgJoTiadcuiyqKDWS8rYe0Lkl4jyZemg3/hvRKT1YgKx8RweRhIgZnsvtlvqa2jOq2V0vQO4nvR9iHxPXAuQ+rdBWTrDfrKqNgQXCPv8FfCq8qs28VD21NrWM0LejQcBFKfzQtjC1JjaTvud0reNjMiiETHWZalgvmCSlLB1eOajHG5YfDcSmg82h2B3C6iwEA8qvTvS680GflA==;5:JpZBxGuP6vF7HGmenvCcr2QJwuPkRinZdyof+fRePDW99YG10qj2ivYRZcuOFw6s9PQBS0EBiGnuNdYBOC8yl04QbRTqnUyTPuLrAQvQAjn5KYpPlF/tTgqG6Qu4G0PqWWyG+ZAE8eyLCB+1f+4GYTgiuVVWgnDPe/Ky0YjLrCQ=;24:T+0xdb+zikgYIy0sRxigm0uq0Mc0ubrcHtRtRInDwd2wlUuLsMy13BGLYTL+WXRtzGWhqrXGSTafERHCsBMV2NGRfbChZfyh7mjIbYPpHyk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3029;7:l3su5rFr4jw5cvl+Uu/XaCSlI2MvNANvR++Ic9DHNTrQJIzrihcdLmaa84UoZFGarYZ8AAXpWJJPQKxWEumoyDhBWxC4+g807nhgeJ4ImQmpg7hZXLnQ6I1r2s1/CLX88K05zB2/6Z5dXnZ4eatNGrUGgKTGquFx8WeClPw18lZaaBFyXuyaEaA45JgpF0s9W3JVLcpQ6U8lJsRT7hG8Vvls7UWLnfQQpEqdkLPU0BIMNKc1qDCaGQOblxwLVj3w
X-MS-Office365-Filtering-Correlation-Id: 4936321b-3721-45a9-2eba-08d5ba7d8cc9
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2018 16:04:33.6122
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4936321b-3721-45a9-2eba-08d5ba7d8cc9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3029
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Display and scaling engine interrupts need to be disabled when the
runtime pm invokes malidp_runtime_pm_suspend(). Conversely, they
need to be enabled in malidp_runtime_pm_resume().

This patch depends on:
https://lkml.org/lkml/2017/5/15/695

Signed-off-by: Ayan Kumar Halder <ayan.halder@arm.com>
Signed-off-by: Alexandru-Cosmin Gheorghe <Alexandru-Cosmin.Gheorghe@arm.com>
Reported-by: Alexandru-Cosmin Gheorghe <Alexandru-Cosmin.Gheorghe@arm.com>

---
Changes in v3:-
- Abandoned https://patchwork.kernel.org/patch/10357213/ bacause scaling (aka 
writeback) interrupts are enabled or disabled when a commit posts a scene 
with or without writeback framebuffer respectively. This causes an issue in the
following sequence:-
(It is to be noted that scaling engine interrupts are used for writeback)
1. Commit with writeback attached.
2. Before writeback finishes, commit without writeback, which calls 
disable_writeback -> disable scaling interrupts (ie clears the scaling
interrupt mask).
3. Scaling (ie for writeback completion) interrupt is called for commit
 in step 1. However, as the scaling interrupt mask has been cleared by
step 2, so writeback completion is not signalled to userspace app. 
This is a BUG.

Changes in v2:-
- Removed the change id
---
 drivers/gpu/drm/arm/malidp_drv.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
index f7a8beb..983b854 100644
--- a/drivers/gpu/drm/arm/malidp_drv.c
+++ b/drivers/gpu/drm/arm/malidp_drv.c
@@ -470,6 +470,8 @@ static int malidp_runtime_pm_suspend(struct device *dev)
 	/* we can only suspend if the hardware is in config mode */
 	WARN_ON(!hwdev->hw->in_config_mode(hwdev));
 
+	malidp_se_irq_fini(hwdev);
+	malidp_de_irq_fini(hwdev);
 	hwdev->pm_suspended = true;
 	clk_disable_unprepare(hwdev->mclk);
 	clk_disable_unprepare(hwdev->aclk);
@@ -488,6 +490,8 @@ static int malidp_runtime_pm_resume(struct device *dev)
 	clk_prepare_enable(hwdev->aclk);
 	clk_prepare_enable(hwdev->mclk);
 	hwdev->pm_suspended = false;
+	malidp_de_irq_hw_init(hwdev);
+	malidp_se_irq_hw_init(hwdev);
 
 	return 0;
 }
-- 
2.7.4
