Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 297B1C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 11:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4E7C21A07
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 11:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="ioBtnw4Z";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Az9hluUD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4E7C21A07
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751351AbeFVLSf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 07:18:35 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:49700 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751086AbeFVLSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 07:18:32 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.22/8.16.0.22) with SMTP id w5MBDZhc027056;
        Fri, 22 Jun 2018 04:18:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=LS6VGPZemvAvjyAONz2mH0ZBUdTAnBL+7sEgo7jlaNE=;
 b=ioBtnw4ZL7Ozi88vm46+hGImG9cWaPJxpsiPPFZnWxTATJs5Uyh87sR1MTlSGrZnT9cs
 cEEgK4L+oJ7TsxI8O483MrRcP5f6TO/t16RUMyKDj3JTEytDpHitsutrf9QZawd1IwRG
 got66skyY2Ni8HBX4lqEEVlApdan1eueY+Y= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by m0089730.ppops.net with ESMTP id 2jrxj186te-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 22 Jun 2018 04:18:08 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.20) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 22 Jun 2018 04:18:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LS6VGPZemvAvjyAONz2mH0ZBUdTAnBL+7sEgo7jlaNE=;
 b=Az9hluUD2A2o6m+ctwPIQvVxjpC2GkNGghEPZ2Vvdo1eXDexKPnvho3noh3td0tE5pwu3un2GQjRefdtxHVMmu8GCljPEnDjnrq+FO5rpGjq9FzKx6mBGLMF7nEO2Tn1IKTuHExLFRQiXc21OskOOQfrUhYeK3D43OWa2daZxa8=
Received: from w1t1fb (2620:10d:c092:200::1:a89f) by
 BYAPR15MB2501.namprd15.prod.outlook.com (2603:10b6:a02:88::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.17; Fri, 22 Jun 2018 11:18:02 +0000
Date:   Fri, 22 Jun 2018 12:17:52 +0100
From:   Okash Khawaja <osk@fb.com>
To:     Martin KaFai Lau <kafai@fb.com>
CC:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next 2/3] bpf: btf: add btf json print functionality
Message-ID: <20180622111751.GB3050@w1t1fb>
References: <20180620203051.223156973@fb.com>
 <20180620203703.101156292@fb.com>
 <20180621145935.41ff8974@cakuba.netronome.com>
 <20180621225117.dhrkrtmkfbeihbe4@kafai-mbp.dhcp.thefacebook.com>
 <20180621160719.2cfb4b58@cakuba.netronome.com>
 <20180621235746.dfq6kdtkogftw3ws@kafai-mbp.dhcp.thefacebook.com>
 <20180621172523.6cd00ed1@cakuba.netronome.com>
 <20180622012052.htkvholi674x6i4f@kafai-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180622012052.htkvholi674x6i4f@kafai-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Originating-IP: [2620:10d:c092:200::1:a89f]
