Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA248C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7149D224E0
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="HtlcfAK/";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="BJ+Gc1bd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7149D224E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729884AbeKMCmj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 21:42:39 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:57042 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726841AbeKMCmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 21:42:39 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wACGcSJe010110;
        Mon, 12 Nov 2018 08:48:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=8Yscfj8oglwLXlqeMwc6NFXdNsvg3iptfVkNJo+kjpM=;
 b=HtlcfAK/RtxeHDNJW+z2d+Q3KO4fX393tFkXut4ZpuMMQ1kKP9sxaCDRlbUSn8MCIHQ/
 qilAJNepiZ5gx4nQvZmJEPcemWb1Oa1uRQeAp1LSynOLBj/vYjo6A6pGsDMYB+B0mG65
 p+3646NMhNtWRIk2IdR2f4yoUjgFPpHSGxp78Tmc6JNjpPG9czxTkPGn8RH6YlqW+wZb
 Cip0Eu4pYlqtMcFOyq8evBQrk6R2qYOszzgnTn4CW0JU+fIDOIs2kF2K3fi58ayatorC
 igv/DqupsjWLxg6x3G4hodUCdqOrdk9+geshh6M/FDxQZuK3aRrWKZtDLA8NqxEjjRgl 1w== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=adouglas@cadence.com
Received: from nam01-bn3-obe.outbound.protection.outlook.com (mail-bn3nam01lp0184.outbound.protection.outlook.com [216.32.180.184])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2nnut7kcwa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 12 Nov 2018 08:48:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Yscfj8oglwLXlqeMwc6NFXdNsvg3iptfVkNJo+kjpM=;
 b=BJ+Gc1bd6oqllCudoHqC2t8fTCVeL/uDBeTEqqDpa+F7ILGvVp2022UhIcmrVYx0kRKN/5rifPZIkWPVVa8kqkcFSLE7OqrHbYN1EBPK9O74WqX3N8KbKq3/pnvMF28/RHQLmrdfedQvtu+3cZFnq9GuEuT8dIiAL9YFN6xWv2Q=
