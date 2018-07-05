Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C6DC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26611240AB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="kg/j00Lx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26611240AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753617AbeGENpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 09:45:20 -0400
Received: from mail-eopbgr80045.outbound.protection.outlook.com ([40.107.8.45]:31040
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753353AbeGENpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 09:45:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gL57QJJVroAqaC4Aern8Vop1xiaGtTU+AAQBxVNPlUs=;
 b=kg/j00Lx4XcyZY3G9kLid93hLVGsAjtt8Wb9W/eCSrmdlhO4KsX3G6s8J1qlEimuBp6Uw8BZs8GfEQAzZLcG67PqCsVzRiiFZhGYHHIGtDd6TrcmHzxafvceNclqx/ve4A7/0TeCmGxrCCzFZmYUZCd47fJVo0jeTV83Tb221So=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
Received: from localhost (217.140.96.140) by
 DB6PR0801MB1384.eurprd08.prod.outlook.com (2603:10a6:4:b::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.18; Thu, 5 Jul 2018 13:45:15 +0000
Date:   Thu, 5 Jul 2018 14:45:12 +0100
From:   Ayan Halder <ayan.halder@arm.com>
To:     Liviu Dudau <Liviu.Dudau@foss.arm.com>
Cc:     airlied@linux.ie, liviu.dudau@arm.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        malidp@foss.arm.com, nd@arm.com
Subject: Re: [RFC PATCH 4/4] drm/arm/malidp: Added support for AFBC modifiers
 for all layers except DE_SMART
Message-ID: <20180705134512.GB31243@arm.com>
References: <1529070694-21088-1-git-send-email-ayan.halder@arm.com>
 <1529070694-21088-5-git-send-email-ayan.halder@arm.com>
 <20180626132158.GB14974@e110455-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626132158.GB14974@e110455-lin.cambridge.arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [217.140.96.140]
X-ClientProxiedBy: VI1PR10CA0088.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::17) To DB6PR0801MB1384.eurprd08.prod.outlook.com
 (2603:10a6:4:b::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd209ea1-3659-4ab2-5be9-08d5e27d8a0b
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1384;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1384;3:XDvzbzZrXzJlMxH0Io9QkIXlxzG0X9hMluN1+eGcto80vLwOpPO/PgVa/LnzYIZWvshV9vLVs0A241w5BdXMf5PXcVp6bVHtCj6DUefkxyPAt0xkH4LrpBMRXRFVOW62sWmw+OnPdgwgLRVYj17+2n1Uqc+P211JW1uhZePsXaigDb5H1dSmmbJKbEpRvMXkWVCVx9CLGK8dNC6SnykbWeObO1fjAvDP72JnmMrp+zrLu3LYyJXPTg86cQxqOfhR;25:6mvVTD4wa7tWUzBAbi+HSc7Tn/UHkW19igZNxDlDyxD4UWRwCkoWkvRlLpdB1pk7UXsPAxFerEWwZPTuNr+4tALRXzfbobwWJP7MCg3i3U5WHaPtoyboglao36VTmnwjM3QLGd2OuDzPGt3e7/gUzDPrRM8FPOFhwrbrXSruWuw6XX3M8EbfopsROi1971Yz+TX11rQ3NoJ+duygEbBuGt/B/HOZGoHAGfLk4OFa2jbYod4vGJjSp0vLeBoa0MyxqbbsJnmv3XAOWIGtvnvdG7TCbINFJyyGvPWk/AiXS32n+BTrEmTEIyM9Qknlw3dQ4Hz63ecPJGTtVRwhlCeG9A==;31:spxFUBFsFxkOyw7APZBa5rns73tzPpH6BslNXKIMxrTjbUn7R+OTSRXdIjkb6PCjjKdCvJwfEWRislEnGTNcqobl6opCP4Vg4qrNi0zuiFnYd0ZcyUva0UXRYn8FEFBSxFRf8RQzRdihDYdqGySzOseumEi6f2GdW1luAj2gj2niV/IGAjWxyO8xOxeepNdK1DNc6Jev+b4mn9CC5z8Po1KXmi8wemSmhnm1x6hF/es=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1384:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1384;20:lbFHjCR+0kK7UIlY7rD0OQqlLzDWr5InIJXqx2cjxqIcDWzNFrtp0ZI7KqC6h2i49Z8L/9HbCrNR2XNwf8vqN1vzglUvOo/iLEtVq1WpgcJmm1GjohmsQgZeJzqaPw16TTga9ri7/8XK7uTv+g/1m+bmItU+or07sgZsb3qx5/M=;4:n/mfOK+JtWinmM/mdrTomfNf/eocePBGqVRMIFLMjG9bMHKpcMbZfJ68PQEUfBQB8uFbm59VVV/1ePY8hoU4mRqt8crwvZIzNkOSxzmmM/PFIn3pYxFu/1t7TjRPt6r9ROaaTHFzuY8DyhM51vBVez36/rdjBRH5HseMyGhUL/jHr6Ny8q4AR2qmVJzBlafhPXDpvytKxeDIkBigAtfqxhTpDiFiPWq4MJk5rCqZih1FrhTN9DvWHaMp/LHFYGk5FL/RXIuMUbQmE62uLbl8/t1UUGdxC82ke7jOI9YTnvBzCn3K467AV5jVBCLsQzZJyDlRicsu0wPYvuM4gJTGnVZxkGGt7ladqcSCd1pFEBA=
X-Microsoft-Antispam-PRVS: <DB6PR0801MB1384315A2AA17268717EB5DCE4400@DB6PR0801MB1384.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917)(217544274631240);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DB6PR0801MB1384;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB1384;
X-Forefront-PRVS: 0724FCD4CD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39850400004)(366004)(376002)(346002)(396003)(136003)(189003)(199004)(6116002)(3846002)(76506005)(1076002)(23726003)(6666003)(16526019)(6246003)(446003)(305945005)(58126008)(575784001)(16586007)(86362001)(53936002)(14444005)(66066001)(97736004)(36756003)(316002)(50466002)(105586002)(47776003)(966005)(2906002)(76176011)(4326008)(6496006)(45080400002)(478600001)(72206003)(106356001)(52116002)(5660300001)(25786009)(8676002)(26005)(68736007)(44832011)(8936002)(229853002)(476003)(33656002)(956004)(6486002)(2616005)(6862004)(486006)(7736002)(11346002)(81156014)(6306002)(81166006)(386003)(18370500001)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0801MB1384;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR0801MB1384;23:aBGnAjM0Cs1gtHvd03E5Tmd+Kh2PGG+Nsz9dZZh?=
 =?us-ascii?Q?38cJNRSoFDVPbElgHmUs5EaOkH5SkOeRgIgXstGMcsvqHNFG0+goFYtTqLUV?=
 =?us-ascii?Q?o52WH+WhX3bjoYKDaHSQMtc0MXgk8PVCNbck0DrbdW3XRVekqys8N6XVRiG9?=
 =?us-ascii?Q?O0NTQKIQgrfbuCOVBiDqzaxvPLKk/h9F5gMbc7jBICEW34UI7zzIZlyyF2+h?=
 =?us-ascii?Q?M0wYmEW4TprIRvPPqF22XUtx/7bfess+hfR0r0IvNEP7e/Q7gzV8iq+QkHPt?=
 =?us-ascii?Q?TzC2NRsotYpIK9mO0MsmaY7kJe+/wAHxejiId53kiyOaG5hukSFQcKVlI1Qv?=
 =?us-ascii?Q?bgMJMF88xczBbzFEdJ1gZSlPCZhW13Fmg3TbUV5TTs2kDcBLKFlgs6XuLkic?=
 =?us-ascii?Q?5a+9eGfchZlG1f1w5cfD7RX+fz18cRtdQr7XHP5VqXDbuRx/mWZwS7v57FPN?=
 =?us-ascii?Q?byUU+t3oVcR02fd6oxBK++/5cbqIcvM5XxlS1s5bekWLRexyTlCGeDd/DRkN?=
 =?us-ascii?Q?YSBG2212QJ08fMPGQwJk5PyzgJK/mZyIF47NvlqVLDLSznjPeHsl5TAqeium?=
 =?us-ascii?Q?tQaDcih2eJ2KWV0P2gudo1Jydazcdng9Mhsi9AD481n6uu/pkzrnHmQZ1QCN?=
 =?us-ascii?Q?kpp0t2rgYFWmA0KSIKGR2dVoGEYj4r2FrXfVQ8DtFVTvxKjn7M17L3bC3OmS?=
 =?us-ascii?Q?XB9BnNdaqpJAjcWyNkpDQPIlvBir/8koanxF8YOdOgy8yZX0ImSzBBXtzT7u?=
 =?us-ascii?Q?Bb+rvDy9EArB0UzegFvqJuXBux+Si0XjW04HKUs+iNHjbYbmSdJRF+16iD2O?=
 =?us-ascii?Q?oW0Ebym9sCPTjmwdfpYUqLpQtZAGzk5FL7ygbhhSxzb0TNSA0d5nYKLjh3T5?=
 =?us-ascii?Q?/s28iimCiJgrloJHPEUuaxIiNjz+hWVD8uc8p7qDqSbQiaLeUlEk/DzZEsYH?=
 =?us-ascii?Q?ws6VJI9VLfUZPp8hRHPnNVAJY5S+TZ1AzojqFHeSaImCucsCsZYB9Ai3Vx36?=
 =?us-ascii?Q?nZRCpOkGqEb5ofiODIEsAN6OB3Rtf6az8/bKf3TTXc6JKAJsDVD36KbzG66Z?=
 =?us-ascii?Q?WmTqU8u42aK15pDaoD9PfuNS9POZhwGlOc24o5WVKPk+AMZDgD27FaQS1gKm?=
 =?us-ascii?Q?xbRY+nOCaQMUSlvZnxric1q4D0qfhlDvzZROTTi9pJiSD9aiXZgV5dXkuAun?=
 =?us-ascii?Q?nUUgi7DBOOqjWU7wMJJM8dwvxcuGJ55EDOiofaGUkJpyY5qU4yMK5gYM6hb6?=
 =?us-ascii?Q?YYVF3iGUppXL/wqBxz7Hie65uKEx9IOAGAngji/9gokS0Xv5PzWyU7/r7YAd?=
 =?us-ascii?Q?ARuikeIvfSThyEbv2hRRaHELnYpKz8gj9nwEq8nAyN2UWPxQ8ky/Bg0sz8gg?=
 =?us-ascii?Q?AqO+NWrkXDQuywm0ZqAIFLCVl2hbaMzTDc89ue/G4NGFV3X7r7AdFIRDdKB8?=
 =?us-ascii?Q?PtMI5KsIDIA=3D=3D?=
