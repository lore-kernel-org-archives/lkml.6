Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51603C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 11:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 026C020685
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 11:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="iHZfKczz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 026C020685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732669AbeKMVSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 16:18:53 -0500
Received: from mail-eopbgr690061.outbound.protection.outlook.com ([40.107.69.61]:43008
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732037AbeKMVSx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 16:18:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bsnzmQDXyN/4c7BTYKQILUItukZ4YD+rLw6bfIVdzM8=;
 b=iHZfKczzF5B2yEs6/OQ8mOL80Rh9wzNHXFdxb/U8wfompErZEHyohwFzPhzp6XDiro+9LkoIjM1RX7FAAcws03bhXhpalGHIcqV4rFZkptp9NUElRyY5tvf7COAQ0uTt8IGCA/xq3Dfvqm8a6QEFw3dsnI+aVE5vwV/W9BjI8IY=
Received: from BYAPR03CA0018.namprd03.prod.outlook.com (2603:10b6:a02:a8::31)
 by SN2PR03MB2271.namprd03.prod.outlook.com (2603:10b6:804:d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1294.21; Tue, 13 Nov
 2018 11:21:10 +0000
Received: from BN1BFFO11FD014.protection.gbl (2a01:111:f400:7c10::1:157) by
 BYAPR03CA0018.outlook.office365.com (2603:10b6:a02:a8::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1339.20 via Frontend Transport; Tue, 13 Nov 2018 11:21:10 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BN1BFFO11FD014.mail.protection.outlook.com (10.58.144.77) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1339.12
 via Frontend Transport; Tue, 13 Nov 2018 11:21:10 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id wADBL9Xc025604
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 13 Nov 2018 03:21:09 -0800
Received: from linux.ad.analog.com (10.50.1.118) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.301.0; Tue, 13 Nov 2018
 06:21:09 -0500
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>
CC:     <mark.rutland@arm.com>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <Michael.Hennerich@analog.com>,
        <gregkh@linuxfoundation.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stefan.popa@analog.com>
Subject: [PATCH v5 2/4] dt-bindings: iio: adc: Add common ADCs properties to a separate file
Date:   Tue, 13 Nov 2018 13:21:01 +0200
Message-ID: <1542108061-3471-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(979002)(39860400002)(396003)(376002)(346002)(136003)(2980300002)(438002)(199004)(189003)(48376002)(50226002)(305945005)(6666004)(356004)(7636002)(4326008)(486006)(54906003)(47776003)(246002)(50466002)(36756003)(44832011)(8936002)(476003)(126002)(107886003)(7416002)(106002)(2616005)(426003)(106466001)(26005)(5660300001)(110136005)(2906002)(316002)(51416003)(77096007)(7696005)(72206003)(336012)(508600001)(16586007)(186003)(8676002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN2PR03MB2271;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11FD014;1:Tti4sf3T228GO/IqU6arbLvkBR1bcv1W8Tqas+0xFeK3sZbJIQMBOEKSyPkGgmNEBlIesmaJzj7RnbuHRdTtdiZjTs8UDUmNSMHxGHz6XghAmh4ZdmeBL3hC+H5d0xGJ
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6e46409-b396-4c52-4718-08d6495a1d03
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390060)(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:SN2PR03MB2271;
X-Microsoft-Exchange-Diagnostics: 1;SN2PR03MB2271;3:OogWH3Ni/O5cgQo3+V/qEc/ggtIBaI45P4mEtO1ANNrzbkDJnEaNszPnI8bNEXVYbEvssowQ+ZgsMBHbv5W87ZpfQbnL2fJvtbIVhC6GgdLvFA0z2fcTcIPQMDm5OZt4sUS3BqHk9D8FdKw17f38fDah+jXhowF0vA6nyc5Ftj4UejEIPEnOoF6FTEvUyHTvH7/zAs8vhSCQa/XgZM370Oo8J9ibUnAxayUtBOBo41v71+0HOjVuXo4O2BQMQg4ZjFyPPu2IWk6yb+6L8Hur+DsQnmFymzBp70lnMZGsuLka8zhEkLSiDrfuP7FhGH7yjqIjHA43ii1BYeTcXfcOsmNDDjSK5f9aSSA9lAHcZfA=;25:eCfL6R5RvYjDPEPt6LVBLZpnIl7kJ4yY/MYnaqPfoOC79GtG97THvpRs+d9rse7UE/AGEIacCjM3RdgrODK10816ncLSf1oO5xYXW2Tph3qjAq+XhzEG5u1y6fvHo0+BW0JxREsNV81Cd8w3NezcuJsG1IB7iGYF5Zb0JJgl5XFDgZSNf4avqLPoVZJiGsXkub7+DrIaRMHSWVIxrMnKqmOGVdiUMpforIuhi3ATGC1EWn8URMNvabMJs/s1cao2nTroduKHF3RWIafM+cduruWsvfIPC1xciaSZmeO1Cg8Ur071C3fPbmbtugPPMgy/h061frZ+0Twlcfg2qu5WFA==
X-MS-TrafficTypeDiagnostic: SN2PR03MB2271:
X-Microsoft-Exchange-Diagnostics: 1;SN2PR03MB2271;31:wsnMjGkx8TaZoo9soEcNAkx8ylvp3ageMfbT2VQ8PRziSpNMxcdgPnUJBmTdRAtwtMDq2d3ilwCxngMDaM9gUiAbvzDz1ptDNeIzbzHy5EXvBh8xvkUHf2VEWrD3bb0byVuMenf7BL6umK91rc8afSSYwLEP0hsS51cpPVB+2ZLaPhtQs85cpuXab7ubuzfAeFOJnTrDboFLqE+9hABw81runfUMo4AUPoiKT62/row=;20:NMWvc2aPaSR0qQ4x/BFI9YDYC/jn5dsCA6wSdNGQjjLQV/nXftfzG3B+l2M2S1ya1eXaiKKhq6bePUTW8MfwZqBC15o2SxTpnewFWU2iT+Hm3Qo7vyPwfRylrq0RrhccdKGqdALHRSf1vZpNo5pniwgGZL+2C6evx80tRtxqb7fRLgXWz089L6r5dsrkK1yuopZa+aSuYsc/RaU8oHr1xE6kqJgph/W1kw9qs86r3UcD9EdhqEp8hVEhLFk7KXxjGp46EIPmi9M9yik+6en68iWQevw5Rq2AGZFxEkZtNv2ty4EYRNeChteMq1+xpypydx1SmToRbD0le1iF4HKWdfoL4rC9lkua7RA0OYDl8LyNWq5KAavaewPaZKv/WUUeZ2HxFJZcGOacaimayNuQzkjnEUQpvIC/jxHiMp3tTk/HGSxhINib06HHEZ9meQC7Br5SC8FAfxvNRuNMSzFF4FG7HJqlN+4BKl3fz7B6zd8+MhHHhVlUss/P99hCcjRz
X-Microsoft-Antispam-PRVS: <SN2PR03MB2271358CEB9B7E6467BCCE889DC20@SN2PR03MB2271.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(232431446821674);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(10201501046)(3002001)(3231382)(944501410)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:SN2PR03MB2271;BCL:0;PCL:0;RULEID:;SRVR:SN2PR03MB2271;
X-Microsoft-Exchange-Diagnostics: 1;SN2PR03MB2271;4:RcNbZUqAeJOa2um2brOBevklSifeRDdmw8+9FbUbUoFeTiPOSyOLPVYEVyM2PvP1QTGr2mTt//NV7vvdVwDJo2B7ANOZJxpAQTvAHUqnbiPdP2nmg71uw8uBaK4+SuxcjMV7gsBfh8AMfecOZsaR4hltPMRcO6LVHV/8tz4FYPQBwbGJmwA5ruGORcEx6Sp9pIwPOtdJyoOeuTvZdMDBWyY01VJqc0f7VkebzQgci+b1qH9/paK4R2z0XJYRADe7c3YdIkfJ3S0oZ/8m7xZtVSjAUZP9JDcZho+Y9kJGmM/peyrSqiYlBvdIuP0xJl7B
X-Forefront-PRVS: 085551F5A8
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN2PR03MB2271;23:b9WMpPFPg/5laqMfwb1fsnmTo+PH55oecMVjporFo?=
 =?us-ascii?Q?aZLPBe+Nygvw0U/v9P55Tp8oUUCH/wpTYf7g4X6esAoHsGN4LDauRwLVUH1x?=
 =?us-ascii?Q?W0UD8eK+DSv53FS6TtovjJ0rLqgRMhh9CcmPN5wLNQy0OZCRfG4dt/AfdnhW?=
 =?us-ascii?Q?n3oI4rQ5iR5vrcMgSp6FZnnZWrc+BA5ocnvbE93+C/oskVnDUZWMox+PYUfY?=
 =?us-ascii?Q?+Ak9002KLeu47WGqULLndl96CpLwfUGEWITp5Bdu2WTxrWJ5QbUl0atmRIAY?=
 =?us-ascii?Q?ERxfINDUzu46091TEJ75svrTcIhkatzWfQc1Uk0sRslPeEJHbQ2H8nGu+WQQ?=
 =?us-ascii?Q?BokrOP6C1EVjqZq+DYDBGHL9iWyDdlkhHzfDNklYSSjGuUYfifvqT83yuP03?=
 =?us-ascii?Q?0/RmgEe+3SUO6SG/n1j1SHjY23cBsSdEVD9xrPuEli+H4cNR974iriJsvN+P?=
 =?us-ascii?Q?KHApQw5UNlwI+NJqlHzj43fLTFwVX5O4yLaKCkd6dyeVI+oOfxa+d4MqsiT2?=
 =?us-ascii?Q?PZzc3Ia92zUEZ01oVKiiGIpqlizdYRIugUgSuntFQVk0LufVavwbSt1W59d4?=
 =?us-ascii?Q?PyfM583fCS4zPnjPl7cLM6+CHl28EcHR5bG8yeKh78/XAzvrpCbjaHHgTeyu?=
 =?us-ascii?Q?3tG0cO5gyUNhsQrja1rYONRKsP/vkAE92n7/+5mHbxjVLb+etDtcWqn9ABlC?=
 =?us-ascii?Q?MCaz1rwdfNBsVmSWhYT3c1SqUeQ98UkfElRi/3M5KEwPTpm/FzxDoAc1gPh3?=
 =?us-ascii?Q?lXV52FPOajMc9yLqwDrCMhlHhXfMsuFKLszxKEwjwbuiToP53eoFuaoiYVzU?=
 =?us-ascii?Q?+WXBAkwWkWrwnMFAK4PIZ90K7Jh3YPNEqstLorGqZnFknHpOoR5efM0nljsg?=
 =?us-ascii?Q?/end2GL9N03XjEhFsA8Om/jmlXCgcHygokSe7LN/bE/WnXM/AmdMwEDv3PtE?=
 =?us-ascii?Q?iH1BupfAHck/0UBO+DXfsqBhRr/76jRn8UEe+PUm1ITjYlRXHibfGe8R0fjr?=
 =?us-ascii?Q?NXSXlYGE/MEKsju4JHePj3K5J1pEMA5TjDunb5QXJswgL6GngVGeeLIZTofO?=
 =?us-ascii?Q?HY7psx5f0zDNY8gvyxZctSjIaF9X8fGtse+4H/yxwxbgsGoZf6GeCcXlarqE?=
 =?us-ascii?Q?jHAfaNQ8Lw=3D?=
X-Microsoft-Antispam-Message-Info: CARTwJ184JoGr2SiAbAQ5YplNsfDV0G9hpEvu4sv7dxohHKdJ6mUHu2XKkRIfqQ+Bp5/HZzlA+7iYKtTlaOEyjIkY85bz7b4XA2NyuQfuiCaak+/eIHUiGKxUiGAZEUzYI89DVCxROA3RWSAZIOvk25SQAP9ViSBhGAEsOCpEy47ERrPw/hHU2EwzCiJCQYBBTU8rviAnuwHWohobvG1wdoRP5fAvo/WI5t7mGPXaQayXj7Ue9ypZUQ51EZ7+C1zfpcX5mihLRfgdlAAEiYZiPqEz5lYxFkwwAkl964U34C15NO+XGHrSEl7WuV99FnQtV7Jif84aljb8WNGRq5fPu1q1msIG1RTlF/Xtluf9sE=
X-Microsoft-Exchange-Diagnostics: 1;SN2PR03MB2271;6:SWzq7qZqOFzSUapnX+yWPVGEpd26aTSdWlvtPINe7XougQD8mXHhhp6Ib9y428Ood9xkBSpUE79GK3s7qUv2xKDYGqArJIsTxRAU7NtSxGIjrO6N4IWv+sOdzKOOn/cy19Ub9c7J5VeEbIzPeGatBCTo/MF/ulu+ZkDGEGXYnXP3jwPIV9fia+JG+nl24TaB9ZLm6XUJLapylDXlszLiR9Ni05felj2v27l/xxCofsnRYVHEyzdd1SvupmK4DGtp1azMJWsNUSOD9ds9Zv6KvFhEKdykuFCjx2fNkYCJAy1ZVyLi++BxJxROcYOcHT3I8aKXJpo4uo0d1lUDRCtFwK3QKi6iaAy87PVKiIymr4AWrmAweksRzlALTgkZNsgSPFWRZ65++OfHMxWpgb4LFOzqghgrwctTO5nJy0OHav3DeeZXV0gX81zKfHlQ09t7X8mIST+m0lot/SOEn+4r2A==;5:xr8hRG//rm3O/CeITuS4GwrRfcevnmQ6W47Z6+GhKfvGjWs6QizdH7kZzjfVez/OuspEvmEvV04mFi6hd/UeOUaNwt0Rx2FImD7uOlmYIIvnVQGJnEVI5/e1YjQlC9s19mIQ0UzY8fsz4mCd+ct4K4PTltam8R1SpELwuONBQ44=;7:qSrts7MXaowwx1BrMRmROMEBb8/VhEfZjf2Z2DkdIg7GmU9wO4PWNmGMEJZ5HflJWiZEQtC2f2g7wyKV4PlFKgOX/Gmrej9i8gugxhwXExDIpC4fDl07p82/0jSZEoG3Dwj4aKviyTS5IX0S3slyHQ==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2018 11:21:10.0735
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6e46409-b396-4c52-4718-08d6495a1d03
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR03MB2271
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are several ADC drivers that depend on the same device tree
bindings. Rather than continue to duplicate the properties, this patch
adds a common adc binding document that can be referenced. For beginning,
only two properties are documented.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
Changes in v2, v3:
	- N/A.
Changes in v4:
	- Added this commit.
Changes in v5:
	- Nothing changed.

 Documentation/devicetree/bindings/iio/adc/adc.txt | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adc.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/adc.txt b/Documentation/devicetree/bindings/iio/adc/adc.txt
new file mode 100644
index 0000000..5bbaa33
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adc.txt
@@ -0,0 +1,23 @@
+Common ADCs properties
+
+Optional properties for child nodes:
+- bipolar : Boolean, if set the channel is used in bipolar mode.
+- diff-channels : Differential channels muxed for this ADC. The first value
+		specifies the positive input pin, the second value the negative
+		input pin.
+
+Example:
+	adc@0 {
+		compatible = "some,adc";
+		...
+		channel@0 {
+			bipolar;
+			diff-channels = <0 1>;
+			...
+		};
+
+		channel@1 {
+			diff-channels = <2 3>;
+			...
+		};
+	};
-- 
2.7.4