Received: from BYAPR07CA0043.namprd07.prod.outlook.com (2603:10b6:a03:60::20)
 by BL0PR07MB4100.namprd07.prod.outlook.com (2603:10b6:207:4c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1294.28; Mon, 12 Nov
 2018 16:48:20 +0000
Received: from DM3NAM05FT054.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::209) by BYAPR07CA0043.outlook.office365.com
 (2603:10b6:a03:60::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1294.21 via Frontend
 Transport; Mon, 12 Nov 2018 16:48:20 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 DM3NAM05FT054.mail.protection.outlook.com (10.152.98.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.3 via Frontend Transport; Mon, 12 Nov 2018 16:48:19 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id wACGmHjx032181
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Mon, 12 Nov 2018 08:48:18 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 12 Nov 2018 17:48:20 +0100
Received: from lvloginb.cadence.com (10.165.177.11) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Mon, 12 Nov 2018 17:48:20 +0100
Received: from lvloginb.cadence.com (localhost [127.0.0.1])
        by lvloginb.cadence.com (8.14.4/8.14.4) with ESMTP id wACGmG5R019065;
        Mon, 12 Nov 2018 16:48:16 GMT
Received: (from adouglas@localhost)
        by lvloginb.cadence.com (8.14.4/8.14.4/Submit) id wACGmFL9019056;
        Mon, 12 Nov 2018 16:48:15 GMT
From:   Alan Douglas <adouglas@cadence.com>
To:     <kishon@ti.com>, <linux-kernel@vger.kernel.org>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>
CC:     Alan Douglas <adouglas@cadence.com>
Subject: [PATCH v3 2/2] phy: cadence: Add driver for Sierra PHY
Date:   Mon, 12 Nov 2018 16:42:16 +0000
Message-ID: <1542040936-10793-1-git-send-email-adouglas@cadence.com>
X-Mailer: git-send-email 1.9.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(396003)(136003)(2980300002)(36092001)(189003)(199004)(2616005)(126002)(476003)(575784001)(2906002)(246002)(426003)(50226002)(26005)(48376002)(87636003)(486006)(8936002)(26826003)(36756003)(86362001)(14444005)(8676002)(51416003)(2201001)(50466002)(4744004)(47776003)(356004)(336012)(316002)(42186006)(16586007)(105596002)(186003)(110136005)(5660300001)(107886003)(7636002)(305945005)(106466001)(4326008)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR07MB4100;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT054;1:tBm4X8PX4Dc7ibEOWPrtPfc/wUR1g3Q4YtqW2L6e1V4p6yU/efx+NOKH3cswgRe5X84GFYtGxRVW50tTfJNDEE+vk2Vye8tfg8dNzLhPcMoXhONOxE30JCsvNpOq5fY1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 006e2e50-1713-444e-807e-08d648bea6e8
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390040)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:BL0PR07MB4100;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR07MB4100;3:CXq+4Gn4fPfgKiFjM75Rri1a50Q6qdAeggFv02Yl/HRIyhhz+xr9hYrz+49i+DHx/3NBn5zZHXVFf6ZyoHNBsUnLQQTYDQnd8et4kF9vZCbrOQeGmmbihUNEuB9SGVlZKM9w5EPl/S5eyVwzr3fDURFDPr/aQEaM07rv77PtuG1MQCuRzsz72NYJYLcLXKcRevI9Bu6Pmxhz72WFO5l3cmBO8/8nTvn7auayZwS/XYYiN21l78Zk+Jiky7YtxdxNKLT93Lv1w/ip4/A3epY6ma2IKMjJuJyPc7VLI2L0K7KA7449K76TdU6dHOQmoyfDbzGzfVAt+F+YFX8Apo+U7crCw2Bp7ejnk5Mp43lnemI=;25:tuP3BKC3lo96j4wFFA6EocySxkqSZRq7PGrAbH62OfM9vHUlvPkz8P929000g5/5hsyyoiXOAbrsLxFZ1n8BO5lvIxV29JYVUThxmN9ZEmPgi23w/uGg+qmb5vK6AFBBN/K8V3AqOmrefsb5+jWFRMrrq+dwiS4MuPdI/fFZNU9ys5rS1WMqtYOiHGRxpPj0Afl3pg/AUrp/f7V2jEG4WvCL6TP6k/fHKeOpcEX//ETxpLhOfA+BfTxJMKXTNZVxsPTuqq1F33sjcYJCXNDR1akhIW6+je5jPEy7EiB0GngCxI4hFssyh9LgaYP3k3KMjU705gcS8PH8bNSjW3feLg==
X-MS-TrafficTypeDiagnostic: BL0PR07MB4100:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR07MB4100;31:qLKgGhaCdEY1gsyrl5J4s4OQWnz9WXRgmvPRIJGzUJOXTYNspHTG9mu12Um6SFi4q7zV++MidO8HpPRZSpm+oMeCa1u5Qllj+OuLZthBPco86O96EovkAhrYizzlaW8G9W1oFFQT4lQSw9MH0dyhVqqrVpY266VaSHiQYD7IulTNEojmoZMC6blx8v6biyx1UddHfFMoJ+53jNLmROFpx4UasQ3CEx7O/cMYphK8ODc=;20:wIZsBSsxjm2DLepVMq7JQuo/AePL7wvbQnOJHGbNcZvhxN0qMwPCVceTl/VndurhIU04SjmdrmPlpFA272Xm1qSQN2ZkEMBB6YtpvbGxjCIC5P0kL2JI8rsNg7Qcne8XcIt2uMis1JeRf3ym6m/rjVjU3mFAMdrpis+9LokrFRh9YdcktBnzKQwVSQT4DuZijzMgqD7LC2JTw1wpRqR8Q/SiBsQkxEoIxYoOd0lrY4JynDmdYz2q9JW4amjFjq2UqMXu084w3Pymc6BNSwVDyvYCe0r/UjXLU/5USDZwPZpFvic6x77PyR7beG6qJP/KoNo2K/1KYkXgcHsOnxra7yvGo3Dk4O1BF4x2dE2YGo4LMVAz9bU+oP51oXt1X56rn157YzrUxG74Mlb37v2Kz8gVAZCOvE9nuscy/SPeLjAi+17rIBeeFphu0lSLWL/3mzWCoIaZmt1ZMiZW1o6RlT6XFhqm6yaHc9IqPaDCNr1AsWjJei9JdvsNtgwLFrTU
X-Microsoft-Antispam-PRVS: <BL0PR07MB41007AA23748592667583F6BD8C10@BL0PR07MB4100.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93003095)(3231402)(944501410)(52105112)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BL0PR07MB4100;BCL:0;PCL:0;RULEID:;SRVR:BL0PR07MB4100;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR07MB4100;4:Bt1Ktg0QV0m3FyeUo2XBetb7RpsPO1LoLM0vO5eXY40E/BXvhrC0RCtuaov3cM5pNngmD9d0yaYy/TZKlGlYNxlVYvysn2SydTEL20iMoMNEo/7slfpdK4qp7T+tNtjAt5AedBaM8+edrP8LTUm8DNBfj5wXfvAZrotrd5TN07sMWcN85I2rCUJezBXJRNyuIVl/lx5LnVeu1GRZg5y8W9bJM/qLa/xwj88grKepZzADZ3/0glxCVVRkw//vdQb6uGb2ue5TA6ZkKFVG5WM50GmfXidB27kjL15s13QIBkpAYmrOiqX2YgU1DCzdCd1m
X-Forefront-PRVS: 0854128AF0
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR07MB4100;23:GQhmGGfNnwpC+gk30tqjtk30B4Y8s+For6xU2GvPB?=
 =?us-ascii?Q?CrdB+j/S3S1bNUO6mMJd6AmBnUdu81D0ZHpJekA6EJCLvKpyk/fXbCWqDqHk?=
 =?us-ascii?Q?c6RgxCdGAuMxB5wny5LaleqAaMU7C6Ft9Q7f9Nu+lF4nISS7De6NydtI9KB/?=
 =?us-ascii?Q?RTj6AeXMdHWUCChVa2jsJZekFHOfuhZsawbiqc+GIYapfT8OScMxmJZQcrsk?=
 =?us-ascii?Q?eIFAoGTpLTRsfZhlbKkk9C1Yf46/MnaoLke0FvfGgZdlF1avLdiRrcCCrGg2?=
 =?us-ascii?Q?Ez54KzVF/957J6xfJb1zydIUcHms3F+o9cz1OiqkKGrjG9bJ8Oo9JRhW+Md+?=
 =?us-ascii?Q?eXzR8bSSkNMZ/cJ0ymixArdkX2HPVksgIdbo8WcpoXhZYO/mvq40mV0fPnU3?=
 =?us-ascii?Q?+ckfjUvCFgKsmpXRUwZxPsKqLsLOgDWQijcYIptjw7lykSO4BRuROcumo/5R?=
 =?us-ascii?Q?mSaTj8ca+3RGiyY/zCCTFtqP/ceB2nujG53rcG7ZPpdpef8LD5qLq+ZHyYml?=
 =?us-ascii?Q?CFcCskiCGJL8sQTy3T0ANqN/ju26nsbrga+DWy9F5ReoROEJ4aAaFLGR1dwo?=
 =?us-ascii?Q?9M0Mwi5yP4gmOshW/1LpL/SBgn3sYDunVmrnIsbTjvy8tZ7NxJv8v2NoU/J4?=
 =?us-ascii?Q?VDEMxYIGMQi+BsSt1GLeOyx9Kx/P451ZlqynvXT+J1KeyoHAq8NdPDoL9d/k?=
 =?us-ascii?Q?lZ421+988LZwnFJqjYLfXr8sD/49RX9WD0TtfhSc/voaetnuFhJsGRtZkpK3?=
 =?us-ascii?Q?KMdygqi/L9dwVekZe5SJ3Sng3MDYBJEhh3PHwIW2G2OagXl1gbmrRopYZGdx?=
 =?us-ascii?Q?tYcJhgmdM+ypLkT1zZlg7FP8FS9x38ckfyJ0YceRMCIJw5Boeei/MOmQ2zaJ?=
 =?us-ascii?Q?XnoAECOANCUNvd2irJpE4Z0tkJ2LG9pyKqe6Ng0wRZLIi7h9QRQq56y4jP+8?=
 =?us-ascii?Q?kWESbGnMZVNTnZgOyPKbn9kgLJtR+IbgMXQ8jCl6Yol1vP7kxoW2GreOJLB+?=
 =?us-ascii?Q?20dF/vRww1UQOcI0U6P0Zt4EkG4Q/vB9uhf3JhV0fbz7Evc8bGtbVeyIdqYr?=
 =?us-ascii?Q?rEDGmc=3D?=
