Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B3DC433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 15:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A9342086B
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 15:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="3T0NI1N/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A9342086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbeIHTtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 15:49:36 -0400
Received: from mail-co1nam03on0040.outbound.protection.outlook.com ([104.47.40.40]:39808
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727256AbeIHTtd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 15:49:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4GNFl4f/J54zigfvF25AREp02RymxyPuWz6cNSjukBk=;
 b=3T0NI1N/zlE5JHXUTjmI/Z7TyQzXO8GEQFt8NPtCTH/MfsIKQ1oKObFGaDwaD3ZeS6UfimVCyw5oDoPPAvU5lEKlGfpqX/aYqAEZ2fX88mzyi/bd1NhfVc/TPLArCd/RggrhJmZjAswold/bRRk+W5yRQT8N7o4AAJnPDwlKS/4=
Received: from CY4PR02CA0044.namprd02.prod.outlook.com (2603:10b6:903:117::30)
 by SN6PR02MB4941.namprd02.prod.outlook.com (2603:10b6:805:99::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.16; Sat, 8 Sep
 2018 15:03:21 +0000
Received: from CY1NAM02FT044.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::204) by CY4PR02CA0044.outlook.office365.com
 (2603:10b6:903:117::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1122.15 via Frontend
 Transport; Sat, 8 Sep 2018 15:03:21 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT044.mail.protection.outlook.com (10.152.75.137) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1122.15
 via Frontend Transport; Sat, 8 Sep 2018 15:03:20 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:54063 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fyelc-00020y-8N; Sat, 08 Sep 2018 08:03:20 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fyelX-0004pQ-51; Sat, 08 Sep 2018 08:03:15 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w88F39V5031606;
        Sat, 8 Sep 2018 08:03:09 -0700
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1fyelQ-0004oc-VF; Sat, 08 Sep 2018 08:03:09 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id DC313604FC; Sat,  8 Sep 2018 20:33:07 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Thinh.Nguyen@synopsys.com>, <v.anuragkumar@gmail.com>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH v4 5/8] usb: dwc3: don't issue no-op trb for stream capable endpoints
Date:   Sat, 8 Sep 2018 20:33:03 +0530
Message-ID: <1536418986-16609-6-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1536418986-16609-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
References: <1536418986-16609-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(396003)(39860400002)(2980300002)(438002)(189003)(199004)(3923003)(36756003)(81156014)(36386004)(50466002)(48376002)(51416003)(76176011)(47776003)(186003)(81166006)(8676002)(478600001)(90966002)(103686004)(26005)(107886003)(14444005)(6266002)(356003)(305945005)(446003)(5660300001)(106002)(106466001)(126002)(2616005)(476003)(42186006)(110136005)(50226002)(486006)(4326008)(336012)(8936002)(426003)(52956003)(54906003)(6666003)(16586007)(316002)(2906002)(39060400002)(11346002)(63266004)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4941;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT044;1:qn3ctWCnS8IOTefKpSV+g5BTQ8QSvkbMVUiuWbWgg2SVEyoi4t4HBUle8LQ3YbYZeIj7awX95Uzck9t2EqVb+7qpd1xoovb83TLk1o334Emenf78Aa3U49NYN5ZqXNH2
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2503673a-c8a3-4a95-b1ef-08d6159c379f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:SN6PR02MB4941;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4941;3:duBMeVC9luF/yACY9QYmM5kimzSF5r34igyf9Uflgx7jOQq7HWBwfp8/THp+T+8z8gH/mnqKCdOd87WnbI7OpRik3q6CdLaR7C9yXO3nBcTCspytOLBwSFAkTUNile5nv6XJTXmutS1vUMHhYCMfQ3magpghopD+lBx7XXPIyM8dZQ9pPlfoWDEvR3GPrbFYOwoS2vLw0DSn6WyAqwvYkV6wOuBU4YNwqa7GRCcLVtMyGdWbUDSbEAxswWsH6hIYqOjxNmDntryl0XZHyiJzW/NRcM1dC822GL9VQ3IjQtxbZtYx5Te1LUaOinNUojAHxsXIAotAnm3lgNGmjxxYGD/kgxlx7JJwl+hV8GmPWTc=;25:cb1d2nvWzY4UETd2OLbhA8py13P2biGm3WspRJiQawaW7+BiYdhdnlwxQnQ88ug/87HHIie848BQyfAAoodQEkFR42KKOlQ+thYWaOntohtCo0bgHFjt64um2Y+6G/04AKhDhLa9GECtjc2JW0z31T0t7oBUTke1p8OsiNHjvfcXBd9E4Wiu8ppUHijZfm/fq+fwYakC2pB+YWecHFjFl6bXaspul/Z/g9GLtfzpFONDKoDhXF0uTiyGCpgJTovd1IiukyH4tj/pXmNqSjzmCP57eQtKKxfuuHJXi+2i16hhTqyHNDVdhPz/EKWNXJO3xOMFNtF1yE9mLRiOaWNYzg==
X-MS-TrafficTypeDiagnostic: SN6PR02MB4941:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4941;31:xEdSbynALbNqLlcwaJ58fml17+A49PpWhbZLH5jEi/nPIq92BkHKZ0JSdR7yHPQYZYKo6Zh+6AxPAihHuaHeN/wdgFqGxdZeAwEHpDbmuIQnpyurlgozZIVx3+/nHcCyTZlJ/wjn90JgDoGzpkXyotPLTw+cuq9F6+axRwvolvE2l6ag2e2AI5+Hg4H0tr5Jj1xTWB7zjct7JI8rMf36vjgKnx0cIgJWqh+7VCovBcE=;20:rK/E7UzM+MkbvqSLU2QdXqOJxq6ciUWa2RR5wVprU4PIlFXY/2nhdOoXWT95zN2PmfF98WOvbueTPZ/kOl8zA1BasGPWBlJX9FOZO/ieNiwonL6HYmX6xt5np5qIe2oYOI2jfORDoMHDZYzAxKkkodltL8CNNobh2Vs3tok37Rkh3JdKC34hDcN0Yi92tn2Xmwezew5JdeVmfQZp8LwDA3KTE0+Bsm0rwAkgAiFazE01YC3MrRYGFDZcJGXyYIYMzIyZjN9J8f/nDwnd/Wb/6cAAPWhSfhCjHOfB5zLPylD8BdmMjzCN5+ABsPIYjctd7PIpfiSd/JkX1oZe0gItsAkSsfsnYge6KZWS8MELFF+GQr/QmhxR3SyQnYfcyQAEztaN2SpknY4T3e1+mgWLK5a2wASwzKStswqM+lTgDFzt89fTuTo8Sj5g9u9pf6NzUxZzlQF2iwJB/fBY6WFp/i0XT5oHMhuTq+xp4Douqg1DrMVOk+BxuOhPZdRZug2h
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN6PR02MB4941380EDC41EE14A512E882A7070@SN6PR02MB4941.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93004095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699050);SRVR:SN6PR02MB4941;BCL:0;PCL:0;RULEID:;SRVR:SN6PR02MB4941;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4941;4:1xEU9a+xFSc8jJMsPHjRcnzmc+fpZR7JVAoaGpxwOCkvPx4tawSgP3u5qlAYArGcTJ1IPPJdNFPAxqCu6Ehs2w5IQJuszdo0PmYCFKkf5f20ZE0Se9Jhz5BGVyEN9q8ZBsxnhJRM+rRJMHI5MvTxEjXYy28HxoUjSAu2gaM8u51E3YZU9kq4i3U7CnMftgDaFAb5qr9q7eb9gNN+7CnuAK8+PXG8COUtukYNmC+a8tnVCp0m+ak+9GGbROmgrdzDun2FKQpIvvM04YXkG0qDLb3kGYIKmwdG2oP6meI/CG6P7drUnFdxU5AnjYOkbyBy
X-Forefront-PRVS: 07891BF289
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR02MB4941;23:tnxeGiQeNviWPbxusIp+JAOf3nVZnOLDCQAjkT9Sv?=
 =?us-ascii?Q?sUAQ7962n1ImyQmGpcwdYm6lYgL14K0lxMJLO5Nm2hPg3zxxxr32BlFeQmU2?=
 =?us-ascii?Q?l370wUGeTfCjmR/WtzqRktpHkZpmKZ3raJYxdYAInvcg3wkRpjyPMfeO3l1/?=
 =?us-ascii?Q?s9P4RH+0N47/X3xiDBQHQwjoBM+jBUYPAoCSO6q0OtD3UMAVCelxlhHYymuM?=
 =?us-ascii?Q?SutowWGtZu8TKe05TmkeKZrhKMnVEfjQlveHcuGtBlXO8CL4od3XeG1h31nb?=
 =?us-ascii?Q?GROQY6V37Lgv7GnkPc79FuD0PQFiiW+hM924OBQL+tI+Ukd0BJnTdIxc0z59?=
 =?us-ascii?Q?Gy5AgdtVBovM1shAzFRUEFEMhJJTup4ekBCqKNH6gBgDBvvz4kPeOmCwbHoG?=
 =?us-ascii?Q?ka9ew5ClWZq4Az0BnHqDxvvPyeWfMi4JlyBh4IZzsz+MyfdUmsvf1pK+BMaG?=
 =?us-ascii?Q?E5Ezf9lBooSha79rua1/TUxBgcu3n6T2qiz38EVCGxg5hTk03rAKsdPUdXpM?=
 =?us-ascii?Q?EDmb+G+cV1W1tdXDjwh0D9TB8FLFz1Rzt27kZnh6dCaVMRsMG3IGYzd4oCtx?=
 =?us-ascii?Q?HGAIXYbsreU/GSmHkMBHsJxAMGK0CLMLCOgfYj54PTClEHFxrEPkZ9Rx0NdW?=
 =?us-ascii?Q?qpGOu3CKica0bSKYYRq50ydV1ZgzguG8N/OYdtcRpUiXQrTcBuJGndxmnTEx?=
 =?us-ascii?Q?Zk94bbp/U8h1m761mSuSK/rG3Cp7HByViwVBI0O5AaQHnWMWyhQLPMF1PB8x?=
 =?us-ascii?Q?/Alvb94xVI0pPOSrqUlsWtqWLZpO4q+NE7s/58RqwWcPIl9+0L2f+zIDG8oq?=
 =?us-ascii?Q?ZHou6syrDGFNMX9R23S8fTlMQC2OYBTFl6rHx3UQFrkz8gWeo8lOKBs93dBP?=
 =?us-ascii?Q?qDruh1MJ62pu5w9J90a0lnoBBVbzm4Hj4+DOSbbabG/LoBJsU+XPZVJ1I85J?=
 =?us-ascii?Q?wMzJW9clinOplpuzDOf/vF6AvkcvQEVOzjYpIdgiOIo6JvWIWXmtgKzorwAA?=
 =?us-ascii?Q?DXHFFd6w+6u0zkCdgvRXyBxnbcOfXpSwsKtz/cPw+Lrhzmd8CfgePN7Fd4IW?=
 =?us-ascii?Q?PEKjG7YeXJ4UFOJtDfFS32KsNreg3Iiy5K7+EBwiN9bUnf5X31OxOwD2f3Ou?=
 =?us-ascii?Q?9NQqrOFlOEilVLV8W39sb3faGyHmTfcLVBGgjZ+ocD2ugJ1q02+yqS1lhn2I?=
 =?us-ascii?Q?o4yUNztnDSFn/f8KaJ1/LKmrwxzISw3jR6vg7QzftqLuhNC+4ztS6z313nkz?=
 =?us-ascii?Q?sxJEABGm7gog+L2zwU=3D?=
