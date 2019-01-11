Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD50C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E714921848
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="EIR2u2Qc";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="UgHv8fPz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391465AbfAKPOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 10:14:46 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:37660 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733069AbfAKPOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 10:14:45 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0BF8oPO013126;
        Fri, 11 Jan 2019 07:14:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=JyTnKQiVjLC4zxOr97BxssYHpIuHaTDSRGYP4K1bxc8=;
 b=EIR2u2Qc2yZiJC9w6wDOqUzWdM2/vo52tIY+mrl0Argl+KUW9fMRKD/jBJUsi72adKft
 ovMHmNzooZCKaRE2BvBH/ozIe1QZ4EFjrRWk/RAToihbwqWB5UgUezS2W+Qr3MhSBjTa
 +d242mokrEpvBetwvnAyvjFzyeIwMXgKjqSoUD+x5vieEVJBDNx3C+Li28tM0r5O3BbJ
 GGiM7/0uuaaqI4KjfEi4YIBfO7B5sV/Yd5UZGR7zbnxlKp8w8WFN5f5mJHbWD6kl0spk
 GkPgoOGThqVtUIddRy+YISV+83f+/sNutSjmjDN1aj565xzuilb5eLkSKRC4m+3UF4tb fw== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=jank@cadence.com
Received: from nam01-by2-obe.outbound.protection.outlook.com (mail-by2nam01lp2054.outbound.protection.outlook.com [104.47.34.54])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2pts22dryh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 11 Jan 2019 07:14:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JyTnKQiVjLC4zxOr97BxssYHpIuHaTDSRGYP4K1bxc8=;
 b=UgHv8fPz+TLtSGyWPk/dO2AQRwzUdE3HScznPe+VMpiF3ODZhi6zXpcj5lMs0MYvCxQcGaUMCpZ4U6gfG1Xq0zq6xxjh92YeOD0V4ij5dhLrx6p/JqS9SGmt0mMrtwb7tcu8mVbCWW7OrmJZIvFyvgO6/WyiGPCbrxeDPMUcbVY=
