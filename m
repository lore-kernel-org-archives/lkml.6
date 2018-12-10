Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C0CC5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8134C20821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="Qw0bHdng";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="W8iwVfGc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8134C20821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbeLJMkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 07:40:47 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:48422 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726292AbeLJMkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 07:40:45 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBACdJG2009774;
        Mon, 10 Dec 2018 04:40:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=4CD+Em44vjNYbC2WCp65C1rbHuN2QFw2LkkynYrTtTE=;
 b=Qw0bHdngea6ItEMstBcvLL4P8gDHtQpJz13UNIP82HBFc8uRujFgq3nl1PrEFiBBrmt1
 8Sdau6apZk/6fDoD5hK0gjI+asaxUhuNcNcnb6ddk86NKyFM1pjT7Pk63VuMR4UKLqnD
 xNiX5uKLt2z4ZuC58rfgtCJTRjVtzqgliNgp/X3mtsTRNsPOrkF+O0sfNMiTAnJjs8dR
 p5XdaAScVdcWDIqFsTPTza4Hrs0nC6WALvLMVEFv7G9fLagQ5WRHUug2lwqE4QW+rQrB
 3Z9yyMpa/rtn44TkcRyowm1kk9GKF77yQx4bSKHQMo2q+zUpHHQFvn7iJsd1YSaGiDVB cg== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam05-co1-obe.outbound.protection.outlook.com (mail-co1nam05lp2052.outbound.protection.outlook.com [104.47.48.52])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2p8ae2hxyc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 10 Dec 2018 04:40:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4CD+Em44vjNYbC2WCp65C1rbHuN2QFw2LkkynYrTtTE=;
 b=W8iwVfGcmh5MnUzrrwMKLCcjJIXJEMCzplUo2oTGnvV1ZaPJeYcOb65STW8MmIGrFywbUHRzmDGjaGScZtZXmnFgHN++YP9X9leE+I0d9K8w4OzbyjO41nSZ8Ua1+QEbfbq/xGHVG44RdKtOyWIdK4M7Z70cgApaYZHMAOJfsdU=
Received: from CY1PR07CA0009.namprd07.prod.outlook.com
 (2a01:111:e400:c60a::19) by BN4PR07MB2163.namprd07.prod.outlook.com
 (2a01:111:e400:59c6::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1404.17; Mon, 10 Dec
 2018 12:40:24 +0000
Received: from DM3NAM05FT023.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::200) by CY1PR07CA0009.outlook.office365.com
 (2a01:111:e400:c60a::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1404.17 via Frontend
 Transport; Mon, 10 Dec 2018 12:40:24 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 199.43.4.28 as permitted sender)
Received: from rmmaillnx1.cadence.com (199.43.4.28) by
 DM3NAM05FT023.mail.protection.outlook.com (10.152.98.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.9 via Frontend Transport; Mon, 10 Dec 2018 12:40:23 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id wBACeImB012942
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 10 Dec 2018 07:40:21 -0500
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 10 Dec 2018 13:40:20 +0100
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 10 Dec 2018 13:40:20 +0100
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id wBACeHOq007538;
        Mon, 10 Dec 2018 12:40:17 GMT
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id wBACeHis007535;
        Mon, 10 Dec 2018 12:40:17 GMT
From:   Pawel Laszczak <pawell@cadence.com>
To:     <devicetree@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <balbi@kernel.org>, <rogerq@ti.com>,
        <linux-kernel@vger.kernel.org>, <adouglas@cadence.com>,
        <jbergsagel@ti.com>, <nsekhar@ti.com>, <nm@ti.com>,
        <sureshp@cadence.com>, <peter.chen@nxp.com>, <pjez@cadence.com>,
        <kurahul@cadence.com>, Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH v1 1/2] dt-bindings: add binding for USBSS-DRD controller.
