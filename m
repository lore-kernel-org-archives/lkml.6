Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E6BCC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3BFE2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="duPRfaGs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3BFE2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967050AbeFSQqF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 12:46:05 -0400
Received: from mail-cys01nam02on0070.outbound.protection.outlook.com ([104.47.37.70]:13344
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1030260AbeFSQqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 12:46:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/eT3kgJuwT6y66m94p/kgGXU/jvbCtMsa3XQSa8R+jc=;
 b=duPRfaGs4K6drnNDMidR5Pj6jF6Q9O2/JtapiOZmLTToAdnxMz6hXbAYCR4yqNQP8PVWaIPG7OI6zDGyzeYKKdmdE6QRXrbmAXe4viCGd3Jn45TkL0yMiP+iaCymax0Z7YIzAGcrHTK37LUU/ARS1U0aqgLJYaFXGzK+zF6Oz5g=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com; 
Received: from ssuthiku-ubuntu-b2.amd.com (165.204.78.1) by
 DM2PR12MB0140.namprd12.prod.outlook.com (2a01:111:e400:50cf::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.19; Tue, 19 Jun
 2018 16:45:58 +0000
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     joro@8bytes.org, gregkh@linuxfoundation.org,
        rafael.j.wysocki@intel.com,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH 2/2] iommu/amd: Fallback to dma_direct_ops when fail to enable IOMMU
Date:   Tue, 19 Jun 2018 11:45:34 -0500
Message-Id: <1529426734-20639-3-git-send-email-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529426734-20639-1-git-send-email-suravee.suthikulpanit@amd.com>
References: <1529426734-20639-1-git-send-email-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SN4PR0601CA0014.namprd06.prod.outlook.com
 (2603:10b6:803:2f::24) To DM2PR12MB0140.namprd12.prod.outlook.com
 (2a01:111:e400:50cf::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c1c5152-da42-4410-8888-08d5d60422b6
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DM2PR12MB0140;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0140;3:CjFBMh+lSn1FBnFBVmqWPXAAq/SGNHyzvsWoJ6iSo/lbbMkwuy3gYXrlaSX/sR57DF9IRCpcSPWr/zfOM/kuqX1e1GEmP4jjB5xdnEzhMa4IWlj/MfpKsn9+B+RlHklJX9ZmJSlFplvi+ezspZ79zPT0lOzSWt8JhgCU/kCf4WHutJOSEUixreZDtQuDqQMyWPVk040+AXevqqVvDjf49bIXnJZiIiIMnVRjq09VbQQjRsvDyXjCTpqE5Bbcmn3m;25:s3PY/W2B1mwoRJTeoB2gODpNeulBnyaeZWUk9fyiohgtVKo4hNz2mf1+1LShY4Yo1KXfrHFvfqKDUBN6yjKMKNzb7S8/VdaDbQ77sJxaz4gJzTGcd+EUc5TAQHTRZaCSZHslASSBlr7fe0znSlnYwPXiUeucdtAxyjDskXbFebIhFhiNAv9mPMCM2oBgLZBj1qnTX6WHe2IxxXubdtmldMazQpf/2RTZEXB0pjBA8jFRTkGzFVp5gzROtjaoHUH0u4KJyUAGBDtdfau+xWuMl5W9maifKunZtMJnYgoU14Pm/seDnYU2jGk9wwR84Rt41RXttiebN1vlrCXq3cbCdQ==;31:QCaLW6wZ6EazCelqAZqBzM8oGIMkBnGVDuDpj/b+Gu0sMOCs1jT8LGZ26Rczu8JswKPZyVxCpaA4+C2rnuFd9ZiDQs9RFy7vCGV/jAl3Gc2nzZsbOKdvbevDhVS1dqmKvIojTKhLu4NokZnjy/ahs959XqCFIMGpIu77TFoTo9jOzv7XGJhY6wTMoV8IWwaj9lTGxMjNf+cw6LqozVnK7WHkBCO47fQI77s4rDBr+xE=
X-MS-TrafficTypeDiagnostic: DM2PR12MB0140:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0140;20:i0Xx6JP37L3V7iM2PNJylAWduEHhZ+MfPCBAJpTPygy467fA9M8qVkvCaEC1r4L+QEqHxoqEMmHfm2LPGJrlqv/QeXUoh++JXRRlEjH1QUyJrfK57c1Uzw0loUbgqNTjUEhFSj+UrsHkzhdaMuD67QZxzyaoINDwJO+cdMYxikSlQ7JKVhvyXZlSu5SMfHLIIxPjAZeY9YK7QxtPrbHSHvYn7xS7Gu4Lp0jYP63kn08SRSbqg0hdP81/ApWf7SZ3ysLa1i8BKjft88ELi+erwCUWM6z8LSAa58EEMCpEeFsAcnfInPN0iOnbUYPvVQm2wz9qTOGOYHu5WxCnsIiMnoJafDiqLZg5BF632tAqmOIz6A/Ou68kNHwHpXrX8bBreZEIpMlzGIkJCoDZf+NEg89pX5SzA/d/tBQuNAedj8mLw16Cdb0BgRsxSCBzzeGJtWwTKTjnMsxbS0RoceEpFelgrmffhxFGdg/TuNUEqhgbz2c7tbYuSgtnUpdssnrt;4:SG0AVb1P9jWFOTcOU94i6ZZ2fudGnkVXM34i69z+a2a5FsLifsc5yh33sc2peE64gKPRY2xY9bajhNe5DC0N7tPiaHpV9IOSIVOqKFrxlKwEIeHnU3BOQ4mIRlPllrbTz0qTJ8XtTG/G3hFVbt6WscWhg/QmEo9ik4CQkF/oul1rLyOKCWbWDHglWIdIuniWpzixJN/DcYBNenlEFQ8iJxOdUB3PNIUgoMNoXoxxl78WPo1UscY+aZQHY3Bl2nyj3h7ihyPh45kugieMBz28dh4c5cNoBmPSTpSTjzWTKzCUT6zYuEGpX1McQY78XXo4
X-Microsoft-Antispam-PRVS: <DM2PR12MB014076E12C86E37A253C7740F3700@DM2PR12MB0140.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DM2PR12MB0140;BCL:0;PCL:0;RULEID:;SRVR:DM2PR12MB0140;
X-Forefront-PRVS: 07083FF734
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(366004)(39860400002)(346002)(39380400002)(396003)(189003)(199004)(44832011)(16586007)(11346002)(476003)(956004)(2616005)(316002)(81166006)(81156014)(50226002)(106356001)(66066001)(47776003)(8936002)(53416004)(105586002)(386003)(72206003)(26005)(25786009)(446003)(16526019)(7696005)(52116002)(51416003)(76176011)(186003)(478600001)(86362001)(59450400001)(486006)(5660300001)(97736004)(6666003)(2906002)(68736007)(8676002)(6486002)(36756003)(7736002)(53936002)(50466002)(48376002)(4326008)(305945005)(3846002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR12MB0140;H:ssuthiku-ubuntu-b2.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM2PR12MB0140;23:sP9NMhiF60ToTXx5TmF7fCLxcj47j9R1B6l+T5L3A?=
 =?us-ascii?Q?wpvSvP7B3KDEFAKmPicitz6rS2tvsVjxWLpjrCoHOwcqEaX+C/VKKQpfPiLu?=
 =?us-ascii?Q?c2gDb9ok5olJERnrVxefcF2Nx5pUmaLEA1iEOtBX30aqefYZU9rzgVBoOJpr?=
 =?us-ascii?Q?sh1QHbSty+OBCFTi5ZxL9k/jVydBhCvfVIFFB3rcz3QEIyOMW5mi42pNSP1P?=
 =?us-ascii?Q?6eNwdlkCL/lnE+9Vc/vyyvk8dKUbzaCKF2ggFOZ+3HyDN2S9N6bjqFPMGGKG?=
 =?us-ascii?Q?MAM/sDdUYVttWEgECSl+G85q3Fx1qlKIaFxQqpspCxizy/dn2d3UTrF3fcfI?=
 =?us-ascii?Q?fk5FDbvr1aJbv593qyscRmOsxd8MV6SUYzLcX73ljV5gtYMu4V8xlvTinaOo?=
 =?us-ascii?Q?nF/HfDRtdHZD2Urv2eaagl+5lzC4tb72YFlxXvwqoSWT3ezs0wY+3ApwVCvw?=
 =?us-ascii?Q?dQTl2mDUn7Vlcdc+ZN+tKTtDgL7nZNshUTyvPGrXVdc8SELZK1G12V6Z81fV?=
 =?us-ascii?Q?weBYgchF/3QdqRGhfVsDLoI3YYtTfgp1XO15OcXaCFQ/AtEDImGUgsNxOn7J?=
 =?us-ascii?Q?hv7h75wpWX/lBMk9DEl8UkhpQENmlo0N8tSIcEcdVKcNGwPLGtkpwCqlJwRW?=
 =?us-ascii?Q?2casFSUkRJTahaaaasrKhx4YWslwaLb/2P1S9cukIoUwccafo+hK+K2AoOkA?=
 =?us-ascii?Q?qBRihSkM9rxb9R/bIn7AVxfV9XPQmoPiUVjog6t3zfqmGqQTijKaRmaQYoQW?=
 =?us-ascii?Q?2exXYOsQwCEd9ZUi3EcnX75IBvoVHFRHfSHsKwB62eKcIdSgKBZ3OCKBTSMd?=
 =?us-ascii?Q?0D7wcdB+8858NguEcHBrVjS95NchnwJsLnkOC7gREWbKpvKHennvUp/6TWYP?=
 =?us-ascii?Q?6oJLlXiXdHRaPrTGpDgiU3sn7vACvDCLPVozp/Cl2y+ih0XUg+TiFxOT1RLl?=
 =?us-ascii?Q?W9NOzL5cQmOeEfpr3KTyD9GNtEtGytuQ2ZH/XtWdsa2peBahn69wu8WufqLt?=
 =?us-ascii?Q?AGEECOfhFDd7KGT++eRX7jrp094fba0s+Ru0C8oie/kcYBxS0Tk4Yx7vfnWs?=
 =?us-ascii?Q?1W1bdZ8rZCvBZ7/lo/17Dpm4flFyJrwHzJj0vZ5gAP6SoiVlCOOj90YPIKab?=
 =?us-ascii?Q?iaovVsZOWq4puGouVeaM7uvzR5u4hVbkSMQYXQPdfWIaO7+LQA7eWzXB8MoA?=
 =?us-ascii?Q?gIYfK6k3uIFYNTdZOpq+s0fqHhvECNC+VcB2QEZ5ndEpaHxcyxliBx/NA=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: /vbzw67Ho0ifE5KIekl4wpNS+kG+2PAcLIkEqaBJw+6gdE39iUS6CBwzC5J4Oz9nw2lWQACdSrV0WLFjg+01WOgzlXdv6qgiaP9sSvly5ZCWWEBGA4qkkgig7+7/UGR1ETWY8+jjdPF7gpW374uI/mhTaUHT5Mjh/9f5nfB3k4an19YYAsDWJv+xsSL82Rwlx9vShpWRb79KvJ4jun4/wRbphevpJjDf1vBVJQ3Fa4XTQsTqaNwHecGxpJfTmfALmAb0l2nS+zDipPbFY7Ze9kQwBh+K3TPJkrElgSvDJZB45hmodfe+rOHOR5WCS2VsQMi/1xqoIuInJ5NEbQGf5Q==
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0140;6:sgoE9FcxlXghUwwKWEmWBcDp9TXa8vQW4Tn4MrXSCauRN+1KpkTwb3uxQEnCjZka211gZzz8/TKd7xbg7T55mVYx5qJWpk4nuxIRyqvdkdlAPdsJEvteGZ2RnUmDn922R/lBA8fOEyLKEF3HbWCmtvnRiB3T2KAwACkEW4L21/XtzwwKPELLpIMRKvj0tUP2zqz0y+jJ5S4PIxDAEsJ6mva86TXlOVMsxmGPise1bnvJI0UlJOccJY5xfV+SBLcZuDhqv3E7d6kDiRbInK3Bb1gQiksWoG/CFTOc/Pk/KgtG3gZscJfKts70SaoEWNjzFNFOfHhS4kQUpLMhzLHL6Sxd5A/VdE27LPlrPManq7x3DrU0oHcU2bcudcmGFKmzsTnpywopDcqlW9rGvu5pvmz5fE3zVNd4mTY4XEHUzgy2IbcYX82sBnd4EcFIObT30QnULHTtbUwLUv7usA0imQ==;5:9lh3Y5b0UGgcFiegWcmTkFK1AaUjwunEYZSZ2uWlWHcjqvPirEMCNdYCCy+OCZhE8vrgZUx+PDXtYGUzXBMzqHjGWG1DDJ6WUqFOp6z5L66K0bQCpNYkJOCWyRS8Hzntc1pWtPsT2SW/Cm7N8isVgEs5+DIDvshxxUmcTPDRZrU=;24:dpy1cjlb83NWr52VOBlAqS5BlgrEVf7WjGj4iM8pHT2wm9Ty9JeFxlvzkdTHlRY4xqj5XllDviHlOiMPpVxQ6N1W5jzceXX/gMXtw2fMtXY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0140;7:Ah2F6GrD4pJQFYR/2W6k4di2RdwkKDaTccid0AsemsQxIX5+J1aLLTbAL16RGZFM4CIIrWI52p3BAIr3R8YVVkFFf8/Nzv6Uv215EudIMVZGIgK1/gPkYGa4K2NiRbY5i4flyr8sI5oFQINSA9+ZL1CnFYSh3Kl8iFszUOgOJwmAV/o4U5YYSYufIF83E2LkSXjrDg4GfI5Y+FvwmKuaLwQjAAqacrnwWfp2GzLddk4CDUOKDeYyVdUdf53wZAa0;20:K/qrlUHmrAOuyAB4Qdu1BlJWxD/H+1QmkqZSjUAAIpxUlJ9WuVOgyYleiV3M1F+kenVST5NHf3JkHqtTPchNApwU5I2+OrUnEQL0Kh03azBv8sihZYwLFCmp/RoJFKzoYO/YWGbKXPRYA49ePzld3g5cvS5kyYFSqJiTZRiy2JE4/is/1cxdHBD/VeOolpwofbT9KtgH/dLn4RmyXEWqm2iSlcYWNLaxYFPAcMl0RHf4bOTBs7gL0PyT4EvOa3b6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2018 16:45:58.9191 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c1c5152-da42-4410-8888-08d5d60422b6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR12MB0140
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case the AMD IOMMU driver fails to enable interrupt, it currently
results in failure to boot due to invalid dma_ops for buses and devices
previously set when they were added to the IOMMU.

Therefore, fix this by unsetting the bus's iommu, and setup end-point
devices to use dma_direct_ops.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd_iommu.c       | 14 +++++++++++++-
 drivers/iommu/amd_iommu_init.c  | 19 +++++++++++++++++--
 drivers/iommu/amd_iommu_proto.h |  2 ++
 3 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 5337fb2..3446763 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -381,6 +381,9 @@ static bool check_device(struct device *dev)
 {
 	int devid;
 
+	if (amd_iommu_failed_initialize())
+		return false;
+
 	if (!dev || !dev->dma_mask)
 		return false;
 
@@ -486,7 +489,7 @@ static void iommu_uninit_device(struct device *dev)
 	iommu_group_remove_device(dev);
 
 	/* Remove dma-ops */
-	dev->dma_ops = NULL;
+	dev->dma_ops = &dma_direct_ops;
 
 	/*
 	 * We keep dev_data around for unplugged devices and reuse it when the
@@ -2722,6 +2725,15 @@ static int init_reserved_iova_ranges(void)
 	return 0;
 }
 
+void __init amd_iommu_uninit_api(void)
+{
+	bus_unset_iommu(&pci_bus_type, &amd_iommu_ops);
+#ifdef CONFIG_ARM_AMBA
+	bus_unset_iommu(&amba_bustype, &amd_iommu_ops);
+#endif
+	bus_unset_iommu(&platform_bus_type, &amd_iommu_ops);
+}
+
 int __init amd_iommu_init_api(void)
 {
 	int ret, err = 0;
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 09d271e..d3f9cb3 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -245,6 +245,7 @@ enum iommu_init_state {
 	IOMMU_INITIALIZED,
 	IOMMU_NOT_FOUND,
 	IOMMU_INIT_ERROR,
+	IOMMU_RESOURCE_FREE,
 	IOMMU_CMDLINE_DISABLED,
 };
 
@@ -307,6 +308,11 @@ int amd_iommu_get_num_iommus(void)
 	return amd_iommus_present;
 }
 
+bool amd_iommu_failed_initialize(void)
+{
+	return init_state == IOMMU_RESOURCE_FREE;
+}
+
 /* Access to l1 and l2 indexed register spaces */
 
 static u32 iommu_read_l1(struct amd_iommu *iommu, u16 l1, u8 address)
@@ -2331,10 +2337,14 @@ static void __init free_iommu_resources(void)
 
 	free_iommu_all();
 
+	/*
+	 * We failed to initialize the AMD IOMMU driver,
+	 * and all resources are freed.
+	 */
+	init_state = IOMMU_RESOURCE_FREE;
 #ifdef CONFIG_GART_IOMMU
 	/*
-	 * We failed to initialize the AMD IOMMU - try fallback to GART
-	 * if possible.
+	 * try fallback to GART if possible.
 	 */
 	gart_iommu_init();
 
@@ -2583,6 +2593,8 @@ static int amd_iommu_enable_interrupts(void)
 	}
 
 out:
+	if (ret)
+		pr_err("AMD-Vi: Failed to enable IOMMU interrupts.\n");
 	return ret;
 }
 
@@ -2665,6 +2677,7 @@ static int __init state_next(void)
 		break;
 	case IOMMU_NOT_FOUND:
 	case IOMMU_INIT_ERROR:
+	case IOMMU_RESOURCE_FREE:
 	case IOMMU_CMDLINE_DISABLED:
 		/* Error states => do nothing */
 		ret = -EINVAL;
@@ -2684,6 +2697,7 @@ static int __init iommu_go_to_state(enum iommu_init_state state)
 	while (init_state != state) {
 		if (init_state == IOMMU_NOT_FOUND         ||
 		    init_state == IOMMU_INIT_ERROR        ||
+		    init_state == IOMMU_RESOURCE_FREE     ||
 		    init_state == IOMMU_CMDLINE_DISABLED)
 			break;
 		ret = state_next();
@@ -2747,6 +2761,7 @@ static int __init amd_iommu_init(void)
 
 	ret = iommu_go_to_state(IOMMU_INITIALIZED);
 	if (ret) {
+		amd_iommu_uninit_api();
 		free_dma_resources();
 		if (!irq_remapping_enabled) {
 			disable_iommus();
diff --git a/drivers/iommu/amd_iommu_proto.h b/drivers/iommu/amd_iommu_proto.h
index 640c286..7d81254 100644
--- a/drivers/iommu/amd_iommu_proto.h
+++ b/drivers/iommu/amd_iommu_proto.h
@@ -32,6 +32,8 @@ extern int amd_iommu_init_devices(void);
 extern void amd_iommu_uninit_devices(void);
 extern void amd_iommu_init_notifier(void);
 extern int amd_iommu_init_api(void);
+extern void amd_iommu_uninit_api(void);
+extern bool amd_iommu_failed_initialize(void);
 
 /* Needed for interrupt remapping */
 extern int amd_iommu_prepare(void);
-- 
2.7.4

