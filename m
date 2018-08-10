Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35274C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 15:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1EBA22408
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 15:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="JYJHGsGk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1EBA22408
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbeHJSPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 14:15:35 -0400
Received: from mail-bl2nam02on0081.outbound.protection.outlook.com ([104.47.38.81]:48192
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727422AbeHJSPe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 14:15:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X4JzRgS6Do/LAuM/TyGaO4Mk1zC13x8arDhESBMQAKU=;
 b=JYJHGsGkpNuqzIUD84IXIkTgSLOnGlMdjnhD8mCWT2OI5oATP45uIijd76ufXKhEZuqgIsX6vop7fLB3b24g5LNE2hUv96NZ3mbg1edlWGOk05RUt9qq/s8fE5nQZ5poubzrk56/cxlzEhBdwQD6y/z0RIBrKY7sC9fBfAZNFEE=
Received: from DM6PR02CA0032.namprd02.prod.outlook.com (2603:10b6:5:1c::45) by
 DM6PR02MB4460.namprd02.prod.outlook.com (2603:10b6:5:29::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.19; Fri, 10 Aug 2018 15:45:08 +0000
Received: from SN1NAM02FT051.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::201) by DM6PR02CA0032.outlook.office365.com
 (2603:10b6:5:1c::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1038.21 via Frontend
 Transport; Fri, 10 Aug 2018 15:45:08 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT051.mail.protection.outlook.com (10.152.73.103) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1038.3
 via Frontend Transport; Fri, 10 Aug 2018 15:45:06 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:45990 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1fo9b7-0000H9-UJ; Fri, 10 Aug 2018 08:45:05 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1fo9b2-0006lu-RD; Fri, 10 Aug 2018 08:45:00 -0700
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w7AFivLB007795;
        Fri, 10 Aug 2018 08:44:58 -0700
Received: from [172.23.37.224] (helo=xhdbharatku40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1fo9az-0006kA-9h; Fri, 10 Aug 2018 08:44:57 -0700
From:   Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <bhelgaas@google.com>, <rgummal@xilinx.com>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH 1/4] PCI: Add setup_platform_service_irq hook to struct pci_host_bridge
Date:   Fri, 10 Aug 2018 21:09:37 +0530
Message-ID: <1533915580-31805-2-git-send-email-bharat.kumar.gogada@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533915580-31805-1-git-send-email-bharat.kumar.gogada@xilinx.com>
References: <1533915580-31805-1-git-send-email-bharat.kumar.gogada@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(346002)(376002)(39860400002)(2980300002)(438002)(199004)(189003)(51416003)(47776003)(76176011)(50226002)(107886003)(4326008)(356003)(2906002)(36386004)(48376002)(7696005)(50466002)(6666003)(305945005)(36756003)(8936002)(9786002)(106466001)(106002)(446003)(16586007)(126002)(110136005)(63266004)(8676002)(478600001)(316002)(11346002)(2616005)(186003)(81156014)(81166006)(426003)(5660300001)(336012)(54906003)(26005)(486006)(77096007)(476003)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4460;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT051;1:HZ+AHAN06TLtb1MMFhkn/PRkuvyRTadtsns7aYW2CSeHqnehOfXJ5wTjdzqU0EgH4qWu0HqQ/exuieoR4t+inPLZFavaApNJJpv1wTMRjlfp6DqOPtpBC9nddy/tUKDg
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6ffd4fb-6bfd-4a53-d801-08d5fed83fcf
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:DM6PR02MB4460;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4460;3:YnmZsfQ1fERanQUxrF/b7hkomKBsmOERzBAobYPsoLKU2d8vCgWZEuGPt5uHKIXsEG/3hU+mXC1+blIGhDpoD3TYMKEuvX28wJbPYmXOK9C5+w31R8csscao00cnFDRwrSLx7kos/3rItyjmeJWkuV+PkrJlabgeZtp4E1dy+QWQaqyRKbwVOvMfaZDBgds56RitntrosjsJx2vFudBoSF3HI9eLV0eGVdSwkvsHTEHTxRMvbEsKBghjmXgWMy2eBl4TJClkagxODGwfiEQQBJRg7bJV485jxR4ug0mbtxyaowW5mMpKRd2Re9KgARkl6RPIWgIwc65lldPldHnRRRMsjJNKhiaIF8M6QsbDAHk=;25:VWapaYOAwcIC3+7IE6TUUmeSG9cBJ2hAqYIiC4G0VzJ5lLngwtZTVGo3LfIcpOV/3+0ZQcUFhzLs6MnUh+zCQ1K1xptLQbYWT2Ybc6sszd7iwH9ccNZFP7KkdHiXDjbyBsxVMJxfZleu9/IqfibCMYO5M6/pJpKUwHsUw8t89jSq6Uo/LV6X+Mt9PgDyjtTf4keiWC73nZO8Z0f1pchc2omIxY8cE5k9TPOOlSJH+tsDmFFTmPI5deciDA1U2rsQ9M5nKPjN05Ceo3FM8LAjNLceCuObu0AxTdcuD/H0iL30xX7izPSvN/6ZX/QvVZqloP6cJQVKtFYLT82KBAi9Jw==
X-MS-TrafficTypeDiagnostic: DM6PR02MB4460:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4460;31:uO9VdSEZvxEtGUaIkktTJSxVFWk6GRwGaSbJgv0Q1i3ufPxe4w25xobAi68tvP+wha8NKdmUM6FUV3Oy0FDXO+znFDIecRG0Gz/ozJ4slNouWLzFx9JkQ8qqCbGmcJPCZ9oGviq4FN1xkugi5kKJWRUL2ERQibOM/7yVllZvKb5HAqHly4Ay+B+9AI5mYUiIXQ0KLj7Hg82DAQ3kqImam3jtCqBeCiQawrqUp8Z3m/g=;20:FvJ+O+EsPpaQnAvrT1KCuFQqdBAsCmvLbMn5eaBvpPBpEQZ8Ce9WrPRkTA8JCBjICFuUzKPSLKZnmJxiOscrcJfRv+VIwTfCDRH5E0706HABXK19VlQ9vSdceeA5oVB94E6n0FG+X2hTNT7HCp2NrWxx8KEZEEjtBwXA9/o9NpsI7kw3G9hbo/YwpqDENkzcgQUqWJDhhs0oUIuNlW/NGMKHiFJUW8MIzqARiUYT/RmuXvyT9Ee3R77Zke5ZgYDXqBZkpxjTNbeLicJCGTEZ/0SOSxP+oKA1CFiYyxi3ukaEhq87oW90EzZbbxMLpDJ6qRMWMEO+oqTI+Eu1wpCfYopNsNKUmc43wUqNHC8rdHe4UwlmsIGQEUtpn5CZIPJafBtADHtVyKlYnSibec7s3d4RX/n1xUzBz4vtRR8vrNwV3CREqjvl6zsjCpRE/LMDnvVBHiPFXD61AF+f1WdAV1C8RMdEUiEUdlsef9nnpqkUe1/gP+JvU/roiDCSh3HV
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB44606B3FCFCC175B9D5EE00AA5240@DM6PR02MB4460.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(3002001)(10201501046)(93006095)(93004095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:DM6PR02MB4460;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4460;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4460;4:ShuYbdbpicH/g3mhtAHz8vGnSwP71w3gZ4MDQzFG4ZC7gN/A8P+IgaGbHzqHuzzHgyHEGG9+Bf4Wm8VAotOIhDahVmGEkJg8UO+cV3MBP/1S2XRpMY3dQOSj4F7LNIaCFP1/AuX2ujOBRFo/ghgjF0QpsPa2rAO5vMBhnhX40WVAbC5ufwfu3OtbfUe3uMUueS7X4zqPtqTjqjp7XrrGaYTshoLACQMA3uB/ZMQiXe7caV30VFgiw69Lx8UYpvTtjrlnuSyh3svZHoLVPm53AzvFTZbkIw96DQVGJmNJJrd3hLOqrnlXddllBSACYHjK
X-Forefront-PRVS: 07607ED19A
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR02MB4460;23:X7w6R1O1J44AnAAdAXdiecgmW4+g4Jq80hFVEA4FV?=
 =?us-ascii?Q?PlTLyI1HBJl59uw5YYd0fpfbTitpEYmvDrmvlyYbkwcSTeIoszsiNEo2cvZ7?=
 =?us-ascii?Q?ZB+49mRwtVFTQHbcNXEOzHCAuNK//ZWKgdVUwFfcGzyIozJC9KFlPEkoK1SR?=
 =?us-ascii?Q?btUHgV9OIuIVbuXr5H1NUjNsOCRNasnzz9Fi4muGC7j/mkBdA4LiM6q3dmJ1?=
 =?us-ascii?Q?CISUE6jhd3vv3BHzmJy2g6D/sx8+0CMoI/r1aegCKnDdnRiQn8uXZgrmwwAp?=
 =?us-ascii?Q?SQApCxaDznd5M6EMeKHqwU/gZWF84vBGE9VoADYMGI5Ws3d2VlQ1nubLKwdX?=
 =?us-ascii?Q?xSFDZa8w8zgDOEVKRE5YIIhBOAizrw8D3Y8MI4ejje2tt42FtVnbvj4LnXY6?=
 =?us-ascii?Q?Rp53nzLD6t0iIJb+mMRwObTQF0OnxksADP0y9T8r2vc8JcyhWlio2Efs+TxF?=
 =?us-ascii?Q?02VZgkBAox/5t6xlDmoIYDcrynXZTB19s8kkUJhc/kBHLafOTIL9CVIer8xV?=
 =?us-ascii?Q?BGctuNR7k54FGF2jTcD1MnEIy5ETw4C4AMhOcLDTbCOFy3A0aj1skig5uSkr?=
 =?us-ascii?Q?zUda0NJ9XON0Rc3WvPl7+XN3RngpAxTnXuXz/PSf9o9P/FlvW8PX5wIMNRa7?=
 =?us-ascii?Q?9Wtlj+2lVboedOVUMZh6pUYOp4ZvxLy+tRS2LJ7UDWIS7zRKNQHVAK5vh5o4?=
 =?us-ascii?Q?ndRbBoojE/he2UVSgppYjeEmn6gjXhgUdHAHPHxv2hMici+unyWL+n50VGLC?=
 =?us-ascii?Q?YYcgbpjprLnmbHQqJvyFVphQqFEMTjDmBoN4nhFI7Kp5ii77TtTdFWdpBIEm?=
 =?us-ascii?Q?Q70w6uSzOPAxH5JGUEN6c6OiucQc5LaOvfixNOcwfTthyI09XhohKw+34Bj5?=
 =?us-ascii?Q?lHb9XwMDyDiNnaui2U974N8yMbKad0Qt0OclkUpP3E+BxuohDT9QaHMSvA3h?=
 =?us-ascii?Q?J29ogWZzuDiNGgf3b6dBCjdTcjVzY07mkzR96zOYSAOP9/63VJvxf0N4IFq6?=
 =?us-ascii?Q?EQYlfhZhNcSWaawgHhlYRZWT/1xPk5SqWuaML67Rdu4NHMJ5vaSPVkBczbC/?=
 =?us-ascii?Q?7iZgpv2iRi6lXVdsGn3++byNCT1Gd89fWushD85Y3xZmGG752tZ0fC243ded?=
 =?us-ascii?Q?XziiCid6T3knRQ+VAxgQ/yIwJDUZyU9?=
X-Microsoft-Antispam-Message-Info: LgEn9IPxRrj3xu+RANk9FAO70rkSOqpcCAvHANkvrOsBvxs0AA/47X/MpCPTL19Jcl5PCX0gXOkyh/NyqxYwbwhp+21Fl7msa10fmoVJsNwOaXx7KhO0QfydGHP2heKYHqCDVCndAdS3aQnSgRx20NHX+ATceJ+j+flYrTS4zJavbMCpHukbOrGmOBgLuMXestOS/CIaq6/ovdNxYxiDF2J12kIhOpG3vkeWH/EYX+mIphbvirahq1JRiicPYMIgApwqlbpkArBUqKX6a/L55puhviPZyJs2a8RhC3QuB9niMYmt1kb9eL48K+d+Aq1deWGhTembR1RU5LiPoPw5G1hA1p+NUXAEMrnlm5PasjA=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4460;6:SvnlePr8C4YioHAW1XpsrsI1gIP8Dq+RSWsrk/SATX1VF+JqUvQ2hy0bvwHGmwRRhApy3GbHJXS1ONvhoe9EGK+OA9wqofeHXSpaFgXGHzf3DkVnUKWhfKWuABlLUT8DD1cAfX16DEymbVZltxDGfrIv3rjghtO5tGYjaFod5VYXzQbxGUlhBchnoXxmuDoPA6lCWbN2MBvurRF2a+byRRoafstMhgvR8xxPOh+AI6kPV0/K9eiLhQQZJg6acdvUBS3imwq7YFV41axzVTPUZBmUjXvqtU8gq5u3+38YtK9vibLwcxvpI1cZi7JlELZayi/7eZGbJcAZ8D/eB2HKXnKOM0PIJP51UpR+GY+EHE2607R4Lp19ThT+oVAAmly4jQLMkqUQMSY38TwVnJBD0pupSe24pBwtcIfkO2ojW0LIIhj2Zpj4HyFVsCArDIp0fUYS06l9pfQgGlys79K0qw==;5:7+s8uMwtVJNDmiUUK1YWiUJMkHzi2V6pbC0/1ESo8dJ1cQr9LfyeeCjaLnxAooz2FyIHu2Gt3Kr1BZKtNK83DpCBlrF8WUZqL+6Qqrm6Eo/jAKlGdDfc1W6gkhHRfTd0AP2kn82M5BiD98CFIJdqAO14ZbF5vtBA1to0x0vIRAg=;7:a/rGM/LV8pbZrWD9HYYHYUIEBw1RP8PYkS1mG2OZQmRVbWxpAGT0hOTPQPLwO/4sP2W+B1O/rYG+OcDxAtTDZv4XbNZDgfOINXC3rLXVvRy7PR3WIsimW3D4MjysWZhoav1wgAnRFDVEYO0aoyHc+wUf+L7mUdrfb6PFUnBO2s8DS4WKpyX/wDXvb/4ki8quaLCke5IFVtLNIbJWm/cGWSvFOpKzacj0t79f6zbB57Hvc0Pi0/d1MZBkkhjcYB9u
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2018 15:45:06.8207
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6ffd4fb-6bfd-4a53-d801-08d5fed83fcf
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4460
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add setup_platform_service_irq hook to struct pci_host_bridge.
Some platforms have dedicated interrupt line from root complex to
interrupt controller for PCIe services like AER/PME etc.
This hook is to register platform IRQ's to PCIe port services.

Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
---
 include/linux/pci.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 340029b..c28f575 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -470,6 +470,7 @@ struct pci_host_bridge {
 	u8 (*swizzle_irq)(struct pci_dev *, u8 *); /* Platform IRQ swizzler */
 	int (*map_irq)(const struct pci_dev *, u8, u8);
 	void (*release_fn)(struct pci_host_bridge *);
+	int (*setup_platform_service_irq)(struct pci_host_bridge *, int *, int);
 	void		*release_data;
 	struct msi_controller *msi;
 	unsigned int	ignore_reset_delay:1;	/* For entire hierarchy */
-- 
1.7.1

