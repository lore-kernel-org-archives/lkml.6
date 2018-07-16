Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C294ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 22:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BC4520673
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 22:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="dFwobmKw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="GxQ7BMHy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BC4520673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729876AbeGPX1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 19:27:22 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:57972 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728947AbeGPX1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 19:27:22 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6GMmSsQ002995;
        Mon, 16 Jul 2018 15:57:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=jLLQVtSUFpEuzu2eJixM5N0ZqJGCkynMnELlj564u88=;
 b=dFwobmKw+z2rdmGnVCbtu9pY5lbhuI/Yf9OgogBQW7l9nGZExX5F0lHu5Ruf26PaRO6w
 SwDaFhKLPEZO6EMVuy4Fw90zG7XQPWU1/fKm7yxMP/C7RXaWHUbiiI//N6sevka/ykd0
 8jDZ2+X1zh0RQKGv6ryDI5XCQaaQGBiu6JE= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2k93ha85kd-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 16 Jul 2018 15:57:25 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.23) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Mon, 16 Jul 2018 18:57:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jLLQVtSUFpEuzu2eJixM5N0ZqJGCkynMnELlj564u88=;
 b=GxQ7BMHyIdUm0QUva752/YJ3d3FZjM6cpa5qsTNoVVE7Oxu2WYpam4CKAC9TkiYzFHGZ5tOr62Bj0EBIItVZygMo/PIjcsgjf7fcVwJgQ0/Vlp4DB8r4HYTqxKjvsIrsX1Ljnox/glYGajCHZSZArEi1dagSOIxMsGKwD/og56A=
Received: from castle.DHCP.thefacebook.com (2620:10d:c090:200::7:d20) by
 CY1PR15MB0171.namprd15.prod.outlook.com (2a01:111:e400:58bb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.18; Mon, 16 Jul
 2018 22:57:20 +0000
Date:   Mon, 16 Jul 2018 15:57:16 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH v2 bpf 3/5] bpf: bpf_prog_array_free() should take a
 generic non-rcu pointer
Message-ID: <20180716225715.GB3898@castle.DHCP.thefacebook.com>
References: <20180713194114.2711-1-guro@fb.com>
 <20180713194114.2711-3-guro@fb.com>
 <41b5f919-3155-5bd4-2774-84efd58650e2@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <41b5f919-3155-5bd4-2774-84efd58650e2@iogearbox.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [2620:10d:c090:200::7:d20]
