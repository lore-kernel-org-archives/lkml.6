Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA42ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 17:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91C262089B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 17:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="GgZdTT/0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91C262089B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729350AbeGPSUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 14:20:38 -0400
Received: from mail-db5eur01on0109.outbound.protection.outlook.com ([104.47.2.109]:33184
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727479AbeGPSUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 14:20:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i92DikvOx0zh2QpFUmCSbMmCnKmBqaSbStkmm/KF/yY=;
 b=GgZdTT/0plPEwpy6QwV1GWCY4KC12sPBgh1jzdfGvzGNCW+8yXpy4A4tyJqV8xKo3wLaKwP74fZ9zvDLlrdibFXGc6rXapTNHpjB9NjJQAKPv03zOphIhVnQwBfvrIPix+lURKP5C6hG2yrRJNCNIvt8ZsFlvY+1Lk41HKkeMpE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=avagin@virtuozzo.com; 
Received: from outlook.office365.com (4.16.175.162) by
 AM6PR08MB3255.eurprd08.prod.outlook.com (2603:10a6:209:47::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.17; Mon, 16 Jul 2018 17:52:02 +0000
Date:   Mon, 16 Jul 2018 10:51:50 -0700
From:   Andrey Vagin <avagin@virtuozzo.com>
To:     Stefan Baranoff <sbaranoff@gmail.com>
Cc:     Pavel Emelyanov <xemul@virtuozzo.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net,v2] tcp: Fix broken repair socket window probe patch
Message-ID: <20180716175150.GA20960@outlook.office365.com>
References: <1531668997-1439-1-git-send-email-sbaranoff@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <1531668997-1439-1-git-send-email-sbaranoff@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Originating-IP: [4.16.175.162]
X-ClientProxiedBy: DM5PR20CA0016.namprd20.prod.outlook.com
 (2603:10b6:3:93::26) To AM6PR08MB3255.eurprd08.prod.outlook.com
 (2603:10a6:209:47::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2dbe3862-0e5a-45db-038c-08d5eb44d71c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM6PR08MB3255;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3255;3:3SlTPUcNugCsnFaVMuuo6KN6U5vq8QhhFSAaF+sl5FZKx4ZQWvvlI+ufsuoYo+lXYFvgHhfuAyFtBmvoKOXUxYV0mBzGnJ62iGnuf8dwDT0OSHybS0RD7lImvgi/ZBTldcOtPxZzqORJ++1kHb4pB2Q43ZPRj5B4kkFgjEcBzFDcHLnjj5Lc5qEXsS3atGdGuVPD8f2t9DSiOO6b7JWZ95RjodevB6wCcbqdiawC+Vazaae77bfvueco/L7RVunc;25:Jt8QrjrzCZNPAxts0ZlMqs35qohT1GenQ/4dVCvSNOq3d2Lk8Tq7QMiNAesHom+Ee/msN6BKyhVtab82ZnF68k7Dxk0mnQ6TGSfq9sfYCZW/PS0frx+vHNvdMyipHvBItr3c2zDEhKuYHC5xmhvhrdAeW5z0kFAZLlVDXQB62nsRHUDJ2wSk8VA9JWrDBrVo6VzMphusI9znMTuepgTEWIivjcNmy7oRJEavAYSn+3xf0e0GaBpbsleFtwq6JSoyJoJUsmQzgIFLlRBJWCwCTUj0b0APXQ3ulVrsSnaCPyJmINH5k3Le8w9JaENx8LhLc0yfOPvy0DKvO4wB0M3Jxw==;31:zoLu43t0EAOIA3l9K3LjYjTxgtUzmu/6HA1qRoEOBIJcpXf1/oTWEmARasrIhEzgvThJ21P+6o7FnUfDWF6lMj/AGkdtaWqVRfjoCoI2dIt4Kqso/mNN1zdYKiuo1cQ17EzA5RtPkc8QVGpgnNBXFV178b3Ev4ab2z+TqAK3DEwvhFm1Eg3h9HFU7Eu6fAWKEtw1n3GNuhBFZSQoY0z64NavIzqDnu5/1JqqGYixgrc=
X-MS-TrafficTypeDiagnostic: AM6PR08MB3255:
X-LD-Processed: 0bc7f26d-0264-416e-a6fc-8352af79c58f,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3255;20:xZkrq4ZzKqfOxJJA2l2W1Tlbn9kQDkFH6v2QszaOryOGqTJzzsWQMLdmV6nNeeqXKTcA6AboNWZJAggM5wJ5uRXNtvwtONcc6uxeftRlbpnqAzKKaZ2Y6GwshOH7zXzWdIQ2UC1csu/8MdiIGmdYlxCV96/x4jzrg/gSeFQ14Dqik1g8VevhezmmPds6WpSPdB6VEESYEARJsoJk8NGXqgy6GIpDfYru1eNHTXRZrepsFk0dNMilna4YOqcj24gq3+nnsVXODDPO6gcuY6oZ05UrVQalcYxrYjEiMC2zQ2PCX29iR2c6hUuQ2C77KOCJQV43xFB6xwtkQIHzDytB7Y+TTW4yezVGspIbY/Y0z5Q+S/65aEYlppAjvw1m9g3w75GaMqWMADgWSq1Y5q8m5pKkzcKq68/A6V3SQMmVlc8NoAU9PTLnsa7DN6Ac658ts1NfVd/2oiAaD0t3zN4lbDitl6xn/7Bf/pPI/kI0ouaDMd5+/Fp0dwjUick5H7lf;4:cbnJf/Z7dOhxQLg9VrslAophs+0+ZUG88/YBxBOKuqfEocxcKFx/XR2Bjq2XssnKvoO8X861Dfuyq/IPiU157fhYZNpoykINemeOJ5j2BOZ2UGWvnowlFTezTgg+ELZjD6fLXmRW7J9s5bbELo7QMxj0/NI76ILgT2O30XCcJHtK52mdJbqvt4jvr4AJpcXFh1otoQoz0sxFEvTNP2eEGV17O+H6aal1geKPL+MY8byM57w4ysB4o7N1F94XCWF2oKNRz1G2NcEQ3t+NZ9D1oQoIaeAELDbWmBm0sL2FJMXbC+PuwiHTt9EkTo4gMWBy
X-Microsoft-Antispam-PRVS: <AM6PR08MB3255E8879C1607A86CE62BC5CF5D0@AM6PR08MB3255.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:AM6PR08MB3255;BCL:0;PCL:0;RULEID:;SRVR:AM6PR08MB3255;
X-Forefront-PRVS: 073515755F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(136003)(366004)(376002)(396003)(39840400004)(199004)(189003)(229853002)(55016002)(2906002)(33656002)(11346002)(58126008)(186003)(7696005)(52116002)(16526019)(76176011)(476003)(446003)(956004)(7736002)(86362001)(37156001)(316002)(26005)(386003)(1411001)(54906003)(6506007)(486006)(66066001)(4326008)(47776003)(1076002)(6916009)(25786009)(9686003)(5660300001)(53416004)(6246003)(68736007)(305945005)(53936002)(6666003)(81156014)(478600001)(8936002)(69596002)(8676002)(23686003)(50466002)(105586002)(106356001)(39060400002)(81166006)(97736004)(3846002)(16586007)(6116002)(18370500001)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR08MB3255;H:outlook.office365.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?koi8-r?Q?1;AM6PR08MB3255;23:J5d5xpdOATgRlvyjuMzO3Oz8KQmJg7r+PpretDHW62g?=
 =?koi8-r?Q?Z5IWMzSdUQ/QkAsgx14l3GzRM/WMw8nJDhin86oiJtndeFVBlwS4NKquSWQjsf?=
 =?koi8-r?Q?gqBb3CDcX5/jkMZSMpMIZhSx5d0tizd6diF228AEJkOIR0ioG114xleXX3CZ9L?=
 =?koi8-r?Q?ADcmFbHCJ4ZF2Z6IG1DOQM5KVvZTGTCoVwMctHfFo1obXn5ig5enlu1v9prSUP?=
 =?koi8-r?Q?bEpzCWBxnT+qC+JI+/EYhV9CQMhZj9X59SxGUGMpzvh1Sd9OvlE2LOoJ0wEa3k?=
 =?koi8-r?Q?XotD/xHw/DG+gmQQICRxPKJ06AziX0fNNZNCBtTlEta+vu6BKnasX9IzdL4oRg?=
 =?koi8-r?Q?dipuuTHvBItnTNaAlMBj1s5gvpt/Ji2TTVDaeT4in0Xp2LNYMMI6aPJnXDsHMC?=
 =?koi8-r?Q?mTApoalZnFbYLn1Z+UQvbIWCSscUUx/hqscm1s0f5Eui1X3DgU5guOL2QNXG0U?=
 =?koi8-r?Q?lQVrDlQoapkWnRgjno52Wv8UnJdn0xYSdOMuQ95XqGHASMEI6Axu4kswKaM+Kr?=
 =?koi8-r?Q?lRhjeLv2osyyNl0WKn/WcD/AScix76t+mG2DVEpD7spUqWzMPakxUC4F95NRlr?=
 =?koi8-r?Q?BrMK+JLRgyykJaHUz4/2XbU5P2kHNFchVm991NMjdl/ZsIB0C4rBfqR2ztsuLU?=
 =?koi8-r?Q?LKMbaZUpX2v8fchv8ZuIQk6jezJFQx+sRs8FB0nqeP3J+9nh5pTxkbvqGDqj0d?=
 =?koi8-r?Q?5PLzMMBSJChmToWYyVxsl+l12fVlFp+0VeGJuih0ATJeXuR2b1AnTV2CyHlCUm?=
 =?koi8-r?Q?JrKl3JKiGp3trrLh/KC9uzyhjQ6FdExVxci5Q7OKr9er8zVv5STOMYgrcrNRpt?=
 =?koi8-r?Q?Nc/AqiiEnH7lUKWYkQVpf2XOUrA8CY2yUGBhCupkT19IGnd3e1REXe0dEUSX4w?=
 =?koi8-r?Q?AZB4R4tQZwBRZb8KQIG0XL7fd1aRtlksFvfVfMJhNSNdn8eLb/uZ/ksRlSyHGt?=
 =?koi8-r?Q?T63snY3596lvAban9x83b+eI78PxNYU61oY55v14GjxjNnrcD+iFleG727xWp8?=
 =?koi8-r?Q?IMowKs4htl9AGrByLG4gjo79+WRKXEVX/4K4WkSNAM/15D8S7JmZpW7Wo6At4T?=
 =?koi8-r?Q?KDwooVRLIBP3Hs8iLgU4R4zOMmEEVpXDsQBoRCGKc0R0X5O5LIOEcrIkEUTEk8?=
 =?koi8-r?Q?SoOTE/1Aam/ndN2ctiUCPElG/LTzhWNxFpcL6LAo0cp2jDKfSFtB2wApTgsaab?=
 =?koi8-r?Q?DqduP66IPoiApsnBO2uas/lqkMUk85tB9KZbZ3y9kXzsaYh8APMvEiLLfqAfRY?=
 =?koi8-r?Q?sIDZznl53KF3ZqOw4QEDTNobae5497Eu50qKGCF6deokrSpGeNR3PiXLT8oNrh?=
 =?koi8-r?Q?0NGvczvdJITcpEDpte73m8YAKrZOfuQqHMHVatTIqDXCfwh6b+uiI+j7I4QHf9?=
 =?koi8-r?Q?n?=
X-Microsoft-Antispam-Message-Info: BY+6xQgH/Ct1q0FA8Udyu8IqMoyBSKNvyunRSuexhPLZgCahVmUV7sbHV2fOv3TljiFi9fXQ+OwdjdOLU0RSL4TnqcDHwNFt0BIyN4Z+C0FAcTeB3rga0xSVFuv2H1JJlcL357/9TIc+U38+mlr5ECwwosOUhM06Ip2CqSEQtDLjctrfLA0I3HfNuLd/CsFcNr0CMMY/shTrvShvdNyBDv/ZeIxV3R0fBTdnP7XvKo9NZJ3sVsRgrlMIGTva3Pjdt6ksMQZNpNrBK5cMaIwy1sRhl4f0GvWmWGbqC+VEpjwOthfWqSq972gz/9YjeprcsybyoPntGsZtaULaOI1VkPi5t2pquE6cHK0efmEbIU0=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3255;6:nad4X/Es/p2Kv6cdX0HtpPWSUTf03/66MRn/dHnyMbs8GQx9c/panGIXRb8YgNnSrQscF/fRcweiyBwVzJZqZ8l4qwYarnN90G5jGcPc+89svp5Z1R0PJSrcgQpEfzPImBq5j4XcbDRrX1sTXMrR2Y0jBo1b31+jq3gnMii0ZvQ++gkBjROyX6g8ztatU2u6CPZ7JVP2STRQnfLbxJ7KvnQ2EVTNT31vCbKTQW5RcSTGFE6dxnsWjKZ7A16NPCYFuelfgiCjJmDf197JE4ZZzbcyIEHGcSRt4sg5Aa33yEcPb6LvduW5AWqh8PvLr09bXqTQay1yRaN5h8DcdhdWXfXjcUJEMmTPPkVA0kTp7Sxq3th4CMdXLHTWx+FDLcoo36vR7YGoQEhHUVYDSde8eMQSGOpF8MAWivn5uLLQYHiIyK4It8rlLA4kGD4RdzoAEnJpnN+I8oHWobu6dfaCQA==;5:4uXfo9wBSAFrs5IJyMX+a1YkTETWSdokn+bNxpWxbyxHcWcuBXSeutJMM6kkNCmKxvxbVfQSAWd5dbeXp4HT70OyhBVX0kZmkV4N32Azd8z5LxtA9HEqSMYUlwot67zs/8hmMA/WIbnQPBeBpOji9Wmquj4r2Blub9hVa3jK5WM=;24:FryQ1Ts9RgAIECfSqfxq2+o0PAOn+xE3rJ3vKE2HT918QVmFEy2/j5SLtMzh67WJ6+Y+7Fh6E4RbTnukdEgr/a45OESL2++6ZOCoZ1TLRUc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3255;7:WXgLBPgA+5V4gIlAzLenY+hpCEDxDtxlnAoYUhEdYrNF9LPaX+BxqOZ7uXj7PkMsJQxGPM7TeQl2psH9G5PElSe+yJ3NLdo+Z1S030Mu5/JZCT6//nQ2iseWSBxpbwmACDwY0H2VO8cN/PwtxGHGgR150WrZw4jSsTqsur0xlY5aA0GcRvmGvv4kL/AsjJ+zbgY1p7p8ZaiSJJNW5hJBxCDyOXqFf85lrIhUDz9uGtByR+24akGAxyQf37FSDzVH;20:u/7cp1143IGjkMWG4/2PeJaUZCyZbkUCYssMB1JA0ftqMDeRsyQIAgelENQNHcCuEK2xeda1mL/2Se5IqdATfk2ooSL6bwxvsg+hbdWP33tsIHXzO5N6LJk/p8wOgrmiBOz/9AupO2jl5D484pSYpTpBwYm0NPVfERcOKegL/b8=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2018 17:52:02.5242 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dbe3862-0e5a-45db-038c-08d5eb44d71c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3255
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 15, 2018 at 11:36:37AM -0400, Stefan Baranoff wrote:
> Correct previous bad attempt at allowing sockets to come out of TCP
> repair without sending window probes. To avoid changing size of
> the repair variable in struct tcp_sock, this lets the decision for
> sending probes or not to be made when coming out of repair by
> introducing two ways to turn it off.
> 
> v2:
> * Remove erroneous comment; defines now make behavior clear
> 
> Fixes: 70b7ff130224 ("tcp: allow user to create repair socket without window probes")
> Signed-off-by: Stefan Baranoff <sbaranoff@gmail.com>

Acked-by: Andrei Vagin <avagin@virtuozzo.com>

> ---
>  include/uapi/linux/tcp.h |  4 ++++
>  net/ipv4/tcp.c           | 13 +++++++------
>  2 files changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/include/uapi/linux/tcp.h b/include/uapi/linux/tcp.h
> index 29eb659..e3f6ed8 100644
> --- a/include/uapi/linux/tcp.h
> +++ b/include/uapi/linux/tcp.h
> @@ -127,6 +127,10 @@ enum {
>  
>  #define TCP_CM_INQ		TCP_INQ
>  
> +#define TCP_REPAIR_ON		1
> +#define TCP_REPAIR_OFF		0
> +#define TCP_REPAIR_OFF_NO_WP	-1	/* Turn off without window probes */
> +
>  struct tcp_repair_opt {
>  	__u32	opt_code;
>  	__u32	opt_val;
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 8e5e2ca..ec2186e 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -2823,16 +2823,17 @@ static int do_tcp_setsockopt(struct sock *sk, int level,
>  	case TCP_REPAIR:
>  		if (!tcp_can_repair_sock(sk))
>  			err = -EPERM;
> -		/* 1 for normal repair, 2 for no window probes */
> -		else if (val == 1 || val == 2) {
> -			tp->repair = val;
> +		else if (val == TCP_REPAIR_ON) {
> +			tp->repair = 1;
>  			sk->sk_reuse = SK_FORCE_REUSE;
>  			tp->repair_queue = TCP_NO_QUEUE;
> -		} else if (val == 0) {
> +		} else if (val == TCP_REPAIR_OFF) {
> +			tp->repair = 0;
> +			sk->sk_reuse = SK_NO_REUSE;
> +			tcp_send_window_probe(sk);
> +		} else if (val == TCP_REPAIR_OFF_NO_WP) {
>  			tp->repair = 0;
>  			sk->sk_reuse = SK_NO_REUSE;
> -			if (tp->repair == 1)
> -				tcp_send_window_probe(sk);
>  		} else
>  			err = -EINVAL;
>  
> -- 
> 1.8.3.1
> 