Date:   Mon, 10 Dec 2018 12:39:14 +0000
Message-ID: <1544445555-17325-2-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1544445555-17325-1-git-send-email-pawell@cadence.com>
References: <1544445555-17325-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(136003)(39860400002)(376002)(2980300002)(189003)(199004)(36092001)(76176011)(51416003)(97736004)(305945005)(486006)(8676002)(81156014)(50226002)(8936002)(36756003)(69596002)(446003)(47776003)(5660300001)(81166006)(2906002)(7416002)(106466001)(2351001)(11346002)(107886003)(105596002)(53936002)(2616005)(50466002)(426003)(68736007)(4326008)(336012)(26005)(126002)(16586007)(86362001)(575784001)(48376002)(54906003)(6666004)(6916009)(476003)(26826003)(356004)(4720700003)(42186006)(186003)(87636003)(478600001)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN4PR07MB2163;H:rmmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT023;1:bdRBgc4Mv6qSpJGcmvNekGLA6o66my6Oz6iLngtW0vD6B/XQNyQ9HIO8ePJAcAoEg4UoxbosanzxV+hODlZ4l/+fQZ+GIlORKfvzIF+UPXBVMjUJhwsurGi7PRlTkB6n
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 444ddbc5-4468-42ca-529d-08d65e9ca77f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060);SRVR:BN4PR07MB2163;
X-Microsoft-Exchange-Diagnostics: 1;BN4PR07MB2163;3:rbxtdPD6tv+QowW96TrOa6JhaXjyf+q3JVqkN0IwszdDGlu1NoUI91cPvv3ov4oCd47Nu7ryT+IR8uKgMD76O3WKlRCk8UIu7j29PuNSPeEF5yDelXHe8wfIiy6pv4rM7GG6VXWKn8AW8ZZwgOr+hdxWSt6iL1SLXpYSuO/Jrb3/YuMejjDeGOjxk091vXx+KLb7fIFKprruEY+3VLMJI3+x1r7yj992qTF7e9ybQ41xqLrDaJEmDQpkpomRSi4ahQHR/rcTFXsXEUjVw2y9jcXqpVxzoicRpLRKF0ByITRTFrRNeaYAufFKer/uUEDLzDmEoq9zOeISZskgsv5bAA==;25:5NsdkJL06AvcTA2dNIdvygfjMTmyv8nU374RW8hpR8tJeyBdFaDTehnpU2kEvjHp9S9OSU2M37ujL/gxcLYJai7wMsxuxuOo1sNvhV69fE35FLIk2bZM4LwDJIH7+CYKxxiAE7xwFyIC9qbqwEP1+BhgQPKGKfRhd5GXZwu2cJrcGy8690dyOQxWFC66kim+dcn8VSv0huPh7vOQAnDFFZUN7AWHyfFJJBGECFqYKXk/hdqap6kTA5HN5TbpJ+zKP5lKzDlH+5Pa8hm9pIQpD/HFdWaVUjLmPebTdfaZOcMW8qcEWqqm1yEUeQu6K7DgDTJCUdBkyHCQXpzHw0FB/w==;31:8DYZC3P+bC7eBNSluUcvDtCibqklAfOK44Oto6i8fFRIafrYbald/P/DQf83dCvabY79jVkqR6I36eqDKu2QD6S/lBXqO/HdmWdtmsTUstp9J2oZXkM9NTqUpoBdxp85xQSX5sLbYJgh3L6DJbsKcHg2UPHE7dNebLRbOY4FWeppHTW1dG9L06X30607ndRAdJHJavHQO2tx53LCjftif2yxm1T0zxcQLjZ+ARcGbnU=
X-MS-TrafficTypeDiagnostic: BN4PR07MB2163:
X-Microsoft-Exchange-Diagnostics: 1;BN4PR07MB2163;20:DOSrOmVjjCzICa1RDautQGF5FoDx2lpkTx6jqL8o1h52VvN9ybAMIsl2MDjAx2fGI33SIZwINnwj471lFXCBnuoLgvVI3udT+fTWzJlaoriu7E5p0zKM6QooiOw4Nqj75wWuh18lEdfRWIvFtlNJXSm1jujNW6P/7ANf9eoZUIwA+4QU8HXKorGC4oS9qH+2yghZPXlDhEiBCowyTqeVYEGyAQPwC1Mb6c0V/YTwHvzJ2Wo/jOiAinjHYNMQFadwtU7FvQ/9++8Juv7Y1U0xS9z/Vr1WI1afjseQfff1ELXTotuJcYp+Sf3Flr1Cq3UNhg8zdcQY9kqi0bcxv2lUr72wuaz5GWLdKdu8zB8cHZF6aVJ96pfFglJs+1IvCxhDRln5ljrB9lzEOMy8k6R3tdq1m7uAc4QAqq3/QWVxY6GtQXsZw1hR186hmAiSjoYRm4l/Z5yCKvlcwk4SvIuIpvaxNMF6LGn6q75TzuL0cnmIBo24sCadRvgmiIH664tP;4:pYRqBFjoJEL3je38VD8eg9ycx1rygLKA7BTafA5rtq3nNd8jiwXHkO7ct58vsx3MHt8uIQgffs8GK/BIgvv9YgdHvA4a6810uUJdhR8+x6J+KlKy7uS6zjIXXRC1VL1MJBtgiYvS5gLYrev9S9sw4EeKiBOA/Zs39DBhsypNzWRoMzdttMAzZjOGu6VqE08pRxFwueUsLIBbNy6NAuQlDkYcbcKxoRQ8tAZDbG2y+up84H7ib0HBKWIQPYomKOoZkyrKujzGZc0ttAnd6RQC7Q==
X-Microsoft-Antispam-PRVS: <BN4PR07MB21637D6D4823635FC7B35768DDA50@BN4PR07MB2163.namprd07.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93003095)(3002001)(3231455)(999002)(944501520)(52105112)(148016)(149066)(150057)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BN4PR07MB2163;BCL:0;PCL:0;RULEID:;SRVR:BN4PR07MB2163;
X-Forefront-PRVS: 08828D20BC
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN4PR07MB2163;23:M9rP14Okz58gUzCQtXpSWxpH8YL+Zml4h7HRlO9Lk?=
 =?us-ascii?Q?5/5cvTRnUKdzPBemkh0Zs1yakzaih1eNTyHTTV0izCaSzzcXxV+JkIlTIzx0?=
 =?us-ascii?Q?SKhzLIW1KHxMEc+F0BQD1i4ZcVNkflLrukHW/IZli03Gp5Awt0OgLaU26NOa?=
 =?us-ascii?Q?5qJIe6D/mpx5GkMa/wzPHPe8gf18vZwI1/imDLz2usYsUb5dmwk8AC1MfP3u?=
 =?us-ascii?Q?CHZ+Cc7ZmcSJLwCnTaSjDlZjihl6qB9xhdBfESqJZbbn4JRe41PNrFEg95Kp?=
 =?us-ascii?Q?rOn82QAqdKyLqUKE+Y2pZtn23UTx7RfjD6QH7Ths9ypAGiYdd27T5RIjKyxY?=
 =?us-ascii?Q?2/VZ7Rd60fdikkFASioBTBrDKPq26oqpKCwhzwtUFcnEWiCdbQzCuCFDTfhF?=
 =?us-ascii?Q?iA475kf0dXXlKXlJE+eqkw0QtbUz3XpoDHgHpJGFJDowJCQ0hznIlANqOx+9?=
 =?us-ascii?Q?IKoChqB8Q454QqMVxDBTjjBjDNQTP1mIbSRs51fVuHWtQGZG91BVYLYjaXQh?=
 =?us-ascii?Q?xRWDwDbaGqGBIslkgBh3Nohn0mTQ2Am1X+O+YZZmVXbckBMbL0dFydv6pLzo?=
 =?us-ascii?Q?4X6IgSPasvVYOYoSA+AjsgXXSD4BzWpVl8BmR+MGpv1yVSs+MVkmwjlahb+X?=
 =?us-ascii?Q?YZAgBgirUWYu4SoFIBBi/IMpKNd6OuFtmYh99iEEYvmaOQNMmz4/fx/SS7qb?=
 =?us-ascii?Q?3BpDUncBYCAgaMdoznsz3PyflJtDq7qGJuWcg9bDQS/lZ5jq2/lZSt3g+JTs?=
 =?us-ascii?Q?cWMh+f7Ik15/tBjQEDoDSRBaKh1IqZWWc/kdU06fXJH07gqZi53ZnsvPjSHu?=
 =?us-ascii?Q?e5gwmUsZo5IipZm4IBFr5YfcwaTKjrUmkdTStBE6c4pfRudx3L74+l9OE6bo?=
 =?us-ascii?Q?TtP+3A6OGRYsXd3UgkzJOjzsgD/rMVockeEy93U09I4e4bU/30aV16Uzj8OZ?=
 =?us-ascii?Q?igZumrpcDjBehNtSK3DvgTl81zq9dkDpaDkybMwmf1MEHeOgiiUqnUzdRQf3?=
 =?us-ascii?Q?qcn4ENosUE7KdkAbvI4pOB/8QpqYYU0qhnHF0ZEcAbHekkubfrePcS0wdJGH?=
 =?us-ascii?Q?CWHcDJvat3W4eJ2Tuv45TXevp8fRinj1yYOpm1v6PhmOH55WX9D6wTyQCAWx?=
 =?us-ascii?Q?tswbliFNogiizhEzhJMqf9NfNYHa2HdsL/NiGj54MjAOBWr3mzkM76R6HAwz?=
 =?us-ascii?Q?JSoFcnert1XLK1b+3s52V6+P0bJMcSceQXzwKpX95FnuF2CI3zHx8Zvop0wo?=
 =?us-ascii?Q?aevyxOz/aF/ZJHHbsQ=3D?=
