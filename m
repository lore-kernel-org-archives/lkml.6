Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B611C0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 17:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEC0A20833
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 17:52:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="pJTcVpg5";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="oF5s7NOh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEC0A20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728876AbeKDDEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 23:04:36 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:40114 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728723AbeKDDEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 23:04:35 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wA3HmkV5013631;
        Sat, 3 Nov 2018 10:52:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=yPJGlb5ulKqMVavi7wS9bV4rckwPyMRDqxTrl81Cagk=;
 b=pJTcVpg5sP80rQYoUl8MItxFy5WTk1YdL1RR/iphIPJbFOp3/6jlYQXEKB+qPBNImtyu
 WI3nqM6btHo5xYKKwyuH4JRrqSrzZOtGjoAyNUkkFusB9r5pfcjFQi8CHogHkCkum5mT
 +3v6deaWltO6M6e6tdlWdH+/+P0zzdvBuxnz50YeUdiM9a8Kcw+DI3tjfMmVIzuDh/6H
 kioTfPaXqRs0kTiazZ/4N7EwnZlzNBXfEl+s0cC2DqkutYVfrVlIpwMW8zgFtCDj51km
 s7LsSsRHtsm9+kT1cuo35tj7yCvJ9JCGru/w6E/1E93xujOFJLj95aF8abFerTeodb2c PA== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam01-by2-obe.outbound.protection.outlook.com (mail-by2nam01lp0177.outbound.protection.outlook.com [216.32.181.177])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2nh9ed9dn2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sat, 03 Nov 2018 10:52:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yPJGlb5ulKqMVavi7wS9bV4rckwPyMRDqxTrl81Cagk=;
 b=oF5s7NOhZc8kFQqgohSgGDbR/o0+USbtN5daO7L7gtmu6aUoDWue8a5/4DEtw+KqGdh99bru3ukRACxE1scT8r9Dsh7UH/dnVbn1QVl6U6EqvJ/UADdFcel1so5x3KYANCGtptyOunhZDX6VZkrsNc0hpAKvfTVk9EWTZu7DyCE=
