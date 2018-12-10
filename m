Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4CA4C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EABD20870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:40:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="llblvpek";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="p3Da6KlI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EABD20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbeLJMkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 07:40:40 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:48384 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726292AbeLJMkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 07:40:40 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBACdJG1009774;
        Mon, 10 Dec 2018 04:40:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=sKTRugUuYCYP12UqNwdFRfADVZUfJq1wCnwfVhoPeDA=;
 b=llblvpekpt3mCUJC/z28aaN5JlKKsgcQHpoPydea+xOj5l2ZRtVFBnLjVsmbLoKll8bL
 /TjlDAVYH8Ogt2mq9E8pWA3hXf3VNQVP7UL+oqrYWAqTMJxO2307odaF77i99GoBCBH/
 RGVpCoMWMxLsGHCJImENjs322PbNVI/A8fbDb5EeOvvmadfCcHP+hLF5l5ZbdWDiM2MZ
 RwsP+HhOFuTM+iWXn4zDJQcyhyeOlopwzlksF5gvmasJGfiqEubn1xSp/csa/WSl6sGs
 83eBEOI+d9JaxSemVvXNQ0x/ePzLQ/VpM62yGH7zfmglG0UKNWAs/mDAIuPkCbrK+6Xx xQ== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam05-co1-obe.outbound.protection.outlook.com (mail-co1nam05lp2055.outbound.protection.outlook.com [104.47.48.55])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2p8ae2hxyd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Dec 2018 04:40:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sKTRugUuYCYP12UqNwdFRfADVZUfJq1wCnwfVhoPeDA=;
 b=p3Da6KlIvPgFR/XuaxP99Koqi18C4aL7yEEu2PK7plewTldvN8ebQJ7ljKyoBfMGDnThP4S5RReYwDm/4meEt0QZl/I4pZ27pEOtZPc3x0fnJmxnugXMXgWAoncTkR5HCWLtRkvpPnVSkwFJ684XSDuVpNfVeoS7PdmFccHMT28=
Received: from CY1PR07CA0029.namprd07.prod.outlook.com
 (2a01:111:e400:c60a::39) by CY1PR07MB2165.namprd07.prod.outlook.com
 (2a01:111:e400:59d7::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1404.21; Mon, 10 Dec
 2018 12:40:23 +0000
Received: from DM3NAM05FT047.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::204) by CY1PR07CA0029.outlook.office365.com
 (2a01:111:e400:c60a::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1404.17 via Frontend
 Transport; Mon, 10 Dec 2018 12:40:23 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 199.43.4.28 as permitted sender)
Received: from rmmaillnx1.cadence.com (199.43.4.28) by
 DM3NAM05FT047.mail.protection.outlook.com (10.152.98.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.9 via Frontend Transport; Mon, 10 Dec 2018 12:40:22 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id wBACeImA012942
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 10 Dec 2018 07:40:20 -0500
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 10 Dec 2018 13:40:20 +0100
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 10 Dec 2018 13:40:20 +0100
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id wBACeG7m007531;
        Mon, 10 Dec 2018 12:40:17 GMT
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id wBACeFoF007405;
        Mon, 10 Dec 2018 12:40:15 GMT
From:   Pawel Laszczak <pawell@cadence.com>
To:     <devicetree@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <balbi@kernel.org>, <rogerq@ti.com>,
        <linux-kernel@vger.kernel.org>, <adouglas@cadence.com>,
        <jbergsagel@ti.com>, <nsekhar@ti.com>, <nm@ti.com>,
        <sureshp@cadence.com>, <peter.chen@nxp.com>, <pjez@cadence.com>,
        <kurahul@cadence.com>, Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH v1 0/2] Introduced new Cadence USBSS DRD Driver.
