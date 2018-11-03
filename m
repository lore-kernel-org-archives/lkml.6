Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E563FC0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 18:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A11412084C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 18:08:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="N9PxIPDk";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="UFDP0VRa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A11412084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728832AbeKDDUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 23:20:09 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:44777 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727281AbeKDDUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 23:20:03 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wA3I49sh028064;
        Sat, 3 Nov 2018 11:07:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=XAxPoCD0kyd6vPN4NXAhjVMT5q0idCMpBPC/DfPb5N0=;
 b=N9PxIPDkHPuQlHTMtTj7Dx5kJCV7qfC9Ryy9aE/eEAbiPaMjTqG604ZkRiJsValU0NXO
 35eoFC2CcR6txnS7kCKNW/3lZi1wuoNJcEEsxdESQ/6dUJXgsoefVQtiZurMzXZlPMlH
 EPfYoADyi/lJrKMZqtLBvyRd45YEyTGJeKnI34nLlT37DuP5N4nvAXEJhiH9kCu/Te3q
 WiG57N8H6/YIh7wYIToGMadzRtyqhFqSbQPSpM36F/EHQ5aZtBXy3ARUjxJRbmnV6oNo
 jim+hqRSEO4FXT3mO50YN0dT0CHNcbN1yr0LHM43uxp8t3soQF8kQEAN8l03/vkEJW7M rw== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp0054.outbound.protection.outlook.com [207.46.163.54])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2nh9ed9ewg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sat, 03 Nov 2018 11:07:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XAxPoCD0kyd6vPN4NXAhjVMT5q0idCMpBPC/DfPb5N0=;
 b=UFDP0VRakBFlJFHAfC38LKFLWnr/sJ3cA2n8E8TbMCocQCd224y/o+H5C5EHcdNQBRjPAnBCX8YpmSq8uZqxx3APsdnz+r2WEptQBTKq51lf1p801mF4H+PFclgIkbzh09GibE8Z9uSqvJO9UTmGnO0ucgM4HcGnpHWywPas5K0=