X-Microsoft-Antispam-Message-Info: ZlSm48odadmjEb2bl0DMub+7A9TCj12QYPZph6FrUgEIZ7bjjzaCNf4AoQJo/9MU8O/O/Abq2YAczGXjyEHQkhDrMAnKPMvXUyI1yAYLl/YmG2P5zBqMX1NLwThg1zRiUEQnxHFYcMcyfM9q2+9km+4c14u7piMRcaZV0QVfFrv1PRYos4Qv2hMFn+XR+cW1m812ctlLBYiy6P8HNyJYbEdpdq72mneZs5JjLqeBMFSo8huO9KWghlnyI0JWdHcTYGfs3Zh3B4JuvZkz7lPYSf6N5E7J0cLUzGFrf/wa2en5W1/kqJXIRsTF8hVKoUR1Yc6EEJx+ZpRotwtvB46spo+koF4aOMcqPZdh0covKvk=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4941;6:EpG5MKuChsTM+ZSB6NrHzujnMRc5tlxAwFk523Gnowf5zKjHGn2gFPSjwUqF6gw14f/GJjS/ti51+E0Gs/mmTGbZrobyf7YAR1beSMxS10YX/JEU0e+bb5Sa8Qu69cye1zpoEq2nvhvA/kpljUd1rqm6im+iG4nrneh+U/io2mJlEwwOVVxppx5UADtJGydpXc9t6VSqkHjMvyetUsBZXGT+6/b5JKnpMySTK5awiWE+fVjjz88sIKHUd87WfGA3bCTkBwuu3H5FqO5jFzB33kgjJGPEKGNJzKWC7//2hp6r2IR+TKQ4tL2eeSsB5hG16AeOOv37OSfkCrBKB9k9k60juGsChfqRzJ2ouKSSganMWqW8z9OQqF25Be/czavjPL6kBs1cfy/TdopqzGv1ZAbl0X5iD0sRf4jDWH5oDuwYRwBpu3F37vM47rNWw1UV8SaEDNAECJKFZ8ZQxOKktg==;5:crM2Njv63Gbefg3VfbCZfahpiecb32uPPZH3D4ZWjt5kNJNVT0MxTE1t3JqYrfyLz5KB0kTrmPdq+qn1HTvWcLyir8w5GVs5n/Jp4jerMMHoc6Yd8YJoYoloRHtSXzCiba+L3bfvn4N1rMAyNWSNAiZvATzaO4ScjGZ3KlG8ru8=;7:AIO3WWtT/n5qXC1kdKenLV4kkwp4xBxKotevuTZfPIdWSkU4tHnPPA/NFU3Q0PbwRZ14IRQqFYZkQ+H3b3lulcZ4VV9G4pGQik1lDO6cDxcY/jqyJHQy/RIVuqqOh6smMyId6eUnh0tfanObPUaD4uip6vmibU2/Sko2jH+V3R7/srYCAg3Lw1b+Dcsm25BVKl80LTXfjLbGbpxHJBKgGcpYUQ9dD/+HXuneRFJx3BBlDje4GJQ9Z4vCCqr240kY
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2018 15:03:20.8047
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2503673a-c8a3-4a95-b1ef-08d6159c379f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4941
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The stream capable endpoints require stream id to be given
when issuing START TRANSFER. While issuing no-op trb the
stream id is not yet known, so don't issue no-op trb's on
stream capable endpoints.

Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Reviewed-by: Thinh Nguyen <thinhn@synopsys.com>
---
 Changes in v4:
	1. None

 Changes in v3:
	1. None

 Changes in v2:
	1. None
---
 drivers/usb/dwc3/gadget.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 306d4c5..97bfdf0 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -677,7 +677,7 @@ static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep, unsigned int action)
 	 * Issue StartTransfer here with no-op TRB so we can always rely on No
 	 * Response Update Transfer command.
 	 */
-	if (usb_endpoint_xfer_bulk(desc) ||
+	if ((usb_endpoint_xfer_bulk(desc) && !dep->stream_capable) ||
 			usb_endpoint_xfer_int(desc)) {
 		struct dwc3_gadget_ep_cmd_params params;
 		struct dwc3_trb	*trb;
-- 
2.1.1