X-ClientProxiedBy: AM0PR05CA0043.eurprd05.prod.outlook.com
 (2603:10a6:208:be::20) To BYAPR15MB2501.namprd15.prod.outlook.com
 (2603:10b6:a02:88::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 334aca44-78b7-4a15-f9db-08d5d831d2b7
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989114)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB2501;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR15MB2501;3:7Kk/6G6wmYGPJQwGqLUv2Elb8RxBLZGWEtuM5fJpeKA3HsEIwmx0FafCFre26Gqd0dFi+5Nm+3ioLmjmrgoIJWRus7Q7BrwIjq+FfyyV8Ote8NWKrsoqStdomBBEqBjvdx9s+9RPf/ykkmCv9YvuZelXq1f6U7lDzEz/rM9JOejAPUmJAdrO/rk3sOu03hVW2W0nOxVFgOgHj0XJU5ti2VbRXjadOge3EFErdRDAzPk1OWJHxEkwO74QBH3p+VKv;25:BWF/bOIb3JoP7wbSmyT65NylKnyQHf0K+y3sopIeE1zfhP/t8GN6QRG1DJLJp7oiSCEGjuOzuJbPUNxilijr7btxsv4rpxeGfXs+ZFvajfV2QsbuV6wlp3wxrCYqWmn8Ci7LfwYT2bi+9XlJZuhij+mWj1A+/Fj7BkbPs6et8Gckv0KTij/m++MSCU4zywHXRx/YNa3OY6gBHIyAG1ZYrvOkRSOc2J9+zxXzjuN0A33/g46RsbK6l0Lwwktb2OLC8W94xzhJEyvmoQByzFFdloAEhrDj/K8qnitpqhJJ8ecVGDjYLWkFBGR3B38rGvxBmj6NCB5p0tZhvojkz3aJ5A==;31:C8Ev5hZd2zPN0EN88CE7TfUMJKZroBNgZdDwt1ldSoYcVcRjUUytZ6+kjGeUZ2hQBlE/dFRjl6YS4KALaPyOXLAQzLK90vuK6ED2aMVgGyVqoT7eGiErq1ZG5KeDrhcX+QcHNTNRWQ4H3KSdVgWRXYndQX4waOp/ZuaversAFK8te1APSPlJDGdXVhnu9TTyNRWe3QFKZQv65bpBvdXUudGoLS70FYnkhchYfNumEv0=
X-MS-TrafficTypeDiagnostic: BYAPR15MB2501:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR15MB2501;20:nF0lTzsFK0KP06fJRLDJjcIHs8H9kTXihqNwukUUY7FymF7ZCw/nfG2FveRlXajwLAiaFwQzH8qYF91Xzy4uJsUvtbruDDdfcfYOEGXUhZ9JDSANjbOFl8cXEbWip0sjNd3tvVQZclIakwT4rDTy/MAtKN++FDx12ejNmJoh1WOpRHFXApb+dsozsYl2YScJcwq56zv/4BM8BIv63QwIVJ8PoinkqC1VUK87/rdTS5M/Ti5YsuQbKma+FH4gySkvdU01d9vAz6o8A+l16JkgvMsXOTuKIFdToWo7KFG9v23Ze8k/mHo7OO8/vULQjA7CmI40ubjpr1ccLCqYWR0hSnNmKvjRCZGCS74Xr9Axea4CNJ1VVMrmywlBuSSeqljPJWIVsy74PqY7NwH3QpJSVuhjfXioCcQsgcZpMAz5DMU4EuvDOJHl8KAks4iGBzPGZf9SyRW4Aej8wfwi06cEZNvtTM3SRufq6Q+VDza4I4fmeeJ8dQKXBQrFKQZD1ByK;4:VxsKDFTaBhpKVy+E3A4oMk2/FHr7moHGr8WlI7rhS2GNMngkvOGz5wicF4H9XhlnQXIkdJzxcckB1MEUk9tK/E+aP7q1hI6CLmIB0Y9RFREpmGkbsbyK6/0gCjhR1fYE6R9k2GO//Yv7hF9GE4IGq35RV8b/sLtfu2ovOUpxNtqn1BUoz251lU4kMCcsgi6KrpkjvzV0s+1siJXyJ/GNGw13FNf3m4+Cm5xsrK9VWz57q7ncBmwHBGqZMO2qW0iUyyWGmFs6ZbqZrkHJR021JA==
X-Microsoft-Antispam-PRVS: <BYAPR15MB2501EC1ED8D37D2FA14DAB79C6750@BYAPR15MB2501.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:BYAPR15MB2501;BCL:0;PCL:0;RULEID:;SRVR:BYAPR15MB2501;
X-Forefront-PRVS: 071156160B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(346002)(366004)(39860400002)(39380400002)(376002)(199004)(189003)(39060400002)(6862004)(9686003)(6246003)(97736004)(7736002)(81166006)(8676002)(50466002)(81156014)(86362001)(53936002)(23726003)(478600001)(1076002)(6116002)(8936002)(47776003)(305945005)(55016002)(25786009)(2906002)(33656002)(58126008)(5660300001)(52396003)(68736007)(33896004)(76176011)(6636002)(6496006)(16586007)(54906003)(106356001)(316002)(476003)(93886005)(229853002)(446003)(11346002)(4326008)(46003)(33716001)(386003)(105586002)(486006)(16526019)(6666003)(52116002)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2501;H:w1t1fb;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR15MB2501;23:dPEMwNqB2OeHnCjgBsTVNkXihEdN1PB95HDUtfPQ6?=
 =?us-ascii?Q?SNGefYXkrxhabDHaDli3dU3Mw3MpEK2/K+mqzPB3aFTJVf15nZb8+O5RVRTf?=
 =?us-ascii?Q?RBw+3Ymm+kg5eu2MxoolL0YiAu4dINlE914ymd9ULhtoNpQo8JEz8snvs66J?=
 =?us-ascii?Q?Rgh2WwqJJodgMl4/huiglx6EdzjZ3Dz21KUX8yuP2aRcAUk52KLKgGW8H6zl?=
 =?us-ascii?Q?j7+t5ry9EEz2UaLTpIewzkRRBYDOXYpAbA4XuLqInjpiXeDBFo3zvSt4EZs7?=
 =?us-ascii?Q?Dz7+9GWQ1KlUKrBVqhYte6pH+jSXMp/ySeaLiuQJ/lUB/ToR1QKafnEcap9U?=
 =?us-ascii?Q?qsfrTiNjjQ5isvwHayV9m9J5TSSRDu9Rm7NPS+UYMc4d/IbKxTH+Ye/3H0ly?=
 =?us-ascii?Q?kcZPO1llKYFNNVXN5KNgkym5C3lP5QDKnd170EnGXKyjN8Co/5ISOOhtE7Qd?=
 =?us-ascii?Q?69gFvkLwKQNH5ilvLGdJjclo5MzoCyUAL7ZblkvmHer/jaWUHA9oVJYJjoeA?=
 =?us-ascii?Q?IQRJnLfwAOasAXiTR7IOaqX1HyC6x3WMKg8leobdRM/UqeKx60Nqrjt9Crbb?=
 =?us-ascii?Q?wu0Ovy3Y0tE+cRuwWHqrk8ER/7N5HyZ+FClAxOeEuTez1kn2/YO47gpSObUA?=
 =?us-ascii?Q?mQCABJ++u42QvnFx+PuAFycmgdcDedk0Z0kywZAbIfxi8NzcsgumnYqYukD/?=
 =?us-ascii?Q?e3HzIfHxQrVh55wB8K3fuSOLVN1/VBtQiwM3abwQQJbywqYP3fZwm1ZtE4ID?=
 =?us-ascii?Q?yTTRykJblG4gtZQBcLumwW9BPfh+MLvOsuBu8geDWjbAzygkSMfweFJ45FUV?=
 =?us-ascii?Q?VsR4xm0p/8qbwxapj1TH6TIPZAHozkgbg1/oeG9KGXVdKDSB9G2VGWBeQBI4?=
 =?us-ascii?Q?U9U1NyryC8Yo5LgM3vkS80J9SDJtMEKiD/r0gCVU3ZhG5YdaXZXfbHFkbjsc?=
 =?us-ascii?Q?//wRwHt6XqI9CuGBu1Sw5Bb468eBeJMfyAt1AOLOMRcc9qzcsEU9FlmC0OVB?=
 =?us-ascii?Q?dZSsZHR2MTrjiGSkRxpjxbZ6Brb+txmz5RW69JClwnU5niiwdORN2kr8VzX6?=
 =?us-ascii?Q?8bMztLySjM4IuU6B3WpzbA9qbElb0lUm9rWK0x80nvsIqIFmUT0+SEt62OkC?=
 =?us-ascii?Q?wLAltNIT2NrwDME/mKa//HRJ67Eb8yKdCXglkZ3tG+cPISID/oPoqXoMlsLw?=
 =?us-ascii?Q?XL97k0DSjgv0gMxmerfVZg/QcArvkwzZlVOqsnCfKVwGF0q+JDV3D45QYCn0?=
 =?us-ascii?Q?TeF4/wyrR83qxhe17/S6zPt91r5T/+5/IxA1Hl73vrZSgghnSHh1qURPYFJh?=
 =?us-ascii?Q?+38mJrsUBUtVmnB4OHcaN9Bb3iihCplmOfCZPIS9Z8p?=
