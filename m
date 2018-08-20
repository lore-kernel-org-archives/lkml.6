Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B3FC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 12:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD9CF2154B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 12:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="CSbEG9Kd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD9CF2154B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbeHTPyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 11:54:36 -0400
Received: from mail-eopbgr00058.outbound.protection.outlook.com ([40.107.0.58]:20224
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726775AbeHTPyg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 11:54:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0qb7/yK4VfUS7NZwRpeB+d0Rr/v4A79hi6rqio2orsM=;
 b=CSbEG9KdyNEkYolUH7JCHghDfy/9bKZkmCvv8v6rHaJdnPYEXSYOG7b1tGXwLt3PwtMpB21rULin8n7tIMjVoqhm+UotZ2z9SNaOqSqUEeV9kgq8g2QVdLB5Sm8nC15CpPRPWShTAz5t4lOS4s8f2ohPPiFpPiSgla5WtemZQhY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
Received: from localhost (217.140.106.49) by
 VI1PR0801MB1392.eurprd08.prod.outlook.com (2603:10a6:800:3b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1059.19; Mon, 20 Aug
 2018 12:39:02 +0000
Date:   Mon, 20 Aug 2018 13:38:59 +0100
From:   Ayan Halder <ayan.halder@arm.com>
To:     Liviu Dudau <liviu.dudau@arm.com>
Cc:     airlied@linux.ie, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, seanpaul@chromium.org, nd@arm.com
Subject: Re: [PATCH] drm: Use horizontal and vertical chroma subsampling
 factor while calculating offsets in the physical address of framebuffer
Message-ID: <20180820123859.GA2054@arm.com>
References: <1534527184-24552-1-git-send-email-ayan.halder@arm.com>
 <20180820110319.GV907@e110455-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180820110319.GV907@e110455-lin.cambridge.arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [217.140.106.49]
X-ClientProxiedBy: CWLP265CA0190.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:4d::34) To VI1PR0801MB1392.eurprd08.prod.outlook.com
 (2603:10a6:800:3b::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36ebeca9-5cd0-42e2-8265-08d60699e8d1
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1392;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1392;3:9NEs6jJ1b5PaO/IoeB1dPT389AefvkOSZASlD0p/8Np2dDPunBMSv+k68aYdGs5V9bW+vwTYtTRrk4tPgWZC7LX63mPAe4ndbxO5oUOpns2XjJFfGm5o4LvHSZXjpiaftYcL/UKE8vDHu7Z0V7eoDO1v3DjNlhf4ShotxjxKuwFNHXmr6tc2Y/0k2qUOcRrooJk9lCSzIJHUUyWlvLX/aVj355m1S+ILhL9N4VrkMFmUB+mI4dZnsYA1yDodOaGB;25:IXOlOzYK2e5M5w0TE4jnM6oxl6+L0ID87pMRLe7wxh1z+9UaHebWNJsMXTLG2O0kgtXzCtPbFuF6rnxS5eWCxYzmu3x89h74pwwcfTC2jREDq/nkcUaoOqozaM1X/M6Nl24TwulU+3xwIIrJIIK7UowXbcEnFH2O+Ey+yPvfB3Cti0wIZbAN8iBAhI/HXOvHGC2agy6lnvc7Qs3FvPQdNUbv+vv6XUvQT5qidfzmIlE+R1mX2AisUvWpkvid/iesEkOei/cnC4VOQw+qy3j+dmFeOdx7QiiAkvleac/yuhGsd3ArktcVO9vp5Gz6M2JE6VXqxuFqC3UYFQk9M5Y1AQ==;31:Sl1gU/jaPCxqdOXTOsyRweUkvvwZ9D6E7lSi6aG5qgfJp/M67TLerpHVKJUcG4xrJzV14PJ5N8iIAb4GRjPHptSTiPNGkESqO5wl3LnRYatIJemqYtq3O9RCyPfeD7wZp6jQqhCEGMwf2z8EMueC7Az9/58nm67WHjl1NRdrrzFzmNweVAWEN0ImvgURrgXISy9+2nW0KIFneVYl+Po7vuJwtx9ekFVJ1iywie4x4fo=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1392:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1392;20:Chuh80/cGvxtxE8DZSxpYt69FE6j/X4jQjtRgscjln6NHdWHquDg4EX45U2o28bHyb8eap2u6iGOWU3MOdtoQAiySdh6fin1dyMvwf+IP37YwMvyLbSq6B/Ag5itAdFZZbaZs554i5sqSc9z8ORwwpUtB6eP6vKultZD/f5rVAWA9x9/snOB1tbeCpy8kCl8dJCp7wZuV1nTNG8dyzNrJm9YPsJBNFWA1XRcp1YoBj4pzSujQxdx+65Cx2ZKPB9FLAbVZeDg2Qo2iezNdhykXe5Df5qzr9ZkPNXiL+g9CBR2BJPPz3vrpJQWVDbE8ONOcMo8IPnnMXlQ8LSN/IGRnw==;4:kKFgwO+ZJ4IpXmN9c++dtpmyDWwkJk7cVnqsTQxfw8pZ2EAK3fyfXs+djLCWbufJy1R/yYin+NkLyeC3/d71nRcSs2z+LOLRP2x4BYtEKZvIzxiWDdUSDRdeivftgNlaf1Cz4bCbOqhkKaW83sohmWTU9JarOnSxHq9rHsrjNI1XcIByV2b7jw6CLLRRJxFPKvOAfo+cU1y98bzIcuJGNGufbxrB20EZEG9LFxnCnFWR7gG6QYRr2KDrBgTz4G4AZ1wiMKv/OVA96AJe9nymzRpKOqCYyVkebupGHdVA+swwB1OkU6paUDICPyQS+IYLCajHxywe48b+Vriu64DTqoAfGylnAZarvILgdW016kE=
X-Microsoft-Antispam-PRVS: <VI1PR0801MB1392B6F64A701DE2812FE4F0E4320@VI1PR0801MB1392.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917)(217544274631240);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699016);SRVR:VI1PR0801MB1392;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1392;
X-Forefront-PRVS: 0770F75EA9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39860400002)(136003)(396003)(376002)(366004)(346002)(199004)(189003)(575784001)(2906002)(86362001)(6486002)(97736004)(7736002)(6246003)(106356001)(16526019)(53936002)(6636002)(305945005)(44832011)(6666003)(6862004)(5660300001)(81156014)(81166006)(4326008)(229853002)(3846002)(6116002)(14444005)(36756003)(52116002)(6496006)(76506005)(478600001)(23726003)(76176011)(8676002)(8936002)(68736007)(966005)(72206003)(33656002)(37006003)(6306002)(26005)(58126008)(386003)(486006)(316002)(446003)(11346002)(2616005)(956004)(105586002)(47776003)(25786009)(16586007)(50466002)(1076002)(66066001)(476003)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0801MB1392;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0801MB1392;23:+xpm90OJKYuv7i9UUaYNVyRL4nacdUgm0/2yDzQ?=
 =?us-ascii?Q?tWzjPJ2xbaC6w+4slpvIo4aYH9QJ7mql0o/PQ3sBRM5IHXEVD4xbSQC3waW1?=
 =?us-ascii?Q?TMw0pU4zHHTNOhiDqs1+AiIVkll1fUAwAYH358rZldjXNgXMTHs+VtAouv1X?=
 =?us-ascii?Q?UlCWO9pziCpAWgUgNGw4d9HPlC3lkMJbrdjvJYd9ryjUjrMdfX7qrOfKr6bL?=
 =?us-ascii?Q?aVXfNyPMkmSIUb7wgbkSSL8EMDD2PbL8H/kyzTaPOZK45+b19AEjc6im1nEP?=
 =?us-ascii?Q?URG6vTdgO6DZFiIc0uW7AeP+aKF/CktBMMpGKz97uSLIv1d/7pgrs3ryjUm7?=
 =?us-ascii?Q?1lzst+39kc3CSTPt+g3A16aubkFoF5nhpB0mJcww3YbhEqFIItSgF4pqwQHB?=
 =?us-ascii?Q?4iKcDkxNP/mQRqFiwMJ5jQI1ouF9ZCDOGLxG8c4a/hK3qgYlhXwvgSJzYI/j?=
 =?us-ascii?Q?zvmlMZxs/Gn6B0L362yAiD89ABVjbIDFJb+1xOxIcwHamRY7i36Ce5ZlXynB?=
 =?us-ascii?Q?OLA06ZpqrC4AN3ZkQwzt8eDBgOE/m2Yo22CJ1AlcaPHa1MFUj8VZwEVFTODF?=
 =?us-ascii?Q?VM//wbdWNPxhDtXBIqBhBQD89iPBrpAjIP4dP3H8OLsXnYAz2Jz4SmGTKmMp?=
 =?us-ascii?Q?2+KW1jzr8nts9W0WYtM+w26oBHT/yG0vfYC6Z7X4aNYXkHOylMnTStw6819i?=
 =?us-ascii?Q?b1S2WaPWT8lfIWKLq7fJ4+Zttc3MnUaLyExb0l12z75O2Ji4efvxiGc+WOBU?=
 =?us-ascii?Q?5uQAn33KeJxn2L6gqTabbMaVoLIMwfr7iYTvc74u+zS5vxUhhuuHxPQRP5DI?=
 =?us-ascii?Q?I0P65OnicYq4g2mGXdWs1j8TReQ1fMviS8W37HEPyttG4cN1Kdm/L8tNzfZ+?=
 =?us-ascii?Q?pYzn/+TGo6yUiuDYVp/XcZwhBTvy29w8b/vANCRcbRt+L57bho1nAMtDrrr4?=
 =?us-ascii?Q?E3WKd6UHG0pXtvwPRHDFoSCdknB+yULJWrfDIopqMRB2/4kLU3L35V+bPsdS?=
 =?us-ascii?Q?MfKPHBzxXK5FuB/9GL3j1/WEwu9cqPgg1ev2hfch/HBJAPXKfJw8Pj1J2OMg?=
 =?us-ascii?Q?2KLEH8B5NCAdmYh21KwhbW1AJNAbBsYJZr+RsF22eyR51oVHC3B3bq5bGiqu?=
 =?us-ascii?Q?LPkO+/E/mF6ydDKSeX/2BmYcA8xASGsswpnfBcZh9hawtICPQbqxuzXoTlvl?=
 =?us-ascii?Q?v764m6dybDcZVb2CCUmk7SEg0Hp2/wqBfhcrQvLGT+UYUjJCv8jZDKchF/Ec?=
 =?us-ascii?Q?BXi1+9NFGcGk2BN3QPVJkXoMnmvUZknqDUxoDqZbeLTTYGlI1pFvw1f6B/jB?=
 =?us-ascii?Q?MTuKbAJ4qDSbM9r8B4rOP2VLMN53eBKoW6p9l8oC5Qj2eJ81V7cwmiD68OQj?=
 =?us-ascii?Q?xuURtTpOZqTGgxag12WuLN0ZJMiOnyUXkxDPI9qHVkimXIGTSx9I0QVhWvEw?=
 =?us-ascii?Q?P8/FZcInH2A=3D=3D?=
