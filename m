Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B2CC28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 13:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA4C02098A
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 13:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="ImJwcrbs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA4C02098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbeJMUxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 16:53:17 -0400
Received: from mail-eopbgr680048.outbound.protection.outlook.com ([40.107.68.48]:5096
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726292AbeJMUwg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 16:52:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X8gXjybF9RNvKBv2HMFTL/dscQJuoX30GOc5BO55GWo=;
 b=ImJwcrbsDPv2LDCmGU6Y/iDDc8dN/EMqTBQIzzdB1JmvQ2KoGbkwGBbqT71QIFlag7+vVNUhZTOSvdRlTilgYHxDGb08taR1P8WDDcnif0Sher90zE0A30Tuz8enX0/ZpBk3jONehv/dRm+hFt930OcmJmUBfMHgxLEIXTvDTEU=
Received: from BYAPR02CA0014.namprd02.prod.outlook.com (2603:10b6:a02:ee::27)
 by DM6PR02MB4457.namprd02.prod.outlook.com (2603:10b6:5:29::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1228.24; Sat, 13 Oct
 2018 13:15:22 +0000
Received: from SN1NAM02FT015.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::203) by BYAPR02CA0014.outlook.office365.com
 (2603:10b6:a02:ee::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1228.24 via Frontend
 Transport; Sat, 13 Oct 2018 13:15:21 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT015.mail.protection.outlook.com (10.152.72.109) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1250.11
 via Frontend Transport; Sat, 13 Oct 2018 13:15:20 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1gBJlH-00068g-Bt; Sat, 13 Oct 2018 06:15:19 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1gBJlC-0007wb-7S; Sat, 13 Oct 2018 06:15:14 -0700
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w9DDF4om026380;
        Sat, 13 Oct 2018 06:15:05 -0700
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1gBJl2-0007np-7E; Sat, 13 Oct 2018 06:15:04 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id A3413604A3; Sat, 13 Oct 2018 18:45:02 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Johan Hovold <johan@kernel.org>,
        Jaejoong Kim <climbbb.kim@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Roger Quadros <rogerq@ti.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <v.anuragkumar@gmail.com>, Thinh Nguyen <thinhn@synopsys.com>,
        Tejas Joglekar <tejas.joglekar@synopsys.com>,
        Ajay Yugalkishore Pandey <APANDEY@xilinx.com>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH V6 01/10] usb: gadget: udc: Add timer for stream capable endpoints
Date:   Sat, 13 Oct 2018 18:44:48 +0530
Message-ID: <1539436498-24892-2-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1539436498-24892-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
References: <1539436498-24892-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(396003)(39860400002)(2980300002)(438002)(199004)(189003)(76176011)(48376002)(51416003)(81166006)(14444005)(356004)(106002)(5660300001)(36756003)(54906003)(42186006)(81156014)(486006)(36386004)(107886003)(426003)(90966002)(2616005)(39060400002)(110136005)(2906002)(16586007)(316002)(11346002)(446003)(7416002)(6666004)(8676002)(551934003)(476003)(126002)(2171002)(6266002)(52956003)(50226002)(4326008)(63266004)(336012)(186003)(106466001)(305945005)(8936002)(50466002)(47776003)(478600001)(103686004)(26005)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4457;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT015;1:i7ah8hMV0WwQBtuTolNJUxggNtgZd4M59kgS8KKtHBYVEipTl+s9dR7m07rkjbhfY3ijpkO0RlyKrr/uSJGg/Mz0LY1tjFRVkus7WqmYkagzt9T7sTG7da18N4RN7tIN
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8222ea8-ae99-47e6-70fa-08d6310dedba
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:DM6PR02MB4457;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4457;3:JnZAAFzkaUC+aBnj+Rm25O7F4GYkOu6prW1GNgff/5QMkfytI7SUACdMXuXvP3mL1T7dqmC3TbAF2kOUg8BMtGv+SNE3CfjN3UJXDboJoTmtIeYH8htQ+gq0Sw7/ZjkIJzEgM0VMnd5sMUI0/b4cHXalVPz4FME3woOPNE9VWsqy13vNXAAwQLNHh4RFpzLOjxqTGvN4t9aBZWFBWnOToQpxXuEHykpKZPjUiRcjE1c1Uq1u0omoLlQHriSvylQSfmH33xrYk+2rltSNlkkcqDhfY7N7K0nAnfLczgU8MDiXspXYdDsv3RAT9YBQNHcH+EOQgzumu43UjiFwepO3N9oQlxbcG/GAocws84GtokI=;25:CnXNGEgJrL9QWmCbgGUC23r1JF0IkHZAuVpJoICEPKHuQU//EGklOE9iXbgEPMd85YLIRTbXoa7lL57mWWzPhhEcaQ7xAVTdNWBAwnDHVrDaIL+FXoGciBfkeT2rKFti/3iTszklEQOWU7VwotQ5s+kwIrqV6RoeqHPKyTMZ+OfkvPM1Cpap75cSHL7+o6MyVWB/D7DgxOhwroq2o4uxlnu2UXxY2DXeYA8LgbEJG5iZ0a1XlP+cKLX3EPYFHYAvKFHwx5OGssTZCnGGxzIOEYEY+MiG0EPLYyf3TIzl5+GAxJ5mwZleP8MLkqjWwwQ/F/rYBjO1LJqvzCh1Gu/L4g==
X-MS-TrafficTypeDiagnostic: DM6PR02MB4457:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4457;31:e0PRcCTk1RsD6kXQS4FIx/zUv/FPNKhmf1D0zH2UetkRreNEQaaaekXI+t6dR/rYjnGccwwUAfwFRSJiRm2HEnIyQdSqknWdA/2Du/HCTnDCKMRpZnONdfTglxeT/6IKzroe70SzH78NMmh+nE14qx2C8t+YmajFOx8K9AsqPebf6N3MG807cjpB6OYs7EJbRx+J6ItKfCJ73jPxOgMKozI60vA8n24PuXv9hziCndw=;20:IoSthHAb5ZQHBAUVcEpsinubeoZiHvE1Eg4gHVdbrp6Gv4hRjJPsS+cHHWJzWMqq6ch/t0Wf8xoVG/HWtBwJIzjbTkZ5eAR11CgqCOrkLwS6UFK2vEkKiQcfcnel5LBo9f5lVduwosgXBuPlV220Zhp5uCYYnFNJvOCDOvdcE0dErs8aoqymaFwswEiJ6iobkfSveFG48Q/zS7J39qiIuGN3uQekLMsqR6iyJ0/9rm1LvthxFNdlPwmzsYnz2hBnxy4Ve4zyrVoLRCk1hI6imx7eu6iE4EUK9PnoMfMxnfQZmCM3b3czyKqPo+GMxgluCzHKSsKCUOxR3GxwOZl1qkUHtui6uxn1TcbyS2D2664wLTwGR5Av+7s3+Mf/UwO/G1sQjznLOWDEUolGpYwJN0Q6jv+DBXsijr6cZ8rAPbDC6ZibvpEaLqW8nmm+JzfBgVu70TCRN/uEoU31OwXlcr2huVumzXmBVJdJPWTdpSv+QCMoLRxcTgl+ZpQs1UzI
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB4457C1269E1967811DB7D77BA7E30@DM6PR02MB4457.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699051);SRVR:DM6PR02MB4457;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4457;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4457;4:8by50OofMJWDwUJVWiK5ICHVtHBMzpXqBHqQuv6RFuJWMo7tdDl2xcQkmduNw++hGioM5vmxo0korxUhN8ZwIWOghcp5oquciBZXKCRWVqMXATejFRbo8bZSBXtRuZpmIqnCYJo0HpzNkQBNvNAAQ0G8Efc+OnpTheUNqb88IyF/YB/8CKQqtEP9XgKoAE2L81MhPfgqnjeFR+RrDju8Bl9xZk3zvD97hegyNVwuDAKW4wsehwvhjS8HEEweizCCNX5VEXFApHILXz34TpaU+rGmw5hM9w8v1yAzrHuJovlO+pZSnY1AxxxwiCSrF5c4
X-Forefront-PRVS: 082465FB26
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR02MB4457;23:5knaq0NKJuLy7JUy+DXGTEEz7roq2p30XIL5fn+n6?=
 =?us-ascii?Q?Ow5328zUJ+cmOvxQspJyuDuDaeK1HO0SHABjh3xoLr6suW5AgWhIt0ppJQF9?=
 =?us-ascii?Q?cVc1xc1q0DqjNaZzr/Rx/pt2FSArh8EGWdtSgWDKa4gJjxvIU74jIejA/Qsy?=
 =?us-ascii?Q?KiFc5E8n+sOhBn/qaILNYyW2K0ESBly0FzvKADwjH9ECmEPUhDYVAJTI9JJO?=
 =?us-ascii?Q?zoLAb7y2N4an0GWzTTDN3nCD+7CvDiFE0D4qRmi5MJwiwSgX9lZuD2/76ITJ?=
 =?us-ascii?Q?aKXiPdc3DOsLPdCg4NsaafdepX8qIvsmCiQV48Td/OIpx8zFLlgdzR2azW6X?=
 =?us-ascii?Q?RrNBUEs3R2QQSOplE7A/KWzrwlp1Y30W+6kcDf6tlIsvqf7TzidOz2pp9vEP?=
 =?us-ascii?Q?WMoNhs+6MnBbs+qpjJl7Q8kbrakshmtBwPQXZAwXGsH7Qnbo81amS+h6RRco?=
 =?us-ascii?Q?RE39PEBm7Mnu65X15zanvWMfyq4ZiL/A9aMqjy801pEdkOWZdqtGHiapL4tc?=
 =?us-ascii?Q?2c5CrswsCw5Zik6Jw6bKV+vkaB9szSVuKTXnNbE08ivhVpNaGVl7Xij0zOwv?=
 =?us-ascii?Q?ayU+tUiiD3yPkrPdquuR7tdnB1ZJI+eNmoU1Cw+Uk3X6hgyEZds8fKlrN3rB?=
 =?us-ascii?Q?au2OHXUOxlwi2Illu3URZYiGLAcqA+NmPZgzSs75egUnOAaeLc2MI+qPny9F?=
 =?us-ascii?Q?t0DZnq0n6Cdh8g3LComGkhraPzAIwBI/sWBHkbL/x026xZL3xL+PSSYhxmFN?=
 =?us-ascii?Q?4iFbCd0Vd3b1PaBVXAnDx843skDMDnOV67UIwSKwArfVnZWa5LDn9oIBGyEy?=
 =?us-ascii?Q?kNph3mFrVa3buC1R3mGWZSR6o6AvftNFhnI0GxXgFd+Fb98Db2Uzmekk+On1?=
 =?us-ascii?Q?fGsrKAFGEvEcvY0RhKuPKmsAozDLXZ6IdLkdyLdn+d+xzQ37XRMe+7+gGmLL?=
 =?us-ascii?Q?wVS+c1mxlt8ycciFYSYZ5MzBlrp61Y6KKnZHkb6sTDwZRC4uhEpvrjaJxK4U?=
 =?us-ascii?Q?03Fds6boEv+6I8lTdHC1vVoJL19p/lt66epocwwodkWDz94s/kWGv1SQP2Iu?=
 =?us-ascii?Q?1BB2vKOdOcFnB7GdHfZGTaCMsKomjfzCKQyceMcw3UIoRRqV2wX1o94tfrap?=
 =?us-ascii?Q?9CTdQsN3GaTDZ+IwO+YzWFlrCfTx8iyjt3XBDa3VbSirlTQD7CmGV3mPEdNE?=
 =?us-ascii?Q?WTbNaRMTExy9UbQgorOSrAaZvcsR5UFyFcn1KvsDNPTurTFnOkEaQKbSJatx?=
 =?us-ascii?Q?C9pyd/yE0N3zor2VvM=3D?=
