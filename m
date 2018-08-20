Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47484C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 19:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D460520852
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 19:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="cJB3hkKc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Aj0tdvbJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D460520852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbeHTWW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 18:22:59 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:43384 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726293AbeHTWW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 18:22:59 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7KJ5FCm017592;
        Mon, 20 Aug 2018 12:05:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=EYWBKVYiuqO3+Nc7F+YEGjoCWsyZsSHros090MIFqpw=;
 b=cJB3hkKcn0sBciPHpA69rhCl0lNcEChUr0HOHDhzHYssk4D2iS+RGYmqd8t6ewh1gOoP
 F4+KoCcLTId32KEOQ3u7ZQNMLK2rLyut7mBIFYZK0f/wy7Ywu/DLz5nDH3haLmXWmH37
 hju5ma8US/28/CziSfwfP0uIPku7cAsMLpY= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2m01strbpm-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 20 Aug 2018 12:05:58 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.14) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Mon, 20 Aug 2018 12:05:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EYWBKVYiuqO3+Nc7F+YEGjoCWsyZsSHros090MIFqpw=;
 b=Aj0tdvbJ6rqYHGikt+dcWwZt5twUePfPwE6L7AABx29lUgw9CiLHdUAGoyrUEv5ZVXBKbGvfGFaWiEBup3Le70eAZQc8jH+Lb/q562PGT21jvKeG6q25vuDieyLe4nMnZj5Ym0W1gJ9KUVyIUaHQ0pBjz5NkHGH/kmUKd+QdGZo=