X-Microsoft-Antispam-Message-Info: xna1qZ72InyqiGyG1CPZ5zYho6GjgYSZTVNe9GWhfuFz8U9sY/uMfh0mJl2+W02cvxROTjehV05CYwmiWLfFQxh8xbnqtPsvN0jt3HFrHvIQA3iaYOe8EflbTtQI4YPnyGIzrA6hjF3Y4XhT3V7USvRsRpwbUYbiNVK5wXBSP/yOAamrBTiG/Np7jQGQQIAI7pDIbay3oNFuEsOo7Kv3FNEEoEl9/bhKRc0z2M6W3Ho6sGmS4PGp/wuQPbMLIzrQJxusuhdbu0FzdnOziYMVP75HIS/XGWqsg8S5K+5lHP1krynwWBRUfu1/BBRUoOPSMkojNEkNI6ZbvymxYswnIRorbPzq2GBJCw0yvefavKo=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1392;6:G57UAE4E5fJ4qsVrYw3/cBWT6ckUgELlXpRDQQnArXMKJBCNP7deXTZb+H6Kd5/gzLi51a3qVT1eXrcDJaIazPFqA2wP6mLnALeFoiursEP4cpibLwut1/r/UzeBPQd4WNQls4exfxxrlDDL0Ko49j4Np9USuGdXBlc15CnzT8AHorxjqExf4YW/Xb1JF14YEdB3W93dzokYHnBme+Ud0b/YVGh6ZImYl/wDLdNaoKZtQe+uwQYDUpU+dUyMGV8eW2GUjRsELdF6aGmkaPmmUPsh8xm03zIOIoyuqHXPsmhuqBbBgvIwCsIEoC/CfeOV2sKluadLf12sayYp2ndkxYrcLqRVZYYGVkqr7HyAmU85lmc8VIMpVH2L6YknU7TEIp351Gnuc4tSOB7+oxeNu+iRWIda/luqNrWm1TsbX/tWok6GqwBEYiL6qMc2RIkQ1V9l66XybDdLZF1640fslg==;5:bonWhFu+fgyn0hsHDfKH04OgyH5p97P9mrZ7PUsq8qD8tlKtkfaOPgsDLmFIU6CLTuvJyi2Fzb/CUu2MluzzS6Ep8/WEjsUhiVcvwLPvV7YBzjUYIf3C+/1hVJVKo1oK1tFN2g+++4xbhB+OsQF57x/Fd5NvMyIZ99Kddy5NtP0=;7:JbCRULW2EtnpgCVyT7bL0o+EKjfPQG53gcuJ80RWw05TTKUnYT2b2+CmBgMIv80aKDOWZpDWoYyRAlYobUGbRS9lwaTfy7BdnQeWHz26tAas3ZFJOLssjTV6Xz0wZ6YB1j9deEf0SyxfcCleuXmptKdT4pVcTncnAN84YdSKJVEZIupB/vPYv3tHTJJU0d8K0zmeKbHb9Pw+eH5rU/rLO2k+dsFNukbClsjkBTW4A1uV6aSh5XR63iox5Zig5V9/
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2018 12:39:02.3970
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36ebeca9-5cd0-42e2-8265-08d60699e8d1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1392
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2018 at 12:03:19PM +0100, Liviu Dudau wrote:
> On Fri, Aug 17, 2018 at 06:33:04PM +0100, Ayan Kumar Halder wrote:
> > For multi-planar formats, while calculating offsets in planes with index greater than 0
> > (ie second plane, third plane, etc), one needs to divide (src_x * cpp) with horizontal
> > chroma subsampling factor and (src_y * pitch) with vertical chroma subsampling factor.
> > 
> > The reason being that the planes contain subsampled (ie reduced) data (by a factor of 2) and thus the
> 
> drop the extraneous "the" at the end of the line.
> 
> > while calculating the byte position coresponding to the x and y co-ordinates, one needs to be
> 
> and drop the extraneous "be" at the end of this line.
> 
> > divide it with the sampling factor.
> > 
> > Signed-off-by: Ayan Kumar halder <ayan.halder@arm.com>
> 
> Otherwise, it looks good to me!
> 
> Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
>
Thanks Liviu. I will update the commit message and push this in
drm-misc-next.

