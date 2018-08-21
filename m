Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FDD0C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 21:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93B6E217DF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 21:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="U7aLtQsn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="eMFHJA2P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93B6E217DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbeHVAh2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 20:37:28 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:34818 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726788AbeHVAh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 20:37:27 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7LLD6iJ018017;
        Tue, 21 Aug 2018 14:15:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=oGdKo5I01ekMYjbUPJcFqjEHzojjnSraSHGyDTXcqP4=;
 b=U7aLtQsngTQNadH83jqF6Zg8iL35QkNqfz5Sy2xoxjmQoDVgm+G648aync8bYB60Jhlc
 LK8cAAZyqWrLZpd9KZDPakeq57LPlbEoSILXeGigPfbMYfBqBRxamG9B4CKsq2l5i7hf
 unKK58wNTDWnJTSD+DLerKZuVjLxNNB4AHM= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2m0ss9r4a9-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 21 Aug 2018 14:15:35 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.33) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Tue, 21 Aug 2018 17:15:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oGdKo5I01ekMYjbUPJcFqjEHzojjnSraSHGyDTXcqP4=;
 b=eMFHJA2PJM3goh5SwY0SWOmXrjZIAOLXJevoXLJh9w1rHRBPB7bl9xfSm1/bLfjU5uXzviNIrlDWTS2aH7Cpmoz73cfTILFW6iZ/ovzNpDFsh1ZanZvdUjimyvBF078iPoMxMVUKE7A9ECAGDndhBt2mJin2xFLVV7aopBbbHks=
Received: from doronrk-mbp.dhcp.thefacebook.com (2620:10d:c090:200::4:3df0) by
 SN1PR15MB0479.namprd15.prod.outlook.com (2a01:111:e400:c422::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1038.23; Tue, 21 Aug
 2018 21:15:30 +0000
Date:   Tue, 21 Aug 2018 14:15:22 -0700
From:   Doron Roberts-Kedes <doronrk@fb.com>
To:     Dominique Martinet <asmadeus@codewreck.org>
CC:     Tom Herbert <tom@quantonium.net>, Dave Watson <davejwatson@fb.com>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] strparser: remove any offset before parsing messages
Message-ID: <20180821211504.GA76892@doronrk-mbp.dhcp.thefacebook.com>
References: <1533854411-28184-1-git-send-email-asmadeus@codewreck.org>
 <1534855906-22870-1-git-send-email-asmadeus@codewreck.org>
 <20180821145321.GA44710@doronrk-mbp>
 <20180821193655.GA15354@nautica>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180821193655.GA15354@nautica>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [2620:10d:c090:200::4:3df0]
