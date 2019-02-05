Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7398C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 17:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1DF0217F9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 17:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="F8MARENk";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="bHGZdUD1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730301AbfBERJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 12:09:04 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:43522 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726717AbfBERJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 12:09:04 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x15H26qN003188;
        Tue, 5 Feb 2019 09:08:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=proofpoint;
 bh=wl3/61dRHk+U1MDJpSGKdQhqqWeRJbRFnnW91i2wGr0=;
 b=F8MARENkLhu+y5PTe7pCBU+Wrh1bRI+C4QVN0EosIzvcvAseNHbUSDqsPPUG1REt/5y7
 APZH4x/NIkHoP8gPpHASevMU57R4AArWQNVL6BlMrSSIG/f3KSBCivqkDmCwVs9JqC5m
 PAc9iVYIWKslJTMAUiV5mhEeTFmZe4VnK06Fjs0bgWy4dvaRv6WXEOLS42KH5tBQFQWs
 KHG0STZdfsOCXFBbGYqWROxJtvD1xnLbcKzeYuqJ5yWIGDL9/vELgS59aXcEc6LfmEyO
 VCC9igHMRUcxkqgYkYSMd/ti1QTLH9kNVC9+KOSjTXuJK0n/y/H2BfVrifcQ7QHHUK5D dg== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=piotrs@cadence.com
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2051.outbound.protection.outlook.com [104.47.46.51])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2qfagt8ybe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 05 Feb 2019 09:08:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wl3/61dRHk+U1MDJpSGKdQhqqWeRJbRFnnW91i2wGr0=;
 b=bHGZdUD1JL6KycAW1ytgegRAgsUQVNXnhUAXewBDv6PSatf3ar5NntS0Dz4GEycEFSqgCub/fbOlLK+EQqpbeFpBheUF976TA/qra6GFDSp2nwXI2uO0Mf8Q053Zgly/2azChWeVavLgi9YdtL1hbjFcqCzPCiXPF6ZNYS6ebEE=
