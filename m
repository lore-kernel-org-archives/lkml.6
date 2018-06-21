Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9094AC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 13:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41C8920837
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 13:14:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="TXmNEK2/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41C8920837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cern.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933275AbeFUNOJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 09:14:09 -0400
Received: from mail-ve1eur01on0082.outbound.protection.outlook.com ([104.47.1.82]:43294
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932695AbeFUNOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 09:14:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector1-cern-ch;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QSlaXvpSDZrfapJV1rd7r2xhrfeE+VTyKda6v//mtUg=;
 b=TXmNEK2/m0/K3gHMFvGWcLWA1VawlSEuppLErb5PraJOouEUlbaaxNKsa+pAZcjVwTUvyk2M/8me0h2Mp8o4VPOAJQ4+LOS20x6JQt5WpR9khAoXd6JwbC92eYwy1xIaJDPknA+TGNDqZO3iUpo9TiHv/NOpfuG41tJycZ0To3c=
Received: from AM6PR06CA0032.eurprd06.prod.outlook.com (2603:10a6:20b:14::45)
 by VI1PR0602MB3376.eurprd06.prod.outlook.com (2603:10a6:803:9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.17; Thu, 21 Jun
 2018 13:14:04 +0000
Received: from AM5EUR02FT040.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e1e::206) by AM6PR06CA0032.outlook.office365.com
 (2603:10a6:20b:14::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.863.19 via Frontend
 Transport; Thu, 21 Jun 2018 13:14:04 +0000
Authentication-Results: spf=pass (sender IP is 188.184.36.50)
 smtp.mailfrom=cern.ch; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.50; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.50) by
 AM5EUR02FT040.mail.protection.outlook.com (10.152.9.8) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA_P384) id
 15.20.884.17 via Frontend Transport; Thu, 21 Jun 2018 13:14:03 +0000
Received: from cernfe05.cern.ch (188.184.36.45) by cernmxgwlb4.cern.ch
 (188.184.36.50) with Microsoft SMTP Server (TLS) id 14.3.399.0; Thu, 21 Jun
 2018 15:13:42 +0200
Received: from pcbe13614.localnet (2001:1458:202:121::100:40) by smtp.cern.ch
 (2001:1458:201:66::100:14) with Microsoft SMTP Server (TLS) id 14.3.399.0;
 Thu, 21 Jun 2018 15:13:41 +0200
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>,
        <linux-fpga@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Reply-To: <federico.vaga@cern.ch>
