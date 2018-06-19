Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91EF7C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FD1B2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="OeOHJV1k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FD1B2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967097AbeFSQqp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 12:46:45 -0400
Received: from mail-cys01nam02on0070.outbound.protection.outlook.com ([104.47.37.70]:13344
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966866AbeFSQqB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 12:46:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=633x0iq4tAaABXXxgfrmtJdDKuJP1QZ9gLJ2Vr8h3vE=;
 b=OeOHJV1ktoOzeICjl5ZnMciz6KqiFHLDe/4THwlbtP6nGBSbe+MkWk41AaMquJ1A/UftZSekOqkY3nOXklGpJCjzSiRN32TK1v7kgTYkMhqiCiXEaRJL7OGgcWEd5fMfv/7yByU0nNzvpva+n091FPK6mZQyLsP6Ctec2+7YiKA=
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
Subject: [PATCH 1/2] iommu: Introduce interface for unsetting bus IOMMU
Date:   Tue, 19 Jun 2018 11:45:33 -0500
Message-Id: <1529426734-20639-2-git-send-email-suravee.suthikulpanit@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: e337e06a-c185-4097-9d2d-08d5d6042244
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DM2PR12MB0140;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0140;3:luR6IrtbP/AJ5TK2jBS0obm5EqSukcP7O28On6EYKi31urAdR7xWGbfcGp+heeVv8jL2UnaSCci0y0r2O32fMdlA+a4zKQFify0h9MTk1KcKlCW7uTtj6wuXgaGGyZyZ7G6/rURJy0eatUmpGWcsxenGGB8E1XjrCt6I8PRpvbUTRphcgV68mjySGndqyeGgnuyU42bFoXslABN98KVTtCPK7oQDBAKVoPYNvQw4lhObVJvWRz+d97Xanjqv5P/v;25:nn8iRunS5LTf5+GfIRWQWTf7x4kL5OWQ+fiElYoSUs1NOPiw8GN1NfWQ4Fikr1XlKALtQEHF9l3A6x89iOmdaz/SOxAmnK9VPt1+P2KAaiH2H62GJYthgMWc5mbJV8E7qMF+jB7wGvpggJgE/g+5J8DGY2k2vtSBT8PaVm6Rz+iHSyu6M60i7ocatuDHahlqqbqSYGm7j6TvSQUEMSXhCSSBO8Hf1UC0RzGWkkR5FJBc2Hxmbbg8XiiWMPMsLeSF8phmQHwutpcaI7evgbhi+UrvFQR1P2D8RShONuKH+oyyDrk2BIlE9aIrt4G0LMdKcaInPJwko8Tx04Sqw1ujsw==;31:ZGCRLtcskTmmwauKD33CWtAOpEmczQ00hn72J8VBI0BOO2rrkdg1TRKr8ZR5XqYZP8muySHWEIs55ZkKNlejgFpqNoN/EfvFQ9vo7U3bYaOIslZk/cTFqTYaxvo6E4jjV/Q6ewMyHpMLTY0uD+iFQsrYSrLal+swDg+l8zDySLrWbYdYtk5GWqh11wiiUIpRwYahxenUWG58Z96YnhH5CeLrdXri9LfYUhi90DdqK2k=
X-MS-TrafficTypeDiagnostic: DM2PR12MB0140:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0140;20:q4rRcxVP9hjMAhE3KL6in53hJJ1DOdBDcZJj4AEEfbS51tL1ff5C55mCUqPwOlB9u9dekmMz7yfbBZW6wXOB3TOvAegrKGPvlB14TRh31Wv7sXJDgWOH27kE7+MW782jmIKRf8RR9mwnrbag/+//6dWqLOnj/bVy2roz/sKVtyZ+4qsp21BDOvxkjnn5GuiP9LhzqbM2zb9mzL4eYtWa4IPYuM3AGsFTWYkemN5HuWPJPO1YJO2iIgnyUllxWjQhMX+W65DtoNF/ba4zqd+/lLxdPI4ZRgS99k4m2UKmalAyqsyBldNW4xvP8fF03rTA6p6YB/8xz1T12Lm8XCS9eXlAqv6MgL9ZR92S/FW9TwYh6XI9UoZQnXsfxt4grYM+u36Q9yvyDLMhFFk+i5dmSjMqT4Up3I4JPjmaa25yJs30LY7mnQ3p16/oqb623ZdR9Nis7E6d+kPnmv4I60MWcvOUQhNN+ZeBm14nePXGze3wA0xUJNu0SfpsF25LW2Vj;4:W5dIROUiwQwAu+PCLKkPazKHe3bzeyZW1uJorrwoPvc5Upau8Mg/tLh/PRaxtRCPFb9Ro31f7LCalA32V3kQ13HtqwGP1rksH2yPBzzd3ih6NoUzb/1dVLMsnZcmYcwpsAqqAOCHqWJmImnURd8bmau90GgxFFVMrseVMJVRbMtdOWSf2T98N+Yv1WWTvjsJWMV32jR9lO/Q9pBFtUE3USKtZijRdeYVLjBdXNyMbX5dl9FidkHwfEyBFgRsP0DVNyB/JuB0x3aICXnEbI7vISqkQH93AYSI96itKsT8xgk0aV28b6s8jE4IpvLT5dv5
X-Microsoft-Antispam-PRVS: <DM2PR12MB01400106DBB1D3C683D0E26FF3700@DM2PR12MB0140.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DM2PR12MB0140;BCL:0;PCL:0;RULEID:;SRVR:DM2PR12MB0140;
X-Forefront-PRVS: 07083FF734
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(366004)(39860400002)(346002)(39380400002)(396003)(189003)(199004)(44832011)(16586007)(11346002)(476003)(956004)(2616005)(316002)(81166006)(81156014)(50226002)(106356001)(66066001)(47776003)(8936002)(53416004)(105586002)(386003)(72206003)(26005)(25786009)(446003)(16526019)(7696005)(52116002)(51416003)(76176011)(186003)(478600001)(86362001)(59450400001)(486006)(5660300001)(97736004)(6666003)(2906002)(68736007)(8676002)(6486002)(36756003)(7736002)(53936002)(50466002)(48376002)(4326008)(305945005)(3846002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR12MB0140;H:ssuthiku-ubuntu-b2.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM2PR12MB0140;23:cb1DlYfHPua1LV6tmnZyQqbeWXvOw2s1nJuu8jQ6N?=
 =?us-ascii?Q?NFEejhBKkIOKkXHi5pfcWHuUNvXgdyQVpAHNQ/+oBjfXSQ4ej94q6MTcrbcS?=
 =?us-ascii?Q?fIOK66N/FVHmc7WvcuJV6o9Tx19Y4rvUDlJfSDA2N1sHASvQeu2vlMt4o0Ny?=
 =?us-ascii?Q?xENDvqiY8bWa/E0xQzMAPMwxVbtuoeNuNhN+S6QHzpOXL6DDEOWGZ3EMg8v9?=
 =?us-ascii?Q?fnbvShZ+zTMeC5KA2u/ISTzSS9GBLaCr6B7EeuKUFPRrFkcd4dvreSZoUPSR?=
 =?us-ascii?Q?qFPF36fIi20t1RZER4CqofQiEsZY18IOOWI0R1GiynxrUPKo78iCqdSQMZNB?=
 =?us-ascii?Q?z7de3IHRCISLI83Z0Iw9u3uFqeRqmWmxvfQcuHS5VqX9wende3F5LR4GS1qo?=
 =?us-ascii?Q?R8m2ec6Ld6iE/x+8PPkG25vCDxxpBq0toSThn5uMgzKBoC8ZsPpV+nHgaSCz?=
 =?us-ascii?Q?Sr5WJX6iAKnXfSzGACbNK77C5zeL22TSavQexnfitzk2wHDQGrljbLfZghEQ?=
 =?us-ascii?Q?x1DtjVZYKV6e6+sv5Pm6W03vAFJjd6UaUve9hoBcfa1SfD17jM8UkLu4pBjO?=
 =?us-ascii?Q?XgLT3bIR4UA0IB24AIREB79yrkynNCShC2JmtslAtxYB98e0EWJrQRoUxJRW?=
 =?us-ascii?Q?KkPByiiAQCPnRlRoXExCg8Um/O3+yj8OeTx0YBNTq/QvImRO3o6fMTb48tD5?=
 =?us-ascii?Q?jLcMsWgGAV6jSA4Kdh0vZviHmOiWP6BqO6wSfGZ0oelqrPmso1+KU08I0BWI?=
 =?us-ascii?Q?SFI013pUNh3dlmo+3qrn5iJOvoebAeH147miRIbzSB5Ose5eENKTQOvIcJXS?=
 =?us-ascii?Q?HyuBPjVxxaHSUhPBB97/apc8LAUj4RcDKIIubRyLjjxh6lo45QB8tPE6mvmU?=
 =?us-ascii?Q?/5PZpAvBc9c/UmzipKKVzgTs67lkuXWZ0TaNJz4jm4MLoX+XGSTsvFS7GQVu?=
 =?us-ascii?Q?TZR0iLwoT0z17hShO52IXsJSPNUZtQkBgCNKS3BYnX2cYLUPKXnnxlcFEaQk?=
 =?us-ascii?Q?fM5SpBbbC9ohasWz5td+YzzyXXrglGL002WUyT2kzSQJuxrTUh2dCJL8LSVU?=
 =?us-ascii?Q?6BNoIOgC/jKTypInKc/ihMQ1iLO1h7yAYVk1HgmieX99aTPDGXYhlYvD6Muf?=
 =?us-ascii?Q?7DE2R3h7HDWhOo9qZlQSUIeK02xIBw1EzctI1E/lhp97HuF5YyZq60VaB/S7?=
 =?us-ascii?Q?8xfMUrTLtZ3DWVLm00wvmnoTe+hQf1gkIYf1/FeqKTFWb9sZkvT83UEfQ=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: 3rQeC4+J0K2xfH7xprFJRzK44zZD6nJx/INHX71hwCwtJiRy3CAPXIyyFdj10OwlDNC1LR+2PMU+Zl4kHkCnNqPm/hLRhS4GxiXDsOvS03kldL4x1L+1ZOGPXvPsZUa1lFzaVP6R2YmaQeaMa4O0PUsfqqO9LPBU8YStE2XvBQU4SB0f6t6f28aagFldhGMNSRnbFHrRsD6adOE7SLCIjh6Uhqc9nHuxWG/6ZcR+p7hO2UPsSlmXJsfqtEWVsKHBVOaRTgFU5VHkWqLwY8AJVCveM24T2E3+xpzGnLvbsm16PA/3BhOtdOlb46TFMYgmWVUKCQTfH2xxSAudaW38uA==
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0140;6:HiTrwJFNMiWvfgk9jYLLX+fS7ImBK2uUXHVyDJsesVjXEJYu2ynG3zr5qgs8zFVVL7kQMVpkAI27Y2Uw0IeP0HagZEFpF5f/SEr6XlFYmQjX/P+3xK1n7/Ap7YomqefjWEdHDSuzDAH40FPBXbx9x86nrmYRoYj7ET54FvlhC7zeM+yhQW4UeRWN3BBserhH7LBLIQBFtKWPyvaxsMwFEciH4+GZ6XrqXXTSj9D7dvbJPzTS3srYEginOpisdeelaZBicaDe7EAejOfK/nIgCLJ66FmdO+2YozJio8rCbiqHT2qbysbhiXSl7Qo3XtTJx5N3cJm65sAD2k0OBw6It6bbOE04SyWxLNaL1a+LO8MO0eex9mCitW1Tf+Rxz+Dr855OWjU1RS2gTiu9gqW0/9W0FCDADjK6kFwQZPw6dh2Gs5z+Kvb8AreAd3gnc27duo9D5U1StAj1ngPEIwcarQ==;5:8JTXgzfOFpZmh65HyCZUFdJTrSi/B2CXQdwNYfVVxe3MOY1SEUWJMc3f+qWvCsMtEa1hAECD7NrmBlNKqPEtzinEAujPXQ1bYjrxByK3/kNyi7R0zjAJ5ecxaKs+KXzTmG8CJf7qMFm4qAJ2q1VA3GT0AU2NznJvq5ZGQMjXRrQ=;24:z+jp6lC03TmFojXka+Ka6WNXWTRh5K3Jq/7M6jzBLcMGH6kpSobKA2JaGRWUFSyb40c9T3he6KgvTvsR2ng3x072S6GlZoAfBD3oLRKy/HY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0140;7:QB0r2QEZ1TdM26IZYRsMhxaUakMa81VgUZrgU5vdh40fMEkvmoDV9aLd1hvd3uoVf4MgZ+XaZhebl3A59Y67YA9u6SiUN6weo1wihEoUvpKq5TFIppqtiROXcKbuiG+ZRFIHObL+IbL+6cLQYrpD/vSNrs/J32i3hKjwlXZ06wMPXouxgQMQF5xCWZijiGQL+Bznc1XJYM4ecv6qAGqniDCB0zOfVSUxYM4FnEAH5OmdyuWYSEqZA/0AOoWVlxAQ;20:Z6fkCEKIELIaA5YLgrR0vaYYAEMXeteUsEygW0zYXiPd33Eav2FcGWilZheNQsRDG8KGsQuZB4Zqil7VIbQVq9LWgwV0YLaKeor8dh2aF8Y9KwLOruaSVuEYImCBV4WT7k6+442I63gbnV7RTnrcEdFOkU62PNF9WIgtXRsGQ2gM7SIUIfJ0JZQcmBpsl7IMNRpWQxhKvmKppnULVeqBeqjCjPsyWTXTOlnQH1SUyLbqqnWt+ViW+WyBwiYLGzyj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2018 16:45:58.1715 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e337e06a-c185-4097-9d2d-08d5d6042244
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR12MB0140
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This interface allows removal of IOMMU from a bus if needed.
For example, when the IOMMU driver fails to initialize, it should
unassociate itself from the bus (i.e. removing IOMMU groups and
unregister bus notifier block).

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/iommu.c  | 22 ++++++++++++++++++++++
 include/linux/device.h |  1 +
 include/linux/iommu.h  |  1 +
 3 files changed, 24 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index d2aa2320..56691ab 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1165,6 +1165,7 @@ static int iommu_bus_init(struct bus_type *bus, const struct iommu_ops *ops)
 	if (err)
 		goto out_err;
 
+	bus->iommu_nb = nb;
 
 	return 0;
 
@@ -1179,6 +1180,27 @@ static int iommu_bus_init(struct bus_type *bus, const struct iommu_ops *ops)
 	return err;
 }
 
+void bus_unset_iommu(struct bus_type *bus, const struct iommu_ops *ops)
+{
+	struct iommu_callback_data cb = {
+		.ops = ops,
+	};
+
+	if (!bus->iommu_ops)
+		return;
+
+	bus_for_each_dev(bus, NULL, &cb, remove_iommu_group);
+
+	if (bus->iommu_nb) {
+		bus_unregister_notifier(bus, bus->iommu_nb);
+		kfree(bus->iommu_nb);
+		bus->iommu_nb = NULL;
+	}
+
+	bus->iommu_ops = NULL;
+}
+EXPORT_SYMBOL_GPL(bus_unset_iommu);
+
 /**
  * bus_set_iommu - set iommu-callbacks for the bus
  * @bus: bus.
diff --git a/include/linux/device.h b/include/linux/device.h
index 4779569..cac7baf 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -133,6 +133,7 @@ struct bus_type {
 	const struct dev_pm_ops *pm;
 
 	const struct iommu_ops *iommu_ops;
+	struct notifier_block *iommu_nb;
 
 	struct subsys_private *p;
 	struct lock_class_key lock_key;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 19938ee..65f998e 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -287,6 +287,7 @@ static inline struct iommu_device *dev_to_iommu_device(struct device *dev)
 #define IOMMU_GROUP_NOTIFY_UNBOUND_DRIVER	6 /* Post Driver unbind */
 
 extern int bus_set_iommu(struct bus_type *bus, const struct iommu_ops *ops);
+extern void bus_unset_iommu(struct bus_type *bus, const struct iommu_ops *ops);
 extern bool iommu_present(struct bus_type *bus);
 extern bool iommu_capable(struct bus_type *bus, enum iommu_cap cap);
 extern struct iommu_domain *iommu_domain_alloc(struct bus_type *bus);
-- 
2.7.4

