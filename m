Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE6E6C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 12:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 859C420850
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 12:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="aJy+XLXA";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="YhMh+7F6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbfAHMXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 07:23:24 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:45840 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728604AbfAHMXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 07:23:22 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x08CLmJU030724;
        Tue, 8 Jan 2019 04:23:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=NWesqUfIA+mE3K755IgmJw4x7JF/WyTASlo64KlCvxg=;
 b=aJy+XLXAl77ROM3RUtgAor+p7mycVGbdSsxRm4AvumoYisjmbngs9hHWq7EL0/mWoxAp
 h8RUGjItfMHYJNfAYhOa9bh8Z+bRctAkYsuRYBS2R3ikj+uD9GBVAR6tW3qQ7/4lbv2C
 2qaEHkXbAXaRoBhQ5LDr5uKDScEWwaOyvrOSQJmqhdzHiniQKxPNg69FyTvDd2Rpa3ec
 l1u93iv2rKkt3013hdnh64JD75+q0sY5GqyqDlA7WW6Open3StAL+r7mpe6wie64kcj5
 +2KFBZrHwbVcPyxpyUEeB3Ji8rJNlw1huLQ7oECjfQQAcwJWWRl/OvVoJqoRJtWAZgGT Pw== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=jank@cadence.com
Received: from nam03-dm3-obe.outbound.protection.outlook.com (mail-dm3nam03lp2053.outbound.protection.outlook.com [104.47.41.53])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2pu6xwkeup-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Jan 2019 04:22:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NWesqUfIA+mE3K755IgmJw4x7JF/WyTASlo64KlCvxg=;
 b=YhMh+7F6Z3oNH5eiYCz5HVwCcvCdkARFV41XOypaKhhuobZQsRYb6TUf8b4zvxD7g9sMlk9yF2Y2kg/RXpLwv5lymIBIXmIFwtxTuR2TsQTHTrNgi5uJhzppJ/XqFGb+yPwQOOrPbUyB1WaReTgX4r/dg0LENKVeKaLDqoyhIMM=
Received: from DM5PR07CA0057.namprd07.prod.outlook.com (2603:10b6:4:ad::22) by
 DM6PR07MB4412.namprd07.prod.outlook.com (2603:10b6:5:bf::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Tue, 8 Jan 2019 12:22:57 +0000
Received: from BY2NAM05FT052.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e52::209) by DM5PR07CA0057.outlook.office365.com
 (2603:10b6:4:ad::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1516.13 via Frontend
 Transport; Tue, 8 Jan 2019 12:22:57 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 199.43.4.28 as permitted sender)
Received: from rmmaillnx1.cadence.com (199.43.4.28) by
 BY2NAM05FT052.mail.protection.outlook.com (10.152.100.189) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1471.7 via Frontend Transport; Tue, 8 Jan 2019 12:22:56 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id x08CMpDL022959
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 8 Jan 2019 07:22:53 -0500
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 8 Jan 2019 13:22:51 +0100
Received: from lvloginb.cadence.com (10.165.177.11) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 8 Jan 2019 13:22:51 +0100
Received: from lvloginb.cadence.com (localhost [127.0.0.1])
        by lvloginb.cadence.com (8.14.4/8.14.4) with ESMTP id x08CMom7012680;
        Tue, 8 Jan 2019 12:22:50 GMT
Received: (from jank@localhost)
        by lvloginb.cadence.com (8.14.4/8.14.4/Submit) id x08CMojL012679;
        Tue, 8 Jan 2019 12:22:50 GMT
