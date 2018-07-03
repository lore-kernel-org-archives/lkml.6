Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99CFCC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 08:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D0022199D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 08:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="E4yB+sJW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D0022199D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754630AbeGCIot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 04:44:49 -0400
Received: from mail-bl2nam02on0070.outbound.protection.outlook.com ([104.47.38.70]:23291
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754096AbeGCIoq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 04:44:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FHlMcp56oPlJ9o/2FEQLD19Gj+dFvZX/t9lIt5Iu0Uk=;
 b=E4yB+sJW+lQ5AZZR7cZYQVSUvUuNcUYiFhztY6F7MVPAnYSewaUnPYwJZqwHKyHlL0tT+2OrkngFLqrlljz0+rkTQp9CK2a6GgLcjP6yPxWrWUNY8YxbH77eF/4FcvF0J9puri2MC6W9GsRV/dKhPQ5Hf5nU3ATG2stprOgUpwg=
Received: from MWHPR0201CA0037.namprd02.prod.outlook.com
 (2603:10b6:301:73::14) by BYAPR02MB4455.namprd02.prod.outlook.com
 (2603:10b6:a03:57::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.25; Tue, 3 Jul
 2018 08:44:42 +0000
Received: from SN1NAM02FT062.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::209) by MWHPR0201CA0037.outlook.office365.com
 (2603:10b6:301:73::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.906.24 via Frontend
 Transport; Tue, 3 Jul 2018 08:44:42 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT062.mail.protection.outlook.com (10.152.72.208) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.906.15
 via Frontend Transport; Tue, 3 Jul 2018 08:44:41 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <appana.durga.rao@xilinx.com>)
        id 1faGvR-0004Q2-FG; Tue, 03 Jul 2018 01:44:41 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <appana.durga.rao@xilinx.com>)
        id 1faGvM-00024V-Bp; Tue, 03 Jul 2018 01:44:36 -0700
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w638iS6m032364;
        Tue, 3 Jul 2018 01:44:28 -0700
Received: from [172.23.37.94] (helo=xhdappanad40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <appana.durga.rao@xilinx.com>)
        id 1faGvE-00023i-3D; Tue, 03 Jul 2018 01:44:28 -0700
From:   Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
To:     <atull@kernel.org>, <mdf@kernel.org>, <michal.simek@xilinx.com>,
        <navam@xilinx.com>