X-Microsoft-Antispam-Message-Info: RHJrnVHyBpvDHAgThCNqQWwRv7uxUU+MecrS1nYqOLHTRgGQxTBGf+d+zFAf+d4fO+80yhh3VXxqLP/oTYq4POLntymFFvWomvkJMlgHv9atWX/rvCEuRGyvdxkuPjiyO9Yz3qo9+dEup1VLLla0SCeUozhYR8rNekLA0Cpp+rsF0GmiOahDREwrdYGgLklE05RJ9Y2EFHZrq6hbiSu9ZE+2PKK0XkogqxGE6/RBvCP+PUKYaXiDr4JFBHjCFLilC6+S8ETHbtihnihSZmI69wDPaeJohwu+CyXg2TEHzhXm24HSP98IsrxeLYMaJxxmA6aCJQHyCjICMRiW1CS3oh5bIu9MHwjSu2sJrD2VLSU=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR07MB4100;6:Fggy5zXaOeEzjlmC6H8OCIN6K56gs/dRF8jhU0kZ+eMvpGfzy70AvZ7d03vsXku3JJl47x/bt39an5twoXCuR/hdxdPTyLsnOKYBeWqPOwX+LJbrz0+t3ehLuSwgb8e7WtacdMnz4j8V2imeQwkfv19bO8fNhat1pMW5fe5dkJ70juhR1tCseUvWlFd0JX+JwRvadBQw4hfnJvMiOEnRREwOh9bKGxdfjSwiOUATykPL/ihynpl/Zv2wbOECfFqsW4mCP5CDyIrpKesUag/WHBdK80ayEoXJHJ+tADV28T+VuSRY2fFHZTZtZDSiBrrC0mCAx4yO5UNhyXPbs+JCT5RQ/wfxWClPTllrN64+TwClG9zQR3kX0GzO6Ac/Wv6HH7LzNmHIVmFxged39Z4pP7c6LNeQthZHeBaee9Fofpjoj5/zC7ASQmgQMePq3frUGoPAXp9cbiAzCdnBPdUV2g==;5:YtqTIeGbbZuD8TGMnmdkaXMXQglBLwdkAO8IJ4gZt1D4NOXh4Q1E5Jtbqp8FDaxg8eIU41VnLbcVAHu9jm2JWG1dZJJON2WTGxoSynnwkJDvHtjiCM6jeKfrw8LsIE0cspCQD8//QOSDzyvWfm76P9zZbcsiITV4acEuM/HtKnM=;7:5e2sUTAtkr4zsEerGVzfbW7zvr3fqId1RhHEnBH8d9GBZYbg4oM4o/QT5z46Ykvkt+IxVuVEVAZHYl9Skoz9eqRgvsNeqiWPIdVp7zmKwAJqis9SgbzxnCg7AjAvUXdtPeTlaYwFis+1ga3jll1tmQ==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL0PR07MB4100;20:4maCnkj/MC7ZqkV/elyNPQYD+vjIk2xu/QUV8yiTmhnJoy5sLccZEE7BEUKlpB9RFXp+cUziIyphiwhJz994eXLIwouXLlMQ/h8Uj/v3ciUGSzJxzQXyNix20OXSksg97rvB9RjAlT5zvjwbvPYM+NJ8+rfY+k4TpmUoywHMqNAxcYJ6l8AfCBWcbpRBzOXebXxdUXiDfOAl8eC8G4ep9y9KztwW8D1kLDIsCdv/5+R/he8jaelupLYDWF9cK0jO
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2018 16:48:19.7150
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 006e2e50-1713-444e-807e-08d648bea6e8
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR07MB4100
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 a:mx-sanjose2.Cadence.COM a:mx-sanjose4.Cadence.COM
 a:mx-sanjose5.Cadence.COM include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-12_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811120146
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a Sierra PHY driver with PCIe and USB support.

