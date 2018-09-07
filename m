Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A0C3C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 22:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7DDE20652
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 22:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="RV8POgaz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7DDE20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbeIHCpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:45:17 -0400
Received: from mail-cys01nam02on0123.outbound.protection.outlook.com ([104.47.37.123]:50080
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726394AbeIHCpR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:45:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BrEyJOql9CMtEKbt8aQH2Lfrglad3tyJfRKjNM8IXuc=;
 b=RV8POgaz7vqiI/lwI+arTNTjB/TAElaI/f7psNlZb3P8rW9JB8Jt3q32a4fMFEGiWOK0rp+fWpALFr9Xu1pjWADrumVLJ0XjUkmkbD1gRMDjlrb03mfIyPh3IRLa0M/tU7jaPLqOa6jFBFOOztXlerudtJQQYwazr82PqVQo5iI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 BYAPR08MB4934.namprd08.prod.outlook.com (2603:10b6:a03:6a::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.16; Fri, 7 Sep 2018 22:02:10 +0000
Date:   Fri, 7 Sep 2018 15:02:08 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Igor Stoppa <igor.stoppa@gmail.com>
Cc:     David Daney <ddaney@caviumnetworks.com>,
        Igor Stoppa <igor.stoppa@huawei.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mips: bug: add unlikely() to BUG_ON()
Message-ID: <20180907220208.nqucxycxsxmyxt4m@pburton-laptop>
References: <20180907180302.656-1-igor.stoppa@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180907180302.656-1-igor.stoppa@huawei.com>
User-Agent: NeoMutt/20180716
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: DM5PR2001CA0007.namprd20.prod.outlook.com
 (2603:10b6:4:16::17) To BYAPR08MB4934.namprd08.prod.outlook.com
 (2603:10b6:a03:6a::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a4f9211-9ada-4572-215e-08d6150d8f79
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB4934;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;3:aX1rigjSaLx6sv2stf1K5hCxwYDj/P8SmqQWFwTcUuMZiaY2upPR8BogTFUDt8UbgCjyS4Raw55kAzq8mj7mN9A21fh1ohm8PYMpIzPp1lJhojlwSUkDVnCmrI1M8LUariEDtye6Zi8Gb8gDImgGoalGJqgAEoThgXdRcn+1JXMAtAKbf6Gd4sRZQDbg17cZYElb2uSkEPknqoNoTa6lOTJ88c5XbMMiQIVu+NPWm+oIL4HCl1oEhQNq5ArGkaSj;25:w6RfehWOTiVXc1MM1c1SqCTbLFOZFVRNqazKh40/P+OQDSVumbvn2nqgaqx8LiiS1utz2KV900N6/5Y2p1GZHYOvk3pPjGGYI3WW6S2gROfvAkFkSTHZBKrS1CFvIuAtCKJdmECVnl9JFHA+Whk+ng6dqMNMa9GzhwIR4g7NuH6Sl8209Hjj6IpUASpMJnPBKxryKdQa/5DMRSRRfu4/bi11sJMlEolYFINv+6psLZ5+EFPVRncm81rhQPNjkAgfJmdv6AqVSi0yZS+agjgvDMkT7UkhskjQb8EAaJzlLz+q9UDxkxGfBkwvyui+MfODEFlVf7JjANKB2BobnVM3HA==;31:oM40EOkf4iIJNUO8OrS71LxXFJ1qKm9bnsuYplK5QFbXrDDZ93za+Z1lCy/KQZhkIP9JnCJHUYAqRYc4old4ZQ7ztzuGXsXgqUfoyUgUWleNzwYXAMyZAcH1u5N3vVkBxDtBtYs/lX9BmvaUMlpT0iEoPabQfnEgSuFFWOllxX1ItazBMQueavnM8Ffmj9Wnl8amEHuI2ZGWerbq8LNIhr83hb0J9s/0VNzIPTxO+1U=
X-MS-TrafficTypeDiagnostic: BYAPR08MB4934:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;20:JXGZ/WqRpRnYT6/SbDjO+rRYN0Tt2iUqaIXFsCbnMmWGHSjFvos34KVoBkc3LkOsdxrdfdpO94/0i/z2r0rdkibJWbvTuBPdktFiQvUXWcpLKb3tXMmzRJE5bCtNbreJB8agIUIwZ2Md8CQArwiY48wtuX+TTp1vZZDb/g+KRlSJ+5tFLfhdI0cLpVDHiMM0nHinOghVopFNuzyCLZQelxtDJuzFZFf8VlD5t5RGkfrc1nqHnk52bk5l/lPsftJN;4:Smq7kRQokkdumNRaNzpn0d3MjB46BpSu4Jrmmm3u8l3oNLfuzzzcNetghU79kOqlujGbX4MlofT/lhwSD3j1sOcA/TdThz0jkNre8NFWYpTOvM1phCivbaB5kRrl5b+C7jdZlQDsBtwW1kmP7IRYxUKr/Xtft25AkxScdxAXVeklKV3h5eam2lAmuj8F11yTSN3d+R11DshLiC7VBodyz3Fz/dx2eUwewUv3r2MYsZgA8gSMgueEiiKl2+7C7aLtNPNCPUh2Tyj8cyhxlh3jdw==
X-Microsoft-Antispam-PRVS: <BYAPR08MB4934D991B087C276BC618D21C1000@BYAPR08MB4934.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(3231311)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050);SRVR:BYAPR08MB4934;BCL:0;PCL:0;RULEID:;SRVR:BYAPR08MB4934;
X-Forefront-PRVS: 07880C4932
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(396003)(39850400004)(346002)(136003)(376002)(366004)(52314003)(189003)(199004)(68736007)(105586002)(76506005)(7736002)(9686003)(305945005)(6486002)(316002)(54906003)(229853002)(106356001)(58126008)(33716001)(16586007)(44832011)(52116002)(6496006)(486006)(11346002)(1076002)(76176011)(42882007)(446003)(33896004)(186003)(26005)(53936002)(16526019)(386003)(6916009)(478600001)(66066001)(476003)(956004)(81166006)(6246003)(39060400002)(8936002)(25786009)(4326008)(97736004)(3846002)(6116002)(23726003)(5660300001)(81156014)(47776003)(50466002)(8676002)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR08MB4934;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR08MB4934;23:bJE50+5ukDhBoOuutgOU3sPo2VE3Gxfa3X+cVKt+Z?=
 =?us-ascii?Q?M1n43e/8gp7LFTQl629+IPAARCi8+5CsBiIrNgPzPp38MVFhDqxOPoYhGK2l?=
 =?us-ascii?Q?wjhG87s8BastaGB0AtcGNKy0S8G+ovVhP5SSDskxI04JtyMNIvLUI49ySaMN?=
 =?us-ascii?Q?tVaoC4nvsqtMsx/CK0iVUH+LPb6Eya+/Ep/Q4cO6R2/LrWmEt64jUmYhB7Dy?=
 =?us-ascii?Q?fMDVeaKuuMlqAFGWZ7FyhyQeaNBq++Cc7PURFcGYY6Li2qVWeEy2j/LajP5N?=
 =?us-ascii?Q?0uQVS6uernuWVhhelIvl9zZM1AhIBg/t+98agnCAJW7U5ypQXBAqAWCioQ3w?=
 =?us-ascii?Q?ZmFhzKdcmDjzaHeuYWGvRNpd6BLjA7ETcbdRTrpS0zA9/JYZC23OHpww9Q9h?=
 =?us-ascii?Q?VvOv16NX9yIZ2nujVPXkP8abyvoz9lv+lU1psB6v984x+kHk1i/6BtqNOiku?=
 =?us-ascii?Q?0wyankN1N06TzkxZcgHTN55S4UAh7tvJzlo2IApduqQ272pzNR2NjdLGDeiD?=
 =?us-ascii?Q?A4HIN0QNwuUBXqo4J25BALk42bv4EWEaG5kqCUpd6/yJD8Ei+UWaCla9VVq+?=
 =?us-ascii?Q?eZot9B18UVIih7eSQWvBugmOICqVp+hDP6q/MgGrkAl6szh1wgNikls0MlGv?=
 =?us-ascii?Q?x1QS8XZT3hqGUIBayvz8s7gN6bmFqaCpmx++yH4BjImNv5vKim72IIa0Ahpm?=
 =?us-ascii?Q?lcZXpzR1c0UIF9hZ1aH318x7Y2By5LJyaWS2nl1dvkQOAkIBI2+aB6z7nOa8?=
 =?us-ascii?Q?EjZLfhv3GhOJ2Gigoz1oBRJ+vaRJMbS5OCJNuET4TInhrYQfm6LLmCllnOXM?=
 =?us-ascii?Q?9HEQE3NEIuBdEnOJl+5R2WRJL+PmQoUAcoyzr71L7czr/Y+j7Q0tAyorrjDV?=
 =?us-ascii?Q?tbnUemhEeS26M/+Ma/6MTuPl5XF1t8IHa1G5t2Z3EXIs07mQCGWrm74gum0H?=
 =?us-ascii?Q?JNo4pC/ydMMIk4aqmUmnt1N4opExsk4A8kjc1Kp/fpVRVQ5bAs5Bnf0dnxUY?=
 =?us-ascii?Q?QQkDT2vroSOCS2nhjdJleykgg3JdrWdwIxCHtxNlH98VsVK6VFq5V7JYxtau?=
 =?us-ascii?Q?CnwVtPbrFoLruHlpbBv6GvSoi0Z+q50SLkUosKob157iM9h2N3pnI9I2UrQH?=
 =?us-ascii?Q?NMWJ6/23RTphGPyItXWR+RgpqEFkN08nfWhNoVE5P4vw9UnSfa9KP1Nhqxqp?=
 =?us-ascii?Q?19Evv4tPL4ofWN47hYVJQXVBovhKbz3F7lcuQQiACDIQNd1NoSrc5LGsew+8?=
 =?us-ascii?Q?95ok8ezGWm19pxasOXK8TkKBGNiEZPNx5wJ55lQNOu4qdLg1vQMbXqGRpmZm?=
 =?us-ascii?Q?ovGSQ+qAZDtRp91VGMqVeDZAkh8h9AtSE6R7wb9gm5K?=
X-Microsoft-Antispam-Message-Info: IZ21mbYnvFs9tyUg6OSImACWHDLuRkpXDCt2EPUfoMhi5+CIkHMZrI8rGrkkXn5W27zEJgpGDLt0Kfyy/ZTdgjn4YTDIKt3pJVLqm53Z17WPEAAQC/hdT/GlccuWhqWdiPHdmZduj8RlT9Epei1CxY5Q4LQ1ADavvrwc6sJhNiURjo0/p6D7VcG/AdP6BDZdw2ob+M5caZ3Nn/xzXpgh6jPEDdPilDqEd1kSGLTEAoloRVZnkmqiJOuPeFX0V6pJbQ9wjD53Qn1MhkDaSYHywL38cgInJ88IrbbRJORE/I5awDH9+iQW9gIt4EyKy7v/TSk5jmp3wGwMVEvYb92/i7edbYPGhHhSkldw/v9Jy2A=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;6:6BFBfJiYTh+aaUWOtTv/QVAVo6Cgq7B8CoggsYN3xHSC8rg58J8KB89Bu02N1nwZIy2u3ePurWCFbYBqrIUN075RIM/7CI6G6+PmP4JaOlu9r5j+Lavr8yyG4RRjr9dmKN9VljQx08R89814GHHJtFexVEN0wmzWSC8cFnIsdFpa80MT3bO6jA2KH8Ku7SE+JLm5n2K07+X25VCTbHMJ+5zkebBkU7da/bzlWyW5mcw/DFmHDvvrw3XDj4L7NDeQrKKFc519UIkKk8D/sshDO5p/0LhX06Tz7Z28uhb6OhdDVCWtKgLpN796xR0/2o1I4dthhNRiGlhNXJU0smo/y0VJMYCS6eX6fergaZfw/bJp6Uee64mq+cM/tRbKTiidLoneMyrbkXiSoLrFGsb21llTvzHW6F/Zo2bjGpDG5nuyCVeaibJarnvifDPuwp0HcPA0RdFRuksz95Hac37btA==;5:8jFqAMxW/vBs9kfBXBm2dPWesP1M2h2P/fvwiGup+gazNGGxbGV1m/7/dKO9VuImRqp/cHiX7uqjMwYt8dHm4I78iXU04TdsWlwxkoWknviaLWcdWqepzXTVxHZ0TjojgN0VeYigLtK9bPlkHPT63zahyLde+aBzPlmpdXhjImA=;7:Y3rb9jkK5kpfMqJVuhmo1L8sfMsDquj9RM9WE09rdxNR6MeBo/dNsHpfcnsj3kn6hKGks8QQ3WRl7UOpTKzdeKWGPfKWpFQZuBpS3seFHcueBodlPpGFr+qszHYX+6e3LA/hruPQZC0KpGXrh7rUlWnZsSMIpSErD9ALvoKskWVUf18Oa2glS/UlLK6fywTwbaakAv0seVnk9saq7zEwE7uwAnK7bXQw2z+nBx/QmB4zZQbcx98fBXt1MjSU4FXV
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2018 22:02:10.3581 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a4f9211-9ada-4572-215e-08d6150d8f79
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4934
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Igor,

On Fri, Sep 07, 2018 at 09:03:02PM +0300, Igor Stoppa wrote:
> diff --git a/arch/mips/include/asm/bug.h b/arch/mips/include/asm/bug.h
> index 745dc160a069..02101b54aec2 100644
> --- a/arch/mips/include/asm/bug.h
> +++ b/arch/mips/include/asm/bug.h
> @@ -31,7 +31,7 @@ static inline void  __BUG_ON(unsigned long condition)
>  			     : : "r" (condition), "i" (BRK_BUG));
>  }
>  
> -#define BUG_ON(C) __BUG_ON((unsigned long)(C))
> +#define BUG_ON(C) __BUG_ON(unlikely((unsigned long)(C)))
>  
>  #define HAVE_ARCH_BUG_ON
> 

I'm not sure this will actually do anything.

__BUG_ON() doesn't use the value of its condition argument for regular
control flow unless it's compile-time constant anyway, in which case
unlikely() should be redundant because the compiler knows the value
already.

If the condition isn't compile-time constant then we just emit a tne
(trap-if-not-equal) instruction using inline asm. That will generate an
exception if the value is non-zero at runtime. I don't see how adding
unlikely() is going to help the compiler do anything differently with
that.

Thanks,
    Paul