Received: from DM5PR07CA0100.namprd07.prod.outlook.com (2603:10b6:4:ae::29) by
 CY4PR07MB3096.namprd07.prod.outlook.com (2603:10b6:903:ce::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.21; Tue, 5 Feb 2019 17:08:27 +0000
Received: from CO1NAM05FT027.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::207) by DM5PR07CA0100.outlook.office365.com
 (2603:10b6:4:ae::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1580.22 via Frontend
 Transport; Tue, 5 Feb 2019 17:08:26 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 CO1NAM05FT027.mail.protection.outlook.com (10.152.96.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.2 via Frontend Transport; Tue, 5 Feb 2019 17:08:26 +0000
Received: from mailsj6.global.cadence.com (mailsj6.cadence.com [158.140.32.112])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id x15H8N9v013891
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 5 Feb 2019 09:08:23 -0800
X-CrossPremisesHeadersFilteredBySendConnector: mailsj6.global.cadence.com
Received: from global.cadence.com (158.140.32.37) by
 mailsj6.global.cadence.com (158.140.32.112) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 5 Feb 2019 09:08:20 -0800
Date:   Tue, 5 Feb 2019 17:08:14 +0000
From:   Piotr Sroka <piotrs@cadence.com>
To:     Boris Brezillon <bbrezillon@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        BrianNorris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: nand: Add Cadence NAND controller driver
Message-ID: <20190205170812.GA18748@global.cadence.com>
References: <20190129160337.24350-1-piotrs@cadence.com>
 <20190129161040.20299-1-piotrs@cadence.com>
 <20190129182100.2fcb4e9f@bbrezillon>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Disposition: inline
In-Reply-To: <20190129182100.2fcb4e9f@bbrezillon>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Originating-IP: [158.140.32.37]
X-ClientProxiedBy: mailsj7.global.cadence.com (158.140.32.114) To
 mailsj6.global.cadence.com (158.140.32.112)
X-OrganizationHeadersPreserved: mailsj6.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(396003)(39850400004)(2980300002)(36092001)(189003)(199004)(67846002)(16526019)(26005)(7636002)(186003)(106466001)(2486003)(50466002)(386003)(55016002)(6116002)(336012)(229853002)(6916009)(3846002)(316002)(54906003)(1076003)(86362001)(7416002)(23676004)(246002)(356004)(16586007)(478600001)(58126008)(305945005)(7696005)(476003)(486006)(11346002)(8936002)(53416004)(126002)(8676002)(2906002)(426003)(5024004)(6666004)(105596002)(6246003)(26826003)(33656002)(47776003)(7736002)(956004)(6286002)(66066001)(76176011)(4326008)(446003)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3096;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM05FT027;1:PLUoBFBbmG0fpaOqzMIOncw239/C7LIkNyHs9zDJMJnu9cEPSa4jiobPdj7tcXPlPak9WZJh5c4cP+h7rPGtBbCsDVH3YUxZvumpPVrWIScxM94PjrWN+Rt5b1VeqGIOtjeNJliSrAXXqGTU/CoJh/AjqlX7hxSQaQLQRsx/vCQ=
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: faf2b02f-b621-431b-8e23-08d68b8c8b15
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:CY4PR07MB3096;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3096;3:CN/3vK0DfSAzz1lHtb9hB+KoE90X9G621GmLprAGcHS3s+1K/MA5g0Lt3zWmqXnU7QYLHqTwx9ePMUZ+wapF+dQkpy0NldV/KSRVdQKcvmTa5+osrLg/1XHOknGYQ6pFUOpI+KTxLfS9iEaj6O4z8IxCUfEm5jzqNnbrHvIRJIIfaq3/m9joxP0u9DahK1KFun7x6njtqAN9ibZU/z5vPTkIdwH593qGErUte4SF0pMPIjRxN/t/m5XfUzDNBfCV/eb8/2KBX3bcIGhgPLtCEkNa+YXeu0Wpk7CZi/qBsWOLjjtAoG/7BNV8vjTs4OaAsald/KS8jqTORqRBlt5fyqMpmpTSN1LTiw/yTP/+9XuGr4dSSlQVABX2aWva7rW+;25:2o6CzxEAymwzUO5Z5t/durrLdgmT8OkXnpWyqPIWhm794sdEOXKOVHfOwqvdI2huostDoXWF3G/cWPHNL9c2DICMDJod+rvuf2BjXkz3OTQtH7WkxTNh6eEac3FiPE3tb7dQukK4Fg+8AvGYHQ05wnY6+GiuSqrpqzka3lrVSpk3mgLCmjl756W2Y+03wVBXdMcco8Yj7obNkns5pN+wbYh9uLYTzML/29sYFDOFxiGWNewwYtruZsTO4KGEAH/vg76u16GuovbzNisDPuuN/yR+xpUopmJIa+2uTqdzuA2wrhaCp9pHy+v1T1Q438D4TLtuXjdAt30mwz6Fi2K4nw==
X-MS-TrafficTypeDiagnostic: CY4PR07MB3096:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3096;31:qTH9yVcBtOrs04Dquryr3jB4VwJ8hjk7YHn0J4glc68AhcG37J7rPB11hKBu1Pe+nXQJI00Wb9ysxTAmLTdKvoAaZ87vKu9oagmkqoF9IyO6a7untJ34n2Ot4KXKrH0ChxWjrJ3JzV6eF6klwuAlhPQ4gvuL5B4nVKq9CUCTB4+vHzImYWphUTngCv7XruGXUv4915SRqEdTo+zaK2moDcSxvmsH9ZgSIj+z3EvGQII=;20:vIcavCp6CFAXol1b45OBvuuEVauvP65omJgZMZ5DwCTqltf5BwlwXJLE5/VQM5XXR15baz/DAx7KBKtvzj72cW0QUc5cyezUynq9sJP21Ibo7NXV28/CkxYXLIhBNnQsO5MHgSidPpVWMYlvDJUQK4bLrUjCWhHOYmYWGig6rLrL3kwynJnZ5maH2oId5pYvXcPCItZx/9kYlHo6dCou1VV2e3AvUDVGD41bUfFjL2y28PuP85eJSmEL04zsPRgz1xvZuj4HV6i1RxkTWqthig7/bCui4Mf27PskhTZquywOoExAYlLdBe2He4jMIOkTMxKvCOGbA6UIkz+B6dHS9d8/LZ5PH5UGk53pMy3pxhuNmHIgNqmoLuqTaWP0bRw2jOtYW4xUyPdt7YQmHQFzB0AcuGdJ0MsdUN4hgmQ96NsDsEy6QSusiwhnqo3pYK7YbwB/W+m0+ZSE/D8CjUZeDkUu1lblQstDUI2MC1cqXNyYwHIaaVbUAKLj6SikYaw/
X-Microsoft-Antispam-PRVS: <CY4PR07MB309656087A0355A3A5751671DD6E0@CY4PR07MB3096.namprd07.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3096;4:zOE1wT9BKYn9rjlfXNjkYpxCJepS1a0AeZOWRHZ8z452DEZ7wXt5d6OAKhkay6qj691RFdCSGbH2GKhkxysbNce7s/ZAxhH8ahE0vX4Qa4rPlgdewboMwg7xOrfWsFEdqWM/NIDTS1O0SaxOJcqiNnDhRIYmo1fZWsC2vAp9P9GMbp6ayk+jcKW0+CDbpjpB9cLZ5vEWfrzSjcpwMQP02oUi+r8cA0ZUswy0VMBQnvAemRQYfQ8Jt06v6eKN+RjFETjFaKdhJJFMcVLw86ZPwpNgtHJM3EDbZvK7zSb24/M=
X-Forefront-PRVS: 0939529DE2
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjA3TUIzMDk2OzIzOm84TXdWMDlCREZoSFBoV3NsVWpJSG9IU2Ir?=
 =?utf-8?B?b0c1WG5LT2tpbHBHYTVtTU1CT1IyWXB5VThWZGdVd0ZGeGV0SEw0dGYzMFdq?=
 =?utf-8?B?Q2FISGZleDlVdzVPanFNdFlQSllHc1l4d1B4VE8vYktKRnN4RDlBUUhxTmc1?=
 =?utf-8?B?UEtCcTgvbnlCdklEM1JCeHRzY3NXY1pITzBSMGdzdkEvekxKNGRqNDM4SC8y?=
 =?utf-8?B?dGlGc1liSDQ0UGpVeEx4T3RHK3hCZEU2YkQvNXVCTGxWTSs3RzZHUU1NbW9C?=
 =?utf-8?B?ZS9wSmFZS0pXaXhXc1EzclQycHR4ZjNNUStCYk82RHRyNGFRWVBYQ2kwZitM?=
 =?utf-8?B?QitXRTRvRnhXdkZLOFduOVZlbG9neFVkLzFGYUFiV2JPTXJITEdwM1RMc250?=
 =?utf-8?B?M0hYZUJaV3dGdjBnZHN6S3c5aDdZUmtKSzk4ankrVS9DdDI1eUpiTXNNOFFR?=
 =?utf-8?B?a0pieTVFR0xEdzFUNUZ5YTkrREdkSkVqTDVhcnZlRlREUnJDRm96N3VCZVlJ?=
 =?utf-8?B?OXk5bEwzUG5OVWh6aEVJczVvRmdUNTlQNTdlSTdONjlMZFgzaG9icDdaNTRF?=
 =?utf-8?B?L1QxelA5TnZvdEtqRzlJaGhZNlNNNS8yajJTMXZXeHdPaXhTUGJHZTQ4NEp5?=
 =?utf-8?B?dmU5SnU4TlBCc3JieEtuVmZKVjg4eGZsd1pBUWkzbHlLWU5DSE1ocW0zTURv?=
 =?utf-8?B?RHBnMkVNdDRFZTZYS1cyeUlFc3ZYYU1namN5OVIvdm1TZGRLb0E0QU9xNkQ3?=
 =?utf-8?B?NmljcS80bU1XMXZidnJEWTZaQmxnNjBpMTcrSkpZdTJMODIvZks3aTBiKzNo?=
 =?utf-8?B?TUdyN1dEUWZDVmhibmlrbVpLT0ExQ2xMaG5RWTk1N0RYOEZBNUdhVS9rT0xv?=
 =?utf-8?B?cVNJcFEzcTRhWGtTOCs5UkZ3dUdFVko0VHpGZXlENVJxQVZOS2ZnR0lXR3hD?=
 =?utf-8?B?WENNR3FVcXlMWlByYyt0bCt2MFdCQnB5M0NQdUJ6YUtJVmVHOGJSUXZGWndQ?=
 =?utf-8?B?Y3JuVVF0ZCtrYjBlY25FZXZVQnFFYkZxS21SM0xrUWkxU0FWdXNua0lKNmlu?=
 =?utf-8?B?eWJERzNwRkZuVUVFay8wcTQ1RUpmSXFaaGJaYVIwcDhYVjYybUZiQXlkNGtq?=
 =?utf-8?B?NHZLcklvc2paL2lLZHh5UWdkczRCM3NXdDVlR0NOZlE4S1UvbFgrYnRVZlhD?=
 =?utf-8?B?QktONFR1Mm5kbE83aWxRUytQbTVaWEdZMkFxckVuUGxhZ0pTMlhieC82YSs4?=
 =?utf-8?B?SE1CdURxeTNIdjRvRU5yQ2M4RG4wYTRDaWFBNTM1ZUZwZ0FRcnIzTmY3bmI4?=
 =?utf-8?B?M2pIb1NlQXEyRmpKclRCa2tzaEEzUWsvVXpuTENTSFZKMFEvYkJINFdBbEVG?=
 =?utf-8?B?SzhDY25TNlF1eDc1K3BKdHhRZzJmN0RJRHUvVUY1bm5Jdjc0dU5FVnM1bDhm?=
 =?utf-8?B?Y3BiRlVTZ0VSejlpUVUveDJ2OEJXY09KbzE5ZlVMditQZ2JrNG9HNXNVelZB?=
 =?utf-8?B?RzFiRkVoL2tWUDhhYmlDWVk4WjdnWExLWVhwU2xoTlVMMkVRLzNJTEhmdXpm?=
 =?utf-8?B?d1pJQk43bDVCUTdZeDd1a2ZENko4Q3VyMmVZeUxnbFVLUko3SDNRUHVtTk1I?=
 =?utf-8?B?bVNBeFpTZkh2OWVWdTdXS2NmZUZ5dTNMTDlyZ3laRWpyZ0FuTUFiSWxaNlZY?=
 =?utf-8?B?SnZGSlNJRlRtem1Tdmx1VUJrRjVKd2xZbXhFSnBlT05MTVhjd25HdkxnQWRS?=
 =?utf-8?Q?izncVycYVrvgGwdv8IfYkh6RYi3e+98cWUQWE=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: IWmYJ4unIgJfk+QiugP6Dpc9RVksLqOmMaj0hjTQvQB6F6H8nQN6F33gxV471A3kgV3/Qckv87vghTFUEAV+mRMjjQ9aPvblGKnoqPayg2d1Angql79gX8G60GoUl/6/brt2q/0kiMupPwL1oXmQA1+Z9eA0PNLB+a9hRuXCPaFdtx2cUawmicBtnqFMSba1zDZbW+xf8cXHf+x8FSqKIM4Bdd3Pw/lwZI8kmMqI1vpybNHjnQXEtl71jHKPuShtJq5+BWgL3+Lf4ju4C+9pLDoLTN3yKxoT5foLzQqTzUpa6M8lqj7Bati66W5hGv2/mXVBTjAGibn6NWJNW4FbCYjl+JelyCLn52hFhQssk+utwrVYEbGnDDy1/1HqzD4OruayS81BHPsbpTt+T0EN5DuYLSQilSfbowOjcT91l/w=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3096;6:T4ElQccVHUn0GclZYdNlAoiVZWlTs+S8F6kmV3XK/YXok90sAPmlMmRFAjB9s5qFojdWz6w9Fuug2YvWZBVj5jdd3Utf4AV5kvasCGoNSmGelgTN5ycnniCLdJY1xhZFq03TFLQvrCkfrSVeoZSfR+OnFCh9UREEOW6f+KQlXbzukLtZ2z0QQOqAo+Mu4BjblAcra1WtekqIuUVcW188in+7uib3aauAVB9IjYw3NbOsed1p1Bns+W/666gsou8BWl3ReClADeQo3KVoAI5H9H6KdV63ABSctrJ1sCvqODdkQfixRGTMfELTvsPqG1xhVSvpVV7oLvIUJDS5R0DjQU3dBB7tfoubEuIRcuZeVbjQxw0FfYcjO+i+jrwRGxiX57PE1nD9dVEsfnt/2v0V+4jZz+wGZ48Iyfy2oCfDocd0KYdKhKb3afJXIz9W+VKQw9+hP9yaJfQNZAZKLCGB8A==;5:vABkw5R0aadmS+Gkw+1zZlPBkfFuiTIAXtnMKsJbbrr+qpYFl6KeQljmOh28qcbd6zT5NRMvivPYxuGWyApm+Z/WBwNYgvrtM9b3U2MSnLv+wabam39j5jWKdik8WeFTZW6Fr2JbangCNguO8uJaYG4eaTZSo2eJOrKy2GOoSPAKbwyzYFdF+1yPltOmPfFYSg0Sc07uXTAjXpx2YonC0w==;7:VozvnjK6xCFj+samTp2AQU17nG1TemvIYMt/2VkUoS9b5Nxk2ufuIVboDTWWuNCHJxw4qtP2/ndaLUAuK6BVbZQwUmMsszsQUoalTbC65luYnvWU5kD7h9e8Iy8Mu8XN0NzhnCunOCZ64AwdP5qR2g==
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3096;20:QhogYrgaQ1kKTR7gd74BH9DVPB/taoat5Rpp46uXIl5La9Qm43ErcaxOgs1N8yGtcK/kOc3QfGvZ6IB+ROdpb7BYjkGc9n816Vi3kjRVgvlt9Ox+KsC0M+JL1DIBqbmt/HFu8NEj0pl0SmNOR+UKDDM5eAv5/i/H3udCpe3mbJysqXnvfqIb1g9JiKC1xJGtYrWhu+tZ39Ga44HgqPg7JNAf6e+OdiEB92lsH282ka3BxPyJlk0sXFarEkckVIE/
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2019 17:08:26.1138
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: faf2b02f-b621-431b-8e23-08d68b8c8b15
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3096
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-05_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=604 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902050131
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 01/29/2019 18:21, Boris Brezillon wrote:
  
>> +Optional properties:
>> +Driver calculates controller timings base on NAND flash memory timings and
>> +the following delays in picoseconds.
>> +  - cdns,if-skew : Skew value of the output signals of the NAND Flash interface
>> +  - cdns,nand2-delay : Delay value of one NAND2 gate from which
>> +    the delay element is build
>> +  - cdns,board-delay : Estimated Board delay. The value includes the total
>> +    round trip delay for the signals and is used for deciding on values
>> +    associated with data read capture. The example formula for SDR mode is
>> +    the following:
>> +    board_delay = RE#PAD_delay + PCB trace to device + PCB trace from device
>> +    + DQ PAD delay
>
>The unit of those props is not defined, and if possible I'd like to
>avoid specifying custom timing adjustment values in the DT. Looks like
>some of these values are SoC specific (depends on the integration of
>this IP in a SoC) and others are board specific. For SoC specific
>values, this should be attached to the SoC specific compatible at the
>driver level. For board-specific values, I'd prefer to have a generic
>way to describe boards constraints.
Moving SoC specific delays from DTS to the driver data is clear for me. I do not know how to handle a board delay. Could you give me an example how it may be implemented? Where this board related stuff could be placed?

-- 
--
Regards
Piotr Sroka