The PHY has multiple lanes, which can be configured into
groups, and a generic PHY device is created for each group.

There are two resets controlling the overall PHY block, one
to enable the APB interface for programming registers, and
another to enable the PHY itself.  Additionally there are
resets for each PHY lane.

The PHY can be configured in hardware to read register
settings from ROM, or they can be written by the driver.

The sequence of operation on startup is to enable the APB
bus, write the PHY registers (if required)  for each lane
group, and then enable the PHY.  Each group of lanes
can then be individually controlled using the power_on()/
power_off() function for that generic PHY

Signed-off-by: Alan Douglas <adouglas@cadence.com>
---
 drivers/phy/cadence/Kconfig              |   9 +-
 drivers/phy/cadence/Makefile             |   1 +
 drivers/phy/cadence/phy-cadence-sierra.c | 395 +++++++++++++++++++++++++++++++
 3 files changed, 404 insertions(+), 1 deletion(-)
 create mode 100644 drivers/phy/cadence/phy-cadence-sierra.c

diff --git a/drivers/phy/cadence/Kconfig b/drivers/phy/cadence/Kconfig
index 57fff7d..2b8c085 100644
--- a/drivers/phy/cadence/Kconfig
+++ b/drivers/phy/cadence/Kconfig
@@ -1,5 +1,5 @@
 #