CC:     <linux-fpga@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Subject: [RFC PATCH 1/2] fpga: fpga-mgr: Add readback support
Date:   Tue, 3 Jul 2018 14:14:23 +0530
Message-ID: <1530607463-6287-1-git-send-email-appana.durga.rao@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(39860400002)(346002)(376002)(396003)(2980300002)(438002)(199004)(189003)(426003)(77096007)(8936002)(36756003)(26005)(2616005)(356003)(8676002)(14444005)(81166006)(81156014)(186003)(107886003)(476003)(106466001)(6666003)(336012)(4326008)(50466002)(48376002)(36386004)(305945005)(63266004)(9786002)(106002)(50226002)(486006)(2906002)(47776003)(5660300001)(7696005)(126002)(51416003)(478600001)(2201001)(316002)(6636002)(16586007)(110136005)(54906003)(107986001)(217873001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4455;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT062;1:oIVGZoJ50JQYwAlrvX+h4ivPeOu+ov2T9ZjjsOcMcz4wx3Bz8jux8BKx7+o6cUDMUrS2Go7blP79agAXorGfzrq/nBvliuOFK1VODUxqpZ8MWKtpRRyy7v2KV4CwyfQt
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b7eabda-8437-494b-01e2-08d5e0c13848
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BYAPR02MB4455;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4455;3:a3lbZpvoJZVW4eJ9ifrMG/07tMJ4ZneG7pJj1JuTrBQ7jSHS7j/va8vvXZduNRlbE7CLwunwzRn8Z/Z+6TcnU62hQvnDTjVWPi002LHXweOCgk9QPxChaj5skqELgz1VkIgMqa9DxrhOT0I8Q3ZrdBLvwNlje8ygtReYMVOq//GAiqkSpMcr3EWGapThgC3h9LYgKdOsxNyyYGynf9ucV8OZH94aN1MBJzDG8Pbd7DI8zH/KmMm6PTg0WJ4saiCXitvdGoNG00iMBjWCUklZNCxRU86M+wi6l+YXHdpxiDq/kvpupUanBBrIgm3YLd1Qpjdn2hM1yg4neY6D0sUJofE9QUbvUcTLDSiXx1508Rg=;25:MF7w8KN219KUj7nOS83my7nBP0ckUnGCUY+hZADwVa5wUyUFmkHTvmCdDh0rl3SVfEGJ81OLzFZYMeEnBAYqHe6+2ESy4vbhRynVQq32Z2Z9+LnvnhzBo8rk+vq+AdZIoxHKXutvNPmxmiUSEcnaY/lIN+VC+THLlTfK2RywTTkM+RnGfCyWmn0a4odiAKVJOqiHPLMrCEYbmq3FMygxYII8Ooci7s2RVzgd09Ne9dzuOecddmWd6TOJaHiPa5rdoKVzsTlGjA6OW78cRE2Z/bJmbzdtyjaY9S6EO64r4oJr1ahGFQWINWRIVtytEQACaKBpSgiilzb7068i4Lq3mw==
X-MS-TrafficTypeDiagnostic: BYAPR02MB4455:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4455;31:/QlwcqPj8NUlIPQsG5hd9geOaCZGDizQ/MlJLHXfaaLZ6p7Kz8vZDgFXgSA+jx0uK2bo2lFF+X+h5v3fS03x8EZIhIW/2OL89NDie6xxdYsCV+hDOmXG3g/sxf4d7TsTeZkAoArH8qtcTIK83lQ6eqX/TbK7QI0hsvfP65MMeyiZC0lrMn0sjsI+BsMZb9oXF5On2ziXm4z7bwhj3aumKQlnJTIFlkaOtBdWpDMg2n4=;20:Ln+/dleVdPh5wgjpoRwXhhhGijI/dxs992cnlJXc3GJAIxMVsBa9kZiGYYJHBjrnNs3VpPWoXl0QCJUEkRittt148qjOQXYzn/PisKHWHSJaV4eyi+2aFUEXoXWbULG57zRViA8YGeTgjCclLl9PIBxrtG++WWJIyKvlPVg5R4hf3NrKHr8fPxpOKrL5fOgsqw0YtujT+UbqP7fxODGVnxWuIhyEVNzIDEDcf+7WsP+H1UtrlUeHmPboFe3lCLYFjDbqYezU4D0jMe33TgNBTUBqs38omcP4uKFXxvfHZqkeioCeQTkj1sFxQCE/hzK/rSrKQLH/qtowSA0cryGKOPhBlXdd/xksDaQ7sMec53zMugYHQ7GycM7yd1PJAwTChmdFNMP7PDNL5MA//aohp1SJiZKkYYWKMlLuuPmyFahd/xPBzvYDXqpx5X2jnI3XgKaKpJRZyyAoH7cjCDs+eG+4akKmKR+BfXX0pwrzn9JtVI0J//NAg+zxOUvOI8yt
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB44558170BBD10413D9C58F60DC420@BYAPR02MB4455.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(3231254)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BYAPR02MB4455;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB4455;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4455;4:CK1JxMNKyF4/0xCJk8ubOyHfx0j9Qxc8kHia164dwrSdowSc1YVSYGz5aLVcRuKyfcfHcSyd0JXj+GonkM6f3K/EwBsm2t8vefVfsnJ5L2kUIfQ3OgN9l7aSRL9yGyIVGYeT5fuayFHHmCpU7xbfmYZljYancn3X4Sw3NzILmUMNFdzV4mH1WAGFsoVxvT9MEN0fsgU5Yh0NvE2NuX/HgzhFjgkAS3jiJAAg5jKU2MeEDMTWlLFGbql0jtJFKxvMCKUVI7a7OVAAwK/Mh7jcAsv5Zv4q3i81Gbi3zA4xWv1Mg+FQcQ5fdxMLAJlHa2aU
X-Forefront-PRVS: 0722981D2A
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB4455;23:Ap7L2WQVrv7ta6NTgIXFdJRmhiVTCigdgcqtU5DPD?=
 =?us-ascii?Q?Nb0F/6ZaWDqOTJ6lyA5B3IpLnmslQGagPmvr6SLj+CBXoL0sZcKOaibPF9yw?=
 =?us-ascii?Q?OSQwzFIKn8WerwKLozm5Oqsz3m6hrURH3bQ5VZIQpTs/2tEkTvr3Vpmcx72d?=
 =?us-ascii?Q?QdkbXgz8qD3dHTnQyj1aaK3dD7ZF1bedD0HMMLOCubwi7SDZe7ZiXkLJFvYO?=
 =?us-ascii?Q?wtj1MyO2j/gw6FCuCRHhfwUWmwQrN0ZBsp6BAhm3TWOvyr3E4KvZ36ryhV39?=
 =?us-ascii?Q?t4S7SGLC9x271CWVMNfOh5FWs1zZqs+yyg4cokDq6WVPzbSLoutTO2zi+XLT?=
 =?us-ascii?Q?cRH64B7QlRtkjd3MzaxqAGBED53nF22Uy8jmhZ0Y8ggFBLoLyLkAp/IojZSW?=
 =?us-ascii?Q?I+X7M4gPkbaqWE3AF66JGGtvRwvBJZEmKAE+NG1SatI5kmIKLT3D0/Oun6/y?=
 =?us-ascii?Q?o8hkrwfkrb7LCaEelm4P2NcWrrWGyWMXSvLBsdQ7WhKmVWqerlqXMNcPGNKc?=
 =?us-ascii?Q?wgGzNEokCa811Gk0Z80QSUCODiENPcmRp9w78OIowDcnp8G+UGuHj2m7A4e9?=
 =?us-ascii?Q?UcQjbeiAgxBxSbBsl/WxXmzAx1d501WgXv6lNIdQ/L6wn1bFy8HAGldYGnhX?=
 =?us-ascii?Q?pJPVj8Nd+N0xTiR3raGtq7FlLT99HPUAWSjz4JRK1mfd7B/pG9NNXXqB7cuK?=
 =?us-ascii?Q?HMbwl7FcfONEmOVwcPZbUEqKNKvC7cS5MY3M318W7R5ivPnLe6R7A2phQCEr?=
 =?us-ascii?Q?yCbFyofRGtA6OY6wszIOz+3uZe/aQ0VFQbMaTRg43R9u+xn7PUCPpFen+g1a?=
 =?us-ascii?Q?HQXmOHnYNZU+wu1822WDNn72sdWaMo68COEt7xFZMi/eWVRnfGdK0VQo9BbX?=
 =?us-ascii?Q?JQKq8u/WrB2qtbM3GAvpg0CDlK0vakqv94qhnbmGLXST8iPWZkeLXtn5RKIq?=
 =?us-ascii?Q?UVylCHu9Gm+N5XgrVPHO1CKbi4io824qSBX6OLViOvHl1Goq+Y4XTHgEsnJX?=
 =?us-ascii?Q?5VSsLt4rPJO3v1EBM/csGZ2du2K1EmkxyuCg1onN1gJDiV1zFdRk9NNTfGjO?=
 =?us-ascii?Q?gJtXGy+FpOLKG2VQkWnb7urGat2/kniifrn6IX0M8gqOcGzkOVHBq14ZqAaF?=
 =?us-ascii?Q?YKkOx+8irk2tovshEvpWd7yQrdJnhn5?=
X-Microsoft-Antispam-Message-Info: yqj/Hu33nKN6ZI7/0C2D6H3FI1m0yIgIHNBDMacn3mBUdiTVkFS5kF0sVxjMGMNuxFJvoZs1E/c5CblUzMrBX0cisQMqK77fzEJEHaNL4pGpUPgKEOa4NVficCga1ftYaIstMWydfvulvlmFG9xdr5JizlO7QOi+CQpb4EKvnYp7ihqLfuyIduyOnGGJLvTH5SFpDH+NMJG/nDWP06Ef2LKxJqcgxdGN7rSKd112Esfb0SpwagwKVLCDUlCWdX/kJKo5sl0hzl4FF1LJmVIP8SFh8QXJ4OtKyDDV0cUVxDQTZhAJ2IWj9ciEoILFO2BQq4bI2359BYsyN+NOHUiERypaxJD/KkWcsuh0Ewj1quA=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4455;6:36qxWoaN2TWGi24HySXN3GNamoJcjmFGGxidDb4oi02h9/g/44W1iivBkCwdgvBnSkTFaxiJ4KJtED38hPnS0nmm9uSkKxBurB2O9YzpdLVBwB1X2MIxW1ahB00uOE+lKrOzmRtYOhovj20XZwqyUF9sA62oJatqq1pFEFRYa/A3FG5koKQp0QM+jakKNLxycneqaRA3njF56nWXUfP/iIOz/jXoQ+vJrQENLJEKMClfqZ4/08ITYvQVmwsUi4N0fT9JYiDVqAWZaf42y4kPFrsfAFT5gBEe5mFECyJXwn7tswAFkFZ5FuAkzhNfoMgReWLmoq2y7hbW2mDsxaOnqrIporMOx1Bscyo+F9EwFOEAYTLLrWcTpUrDd3HtwaDd/yILgB6mJuCxu0EJpRQhruFMZtinyuvxoyCZdr1fU9s5MQJH/A7s1RAa7OGFhapqx2ctjFiw4F3DG/pmRpDQVg==;5:QPTlvXsvq7MVPL/oJhk/AACr+CltCXmya2PW1wXaEvk7V7EbUBf4ra4JOrQNo3fXht66Q3lTxHgoUFtpcYyu6GuHcKDoaeNSAFo7wiVpgui6HOo5pocpMoWaObH5M2B0PAFQM1b6h4MgYGn8mtFBv8vpAvOKv2ZuwbyN/SW+7fQ=;24:EWM6AZJBs3TgTjHWW2WkMephsyj5qieckz9OJS8tP1/AK4r7V6/Si90R2x/8qc1Vv5/HtAiZXb+1bjYZeBSi6QGFQAcpL5uCvlwGUAAUUL4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4455;7:Yt5QHvWWz2WqOFiGsQWRAUq7+TBKKJnXSA6IutcYDZpvevwdp39MCZsCRu5nJLJaa2hOrbHyd9s3+piLYKP1tlH6vIwq9Dp6IGAhOVI5m/VD37bEtfAENd76dqX7Xcopc0esxNE7VnhqI84DkxSHSD6WkqUfjLEs65EJ+Iz3IPvDMPh/dM1GRyZx1qtwwRf2DxxjxcQBd5Aby3Oagir0B49rclRdi3kOyp/BHrubFNkMudW825448iNKox/k8kdz
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2018 08:44:41.7846
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b7eabda-8437-494b-01e2-08d5e0c13848
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4455
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inorder to debug issues with fpga's users would
like to read the fpga configuration information.
This patch adds readback support for fpga configuration data
in the framework through debugfs interface.

Usage:
        cat /sys/kernel/debug/fpga/readback

Signed-off-by: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
---
 drivers/fpga/fpga-mgr.c       | 52 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/fpga/fpga-mgr.h |  6 +++++
 2 files changed, 58 insertions(+)

diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index 9939d2c..7a9fd7c 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -484,6 +484,39 @@ void fpga_mgr_put(struct fpga_manager *mgr)
 }
 EXPORT_SYMBOL_GPL(fpga_mgr_put);
 