Date:   Mon, 10 Dec 2018 12:39:13 +0000
Message-ID: <1544445555-17325-1-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(39850400004)(136003)(396003)(2980300002)(189003)(36092001)(199004)(50466002)(305945005)(42186006)(54906003)(16586007)(51416003)(69596002)(7416002)(2906002)(217873002)(186003)(14444005)(316002)(87636003)(36756003)(26826003)(86362001)(356004)(26005)(5660300001)(478600001)(2616005)(4326008)(105596002)(476003)(2351001)(126002)(486006)(97736004)(106466001)(426003)(336012)(53936002)(4720700003)(68736007)(6916009)(50226002)(107886003)(8676002)(48376002)(81166006)(81156014)(47776003)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR07MB2165;H:rmmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT047;1:Z2qFpWpLAXuV+yID6G4FfFTIDv0/7BlKCNzLl5AH9fqTkIJC0MMoVR64O28jz94k+wE63JSoIazGNs5wq+R/dKuM4dEFxCzf2D40pPL9jit8cQGAaYP6zRNpKPVOvBSJ
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6178b81f-33bd-4f6b-cf8a-08d65e9ca6fd
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:CY1PR07MB2165;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2165;3:TEmTkmqA33vYqdDJaB1f03qGW6TqznKO2drFHInOXuoGx2YnJ4kWYHM+bwHXcYyFAxNRf5uLU1EB/PIyUluIQb1xk/mFl9xDkmdqkaQZszBpwFLZsn/VEx1CmODRWPKRLpEMorKLSWLnzdBxDkyKz8a/NddDpi6Z1zYKH/uSsEO62sng+Y0S6ANi+oJ7+yqi0+Kh0ff1IAz3KIH5lkrJccU+3dJx4s94Y31YXHfQIuG86Ay/zs4SPQV78TAuot+KH7fIoY1GuHbBWhkvDej0oQZGAsYGOZo2YzC4AUIqMZXjo4jJRGDTawBLJowXiFmhDwe8vXaETzTMfVnlgo2T2A==;25:CwfVrVssoO6Y4FMYX2pjk1faRLTcvesEDv2i/TCdqhAHFEsBnXo0HgXC3613r2PwMKLJxap7ncLB5NFxw5nCXGEDG7XQYVivOrpPL05qBNGcT6fIgVmbJVKZmMhMn0g1+SB+diHtIY6/SS/FlE003uuIq3ScYPZJD8C4a2Iay6Urz4vi3wOD+kGeEfEmKEvcnKY4UxedNxlesig/mmvbls8wOmKvBTJt/q0qw/bXfpsV+MWHkFLQ1/Ube/3nOocr0ibyARA1vgyN3byoNo4yTkWGeUQTC2HKyhvm/U81virhPSg4fxL9Q1i5UuelzpMm0BQIe6marYP2PXho3nIftMaLG40C9Zmk34O9EqNa0Rw=
X-MS-TrafficTypeDiagnostic: CY1PR07MB2165:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2165;31:/wqmyDN1pPKvWPPD7WvGJjadHeeefiLCn/0slVjrTxX8ukNf9jLFsVufuEAMaQAX09WesWnlQzX7FflfDdRze9PoI2H0+V8C8UJF/3YWD90flOV1MP6ZsPQQfeEh4rMqmUksZiMZ9UIr7azqlHsptB/2Mtt0+RAM8lufx0P2benW1qRE/7mpk2Wock/KDQbEIpindHIfAy0ozuwKjG8Kiz6C08Cpqw77x2wlu5OnifI=;20:+3aoOd1G5leIhId8DArT3azGuVtms0WGy8ozFtpX9go2FQwfM6ojJabev0R0f+1w+sRaSdoqlKtZHEyz6kpbHUDPbQ9/WlUUuUc4Bo6nLohY5Y6jibuH84m6IPhTaVysLFlt95JXY1oiANHRlL+vD4PLeHe78BFHtIZ7rk7c/tiDZsfsn9OkPnpsbMsLwWfVPwC4ob2GNpMF2rgv97+PxX+fHEGP5G1WnhNpFMnI8eX20zhEDupEVcu3Y1HmUhFezkGE5pi3vaXwTvJucoUi/RGptxPokYCbUEmWLkR2b0zhlojDJTSlCuee4c+qigCMb1/369SVin4Sv62fj0U2LK4ndCSCM/WGzCrrbNsUmZu4fAHfw27w2AosqsWe9GnCfyyJ2zeEMvzfP0yhbV68IpvRczzg6Q6i96fDmw+w23oPCucimiOqJCX9/n515mUjOOkOmgh2HPUJH7+4DDGh1406HGxqEuDt7EwU88ERbfdQWwySeabnG6+2MmNOqJH5
X-Microsoft-Antispam-PRVS: <CY1PR07MB2165B84A412F6548D57AFFD4DDA50@CY1PR07MB2165.namprd07.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93003095)(3231455)(999002)(944501520)(52105112)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:CY1PR07MB2165;BCL:0;PCL:0;RULEID:;SRVR:CY1PR07MB2165;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2165;4:lUtnoawsFkshUP9gEodTEP5VY3+vq8hGIGcPgv8Ed4ybwpBu5v4wJY69tMNDL2Ctbj+kQrEmmNq3CY8b+cnr/DKg2ZVuhDBGx/39jTRjEzOQ9wxeatmknenyzZIIzzy8qiW18AYbIxJRwQDn9vVcqMk4sdb5C7UfT/0ajr1yltkWYaWcUDsLbHZdwuBDGR6yOcXiN6pnFrTuXVONPEX17AqTdV20mf4qHxt7mvyTxL/4ZoqQgZgdvWSihvkAwJNpyZjkbCZutlf0qh6cpj6Yrg==
X-Forefront-PRVS: 08828D20BC
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR07MB2165;23:40JllgeHYhaoqPM7QMbpFiEMYHuKfFhLUfUZw0Uo2?=
 =?us-ascii?Q?InzRRn5SteazoNSkru1eWHu6H/JU6zI1m90jcWrVF/n82AH7wQu2OP0xFA4d?=
 =?us-ascii?Q?WTPPySNgflUvU4Nf/1Ny/2cYI8iDfDEmSjhQyTWPNqCNuszanW6GnWsVPEA8?=
 =?us-ascii?Q?gXIHIPvQrfKHY/1CxldFCu9KzPfHdtzpDLjpZ2pszuT8sePwvDEjpUVB2NwO?=
 =?us-ascii?Q?j32PPm85oREoP0juy4HYg5M9cOUJdMkfH4un5CMxt/u7Es5kCYiiuJf5VKnr?=
 =?us-ascii?Q?WrquN8Vk9mEZ3SnhSVKNDrXpAJZaupKUEfXdt59Tm8ioNlxdFlTLE8Qbf0NV?=
 =?us-ascii?Q?HalMZN3VMCUDCDMG/BIV859yny1a+n6XARgovuY10gZNWBoIx9U/k7v7P+K0?=
 =?us-ascii?Q?DHV1ZIKe7+xYI+70iLJ5ajv0v+HZrLWvjAPZMRtUlkRll+bn5ccARmlH07Gy?=
 =?us-ascii?Q?NlShg33oWcHrH62sf1GKT5pRJ7PVRSUoi1PwjIJIHrTgEaExO4Dg3zPxFCeu?=
 =?us-ascii?Q?Djdp+PP6Kba+NPUaJW0V5BdMpE5CUguFnKuVsl5NrNx4aqnrgSBPSwpubu5+?=
 =?us-ascii?Q?lby2CcefTjjGyqCv76Tt+vUJArveK3cwVbBTE2rpSrSoNCV2+0y3MuAxI/b7?=
 =?us-ascii?Q?uW0lXg8FlN67L5OXRvrlyDnT3YZMInyMKUqAt5iHUoZrMG/5Np1mpwrsVOud?=
 =?us-ascii?Q?3GaO3Al3jyMLEoX6u7WVc7h0RiKMu3CvYO6s4/cotduXZ9cSqwPdiRmjntPe?=
 =?us-ascii?Q?ye92MEGySuS6zXhyDWAkG6ov8i4dh98flBMcaootPDFUNW1gVwG8b8wP8BYo?=
 =?us-ascii?Q?mlgp5RcPZ9m45VLEUN5K2mPK62f4ozLdya0f2cTn50e7i3F1lUMupKsf/ycE?=
 =?us-ascii?Q?fCbpq8F2qyVYyMdvm1wUPnAA04gHcVIH8AHX8gGdEXMOSBNh0b3Bto62pX9Q?=
 =?us-ascii?Q?KE47D9MTL1LEMmWhPfpNdIHE71geLP7H94yBUOYXMOPCNGXdN644I/0wgnc4?=
 =?us-ascii?Q?nCwma2cy1rbH8zoisooj08phMXjT+MEfA7g5jg55KZN9CNUsrcDP7hZVG+jy?=
 =?us-ascii?Q?K84Vkr3fp7wnD29/gfPX75RZjbaw2ucCAVCmvVsmb0nGddg+gB448NeE4hVV?=
 =?us-ascii?Q?ZzWLULOYfKmXoWjL4LLQFNs8MsNdWN1J/FqYM9F2R0a86HoUVYzhILnxnbGZ?=
 =?us-ascii?Q?Z4+mOJX4hQUNLrBs/Y/YZhqP3IR/VUwVxkN?=