X-Microsoft-Antispam-Message-Info: jNunhjWOv8nsYN5C+1YmGT+HVgzhqI/jq1vHhanWzNeKuGSVa1/REmCyLCzWyFzi75HUO6MSG1ZKug+nqGb5+J8hRy4V9LefNAe05fjkYRGt7wEj0tDpJl30mduls18D3tV5Gk6/zUfJW+XrjkRPKsSUsgm5aF/I40KV6iF1twX0jfiWV80zydam9Vc4JvoCQxY/Zdn8/biaiLCbFLoNv3IfQ1MxZy8PmYizek1dKiRF8LYXzLXNjXgTd2/ij+lFOOyJCTRrdNYcJMMrwgdpcx/i8fsMPVmaLou6WDaGlxLVLfdZP0HtK6U//FeM1PBifVngPMs38iER+wLfE1oKXij0s5yzq2xux2zzhUhCu1c=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1384;6:1PbdK3fLWSElnJ19BHnCgO52XAByrvcQLwmWQclC0mGIUTV3sM39we2H8ZjS5R7AASbdOvLe5jfs+3RG9/Cj1WTpY2/3b1DatlOW0odLEyLgnTtdX6GqisSZ8jhHOQuoRCWtZHf4QHdH/WZN32Eb+f6623Ohvc1bN5a0Vd6yQqwWUNaUC0pqm+2LmX9t7686A+v7w3OYDdMN1ITAZ2mrdDhQgtfWsQEkze/mRQX6cWN6MjWyD5NgvF3+P3RPcGSpYyvHCfb4TmFAJHuYgHsfubL4HcZwurckNavOk8lCRTpAAhiShC1lYDjpjMi8mn9bbn2KLTDkyrUnFpge8MIl0EhMdalLgO2ZMc6uWhQb7u1evabK3nU43uq4NysSOFxoMwarAPVL+r1Pmu8QNp+cZ1+2zsmhWtmgY0WYl71lqd2zeJ5ugc4fHgAyB9OyJeHJb+1um1YAqfSwnWEqrJ21HA==;5:r243jaHassXGcwImqgQVlU3QWxBaAkOFPLPV004eQ1PYuqoZrz1Qa7nLenw9pkuZKqb35qcl1bhpp114CHu8AJLt5CXvRWKMfmxMOLTD9tsbq45N/NsQOMw+G10GF5avEB6OlzRfcIgW9HctYhSWQrgOXBJ5DjiF1iWHXZo/Z7A=;24:CQopMeUqceFMxCS8SesfU9Lm6qZeZuxasj5XIE+UgqS/ygb5RkJbWwpstss1JHcOTFlz+UeTmtu/s3QprjFSLsd/RrSsiDDEE/0PG3qNkH0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1384;7:5Ky4cfu1SqucMPZBk55MWKBLbizkVoV1yMW2tbrjUjdKfXFzKav7wiXK4swtfz9UpFQslLW6A6mmQArC8XWviS1hoK8BOcyIhXPwZbgyMPl8Q8Ea7/g7zXDwhLFa0H2UGD9m5tvQzikqntA/8kl+GVhOH+TlezuXeK2cuZiLRGI4yDXBgKiagGf5TL7VFnX29u/XX26EDclktIw0AvmmFxMxP76ohpNojQQwaJgpjovCqz1G9qg/KlQPA1JOMW0E
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2018 13:45:15.5761
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd209ea1-3659-4ab2-5be9-08d5e27d8a0b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1384
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 02:21:58PM +0100, Liviu Dudau wrote:
> On Fri, Jun 15, 2018 at 02:51:34PM +0100, Ayan Kumar Halder wrote:
> > On planes which support AFBC, expose an AFBC modifier for use with BGR888.
> > 
> > Signed-off-by: Ayan Kumar halder <ayan.halder@arm.com>
> > Reviewed-by: Brian Starkey <brian.starkey@arm.com>
> > 
> > Change-Id: I4739ff55c0f6d5715b268cb3947ed133a9ee7c2e
> 
> Please remove the Change-Id
> 
> > ---
> >  drivers/gpu/drm/arm/malidp_drv.c    |  1 +
> >  drivers/gpu/drm/arm/malidp_planes.c | 46 +++++++++++++++++++++++++++++++++++--
> >  2 files changed, 45 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
> > index 7b6a848..7bcd679 100644
> > --- a/drivers/gpu/drm/arm/malidp_drv.c
> > +++ b/drivers/gpu/drm/arm/malidp_drv.c
> > @@ -392,6 +392,7 @@ static int malidp_init(struct drm_device *drm)
> >  	drm->mode_config.max_height = hwdev->max_line_size;
> >  	drm->mode_config.funcs = &malidp_mode_config_funcs;
> >  	drm->mode_config.helper_private = &malidp_mode_config_helpers;
> > +	drm->mode_config.allow_fb_modifiers = true;
> >  
> >  	ret = malidp_crtc_init(drm);
> >  	if (ret) {
> > diff --git a/drivers/gpu/drm/arm/malidp_planes.c b/drivers/gpu/drm/arm/malidp_planes.c
> > index 3950504..55c9a1f6 100644
> > --- a/drivers/gpu/drm/arm/malidp_planes.c
> > +++ b/drivers/gpu/drm/arm/malidp_planes.c
> > @@ -124,6 +124,35 @@ static void malidp_plane_atomic_print_state(struct drm_printer *p,
> >  	drm_printf(p, "\tn_planes=%u\n", ms->n_planes);
> >  }
> >  
> > +static bool malidp_format_mod_supported(struct drm_plane *plane,
> > +					u32 format, u64 modifier)
> > +{
> > +	if (WARN_ON(modifier == DRM_FORMAT_MOD_INVALID))
> > +		return false;
> > +
> > +	/* All the pixel formats are supported without any modifier */
> > +	if (modifier == DRM_FORMAT_MOD_LINEAR)
> > +		return true;
> > +
> > +	if ((modifier >> 56) != DRM_FORMAT_MOD_VENDOR_ARM)
> > +		return false;
> > +
> > +	if (modifier &
> > +	    ~DRM_FORMAT_MOD_ARM_AFBC(AFBC_MOD_VALID_BITS)) {
> > +		DRM_ERROR("Unsupported modifiers\n");
> 
> I don't think we should polute the kernel log buffers with this. Maybe a
> DRM_DEBUG() if you really want to get some notification?

I agree with you completely. I think we should use DRM_DEBUG_KMS()
like intel_framebuffer_init() uses to log unsupported formats and
modifiers.
I will send a v2 patch for this.
> 
> With those changes added:
> 
> Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
> 
> Best regards,
> Liviu
> 
> > +		return false;
> > +	}
> > +
> > +	switch (modifier) {
> > +	case DRM_FORMAT_MOD_ARM_AFBC(AFBC_FORMAT_MOD_BLOCK_SIZE_16x16 |
> > +				AFBC_FORMAT_MOD_YTR |
> > +				AFBC_FORMAT_MOD_SPARSE):
> > +		if (format == DRM_FORMAT_BGR888)
> > +			return true;
> > +	}
> > +	return false;
> > +}
> > +
> >  static const struct drm_plane_funcs malidp_de_plane_funcs = {
> >  	.update_plane = drm_atomic_helper_update_plane,
> >  	.disable_plane = drm_atomic_helper_disable_plane,
> > @@ -132,6 +161,7 @@ static const struct drm_plane_funcs malidp_de_plane_funcs = {
> >  	.atomic_duplicate_state = malidp_duplicate_plane_state,
> >  	.atomic_destroy_state = malidp_destroy_plane_state,
> >  	.atomic_print_state = malidp_plane_atomic_print_state,
> > +	.format_mod_supported = malidp_format_mod_supported,
> >  };
> >  
> >  static int malidp_se_check_scaling(struct malidp_plane *mp,
> > @@ -524,6 +554,13 @@ int malidp_de_planes_init(struct drm_device *drm)
> >  	u32 *formats;
> >  	int ret, i, j, n;
> >  
> > +	static const u64 modifiers[] = {
> > +		DRM_FORMAT_MOD_ARM_AFBC(AFBC_FORMAT_MOD_BLOCK_SIZE_16x16 |
> > +			AFBC_FORMAT_MOD_YTR | AFBC_FORMAT_MOD_SPARSE),
> > +		DRM_FORMAT_MOD_LINEAR,
> > +		DRM_FORMAT_MOD_INVALID
> > +	};
> > +
> >  	formats = kcalloc(map->n_pixel_formats, sizeof(*formats), GFP_KERNEL);
> >  	if (!formats) {
> >  		ret = -ENOMEM;
> > @@ -547,9 +584,14 @@ int malidp_de_planes_init(struct drm_device *drm)
> >  
> >  		plane_type = (i == 0) ? DRM_PLANE_TYPE_PRIMARY :
> >  					DRM_PLANE_TYPE_OVERLAY;
> > +
> > +		/*
> > +		 * All the layers except smart layer supports AFBC modifiers.
> > +		 */
> >  		ret = drm_universal_plane_init(drm, &plane->base, crtcs,
> > -					       &malidp_de_plane_funcs, formats,
> > -					       n, NULL, plane_type, NULL);
> > +				&malidp_de_plane_funcs, formats, n,
> > +				(id == DE_SMART) ? NULL : modifiers, plane_type, NULL);
> > +
> >  		if (ret < 0)
> >  			goto cleanup;
> >  
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