+#ifdef CONFIG_DEBUG_FS
+#include <linux/debugfs.h>
+
+static int fpga_mgr_read(struct seq_file *s, void *data)
+{
+	struct fpga_manager *mgr = (struct fpga_manager *)s->private;
+	int ret = 0;
+
+	if (mgr->state != FPGA_MGR_STATE_OPERATING)
+		return -EBUSY;
+
+	/* Read the FPGA configuration data from the fabric */
+	ret = mgr->mops->read(mgr, s);
+	if (ret) {
+		dev_err(&mgr->dev, "Error while reading configuration data from FPGA\n");
+		return ret;
+	}
+
+	return ret;
+}
+
+static int fpga_mgr_read_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, fpga_mgr_read, inode->i_private);
+}
+
+static const struct file_operations fpga_mgr_debugops = {
+	.owner = THIS_MODULE,
+	.open = fpga_mgr_read_open,
+	.read = seq_read,
+};
+#endif
+
 /**
  * fpga_mgr_lock - Lock FPGA manager for exclusive use
  * @mgr:	fpga manager
@@ -581,6 +614,21 @@ int fpga_mgr_register(struct device *dev, const char *name,
 	if (ret)
 		goto error_device;
 
+#ifdef CONFIG_DEBUG_FS
+	mgr->dir = debugfs_create_dir("fpga", NULL);
+	if (!mgr->dir)
+		goto error_device;
+
+	mgr->parent = mgr->dir;
+	mgr->dir = debugfs_create_file("readback", 0644, mgr->parent, mgr,
+				       &fpga_mgr_debugops);
+	if (!mgr->dir) {
+		debugfs_remove_recursive(mgr->parent);
+		mgr->parent = NULL;
+		goto error_device;
+	}
+#endif
+
 	dev_info(&mgr->dev, "%s registered\n", mgr->name);
 
 	return 0;
@@ -604,6 +652,10 @@ void fpga_mgr_unregister(struct device *dev)
 
 	dev_info(&mgr->dev, "%s %s\n", __func__, mgr->name);
 
+#ifdef CONFIG_DEBUG_FS
+	debugfs_remove_recursive(mgr->parent);
+	mgr->parent = NULL;
+#endif
 	/*
 	 * If the low level driver provides a method for putting fpga into
 	 * a desired state upon unregister, do it.
diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
index 3c6de23..6013809 100644
--- a/include/linux/fpga/fpga-mgr.h
+++ b/include/linux/fpga/fpga-mgr.h
@@ -114,6 +114,7 @@ struct fpga_image_info {
  * @write: write count bytes of configuration data to the FPGA
  * @write_sg: write the scatter list of configuration data to the FPGA
  * @write_complete: set FPGA to operating state after writing is done
+ * @read: read FPGA configuration information
  * @fpga_remove: optional: Set FPGA into a specific state during driver remove
  * @groups: optional attribute groups.
  *
@@ -131,6 +132,7 @@ struct fpga_manager_ops {
 	int (*write_sg)(struct fpga_manager *mgr, struct sg_table *sgt);
 	int (*write_complete)(struct fpga_manager *mgr,
 			      struct fpga_image_info *info);
+	int (*read)(struct fpga_manager *mgr, struct seq_file *s);
 	void (*fpga_remove)(struct fpga_manager *mgr);
 	const struct attribute_group **groups;
 };
@@ -151,6 +153,10 @@ struct fpga_manager {
 	enum fpga_mgr_states state;
 	const struct fpga_manager_ops *mops;
 	void *priv;
+#ifdef CONFIG_DEBUG_FS
+	struct dentry *dir;
+	struct dentry *parent;
+#endif
 };
 
 #define to_fpga_manager(d) container_of(d, struct fpga_manager, dev)
-- 
2.7.4