X-ClientProxiedBy: MWHPR1201CA0006.namprd12.prod.outlook.com
 (2603:10b6:301:4a::16) To CY1PR15MB0171.namprd15.prod.outlook.com
 (2a01:111:e400:58bb::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66adda5d-e105-488e-1ab8-08d5eb6f7ce0
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:CY1PR15MB0171;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;3:LqevXkMrFYUw0Ij0WkcB2NxFp4h4Zx75eEGADJNUqZJxmAlcK6tvnQYwwLXTo6vpkt4HaSf2MDWUkKf4jskEGDzCb7MNvjgw0DfoQHO9n7skdgmSqE/wViA+FDarT38e5YlpK+vZR3IERVMzd86HczaePwhowNkGKS6w1COiPSDpWYPJ1l5cJ89ZcWDyoJkAKkoy0jYhg/z7GATiE712iaGuxjxCIZtDJc4HIved/Ycz2CB+5K8gfAgyjJznpR79;25:+aOv9UmXRHPm1z+NcONZqBa3wo3g10tnibezZSLKVOZAgEqZrnC+phxagFWWOmN/+vQOO+5oQ+3zIiZKHbrr7iTr2yM8aJz4atawgkADHj36PnBAAgBljQIZ56IJqkuBriGuKpaMvr88pBLvxGdRixSrBoGXlfVyIWHSeCfoVdrFhGqUZMeVeIv35UqGlNFLnFfqd4BwL6A8dY5vyRu/sIX5zOzZdoin9WP6pqVdWQE/qKvscHh2wIRrs/Uq5yQI1LISQbIcwXp36q03HOQuaw1O2Gn2LYLQ34kbVoleRlFY+sfPCNFzE22iHlrHZSRL34t3ErQwnDwNMp1szHhh/gNZ2OW2zU4UPwRTrX/B8Mw=;31:0j10uMhiqSrFGM4Zr1z4npdQeZ0ZwUooL33lLixot/J+00qMnP862z9tPhoBwJ7JrkdkLSwG5qm9JtHOllj1y13SmD03JSTVLqabqOyDSD295LtlQhHxyqelopReyxk6JkaFOWHr9FHkBi2+4DHDj269MiPecbK8nOqw1FvlXNKETsGa7k20BPU90uVJ+kXGmKR3feONpyGWsYQjb06Xvem20O4Qwjg1T/kBhqabeOo=
X-MS-TrafficTypeDiagnostic: CY1PR15MB0171:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;20:WLhi6SspS6GD1YsOtRJNvtfjWEO7vSFkt8GX+keOld7W5TFIY/hLDODc7Ppgtih/IYaf8ko7nKDN4dHvqEr+vCXzCGXUlLff+LZMootzU9BFe3/HdM/a1oAz2TroH1/uNl35rU/hodMGLlX8h3vDv1Ej+szcPq9v0r0ZoIpMSZFxxgw8UbbWu50mQmzLbQzvYn+D7yQDH+kmygeDnQEuo7YbAWvgvmL3S4/8EWgt6I8b5bfjFs/OaykOYDJyPG8mSvmcXnij4bCbjcfLnfOw8JFsL1gDX1Ek411Zrei7h9sjse6NLZNrDqxeWb5pHPlV6zlRL9NxwQbu+v6DTlAKsTyDgKwvEHAME4RwjP12J/NOJVBsFF/BKn2T284sYVfD827qkcVNUup/A/L10DGKD5wuflRCjYIVtS9kIj8qMXF6Vq5F9QgZtVWLUqE/BWt8bIkj6xNVJbJegmGhiQOfbvxnN8137dlx1iDcn0nsUy4m7/vxEKu2dUP74s7R13bs;4:G/NSaBb/3nw3kQBcT22y3c1ZjIvT2/SZAyR6XrBSFhMXGHC8LCv5dYMZw4ynjqNaP5DWTxgaX1jPTtiWlnaQmeDufDTuMGf2HUGD2NItkApmHaNCaKDRivjzQj0NWT8Cnzbsj6uyFZcWo5kp7rH9ei9KCN5XIddN744NeJh42hA84x/5s7uOR8L4oZoXi9AS/N988OfAt2zCg2qMmfgrU0DLU9LEO81yew2xMicB9nqn6uYhu4pE1bsif3mWXgvjrZHdJUDPL9xJOU+7VHGhUuidowzClv4jEF9LWmFyYm6ZnBt0GKg9cUkH29yd6qg79/Aa8AxLo0sU9jx047z5YEAPv+oQwJfwnmCw/LItkOY=
X-Microsoft-Antispam-PRVS: <CY1PR15MB0171272F58C748B2174EE63DBE5D0@CY1PR15MB0171.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484)(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(11241501184)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:CY1PR15MB0171;BCL:0;PCL:0;RULEID:;SRVR:CY1PR15MB0171;
X-Forefront-PRVS: 073515755F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39860400002)(396003)(366004)(136003)(189003)(199004)(6916009)(50466002)(53546011)(6506007)(386003)(8676002)(6666003)(46003)(86362001)(575784001)(16526019)(23726003)(1076002)(6116002)(229853002)(186003)(81156014)(5660300001)(47776003)(8936002)(305945005)(7736002)(105586002)(33656002)(52116002)(7696005)(478600001)(52396003)(81166006)(76176011)(106356001)(68736007)(58126008)(316002)(16586007)(25786009)(476003)(4326008)(486006)(11346002)(446003)(2906002)(9686003)(55016002)(5024004)(6246003)(14444005)(97736004)(53936002)(18370500001)(41533002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR15MB0171;H:castle.DHCP.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR15MB0171;23:A1/ZtMFYvu3jur+8k/0jIVHiDr67oom7s0elru31f?=
 =?us-ascii?Q?l2faB6wiIpFPXq1Js+xvcaSYxniDSo97/DNnxJHFqq3sG2KvarZeZGbtmmxj?=
 =?us-ascii?Q?m27aL/nCuCqA3jWryu+oGv19c4tpQmnlQtllj68rKNvoUckRe/Mgs5EiIXgA?=
 =?us-ascii?Q?cZKx/PobwtMAot7m/l+N3IfNBHDvTjtNqdpHFyRzbSceeXGfjsGKic7XOd1B?=
 =?us-ascii?Q?v6nXbU50z6ewSX7X04Nzt+aOz3S1T2YPa+1NhNwQQxU8HavT5F4WZkz96luY?=
 =?us-ascii?Q?lUOvOabTN1jWdcLnezimyItmz5Kn+ZVvJgTtUrzpI90SzPBeEbbk6tz7qIXM?=
 =?us-ascii?Q?QO1VLRKxu3eePt2LQS8GejPqkC8zHaIgNTuAp7hnc1sCiiPzCuy91uztNMdP?=
 =?us-ascii?Q?mqkvYGq1k+hlcvXy7+AQDC8pUTsbN5GTLQZfJbEuG66qCHcKyl7RlHCNhHew?=
 =?us-ascii?Q?jGGv8ACMkWjGmw65cnQfpmYhUJhEBc2WOwMU0d3o7E2dHc2Jv+6upXCWsy8Q?=
 =?us-ascii?Q?f/9ZIt+hlCbRRVM640LDWrXz2CQBlv/8IGIOMqeoKosVOg83JmN2dEqccPQP?=
 =?us-ascii?Q?60ix4gHEyd4K/2J7xd9A0tNT/polEMoMKM/ZgmGFqZ6WcGn2cqexe1zgvHbd?=
 =?us-ascii?Q?icX2V9RE5k1N7AzEhSkisHtdmaMLzWsUgWj/5Vy+RiQuEkNtVb1PK05RDoi1?=
 =?us-ascii?Q?s67HCZwGT00onuQ3j2g49gfGVDQSKZzt8wPoHahd3CAgB9stO4vkmG9Uc8vE?=
 =?us-ascii?Q?4drDhVb9J8aSxfK9Vj9EkFbtKTcAM5NassOY0NGlqS2sS9QQLgvZ6GnsORgy?=
 =?us-ascii?Q?WZrcT/OsQslDy0B4SjGquj63lOolsonSplxcxXD9MRG3unL6UfegERo/NR5V?=
 =?us-ascii?Q?Ye5VFPX+eB0HmYEu97uJu8ahFGHCpFPOcnS3VO2EyVFMuNcNrZ/Kg3RBPBdH?=
 =?us-ascii?Q?1Mwtv90FXHOGdfrEofdTAYupA4woCCRtLm/E0tVFRqn7R5mFA6WqNT+q1NP4?=
 =?us-ascii?Q?Pj+HGgQ7C1FVa/u2yxI23m5DdoFib5FJXtUH1AQtv2hEtHIIw3+KMyVyAFEJ?=
 =?us-ascii?Q?A6c5RHMbyD1BUi4jvgtfySgsllZm0nDy7S+BAJXFcWmPaS9FPhLeLctyb/h+?=
 =?us-ascii?Q?/1CK9QotF5w6Ish65+5bjc1Ja5l3F5oLTrVbzCetDNo6CM7JGKOSDONeaiF9?=
 =?us-ascii?Q?FwlniqkM1zkwnVKMUnXb8Cy8pzNyBiFNXbehU4t2VX+8UmTugWnZdmmdN9vB?=
 =?us-ascii?Q?ULoW63M3pG3Y91iz503jB+sBAsjRfhMfKo22pJxWtH1QcAl78rBqwCQ48YtX?=
 =?us-ascii?Q?56TeM+WbyToVlE56ZJLeP0qzkU1jI6RDVCqJBzkks+k?=
X-Microsoft-Antispam-Message-Info: sXIXQweiA/lvREqszjl23JJneweU5xc7xICOYBlbp3MBCw8x6kNgbqrtk3QpnRku9llf6iaY2uo8lkci41DizgKz2D00JWgLnVBIvCg3ZFANM8DKc64N8b0wK9/J15pFZoVonqb3pcxguUUBhZdyFIg9AZFcm5JFvQQ4bWvBLjLT1m5a+5X5sm04+bX3KWD4k0MKp/IQctNcklcu2R9TglNfgP9EpNVWTZyodK0pv6W+4QaTqRukbTb/xW0LllEQLuH+HMh9kpEWUFfIPjnxvC7jTZJMF4ioq9TZrmTrPvlD+oTwkINeKT6r3xA4bmAHe7o6Kg+EHfRu3a6VQNL7z6CfvVwVPH+lXwHGJuKMXB0=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;6:6Y18bZ1RGN/4Xm2dWMD6dwDN/ePyY4OQEijr6JgMvlbwbbHYpbyw+5tZaxOzq3BpxTBK4JU55KHHwYy11xF4ps93RYWwerpubnzhmv/vT49DP93lqTiHS922u7CpHp/3Qmg+phFTH+ttm5b/RxtRkh7PoYzxBOszcT0PCEjWJ2+L8jhh7IsNyCPYHwfR/+qNtxmvMVE87NMfsxlTe2ZEwB2PaWTl45+BpFOsgHqKF73PD+iWmRtN9+ccYrY0lplo4WN5ORpejm2kU4P0Wg4dxGJPUVqbW9rF2+y+vp9tCKw0jANR81IZZG1sukU57zb1H0rLups1TyjQbjmr5D8SdjIHlMfXqwzyaNgxevHCe9khkoLWNl31h5A39+gR2AzNpLv6gVQMxbHHylun3QIdsf9pP668/vKGTeja0NIudNoveBUF0wQ8Kn81LNySn4Ps7Ctq+XT4c/QLiamTJQakTQ==;5:eYqqhGtZ6eTyC4+AhTQNHXem2TKstVQh+B267dDy+yARpeAov+lShau9rMr8st0xrF22SDzRUMvpGyemkbiTv3NiE1xnb8OGES3uIz8kfcDBJvbuDzrLajfyArGlFGmOxRldkDo9Z4QJE8gT3yGshDUkJLmZB/3kQZ2qzy+XKUs=;24:GG4iR4GRE3kvcA6fwFPY0Ewn5kGv1fXOnSBHApE8BJ8MzveukANuC0xS3+slwRTd9n+5j4qhqhByzzYOO1XsZH6ZVngFWHFO1gprmZjbFlY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0171;7:b/BejiYlIYOVB+6MvqPV3oqAMQ+Qjku7APAFIcJYeEpu9+23c0la7GEk+dixjhT07h61G5hMzFb+4tXMPDvDeT/blFKSa1jovaDgzd55RpfV+aUx9v8WLVCyvQS88ywY26ubd5Xmi+C9/lYJGYd+U/ftgbtElsfC1hz3B+2HUFK6CFPaFYyIRmFL7w0+nMzWCjIt+KCPlVUZTYZxjrdkvPbrptqr99RbJPDwKjDia+fIy0Pj/194B4LkHsXSB346;20:2LqMOBdAU1ayXFFt4929q681fwkQlcvMBQLTnvnuIdEFM0bbEyUrU6UnNaAawxiT9VuRoOA1UBRcSO8jUBETech0yyPLUAC98OjFJxokHTiLwv1Za7ac39+jBXJvWu/YbEB/agyw69oSMMdDKWNplaxUWKfDjOJOePzXoefanMc=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2018 22:57:20.7358 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66adda5d-e105-488e-1ab8-08d5eb6f7ce0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR15MB0171
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-16_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 12:30:18AM +0200, Daniel Borkmann wrote:
> On 07/13/2018 09:41 PM, Roman Gushchin wrote:
> > bpf_prog_array_free() should take a generic non-rcu pointer
> > as an argument, as freeing the objects assumes that we're
> > holding an exclusive rights on it.
> > 
> > rcu_access_pointer() can be used to convert a __rcu pointer to
> > a generic pointer before passing it to bpf_prog_array_free(),
> > if necessary.
> > 
> > This patch eliminates the following sparse warning:
> > kernel/bpf/core.c:1556:9: warning: incorrect type in argument 1 (different address spaces)
> > kernel/bpf/core.c:1556:9:    expected struct callback_head *head
> > kernel/bpf/core.c:1556:9:    got struct callback_head [noderef] <asn:4>*<noident>
> > 
> > Fixes: 324bda9e6c5a ("bpf: multi program support for cgroup+bpf")
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > ---
> >  drivers/media/rc/bpf-lirc.c |  6 +++---
> >  include/linux/bpf.h         |  2 +-
> >  kernel/bpf/cgroup.c         | 11 ++++++-----
> >  kernel/bpf/core.c           |  5 ++---
> >  kernel/trace/bpf_trace.c    |  8 ++++----
> >  5 files changed, 16 insertions(+), 16 deletions(-)
> > 
> > diff --git a/drivers/media/rc/bpf-lirc.c b/drivers/media/rc/bpf-lirc.c
> > index fcfab6635f9c..509b262aa0dc 100644
> > --- a/drivers/media/rc/bpf-lirc.c
> > +++ b/drivers/media/rc/bpf-lirc.c
> > @@ -135,7 +135,7 @@ static int lirc_bpf_attach(struct rc_dev *rcdev, struct bpf_prog *prog)
> >  		goto unlock;
> >  
> >  	rcu_assign_pointer(raw->progs, new_array);
> > -	bpf_prog_array_free(old_array);
> > +	bpf_prog_array_free(rcu_access_pointer(old_array));
> 
> Taking this one as an example, why can't we already do the rcu_dereference() on the
> 'old_array = raw->progs' where we fetch the old_array initially? Then we also wouldn't
> need the rcu_access_pointer() on bpf_prog_array_free() and yet another rcu_dereference()
> inside the bpf_prog_array_copy() from your later patch?

We can, but then we have to change bpf_prog_array_copy() args annotation,
and also all places, where it's called.
IMO, basically all local variables and function args marked as __rcu
should be not marked as RCU, but fixing them all is beyond this patchset.

> 
> Regarding former, rcu_access_pointer() should also only be used for testing the pointer
> value, but deeper in bpf_prog_array_free() we also deref it, etc.

Hm, but at this moment it's a not "real" rcu pointer.
We're sure that we're owning this pointer.

Btw, we probably have to use rcu_swap_protected() in this place.

Thanks!
