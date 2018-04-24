Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751990AbeDXPck (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 11:32:40 -0400
Received: from mail-sn1nam01on0062.outbound.protection.outlook.com ([104.47.32.62]:25600
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750739AbeDXPci (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 11:32:38 -0400
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=permerror action=none
 header.from=amd.com;
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <linux-kernel@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
        <David.Panariti@amd.com>, <oleg@redhat.com>,
        <akpm@linux-foundation.org>, <ebiederm@xmission.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: Switch to interrupted wait to recover from ring hang.
Date: Tue, 24 Apr 2018 11:30:36 -0400
Message-ID: <1524583836-12130-4-git-send-email-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524583836-12130-1-git-send-email-andrey.grodzovsky@amd.com>
References: <1524583836-12130-1-git-send-email-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(39380400002)(39860400002)(376002)(2980300002)(428003)(199004)(189003)(44832011)(2906002)(486006)(26005)(8936002)(8676002)(50226002)(36756003)(47776003)(51416003)(54906003)(7696005)(53936002)(72206003)(106466001)(16586007)(476003)(11346002)(97736004)(110136005)(305945005)(356003)(81156014)(59450400001)(50466002)(77096007)(186003)(336012)(446003)(48376002)(53416004)(2616005)(5660300001)(76176011)(81166006)(478600001)(316002)(105586002)(6666003)(104016004)(126002)(4326008)(86362001)(68736007)(426003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR12MB0332;H:SATLEXCHOV01.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM03FT056;1:wVuSgJ/ujF3iuErjdKDjcxpE4/m0IR/NQUzsz/LbMKwYiOylEO7pUf6FdTNjks3D4e+e1DtsLc8CXpimmduEFAoeRq+APd26HLHkuoLhjl29vMeGhdEFRHQfhkiuVhfR
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:DM2PR12MB0332;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0332;3:bkBmQ5EDtcnwBYGOUPhFgLVd0KXCXoVP5VCool0bhKMDHvPqP35OAmKRYJsJlPtfh7PavAWvP85qscDf3OtUmqrUxWhcDKuhAZWhgoKndBdokcQ1NfcpfWfWO3KdmAcPfXImcMlA/kPuUhlRHSB8b2/JPTnvqWUpau8++iijfJdUvpcbmws9UDTP9dNaxS1jT59kitVOocjCIBMheT7u/GARLl24WRtwL+6oxePf3E2yt+/s6ieHnABg5ZA5uSSKgwN0K70gjqayRyErTtcAfmYpLiijp4R3pumW9OF8jGNndoZ16PeL4PB/+f+hI5r/yQRKo+zGd7eFwrV4wZb7YXzL1bWjPUEZw+fVmFQ/LNs=;25:Qats+4hVt7olNjllAhSPhs++yl41tVEgAXWSsfEHgyNVyjMgn98T1rlfnq1Rjpblq6/hxkwBASzH40q88JS7mGBcmtKIY/GJzzchkjp4M75zRIH0La/l9J+LfXQE1otovIk2OlQDtOg+/wJnD9J0eS5hgp+TY0TKrVs36mll0mo2pt9QFr6j4EcB1x2utYKDz2MiL0SeEd4Gwp9q5Ju/x6Fv7cxWxBnRiHPbmntNbkRMIQKcaIQmWJ0iYCHMJ0vCgQFC27uAEm2hWPM3/vKrZ8QirtBOILwWgiaq8/CEDbYNSn5JNK9KFeC6llq2Z8uTusy2/ddiEPgfNR+8JsS53A==
X-MS-TrafficTypeDiagnostic: DM2PR12MB0332:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0332;31:ekfUlQKVpSVPL6lMX3TqS/bZh3Q6CO4prJdumFMXdfD/ml1NH7hKAKvJeqQGUZXuogto2f0vq4i4pgItTmYbWDLwBWf7GbN3f64FcKSJ9wVmjvOXW/icV9vaXuhGd7i9cwjVTznXavCAG9Klcejmb/vcBl874zj3KpKdj0LV9BDz7LqrYqlX8TSnsUinUCAfQIDVPE6LHrq1fadcE4dwL0UQdVl0V59KSs4CEGXnP/Q=;20:HoZB8o7HQ8AYmKjF4UMtnwNcxiHg+VJ+osEDSSOZq8HjPeGvcBznCPDhr/W54mafg6i6aivPfnj3OEtPub2hKkw6tqi+ojBWq4Zwq2nkCwP0qSRg/TKDeOla7IE/jHiXtFxjO7deMDrzx5iC0rQKYkztuyZtdcqdI7eLU/GXHZvN1y8JZrz2Rb+hAi5YL7YrkyIqocbNoel343uxZMPM4fpSlb6E4pF6K5wkGM/bQ5fXYcUdnZZP22XQIyhauxGxjo3xuhW3WTsmMfLIv3Kx08aW1fPS5qFvE4HMJyJ7J27OF5o/UmanAP2Hj9OQK0AGMCPVyMDjpbwpEQ6zg6MdLVYRIdJu2QZhg96FMVE46jGaOOvEMu8+JfhnFYt6L4Lg+RayOrxl2CrWnmVsuwpDXo+9MIl9G5P3YoNQUVUmvuo6EMgq3Wv1J6O3E1Gn+BYsePTe/jRVN1d1rW7Gt+JhsJrA2lf0eqIT53+wtnsFbs8aZtmtP1nUfam9bP0dtb/d
X-Microsoft-Antispam-PRVS: <DM2PR12MB033235772B591D18D4775A00EA880@DM2PR12MB0332.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93003095)(3231232)(944501410)(52105095)(3002001)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM2PR12MB0332;BCL:0;PCL:0;RULEID:;SRVR:DM2PR12MB0332;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0332;4:A1sQidw6VKjAjeeietadw0Fg9UPBU/H/9gDzL2E6mpcye8fkxEBbWVLwznVx+gnoZQzceXqWq51qUl+W462J8ivViYWWoqTI+G1s9GZcvAF9lhkcpzQFBydOADI2gG27+iKYE9r2ASEgf8bZJNmfLFQPAYtdQ/bDuqS59xsRaheWlGXxVX0GlUl/glsw3rr2uw/iV6UipKX51t686p+TilFb/CJQshUNuZD4lJZ3ji6MY61ZaSFXEju3e63PdSlD8kjFVxoPS3owA5zTNhRYCnwB+8FdzfS7NIG3oWvQpXAoq4KcQmRBBv9W8Da17KvM
X-Forefront-PRVS: 0652EA5565
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM2PR12MB0332;23:OvVmSjJIgGKKOOOwe/QVdDnVOMVf7lNiltoBV3nxc?=
 =?us-ascii?Q?4b6RNvgl1IH+XPR8tHpokKe3mxpfXEf/H5Tj0tW34njo6DmUvN4K4hUnnzvE?=
 =?us-ascii?Q?YP/70TnfGXhhkKYU1qB9uKRgEW5Zezsaui9BHFS43VsRHREnBKzpJGs1bVcL?=
 =?us-ascii?Q?+o9OU+XPoP3lRXKXNzXaZEh6srv3/nFYT2ocZRcDVriVkC+zJkK7rXLPf0f3?=
 =?us-ascii?Q?AsQz84xmYL1rbu0IwVUY1gptaS95i56yJHz0fFuhzte2VNhdAqa9ecRP4zhK?=
 =?us-ascii?Q?gYA6wjXMRiagIp8XVmCdc4/136tc7PISPzL2moW0OJc3jw4p9/phgZ6KELor?=
 =?us-ascii?Q?vW/+QHRVG5v0CHC01e0c/hryIf8Vs6tPTmlc98pGKvI+dB6/i6zeF5KZiM/s?=
 =?us-ascii?Q?4/D24k2wr1LApRPPLmity4qPJf6PKqRZ04YU2y4U9PtyL2SIp+bMUypueyx1?=
 =?us-ascii?Q?vmYSF3/f6omKY1wgLMnVU3S4ufWqP4/DxpgsAlg8ZBHUv7TCVfVrjtEHDAH0?=
 =?us-ascii?Q?xzgtxuXeHi5Ll+/V+zAh4EW+dO95AMsXPe10F2q16uuZgYODUEMy2DstTmnv?=
 =?us-ascii?Q?YOjRA3AFb+ds0Kru6rT+yG4RWggrICvcMb8HkoMrFyuSdRXQmOv9V8g0yWEG?=
 =?us-ascii?Q?6zJ1M+ekMI8+udNKszEKHc6ssESN2QcvzZnRggHsJ8IMTOTj72OZ/HgDviQT?=
 =?us-ascii?Q?XMdbrPAcp415HeGgnn+VrAlZNIqyGr2z/oqdTsARBTcwwxS+wyy/by90vlzk?=
 =?us-ascii?Q?ZEF/1pu/1b2PFshMqJKael5OVAzz/xzr9EnVDT21hg9bKtc+RBog+iCNyA3W?=
 =?us-ascii?Q?CwmlWsBQy5JGMNtcsbB2g1q9ER+ifNFb0xyCDlYdqqjiQ9tatFP1FUdj/umO?=
 =?us-ascii?Q?qm/QG203lo0+nXstJ/64p+RXqsCF6xFPUx8ryrF0TQdLYVBboA+E2RHRfVsb?=
 =?us-ascii?Q?mL7FHa6kdyalMtv1teCv8YnqHLsg3s/+eciN80NJq9J2asG7+3L9VDBin/Af?=
 =?us-ascii?Q?7OCh0j4TRdq1hWhiQts1EBURNLnPC3Qe7oHHTYfAN25tPLBFy84GyFU5aaBj?=
 =?us-ascii?Q?KLEnKGN14L/J2ICLnqXZmgQM49rZz7tyk4BZK+fMx9JKVFY4xrOJh6trG02B?=
 =?us-ascii?Q?Q6kOY8jV9DKGWxSlw9YhVkfevm6TDstneYCF9AUuNgYn40PkOF2bI0/GAhzT?=
 =?us-ascii?Q?WEhC3f3tLh+OWK5ygg5iDzcBhKLRcq88HeB?=
X-Microsoft-Antispam-Message-Info: PDXdeEmnfQCnmpmGJTVyNiEGT5s+4XUvG/Xtlg4j2e0XZO9W7Nbae6+J0137rvz7mAz0HKuquWnX+g2WPlu/uN1C6PjV9+gKsIk0hfm3ZHqtzp1n6AnWwZ5Dk1GNUI6M7m/0F5BxfUkjp2j0tffa32Tpti6uIc1K+WxG4vwnZ/KV5oBGo4k+arVqSfDZaZBd
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0332;6:t6uQ6QsBlD9D/XjZufETflvjaQgVDSPgr96S9b6MAI9aV+eu6ioY8RV6GBLr9+d+D/mn26qDKBRB3qjp96lpSBJNhh37bLQWgpJ01+emo0m9/E0rNwvEv4rihVp5WDxgyaNS2QHfAtQA5RUAiQD0+PH3gvG5A12xoBBlc1DIjDII+lx5G8HP+B+Fs3qtD3yVrhZJ9mv0eCXg8tylL2zGmfGdRyJUV0mlqnDYGqvJA25lFNlyqeinSM9+ADk3W91fH4MWSQlTNxjUVC8X//S0teDLTQHaZ0tzVm9i6x0+j+83gUDSKVCPwTT3ey/r3Zmrzr/cR10sKtOEfbDHiWGcy/IbIh/ecxnf6GqiLN2RaFNjOsoUFyihnn0E1FKjHL4z6fqU0kvk/hYwxZZCEGwJnivWZVxvyeUV8x3rBePQAw1b73BrWQ8p91Pijh1pGBDK74EfWJ44YIlWsReW5zxAbQ==;5:Nu4bOKutLLRrLilGI1WEzIWv65bO5mHg45yvhvgj9GpGGTsGbhGPDJSXZ1etXpRqiof7dVbHrn00PK6MrZYW70H0Y3gpS3hLU/36vIQy1cXIrNPQcBbap828J6d7+7qu/UMifhUYxhH6V8wt9RJ7DmbaBpZ1YYNbZrdfuwxnGs4=;24:tl7VAe/hKyMuwBDE4iSCbCBYZh7xCpfIOJe9V21n1yfl9I1+mrUoeN12ogICes3206JXd4OsBaXUvt94JhnHMhc6tpnbOIlg65oWrTxBa0w=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0332;7:h+p1Ux8QggXPM7pM9rS8lDvKSA410ZYbV15zpZ607Rj62tU5rqSUt0UY+K7mz1+IhfYDLXEgebzdo2O/aHZWNlHoF7131m5tjpkmA96lrKeXWlynlT3DB+rGzeSjk7UbpFUDhw8WEx2mjoaxBdsd3uKV7iz00tU1FvrXAAF6Ent1+455mIU9AxoSWg6fLUdHG1AM2qfCUee47QsXmgH2DFeb2mIDVHw+MnpME4byXVgjNBq4bKeHw5Y3iRSTXxO+;20:YmSKgkMPR3K3B189xFkoH0KBjuU89fU3dxnFOj7OmemaW08gA8B8HvQaXW0lcRo9/bEOWUlyS142aR40uLJlvIQlqCd96atGsGIsbtUCqDgX/6FhVtI/m+CHnLJzsanI4meUc4zTsCuLDe2xm10EDA9j7KSCoHJHdVQ35PDTcVEmdApSFKvCLtkq98NVc6mMDgwK7npyAPc5Okjf//4EPYFjm5bDMdgjbPCRPJ7d3Y9spTXfghG72YIza4u25Zkn
X-MS-Office365-Filtering-Correlation-Id: 22f329bb-8cd7-4b60-aedd-08d5a9f89aa3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2018 15:32:35.1382
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22f329bb-8cd7-4b60-aedd-08d5a9f89aa3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR12MB0332
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the ring is hanging for some reason allow to recover the waiting
by sending fatal signal.

Originally-by: David Panariti <David.Panariti@amd.com>
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index eb80edf..37a36af 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -421,10 +421,16 @@ int amdgpu_ctx_wait_prev_fence(struct amdgpu_ctx *ctx, unsigned ring_id)
 
 	if (other) {
 		signed long r;
-		r = dma_fence_wait_timeout(other, false, MAX_SCHEDULE_TIMEOUT);
-		if (r < 0) {
-			DRM_ERROR("Error (%ld) waiting for fence!\n", r);
-			return r;
+
+		while (true) {
+			if ((r = dma_fence_wait_timeout(other, true,
+					MAX_SCHEDULE_TIMEOUT)) >= 0)
+				return 0;
+
+			if (fatal_signal_pending(current)) {
+				DRM_ERROR("Error (%ld) waiting for fence!\n", r);
+				return r;
+			}
 		}
 	}
 
-- 
2.7.4