Received: from DM5PR07CA0077.namprd07.prod.outlook.com (2603:10b6:4:ad::42) by
 DM5PR07MB4104.namprd07.prod.outlook.com (2603:10b6:4:b3::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.21; Sat, 3 Nov 2018 17:52:28 +0000
Received: from CO1NAM05FT038.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::206) by DM5PR07CA0077.outlook.office365.com
 (2603:10b6:4:ad::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1294.20 via Frontend
 Transport; Sat, 3 Nov 2018 17:52:27 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 CO1NAM05FT038.mail.protection.outlook.com (10.152.96.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1318.5 via Frontend Transport; Sat, 3 Nov 2018 17:52:27 +0000
Received: from mailrm1.global.cadence.com (mailrm1.cadence.com [10.209.213.2])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id wA3HqPd2009434
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Sat, 3 Nov 2018 10:52:26 -0700
X-CrossPremisesHeadersFilteredBySendConnector: mailrm1.global.cadence.com
Received: from mailrm1.global.cadence.com (10.209.213.2) by
 mailrm1.global.cadence.com (10.209.213.2) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Sat, 3 Nov 2018 13:52:30 -0400
Received: from rmmaillnx1.cadence.com (10.209.208.46) by
 mailrm1.global.cadence.com (10.209.213.2) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Sat, 3 Nov 2018 13:52:30 -0400
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id wA3Hq9x9000566
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Sat, 3 Nov 2018 13:52:23 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Sat, 3 Nov 2018 18:52:17 +0100
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Sat, 3 Nov 2018 18:52:17 +0100
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id wA3HqCjU006528;
        Sat, 3 Nov 2018 17:52:12 GMT
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id wA3HqCv0006525;
        Sat, 3 Nov 2018 17:52:12 GMT
From:   Pawel Laszczak <pawell@cadence.com>
To:     <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <rogerq@ti.com>,
        <linux-kernel@vger.kernel.org>, <adouglas@cadence.com>,
        <jbergsagel@ti.com>, <peter.chen@nxp.com>, <pjez@cadence.com>,
        <kurahul@cadence.com>, <pawell@cadence.com>
Subject: [RFC PATCH v1 11/14] usb:cdns3: Adds enumeration related function.
Date:   Sat, 3 Nov 2018 17:51:24 +0000
Message-ID: <1541267487-3664-12-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1541267487-3664-1-git-send-email-pawell@cadence.com>
References: <1541267487-3664-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-OrganizationHeadersPreserved: mailrm1.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(376002)(136003)(2980300002)(189003)(199004)(36092001)(6666004)(16586007)(42186006)(316002)(246002)(356004)(26005)(54906003)(5660300001)(4744004)(36756003)(305945005)(50466002)(48376002)(107886003)(76176011)(51416003)(105596002)(2351001)(8676002)(2906002)(7636002)(8936002)(26826003)(50226002)(106466001)(14444005)(478600001)(87636003)(6916009)(486006)(4720700003)(186003)(426003)(476003)(2616005)(126002)(446003)(11346002)(336012)(4326008)(217873002)(47776003)(86362001)(309714004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB4104;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM05FT038;1:04uLrrO18JfFUMa6/r86GLysbjv+kZLCZO1k6IUiuFwtD3bJfZwXvgT1/rI2l85dTmrr+6zXqywFjy2oE+lXKYf8MljsaIfpBxSq4lINRjc+YF4zGklSPbT8P7d9fkTz
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18f3b72f-ae0c-4992-f66a-08d641b51e9b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:DM5PR07MB4104;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB4104;3:imxNEqzl6siVKTX8QW4o3TGUJnIC2GrDZkPv5pugO0/05Yd+9XdO61WyY511xsQAtXgA4HQ8o+WqrHiyXOAxnOX1rCbJPGWx9fhGJyk+K9dgOmI+Kpd15X3NldYEr92WJhqOSr+qa+qmqRYYz7GkAWV4x+3VDvCfO3iUqTXB9QloN+9eBN8eBQPbU/RVVcr7EeS4dJZIu1ELoJo9W4lSEDDEA4ZfsMJiPOJbSZLFCbe84RFtvjFyPuzBvFH0otkEykcuCmTkbT59ynFGGh0KwnAQ9AnYCY4id+qr7F1km1npFwZSTFPBxaQ7mimy9THz+BHp/YvupCJZIZRIU6FQe1FRMoAPPNEpdtpeJK4OoIY=;25:AR1bJiiXz4qD9hozbMwcNFmP7CxghVj5HRWY52vgVmypuKbEEAcWCzQeC687koXw0bjv9d8IJFzKrRPuiE5xONAfPJnJCL+YBkLY76HSqKvnwmg0i2GXv8VDJxTDnQhRrt7BSSmitj7KOaTC5mCeEXPK65aMa507MFRQXQiMmL3sMd25SNlARC0MEmWYLRAX/T6YNJBmXwqFCnuP62L2FDuIM3myCSo0gAq4nRYHjwF4D+PnNRRGDuwLwjd+Xx6/HpNFvaCYcsHoa6HWnHoTtsLoXDwoDJ6+lzq+NgqoKIY+4cIE9R6L4RU64rhvbec/Dx7DPu9iRNnezkxsOEDIEw==
X-MS-TrafficTypeDiagnostic: DM5PR07MB4104:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB4104;31:THSt08X/sFoluddM2kc+OqgPNEAoc1H4sGDdxl+zjKsQ7+mAIneMG8xHVlbJhh/G1teI8ZNlW3eoMtBBthAEPAe+n/8QqbHDdsrqG9kwOClHHfoue0I1qJGzqW4OJjcj96ydNGTgVztpogap64E5egl6qLXMe3qDfLDWaTHGSZSAw3nr/oAXKkHK6BgwnoLO5u52qOIgzBl6Du8vkYYcsrzYszipxfIXSBNwfofY7sg=;20:j37zbeqv5CSiRAxQf7Vu4yvpnr9ZGeO9s1EkZzU99xx03vOb5JAIqgINOgEluvaWR3zQ9YfsVOoatpq5SereO+uSoE6Aaa7cGJbk9uikDRXYDayvSZlw6ka63xT2kegeoHt0GXkmZp5PPCQNo/YnFieik9amt9SKhWnILI1xJN3bhcFX6/vlP1441fysmL53aigo/rz8iJBG35iBJz1PQkXgYwG82C6sDgqJqnk07e1cqI2eaAGOOMmWKdXU+SoIUjWo72pNNhwF3Mno57in8orlZ3chFLRfSTlyakrjgAYlqQa19+rqL6FlXT7jM3kjc6/ZhT4gWFviATL6jN5bj/F29TfmdkxCrCzYYMSzxXzqSB0ueo7YvKLA/ZZibdggL6BJ+fzMcHkjAZztp2uHJtJyvm9bU53tcF6izQ3CHHgg9dZjWuB70sJrP6r95zv+WDp0NIJCE/LImaCAjQzlbepf4lFVrt9WAVUsSUDvq1Q+yJ27iP2HyUyh3xL8cQe7
X-Microsoft-Antispam-PRVS: <DM5PR07MB410481E7AD0EF03438C9705DDDC80@DM5PR07MB4104.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110)(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93003095)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DM5PR07MB4104;BCL:0;PCL:0;RULEID:;SRVR:DM5PR07MB4104;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB4104;4:g4J3VmtOTVkXXJTlDkWC3uuATutIVAuyiB0BmyhScPSO9YvKCvFt9YOtRhliM0JrO634DpFnTbS8IiekM5UgIn0EbFhxPhD+5yDG1Xbrmx9VDRcLspmBgzmUf8VrNoqO/Uv97IL36qGokZuXGO23IbDFBFFxqPiH0u2CR5fGa6z1lN1eKTlWub7UVVzmdeMKxeajp4z/M+e3Ny2N69YUc5zz4deNtYRJTDNDUftQa1CP5lCXl9YxfhSBzm2coVVjbmMqnpuwn9tYtYI4Uj5sRSTDBsztum0qsgrUGwoZDobjJ3hJ31nm+6DkCDXiw+At84I+vL5AUq858mXxHKFLwGpbrsU028vBe1aVcLU27LY=
X-Forefront-PRVS: 08457955C4
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR07MB4104;23:Fpq9JSW570ZzCLY4lx5Ou9aCVOG8gbcsn2KeETBDI?=
 =?us-ascii?Q?Atqv49GSQxjkR3B1izsBaNWkKawQXS1mKepdW2M+iILyid2xdQ9MROxMRBcy?=
 =?us-ascii?Q?zG768y32kJVNUtDW25hPhMK/zh2WqpJrKBRzTe0y83XXBY8bWCJgrIX+etlK?=
 =?us-ascii?Q?gZm7Yv9dF2gmLm7hzla4L1yvGibSPK1XqHVzLzdoe8BSfIf+fdrvTRWw0dxv?=
 =?us-ascii?Q?sZszt7d3ejx+wk4YXWqBXmoWexh68fCu/PfNlZy8ZulT3RDIUWlbszn9dPJm?=
 =?us-ascii?Q?GtPOzuuegeikvL+bgpPRIXqYMdJ196oe1d+pm1KCH8vbJ6Vy4g2nf3wd3LRX?=
 =?us-ascii?Q?FkwQ6G5Ka2JNxclblVYyQIYbwTkNguznXMUwAcRHOKyrVm7+LGrLxhhiPz9f?=
 =?us-ascii?Q?zaJ7x414BvskEm2u7hILPWyyrzp8myawaRipfRwQ8QJGVysRIrpJVqMQFc9A?=
 =?us-ascii?Q?pBakM1OdYDdzkclXbOyN36yhsddQwGNIU1D067HOwSi4i6bywBlilyh5VyH2?=
 =?us-ascii?Q?1oGV8ScVmsTdfTQb2AnsosOLp8CZ/MVa5HsTmzeFpK+Ui1iAt2DMxg7MHCqZ?=
 =?us-ascii?Q?ImU71UPGneEit/LTxELarFeK79Vh8rxa0gugvMDIC0thXK1sN4V2DbYazzaw?=
 =?us-ascii?Q?+wMvs68DpTPQC6LYbZnSnB6oNpeBkU1//3bOTN03fUpwHdJuM/gNW7HQN9DE?=
 =?us-ascii?Q?o9+U6W6IdSJYPYC/LU2j/nVKKykL789nwTUByByg4cwtfw4Lnt91Pkm/OBgF?=
 =?us-ascii?Q?zPxTE3Cbb66olyvC/3ljnlX2p2VR2zGRXa7NHjPsyiHkceK2na9wPD2sLDrP?=
 =?us-ascii?Q?XGsnNrl6/rcuNw9vTMI+bd3ajUB88XsPtVzB4YmYYTzP3ywR/PhW5yYC32ul?=
 =?us-ascii?Q?AKaYA3cdeFc1CJ10qE+/nNyjIgHr5kCdN+2k2v+aEoQFDkcLw7rK7ABKAF4B?=
 =?us-ascii?Q?/TAOqM9YLhpkciHWGJOp1kfYHItu1PWRzOsHadFfvIsEdF1+4mDs1+aMaE1m?=
 =?us-ascii?Q?5tsZbUFxo9vyIM22u+WUxDW21EBCcvIGPUDu9gwlgsB97DUKY1NansN4VAlq?=
 =?us-ascii?Q?yjJvKVMf5vBkBMM9ach8j7K0c5YkYFq1pB/cFRhQuuX2rDSR3Bb6d3QZbHOX?=
 =?us-ascii?Q?vr1VViTqzXhyN9NHVAlO+GsIGqF4v4fz5CKLxZIcn/QPUXjCEI20GWDpVr86?=
 =?us-ascii?Q?7OJkpn19yRtzEZHODtpRNx6wBWmEF8Qyl0p?=
X-Microsoft-Antispam-Message-Info: +iDGpktr0BSW6Q+WAgeP27d848IN/5Dtw28cvH30nKyDh51mBEBrMZR9Yzll/lzrfrIuogdo4+EGwZElnna7o5Ct3O/kBXUo8kzxAFz2r/OckT7dd1YEB4DwTB4YYqxGMBFAsSTLQJ7z/dgHp+/fgh/dyvJkLlb2EXFLaKSoe5GGoPvGs4iYH7CCymK3KFTcqBxCiUcHZNqEozm0QXqSaML2S9Tw8+NbEfNH4+Hh8TFF0nQXNgzpFHsQBj8C2HKzJbnY89neM/brmrBdrgAegDgXnyxTOs4iHGbrcMJTt9XSl6/V4MHuoeb2Wg6Bi2ZficZq6dP+y8u240YfnQOYr610FhULOw8jJPO4McHlk3M=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB4104;6:EraNcU9Uhxzt7KkERklommtB18zpx/2y5Lk1Qx5g4ewlpEwOjIoT+ys2x/5CC4+O2yLNw0uZB37ES/a2X+yO2zHpLsjr0hcbbb654cVB+yD5C4UKZ8KecT3qfD3WKcKhGUQ7lEzSya5uC0n8IaGO75kFCGn5I2ykfpg1QWmxfDxaQjk0+uF2f0gxnrokiAVkouJifdk4yWbgEiMf7s2i7eIoVXTtmGWjnyIJMoKsihMu9D8zQPxJwpFojoLqoTn0xorNtN1GoY5bt5KsIugTUspGUB8x7p5LrcqTNqWbh/0WZv/7rYu057bJtZU5gcxQqbE8tnN9LaKuVRmf3V0E6IB8D+wuSs7i375Ueq2qLj9DMRY5g7joXI73FwuxE734As/4uS5LWK9ufcvqXW11brtj3aTA7/T+xLisJTR5VbrLZsDkQgzbpfXv1QYkGKm2CU8T7e0Q8xigmo/+9rNcng==;5:Alf7IUsyvyH1I6Eq5kaxMIv9Q16MHjhfnpDJU1J8OULH4XAQSOsIBvhqvf3TT6roYM+solUF7/sKs+y3KiynwMgY84BwRhXZHbrcFCW5Q2kpqU7Ox9QF66uvQuHLlVDGnWxWDFhBhx7qrkcqzo1i3ntWKbOzqjFhah06chsDjxk=;7:vjReAZ58LIoVYJSUjXvMPd2SslOcbwY+xmm9bBPnTZRw0+AqdGPBE/RTOXhSNik4NlSuupLhIGfqm0mSqseuGihbAMPMQUXGyW0kwoInlSe4Mm1QTioWHI8lp48aVih30yHlfRohL1hCNd8yaIfuMw==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB4104;20:pCqnWsNVl9d6vFBZhO/PbpKCxHeFYJCKbE4faP5HomVA5V7OZw1WpJp01WaI7mrR/sXCsVYHoLtMhojs5ppXbuXa9cIJ+k9i5OkFNFYxPZhAOTsMZQZrRreHP4WpzDledqz4c0aui5y1siOfo3m80tAELFcZXT5CWkQyfovtE9kjz5CQ4mhRYJLr/nFwRoEW0RL+QRCM3UO8aIv75GWMsHS3Vp2GPtYi9n60/xb3nja3F1mJVE67Q1A9B50yi7E5
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2018 17:52:27.5271
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18f3b72f-ae0c-4992-f66a-08d641b51e9b
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB4104
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
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811030169
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch implements a set of function related to enumeration process.
Some standard requests are handled on controller driver level and
other are delegated to gadget core driver.
All class requests are delegated to gadget core driver.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/cdns3/ep0.c    | 490 ++++++++++++++++++++++++++++++++++++-
 drivers/usb/cdns3/gadget.c | 119 +++++++++
 drivers/usb/cdns3/gadget.h |   4 +
 3 files changed, 609 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/cdns3/ep0.c b/drivers/usb/cdns3/ep0.c
index 369bd6748416..555ac7f6842e 100644
--- a/drivers/usb/cdns3/ep0.c
+++ b/drivers/usb/cdns3/ep0.c
@@ -10,6 +10,7 @@
  *	    Peter Chen <peter.chen@nxp.com>
  */
 
+#include <linux/usb/composite.h>
 #include "gadget.h"
 
 static struct usb_endpoint_descriptor cdns3_gadget_ep0_desc = {
@@ -52,9 +53,31 @@ static void cdns3_ep0_run_transfer(struct cdns3_device *priv_dev,
 		writel(EP_CMD_ERDY, &priv_dev->regs->ep_cmd);
 }
 
+/**
+ * cdns3_ep0_delegate_req - Returns status of handling setup packet
+ * Setup is handled by gadget driver
+ * @priv_dev: extended gadget object
+ * @ctrl_req: pointer to received setup packet
+ *
+ * Returns zero on success or negative value on failure
+ */
+static int cdns3_ep0_delegate_req(struct cdns3_device *priv_dev,
+				  struct usb_ctrlrequest *ctrl_req)
+{
+	int ret;
+
+	spin_unlock(&priv_dev->lock);
+	priv_dev->setup_pending = 1;
+	ret = priv_dev->gadget_driver->setup(&priv_dev->gadget, ctrl_req);
+	priv_dev->setup_pending = 0;
+	spin_lock(&priv_dev->lock);
+	return ret;
+}
+
 static void cdns3_prepare_setup_packet(struct cdns3_device *priv_dev)
 {
-	//TODO: Implements this function
+	priv_dev->ep0_data_dir = 0;
+	cdns3_ep0_run_transfer(priv_dev, priv_dev->setup_dma, 8, 0);
 }
 
 static void cdns3_set_hw_configuration(struct cdns3_device *priv_dev)
@@ -90,9 +113,430 @@ static void cdns3_set_hw_configuration(struct cdns3_device *priv_dev)
 	}
 }
 
+/**
+ * cdns3_req_ep0_set_configuration - Handling of SET_CONFIG standard USB request
+ * @priv_dev: extended gadget object
+ * @ctrl_req: pointer to received setup packet
+ *
+ * Returns 0 if success, 0x7FFF on deferred status stage, error code on error
+ */
+static int cdns3_req_ep0_set_configuration(struct cdns3_device *priv_dev,
+					   struct usb_ctrlrequest *ctrl_req)
+{
+	enum usb_device_state device_state = priv_dev->gadget.state;
+	struct cdns3_endpoint *priv_ep, *temp_ep;
+	u32 config = le16_to_cpu(ctrl_req->wValue);
+	int result = 0;
+
+	switch (device_state) {
+	case USB_STATE_ADDRESS:
+		/* Configure non-control EPs */
+		list_for_each_entry_safe(priv_ep, temp_ep,
+					 &priv_dev->ep_match_list,
+					 ep_match_pending_list)
+			cdns3_ep_config(priv_ep);
+
+		result = cdns3_ep0_delegate_req(priv_dev, ctrl_req);
+
+		if (result)
+			return result;
+
+		if (config) {
+			cdns3_set_hw_configuration(priv_dev);
+		} else {
+			cdns3_gadget_unconfig(priv_dev);
+			usb_gadget_set_state(&priv_dev->gadget,
+					     USB_STATE_ADDRESS);
+		}
+		break;
+	case USB_STATE_CONFIGURED:
+		result = cdns3_ep0_delegate_req(priv_dev, ctrl_req);
+
+		if (!config && !result) {
+			cdns3_gadget_unconfig(priv_dev);
+			usb_gadget_set_state(&priv_dev->gadget,
+					     USB_STATE_ADDRESS);
+		}
+		break;
+	default:
+		result = -EINVAL;
+	}
+
+	return result;
+}
+
+/**
+ * cdns3_req_ep0_set_address - Handling of SET_ADDRESS standard USB request
+ * @priv_dev: extended gadget object
+ * @ctrl_req: pointer to received setup packet
+ *
+ * Returns 0 if success, error code on error
+ */
+static int cdns3_req_ep0_set_address(struct cdns3_device *priv_dev,
+				     struct usb_ctrlrequest *ctrl_req)
+{
+	enum usb_device_state device_state = priv_dev->gadget.state;
+	u32 reg;
+	u32 addr;
+
+	addr = le16_to_cpu(ctrl_req->wValue);
+
+	if (addr > DEVICE_ADDRESS_MAX) {
+		dev_err(&priv_dev->dev,
+			"Device address (%d) cannot be greater than %d\n",
+			addr, DEVICE_ADDRESS_MAX);
+		return -EINVAL;
+	}
+
+	if (device_state == USB_STATE_CONFIGURED) {
+		dev_err(&priv_dev->dev, "USB device already configured\n");
+		return -EINVAL;
+	}
+
+	reg = readl(&priv_dev->regs->usb_cmd);
+
+	writel(reg | USB_CMD_FADDR(addr) | USB_CMD_SET_ADDR,
+	       &priv_dev->regs->usb_cmd);
+
+	usb_gadget_set_state(&priv_dev->gadget,
+			     (addr ? USB_STATE_ADDRESS : USB_STATE_DEFAULT));
+
+	cdns3_prepare_setup_packet(priv_dev);
+
+	writel(EP_CMD_ERDY | EP_CMD_REQ_CMPL, &priv_dev->regs->ep_cmd);
+
+	return 0;
+}
+
+/**
+ * cdns3_req_ep0_get_status - Handling of GET_STATUS standard USB request
+ * @priv_dev: extended gadget object
+ * @ctrl_req: pointer to received setup packet
+ *
+ * Returns 0 if success, error code on error
+ */
+static int cdns3_req_ep0_get_status(struct cdns3_device *priv_dev,
+				    struct usb_ctrlrequest *ctrl)
+{
+	__le16 *response_pkt;
+	u16 usb_status = 0;
+	u32 recip;
+	u32 reg;
+
+	recip = ctrl->bRequestType & USB_RECIP_MASK;
+
+	switch (recip) {
+	case USB_RECIP_DEVICE:
+		/* self powered */
+		usb_status |= priv_dev->gadget.is_selfpowered;
+
+		if (priv_dev->gadget.speed != USB_SPEED_SUPER)
+			break;
+
+		reg = readl(&priv_dev->regs->usb_sts);
+
+		if (USB_STS_U2ENS(reg))
+			usb_status |= BIT(USB_DEV_STAT_U1_ENABLED);
+
+		if (USB_STS_U2ENS(reg))
+			usb_status |= BIT(USB_DEV_STAT_U2_ENABLED);
+
+		if (priv_dev->wake_up_flag)
+			usb_status |= BIT(USB_DEVICE_REMOTE_WAKEUP);
+		break;
+	case USB_RECIP_INTERFACE:
+		return cdns3_ep0_delegate_req(priv_dev, ctrl);
+	case USB_RECIP_ENDPOINT:
+		/* check if endpoint is stalled */
+		cdns3_select_ep(priv_dev, ctrl->wIndex);
+		if (EP_STS_STALL(readl(&priv_dev->regs->ep_sts)))
+			usb_status =  BIT(USB_ENDPOINT_HALT);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	response_pkt = (__le16 *)priv_dev->setup;
+	*response_pkt = cpu_to_le16(usb_status);
+
+	cdns3_ep0_run_transfer(priv_dev, priv_dev->setup_dma,
+			       sizeof(*response_pkt), 1);
+	return 0;
+}
+
+static int cdns3_ep0_feature_handle_device(struct cdns3_device *priv_dev,
+					   struct usb_ctrlrequest *ctrl,
+					   int set)
+{
+	enum usb_device_state state;
+	enum usb_device_speed speed;
+	int ret = 0;
+	u32 wValue;
+	u32 wIndex;
+	u16 tmode;
+
+	wValue = le16_to_cpu(ctrl->wValue);
+	wIndex = le16_to_cpu(ctrl->wIndex);
+	state = priv_dev->gadget.state;
+	speed = priv_dev->gadget.speed;
+
+	switch (ctrl->wValue) {
+	case USB_DEVICE_REMOTE_WAKEUP:
+		priv_dev->wake_up_flag = !!set;
+		break;
+	case USB_DEVICE_U1_ENABLE:
+		if (state != USB_STATE_CONFIGURED || speed != USB_SPEED_SUPER)
+			return -EINVAL;
+
+		cdns3_set_register_bit(&priv_dev->regs->usb_conf,
+				       (set) ? USB_CONF_U1EN : USB_CONF_U1DS);
+		break;
+	case USB_DEVICE_U2_ENABLE:
+		if (state != USB_STATE_CONFIGURED || speed != USB_SPEED_SUPER)
+			return -EINVAL;
+
+		cdns3_set_register_bit(&priv_dev->regs->usb_conf,
+				       (set) ? USB_CONF_U2EN : USB_CONF_U2DS);
+		break;
+	case USB_DEVICE_LTM_ENABLE:
+		ret = -EINVAL;
+		break;
+	case USB_DEVICE_TEST_MODE:
+		if (state != USB_STATE_CONFIGURED || speed > USB_SPEED_HIGH)
+			return -EINVAL;
+
+		tmode = le16_to_cpu(ctrl->wIndex);
+
+		if (!set || (tmode & 0xff) != 0)
+			return -EINVAL;
+
+		switch (tmode >> 8) {
+		case TEST_J:
+		case TEST_K:
+		case TEST_SE0_NAK:
+		case TEST_PACKET:
+			cdns3_set_register_bit(&priv_dev->regs->usb_cmd,
+					       USB_CMD_STMODE |
+					       USB_STS_TMODE_SEL(tmode - 1));
+			break;
+		default:
+			ret = -EINVAL;
+		}
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static int cdns3_ep0_feature_handle_intf(struct cdns3_device *priv_dev,
+					 struct usb_ctrlrequest *ctrl,
+					 int set)
+{
+	u32 wValue;
+	int ret = 0;
+
+	wValue = le16_to_cpu(ctrl->wValue);
+
+	switch (wValue) {
+	case USB_INTRF_FUNC_SUSPEND:
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static int cdns3_ep0_feature_handle_endpoint(struct cdns3_device *priv_dev,
+					     struct usb_ctrlrequest *ctrl,
+					     int set)
+{
+	struct cdns3_endpoint *priv_ep;
+	int ret = 0;
+	u8 index;
+
+	index = cdns3_ep_addr_to_index(ctrl->wIndex);
+	priv_ep = priv_dev->eps[index];
+
+	cdns3_select_ep(priv_dev, ctrl->wIndex);
+
+	if (le16_to_cpu(ctrl->wValue) != USB_ENDPOINT_HALT)
+		return -EINVAL;
+
+	if (set) {
+		writel(EP_CMD_SSTALL, &priv_dev->regs->ep_cmd);
+		priv_ep->flags |= EP_STALL;
+	} else {
+		struct usb_request *request;
+
+		if (priv_dev->eps[index]->flags & EP_WEDGE) {
+			cdns3_select_ep(priv_dev, 0x00);
+			return 0;
+		}
+
+		writel(EP_CMD_CSTALL | EP_CMD_EPRST, &priv_dev->regs->ep_cmd);
+
+		/* wait for EPRST cleared */
+		ret = cdns3_handshake(&priv_dev->regs->ep_cmd,
+				      EP_CMD_EPRST, 0, 100);
+		if (ret)
+			return -EINVAL;
+
+		priv_ep->flags &= ~EP_STALL;
+
+		request = cdns3_next_request(&priv_ep->request_list);
+		if (request)
+			cdns3_ep_run_transfer(priv_ep, request);
+	}
+	return ret;
+}
+
+/**
+ * cdns3_req_ep0_handle_feature -
+ * Handling of GET/SET_FEATURE standard USB request
+ *
+ * @priv_dev: extended gadget object
+ * @ctrl_req: pointer to received setup packet
+ * @set: must be set to 1 for SET_FEATURE request
+ *
+ * Returns 0 if success, error code on error
+ */
+static int cdns3_req_ep0_handle_feature(struct cdns3_device *priv_dev,
+					struct usb_ctrlrequest *ctrl,
+					int set)
+{
+	int ret = 0;
+	u32 recip;
+
+	recip = ctrl->bRequestType & USB_RECIP_MASK;
+
+	switch (recip) {
+	case USB_RECIP_DEVICE:
+		ret = cdns3_ep0_feature_handle_device(priv_dev, ctrl, set);
+		break;
+	case USB_RECIP_INTERFACE:
+		ret = cdns3_ep0_feature_handle_intf(priv_dev, ctrl, set);
+		break;
+	case USB_RECIP_ENDPOINT:
+		ret = cdns3_ep0_feature_handle_endpoint(priv_dev, ctrl, set);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (!ret)
+		writel(EP_CMD_ERDY | EP_CMD_REQ_CMPL, &priv_dev->regs->ep_cmd);
+
+	return ret;
+}
+
+/**
+ * cdns3_req_ep0_set_sel - Handling of SET_SEL standard USB request
+ * @priv_dev: extended gadget object
+ * @ctrl_req: pointer to received setup packet
+ *
+ * Returns 0 if success, error code on error
+ */
+static int cdns3_req_ep0_set_sel(struct cdns3_device *priv_dev,
+				 struct usb_ctrlrequest *ctrl_req)
+{
+	if (priv_dev->gadget.state < USB_STATE_ADDRESS)
+		return -EINVAL;
+
+	if (ctrl_req->wLength != 6) {
+		dev_err(&priv_dev->dev, "Set SEL should be 6 bytes, got %d\n",
+			ctrl_req->wLength);
+		return -EINVAL;
+	}
+
+	priv_dev->ep0_data_dir = 0;
+	cdns3_ep0_run_transfer(priv_dev, priv_dev->setup_dma, 6, 1);
+	return 0;
+}
+
+/**
+ * cdns3_req_ep0_set_isoch_delay -
+ * Handling of GET_ISOCH_DELAY standard USB request
+ * @priv_dev: extended gadget object
+ * @ctrl_req: pointer to received setup packet
+ *
+ * Returns 0 if success, error code on error
+ */
+static int cdns3_req_ep0_set_isoch_delay(struct cdns3_device *priv_dev,
+					 struct usb_ctrlrequest *ctrl_req)
+{
+	if (ctrl_req->wIndex || ctrl_req->wLength)
+		return -EINVAL;
+
+	priv_dev->isoch_delay = ctrl_req->wValue;
+	writel(EP_CMD_ERDY | EP_CMD_REQ_CMPL, &priv_dev->regs->ep_cmd);
+	return 0;
+}
+
+/**
+ * cdns3_ep0_standard_request - Handling standard USB requests
+ * @priv_dev: extended gadget object
+ * @ctrl_req: pointer to received setup packet
+ *
+ * Returns 0 if success, error code on error
+ */
+static int cdns3_ep0_standard_request(struct cdns3_device *priv_dev,
+				      struct usb_ctrlrequest *ctrl_req)
+{
+	int ret;
+
+	switch (ctrl_req->bRequest) {
+	case USB_REQ_SET_ADDRESS:
+		ret = cdns3_req_ep0_set_address(priv_dev, ctrl_req);
+		break;
+	case USB_REQ_SET_CONFIGURATION:
+		ret = cdns3_req_ep0_set_configuration(priv_dev, ctrl_req);
+		break;
+	case USB_REQ_GET_STATUS:
+		ret = cdns3_req_ep0_get_status(priv_dev, ctrl_req);
+		break;
+	case USB_REQ_CLEAR_FEATURE:
+		ret = cdns3_req_ep0_handle_feature(priv_dev, ctrl_req, 0);
+		break;
+	case USB_REQ_SET_FEATURE:
+		ret = cdns3_req_ep0_handle_feature(priv_dev, ctrl_req, 1);
+		break;
+	case USB_REQ_SET_SEL:
+		ret = cdns3_req_ep0_set_sel(priv_dev, ctrl_req);
+		break;
+	case USB_REQ_SET_ISOCH_DELAY:
+		ret = cdns3_req_ep0_set_isoch_delay(priv_dev, ctrl_req);
+		break;
+	default:
+		ret = cdns3_ep0_delegate_req(priv_dev, ctrl_req);
+		break;
+	}
+
+	return ret;
+}
+
 static void __pending_setup_status_handler(struct cdns3_device *priv_dev)
 {
-	//TODO: Implements this function
+	struct usb_request *request = priv_dev->pending_status_request;
+
+	if (priv_dev->status_completion_no_call && request &&
+	    request->complete) {
+		request->complete(priv_dev->gadget.ep0, request);
+		priv_dev->status_completion_no_call = 0;
+	}
+}
+
+void cdns3_pending_setup_status_handler(struct work_struct *work)
+{
+	struct cdns3_device *priv_dev = container_of(work, struct cdns3_device,
+			pending_status_wq);
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv_dev->lock, flags);
+	__pending_setup_status_handler(priv_dev);
+	spin_unlock_irqrestore(&priv_dev->lock, flags);
 }
 
 /**
@@ -101,12 +545,50 @@ static void __pending_setup_status_handler(struct cdns3_device *priv_dev)
  */
 static void cdns3_ep0_setup_phase(struct cdns3_device *priv_dev)
 {
-	//TODO: Implements this function.
+	struct usb_ctrlrequest *ctrl = priv_dev->setup;
+	int result;
+
+	if ((ctrl->bRequestType & USB_TYPE_MASK) == USB_TYPE_STANDARD)
+		result = cdns3_ep0_standard_request(priv_dev, ctrl);
+	else
+		result = cdns3_ep0_delegate_req(priv_dev, ctrl);
+
+	if (result != 0 && result != USB_GADGET_DELAYED_STATUS) {
+		dev_dbg(&priv_dev->dev, "STALL(00) %d\n", result);
+		/* set_stall on ep0 */
+		cdns3_select_ep(priv_dev, 0x00);
+		writel(EP_CMD_SSTALL, &priv_dev->regs->ep_cmd);
+		writel(EP_CMD_ERDY | EP_CMD_REQ_CMPL, &priv_dev->regs->ep_cmd);
+	}
 }
 
 static void cdns3_transfer_completed(struct cdns3_device *priv_dev)
 {
-	//TODO: Implements this function
+	if (priv_dev->ep0_request) {
+		usb_gadget_unmap_request_by_dev(priv_dev->sysdev,
+						priv_dev->ep0_request,
+						priv_dev->ep0_data_dir);
+
+		priv_dev->ep0_request->actual =
+			TRB_LEN(le32_to_cpu(priv_dev->trb_ep0->length));
+
+		dev_dbg(&priv_dev->dev, "Ep0 completion length %d\n",
+			priv_dev->ep0_request->actual);
+		list_del_init(&priv_dev->ep0_request->list);
+	}
+
+	if (priv_dev->ep0_request &&
+	    priv_dev->ep0_request->complete) {
+		spin_unlock(&priv_dev->lock);
+		priv_dev->ep0_request->complete(priv_dev->gadget.ep0,
+						priv_dev->ep0_request);
+
+		priv_dev->ep0_request = NULL;
+		spin_lock(&priv_dev->lock);
+	}
+
+	cdns3_prepare_setup_packet(priv_dev);
+	writel(EP_CMD_REQ_CMPL, &priv_dev->regs->ep_cmd);
 }
 
 /**
diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
index cb8a3473449b..e5c4d9236f07 100644
--- a/drivers/usb/cdns3/gadget.c
+++ b/drivers/usb/cdns3/gadget.c
@@ -70,6 +70,30 @@ static u8 cdns3_ep_reg_pos_to_index(int i)
 	return ((i / 16) + (((i % 16) - 2) * 2));
 }
 
+/**
+ * cdns3_ep_addr_to_index - Macro converts endpoint address to
+ * index of endpoint object in cdns3_device.eps[] container
+ * @ep_addr: endpoint address for which endpoint object is required
+ *
+ * Remember that endpoint container doesn't contain default endpoint
+ */
+u8 cdns3_ep_addr_to_index(u8 ep_addr)
+{
+	return (((ep_addr & 0x7F) - 1) + ((ep_addr & USB_DIR_IN) ? 1 : 0));
+}
+
+/**
+ * cdns3_ep_addr_to_bit_pos - Macro converts endpoint address to
+ * bit position in ep_ists register
+ * @ep_addr: endpoint address for which bit position is required
+ *
+ * Remember that endpoint container doesn't contain default endpoint
+ */
+static u32 cdns3_ep_addr_to_bit_pos(u8 ep_addr)
+{
+	return (1 << (ep_addr & 0x7F)) << ((ep_addr & 0x80) ? 16 : 0);
+}
+
 /**
  * cdns3_next_request - returns next request from list
  * @list: list containing requests
@@ -454,6 +478,99 @@ static irqreturn_t cdns3_irq_handler_thread(struct cdns3 *cdns)
 	return ret;
 }
 
+/**
+ * cdns3_ep_onchip_buffer_alloc - Try to allocate onchip buf for EP
+ *
+ * The real allocation will occur during write to EP_CFG register,
+ * this function is used to check if the 'size' allocation is allowed.
+ *
+ * @priv_dev: extended gadget object
+ * @size: the size (KB) for EP would like to allocate
+ * @is_in: the direction for EP
+ *
+ * Return 0 if the later allocation is allowed or negative value on failure
+ */
+static int cdns3_ep_onchip_buffer_alloc(struct cdns3_device *priv_dev,
+					int size, int is_in)
+{
+	if (is_in) {
+		priv_dev->onchip_mem_allocated_size += size;
+	} else if (!priv_dev->out_mem_is_allocated) {
+		 /* ALL OUT EPs are shared the same chunk onchip memory */
+		priv_dev->onchip_mem_allocated_size += size;
+		priv_dev->out_mem_is_allocated = 1;
+	}
+
+	if (priv_dev->onchip_mem_allocated_size > CDNS3_ONCHIP_BUF_SIZE) {
+		priv_dev->onchip_mem_allocated_size -= size;
+		return -EPERM;
+	} else {
+		return 0;
+	}
+}
+
+/**
+ * cdns3_ep_config Configure hardware endpoint
+ * @priv_ep: extended endpoint object
+ */
+void cdns3_ep_config(struct cdns3_endpoint *priv_ep)
+{
+	bool is_iso_ep = (priv_ep->type == USB_ENDPOINT_XFER_ISOC);
+	struct cdns3_device *priv_dev = priv_ep->cdns3_dev;
+	u32 bEndpointAddress = priv_ep->num | priv_ep->dir;
+	u32 interrupt_mask = EP_STS_EN_TRBERREN;
+	u32 max_packet_size = 0;
+	u32 ep_cfg = 0;
+	int ret;
+
+	if (priv_ep->type == USB_ENDPOINT_XFER_INT) {
+		ep_cfg = EP_CFG_EPTYPE(USB_ENDPOINT_XFER_INT);
+	} else if (priv_ep->type == USB_ENDPOINT_XFER_BULK) {
+		ep_cfg = EP_CFG_EPTYPE(USB_ENDPOINT_XFER_BULK);
+	} else {
+		ep_cfg = EP_CFG_EPTYPE(USB_ENDPOINT_XFER_ISOC);
+		interrupt_mask = 0xFFFFFFFF;
+	}
+
+	switch (priv_dev->gadget.speed) {
+	case USB_SPEED_FULL:
+		max_packet_size = is_iso_ep ? 1023 : 64;
+		break;
+	case USB_SPEED_HIGH:
+		max_packet_size = is_iso_ep ? 1024 : 512;
+		break;
+	case USB_SPEED_SUPER:
+		max_packet_size = 1024;
+		break;
+	default:
+		//all other speed are not supported
+		return;
+	}
+
+	ret = cdns3_ep_onchip_buffer_alloc(priv_dev, CDNS3_EP_BUF_SIZE,
+					   priv_ep->dir);
+	if (ret) {
+		dev_err(&priv_dev->dev, "onchip mem is full, ep is invalid\n");
+		return;
+	}
+
+	ep_cfg |= EP_CFG_MAXPKTSIZE(max_packet_size) |
+		  EP_CFG_BUFFERING(CDNS3_EP_BUF_SIZE - 1) |
+		  EP_CFG_MAXBURST(priv_ep->endpoint.maxburst);
+
+	cdns3_select_ep(priv_dev, bEndpointAddress);
+
+	writel(ep_cfg, &priv_dev->regs->ep_cfg);
+	writel(interrupt_mask, &priv_dev->regs->ep_sts_en);
+
+	dev_dbg(&priv_dev->dev, "Configure %s: with val %08x\n",
+		priv_ep->name, ep_cfg);
+
+	/* enable interrupt for selected endpoint */
+	cdns3_set_register_bit(&priv_dev->regs->ep_ien,
+			       cdns3_ep_addr_to_bit_pos(bEndpointAddress));
+}
+
 /* Find correct direction for HW endpoint according to description */
 static int cdns3_ep_dir_is_correct(struct usb_endpoint_descriptor *desc,
 				   struct cdns3_endpoint *priv_ep)
@@ -1088,6 +1205,8 @@ static int __cdns3_gadget_init(struct cdns3 *cdns)
 	priv_dev->is_connected = 0;
 
 	spin_lock_init(&priv_dev->lock);
+	INIT_WORK(&priv_dev->pending_status_wq,
+		  cdns3_pending_setup_status_handler);
 
 	priv_dev->in_standby_mode = 1;
 
diff --git a/drivers/usb/cdns3/gadget.h b/drivers/usb/cdns3/gadget.h
index 2ad3addf8bd7..3f67ef1e5cda 100644
--- a/drivers/usb/cdns3/gadget.h
+++ b/drivers/usb/cdns3/gadget.h
@@ -1066,14 +1066,18 @@ struct cdns3_device {
 
 int cdns3_handshake(void __iomem *ptr, u32 mask, u32 done, int usec);
 void cdns3_set_register_bit(void __iomem *ptr, u32 mask);
+void cdns3_pending_setup_status_handler(struct work_struct *work);
 int cdns3_init_ep0(struct cdns3_device *priv_dev);
 void cdns3_ep0_config(struct cdns3_device *priv_dev);
+void cdns3_ep_config(struct cdns3_endpoint *priv_ep);
 void cdns3_check_ep0_interrupt_proceed(struct cdns3_device *priv_dev, int dir);
 void cdns3_select_ep(struct cdns3_device *priv_dev, u32 ep);
 void cdns3_enable_l1(struct cdns3_device *priv_dev, int enable);
 struct usb_request *cdns3_next_request(struct list_head *list);
+void cdns3_gadget_unconfig(struct cdns3_device *priv_dev);
 int cdns3_ep_run_transfer(struct cdns3_endpoint *priv_ep,
 			  struct usb_request *request);
+u8 cdns3_ep_addr_to_index(u8 ep_addr);
 int cdns3_gadget_ep_set_wedge(struct usb_ep *ep);
 int cdns3_gadget_ep_set_halt(struct usb_ep *ep, int value);
 struct usb_request *cdns3_gadget_ep_alloc_request(struct usb_ep *ep,
-- 
2.17.1

