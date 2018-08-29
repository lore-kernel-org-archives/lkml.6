Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E621C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 09:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAB9320867
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 09:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="fVKiaikk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAB9320867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbeH2NPz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 09:15:55 -0400
Received: from mail-by2nam03on0057.outbound.protection.outlook.com ([104.47.42.57]:14416
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727107AbeH2NPz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 09:15:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3plWI2XaX84VLC+KK0vHZCIKDz4QVWuHD/4/RGWxjw=;
 b=fVKiaikkTdYrfUlt+7N8UtZ86sl+LR0e0eXWqnXYVtouhj6c+NcpGuVpN50el/VAhEifVbFEmNxdWBu162GJQEhxjofuem60VIWTZeibxJAmUcXW72Oud8t4bSPlUVyB0DWNi/NWxNyomd9uPY04oKD8KF+lV+tQt8l/Ri5CCPs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 BY2PR0301MB1576.namprd03.prod.outlook.com (2a01:111:e400:526e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.17; Wed, 29 Aug
 2018 09:19:11 +0000
Date:   Wed, 29 Aug 2018 17:16:08 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     <thomas.petazzoni@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/5] net: mvneta: fix rx_offset_correction set and usage
Message-ID: <20180829171608.5eb7eb97@xhacker.debian>
In-Reply-To: <87efehk0eu.fsf@bootlin.com>
References: <20180829162456.2bd69796@xhacker.debian>
        <20180829162706.24111f9c@xhacker.debian>
        <87efehk0eu.fsf@bootlin.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TYAPR01CA0003.jpnprd01.prod.outlook.com (2603:1096:404::15)
 To BY2PR0301MB1576.namprd03.prod.outlook.com (2a01:111:e400:526e::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f966463e-ee79-4fb4-156f-08d60d907c65
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR0301MB1576;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0301MB1576;3:aR1s5pe4WIUX5oN1Ke/aV6Vqb1w2/TwG/QpePzcU12dldHF0//izzQraQZ7MOY46trBLOdbzYm37crMj3kHhvqPkHmgKKkYFFkkA/YxFTYojWaDA+dlbMvpUPgodssyzU4YB55Jg+qwnBCDBUUQfDmQbXi+Ow5lx39DopAzLaQBFnInYGC5eSxwoiIosI7R7YNIgY8z6GZen+rZQmyzlDCZmH3bwIvq/p4/hVZr7BKU/S+NJJqU7pQE+cjgQRzGR;25:h+5sikra2UF5z0fW40Q+GolpoBPRCaYJ1cAiRq3BKio2di5hYSTne2w8iH2StOkV72+hU3br2r/ovCRr1knLraiddGHYVmh2MaT774v9Kg1H3sxbluqgGBx0YYatvPtGfd+LHOeO41YecCo2qPU0wjjiVSCmjkeTg1jNtM87Xs8tH4et3fMbRVj5zW5EXYaSNbzZWutQFa+dUBEn3318B6fgr8914s/7S+Zro+E7KkG48Nwo1EDkouOHoqGEw80r/7vxxz4nRsOoLdFMYY46VCejA9pdzeepNyJVhMAiviOgaoOxj1PHcdarVAbcRpHCV5pABxeQ3+DsGQuGQXO7Jw==;31:mPCuAxi87zRvmQg3knl7lFESv9pUV8jH3azu6iYW8K0TOPc34C9PVEuaB7w1R0WWbqHpNrtX8FLpe/ePfUx0a0KgTvxZZke+c/z/zfv77LkY+rfAu7LcGRLOXgDf1KPr2i1S+bR/jBctzyt+XQVjH7IaLtBewPrf0+3iROakbm0Fdq6MCYEohD8huDOFKsbvWxvAvJnnHJXWRd/30vq5jbzQlkeZNQ3gYnHWUs/U2SI=
X-MS-TrafficTypeDiagnostic: BY2PR0301MB1576:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0301MB1576;20:POdR7QP861Wvjvz0ql4dktcaoeCqWIcmqswpSLLAysnc7kiB2gErnBdwyFh4bX/4/erhuWWh0saHou61qsfy2zHbJhgdELlMDCuNf1TOrt1IGLEaafH3X24svCp6ht6RAXwmiQOR/ygEVjBXqiFWnIue6hFNS2c83GbLkmp60mhsY+p2FH4Mq9NX3d/40LiBHnh6MafCWpAo2qyrGaYmT8P+86ZmZpAiyARy9HdkAM+2KwUYQnfMFX6wLCsjd3KTHV1hazMZebcW2uBCvaSJWQARBQMhsq8oVfn75bpLVWN5fkSM/8z1AgzJ3jN5EYMzQW/RjqBwzvoDoz4/R6H8Nv/3sJdcynBggTBM01azCtuq5DMS3I8PJlFJIiuj/SX02DLvfDGGEbBzXgziRAw6FO2oQ00KxTKxnf3xxm4foCh21D6H4WCxokJSmrugVtU3Dyxj4JkVWQrCZl18BuyE7qi3Ds65RRPelZs8kcgH0bWGOxCG2IirsJetZA+Yf4cs;4:WblcKVI/6j1Ool2OTrrimHMKHs9xNbiq6bdjqNK9307WlB6773Ne8zpChNFS8sjnFxR58TkZIbhUy844xd7p1VY9wqngP0GhovARXHazu6Vxlo0sZ3ZJNAKLVcILWUo8528mVjoLXIkSIg9UnQ8c3rco64QvLf3oO2+TRl1UHXo4ScACkF0LP1HcFKdKTFAdg4rnwPICzJfe5MwRKUXL12rqLl9MJJl0gZV9xHTFKNQJCPVGKNrycc8qu5dQsOD+3bHRluLOluGjYcjVTaerkg==
X-Microsoft-Antispam-PRVS: <BY2PR0301MB157640F61B430636CD6F02CFED090@BY2PR0301MB1576.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(201708071742011)(7699016);SRVR:BY2PR0301MB1576;BCL:0;PCL:0;RULEID:;SRVR:BY2PR0301MB1576;
X-Forefront-PRVS: 077929D941
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(376002)(346002)(39860400002)(396003)(136003)(189003)(199004)(5660300001)(7736002)(8936002)(76176011)(8746002)(956004)(11346002)(446003)(478600001)(7696005)(52116002)(68736007)(486006)(33896004)(305945005)(476003)(81166006)(81156014)(8676002)(16526019)(97736004)(23676004)(50226002)(86362001)(25786009)(186003)(4326008)(50466002)(26005)(1076002)(386003)(6506007)(6116002)(3846002)(229853002)(105586002)(54906003)(6246003)(55016002)(9686003)(2906002)(53936002)(47776003)(72206003)(6666003)(66066001)(316002)(14444005)(106356001)(6916009)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR0301MB1576;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWTJQUjAzMDFNQjE1NzY7MjM6R0JLWjNTS0ZNRlB4UnFESzNPcFRrVytn?=
 =?utf-8?B?a0N2T1hSU3dLQTRTUDBHdUVjQ0hjQkgyWTJVcEc4Yi9nc0VWTHE2MnM3Rmto?=
 =?utf-8?B?UWpOek9tcUlSdzRZcHBVZDh1cEVwV1NwSjBZM25FYTVOVE9SVE82cTVHYnF5?=
 =?utf-8?B?eTNleUxaWFlYV1ZmRWhkeUtybmg2UFdGdzFFQjZvYmkrTlFkMFBKTTdyUGJu?=
 =?utf-8?B?YUFHazg5aFI1ZVQzWEEwaHF3MWs3UXd4R1ZYQTRxdVpHTTFZVHpRNUJjd3Y3?=
 =?utf-8?B?d0dIUjdudXJYbmJuUE1MYzU0MDNlUlJUL3Ezak9QOWxhWFlyZFp2aS83V3NO?=
 =?utf-8?B?ZGc0dzM3WlV1eGxLRW1NUGZoRWZGM2xBN0hTWEZXN3pLT0dqUlZOMFUxdXlJ?=
 =?utf-8?B?UGtiaUI4NldsRzYwS1E1UHA1Zm5RRCtvQ1ZTdHNRMW9EWFNXYnEyL3puc3lC?=
 =?utf-8?B?b3lOazhxTlMvU3hPSkJZeGEvUlZteTJjK3dBSmx6anM0aUdEazYzd1dsd2dq?=
 =?utf-8?B?VG9WczE4M0R6ZHlacmx3Wm1tek9jd1g2NEZudFJVYkVscHEwL1JPTHdBaFZ0?=
 =?utf-8?B?SndCcndxbWNheDF3cmRodVJNdGRuNXJHUnUrWnBmeElOKzVBcFlGUG4wcWtH?=
 =?utf-8?B?d0dFTktaa2ZOVkw3MzRvWmZCSitXVEhhR3JhKzZFbTRUakh0cTFFd09XZzJG?=
 =?utf-8?B?cW5HVHFtSUtremdlNVBtMWJGUXo5WFZhTUF4MmtYRFNuMXVWTXQ1NW9zZ09z?=
 =?utf-8?B?dDlpR2VPV2FwWSs3TGJJYWJBb2xWYWpEUTFaRjVXR2N0UnJFZEI0RUkyVUc0?=
 =?utf-8?B?cGRYRGFNZEdlMU1weHh5Rit4cG1ydTUrWDExRmFjSjlzZ2ZYdjZtYVNSS1Bp?=
 =?utf-8?B?R05FbC9NMUlVa1d1Z3ZGZGt1U3plZktWaFRZdUcyWWoyL3RmV2craXp0UUYw?=
 =?utf-8?B?ODA4WHlvTTZhdExCVkJENTZYZzZnWjVEWm45ZVVwS2dvZlI0aFNzSVVneWlQ?=
 =?utf-8?B?WjlxQXZ6Z25veHFlRVRWdDVhZ3VHaWdjMDZqVGpwdmh1UEVGajNSWE5XMUZ1?=
 =?utf-8?B?MXRaUXJyVDhud0UwZktmRW1kVXVJSHVENEE1ZnpUWFNLbkg5QkhobzRiYVJX?=
 =?utf-8?B?ck9wUjNIU2hac3NYS1Q4SG1TeUtlZlJYbkVyYUFUdlFXRVdKSjVRL0lJQXAz?=
 =?utf-8?B?ZHpoNzg1aW1UTjVjNUh1dzQvTnlyV0w4TndXWmU4ZElyTFkwWTFPTTJaNGtv?=
 =?utf-8?B?Zzc2VlF1cnNPdmtDbEk5TFlWNENSbjkvQ1BlMW5JMjgxdlh1dXhLcmx3Rk9k?=
 =?utf-8?B?MjZtWUlteU9oOERZZlE0bytMUHNNUkNPYmU1TGlxMlBzTEt2TW9VL080ZWNr?=
 =?utf-8?B?eVY2VjIzZVgvbysyOEJhc1BIdnRhbUxUNDlrTWUyVDdLY3FBZGZJbUZ2TC81?=
 =?utf-8?B?L0J3L3pRTURhMm1TeDhYOEZnSEVqbDVqc3dBM003UThqVjdBRFZscVRNRGxH?=
 =?utf-8?B?Y0tuazdvVjVITUJVaStvd3NlcWg5Qkorem43R29JUVBhSTVkQUF4UEUzQjFj?=
 =?utf-8?B?RmhZcGhoS0EwM2J0bERob3BLRks4ZHdGdE9DaFZZaTF4TDZIWGwyTWNXY3dv?=
 =?utf-8?B?eGhIcitjZ0U5UkVPaE1mUkhEeWdZeXN4UEoxM2pmZmZDa3FUZ2ZYSWIrR0Fx?=
 =?utf-8?B?UC9PRWRPNit6QWJweUd6bkoxMDZqRUtjTjBpVy9yR2VGMFRJWno3SlNTVXMy?=
 =?utf-8?B?Tnd1MFN0RjhyMUx3YVdYZExnPT0=?=
X-Microsoft-Antispam-Message-Info: K28b4ZunUOIalItusSzbBNoYjLOLFqOB4kOYWQR0OCxXN3/+5wa2xcIrACpWdO10PUv0GYFe5Zm+z5VSO7bAYzkWFuQKLWKAAvAkjRO0gK1yAsFMyHYo9H48kwaCO+zRNdU9YyXi0WbQd1yYkzX7yh/BaAb3om/cxCMLuVMloKqYYsnh+nOi7zK2gx6csi9PnB4AAnDDtsJaaXiDirjzv3FQGYTzRNZJrMh9VwRDKFCWgmPTwp5aR2F9ioFD1uZvSrqi7wqzIqGDF/nD1i7goTsli8vVWrsYiAqWdCEK8sMW7BZN4kPGVI3JkSMlCcPsURvn6VqGsqJ3lQC/ldt1aoGfk4S5Hn+TNAII1q+D4aY=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0301MB1576;6:W6SLR1xeRLJdeH4aQJCGvC38IeTkBIbVnswshTSY4wKeKgow2DrTL+1K8Cbn+EDkaFpLJNvHT+celhqdki6CtWHmWSQjAw0Ao75TL1i8+1NPOwryYKREW+STmUeGPg0UcVWBeXvzIJbDcs76YbX5Ip11kqJjAQ6NoM45DEEelC1YIBlBJfyWWkLl5QN7/0RlXUX2cwJeILYRes7GaC89ABkHTaMHMrXDymxMpIV++zpnSAzkQTb2jfM30SN7JZ29IA4c+dOGoaJpxVmunvJBxIMjTF6XNS2BmC7bG0Jz4tThaK/ocnxa4myFk5SMeilvD8V2nkHoBzFlOt6maBEoWqeix1RK04uWWGnQRDLKSCPI3TwsD+Nq1BK+kIkwkx97umoiJqQ9fvKS9a9tB6DOh+YLS4q1URZuFHSl1Kwv/rn865jW8LaFrjh+tuyd9sDLsBGz9F9U8EFj2RYgs/TWJQ==;5:ZcD/hA8YVvn3YLn4EdPyGL5bm4JArKewcAzq2lDh3duQgR3g54w4+Mc22MO4QQGLP2ZoQQrmvyhFNfX65WOysdAHZoi8H+V85zB87t6MMcM9D923oXPouWDUuqGHa8mzAyLI/mBjLSC8IOL7Ec6M7nTPPgbUfhnQNnhxrerzDdI=;7:T/P0RqHVGYmSPKWPObUQCgBxaJTfyOvOQ2jiPAOTK2iZoL/YVK4PiGH0DaZjwsDSK448P6v+/VRcEDhth5Kka/oB+HsLle9Skw0rYmGctCeoFtfupWYxvnoCQhL2YzjlZ4sVA2v28EJxX2JCAI98r7ZS+HeFY8YGA4PmM+3f0+nbI+w1JVxD5as+WsQdWsh8PBW+kvh/MUqR5/RHqh5VqjAcwnr6tMDN2vlk6a0Y/gr+vQezrSMryepHi+6J9TNR
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2018 09:19:11.2387 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f966463e-ee79-4fb4-156f-08d60d907c65
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR0301MB1576
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 29 Aug 2018 11:05:45 +0200 Gregory CLEMENT wrote:

> Hi Jisheng,
> =20
>  On mer., ao=C3=BBt 29 2018, Jisheng Zhang <Jisheng.Zhang@synaptics.com> =
wrote:
>=20
> > The rx_offset_correction is RX packet offset correction for platforms,
> > it's not related with SW BM, instead, it's only related with the
> > platform's NET_SKB_PAD.
> > =20
>=20
> But if I undrestood well, the value of rx_offset_correction has an
> influence only when we use HW BM.

The rx_offset_correction is introduced by commit 8d5047cf9ca2 ("net: mvneta:
 Convert to be 64 bits compatible"). It's to support mvneta on 64bit
platforms such as Armada 3700. It's not related with HW BM.

>=20
> However since d93277b9839b ("Revert "arm64: Increase the max granular
> size""), NET_SKB_PAD is 64 for arm64, so in the end rx_offset_correction
> is always 0 for recent kernels.

yes, I mentioned this in email "[query] about recent mvneta patches".
IMHO, we'd better not rely on the platform's L1_CACHE_BYTES value,
we dunno whether the max granular size is increased again in the future.

Thanks

>=20
> Gregory
>=20
>=20
> > Fix the issue by reverting to the original behavior.
> >
> > Fixes: 562e2f467e71 ("net: mvneta: Improve the buffer allocation method=
 for SWBM")
> > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> > ---
> >  drivers/net/ethernet/marvell/mvneta.c | 24 ++++++++++--------------
> >  1 file changed, 10 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethern=
et/marvell/mvneta.c
> > index bc80a678abc3..0ce94f6587a5 100644
> > --- a/drivers/net/ethernet/marvell/mvneta.c
> > +++ b/drivers/net/ethernet/marvell/mvneta.c
> > @@ -2899,21 +2899,18 @@ static void mvneta_rxq_hw_init(struct mvneta_po=
rt *pp,
> >  	mvreg_write(pp, MVNETA_RXQ_BASE_ADDR_REG(rxq->id), rxq->descs_phys);
> >  	mvreg_write(pp, MVNETA_RXQ_SIZE_REG(rxq->id), rxq->size);
> > =20
> > +	/* Set Offset */
> > +	mvneta_rxq_offset_set(pp, rxq, NET_SKB_PAD - pp->rx_offset_correction=
);
> > +
> >  	/* Set coalescing pkts and time */
> >  	mvneta_rx_pkts_coal_set(pp, rxq, rxq->pkts_coal);
> >  	mvneta_rx_time_coal_set(pp, rxq, rxq->time_coal);
> > =20
> >  	if (!pp->bm_priv) {
> > -		/* Set Offset */
> > -		mvneta_rxq_offset_set(pp, rxq, 0);
> >  		mvneta_rxq_buf_size_set(pp, rxq, pp->frag_size);
> >  		mvneta_rxq_bm_disable(pp, rxq);
> >  		mvneta_rxq_fill(pp, rxq, rxq->size);
> >  	} else {
> > -		/* Set Offset */
> > -		mvneta_rxq_offset_set(pp, rxq,
> > -				      NET_SKB_PAD - pp->rx_offset_correction);
> > -
> >  		mvneta_rxq_bm_enable(pp, rxq);
> >  		/* Fill RXQ with buffers from RX pool */
> >  		mvneta_rxq_long_pool_set(pp, rxq);
> > @@ -4547,7 +4544,13 @@ static int mvneta_probe(struct platform_device *=
pdev)
> >  	SET_NETDEV_DEV(dev, &pdev->dev);
> > =20
> >  	pp->id =3D global_port_id++;
> > -	pp->rx_offset_correction =3D 0; /* not relevant for SW BM */
> > +
> > +	/* Set RX packet offset correction for platforms, whose
> > +	 * NET_SKB_PAD, exceeds 64B. It should be 64B for 64-bit
> > +	 * platforms and 0B for 32-bit ones.
> > +	 */
> > +	pp->rx_offset_correction =3D
> > +		max(0, NET_SKB_PAD - MVNETA_RX_PKT_OFFSET_CORRECTION);
> > =20
> >  	/* Obtain access to BM resources if enabled and already initialized */
> >  	bm_node =3D of_parse_phandle(dn, "buffer-manager", 0);
> > @@ -4562,13 +4565,6 @@ static int mvneta_probe(struct platform_device *=
pdev)
> >  				pp->bm_priv =3D NULL;
> >  			}
> >  		}
> > -		/* Set RX packet offset correction for platforms, whose
> > -		 * NET_SKB_PAD, exceeds 64B. It should be 64B for 64-bit
> > -		 * platforms and 0B for 32-bit ones.
> > -		 */
> > -		pp->rx_offset_correction =3D max(0,
> > -					       NET_SKB_PAD -
> > -					       MVNETA_RX_PKT_OFFSET_CORRECTION);
> >  	}
> >  	of_node_put(bm_node);
> > =20
> > --=20
> > 2.18.0
> > =20
>=20

