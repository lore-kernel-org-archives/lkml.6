Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E1B2C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B557E20875
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:49:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="nciLJJLj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B557E20875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933745AbeGIQtt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 12:49:49 -0400
Received: from mail-bn3nam01on0106.outbound.protection.outlook.com ([104.47.33.106]:58760
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933292AbeGIQtq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 12:49:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ikb2SuMWZfll26sn3a8+aP1ZZ0snyLe0+ZxtWU5Cv2g=;
 b=nciLJJLjgpUpI5dHO15xA93WsBSVeRUOeg+Nr3YJB7JKs12dWUpdIAo9crQnbICuZ9+++ubY8tEAmo4+LT4KtBHXzh0ndIhc9sGRTk+skqhtQ97bZ2/GxOpTWts3wI2nQI6zcGYCn9VRG8S0o4cbCkddDYhK9iBthslrLEhLyH8=
Received: from localhost (4.16.204.77) by
 SN6PR08MB4944.namprd08.prod.outlook.com (2603:10b6:805:6e::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.19; Mon, 9 Jul 2018 16:49:42 +0000
Date:   Mon, 9 Jul 2018 09:49:39 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@mips.com>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>, stable@vger.kernel.org,
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
        Akira Yokosawa <akiyks@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] MIPS: implement smp_cond_load_acquire() for Loongson-3
Message-ID: <20180709164939.uhqsvcv4a7jlbhvp@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531103198-16764-1-git-send-email-chenhc@lemote.com>
User-Agent: NeoMutt/20180622
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: MWHPR1201CA0007.namprd12.prod.outlook.com
 (2603:10b6:301:4a::17) To SN6PR08MB4944.namprd08.prod.outlook.com
 (2603:10b6:805:6e::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c4a7abb5-05a2-47d4-d5bd-08d5e5bbf839
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(5600053)(711020)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:SN6PR08MB4944;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4944;3:n+H0Fcl49iqelc4sGYhL8c5DcRW9Ee66WBD8AfsDxLXWeCUK8EpDCGSBWbIYE/D0ZbccpmQpjAKpuV0kHsNfUurJ6G6kl9d6Kp8BKdAZFk+y0T009aUom/zP8arz1Q7W/iNvqM6X9+VOYNkBCxVA7AsIHTFqTjFQCMew5fm00Urcy89UdIfN0r7hhuppVY3hCPx5c/Rs1FUqXHpEhnem9UihDCOjjX+ARsZUmiWvCpoRZhWoKL5UuOMuuDYx3N/6;25:YNDnZlAUhLadC6GVKXMKvrBegfiES3gJWylMK+rBB2n28qOR2QNA50qFW1X8BeiGxcifDtXN5hyqZ2UWuYbsgcqC1Ted0V1F1E7twa1vjaMRG3ZTwlIbIZ5/XiWc3fL3WCNCm+7EoyDdnvWAKeky/7zMtt3PLnAg/2qHXokMtW1HdZEbj0Ce7lD/Opwnnv88gHmETofczq1ozkJyazGqCjsQql86t9zwgS8H9e/Now2uzVpVj3Gb0Aw+iavVI5clCmfHqiqcVfvHpjuhjw3FBbctko4iW/ejldSs7UMIcqBFFZ9c1ocEhV0VemFe8fN0q0skg1uTNaXCBKdgL0WqJQ==;31:+lsg20Dt7Kvx4/qYUEo4dff0kiTE9jyHe5fvm8RLbQZ922o1O6FimURX7ptfjyeOogKe4WqZKNzeZhuxMa08WfU4oLqRzT0EUTdhJ4em+mTEr7XIRLegQdVIMFFmV/+GOHz73cTC6xnkmV6mGcWKhlsCVl8f5JGpFl3b1TxLNIiTFB14l4d2uorupBoL/gUu1pT9C2UynSsmA9y1iECnoskKRkg07f3hiiiWHAeiwrw=
X-MS-TrafficTypeDiagnostic: SN6PR08MB4944:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4944;20:sGrzgSdEwWaH0lmOW/EhAyrNzKNrvfETaBXCsVevZzDpvXt/5RX+Wf88zeKZuXRu0a8yOTMjMHFUGEdcMD2BXMwKq0ZOgERP7EYjVaEzgDbPdz0JPFcLKlYL3mTKUsw6kd8k0ycWTo3OTZWQyEfIiZ1mWjR387m7K4LswYbQpzm39KueCXaDg035xmy1rPKMvCnXA3mku52gyjRJ8LTAwCU/jaf1c6H1Or3oE0336JhPLO2GvqUZyT6AZMcA1CP4;4:fkJuVy1J6/z9ChZ8XsSKXMVD6ILv//aKV9IQOrFHm/RrRbM8AEW8TiWSx+fFtR1vAbAfYbdXdusLZUTVLFwIKzSSor14QIXz5rvkEAGwXyNTdTEh/3TMQgvMNd3FsJ15/1taq+M74aTTeqi0mxqxAQj7h0CUuPFI9V5j3HTkX3h5VFK0RCBvRClQS3w4rb1Chl9QkeP7bo25w2yrWTF6ZBLkhoWpIfxvJGN4EJbsHmesQ7LJoIZ3KyaT+TB8U/91niUmeOUNvn3iymQDO3TtYK0X11UBGWImDwG0oI+70ALvG+0/v9fEB5ZPC93KUtIG
X-Microsoft-Antispam-PRVS: <SN6PR08MB494421B2AB0E8FE642BFF9ECC1440@SN6PR08MB4944.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(10201501046)(3002001)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(2016111802025)(6043046)(6072148)(201708071742011)(7699016);SRVR:SN6PR08MB4944;BCL:0;PCL:0;RULEID:;SRVR:SN6PR08MB4944;
X-Forefront-PRVS: 07283408BE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(39840400004)(396003)(366004)(376002)(346002)(136003)(199004)(189003)(33716001)(386003)(8936002)(316002)(26005)(486006)(16526019)(7736002)(39060400002)(305945005)(186003)(81166006)(52116002)(6246003)(33896004)(76506005)(81156014)(476003)(6496006)(8676002)(2906002)(58126008)(25786009)(54906003)(42882007)(4326008)(16586007)(1076002)(966005)(478600001)(7416002)(53936002)(68736007)(6116002)(6306002)(3846002)(105586002)(66066001)(9686003)(229853002)(6486002)(47776003)(106356001)(23726003)(50466002)(956004)(6666003)(11346002)(44832011)(6916009)(5660300001)(97736004);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR08MB4944;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR08MB4944;23:lHID95cj1L+scr4a4+GLdmxK7+XDwFNWSf5ZJk26D?=
 =?us-ascii?Q?XI3Z7AOzriKz90jOKOam98eh7OhdKQUZ9ajVl8bbDAC3liHpO01IKsVOcq8x?=
 =?us-ascii?Q?h9o6xvC7Xb55hhmYg1T5S1g8U7ZXQRI7uwrtb0bNYs8/CNBV38djkSLqP2NK?=
 =?us-ascii?Q?FO1t7/VkU/+C/ZkTQrPPKBZkAHLPmAgPUSgL6+3f+4eEog19My+qt8NJyj3g?=
 =?us-ascii?Q?JgQRFqmwX35nQOP81JovBxtbIjONT6oBt7aGPKeNFXyS+6a5J3sIIL7uIzOo?=
 =?us-ascii?Q?FASfizpFwUlN0n5ivgbUrDxbdw5cJ8u2FJcHlNxcPO1HU5L77Vd1AV86qjtd?=
 =?us-ascii?Q?VOGQ166cTFv38o7TyZ51oFYin4dQIVDQImXGiZItH65EfNtIgTVraiaPgN26?=
 =?us-ascii?Q?Lca/7u+MxWzHtASK9rmz7/qFgovPLAxs+unCjxPjwnPXgkIQ6B54y95fkHlT?=
 =?us-ascii?Q?HkzzgMMgPYZYdRbRXs3YfL9O/QeDylrkNuARrEs11Y8X2X+NBQ2eiCH/Nua2?=
 =?us-ascii?Q?uqbNblwKomeEUW0HCbxECfLoXPD/ovu0lJPQ84dY5Rjw2bQ2rITSFf/Bvb8b?=
 =?us-ascii?Q?Rko/U/fUD0jOyqk6GxIzcxQmZsuNah+GYnoJQksZky00ul5Kl+/jDNXOtXvu?=
 =?us-ascii?Q?86+4bib43RHKpq9fpyEjy1cWInO1hygWek5uzrjt2Rc6AFmQjTsAYblFH6Mx?=
 =?us-ascii?Q?puJMOE8KyKnZPqBrzq9wACo3UHgoxdCwOHp9oaCQZaI1t2vOfuARv0nHXqtF?=
 =?us-ascii?Q?JSPryHJM4SuYujoi6Ix/VonaJz3OnAZP9NUowhjqyLPxsKSTF8FnYPXSLTHP?=
 =?us-ascii?Q?YTJXzLr2ej3PZlpbvTim+hZNXJ7rp8YQwhMayKzOkrTL3LicqVB1L9U3AGLF?=
 =?us-ascii?Q?DMzEcwVvamBx09N9Wb31fpu5eekRy6GCZSnX7/ceZ1G5nc0WEnHaQGmhL69+?=
 =?us-ascii?Q?2/fdKuUJ4glMDkserGj9hGrpBHwD0NwfIfAhT96hsdCZIlSFiWAGBljJLQHi?=
 =?us-ascii?Q?gdkKOs2FYzZiqjqeJJH8PTfS4+xPqWTvVRtD9Dso5v+WaNJx2vZ9HY5oVMnr?=
 =?us-ascii?Q?fnF3Zgsp4V1iebSjIC3izLN3/+RkmMErqU8FEbBtQFxAPffoIuK3sfA1WfQw?=
 =?us-ascii?Q?AgH9jB7ZXj65xyl23oCkKHMBAwGFmfXLi9JgfnCq+wLE0ULp3tQq99UAsUAf?=
 =?us-ascii?Q?0i/k7l4MkoEmKdxtKdGYEaAF6OqYoz9FMuYnWUc4n+lKyg/YD4GBdxb4qUHO?=
 =?us-ascii?Q?NnizwFrHxU2HFlF6epbD7W7LexWpWTrCyQV/pgX8AOZu4l2kWsTficaJi3AB?=
 =?us-ascii?Q?oTp3Xtd1dh8o2zeGEUrbUd5CoKTm9C0K77AcuWqHYA/rDOWr8b9MzdU/BMdf?=
 =?us-ascii?Q?DwewQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: HvJ//td7KAkruDgR5KTqDJks7zZByVpz+SBQRJHXNCHwm8ydNcHkh8yWw+8AmrJvU4VLoAqFoPa3aD9X0Iv0egqssic1vdwobblNmy1fb28bGJfeuC6LDoqXlRBW0YlDAYn4qS03LnDSeaywqLsoAJPUgq8m1/qWgqxBaYbK00igtWd3AEVCgoCGYmEXG4Ls8QhvCsiq7mmjVEno0gU7ZLkN+CKPXFoa0SlAmu7UN0Re+SoM9hby7J0MdiRUWfoM4XK3ydeoEpBTsmL9uECnGdnNozWdrOkevI5qqLchQszGiysULEE1wpz2kDXtTQZOdNBq9ArfhPRLyNgrjpwVMD5K3MIlHVKLR10EFnLTPeg=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4944;6:xyPDN/Vm+ZO1C5R8S0FHXlaWDffXXY70GNPMlfHd6HU/DB8/Mu3CEgEPIpVZx0CNuvI0CL55LgTyfThFIjWR/Kpw7ADYgzPQmLiCFCAGS8qINVdxDAK5hg38a1DnbfdHny085hDQYZ8oWkbGlLcHcgFU6Ypd95RsmtSsShs3PrlLPhXki72JZmwnv7rr4/HWW/VDDYj3OUeId5/nWSjrDWKlaWUrn3SsnuJjkKj8giNiLf38b11UBcjfKNEV2INHxFLoPWRmy3sAn4+mJlJPzbwr61SH5tmnA0HiOsR05pJILZ/V6ZQiFtJcP/NgKuwik/+ldkeR7jdVkRsTYKR/cYeI+a+15uYvFMmyLriSGeaQuQw5dFupKobMozPaG3nncSx1tCnKpZo/n5zco4QPmyUw6gJ6J3SV60kpyaA9JqTticiZsxaGvbODK5dEHb2YttORs0gFPZIBOg/OMnwl/w==;5:9l1mC2AJYwuhS6KMigUDnMHHxa/YDyLu8tyFRie5jZoWcx9paHRG8iC/jun6/744mDYIokAq8q1J+b3J7oz3R6A+LynkRTL9ZzL8j2IBcOwYVCowPaqgZY2DJvfMlIZwquTlEHu/qtJ1Ht48FOsdvN8cBJC1x6z1AObHy2de5Mc=;24:zjpqOQIWLAfb/COcF9YOAZWtfUWZH0Ty27TUVyz/VsoVhv+ZdY4wrGKGXBokE/YjqzP2cG4YiJIERvDKs8WdL+lPZJ0Taen2AElTCfWrI/0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4944;7:/7bh4W1rqX0GSfCpYYXBLY1+ouFSTmwHuXcJfF1Rwr7WaQyogmhZL6CilFgLGCS59wHTkX5BxYE4TKbj9i0e44Nn4Vz/9tuQAoVETvqko9Xn1hf6uo9vs3P1niJWci63u9fYLU56s1mCl3cQtN0PNxHud2B1VvItX+Fy/oalGAgBD0ZuPnr9sDEeHjKByHprbBeRpwg2EME945KksTfHoIVjzWlkR1AV1OjDuXwvkmqtC1dhJeNQeSiUhMITfiOw
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2018 16:49:42.7259 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4a7abb5-05a2-47d4-d5bd-08d5e5bbf839
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB4944
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Huacai,

On Mon, Jul 09, 2018 at 10:26:38AM +0800, Huacai Chen wrote:
> After commit 7f56b58a92aaf2c ("locking/mcs: Use smp_cond_load_acquire()
> in MCS spin loop") Loongson-3 fails to boot. This is because Loongson-3
> has SFB (Store Fill Buffer) and the weak-ordering may cause READ_ONCE()
> to get an old value in a tight loop. So in smp_cond_load_acquire() we
> need a __smp_rmb() before the READ_ONCE() loop.
> 
> This patch introduce a Loongson-specific smp_cond_load_acquire(). And
> it should be backported to as early as linux-4.5, in which release the
> smp_cond_acquire() is introduced.
> 
> There may be other cases where memory barriers is needed, we will fix
> them one by one.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---
>  arch/mips/include/asm/barrier.h | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/arch/mips/include/asm/barrier.h b/arch/mips/include/asm/barrier.h
> index a5eb1bb..e8c4c63 100644
> --- a/arch/mips/include/asm/barrier.h
> +++ b/arch/mips/include/asm/barrier.h
> @@ -222,6 +222,24 @@
>  #define __smp_mb__before_atomic()	__smp_mb__before_llsc()
>  #define __smp_mb__after_atomic()	smp_llsc_mb()
>  
> +#ifdef CONFIG_CPU_LOONGSON3
> +/* Loongson-3 need a __smp_rmb() before READ_ONCE() loop */
> +#define smp_cond_load_acquire(ptr, cond_expr)			\
> +({								\
> +	typeof(ptr) __PTR = (ptr);				\
> +	typeof(*ptr) VAL;					\
> +	__smp_rmb();						\
> +	for (;;) {						\
> +		VAL = READ_ONCE(*__PTR);			\
> +		if (cond_expr)					\
> +			break;					\
> +		cpu_relax();					\
> +	}							\
> +	__smp_rmb();						\
> +	VAL;							\
> +})
> +#endif	/* CONFIG_CPU_LOONGSON3 */

The discussion on v1 of this patch [1] seemed to converge on the view
that Loongson suffers from the same problem as ARM platforms which
enable the CONFIG_ARM_ERRATA_754327 workaround, and that we might
require a similar workaround.

Is there a reason you've not done that, and instead tweaked your patch
that's specific to the smp_cond_load_acquire() case? I'm not comfortable
with fixing just this one case when there could be many similar
problematic pieces of code you just haven't hit yet.

Please also keep the LKMM maintainers on copy for this - their feedback
will be valuable & I'll be much more comfortable applying a workaround
for Loongson's behavior here if it's one that they're OK with.

Thanks,
    Paul

[1] https://www.linux-mips.org/archives/linux-mips/2018-06/msg00139.html