Subject: fpga: fpga_mgr_get() buggy ?
Date:   Thu, 21 Jun 2018 15:13:41 +0200
Message-ID: <4617134.5euanDEBgJ@pcbe13614>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [2001:1458:202:121::100:40]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.50;IPV:NLI;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(396003)(346002)(376002)(2980300002)(438002)(189003)(199004)(47776003)(230700001)(33716001)(3450700001)(46406003)(478600001)(6116002)(5660300001)(336012)(23726003)(16526019)(186003)(126002)(7636002)(7736002)(356003)(2201001)(43066004)(476003)(86362001)(106002)(74482002)(9686003)(426003)(9576002)(786003)(305945005)(106466001)(44832011)(316002)(8676002)(8936002)(33896004)(26005)(2906002)(110136005)(97756001)(50466002)(486006)(246002)(39026011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0602MB3376;H:cernmxgwlb4.cern.ch;FPR:;SPF:Pass;LANG:en;PTR:cernmx11.cern.ch;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10436b7a-4360-418d-c81b-08d5d778dc88
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(4608076)(2017052603328)(7153060)(7193020);SRVR:VI1PR0602MB3376;
X-MS-TrafficTypeDiagnostic: VI1PR0602MB3376:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0602MB3376;20:wrSpZ33tRCLs/IF1DYF4pRLi7QBACWWWYsOpR8/soH9O+DEJgrTs+e81OVbPs2mmAo/Gq0g0UnXRd/BpbMRQ22ITlTHIp6P8bv+y9wIOrzS1AZA/zRjW9vXxEAtw8/Ne1m646fZAUWU8M3I2+37ZsYGOC5szQyFNA1320X0+6dKZUAoamgtnqzc67CMC71zMR1BU17zhsm/Sb7mhXF23En/4a9k4Wg6ZrHRyp1ZlD2c/j0Mo5wiGAyWZspa4e7yfI+P7urcruASk7NDRw+pY2KK1xT0qo5ZGV/cnEr9WlCimzXBnwJnX4KRjqAtgT1R/V6aZyj76Ee3ZhMNP3KFcETpqeNtih62xEeJqEjquoEZYRUWpqHmfcY49rSF3kceRup6JjYe+o9j4Sm9BJs0bKm27Kyw2cct1EPpPpgV6/HW29gR1+I3I/XpO5V3cZ6X8Yar0faIJC13eBT0CuJug6XciBCsREbm22os/DJKxaH3wiuP2hQCalr84QkX1zOR+;4:9pVcleHGu+lFH9TDLy+ozji+DsWZIylPz7XCa4NtWUFQz3m1+ZoCr6VwYzdjmY/LfU3AswxRxTb27LMpRgl04JPLBDSYzw9SEGn04gc0chHwPuuJSpDE8GsGujmY3Em04S3T3qXuSFUfZj3z6JFlgX76YZ7RdJRQWWNsdy5lesTLnCPgr7R54rMjHjeUYpGXZYmM6GH8bTqcqNrUelLYPCRsS+nOIgpNP68LIOPL/ceeacQhBhMpr8sdmBbnBWVa7ivNFXEUAlizR3GiSoyUHA==
X-Microsoft-Antispam-PRVS: <VI1PR0602MB33760DC90594D2B0972CAA7EEF760@VI1PR0602MB3376.eurprd06.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231254)(944501410)(52105095)(93006095)(93004095)(3002001)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281529075)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:VI1PR0602MB3376;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0602MB3376;
X-Forefront-PRVS: 07106EF9B9
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0602MB3376;23:5vYq6kw3xIzbihlH77faZm8U1LXF7V/A7w8LTKa?=
 =?us-ascii?Q?1XDnhoV76Qf7LZJI7ridH8WW44Dh71bPz5pP3DEPjba93Pz6MB+Jw62s6FBe?=
 =?us-ascii?Q?NHyDgzQttp3BcjusVH41x631A7IjWcYWFhVNP3iGpvCyyYmi9zxonZyaw9OQ?=
 =?us-ascii?Q?tpgTf8BkNAxCILys+nKP4jwodvbDeTv/mDPnZiggfQwdQWraocEN3LzTEf+1?=
 =?us-ascii?Q?4zo9yYs+YyPNK6TH9Y/lBK+sQUPrYtNXwAdmdavhDzX0KUZmMwZqpKa0M4Lq?=
 =?us-ascii?Q?X2uVgqH6gI2KSTbPuCZkqikGVMG9A3xVm2NEtb9CETzWi7zMudWMpJVz/O0G?=
 =?us-ascii?Q?dB6qRktsBQkr6VIvT9bEgUWTIDFsYiM1QT0VFTQX4cSMa3A2KDVCsoHMsFz9?=
 =?us-ascii?Q?rwAaaGn7NU5CVrublAtuW3DfcDD/Y3j9X7+0QQXixfhlkCwFoPUILVrrz5SZ?=
 =?us-ascii?Q?EUqLjx7+RMV6a8PKDP4ahmv9+lLoL/AS0hFt9LLzT7kLx8jJG+k8vffD4Px0?=
 =?us-ascii?Q?IPkoWHVbyQzpbQ1JAbZHd8kbL+/4uszaeHA06S/btFACjQYwsh8acf8Rjtpf?=
 =?us-ascii?Q?2ZEtQWAMkrrd4JqxMuR64IMH//weKV+TQCnvbIiPX2gJDJtRic6vg9OH5KY5?=
 =?us-ascii?Q?0VTiQu5v3Lco9cB79PgyzAqRnM1jAgbXKbTkIZoFcipHsEx8lmHVwlPEv8jA?=
 =?us-ascii?Q?UyFxpiwxQNnhmReQ9ejrPB/01KlOgp9Tc27+viavJU6tFw6EozusUqcaAylR?=
 =?us-ascii?Q?CTuA4MfS421+aZ+BuIwj7QU6bk5lLFNJr3fxXAobR4XQ2sfXA6nwkqX8+EQe?=
 =?us-ascii?Q?9DWnRDyVpcekyMiYvvF9FSvVZugO5AKSJ2z+CDVZGqEjTapvA9CC4Bfvk62h?=
 =?us-ascii?Q?GV2gRsLQhq+YBR73Aj9YQDLBl87Q+6L5gK4aTrM95mLu4ThvfKUolml02E3K?=
 =?us-ascii?Q?6IImmBrTntrZiRSR6zcthbDzVzMlfIIrF0xkZT7Rku6GTH2zc+b0LoYJcHY2?=
 =?us-ascii?Q?SRjj9pK98OsLFKu96qUQ9gchZfYZo/BktJAwwo4bJMpS9YDQsHbhDlV+l3JX?=
 =?us-ascii?Q?OsNEPPf5JNPhYXaG/NRf48FSnz9XDBcvjtsLwq9U+AAMx8R0ltcVGYLXBFDA?=
 =?us-ascii?Q?dgy21Tzv8buo=3D?=