X-Microsoft-Antispam-Message-Info: I6mxqqciUEatIeSkyFdjCMuq//9NymGTjQLqDAjdAIihXIFHIJ1v63+XSoaAwXU9meV95y882SNZTxY7EJkQuVRuiKiTfAf6mDBGGzueW9DueTFzOLGN0o9a9A1Mu9QqYxsaVKvQPb5skx1l8N6gKg/J8OQe+cmijvwv9Zn1hvmlzHT9LTNedTZ5BODI61wx7ieRXJqOJdjwudrodZ4lUKMfhf15wQsRfScWc8iZCCn14zZ3ZT5BPV3iMtbrhq2lrtBhy3nIhZ19SF0j8DanY/QqAQJ+uxWS3+P1dsmyTmJqFRL9HoWUgktqQxAHNmLredj/7LhLFQ2HeUDUzd/hYR5zL6vS4JrCjnBjuTvZ4F0=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4457;6:HCwwalWRAAT9dz3O4UFHi9FGAW4IZuDPqqRpznMcRgPGz7yXgxISN9UluQ838Qbp2arCj9wL0bGUexG+nIRtlQlzVOet3YtiPr7Pp7+grMHXvSw7J78yJXpeKQ/xk+g9Benb1lOQ3LPBTQDBvTYZ3txq/GcB4Wu8zqg6unKju0rzIBBs5c7/JatFSiMEIcSp19Kjp4I8pnjdQaVKJUDvETV9c5e0rKUWWZCtacwunb47EEZYjilYAdd2gfZk+L4yHVDjwzSadyxCvyE9qABNFsWCYqqe7cNsQ+MQogBbqti6p9fF5tVPYn4pKZe6LKR3GKXfQRvtMF3spa54ycu6A+a8gUtl9QwMzR4Sl04QcIpHmk5cDZG02+AVNqK0n3mZ5B77boTeEls/eieB3PV4BX8PcLAAECQNlrYvw8mnbNgEioh/4eAH863HLH66tr9UBV4S6mgSBTyoQUvrXnCJvQ==;5:isWn2gUvm/ZE7sj1FF5Mr64f2IHCzk/ujQwByi4qRAdWLdCUttDFS9nUfTabrmP1jj2pksEX6fUdI8Zk20gyaFQ+VQNXOQm38VGOfhq57HKnYKNaSKzD3vycsgQaJ50ChLbtizujypolFaK28ffXxQhP0YQlkrXO8iRZF1XObHM=;7:Lakzp4Bt2wD3w0QEk2UXa+8OtYwZ4WzRzWpI0ULS1lg1vYybDseDzqFsqeiVjdFUALzOP3JMdsWu4tcbOMcd0tqmu4uL832nbWkJ6pKMlIXzycKIHxlIu2WWupTCM4cSWr8iUR0gJ8BrletmymvkK/UFtTs+n9FUGow7gsiFUI6AFpj540/ybJyXBX42kVDgAer6m3c6Qw28yXTYzFha+8MffcbEyw41zDx+g29XSo2/9a8WqI1PNcF0Hfc+5woO
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2018 13:15:20.0695
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8222ea8-ae99-47e6-70fa-08d6310dedba
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4457
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When bulk streams are enabled for an endpoint, there can
be a condition where the gadget controller waits for the
host to issue prime transaction and the host controller
waits for the gadget to issue ERDY. This condition could
create a deadlock. To avoid such potential deadlocks, a
timer is started after queuing any request for the stream
capable endpoint in usb_ep_queue(). The gadget driver is
expected to stop the timer if a valid stream event is found.
If no stream event is found, the timer expires after the
STREAM_TIMEOUT_MS value and a callback function registered
by gadget driver to endpoint ops->stream_timeout API would be
called, so that the gadget driver can handle this situation.
This kind of behaviour is observed in dwc3 controller and
expected to be generic issue with other controllers supporting
bulk streams also.

Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
---
 Changes in v6:
	1. This patch is newly added in this series to add timer into udc/core.c