X-Microsoft-Antispam-Message-Info: Ngr1aKBZ66TlLpZnw9PcZyXsTjV54Dnj/XpFooLT6c0mYbWeq3mCM7IyqmNEWMGShok5J1eWqi2V4toGbK4TYJDyY6Wti8+9in4qYqbmbi1Sg9tRG+8795+mKkACrUkriLRGJQBRTW0BvXphgC4rCRFhDrfoK5FCrWamCFWFIBxZhCs1sCDzR2TTXT9LajnziA9OJCFtBp+FzNzy98m0TVTaGiiu5gB/BkrbV5r7yfqoMr/io9fY4H+/9JqzHIDAxE6XJ5H+TeED2YTOqL48+JHjEzXbulTvfQwqjrh3OUis4zt7LT53jOjK0oI4vpt1
X-Microsoft-Exchange-Diagnostics: 1;BN4PR07MB2163;6:+U6Zv5ykqKFinO6APtZRHP7ICJoEHortmy2oFNHp9qq3OpGS1eOLZQmyV92xUonRUu+iBOEfZ2oLYHa9NuYSfA1wD7zN/CZPUmyNofzr/R1dBrw0R4nPHSxD1zOpzCzeev7okJVtQs+Cc6pfU5ry71UlOrmBQeKuxvB0SVhwmR881yK9+ZbBkYgssqU19Rhyc4/dQ9v19v3S6T1MfN2dfbPFFirVQrBiKj2B0LKhbiTiS68v/6KqzJZx6B4im7gsiIcHQGQhbEULVPEMdZuUqmUGaFk7q7auKYrgHZFW0pNnf0VLRCt13fAkBy5JdNu5faYNHWV0oB2GVRDESpPVXx9bYDaE8/mC2EcukZ9Yg06vzvAWPv4E+VveXNdS06EfDPzgK9vXk1JHKQ9IGw3mLJe1RqIw5a2IXeKqUyR8MJkOWGyoJ9px1P40ZuE8NDbIBYAEDznnwxXo844HZ253lw==;5:OY5b4JBvTFAkvDfddCUoSqE/ALvppgZpblt8z758PdgOu4SlRbFfznaT1poD/DRNsu6T627yRLpTHVJCnFjIGKjurULQTZraWAsCL0qtJdqS6uDx3kv2UmSGC8TDOxiZ+/FcxGAug8NGD/lEtAaY/4UNRBl8qCO3NvrnzT2qC8o=;7:dyMHpyR5ADFoD4FZqvFosPjtZS3kqMzU1TTOUwVLATWRXbJO9J2C75JAPaR9CLZLcIpkuunX6m+HqKaN1ZnUpAACdocpyVFq3T0boAL89ruV+yXiOlhNbfQdzvXEjD8hPp1xUwOPL8TwKrhWpEzXYg==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN4PR07MB2163;20:H+aVXXD7XdGwd0kVcLhJXDrHlOMi/sX4fYsgxrrnk9ngAjm5MN3eTKYK0EZ29/pWSI+WQX7nKSkx4Za1R9GGzNodTWYIwc2A/+HgvNVjioE0EL5m8LsBiOdMHp4+xi0VaIaue2m37h1xCaEkerlBFY45PBTzHFUU+MCN60PIMxwcYLT+p/5/1L0oyfK1+BS7UEq1qiETa8qo8FKFvoON9XG2HQx9qGEve/FrVuQFeY2jzXCn7B4IQzyYpq7ZrC6W
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2018 12:40:23.1926
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 444ddbc5-4468-42ca-529d-08d65e9ca77f
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.28];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN4PR07MB2163
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-10_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=717 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812100116
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch aim at documenting USB related dt-bindings for the
Cadence USBSS-DRD controller.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 .../devicetree/bindings/usb/cdns3-usb.txt     | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/cdns3-usb.txt

