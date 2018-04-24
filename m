Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752845AbeDXSOA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 14:14:00 -0400
Received: from mail-eopbgr50080.outbound.protection.outlook.com ([40.107.5.80]:51605
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752294AbeDXSNP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 14:13:15 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com;
From: Ayan Kumar Halder <ayan.halder@arm.com>
To: ayan.halder@arm.com, liviu.dudau@arm.com, brian.starkey@arm.com,
        malidp@foss.arm.com, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc: nd@arm.com,
        Alexandru-Cosmin Gheorghe <Alexandru-Cosmin.Gheorghe@arm.com>
Subject: [PATCH v3 3/5] drm/arm/malidp: Enable/disable interrupts in runtime pm
Date: Tue, 24 Apr 2018 19:12:45 +0100
Message-Id: <1524593567-5559-4-git-send-email-ayan.halder@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524593567-5559-1-git-send-email-ayan.halder@arm.com>
References: <1524593567-5559-1-git-send-email-ayan.halder@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [217.140.96.140]
X-ClientProxiedBy: VI1PR07CA0189.eurprd07.prod.outlook.com
 (2603:10a6:802:3f::13) To VI1PR08MB3037.eurprd08.prod.outlook.com
 (2603:10a6:803:45::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB3037;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3037;3:7yvCTspeV4FVKqJ+luwu0pAWzC3sHMcwc0ddMg1io9OxoM3LJCs3+lMC5O7FTE2MFGwSWQgn/8tQ5CO6WYyXRbPdLP+YZ/V6C+A4Nil5Pvua2D5Mg6l4SuE+RnDfUYroLmJVV6K9x2JrhbX3cBe8GJmCoyrsLP2Ypv42Y53xx9K5KfU1a7n1TAA01G7jyHn303e2sRZUKH2bhXxMxggNDmHzyloa46RXXisHJVAn1OBBEWUlthiKcXRc/0589Gjb;25:ZIJYHYwXyGJ+w1EPwoKFbX/UesG4v4YYq2ZnqIovJTnvXa70aVspRR1szyrYj8rOwRSThbshBGeHqDA62wW3x2z7m3C6VuZDSGy5Qa0KXlyt+OqZHV6QNXEBXRZcSmywFb8dHpYd/Sjx1V8V70s3mU/DGBo1hzblj2nYKFQJPPZxC+ytOwCnJ9nSr2+z+9SwZVXnn42LgH40nHijUVJ1av/sSP+J7dzYZEDoDmovhfehHSWNkWEaGBo6VBCm4IMazBamV1RGE1qWiXjIkJPxhag1Jp7i+YLPGzwudrS4SAUx+25RZ1ZeJ9oxAyHeor19v+vFiPUPCBE4eiaxDJI0wQ==;31:wdybkf8Lat2w2PrqFRpmv8GAhhXUOc3uo/kKQDEcECOdSV20o6tSolCaaZLn8BYh7uAowIbNaH1IwSTvs7OULVPrRXU2NhPhv7EAFatLrGtjOEVlRb1OM2B3YCuuGZq3yh9bGy9stCZcA5/v9XRD+oRlD53+/2htVG5RRLqAFl+jpi2F/uU3fRjMDshLfMtY2t//MRPdYyZtHHUMlYmZhSmfB9q7yGB++Ic0ozs+Q+0=
X-MS-TrafficTypeDiagnostic: VI1PR08MB3037:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3037;20:+XQUNHIGeOjsZ/JMgH4cAj43tKWc2ox1DsvijG1QXchG0s+AVcNWpPEonbQU2pA0b0ICb8ubD4vqPqWDWOaFRtIHCkD/QdEjppqYcmjP2cqN1ZGFPVWgAd1zMsmF5qYbmZw5U9O6CyK0diYncTdUMbKhiVjD+pL5NLO3f0aRkPqeXT3Xi1OIjIQBq/gI1stDwfo8FcR80UmgiGB8rRPhJJbBVhgTqUhIXzkDI8OuGGhl/+Tv11B9HrlED3O4dKw5;4:ztZu8+pyW9F8VWL65bxPQdBblccWeBde4qwjDStHtVjYW4SBwPgvzHH1I2/Hft/KwK98/zz6cdPitup1udUW6wIIDIP2SF29d6aKpn3I2eGLqbnuvwm7uYZswfa8LUwGs5zlI6DbGFj+QTyuDXfGCDwExPSqD6RhyXHWoG0Il/cxVs+aVoQpJjwgxT15ELwtWKyF6w8bUnMqVRzGsZRV6t1hUcUnrWbId1v3Xbds3kNrdtHqabMTxQfexgVojlNIkHpO8tr1/oP5CZhAZjKeBE3U1DbNJ5RZkxgqZgMSBIMtaxAzSh5/mHN5dQwws1lJ
X-Microsoft-Antispam-PRVS: <VI1PR08MB30370C93A8EE5660FC81BCF2E4880@VI1PR08MB3037.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231232)(944501410)(52105095)(3002001)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:VI1PR08MB3037;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB3037;
X-Forefront-PRVS: 0652EA5565
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(39380400002)(366004)(39860400002)(346002)(396003)(23433003)(189003)(199004)(316002)(6666003)(51416003)(6116002)(53936002)(3846002)(97736004)(6486002)(486006)(5890100001)(66066001)(2906002)(76176011)(36756003)(25786009)(86362001)(72206003)(478600001)(105586002)(8936002)(26005)(8676002)(966005)(956004)(476003)(47776003)(48376002)(7736002)(305945005)(81156014)(7696005)(68736007)(81166006)(386003)(52116002)(106356001)(6306002)(50226002)(446003)(16586007)(50466002)(16526019)(4326008)(11346002)(2616005)(59450400001)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3037;H:e113505-lin.cambridge.arm.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR08MB3037;23:tLzHYJJd4tV5OHQKIxqAX3bdTdu/9xdD8fKcixeyi?=
 =?us-ascii?Q?zE3Z4Y6Rr9xp3NPuN0SaxpVx7dVONa2JapMmH/xX3t5AQdmjSvSuapAGXEnE?=
 =?us-ascii?Q?JbydyghEapHATbgqdLcz3LAhF72bpiozLtRiFQ7N8R97NRiOiFJ0KIYf1tFB?=
 =?us-ascii?Q?lnGK8FjqpxIy/5RSmH60KjedYA8uUU4l1McHM4+4hoMoAun4khcHGqGD/023?=
 =?us-ascii?Q?oHUkKjJrtrCKLPtRA3BQjJshoA2SkWlhXmLRnMbP68ri8G1tZuYB5qUNhNcq?=
 =?us-ascii?Q?TSA4k0lP2c2ePVnnhh51pG60T3C7W36egeAO210NeLwJpHryrV6woI5vVJ7A?=
 =?us-ascii?Q?ZtK8yk9QEJgWfsAWI3dIaUi23RKTW2Y+fPapq1IDy2HNrnMoUaIJkoJdlwM3?=
 =?us-ascii?Q?0xceT8RXdnn2shtLDI7+VncQzODMJ8tLGhnSKzPsiR8Cc+Nyq315rWvUpeF4?=
 =?us-ascii?Q?6tWEIgni0S87T8KSmu8FfbCheUu/e6IEzthqnWSYgRY17DGKUbfhHbXofpXP?=
 =?us-ascii?Q?iEdOssZma5QhWl24boG83wIny6DoJMHLpKLNR9OGbuDHZSteJFxFW3p1pK3S?=
 =?us-ascii?Q?hCGPlbqIb9kaspqlhD+SbxdAAIoIwe+7P2RHk1TICndcR+kUDpPquNUJxJrC?=
 =?us-ascii?Q?kO8R7PiE7U91TKz8DxH8w1s9J512DT3wOf4uv8uhVCRboSy6m1Nz0kXosQQy?=
 =?us-ascii?Q?nzBzjrQAGsiv8+hT2/C6sMKtFIJ5WN+oW7r22jL4U6EqJsPcsyP2u1jWC6oO?=
 =?us-ascii?Q?RSWqCEU67Ca3HQfGSz2EH4ahBT4H8fkYjEz7dpafaQajcwOj6qzbZ/cGL69g?=
 =?us-ascii?Q?RiP/izSl3VaBq74nTSOek61XuVtkCUZlgREywlEjY+guPhXeQsYw8HnkKK5w?=
 =?us-ascii?Q?gBsA9MQ334bZbWldtN4o86Ap80jxTYZVC1HUKdnBJ7DCw1DX3vxm0foHK4bA?=
 =?us-ascii?Q?w6M7KcMskr1gFPxzK5YzDMUDZTPsmTvWZ/p07+xJ1JENUv/1b5MOCdjdtnrZ?=
 =?us-ascii?Q?CEimjZH3wHWFGhIDPFNFIaz2ZeEk95h7nxU7M3LIsNIXRMVgZkFUB7oc2ol4?=
 =?us-ascii?Q?PyXIbMepmNPzyQF5TuuN74T7QKPQHEP7SixwHduO5FzroUYA1ROk9fmfkuxK?=
 =?us-ascii?Q?Vf86eFR6sLOmeGZYSMS0J4kUNLHpZmxyzF+F5NlYAJ8yvDpF57i5qVKFjbBF?=
 =?us-ascii?Q?eC01+DtU6Jd7LKUyYGtzokkZU/dAV7YTg41uTCV8XqH+nwBH+rIHmB/GvzRi?=
 =?us-ascii?Q?mmEAWZ5ee07gKILZDI=3D?=
X-Microsoft-Antispam-Message-Info: h4N792xjK8dcg3sTXgUG1uXNckjRg5uVz1/IQJRfOmVRsJkrqJWqsWLmIwzsnDXlYVVVw/yx4Md8OjbL613VTyduiAseVvvfNi8odU/FmdCWyNTXXB7dnFlPDHq8+kiXKSkbUw30wqAx47foOgmO+YCh2lToE9pL4g8ox4Yt+g31iiBgqhgRT7UfbuWH1eNz
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3037;6:U6wW4Qqztx4+KEXTEPrKr1VxL8PlN59o+KMetlw4c+/QjoFuhK6SnSh23+8WJrfVuIXErJ7/KsTpX0RIFLGkhMVNT8CwOgSuaWjylguZ0h/D+cVZh/pPoct9kT4mGAvx2vRDXP+LzgIe/nOwA2AYAKyZN+WUmbVq819zFhCu9bXPr9I18hZoJo+VZWa3s/FL9Wzs8DeXSQXLGwL5eGYzO6Ls4mvYeK/FRWgf4q4KNJSDOEdPMWa5G98LIlaem9RQNAgwo1D7plHXbwoH+XBXfMOGJWPF4Li4hpVt8+wwSm5qkJKdB9ZM+xf4PVSFlwxSR3ycwGEjqTIMQ1VtvGSiqxB73mD2n3VkAiER/2lyZTPYoVPvX+4d81j/ABqj1Rk0cH1i7DKDNJghRZX2L4lShnX2iCZEaP/kUL0BioP1bkLGFdhht5pAh78BgcwzJJtVHvcfH71Bt3Vo5/ak7kMyrg==;5:SP9yi1VTUQHJogz+u/oQdNRnWM8Fp2OxZDuMO4c1vAX5eu2+cCrhh8EgAKQP1EteUOWahKA3Pre7VDwv26CB0z3MVXYwkEDGGEL/zfQuQ5uVeDpEKto+aY8mAY4tZ3bhAcI4mwH/sbbD2LcDgNd76mGgjAla1au3GF5jdDggbhg=;24:lv9h4gFXD3GinjvkYWUApK506hNIc7BFA7jdQZ+z89wNNwQ9ia0qLuDTSkssknsiel3NWszFVskZYEi+8b02Hbhm5jjEojiWyTuKckI09to=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3037;7:UPC9ctNCkbfFaKMtBuaB6MpJOeILkv2qOk32NG771ikxTo4DQg8pljtAQ2DwQ61JkB6zbURJx0kbLIrW9mOGz3dIuIfMoxVn9Fwz7x7j/PsAlHmlCwg8j1/u/Z11/piLTKmB6gWUu0XkcmNDCRfEAB+o6U0/AY6h+AeuhwC7yYMCi2Qs5BgZV/2IE1Z3mTy3GPrrayB0C6ptGb1/vAKXGE51/sUAaPvEy05Z2vI2tEuXVHUCEgrdgji4E3F4xtW5
X-MS-Office365-Filtering-Correlation-Id: 2e682394-799a-4cc6-8260-08d5aa0f08eb
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2018 18:13:08.9926
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e682394-799a-4cc6-8260-08d5aa0f08eb
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3037
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
