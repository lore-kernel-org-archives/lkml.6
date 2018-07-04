Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15549C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB7A5223C4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="nwsEaa9o";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="ZrkGrVEg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB7A5223C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752942AbeGDQbu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 12:31:50 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:53536 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752565AbeGDQbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 12:31:48 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w64GSJZX025887;
        Wed, 4 Jul 2018 09:31:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=GGmXZluLATsZluAM9jLh3/drtXDwV77IdKGSCH92eFE=;
 b=nwsEaa9o4M7DUhKZkNZl2TgKUdR2+s6Q3UV6UibqGHw/mOBoLgGyTFgiVYxipqpxQAaU
 DKq8NrZ6CIAS/rc4YXTB/SwFmVEg+/UTWtbISrVqkhZ9v16LyJ+luoNjdcFmdZn2+viN
 7t+wmZCVVNxHS5A3o/V7cnezmAbWGqvJ3Ts= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2k0w490kd3-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 04 Jul 2018 09:31:24 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.33) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Wed, 4 Jul 2018 12:31:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GGmXZluLATsZluAM9jLh3/drtXDwV77IdKGSCH92eFE=;
 b=ZrkGrVEgdZA5mQW98IDzozZ9Xft0YadFsoqvUB+ZBcPQjH4/nHaQqiscEZ2rY+57nmiObzE245AmYfZbcyfEji8F7BwjBqqVXTvt1G5aBmIpYASTqXRW90c/tJFpoHj/gJyK+Pqf0wnRKFzAP/NerrIl09uZw7udOy4L0w2uXpA=
Received: from w1t1fb (2620:10d:c090:180::1:2e64) by
 SN6PR15MB2511.namprd15.prod.outlook.com (2603:10b6:805:25::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.24; Wed, 4 Jul 2018 16:31:19 +0000
Date:   Wed, 4 Jul 2018 17:31:07 +0100
From:   Okash Khawaja <osk@fb.com>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
CC:     Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 2/3] bpf: btf: add btf print functionality
Message-ID: <20180704163106.GA2200@w1t1fb>
References: <20180702183913.669030439@fb.com>
 <20180702191324.570616684@fb.com>
 <20180702220659.6baa77ba@cakuba.netronome.com>
 <20180703214559.GA4448@w1t1fb>
 <20180703152331.151d1c4b@cakuba.netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180703152331.151d1c4b@cakuba.netronome.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Originating-IP: [2620:10d:c090:180::1:2e64]
