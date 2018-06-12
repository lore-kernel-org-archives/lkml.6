Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 71593C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 21:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 059CC208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 21:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0SZy4of4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 059CC208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934350AbeFLVlT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 17:41:19 -0400
Received: from mail-eopbgr710065.outbound.protection.outlook.com ([40.107.71.65]:52897
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933533AbeFLVlR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 17:41:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=415mw2N85dokXpRvQf8K4FPKuCnfSlNeKpqYhUqbJD8=;
 b=0SZy4of4PRjxSv8CEcoAklhAa/ZaQEQYWY3EK2HLce8HKVuN3T0cVZ3bbuyJo8jAn7yWmEBaiHZGK1IZ2ySt6TG75DBegtqNPcPA8XgBMxmjwGGZZAlrbnkqrfAVGRo5qaG+sltv6tjw5KrRWV6juQf3TRpbXe7jbdQ/sXFjKjE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com; 
Received: from [127.0.1.1] (165.204.78.1) by
 DM5PR12MB1452.namprd12.prod.outlook.com (2603:10b6:4:d::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.15; Tue, 12 Jun 2018 21:41:15 +0000
Subject: [PATCH v9 0/2] Base enablement of IOMMU debugfs support
From:   Gary R Hook <gary.hook@amd.com>
To:     iommu@lists.linux-foundation.org
Cc:     joro@8bytes.org, linux-kernel@vger.kernel.org
Date:   Tue, 12 Jun 2018 16:41:12 -0500
Message-ID: <152883965482.1936.13657625103232933481.stgit@taos>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SN1PR12CA0079.namprd12.prod.outlook.com
 (2603:10b6:802:21::14) To DM5PR12MB1452.namprd12.prod.outlook.com
 (2603:10b6:4:d::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f5b46fde-214e-4d31-06b6-08d5d0ad399a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(711015)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1452;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1452;3:jYYoFkepNnVFsd7jnh2PP3WdvauBoqf6HmWlNJ9VEOQGDYr6wshYrJd52YKfHx4QC/RoDvjgxaXhuS1fz3RGQAsybgtJamCuzgAt5N3vowKxZGk3U67gnPQ5GZ9eQ3PRtfCS7qWPO5lmzMFUMa+FkA8Mh6NVy1U7xzZzxlqr4SypbQkzeYn4yRefL+KZC1KxjGxHLtBCdSAfO6FLVUgTi3RN9ggTXidW4ptcwjb9Yolw9dPEva8RgQcBvspEwHO0;25:fWtSTANwjbDz3xmH0FMgQNdf9c4KHBckJzdg0qphfkVQ5CI0tjMX8RcgBSKfJaHM6p6Tb+ZD+rKGy3hV/ID7/nmfHrbr7bRbq8kX8qzfGlk7DuC7uQGso5IRVKCR/RPnNmrlOSopSNPOlxm52zCoSPcX8zfoJarOxhWIkSUKeUPbhWQLN0SvaO61kwo6EDD1X1eWN0n87hlLB0fPFxfUyfiEieo0lwjZoMDXhdHZK0wA4hwg8PDCVZMWlGTI6rFKaUZiG9WGmzpEcgNeKtped9uDpf23UVs4mX9CTQEY53ZWWoap9hqqwXSZBIV7QYZ34l9tgNaqoFAqQNSlmrq46w==;31:IdERk/tjK4kRRGSYIDXhPADLw71RVRLMQ+7gmPNuosmPSetuUfpkkJv9hfjAOQIu2SvvxcXArrgHkzsgfmxR1WSwJXfKX0P86xVrARm5r90vVdwAJOT2v5Cn8B8jZmu3KVqfHwDhdijc6mOQMgenMmAQPnykbzFLF0DOdo6w2d5qt2Fd+lNrsYISJke9iMUGxhYrw3hpIBFg0VrqGOSbNrAr3FTYiqhlFqW42QTbRbQ=
X-MS-TrafficTypeDiagnostic: DM5PR12MB1452:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1452;20:ayiBTrbsugwRHnXi88zldByevQr3CINhIPOSJquTjoxsg5mXgF6bZSGDzWjZb8gAwuDrGpH8UseW6405X1wByKV1lA/srA/rz1v9sLSaK1D3H/rY7AiH5dQGpONSzkSHswB34PymBmXdF/7IZzXcrSZ12V2X4XzRwwpjGe1uxCKkJmT2KIHqT9Yac4VVwvZo7ANdjeLILHobAFDEoUF5OAjpm++X2oIQfRkGuMPr8CEY1gh6DhscEVHAKDvbylAcEGKe6wTisK5n66zIO7Cjct9d+iEFGp8Nzbgg4i7KMnTdOptgVwXfJ1kU6yZKRNLhunpLMZCdabyswEzQSgHWJT44XuMdQEYhAAWF+eOIDeV+l6dhwPJV6OlkK9V21rG6LbJkcdIIxve5VRQTxCi0eM9dEYYc51W55OVLF/DXcpc0thX37d7kp3qWAhetdGz0CEd/VaPnrweVGlAZ49dYVwmTtPid7G2opL3pH4m8Qw8DcnRf+aBBHUPR2YBdyxsQ;4:wePJgjrb37+9ACBEToLYum8e5oOMQgH1jYtNtiaTg8iA84d87DkAYtI2pGv60xdbHWO1CopYAN1/y/ED0YaZFGtwwmCl4u9zToZnV7iz/ynB+rZIckLGxxiwcuRPfTeMhu6283q9SOLdBKAwqx1gxycEy7xZx8a760kIlmuy9e8p99X4VleTwhIjoFFIfGtlBj31ZJQCl7y8JdtANRS0mQKGCzRMKuaaR7weNM166A+dLKPsM1iMOdGSvLQu67yw1dI4LkeBhV4bWTfNMXJfVQ==
X-Microsoft-Antispam-PRVS: <DM5PR12MB14529BC0D5F979BA4F3313F6FD7F0@DM5PR12MB1452.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:DM5PR12MB1452;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1452;
X-Forefront-PRVS: 07013D7479
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(7916004)(396003)(366004)(39380400002)(39860400002)(346002)(376002)(199004)(189003)(23676004)(2906002)(486006)(58126008)(68736007)(50466002)(52116002)(2486003)(6916009)(106356001)(5660300001)(2361001)(53936002)(86362001)(956004)(2351001)(16576012)(105586002)(230700001)(72206003)(6666003)(476003)(7736002)(97736004)(26005)(77096007)(33896004)(386003)(6116002)(81166006)(81156014)(16526019)(186003)(3846002)(478600001)(8676002)(25786009)(47776003)(103116003)(305945005)(316002)(6486002)(33716001)(4326008)(66066001)(8936002)(9686003)(59450400001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1452;H:[127.0.1.1];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjEyTUIxNDUyOzIzOnkxMzRML2ZoSjRhbkdoNE5IR29MQlBWeXZa?=
 =?utf-8?B?NmQ3QnZoTUlnK1Vyd1pMb3RQT1VFZ0ZEdlNRaW5DQmJ3S1hvQ3RYNklUUGpk?=
 =?utf-8?B?OFlacFZydmpDS0NkQTJKN3A3TTI0NFlwWE5sUEYzeVlJZnVRNFhETUt5Z0c2?=
 =?utf-8?B?VXVvYkVhWWxHdmRBVStxUEdQWld4dEJibnU4RHlXd29TbWZNcS91K0xLeXBT?=
 =?utf-8?B?ZDEzZENsY0tNb3I4S2VZOHVUWWdjYlE1N0hDWEs2VXRGWktMTnllaXI0K0wv?=
 =?utf-8?B?ZTdOT2d1d0ZXZmZTQTJLS00vRXducVNjanNGcEdNQUJOTkpZeEoxY3RBU2xJ?=
 =?utf-8?B?V2NsL2NJa2V2allqZ2plVzc5ZXRQK1dIU05jcnI3Vmp3YlZ6M1lMY3QwNUtL?=
 =?utf-8?B?ZE94cHk4TUdFeWsvbWRrOEdZK1oxeTBuMkRrdFg1RWRJNysxREF3U1JYK3pK?=
 =?utf-8?B?YmlVZlNuTzR2aVlnVVVLWURSb3dLWTlWSFR3ZTg5L1QrRy9NSmVGamMzSXFy?=
 =?utf-8?B?d29JNzR1ZXZKSGpNcFVqNWQ5YW05NVRoY2JnUm0vdzQxRi83cnJqWlZYY0tw?=
 =?utf-8?B?a1UzbnVkMGg0enFFT1BVb1pzcGlCOURyWEhvT0pIWnNwSHZPT1VGeEJoQnBT?=
 =?utf-8?B?MTNYVVRWTDk3SkJpTTU4bTRVelV2T2JCVXFMbWt1MW5CclQzUkxXd0sxWGpk?=
 =?utf-8?B?dkdlWXhMVENXbWFKQzB6LzJYTGVGc0wyK2R1SldpQ05kbDJkSkY5UngyN3oz?=
 =?utf-8?B?ZWtsY01zeUkyTmpNbjJKc25MVWZ0dURoNVpMaHJYcDZBbm9VMTN0K0sxZEtK?=
 =?utf-8?B?MjE3WVlWblphSUZmY2ZJVENWeHlISHVJS3Y0ZitDbHdtSEJLdWpId09WQk1X?=
 =?utf-8?B?KzFLYmJDL2Q1Q2dqN2t4NW5sSEhFaFp6emZBN0tWVkdaamlJdTJGaXRUR2xS?=
 =?utf-8?B?WWwyU2xCNDlrNHArQlB3T2M4a09qdmt0UlBHVU9HUEtUL2JqQTA4VUh4TzJM?=
 =?utf-8?B?TGxWeVJUM0ZqSko1eFcxRnlhY05ISEdqanZIWXZ2Z01sUVJYS0d6M0t1VWNK?=
 =?utf-8?B?ajliaTZZZ0NockMvdjBVNmJJYWZIakYvYitIWnJJUnk5WjhLcUlTUEg2TWxN?=
 =?utf-8?B?ckxkS1hBNjdpVnlzR0RnK2JQOUN1VHlXR21lVWJ6SzFFbDFzcmFLL0NtSUh3?=
 =?utf-8?B?VldCYmxHU0hPd0N2WEN4N1Z5SnhWQVJ1eC8ydnQvbk1PWlBaZzQ1M2xCUzZW?=
 =?utf-8?B?cGNBYlA0VWJIaGtEOHVNTXdtS0tyK0EyODJadlJ2d1RkR3pCMmhVVWJIYjlJ?=
 =?utf-8?B?NGllbXcyQmhJVXNBenJ6VFN6emhYd1cxelJnSTFxaXNFTUFkR1hGSnh0c1Z4?=
 =?utf-8?B?dDlRZ0NSZlI5cEJzVExtaEFJaVdUTjJTS2tRK2ZNUDJza2tLSUFJZDZSR0tj?=
 =?utf-8?B?WkM4Z2lUQkFjcDkrbnFBZldsUTk3cDF4ajlxOER4ZUFrTE5paXRrcVR4ZStX?=
 =?utf-8?B?MjcwbmhodlUwTmRsSzRiTXFKb1Y1d1F2dW9uWDA4dzg4djMvandzaWp2dUZS?=
 =?utf-8?B?cWE5UWZUMXJGRWtuenZvaEZrQyt2WVQzaWtmUXF0YkVCRUlZeXlvQllnWWw5?=
 =?utf-8?B?c0tlTGJodFlyQnAraEl5NFlTUnJnNUt6Z3VRb2VkZmdwTUFIMzg3V0JQeC9M?=
 =?utf-8?B?cmplTFd0dytFQzJvZGFwNCthcUZxUndzb3pFOWt3bEwyMTZRamZxNHY3U1ph?=
 =?utf-8?B?UXFZbVBSdVBvUHlLU1cxUT09?=
X-Microsoft-Antispam-Message-Info: 6fKOVVJkY2Cv3c0nahlwRPYYFvWaGYK6o6A1N6RsRRBC531fXYfSsv4B1UTt/O4pb3NfjWzpxz+yHXeU/qGDYQfHuZC22ywb/QEshqGs6PTHjHrKYHkV7ILyr/9LXS/3Dr/Fs4Je8hgmbe9JazTbts71ho2LRirUdSjhzQyJW+nxaVNjMFAkV6hN+SrHvfS0
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1452;6:O00Mj3jkU84DOKgUljrh2jLYoq2VD+8AD9kbK/SgGZ+sGVnKjgoJ8u9LrGSXQ+gt4w4/8C2/XDW1yz5mMazgEZcBsD0qgdueIe9GsWMPnBCq1HgEulsx7nff0F0aSFM2SUgiIePaUeW0PpVY2FHuM0G6+m22OPVfLHYAmjEpvJIQdNE+wKCViJzTBC1/ieyBwelWqIxy1O+7T9tesKtTrHWbkscqulQwERR97ft68EpMJIObcwz9BdSrPgGnZkiTjlTy1KbVZiSij/IJQsACFWB/44JjbTpizcECcNo3dF7NAo+qMfaPw8aonn85MrOBHqVFRYmeW62u2yMjRcP6NhRS5KOtO9XndIE2WF+c2feD2L5UEf95tpwNn9hjRnFoikuwf7QNXh6ncOEN6eSzNXA1HSvzj3Dlt5TkrQUhbz+bmGu+xer7a/+Ok4xBnYxPamjYZqb1a2MlOjznpxBPaQ==;5:/q4vhlwI+qtFgflWncowIMRxB7RRATk28rvRqEBna4DqL7bRJx3EPMTW9iZxb4RMbHX1J1qtJsASvDOg2I/5i+w7DR2CUHh5d/VPLygVR366I4bjlQiMvnXcc80dMqpfaaDYECNaCdPi3GUhtgaMCV0vVCdaNDsYVWgVbA02ShE=;24:M8agav3SQGt+fZTFXefQSA+o5zkYswn9jfGQ3InLsfkJ5ECGCy6aGEuLQMvz7mwI/rnl3uvWbtjM+03WYlbSkbTd3rYqOjOCerlygNPBVSk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1452;7:nlaBfYuH35UptW471XR4msClPYc2VHiJqr75I1f+zz+CJJR3csZQnn/Ypzk1jEFoYcKzVvIrhGJy7URTtK3c00fcVdyI7XQxQX7tWKTNfsgooi+ATTjrqcXHSv4cuinue8n+MwKdwZBjopk8FJYiIyoCrmBYAGCM1oVwzSOWHILdp+4MZSn7aOI4qG6aGeNb9e6bnPKWIIY0OIjzCyTNfCq4R3xhXX8H0A8i8vv1pUrn7vucei2iWG1pDB/lkSX2;20:pirdA3zfI9pQLIUI9N4cLt5xDaGX0aLRcfnePGaVn10YZDOITsD9FojWv0JmQxFSg4fZiZBxf0+wBR1aKAwHku/rPYIYq6kmQmdwiVw6+rhmQ2uc1beqFsMpdQEbyh2DAMFKVdJ8EOlFg3uOk575a3u49+1gvsv6ymdKeH9V/m8KKhCKq5U0Lrh3cCBUABpVieeBSsHN9kh/deeVMBFj1RfUFNkWOrzQKsGIj8PtLYNXy2ysAO4FKrlzS61rYk0U
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2018 21:41:15.3905 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5b46fde-214e-4d31-06b6-08d5d0ad399a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1452
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches create a top-level function, called at IOMMU
initialization, to create a debugfs directory for the IOMMU.
Under this directory drivers may create and populate
vendor-specific directories for their device internals.

Patch 1: general IOMMU enablement
Patch 2: basic AMD enablement to demonstrate linkage with patch 1

Introduce a new Kconfig parameter IOMMU_DEBUGFS to globally allow/disallow debugfs code to be built.

The Makefile structure is intended to allow the use of a single switch for turning on DebugFS.

Changes since v8:
 - Change Kconfig to use both an IOMMU boolean and a vendor-specific
   boolean; ensure big warning messages
 - Make the function that creates a vendor directory more concise

Changes since v7:
 - Change the Kconfig approach to use a hidden boolean for a
   specific device
 - Change some #ifdefs to reference the new boolean

Changes since v6:
 - Rely on default Kconfig value for a bool
 - comment/doc fixes
 - use const where appropriate
 - fix inline declaration

Changes since v5:
 - Added parameters names in declarations/definitions
 - Reformatted an inline definition

Changes since v4:
 - Guard vendor-specific debugfs files in the Makefile
 - Call top-level routine from iommu_init()
 - Add function for instantiating a driver-specific directory
 - Change AMD driver code to use this new format

Changes since v3:
 - Remove superfluous calls to debugfs_initialized()
 - Emit a warning exactly one time
 - Change the Kconfig name to IOMMU_DEBUGFS
 - Change the way debugfs modules are made

Changes since v2:
 - Move a declaration to outside an ifdef
 - Remove a spurious blank line

Changes since v1:
 - Remove debug cruft
 - Remove cruft produced by design change
 - Change the lock to a mutex
 - Coding style fixes
 - Add a comment to document the framework

---

Gary R Hook (2):
      iommu - Enable debugfs exposure of IOMMU driver internals
      iommu/amd: Add basic debugfs infrastructure for AMD IOMMU


 drivers/iommu/Kconfig             |   22 ++++++++++++
 drivers/iommu/Makefile            |    2 +
 drivers/iommu/amd_iommu_debugfs.c |   33 +++++++++++++++++++
 drivers/iommu/amd_iommu_init.c    |    6 ++-
 drivers/iommu/amd_iommu_proto.h   |    6 +++
 drivers/iommu/amd_iommu_types.h   |    5 +++
 drivers/iommu/iommu-debugfs.c     |   66 +++++++++++++++++++++++++++++++++++++
 drivers/iommu/iommu.c             |    2 +
 include/linux/iommu.h             |    7 ++++
 9 files changed, 147 insertions(+), 2 deletions(-)
 create mode 100644 drivers/iommu/amd_iommu_debugfs.c
 create mode 100644 drivers/iommu/iommu-debugfs.c

--