X-Microsoft-Antispam-Message-Info: +MeSZXrLhrSAzy/Vod34x6j9gjTin4dgWLhb9T+3XGxQFeDCk0SoPyH9rlCi1DqGZT3+qXOmYypCVrplR+R2krc6grmgKj+pyt5CckVBUNj8Qav6lUDBMWValsfUxzNjst+AHwNJ1l8VPcQcg4BJh4lfeiAfV3SFARf4WzYVJGFys4zU4gNpP7D2o/NGEWeArgVVZwnrjd0cWOdGyhIHW43rt5MIChkZdVMefXRZEE+l/oVVV2fl83yAiojyXyD4JIlm3vteXWcyiWJhX5VSBy2B8ACbNQVnDfmN3G6m5Xs69sYDHAmJXBd1ZYpMUbGj1V6+NTXO/JOPIyRRvCXhpQ==
X-Microsoft-Exchange-Diagnostics: 1;BYAPR15MB2501;6:rG/dIDkn9C56K0wFzkXP6WNgdHoVUw4nKji2dB+x52XpSOXHDTl9bf8g4CFo9kwZ0E+CqSk5lvr/fLOLdebuMnTnK0Lxsn/35aoeRbnkKfcxDgRH9pdgew6Rq2ORhtk5/NJzJKDzbKYW7qtFPvQlF74mOMKmN/AQU6opYzrKp5xV7LMniIGtRB04GAO3Bywq0j0FfkAbllzUydykdQyMlazil2/dPtLQmbnSvNmUqm38kovLTMvssPY8DEZwHxBoA4E3VFBPxTCX0mFa3FjVzSMvqmi0HtsMIEvKAIcm3YbkuNLeXlhSt1UAK4glZgodqk8zgJ6MLJMWw1bzcZvFNHiyJkFdxrSZwAoRJApogR59PC/VrpA9ChlmXw5oDLQ8cSKsYidzSqMvFvwKE7xGx6EiBiuZEFj/XGAnzzTl9YTxi3f7QDJuaVRaoF3mn3iVvJuzhvSXSLfYmEUh8CAMCg==;5:NVFkMaPr/RnprkW37RM8vJSArX1C/P+d/OB4NtXERRM0y7V50mlEd6xHag59ZGuSgV6IGhok83m3s+gt0Ytl7BYf4fUA5YgCH0SrJdaxvqdkwGUYMsj+XXcgbN5z/eUb1tGnRpqAz0LlGwNnmeRRrn92vtoTRLvxoR3Sa1Wf8rY=;24:kFKFu7xtIRF/yxaS0BkechiPKebStKasVL0biMtAezymy24MDkp8fLFhzpkXiij7J/CV0Yk6dd165sDmGuuBeQsRrzR0Sa/zNT/+v0UJlIw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR15MB2501;7:6rn6tpCMm6bzB+dIAclTEfEURj19g7OM9k3gXNDb5kMjy11sMXL9isfoo2ZlsW4tjqrlc5ePp+JlHLniVGoRvX3xo7Z41TdDq90RVn980ovq3XgCb+pTlpxo7GEAkbbIcNkpdamtbcHyxb4WHIqOetwN5L0xgtCuHhkjt50qQ7Qxt+h1IahBUT77gcIF7DMKGLKOk900hkIYrAyPkPSoLn2bcjmzNzY6B6mYWbirBvuOk87babhP7uB1CGpyKwFi;20:Mg4wyazfBJVSzfwv5q0+dZ5Y5y1nHV9VEsR8TVc5MpOYJV5hnCuRyrHQY1Zb4V2i2ezZapO7JGKXkk8m+hymbt1ZbW5WM5q3HNkE5+ytYqckOgQ4cFMMeHsRzzkSRrCzzbs0hqPvxzZHjFqLCVxAA4vBvt0/48NtHIEdwpdkD1U=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2018 11:18:02.1996 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 334aca44-78b7-4a15-f9db-08d5d831d2b7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2501
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-22_03:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 06:20:52PM -0700, Martin KaFai Lau wrote:
> On Thu, Jun 21, 2018 at 05:25:23PM -0700, Jakub Kicinski wrote:
> > On Thu, 21 Jun 2018 16:58:15 -0700, Martin KaFai Lau wrote:
> > > On Thu, Jun 21, 2018 at 04:07:19PM -0700, Jakub Kicinski wrote:
> > > > On Thu, 21 Jun 2018 15:51:17 -0700, Martin KaFai Lau wrote:  
> > > > > On Thu, Jun 21, 2018 at 02:59:35PM -0700, Jakub Kicinski wrote:  
> > > > > > On Wed, 20 Jun 2018 13:30:53 -0700, Okash Khawaja wrote:    
> > > > > > > $ sudo bpftool map dump -p id 14
> > > > > > > [{
> > > > > > >         "key": 0
> > > > > > >     },{
> > > > > > >         "value": {
> > > > > > >             "m": 1,
> > > > > > >             "n": 2,
> > > > > > >             "o": "c",
> > > > > > >             "p": [15,16,17,18,15,16,17,18
> > > > > > >             ],
> > > > > > >             "q": [[25,26,27,28,25,26,27,28
> > > > > > >                 ],[35,36,37,38,35,36,37,38
> > > > > > >                 ],[45,46,47,48,45,46,47,48
> > > > > > >                 ],[55,56,57,58,55,56,57,58
> > > > > > >                 ]
> > > > > > >             ],
> > > > > > >             "r": 1,
> > > > > > >             "s": 0x7ffff6f70568,
> > > > > > >             "t": {
> > > > > > >                 "x": 5,
> > > > > > >                 "y": 10
> > > > > > >             },
> > > > > > >             "u": 100,
> > > > > > >             "v": 20,
> > > > > > >             "w1": 0x7,
> > > > > > >             "w2": 0x3
> > > > > > >         }
> > > > > > >     }
> > > > > > > ]    
> > > > > > 
> > > > > > I don't think this format is okay, JSON output is an API you shouldn't
> > > > > > break.  You can change the non-JSON output whatever way you like, but
> > > > > > JSON must remain backwards compatible.
> > > > > > 
> > > > > > The dump today has object per entry, e.g.:
> > > > > > 
> > > > > > {
> > > > > >         "key":["0x00","0x00","0x00","0x00",
> > > > > >         ],
> > > > > >         "value": ["0x02","0x00","0x00","0x00","0x00","0x00","0x00","0x00"
> > > > > >         ]
> > > > > > }
> > > > > > 
> > > > > > This format must remain, you may only augment it with new fields.  E.g.:
> > > > > > 
> > > > > > {
> > > > > >         "key":["0x00","0x00","0x00","0x00",
> > > > > >         ],
> > > > > > 	"key_struct":{
> > > > > > 		"index":0
> > > > > > 	},
> Got a few questions.
> 
> When we support hashtab later, the key could be int
> but reusing the name as "index" is weird.
> The key could also be a struct (e.g. a struct to describe ip:port).
> Can you suggest how the "key_struct" will look like?
> 
> > > > > >         "value": ["0x02","0x00","0x00","0x00","0x00","0x00","0x00","0x00"
> > > > > >         ],
> > > > > > 	"value_struct":{
> > > > > > 		"src_ip":2,
> If for the same map the user changes the "src_ip" to an array of int[4]
> later (e.g. to support ipv6), it will become "src_ip": [1, 2, 3, 4].
> Is it breaking backward compat?
> i.e.
> struct five_tuples {
> -	int src_ip;
> +	int src_ip[4];
> /* ... */
> };
> 
> > > > > > 		"dst_ip:0
> > > > > > 	}
> > > > > > }    
> > > > > I am not sure how useful to have both "key|value" and "(key|value)_struct"
> > > > > while most people would prefer "key_struct"/"value_struct" if it is
> > > > > available.  
> > > > 
> > > > Agreed, it's not that useful, especially with the string-hex debacle :(
> > > > It's just about the backwards compat.
> > > >   
> > > > > How about introducing a new option, like "-b", to print the
> > > > > map with BTF (if available) such that it won't break the existing
> > > > > one (-j or -p) while the "-b" output can keep using the "key"
> > > > > and "value".
> > > > > 
> > > > > The existing json can be kept as is.  
> > > > 
> > > > That was my knee jerk reaction too, but on reflection it doesn't sound
> > > > that great.  We expect people with new-enough bpftool to use btf, so it
> > > > should be available in the default output, without hiding it behind a
> > > > switch.  We could add a switch to hide the old output, but that doesn't
> > > > give us back the names...  What about Key and Value or k and v?  Or
> > > > key_fields and value_fields?  
> > > I thought the current default output is "plain" ;)
> > > Having said that, yes, the btf is currently printed in json.
> > > 
> > > Ideally, the default json output should do what most people want:
> > > print btf and btf only (if it is available).
> > > but I don't see a way out without new option if we need to
> > > be backward compat :(
> > > 
> > > Agree that showing the btf in the existing json output will be useful (e.g.
> > > to hint people that BTF is available).  If btf is showing in old json,
> > > also agree that the names should be the same with the new json.
> > > key_fields and value_fields may hint it has >1 fields though.
> > > May be "formatted_key" and "formatted_value"?
> > 
> > SGTM!  Or even maybe as a "formatted" object?:
> > 
> > {
> >          "key":["0x00","0x00","0x00","0x00",
> >          ],
> >          "value": ["0x02","0x00","0x00","0x00","0x00","0x00","0x00","0x00"
> >          ],
> > 	"formatted":{
> > 	 	"key":{
> >  			"index":0
> > 	 	},
> > 	 	"value":{
> >  			"src_ip":2,
> >  			"dst_ip:0
> > 	 	}
> > 	}
> hmm... that is an extra indentation (keep in mind that the "value" could
> already have a few nested structs which itself consumes a few indentations)
> but I guess adding another one may be ok-ish.
> 
> > }  
> > 
> > > > > > The name XYZ_struct may not be the best, perhaps you can come up with a
> > > > > > better one?  
> > > > > > 
> > > > > > Does that make sense?  Am I missing what you're doing here?
> > > > > > 
> > > > > > One process note - please make sure you run checkpatch.pl --strict on
> > > > > > bpftool patches before posting.
> > > > > > 
> > > > > > Thanks for working on this!    
> > 

Hi,

While I agree on the point of backward compatibility, I think printing
two overlapping pieces of information side-by-side will make the
interface less clear. Having separate outputs for the two will keep the
interface clear and readable.

Is there a major downside to adding a new flag for BTF output?

Thanks,
Okash
