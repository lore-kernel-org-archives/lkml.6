Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E569ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 21:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B392720856
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 21:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="FK8VLOWZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B392720856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730798AbeGSWAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 18:00:50 -0400
Received: from mail-sn1nam02on0132.outbound.protection.outlook.com ([104.47.36.132]:51805
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727769AbeGSWAt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 18:00:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7cQqMKFfy9TEGpiDz16vsLEUvZVXOdOehJ+jL13GfBM=;
 b=FK8VLOWZxzfnjXUPdJFfTCkXDz/wqEG90bGRuadcpIgcbZgT2t4rTAE1PZJKFfKgoQ8mmAKaWjW09DQRP/sSZXZhc4CCSujHx2kVlsc89Mo0DJ++NMkjYvOb3NfWsAHBpBsvZUUt1l/Qpl9OhKAv9cLq7JjHa3nFZTwKeKerip0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 DM6PR08MB4939.namprd08.prod.outlook.com (2603:10b6:5:4b::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.19; Thu, 19 Jul 2018 21:15:51 +0000
Date:   Thu, 19 Jul 2018 14:15:47 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        stable <stable@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MIPS: Change definition of cpu_relax() for Loongson-3
Message-ID: <20180719211547.7hlkkljnmtbdubot@pburton-laptop>
References: <1531467477-9952-1-git-send-email-chenhc@lemote.com>
 <20180717175232.ea7pi2bqswnzmznc@pburton-laptop>
 <CAAhV-H5_==ZdKTOJTNXkRBTqmr5cxFvcaVabfNarEiQt_LvHZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhV-H5_==ZdKTOJTNXkRBTqmr5cxFvcaVabfNarEiQt_LvHZQ@mail.gmail.com>
User-Agent: NeoMutt/20180622
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: MWHPR19CA0061.namprd19.prod.outlook.com
 (2603:10b6:300:94::23) To DM6PR08MB4939.namprd08.prod.outlook.com
 (2603:10b6:5:4b::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71139d57-24d3-45c1-c0be-08d5edbcce36
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(5600067)(711020)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:DM6PR08MB4939;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4939;3:tLMYxoIhNdTatUBO6masyCANIE9YnSWkiLufZaMfKikekk+H68oUcGQmclCSxJolCRXpKc6iOYKXU1NWHP8g7kNtGK/7RWnM6lz+2mNi3bNB8CTVQhmMKn8yJ7LmNhszQqmVgDbATH0H/RquFKjGfZDkelbl3y691+ZP7ajIZ6FIpn1/IKM2Gbo/WFRzqYkq3H+vLS5UWkO6RltcGBGvCLLeEjuVt3nHjlitG1vgLo3ZjSKeGyvcTtDZvDHpoPYE;25:b2Y7VPAsxl/d9nFjVo8jovfosHEWK/vbQNMAmJ/0eEKRjmRpwuYmB53Ja/Vk3tCcNgCX8l450g57xI3b6w4YUqXuJaCKyamdODT9hL0lwiXr/ra42g1Qe94MH4w1AZEHO9a5WIKHEO3OLfWhktg7V1kJuzZ8JK2DVJq7IBVsH5nzA/YXOawvx84gLpz77K76Ctff2trNFErC51nxjgAGt2KdO6HtpIqE7ZHBMMxE9uzPlrDVySrqZQLXWv0XXfEfo/xJ7JBOXyMHjvoOlI3IdtRoMOFnN8iSFXNJgT+SCeUL4p4ta54XRvM0c0voyZhjDcjMKynK+BdQ9YQNh5bRVQ==;31:H0Nti6Q/tkjK/4JW9T7ddHHyiiqjmwY7ke+8BrhBP2979+YAe18veSUY0ajJxr1feVv9PujGJcCHz9gGB/ppW2E1XjuNy3obtEJBBm3O+fZIkh1DFQaKpQufWKxMbGUuOk8qxJh/6w7cmnLxUk6gnmb4ZxFdOh+kztrnR6hhhuVN220Wga3QIGRSZqWB2K3LpJJSfexFzxcrAt1HmixOOk6z9B+yV6PlL7AHlMn6V5o=
X-MS-TrafficTypeDiagnostic: DM6PR08MB4939:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4939;20:o4D+HwZ135d+quCKkFDRVnnhvROld8CTF4I2ErdeoBpg736eRfCQHybB3iBj8l4yxiSWtW7QngiXI++SB29cJHIlaTaM+/C+6xBBA87IgHAUX73c5ftq44pfoxbY84UTNI3KdClWGl6nEb3k4egm5/lykqd92fxAhOBLLhxARd7f+uVkBjs9+lA8FO6hKCscZP+5NatDPVD8w85USsWeh4j0MC0X921wUZfKguatEPj78//ZyaDxrLkP/XalQibC;4:UpteYClc0i+RLeWTpC3Sk/TeNoQenfWQp8zj+h6eO2/fS27d0qfTKg28yRR+jZSzS4fCtpchOOV9WeEEDlkInTNXvr5WVUhfljSBgsIbMPfQ3iE2bvifrGMlGyfmpdAG9Hkcb/5aGU0gmRydCUadCl77sX0608FxayDgxoJavRy5aMP0aKUweZdDKRgHKkVb2SEFbb4hReyyI//FaoKDFaxJSgfYQtHRV9VEOmTnAzJgzF8LqWiv4BeI1lZeeKFiD4n7cLuFSdkv+qSDtu3WYw==
X-Microsoft-Antispam-PRVS: <DM6PR08MB4939FE33FBE52B4E6B034AF8C1520@DM6PR08MB4939.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(10201501046)(3231311)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(2016111802025)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6043046)(6072148)(201708071742011)(7699016);SRVR:DM6PR08MB4939;BCL:0;PCL:0;RULEID:;SRVR:DM6PR08MB4939;
X-Forefront-PRVS: 0738AF4208
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(366004)(396003)(136003)(376002)(346002)(39840400004)(199004)(189003)(956004)(54906003)(97736004)(47776003)(50466002)(33716001)(478600001)(6666003)(9686003)(6486002)(16586007)(66066001)(486006)(6916009)(8676002)(44832011)(14444005)(316002)(2906002)(476003)(11346002)(229853002)(58126008)(23726003)(6116002)(76176011)(386003)(53936002)(16526019)(4326008)(186003)(39060400002)(6496006)(26005)(25786009)(33896004)(1076002)(42882007)(5660300001)(68736007)(7736002)(76506005)(81156014)(446003)(52116002)(7416002)(105586002)(305945005)(106356001)(8936002)(6246003)(81166006)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR08MB4939;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR08MB4939;23:YnAmzD0kS0IEwlq2xjpEPEO8A7G04SvlQkMYyzwr+?=
 =?us-ascii?Q?1jmUNgavsfiTe3d+gdJyy9fKzWD0AQRIvOnfVzYnTV3U9ygPMMhSa+aE2QhA?=
 =?us-ascii?Q?v7VIbkSdeXAWisma0VR7x+1PLyPxG5Jd5WRQ8kxys+PGeF6Rl+bs9HWkzEt+?=
 =?us-ascii?Q?Hjc++6FoDxax7Y+miImhXEDk05HMgLohLZ+C7kjRn/TBTsu08MESa7+qs0W0?=
 =?us-ascii?Q?zjqJhBOyVTkmHOAMoh3zzGxeiD2ayPD3xM8UNNRcbYISZDR+sBwC9IKsO82+?=
 =?us-ascii?Q?KsN57QkDQiuhYudXdZHkwDydjRjwGyo6AQItzYU34L4jiyz8ZwQ5T6Ryqx6P?=
 =?us-ascii?Q?phynmCzVTlirDu/UhLwSXn4EsHeZjKEVdvl2Hj/TRxv2xrB/aJaQ2i79UmMY?=
 =?us-ascii?Q?MH1ype5LadLXGZftoSCpX1WpNeF5lhUZUCxRTWbXwKb3OevVhz0NL5cAhdMM?=
 =?us-ascii?Q?8gjCGc3iRTl0HdRbf9RGa1rMCkXc1unVpDqIWioJ01FqVAGVR3Tzl1zcXlhs?=
 =?us-ascii?Q?HgeuKezRKbJthG4c7mFtHdz7qmhhLytv1stpKQ5efV/8YwXPVMA3u6IgD76y?=
 =?us-ascii?Q?LIzt3do2S4lCNBfOLnoPRiYfiwWWLpWFjAMPb3C2RvWNOIVR+n4LbboYTSQ3?=
 =?us-ascii?Q?E8P91tSE+ZHVbnbKyEHFWdYTPIrfY+9NnfKEpbm9TvvYNIZKHpT/qvs7eQ2w?=
 =?us-ascii?Q?LfpEvp+p3m5XHkzxyz2tHIRq9RvHiYCOE1nMhU4NieJ8NNaCnJsIA7xP8OvF?=
 =?us-ascii?Q?2xlO9cs7cT7R5SE1MGI/NbTAB23mMCcPp9R7ZTrIBuzzIEv+tIHhUKtyZPqE?=
 =?us-ascii?Q?cV7Zv289Cta/y5JWOJuR/uez1jVpEuJIdt1jkQAI63y96zjorVXIur9WO5ly?=
 =?us-ascii?Q?6LQtDALYtyLkChvnmSlKqu3tWUTZIJGiRTAU4aymcPFdjjEriz0u0AyqUbN/?=
 =?us-ascii?Q?+ehn/+5FVFDiZZRKPPzvc5UEZumv8fopr9BFXOt8IkMbk23tuPnkc5iTqXYT?=
 =?us-ascii?Q?6xC8bjjcmiGyYvUFBZHQtO+I1llVyIUTu9Yo8FFCZRsJ9RKYuzfrsFYDXHVh?=
 =?us-ascii?Q?XhSYc51sxu9XR9wZzRh99pUJkoPVXx9SSJi+ooOB09WcvubarR/ZrsfVJrJq?=
 =?us-ascii?Q?ZL85izZC6TEPUR2GfOcdkUf7+t/HwckFgajS9xcRLCcI+ZTUITyk9TCB6TiC?=
 =?us-ascii?Q?AunIqF8ISDCpBYdKRcGcFTa97ADu2/fhZLtVMeaIH/ZIFRljGM90g2YwffXk?=
 =?us-ascii?Q?T+JBtJZQ3gKCOwgQw7b/gNjpy4j/D2m7UviTNZK4T8AeCbLVQDQVznzvArMM?=
 =?us-ascii?Q?k0ScK7xBKq8RJoVXI7NRT3tdaOfaN7t7JpulYKtXQu+MgiK3h4TBNbPaTXwp?=
 =?us-ascii?Q?vWByV0I45O3AUFriaeHe8SHOew=3D?=
X-Microsoft-Antispam-Message-Info: NEd4elzlBGCFUAc0OvvRmLGbv/XzCD/BLck8myofxQdLZnvcaZfttZPTTSGvS70PmBSen7oukmLKD00yMW/ZEac/8zuTOpj6sQCFWaeSfH1XcIH/AgnT3XpfWdqSMlU+5nvcM683pjkhWOPmRaBroCv2ikCpcb4gE0HRUSnZa9hoOXCbjAAOLW9x1dcOYrDRXJVQ32L9g/T0Ut54NdKAHLasgWa8pYR7w1++WhePbt2F1AISqx9UoXqlqnLQlrzgT2BjXowQQrak3z4ZJyvyIIBXuW5pAhJhchUg9wNjzqy96r6EHaMBLLC02GAEmugO0S3fh0XAZKkQDlXJTxpnrp6oI6q3/Mqm/JuYvfTOcks=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4939;6:VHXvTEZ9WVRwTqCnw1UL7bLiqYSFaUd9ax1pvk1EO/tB9EMYciDdmPDEEC/K3uLTHWyLVvikxbS6Y19YCdIEyg6O1NXWx8irN2WCMSqpfUV4U7BJe8FX0LIvOfEVg6kSDd/1e6jIfS+LK/W65uPIBwXbzt5EhuC2YRBOKWgdSE/O9bwzURXCxopOgkanQkgo/c/H5oVD2J3UbTnbjPOuWXaGSUMJxhIdQDN5knlvJbm3T2/f09kmQ6d8jt8ZFUcHt1OW9tGgV0lYUvVMYHjJkmFhySsdL8yFvAlzfRrCUjMkODpOgvNF50zQkTC+Sro7sZi4x9vLLcHuXOCey9GKaEztQ+MPuxwy1NqNhGl/5hDpWIAjrpXJNvtKuGjBj3/Dimq+kycPpDYrKOjkUZLdfKtYjWxGHZFYYH6cdwkY43DV+H0Dj3ewz1vRlaw8NkRySasyBnqXWnhHrAk9CZ8jAA==;5:ordcTKltHYMW08cFrADO+uFjJayEB4CnGY4KwkJvFXuQ6DU+ol9pPfnmyPg8D+d4Yvee00Do12jXedr2m1IyYn/e7TilI8+xfvCZnHyHR/Nw0OhubrCK3UCZzsiFw9nSEIRzOKijQAO9C9/Thm32yGIrqMnY5XjwZ1zyx8opfJE=;24:UAcmNQkaZRxjdhRln9x9TMpIKziF45C81KGa3xOi0FKqxkLvLWINFO/DYjbG3Xjbuav00tww9O8aOcRJ50QHw2LSLceddwZmWWHZydWhtog=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4939;7:fy0qK8IKcrecCkYrBNEt5fq/4CnyKSAlJZ6XaAGa8YnLK5rDx238IeS9dymxdkcKyzP6gB8lEJgTc/NSW7DOJh1Sv27/gNzXl1C+N45e4XXN3SL8/WgUfZYbSlMR3FovBFXnWZK1bo4pLnm9RTUP14haKL+SyCecJ6wNRPbSV8Ge0Sq0TS2xrwy+AoxrLIcYnbJSX54I+LT23nQDB/vlQ/EP8Hwcyw01mA42f92lkDcqFptgriXw7G1iB78KhT1y
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2018 21:15:51.0716 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71139d57-24d3-45c1-c0be-08d5edbcce36
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB4939
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Huacai,

On Wed, Jul 18, 2018 at 09:15:46AM +0800, Huacai Chen wrote:
> >> diff --git a/arch/mips/include/asm/processor.h b/arch/mips/include/asm/processor.h
> >> index af34afb..a8c4a3a 100644
> >> --- a/arch/mips/include/asm/processor.h
> >> +++ b/arch/mips/include/asm/processor.h
> >> @@ -386,7 +386,17 @@ unsigned long get_wchan(struct task_struct *p);
> >>  #define KSTK_ESP(tsk) (task_pt_regs(tsk)->regs[29])
> >>  #define KSTK_STATUS(tsk) (task_pt_regs(tsk)->cp0_status)
> >>
> >> +#ifdef CONFIG_CPU_LOONGSON3
> >> +/*
> >> + * Loongson-3's SFB (Store-Fill-Buffer) may get starved when stuck in a read
> >> + * loop. Since spin loops of any kind should have a cpu_relax() in them, force
> >> + * a Store-Fill-Buffer flush from cpu_relax() such that any pending writes will
> >> + * become available as expected.
> >> + */
> >
> > I think "may starve writes" or "may queue writes indefinitely" would be
> > clearer than "may get starved".
>
> Need I change the comment and resend? Or you change the comment and get merged?

I'm happy to fix up the comment - but have a couple more questions.

Looking into the history, would it be fair to say that this is only a
problem after commit 1e820da3c9af ("MIPS: Loongson-3: Introduce
CONFIG_LOONGSON3_ENHANCEMENT") when CONFIG_LOONGSON3_ENHANCEMENT=y,
which adds code to enable the SFB?

If so would it make sense to use CONFIG_LOONGSON3_ENHANCEMENT to select
the use of smp_mb()?

How much does performance gain does enabling the SFB give you? Would it
be reasonable to just disable it, rather than using this workaround?

Thanks,
    Paul