X-ClientProxiedBy: MWHPR15CA0065.namprd15.prod.outlook.com
 (2603:10b6:301:4c::27) To SN6PR15MB2511.namprd15.prod.outlook.com
 (2603:10b6:805:25::24)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 767d4175-5fdf-48b1-c047-08d5e1cb9313
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:SN6PR15MB2511;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR15MB2511;3:Wj/9FKSNAAW03sxuyp44qnz4Ay+YaRIkSn0Ce3e13QStAt+7BQ4nhMjz7ZlrWOnGZjRVIMZ/a5O7N1ZmAfILXzE78fzCdxkin90+ovJpqnopeGArg3xQ1LBrXaq38BYbbPcuSIFkv2a5piazYS+cOBrf0drv87ZKJnMfGzt6g+PtP3RS7q3FhSc0DKIZwCiR1axyon2nL80GPHl9hoV4mmWCiqlao1SdM8KnQqFcLl1dOG4aBloc1FQk/5H+3gyY;25:PwdA/rXLtKXqlNrrP3lLRa6K+x/f5RAbvW0YPHODa+ERBIUVb381ifUJoUJXj7WA6TYYpEC9S38odivyVFTn7zyVqQ6jk73r2K8zoUVn9wyy4ChqZeqpClnALYop9TZAcpmkbsL0gWrBP7MKFsP/IiXBcarg6NG6/H1w253tM14oxJBbQ9Ohxp3yQnUG9UtH31CRBRHvpJVjHP4KPkCPht24ez2CBQl1TeDP6ot2uIfuuIdqOiPwPAaTwdIqBv3KCGZv7IAWjlp9LGaQ02m+jFR4iHROS6rDoNlr9vmmz1S0io2is+dw/wFX2OJ5VK8aITo/CCM6ajDwH/tRwGpyfw==;31:PuxEMwMQWmIHC+1ehk+B6E5M1W0k5DyAIIKuB1MLq7UTb/tZx7eZUsdumTfUUZ/s8mqq+6H4R08iwQX05fKQT6WzC3/jzxgHzigBc638LazzOfsxEpa2a3om7a1Fz+MN+lsOJfZ+vMmTp/pgU3xsoWfkqlG5Ka5vqGl8/B4VkHRfWxHqzIAq2mHMfOQhqQp5kpGh/rSab22544+bkQLeSvFy3I/yILW2jVxU8d+ZhXI=
X-MS-TrafficTypeDiagnostic: SN6PR15MB2511:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR15MB2511;20:/6kNHfpNJ9e9GD1s9juP9HMyKEqdHcyflxvRq4LEtdI/GHgYxOCwyLiAw39gTqPQ445eZ4qmSkRo695dHsvSJAyW08Ol4slbyguWvhDwE+xrGvh4hL/HKKNEmSEIiMtIfv6h/qKitpMQNiR59J8w1Jk/5UpW/NfAE6n/aCTfm8SWKLjQ/Vpqx3mYRRMuC2fqHhBLUrxhmJxDpMOirNp0V5aQVAvsYmIRjzlDDNx9BNLEg5w/UJR7aC2PNq/v4biuSGSWHZbAVjW4g5dixyPcOoPJPpGto3RyNv7ymFDIgUPqnN629OsDChesUjUo2N1iTCwql8mF4Elw6sdm6Cc2sv1L1ZcycITq5KMSwD3KMRiObx8wDyMUHh4fmgE+d/FkymR4fclgd8s59hCpF9scdT1zT6Xp9xn289v5mwpDeLC03P1z/gtQnBWSevqk2Qed8fw3bCCDcuesIuQXyoRN/koA3L9Kj1QG56uGysP4IyaWhIPzopaIy0JDzMj93Lh8;4:eXLqnFizB63FAfaP/IRHFLkpdYSiLWkfUL7FYN7nBaXl/x4Cxvyo/PzFRYTtd5l2RQ4Uywsf3IorMKX2E7pF9qFOqWdfUW/cC7NeMwCigd2B0gWhtNFW1pAfnlU/gp+BjSGugqjcZM9CdGDAbh0FJ1nwCD5m1MDs24GT384sTyzbCY30p1/s/61HS0gVdgz26t2AxO/CbEyVixs0aP3mek6q9bo14avtYL59Vf2JkjOOI+FEhM6+PC9PuRp3QpC7UcAXHruLuBi0I1b7F/4cqknRZNLtSktwEXfQuXO6Ux9FL8rglX7IcxKmdgNej0ZV
X-Microsoft-Antispam-PRVS: <SN6PR15MB2511035C89192E768A65E252C6410@SN6PR15MB2511.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(11241501184)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:SN6PR15MB2511;BCL:0;PCL:0;RULEID:;SRVR:SN6PR15MB2511;
X-Forefront-PRVS: 0723A02764
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(366004)(376002)(396003)(346002)(39860400002)(189003)(199004)(58126008)(476003)(46003)(5660300001)(9686003)(50466002)(97736004)(16586007)(54906003)(11346002)(6916009)(53936002)(55016002)(14444005)(6116002)(16526019)(33716001)(478600001)(23726003)(186003)(446003)(486006)(93886005)(316002)(1076002)(33656002)(386003)(68736007)(76176011)(6246003)(7736002)(33896004)(6666003)(39060400002)(305945005)(6496006)(106356001)(52396003)(105586002)(47776003)(25786009)(52116002)(2906002)(229853002)(4326008)(8936002)(8676002)(86362001)(81166006)(81156014)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR15MB2511;H:w1t1fb;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR15MB2511;23:WhG5XSWpZ4yAxOcTPCY8sUnqsolwxeWrA/tIXSD0K?=
 =?us-ascii?Q?QA+n1DVusNFs3ep8nj5CWCeN0KREzFS9CHDRJX+eWyataMYV0Xo+1R5kkrI4?=
 =?us-ascii?Q?cpJjyO5BSeE6Z8Bd283J/NGvEchPsFIEFjgc/Qff4VY7jU2fKJAnTYNwfEa6?=
 =?us-ascii?Q?maTwCct2AAZ+tmeOeiXQy6+UksNGaSAxd2a0A80ci2Mczu05yOz5lWXKV3wf?=
 =?us-ascii?Q?2sJqWiduK/q7rp2GnQYqdmtxx2/IzlFuflGS5PCLNjCkkoqK13Ye60NtwL2f?=
 =?us-ascii?Q?iQTmoJ+68cgPV3OtuhtcikKqAhEQIfmhL0d4Ns5w/Jr3aiaoYQ55evuKieuz?=
 =?us-ascii?Q?HYMFx46cGMhtyXMgKjZPZ3ovZda0HIJLqB0/CgJKHLIt8f821aTtGjWG3Yd2?=
 =?us-ascii?Q?OVzKqbDHqm4IxelE3EHbvjVecqS3og0NXwVtQOQS+jEcSMBCN5v4oEmByGwf?=
 =?us-ascii?Q?cjQ4xFl8CMdif9E+oWyNjALCiF+oZzTSM2pZX7jBBo1s/z1cqnEN0lHZnUiK?=
 =?us-ascii?Q?60d/I8aH5L1EunGImPhdubMyVCt6SpXmiKXSfXc1qdfKdKqqN0Dd3uFxQ7w0?=
 =?us-ascii?Q?TvuhMPU/jY9zPckLuJxOPyPEoMlT/BS2W97wPO1oVe3/r6GD8wAlROn3f8Sw?=
 =?us-ascii?Q?DVO4Rgt8gqrPqbkPCX4nLawnlDKBu95eDBNCWF3SQ0WoE5tt30vLrYC2MUnh?=
 =?us-ascii?Q?sTldmF6Njbo9Lmp1lD5t8/zXNB43fK7J5Y+Hgv6bP6F3zldlIQpM2pxkDrSg?=
 =?us-ascii?Q?2XGaZJqb48qnNgdEgDbDWPYhqcyhwbBm+ZtYizrvt9NdyPXnWO+zAXUEQg18?=
 =?us-ascii?Q?YH0yfde+C5Qnt5Fflstj4LVAOsiULywEwcvm6kc51w+oag0LqfwLHkC/W3cT?=
 =?us-ascii?Q?2wOFKdHIGN69pcxaZPFwwbMX1cgcoO21Ouz3nUphdFQGskE9yykYT+m9iE7k?=
 =?us-ascii?Q?UJbsqFHkaehd5Qy+Plj+CzGZ5JWugq+JNL4z8zgC1VWhWV//FqHRQLq50kDu?=
 =?us-ascii?Q?4GDqM6AWAGda02v1he5FWG6LLn9ClV5ijYUERQuNiDQG2DhglAKqa1pVS5L+?=
 =?us-ascii?Q?9Iw/pd9bPVsaea0JJpCH9I85Lk3ZfkAOBG/L/md/+lWY1o877AHUZ/R+HyYR?=
 =?us-ascii?Q?8pSY8MOQjmZW2lUy+tC7lV+derdV8bpy8seDxXhlsneaHrm65htpT1ZcRS3y?=
 =?us-ascii?Q?bH10vWT/ahXlO3HlNtXPwVsi7q+PvnTZ3kyvVNpWP8Ii0LSYnzTAKLO4KvNF?=
 =?us-ascii?Q?tFuWzUyQ1IaRGVHVI0+R82C3gosBKW4Fz4h5gHN2N3FqqqBVvYHVifXCJsoy?=
 =?us-ascii?Q?qJz57LAc0aFqNf/u2cIs5PASJPIiPu4CwxuKcPRNyAX?=