X-ClientProxiedBy: MWHPR04CA0108.namprd04.prod.outlook.com
 (2603:10b6:301:3a::49) To SN1PR15MB0479.namprd15.prod.outlook.com
 (2a01:111:e400:c422::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bfb57bae-b13e-4536-94ee-08d607ab39e3
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:SN1PR15MB0479;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0479;3:djIyY6mqSJ4XphuYgmgwfNHGQvjqwY+60kn4unUA3grhRYpH8N64QL8XUrJHqPopApQKMGnb+HsQaprGlq2VgVvboyZ9eVxLNly3N4PY5Rq3nKIKSSDsh+K5S91HxyogDUTC89Ru+DOzFxBjPBL1bBcUeYi8749RdTMUX3zayk9Bt93KxQ1UBGMRnedpH9wCteyuWS/FkxgNbkALE3EuxHiJInHHLqIFYX0kstPW/SCYTePIjPcIqkPkp272t32A;25:Gy7xNhilJ59G2YdPijgKyQ/G2N/zTOQNSOu2WVws4/YdrUkrCCN6p+9PGFisIjOAkbJWKW4PmY3crMnHlLKuSFMfTYOZP+rN4Xr9/Blc7ssP6Qadbg+uUto7rBfxHTHO6Ir0DK4uhdhRl1P7AXltfhAClZ0kfYpZ9X4wB4n3KDUPz1f6zE6bQX1AUCGmPtXr/T+CakOXgJsaTdapD3ZB2MGKlil47aovc0yfXXN7eOhSQvzotAM876R3vGVCpQze/YuU1cqW/u78kHy9LNsos94lLEsojRwxZ+IYh8IqKuGlcoiPMR41TY9htof1QeeSrqdUi+i8/YD7vs84WXgtvg==;31:MeSNFgRGhdvumrI9beQV+i0f6AzH4xdNuhYL/9zvY+Lf1F8ax/xy1BzSZA8/BvAvPgLEIQtJtUsjipGtjgzq7HxGvgRmEgloQm7DNkI5dtwkznjx7BEZmmyYOngDJpCFN2IJmcfZ2kwriY6qpW6AoGtAmBg2H5pubNM3j1cdO/WPsV4BtPhehVCvd9g6rEJmIC4rS9fl55ioL6lKbRhEvkerGT5ym+KpXmbpnh5gUEo=
X-MS-TrafficTypeDiagnostic: SN1PR15MB0479:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0479;20:DgH5u9uHexNj7/I8x8mZfTvZDisBK/ZGUEss60iq1m6w7W9EXYkBpUAz54lUGtyfEKVPtcrwJjUypgCh2zeUOFm+RFTnve8cd4hMyLne08ffmR8DDbMprfDgni8I7hThsjGELikrMuCk9MG1hPVW8g4kj+UTbAijzhWfY1Qi6choqRO4DmM3VFCAtrBKTNmPP7EvlCRSYTqVNM/U4mXjDq1aStRxICMdTbvPvg5l1d5e2amwy5bGUYdVbZ17JDDJytSTXWlveQMX1bLoAY1a0iFpsS9qifnuxt6coA9BC5TpFfpzqaiGkEGcaogOH9rQDyL95fo8oZ3gtHgvg5cjUnfyll2RrmkhlRfKo+U1l9f+OoSbHCQ2IFN/4F/xqRfKQBR75llYusQfAk3NISbSk4xfOLhwn0u25ca40FhpZV1rc3xrJExHaAqEf2fe9pBcqBgJoEFuP2V+TCubFYcAUUBy9xNWUMWXO732hcr9UAfLviI3VzK/32aKvC9ER92D;4:zUdYqG/mOMagHNbPqhlfKajUKs/iMEqFJHpfg2Rn1iYWvA71wyGEIgBoXTBu/5Tcf6XBhda6gBneFv8uSONYCTXdRJgMgC+dUQtEmanMjdw08d96Sld/+WHXamTwiatNBuA2OPLG9a2MII6m1wVMfqW2ambz81L49sSHt9EfSLhbfzZpkVc3bUFix9nEUlEvWxEao9Au1ab2j8PTx728hH0BrYlAzfzzqUm3mj4pb5YiOdBlsA2qQDeB11RxUiEhtVgS3iUUKNvcfQUAzM/8cQ==
X-Microsoft-Antispam-PRVS: <SN1PR15MB047991688EE9233B447888B5D0310@SN1PR15MB0479.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(11241501184)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201708071742011)(7699016);SRVR:SN1PR15MB0479;BCL:0;PCL:0;RULEID:;SRVR:SN1PR15MB0479;
X-Forefront-PRVS: 0771670921
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(136003)(366004)(39860400002)(199004)(189003)(6666003)(6246003)(8936002)(5660300001)(68736007)(33656002)(97736004)(4326008)(25786009)(6916009)(47776003)(106356001)(50466002)(105586002)(81166006)(7696005)(93886005)(46003)(52396003)(229853002)(52116002)(16586007)(316002)(58126008)(476003)(8676002)(53936002)(11346002)(81156014)(386003)(966005)(54906003)(305945005)(23726003)(55016002)(6306002)(1076002)(486006)(186003)(76176011)(6506007)(16526019)(7736002)(9686003)(478600001)(86362001)(6116002)(2906002)(446003)(18370500001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR15MB0479;H:doronrk-mbp.dhcp.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR15MB0479;23:EZSDQxi9SNPL9fg5BCd4XwL2z9NEqqxCwxzQeThWs?=
 =?us-ascii?Q?Mxxe0AF/sneOTeRGG4MXuDoXwo+dZQbd4Cb704ZVmtOCZeK1fYFNdx4Drq02?=
 =?us-ascii?Q?qjN7vbYlan8NMfIaD6r/c/eWpzCd8xAbE3LT+O5WBPdDhA1Kb1/mbw5qO2Ht?=
 =?us-ascii?Q?Xt+tnnE45PGhoha+rd4S5EjKWhZG37xbTmXmvFa1nDsQEpqdpLZi97wdF7SE?=
 =?us-ascii?Q?6LPrFrzb2USEDB7+1TVxD3FeJ6lTScClNKwVZ73tjdyz3UwLbxgYaNCSnaGK?=
 =?us-ascii?Q?B8ckf+h5vLkfXVzcAnfARqx6Jt4dcqBWCLwqkBL+g+IIPk51hX4E59ldlrNs?=
 =?us-ascii?Q?ugj08qLGFYL5In1QIjXw43N95WTkyrhc/bP2esdahPVFXqOuKgflh/uM+lVd?=
 =?us-ascii?Q?RXvnxCSq5QJLl7fcKSBDH4R57iAyMXA18MQa7FDstxNKFVs42g/i0VvzNnlW?=
 =?us-ascii?Q?dK1YC1wBoZColM2cpHElr+O2Spr0JwHGUXB2tF5EFL9+KO/nXKsov0symhCZ?=
 =?us-ascii?Q?FlMaICRst8u0zbljXwmZe5UxD6YXhA0xhVeIx9pyOQ1HtIfBIYxOpv2UHgGD?=
 =?us-ascii?Q?8GXQRzAyN8ul5tL+WT3x5c2oytBw5ROBrQKq/xzlp4QLYxpuEocJPvAcIEhh?=
 =?us-ascii?Q?t00lkddpeG3c9AFKICkh849eOIdwTH2nfnbcVwPANlnpWj7a+ykTqRuugFxa?=
 =?us-ascii?Q?/NA02hpFjPOmXSdHmiwRXv9u/tswMCrYYJ7FN56Lw9OLo5BwfdHdrm1Zjf+R?=
 =?us-ascii?Q?ksCFLn4uhoy0xYILPixcpPQeKMnb7Uw83ZfdRamu6x3Mp4BG2JQt0Sm/0j9+?=
 =?us-ascii?Q?Mrrk5GuGwE6Pn15ovXiL9kjP4deTW11nxD68tZyFpgRp/ekgJhIWiAO5QrL7?=
 =?us-ascii?Q?YWEBkI4oJHJ30boU6Pgu0qMagOmyAM10HiXZ01TsI7RVr8vqmmkrtn9Na8nD?=
 =?us-ascii?Q?HdqUR24mBFpeEUrkk/CIMBnr1+j0F6u+5vDEsdTyRk2+xJ7BZ3lo3MO8UEys?=
 =?us-ascii?Q?51eDc9ImIppBO179NKdKd395rWD8gWG7DgT6Icb4ix+Lyb2zc9OCFZtBPvCM?=
 =?us-ascii?Q?2vSk6FWSd+X+ruN3rzof38CaP/Sz8lopklo6YIvj+Xln8kP9xrdKOkZxHurU?=
 =?us-ascii?Q?7XSBWqsQsZ3LWV5Mk8ES2tmCU9ZPM36s++WO63TTtFxhYyhnFJe8hWmZboZq?=
 =?us-ascii?Q?RrawamOe1ckPYSOerl+exTQaEa1vjZxTBn+DJ6GfL0Gf/6LYPCbbjbhQmmXR?=
 =?us-ascii?Q?+dT5kPQ1kLZ1I9+q8IFLlTYkXMYiP/coyaKlrOQ?=
X-Microsoft-Antispam-Message-Info: aYGdHE4Wksbr7UoUwhKfND7m+6eY+Mw85TdXdjdFaLaou6HgTtKD316n8JPZg6DJwOi8iGkpqQAle8bOeRzcfYtYjS1pAajC86kA1OP6PjSOjj6DsVuElYQ7sE2lKmDysw8WWBlQtBHSWUGLB8mGGmrdzFsmMt7F5YlGDolaG6loFu1ZByshhP2ad6vYohtNV86rsLf9DiD59WR82jkmdePFoZTqWRWdxxb5cgUeofmgBkYfaGw8bFDim4h6gqONmS+cCK4bNeR0Vm/CIatzk+9cap+PL48FX8K/g/lDGTyKKhf2AXV8iCfUXOvS14dc859Qy9IBcU2Ptf2FPxfzOmIDoeag2r4CBTFLBA8bQhM=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0479;6:yiLgUK8fcmmYynzIMUu/dI9DhDT3+D2CgINF9kRqgLIbHCQ+nu9lgzenf0lJZoo6/41l+2yx2/dR88yyH9luJKNbJ6w/J7CHB8yY7y60VsSJ/f3+dsjGqQIIRjO/hsBvbsK3ofeSPAq3mkwDA+HkpxEqr9kXG4GArQGNjpKHEh8iQy1i0eIQOY+lVf5pxH/Lxu/XfFs+e+8CT7XmtwQrguX4a0MBOpUOHLeSo522ZW2tTWBxvPa0V8P0P+3VylURCwsPABcC5idW2o1b4wff7tPrfkEsddEVftEypArD0OvIhBVuxvMY/iskD04sTujS7Y2HQH06JLKZCprjpTtSTYXPAISg80BtWP0oaxAI+PFMi33bIaeS1QnUg8g98LecpvbruDNKrwJpgLPSxhNi3uhJbsz8glYrAVffPFvS04x9QfL25xhLZ4E9BDEdmIgywtyO9yC4GfwcGtQzXoc+Cw==;5:3/rhXLd7ydB3uqbO1jB0o4Zp1eIUE6yyv1GjxCWROlDvRe1HDLDzggiwLHoPMydBTf/2NVCIwbxi4dcQ4B0WtfynAzDxPKoCP0VTkJYEWwgo2MNEy/Il7a10uJYyiF94KIRjPuI8R/EGNHDN8LOqwEL+lVkNb40jOVkJsE/N/Ds=;7:MoIgALdxS+un9WpOVmDi+XkHBmaGcCNMPO+e9YMSuwXDTlg+8vtY7YRmo6a7h79LiH/ttK/xT8n6xlDpYykWfvD2bQNqC1q6WnU7+VuX+eA+CWsGPRLqGuLrrjml6oWSRnmYKFmEd+wBsNO+TntityzMuwZmCqPoFiSTf6dIXs+L4rSRtxa1Izr1I2kcLbZQR0lefyueQPFYUvJZgR7RPcZzSolahKwSqQhLqTI5o8lv14lhgk7d80qBbPkBnKAo
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR15MB0479;20:EvFMAA+kuuNqoU/Buyh9U72/NmiukFVcTgxve0MTqirWEV34wIMDt05he6PaM6+SZDoVJA8tckwq68FhhXKUpcjcii3p1KT62TnKnKTBB+g6j/ma6kcB1JrbzTos0yaI1tGg9sME4Ghlx883U7TOTvf+pVvqQ9YZjPih8sxQLHM=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2018 21:15:30.5584 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfb57bae-b13e-4536-94ee-08d607ab39e3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR15MB0479
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-21_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 09:36:55PM +0200, Dominique Martinet wrote:

> One of the solutions I had suggested was adding a flag at strparser
> setup time to only do that pull for users which cannot handle offset,
> but nobody seemed interested two weeks ago. I can still do that.

This seems overly complicated. 

> That's still suboptimal, but I don't have any better idea.
> To properly fix the users, I'd really need help with how bpf works to
> even know if passing an offset would be possible in the first place, as
> I do not see how at this time.

Thanks for clarifying Dominique.
It seems like we mainly agree that the proposed patch is suboptimal for
existing clients of the library that use offset correctly (tls). 

It also seems like you've identified that the proper fix is in bpf. 
Regrettably, I cannot help you understand how bpf works because I'm not
familiar with that code. 

As an aside, I would recommend reaching the netdev FAQ page:
https://www.kernel.org/doc/Documentation/networking/netdev-FAQ.txt

It contains helpful hints about how to format email subjects (specifying
net vs. net-next) and determining when trees are closed (currently
closed). 
