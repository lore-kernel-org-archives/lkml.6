Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F5F2C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 11:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC45524031
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 11:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="hM9/sNPm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="ZW1wtlHE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC45524031
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934046AbeF0Lso (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 07:48:44 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:43140 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932340AbeF0Lsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 07:48:41 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5RBcRNP012101;
        Wed, 27 Jun 2018 04:48:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=0wYD1epWaIItBGVYCqvH4Mz/pUHhn5EH036C71UrDKY=;
 b=hM9/sNPmNLHEOu/uqlysGFGga7plpTeuKxuwWZYXDMwy5K9Aj2rllqOL+sSyGOMtPVGZ
 9IaiXfkkPRcwhxmiR1lONuwAYpQoJlrV5rU6t+AUWNElRWVik1Ws4yCQNr+y2mgXWWeZ
 RmodrIXTfhbOBN+K0QwadENb8EIyEv5gtgM= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2jv3nfgpwy-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 27 Jun 2018 04:48:19 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.24) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Wed, 27 Jun 2018 07:48:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0wYD1epWaIItBGVYCqvH4Mz/pUHhn5EH036C71UrDKY=;
 b=ZW1wtlHE7Wkjy9wGhjKgwMfDjueiVPoIvdmU94J3C1fSar+hhW0LHa2qaWbAovcaNgIoihMqWdwx00/lnkwQqerpLtpiojKbMVCollYKosw0hyLhNUl6Kcxm/8rrKSbnWaklnIgriBxnHSjG/UXNPO5n6naz/jsrV/yHNALebZM=
Received: from w1t1fb (2620:10d:c092:200::1:e949) by
 DM6PR15MB2508.namprd15.prod.outlook.com (2603:10b6:5:8f::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.23; Wed, 27 Jun 2018 11:47:53 +0000
Date:   Wed, 27 Jun 2018 12:47:39 +0100
From:   Okash Khawaja <osk@fb.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
CC:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next 2/3] bpf: btf: add btf json print functionality
Message-ID: <20180627114737.GA1580@w1t1fb>
References: <20180622205535.c6vjhdwt5er4wc32@kafai-mbp.dhcp.thefacebook.com>
 <20180622142743.2b890d0f@cakuba.netronome.com>
 <20180622225408.jor7lpvsksnwiiec@kafai-mbp.dhcp.thefacebook.com>
 <20180622163200.20564ec4@cakuba.netronome.com>
 <20180623002639.h4qxy7aakypi6t7b@kafai-mbp.dhcp.thefacebook.com>
 <20180626164820.GA12981@w1t1fb>
 <20180626133133.618af1d3@cakuba.netronome.com>
 <20180626222709.fsznwqauxojhhx7v@kafai-mbp.dhcp.thefacebook.com>
 <20180626153559.0511f709@cakuba.netronome.com>
 <23968d53-2895-f0bc-a38c-5bc99e1846ab@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <23968d53-2895-f0bc-a38c-5bc99e1846ab@iogearbox.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Originating-IP: [2620:10d:c092:200::1:e949]