X-Microsoft-Antispam-Message-Info: nRHG2GA4VnjQcar0TaS7+BH5L4WwRDKuVSQ0HdZzAtsk9Kuw49BBz3/KFeSxEj6L56M7GJhc9jWbCS7T/iT8/bMu7suM1+a8ACWxTnKB6qGNfajGubKRFsxhIHYAfKwJydhmQ7Wk51ElobJC8XAOghCzzpaozZ1VRDlPWTNyO5hME6bN9bDyItIbNPnVnEP67d7m/NpmftliCCuaD+rKp9Pa8jQdmX2g0bk+BtCD/LjOic4VSLmwMWJMmgKSSmwNX5OLhKPh0RUtxBbg4M9BkpW3atmtaD+9ZQDMzitvxI8yCrl/TWJ/N7nQSbO0slXB
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2165;6:2g2ulD4WFkcD/fhp6f9nJc9qI9oe/HDI3JXY3Fuek5AFJr6DD2T9DAiu4yqXIMYW2fu/m2qnrKLGDNxGTRYEc+zLmiakM8atHVOf29BtdwSyaPeqh6FZVZBy+lgeKZTY0dnOl2eJiJpRoaDePjcGPStxgJRV9S6ylG+JKusp1mrSZe396xBS0CL5tUDvx/WJTGwfQOUFrPNj7FqxA0j+xGqbH2IOXbelBrKYEREHaNqPd0ik0j9zuZKsaN8KubxIkdX1pXrDXgDGE7bHWU9niten6fwIae6ZazBLgw2RUJtFngCp/h/HqJbWoPSWSgB39Wj1vwhYIlxi8QH4Zv+ETTlS62EGcm+wWDgn5QnWtX2YCQ1EOrzOqcc1wa3TsHSASPv+xPffo5edWj09sSXMExV4AhexHUsGdSe4Sw/NV8qEmfRKpjLSSoO6g+WkRax/Mij9xFWJjMMPIhmmZl7Rz6Uk0T/vEExxDeQ+PuYyuRA=;5:sa5orWD2IfYzkfpPhJD2jHAm6az7EZ8r035aJDKNMm0Pzd76WLxEKRtoEbc4npQV3mjAxEW/8ykNEvbG9rWNxUT54wtHkGZQbIyfByuvgq8pIGNMKo30p3/DXlYL95IXIeW6qGDHQQhfWT/vZ8OHnzaw8G9/CTSgdGEkxEefnB8=;7:2vTRm808kFoWAb2EEfwhxTmIwD8M8jV93dkAbgRt/KwWn5Aa+xI+zW+P+EKf+k9r9ImdAeccEGTxd/lohlVwicO9MFAHhxrFb0NtBpJxYn7J1PkRxeK8y5Zpqlm7ubDLiwgbHHCiNvyG6wCkHIurtQ==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2165;20:AfQcew7/wHNDJdKMDXxK3me6BEY20MP9t2C1Yw/77PRCuR/yCp6QdiqEF7fhTTR8as43VitZhLzVKspw8UuAPOMtWQHWkUpe7WUeren0wCFYsEAcgetHTpf7lUucoy+YR/uSH0fvTvJVwgKIy5Tlt68PR3yAGt9cCbXTGL1EGBvKAopeSh+05T2yWvPukZ+BsqJtUplq9CXve26XXf6cHbektMJp3JXFMGwzsIWBoSJqrxbfMp+xfL2Y5YBdZuXe
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2018 12:40:22.3439
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6178b81f-33bd-4f6b-cf8a-08d65e9ca6fd
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.28];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR07MB2165
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-10_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=526 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812100116
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set introduce new Cadence USBSS DRD driver
to linux kernel.