X-Microsoft-Antispam-Message-Info: HF5pFlwn4gilyd7ytiZ+ehdea3JZPQRHCamWOZyoEfnGG6VW+TLPA3915WNtyz9Oco5QTxH9uIHDyQOxUuwB5Pv2+Ls4R4aIPeSUc0nKSR71o6jBjIX54kTVBx31mKf1RbGFc7K9oRdn/h7GSxTF6/E88cxKq/Reb6dqjslIycZ57IFP91gMhXCYxxiq/fkhQc6K6S2X1c2TPqBtI/yAYfnD/rutyOH2jzbyg6PzUyoKHZLZnl/8UVSbGs8szPkHa7au7Z+r/HWaKmG5g9iqFIYyL2WytaJmCEH9xeXzi9ZHs/uGcuRBhZ4AkFZ/jZJYScElZnVYnSWxVtSKM31IbzV3CjgpjHHL4LBrWUt+knU=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR15MB2511;6:xDZmGJ2ZXrSjr141+S8FAyjl6FDf0TBAU2kBb6j12ox7Dnex9IEnTdjSRJUFRuplKjAjA3pcKyNyZA8oOq6Z2t3g3KC3s+tFrHEf9lBAJeuJV0p42urIntmxCPc5biZad2wke2ibdvecNkRzUT9Umh1P7Np8EjILXKwy7FJuKq4UFQHcgNAE7VRrVVNc3VEDzPsGp5zCEdtl/Hde8AfeQdj160+1bJ7mZBBE6/varT9Uzgmf7x9W48bOXSvMEL4i2VvyK2VWHJk8Op3MHDuou4G280jGW+L+VZOT1GP4iUBBWYCJG/l8pIvzldSLoW5W4NbBd+0HD0TNGGYELhGfC33h7JSUNYmcN8VbVEwTdiQP1PuWRRqRkTRXLLMUbmyWfX+ruoAnp93yJO08Hp0ksdm7wqT6Zz5CEXTQNdz6OhsQ6tusgBC0dm12o/08uPoE82chsgX0ho4ozhj5+HbkLg==;5:UquIJokQ1BTeDChxlNP+yksqJpWARk2th9/r/r/D0ehMd8p8vARC2/881Kf5KYsrwrRU38jPRRPLsM8cU8B6t5S1FNqmPnV6byzUXqjm/v/mn/Hjafd+7ekpchBBZGNkkBvUy0NCqWhA1agGes7hUTfwoQUDjRcHYssZ0yZMMcY=;24:Z9SMNqAIwAk73dPR2rFIabYZscSZVv4H7QfsKdPGT+dnW1/YxGx6IRU6QVc+DwAulP7C5Flfkp4HzMD7t5Tzj8cG3Y51PDCsUWWcDzV1TIE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR15MB2511;7:yYHob97XIO1DO6WtdzhdnG1T9ZMitT6RB6G81BAxYZkLlZf73yOYWayskVXFoTHGZP5c8hg+fU6DXKfR45tHVFl3wFk4LS3l0BKYNFiRXMcvqluhfLWwSlFyK+agkITDMTlwT6P8biuQpaYpqvNuyUx++G30Qvviez7stJzY+34Qv1uUp4wytgd0Y9bEtXhOOXSZB9lXUhd+NqiyG2ZePH0gX1ysM4Fz7wKGdmlLOBm7YynTY6PMHfaN+YayxTtG;20:lzVpxsZm9pJf0ADWLzSk5PQSaXVzllPl4zn3Wt7B5p653A7C+874jp6LPJr9Uey2IovBfXm3Fx2Zo9unr/vYi5JtaEhA7n3xkJCpmP1539IewiGJLFcTejbsg/zl0kMUrytG96rScHMlzdxRCf4FiQ/0HpCZukRi9sqRqORxP2M=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2018 16:31:19.0886 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 767d4175-5fdf-48b1-c047-08d5e1cb9313
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2511
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-04_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