Received: from BYAPR07CA0036.namprd07.prod.outlook.com (2603:10b6:a02:bc::49)
 by DM5PR07MB4103.namprd07.prod.outlook.com (2603:10b6:4:b3::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1294.21; Sat, 3 Nov
 2018 18:07:54 +0000
Received: from DM3NAM05FT039.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::206) by BYAPR07CA0036.outlook.office365.com
 (2603:10b6:a02:bc::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1294.21 via Frontend
 Transport; Sat, 3 Nov 2018 18:07:54 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 DM3NAM05FT039.mail.protection.outlook.com (10.152.98.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.3 via Frontend Transport; Sat, 3 Nov 2018 18:07:53 +0000
Received: from mailrm1.global.cadence.com (mailrm1.cadence.com [10.209.213.2])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id wA3I7ppP028834
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Sat, 3 Nov 2018 11:07:52 -0700
X-CrossPremisesHeadersFilteredBySendConnector: mailrm1.global.cadence.com
Received: from mailrm1.global.cadence.com (10.209.213.2) by
 mailrm1.global.cadence.com (10.209.213.2) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Sat, 3 Nov 2018 13:52:55 -0400
Received: from rmmaillnx1.cadence.com (10.209.208.46) by
 mailrm1.global.cadence.com (10.209.213.2) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Sat, 3 Nov 2018 13:52:55 -0400
Received: from mailrm1.global.cadence.com (mailrm1.cadence.com [10.209.213.2])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id wA3HqmJa000616
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Sat, 3 Nov 2018 13:52:49 -0400
X-CrossPremisesHeadersFilteredBySendConnector: mailrm1.global.cadence.com
Received: from mailrm1.global.cadence.com (10.209.213.2) by
 mailrm1.global.cadence.com (10.209.213.2) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Sat, 3 Nov 2018 13:52:20 -0400
Received: from rmmaillnx1.cadence.com (10.209.208.46) by
 mailrm1.global.cadence.com (10.209.213.2) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Sat, 3 Nov 2018 13:52:20 -0400
Received: from mailrm1.global.cadence.com (mailrm1.cadence.com [10.209.213.2])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id wA3HqD5S000571
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Sat, 3 Nov 2018 13:52:14 -0400
X-CrossPremisesHeadersFilteredBySendConnector: mailrm1.global.cadence.com
Received: from mailrm1.global.cadence.com (10.209.213.2) by
 mailrm1.global.cadence.com (10.209.213.2) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Sat, 3 Nov 2018 13:52:18 -0400
Received: from rmmaillnx1.cadence.com (10.209.208.46) by
 mailrm1.global.cadence.com (10.209.213.2) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Sat, 3 Nov 2018 13:52:18 -0400
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id wA3Hq9wx000566
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Sat, 3 Nov 2018 13:52:12 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Sat, 3 Nov 2018 18:52:14 +0100
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Sat, 3 Nov 2018 18:52:14 +0100
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id wA3Hq9C6006324;
        Sat, 3 Nov 2018 17:52:09 GMT
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id wA3Hq944006322;
        Sat, 3 Nov 2018 17:52:09 GMT
From:   Pawel Laszczak <pawell@cadence.com>
To:     <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <rogerq@ti.com>,
        <linux-kernel@vger.kernel.org>, <adouglas@cadence.com>,
        <jbergsagel@ti.com>, <peter.chen@nxp.com>, <pjez@cadence.com>,
        <kurahul@cadence.com>, <pawell@cadence.com>
Subject: [RFC PATCH v1 01/14] usb:cdns3: add pci to platform driver wrapper.
Date:   Sat, 3 Nov 2018 17:51:14 +0000
Message-ID: <1541267487-3664-2-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1541267487-3664-1-git-send-email-pawell@cadence.com>
References: <1541267487-3664-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-OrganizationHeadersPreserved: mailrm1.global.cadence.com
X-OrganizationHeadersPreserved: mailrm1.global.cadence.com
X-OrganizationHeadersPreserved: mailrm1.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(136003)(376002)(2980300002)(36092001)(199004)(189003)(2351001)(5660300001)(4326008)(16586007)(107886003)(246002)(2616005)(356004)(86362001)(446003)(11346002)(6666004)(106466001)(26005)(8936002)(8676002)(87636003)(316002)(42186006)(105596002)(217873002)(186003)(478600001)(7636002)(305945005)(54906003)(4720700003)(2906002)(36756003)(47776003)(426003)(336012)(50226002)(6916009)(51416003)(76176011)(48376002)(26826003)(126002)(486006)(50466002)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB4103;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT039;1:oyVMZbXzSuzYoByRLl1gh1fCkkPYhNw8G61mqakFsArgHOTOf5idm15CuZ2R8rzXLX7LwuDxh9ajVIJjZvcKI47ww6l0wMTnO97+2YwYqlv/dh/2oCMRRVo7uyt1m9LY
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8bda561f-dd08-4184-0d0f-08d641b7468d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:DM5PR07MB4103;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB4103;3:GJvcWTPxEvlkzk/N01ikFTAv8OC3yQ2lhrloPWPDkf9SheNjgq4NtAfpmGE2NApHfDPmGC7fiFtgnkKOgvkLH/PWlDxLjEyasNZ9sAaiU/CnfPFMcfM/YjxsBlQdyR4DiqXxz4t7kA87cx4k7Vv8XFiK0nNOrIIzyW4CrzHRKEZE+E25L08kH8i5imZEis3OR8O+N1v9m+t0rOd7zIKt88pBKjrD7nBSGjRvJxFjQsd04UBlNb2UaEo1xqC/IvOItvXwwYNVFOGLhB19EDIHX6YdbvhubgpnTxS0JOBRd5wefx8dwEphX9t05ammedU26JYz4S65Yv6z6IA1bhh68Xp66mHpw1TDjSzJG9xYXKM=;25:ftIZu63dDq0aA7/MV1k8loMLNv7IHPcyxJ9R+L5aaqY5eBkppTkyW9tiT9XwOGcwdyIp+n6E73GEXYk3EN89BGvnOvrgPzSmWPoXv1s8gaDX52xFCeF6dsuEWPG2gBAb592fq88+TvIyJ4xqtzC2ulwFKx+r9fll906OIBq6NNT9F6ghSpxL89e2tc1Ep2vuWo86msluGOmeXLVoazzDJZXtzRzdmoet9NGvujhlxqPDFXHwRlqQYsj2pt3TQKFEig39rLC85x6iYdY3JgB05D9OJNttK1+Rhl6LDq/Luax8ewmt4xQEeb+DlCwnwmO/Iz1zGrFMox6dOWJQI7y60A==
X-MS-TrafficTypeDiagnostic: DM5PR07MB4103:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB4103;31:4M64QUyol32ZiYT96lWe1f9t/eJb99UEoB+rY5ZAcQz8tUP0tUl9CkFP5FR8b4BR+rv09MWo79cIbC2OeS8OUyy5ePdk0CtdLxJdkW2rFyn/+eRovYA8gN9LwS01amePMzVpf7lOPSJU4f1d9BGMf5VbugbTX1U6bDwyZTnmQnYKEOozSyCbg2LUoOYwNfcMuyqo6DXrnLMoYqH+Ia8OV2QZCccOgjQTI8avv89TwzM=;20:m1aRJVBi7iFJqe8mGm9iiez/Scw/zaZyotDN0jllFsrl7d2Rv1FjWaN+7JUrx/7J2DOWNkBG+iaTDGSd5OfYZt2B3cTP+tDB5grg4RptiDqMvQ82WgR51Hex8YHUrtiAKIat1zeFHPcV23y5gtJN0+zRJYmpXOdDymI7YVqKzqAow4SeUYQluXpaAtWjOaO/bt7166GrJJjjnvBlHkfQEQYIX9I5jg+GlSAX/GrhsAHxJvrruA9nZ6CZFiONAqYSjc1er01X8xgmz7ev2W8Avo0CxPjiwRn1akh2hT33SaFqCKq5QqGQwHCg6QLZ5nhoYCPSKBnE50baQQ6KYejXdtXIueYDBo566iKPmJ7Rd9QVqDzRVQ2v1EJ1jUN5yR44cjSSevFdIhps+X/NCV6hkg61zT8gk4+OywcsZuWIusaGd4wpjsf8Jl03vUEKAyHdA1l+ji8GA0iEFzE/qD8ztVUZCUSYULS1QWUUhB5MPXah7T44Lnld+A/p6pR0C5l2
X-Microsoft-Antispam-PRVS: <DM5PR07MB410326711011EDBCB2DA6B49DDC80@DM5PR07MB4103.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93003095)(3231382)(944501410)(52105095)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DM5PR07MB4103;BCL:0;PCL:0;RULEID:;SRVR:DM5PR07MB4103;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB4103;4:UhHgDCSucnOZ6rlzSKspKIi2oGKVi3xkXYqbnxRSl+i+qmx8d2ouGOjveVSs4x2/k9pakPhYAaJbCnDY5Ku+f1rsgK2amLOKFJCkmnvVCXcuX4yIpR6kgv2b9KfZpziWAq55Mqww5tVHCqPCpUkiiU9nWUaH291wNKmklzmyo/64u5s2azoIPZSZM2bMUm7Zb2ysbO03cq8DPwGral1OYrh/VJ05pOKwddFJgcOcvcPTPb1z12dJZXCNgTw9B8eZJQD+Z7ESdSik7iJItmDeIXCW5O4LgreorXx7dQGuKH/6kSAA/COisE5fQK2nZFaR
X-Forefront-PRVS: 08457955C4
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR07MB4103;23:wPzHTCkIQdkyVgSxkH1KhTE3nCOeH67i583CyaW/f?=
 =?us-ascii?Q?6e5qqr4DZ7l4RsWtcZ6/O5+BNIs0kb5UDg7z14fC5IrkQxNAoK1JnlYls76e?=
 =?us-ascii?Q?ZTbQ/k/iMWlUOJdrqqBjhv4MSbIDrU1WjjRLJE5TfmL5ADhX/V1sqKXXxiup?=
 =?us-ascii?Q?fchbybvVAPG9RtosZYs5iJDtCkct8rjta/Se7Po4f7CUX+U0I98/srclFYCU?=
 =?us-ascii?Q?hh+xDWwb1vPu/qoRxQSUY7j3ANDJGaH1Wt+u4XA1gW4OdpxyTHtPQYwQlvHB?=
 =?us-ascii?Q?JCmBfYoa5tWRZ4HVyfDaPJiXgjkhlOJPUuMdk8H89svluwRFZT4WLGo4Qg3f?=
 =?us-ascii?Q?kkxGuuAtFf03J96dttTfYB/RDTUFRDURYxxOwZT2jg5uQoYdXX6Cxv6LDhYJ?=
 =?us-ascii?Q?YZADV1nTOcFB9lqDbSb0NfyDXeDTjOFiOBasQ63b4f/0Sm95rPZx7I4PMKUZ?=
 =?us-ascii?Q?j3Ho4DBZcF9NNaIVU4a8zSRl1W7L6cfooP0vAWb17Mmbum/a1C4r7Gf9KnFB?=
 =?us-ascii?Q?9ETdt/+G0I0X+Z+dQvFMx4/jdUjKhg9fy+B1WJ5Q3b2N3s34DugljdTcTvwF?=
 =?us-ascii?Q?+/LE2eZMBB8vDSF2FofwHDMCepcxGGBziB5EMJDwfVStHJcYJYQyxKKn6VXH?=
 =?us-ascii?Q?b0ONyanQ/gOH6cZG7NNIE66CWKe3WcqQpLSt8u4aZq/7L5hFleM8DRM+tEHQ?=
 =?us-ascii?Q?O8TEQ2gq9EWVjl6IBExB9TZ4vmEVOLRpe610kBMl/QopI6TH31Wo5ZHfp7Io?=
 =?us-ascii?Q?REGILQSOBlmLQu1ycvQyvaXxVlyAavPZvIFq0neEsxLGtLK+VYhHWzrp8cIX?=
 =?us-ascii?Q?eUUdrV+fssD/pyg/a5tWJ7BAPC+v58kkKIzyQddZ3pjDqAh3iM36Tb/vCUaw?=
 =?us-ascii?Q?meYj1eOPIml3fBAaQG0VV/WHpWR9EfDR5nCxgIzpLuTOzSJbKuytLVwPI3Fq?=
 =?us-ascii?Q?by0Cc4Zer3jb9nqyJ83/09WxL6bQJ7+J0RlnI/yxe5s97PmSKUmVEyENnpUw?=
 =?us-ascii?Q?o7T/2876Ce4W2wcvsRIgXTCS5XJXp31WRotpGBQ0Cn7omL3ysxhdSCjf0MY7?=
 =?us-ascii?Q?KDXK/dl8+kM/Y/7takd20be+vUJdjD0Fry1m2uKEaarUdJ2dw18YF/NyviI8?=
 =?us-ascii?Q?OfOWItH22ZYv1lPK7nNxIsr15Pl2Mju?=
X-Microsoft-Antispam-Message-Info: 4HwVFdpXzccvoRb/pTf0JPovE8mApMkBjFt+pSDqSd47h2I1jvpCza4OxgpdCXulXdA9VOXrBad27Z7cLz41ptv7XXq8zuL97k3I1a9Nt2CZCCTpLZORlxyr1ILydS4Zu8hHzahtVFL1nVqMVXXzf8JYGjrqzWVWeaFd/t7hd7FMG0cQFDVN+YFEQlZWEyKTDtYS4mV98znIKvlVKQZJ9SsNEASCWoL+E63O5VAOUrqa+ccUQdAGiYQLD1UZFTk7DnxBVWip0oo6Ks3z1LLRv3F2L9HYzkBzbGPJlf6Z88Pep3Jg0San70cAoPGAM/FFFlx7xj4YQscn+8fsPil3u7G1KlVT/dZ/b245qp+vxd4=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB4103;6:HaklAfVEBiqioXGpnEjAQ0C9R/5fYLiSE6T2PIhNZKYtIuT3He9t+AzvPhAIWB5OmaskgXiGI+RnomhKqyYWeklqwF1NudLIKSkIRY6VuB4OhwoxLDD7ywBe1nXalTBW4iBM4QzM3V8HTF0sxNzbqXkaZ+ZI3JfS2eO6IF+7hCrvu2tvfawtEbxxQLjMCnONlBwMd1cQ86rVigl8mcBU6WrUmjwMGKTWnLPjP5y50+wSAXNZ4sykwm1B66VOO27SbXyFcokzvSY+e4lZ+mGVkjnQ6dGzYZxH0ShgPnp96Mx7XJ0fEXfmahXMhlGI5EkOyrFU8oyyOad9xBJkUsSTrTyYRc9+8FIkmD4r40HBQsxg7KG2MgvZhnNwBE9Zn3uEpHwmD9PhtwF1uABJ4RuF0RK9NgkAr4CqsEKlxgSCvSOEsVRGU6zcGFJBp7JIpSfIq6fkaOoJkF36qagqKl3G9g==;5:C2na7jmNfL3V7f1PkH9WMVpMQv+kOyeI23u4RpewdRtHVONezfiZMcDicqWQ21fKDjr1we6GFApeYmTF4ueOkQpRqUOEqgK/WUGYo/7gfdt/1GAmMm8PXjBnPJwZMfFrKcSo0ahPSz9uBqEKGCTb6oAAuEHMcK898EotHT/kYIk=;7:h25nA7VWBTeJoJZ3HKZMUMWkMggAQ1ap4r/Gc9H3VicZRuL2VioHJeLl/FkFVx+ElDabFxuC5gLg4QQjiTe/ine0FvDj5ZKkTFP+VfAjsRFCwsBOQ0qMFdXx8Vl4jxmSPjqXJ6DwkuWME5MD9Qgqqg==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB4103;20:54+zmjMYBSdk62cNWnuir0FixrEq2Zw9SMqeMS+rCKxmuM4sOHXNfm/soaWxHCrp4C96N8YwjY39mY8MwUbR+RsL6SlSK2hnP2U2mt+SWWUpkjEZtdifkaOfQVC7lwZ2ECQJlZB1PThCsgPABVKf4RxIeack4tXv4AUyLSIuDYsxwTvTX5onNtUomrU2YefIQgehR8RtsfcoM6P2VF2CVUw7dBBtmuAqptsZ5YxH/wAtvQAQBR3G4dti3Yypxwfb
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2018 18:07:53.3910
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bda561f-dd08-4184-0d0f-08d641b7468d
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB4103
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 a:mx-sanjose2.Cadence.COM a:mx-sanjose4.Cadence.COM
 a:mx-sanjose5.Cadence.COM include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-03_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=946 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811030171
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch adds PCI specific glue drivier that creaties and registers in
system cdns-usb3 platform device. Thanks to that we will be able to use
the cdns-usb3 platform driver for USBSS-DEV controller
build on PCI board

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/Kconfig                |   2 +
 drivers/usb/Makefile               |   2 +
 drivers/usb/cdns3/Kconfig          |  24 +++++
 drivers/usb/cdns3/Makefile         |   3 +
 drivers/usb/cdns3/cdns3-pci-wrap.c | 162 +++++++++++++++++++++++++++++
 5 files changed, 193 insertions(+)
 create mode 100644 drivers/usb/cdns3/Kconfig
 create mode 100644 drivers/usb/cdns3/Makefile
 create mode 100644 drivers/usb/cdns3/cdns3-pci-wrap.c

diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
index 987fc5ba6321..5f9334019d04 100644
--- a/drivers/usb/Kconfig
+++ b/drivers/usb/Kconfig
@@ -112,6 +112,8 @@ source "drivers/usb/usbip/Kconfig"
 
 endif
 
+source "drivers/usb/cdns3/Kconfig"
+
 source "drivers/usb/mtu3/Kconfig"
 
 source "drivers/usb/musb/Kconfig"
diff --git a/drivers/usb/Makefile b/drivers/usb/Makefile
index 7d1b8c82b208..82093a60ea2c 100644
--- a/drivers/usb/Makefile
+++ b/drivers/usb/Makefile
@@ -8,6 +8,8 @@
 obj-$(CONFIG_USB)		+= core/
 obj-$(CONFIG_USB_SUPPORT)	+= phy/
 
+obj-$(CONFIG_USB_CDNS3)		+= cdns3/
+
 obj-$(CONFIG_USB_DWC3)		+= dwc3/
 obj-$(CONFIG_USB_DWC2)		+= dwc2/
 obj-$(CONFIG_USB_ISP1760)	+= isp1760/
diff --git a/drivers/usb/cdns3/Kconfig b/drivers/usb/cdns3/Kconfig
new file mode 100644
index 000000000000..888458372adb
--- /dev/null
+++ b/drivers/usb/cdns3/Kconfig
@@ -0,0 +1,24 @@
+config USB_CDNS3
+	tristate "Cadence USB3 Dual-Role Controller"
+	depends on ((USB_XHCI_HCD && USB_GADGET) || (USB_XHCI_HCD && !USB_GADGET) || (!USB_XHCI_HCD && USB_GADGET)) && HAS_DMA
+	help
+	  Say Y here if your system has a cadence USB3 dual-role controller.
+	  It supports: dual-role switch Host-only, and Peripheral-only.
+
+	  If you choose to build this driver is a dynamically linked
+	  module, the module will be called cdns3.ko.
+
+if USB_CDNS3
+
+config USB_CDNS3_PCI_WRAP
+	tristate "PCIe-based Platforms"
+	depends on USB_PCI && ACPI
+	default USB_CDNS3
+	help
+	  If you're using the USBSS Core IP with a PCIe, please say
+	  'Y' or 'M' here.
+
+	  If you choose to build this driver as module it will
+	  be dynamically linked and module will be called cdns3-pci.ko
+
+endif
diff --git a/drivers/usb/cdns3/Makefile b/drivers/usb/cdns3/Makefile
new file mode 100644
index 000000000000..dcdd62003c6a
--- /dev/null
+++ b/drivers/usb/cdns3/Makefile
@@ -0,0 +1,3 @@
+obj-$(CONFIG_USB_CDNS3_PCI_WRAP)	+= cdns3-pci.o
+
+cdns3-pci-y		 		:= cdns3-pci-wrap.o
diff --git a/drivers/usb/cdns3/cdns3-pci-wrap.c b/drivers/usb/cdns3/cdns3-pci-wrap.c
new file mode 100644
index 000000000000..6c229ab6dffb
--- /dev/null
+++ b/drivers/usb/cdns3/cdns3-pci-wrap.c
@@ -0,0 +1,162 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Cadence USBSS PCI Glue driver
+ *
+ * Copyright (C) 2018 Cadence.
+ *
+ * Author: Pawel Laszczak <pawell@cadence.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include <linux/dma-mapping.h>
+#include <linux/slab.h>
+
+struct cdns3_wrap {
+	struct platform_device *plat_dev;
+	struct pci_dev *hg_dev;
+	struct resource dev_res[4];
+};
+
+struct cdns3_wrap wrap;
+
+#define RES_IRQ_ID		0
+#define RES_HOST_ID		1
+#define RES_DEV_ID		2
+#define RES_DRD_ID		3
+
+#define PCI_BAR_HOST		0
+#define PCI_BAR_DEV		2
+#define PCI_BAR_OTG		4
+
+#define PCI_DEV_FN_HOST_DEVICE	0
+#define PCI_DEV_FN_OTG		1
+
+#define PCI_DRIVER_NAME		"cdns3-pci-usbss"
+#define PLAT_DRIVER_NAME	"cdns-usb3"
+
+#define CDNS_VENDOR_ID 0x17cd
+#define CDNS_DEVICE_ID 0x0100
+
+/**
+ * cdns3_pci_probe - Probe function for Cadence USB wrapper driver
+ * @pdev: platform device object
+ * @id: pci device id
+ *
+ * Returns 0 on success otherwise negative errno
+ */
+static int cdns3_pci_probe(struct pci_dev *pdev,
+			   const struct pci_device_id *id)
+{
+	struct platform_device_info plat_info;
+	struct cdns3_wrap *wrap;
+	struct resource *res;
+	int err;
+
+	/*
+	 * for GADGET/HOST PCI (devfn) function number is 0,
+	 * for OTG PCI (devfn) function number is 1
+	 */
+	if (!id || pdev->devfn != PCI_DEV_FN_HOST_DEVICE)
+		return -EINVAL;
+
+	err = pcim_enable_device(pdev);
+	if (err) {
+		dev_err(&pdev->dev, "Enabling PCI device has failed %d\n", err);
+		return err;
+	}
+
+	pci_set_master(pdev);
+	wrap = devm_kzalloc(&pdev->dev, sizeof(*wrap), GFP_KERNEL);
+	if (!wrap) {
+		dev_err(&pdev->dev, "Failed to load PCI module\n");
+		return -ENOMEM;
+	}
+
+	/* function 0: host(BAR_0) + device(BAR_1) + otg(BAR_2)). */
+	memset(wrap->dev_res, 0x00,
+	       sizeof(struct resource) * ARRAY_SIZE(wrap->dev_res));
+	dev_info(&pdev->dev, "Initialize Device resources\n");
+	res = wrap->dev_res;
+
+#if IS_ENABLED(CONFIG_USB_CDNS3_GADGET)
+	res[RES_DEV_ID].start = pci_resource_start(pdev, PCI_BAR_DEV);
+	res[RES_DEV_ID].end =   pci_resource_end(pdev, PCI_BAR_DEV);
+	res[RES_DEV_ID].name = "cdns3-dev-regs";
+	res[RES_DEV_ID].flags = IORESOURCE_MEM;
+	dev_info(&pdev->dev, "USBSS-DEV physical base addr: %pa\n",
+		 &res[RES_DEV_ID].start);
+
+#endif
+
+#if IS_ENABLED(CONFIG_USB_CDNS3_HOST)
+	res[RES_HOST_ID].start = pci_resource_start(pdev, PCI_BAR_HOST);
+	res[RES_HOST_ID].end = pci_resource_end(pdev, PCI_BAR_HOST);
+	res[RES_HOST_ID].name = "cdns3-xhci-regs";
+	res[RES_HOST_ID].flags = IORESOURCE_MEM;
+	dev_info(&pdev->dev, "USBSS-XHCI physical base addr: %pa\n",
+		 &res[RES_HOST_ID].start);
+#endif
+
+	res[RES_DRD_ID].start = pci_resource_start(pdev, PCI_BAR_OTG);
+	res[RES_DRD_ID].end =   pci_resource_end(pdev, PCI_BAR_OTG);
+	res[RES_DRD_ID].name = "cdns3-otg";
+	res[RES_DRD_ID].flags = IORESOURCE_MEM;
+	dev_info(&pdev->dev, "USBSS-DRD physical base addr: %pa\n",
+		 &res[RES_DRD_ID].start);
+
+	/* Interrupt common for both device and XHCI */
+	wrap->dev_res[RES_IRQ_ID].start = pdev->irq;
+	wrap->dev_res[RES_IRQ_ID].name = "cdns3-irq";
+	wrap->dev_res[RES_IRQ_ID].flags = IORESOURCE_IRQ;
+
+	/* set up platform device info */
+	memset(&plat_info, 0, sizeof(plat_info));
+	plat_info.parent = &pdev->dev;
+	plat_info.fwnode = pdev->dev.fwnode;
+	plat_info.name = PLAT_DRIVER_NAME;
+	plat_info.id = pdev->devfn;
+	plat_info.res = wrap->dev_res;
+	plat_info.num_res = ARRAY_SIZE(wrap->dev_res);
+	plat_info.dma_mask = pdev->dma_mask;
+
+	/* register platform device */
+	wrap->plat_dev = platform_device_register_full(&plat_info);
+	if (IS_ERR(wrap->plat_dev)) {
+		err = PTR_ERR(wrap->plat_dev);
+		return err;
+	}
+
+	pci_set_drvdata(pdev, wrap);
+
+	return err;
+}
+
+void cdns3_pci_remove(struct pci_dev *pdev)
+{
+	struct cdns3_wrap *wrap = (struct cdns3_wrap *)pci_get_drvdata(pdev);
+
+	platform_device_unregister(wrap->plat_dev);
+}
+
+static const struct pci_device_id cdns3_pci_ids[] = {
+	{ PCI_DEVICE(CDNS_VENDOR_ID, CDNS_DEVICE_ID), },
+	{ 0, }
+};
+
+static struct pci_driver cdns3_pci_driver = {
+	.name = PCI_DRIVER_NAME,
+	.id_table = cdns3_pci_ids,
+	.probe = cdns3_pci_probe,
+	.remove = cdns3_pci_remove,
+};
+
+module_pci_driver(cdns3_pci_driver);
+MODULE_DEVICE_TABLE(pci, cdns3_pci_ids);
+
+MODULE_AUTHOR("Pawel Laszczak <pawell@cadence.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Cadence USBSS PCI wrapperr");
+
-- 
2.17.1