Received: from tower.DHCP.thefacebook.com (2620:10d:c090:200::7:371a) by
 SN1PR15MB0176.namprd15.prod.outlook.com (2a01:111:e400:58cf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1038.25; Mon, 20 Aug
 2018 19:05:51 +0000
Date:   Mon, 20 Aug 2018 12:05:46 -0700
From:   Roman Gushchin <guro@fb.com>
To:     David Rientjes <rientjes@google.com>
CC:     <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Tejun Heo <tj@kernel.org>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: cgroup aware oom killer (was Re: [PATCH 0/3] introduce
 memory.oom.group)
Message-ID: <20180820190543.GA29491@tower.DHCP.thefacebook.com>
References: <20180730180100.25079-1-guro@fb.com>
 <alpine.DEB.2.21.1807301847000.198273@chino.kir.corp.google.com>
 <20180731235135.GA23436@castle.DHCP.thefacebook.com>
 <alpine.DEB.2.21.1808011437350.38896@chino.kir.corp.google.com>
 <20180801224706.GA32269@castle.DHCP.thefacebook.com>
 <alpine.DEB.2.21.1808061405100.43071@chino.kir.corp.google.com>
 <20180807003020.GA21483@castle.DHCP.thefacebook.com>
 <alpine.DEB.2.21.1808071519030.237317@chino.kir.corp.google.com>
 <alpine.DEB.2.21.1808191626190.193150@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1808191626190.193150@chino.kir.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [2620:10d:c090:200::7:371a]
X-ClientProxiedBy: MWHPR11CA0011.namprd11.prod.outlook.com
 (2603:10b6:301:1::21) To SN1PR15MB0176.namprd15.prod.outlook.com
 (2a01:111:e400:58cf::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c3b160c-bdf8-4e73-9172-08d606cff2d0
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:SN1PR15MB0176;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;3:4shs5CrvdDJO46ueLFcgCmfLWVwAKmgm66UmVeinlH30hvfN9JiL7GwWrVbPQpBqaZxnKFGTSHxLjVK35nwkRso13kLVbW3OntYI4M3MNl6g+sqUDX2LJbdjx+9DA+U1NYpRd1moMREoh+eV2XZ0PuB6t1gtdkz7Qxfl7L+f+agjDiYdKMTzQO8A+AUOLWqY3nnl4M+Q8XPjce23Q0NMuyPeo5BwxnEOs2qrKNONWhjddQXGcUKGcoxCva56AGHq;25:uj7rq+83s9hn00+eWU4+iebmGike7qOzv9CHRWG/PIQuwm6/qtPSrTcKhoLMpmMmlNo8cqzKnZPDXMUx7YBHe/RerKO3cuK8TDdfKZS22cIxCor68U/BarU0LzwoEkCLVmsGMrCU4Rtg7eB4C9EKBb/gjKEMSg0+A2pyd0BWqtUzwn1WX4eSjAn+qUYjNivaBsn8snn8/RG66+eX9qLRPeEXge/f3lzs9D1/ehVmQVe0GYud5HP19XbUqHiUMqICxaSUvpoOi8XdjITEuq0b7IdQqjSSqKl90BgfWaJAPOD7XStovqujGSlw+d+hwhvPlYFb6ywekQ9NRFDwejp36A==;31:qWkE7MVttZnD2y9jX1VzZ2gUaeiZxUN5CyARBM/8cT+CX//pijJ37eg4W5biOOJvMWOxcEolRL81OvVroqmU29whCrkVn+WuU5serqfDsWtwChIIRBIwvGwZveNLz9Zf2SfEzMOpOThl7bSM1tYHVmyUbQDKrvrva4iG8kcmbpDCe0ficlYerH1pGRWLNsrIpAjvv16Ih5VkLREEYVMxiYwM+QhGa6fydXMnm3nAbwQ=
X-MS-TrafficTypeDiagnostic: SN1PR15MB0176:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;20:sT0r+Aorio0AbmycGZdN2CgDMaF7bOhyE9LW2fnMbq8PlkmDT09cnIYP6a+l42Tt8LM4bSa5O4o+6TqhiSrODDyuKdkNEQ3lPL47SPIyEGsZTWxaSQAPSwaMTrQ5jLkf2n3E3QgFyZfVdD7K+lqCmVt/vfdGRRe/JL+8fv2Nmc2VvHiTNB1wCg2PxpFtXpQKkbGCTheLe6F9cry7NRWowSTmUqQbFP7BUAMlvNBZhV4sLFTysDkeQJERpaG5e57oaW4NQyrNZcMdDITAp8kHvpM6lp2FsLI5421RYJBidIB70Cmxtzc1wc1NWDcreJODjUZC1f34+mvMSdQQJavKo3mxMyPo+wRSjom/WG7aOrC2diSBX5QbgNmXsrhd54CDYg1eYquISCX8hl4TTgbhux6Er0m7m4YhpQgT/k8fVAB4J8MxB0rDOj3y1yM2g7jpzGhXWh0pvsP4guLMj6Y963b6dJFCHGYMT5KP/4sAU3Fp3FbebizZbfykCKrtw07F;4:7UPjZc8VUaaPF14njTJkBGltl+yOij54vg4LNCx3UChli/IybK2bKRKT716gbjaHZ+hVuGGmI6gGlesuAxJPB2RauqA/NtVZJwxh9R7IOwyUlXA3zV++cRX8jgd9Kg43EKVkj/ouSCzLR+lhLFUIRP7C7AGcL891cMPfyefChbIw2fUQK0iijnxI732fMeOlDjmUIn/piUwIbsnfWDBzcuQ8ZlpDoPY/Fcw6s10JoxXX1YNPePhOJhe/gDpadq0APevG5PZf1jeRUc10zt57iRQdrVZqiRX0XvEuI2tjYnK5nILNqOPRyGJ8rW9iYncgYvV77B/VzlQ0BN7mev+xI8oVQRMKZzdqY9GIwq/htS4=
X-Microsoft-Antispam-PRVS: <SN1PR15MB017620E0CC07B080281CDB8FBE320@SN1PR15MB0176.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(278428928389397)(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(10201501046)(3231311)(11241501184)(944501410)(52105095)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201708071742011)(7699016);SRVR:SN1PR15MB0176;BCL:0;PCL:0;RULEID:;SRVR:SN1PR15MB0176;
X-Forefront-PRVS: 0770F75EA9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(136003)(366004)(39860400002)(396003)(346002)(52314003)(189003)(199004)(23726003)(5660300001)(561944003)(93886005)(6116002)(186003)(16526019)(86362001)(6666003)(1076002)(6246003)(55016002)(9686003)(4326008)(81166006)(478600001)(81156014)(6916009)(229853002)(106356001)(14444005)(105586002)(58126008)(54906003)(2906002)(8676002)(6506007)(386003)(446003)(11346002)(7696005)(52396003)(97736004)(316002)(50466002)(486006)(8936002)(33656002)(68736007)(25786009)(52116002)(16586007)(47776003)(305945005)(76176011)(46003)(7736002)(53936002)(476003)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR15MB0176;H:tower.DHCP.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR15MB0176;23:NjBzRPELKKnctdMnoC7+P/nO8QuPVCi37RpQxnKXb?=
 =?us-ascii?Q?I8rXiahSeV2u/0PuMQoukwZz99ZrFkAamra2+RBYOFonRoIrCKvzxN5+GeoT?=
 =?us-ascii?Q?pzTzBspDiusYY8SjkkDSI+CvbJWLBiZZ8hRZFVD0V2CUGLLH0H5ffywLbj4K?=
 =?us-ascii?Q?QX8iEuhftLuqbaqpcQDgC5neaz5AyFYn2rLmrPamIfc0G4SBFa7k4Pbiil1E?=
 =?us-ascii?Q?qO8qI9OHl545aofIn+9y8AeQBwEGE+paB34QBuRESX2s6Ot0y6p23jLau6km?=
 =?us-ascii?Q?CMPwMMBMOGoV5YuEOxsiug8W24+9JkqqJBNyf10Knz7CusxqikkjghSfNgT8?=
 =?us-ascii?Q?TjHsgojUCwj25Tf8D517F+cHEUYB9WGBxGaiCh2lZX7YBleQ9NxOUFL7WZKJ?=
 =?us-ascii?Q?XDGD7gEfdh0gNOCfq9yHO0F3oT6qdCpQ+Yi3pok8hJH5UDwGX0m+mR97yVCS?=
 =?us-ascii?Q?LxXPOAr8Sy0WkUi5I6BX9dAsks32scwW0/lTnx62/WIvjKER0I7tPQMSvhzC?=
 =?us-ascii?Q?6bdAkBByUFE1Q2LjQdtjcgE+b2pfutPYTC/LG0g7qJDICaTp+g2v/Wz9YYk9?=
 =?us-ascii?Q?/vXmNfqS2SonxJKDY5EHLWxRwVvO7tUL4M1+J7orisO4u0LdZ/xFvB1w9lc+?=
 =?us-ascii?Q?0cSi4m1rxD/reF4kQXdY93HR7zzK7m7SJ290YMS2wTBiWydoAJos4nJqzd0p?=
 =?us-ascii?Q?Ekyqy9+F3DJ/snqSgvXrMeDQkVBxDv4skaN647huJyXvt1vvD4wOti3bbogQ?=
 =?us-ascii?Q?tLOrdVFkKUkXVURckTTprNgK3GoYLkWvFSjLOGn/kL8jkuXkBm7PTspE/iEs?=
 =?us-ascii?Q?8ATibFYmdN1jrQQrqVkrMSnACqwKad7syX4gcz3DjymyFQkgV52mxIcIJhmg?=
 =?us-ascii?Q?3WR8yqyRCHE1KA22YQONbumEZ6qNu7zA+qJCwZO1LIxvM6aTEqbGfFV2x42U?=
 =?us-ascii?Q?uIR0zUYcOV8FlFsbuFVEv1yhgwz6fiEs/sI6OHDb1juU6kFYYpHmCWLS/GQh?=
 =?us-ascii?Q?vbjfLPi31U3DscEAeEyzoOInwuHyOfr83GNMFOtTG+vnP819PC1whK616rop?=
 =?us-ascii?Q?9OOhk2hxgJhQJaQUZWSDOHAmFxhKi/PTw1qpSIGu15ImZKJ0Q7XdKVQqS6nv?=
 =?us-ascii?Q?sYglDGF8NMTmbWfyu/Y4e4X5a5IOFmIOMVnHuU5net0xb8cqTXwROkv659qU?=
 =?us-ascii?Q?ImlJd59SAriA0mt8oIh5Nyd10w2gBxwZJCe30e+wWPFHsMdQNKTTfMOKvESd?=
 =?us-ascii?Q?PharDmlUhaqlz47Y+C4WZnDpstk9bZqxc8axlpLIOuJGQ32vFowr27ZOXhec?=
 =?us-ascii?Q?ZTcx231M6WEhumJO+maFqGnN9g09uVYlgNL3KhjyQre?=
X-Microsoft-Antispam-Message-Info: oTvQ5UX5wrVzjxZ9ZdtVPpUeEtj2iKqg3+0b8XrqeSMKBEABKEeTVGtO6Fx7YNQAX0wr9Vb5oHMIPMPARGTOIPmrMu3ya25h5Suv2rGaZFkkOeChR8Mu1QKcf61vGozRekNnqjBiGWX3Yr7Dq8DTx2EqabLTD1fzT7C9/EHVUpkjivDKSfWS01l15dGxvQjNmDu+WA5O3R2veycD4ZhfGT9rwCw5cpmiLDOaHc71ddtV7JwLCK4Afz4mmxEWp1Tp84zX/APS6g9SZt685Ltc7hRniG4Tao2BN/nRQSmeUTCNs1U1hnx3sGEH7UFWv/Bbs6yTSFuwG8fwHDnDfLMPdShoVYtgBZ0MQBDEIsW+yiw=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;6:EPwJbLoq7DJBAZL1NfRWdkwC3O+U0Vo8I5i/hjaqM3ylvVT1tbfUV9QRH7Ne4MQj5lsrDNJmxR6ekHc6ZEqrOrLaNeKaTUGLiqR1n69psJ7O1h+yJctZj7y+gm1nCvMqihVXVibvuVhy8HAPLuapUuSorXU+cfm0WeJAlI+42yG2UUWoSAIxjOs3zILqI6sghrl13oFGjjEc5dGrEZTVAuvUG+RrY9w2g+hC4MOgkA/miMbRPEut9CKQJ99PgBxzV8NreFgOSNZLchVTCl0LUVKRb7zqvPQjvu3wMOCX0diYRoej9lpmBSuiEl8tdC4LL2kgrGGYLhf7fmz8E19eSImSDdA6/RU3lkrwlETlIWkFsQAsHN669I8PR3DWPXasV4k32LVKKzlNh7iYMR2jkR99P5KLea3WvNhz0glGkRADClfC1Zqt6gqDtREvo1g+KM6+h4yG/zzWMOswKLW+MA==;5:i+toJGNVT56K2nxnHwzYtrG9TzC0fpiq8CireO90A6+vUDZ7ITu0GvgT5TYSnfGJiXtWrW+YHrr2y3i0WxJaKJlw5bWzDTEMjA0ogQNIUJMd2ZSbBDxPvAUKc0mZIGAcNv2NuqRFy2xnKOjUAzQpRSIhuqn/0g2rlEUdfOGdKNw=;7:E26vzqnz7ck1jkVWnsnttGfyfVM2J8Rz4ZuC9GevA5QZGzwIFiZdO52F3gToEHTsgEboPx31ZQzzr9ptOnCE8Lq9+sc2NRmOM6mz3z9vNKnPKJReuBuDzm6VWgWecAyrMBpHn8rb9knlz/7FGZb5BeLvICOiBMTqs8pHno8XwRMr+OzoubhCZA9S/JqY8VD6Ux1KyU+yVgdR3DwUKnFoZcZToHsHBO2+B01jcFxwPyo5shoyqcIeOVe+GTd3PLgj
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0176;20:zAhHpLpp1+1D381N7ssPPgWzIs8BEO6SCFNCo5JxN4aoXD92Qs/8qC+5JNGIcBWurzSsYK+HmLOIBmrR/TYmv+OOCdZvmxJKowzpadJntkTzqPFgj9Db4rhMOLYgcglzyZHLZqniYMspkPF9OtrfcJHLmjQ+l56hBDDv9cFsem8=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2018 19:05:51.3286 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c3b160c-bdf8-4e73-9172-08d606cff2d0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR15MB0176
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-20_05:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 19, 2018 at 04:26:50PM -0700, David Rientjes wrote:
> Roman, have you had time to go through this?

Hm, I thought we've finished this part of discussion, no?
Anyway, let me repeat my position: I don't like the interface
you've proposed in that follow-up patchset, and I explained why.
If you've a new proposal, please, rebase it to the current
mm tree, and we can discuss it separately.
Alternatively, we can discuss the interface first (without
the implementation), but, please, make a new thread with a
fresh description of a proposed interface.

Thanks!

> 
> 
> On Tue, 7 Aug 2018, David Rientjes wrote:
> 
> > On Mon, 6 Aug 2018, Roman Gushchin wrote:
> > 
> > > > In a cgroup-aware oom killer world, yes, we need the ability to specify 
> > > > that the usage of the entire subtree should be compared as a single 
> > > > entity with other cgroups.  That is necessary for user subtrees but may 
> > > > not be necessary for top-level cgroups depending on how you structure your 
> > > > unified cgroup hierarchy.  So it needs to be configurable, as you suggest, 
> > > > and you are correct it can be different than oom.group.
> > > > 
> > > > That's not the only thing we need though, as I'm sure you were expecting 
> > > > me to say :)
> > > > 
> > > > We need the ability to preserve existing behavior, i.e. process based and 
> > > > not cgroup aware, for subtrees so that our users who have clear 
> > > > expectations and tune their oom_score_adj accordingly based on how the oom 
> > > > killer has always chosen processes for oom kill do not suddenly regress.
> > > 
> > > Isn't the combination of oom.group=0 and oom.evaluate_together=1 describing
> > > this case? This basically means that if memcg is selected as target,
> > > the process inside will be selected using traditional per-process approach.
> > > 
> > 
> > No, that would overload the policy and mechanism.  We want the ability to 
> > consider user-controlled subtrees as a single entity for comparison with 
> > other user subtrees to select which subtree to target.  This does not 
> > imply that users want their entire subtree oom killed.
> > 
> > > > So we need to define the policy for a subtree that is oom, and I suggest 
> > > > we do that as a characteristic of the cgroup that is oom ("process" vs 
> > > > "cgroup", and process would be the default to preserve what currently 
> > > > happens in a user subtree).
> > > 
> > > I'm not entirely convinced here.
> > > I do agree, that some sub-tree may have a well tuned oom_score_adj,
> > > and it's preferable to keep the current behavior.
> > > 
> > > At the same time I don't like the idea to look at the policy of the OOMing
> > > cgroup. Why exceeding of one limit should be handled different to exceeding
> > > of another? This seems to be a property of workload, not a limit.
> > > 
> > 
> > The limit is the property of the mem cgroup, so it's logical that the 
> > policy when reaching that limit is a property of the same mem cgroup.
> > Using the user-controlled subtree example, if we have /david and /roman, 
> > we can define our own policies on oom, we are not restricted to cgroup 
> > aware selection on the entire hierarchy.  /david/oom.policy can be 
> > "process" so that I haven't regressed with earlier kernels, and 
> > /roman/oom.policy can be "cgroup" to target the largest cgroup in your 
> > subtree.
> > 
> > Something needs to be oom killed when a mem cgroup at any level in the 
> > hierarchy is reached and reclaim has failed.  What to do when that limit 
> > is reached is a property of that cgroup.
> > 
> > > > Now, as users who rely on process selection are well aware, we have 
> > > > oom_score_adj to influence the decision of which process to oom kill.  If 
> > > > our oom subtree is cgroup aware, we should have the ability to likewise 
> > > > influence that decision.  For example, we have high priority applications 
> > > > that run at the top-level that use a lot of memory and strictly oom 
> > > > killing them in all scenarios because they use a lot of memory isn't 
> > > > appropriate.  We need to be able to adjust the comparison of a cgroup (or 
> > > > subtree) when compared to other cgroups.
> > > > 
> > > > I've also suggested, but did not implement in my patchset because I was 
> > > > trying to define the API and find common ground first, that we have a need 
> > > > for priority based selection.  In other words, define the priority of a 
> > > > subtree regardless of cgroup usage.
> > > > 
> > > > So with these four things, we have
> > > > 
> > > >  - an "oom.policy" tunable to define "cgroup" or "process" for that 
> > > >    subtree (and plans for "priority" in the future),
> > > > 
> > > >  - your "oom.evaluate_as_group" tunable to account the usage of the
> > > >    subtree as the cgroup's own usage for comparison with others,
> > > > 
> > > >  - an "oom.adj" to adjust the usage of the cgroup (local or subtree)
> > > >    to protect important applications and bias against unimportant
> > > >    applications.
> > > > 
> > > > This adds several tunables, which I didn't like, so I tried to overload 
> > > > oom.policy and oom.evaluate_as_group.  When I referred to separating out 
> > > > the subtree usage accounting into a separate tunable, that is what I have 
> > > > referenced above.
> > > 
> > > IMO, merging multiple tunables into one doesn't make it saner.
> > > The real question how to make a reasonable interface with fever tunables.
> > > 
> > > The reason behind introducing all these knobs is to provide
> > > a generic solution to define OOM handling rules, but then the
> > > question raises if the kernel is the best place for it.
> > > 
> > > I really doubt that an interface with so many knobs has any chances
> > > to be merged.
> > > 
> > 
> > This is why I attempted to overload oom.policy and oom.evaluate_as_group: 
> > I could not think of a reasonable usecase where a subtree would be used to 
> > account for cgroup usage but not use a cgroup aware policy itself.  You've 
> > objected to that, where memory.oom_policy == "tree" implied cgroup 
> > awareness in my patchset, so I've separated that out.
> > 
> > > IMO, there should be a compromise between the simplicity (basically,
> > > the number of tunables and possible values) and functionality
> > > of the interface. You nacked my previous version, and unfortunately
> > > I don't have anything better so far.
> > > 
> > 
> > If you do not agree with the overloading and have a preference for single 
> > value tunables, then all three tunables are needed.  This functionality 
> > could be represented as two or one tunable if they are not single value, 
> > but from the oom.group discussion you preferred single values.
> > 
> > I assume you'd also object to adding and removing files based on 
> > oom.policy since oom.evaluate_as_group and oom.adj is only needed for 
> > oom.policy of "cgroup" or "priority", and they do not need to exist for 
> > the default oom.policy of "process".
> > 
