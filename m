Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE8AC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 916862403A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=concurrentrt.onmicrosoft.com header.i=@concurrentrt.onmicrosoft.com header.b="mhYX6exV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 916862403A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=concurrent-rt.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754017AbeGEQSQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 12:18:16 -0400
Received: from mail-eopbgr700093.outbound.protection.outlook.com ([40.107.70.93]:4016
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753495AbeGEQSO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 12:18:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=concurrentrt.onmicrosoft.com; s=selector1-concurrentrt-com02e;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gzpa0+aVECxRyRiz3AcZGUqpQZIG8f1L6fNSJeBOzuQ=;
 b=mhYX6exVAXfb7nz/RNXx0Z0Mj0FUQE6GEvlBXwUkyVS5UZUP/Czz7Le8nlqcWd9r9fA/SqoWr1d5jlN4+IUR/d8QPgLaOsFFrqAG7XZebtpqH+2wcXe7tS8ihSUzPVPgDofWc027jo3CuLJoVKSAQjU4BhJMnxVswcDe7XHzqGE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Joe.Korty@concurrent-rt.com; 
Received: from zipoli.concurrent-rt.com (12.220.59.2) by
 DM6PR11MB2570.namprd11.prod.outlook.com (2603:10b6:5:c6::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.24; Thu, 5 Jul 2018 16:18:11 +0000
Date:   Thu, 5 Jul 2018 12:18:07 -0400
From:   joe.korty@concurrent-rt.com
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Julia Cartwright <julia@ni.com>, <tglx@linutronix.de>,
        <rostedt@goodmis.org>, <linux-rt-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RT] sched/migrate_disable: fallback to preempt_disable()
 instead barrier()
Message-ID: <20180705161807.GA5800@zipoli.concurrent-rt.com>
Reply-To: "Joe Korty" <joe.korty@concurrent-rt.com>
References: <20180704173519.GA24614@zipoli.concurrent-rt.com>
 <20180705155034.s6q2lsqc3o7srzwp@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180705155034.s6q2lsqc3o7srzwp@linutronix.de>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Originating-IP: [12.220.59.2]
X-ClientProxiedBy: BN7PR10CA0036.namprd10.prod.outlook.com
 (2603:10b6:406:bc::49) To DM6PR11MB2570.namprd11.prod.outlook.com
 (2603:10b6:5:c6::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53963561-b9a4-4616-b35e-08d5e292e7cd
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DM6PR11MB2570;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR11MB2570;3:aIjWsEHycWmYn/87PQDSt7bj2Cdp7/cjAjdPvHMmF/UQHVR89hurjtG6/E5eQYr/dLYVfnLFOmgO31Pjfm3tLyr4T1iWjiJ8ulaR+OlzOnixuYJ6S9Fno47q7TUexQUEINya6LaBH3QAuhYZEsTUAtoEncw2dSi8iDvGJHmP/+2s//t8S/YoEE1r32noNBd+gYuZcKIxmIBPk+7D/fcrI1kEXP4hBgBCtRM0cWzSLtrWM3QZnisuiNNzwdSkXK66;25:fa1+dvBcLK/3NqmNLA+18LRMH5aMBaCl8zcZbTIQOCmCR+Sks+GWTfm4+19uGla2R4rxEM3wnifexU+FopRmSApgslEhCI8Ib/fizUjTwB/wIgI918MPtyT7ODGZQCAj+pAC9FUBpi/7oJtiJrQwXkdTgOtgJ7bMKkSayHJEBj9x+R4ql+SVKRhKJ6L+8QqMrvE/2E6Xr+hRHd3BEE/Xagw6+S0+S0Jr0/ZhkMVlwYRv0I87kN0Ec7UmImcAwP8O6XWhV6Fnjm5fuFxK2Lp6DBB6jvs/VLcpvlTeVGg7bsANj7wEFNm1DnoWi7TzrSR27KAHPnjTjXR282vnBTkqDQ==;31:AeYd7XFjhiT7xO62y7H7Ue+LkQcu467OZAErUoOLMJHJxOOJPCF1ze6elJhsE2zDFGR5fMhlg7JeZCgPb52vg7Kmpa7amY/fE/b6KKvEHGcxQ5Jy3zhItud2jeHk4U3o/0GZwO8Ufqw161RCReX8Zbi+aIBQ0Hv3RrpnvxLRHNNw6djBCOP3daPsJuRaQWJSSnNDjWX5d6KObcJM9JYwAvOFferS/t4b1YXmaNC3Hh4=
X-MS-TrafficTypeDiagnostic: DM6PR11MB2570:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR11MB2570;20:NZVHuO/mXHsn5BpjneSaLf62saRjhMqBeYWjeLRZLLHRQzWJSchOYPFFTwdkEoQdS8qBIX6XoDvGJTUfJ3r3qUVLmBP6yqA0SaPu+ZkWLnwDwOOP9GJp2/7uW15nCffDav1U/vTqsgvJBy8Z1e1iERQF2FTip9zXcGRL7fmWY2TyjFCuzoSgWLeKxZ92PSyYjlWGwvj/VsHKfQmj6iGjm3DDt3i8SzQXElIqD+oTtLufuxGbS2PeNiCOR5jq3IYejIQwlr3vvYS71ffIvwQ36Ga7NlfUPxjBuj0C6wgnIuTveU+SWDovIlkiYlSQD4yWN5XLa3v2VsRNH6JW51UubEzN6QEtk7YPd9H2ZJAoy9XvmgL/aAWTzYKe6Im/z+w5HaSeVq6rzcybiQR0VakqgRxvqh5CWawNv8OTXQfvTaw=;4:opqYBI0RYFzBaXqfzl/82yQnxb54wa7s9FIC4OjkYfi/Yx2XvjdjEXRFgzt50cX6sv9vqXX1mf509CDUbis1+nJUcyvXF1HUjVw4jCkfHhRsL+Bu0pklWY6cv/KwRK6LUCX552d41x6R3xdiwuobjmJWagpF/mo4MnFGqOSkKKy2BKYlIs6Oau1qk2Tp0aotSrdGhygK+bjPfdZoDg5YAng40DzwdoAag8D87sSx3k1SvjjyVbwyl8VoAsCUmjroko60nR7doOk28pZColh/9shiaJa3DTq19re5rlSRPVqJIrs+xx21mQu4U/BLIL8d
X-Microsoft-Antispam-PRVS: <DM6PR11MB2570657781BEC58D7FDE21F3A0400@DM6PR11MB2570.namprd11.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DM6PR11MB2570;BCL:0;PCL:0;RULEID:;SRVR:DM6PR11MB2570;
X-Forefront-PRVS: 0724FCD4CD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(39830400003)(136003)(376002)(366004)(396003)(189003)(199004)(3846002)(6116002)(23726003)(186003)(16526019)(26005)(1076002)(14444005)(2906002)(229853002)(386003)(6246003)(105586002)(478600001)(72206003)(106356001)(486006)(85782001)(53936002)(446003)(97736004)(53416004)(86362001)(11346002)(956004)(476003)(43066004)(33656002)(5660300001)(6916009)(6666003)(69596002)(58126008)(68736007)(16586007)(50466002)(54906003)(8936002)(47776003)(4326008)(76176011)(55016002)(9686003)(52116002)(7696005)(25786009)(7736002)(8676002)(305945005)(316002)(66066001)(81166006)(81156014)(18370500001)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR11MB2570;H:zipoli.concurrent-rt.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: concurrent-rt.com does not
 designate permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR11MB2570;23:rw2bnf2D0fh9zaO/wkGIfjUL4ijlYKyDCaseZHw6l?=
 =?us-ascii?Q?Qfzk97rkJDLTLJWT7VfHmzfqpaIDPO3SzwTqUaL+PvKNms50R/nefTMnSoED?=
 =?us-ascii?Q?1ZM9/ZysDd9IUiLEKbG4PWiZdPJ4CDdQNqKIHHbnOJIHILLF5lWR/8a0olkS?=
 =?us-ascii?Q?IFGIGRri1LW2Zge21yVPg4eFBKpBGOEoj7wUH0Kf+QQMI5ZJEnSpe7yd5wlP?=
 =?us-ascii?Q?PeNT9giUygMmuzaCWfCWDmTF9uBGBWH1iEHbBvi2SRaTMeFBuzeCx/7X0Pgj?=
 =?us-ascii?Q?B2iH0A0PzJJigxn4hldCbpVqjbFSFgzOqbypAQFOWt6FahE/ovDf++vOkQpj?=
 =?us-ascii?Q?wiIwQt3aDyHhWfOnAp/Ikep80MZ1emsLTdFYbyCNjiryXCBYxEQRs7JB/lSY?=
 =?us-ascii?Q?3OCQ8iNFNUh+xp0Mp1iY2DEnbBT9FQjlOJeqpypyHARBmWqRN2LHOQp0rCL5?=
 =?us-ascii?Q?q1GpJYyq6nD8hMrHkxg8uXXFYqXUQE2q9JulzsguJvWT0M49+BgBlaXvsHo2?=
 =?us-ascii?Q?MDZd4rWPzlHu6/l4rIJHVWFIc5iVhrzOA7Ao3cH+YUUV+IAvL7p8vpGAdZxv?=
 =?us-ascii?Q?ZRUo3LW4MxqnnewYAo8YIDqSDqTPCIXoqHE8URjY8mtKgSDHEvNynFPa4QCZ?=
 =?us-ascii?Q?ZRchbJ8VFIR6qMpT35ni4DkepOomRoge/almGvHf04ItRvduC5oSc8n/gaBg?=
 =?us-ascii?Q?chygR2SSsOq+bskx/uC093AWcfiJ4CaXEmB+kwEBGpLQhp5Awldc8mghdMpB?=
 =?us-ascii?Q?YLai4UtXhARynk5foRNTmgOLhs9n0GNUatH72OorN7TSP4/JRUjm2DQVJgrM?=
 =?us-ascii?Q?8i3sZ8Lg4L9bs38ewQHn48X59cW7i5V6NQ1JML3OZJAo0o/9PFU4hX992cpk?=
 =?us-ascii?Q?hhFHHolVfcTntd9gE11WjUTejuB2KxMsjrFLKgXe+dcZGmxjgsoF/UhWcVT/?=
 =?us-ascii?Q?+LqJ7s0DdkYr8xQXKBrlUaegcRnKo++67u5R6y4hOHFclOZMgPfOHsRfJt2/?=
 =?us-ascii?Q?zzzMZHNHAxzPzOzh1hIqDq1Ynhz19iI7IWqVIFJAv4wboyClLnIdH7UpA+LY?=
 =?us-ascii?Q?32rZthuMOVPNZEnVt7sbI8O1epwSOKDCnLAt015DJfu1K7eclkGNClILN96m?=
 =?us-ascii?Q?UCowM/bzHIOz5GGt4M1TL0VrJphxCMk4viG3gs+ZdBvENixlDMXMsEwsCXF5?=
 =?us-ascii?Q?Me3K6f3y4PyUpiyAKtIgN9qqQ5Jq0rDfjggChLugl4q154Wbg1xLzRBVQ5Um?=
 =?us-ascii?Q?F/M9fi3rC3QAWHnPvZaHONWAN20dyyomwh3b43v5YkqGb/0oT87gdez2RVdu?=
 =?us-ascii?Q?iMVcayr2XzW1RDiAIOPl37hILMAmZP4DyyQAfb3V7qwA76S6Eew6j74UchtS?=
 =?us-ascii?Q?BIUQXsK3IiKCZAJIk2k/a5Ui7U=3D?=
X-Microsoft-Antispam-Message-Info: 4bcEJe2VpOxw7jhg2a2fpkM8xDBKvSBU6/0ZFzuP5T0TwEwovC33xRj4CAhbqtQ0oYrZZYcyx2NJ1NTBKNoDHyxZtZgRfJzSO3CCkEGF4qVZjE/ZWBB146sRhKATFeA+KT1mmomX19QWmoSlNHddfhEllu3XkhY6WtMpgTN/AF2amh82sVmasLKb+aRYH4vN4JY+lheoZIEfU7XFegjDbGZE3YvzZX3Ua0HjbAqLmmAI77Wp6M8tyFFs0iM1lZKYixhO4Yrj1yUbX89dJAyZyzW3B5l/Y7fcvruzY2vS7bcK0z2gxYOdTBIZQe3Zbn0TM4vqadVnIoMve1hSvGqy+O+2ocP7eMNnzvVxYmbFi+E=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR11MB2570;6:U0Bm+jGiAUedeMVm1RtbTesQcs7VnnTUC84JdPMuxIf8usoa4d2derLgbClNneaq0Z1VsHolYHuyNB6MX3k+zctzNNDffYwd1oGbRYtH0ZKEgM241RINDtepOOF3rJz+vVf0FEUcfWyd27lDXZ/8MuA7rH7Hccw/8C2O97aaHwJzjCxhP9hfHgRnPXY1Kje87zRF62CuG29y6H1ok6uTdIuNZOeUdlA7D5tmh7sTE5Jt/Siw/7BIi5wH6SjiEVxxKMg90m8FC5ChsLlYEoSYOi7zgnlom5QAaby5O3EZDp/OpjeZIBo+eVfIbSKp98EgBhoh7GtzNuzIvbyDdMndUF/QYLiVVyWKU2JuIwckErh+tZ/vf9P1izZ3rFGep6giUIe34pvqxMH1BOrzF4FRy4dtEdYqzvgsdkKqe8wd0c7zgMRhyeL8dQXkP+GnTzGpz8N3LYmmNDAnfEVtKzBP4w==;5:BpSTJV3Ki5BkzJ5BmVywYCtMB8Nl6vW2zF/dsUe4si73JgMNL7Yj0atVrgM4LrUQYmvqjU3z0YvKw16w2GTpHAbszlQf3r2lhsbkIxK9M/IUPlSJfaeVNE+tXHdIXOGEiP4eyzzEQXzOkxMDCD0ki8bOVyd1qCA5wY6nFpGxCr4=;24:wvqRmMnX+Jwv08YzTfMXZywCWyxRm4HPbpMlysL1RWKBSt7Btp9598qWM7GBX2ycB0pHJ03i93LmPx6He/VIsh4t/8fyYQ1lWHFOYSPvOCE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR11MB2570;7:ZZVDYcIm2uBfuEK4ROY2NgVATVecfgHiqn+rUCDfbor01ns1t5fzglzJCvNatOaYVVFNwKr+HNcJFrKFlN81nOZojNvV9tMHp6Zxdi284kmhWcLYiudmoUDgOSYeHRXhWz9ALKCl+iDM383uIN36jva76bWyRUJd0/rs0a6NHBuqd9xT8dqVzDXkeTtZXXjR/YjCKrCaapGAuTMF4vYRnDnZu9H3HhVgBuycz1pjzVagvCLSDNKWVhCf1gkpDlCI
X-OriginatorOrg: concurrent-rt.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2018 16:18:11.9079 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53963561-b9a4-4616-b35e-08d5e292e7cd
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38747689-e6b0-4933-86c0-1116ee3ef93e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2570
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2018 at 05:50:34PM +0200, Sebastian Andrzej Siewior wrote:
> migrate_disable() does nothing !SMP && !RT. This is bad for two reasons:
> - The futex code relies on the fact migrate_disable() is part of spin_lock().
>   There is a workaround for the !in_atomic() case in migrate_disable() which
>   work-arounds the different ordering (non-atomic lock and atomic unlock).
> 
> - we have a few instances where preempt_disable() is replaced with
>   migrate_disable().
> 
> For both cases it is bad if migrate_disable() ends up as barrier() instead of
> preempt_disable(). Let migrate_disable() fallback to preempt_disable().
> 
> Cc: stable-rt@vger.kernel.org
> Reported-by: joe.korty@concurrent-rt.com
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  include/linux/preempt.h | 4 ++--
>  kernel/sched/core.c     | 2 ++
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/preempt.h b/include/linux/preempt.h
> index 043e431a7e8e..d46688d521e6 100644
> --- a/include/linux/preempt.h
> +++ b/include/linux/preempt.h
> @@ -241,8 +241,8 @@ static inline int __migrate_disabled(struct task_struct *p)
>  }
>  
>  #else
> -#define migrate_disable()		barrier()
> -#define migrate_enable()		barrier()
> +#define migrate_disable()		preempt_disable()
> +#define migrate_enable()		preempt_enable()
>  static inline int __migrate_disabled(struct task_struct *p)
>  {
>  	return 0;
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index ac3fb8495bd5..626a62218518 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7326,6 +7326,7 @@ void migrate_disable(void)
>  #endif
>  
>  	p->migrate_disable++;
> +	preempt_disable();
>  }
>  EXPORT_SYMBOL(migrate_disable);
>  
> @@ -7349,6 +7350,7 @@ void migrate_enable(void)
>  
>  	WARN_ON_ONCE(p->migrate_disable <= 0);
>  	p->migrate_disable--;
> +	preempt_enable();
>  }
>  EXPORT_SYMBOL(migrate_enable);
>  #endif
> -- 
> 2.18.0



Hi Sebastian,
I just verified that this fix does not work for my mix of
config options (smp && preempt && !rt).

Regards,
Joe

