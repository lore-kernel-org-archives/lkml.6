Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17704C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9326020881
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="h/uxHwrT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9326020881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbeIJTGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 15:06:00 -0400
Received: from mail-eopbgr30048.outbound.protection.outlook.com ([40.107.3.48]:45472
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728187AbeIJTGA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 15:06:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ojF0Ud79ibeYDw8YO7ysgNuMm5sqPCYyrjausIvtW0c=;
 b=h/uxHwrTYW37ufg6f67wLgnEeZNBbbY6aF6kPQ7Qd6DFZKFREJZQ6AbeftfgBsqIn1rNHo14UBN8QkOD1jXowTHgSFBYjiFnjoTbCppgvspUDAhpaNQWyXDO+xVWpjrH68sNQfsIyWqsd6qPsLH+uma72hkTNy+8FAWoJnIO7xw=
Received: from localhost (217.140.106.49) by
 DB6PR0801MB1383.eurprd08.prod.outlook.com (2603:10a6:4:b::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.16; Mon, 10 Sep 2018 14:11:37 +0000
Date:   Mon, 10 Sep 2018 15:11:34 +0100
From:   Ayan Halder <ayan.halder@arm.com>
To:     Brian Starkey <brian.starkey@arm.com>,
        dri-devel@lists.freedesktop.org, daniel@fooishbar.org,
        airlied@linux.ie, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, seanpaul@chromium.org,
        linux-kernel@vger.kernel.org, alexandru-cosmin.gheorghe@arm.com,
        liviu.dudau@arm.com, tfiga@chromium.org, hoegsberg@chromium.org
Cc:     nd@arm.com
Subject: Re: [RFC PATCH v2 1/3] drm/fourcc: Add 'bpp' field for formats with
 non-integer bytes-per-pixel
Message-ID: <20180910141134.GA19567@arm.com>
References: <20180823152343.6474-1-brian.starkey@arm.com>
 <20180823152343.6474-2-brian.starkey@arm.com>
 <20180831081730.GM21634@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180831081730.GM21634@phenom.ffwll.local>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [217.140.106.49]
X-ClientProxiedBy: VI1PR0902CA0051.eurprd09.prod.outlook.com
 (2603:10a6:802:1::40) To DB6PR0801MB1383.eurprd08.prod.outlook.com
 (2603:10a6:4:b::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46f5cd10-9f79-4224-de26-08d6172752c1
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1383;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1383;3:3cjr6yVidp9SGUL5sGhn7POuQXxdKjBrUONwmD8fGESW6wd9PaXB8MVpH7h3CZgYPtWOMyaQWVcZVTXahDoVqhpyQATEAWkEvC2StmLdVjJf3VAaDBwelqLEzGEuEnb2qko93VaVHrEwYIF7eEJpqCA9w3QK1YvOaK9CWJ5/b20t3Mz7Qy4xBC9EsW7CCDsnoA10ofepwzFbV2abmWgsIoDswzta5loU9F0K5PXWMVAIgRDXVqqMnCu6SsG/q33T;25:MAwK2AAhpRuFMT+UAaNfEE2Jf16j7kJ4M7RTctE4q5GQj3Pb0njxnuQLNRyAAdt0jVyYqhF9V78+GrUnoVStUTbtwHLst8H/ujVD2jyL9olUVKMwC1ZWLy7qLv0PpUw6wZgGmeFYhLAaJgJH2dM6zVXaoyO0y6t1WWIxi3Br7P63CbH7Wc6EBnvvSQqD35gkPP3YfQwLhNE3vMsa4X/yObaybC2hZjNko1hZuvGx0VBLsnhnQSD1j9ivYuPKTw5nX4KKGZkY1KcH0dG2FlB4qeSdesxVZ4V1ShVX9jOQzptOlFtbm4yjtzitvJ7f2VzifF2Ve3vzd5EjydXwtb8GiA==;31:1K3Jo53MPOBOiuqEk6xezbZzyNnmPbgr1XbhWghrYnp1ugMvfh2klX8KRDAQ+vxY6X3KDKyMK3n/6CwcEMMSIy4duTj3kNwFz4ShJcLh+mcuh+3P0KPzg+awwhwBtrpqwOJdoKAL6hfyLqecZsuCZo/kkmLwFvM2Qpdfx9xoJsQ2qAUD6bRGs8ldXKghXpNkxIm9Uy+aZNgRIzDBA4T2g3gfNcFby4ZxCu6C2TYpPdw=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1383:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1383;20:xyiUmPshqgAjzL3d0mZ8xlcu5b9viBt6LtBfZR2zBK7BrIYZU5qZ74gjYwcEpa0SX5YVsugudg9W9nEpfW7pCtpRDiGe3Hc95sb+6U4G/CU+e7bemhBdGnDtJPdR5tnn6hAVUrlyket4p2UAm++t3qqIb5ULmdtZTA7GwDH9QDSKyAGJ8qLikdfqH1Drq/EHHgtvOY3oTwcc5Njl6K0QDdMETWqakFxxPCLSoQ6Vh6iTmV2+ZK/ZErW9I2QgMKONnxXKrSyvLXubkVk1KruAXarmkkXPrxgqJ20MrU682o6fBWrG/s47dMqC5ERu1EVLzonPUA4TknR+0apYESbjxNnWdFgs59lJO2q89CFQepQX7XXIFXuS9mXVxbgigAAt9ByNjDByqthwBrkh2s5e1eXim6FncnHYE8ncimwhjEE=;4:OD0rU76VUeWo35fuITbaHCIAvnlm9FeoZmIjaFPF4mnyvdlIzdoPdt5XEc92nLVNUQc0MerR4+HRkJA31wwE/yEAT3GFARHZ9YqrnqwZ4MO6/16oOXELlNghgFQwuXyGADdXz+dLZYZtDGbYqw7Esr9S6Fe8JAFoAtEgHI/ZsJBwngg6+7kN9DdmV1cSME0Uib7hCYKbY3OhndrDHzkdizwWa+TzhF3Jj1eElC5OeZuW4jAq4JhCS5TWei4t/1HatgP1hOw1qjdddlpFpwhWqkz+dvsCEDCefx6Za0ZBn9mWClepqDQmGHgc1n4p+wlSOrq51afDzEgnU/Uj95hsquSGFimx81TgARjH6Tt9vKw=
X-Microsoft-Antispam-PRVS: <DB6PR0801MB13838613D64144099D55368AE4050@DB6PR0801MB1383.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917)(217544274631240);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(3002001)(93006095)(93001095)(10201501046)(3231344)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050);SRVR:DB6PR0801MB1383;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB1383;
X-Forefront-PRVS: 07915F544A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(396003)(346002)(366004)(136003)(39860400002)(376002)(199004)(189003)(33656002)(50466002)(76176011)(52116002)(6496006)(25786009)(4326008)(53386004)(2906002)(6246003)(5660300001)(587094005)(26005)(66066001)(478600001)(6116002)(3846002)(1076002)(386003)(6346003)(23726003)(16526019)(36756003)(6306002)(217873002)(106356001)(72206003)(6666003)(105586002)(956004)(47776003)(97736004)(476003)(2616005)(6486002)(53936002)(229853002)(58126008)(86362001)(446003)(11346002)(16586007)(81166006)(316002)(966005)(8676002)(14444005)(486006)(76506005)(44832011)(81156014)(305945005)(8936002)(68736007)(7736002)(18370500001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0801MB1383;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR0801MB1383;23:0F931TMxDJG9Mclg3SPqAQ9lmC4hinKwqonBS0S?=
 =?us-ascii?Q?uyh21VVZsmzYHpWccXLUXcGpRzvSRFQJms6Z0VSwdJsuMMwyRFqXJadX798S?=
 =?us-ascii?Q?KhElooNdBKqawABLLDjX1XKJ21K7H4LvPlWJEraDk3K7USHw0OfZsmdvyFRo?=
 =?us-ascii?Q?hbVzqi8ScQW+IDBDV7IK2gOWPkypiIXtulLLayZaralgjchK4U5JM54fDsm4?=
 =?us-ascii?Q?6lowrVi46e0BTzvYTFv74SF3+sAY0O7GZKhw/pwzQdGpXOFqZwH12dfYzohr?=
 =?us-ascii?Q?aXWx4U40CzGjFZGzW7H1hZJXVCQrmEO5EBZjB4e24s1uVfJxFgxWyohJBl80?=
 =?us-ascii?Q?gSgiLRxRYOvnvHZM4tBRUMH/RzMh59fFXlTg5Ua7VQ3SuRANIGFWaznI7Lkn?=
 =?us-ascii?Q?swpgN1DOGEjxnTDITt8d1oajuUpjQYpyu15ps4LTQrRBZlETsPd9BJ56DpK7?=
 =?us-ascii?Q?XcOgt2lkVETECTCPAmmbqGOuFx1VlX/UvHc8oP2FDt5JtY9bu3nDNXhnyJ/3?=
 =?us-ascii?Q?X+T8e1974X1BtHqay0OVydomrxLzzA+oBHkCBxRb/vIPY2KpthXwxtecNcYN?=
 =?us-ascii?Q?2FAMq4dipjvGtsxrRANJUC2AIpMRm1onZV+dldFQX2ZiunnzfQtpM331kbyR?=
 =?us-ascii?Q?ZrqrIi1Tsyk6+9dkmlUEdNFkxCVYWFya/WDA9Dchew8mJqDfzmSHLpKxB4ij?=
 =?us-ascii?Q?oVOEIZAbmJZQCb1KdY1YAOmeAs+8dLHk7LiV1plW+jLFqElZysmDdfokLSaA?=
 =?us-ascii?Q?DQNHTylPVpXfGvSHuNhVJzTzc4unhXtiARw0IvLdSYqrPji/y414pWkqOkGT?=
 =?us-ascii?Q?p63sY5bpo16EmY8EiR6fbu5Mr0iYfYD3jZ+70BvxOfIKLabsE3RQL+cKEEdw?=
 =?us-ascii?Q?gc851/fWtjrq+jBUfgSNJk0p/F8DwZve4gKVmIgVrS7tr6U8DLXTbAe5fczn?=
 =?us-ascii?Q?uRdJtDXQ70TQTBHvLcH+np7Rdo9TRKtS+/hDiZByMwd0fh/1Ok3UWEVpkPKw?=
 =?us-ascii?Q?f7CUxDLfCySJiVkw01T1CAzgJ721xEAYKOUjxLgK9XR1srodbRMgwQXsq8Q9?=
 =?us-ascii?Q?njjidnnVaxePzcpaCRUkSJWAN32HoJDrpPLPW4guENdMOyN9GvsMEsI1mkET?=
 =?us-ascii?Q?cBLLHRw845h2zF7cFPfDTOdRwT4yXxRsmR82GTWqryxrWKZ/LeFkkhEGNCuN?=
 =?us-ascii?Q?ZJ5IKERl2Q63VU4TuO+Rmdet7FYfeY0Mzt2HXQfEwWnmmxaSv0v1QM6kdaBg?=
 =?us-ascii?Q?qhNTGhA6tcT5vXehMT8YNGwXViGnahSREpUiTAj8IKZnrzkW/nGCRJTVYJK6?=
 =?us-ascii?Q?/ZsqC48qtKpa+PQPIOV8EqlFTw4Q8STNvul5A7HMrMzQXQjzqtaPDB7Pk3O2?=
 =?us-ascii?Q?U4CX7jxF23Ynfs6Fp3q0qI9AWh5+7nN+kA+e4k1SYN+iVuTSeDjouLE/zUi0?=
 =?us-ascii?Q?4vbEAG1pzOgGoNHgCZGiDG6lupVZYgmd+pPaERI0h63MHAUf5MYkj?=
X-Microsoft-Antispam-Message-Info: ofEwNFibGDpJovcSsvHOQFr9jW2Ro58hZGq/DVDCUPsJDAG5Su8Ddf6polam/aYXam8DVQFhKQkvt7+GjUbdnpezlQiWJYaQLGYdKLfvMzxFQACF29jO830R0Q+y9/+/XAnPiroOOQgljzol6yRi2xqnJr8S8XtYCsX+wdk9Xs0G1iXfooh3dBOuZ2OL0RjA2Tr3G8Fped86Lvl2Drrz5jsja++uEL2tqxFdX8o1mBwo6O5+RVki7Kxcz1Tp/zCetfdzLNbeUFCWvEG/+v9nQ2jd8mgstS1/ebp2CH+1igUr8bTOAy9QutSpr5X2n9744gNitHY9FRrFAYOxmFJ6ofmu0wYfAwGdXx3kDrpFEns=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1383;6:yFS5NZEIVEE0WosIVxb0kA5nht+KXYQv1pu6vplrtJzdeve/H06YvZyZug0uddxy5DUpTVJQkl0ji8u3+GIqkK726It+6XMSusJXwLy98SXEl30gM8HfrPt3KBAT8gwCBqNYHAKtxx1JypgfRKPALT8vp17a+RlH3Yn8/sVbPVGM8sopN+ode7xLBb5a9hU72PoJeWJsOOT3BnpABvCO3jlm8QY+EQ0fn4ojibhh9ZS1bkYrz6NynfvQgXkZ7P1wqyG9R32Z9oIzZcCmrQVoLgOaQaj9MG356gCEy/Il3AOkMpQvw9/Hz0h+7B7PvWOIQ9tw3LSX28m0GUatuhpIqkdYmzcbmXkJwVXBXyMlZMVelZmjwak9WryZK+XFkHuqZ2tgwzwZIdDyOHuIFjoNQhONgT+fzvOEOQZwJSQ9MzOaPq7p9NcURohv2E/S8jtV2rWOgF+qUaybodzHMTbGUg==;5:sfSezh8aax1OtuO7j2dsjzTLniYPh5WXbzVUXNIGTByVn3Hgv/K0J6y16fcMUSaaNZOv+rArKqPGAY6dfQiQzRX6Uyrj0a+YuMmO8br19zNL47CtIG8M/2fOKhEi7YE+b33jTPY6PW0H8UHgMU3X3tgZVPJj2UUNrNehKi6ett4=;7:fCBjaqpaQkOj1BxDu4ha4TlDvVuo/F4nhxE+iUYT/0QPPsWLNClBwRcrGyavhOKuQIBIoiq6pXaWutqmO6MEax5csQzuuQULs2VHq2E9Akbad2djVenllwjauB4sFmL0HCFYKpmd1PZvlm3CA564aLu6Jm9jsBZ7WWamt8KrHFup4/KZBQmcxSB9UXFehXgxs3GgkDMcOb7wA0W0+mbRAkJ4Q9Grs16myKI+E0Ys5wHpEQ0Q1hei+bMhstla8O7s
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2018 14:11:37.7422 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46f5cd10-9f79-4224-de26-08d6172752c1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1383
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 10:17:30AM +0200, Daniel Vetter wrote:
> On Thu, Aug 23, 2018 at 04:23:41PM +0100, Brian Starkey wrote:
> > Some formats have a non-integer number of bytes per pixel, which can't
> > be handled with the existing 'cpp' field in drm_format_info. To handle
> > these formats, add a 'bpp' field, which is only used if cpp[0] == 0.
> > 
> > This updates all the users of format->cpp in the core DRM code,
> > converting them to use a new function to get the bits-per-pixel for any
> > format.
> > 
> > It's assumed that drivers will use the 'bpp' field when they add support
> > for pixel formats with non-integer bytes-per-pixel.
> > 
> > Signed-off-by: Brian Starkey <brian.starkey@arm.com>
> 
> I assume you still require that stuff is eventually aligned to bytes? In
> that case, can we subsume this into the tile work Alex is doing? It's
> essentially just another special case of having storage-size units
> measured in bytes which span more than 1x1 pixel. And I kinda don't want a
> metric pile of special cases here in the format code, because that just
> means every driver handles a different subset, with different bugs.
> -Daniel
> 
> > ---
> >  drivers/gpu/drm/drm_fb_cma_helper.c          |  6 +++-
> >  drivers/gpu/drm/drm_fb_helper.c              |  8 +++--
> >  drivers/gpu/drm/drm_fourcc.c                 | 50 ++++++++++++++++++++++++++++
> >  drivers/gpu/drm/drm_framebuffer.c            |  8 ++---
> >  drivers/gpu/drm/drm_gem_framebuffer_helper.c |  3 +-
> >  include/drm/drm_fourcc.h                     |  4 +++
> >  6 files changed, 70 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_fb_cma_helper.c b/drivers/gpu/drm/drm_fb_cma_helper.c
> > index 186d00adfb5f..e279d70d3e60 100644
> > --- a/drivers/gpu/drm/drm_fb_cma_helper.c
> > +++ b/drivers/gpu/drm/drm_fb_cma_helper.c
> > @@ -118,13 +118,17 @@ dma_addr_t drm_fb_cma_get_gem_addr(struct drm_framebuffer *fb,
> >  {
> >  	struct drm_gem_cma_object *obj;
> >  	dma_addr_t paddr;
> > +	u8 bpp = drm_format_info_plane_bpp(fb->format, plane);
> > +
> > +	/* This can't work for non-integer bytes-per-pixel */
> > +	WARN_ON(bpp % 8);
> >  
> >  	obj = drm_fb_cma_get_gem_obj(fb, plane);
> >  	if (!obj)
> >  		return 0;
> >  
> >  	paddr = obj->paddr + fb->offsets[plane];
> > -	paddr += fb->format->cpp[plane] * (state->src_x >> 16);
> > +	paddr += (bpp / 8) * (state->src_x >> 16);
> >  	paddr += fb->pitches[plane] * (state->src_y >> 16);
> >  
> >  	return paddr;
> > diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
> > index 0646b108030b..ab369f250af4 100644
> > --- a/drivers/gpu/drm/drm_fb_helper.c
> > +++ b/drivers/gpu/drm/drm_fb_helper.c
> > @@ -1572,6 +1572,7 @@ int drm_fb_helper_check_var(struct fb_var_screeninfo *var,
> >  	struct drm_fb_helper *fb_helper = info->par;
> >  	struct drm_framebuffer *fb = fb_helper->fb;
> >  	int depth;
> > +	u8 bpp = drm_format_info_plane_bpp(fb->format, 0);
> >  
> >  	if (var->pixclock != 0 || in_dbg_master())
> >  		return -EINVAL;
> > @@ -1580,14 +1581,14 @@ int drm_fb_helper_check_var(struct fb_var_screeninfo *var,
> >  	 * Changes struct fb_var_screeninfo are currently not pushed back
> >  	 * to KMS, hence fail if different settings are requested.
> >  	 */
> > -	if (var->bits_per_pixel != fb->format->cpp[0] * 8 ||
> > +	if (var->bits_per_pixel != bpp ||
> >  	    var->xres > fb->width || var->yres > fb->height ||
> >  	    var->xres_virtual > fb->width || var->yres_virtual > fb->height) {
> >  		DRM_DEBUG("fb requested width/height/bpp can't fit in current fb "
> >  			  "request %dx%d-%d (virtual %dx%d) > %dx%d-%d\n",
> >  			  var->xres, var->yres, var->bits_per_pixel,
> >  			  var->xres_virtual, var->yres_virtual,
> > -			  fb->width, fb->height, fb->format->cpp[0] * 8);
> > +			  fb->width, fb->height, bpp);
> >  		return -EINVAL;
> >  	}
> >  
> > @@ -1949,11 +1950,12 @@ void drm_fb_helper_fill_var(struct fb_info *info, struct drm_fb_helper *fb_helpe
> >  			    uint32_t fb_width, uint32_t fb_height)
> >  {
> >  	struct drm_framebuffer *fb = fb_helper->fb;
> > +	u8 bpp = drm_format_info_plane_bpp(fb->format, 0);
> >  
> >  	info->pseudo_palette = fb_helper->pseudo_palette;
> >  	info->var.xres_virtual = fb->width;
> >  	info->var.yres_virtual = fb->height;
> > -	info->var.bits_per_pixel = fb->format->cpp[0] * 8;
> > +	info->var.bits_per_pixel = bpp;
> >  	info->var.accel_flags = FB_ACCELF_TEXT;
> >  	info->var.xoffset = 0;
> >  	info->var.yoffset = 0;
> > diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
> > index 3b42c25bd58d..bb28919c32f3 100644
> > --- a/drivers/gpu/drm/drm_fourcc.c
> > +++ b/drivers/gpu/drm/drm_fourcc.c
> > @@ -272,10 +272,60 @@ int drm_format_plane_cpp(uint32_t format, int plane)
> >  	if (!info || plane >= info->num_planes)
> >  		return 0;
> >  
> > +	/*
> > +	 * Not valid for formats with non-integer cpp,
> > +	 * use drm_format{_info}_plane_bpp instead
> > +	 */
> > +	WARN_ON(!info->cpp[0]);
> > +
> >  	return info->cpp[plane];
> >  }
> >  EXPORT_SYMBOL(drm_format_plane_cpp);
> >  
> > +/**
> > + * drm_format_plane_bpp - determine the bits per pixel value
> > + * @format: pixel format (DRM_FORMAT_*)
> > + * @plane: plane index
> > + *
> > + * Returns:
> > + * The bits per pixel value for the specified plane.
> > + */
> > +int drm_format_plane_bpp(uint32_t format, int plane)
> > +{
> > +	const struct drm_format_info *info;
> > +
> > +	info = drm_format_info(format);
> > +	if (!info)
> > +		return 0;
> > +
> > +	return drm_format_info_plane_bpp(info, plane);
> > +}
> > +EXPORT_SYMBOL(drm_format_plane_bpp);
> > +
> > +/**
> > + * drm_format_info_plane_bpp - determine the bits per pixel value
> > + *
> > + * Convenience function which handles formats with both integer
> > + * and non-integer bytes-per-pixel.
> > + *
> > + * @format: pixel format info structure
> > + * @plane: plane index
> > + *
> > + * Returns:
> > + * The bits per pixel value for the specified plane.
> > + */
> > +int drm_format_info_plane_bpp(const struct drm_format_info *info, int plane)
> > +{
> > +	if (plane >= info->num_planes)
> > +		return 0;
> > +
> > +	if (info->cpp[0])
> > +		return info->cpp[plane] * 8;
> > +
> > +	return info->bpp[plane];
> > +}
> > +EXPORT_SYMBOL(drm_format_info_plane_bpp);
> > +
> >  /**
> >   * drm_format_horz_chroma_subsampling - get the horizontal chroma subsampling factor
> >   * @format: pixel format (DRM_FORMAT_*)
> > diff --git a/drivers/gpu/drm/drm_framebuffer.c b/drivers/gpu/drm/drm_framebuffer.c
> > index 8c4d32adcc17..7e00360ff70d 100644
> > --- a/drivers/gpu/drm/drm_framebuffer.c
> > +++ b/drivers/gpu/drm/drm_framebuffer.c
> > @@ -185,20 +185,20 @@ static int framebuffer_check(struct drm_device *dev,
> >  	for (i = 0; i < info->num_planes; i++) {
> >  		unsigned int width = fb_plane_width(r->width, info, i);
> >  		unsigned int height = fb_plane_height(r->height, info, i);
> > -		unsigned int cpp = info->cpp[i];
> > +		unsigned int bpp = drm_format_info_plane_bpp(info, i);
> >  
> >  		if (!r->handles[i]) {
> >  			DRM_DEBUG_KMS("no buffer object handle for plane %d\n", i);
> >  			return -EINVAL;
> >  		}
> >  
> > -		if ((uint64_t) width * cpp > UINT_MAX)
> > +		if ((uint64_t) DIV_ROUND_UP(width * bpp, 8) > UINT_MAX)
> >  			return -ERANGE;
> >  
> >  		if ((uint64_t) height * r->pitches[i] + r->offsets[i] > UINT_MAX)
> >  			return -ERANGE;
> >  
> > -		if (r->pitches[i] < width * cpp) {
> > +		if ((uint64_t) r->pitches[i] * 8 < (uint64_t) width * bpp) {
> >  			DRM_DEBUG_KMS("bad pitch %u for plane %d\n", r->pitches[i], i);
> >  			return -EINVAL;
> >  		}
> > @@ -476,7 +476,7 @@ int drm_mode_getfb(struct drm_device *dev,
> >  	r->height = fb->height;
> >  	r->width = fb->width;
> >  	r->depth = fb->format->depth;
> > -	r->bpp = fb->format->cpp[0] * 8;
> > +	r->bpp = drm_format_info_plane_bpp(fb->format, 0);
> >  	r->pitch = fb->pitches[0];
> >  
> >  	/* GET_FB() is an unprivileged ioctl so we must not return a
> > diff --git a/drivers/gpu/drm/drm_gem_framebuffer_helper.c b/drivers/gpu/drm/drm_gem_framebuffer_helper.c
> > index acfbc0641a06..dfe224ccaeba 100644
> > --- a/drivers/gpu/drm/drm_gem_framebuffer_helper.c
> > +++ b/drivers/gpu/drm/drm_gem_framebuffer_helper.c
> > @@ -161,6 +161,7 @@ drm_gem_fb_create_with_funcs(struct drm_device *dev, struct drm_file *file,
> >  		unsigned int width = mode_cmd->width / (i ? info->hsub : 1);
> >  		unsigned int height = mode_cmd->height / (i ? info->vsub : 1);
> >  		unsigned int min_size;
> > +		u8 bpp = drm_format_info_plane_bpp(fb->format, i);
You might want to pass info here instead of fb->format because fb is
NULL. ie drm_format_info_plane_bpp(info, i);

> >  
> >  		objs[i] = drm_gem_object_lookup(file, mode_cmd->handles[i]);
> >  		if (!objs[i]) {
> > @@ -170,7 +171,7 @@ drm_gem_fb_create_with_funcs(struct drm_device *dev, struct drm_file *file,
> >  		}
> >  
> >  		min_size = (height - 1) * mode_cmd->pitches[i]
> > -			 + width * info->cpp[i]
> > +			 + DIV_ROUND_UP(width * bpp, 8)
> >  			 + mode_cmd->offsets[i];
> >  
> >  		if (objs[i]->size < min_size) {
> > diff --git a/include/drm/drm_fourcc.h b/include/drm/drm_fourcc.h
> > index 3e86408dac9f..d4af4dab1623 100644
> > --- a/include/drm/drm_fourcc.h
> > +++ b/include/drm/drm_fourcc.h
> > @@ -36,6 +36,7 @@ struct drm_mode_fb_cmd2;
> >   *	use in new code and set to 0 for new formats.
> >   * @num_planes: Number of color planes (1 to 3)
> >   * @cpp: Number of bytes per pixel (per plane)
> > + * @bpp: Number of bits per pixel (per plane), only valid if cpp[0] == 0.
> >   * @hsub: Horizontal chroma subsampling factor
> >   * @vsub: Vertical chroma subsampling factor
> >   * @has_alpha: Does the format embeds an alpha component?
> > @@ -45,6 +46,7 @@ struct drm_format_info {
> >  	u8 depth;
> >  	u8 num_planes;
> >  	u8 cpp[3];
> > +	u8 bpp[3];
> >  	u8 hsub;
> >  	u8 vsub;
> >  	bool has_alpha;
> > @@ -66,6 +68,8 @@ drm_get_format_info(struct drm_device *dev,
> >  uint32_t drm_mode_legacy_fb_format(uint32_t bpp, uint32_t depth);
> >  int drm_format_num_planes(uint32_t format);
> >  int drm_format_plane_cpp(uint32_t format, int plane);
> > +int drm_format_plane_bpp(uint32_t format, int plane);
> > +int drm_format_info_plane_bpp(const struct drm_format_info *format, int plane);
> >  int drm_format_horz_chroma_subsampling(uint32_t format);
> >  int drm_format_vert_chroma_subsampling(uint32_t format);
> >  int drm_format_plane_width(int width, uint32_t format, int plane);
> > -- 
> > 2.16.1
> > 
> 
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