---
 drivers/usb/gadget/udc/core.c | 71 ++++++++++++++++++++++++++++++++++++++++++-
 include/linux/usb/gadget.h    | 12 ++++++++
 2 files changed, 82 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index af88b48..41cc23b 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -52,6 +52,24 @@ static int udc_bind_to_driver(struct usb_udc *udc,
 /* ------------------------------------------------------------------------- */
 
 /**
+ * usb_ep_stream_timeout - callback function for endpoint stream timeout timer
+ * @arg: pointer to struct timer_list
+ *
+ * This function gets called only when bulk streams are enabled in the endpoint
+ * and only after ep->stream_timeout_timer has expired. The timer gets expired
+ * only when the gadget controller failed to find a valid stream event for this
+ * endpoint. On timer expiry, this function calls the endpoint-specific timeout
+ * handler registered to endpoint ops->stream_timeout API.
+ */
+static void usb_ep_stream_timeout(struct timer_list *arg)
+{
+	struct usb_ep *ep = from_timer(ep, arg, stream_timeout_timer);
+
+	if (ep->stream_capable && ep->ops->stream_timeout)
+		ep->ops->stream_timeout(ep);
+}
+
+/**
  * usb_ep_set_maxpacket_limit - set maximum packet size limit for endpoint
  * @ep:the endpoint being configured
  * @maxpacket_limit:value of maximum packet size limit
@@ -87,6 +105,18 @@ EXPORT_SYMBOL_GPL(usb_ep_set_maxpacket_limit);
  * configurable, with more generic names like "ep-a".  (remember that for
  * USB, "in" means "towards the USB master".)
  *
+ * When bulk streams are enabled (stream_capable == true), a timer is setup
+ * by this function, which would be started at the time of queuing the request
+ * in  usb_ep_queue(). This is because, when streams are enabled the host and
+ * gadget can go out sync, the gadget may wait until the host issues a prime
+ * transaction and the host may wait until gadget issues a ERDY. This behaviour
+ * may create a deadlock. To avoid such a deadlock, the timer is started after
+ * submitting the request in usb_ep_queue(). If a valid stream event is
+ * generated, the gadget driver stops the timer. If no valid stream event is
+ * found, the timer gets expired and usb_ep_stream_timeout() function which is
+ * registered as a callback to stream_timeout_timer is called. This callback
+ * function handles the deadlock.
+ *
  * This routine must be called in process context.
  *
  * returns zero, or a negative error code.
@@ -102,6 +132,10 @@ int usb_ep_enable(struct usb_ep *ep)
 	if (ret)
 		goto out;
 
+	if (ep->stream_capable)
+		timer_setup(&ep->stream_timeout_timer,
+			    usb_ep_stream_timeout, 0);
+
 	ep->enabled = true;
 
 out:
@@ -121,6 +155,9 @@ EXPORT_SYMBOL_GPL(usb_ep_enable);
  * gadget drivers must call usb_ep_enable() again before queueing
  * requests to the endpoint.
  *
+ * For stream capable endpoints, the timer which was started in usb_ep_enable()
+ * would be removed.
+ *
  * This routine must be called in process context.
  *
  * returns zero, or a negative error code.
@@ -132,6 +169,9 @@ int usb_ep_disable(struct usb_ep *ep)
 	if (!ep->enabled)
 		goto out;
 
+	if (ep->stream_capable && timer_pending(&ep->stream_timeout_timer))
+		del_timer(&ep->stream_timeout_timer);
+
 	ret = ep->ops->disable(ep);
 	if (ret)
 		goto out;
@@ -245,6 +285,18 @@ EXPORT_SYMBOL_GPL(usb_ep_free_request);
  * Note that @req's ->complete() callback must never be called from
  * within usb_ep_queue() as that can create deadlock situations.
  *
+ * For stream capable endpoints (stream_capable == true), a timer which was
+ * setup by usb_ep_enable() is started in this function to avoid deadlock.
+ * When streams are enabled the host and gadget can go out sync, the gadget
+ * may wait until the host issues prime transaction and the host may wait
+ * until gadget issues a ERDY. This behaviour may create a deadlock. To avoid
+ * such a deadlock, when endpoint is bulk stream capable, the timer is started
+ * after submitting the request. If a valid stream event is generated by the
+ * gadget controller, the gadget driver stops the timer. If no valid stream
+ * event is found, the timer keeps running until expired after STREAM_TIMEOUT_MS
+ * value and the stream timeout function - usb_ep_stream_timeout() gets
+ * called, which takes necessary action to avoid the deadlock condition.
+ *
  * This routine may be called in interrupt context.
  *
  * Returns zero, or a negative error code.  Endpoints that are not enabled
@@ -269,6 +321,13 @@ int usb_ep_queue(struct usb_ep *ep,
 
 	ret = ep->ops->queue(ep, req, gfp_flags);
 
+	if (ep->stream_capable) {
+		ep->stream_timeout_timer.expires = jiffies +
+				msecs_to_jiffies(STREAM_TIMEOUT_MS);
+		mod_timer(&ep->stream_timeout_timer,
+			  ep->stream_timeout_timer.expires);
+	}
+
 out:
 	trace_usb_ep_queue(ep, req, ret);
 
@@ -291,6 +350,9 @@ EXPORT_SYMBOL_GPL(usb_ep_queue);
  * restrictions prevent drivers from supporting configuration changes,
  * even to configuration zero (a "chapter 9" requirement).
  *
+ * For stream capable endpoints, the timer which was started in usb_ep_queue()
+ * would be removed.
+ *
  * This routine may be called in interrupt context.
  */
 int usb_ep_dequeue(struct usb_ep *ep, struct usb_request *req)
@@ -300,6 +362,9 @@ int usb_ep_dequeue(struct usb_ep *ep, struct usb_request *req)
 	ret = ep->ops->dequeue(ep, req);
 	trace_usb_ep_dequeue(ep, req, ret);
 
+	if (ep->stream_capable && timer_pending(&ep->stream_timeout_timer))
+		del_timer(&ep->stream_timeout_timer);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(usb_ep_dequeue);
@@ -878,7 +943,8 @@ EXPORT_SYMBOL_GPL(usb_gadget_unmap_request);
  * Context: in_interrupt()
  *
  * This is called by device controller drivers in order to return the
- * completed request back to the gadget layer.
+ * completed request back to the gadget layer. For stream capable endpoints,
+ * the timer which was started in usb_ep_queue() would be removed.
  */
 void usb_gadget_giveback_request(struct usb_ep *ep,
 		struct usb_request *req)
@@ -886,6 +952,9 @@ void usb_gadget_giveback_request(struct usb_ep *ep,
 	if (likely(req->status == 0))
 		usb_led_activity(USB_LED_EVENT_GADGET);
 
+	if (ep->stream_capable && timer_pending(&ep->stream_timeout_timer))
+		del_timer(&ep->stream_timeout_timer);
+
 	trace_usb_gadget_giveback_request(ep, req, 0);
 
 	req->complete(ep, req);
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index e5cd84a..2ebaef0 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -144,6 +144,7 @@ struct usb_ep_ops {
 
 	int (*fifo_status) (struct usb_ep *ep);
 	void (*fifo_flush) (struct usb_ep *ep);
+	void (*stream_timeout) (struct usb_ep *ep);
 };
 
 /**
@@ -184,6 +185,11 @@ struct usb_ep_caps {
 		.dir_out = !!(_dir & USB_EP_CAPS_DIR_OUT), \
 	}
 
+/*
+ * Timeout value in msecs used by stream_timeout_timer when streams are enabled
+ */
+#define STREAM_TIMEOUT_MS	50
+
 /**
  * struct usb_ep - device side representation of USB endpoint
  * @name:identifier for the endpoint, such as "ep-a" or "ep9in-bulk"
@@ -191,6 +197,7 @@ struct usb_ep_caps {
  * @ep_list:the gadget's ep_list holds all of its endpoints
  * @caps:The structure describing types and directions supported by endoint.
  * @enabled: The current endpoint enabled/disabled state.
+ * @stream_capable: Set to true when ep supports bulk streams.
  * @claimed: True if this endpoint is claimed by a function.
  * @maxpacket:The maximum packet size used on this endpoint.  The initial
  *	value can sometimes be reduced (hardware allowing), according to
@@ -209,6 +216,9 @@ struct usb_ep_caps {
  *	enabled and remains valid until the endpoint is disabled.
  * @comp_desc: In case of SuperSpeed support, this is the endpoint companion
  *	descriptor that is used to configure the endpoint
+ * @stream_timeout_timer: timeout timer used by bulk streams to avoid deadlock
+ *	where host waits for the gadget to issue ERDY and gadget waits for host
+ *	to issue prime transaction.
  *
  * the bus controller driver lists all the general purpose endpoints in
  * gadget->ep_list.  the control endpoint (gadget->ep0) is not in that list,
@@ -224,12 +234,14 @@ struct usb_ep {
 	struct usb_ep_caps	caps;
 	bool			claimed;
 	bool			enabled;
+	bool			stream_capable;
 	unsigned		maxpacket:16;
 	unsigned		maxpacket_limit:16;
 	unsigned		max_streams:16;
 	unsigned		mult:2;
 	unsigned		maxburst:5;
 	u8			address;
+	struct timer_list	stream_timeout_timer;
 	const struct usb_endpoint_descriptor	*desc;
 	const struct usb_ss_ep_comp_descriptor	*comp_desc;
 };
-- 
2.1.1

