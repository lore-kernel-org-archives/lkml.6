Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36431C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 14:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7F97219C9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 14:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="X8nmLXfX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7F97219C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbeHHQnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 12:43:42 -0400
Received: from mail-eopbgr00067.outbound.protection.outlook.com ([40.107.0.67]:56802
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727219AbeHHQnm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 12:43:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HFj13c4hIpKAFDjKo5DW5X3FJjLKbwQDS2kabFEbGNA=;
 b=X8nmLXfXgztG48Y6u7BQHroQtp5mniRQLze8G8Ygq83R6wNlDdcuc0122x4UuyXSUtJWOzEfuXz/JyDcjSuc1b2tLP5HCiL0Iv6VAe52gzyU4liZpnMv2nVEo+BvMnc14Xb61OUlxB9GwhJbzdPSBUSKh+Qng7nMPmxn054Pzc0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=talgi@mellanox.com; 
Received: from [10.207.0.55] (193.47.165.251) by
 HE1PR05MB4651.eurprd05.prod.outlook.com (2603:10a6:7:99::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Wed, 8 Aug 2018 14:23:18 +0000
Subject: Re: [PATCH v6 8/9] net/mlx5: Do not call pcie_print_link_status()
To:     Leon Romanovsky <leon@kernel.org>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc:     linux-pci@vger.kernel.org, bhelgaas@google.com,
        jakub.kicinski@netronome.com, keith.busch@intel.com,
        alex_gagniuc@dellteam.com, austin_bolen@dell.com,
        shyam_iyer@dell.com, Ariel Elior <ariel.elior@cavium.com>,
        everest-linux-l2@cavium.com,
        "David S. Miller" <davem@davemloft.net>,
        Michael Chan <michael.chan@broadcom.com>,
        Ganesh Goudar <ganeshgr@chelsio.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Dirk van der Merwe <dirk.vandermerwe@netronome.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
        oss-drivers@netronome.com, Saeed Mahameed <saeedm@mellanox.com>
References: <CAErSpo4PK+SQLNfdkLNt9eLc7bpbxbkZCsa8T-tQpid601n0SQ@mail.gmail.com>
 <20180806232600.25694-1-mr.nuke.me@gmail.com>
 <20180806232600.25694-8-mr.nuke.me@gmail.com>
 <20180808060848.GQ13378@mtr-leonro.mtl.com>
From:   Tal Gilboa <talgi@mellanox.com>
Message-ID: <05056a70-ee78-ea3c-0b9b-6d64a8663b11@mellanox.com>
Date:   Wed, 8 Aug 2018 17:23:12 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180808060848.GQ13378@mtr-leonro.mtl.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [193.47.165.251]
X-ClientProxiedBy: VI1PR03CA0073.eurprd03.prod.outlook.com
 (2603:10a6:803:50::44) To HE1PR05MB4651.eurprd05.prod.outlook.com
 (2603:10a6:7:99::24)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6bcf6924-db01-487a-7dfb-08d5fd3a8143
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:HE1PR05MB4651;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB4651;3:79oBaTGK2cPt0ckHqB3pIxJVZ2owIv4i2Yx9vpUMjhULSRbZqb13y34ZzKAI+j/8nXAm/R7FHzXcu9t0P7jlKzR1/O/3dlroM1cMw/I6NZMO129HiVHOHmDUxPZ4JvTKTGrWWW1aD45C8HIsDU9NQJe8sfLA2Mlm7FgqCSHoqkv0fdscwqie7Pv0sdkEmV+Yz6qgF0gprlg19T9vGMMOrHcQ85wxYKEGLXJz/wAzwB9ShVYMXhTkD0qUfE4p+O1H;25:1kXsIfXjNMrA+LOekTrNU02+UT+p3NEhEq4LORMK6Xm9JOfHMTvi7F/Ogs4UNzaXkxBO6LphI+zwn+aeH0NX2ewRiReokthy3wrsf9NVGQFdXk+RWzv24Jx7F+FlPD7ZUsZXonVlMD5AdUvip8jfemvVQJclwbpPXnDvc81BJQtBVGCaveYhZyq8V2aVhtGVAv7+bdVzXulde4pT92T7gtfjEx/W7n18aHJ6ptNLSaGS0zVMtrySlwA2fHDgKVqavGfadTZEgLQ2VJHFnUSAOxfVNlwwn6wjxlv7FHpua3Dm+hoF/SFaeSsECfb5RKa4I6Nw8j7e1dN3BVGrZds7Nw==;31:r79toP/Y8Bbznv8uxEHrnhGWccFv8KeCj9uag7HhQNaUU6G3UceLXbunbfCxHftkVn7gm2Y9lCKj9Q5wW/XIsa1E6bziJAXwwevdsWYcsH8UTuTJrDOQMgrkE3VzBO2uGMGaBYQk8B4yBk9jl7oY7LrtRNZS0ortFq2s/MwyO+amxYNXpfuV/uPcqBANvHA0NxsH6nad1ai7/5L3+u0QflHUSFE41rEvZVLnGkopjEE=
X-MS-TrafficTypeDiagnostic: HE1PR05MB4651:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB4651;20:UulakOpHS0xK651dk2VJ0XHN1BHbZ3+IsLOG62UnA1pqy9XcofyRUfLoAUpGEGyk6bbCj12os5maxIT5RPZmfUUx0JVbneeMAB4d8EOyc3FBYHEMPYgLPlspPRvuPnlrDzQjcSCyKI3Sa8Ip8LRIzq1sUI7nyHaqWi2JWe5QjriH+o5EoX3WE8OmdeElgEZnMPAZJeiAidOv0bHSP56mTUn9Ix+7bwXf5LIaqts7aviy+bVQtCFRpN1Ht68F/w1SJnJugJmMP1UWYz3nW/aHsVHVtmx0RNoWCdmkQZgR6/U8S3Td8cjeRKzRMlSFSumxEbCagk7+wkoZVVmKaWOn++f/t6A/+ROiGdmbjWplB/0v0K1hl/uMJo+jgdG3Y+5ZMDdJG8orNbGLw1MOjZQSaH3fu86S01WeAuA+Hr7WGEZqtCvlDZ2QIMiscmw3fscexikDJwpIQCfOxtDICrVO36E3NnophbMmweK9gmq2bNi1mRcWg7d+GBP7olUG4SHx;4:FiBmMEol9aPrq3YZyc/lRh4TvOY/TM34CORMaAzGuIRHrrg18BrOrxnYGbKPXx/TjCFllg9SbEeTHGQfyff1TrIww/6aY9ouYB1lZulB4qrFoALWp+tFJzNvSzsmPZQvNn4SGW1hh9MGlP4cVV82ZXDilbnMo5E9HlsHkd/hxNaIxaXaOwfbsUmzAFAUsNoWQtBJ8/44JVRpR7d/GHdkIaAL1wEottNukwY/DJ3XQDUNM/RS3Sv6qzsZtHID5Jp/AZZmGySn1jn0OiC/vkZye786diFlLPvkbBT7iHvkWKoc2mJwu3EYcsYqMjqAAiLB
X-Microsoft-Antispam-PRVS: <HE1PR05MB46513FCF0F4BACE53E427F90D2260@HE1PR05MB4651.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:HE1PR05MB4651;BCL:0;PCL:0;RULEID:;SRVR:HE1PR05MB4651;
X-Forefront-PRVS: 07584EDBCD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(396003)(366004)(346002)(376002)(136003)(189003)(199004)(5660300001)(65826007)(31696002)(76176011)(31686004)(6486002)(230700001)(8676002)(53546011)(93886005)(7416002)(478600001)(105586002)(64126003)(23746002)(68736007)(81156014)(6666003)(106356001)(14444005)(386003)(36756003)(81166006)(86362001)(50466002)(2906002)(52116002)(97736004)(2616005)(47776003)(53936002)(58126008)(66066001)(305945005)(54906003)(316002)(16576012)(65956001)(107886003)(65806001)(486006)(16526019)(4326008)(39060400002)(446003)(77096007)(67846002)(956004)(26005)(11346002)(7736002)(110136005)(8936002)(229853002)(3846002)(6116002)(476003)(6246003)(25786009)(3260700006);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR05MB4651;H:[10.207.0.55];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;HE1PR05MB4651;23:xpyNIiIgDc33GYDvuFkMKADjgn8RVN37Rt7w4?=
 =?Windows-1252?Q?EG5E0zzt6Rkf3OUuF0YPC1ahxqj0Xi+Mv7eknFAEb4W8suae/NpV51r+?=
 =?Windows-1252?Q?zOPlSIusUu4ABJq/1gZEtx9wVFNHaA2yhxl7tCF5fXkd8a5IxvBF/qUX?=
 =?Windows-1252?Q?Z26+VFBAFJoOEwzAs/t1oJ0N4V8wGJRHnuNQfX35seW+Pqy+uZR+H1OO?=
 =?Windows-1252?Q?kxNCc3Im2FmWClmRIfBINVsh7BdnLs8YwJd5CV1tVoFnS1ELo94hZQjm?=
 =?Windows-1252?Q?GEmAYyk9ydE2Tl9YJoHuAQHqwMrLoa8iy9ZUEf6d7tp95gd53YqDzOfD?=
 =?Windows-1252?Q?uKZ5eOhovTI6qRIDF/0MUsDBEXRFau8dfXI93SwCPUWHQpRzEzJqBKbv?=
 =?Windows-1252?Q?Jweg2Jsh76dzhWwJJcSeNwRkUQNuDUzL39BzcuNNjBvqaGjsuxA2s+k7?=
 =?Windows-1252?Q?7EWb9IXDdkcW6ckcXQGOPu4wdXWCFVTFjUgR/twVUTrSVBQJcOxP4IyJ?=
 =?Windows-1252?Q?88aXt3Jvo3Wysv3sCLgD4+zdYWe8Qh+n5QKI+3O2Z0wu1xvIcxiANp4w?=
 =?Windows-1252?Q?2XRoPcAfxvLdfQYxzCmUdJmvnI1FJAOTYReGqrcdDqpx1KPmbhxKJY33?=
 =?Windows-1252?Q?aOgjS7qLd9pfpafeUMNVuBFVQeVWcWBv+tm/AsnGbAXbZAWJao9tq67t?=
 =?Windows-1252?Q?+qYIwRw5nppFdbgrcR0NlYNugLbw/GUiWDIpyjp9pMcW8FU5+TS2mLLa?=
 =?Windows-1252?Q?sbBDVUxcKaK8o3cabe65+rkx0h6Pa6gdSPDl1n2TMJ7umiYwxfuoPEe0?=
 =?Windows-1252?Q?ysuhNPqeA5ZzCMJD1nxxhagja6g9hl7uc1sQdgYXOXI7FmSx7Bd8RSub?=
 =?Windows-1252?Q?EP/Tzaj8UExzetTSp/xGcWw964Ud3ki52wyG6BaH788a1qzlu90dOaUA?=
 =?Windows-1252?Q?Zzxypt9YK2yjYZVdcWmf6u6wS/YyD9mXkleyM7o27kwhYQyl7MarJXgl?=
 =?Windows-1252?Q?QNmfxyn9J2abnJmAqdfSnMX2IAKRIdaum+dA9aQfslvxdkRH0kzvZwjS?=
 =?Windows-1252?Q?WFvyQy95L0Z90SLlLr4JX3SZ/vP8/48RxUC0vxkFJJS4S/ErKkfKNJZ9?=
 =?Windows-1252?Q?SWj/8fNiFKBnnynDpExXYKJK5loLmt6I4R9rIJpRY5dn6ZXsjqlj5NG9?=
 =?Windows-1252?Q?n1wLJ5V5cx+yL29wEng6kYsX/rhgyD643bar93eFaajw5gxCNjE1EquX?=
 =?Windows-1252?Q?+fCZ9v3fjOl0ekpi+7Q66gBPmxwOdBnjWKExeFIjg3zQV0aDMIcLg2hR?=
 =?Windows-1252?Q?dhLgPDp1oggtxOyNrERDYZ2ER1PTSO/d0UElJNudgzPVv5/lloZoa7ML?=
 =?Windows-1252?Q?Rimsddpfnt5IS+LE6pWJ9b07NM2XWKFpu80NOzWPrMYSa0/6/CrgyL8Q?=
 =?Windows-1252?Q?OMVcaUY1Wh1FTQig5tSBJ+NWLMTbXHEzFOm4cGMxNIIijtPYoltcnfpH?=
 =?Windows-1252?Q?C9uggXDcwTJcEjdJbqiIrmIQw0cvGKYcwJi1vDCwYvDiRM+p/ThdgfDY?=
 =?Windows-1252?Q?WP1ll7sjL0yiZNrqR3MmRVtbXkU21U30vk3s4waSgu8C4jAO1Symzcdo?=
 =?Windows-1252?Q?Y4jUZOZcYAMXARerbk/71LcL0XmebdfH4SEjBMu5PFh?=
X-Microsoft-Antispam-Message-Info: JsgXrjb+6/gIlnH7WbWPgJqwresyeF1Gvy6vMYi5XBfebYjV2T2yTVJpTSAe+JVatp8FOd6DsY1eSJfkGgipwLl4d+deNVcXaRE8owV74wH20zxKyGYE7cWc5uigRXq92b4q3gqtlEPsmgh8bc64ab37p2A4sINgDl3dEpEnAFPC/5ne/ZqEfE3LEbNF5S/frki1RFoM13oyPaAEvPjfXvtp32k0z1J5BIXKag0crGYpNds6lZ9V4eDkU3qb7i9VRKl+G3pYs/0lFb82RqN+R9KKKN2ezMot6/j9EUlqaZr5L33S5UkagKZHo6IDAcBugsQScoN4+guf94YUI5pkpLfzdmohRPENlUg4aOZsGQM=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB4651;6:E56FTSNj0rPWN2G9YOjHHSO1m/NyczxXsMfBvSwF6g0k7fYtiOT9al/KdhaPpJ3/HvoBS7R8l7szJoTV78jjht4Ejp+8O6bkVw0B3QBHvuDlFqfHU+nQ7KOHne4ASey84hmHPl6TOWWovaI6m9EwFwtHXpiLwkTQfYozBfIhjRKHylzacqoyqG6MZ6n/zzJ8n2UDI0O+TTy2QWIZmptIKIfCU/r650zFd0loECBH4y0jZehCHGr8L+d4Z7RJeJeisOXUTGz546bT1QB1V1yGB5OR86gDPPa6vQFtEX8SDH2pRr0xyRRMS4hoxtpJyigkEo+OWkju6xG4E2cAUrRcVrx5GCUqweSyB5HodavGRQvSbC1jjpQSmt5nclV2N2zkCBxm3GyVTH8wR/Wl+YFIV5THfRA2pulhjrmb8euaiExul01iSVQfu0zPeeBHSWndc+Dbzm2gIUcHZKYYlzluTg==;5:slquWIIjYwGefpTGJ9OokTl94HBY+mZwX8Pv9PLsv5bsKIpzDJQeYlIayxrJVVN5VANoUndkW2t+4EYQ7AKPUR2rfpKGtjsJM54mzNbbcQbLeLFsI5xdI9TiwDlr9L8ftmR4xD97rXoPZRoEJaTA26bFv1I0B+kneCIK5oDsAGc=;7:5shklfpIRwKugAZFAv+QKCFEYjg065H+OmFeQ+ghhRy7ue9lo1JZKtQBlPhsq5K2/bfZkp5Ql2CfvbuclPWxSWEALuC1SWy4fAOW06VJHqqdZUFjS3WjFYh2KyIl5JKcaNE+zOXlSq5WNKOPTXIRCtt3dHmUExmi1Wnrj6d11AXhvVwdqlQEpGj8DFcjW9cSLgtWH89tsTNmEWagIrjdfRG6BBNggS8sYFjdEK3bJccNT+HxPQ/Zz6kd8bkdYNVk
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2018 14:23:18.0879
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bcf6924-db01-487a-7dfb-08d5fd3a8143
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR05MB4651
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/2018 9:08 AM, Leon Romanovsky wrote:
> On Mon, Aug 06, 2018 at 06:25:42PM -0500, Alexandru Gagniuc wrote:
>> This is now done by the PCI core to warn of sub-optimal bandwidth.
>>
>> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
>> ---
>>   drivers/net/ethernet/mellanox/mlx5/core/main.c | 4 ----
>>   1 file changed, 4 deletions(-)
>>
> 
> Thanks,
> Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
> 

Alex,
I loaded mlx5 driver with and without these series. The report in dmesg 
is now missing. From what I understood, the status should be reported at 
least once, even if everything is in order. We need this functionality 
to stay.

net-next (dmesg output for 07:00.0):
[270498.625351] mlx5_core 0000:07:00.0: firmware version: 14.22.4020
[270498.632130] mlx5_core 0000:07:00.0: 63.008 Gb/s available PCIe 
bandwidth (8 GT/s x8 link)
[270499.169533] (0000:07:00.0): E-Switch: Total vports 9, per vport: max 
uc(1024) max mc(16384)
[270499.182358] mlx5_core 0000:07:00.0: Port module event: module 0, 
Cable plugged

net-next + patches (dmesg output for 07:00.0):
[  331.608472] mlx5_core 0000:07:00.0: firmware version: 14.22.4020
[  332.564938] (0000:07:00.0): E-Switch: Total vports 9, per vport: max 
uc(1024) max mc(16384)
[  332.616271] mlx5_core 0000:07:00.0: Port module event: module 0, 
Cable plugged


