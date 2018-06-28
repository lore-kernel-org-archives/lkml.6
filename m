Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5EECC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 13:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 504F927416
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 13:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="j6llUeP/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 504F927416
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966194AbeF1NO0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 09:14:26 -0400
Received: from mail-eopbgr690040.outbound.protection.outlook.com ([40.107.69.40]:14656
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965388AbeF1NMH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 09:12:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kInR19grd0yYewjWCULP428xtVZl23WGktmMZqP0Beg=;
 b=j6llUeP/2a2duGMqKijFWHHRfw8l3pi0bL6tOukqnRJjb4iJeqXbG1VEY8RiUxnl8C5tC1RQI+BSddY6FxgAyFtNxA+iaKJlBFUvV/F1eAbRNVdZ1uiRQxlS9yUNq/ZCK853yiiX+G5Lu22/zIlQ0DEwjYxFxVK/4t5foYKqmdU=
Received: from SN6PR02CA0026.namprd02.prod.outlook.com (2603:10b6:805:a2::39)
 by BLUPR02MB163.namprd02.prod.outlook.com (2a01:111:e400:849::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.906.21; Thu, 28
 Jun 2018 13:12:04 +0000
Received: from CY1NAM02FT043.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::203) by SN6PR02CA0026.outlook.office365.com
 (2603:10b6:805:a2::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.863.17 via Frontend
 Transport; Thu, 28 Jun 2018 13:12:04 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT043.mail.protection.outlook.com (10.152.74.182) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.906.15
 via Frontend Transport; Thu, 28 Jun 2018 13:12:03 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1fYWiQ-0006cQ-PS; Thu, 28 Jun 2018 06:12:02 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1fYWiL-0001yd-MW; Thu, 28 Jun 2018 06:11:57 -0700
Received: from xsj-pvapsmtp01 (smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w5SDBskr027434;
        Thu, 28 Jun 2018 06:11:54 -0700
Received: from [172.23.37.80] (helo=xhd-paegbuild40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radheys@xilinx.com>)
        id 1fYWiH-0001xq-Ut; Thu, 28 Jun 2018 06:11:54 -0700
Received: by xhd-paegbuild40.xilinx.com (Postfix, from userid 13245)
        id 20A30B208A9; Thu, 28 Jun 2018 18:41:53 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     <davem@davemloft.net>, <michal.simek@xilinx.com>,
        <radhey.shyam.pandey@xilinx.com>, <joe@perches.com>,
        <andrew@lunn.ch>
CC:     <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 net-next 2/5] net: emaclite: Simplify if-else statements
Date:   Thu, 28 Jun 2018 18:41:47 +0530
Message-ID: <1530191510-10310-3-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.4.4
In-Reply-To: <1530191510-10310-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1530191510-10310-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(396003)(39860400002)(2980300002)(438002)(189003)(199004)(106002)(103686004)(50226002)(446003)(26005)(6666003)(186003)(4326008)(36386004)(106466001)(11346002)(47776003)(2616005)(2201001)(90966002)(2906002)(126002)(6266002)(52956003)(476003)(5660300001)(486006)(356003)(305945005)(51416003)(336012)(50466002)(76176011)(14444005)(8676002)(478600001)(36756003)(426003)(48376002)(16586007)(54906003)(81156014)(316002)(8936002)(81166006)(42186006)(63266004)(110136005)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR02MB163;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT043;1:vYMgOUXvZN3LvgnvT2f/QnOxipFK2CmCWrtIwYdJ/9624h6Lb4bv0Xji4aYnWghQ3q79ZWx9NyC7f75dhnXVS32YBVtdPFELKE6myCcoyWHBmFod8k/x187tylq50OqX
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0bc447e3-b217-483f-8e0c-08d5dcf8bdc1
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(4608076)(2017052603328)(7153060);SRVR:BLUPR02MB163;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB163;3:Zpae5itjYdveRu7pZ+muRvc4eKOv06Fgx5ooJ4uA3EesZw/gNbPSRj36tUpBPm0oixvpwY3olWr8MxgNuIE/rG4LXsysc2YgEoAkINtZL/CaEBUTVXg5l+WenZ8mpibKNLJZhS22h7nYZjeTgBFi+/Wd/2Rv3Q2xToX/SRY48nldtZ3DKCh52WUBMfEvB4XGgNyhpw4toXppfB8slFYGROWmsSAfIH0u3AtC737S2XCdpSMkQI7VhtQEOgbCz2U62tcXbpSkzS7e/acSc5IdF+ADcN0tTLOCIzijRB1Hfsy6ThRlLYwfRVErawrAxVdiYK0YeoRzbj6wy0UKRiSQzfFPseozscovq++hKjPlWtI=;25:3V4ZCGoxaaJkMiOTz8nwNOm7i/B0liiXEdrHuis7rJZSgBlmFU09UQTUuQnFmlEn5A0Pf0hqCuWBGE1w+fPnvBn5ZCpdz9sdxWWCZ8xnyEas/WJ+Ls7wSj6EMpgNgoiwyXeSJMQjIGTl0m7oPMeyj4314/qKzwXRiO1Op5NBHrxyiACg/pnA3QmEAL/4k2h3UxSzeon4uaNaJ2aAdhampzn7Nng4KXNbNQFjiXI4MKrxsSfNbyt/zHHvW6KpIxxDGahg6RYfBb1yOhcjlpaxQqapniXLVAvBGsJ3rL0l11tDi1IBhOOxHVjcff2EXyjwjGfz7uXSdbf8w31zCekjKg==
X-MS-TrafficTypeDiagnostic: BLUPR02MB163:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB163;31:pZLCvFHrUDPTE8QDRFhBiZ+9bJQDJBJy2KabpHU/P+DIKtzeaGea7VM9i+is2A/T1s6skAk7jlZl5oSOm+s9LtPPtG3YglPOfUJYYKiJd4I8QXuy5atDLA47AbX+6WwHeVmVFZ/s2W5EqR9k5XevQry3NDfvTmyW+D1EMwiGBdGxC4Ebc7SfIrpWHImJQxWkG4ZpS9Ug8GwVZ3lK/0qYrkCAixay2n4sXy5rJykDaOE=;20:6QBxLSLT6lqI2axxxLaWyRwmbHLOLLv9S8eMhjnFDBfonyZEarDLoNvE+G/IH4gLQYq6ZEOD1ciR23wrvYOgqKfEWj7XAUNdjmjb+fqGAFrvLlRQzdu7YPKg1HuhlsTu7nrhb9oJn8L2yHNQFVqtKCMaWN+EBvVJP1wPkk6B/12j7V6WyU8k08n2cy/c2EKMxRicL8bBoZDPQ0nTQZBV0zJktQPx/HvOcznCF+R6+C2inP0vAcxeCElfgVAH+zsVhcJezpwSByETlCSzEWqkVALFLT8LzbxrHzNUgk9HbcRvbOTWZENuijVzQli552w7WzYOXF6PHl1NS8LGIff9dht5UIsYxXBgpkhtlTr7iozPnKMzW3enr5sZ38UephOjEGbesw/XN9yq6bozBcArfCAdijUlZss0r0adX30sKAs+LyTPwsneW+xgytcp+fzhmlH6pyhmbxSt0NDPgjNIw07OXMLaV9hqPWqVhRRV12JFbxGxsPXAMyouajnZu3ip
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BLUPR02MB163EF2AC74FF84E2B01E63CC74F0@BLUPR02MB163.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93004095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BLUPR02MB163;BCL:0;PCL:0;RULEID:;SRVR:BLUPR02MB163;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB163;4:m5cz4jPkNDEow2oXI1DOyijPNU2KjR6aEFXbeyAor3X52nzrAE5D23gkNP+TW1TssSkvOFeUjwyxxITeyAWdfbna/3j39WW82etZ0a+O/A6kkvaU3beDjJlIxYlBv1K8vPmubHTXvyySCRXSlMGTIXqDBSfs8XHIoWIEThaFZZkCn95QUbmmeWXWBiE98uCyYGMmGbTPSvX5OekLxJoHkS0QbS9IddaWJLbRXX1S93fM/Cpo2FRjYJafDXOvFFL/z3ehU4Y+M9neGUs2pEFUV/4bAdjOiWNHnbFVfWuTkCZrZmYeBXQXYvQtxELAvR69
X-Forefront-PRVS: 0717E25089
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR02MB163;23:CFbBOwoqzaaTkSzOXjdYjkKp98saAiQGyLT4+BpdJG?=
 =?us-ascii?Q?9hTrnm1DgtLEjbfjTMlaN3T10pKjq9ABQo8SHP/Bq7Liatm89a3cEu1bE6Vf?=
 =?us-ascii?Q?AqP+0GO1mmmjmQp53yORsABSnwBGALW2CjcR436tsr2xqpxIIE/bo6WHE+Oy?=
 =?us-ascii?Q?lTRJn6NzgzAbat7rwcigVPgxX9AC2cLoTuXvqPsZQcAJ5AlUYH8AyTSJVwpy?=
 =?us-ascii?Q?Y4oABwqFyOhdeGVKQX8t4dZYDaNEdxT+FryVHsx3XGGnGIEhs1eOMkRhRM+6?=
 =?us-ascii?Q?teJMna1CT/I55lRJE8QbNJyGrz6yyXwubvBhD4p4L01TYHQz/3dc3PqwYn9J?=
 =?us-ascii?Q?R9fk1P38pyrYfp766ygaBtiBzglFaMEZcnpcR7irzXVEFDocVObJyhMYJOk1?=
 =?us-ascii?Q?Fqn+o4Ns2H2zG+CgdqXTjBoHstwPUCgY1ZiZ4lE2Suq5Rm+S48QQL+NCiR5E?=
 =?us-ascii?Q?v8k/9Y0gc4GHXVWq1hZa0wjGABAr8nEJPH89hbSVvjtzBYVlM5g/I8sA+2eg?=
 =?us-ascii?Q?qzZZEBZN8W+WeRGEGwoG/s4SMs7xbsOmrbve2SvAf8CiQiYDGp6cyJhzeOA3?=
 =?us-ascii?Q?URcNZ4avRmz2ENP8MH0wiQjDA19jpQL/G9Py4KvLB63Gysaw3+Ov4B81L2Fe?=
 =?us-ascii?Q?dSgp8FvSNzPWWfOkj5v8CNr5hdM5QxOWn0tC230/ReUHEe4AuODfx4/DCefV?=
 =?us-ascii?Q?uSXfkSwDAbdBixnZFAPq+3RvQuwUys3/69TsCBVtUipvfjKeutBqCwyeLE+I?=
 =?us-ascii?Q?N1yT24Ji5vHlBrz06eNszLzCHF/G3EtrrIz9MeY6SEqE9ZA9ZQ/c2dJehiKV?=
 =?us-ascii?Q?Qg1sxJunZmNr2UuvtlGe+sMUHzJH+QjuxnViOJB20AmJkKpxejJu17R1W4vx?=
 =?us-ascii?Q?owIcme3ji5g5a0pwkiy444bmCcpi9Ti44YCX7o7o0ZADDQzGOFtZh9Bht5vs?=
 =?us-ascii?Q?uT+Cc6SAkJt3C6x6CfNJ32/9gl09oR/yJiReePaSnerNHtQV8Ms09Po7JsdT?=
 =?us-ascii?Q?ONjFyWO875EHG+WleXXGzJEqkv+NAcGpgodw8e/d+s/7MFpamGoPJynokUQC?=
 =?us-ascii?Q?An8pafw5OtrlTz6qpXyOod14S5mCFHdS7G0hlsRa9plYn9HlghavakjsgYWt?=
 =?us-ascii?Q?fhdsJl2q7pJmCccjsbaFfFxEz3U4mZ4kWK5glFcYr+Bx4klucuOw=3D=3D?=
X-Microsoft-Antispam-Message-Info: WlAaiVJX2a9ZhseVGTcsGifi+YsXHWcYFMUywH29SkXk1/EXAkla3DfKEiB2hEN4a7rjU/XW8UUlKJQKC/g0GRqXKhWqDg+LCPI306YvWZOltPLZYbml+q7PjUvSb/k1WXaYU2bC3XJV2sr16aFSDljNr1yXamDkGaqpS2iBL+EY8ffNIyecChuH0DMByaAMAhhkRheCvR56Am7Qeng2cCHK3zRHjXqMGvndDG8NyRM+1OULXMye4n8bNqYIJfxvIuLwFIStWocKUrhIOQXR/06rzf03fZ5ovYCteOcpyfDmIgANnPK5Wf56aRB6cllTpS9T8tpvkjPwsYsVV8dZ4juNSBuKZz4UzkHsgXhskJA=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB163;6:zuu0xNMbGMuK+CP2jvqiDlL/A3gcuwUkvlQqxznZeP92dkTpZ7bHmAQ9GKlNS34AlvSDv3H/IeyBS2PnR4wvfe5QdltUL0tEjpm7Sxkg5xT/Uw4bN+ikskOOO0iswwcfpY2wXrl7Fnhokrs+jAk4RCvUmd53sAUt7JXKpRRpJH3NUnL9Dn0cqSkMYjrOfOb5vBgfVu7zt35tozArKUv3Qp38d76X6nJUCfSaqo0UcM8xHuk3OfvaxNAvu3x/pkxt4Y3BS2rFdWWwu2aZMomQ70Fy3YadANNF1uNKcCe/XXEHQZzMI6/t+SeEIfrfAx5khYavFFKs/PUXbLDX7Wab/WDV1SWJhAY6Ox/4kdfflFyXExajIkmYOCd+qS2hseEfaZjtsHWl49u5CnQv3fVDNumm7jdvPiufvblvAYRvKj2CWv/NxlftjIhrBPgJhIJ+DnuIiCQJ2rM0N7W0uaFggw==;5:PoqKkKU+Vzh9bGfKpllPGA7nTngHYkl/ahP3S327DiZ3NWhfrTabh8MgYNlizTPvPIQRdgX/zxR9E9iyxKB6wmUyTu1kHki7wpWvR2T00e0qcjEdiCunOmYoZcUTIWbLipOQyY7A9b01KcwOhlUlX02We2fILv2QVo7IP3kyT78=;24:fBr0BuqimwqRfB7KV79NMgLDhDEUp36Jqd0Ujyb2rdpMBw1WOcL3LG0RG+qecGuatHT/aAGM0/BfK6ITG1uZwvLjGegnXUcQ5YC9OXvxVto=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB163;7:KTlaGZgEuW5RzKp1PEBVlV0OKoPvww+uRM6IPIrDLW8A0n64JLZ7xbtKhzGCuuXYi1rWJeFzRwTgQxaMV4r6dPa0YQA9Flu4EPhnvCpq9DKTk3/XnHfZyftXSmR2eUdqV+pQuJtdZB8XpLP9Ak8jOhP0i0x47J+bMTPHWZv/kSQZ3at4/8I3TPJCW1SXLHT7hf5HOPhIy5woEMXTTVxo0cvapz0UA8dZdXm0E15YXqEX86qgoFQhbnkrLls+U7T5
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2018 13:12:03.2621
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bc447e3-b217-483f-8e0c-08d5dcf8bdc1
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR02MB163
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove else as it is not required with if doing a return.
It also coalesce the format onto a single line and add the
missing space after the comma. Fixes below checkpatch warning-

WARNING: else is not generally useful after a break or return

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
Changes from v2:
	- Refactor to make failure path return early as suggested
	  by Joe Perches <joe@perches.com>
	- Coalesce the format onto a single line as suggested by
	  by Joe Perches <joe@perches.com>
---
 drivers/net/ethernet/xilinx/xilinx_emaclite.c |   34 +++++++++++-------------
 1 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_emaclite.c b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
index 0544134..b2c7afe 100644
--- a/drivers/net/ethernet/xilinx/xilinx_emaclite.c
+++ b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
@@ -564,19 +564,18 @@ static void xemaclite_tx_handler(struct net_device *dev)
 	struct net_local *lp = netdev_priv(dev);
 
 	dev->stats.tx_packets++;
-	if (lp->deferred_skb) {
-		if (xemaclite_send_data(lp,
-					(u8 *) lp->deferred_skb->data,
-					lp->deferred_skb->len) != 0)
-			return;
-		else {
-			dev->stats.tx_bytes += lp->deferred_skb->len;
-			dev_kfree_skb_irq(lp->deferred_skb);
-			lp->deferred_skb = NULL;
-			netif_trans_update(dev); /* prevent tx timeout */
-			netif_wake_queue(dev);
-		}
-	}
+	if (!lp->deferred_skb)
+		return;
+
+	if (xemaclite_send_data(lp, (u8 *) lp->deferred_skb->data,
+				lp->deferred_skb->len))
+		return;
+
+	dev->stats.tx_bytes += lp->deferred_skb->len;
+	dev_kfree_skb_irq(lp->deferred_skb);
+	lp->deferred_skb = NULL;
+	netif_trans_update(dev); /* prevent tx timeout */
+	netif_wake_queue(dev);
 }
 
 /**
@@ -1052,13 +1051,12 @@ static bool get_bool(struct platform_device *ofdev, const char *s)
 {
 	u32 *p = (u32 *)of_get_property(ofdev->dev.of_node, s, NULL);
 
-	if (p) {
-		return (bool)*p;
-	} else {
-		dev_warn(&ofdev->dev, "Parameter %s not found,"
-			"defaulting to false\n", s);
+	if (!p) {
+		dev_warn(&ofdev->dev, "Parameter %s not found, defaulting to false\n", s);
 		return false;
 	}
+
+	return (bool)*p;
 }
 
 static const struct net_device_ops xemaclite_netdev_ops;
-- 
1.7.1

