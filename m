Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52539ECE565
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E38B12146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="jEFYFj9V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E38B12146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729958AbeIRTTO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 15:19:14 -0400
Received: from mail-eopbgr690049.outbound.protection.outlook.com ([40.107.69.49]:5488
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729867AbeIRTTN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 15:19:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WtDbL8pcWMvxS7OjpnYyKrujJV4zcEk85aFjUHna+YE=;
 b=jEFYFj9Vva3kCeXiDlr+hsu0+5pUmUYPPG8xmPkZD81voiuec+ZqEGCiZcqjmf+hl2McLqRW2CeISyn/6KvyYpafRf2RR6PEZbLw5vsWNxMDRjogw3xgJbu8fw1m2wpSoQWqeGzmoSFOQ1ZfM0ZI/FmfPy+iLiTXnsUyo1NUuqM=
Received: from BN7PR02CA0010.namprd02.prod.outlook.com (2603:10b6:408:20::23)
 by BN7PR02MB5106.namprd02.prod.outlook.com (2603:10b6:408:22::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.13; Tue, 18 Sep
 2018 13:46:28 +0000
Received: from SN1NAM02FT033.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::206) by BN7PR02CA0010.outlook.office365.com
 (2603:10b6:408:20::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1143.15 via Frontend
 Transport; Tue, 18 Sep 2018 13:46:28 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT033.mail.protection.outlook.com (10.152.72.133) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1164.13
 via Frontend Transport; Tue, 18 Sep 2018 13:46:27 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:46199 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1g2GKh-0002B9-44; Tue, 18 Sep 2018 06:46:27 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1g2GKb-0002Ap-W7; Tue, 18 Sep 2018 06:46:22 -0700
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8IDkDHD006128;
        Tue, 18 Sep 2018 06:46:14 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1g2GKT-00027Y-8j; Tue, 18 Sep 2018 06:46:13 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 625AB12142C; Tue, 18 Sep 2018 19:16:12 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <ulf.hansson@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <michal.simek@xilinx.com>,
        <adrian.hunter@intel.com>, <manish.narani@xilinx.com>,
        <leoyang.li@nxp.com>, <sudeep.holla@arm.com>, <olof@lixom.net>,
        <amit.kucheria@linaro.org>, <rajanv@xilinx.com>,
        <jollys@xilinx.com>
CC:     <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [RFC PATCH 3/4] mmc: sdhci-of-arasan: Add auto tuning support for ZynqMP platform
Date:   Tue, 18 Sep 2018 19:15:38 +0530
Message-ID: <1537278339-9257-4-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1537278339-9257-1-git-send-email-manish.narani@xilinx.com>
References: <1537278339-9257-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39860400002)(396003)(136003)(376002)(2980300002)(438002)(199004)(189003)(103686004)(36756003)(2906002)(305945005)(356003)(7416002)(50226002)(8676002)(4326008)(8936002)(52956003)(81156014)(81166006)(2201001)(6636002)(6666003)(5660300001)(106466001)(6266002)(47776003)(72206003)(2616005)(126002)(426003)(63266004)(186003)(90966002)(36386004)(26005)(110136005)(54906003)(16586007)(42186006)(217873002)(51416003)(106002)(50466002)(478600001)(446003)(48376002)(44832011)(336012)(11346002)(76176011)(316002)(476003)(486006)(921003)(107986001)(1121003)(5001870100001)(2101003)(83996005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR02MB5106;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT033;1:ugR6k3uVqidgOTS4G9zZI3Q9OZJ0W67pojIEnUB3icR0mKWBaXSbGsoT9lmlu+HSQ/dPoa/CPFDmIngX+fLTenvhFtdjiJINAq5x3OBb6Gb14itwqt0F97RS/twE25yv
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8870cf56-7169-49ac-54f3-08d61d6d221b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BN7PR02MB5106;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5106;3:1H5v9rhQR4AxMfRTkkLQBhoy06cYa4ToZGNw2gX78SQMk5eL4NlozbDujiSaQgc0G4ZeAEPCbhFFkTMumNDAKlK/01RIWV9r5TeyctPlWcUhFlSqhuwZLX6ifKUVGPEEZq46X7szrLtwdfcB/3MMnAsyzdAl/gsLSbIlSauiI4npwuL8rIMTnHBeElFoboSTYmmL4ygfpG8Ldjd6qID7cVk6PrbCVZ9iykGBSVzbZpqBzKA0zxy3eDztc0HmsipxnSIWXSIXC/aDKzlkqQ4xkjWANK4z0bm+owVMcPwbe7En/drbQP1/l5nCL+12+DoZKbNvT3hRlKvrhKrBTZhwFI0bJelFMy4D78yylWnP/eU=;25:rY0j6vITa0OJrRih4F13SVEwdRL5yHbDqs+CTI63ab4g3lDJuQ1HGOUvYn+PpqaB/qr8ojPBRiM9i6o6zBL7y4R2DQ/npwk+TJygp4IEMDltcb46BfD0yntWeJV/fUj2GLHcWqI4hdh88STcV4FesBRrWbpnFc31iHOt5zuMxhfD6RwgYZ0hc8dM2bqrQ3KKnDHiPOpTJ/RWmN17ErVDs/eYfjB4yhOTjvY6wbEbg7Pbb/L4YNXec6SwnPcnn9A9juYsOVroOtcdjBHuei5KPVUB9XyXJ4R9jtWMDP/Lk2jOyDFyR75ZJeQHgOOcRuM4x404z3viZrg+Z8ESXGtDCw==
X-MS-TrafficTypeDiagnostic: BN7PR02MB5106:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5106;31:7Vd/LNWIo6V1Q9AGl4PO3J9iyKqGUlFZEnCqHpl91DbFjaMUcgKdz/XeeV2isRz+f/xGu4BWT6OZf72inzOqvdX16NnVvbzSlT2fON5Uk1YJZ0y/Dt03qlynIcCt8NJe8wxl1c7E4baIUIuvoz5DLFo/ADHigYFeppV9jB7jUF8vkxr8uzv1f80J6oMPH1YzN+9+qqC0aSOsEZv2yoG3qEMzFE9Cf9PWDa3+j4+H06Y=;20:5LI1RRfgEvCMZQdZGOOVozI2dpfekqfKUM7gyK4IZco/62p38p0OfueiWhdd9SJLCms/2q2qcusQtoLfoX1fVP1cjIwMjzgkk2p/gj3LY9iEZihk1b8ZsGfrbBBX/q7XDihPK59hcGtdjyHSvM3t3hYoIkC2G6EWrn2E1bStk3NoEiQTBtUyL4vr03kNyNtXsCKWw8he+Pafv13forvBIZK+e8QYCINUc4qIPXNFJ6CrLU8RTuRl7Q/hzlFjQQysPF+rFxHc01ENgazLVZ9tpevzLIsKMR0IS1joWE28lP8CJnvfKRDKrTtHEY1fi95LlmFbh5ABFLSebVSK0qq7yOeTalmDEeBKPIHEKmwqoRUh/nY1vVOICBm4kCxW0m3YiKINMz3wepcxuEvfjr7lEGbiv0lR03P4RMTlSBIWLoDW1GTNiwNMfJsY5wwiIZ4uQ1F+2ptwleyIbdaYP9ijhlkCgE2X/dD22J4Heb2iiaa+0E9WMv22qNJriwC+Q+Dh
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BN7PR02MB5106FA72C5E9944522CC07A6C11D0@BN7PR02MB5106.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(93006095)(93004095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050);SRVR:BN7PR02MB5106;BCL:0;PCL:0;RULEID:;SRVR:BN7PR02MB5106;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5106;4:Ckq8lkVj5FilWv4ALrEfglVqL/pY43jkikfL388XNzBW8mAcbcsA3l6vhNEPQJfEyY0z8sYuINJPpxVNjUj2VWFWvjBttA2pQcYY+MHS6Vbzsb1VKqj9dxOw+L//XWN2yugpLWx773HfVVLPeI/lsduWt6bhzpjdP+KgWQBq/oe3KF24Xm0bWiGcGYaCqw9m+4gp2Da5LSZrN1wAyo39Sd6pkltbZ/otW5juGPrJoYKKN/FK7oV5p10yh6rHESsUzRKX8F6dpHNINBptqYZ44WlG9ABiCoOKe+oFvVDXO35kHXXtsLAoWCNvuMOBgLhk
X-Forefront-PRVS: 0799B1B2D7
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR02MB5106;23:PgSMHBrSFL/1xuAJzF4KqA5B1XDg6Uk8m2shft+qd?=
 =?us-ascii?Q?62w0YUy04T3nkt/dEVNu4Jd6u1C/GSWhRdf+ITwFFXASzyJZAt8UDC3SCg48?=
 =?us-ascii?Q?Q98cUST4TT7wVJuytmAYaYUnGvGx2y7hOI2id4BLq+l00RKH6He4qfpeWooG?=
 =?us-ascii?Q?KX1uZs8yG7CBzglvo3u0/FHteG6iSawFJhK3hZ6jKFoP+JoEQHTj1zir3o4k?=
 =?us-ascii?Q?2tk177B+Fs1mL6dCnhxxGYrRzQDf1hlC+I7qxm66sh99kv90G8vR6AoqLztS?=
 =?us-ascii?Q?Y6+WWWWIegTcpOmZIoXuk6CkcQR9ngYiBzaN7hoUNmsh9YiC3lKlPgM6clOr?=
 =?us-ascii?Q?2W243GXayd/docZtCcmAD+HO3ks9gUGoNwr27DlcMlWsOHrWrr5IN0D8++5W?=
 =?us-ascii?Q?M3s0IjMcS75yV6sT+FdGBWiY+KybWaSs1QiU1EmfcU2YFbRFUkc4VLl0ywCV?=
 =?us-ascii?Q?aTSv21S793ICffqlXkFMnwWZKYM+cd0CyZziqpIrvUYsv3OQ/SG/xVkqRqur?=
 =?us-ascii?Q?JLNMQxIF5K81K1Dd2FizA7q7lKMbSYJELBRHoTt4Hwm6ziRuNMXtms6y/XYQ?=
 =?us-ascii?Q?2XcsSzRFafWvjSuQNJlNMc4mxuAnBoGjyCl6CSrc1KrR6UUk90mbZInhC9ce?=
 =?us-ascii?Q?cTp2T9LkJKr0XwZ70Q07wHEiRGI5b7KOQs4AycF9xacTwChWcIhtyi6tFhuf?=
 =?us-ascii?Q?uFyijOIovX6X6J/mnHZDGpnV3cXViVv+vz1RVK2+LTeYh7NHU2LLtOSUju/S?=
 =?us-ascii?Q?8iFdgh/4h6KkCqwzHigfSHeW7mPDHNeocVfZAvCPx5YMfLHJTojns6lMVUdR?=
 =?us-ascii?Q?gjzsO5ek6nuK8dFEeoKQ0CZHMCJ6/t8Jka00xuVFKU79BhwjjRQf+58y9Ojq?=
 =?us-ascii?Q?UZdmZHNXtuw+mCGrIT3XVFt/orCJBym62voqHNJMQZbpbNn+/sMt53l+yeIg?=
 =?us-ascii?Q?rUlWA/S9UbdQ2A6HXy/y+0BDVkpyRQjUmp23I8h9hsLGuRec4Ly2pfcQwyel?=
 =?us-ascii?Q?Fs4CnIdD0fokuVxA9QR/VGBNvtRaZJP8hhIWDu0hbhv0A5nIfheKP/CZhhnF?=
 =?us-ascii?Q?4drRBtmFDVzbd1bTUvPfcJ/bsjLasnk0PEA6GI3rtpRkhbJ9kHpup6iZWFkY?=
 =?us-ascii?Q?fr7kNKiAJtWmGwaOW2/G9vSuz6M3sX/peJY9viYmm1fYy/JKyO3I4uuDCYwb?=
 =?us-ascii?Q?F1TWQU/tCpSFwZcvJmHXd4r/jdwZ8s2g8wPV/Un7RfjgA7AXynNOeTk86982?=
 =?us-ascii?Q?vuSil9WhsMzw29WHRB8NplWPf46ccEIULHp00i8Z0rmNJPBA/HpF8z3oggBx?=
 =?us-ascii?Q?mmgFNQJSbo67IoN+pqz05HiG1l9BB3v7qyVcZ8kKiTJYMxugKi4cVfdlL9qp?=
 =?us-ascii?Q?GRMXA=3D=3D?=
X-Microsoft-Antispam-Message-Info: 8ubkBL4gXeK6YwWOdVM8NYKowN5pzTqNEJVKjeEImIcnv6UbRJZ0L6diYoy8CjoSfN83d6bMVwp9d5+pW8hVQLOHyjojyjXxdDFlwSu8WOEbDqrCnYd8+SWQqw+4zyZPBKyigUjgDl6L4QnfHJKg4WfyQ+dHDcjxE3aoZS6NpPCmFVwrlprah55rkpNlQUTQH+U+jahvUvVM4M4RU9PcpG8U/s2D1RWMubTSFenXkziiTIfyT5JyH3FIT8plNWT/cnQUMybrMu0UyA8GICQfjFvFh1P0dudbdd2sySv+tnxnUUQxu/DjEXSk6yXvV6vtkvj/bXgQJbcHYUFuVpy78OwGhzCejNWODqo3VpmQ+6E=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5106;6:PLd1/ouTIODE2RrvVrXq4Tsc5s1AmNVPWxkLwTbtR+gauG8JH8YpFOAdsNM89CEfgS7lBiotCmJN2ACrZ+dAlLUl8VWqBf6Z5dUfGtujjBW1wJGLCiniFIHhj3WOq7JQS7A4tZHabttraud45TfpeZFB3IAQ8b8wN7OYMkMRRU0oVUW6Zke+MbA00rj3vQFcuVVD4xfwl850jkxJekVUxicZfICPdNtqX/e3XAJh0Tq4fl0+vJmYmPWQNzq/BWbN6ZU2iIEtjxsOeCM1Kht/ejA9oP+e8MTI2RzT9S7Dgxp8K7chVqz4JhmyVi+be5GrDxgC7M0GDbbLL2G+CqPYpXXGXH/L7jXNmhwDJjDBE8ufpk2p/IXXX+Eg6p4F3vjeCS2TVnOuH49DcngOGLw9vuLsbKuVFd6PH1tGnWWPPSCFD0GXdWV0Qc3a/7mkKx0gyX45PydJVK2B36ERWMh7pA==;5:ZqPTwY8rxUHkkRR3CzFkUBj2ANFiuD3XjQM65KmEiI7/8nf8d5V06qeQFMzVwXRMFfX7q5zUc/+6DNZ4ewW999lKRi7SgsF3hirPvYA6VHKvAAQMG5P10xNqaIOZma8+siwbR/ePDjxsju3grNmSjEI9qk+f9H8+3pOAH/Kc/Eo=;7:ioeLglo10hL3h6zSz8c9f/KLFTObkbYM1rmJr/xmTt3U2GeE6XpndLcizqd7euLj5bON6nH+JUHj1TSu7oN74HmqLZsMtY75Xg34bc94PwtP5Xt70NUUPGgXe346YXHo0UuZuTT1N9mKfw/owl1WY+Z8QBYA1U2LBhrwPr4HwVj/38k073VS804Kmuv4ZSrHmcxDLiG2UeBHYDycuO+cYbv8yP/c6bK+PyOBCyVfZSQ5BdmTvc4+518bkQWF4r5q
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2018 13:46:27.5048
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8870cf56-7169-49ac-54f3-08d61d6d221b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB5106
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support of SD auto tuning for ZynqMP platform. Before tuning
execution, reset the DLL and after the auto tuning process gets
completed, reset the DLL to load the newly obtained SDHC tuned tap
value.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/mmc/host/sdhci-of-arasan.c | 83 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index a40bcc2..1a8bbd2 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -26,6 +26,7 @@
 #include <linux/phy/phy.h>
 #include <linux/regmap.h>
 #include <linux/of.h>
+#include <linux/firmware/xlnx-zynqmp.h>
 
 #include "cqhci.h"
 #include "sdhci-pltfm.h"
@@ -98,6 +99,7 @@ struct sdhci_arasan_data {
 
 	struct regmap	*soc_ctl_base;
 	const struct sdhci_arasan_soc_ctl_map *soc_ctl_map;
+	unsigned int	device_id;
 	unsigned int	quirks; /* Arasan deviations from spec */
 
 /* Controller does not have CD wired and will not function normally without */
@@ -163,6 +165,72 @@ static int sdhci_arasan_syscon_write(struct sdhci_host *host,
 	return ret;
 }
 
+static void zynqmp_dll_reset(u8 deviceid)
+{
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	if (!eemi_ops || !eemi_ops->ioctl)
+		return;
+
+	/* Issue DLL Reset */
+	if (deviceid == 0)
+		eemi_ops->ioctl(NODE_SD_0, IOCTL_SD_DLL_RESET,
+				PM_DLL_RESET_PULSE, 0, NULL);
+	else
+		eemi_ops->ioctl(NODE_SD_1, IOCTL_SD_DLL_RESET,
+				PM_DLL_RESET_PULSE, 0, NULL);
+}
+
+static void arasan_zynqmp_dll_reset(struct sdhci_host *host, u8 deviceid)
+{
+	u16 clk;
+	unsigned long timeout;
+
+	clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+	clk &= ~(SDHCI_CLOCK_CARD_EN | SDHCI_CLOCK_INT_EN);
+	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+
+	/* Issue DLL Reset */
+	zynqmp_dll_reset(deviceid);
+
+	clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+	clk |= SDHCI_CLOCK_INT_EN;
+	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+
+	/* Wait max 20 ms */
+	timeout = 20;
+	while (!((clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL))
+				& SDHCI_CLOCK_INT_STABLE)) {
+		if (timeout == 0) {
+			dev_err(mmc_dev(host->mmc),
+				": Internal clock never stabilised.\n");
+			return;
+		}
+		timeout--;
+		mdelay(1);
+	}
+
+	clk |= SDHCI_CLOCK_CARD_EN;
+	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+}
+
+static int arasan_zynqmp_execute_tuning(struct mmc_host *mmc, u32 opcode) {
+	struct sdhci_host *host = mmc_priv(mmc);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
+	int err;
+
+	arasan_zynqmp_dll_reset(host, sdhci_arasan->device_id);
+
+	err = sdhci_execute_tuning(mmc, opcode);
+	if (err)
+		return err;
+
+	arasan_zynqmp_dll_reset(host, sdhci_arasan->device_id);
+
+	return 0;
+}
+
 static void sdhci_arasan_set_clock(struct sdhci_host *host, unsigned int clock)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -469,6 +537,7 @@ static const struct of_device_id sdhci_arasan_of_match[] = {
 	{ .compatible = "arasan,sdhci-8.9a" },
 	{ .compatible = "arasan,sdhci-5.1" },
 	{ .compatible = "arasan,sdhci-4.9a" },
+	{ .compatible = "xlnx,zynqmp-8.9a" },
 
 	{ /* sentinel */ }
 };
@@ -792,6 +861,20 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 		goto unreg_clk;
 	}
 
+	if (of_device_is_compatible(pdev->dev.of_node, "xlnx,zynqmp-8.9a")) {
+		ret = of_property_read_u32(pdev->dev.of_node,
+					   "xlnx,device_id",
+					   &sdhci_arasan->device_id);
+		if (ret < 0) {
+			dev_err(&pdev->dev,
+				"\"xlnx,device_id \" property is missing.\n");
+			goto unreg_clk;
+		}
+
+		host->mmc_host_ops.execute_tuning =
+			arasan_zynqmp_execute_tuning;
+	}
+
 	sdhci_arasan->phy = ERR_PTR(-ENODEV);
 	if (of_device_is_compatible(pdev->dev.of_node,
 				    "arasan,sdhci-5.1")) {
-- 
2.1.1

