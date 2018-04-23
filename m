Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755681AbeDWOv1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 10:51:27 -0400
Received: from mail-he1eur01on0056.outbound.protection.outlook.com ([104.47.0.56]:26568
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755489AbeDWOvQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 10:51:16 -0400
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
From: Ayan Kumar Halder <ayan.halder@arm.com>
To: ayan.halder@arm.com, liviu.dudau@arm.com, brian.starkey@arm.com,
        malidp@foss.arm.com, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc: nd@arm.com
Subject: [PATCH v2 5/8] drm/arm/malidp: Enable/disable interrupts in runtime pm
Date: Mon, 23 Apr 2018 15:50:48 +0100
Message-Id: <1524495051-3891-6-git-send-email-ayan.halder@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524495051-3891-1-git-send-email-ayan.halder@arm.com>
References: <1524495051-3891-1-git-send-email-ayan.halder@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [217.140.96.140]
X-ClientProxiedBy: VI1PR0701CA0055.eurprd07.prod.outlook.com
 (2603:10a6:800:5f::17) To VI1PR08MB3039.eurprd08.prod.outlook.com
 (2603:10a6:803:45::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB3039;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3039;3:4KuoxLase/ilLUoM1+fcNMoLnZrqCdqkWakzTMW2bgNE/O6+V7wPP/VdGt4S+jOQ/BKAyCqf3W0YESGT/5O0/DyYV86k7PZU6sNU59TeL5yB8iiMKzGA5J+hAaGt2Fnhhv3bSnSWax2sgeix0UuKUSBCO0fT84B6ESm6Q6ClHRn7nGXqSe6ecwKd7m9wzDxeKmaiuQf7wEkDiL1jUQeysMoGN8z6CVKLquLmtGimDR14vjX5DiuJLGFWbAUMZpiv;25:cNfUDyRwuWSYWUT/RuLeBmAMuF2Q/ewVd+qQXBhijoosniZHTtrvGXm0s+a8wZN3ZWXPY/kqH3UvuB4allBlNC1UUBZe6RTq66f/pnNTOR5fiZXdT/SUsxgrsOhTmITc/BYBjcj2NCD+SSabnpLHIOSG6AkGPMH9o/wNusx6Yae+s+MAaNJenfBojrL83Fk4m0eRfsY46fwl2BSg7S29gy2Xko/08rUB8gf7IUIqSnoZDAKcSsW5RbyLNnEuUaZtTccWbSNtyu7kT8Zglvjq7oBfwicVAo/6MSQauylxyPX9g3dPYjqjmnOQBefKm6YM/nTAP5kad7Q2D1s3z4NSsg==;31:3ZKwXwl6hkpTlHcFirtmoKyIt2OaNE2jS3XZ1shauA6cX126k/LbdaGvW+1QP+1SWy7vqbzamSkCJatRvY7bks89koKDq40wiRRuyooxJ/tf4aw4y1TPZcbin2Q4cQVv1Mx31kmTI3KPx7io4cQMMMv+bFBOSqu5W5QJYmK6JWg9cDPSBeju35QQWELuyGBqV7/a8VEnwl6IjP7buvAhRurhhLTT7k1v0pScB92cq9c=
X-MS-TrafficTypeDiagnostic: VI1PR08MB3039:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3039;20:gO3ioC3P/77ltwxjYOJuHJKIODngZXuvSbl93Mduk3++N4gS1uqO5Viiotfb/HP4SZpvUzkrE0z6OJy5xVhQUUM7XJvCsoNDNJOjnDeb+qBkfduedMor8Zswud8XwEmStZRWdumBxv3LJqukXQn8c0FLc374C/BSFG15mgc4n2Rvf/EgfJ37aKR6GrSOKoX1r7nF6960SliVypUQk0979VXEM3S1Izhgj/dhjTTQxvSFAywrBUOYlguPWBf5DfLM;4:ZiBQlBET6pMFzmQwKUH4fUsbh+Ilc6rOMmp9Zn5kNcOpOh5gMR8EolfYk2uqrv4qftBC7+aZFmtgrq4XodkllVOfPttWHVsz8+NWj78ml1hNgn6KIQ9GHQs0v1IuYRWD5T2Ril8IYZ0G+55EUDO/KtzgvFJl3z9338L35UCmByXK5kEcnkJ9PgUaJHV3qbvxyMcBAs552KtHARsGLgiqz+KzSGdISPN0o7ospF3hr5q+m+VW1ybdPge2xe1ugj6uwx9GuCIYJMUOv9xx5F3TZmzTLiq8DAGSWz9BJmwPWfxIu4X1S6RJWcBYZF7dxchM
X-Microsoft-Antispam-PRVS: <VI1PR08MB303968B670342457B057E0A1E4890@VI1PR08MB3039.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231232)(944501410)(52105095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:VI1PR08MB3039;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB3039;
X-Forefront-PRVS: 06515DA04B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(39380400002)(396003)(366004)(23433003)(36756003)(47776003)(50466002)(6116002)(26005)(81166006)(3846002)(8676002)(48376002)(5660300001)(7736002)(66066001)(305945005)(16526019)(446003)(478600001)(2616005)(956004)(476003)(16586007)(52116002)(76176011)(59450400001)(316002)(4326008)(386003)(25786009)(72206003)(86362001)(6666003)(7696005)(11346002)(6486002)(2906002)(8936002)(50226002)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3039;H:e113505-lin.cambridge.arm.com;FPR:;SPF:None;LANG:en;MLV:sfv;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR08MB3039;23:y7UmecvZMFxN7pawPiQXhjKU+hC53f/uniYCiP78X?=
 =?us-ascii?Q?oyYrtATJTU4JaHeeh9PjsSNrwl1ejVoTdq6MWbkTvgwNCP11TivdCdWWSHEZ?=
 =?us-ascii?Q?NKTXFH69/K6shZDoIqlPFlEoRseuln62FH/uf7lIiGykO4zIsmqDKSQ0mEDe?=
 =?us-ascii?Q?/JYa2zO8fi2KbwLVPgV7+Q01g1WMOWNjxpg3llalFMS1dOEtK83XLurNOPtz?=
 =?us-ascii?Q?a8D5GZighBgHsWod9gMwBxfJMzZBsV1YYFjzRxeLNZpHTUzINwydKGYa2G20?=
 =?us-ascii?Q?43p77s9Tzhl2fdawXgHZXC5SP+LIQqWU/4qEex6arS0WnruH8sWCGe/pInnf?=
 =?us-ascii?Q?yIapXLLCnzsC8tCBHM/VsgDsYhJ7NcNTH+JbBnFUY/s1yjSS4ZxsIKQ4/9Tz?=
 =?us-ascii?Q?qKIxWxycP0l2jBmlOZJVcnPLa8AH0nCyV4OYKNp9yuFILnZyMcABvJAWwaqY?=
 =?us-ascii?Q?DloUwrA0j2B8EUt0seC0xbLVvqpRUOZFoml1fGxN3r6UslmzfOeZwiT//vXF?=
 =?us-ascii?Q?zvYoIEVTASdqYKiWYz7PSEDgMYjj1O9cAReonm0NCJHHUo0Aqaxa9qsAu58I?=
 =?us-ascii?Q?PucqLjq7Xfpf4oZlZZWVeRqqg8EEX5RbpoACI76ILWee20jLYTZl2ln+6vna?=
 =?us-ascii?Q?Qud+AGOyJCfcvEeUm19OSMI7noliaElzYzoVB/t1791+PkaF9rpsyx5DidGc?=
 =?us-ascii?Q?ti2VSDoZiRxFa9AIpwQqedYhEoumLnNYJjz/g60A9OCx8uF4U5Y+DGqxyhdT?=
 =?us-ascii?Q?fdrbRUSx1QB5ada7cie12ODsd8OctEZaK+IJAmzB/B1xs3oFYifC/bczlV/Q?=
 =?us-ascii?Q?+FP9nDHWAQ27FtNzSwkOGuMylx9woQhJP597OpYH/gWLtX0Z5U2WcG1jxEi0?=
 =?us-ascii?Q?Haw+s6J8lZHHXgmAqYdAdIqFIzdLrmaZ2HVWdXjLOdky9S0VkapDx/+4sDzx?=
 =?us-ascii?Q?7WivpT2zL/x+KfTP0hTokzb/Hw15HExeA8uTNXasxolHW+A6Qf6rqTe/NLhI?=
 =?us-ascii?Q?yX3rEu4UjO2WKVL39TUeh9J?=
X-Microsoft-Antispam-Message-Info: wtjXrf2N2jER+8QqlnliZPAtFA8ESTl12DcYiEdtnqkvjcmJEzRFnOWra0AoYWLJEIFGNOXV4lj7dIJsvVNRLcjMZ4TpHqTCLqe3Sg6h1jpBht+yA1r422M7thAkzz9WB9xjYE7LEP5jyWwaLBoeoUMpxtCELWTnxLrhg0hzmgaskfdxF7dZxDmYdPPw7bN+
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3039;6:+XfsMjRTB6Rk2z0P00/iRCCR0W3HJCtRb3H4+fNuOf08ykoW/+caiIBvzdabZ2GLkmqAli67tDGUWYL2VkpVSiNO9C+yHXlOJUPXMyQo11dyqr9rR7iCAh7Vr3+RKeRoFk2uf23LJDn5/oBhRufn0qdHyk2bUJJjC2EG7BkDN0HnAOHzG/B0o3uUAHGZUl9yymGjOREwl/A8nO0kXv/jLOt7tu5Hr1p8ydSx0KNcKRsgRBGzTFYSDhxwiFw2KMU2Ev4oQQTLWEimsglCpdZvkUSjb2fCzkY9wZxwbaZcZQWruVr+/cWTh4nBBfvbKnDyefAak0fqAPo679ULwvaG0aWKQYTnsI29iBkut88cE7e2LEiSwUG2U6zknhax40p2S4ERBqGCoaPVXNbhov4GRoHmRwXIAX1Az/3X8XlBon7xnnyb44VfBpapooihd7ZN0ifjZRjNLCY/GwlemxnCpQ==;5:I97aETcrMFafY1F4YMXh8pq+sWjef9PZMbNOnyhUifBR89n2nMoUxd9NzOAD9YVJbF5Ei2qx/Vprz5stlKwohPB0WRNQQEoDZGotAA6ilb1mkLmZamqfuE5wp+jeIn7wcMvfRxBzFL4Gd+GRbwJJ/zte70l80Trq9mrrQiKRzvc=;24:pDZKfNsK+88zU1Z7GyE8uu1kWbtXggwdu9IuW8vo266HEAbHM6g9qBBciwOlZ6duplNSje+l4OFW9sYIiYD/rzfOrSoD+OqcTr+FFOaUDGI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3039;7:ewSYwlNv1vxcQbaoWDzKk67j4lc+JE5oTN2mTRyGOmvtLiu5wpDvlAceQu5upQVrk5AsAdd9hxiTu+qbET1ZsA2nyLOZ5V0RyFpx/I1HPMFTdWZCvk/CljYXPNAQK+J/7EcUQQ8dDtXPapvISeIzuATdKBHGNjEpN6G1VQqyItAuoc1PhVSVhczyyQeT7EWfsneazPi0JpVCx5TA1Nd2dJO9NU3xGUqzojFIaNv2pfWLLQDFSC/n3AQTlxZonqmf
X-MS-Office365-Filtering-Correlation-Id: 8f1c1a75-061c-4428-5923-08d5a929a60d
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2018 14:51:08.4001
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f1c1a75-061c-4428-5923-08d5a929a60d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3039
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Display engine and core interrupts need to be disabled when the
system invokes malidp_runtime_pm_suspend. Consequently, they
need to be enabled in malidp_runtime_pm_resume.

Signed-off-by: Ayan Kumar Halder <ayan.halder@arm.com>

---
Changes in v2:-
- Removed the change id
---
 drivers/gpu/drm/arm/malidp_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
index f7a8beb..e5a1fa0 100644
--- a/drivers/gpu/drm/arm/malidp_drv.c
+++ b/drivers/gpu/drm/arm/malidp_drv.c
@@ -470,6 +470,7 @@ static int malidp_runtime_pm_suspend(struct device *dev)
 	/* we can only suspend if the hardware is in config mode */
 	WARN_ON(!hwdev->hw->in_config_mode(hwdev));
 
+	malidp_de_irq_fini(hwdev);
 	hwdev->pm_suspended = true;
 	clk_disable_unprepare(hwdev->mclk);
 	clk_disable_unprepare(hwdev->aclk);
@@ -488,6 +489,7 @@ static int malidp_runtime_pm_resume(struct device *dev)
 	clk_prepare_enable(hwdev->aclk);
 	clk_prepare_enable(hwdev->mclk);
 	hwdev->pm_suspended = false;
+	malidp_de_irq_hw_init(hwdev);
 
 	return 0;
 }
-- 
2.7.4