From:   Jan Kotas <jank@cadence.com>
To:     <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-rtc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jan Kotas <jank@cadence.com>
Subject: [PATCH 1/2] dt-bindings: rtc: Add bindings for Cadence RTC
Date:   Tue, 8 Jan 2019 12:22:41 +0000
Message-ID: <20190108122242.12411-2-jank@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20190108122242.12411-1-jank@cadence.com>
References: <20190108122242.12411-1-jank@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.28;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(39860400002)(376002)(396003)(346002)(2980300002)(36092001)(199004)(189003)(1076003)(478600001)(47776003)(50226002)(305945005)(68736007)(356004)(6666004)(86362001)(106466001)(48376002)(8676002)(76176011)(105596002)(50466002)(69596002)(81166006)(81156014)(316002)(16586007)(42186006)(51416003)(110136005)(54906003)(336012)(446003)(53936002)(26005)(126002)(476003)(87636003)(2616005)(4326008)(36756003)(426003)(97736004)(11346002)(5660300001)(107886003)(2906002)(8936002)(186003)(486006)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR07MB4412;H:rmmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2NAM05FT052;1:SQc40NzsA1B6++IsMqedfkeTh1hIadPUSWytotUFN7iWqBYEzdJ3qzjHf6IQovu2lGFXaKA6O+ZO5BFh9X4+usxwu48/V4oBXkf5MCZxYf++K8/4zXV8yVScK95x0c7O
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bbb15a04-efdb-4857-e53d-08d675640560
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060);SRVR:DM6PR07MB4412;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4412;3:GRuQbQgZp0yWSEqIA83u3peUbBZIRd1wqJfv41iLcOqQ8czyK7Ly9VrDrcUnrUJ1C+DbejfOjK+f/qaYUl0VSM6ndCAKeNwYsPi+iIsOX6m4DwyBblXDFhEOlZ++2yulF8eV8yvzPxN2zZg9k3d8rDSdTVZ3hguX2iNbW06g6UexJHhVIOK3z5rhuL2+P132HQcF1u+4AqSGmh9SSWb9e97qKiM60dYj2/9byDZeEyUlT366wXZbjXWcQakMQz7wFaSm3Nab5gfXyuRVXJwsvOWLk9VRCrjoMpkbqjvH4BF7+hjFphu8KABw2ITa+hhcUP7kmNsuybPabp9RO7oLaBWJ5HbGN58Y/xfjqEiR488l1nDVGWv5BojXnhQVeF3L;25:ucowNCLgvrTlHXTrUVLK3j5/P/L504IgT8oDzHWmb4eMhhpk73eIQvcFTVV3jlHCcul6KjKXp+lw1S3zeSFhu1RITVItO5g/iuey2L/WAv17GKqF5qrC0LA6d1mgulfeHHUu+HHb8XV2H653YsmEsxl70SeNE9B0+IdBzF0w6QHrGMH9bkQIXR/9QfgwWIW4nLqumNxS5hgoJruVNIVJGTAbR1nQWONDrAu8EeSjcVEXSTQW9zwL+7vG9Av4yNVXYWnooIJbN4cG8fNtgJsHVh7PCcGiQufL2Z8w/nKq0BbBEFQ8YVWucv8/3Zcd806z5mTKIPcNJOlPkErKcq23gg==
X-MS-TrafficTypeDiagnostic: DM6PR07MB4412:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4412;31:bn9U5+IP3Ose8S0n9Q7EgcV3dutpICOk+5+e8XLTlrCm2litcSGw7B8e3nJe8U36lVCM+1ndGjjsGuUwNZRiHF9hL6DqdnlC6CksUSqyiERFrNtaNhjyffzySRDUYydTcIsCCWEQfSEHIN4khztfy/y4aoiDKGLpSK22I6/LM7xIAy6HSrt7TJUtphXxAOx6G5qbrE2Xdefa9jwyFem2wCwqxTCSRVxlkPPummTGM/U=;20:65K/RiYFUIlzhiTQMXuIdwWhI9RrLyRWGC18SPlD7cxVXqwDup3JSGd25PXfdBoqd8sJrQGBaq5I8UFIlrZyWOIWa9OKvMikhoAvcmqE3WABSxHfMP6roegI4wXLVB638FY2UrobGRyfqsT92YVNRgR27BH6txoMuDIfws9SwabgfNt+Hf9n2LhuAJxhPcoGy8/Cp8YK0g7bKwzPJ8rYbJxr/eE4EvpcWLo1+GopnLhLf7xSY/o6i+2qOwGeYvy0YGzyJx/mfvRWKhvOx2uJdLRk/sNnyQkChkGcSzAMZQWH5k6xiWBjFPAMXGTBGibLS1aveHDM//+ydvEz/X/nE4/XzljAC4ixygKGqPKft3VhiKLGrb4ANUtStae+J3Dz+856Ai3DoTFufsRaeALApgk6kmSKKr8KiZPiDENLtDcxmns4392K+vCrrk/kgigSBzYQ+FX7i3AADNM8ZgMp1/dYWmxyU8KjSz60xl1vGvI3P5HmOmz5di9KrlsRqdHS
X-Microsoft-Antispam-PRVS: <DM6PR07MB44120A5EC3EB3C327007FE19D08A0@DM6PR07MB4412.namprd07.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4412;4:pyBlMiUkpelkQByynvTM/nL5GZ9LnqMcAuB16tJPuYf6+GD/f8sy3xyHw3vK2LfBuFPF6VOsDmtadrCEIAPCwAKr5B9joNMYH0elIAL20rXJTh9ynPwVmXP+GlsK0qtux6OirrG+KxNQTmCqcjNusDMxpVVWIB9EABXGgMqkCliHiwTsRiBMakJEMQCBbOP0EKGsIbTEaL5Z+Rfh4EjMM/zPq/UNgX06MoDAnWRzTcHY1TUhNClidMx9gHrmpyNTNvZtHxnGWo/D0iaVdHxuQpBnDOLCGFj0zwCenCWtqP5t2cOV0ThWeDintEoJouUm
X-Forefront-PRVS: 0911D5CE78
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR07MB4412;23:Pg+oWBECxpJfSnpPz2DRwDmpw4ztsDfqxK8NB97jw?=
 =?us-ascii?Q?b1MvnIzKMaFhtpLxoMEFLZGO+Ehqd/+eGaVXwBLCOZq4XgPGcacL06rqcE2+?=
 =?us-ascii?Q?hUDgMIt/dGBz6OaBAq4f9WtN9Epf5nDF9cOr/GramMl8ldSC7hVEWUxeJBwt?=
 =?us-ascii?Q?PlERJ0v+My2jtTf+hZT3qldBf79zspkgKPZGgHPj2LhmEme5ovNJ8V2WKOHu?=
 =?us-ascii?Q?hwqabKzRPasAk/oKLKRGW6moJAY0xrtDnQg0bB3ilZNZ5eNK7680BFsIJvFB?=
 =?us-ascii?Q?317iCFJpZIpmhBkk4VzZefipTejYvlolEzAvPFrYGLJ9Dgv5V/R2nFX/H/Cz?=
 =?us-ascii?Q?lP8lHq1856ngzd62dy6FAhNzU5ONSGC6vQXWJp24AYgD9fFF1SswpcjmJ648?=
 =?us-ascii?Q?2Z+j0ElWqxyTKAohZhBwpH7LTpkbkReu0CVnoDNCVuDSL7/NywZRItUfq5JB?=
 =?us-ascii?Q?6tD750Mjdz5nePwLNdCKyDQIcLXvWEAWd+QePNx7OcIlD26Vdu9dzeczBE2R?=
 =?us-ascii?Q?ZT79Y5HmfOGPT6PL8FzHmTEgAUkO64SC5X8675jLe7mNkcn2EY0sN9KcQFCQ?=
 =?us-ascii?Q?Dtef2FAzz41913uzj68/DbOyZLH/5In0tE+y7IjVTyC7wIHq/4eQhwT1xMTC?=
 =?us-ascii?Q?wJxKjd+u/zEF0akFeYbz1wpsY/W+kg0Hlk45fCOAfJl/LHpSJCxNN38AeIth?=
 =?us-ascii?Q?bokUkjpr8hCnuTmbuPHr/gih3u8S74uumJ5T7YypV6WeSEGZlYJS3Z4MH7X6?=
 =?us-ascii?Q?8sg+pJAQArqy2oNPd4d85+JYdHVHHyvcYICSYQ4QqWpr5yEmYC8cf2ujX+EP?=
 =?us-ascii?Q?Lw8TXx6jQGe/kkEhXeX3RZ6Mr5VxcjiNz0D80WWsldJAGtVg75NbYpt49KEB?=
 =?us-ascii?Q?VM8MuJehimd9kcB1OwijoVWYFLMRmkmf2EL91UGbsDX1sAU3+JSOiWnEabCk?=
 =?us-ascii?Q?OslKBm6nzfvMBpgeY6Uu6mhjyd3QjpyD69I3hvod7TOLazreZM1V/YXcH+su?=
 =?us-ascii?Q?e+tpOESXX83AvoVP5YZ9q3ofR5T5UqDzN77PFqm78cGJXieJnO/I5dy2GDgQ?=
 =?us-ascii?Q?Iy6uA1f3tv8SXyUiip6OgspteFLIdMKp2QmC3Rez9pWI1p2HA2d6kArNYle1?=
 =?us-ascii?Q?9VvdvgvcVw/BGsHI1GyvjEgH76xctYr61KrFbzXTRyHvZFMaWfe7JzkuguHC?=
 =?us-ascii?Q?lPMF81NXTdwEWI=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 4Sw1ZP6Npr0qH9TpUaK9sj1rLqcW9IDjJRYGmHrD07um6O3uJ757NDTN9H85hPsrBslEikpsf3op7c42o+sENv61fv1fyHmWW3cpGvej19Zk4lv373nc0z4q33Dve5jvLsrLAVfjNmtvEuDrjB3BIg7+cQZaHye10NiVxapDCKbfKB+XiWBO5UIUaDiDzQC5bNnyiT5I9dEZ08P3ZUuyqLZMmM5uU9eeEjICetNsPKND+WZChfTNsRETQjOKMwhvGKkBK869xnbSiBWeFTWq5/YxCPN9t39dnHg7DubdH00fdL6wZ1XyqF/VkoEr39ly
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4412;6:hn/tbrT4yMl1MCzDFewKQ9kO+gODe7NNawIClbWJYY3bT5WpkmBQCJdPoF15oiRDwKpSIsYt9zoK4hF2WcfKu7VHTtQr0QjPvUPkEpifBeZLt9LmEUoFuhNOBOcGjA50m1Nc5qa1mDgky/faNNgXXuXA8jY61YlPAbF1zmA+g5delT9OEdI2ipwc2c0mr0a9xLqxjQIBjOllpwGWqFbQ5h6WIZABSpiHCT0ZiRuLY9klhQRPCXKH+wZzEcxzgg6gp9gbjX5RnvPgbSgWKQVxX5boWDELzuaMNDQmsgxXOpuTVghZ68OF1Bdp+N4mcW9jtNqsohCCXTM5fwQoGrD3owlxMEvz+NV/yB5Iry/iySLDB5V6K4llM8NARmwsDwgDvFPqPZaKy2BaGEeV0rQr3yi1LfbFz4k9Rz2jNHGCaKXXM0+KKriWX61S8aUyIpp66R6mAkRis9H5JmOY77fhWQ==;5:CaQwFd7YWQ5BH97gaUQeReAi4YYZEHYqTb041N3FeY//N64oUAaWZEiaTM1S/Ylcyh0b6WXoWnONpNHlJqeBKiyRR0TVrb+XpFDfvZcu0HR3NM/tRU2ONpY3p8JVBhesvDYbJrvDl7Rgq9Pd9viCvdB9bjyv2bg+KO/MQv17OxFlm7D55N8iSnlVIbOKWZXK8GpOizoaU+Yvsjwk5q/Ezw==;7:9Q3GW/0v9jdWCPdvRB6wszkVCepScne8QSUXHxo6aBM6xaUzNO6yTDMg8YivH877VHUS6bxADrrxlHV0tsNPPdmlc+ECQBNTSLB/4wuoUw3//DJ51fBZRQtkeOnoSYPhiCpDnE7OSxPQvwSBamSE+g==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4412;20:DUIGJD+37jxcbumWWVXI9pI6baL7a21JQKQ6D82otKvVNsoybpwH30wxlmgJOLwYrLWMhxu3UaUO0EYE421NlFerEx0fVJo84elOFngY1wWhZMS7GxHYjvLzVZYznfKkErgG1JhVy3a6StqE9H1XVJQmjvTF4goDhk6e/70YlcshlWo8o9xDmxdHGwl/6klI0tFpexqm5s7u/IypHm1ETf/2rq88M931IY/R/NnMXTChPNBa9CmtU1V89O1AogW7
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2019 12:22:56.4263
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbb15a04-efdb-4857-e53d-08d675640560
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.28];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB4412
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-08_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=670 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901080102
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a DT binding documentation for
Cadence RTC controller.