X-ClientProxiedBy: LO2P265CA0190.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::34) To DM6PR15MB2508.namprd15.prod.outlook.com
 (2603:10b6:5:8f::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45c4c544-0458-480a-28b3-08d5dc23d234
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:DM6PR15MB2508;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR15MB2508;3:g6kdNSo7TziRtH2rOQxERh4qeacRhvDljJAbUramGL3aVhUa5Q6NssBZANmBcwweQ+P4Xpbi6p0ZiIV32Zn0/o/dsiZ4dHA1J9g5ve2j0wg/toUxG6AObcfSCaDjzihxhakXE5ooiRm5nZS+4Ybh1dwrD/0lpszw8YVuTmlnCLSqoVvA0ksZqsa6/WSzqHelef/5YvtXCWY7LxE7FNS6aljXpyaqjhyQFyBscJ/U7QO42OgSiphbEs/Zysl/2lK1;25:T0ziDv5qIsQorl4OWNCt9R2FNj/vsGyRD+CahBchDurfrL3a2OblLybR17YQuAoI4/aVDRf7J628SBYac3B1iv9asyHL5N/gKh8LROEgqUMu1afgnfMFckxbTQ6NyeQDwnN2foXGuTO/u2e3Q3boNx+PaZXG1+04F3mDcDKjYbMC0d+1hxV0hteI+0MLIk4jgUHLOB4ILFwqXppSpyLWGPkDumJQPM66JOLCb07gscfaag1G1HKQeKedNEyRVF8yh0tAg08oxX2JgpqB7l2Sh5BTPcssU8nyahKj3RGQBYPIzvF3I5WQe4SrnYYK308/klTp0rKLvk2foSDpHS+5hw==;31:tJs3kiRSK5vvqciwt9utdoaqGVdZSEhHajBP6G+CXilrfAUsJnY10dis++33zxqgXMn8ANVbZCC+KHRVS1xeJXnLtT3cjb+56XEq7Ys9nweBy4c+dyFvlPwZg6XtYGIh0uZThgD6loWLN/Shw9CExwqyVSn8pVMPehKJg1QhmrgySmt/o2Jrxz2mQeQG3C1clcPAl0Ig0eJ6t4SHifcEXpFmFS/COR2PvxzcE0iSxwU=
X-MS-TrafficTypeDiagnostic: DM6PR15MB2508:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR15MB2508;20:USVVdtmodFGyGrBmH0bnPMhkJHrS7IL0kv4CmHc1IBQr7NUEeVXcvtFQbtUr8UEjY7tM0LGmAYHB+lTch6zfoPO9VX9AI/+DLhZY1GKeO3+jMkTFV4IsAADiVmjHr3bS0EQ1Bn4w9tGI4maZyjbmcw66imfpiWg290fDZDEkTf1KLZr23DB4EKnlJoqG7kq49/SrOJZfRbmgqdL9FKt8xUWvFETzv2tKuq/MFXZeUd3fduatp2LfuHgbIK3aZFPznA2e70FJVHsvuX2CQdvqr3pWPLB5diBaJmQWYaRWdMKmfkGLm9a+eIzrzYe/FWd3kL5417krMnVjzieOvQTwByCIbFEA8kH2/CyyBntk1qqoC9VKuumHqLV71F0Eh41kBpXaHoAVPLkN2W4NDBfyEWM5h22jUm+3OeTCMeyaO+RJugFRDDzEiPjKmIj6o4B5Ufpw0YgItUZXM3GFxgUxUicmKLI47gdkGFh3A5yQYdknYpx3qlwXClO39CBP2ZyM;4:ADeONpYd4kPiESRadlTayKB40jQXw1AVPRhWziYXK5ZTlf476XX7tlRBw3+RhuBwBaPe1UUJkNTca/9LaTSospWY6/PefHVqrgf8GUxED/3mf1cU06mqK2Xz9xL60nDS2bUf8s+E2c3HYn6scmqaZ65tUfLws3RqTc9y3MBuBSIEI8pwVuT6GIbiBzY8s0xtLrNP0/+2pthraDf2nEiuIY8peA7TLiz+47bUNr5271vDB+suSsnrBV2mENmUICS7OuNT3KimtiVicvSDkrj7iiGiaKS9AOibCpeqVmQVfP7ZbAqdgYEtlH4np20zVmfI
X-Microsoft-Antispam-PRVS: <DM6PR15MB2508E270C7B7F3F85CC2E0D2C6480@DM6PR15MB2508.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(100405760836317);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(11241501184)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DM6PR15MB2508;BCL:0;PCL:0;RULEID:;SRVR:DM6PR15MB2508;
X-Forefront-PRVS: 0716E70AB6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(346002)(39860400002)(136003)(189003)(199004)(4326008)(33716001)(25786009)(53936002)(39060400002)(6246003)(5660300001)(50466002)(58126008)(16586007)(33656002)(316002)(93886005)(54906003)(68736007)(106356001)(55016002)(105586002)(6916009)(9686003)(229853002)(6666003)(478600001)(446003)(11346002)(476003)(486006)(6116002)(1076002)(97736004)(23726003)(8936002)(46003)(16526019)(186003)(2906002)(14444005)(8676002)(81166006)(81156014)(6496006)(52396003)(52116002)(53546011)(76176011)(386003)(33896004)(305945005)(7736002)(86362001)(47776003)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR15MB2508;H:w1t1fb;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR15MB2508;23:uS2f87NVtzRGzdgQgHlZSos7aBYjTnZkb/S1+dSqL?=
 =?us-ascii?Q?Oteh5xPC/clJUGCoG0GjTNVDyNBVEAet9RvznEGKEnuJ+0lycrTmuWhW6Juu?=
 =?us-ascii?Q?1C497S5X8dmafOhpe2DbUfTvy8ExzQ+jKkqAl8U4tyrfLsI6gGeDWCgb/y6L?=
 =?us-ascii?Q?UL8qX5ptl//Tz3+xT3geW9EIz4zuJIMd+2y9DMLczffwAp/LEzGW6tWncEsf?=
 =?us-ascii?Q?c61KHFaI0XrDb4lr504fzIvFxb3iAbSUoa73GgijEbjTbDeUfBboZ5ts+V0/?=
 =?us-ascii?Q?jthBNzxOgEFfniSCLTD7diwoTLbQ33LGuT2iLjICCtgnjaIwkUooWudqqwBC?=
 =?us-ascii?Q?kCByutmznLcGsjZDPLxKcMpjkGsoCBmlJqIDqDfEQZkiWcuwSJUzOMtVLJRi?=
 =?us-ascii?Q?GUdVzpAYwlCfmr8i1FzR+ucHJCErML+QwUz9UrJX0uO+1tB7FVU6oa9WMFtU?=
 =?us-ascii?Q?amTxKCfwA7Yak11O2I2quMma/5/LDPyTttiaMXLfNZn7nGgHReS3KWy2CApG?=
 =?us-ascii?Q?x6DT3aztyZzGuZHKowywq2LrmV3DWcmgzsJOdKmtSvlVOeUdGTC3vNsx2gCD?=
 =?us-ascii?Q?D1qlEptA0TzCiQtd3gjjdDKi+llJnjjptXoHUhkgph2alCwH4raFQBst9FVE?=
 =?us-ascii?Q?2bdat4C8sxaXHrpAJm3huFzBgOga0L8QcwQ4wNon7iHwXG2FhNTpI3mmP2to?=
 =?us-ascii?Q?cCNQ16+ZMl19mqrFGge1/7zJ9LZ7h5Ph5fVpNsj7dhgYVF9JsqLGwhFGPFy3?=
 =?us-ascii?Q?sQZxKDIOg9iOrgKB6v0JUTJCyUMLRVvP14yKzo6CLHWS8XKA7bDFCzdW1t3J?=
 =?us-ascii?Q?uUgbZf3LhhU8qJH6bOfLJ1+Zia5Vzs1V0dM9n1VZpzCN26nVNOG07h42XrT5?=
 =?us-ascii?Q?7ABLjBaXmNspnhLerfexPXNwKUnzS7vz+SEIvrZCnMBTr1//V65npEpgFldo?=
 =?us-ascii?Q?+bK8f5r2jnc/S99drIpfEzqAh01bkHwfpqW5jX/8lMYciyFF+9COFf9fE6Lu?=
 =?us-ascii?Q?diZXPiWFnOkLWGLMK0Wld0T8Lcp3NRtRf2yFitKOi2uK+0dKRc6s4If27hfw?=
 =?us-ascii?Q?DzJPWJQnWR9orX7lUtzqC9kpFH7FzB31PS0Yo5T2aZ099A5so75z6dGdPWN1?=
 =?us-ascii?Q?8H/0ZijinnyCuYl4/hJ4sbPlzxEIBC144RDW2hd9L1Q5Av8XH/i1VzPk08PA?=
 =?us-ascii?Q?L7ndZ1BHzFlXNjuCepCvE/zHcrZtONm6f4amJUqVHX5kam5sYZ660ufpdgnO?=
 =?us-ascii?Q?tg9vIs0Bf9HBF1lkJegMiHxWM4xAYK1GOYtA5wB2qA+ZFeoIAxXg4Wt8oZQM?=
 =?us-ascii?Q?zXsJWvcKq4bU7HS1+lhcZOGB5etOs4lVfmI8gM09hDT7DA/BUOrx3MkBn3/8?=
 =?us-ascii?Q?goHNA=3D=3D?=
X-Microsoft-Antispam-Message-Info: 0DKYB9gegw4xitwffCmMFsJcCgfa6Syh6I0cg//SLvUXz9LDG28DfSUMOCUMbvyCCFImiOG94/GjCYPCr2fjoKYQLj5AasMnTSbkBNpwpongfOLlsRjW7kUTLZiXvT8PuYBkRXATmOZbknVIqU/TbnKEoEv6fg/lInVcqobSHtNTzwjiSxmWI2WFK3MgRS+2F1tlXYJRvAHr8uz5ng32wfnxOLmeRtaj05nN7Dz29SMpRX3BaEeKFJZRGORsfrmuIdw1CvxBbao4wLBwpQCoiB+7lOk4/vF9kBIv5pj1zTCuv/X8qeYdSIWU6+MmaHfdrVU6OmDJo2Xp+oaNjKeDEClUz2HUvQfWjl7ZcdURiU8=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR15MB2508;6:8QkPQUZxyf98qVY2mCXVHaM2DlvSEcjk7sw1VVLB8NGU9r4z7jRt0TKSxuePqY/miTJGRXAV27zFlP+FWb/N0/5losw37wNAzVU6dRr/zYbug3cVYVqEH6hDOOPBwKWBz1R/0+qyzRArbhkNmDzWHILlfXw4saZA7UQBKVv3wqu8JoXQk2Yf6VHCsqX1sNbxp0N9NYQkG1igLeGcHhijlE2t4i3PQCc1YTd1/oytHRpa7wcIZ0uS1gK2X4VYlne4sSMUFbOszwK1CC/tc6kXqDMRela7PXdZloYsqFMbPBFwn0kGAsKkc8LjgAdVaqrq0aL7J7holUZnXmP10SrM/TCswuCGz5jo7A2OMMzFXFdfeQg/WSN3ORjCaqRuAO/o/1pZt7UDlSJm3Y1XjPM05TA/OiiPEOkKgjtz3q4wMJeP1ja2MnjD9QVXk3z22rMFdbwQHQZb1mebOIkBU1r9mg==;5:gudWWHa5oOKt8a2kpECUlqrb2C840AyTvHvAWc8w+18X/hsLntuxzSI11iG6zCEYka8YOb8eE3ycFFWpKg+XthmIxBQ98kp8sRiEb+ONZPfR8kHpnpe8RKedLbK9EFaXJsEea5ZwOmW+YwIk+aIeB5nZoPnYbZ6JEXwyyLYPavg=;24:AFACyp3idWv4ZKFv9066GLJjcCv01CgPTNtS0ry+K00IrQEAbWTCI45ZC4jzxNy5yfV7dntMhYdTUYqKGyVO1qgxv40MUjMg6brbzKrYOdg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR15MB2508;7:fFrjrH2LoC5F1pHdiGtegqzCLNUgxGFQmewlIUEiP9h55zqREUUv3W7ryl22U9LoyvT9wSh0koKvFa6jv/+AgC2Obm/lB8wyLh4j2Z41NdE0ZIkliGfCDOkUs5dhXWX6zhPkLERWj6f3alpF3YIXBYMml5s0NrFTCELp6MNSSZj47zrFiugu++aBs3x3DC8cXTw1pAl9PQTZdQMfZS9qFnjFaDXsic6Y+6mo9B7mLqH4nYdZ++7TokLgRDsFV2eA;20:pjccgYLhWPen1BMDrzx53ntVRBb832V72DUKfJImjhjak+5NcXFoxQegemJbmx49GQYK8XsuhJfgw40vB3M311BlnqwuL30UA+w0sfQGbfiPKZsTCwxM2K60EmozyI6T9wQXoa/uy9Q5Cr4rMmwxNnABsh+h3+28UQdNYDhEbOA=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2018 11:47:53.7799 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45c4c544-0458-480a-28b3-08d5dc23d234
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2508
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-27_03:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 12:34:35PM +0200, Daniel Borkmann wrote:
> On 06/27/2018 12:35 AM, Jakub Kicinski wrote:
> > On Tue, 26 Jun 2018 15:27:09 -0700, Martin KaFai Lau wrote:
> >> On Tue, Jun 26, 2018 at 01:31:33PM -0700, Jakub Kicinski wrote:
> [...]
> >>> Implementing both outputs in one series will help you structure your
> >>> code to best suit both of the formats up front.  
> >> hex and "formatted" are the only things missing?  As always, things
> >> can be refactored when new use case comes up.  Lets wait for
> >> Okash input.
> >>
> >> Regardless, plaintext is our current use case.  Having the current
> >> patchset in does not stop us or others from contributing other use
> >> cases (json, "bpftool map find"...etc),  and IMO it is actually
> >> the opposite.  Others may help us get there faster than us alone.
> >> We should not stop making forward progress and take this patch
> >> as hostage because "abc" and "xyz" are not done together.
> > 
> > Parity between JSON and plain text output is non negotiable.
> 
> Longish discussion and some confusion in this thread. :-) First of all
> thanks a lot for working on it, very useful! 
Thanks :)

> My $0.02 on it is that so far
> great care has been taken in bpftool to indeed have feature parity between
> JSON and plain text, so it would be highly desirable to keep continuing
> this practice if the consensus is that it indeed is feasible and makes
> sense wrt BTF data. There has been mentioned that given BTF data can be
> dynamic depending on what the user loads via bpf(2) so a potential JSON
> output may look different/break each time anyway. This however could all be
> embedded under a container object that has a fixed key like 'formatted'
> where tools like jq(1) can query into it. I think this would be fine since
> the rest of the (non-dynamic) output is still retained as-is and then
> wouldn't confuse or collide with existing users, and anyone programmatically
> parsing deeper into the BTF data under such JSON container object needs
> to have awareness of what specific data it wants to query from it; so
> there's no conflict wrt breaking anything here. Imho, both outputs would
> be very valuable.
Okay I can add "formatted" object under json output.

One thing to note here is that the fixed output will change if the map
itself changes. So someone writing a program that consumes that fixed
output will have to account for his program breaking in future, thus
breaking backward compatibility anyway as far as the developer is
concerned :)

I will go ahead with work on "formatted" object.

Thanks,
Okash

> 
> Thanks,
> Daniel
