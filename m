Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7094CC43142
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 02:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D43520844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 02:39:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="rkBmnquU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D43520844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbeHAEWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 00:22:35 -0400
Received: from mail-eopbgr730066.outbound.protection.outlook.com ([40.107.73.66]:64640
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725872AbeHAEWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 00:22:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w9RxvzCprUgARrBm+7JNA+FBrcddOg5xVTTNJAPWeD4=;
 b=rkBmnquUbfm/Enx4i7H/OXLFRk4kvG36TyXBWc2is3bXjfemaIu3fbBks5Jlyfmgxw7sWyRSwPPtZnG0D5BGHXtCctN2G2fyntjoOHqZX++D4VXGSFxKgSy2nd7LiMS5JNtA+CyiW00/Qy68fxJXSfdm+5Vp4Dp6V/o9UWcxAqA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 BLUPR0301MB1572.namprd03.prod.outlook.com (2a01:111:e400:52a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.14; Wed, 1 Aug
 2018 02:39:11 +0000
Date:   Wed, 1 Aug 2018 10:36:45 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     <linus.walleij@linaro.org>, <yamada.masahiro@socionext.com>,
        <keescook@chromium.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH] pinctrl: berlin: fix 'pctrl->functions' allocation in
 berlin_pinctrl_build_state
Message-ID: <20180801103645.5df924b9@xhacker.debian>
In-Reply-To: <20180731142501.21888-1-yuehaibing@huawei.com>
References: <20180731142501.21888-1-yuehaibing@huawei.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TY1PR01CA0168.jpnprd01.prod.outlook.com (2603:1096:402::20)
 To BLUPR0301MB1572.namprd03.prod.outlook.com (2a01:111:e400:52a9::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5014dee5-9b18-4969-4fe1-08d5f757f7d3
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BLUPR0301MB1572;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0301MB1572;3:YOgZ6RCiCVaZ7jH5aaZ2aWiLXC3fzLVOGdnueWYYA/LpixkL1ONkPukjFgl4Ifb2+d0HXn1bZ+LCzX/e0HIUPoFFtLH4CKAP9boRRdcYBkJYj6kmKp+raLJ/NFJDq3r3PXzgoVmjILndd+Ki9F6mYDq4AD2J6xE6+usYsXaR9e0YmtwyFQSknYUICgKqxWJ6yZGhWlnwIH7aXdCwMDRATst3rKnUE2sdp+52DNCG0ffDUqFzUMfY/zIqY0ZPTjEE;25:vTqytKVqb1eubkLcAokO9JFc6ZtgE2BVYAsQ30PVlCs1JBUm2ljWBEpreU5utC3eEf8CHQNq1NGuo9ttW8+ZbpTrhU2VFrzMW4vct0LFu4DGa5MUOMcPYXiV23H4PKXd/bZ0nI1LJyQ8WrDTkOz4xwL8Es7e3iTHIC184N9UBcOxnRdIAqz0Tn6rjm9mo0HGdKeIrFf/rrEAyVSkH2eLft++IvxNIdJ7TxbMbTFpyPG8JEBDJRRDPMtka5qBHg73QTI8KqcPdzPVt0zZ56JF4Ov/+PunluhC5KOk4bkjWrk+ni/cxbqWpKu+2alPoK6cCdGjASSVquO6VE7FkiiiCA==;31:1Fu19Vo9z/0mbTeoTxWGvGObRp1fXQsSt9egHyj/v5BCN745TIHznX1kvoepyle3L/pjQIbKtwIJDizr/Tv3ixsTSEHG8D/4PA+dmIJSkbCNKVxBv4Ct6jd9DeO2W7FL3mKn0PXlm0CLkSwvCG5gK1VVcsMerpCB2J4RyvTv/+AWEtoOFqLcnE75yFP+M0BLW9CdqiAyBkpGv2hn3NdZfNu4Aw172lYIM0OwbsydeRI=
X-MS-TrafficTypeDiagnostic: BLUPR0301MB1572:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0301MB1572;20:pNQJIjDLRoJfU7GYGWlJXkHY/Yb8dROXOCwcUEIZWS5ImCOXzvhYpKW8pX02kTNiyOGFtvgGwlbpp3uJhzuD0nNC8rXFlq5WGePMlvg273nnIHGi169YCyTxe6sZy0dkFskp3xAhc1P6H1Ch0iMVP0LTq6P8iXkm/T18uFJLsTgaaHf1pYNm9O30ujiMvuTkJK2TFTA192cQbrNS8e4D2h8D6DezI8anEtdspd6wAvjGaCuZRdb96+ERolmSTuHpetI3Yetif4PNg6bFkFeEvfnDYk0a61ZA1IYbc4mfqrhfoSDKjG3biesqKH/98JLwc3FTDAyoko8ZPzkLGtKo/1JaCu9lvoXDCFHUmErw9lbk+GL3JjPU7Ess11Rxi0TMYyo9gyd9vsE6Tw7jGwuOKsHrMnEDZWCmXe0Rkdm06yQH2mo68xiFHVxg4Ciik+/tGZctf1UqlQUQPk2lSvnA4J2GS+JoTS+ICJPvsPtjth70BUIKl56ia6O0Kg2d3BwC;4:2eB39PhyEsaTdp3/uKo31F2duYo9bx4cF2lGPW2GMEmqLqEwP94h4enwn9cVmFCwqU/MkyrosF3Is/0y8Qi1qw5/KO45ENAEOJI5AJoTJMEAefsnyWarlCwjl6tVDIDUTWU91hYSU1MBv2BvGucB5YHLtO0O65Sxq17/tbxxomXMuyuf05o7RTB91OGVVwzQpjD+e/rNAgNc/hlPhk6Wr+VaLibxBLsgJUe/LZCuvFZHj4EXXn9oAcwYzugZw9GPnjBDI2VytG+UjpbavM/LIsFs5ymhQbR0x3E+RS56vmIgvagk1qd3vQS5s/Ovg9mb
X-Microsoft-Antispam-PRVS: <BLUPR0301MB15720C8A64E7D062121ACA6DED2D0@BLUPR0301MB1572.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(50582790962513);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BLUPR0301MB1572;BCL:0;PCL:0;RULEID:;SRVR:BLUPR0301MB1572;
X-Forefront-PRVS: 0751474A44
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(376002)(346002)(396003)(189003)(199004)(54906003)(229853002)(97736004)(316002)(9686003)(55016002)(305945005)(186003)(11346002)(446003)(5660300001)(16526019)(486006)(6666003)(476003)(6506007)(386003)(86362001)(956004)(7736002)(76176011)(7696005)(52116002)(26005)(14444005)(6916009)(33896004)(23726003)(1076002)(50466002)(230700001)(3846002)(50226002)(8936002)(2906002)(68736007)(81156014)(81166006)(8676002)(6116002)(6246003)(4326008)(53936002)(25786009)(72206003)(106356001)(47776003)(105586002)(66066001)(478600001)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR0301MB1572;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR0301MB1572;23:YTM9oYjVgDjbAWlLnzjiuSq6ttqASLk/dI01Ueb?=
 =?us-ascii?Q?p7M7zWHBP5h1aUjjZ0+UeJDmnwP4g4oBfaW9S1njozfPaZ7wpcqlR2Ntjz80?=
 =?us-ascii?Q?BRLYEHokU6uQXowhfPYZB6Rux4ceNQHuvfH2nBmZ1AlOx9u/7aBcUxHTT7VX?=
 =?us-ascii?Q?98QXUuvfqBC4GyKHtSuMCgm0NPLQXcSsNlgRe4tK8LdzE6P4nXFv2akEO//a?=
 =?us-ascii?Q?FBNllTn4LEEAvLsTgQ09jMK6B/8c9kCg5Ba/IDcpf04zIMPqzUgOXIlQTXl3?=
 =?us-ascii?Q?DH3fCRx1VdSlBglZyyDQ9VuGoRysKe3HB08WNYBcDYubYtJ+c6r7GowgTe9y?=
 =?us-ascii?Q?yaLaNputM4BLW8UtJQpQ5NkO3vfc0XcfQhirt5FCiAkt5Ikp7XP9bm2013Zb?=
 =?us-ascii?Q?/YlfDtFJUdT8irSMjHuC0B78RLevVrU4yc9jIEnZCQ+IQA+S9y4/Q0XMlKAA?=
 =?us-ascii?Q?SxCQWOhSQTJMz0vtyQqJhRaqh/Iakj8+92NPfJ9aUMp3QpYNYsCb5hSCTfaW?=
 =?us-ascii?Q?347aMTyG2MsXT1BvwiN9PhFe5yJM2P/a7Tm8P6wtyFrPSPN2iXwhMmel5JNy?=
 =?us-ascii?Q?XTpdG0jd/1Qu6SIKdYp6YBckh5YVLFSp6tZ80bRenA1Hy6e8aTFSVeHW2NqC?=
 =?us-ascii?Q?rwVB8dMtKqe+2IUhqdqrne6mMskCmHeT7xmEx8DhuBSzXZWaq0wTussOaFM6?=
 =?us-ascii?Q?Q7oLHcY7Z2xa858rdrJfrlsQ5dfSsfD3WF/ovAJWXwyGDubjpgLsyT3V5Fk0?=
 =?us-ascii?Q?HIYeq00mim7dbfpbpmwyCPCSjB4irV6dP6FpX8jX9W4GGsWqooPgMmDORNOE?=
 =?us-ascii?Q?Lf3K7ZQ3gGGOyDqiHJB19UtVAcbfHjCF6Va93J36AmzxFCqAnqsEq+B5BuS2?=
 =?us-ascii?Q?uplyeaBGMQ08wEcDOiVfE971jIpuUNJnUe5k0P+XSeqo2PF00IRE8UnctMIj?=
 =?us-ascii?Q?8/glDx4jWtcLs6zi35PbcJRZS8KfLbGm5q2tIxby9ATOS96XtyNw/ZBiz9oZ?=
 =?us-ascii?Q?tRZt5s5lVX/qN6oJv0/YtaqGRLcF+FEl85MFBEVnuVOIHB82eGWAwRr/GGLD?=
 =?us-ascii?Q?gKhBXqzyBsblwDFShIpWXFmRItZi336XAOtikIke0CtuKNqe5kpnOThn1rNP?=
 =?us-ascii?Q?PUzurP6e78qj/xXJ0lVrd+5Pg/hKfv14hVSFOKgEeJdCO/aYMgoB7Vgk4lag?=
 =?us-ascii?Q?3qm2XwmvtpQP9eif49gFCCFOmZSCknxAk9fpMHYswacgA+WwCevVgfakZp42?=
 =?us-ascii?Q?I1DfO0KyTc9bApzejzJXFs48WLGTVSfKW9dFPJ3Vd9lt074eCPBLSdnl3XtN?=
 =?us-ascii?Q?zJQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: SqFQv0eHxSKcOl5Ti52AMe94e/NyldaUa3omuwksYsJpfh7zG+g5Ey86lqUq6KidGddzoDSGIyxvQv4/F968rQvXXgWOAHgrvg1jeIlCIvbIE8O7SrUKJgZUElPhsyNfexhOdoWJ+RDH1p8xhJ+vjehmVlvcPX/AIxSeFcENqBaP38+6/fUeA2CoA4pA0hh0xVDMRrIUmMDvvuQSagqiqIGn7IbCQHkorg9bTNcb6ShKJjNU4TAK0kz+USJ/I0/fCsfTAt1HPubKam11zmhRbzD7tAAPvST7YM9sv8cDlthbqU0p8wPN4ofYTqaEK0GCSxyH4V4YIVjYOFInbQrhfA9C1NvnzAo5Y23NhLNRl8Y=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0301MB1572;6:NMZkFqnrAJSaOZTJotA+2kj108KuuiqfhwYqfqIY0UrpP5ajItrBMkzyLoD0gMVsiBGHygjIB6VgIxDR13Onjsl6e83VckhZXuhZrrphn3n0JsdouVwiSN+m/hy71B3ZDV+n9koSR5f/7N9Dv3ejZuIUKy+Z2kgrfDrZ0iRcZeSpywSizoWHr2JGbQXe+A/S83TgFc0m2H/XN4cw535lS/FQRCryCillORct1EtrjFEyXHiPs6c1qyvcsFdWpwEMp6butnAACjiwdSWSRJgqK+2IlUgqxNXwNuYVJyGjXnET1HV622+IVuKQXtENlcbyoAI4eSk8Xu2lP6El8NZM06AbES5kXP0Ch8E2BfeV1lOhbKRaLyAgJ3LfHzysrff603yGLqmna1Jkp9SZB90ih1H/ES3ofkOnjQbv2bqKdwYfHaRkk/z3XGB3vvvVUMohSvYg0+FPEB0BHbpkfy3OoQ==;5:Ts2ugAP9VXcG9VfHWOTIM4JBhB7nKxIqeQ3o1B9BDJfJT4mgcYUyhVzYhyUukDxzEceMj63mMeX/iorDnujYavHlMYXfEXlX/1RojRImP2upoPt73bhglCewQ7UVP3dFBUEhqUFyxt7Ck6+Rf3qnQnThoX1jGiI6P8bpCZ+SGUo=;7:KdiJmD3A6f3dHeRepVk2fIcFUS55jR/YElMHc3uJcIo7AoKEBYH6EGQ7nl8A2ectMjMEx5YrR/8/Ny4+CKX8aHAY/GA3Q/aolJSEOCHMI/OvTEzrKGQ5CoL08geKbfEJ3zJRlsqKkHMIk6mABAIMFOm182kHnaD01E/5FltteTuUERO1YUbWTxGH2Trv978Gq8qDdU0IRqQg2PtJMXg/W7lkgNqCOVVxVQkAyEp2Zw8y+NfgLd3B+a0t1nLDAY9/
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2018 02:39:11.6323 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5014dee5-9b18-4969-4fe1-08d5f757f7d3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR0301MB1572
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 31 Jul 2018 22:25:01 +0800 YueHaibing wrote:

> fixes following Smatch static check warning:
> 
>  drivers/pinctrl/berlin/berlin.c:237 berlin_pinctrl_build_state()
>  warn: passing devm_ allocated variable to kfree. 'pctrl->functions'
> 
> As we will be calling krealloc() on pointer 'pctrl->functions', which means
> kfree() will be called in there, devm_kzalloc() shouldn't be used with
> the allocation in the first place.  Fix the warning by calling kcalloc()
> and managing the free procedure in error path on our own.

Good catch. Comments below.

> 
> Fixes: 3de68d331c24 ("pinctrl: berlin: add the core pinctrl driver for Marvell Berlin SoCs")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/pinctrl/berlin/berlin.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pinctrl/berlin/berlin.c b/drivers/pinctrl/berlin/berlin.c
> index d6d183e..db2afb2 100644
> --- a/drivers/pinctrl/berlin/berlin.c
> +++ b/drivers/pinctrl/berlin/berlin.c
> @@ -216,10 +216,8 @@ static int berlin_pinctrl_build_state(struct platform_device *pdev)
>  	}
>  
>  	/* we will reallocate later */
> -	pctrl->functions = devm_kcalloc(&pdev->dev,
> -					max_functions,
> -					sizeof(*pctrl->functions),
> -					GFP_KERNEL);
> +	pctrl->functions = kcalloc(max_functions,
> +				   sizeof(*pctrl->functions), GFP_KERNEL);
>  	if (!pctrl->functions)
>  		return -ENOMEM;
>  
> @@ -257,8 +255,10 @@ static int berlin_pinctrl_build_state(struct platform_device *pdev)
>  				function++;
>  			}
>  
> -			if (!found)
> +			if (!found) {
> +				kfree(function);

is it enough to just free one function? I think we need to free functions.

>  				return -EINVAL;
> +			}
>  
>  			if (!function->groups) {
>  				function->groups =
> @@ -267,8 +267,10 @@ static int berlin_pinctrl_build_state(struct platform_device *pdev)
>  						     sizeof(char *),
>  						     GFP_KERNEL);
>  
> -				if (!function->groups)
> +				if (!function->groups) {
> +					kfree(function);

ditto

>  					return -ENOMEM;
> +				}
>  			}
>  
>  			groups = function->groups;