diff --git a/Documentation/devicetree/bindings/usb/cdns3-usb.txt b/Documentation/devicetree/bindings/usb/cdns3-usb.txt
new file mode 100644
index 000000000000..ae4a255f0b10
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/cdns3-usb.txt
@@ -0,0 +1,31 @@
+Binding for the Cadence USBSS-DRD controller
+
+Required properties:
+  - reg: Physical base address and size of the controller's register areas.
+	 Controller has 3 different regions:
+	 region 1 - HOST registers area
+	 region 2 - DEVICE registers area
+	 region 3 - OTG/DRD registers area
+  - compatible: Should contain: "cdns,usb3"
+  - interrupts: Interrupt specifier. Refer to interrupt bindings.
+		Driver supports only single interrupt line.
+                This single interrupt is shared between Device,
+		host and OTG/DRD part of driver.
+
+Optional propertiesi:
+ - maximum-speed : valid arguments are "super-speed", "high-speed" and
+                   "full-speed"; refer to usb/generic.txt
+ - dr_mode: Should be one of "host", "peripheral" or "otg".
+ - phys: reference to the USB PHY
+ - phy-names: name of the USB PHY, should be "cdns3,usbphy"
+
+
+Example:
+	usb@f3000000 {
+		compatible = "cdns,usb3";
+		interrupts = <USB_IRQ  7 IRQ_TYPE_LEVEL_HIGH>;
+		reg = <0xf3000000 0x10000	//memory area for HOST registers
+			0xf3010000 0x10000	//memory area for DEVICE registers
+			0xf3020000 0x10000>;	//memory area for OTG/DRD registers
+	};
+
-- 
2.17.1