> Best regards,
> Liviu
> 
> > ---
> >  drivers/gpu/drm/drm_fb_cma_helper.c | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_fb_cma_helper.c b/drivers/gpu/drm/drm_fb_cma_helper.c
> > index b127061..47e0e2f 100644
> > --- a/drivers/gpu/drm/drm_fb_cma_helper.c
> > +++ b/drivers/gpu/drm/drm_fb_cma_helper.c
> > @@ -86,14 +86,21 @@ dma_addr_t drm_fb_cma_get_gem_addr(struct drm_framebuffer *fb,
> >  {
> >  	struct drm_gem_cma_object *obj;
> >  	dma_addr_t paddr;
> > +	u8 h_div = 1, v_div = 1;
> >  
> >  	obj = drm_fb_cma_get_gem_obj(fb, plane);
> >  	if (!obj)
> >  		return 0;
> >  
> >  	paddr = obj->paddr + fb->offsets[plane];
> > -	paddr += fb->format->cpp[plane] * (state->src_x >> 16);
> > -	paddr += fb->pitches[plane] * (state->src_y >> 16);
> > +
> > +	if (plane > 0) {
> > +		h_div = fb->format->hsub;
> > +		v_div = fb->format->vsub;
> > +	}
> > +
> > +	paddr += (fb->format->cpp[plane] * (state->src_x >> 16)) / h_div;
> > +	paddr += (fb->pitches[plane] * (state->src_y >> 16)) / v_div;
> >  
> >  	return paddr;
> >  }
> > -- 
> > 2.7.4
> > 
> 
> -- 
> ====================
> | I would like to |
> | fix the world,  |
> | but they're not |
> | giving me the   |
>  \ source code!  /
>   ---------------
>     ??\_(???)_/??
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