The Cadence USBSS DRD Driver s a highly
configurable IP Core which can be
instantiated as Dual-Role Device (DRD),
Peripheral Only and Host Only (XHCI)
configurations.

The current driver has been validated with
FPGA burned. We have support for PCIe
bus, which is used on FPGA prototyping.

The host site of USBSS controller is compliance
with XHCI specification, so it works with
standard XHCI linux driver.

---

Pawel Laszczak (2):
  dt-bindings: add binding for USBSS-DRD controller.
  usb:cdns3 Add Cadence USB3 DRD Driver

 .../devicetree/bindings/usb/cdns3-usb.txt     |   31 +
 drivers/usb/Kconfig                           |    2 +
 drivers/usb/Makefile                          |    2 +
 drivers/usb/cdns3/Kconfig                     |   44 +
 drivers/usb/cdns3/Makefile                    |   16 +
 drivers/usb/cdns3/cdns3-pci-wrap.c            |  157 ++
 drivers/usb/cdns3/core.c                      |  451 +++++
 drivers/usb/cdns3/core.h                      |  108 +
 drivers/usb/cdns3/debug.h                     |  346 ++++
 drivers/usb/cdns3/debugfs.c                   |  168 ++
 drivers/usb/cdns3/drd.c                       |  315 +++
 drivers/usb/cdns3/drd.h                       |  129 ++
 drivers/usb/cdns3/ep0.c                       |  864 ++++++++
 drivers/usb/cdns3/gadget-export.h             |   28 +
 drivers/usb/cdns3/gadget.c                    | 1802 +++++++++++++++++
 drivers/usb/cdns3/gadget.h                    | 1177 +++++++++++
 drivers/usb/cdns3/host-export.h               |   28 +
 drivers/usb/cdns3/host.c                      |   74 +
 drivers/usb/cdns3/trace.c                     |   11 +
 drivers/usb/cdns3/trace.h                     |  343 ++++
 20 files changed, 6096 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/cdns3-usb.txt
 create mode 100644 drivers/usb/cdns3/Kconfig
 create mode 100644 drivers/usb/cdns3/Makefile
 create mode 100644 drivers/usb/cdns3/cdns3-pci-wrap.c
 create mode 100644 drivers/usb/cdns3/core.c
 create mode 100644 drivers/usb/cdns3/core.h
 create mode 100644 drivers/usb/cdns3/debug.h
 create mode 100644 drivers/usb/cdns3/debugfs.c
 create mode 100644 drivers/usb/cdns3/drd.c
 create mode 100644 drivers/usb/cdns3/drd.h
 create mode 100644 drivers/usb/cdns3/ep0.c
 create mode 100644 drivers/usb/cdns3/gadget-export.h
 create mode 100644 drivers/usb/cdns3/gadget.c
 create mode 100644 drivers/usb/cdns3/gadget.h
 create mode 100644 drivers/usb/cdns3/host-export.h
 create mode 100644 drivers/usb/cdns3/host.c
 create mode 100644 drivers/usb/cdns3/trace.c
 create mode 100644 drivers/usb/cdns3/trace.h

-- 
2.17.1

