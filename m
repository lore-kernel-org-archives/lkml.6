Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63071C04EBC
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 10:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2965520817
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 10:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="CUg4fnPN";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="bJCq2IQG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2965520817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbeKRUa4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 15:30:56 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:41232 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726180AbeKRUay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 15:30:54 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wAIA8q7D007702;
        Sun, 18 Nov 2018 02:10:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=s1U4lCyBQeWuKJlCU/aJfDaixvzoEdzjirvSGyyh8wU=;
 b=CUg4fnPNE1OTR4pWG7aXfUnHr5+rLtr/4LTx80u23n+RQvKbczRL5drVynjKL+wALDgM
 AcIPFrVDUzdA0oEXoJy/BjzdoUxG0j5okG6QotR9PYsHrdvlQMyMBtTXh4H9cayg3u8V
 R3fqlVGkNkFiBMS+bq434eLgxnEgk2/8H9WqVYNGmpbdwTqdf4T0KxkZTDU5Zy5A6RQX
 AC4A15KRTwwuzxuevn0Tr52+AlICMqn4R922r6OoXpCRoXwJeLz7Jkc0X68vBm0doirn
 gRHJ0v80VUcEj9VumThtd2P03dklOBJsBSwc8bkTMHxMd6M4tN9++z3XwPQFZt+U6wMk ag== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam05-by2-obe.outbound.protection.outlook.com (mail-by2nam05lp0247.outbound.protection.outlook.com [216.32.181.247])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2ntff7w44u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 18 Nov 2018 02:10:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1U4lCyBQeWuKJlCU/aJfDaixvzoEdzjirvSGyyh8wU=;
 b=bJCq2IQGOm1LIUrefrTWPa4JewGUJILBN4r/Gu27hG1I9YpUuXe3bByxlhyUaGR24e7LrFxuE3yoazR+LM+8acKVSuDSQ15wQreYgBUucPhy9q5FMZXGAVMpeys8tUQ19NR27LIV1NK1BVcsSAk3TkI4AWUHaLBDa7jmRX0/SUY=