Received: from CY1PR07CA0024.namprd07.prod.outlook.com
 (2a01:111:e400:c60a::34) by MWHPR0701MB3721.namprd07.prod.outlook.com
 (2603:10b6:301:7e::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1516.14; Fri, 11 Jan
 2019 15:14:20 +0000
Received: from CO1NAM05FT016.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::200) by CY1PR07CA0024.outlook.office365.com
 (2a01:111:e400:c60a::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1516.14 via Frontend
 Transport; Fri, 11 Jan 2019 15:14:20 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 CO1NAM05FT016.mail.protection.outlook.com (10.152.96.123) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.10 via Frontend Transport; Fri, 11 Jan 2019 15:14:19 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id x0BFEHA8001005
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 11 Jan 2019 07:14:18 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Fri, 11 Jan 2019 16:14:16 +0100
Received: from lvloginb.cadence.com (10.165.177.11) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 11 Jan 2019 16:14:16 +0100
Received: from lvloginb.cadence.com (localhost [127.0.0.1])
        by lvloginb.cadence.com (8.14.4/8.14.4) with ESMTP id x0BFEFN1025501;
        Fri, 11 Jan 2019 15:14:15 GMT
Received: (from jank@localhost)
        by lvloginb.cadence.com (8.14.4/8.14.4/Submit) id x0BFECxr025398;
        Fri, 11 Jan 2019 15:14:12 GMT
From:   Jan Kotas <jank@cadence.com>
To:     <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-rtc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jan Kotas <jank@cadence.com>
Subject: [PATCH v2 0/2] rtc: Add a driver for Cadence RTC
Date:   Fri, 11 Jan 2019 15:13:59 +0000
Message-ID: <20190111151401.25047-1-jank@cadence.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(396003)(136003)(2980300002)(36092001)(189003)(199004)(54906003)(186003)(26005)(87636003)(4744005)(16586007)(48376002)(50466002)(47776003)(14444005)(26826003)(110136005)(336012)(126002)(486006)(426003)(1076003)(42186006)(316002)(6666004)(51416003)(2616005)(476003)(2906002)(356004)(8676002)(50226002)(36756003)(4326008)(8936002)(107886003)(106466001)(246002)(478600001)(7636002)(5660300001)(305945005)(86362001)(105596002)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR0701MB3721;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM05FT016;1:+5d8QS1IORjH7uUZm9ESPo/4IY6869cl4AiAOpIhIWV5/HsJu2zolbVF9oD5FzxaJcSCEZmanh/Cgi1ge0XdvOR16d7CwMi/Nf+SSgoBRJHwywfh9WHInULWqY0Tc/Hd5vHvDITdZVVXoS07RO00Zg==
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3295d5ef-371e-4823-9cba-08d677d77603
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060);SRVR:MWHPR0701MB3721;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0701MB3721;3:fZddDELCoiw1b9o/4lNM299x6NjXrGM7y6rd4D96bUyIsNNXtvDjIgWBhSCW7LHuua5QL3Y8jhYNz1fHbPd8FBMRyM5DzTYrgeopIc76VIhRgMyOp4EGGf5vo7KqRHl3E9MsVfx55k4gAFvYnlWII58p+eprFmEBq4npmSk3cbUh2Drx45yVIQvXE0NjQgxeT6jLM9Vn4uJCwtGUpoJ43FgiJq0JOSJ68wU9tW/bchF1LY+34TCPEbmF8UAQ+18rVcxakViGHdr41ut97YbhGn3b6wPZ8rlHf7IKmCUy4F1Fv5/jNVRmbli3WOdXVINmSDGq5XUgGJJhod/MBZ2ZMhPe07Q3s6ijFBJ4lqZ7WAewJokqukO6racGoSHmSMT8;25:Se7XUG3J2xkcIZ8gUn8AAhKqQ5pUETI42zKs24syKVGs5h3pXEWrImw+XQBQT6yY90pX4MjoeH5EApoDC8/3I2k9APAEMOPuqq3HWbVljhk7ZAZqPHpzswZlupYYpFc0KwJhrI4ap/a+ftjr0BiYf5jjDNuJU2riiHCfm6tz7hzZyPTCwmLmqQC5sS8Db95BQEQnwPvDSfcuyTH4Bu/ac3FD1exRxXju8B+WSS/u1VRw8MhF2WZ1jbKkn4kL8nWXHAstuZQTO1v2VuMYCc/0EbKKdJoK3gO2jD5SVrTUt7ZpTZMyquiE+dcA2FLeyy8ibaOvrp9QOGO9YtDx0T572g==
X-MS-TrafficTypeDiagnostic: MWHPR0701MB3721:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0701MB3721;31:lpohmIzCdiHpaBI6ifiGB6LCKFia+Pu+gUOUVtYj1nprD4f1H6n+wa3db97WU4XTGSBZ3rwRbO654vghTbJjdhce85ElGOLLPVEn93z8dyD6XWbhy+pziumkfk7LhDgnmqoGhHFSv/6SSRVoJB7orzeZ5K0ldjp3IcgDHZBjT0p6qsYcQtn6nq6P4pkZ4Bt4kmwYQMwJv5/YjtPeBStopbXwRN+2XLAa2BrfPPfPRas=;20:TaTbfk6zqvg4zqht4H07Az9G5jfFTkF/QNnXSouqY3PMO68jCgIphrqOciUYl2kwAMizclkdXJY7eiWwB0JYoylEqcFXZmc/k/OJ26FACKPuQLaw/t1MT92em8+xLzWFC/lm7+5J97il3YTDFtSyIYp+7EPXEKcxPRE7sJKLQbFoOQA50OqZ3q8SjP7TN3NV6lQaB/7CWgOFDPxr2Dfjr+xISE2IyFwlI9I5BYnVEFL9rHYgv8cIsaLj5riAQ8BSCuCuhEmo99+LtBd55cUkqn45rmbMo195z3p317a3yQr5NTMV51vNWv8q7ATMVnrq6Zx/uL78HpKr0DYsoE7rdlntbvnip1b9ZOd3AgEErc8SXOAANsSqkjhCzdoJBbqyBH+KwtJyxHNlyFqzdcx8/4+7tpkXBxuU1NZsvIPyv0HMeizp9P6OvDWTHolkaiSz9buruBXfons2CBUr3pyULPT/lcT3EsHyRbAP0M37yjqCF0QmmSDZbk3aPqbi2NaE
X-Microsoft-Antispam-PRVS: <MWHPR0701MB372127570567E99FC87A77BDD0850@MWHPR0701MB3721.namprd07.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0701MB3721;4:11YpAyYBFFuQq2czPWMoq5M0zxAa/Ul2/CL7AQwk3YpPXphcmJ8pTL9dyWS1aExea86G8oINM6ORUeGPrGGUzFbykYJ1/y4DG3N57mQHmds0irZBYaSQrG651qoO/rJ6CpDIzpJRSZfoz/gbJ8DYmpEOcuS/F41jbhX6i85iLI+ZnSAviaEPKEqvlHN1be5R5sbnUmGvkWPo/JS4Lad9JFhpNyH64suJmP8mF0Rgv5bUKtXJPBjlbQZdfzR5NekepF/uaEP71w4kuRl63F2jhQ/52O+6l8auX/58pDG8MZM=
X-Forefront-PRVS: 09144DB0F7
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR0701MB3721;23:aCIxxov0dIjQVJivHxYHR6PMpTxMEkebKfD+ORn?=
 =?us-ascii?Q?t+wBH2BH4hhixjeYX4cD5ZW2VH8D/ge6Yzy2btAq4fnNq9FsVVev1geU/b6d?=
 =?us-ascii?Q?mQp62+W/SWV7jXxDRU3wPG3xfezGlzWjh/nAe7HLod0PloGt5Uvb2AwILx6b?=
 =?us-ascii?Q?KZ7vJeQLIAi7ieStievoq3nMq9FroJVItG62IcvPkskw+vBef3YCHpLTodxN?=
 =?us-ascii?Q?6+eWbUmjoYsOJ5ERhWv7ry+f0ZwiVyF5aDouHoSTGL0yGC3/QPwYP8bcM/OC?=
 =?us-ascii?Q?X/LthAf6hbR4CDOZCeK8vEifgCIPjC5lEpcNY4j4yK7XKE6yLd8FAwzerr+V?=
 =?us-ascii?Q?kWoAzymh1Wuo695mkfaoEw62XbALbeIQFH4AylCM4e2Om8k3jv06+HDTX9xN?=
 =?us-ascii?Q?w8v8b5DtbSTnKEbo1kQ5BIJ0BsVJ04QqCR3EQT7+QjchhhFxNdq4QU3O1Lpb?=
 =?us-ascii?Q?nzTbjndiCsmpPza33+v33MGXB3/rR6Sb0a1oxEgBX0KMg6CH94yrxmCj2Hg0?=
 =?us-ascii?Q?js9b9pYIMi/SubaybeDB7PtzVIYxJYFsTks8wlqYK5UUDTaw47w77oL2RnxV?=
 =?us-ascii?Q?zRixDfdxPNKkKJoVpqOCHcJeTyW3EWLzqUka5rKe7F0W/S48TZRNaZ6tHjR7?=
 =?us-ascii?Q?6Tt6+z5p5LPUwWCHWy0+OTGcMOJpKy2mtIBRxl2PP3hUrd5DcFyuhmckFbmA?=
 =?us-ascii?Q?RSDwvPmTo6qUslU6t83YEIq6gTXDNEBKfrWD6lzHwAXvkuujKjJxmct2YJk7?=
 =?us-ascii?Q?qH0UGB/hxhxnHrh01bmr4Noa+saAHU1qZ+kG6r2KUtReP5JeoAhIAuaUvDgl?=
 =?us-ascii?Q?6HE66I+suXMIkOy2wQQqeCNLGsafPOgu4Y/o4aGagzkQGRT7+ruIsZAxcfvb?=
 =?us-ascii?Q?Nd31MAPz5VNMoTolTyBKi7+wNXS0Uwplus056WYQn6SiL6mTkcK9JvH2hn9T?=
 =?us-ascii?Q?+oozNnYeDB1lB4x/beeRPuR7Vt5gvNz7ocvT5DzrWInkPB4ZnKmXHnxPZ2Fx?=
 =?us-ascii?Q?NZ4mtpu3re3E0cB4RsOLeSz+/lYCydprh16fPKJ0wql8I5Q5PlbjU3IfHOhn?=
 =?us-ascii?Q?eRDefx4fdL29vGhC4Y4RzTBAerfJ5Oa41B/DakbVmJrdhSd+PRQ=3D=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: Y8YIYamiJfzLcFRDLEzoeePrqaOJCDAvhfNucgOCGSyiZOxvedVI4Lj02Mxbyq1Ybn8cF9uc5X9DqQR+S+q7DD55CtvRzv2UMMMo4W3/DMQNU0D7f9N0iBV9xvNku4qe6IhinbZzliuDLIgW+v8jFY1+xzRpNpkWAEv31N7IHgj4eatSAwM1VgClyqbeJ0CPRFS3+JafzjUfp3gmNuIMRu/05GZ8U87T+o96F/D+b6QyyFiwUH2pWktQJOqmZL3nb6nJAsgsfUWej8CmP141FCiSwwhVzB0QD7ovBFIrGUWdQHwDTg0pTV5pvhmN2z/eJQ9Re94wIITdyR5T067wRMJ74fRZmO50pKS3qHiyjasxu3VM1gmi6TR59KLuSkpHL+XdZY4Eyap0Bhs12JAr5u7MGvb8l/lYrmwbQ7+r43Q=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0701MB3721;6:xKuNfpCi/UhQk6vrkYvwzUAVZYgkEj1f1DkHlrQRrS9YSU7LqvgVYaksaTxcpCrNB0ATTCs3CwOrw/bkNcAPGbSOv0V2BOUXsYgFH/ToH+wQiNQB42mfJcnZgaDNON5CysDS/8HJTbyGp+Kp7UxeBKjuXNpwkvGUvSAzogsmsamDknbSDj0nSYEtUkppp/pgMDZWyqRjspEgpnZHqYGENFKv6evaGfvSuBfH39uIvIAm1QWCUZdgT3pxPWzLkYOQCkqBEzTEgh4DZEVDfRnReCEH5i8BdrCGlH2vyRGGGd0iR+vZ9v6jQpQAIm5+ncn+DymHWFh7EX9VZ6+UeLmSpfX3UzduzANPDatEDHSbkc5WD9rvibiWu3eImEoxe/Mz8A+uVdzoV1p4uNzRBGGa7m6bsKPonrXkrrnLt7ANsQqdIyqGwDYdgH8y9rUsVo/HxBk8zQpd1hHuTE8F6QsmgA==;5:pPe6T42u9wbQrnGq0tbPAedC2oopWuqNkB+Eg8syZ2/CELHV29TyLPT5D6cKoyoU6msOha/h/FouCSF21w1UUcXJyqe1lAit+8fh94qjhb4vNb0OxWu7Ht1ItmnBRksSzAY7r+Hwyc2f7Z3B6BO/EdhXFxySGTC5+/ZTUzNlKPj6VDeRaeWGCRRdI4yC7BnmCQCwjXt9vYX9anIrPpMgDQ==;7:NUVJG/jCvqXmqymgqT7+V0AECw+9RC3dlgtdem3bUcyvX/rvq6OkcAwwz6B2OOuYeUgPuOGzpza7NX39HTTAWIQBvYngu0mcOeWZWhbLewq5GGAy2OFUV3c6YtBD96qeJ9iaPDI4nUwpchQCgz/RHA==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0701MB3721;20:j0SSbxIvSI6JMuLXn+7ZTTMcjz9c6BdpS62nVmIHe1sEjpPOyZJCI/1YDKoOSuykbN36oh/PkxFt9l6TsTosLREXX3UvjpSSKOXZglkHdm14q0Zxe5r0x+VEKjbSt/sw/khBRh5vlT01d1cPKqJ+klBRzL6JTuc4dt4drW4qm8Eiv5FEvC09JXb0Howc0srL8MBu3lCmwgxVUqmQPluEiq8jaoP9PWWMNZj/vdqiSN/FEdXHwFQWHD+0NCOiOwhV
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2019 15:14:19.8469
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3295d5ef-371e-4823-9cba-08d677d77603
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0701MB3721
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-11_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=851 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901110125
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds a driver support for Cadence RTC IP.
It supports time, date and wakeups from sleep.

Changes since v1:
	Added devm_rtc_allocate_device before requesting an IRQ
	Added range_min, range_max values
	Return -EINVAL for read_time() if RTC is disabled
	Fixed some typos

Jan Kotas (2):
  dt-bindings: rtc: Add bindings for Cadence RTC
  rtc: Add Cadence RTC driver

 Documentation/devicetree/bindings/rtc/cdns,rtc.txt |  25 ++
 drivers/rtc/Kconfig                                |  10 +
 drivers/rtc/Makefile                               |   1 +
 drivers/rtc/rtc-cadence.c                          | 423 +++++++++++++++++++++
 4 files changed, 459 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/cdns,rtc.txt
 create mode 100644 drivers/rtc/rtc-cadence.c

-- 
2.15.0

