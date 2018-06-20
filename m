Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C369C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D75E920874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nio365.onmicrosoft.com header.i=@nio365.onmicrosoft.com header.b="drEqXJ2w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D75E920874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ni.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753893AbeFTOZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 10:25:05 -0400
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:48790 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752838AbeFTOZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 10:25:02 -0400
Received: from pps.filterd (m0098780.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5KELFpJ012785;
        Wed, 20 Jun 2018 09:24:49 -0500
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp0087.outbound.protection.outlook.com [207.46.163.87])
        by mx0a-00010702.pphosted.com with ESMTP id 2jqkjnrw38-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 20 Jun 2018 09:24:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector1-ni-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULNPZx2Z9p5hS4oHNIQiWxWICAC+O8LZ085iCiucpqA=;
 b=drEqXJ2wDT1Duwk+pFcE6IJyS7+RgDnJyGRF4hObq+uvFUp72ADAC/kf7WPvVeprrEP62Lt9rEocShUUZVC2yAIwuKLjAsnx1raNmY+2x4w9Ij2kcFCLZz+WkyoHHm7GEjVedFyft4AVZQeqRt5JvPw/xR8XQLGzZXItjXgkjI0=
Received: from harisdt.amer.corp.natinst.com (130.164.62.119) by
 DM6PR04MB4634.namprd04.prod.outlook.com (2603:10b6:5:27::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.16; Wed, 20 Jun 2018 14:24:46 +0000
Subject: Re: [PATCH v4 1/2] timers: Don't wake ktimersoftd on every tick
To:     Daniel Bristot de Oliveira <daniel@bristot.me>
Cc:     Mike Galbraith <efault@gmx.de>, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <alpine.DEB.2.20.1707182206110.2425@nanos>
 <20180306233944.11271-1-haris.okanovic@ni.com>
 <1523332961.4827.1.camel@gmx.de>
 <c2664fbe-52e7-1044-e9f9-de4875047ee8@ni.com>
 <0c3d5147-a2c2-4773-c4f1-af5745a27384@bristot.me>
From:   Haris Okanovic <haris.okanovic@ni.com>
Message-ID: <b4691b85-2346-36ac-3270-ff722032ea1a@ni.com>
Date:   Wed, 20 Jun 2018 09:24:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <0c3d5147-a2c2-4773-c4f1-af5745a27384@bristot.me>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [130.164.62.119]
X-ClientProxiedBy: SN4PR0201CA0037.namprd02.prod.outlook.com
 (2603:10b6:803:2e::23) To DM6PR04MB4634.namprd04.prod.outlook.com
 (2603:10b6:5:27::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19441cb3-c9f4-4c8e-fe15-08d5d6b992e2
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:DM6PR04MB4634;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR04MB4634;3:dIiAk1STmEjRTR6qhL4dq+HQ8RBdrOu9GdXxGIzgvUlmEQLYIZBOLSmNnrGSitrilR7mhQKhJt6wtGS56lX1H2ougyIygjuZndkm1PO9rjyOUzZjllpwTKd90Lj45ahdDkFxzne4X9v+kSUBXODImKyghhGU+IQZqE7INjCOA9qfwB3uiiom/nf0ZsV1ECnrLNw8ZwGcOOGFRJuuX4bLxwekwpiAAlgIEpdibbpPfUWSErhaztKJ5hSFLo2ntcmR;25:RhpFMuW7FAu3mOUNrqxchDWPj1dhFKrktrC2qCqDbgxQQ/Znujqp6SPdDS2utVbQCJMycyOSyfahWKw66JuB9OYnKhCxuZijpRAlMRPsy8Z+6NlDuCl22mYOyKtFHmXNGiFQFUUtDxLJ+3SNbfXT2Pp5V0Q2KQRbZR20U5BYKs7Eq5vHsQAT7sjkGPDjIljnMI74bMo8LflMuXrA5nike7Sr1qs+lJiSt83/WfHPGoz9tpiaLJzaqptXbtSDoKrachj/oyxEszy1s9cSRRNGnKE2zHpDknIMGN5vAJwOYyNfHJZgwMuzICaxyebBGKCSyMdWNoiG0DQPvSaAhwRISQ==;31:cri7lYq2y5QkbQXEkkH/0a/f0Lh4sQe5XciV2BU+79FZkw70ccejoBUN3Q27bXmZkU4MTItFp2T1D3mR/bySkJuRdwSEZWf/HMYhOT+3124He8tjaY5jlx8bEfhwTtVFrZROWn1bDOybEV4bFx7HHDG8AuC/0EuCD2eEVfeQdOtf4zeUMqcpd6C9r3lKmqIFQBhg/Mm+hvz8Mt4ekq1zGG0vGe2iw3SfUvEDlNuQqb0=
X-MS-TrafficTypeDiagnostic: DM6PR04MB4634:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR04MB4634;20:CU2HlyMEb6gK9VWd7q81SlAArbk7OSbDHkraH/5qjOG/qZYkAiaVNlWS71NuFyPFoM2B81Vm8HyPp6RYiGF6FVOlKFB+yk+hSiqLSlz1c+RI8XLOqs5GzkOteawmM8WCm4PyRvbKoJ9pBmEMdh61i0h+BLjIgR294+xI9y8RBwiSr5sV587S/bCHUVDfut1Ap5TUxUildhwSON5zVZjxjyS7DK803HgnlvjVyNhjEegnTgDUwfN7eow1MNW5Sgmwa0gs57+jiKNOme6B1YxoRCmBxvSU8UeFU7Y65NJdvjAW01swzBZEH/xaP78dSr1Jl8+LpD3WVBJm7qFKM7ATiZXblS3IpijtgVXNacPsX1vaem1xgXhSl20FSNaEZEhDXu3Vuchzdipa0e2DfGPq4hi1yBWV3L1fzetHxxllon9sFpuXv4BxUEJpZE8IqxeOGNYgphJBRpj41XUGoSEsddq12H6WpxPT1Rw1cPVBm9GsBTCXON1tIv+uLiBrb0yARuWobYq8N2sPcqIPlJlzH0ZVX1fG8olWzG/xU5wFjVXnJLknf1qPomqutRBh0kRcMWlIkkYGuGKS2QeESPjCmXggFzTvgzs6z/MJqH3MtDE=
X-Microsoft-Antispam-PRVS: <DM6PR04MB4634820933885444CADCA399E5770@DM6PR04MB4634.namprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(10436049006162)(9452136761055);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:DM6PR04MB4634;BCL:0;PCL:0;RULEID:;SRVR:DM6PR04MB4634;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR04MB4634;4:Q/rEAYnZBSe6mODgSvo62AYfN2kXP6UQ1m4BpWIP9N0VkCSEIQ3ic/uNZKNfaEUQ4K3f929Ha8/6ltqlL6g5Bkl+WgxvNGzWzF14JVs4gPHPlD3/KPY8EFzWXedSZazi0wdWh//T2jKgoOmCgPLsCfvDAaL3zxeZHHaQySvIhilb8JpeyPcALPtcVJ++91GN4zIfj+fQH5DalxHsDfWyJNbKxdWGhoO2akukjC8CfR9uVmze4dNZ6UXIc2swdrnZ3sE/9cNRquX/b2b0zEnt9ombzYXkGMpT0/1oAorrqWgYvgUHcdfa9Z9++KAW+mBBbopZPd/4EqxbPfspU6e5kw==
X-Forefront-PRVS: 070912876F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(366004)(39380400002)(39860400002)(199004)(189003)(2870700001)(106356001)(2906002)(16526019)(97736004)(76176011)(52116002)(53546011)(6506007)(386003)(59450400001)(6916009)(8666007)(6666003)(26005)(229853002)(6486002)(5660300001)(50466002)(67846002)(105586002)(36756003)(966005)(6116002)(65826007)(3846002)(6306002)(64126003)(66066001)(53936002)(31686004)(446003)(81166006)(476003)(956004)(2616005)(25786009)(65956001)(47776003)(6512007)(81156014)(6246003)(8676002)(8936002)(305945005)(486006)(7736002)(93886005)(23756003)(86362001)(58126008)(575784001)(4326008)(68736007)(316002)(478600001)(65806001)(31696002)(44832011)(11346002)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR04MB4634;H:harisdt.amer.corp.natinst.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: ni.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?iso-8859-15?Q?1;DM6PR04MB4634;23:C7dMjvyQ5WlwMUwiLTS1pGx22Ipod1vQRngkJ7?=
 =?iso-8859-15?Q?tPpEVJXHY+9lVXHdS9FKAELgH+OtJN4ePJBbuXMvHQNprXnPJwn4efES6?=
 =?iso-8859-15?Q?J3ACP7rZP6CISVefL5OEuxlXvgEw+k3hnPd2/VEPaKW8TmCW4z/BOFpbz?=
 =?iso-8859-15?Q?jjWdgbP4pHbUoewLlWzKEmguWaWE64qTyIeLXrK+UYMlab09af+AKAkSd?=
 =?iso-8859-15?Q?1B3FZe0jep1Ls3I3N0pJUYiiOc35kOYjMq4kr6wgE+EdEJOvVKmdcIixt?=
 =?iso-8859-15?Q?FDQ8dYkTbPGySElKdnXAmnTZJ8KYq8ryo9WhY6ZkWGeNiqiiu0jVv/DGZ?=
 =?iso-8859-15?Q?5LrsiivBB+D9cYptX53A1FIXJYtzBXnpvWimJw3x0lWqFGrGr4vtIseWd?=
 =?iso-8859-15?Q?IF8rqe/p6hZ8y++YrcbIsTyazf4Zb+SbiCZj9xUz+9q9SuwAzRRLrynFN?=
 =?iso-8859-15?Q?/WBFeuyqtd0XXQavqvxvx/HOH9Iu/WgCGGSBTR5Qta6NKkZWs3GaJIDJT?=
 =?iso-8859-15?Q?YXeZ3ELt6i3x0EqYknSF821+WKonOCOlzIs4ZamaMuHvHhzN5dDzU1Zlc?=
 =?iso-8859-15?Q?osZyGLm07WZT1u0LtZLT5EHAZp7TlPxyQshhkg6Xe449ifLJe3UI8Pdo5?=
 =?iso-8859-15?Q?lhuRO4+bSBUBjA+VUMk6rjPjnchREbvFGuG6omt3zuMimsuljI34JEdm7?=
 =?iso-8859-15?Q?ZH3Xqn0HWVgTjmoIpKv4rFCpH/49BPh8c7eU3tgqC2n3wWwu59a5NBTvN?=
 =?iso-8859-15?Q?PcqzK38IuaTdFYvjcMWGkqO6aNJQGHzG4gJ58mzrCnk3ynVvtfJ2M4doh?=
 =?iso-8859-15?Q?IdlYqc9O6oPrOoR+8tTMJMqp2LV2/PQ2s1pWn7d9BcjKuc4jYGa1fPNtf?=
 =?iso-8859-15?Q?ZVZiLv82yjztJeCSZfJn6jEm3BqPfffcfQXCXte0OqzTTkLPnE7tT+wyM?=
 =?iso-8859-15?Q?piwH6yOnnscWf4bjxprpwvKR0RbPUdPdm8wYsSMQ+DoGQz5J0uu32FbHy?=
 =?iso-8859-15?Q?2ArwnVn8m6qRVH72hEYnw1qSIURMSFvhnnYG99JTs//nB1fipFFPI8a7R?=
 =?iso-8859-15?Q?Ap1mAeCV+3zwg8iawvXzA3s9vTil72a90E0tLSoxmbVO7VC/YNFkJbpYH?=
 =?iso-8859-15?Q?EGfQBryYgDVznZ3t3GOPAi/QvLGnFqeqi+yWUiA4yFRjxLP0xONXALE5V?=
 =?iso-8859-15?Q?nQNpH178eJqiTvVUTsiKZWaCt+fLgVzfdlQu0e49XHOeIbBe2wombZNl6?=
 =?iso-8859-15?Q?EH43e2buJ3spXPeM3u+1naJEWo0OaypTWfvUum9wTAlynPsXG8skuaeM4?=
 =?iso-8859-15?Q?6uFJ9lmdE+Amj1S+4fr1yRBzz+CxGYYxImCMTPK3yg/CRwlB/TztalVrB?=
 =?iso-8859-15?Q?kx5hPndXvK+TM/iZ0Xq5RJ3VF75dUD/UDx7VN/FopI7HlWy+eE1zHGpik?=
 =?iso-8859-15?Q?uc4rWqbuc7Z2xyfcTnn40PxWIQmCcFtO7BTJUXSiMsatC09MX2IjDI1xI?=
 =?iso-8859-15?Q?v15Cv9bESMCUkGaGO3R8/NYozdgS42vvQAzwCqlBcAelXELjw+NejBqlQ?=
 =?iso-8859-15?Q?LDf36OE28iVYHWGwX4IVVlFA6H3a4enxZVlCY9ekfrZ09ncI2Sp9xoy4E?=
 =?iso-8859-15?Q?HqfsgkVTRn0eRv8Y?=
X-Microsoft-Antispam-Message-Info: MFLndNW26xmUtn1YNCNEh/DTEizdBSWQfuAAUmbrH1xtSJn0HQf2D/PGhwjlGvTn0HJ4aq1p3kU87G69Cg2B+caxNf24QFoxDh1pUuHSRVV4T/OG8kZEB+ms08ZoZwIl5laKGl0PBRrGPvEkN9aLAS7GFlfBNDRfi4ll3iCEdnC7Bui7RQjrRctQ1axb0kh4crMWld1mSmyLOOKwkoezeJAq/kjIVeKzYlJFv1weWXSYTs6eKApr3oeIW2OYJCodvLcPF45cIstlfzZ6aRV6CJQ2q+9nrb0SmLcUC9cM4dRWqbR3ZxoGFGa9nYCVyR2TUR29uFk/ms3eXdHeb22g/A==
X-Microsoft-Exchange-Diagnostics: 1;DM6PR04MB4634;6:bqJftgjXQ7truHjRagdu2a006FmtIXQ7rqA9RKfQhzYPFQ9pKrV232N0V5VsiwNLyNfU4Td6kUzrVMbDHonTFt9cNljfWH3yBCwUFFG17BmZUaE6Bx+LnoJ0yAADSD6APMSITSCOIgHdinU6XWNJ91+u625Wr7ARnqmTVWV7/UCbkm4BXm5M0+k6FZezDDsJHykt746HafrYlE6wC5yWz6eXHZfLFJ4/+PT1d5f4VGVJYcQGBM6eZyd9aqBEiFAsYf5ihO8hc0IHQh+8Q8QWo9GRO4MSuPcwumCMq9J14WwND17NvefdEpo0HExEPcbhABfFjSrvJz9VkWJK4KvqsFHFA1gWoLZ+bOaMwC/2JiroY0B9WCF9FqQcpz+83+zt+pNg8dgJcfvv6IA4Xvwk0+JQ8Lv+1FmcMxzpfXMNr0wjX8DZH84GTqEYjBKYoPMGtPlSsQ8/SuSZfLTFoqAytw==;5:XcLC1IvwwAKs6MrPM5WYnRaBblWZFbPO/DtXjfwM+z9pN4InUXaWOL0Q4BVmJqprHLWKFInDqFlhJDSiEpnw/u/YpFj7kuovzgmt7xQ4vP+Gzom5UvKtp4t6nlsMQE2Uawi/fCvUTYU/SqSNG5j+/uevygVeBfAcQVDaSsC0bqk=;24:oTfT8YqfEgPG5z8dO1qTv6SiwiDyMp1AGdhoubXEgcffloTC1EIQgrwMlpW+TCLfL7q7krDrek1aDZTiSu00jwGALoQ08epY9FDE0we5RAE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR04MB4634;7:vTmk2QE+NEXU7HqrPIv2303kp9IZWyerTfh4f99rzNwBsmvoXYf60MOwPQtBlWXY/4zvB+nSDApLXzVT8qRFfjOO3n+uwkh0riWporA9P+GJmfD14V8kIcTkIOm95z4svAx5injSMqqOAUKSRNh1BzjDmCbeVQlUpzIBZwRxDzPUPUF5Yd9zKO9U2EphRNdPXAriJ2/VCKfNvk1OhEnfsctCtNgt6OJS+gE57Hm7PAazIXjsG17MMoR9qtwGudpJ
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2018 14:24:46.1604 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19441cb3-c9f4-4c8e-fe15-08d5d6b992e2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4634
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-20_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_policy_notspam policy=inbound_policy score=30
 priorityscore=1501 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806200162
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

I didn't have time to look at it yet, aside from confirming Mike's issue 
reproduces on my machine. It's still on my backlog to investigate.

-- Haris


On 06/19/2018 07:43 AM, Daniel Bristot de Oliveira wrote:
> 
> 
> On 04/12/2018 05:00 PM, Haris Okanovic wrote:
>> Hi Mike,
>>
>> I haven't tested the patch with wireshark until now. My system also
>> hangs shortly after it starts. I'm pretty sure I hit workqueues in my
>> earlier tests via the block driver, but it's clearly not whatever
>> wireshark is using. I'll look at it and try to post a fix. CCing the
>> list to avoid this patch until then.
> 
> Hi Haris,
> 
> Do we have any update regarding a newer version of this patch?
> 
> -- Daniel
> 
>> Thanks,
>> Haris
>>
>>
>> On 04/09/2018 11:02 PM, Mike Galbraith wrote:
>>> Hi,
>>>
>>> Are these patches dead, or are you planning another submission?  I ask
>>> because I discovered that with them applied, firing up wireshark hangs
>>> the box 100% repeatably, with wireshark never fully initializing.
>>>
>>> Applying them to an otherwise virgin 4.14.20-rt17 to be sure...
>>>
>>> crash> bt 6016PID: 6016   TASK: ffff95dd68572180  CPU: 2   COMMAND:
>>> "dumpcap"
>>>    #0 [ffffb490094f3bc0] __schedule at ffffffffa56d55b9
>>>    #1 [ffffb490094f3c40] schedule at ffffffffa56d5a03
>>>    #2 [ffffb490094f3c58] schedule_timeout at ffffffffa56d8467
>>>    #3 [ffffb490094f3cd8] wait_for_completion at ffffffffa56d6e34
>>>    #4 [ffffb490094f3d18] __wait_rcu_gp at ffffffffa50e59cd
>>>    #5 [ffffb490094f3d58] synchronize_rcu at ffffffffa50ec14e
>>>    #6 [ffffb490094f3d98] packet_set_ring at ffffffffc0c74da0 [af_packet]
>>>    #7 [ffffb490094f3e50] packet_setsockopt at ffffffffc0c75d23 [af_packet]
>>>    #8 [ffffb490094f3ef8] sys_setsockopt at ffffffffa558a5e2
>>>    #9 [ffffb490094f3f30] do_syscall_64 at ffffffffa5001b05
>>> #10 [ffffb490094f3f50] entry_SYSCALL_64_after_hwframe at ffffffffa5800065
>>>       RIP: 00007f3107a1cfaa  RSP: 00007ffc9745c2e8  RFLAGS: 00000246
>>>       RAX: ffffffffffffffda  RBX: 0000000000000001  RCX: 00007f3107a1cfaa
>>>       RDX: 0000000000000005  RSI: 0000000000000107  RDI: 0000000000000003
>>>       RBP: 000055ae1d8eb470   R8: 000000000000001c   R9: 0000000000000002
>>>       R10: 00007ffc9745c350  R11: 0000000000000246  R12: 00007ffc9745c350
>>>       R13: 0000000000000000  R14: 000055ae1d8eb200  R15: 000055ae1d8eb2d0
>>>       ORIG_RAX: 0000000000000036  CS: 0033  SS: 002b
>>> crash> dmesg
>>> ...
>>> [  483.808197] BUG: workqueue lockup - pool cpus=2 node=0 flags=0x0
>>> nice=0 stuck for 52s!
>>> [  483.808204] Showing busy workqueues and worker pools:
>>> [  483.808206] workqueue events: flags=0x0
>>> [  483.808208]   pwq 4: cpus=2 node=0 flags=0x0 nice=0 active=1/256
>>> [  483.808211]     pending: check_corruption
>>> [  492.695124] sysrq: SysRq : Trigger a crash
>>>
>> -- 
>> To unsubscribe from this list: send the line "unsubscribe
>> linux-rt-users" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  https://urldefense.proofpoint.com/v2/url?u=http-3A__vger.kernel.org_majordomo-2Dinfo.html&d=DwIDbA&c=I_0YwoKy7z5LMTVdyO6YCiE2uzI1jjZZuIPelcSjixA&r=8Bziuw3IaCGjyrSAphuGwHmVdHcVwza-srUYwL9U_Ms&m=FlO5SC4s2pRHcS-IG9Y02aEEXYqou1_HtmZakuldqlY&s=JJ8LrCcEF4YKcLbUey5JTreyXV0p1sJ1wqic9LQ1PCE&e=