Received: from BYAPR07CA0086.namprd07.prod.outlook.com (2603:10b6:a03:12b::27)
 by DM6PR07MB5177.namprd07.prod.outlook.com (2603:10b6:5:4e::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1294.25; Sun, 18 Nov
 2018 10:10:46 +0000
Received: from CO1NAM05FT027.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::207) by BYAPR07CA0086.outlook.office365.com
 (2603:10b6:a03:12b::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1339.21 via Frontend
 Transport; Sun, 18 Nov 2018 10:10:46 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 CO1NAM05FT027.mail.protection.outlook.com (10.152.96.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.3 via Frontend Transport; Sun, 18 Nov 2018 10:10:41 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id wAIAAb5L029622
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Sun, 18 Nov 2018 02:10:40 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Sun, 18 Nov 2018 11:10:41 +0100
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Sun, 18 Nov 2018 11:10:41 +0100
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id wAIAAbJd030932;
        Sun, 18 Nov 2018 10:10:37 GMT
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id wAIAAb6L030931;
        Sun, 18 Nov 2018 10:10:37 GMT
From:   Pawel Laszczak <pawell@cadence.com>
To:     <devicetree@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <rogerq@ti.com>, <linux-kernel@vger.kernel.org>,
        <adouglas@cadence.com>, <jbergsagel@ti.com>, <nsekhar@ti.com>,
        <nm@ti.com>, <sureshp@cadence.com>, <peter.chen@nxp.com>,
        <pjez@cadence.com>, <kurahul@cadence.com>,
        "Pawel Laszczak" <pawell@cadence.com>
Subject: [RFC PATCH v2 03/15] dt-bindings: add binding for USBSS-DRD controller.
Date:   Sun, 18 Nov 2018 10:08:59 +0000
Message-ID: <1542535751-16079-4-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1542535751-16079-1-git-send-email-pawell@cadence.com>
References: <1542535751-16079-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(136003)(396003)(346002)(2980300002)(189003)(199004)(36092001)(126002)(486006)(76176011)(51416003)(4326008)(54906003)(16586007)(316002)(50466002)(42186006)(47776003)(106466001)(86362001)(246002)(107886003)(48376002)(2616005)(426003)(11346002)(476003)(26826003)(8676002)(336012)(26005)(446003)(8936002)(2351001)(186003)(217873002)(87636003)(6666004)(478600001)(36756003)(356004)(4720700003)(2906002)(6916009)(7636002)(50226002)(305945005)(105596002)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR07MB5177;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM05FT027;1:hka+mEmt8ESohjF5jVpycfoyuGZGfXwJ4t63mHTXdIpHSyH64a9VXh6qDlq5Gzve9Yz+iHivJN+lf+Rvcbv98vx+3J3cv9irDrxkZdJqu/U9yX+A1a/oWVlnHAV8w6Vc
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 894350d3-fcee-484e-2a19-08d64d3e1ac3
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:DM6PR07MB5177;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB5177;3:RD+OdW+famJI/RkN4qfOYn3BovOJVkG7GD4HAxwSTZE5EFwHzY1vtabGwu1BgX70QVhgCVL0V+9xHcmvqtilqN0JQd7aEi24YTdPWJ4eC5jGnvOSY9m/s52MXcq+7ZUdy57kTcviFLf+a/4wAukdXSKOJxG+GDuAtPNtdJqC5Qx/TUsB9HqPUbbDV1rf1mHHjHJ1/0+xkoXAwKTT+N5VjKIQ3l0t41Sp4mZtwyXIDfzaEN8O5ZjZ/FiG8JpRUzPEhBgm8RUuGWzRSGKhGtzcndviJvS7fspm83XiXgCvwJQ4Azxe7qLXa0vNrtUZg9FmR4PY0uRIkGhyaQNURWBK3whdBnFeAvpPtdDU687csso=;25:+D3jr0cT73OBb1DyzeeMMnVtWX5IRb0/vinSZwoRBuXfI8nvrp/RH3Q3YbbDl55sn3e18uk84AnyVrqBGPuOEWViNWvsaTNG1tTRfB8flQ7d0UQsRjEK+9/1Tm9Si2lCbhhG0aMooUP/AJ0L45HOqYOXIoHKN9tmuOPtgOuJndEWav2EgTRjO+rREsSx44O1Nmz0kDrTTDGXicCPabACliUCY+IJ79uCxz6fhRSUtCVBeW0IdQR1ePvbhoDpZUDx6OqGp6c6XWIVtxpJAKjRqI3FchAtP2TSGKdCM3kPGirut3odI8Ogxmx+7dEqv1XSLJxvZCPCvjU2QH8vwNO86g==
X-MS-TrafficTypeDiagnostic: DM6PR07MB5177:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB5177;31:oc1HAbj6Mf+RY9iRteVO0CYGskeUUTClESSM+0BYAXo/jtC+EDKotEpEt1bA3Q5Qhmrm9htKEjhJI9eKZKUKFe8VHQ5MIQjeeoKP35ohv3QxFSRFR/Tjx0mvyprdE1pXC6o0SKgPMlCj1dpXj5GaYeyv2OOXQXrMMsYSZPBR2TEyjeIqS9Cz2umSr930Jgmc11snDcyRajArooJNL/vOyDoXFze2Cw54ncSQxewf7js=;20:QFtqBdyOvJvBHrT17syEZZigUYJ6a7A4cp8oipWrhmVESDFM2BAWU1oLXf+uvL/VNnPbelbZHsFX4AM1C6Q9HQPtUYcPQEbN1uFqJdBRT6b7VkFj3dzGizLLwUIjB/1nbItuisbh1SLK5hWDzFsXnlKIrhEK5slT7zTXHhKDPfSz5q1Le4Q8fbYtzewz3WPP1n+n4fXJW9YztGrvj5qNRPIycsQWl5D63cfKghqeuUGA+HlnWwNf/AqaWjr9hjhWCG1PT45TlU2NGOkkKl0VfKnAiq1km0IXxiAUSKZUcdDAB0077V3Thz/1YuCsZFfcfVkAp1DfSEwQ9fKPaDN8iCzoOGYX+dr5J8juqb5dse94k7A2uOJhnLcYUzw3EbP/upW+j8ahx6vW2AjpTwhicN0S2o8sJS+Z8cmsOxOPT2dgdVKdt1jdBBzSiHWKnGId6RJPc5T+zGM5qKEk54Ai+YFkdexSO4BQqFzvh+G0tBwXDTFgnJW4WvPGSWX+7cqg
X-Microsoft-Antispam-PRVS: <DM6PR07MB517714A266E11182E94D7531DDDF0@DM6PR07MB5177.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231415)(944501410)(52105112)(3002001)(10201501046)(93006095)(93003095)(148016)(149066)(150057)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DM6PR07MB5177;BCL:0;PCL:0;RULEID:;SRVR:DM6PR07MB5177;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB5177;4:gv3Z3W3FaFqQGbynXdpGsYRJKtkJxx/B+Dd1rmVGXtfgFs7joG1PBki1sUgImHtdEG7qARyX38XyUWuxhy+ue7p5ycaFz0O8F29v2IeHF0aZ5VaKz3MqP+9i2aLMk4OdAbY7wV3PQODdI5ibYsUPLOAtA9hm5r5TWY+xJ5DK8lECnmE9uKn+rDjYh1gR6MD/PrJ/Nha6jNW5kpyqP5s0gn9gI97dwlp0FSosutzgSWkeMhO0rKU77wr7ZJaC8X17dhXZaYVPQwdBIh9yQL6bZmQtNOPJFjXkw83ppU8cUnIk1WE6j3Kd6w75sLsQuNKh
X-Forefront-PRVS: 0860FE717F
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR07MB5177;23:uaNbsKLLugBkX7KTO196h7VPZhtDDkjNs6jsjiQzV?=
 =?us-ascii?Q?JdXlB+m5ADVIgUmc8Es68wq1VidtapJUvzRLePf/vqAMK3iCoNDxtqFYBx5O?=
 =?us-ascii?Q?6RcPEKzYpV/naWG/eZOg5VGupLfawJWVWHJtLvn/uuMwxAsA6ZqnazjIUXz5?=
 =?us-ascii?Q?varyLVrCb4voJpaqziMg0HaVoDlI5IstSy25/wRRUdYz3wt+Vkr6hzRbw5nK?=
 =?us-ascii?Q?9SdQa807SmL7QGisQ9IE8mxtmLu+UtCTwVF9ypWeRilkLBYr3BQ+aRYOBArr?=
 =?us-ascii?Q?m0mG2gjta4Xi5fgbWotBmiVhXEe7xZ/7Qa0Ep4UhGlfczKp5aZX7c2pg0JmF?=
 =?us-ascii?Q?FHbKly0cRPcbQCRJYOl2S+SWBQVtQfyGxNaqUsCztdNSKt/OuqB51jjRA9jX?=
 =?us-ascii?Q?EDSHC0NfMJ5LWJcTWpb8Q4q1JQ5J7lDIRE3aPF8jKuDBOhqvbnSPwenfuJOF?=
 =?us-ascii?Q?Xn6v0f69lFwe+QSm8aArzQ4WlxlRjyIUpzZRjIj/KfUP/Q2pvzHrFiU6Sw6J?=
 =?us-ascii?Q?pveBIcTW/9rna24o5KEItjOdFQ2aXWS1gUJ2DJpixXE+u0AcSsa1l0HxyFfH?=
 =?us-ascii?Q?WreHGTjq80MymxG6Xp4dqQWBn8RpoKp+cNzpFtAdUt0vz6+e9giozvfwaS5y?=
 =?us-ascii?Q?SRxHfEnABDoR+43M16SOff7/nmiRARc/ygCG7E95nLOuMR+aX27vBMg97MQT?=
 =?us-ascii?Q?SzAc3F9ifmQq9FBuhr1l47yS903fj+Jblj/z9WCOLkOSVClQJpGNm2KRvqVl?=
 =?us-ascii?Q?Fcx3HyEwa8zD8q23AEo/Nhxiaj9g7404yLTuLOLsmud6HwWAFq2b4v6HtViq?=
 =?us-ascii?Q?TosYJMSZcT06h1A41lwFuMExVoHKI+ffQC2ngBu4f3IcRxcQlw+HTZUNGKiS?=
 =?us-ascii?Q?uMQs5AHuFUM+UNBF4WYoYUzzsCRNYIyJxFPvwcyTGfVsH3kZmgfOZI9CmGU1?=
 =?us-ascii?Q?b+DJNe+PU9Zd/MZvSFFngN1/WcfYIOibVgi1V8J5CUskxuP36beyh4vNKf88?=
 =?us-ascii?Q?ayB/pOaxJrg7FvwJBTJYNljHhlLUztzZ36DgsiyOjxkrK/D4NGt4aCqeaJTW?=
 =?us-ascii?Q?bXJymxxS55q4XYk+oSZ8c6zhzCAS5uqWHxBXeHqN/e3Lo4O2Undw1vywQ+E1?=
 =?us-ascii?Q?gyFpQ91foBRZ5nSjr/WMjYU54S//WIs?=
X-Microsoft-Antispam-Message-Info: goV+BduM1p/9MKGq+Z8NaIWqDbg15JXeJxK7iqo0W1oUPm0WvwfhAotGn0PpsgagiNDh5fsc9aeF54YJTrwBhD6bHVKr+MP6p/dCUbg4uxADAkyVls8Ee/Ej6zyrdlKUibfUrg1W/lk7vb0L1DS7E/x+w5LCv+pwdfrXkaluGfCnzjdIQkNn795S5Qlr03spKdY53HmpKdRVdrzEAcdtaIjTXWv9j6GXYCMebtemRoA3Pr6tciS/O/qea3tA7XSHp8IBOAcV4liB4U0uOlL4HTqeNPfpr752K9Gx/1Q5jAOsh9A5CFWyysqsiF+8HfloBsEof2jmm/pZplDJHifh3Bh9bOn61hAaapAR6Y5zoAA=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB5177;6:Xpd6PdapRGoLjQNC/aTuKEuL7o9P+wVzog47jWLFgglByUHr4kRRh/6gqILBqvdRvms51j87ANPOEaGtrQxJ+nH66+Xu4Cclj7BL6dQeg72wGPWc0ABafWGEN2ocZ8OKSc0GJnLmcypsS3eDv7UtFg3Gi1sL3NKWaYcYrgNYcOo3bUAZJpmv+7pbIffmsKV3JoG+ZAz0f2jL2EgIGYcBNvopeX8HAmObSqd7SLzf2D14niX/eVrDrRIFZXfEvxgHmxNldQFLAAbhlnEU2JBrMQpzK9XSJgVeHQhhpIqA/Bs9qo8JWFJGMLxDUJbQUnp8tmA1yC3/QtopT0azDGysn73Ltn4nfzBdis7V1YujQDyzdjfy3p0o+kVqYSbdii+1KCN4m1n2KUZIc6w5mTGYd+uBgI6CPsU0djf/EY+MYc4UeXte0v1kr9MA7UocG+fwHrZWFMafVXb76TL1l1jS+g==;5:XHhxkhwjh7KS7bTpjch7szLx/7FMh2GBcWRRogsVhwrnnH2YAPDt+dU+rsnkC1Jsi5HmN+n8OMvL3AALyk0LwIX23NglTr4OVJhz27xmu0WSefdfFaoxb8eS5EOoksuDOeO9TDOi8GUcEWo9B3JJ/ykecQtQnaOWoPj9chkbz5w=;7:sQzh4FoI/cnZUFo1bYI/r+jToiPMNZjKwL4tTzJMwWgx/eT/Ze5lGtXwvexJr9p9sl4HKuPsTq9lHZal+PFoR3C0c4qRoURXjoe6F4S7jeeaEw3fAPbjfYJOV7TzfFYtzjt2uCAxKQd90S5FFzv2EQ==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB5177;20:AH/l3ssxrnloD87J6phEEGH3Po87Zy7X2ltmY8bMKooV9mWamX7pf3/GgksXFyeHw7oJaD58eS8IOzNsXRU6W8qiFRgOa9KKWNEHvJKTh9UMcZ4vGd4rIecQ9UxTPdQ/C81qNRo8qiF6iKS2SPljlMUSuCewcjDEGZ6ag8GsDySm5hkRTZonHuChaeGS9O14KJBbrtTRjt0czDaOdBOjeqnKL8BMNavPRnDeJ1v5bRwYcD5u158yRqvPOFa/YBIn
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2018 10:10:41.8688
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 894350d3-fcee-484e-2a19-08d64d3e1ac3
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB5177
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 a:mx-sanjose2.Cadence.COM a:mx-sanjose4.Cadence.COM
 a:mx-sanjose5.Cadence.COM include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-18_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=540 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811180097
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thsi patch aim at documenting USB related dt-bindings for the
Cadence USBSS-DRD controller.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 .../devicetree/bindings/usb/cdns3-usb.txt       | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/cdns3-usb.txt

diff --git a/Documentation/devicetree/bindings/usb/cdns3-usb.txt b/Documentation/devicetree/bindings/usb/cdns3-usb.txt
new file mode 100644
index 000000000000..f9e953f32d47
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/cdns3-usb.txt
@@ -0,0 +1,17 @@
+Binding for the Cadence USBSS-DRD controller
+
+Required properties:
+  - reg: Physical base address and size of the controller's register area.
+  - compatible: Should contain: "cdns,usb3"
+  - interrupts: Interrupt specifier. Refer to interrupt bindings.
+
+
+Example:
+	cdns3@f3000000 {
+		compatible = "cdns,usb3";
+		interrupts = <USB_IRQ  7 IRQ_TYPE_LEVEL_HIGH>;
+		reg = <0xf3000000 0x10000	//memory area for OTG/DRD registers
+			0xf3010000 0x10000	//memory area for HOST registers
+			0xf3020000 0x10000>;	//memory area for Device registers
+	};
+
-- 
2.17.1