X-Microsoft-Antispam-Message-Info: r9fsKhbutJ0RT+ixeCsrdatMnId6Ze+/ldyoEgSYkA/zVIZvte6NdeiDmZj8VLax7KO/G/7NAcQIIro2DEzFL00XlH09PUHEkVFCt5r254E8CN1isPno8SyH7QFGoFZZ6fD8AUoLrdoqGGLC110EzYSmUKxPzhEmC8JJLjkbC2ENF5Cb3Qy3CZups9bPE51hU95d04up6EEHYduOu4oybtH/uRChZv7GnR2u8YrcE2+j9XwRISV6AkA+aN94NutluRUHbGa3u2QhY4g+WHQlQyR87BYmYGrUEzrbnvxKxSOnlOdVAPY3DbPmzErMEREBjj+i6F8/fNznuAwdXeb2YA==
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0602MB3376;6:Fn5Zcq91cHSaVRYBFXtJH4fBfh7tSe0dC/w+iIMcaFeJjL2DIYtOwjFXIO8Np+YnRZq96G4DQehdctXhGJOyP585+QAv1pW2Grz4holuuKvMcgb3Vo7s/SbT4GTSWqX2jKad9tnfdecwNb2nQ65Ja4yQpqthm2b7Vorb3tYIwJ/JPIG5T115GRCu1Htt/cB/AS0izzHu/Z8pgIMKe4gS/BEZg/hjTfaJg/W4nBvcLXx4PcrEugmP+UytylP9utGsaHmnAB8KguBAPPt/f6pP1Uc7/BLe7fJXkUX5QnwiSHX/Ufpx9hSAIdNSE2Nzj+kAq3orTwP6YR9QcQKbGuAzFKtANJPEmK+eYn0ubn/XgrPfqgOWzil3Ggpg0Awt78RRZYTgHKSjMqVmThq2v84qTErZ9/8+ZERVy3bph8KGP3AWknQW+jHQU0ikoVubJDW2FzzJ/lJDQ49LfdBNUTbEww==;5:uAnyhYlhsIy8xcWG+59OjO64abERFZAuznGlu923hcykXn9SK9MlHq1JDeqg1de7AizaXXqG34/UCoCOxUUgWIlISy73CLCKATk7DjIRKU8eKnv9QTi9xXH0+/mh0xgucBmPJGoMkz7l8KSp2R18FQt4iiuCuHHAXtL+DQEWIuU=;24:l9vyKu8tQpZFNBoGlLjYcjcpCTQCbRTUGsmgJuhTDC14VRWXU3qUzL17GiPqwxm7CxkoiZ/WuRZH8yf7IRZS7CzeULvrbdZhY75HGBGLVk8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0602MB3376;7:JO2xQPB44W9Zgo2QkfBh4BwAJG+TJfEIN1BfsdV/C+Rip0/E2yntrJmCUbnpLirIxfvCi2Qv3tTQBRUDWeiApS0dJOf+wXQCfGDg0iJgpLNxTFmXj7uK5id/Tcds/KMxP7hnAkgc+VJIACNHUhYT6GEMiHeu1IBfHbCNd9HF1jFCOs2mFMtWNlB4M2rRcEhxon0Pr+TKB42tgKGIM8rEJcWE+zuNptje881Nmx64rNG7oLTMbR8Mq6EIulb6Mvi8
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2018 13:14:03.6448
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10436b7a-4360-418d-c81b-08d5d778dc88
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.50];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0602MB3376
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I believe that this patch

fpga: manager: change api, don't use drvdata
7085e2a94f7df5f419e3cfb2fe809ce6564e9629

is incomplete and buggy.

I completely agree that drvdata should not be used by the FPGA manager 
or any other subsystem like that.

What is buggy is the function fpga_mgr_get().
That patch has been done to allow multiple FPGA manager instances to 
be linked to the same device (PCI it says). But function 
fpga_mgr_get() will return only the first found: what about the 
others?

Then, all load kernel-doc comments says:

"This code assumes the caller got the mgr pointer from 
of_fpga_mgr_get() or fpga_mgr_get()"

but that function does not allow me to get, for instance, the second 
FPGA manager on my card.

Since, thanks to this patch I'm actually the creator of the 
fpga_manager structure,  I do not need to use fpga_mgr_get() to 
retrieve that data structure.
Despite this, I believe we still need to increment the module 
reference counter (which is done by fpga_mgr_get()).

We can fix this function by just replacing the argument from 'device' 
to 'fpga_manager' (the one returned by create() ). Alternatively, we 
can add an 'owner' field in "struct fpga_manager_ops" and 'get' it 
when we use it. Or again, just an 'owner' argument in the create() 
function. I'm proposing these alternatives because I'm not sure that 
this is correct:

	if (!try_module_get(dev->parent->driver->owner))

What if the device does not have a driver? Do we consider the 
following a valid use case?


probe(struct device *dev) {
  struct device *mydev;

  mydev->parent = dev;
  device_register(mydev);
  fpga_mrg_create(mydev, ....);
}


thanks :)



