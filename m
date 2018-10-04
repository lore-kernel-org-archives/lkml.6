Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32FAC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BB8B2084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="EsdrmVM3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BB8B2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbeJDWaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 18:30:46 -0400
Received: from mail-by2nam01on0055.outbound.protection.outlook.com ([104.47.34.55]:7296
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727532AbeJDWap (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 18:30:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pYOjxmGx1pKQl1REvGjElbwCqXqVE/JTIwKm7hi3wKE=;
 b=EsdrmVM3VAdLkYKPZd/VeVln24/jaLyQWDNYZ/sp4pf/u4AxXtEm+GJSTdUb9bQS9zEb//95xmTXmg2cmHhdBEsvafMzsuQch0kXMTMRVQnXWzHoGw6eJW8Vv+w4YEIkodQgur04pWuNJueMbjHI4TtfUuCo8GPFMJpnj0bjPW4=
Received: from BN6PR02CA0039.namprd02.prod.outlook.com (2603:10b6:404:5f::25)
 by BN7PR02MB5105.namprd02.prod.outlook.com (2603:10b6:408:22::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1185.22; Thu, 4 Oct
 2018 15:35:51 +0000
Received: from SN1NAM02FT006.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::207) by BN6PR02CA0039.outlook.office365.com
 (2603:10b6:404:5f::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1207.18 via Frontend
 Transport; Thu, 4 Oct 2018 15:35:51 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT006.mail.protection.outlook.com (10.152.72.68) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1185.13
 via Frontend Transport; Thu, 4 Oct 2018 15:35:51 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:54901 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1g85fK-0002Y9-KL; Thu, 04 Oct 2018 08:35:50 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1g85fF-0008Vk-Gs; Thu, 04 Oct 2018 08:35:45 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w94FZZdZ023735;
        Thu, 4 Oct 2018 08:35:35 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1g85f5-0008UL-5j; Thu, 04 Oct 2018 08:35:35 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 50C19121465; Thu,  4 Oct 2018 21:05:34 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <michal.simek@xilinx.com>, <bp@alien8.de>, <mchehab@kernel.org>,
        <manish.narani@xilinx.com>, <sudeep.holla@arm.com>,
        <amit.kucheria@linaro.org>, <leoyang.li@nxp.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>
Subject: [PATCH v8 00/10] EDAC: Enhancements to Synopsys EDAC driver
Date:   Thu, 4 Oct 2018 21:05:18 +0530
Message-ID: <1538667328-9465-1-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(136003)(396003)(2980300002)(438002)(199004)(189003)(2906002)(90966002)(81156014)(106466001)(14444005)(50466002)(48376002)(6666003)(50226002)(47776003)(36386004)(52956003)(51416003)(2201001)(72206003)(5660300001)(110136005)(63266004)(426003)(305945005)(7416002)(6266002)(81166006)(476003)(486006)(44832011)(478600001)(356003)(4326008)(54906003)(186003)(26005)(42186006)(336012)(126002)(316002)(16586007)(36756003)(103686004)(106002)(8676002)(2616005)(8936002)(107986001)(2101003)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR02MB5105;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT006;1:OYBc2jERY6AvgNegR9DVez329yNAizjNFcNKgRS05qcepHez6yEKqIGLeqQFyYM3WfnKlp3s9n/k34Imho+Nmo3FTRgue/ujfPi+8l8NIy0xJSlqOybJtJXULqYiaPEv
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 464ce7f8-5c81-48c1-46fd-08d62a0f10df
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BN7PR02MB5105;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5105;3:GQQJJ/eX7X47QxSS18b4SSLMS2YO/cb9oyon7z3txfsocXOX0ifvvAl/EArC8MNxJzCIWIKICuI82V2z5Au1ahd4U8z1jIfuPFufgakDRRQ64P7IqYB03c/wHNw3P6UGBiOhXKhIUGhc8bAY/Z0YRf35AzSi/fObT6RFqp+D+swhhwnwFcBum74pk93a1L+CKiL8AtsTbqNBMGTyIt0FtaI0npNgKy0CGxpp1JstxKdHh2wxrQszMqklCPZHH6LS5o0lvLecEMXzu+AXQNPCha5oaZ9VZkABcjOQ4ApcZfDDUBMlxAACusr6CHMHGiRk1CREurgYHry5JAjJDknI0XypVCUtYQGHm/lAm0Pm4LM=;25:+mveAbhk/RAEygng63BDxmTOJ8M3O5w4kp44oqttG2lvn68A6EPDAYhwkJrrn+BQVbpzAcN3gImMZj8pog07uMDBlsTRZTdgxjDE9FfkKCzed9XshqGTYjR1pCQF37tcCOxfr6NC4yAvkIkxmq6FtpgKi1tihUZPX7y1GjysQvA8sQTqWW3H4VJRJd0aufs+anBGmxHJ1MSvtB76hXKcbHxHFs/IsuW8T/eFCdy+XMADUqoRGnSM6PTOajTZ5NWo9/Cc8HaDMFGu9l7td1kr/veQYxR7LwulKxS1MtXG671Qq7PoXeZA1SNyUaoI+7Pj6GH3uD1CQYNFtk5EOy9hiQ==
X-MS-TrafficTypeDiagnostic: BN7PR02MB5105:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5105;31:pxKFqrhqgWB7q2HUlnRCmB86pFsUrNGQ9LsS2qODuTm2clbI6ziXuMTMIFbVqYVtnxzAsDloRmA7/g2Q1cfWSmHVzB9vlSL9mcl38DOo2tUU6CHXPiBcQQ3ij077lZ6A4ZEm1MOnni6YweZYiw8nPZZ030dPvQylgCrs/IQuVjYqFl0rCayZFIfDYTUgnlZPuNdxyVhPqaNcomshrSB+E4JigIqpn035ZEU7CfucBBE=;20:8CIUBnZmlUDgSmU6imEHFujPTLO48hNL+e3gRioOtx8Vf166Q6UvJKeQ7ki7l6KEmmwLICVwQD+PCmWduwmiDm2lSZQk3jDsxYooiNezLqCRyeT/BJARKtooa+9xAdLWKvK95MVK0QS2bp1rw8FTasVA1EFv87jshW/CIhmrThD6Rg8q6UjBOOsiuCRmIWD29tiWgi5SR0ZNA7mtODqYFB1iH6p4chqoON8ivpKElZ9MHmDVN1LEdYraTYwwbkKKfrUHA6TIm3KNQT5YI77b/VXRqiczkuK/pQSjUkqid+1Vp3MQz3AqFIAGwRRoWjuF15+jNVGd+bRvI6skG+KOxcd6hzl9MJibVHJDLu9p7EW1PgGkqRprYeRtwMQ3YuHaoSAk06s8u/NkIUPWoVR+BmZD2k/CvZFU1WL9tjrr+zQKNSv8xz2mZ2S2g8BnIQEV4w0X+PsQ7luctmEqC0Ez9/GNsSM8FQFVR8VKSESQtgQntSaLa52Wnu7+H7rU2qJB
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BN7PR02MB51057160F4C9BB5D9A6C9159C1EA0@BN7PR02MB5105.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(93006095)(93004095)(3002001)(10201501046)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699051);SRVR:BN7PR02MB5105;BCL:0;PCL:0;RULEID:;SRVR:BN7PR02MB5105;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5105;4:WYfHum0iudY4LKdleIJvdTYxCJ5A6jt4aQlnro/QYXz2EP+HYmxz0PdDtBv+SJjQGwjhr6jqFmbstNaGKzuRi8c33rYUXmqDQPXLKC/FOtjeRVZznvzN6lmB52gp5rFVi3VvXqY3AEZ8lzEhJeHpapuysI3Ht8sEf3fCEdA90cM8hJ1QIc/w2xARF2i/v3q2Sg2JdJ3elEPLdJAG7GCW+FplN05dmuYjPNdRp7klaxmWyVXtor0aF1b0b+57kkwSzN2IQA8PlQvESvSYxh1FIA==
X-Forefront-PRVS: 0815F8251E
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR02MB5105;23:kfg7eZY+LxwZkcHAwS2Z4ZGsmn2AnEi98i/dmCkHM?=
 =?us-ascii?Q?wFilkm4Mbb2g/54hkDwrLfQUzeCSwhKAmf0Y7wdWC0l7DS5tTNeK1Dgh4XWu?=
 =?us-ascii?Q?8JzcXml96d612l9x9iMO1fH+3Yw3K+KjIVJOE8uIUzb906UYPqmiCiABJLlH?=
 =?us-ascii?Q?xcpkS4QzGZWuIkUZZk3N+47y1rwLKOWdIHlXc6+V9rNmaJAo5WYSYeEYE62y?=
 =?us-ascii?Q?Wq6rFK76adEVC4yfR+yVQUfSSlQr6blssCJ4NhncHHN83SpuIPZkxTlBHP1K?=
 =?us-ascii?Q?8sXHL7fCHr9OMxH26h0/ZgAzrRhr1n5BovzYZMqXv3fPD4fmHlAI7AIQlNI1?=
 =?us-ascii?Q?F3a9lAlQvaW0suwmfhJS/KDNlzUDDKDkEtCYGUCt85TdWUltY0Ty1mduov/k?=
 =?us-ascii?Q?0lS63BXxpz2XtaDBZNQcAOjArvXqcLWy2Yjw+d09HXSu2BeOiEEe34cAU5fq?=
 =?us-ascii?Q?xDq9d9sqfTG4ozpMHt6LLXzNuxfmCF1ib0MDgn7AKKV/3jZXAPE4Ajs+BcFE?=
 =?us-ascii?Q?w8Njjwo9fwoDgFNLQA0aGh/Ge8DnW1C/6PbMEVFrMg2+VcyrROvLm96oRRCA?=
 =?us-ascii?Q?qonIVCFjIlOweu0K8+LbazprjsC1QJCvLf5CSIglrdZHVK0AQ+3oWFKzEje8?=
 =?us-ascii?Q?EDE281q3c6MumEIf28uCXh0Y0IU69G+Lr+zjKEpf4qnc8S38XWFVl0NtLZr/?=
 =?us-ascii?Q?rhAXgs8x5hnp19vtNeyxsdJInHSlqhaocrF3A1FObZdsEMqUq8sMV0/61kVK?=
 =?us-ascii?Q?fHJlfPsbv0GOIn7hlaMC2KEEu5rFcZkiGVXCCdVaBYUHaa3LPMg5SoXQ06dk?=
 =?us-ascii?Q?VVEGCsW+hlKquTlO947ReyCksoysKwjJiv65Hf6egRVgUA+KBRQpVfyDN+Pp?=
 =?us-ascii?Q?DYmEMrrwySTmuUzNhE92O1kOPR4U5kE3Oj8oEnzKzqUphgznqBkbEKWsml3L?=
 =?us-ascii?Q?a+7yw6UePnZ4yqGjZlCd9ZUg+giuB6BH0fpTVfmkyaBtN/MZyYGqRfmUgsCp?=
 =?us-ascii?Q?WcEqK8LCiC+4GYw60uav9fA0g/VR3UOCkWUdJl/X90FrMAo40lXtroq0XtSj?=
 =?us-ascii?Q?Y5ws0ZPPyckdvnyoUjYPJ+gLPTzzq7z13tJbv58A89LmJhP4fc2UZ+LBWPt/?=
 =?us-ascii?Q?+CwNx/MI/UhvIticn0TCeYM5c0qvU6XiNLpreBjSzTH6jDCe9dH7P7epBzUf?=
 =?us-ascii?Q?woIS4/l650kv2pp1bwCcCU6kMgHESsUmD96axijuNCa+vKZ6XxCoSnPlw=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: A9/yOLaxSTdvFlRAEbqptvxDe/SHIAN53ugFh19LQ9o/k53zyqB8ilBwpB/Zg21tLaRMgeLUvCduZa20IShJUqXKpOBU0+Pm6pxJZnQYMYDcAkOtSooVNexFkj2bjLR3bGAYx8LZjX4B0IkKWkpgV+vOFk4D1sldT+lyuH8nraKlR9sR5XioWrAlTq9P05Z291voP78HpbkJNeh7fkofGb17IMU9kMRr2a754tw+i3SJJK9aSLDwz/L3D01ZWMioQnINNZN7a0DQp7u36mVLLXUkTYV+G8SYw8QNtliqh+Lem+9jfaPY4SI27leCtU9eBbs/EoxwxQKxbtD/glnnKg6ybVqJOlu3R34P5eLLni8=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5105;6:C3IkWmEqxowevUiP7ZqPLB38s51Y9gY6uNtlPmWSUJKM94r51opzeGGYiNENoKz/69DkJpfOM+4V840oeYTYqytq9UYbMCm7w1VzoA+Cxeq2dx9OO9u/dBh3re/SvB08X7lcyZoVZzECqLpQU2Zn9HCQkrRfTTfe+RXTcpZiJFVaf6/Z+437xSZrV6dFWbOhcTvZJ7Bu543u31Tg80OYIGmlX3Y7fF2osFSSBqsfe/QZR025LhU6/wTu4KsFH/6Wy2K8dIKvCaY0he4SnwDOK8gPPgCq1HpXQ6IvmhL7M56/x3yniDK72VBcVZ9OtG80+Ho3qcxzyeL3cZdDOkEPKQy07L+eyhFjpi6i+DmxXy6D1ToLnU3ZcUow4yZBFJS/xBdn5TPGEwHBaI6+mnE40IdR8qYDDEXPKnruDREYSfeY5J4yJTF0q4Af3r65Whoi2Xq7771/VBIVmZMXNMTjJw==;5:fqsBsZmsu87OODZ2eyJMg8lqy0YCcd3eteTvxAH8UYE6SmxwD7MH5zx4Qy0qDZ1UHuVIl0pnOTuep1uMvdW9Byg3Hb4AXBU+aPpOQKFypOlMlGhzb7e/LExwdbnY8GfLwCLdZ38r1mQqnctPvtn1Anh6H7BXYwvYh1Br3aDSVYc=;7:mcCrxjL8/Q0zyoIP6zSOnfW+IEtqJHfYqzvN/0upqmZkQnoyDvYz0XuHOu93vI9XQ8QRofhC04/Ke2TSfp6MAX3n2caFzgPCpGx4OjJsEFyVfKrzXAeyUDu9DXtfnICPkwyRgYwf1p4LT0inwWeCXEUk+Cek/FvAxVuEiJE1v37Ja1qYGsCnStDohDHQfe6cDHsuFESeYpN+3v5Ti94sabICp22OXkZr1ApCZ5pGwwsbEcBT6rtBsB3+wRmHw10G
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2018 15:35:51.0604
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 464ce7f8-5c81-48c1-46fd-08d62a0f10df
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB5105
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series enhances the current EDAC driver to support different
platforms. This series adds support for ZynqMP DDRC controller in synopsys
EDAC driver. This series also adds Device tree properties and relevant
binding documentation.

Changes in v2:
	- Moved checking of DDR_ECC_INTR_SUPPORT from (1/4) to (3/4) as it is
	  a feature of ZynqMP DDRC
	- The Binding Documentation in (2/4) is modified as per the review
	  comments

Changes in v3:
	- The commit message in (2/4) is modified (Synopsys EDAC Driver -->
	  ZynqMP DDRC)

Changes in v4:
	- Updated the commit message in (1/4)
	- Renamed function pointer names removing 'synps_' in (1/4)
	- Shortened unnecessary long lines as per the review comment on (1/4)

Changes in v5:
	- Updated the commit message in (2/4) and (4/4).
	- Removed the unnecessary check for match data in probe() in (1/4)
	- Some Indentation changes for better readability in (1/4) and (3/4)
	- Removed repeated code in (3/4)
	- Used 'zynq' and 'zynqmp' instead of 'synps_enh_edac' in function names

Changes in v6:
	- Splitted the patches according to functionalities
	- Addressed code style comments from v5 review
	- Moved the Error Injection to CONFIG_EDAC_DEBUG mode

Changes in v7:
	- Included DTS patch (6/7) which was missed in v6 patch set

Changes in v8:
	- patch (1/7) from v7 is split in to 3 different logically different patches
		1. functional changes like code cleanup
		2. functions renaming
		3. comments cleanup
	- Added a separate patch (4) for making always successful functions as void
	- Corrected 'Too many parentheses' review comment in patch (5)
	- Corrected comments as per the v7 review feedback
	- Made dedicated functions for IRQ setup, IRQ enable and IRQ disable in patch (8)
	- Addressed review comments in patch (10)

Manish Narani (10):
  edac: synopsys: Update the driver code for better readability
  edac: synopsys: Rename the static functions to a shorter name
  edac: synopsys: Modify the comments in the driver
  edac: synopsys: Make return type void for functions always returning 0
  edac: synps: Add platform specific structures for ddrc controller
  dt: bindings: Document ZynqMP DDRC in Synopsys documentation
  edac: synopsys: Add macro defines for ZynqMP DDRC
  edac: synopsys: Add EDAC ECC support for ZynqMP DDRC
  arm64: zynqmp: Add DDRC node
  edac: synopsys: Add Error Injection support for ZynqMP DDRC

 .../bindings/memory-controllers/synopsys.txt       |   27 +-
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi             |    7 +
 drivers/edac/Kconfig                               |    2 +-
 drivers/edac/synopsys_edac.c                       | 1194 +++++++++++++++++---
 4 files changed, 1072 insertions(+), 158 deletions(-)

-- 
2.1.1