Signed-off-by: Jan Kotas <jank@cadence.com>
---
 Documentation/devicetree/bindings/rtc/cdns,rtc.txt | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/cdns,rtc.txt

diff --git a/Documentation/devicetree/bindings/rtc/cdns,rtc.txt b/Documentation/devicetree/bindings/rtc/cdns,rtc.txt
new file mode 100644
index 000000000..40713bbbe
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/cdns,rtc.txt
@@ -0,0 +1,25 @@
+Cadence Real Time Clock
+
+The Cadence RTC controller with date, time and alarm capabilities.
+The alarm may wake the system from low-power state.
+
+Required properties:
+- compatible: Should be "cdns,rtc-r109v3"
+- reg: Specifies base physical address and size of the register area.
+- interrupts: A single interrupt specifier.
+- clocks: Must contain two entries:
+	- pclk: APB registers clock
+	- ref_clk: reference 1Hz of 100Hz clock, depending on IP configuration
+	See ../clocks/clock-bindings.txt for details.
+
+Example:
+        rtc0: rtc@fd080000 {
+        	compatible = "cdns,rtc-r109v3";
+        	reg = <0xfd080000 0x1000>;
+
+        	clock-names = "pclk", "ref_clk";
+        	clocks = <&sysclock>, <&refclock>;
+
+        	interrupt-parent = <&gic>;
+        	interrupts = <0 6 IRQ_TYPE_LEVEL_HIGH>;
+        };
-- 
2.15.0