-# Phy driver for Cadence MHDP DisplayPort controller
+# Phy drivers for Cadence PHYs
 #
 config PHY_CADENCE_DP
 	tristate "Cadence MHDP DisplayPort PHY driver"
@@ -8,3 +8,10 @@ config PHY_CADENCE_DP
 	select GENERIC_PHY
 	help
 	  Support for Cadence MHDP DisplayPort PHY.
+
+config PHY_CADENCE_SIERRA
+	tristate "Cadence Sierra PHY Driver"
+	depends on OF && HAS_IOMEM && RESET_CONTROLLER
+	select GENERIC_PHY
+	help
+	  Enable this to support the Cadence Sierra PHY driver
\ No newline at end of file
diff --git a/drivers/phy/cadence/Makefile b/drivers/phy/cadence/Makefile
index e5b0a11..412349a 100644
--- a/drivers/phy/cadence/Makefile
+++ b/drivers/phy/cadence/Makefile
@@ -1 +1,2 @@
 obj-$(CONFIG_PHY_CADENCE_DP)	+= phy-cadence-dp.o
+obj-$(CONFIG_PHY_CADENCE_SIERRA)	+= phy-cadence-sierra.o
diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
new file mode 100644
index 0000000..de10402
--- /dev/null
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -0,0 +1,395 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Cadence Sierra PHY Driver
+ *
+ * Copyright (c) 2018 Cadence Design Systems
+ * Author: Alan Douglas <adouglas@cadence.com>
+ *
+ */
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <dt-bindings/phy/phy.h>
+
+/* PHY register offsets */
+#define SIERRA_PHY_PLL_CFG		(0xc00e << 2)
+#define SIERRA_DET_STANDEC_A		(0x4000 << 2)
+#define SIERRA_DET_STANDEC_B		(0x4001 << 2)
+#define SIERRA_DET_STANDEC_C		(0x4002 << 2)
+#define SIERRA_DET_STANDEC_D		(0x4003 << 2)
+#define SIERRA_DET_STANDEC_E		(0x4004 << 2)
+#define SIERRA_PSM_LANECAL		(0x4008 << 2)
+#define SIERRA_PSM_DIAG			(0x4015 << 2)
+#define SIERRA_PSC_TX_A0		(0x4028 << 2)
+#define SIERRA_PSC_TX_A1		(0x4029 << 2)
+#define SIERRA_PSC_TX_A2		(0x402A << 2)
+#define SIERRA_PSC_TX_A3		(0x402B << 2)
+#define SIERRA_PSC_RX_A0		(0x4030 << 2)
+#define SIERRA_PSC_RX_A1		(0x4031 << 2)
+#define SIERRA_PSC_RX_A2		(0x4032 << 2)
+#define SIERRA_PSC_RX_A3		(0x4033 << 2)
+#define SIERRA_PLLCTRL_SUBRATE		(0x403A << 2)
+#define SIERRA_PLLCTRL_GEN_D		(0x403E << 2)
+#define SIERRA_DRVCTRL_ATTEN		(0x406A << 2)
+#define SIERRA_CLKPATHCTRL_TMR		(0x4081 << 2)
+#define SIERRA_RX_CREQ_FLTR_A_MODE1	(0x4087 << 2)
+#define SIERRA_RX_CREQ_FLTR_A_MODE0	(0x4088 << 2)
+#define SIERRA_CREQ_CCLKDET_MODE01	(0x408E << 2)
+#define SIERRA_RX_CTLE_MAINTENANCE	(0x4091 << 2)
+#define SIERRA_CREQ_FSMCLK_SEL		(0x4092 << 2)
+#define SIERRA_CTLELUT_CTRL		(0x4098 << 2)
+#define SIERRA_DFE_ECMP_RATESEL		(0x40C0 << 2)
+#define SIERRA_DFE_SMP_RATESEL		(0x40C1 << 2)
+#define SIERRA_DEQ_VGATUNE_CTRL		(0x40E1 << 2)
+#define SIERRA_TMRVAL_MODE3		(0x416E << 2)
+#define SIERRA_TMRVAL_MODE2		(0x416F << 2)
+#define SIERRA_TMRVAL_MODE1		(0x4170 << 2)
+#define SIERRA_TMRVAL_MODE0		(0x4171 << 2)
+#define SIERRA_PICNT_MODE1		(0x4174 << 2)
+#define SIERRA_CPI_OUTBUF_RATESEL	(0x417C << 2)
+#define SIERRA_LFPSFILT_NS		(0x418A << 2)
+#define SIERRA_LFPSFILT_RD		(0x418B << 2)
+#define SIERRA_LFPSFILT_MP		(0x418C << 2)
+#define SIERRA_SDFILT_H2L_A		(0x4191 << 2)
+
+#define SIERRA_MACRO_ID			0x00007364
+#define SIERRA_MAX_LANES		4
+
+struct cdns_sierra_inst {
+	struct phy *phy;
+	u32 phy_type;
+	u32 num_lanes;
+	u32 mlane;
+	struct reset_control *lnk_rst;
+};
+
+struct cdns_reg_pairs {
+	u16 val;
+	u32 off;
+};
+
+struct cdns_sierra_data {
+		u32 id_value;
+		u32 pcie_regs;
+		u32 usb_regs;
+		struct cdns_reg_pairs *pcie_vals;
+		struct cdns_reg_pairs  *usb_vals;
+};
+
+struct cdns_sierra_phy {
+	struct device *dev;
+	void __iomem *base;
+	struct cdns_sierra_data *init_data;
+	struct cdns_sierra_inst phys[SIERRA_MAX_LANES];
+	struct reset_control *phy_rst;
+	struct reset_control *apb_rst;
+	struct clk *clk;
+	int nsubnodes;
+	bool autoconf;
+};
+
+static void cdns_sierra_phy_init(struct phy *gphy)
+{
+	struct cdns_sierra_inst *ins = phy_get_drvdata(gphy);
+	struct cdns_sierra_phy *phy = dev_get_drvdata(gphy->dev.parent);
+	int i, j;
+	struct cdns_reg_pairs *vals;
+	u32 num_regs;
+
+	if (ins->phy_type == PHY_TYPE_PCIE) {
+		num_regs = phy->init_data->pcie_regs;
+		vals = phy->init_data->pcie_vals;
+	} else if (ins->phy_type == PHY_TYPE_USB3) {
+		num_regs = phy->init_data->usb_regs;
+		vals = phy->init_data->usb_vals;
+	} else {
+		return;
+	}
+	for (i = 0; i < ins->num_lanes; i++)
+		for (j = 0; j < num_regs ; j++)
+			writel(vals[j].val, phy->base +
+				vals[j].off + (i + ins->mlane) * 0x800);
+}
+
+static int cdns_sierra_phy_on(struct phy *gphy)
+{
+	struct cdns_sierra_inst *ins = phy_get_drvdata(gphy);
+
+	/* Take the PHY lane group out of reset */
+	return reset_control_deassert(ins->lnk_rst);
+}
+
+static int cdns_sierra_phy_off(struct phy *gphy)
+{
+	struct cdns_sierra_inst *ins = phy_get_drvdata(gphy);
+
+	return reset_control_assert(ins->lnk_rst);
+}
+
+static const struct phy_ops ops = {
+	.power_on	= cdns_sierra_phy_on,
+	.power_off	= cdns_sierra_phy_off,
+	.owner		= THIS_MODULE,
+};
+
+static int cdns_sierra_get_optional(struct cdns_sierra_inst *inst,
+				    struct device_node *child)
+{
+	if (of_property_read_u32(child, "reg", &inst->mlane))
+		return -EINVAL;
+
+	if (of_property_read_u32(child, "cdns,num-lanes", &inst->num_lanes))
+		return -EINVAL;
+
+	if (of_property_read_u32(child, "cdns,phy-type", &inst->phy_type))
+		return -EINVAL;
+
+	return 0;
+}
+
+static const struct of_device_id cdns_sierra_id_table[];
+
+static int cdns_sierra_phy_probe(struct platform_device *pdev)
+{
+	struct cdns_sierra_phy *sp;
+	struct phy_provider *phy_provider;
+	struct device *dev = &pdev->dev;
+	const struct of_device_id *match;
+	struct resource *res;
+	int i, ret, node = 0;
+	struct device_node *dn = dev->of_node, *child;
+
+	if (of_get_child_count(dn) == 0)
+		return -ENODEV;
+
+	sp = devm_kzalloc(dev, sizeof(*sp), GFP_KERNEL);
+	if (!sp)
+		return -ENOMEM;
+	dev_set_drvdata(dev, sp);
+	sp->dev = dev;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	sp->base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(sp->base)) {
+		dev_err(dev, "missing \"reg\"\n");
+		return PTR_ERR(sp->base);
+	}
+
+	/* Get init data for this PHY */
+	match = of_match_device(cdns_sierra_id_table, dev);
+	if (!match)
+		return -EINVAL;
+	sp->init_data = (struct cdns_sierra_data *)match->data;
+
+	platform_set_drvdata(pdev, sp);
+
+	sp->clk = devm_clk_get(dev, "phy_clk");
+	if (IS_ERR(sp->clk)) {
+		dev_err(dev, "failed to get clock phy_clk\n");
+		return PTR_ERR(sp->clk);
+	}
+
+	sp->phy_rst = devm_reset_control_get(dev, "sierra_reset");
+	if (IS_ERR(sp->phy_rst)) {
+		dev_err(dev, "failed to get reset\n");
+		return PTR_ERR(sp->phy_rst);
+	}
+
+	sp->apb_rst = devm_reset_control_get(dev, "sierra_apb");
+	if (IS_ERR(sp->apb_rst)) {
+		dev_err(dev, "failed to get apb reset\n");
+		return PTR_ERR(sp->apb_rst);
+	}
+
+	ret = clk_prepare_enable(sp->clk);
+	if (ret)
+		return ret;
+
+	/* Enable APB */
+	reset_control_deassert(sp->apb_rst);
+
+	/* Check that PHY is present */
+	if  (sp->init_data->id_value != readl(sp->base)) {
+		ret = -EINVAL;
+		goto clk_disable;
+	}
+
+	sp->autoconf = of_property_read_bool(dn, "cdns,autoconf");
+
+	for_each_available_child_of_node(dn, child) {
+		struct phy *gphy;
+
+		sp->phys[node].lnk_rst =
+			of_reset_control_get_exclusive_by_index(child, 0);
+
+		if (IS_ERR(sp->phys[node].lnk_rst)) {
+			dev_err(dev, "failed to get reset %s\n",
+				child->full_name);
+			ret = PTR_ERR(sp->phys[node].lnk_rst);
+			goto put_child2;
+		}
+
+		if (!sp->autoconf) {
+			ret = cdns_sierra_get_optional(&sp->phys[node], child);
+			if (ret) {
+				dev_err(dev, "missing property in node %s\n",
+					child->name);
+				goto put_child;
+			}
+		}
+
+		gphy = devm_phy_create(dev, child, &ops);
+
+		if (IS_ERR(gphy)) {
+			ret = PTR_ERR(gphy);
+			goto put_child;
+		}
+		sp->phys[node].phy = gphy;
+		phy_set_drvdata(gphy, &sp->phys[node]);
+
+		/* Initialise the PHY registers, unless auto configured */
+		if (!sp->autoconf)
+			cdns_sierra_phy_init(gphy);
+
+		node++;
+	}
+	sp->nsubnodes = node;
+
+	/* If more than one subnode, configure the PHY as multilink */
+	if (!sp->autoconf && sp->nsubnodes > 1)
+		writel(2, sp->base + SIERRA_PHY_PLL_CFG);
+
+	pm_runtime_enable(dev);
+	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+	reset_control_deassert(sp->phy_rst);
+	return PTR_ERR_OR_ZERO(phy_provider);
+
+put_child:
+	node++;
+put_child2:
+	for (i = 0; i < node; i++)
+		reset_control_put(sp->phys[i].lnk_rst);
+	of_node_put(child);
+clk_disable:
+	clk_disable_unprepare(sp->clk);
+	reset_control_assert(sp->apb_rst);
+	return ret;
+}
+
+static int cdns_sierra_phy_remove(struct platform_device *pdev)
+{
+	struct cdns_sierra_phy *phy = dev_get_drvdata(pdev->dev.parent);
+	int i;
+
+	reset_control_assert(phy->phy_rst);
+	reset_control_assert(phy->apb_rst);
+	pm_runtime_disable(&pdev->dev);
+
+	/*
+	 * The device level resets will be put automatically.
+	 * Need to put the subnode resets here though.
+	 */
+	for (i = 0; i < phy->nsubnodes; i++) {
+		reset_control_assert(phy->phys[i].lnk_rst);
+		reset_control_put(phy->phys[i].lnk_rst);
+	}
+	return 0;
+}
+
+static struct cdns_reg_pairs cdns_usb_regs[] = {
+	/*
+	 * Write USB configuration parameters to the PHY.
+	 * These values are specific to this specific hardware
+	 * configuration.
+	 */
+	{0xFE0A, SIERRA_DET_STANDEC_A},
+	{0x000F, SIERRA_DET_STANDEC_B},
+	{0x55A5, SIERRA_DET_STANDEC_C},
+	{0x69AD, SIERRA_DET_STANDEC_D},
+	{0x0241, SIERRA_DET_STANDEC_E},
+	{0x0110, SIERRA_PSM_LANECAL},
+	{0xCF00, SIERRA_PSM_DIAG},
+	{0x001F, SIERRA_PSC_TX_A0},
+	{0x0007, SIERRA_PSC_TX_A1},
+	{0x0003, SIERRA_PSC_TX_A2},
+	{0x0003, SIERRA_PSC_TX_A3},
+	{0x0FFF, SIERRA_PSC_RX_A0},
+	{0x0003, SIERRA_PSC_RX_A1},
+	{0x0003, SIERRA_PSC_RX_A2},
+	{0x0001, SIERRA_PSC_RX_A3},
+	{0x0001, SIERRA_PLLCTRL_SUBRATE},
+	{0x0406, SIERRA_PLLCTRL_GEN_D},
+	{0x0000, SIERRA_DRVCTRL_ATTEN},
+	{0x823E, SIERRA_CLKPATHCTRL_TMR},
+	{0x078F, SIERRA_RX_CREQ_FLTR_A_MODE1},
+	{0x078F, SIERRA_RX_CREQ_FLTR_A_MODE0},
+	{0x7B3C, SIERRA_CREQ_CCLKDET_MODE01},
+	{0x023C, SIERRA_RX_CTLE_MAINTENANCE},
+	{0x3232, SIERRA_CREQ_FSMCLK_SEL},
+	{0x8452, SIERRA_CTLELUT_CTRL},
+	{0x4121, SIERRA_DFE_ECMP_RATESEL},
+	{0x4121, SIERRA_DFE_SMP_RATESEL},
+	{0x9999, SIERRA_DEQ_VGATUNE_CTRL},
+	{0x0330, SIERRA_TMRVAL_MODE0},
+	{0x01FF, SIERRA_PICNT_MODE1},
+	{0x0009, SIERRA_CPI_OUTBUF_RATESEL},
+	{0x000F, SIERRA_LFPSFILT_NS},
+	{0x0009, SIERRA_LFPSFILT_RD},
+	{0x0001, SIERRA_LFPSFILT_MP},
+	{0x8013, SIERRA_SDFILT_H2L_A},
+	{0x0400, SIERRA_TMRVAL_MODE1},
+};
+
+static struct cdns_reg_pairs cdns_pcie_regs[] = {
+	/*
+	 * Write PCIe configuration parameters to the PHY.
+	 * These values are specific to this specific hardware
+	 * configuration.
+	 */
+	{0x891f, SIERRA_DET_STANDEC_D},
+	{0x0053, SIERRA_DET_STANDEC_E},
+	{0x0400, SIERRA_TMRVAL_MODE2},
+	{0x0200, SIERRA_TMRVAL_MODE3},
+};
+
+static const struct cdns_sierra_data cdns_map_sierra = {
+	SIERRA_MACRO_ID,
+	ARRAY_SIZE(cdns_pcie_regs),
+	ARRAY_SIZE(cdns_usb_regs),
+	cdns_pcie_regs,
+	cdns_usb_regs
+};
+
+static const struct of_device_id cdns_sierra_id_table[] = {
+	{
+		.compatible = "cdns,sierra-phy-t0",
+		.data = &cdns_map_sierra,
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(of, cdns_sierra_id_table);
+
+static struct platform_driver cdns_sierra_driver = {
+	.probe		= cdns_sierra_phy_probe,
+	.remove		= cdns_sierra_phy_remove,
+	.driver		= {
+		.name	= "cdns-sierra-phy",
+		.of_match_table = cdns_sierra_id_table,
+	},
+};
+module_platform_driver(cdns_sierra_driver);
+
+MODULE_ALIAS("platform:cdns_sierra");
+MODULE_AUTHOR("Cadence Design Systems");
+MODULE_DESCRIPTION("CDNS sierra phy driver");
+MODULE_LICENSE("GPL v2");
-- 
1.9.0

