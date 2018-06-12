Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id CC92DC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 21:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6628A208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 21:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0Xk0cnIg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6628A208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934493AbeFLVla (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 17:41:30 -0400
Received: from mail-eopbgr690076.outbound.protection.outlook.com ([40.107.69.76]:7392
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934354AbeFLVl1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 17:41:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+3Wv/ODDioRi4O0/4eiHxIlhtzljC8h7ioFeSZ/EMMA=;
 b=0Xk0cnIg2OLsf3huJeSUWzEkMdZsc799VBEr8xzux+amTNoAy3lcECzMM3NVlAynty0gA3vLyDNd9IPIM+HJt7EIwWn0ufMsMuQlJKzvpaP/7lwLXk+SbywtDw2Qu8RKVduBuWk5ooARnWVPxZhokjbHMoPqnCFiEBakkRwIGEk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com; 
Received: from [127.0.1.1] (165.204.78.1) by
 MWHPR12MB1454.namprd12.prod.outlook.com (2603:10b6:301:f::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.14; Tue, 12 Jun 2018 21:41:24 +0000
Subject: [PATCH v9 1/2] iommu - Enable debugfs exposure of IOMMU driver
 internals
From:   Gary R Hook <gary.hook@amd.com>
To:     iommu@lists.linux-foundation.org
Cc:     joro@8bytes.org, linux-kernel@vger.kernel.org
Date:   Tue, 12 Jun 2018 16:41:21 -0500
Message-ID: <152883968097.1936.10168344980897538230.stgit@taos>
In-Reply-To: <152883965482.1936.13657625103232933481.stgit@taos>
References: <152883965482.1936.13657625103232933481.stgit@taos>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SN1PR12CA0100.namprd12.prod.outlook.com
 (2603:10b6:802:21::35) To MWHPR12MB1454.namprd12.prod.outlook.com
 (2603:10b6:301:f::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ccbf6c0-28f0-4fb1-af68-08d5d0ad3f17
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711015)(48565401081)(2017052603328)(7153060)(7193020);SRVR:MWHPR12MB1454;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1454;3:7wwOgUonqK9REWbZRfsiFLe4DJ2h2VcWsz77n2XigEYbo+QoIKeM5ItILubIuo6RerqiM7866CHNuOmj56IqoWsX+VPSO4E+E0aTp7a++MR4Qhcji2SqhNkbyfbvUO3542SKMFkh3GAgyYxSWIJCNwcboBT+rS5tZQn43i5f5wTYtQg2Tqd6kLP+9IZkSV1X/t0BS3DMZ2TTL2CQuiz/kezLH8DZQlZMq6LMSvYrnHwsCb6Z9ag0CI71PZ7xMetX;25:qjGUrJFsocuOXz4hM4o1GyawZrEf6ouN/+7auKK8a/ijp1fNNTpiUpcm0Q4FJKRl7Rv4sgn64qemtifxLVPvpcC1A3dDOrDJ7utQjyfiNVGF17BHITbfBcgKe5WUDEeeu1WzBYAwU95Q3g2fSZS1rFTfyFvfLMSNeRM+mcJYCELReflvKH0eDHT0nSuGPfQhysPY6+Ym8shDI1Kj7F56tHcFvkFqCM9AazNx0rj49a6lpI2Mr0HxFY6nhKzhLOelfk1I9RbMb1UQi1EsI+yayXE5t3O1kpKoFwGeL6YtDbcn5mN6u5HRphs1dFdcrsNl1WFc1Cythf9rLmMJISEqjw==;31:6Grni3gRjPg7KmQ89kUVu0E+pkriAh4zsirS+UhM/VCho9xk2wCUiDtN4iSsOKF5wfP/Ct5XrMSzG5EeKrNX2hxggGbvRG9C40HlZnIYm9sPhO2fPE9RAteYxkDxZ6+EBPNfpSxkXmcxn7U6rkHz/QJ1UrXTCnFW5qAohNOycQ5UaqhziHwvKuK+Wmop4U2OEgTIM8NytmOYPy8hLiBpoz5FkTwM7b8Tfl0KSv7EtrA=
X-MS-TrafficTypeDiagnostic: MWHPR12MB1454:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1454;20:9RZ+AgMFrDMaJqiz8occWW/oS2dSsFZ/qgD7gj9uB/ecuKzYxUHAuCUQXcs4zWdgHWuKn3IMnqA/Hjiw+BAGQI8s/HrbPxhM/Tv6xzEm6J7B+l/7JTBe4pkd359TONpwL7xZLOW5JuBRN9iTb2yH2XnaivZYFED/F0XBvXbmE3wsZelXEmys9ceRzxUeRzOKEzruxr1r8/iTwUh9YuLDkM07Rg2RT2GshEvZmEaz6soVH7+mJzfcbO18pSVT3SPMNCaug+DVXlpOPZ0tdr1Ow+QL8OIXehOkWZlrWzqcp84I9ux+KwkGbgcD+OAZVR60WvzpMzLSLYuceE/VgR5QhfseqNop6MPo5N2ErjfScfTC/O+oHMDNJAzhiXlOyX1Y8ScXA6rBXpB3rqPu4Q0O0zhHyCTZooFXPo78aVT/Q0ZkidPpiZnS/n434EgUBDY4koyeGYFBOfAImcj6rFwPi3T7yD0dJ9H49OGJ40cu8GiaeL1S/eOC4SykB873FYm0;4:ENlJutdrqeEV2ptmMLf12wA4lodl5etmYhYyj3bYSPRSWtdSL4U0KYNFgMVbnN8sazXhMvKvbEiAjh8gBDsrtm6P6dsE2QTCNHgOwvlLQiryNf60YbMxViH80enQRSn5tNfIGSSwVRGRjNytPZySCD4pLx3CAIAMCPR84LUsWNv5rsjXYMDwRfVcSTVvH0FLOjR2M+pYqurcnUdPQX7pUvQuR2zpOkfBwCEgWDW5ebMpZ6Nh+ARcy6y+trQxQZfR4JCjj9QmmnOcKeSHJSq6GB0mDJLBEqcHDeBkHD4ZRc+lixOZwuxPDXIPiI/Q3ej5oggEzd8jN/AuLGsQoJFeQkayyj6tRixl3HzuBrwA66Y=
X-Microsoft-Antispam-PRVS: <MWHPR12MB14544ADF902DB372DEEC48FAFD7F0@MWHPR12MB1454.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192374486261705)(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:MWHPR12MB1454;BCL:0;PCL:0;RULEID:;SRVR:MWHPR12MB1454;
X-Forefront-PRVS: 07013D7479
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(7916004)(396003)(346002)(366004)(39860400002)(376002)(39380400002)(199004)(189003)(7736002)(8676002)(81156014)(305945005)(8936002)(105586002)(81166006)(106356001)(6486002)(103116003)(97736004)(230700001)(59450400001)(486006)(386003)(52116002)(33896004)(76176011)(23676004)(2486003)(446003)(11346002)(2906002)(2351001)(6116002)(3846002)(476003)(6916009)(2361001)(6666003)(5660300001)(956004)(186003)(50466002)(77096007)(68736007)(478600001)(58126008)(9686003)(72206003)(16526019)(16576012)(316002)(86362001)(575784001)(47776003)(4326008)(25786009)(53936002)(33716001)(66066001)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1454;H:[127.0.1.1];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjEyTUIxNDU0OzIzOnJ2MmJFc0Q5dWxFRHgrTDVOUEZET20zVHRu?=
 =?utf-8?B?QkxZNGFqeUJKNVd2c1RjMnpNTUdNczZwM0Y1U25MQWNSbUVhYUVEVU1kR0Jr?=
 =?utf-8?B?N2FkUTRobk5xTWFjTnE1SFpzbkxUaHdEeE1Kd08xeUEzK2dXZHl5ZEp3dFRE?=
 =?utf-8?B?NWNRVXE3QWg3QkZRTDR3MnlyUlF5UG9RVm9OaDZnRUVSNEdmRDRCZG8rdEtV?=
 =?utf-8?B?MUU3MExQRlFpcDRsWURmbkdqOUVVL2ZqZzVsdXRzSllSNjJCaDljWkh5ZlRB?=
 =?utf-8?B?MWFJYXUycTFhN1cxNElFRFlVdjVYL0VaOVM3OTBZaElyNkFiMHVZczVKNXNs?=
 =?utf-8?B?TnlKMlZsQnBRUGxtcVVWRE9FMmliMlpxUUk1WGxXR1ZOak40ZUJheUF0QnMy?=
 =?utf-8?B?TDNKT1lWeGJ2UHZ5THh0aGRmM0ExZlZ2RnJFVXhPVTZHNTNaa2NIcWFCV2ZJ?=
 =?utf-8?B?N2lmYzJkdTZnVk55dnphWDFVOXFRd0ViY1hNbE5weHJKb3ZpNDBPcHpFVDdp?=
 =?utf-8?B?RG12WGQvUTF5QldwOExlSm5HbDdFVndnUU51Mk1IQ1ROUS8zQjhZaWQrVnBU?=
 =?utf-8?B?ZExPYW01U1BFOXJSd0dnNG5WYmtyckFOcWtwZlN1a0NXdWZ5ZG5GUUd2YzJ6?=
 =?utf-8?B?Sk90b29ia25ZZzU5SkhhNmFsbTN4MWZJOFh1SGdmTEl5ZERtZzJObUhGTldQ?=
 =?utf-8?B?bHBGWmpWOXB4QWRLSWxWY2dhWXNUZDhCYTUza2NwbnBnS1hlbEVhVUxtQ3pB?=
 =?utf-8?B?Kzh1ZnZEOEEzYlMwK1grVXduRVBPSU93VFhSRFVnTm5TMjFxL2ZkcWtCOHZ2?=
 =?utf-8?B?d0NKbVM5SndYNFlwU2NPbUtURjllMVRqWnBQUENZWmt6MlFEMVBpZWM2Q1Ur?=
 =?utf-8?B?R0pTZTUrdDJwYjRtRnk2bmZBS0VJNU5zcElTRGhkZmc4N1o3N3RQcVdBTHM3?=
 =?utf-8?B?bzc5OU1Kc0NmeXdnTFFLeStTcE9hWkxoWG9nc0JEVkp5eE1Cem1pUHJDVjZC?=
 =?utf-8?B?dDZVOUVwUGlBeWtkYjdBZk1MbGtJeWJzcFJiQUFZTFhHREJsVGlyc2l5V2VM?=
 =?utf-8?B?MW1GVW1JK1R5V0gzenB6QkliV2d5MzlnNllVZFpnd3paZngwV3MzVVMyUzJF?=
 =?utf-8?B?QURzZ0lsbC9wTnk4R1JtNmNBUmtxcERpYWRTZSt5VjVZK1lkZVhiVXBreWN0?=
 =?utf-8?B?MXIrY2hIdVQ5WUZVTk9IeXlybVZxVHVBakVrZGN6dEpBbDE4L2d6M2tVazIr?=
 =?utf-8?B?bG8xTzVZMmNsOExiS09nZ3NBcmo1NFd2cXBGY2pGa0srblpQUU5QRDBPM3Y1?=
 =?utf-8?B?eUxLWUpKS2Jqakowb0N0YWNLelQ4eUFXYUZiK2U1MTg5b3ZpTGxKejBaVGZC?=
 =?utf-8?B?aHhsSlRDNENDMDMrM1RFaElyUnloN3JjbU5sa0FoUTJJYzBBZDdWUUl3TGxy?=
 =?utf-8?B?L0pyRXdrYnh5dW1pYzk3OFIxK09zOFA4WmI5RDZ1dG1PYXRac1hjdDdqdG42?=
 =?utf-8?B?N3VUOXZiRFVBakhBTkJPdUJrMjcxSkI5RGNxS1dEVndnVFY2blFReVptWVZN?=
 =?utf-8?B?eHNYaW02dzBaR2cyWmpRb2VXU1NBcjlXY3V5a2R0RVNvTmt5T0ZtN3d3dW9V?=
 =?utf-8?B?ZGJ4SmR6NFIxcWova2pFUnlUZkFSLzdpRkUrS3U4ZkZ1RiswcStrRGVwQUwy?=
 =?utf-8?B?MWthN0xQT2lFeDMyV0loejlOcnNwWXJlaC9DVitzM3h3Q2dNOEpQUGRnNkM0?=
 =?utf-8?B?WVdTTjl1M0JqV0dRYzFLR3B3QWFMby8wLzBCdDhITU9xYmx3Wk9vamRZazRi?=
 =?utf-8?B?ajZGalhVQUZabVI1cFIydkNmZ0tNTnlkQldST1FUaEdjczl0aStrb0MxUjZM?=
 =?utf-8?Q?5S4hJ7qFE+w=3D?=
X-Microsoft-Antispam-Message-Info: TAPOcGzd4IuTRWQvGxy8FAkUsbQUBXoo2lceBpsEundM4PsY2FFcW/3cSSlKrs0YYvzCHQISVuW97swU5BTjFQD7hD4JQHYTZdXp5ULCshAq8iOBUHPyCsTVa/8yr6TPt+XLtUR335m2YZ2bCXab47F7ehpHME4eseRp4cHyKaYpOWLW5iTqBEorNHJpNc3q
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1454;6:ki9Uq3kEYV6UyAv4/s8zQpNW5TyuucDpPJnFsg3ykDq6Jkimy6+Ne6TNwMiBvuMAwbJOuGj81aV0cAGHoug0sh6gvnbfnSLpJsjbaHZ/IbUyqCoglOTWhdjq4kXWUpkk7lAemknAfNvHqQBPhpcTs5BgJkmrn9pltPR3XTrDBCkbTGlNK40geM8JPjpySJPthqZ4EiYvB2fJxLV5cMJsd7BslYytXmNlfJ9mP1kUBVQ811nUxtImKIxO4DJeAyHatJeJRor33qKVVEZVUKnLdj5ib4kbPguedb/DR4VHgRe2p6lwmfTc06z0iox4Gm2Hs9GpwYxCFzicbFGIndquR0BcJI0LWuODneSb/A/heJ4tIOClaUlg2qYMozOg8OWWTYauLbByOL2sit8XW3lZCOasCtgRsNHcPMBL0FM0hnZXDLIFN3R39sBzRZcgmxmJsZGeJU2OnA9JYby3uNrN4Q==;5:7Frw2M2YIcJTL6jFsNn8f4bNxyRpOclVSFPul7SHZTlaJvXneV5dgILOC7n/mVq/4nYHYq7fO+wgZXYg6oezCeu6uhQNprul5AhZMbYyfhkrWxQQl6nEvvo1eHOqTFr3Yt3GpnRE4TczQXNrw4Ym3p2hwZUf/4j62QQM2Vh0RzE=;24:r+LCM//amA6pmW1x88L+Rt4wDtAaShgsEn4gxQY8MlKaw7n/2Bruqk1FEaotxI9ygVDpb3gGL8YKQSE6iiM53ZrtfaBDB7Nn9qmeA2DnJfE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1454;7:ICW2r7Jo/9VZ13hIE5V7k2BSlMpkZhc3VIbuHpwpIflOGLAv+RmA807U48kmffiPzFKRdeK52+qwmOCPmDFVgVMvX5scoaV1OxJxZm3OcinyTzxzjRV3kBWW5YpUbLksTCXv+7spgmzKcB+yGBcqBLq1rAg4hcWww1mPX+jyeiX6VWIqflckjBoxkXeTNE2IalNFw3Y0Ss6xhW6/Fyjb/1Vtl30unXG4E1OTmiYpbGOaZDPriL3sqloTy0fjKKca;20:jwz38udbTD0rkriSwalbZjD/s4LWIPR/dVb+GpFbzJpDDThUHIanLAy0FCcpQ0IoX9RgxvxtNizCUVc3xlMWD6nVxkT397eNwzmjoNVgJxfWeE47Lg/FtkjtIpn3it3YkyLHy7jLXhfQJamv448X1LLn17eBwjoKxJ4jR84NRXcmKZAFi+am54UY12t8daweBIBfy4JAQIlXrUQVsKVg/3QS0X0Vogg6EzNrPEzQ93KMFZOESTjnCszgxgzjrp8T
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2018 21:41:24.4505 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ccbf6c0-28f0-4fb1-af68-08d5d0ad3f17
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1454
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide base enablement for using debugfs to expose internal data of an
IOMMU driver. When called, create the /sys/kernel/debug/iommu directory.

Emit a strong warning at boot time to indicate that this feature is
enabled.

This function is called from iommu_init, and creates the initial DebugFS
directory. Drivers may then call iommu_debugfs_new_driver_dir() to
instantiate a device-specific directory to expose internal data.
It will return a pointer to the new dentry structure created in
/sys/kernel/debug/iommu, or NULL in the event of a failure.

Since the IOMMU driver can not be removed from the running system, there
is no need for an "off" function.

Signed-off-by: Gary R Hook <gary.hook@amd.com>
---
 drivers/iommu/Kconfig         |   10 ++++++
 drivers/iommu/Makefile        |    1 +
 drivers/iommu/iommu-debugfs.c |   66 +++++++++++++++++++++++++++++++++++++++++
 drivers/iommu/iommu.c         |    2 +
 include/linux/iommu.h         |    7 ++++
 5 files changed, 86 insertions(+)
 create mode 100644 drivers/iommu/iommu-debugfs.c

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index c76157e57f6b..f9af25ac409f 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -60,6 +60,16 @@ config IOMMU_IO_PGTABLE_ARMV7S_SELFTEST
 
 endmenu
 
+config IOMMU_DEBUGFS
+	bool "Export IOMMU internals in DebugFS"
+	depends on DEBUG_FS
+	help
+	  Allows exposure of IOMMU device internals. This option enables
+	  the use of debugfs by IOMMU drivers as required. Devices can,
+	  at initialization time, cause the IOMMU code to create a top-level
+	  debug/iommu directory, and then populate a subdirectory with
+	  entries as required.
+
 config IOMMU_IOVA
 	tristate
 
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 1fb695854809..74cfbc392862 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -2,6 +2,7 @@
 obj-$(CONFIG_IOMMU_API) += iommu.o
 obj-$(CONFIG_IOMMU_API) += iommu-traces.o
 obj-$(CONFIG_IOMMU_API) += iommu-sysfs.o
+obj-$(CONFIG_IOMMU_DEBUGFS) += iommu-debugfs.o
 obj-$(CONFIG_IOMMU_DMA) += dma-iommu.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE) += io-pgtable.o
 obj-$(CONFIG_IOMMU_IO_PGTABLE_ARMV7S) += io-pgtable-arm-v7s.o
diff --git a/drivers/iommu/iommu-debugfs.c b/drivers/iommu/iommu-debugfs.c
new file mode 100644
index 000000000000..3b1bf88fd1b0
--- /dev/null
+++ b/drivers/iommu/iommu-debugfs.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * IOMMU debugfs core infrastructure
+ *
+ * Copyright (C) 2018 Advanced Micro Devices, Inc.
+ *
+ * Author: Gary R Hook <gary.hook@amd.com>
+ */
+
+#include <linux/pci.h>
+#include <linux/iommu.h>
+#include <linux/debugfs.h>
+
+struct dentry *iommu_debugfs_dir;
+
+/**
+ * iommu_debugfs_setup - create the top-level iommu directory in debugfs
+ *
+ * Provide base enablement for using debugfs to expose internal data of an
+ * IOMMU driver. When called, this function creates the
+ * /sys/kernel/debug/iommu directory.
+ *
+ * Emit a strong warning at boot time to indicate that this feature is
+ * enabled.
+ *
+ * This function is called from iommu_init; drivers may then call
+ * iommu_debugfs_new_driver_dir() to instantiate a vendor-specific
+ * directory to be used to expose internal data.
+ */
+void iommu_debugfs_setup(void)
+{
+	if (!iommu_debugfs_dir) {
+		iommu_debugfs_dir = debugfs_create_dir("iommu", NULL);
+		pr_warn("\n");
+		pr_warn("*************************************************************\n");
+		pr_warn("**     NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE    **\n");
+		pr_warn("**                                                         **\n");
+		pr_warn("**  IOMMU DebugFS SUPPORT HAS BEEN ENABLED IN THIS KERNEL  **\n");
+		pr_warn("**                                                         **\n");
+		pr_warn("** This means that this kernel is built to expose internal **\n");
+		pr_warn("** IOMMU data structures, which may compromise security on **\n");
+		pr_warn("** your system.                                            **\n");
+		pr_warn("**                                                         **\n");
+		pr_warn("** If you see this message and you are not debugging the   **\n");
+		pr_warn("** kernel, report this immediately to your vendor!         **\n");
+		pr_warn("**                                                         **\n");
+		pr_warn("**     NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE    **\n");
+		pr_warn("*************************************************************\n");
+	}
+}
+
+/**
+ * iommu_debugfs_new_driver_dir - create a vendor directory under debugfs/iommu
+ * @vendor: name of the vendor-specific subdirectory to create
+ *
+ * This function is called by an IOMMU driver to create the top-level debugfs
+ * directory for that driver.
+ *
+ * Return: upon success, a pointer to the dentry for the new directory.
+ *         NULL in case of failure.
+ */
+struct dentry *iommu_debugfs_new_driver_dir(const char *vendor)
+{
+	return debugfs_create_dir(vendor, iommu_debugfs_dir);
+}
+EXPORT_SYMBOL_GPL(iommu_debugfs_new_driver_dir);
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 63b37563db7e..d227b864a109 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1748,6 +1748,8 @@ static int __init iommu_init(void)
 					       NULL, kernel_kobj);
 	BUG_ON(!iommu_group_kset);
 
+	iommu_debugfs_setup();
+
 	return 0;
 }
 core_initcall(iommu_init);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 19938ee6eb31..7447b0b0579a 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -698,4 +698,11 @@ const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode)
 
 #endif /* CONFIG_IOMMU_API */
 
+#ifdef CONFIG_IOMMU_DEBUGFS
+extern	struct dentry *iommu_debugfs_dir;
+void iommu_debugfs_setup(void);
+#else
+static inline void iommu_debugfs_setup(void) {}
+#endif
+
 #endif /* __LINUX_IOMMU_H */