On Tue, Jul 03, 2018 at 03:23:31PM -0700, Jakub Kicinski wrote:
> On Tue, 3 Jul 2018 22:46:00 +0100, Okash Khawaja wrote:
> > On Mon, Jul 02, 2018 at 10:06:59PM -0700, Jakub Kicinski wrote:
> > > On Mon, 2 Jul 2018 11:39:15 -0700, Okash Khawaja wrote:  
> > > > +#define BITS_PER_BYTE_MASK (BITS_PER_BYTE - 1)
> > > > +#define BITS_PER_BYTE_MASKED(bits) ((bits) & BITS_PER_BYTE_MASK)  
> > > 
> > > Perhaps it's just me but BIT_OFFSET or BIT_COUNT as a name of this macro
> > > would make it more obvious to parse in the code below.  
> > I don't mind either. However these macro names are also used inside
> > kernel for same purpose. For sake of consistency, I'd recommend we keep
> > them :)
> 
> Ugh, okay :)
> 
> > > > +	} print_num;
> > > > +
> > > > +	total_bits_offset = bit_offset + BTF_INT_OFFSET(int_type);
> > > > +	data += BITS_ROUNDDOWN_BYTES(total_bits_offset);
> > > > +	bit_offset = BITS_PER_BYTE_MASKED(total_bits_offset);
> > > > +	bits_to_copy = bits + bit_offset;
> > > > +	bytes_to_copy = BITS_ROUNDUP_BYTES(bits_to_copy);
> > > > +
> > > > +	print_num.u64_num = 0;
> > > > +	memcpy(&print_num.u64_num, data, bytes_to_copy);  
> > > 
> > > This scheme is unlikely to work on big endian machines...  
> > Can you give an example how?
> 
> On BE:
> 
> Input:         [0x01, 0x82]
> Bit length:    15
> Bytes to copy:  2
> bit_offset:     0
> upper_bits:     7
> 
> print_num.u64_num = 0;
> # [0, 0, 0, 0,   0, 0, 0, 0]
> 
> memcpy(&print_num.u64_num, data, bytes_to_copy);  
> # [0x01, 0x82, 0, 0,   0, 0, 0, 0]
> 
> mask = (1 << upper_bits) - 1;
> # mask = 0x7f
> 
> print_num.u8_nums[bytes_to_copy - 1] &= mask;
> # [0x01, 0x02, 0, 0,   0, 0, 0, 0]
> 
> printf("0x%llx", print_num.u64_num);
> # 0x0102000000000000 AKA 72620543991349248
> # expected:
> # 0x0102             AKA 258
> 
> Am I missing something?
yes you're right, good catch! i'll fix this. thanks vrey much :)

> 
> > > > +	upper_bits = BITS_PER_BYTE_MASKED(bits_to_copy);
> > > > +	if (upper_bits) {
> > > > +		uint8_t mask = (1 << upper_bits) - 1;
> > > > +
> > > > +		print_num.u8_nums[bytes_to_copy - 1] &= mask;
> > > > +	}
> > > > +
> > > > +	print_num.u64_num >>= bit_offset;
> > > > +
> > > > +	if (is_plain_text)
> > > > +		jsonw_printf(jw, "0x%llx", print_num.u64_num);
> > > > +	else
> > > > +		jsonw_printf(jw, "%llu", print_num.u64_num);
> > > > +}
> > > > +
> > > > +static int btf_dumper_int(const struct btf_type *t, uint8_t bit_offset,
> > > > +			  const void *data, json_writer_t *jw,
> > > > +			  bool is_plain_text)
> > > > +{
> > > > +	uint32_t *int_type = (uint32_t *)(t + 1);
> > > > +	uint32_t bits = BTF_INT_BITS(*int_type);
> > > > +	int ret = 0;
> > > > +
> > > > +	/* if this is bit field */
> > > > +	if (bit_offset || BTF_INT_OFFSET(*int_type) ||
> > > > +	    BITS_PER_BYTE_MASKED(bits)) {
> > > > +		btf_dumper_int_bits(*int_type, bit_offset, data, jw,
> > > > +				    is_plain_text);
> > > > +		return ret;
> > > > +	}
> > > > +
> > > > +	switch (BTF_INT_ENCODING(*int_type)) {
> > > > +	case 0:
> > > > +		if (BTF_INT_BITS(*int_type) == 64)
> > > > +			jsonw_printf(jw, "%lu", *((uint64_t *)data));
> > > > +		else if (BTF_INT_BITS(*int_type) == 32)
> > > > +			jsonw_printf(jw, "%u", *((uint32_t *)data));
> > > > +		else if (BTF_INT_BITS(*int_type) == 16)
> > > > +			jsonw_printf(jw, "%hu", *((uint16_t *)data));
> > > > +		else if (BTF_INT_BITS(*int_type) == 8)
> > > > +			jsonw_printf(jw, "%hhu", *((uint8_t *)data));
> > > > +		else
> > > > +			btf_dumper_int_bits(*int_type, bit_offset, data, jw,
> > > > +					    is_plain_text);
> > > > +		break;
> > > > +	case BTF_INT_SIGNED:
> > > > +		if (BTF_INT_BITS(*int_type) == 64)
> > > > +			jsonw_printf(jw, "%ld", *((int64_t *)data));
> > > > +		else if (BTF_INT_BITS(*int_type) == 32)
> > > > +			jsonw_printf(jw, "%d", *((int32_t *)data));
> > > > +		else if (BTF_INT_BITS(*int_type) ==  16)  
> > > 
> > > Please drop the double space.  Both for 16 where it makes no sense and
> > > for 8 where it's marginally useful but not really.
> > >   
> > > > +			jsonw_printf(jw, "%hd", *((int16_t *)data));
> > > > +		else if (BTF_INT_BITS(*int_type) ==  8)
> > > > +			jsonw_printf(jw, "%hhd", *((int8_t *)data));
> > > > +		else
> > > > +			btf_dumper_int_bits(*int_type, bit_offset, data, jw,
> > > > +					    is_plain_text);
> > > > +		break;
> > > > +	case BTF_INT_CHAR:
> > > > +		if (*((char *)data) == '\0')
> > > > +			jsonw_null(jw);  
> > > 
> > > Mm.. I don't think 0 char is equivalent to null.  
> > Yes, thanks. Will fix.
> > 
> > >   
> > > > +		else if (isprint(*((char *)data)))
> > > > +			jsonw_printf(jw, "\"%c\"", *((char *)data));  
> > > 
> > > This looks very suspicious.  So if I see a "6" for a char field it's
> > > either a 6 ('\u0006') or a 54 ('6')...  
> > It will always be 54. May be I missed your point. Could you explain why
> > it would be other than 54?
> 
> Ah, I think I missed that %c is in quotes...
> 
> > > > +		else
> > > > +			if (is_plain_text)
> > > > +				jsonw_printf(jw, "%hhx", *((char *)data));
> 
> This seems to be missing a "0x" prefix?
yes it does. will add 0x.

> 
> > > > +			else
> > > > +				jsonw_printf(jw, "%hhd", *((char *)data));  
> > > 
> > > ... I think you need to always print a string, and express it as
> > > \u00%02hhx for non-printable.  
> > Okay that makes sense
> 
> Yeah, IDK, char can be used as a byte as well as a string.  In eBPF
> it may actually be more likely to just be used as a raw byte buffer...
> Either way I think it may be nice to keep it consistent, at least for
> the JSON output could we do either always ints or always characters?
yes, makes sense. i'll keep them always characters.
