Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE56C43A1D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 23:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BDE820BEC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 23:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="qRw4ToCu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BDE820BEC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390828AbeGKXeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 19:34:00 -0400
Received: from mail-sn1nam01on0135.outbound.protection.outlook.com ([104.47.32.135]:32992
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387903AbeGKXeA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 19:34:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OTioZo2CrfDtttYe1oB8hWwlj7Nk4Qn6+ZRGRUEmvVI=;
 b=qRw4ToCuMGbc0be29xd7MfQVrExes/4I+WaMRUUeEydxhwuwg4SJtjxMHlKL4t73tBapfGamDH85uUst+GshF4PLElTxryyazXOp4dTpQEUijz++5h+5UcLECayxnIsjXA/jTmugdwKOclD6cGWj7/hI55+QZVuNLPYd/IOfzQc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 DM6PR08MB4937.namprd08.prod.outlook.com (2603:10b6:5:4b::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.21; Wed, 11 Jul 2018 23:27:18 +0000
Date:   Wed, 11 Jul 2018 16:27:15 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Vinod <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Mathieu Malaterre <malat@debian.org>,
        Daniel Silsby <dansilsby@gmail.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 02/14] dmaengine: dma-jz4780: Separate chan/ctrl registers
Message-ID: <20180711232715.djxrbgmcski5xtjp@pburton-laptop>
References: <20180703123214.23090-1-paul@crapouillou.net>
 <20180703123214.23090-3-paul@crapouillou.net>
 <20180709170359.GI22377@vkoul-mobl>
 <1531237019.17118.1@crapouillou.net>
 <20180711121655.GS3219@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711121655.GS3219@vkoul-mobl>
User-Agent: NeoMutt/20180622
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: BN6PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:404:23::15) To DM6PR08MB4937.namprd08.prod.outlook.com
 (2603:10b6:5:4b::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2586ae2b-3f8c-4105-f715-08d5e785d81d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(5600053)(711020)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:DM6PR08MB4937;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4937;3:H/uifbhh31hWnMcqNcYPyoOzctL9hYebromSxfYAZxgPvsPkZhlpIX1ft9UCk2VstFbm7LZxYrDW4CKIMf9ZAhixNaGI9uxYXRxuDxvU/MJDsOYycqzYNhJ5rxmVeEDSrZTlpSU3wGrmqKUIuSZ4VlhZC7Hpphv91WOgcgw9n7/tHankidiaM3+5V11G2Fexdy1oA2wSRxo341KYwZNvmPmvyvyxdVdOmBVhjGsLVMCBUYWfdLmY+AtDWaLO8Bej;25:yuK+sgCs9tJ9xIn/MUxBxUPwBLSXJL/cYzE8dY3MBA2M628+y13xA71brrgd11sr4wGdcdOCp/0pFWq9FpTU4r7jdOYt/Ig5MaRjrod1MNk5td1gyQpt946p1OuiS26TO82B49eHjN+la1KQsAQqFNgNKnkAf5ShDo2AqUp3qbbt29X6EoWwTLv0ALHVpDRxOLYshXjI4etU44GWqyDvwMY2MDpJIi0q0oa1ZKPr+/Y0Qk8W+WHWuntnTfih64qXHb1YRPgwwigw3iP9A5WgEq+54NsydmByWdj+6IsJ8mx+d/zbFRyP0PrOoqNuXkts+FO41vk9zC1w//DN4+Xozg==;31:Ll2DpaQ1kBdrKeD7AdgJzjky3qeW79v1aOb0C4NXsUt5WKqdlNAHI1CGW1ktNk5Gtq5wDcvB4Or6/BmatBUeHwf9TjzlbeDV1mu0nZozOjn81Q7zgM75KmiZfS64pE2VlKgVN9FnaFebIJ6VfjXThmboSTbTkbKz/xwmJmOskbeeBgfi6zgwaYzZeK1eZdGNJ2n8m23XXPI5yllpTQA6ILNe0+FeYBgb9fCgLw5RHtk=
X-MS-TrafficTypeDiagnostic: DM6PR08MB4937:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4937;20:pJjdPmWUV1OQf8GIynByWe5iEDq8OzTa7Vevcu4LnsckvMf48N6QstvpO2RdICtn1zVnWOCV1B+SxzpMmoTI/89mEijnvckBdYOTM3R2PJ3pPP/GHzqgog/lh55PNGAlPvf2pyr0ewWL2Uc64lisFJlTdhdPLEjynhDhc6MGrCQIisA3Zj3J689WIASWBdWMwtTpk1PxDq3myr6ReTPfjfND0LRXrRPaeMfs7uKOSdNGc5VhBHpeTCxRsrA17Zar;4:GPPBhc7bWfcNBldgOJjBhf0rAL5b4pqVYxfCfdob6rq7LJ/blhXsIBG6SnREH9PJR0S8JJL66ln/c6VCN90Z6wXoi5VhOuCt154VyBgb5MEoBwEZJ9+JRl+L4C4XzMKJAl0TqpxGGDgdU+cEbHjIHH3j5k32YJ7xmebb26HLj0OS1xg4ZBztw9POT0OSA9QLw5tz74eNg5rMeMBGdPALhRfKz7ShjuIWfelRDGiUqaLsdKXVp9czXdr0kxnYJcc/rCXdKVRaNGt7Gc1ZdB1NUA==
X-Microsoft-Antispam-PRVS: <DM6PR08MB4937C58403BC57DB4C2545A4C15A0@DM6PR08MB4937.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(3231311)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(2016111802025)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(6043046)(6072148)(201708071742011)(7699016);SRVR:DM6PR08MB4937;BCL:0;PCL:0;RULEID:;SRVR:DM6PR08MB4937;
X-Forefront-PRVS: 0730093765
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(366004)(376002)(346002)(39840400004)(136003)(396003)(189003)(199004)(76176011)(68736007)(476003)(6246003)(33896004)(9686003)(110136005)(53936002)(66066001)(33716001)(478600001)(97736004)(386003)(50466002)(4326008)(39060400002)(106356001)(2906002)(42882007)(54906003)(316002)(93886005)(47776003)(16586007)(186003)(26005)(8676002)(44832011)(25786009)(81166006)(81156014)(3846002)(23726003)(58126008)(11346002)(16526019)(229853002)(105586002)(446003)(76506005)(6486002)(7416002)(6666003)(956004)(1076002)(52116002)(6496006)(305945005)(5660300001)(6116002)(7736002)(486006)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR08MB4937;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR08MB4937;23:U+7lBjtQnyUEbWrWrHxQq8LeRAbWtuf2AnZ2BLVhX?=
 =?us-ascii?Q?0JoQKzUD+iWhgzkq8kULwovgpcMdfmGouQ68LqyQTEGp3y47GBJzDxofy2yv?=
 =?us-ascii?Q?ERHuO/AyzXE0sZOWgEND0c5L2kQV3L/XPR0fSXvLgCcotoXLBQ8mgxRYwVRa?=
 =?us-ascii?Q?t00OwH6IiCf5902Ro0Xgzzq+6ztV/oZ+Yykf2+cxo0+2H8Q2Vw7ORBXJ3jlo?=
 =?us-ascii?Q?QO/gkyS69YwZtwusZHPLfOOBBpQig0d5/ujfvuvUupT1XlS/QS9tAqqxylki?=
 =?us-ascii?Q?0mBIsnri8+g7QoIxegpB6fSplkim2C7eTeCl7gQxUhrTDfEe1Hjkngk976VC?=
 =?us-ascii?Q?yDZqRXBGJ8GlGnGc8mUdSnFis0E3U8X1Hn9j3GY6dLbE5k3ma1r/t8nPjIiJ?=
 =?us-ascii?Q?Ph9ykGtmG7mvdsfM0BmgjX9BimQblyp/+Cl/DDEbU26KLkzfXn/ykz+l6QP2?=
 =?us-ascii?Q?TCbN3Q0FrZfswgjS8PVmnMWz+unGczptSW44A26ILStHkjq0TrtIFrRQJQQe?=
 =?us-ascii?Q?eNXd/IepIkSHio/++7XoH4gw/bNp1+ShX4ZFYpLyPAWGthy2Q8uBe16e+rpU?=
 =?us-ascii?Q?Csu6HmMW03M3aXh8iX+NmWo1vA1Gg2EF+DIitVopdJvpnyyvFW0LnSHxE/lb?=
 =?us-ascii?Q?sHk5S2HuMN8WWfWyWC0seCwDqo1YbX4vZ2KkFiHiHSEQ0bLaB0bXCA/0dO4z?=
 =?us-ascii?Q?Y1baGRzJCzMhq1d/8pkWYtCvw9Xr+ZJf62IuUYc2yTRzKkRl/l1PoYYzCj1Q?=
 =?us-ascii?Q?eXHHcIGvPzE3uffwsirrEmdyQl7TLjfIWuWIx8X6IcQFef71DIEbwG9vIF1O?=
 =?us-ascii?Q?TDQ+f7F8zM5ABi7bGyKNrIdnu4WniiKpIw2LGfRm8opGOmGvZcBcrokpZKDZ?=
 =?us-ascii?Q?h74cU7c6SKv2+QXu5KEVh+skcvdJuxDG7HtdG1lifxCklVwu9p/3N+5XkXcH?=
 =?us-ascii?Q?DRSEBfTnAniIjgqLoWzILdV6Q7iS3R6RcZhv3cUbbhztaiZDw5JUgaka7Lpj?=
 =?us-ascii?Q?5ALvtNKXgHS0UPR47Q7fivpeS7N8eV/s8ug/8rFUMLxLmGZMl/E19BTEBiEh?=
 =?us-ascii?Q?OKtrasF9cVnngpvjE9hRV9yDu6E990NuAWS7ex9wYA1t8e1DOqFOku21Hx2s?=
 =?us-ascii?Q?YMwlkagmkfJAz2kGKAGXt7nGfo82qq0DOmk1+vXjVfCD0WVhGcIxgfpuAGQr?=
 =?us-ascii?Q?Zr6TWcNVO5jUmAlkHm+2IPoQVd7W5b5DCjVVuSANjJLPtlkFxnuCKV+IWIhN?=
 =?us-ascii?Q?wvQPd1KpTOEWscW7nsah1MWfG+CQFOLHnmzl2kzVyrEGLCspgIN5j8BICxGj?=
 =?us-ascii?Q?rr+W/+4OihwBfcsSC8s7CKM1vp8v8tOonBwMscOCBrb/XY/0cELxxJU30MfJ?=
 =?us-ascii?Q?p67WnCv7I36NKP+lmYjM9Z207A=3D?=
X-Microsoft-Antispam-Message-Info: alQQhCrPbNozLC8hDvhVtZ3i++ebxPpKbVIapto4ApoWtgGSEntQTlSHnEuC2ulDlhcHTha2vuAw6X67JBXnTVgAxQvxSFyO676ZMNtGDydONp6fRpRyY61mQh4vDmAsIfa8SeDm8USPmcb+K2CcOkkNUg6CQNO+cUG+YwOb8KXgYFjCeux/yWjPsYqBXe8I5lJxAWPwoMYQTH6jdGY7rRIXMwVuMcTHZcuB35puDUJkMjA5fLo9pHntfh7cdhQFystjhkGEz7TSITy2ebEoyOgn18TyVrqqsTDkh8iwNo4tIMLXvx/7TjWE4Wfd2WmNn4ji+Sv2Kjsh8usS9PmmVLXu/5KBv0scwIUQ8NAns9M=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4937;6:udxyLLrrU3f1FWEyKxUcvdmn8h0YX20Z2y0am39XhAGqIoaPGwLKw9XxEufgcduWEDjYSxySF3ENoP3NHqESAC/Zq9oLDMHGyAXmTO5w466zRuPL0PgTE5FOXGDDbq5d5GONQ4FwQ9pHEjZxUC3z1SFtl7UexnkgO9HP/9r2PBhONBskGufM/apNARqLsKdV6ytSTx5gbp8ZwNbUPPwjOYys7fBHPkatCr6s8Odvyrn3VZ9SrGQ8mkqyLxoojr8QeNO4JZi1T/1/WYec2GA2Fe+NkJ0zIHHJbuELGy1LgBVSwSF05sBgZgUq45/hJMeu0/inYwFQ6/Vk9Lo/gPaoCTMU+GHnnP5Uw8Ulb/VOL0eWW028k4J1r9EUGK3KGEDjxqse4HEwD7ViMyJrOP6m/HIumaNjTKTO7jZT7vZTmS6oodAixP/XOdbhwfytIZFLAMlsc6Ed1whYIImVvmY/QA==;5:j49ORTVc9COQo83ZWBCfQTcrqVX6sl5ZWAjfbqeaJTrwqRsuL/ERoO311EqGrOUXkzyUddo+QOlNphtCwjKqUc58jYUdgHgguis1Q3g2sfTOO3KWC+Eexbxutc3NpVkUEkhTKv+laz107PshyAMAre3cuagtdkoHCVJDWI3Ryr0=;24:V49ILzSqnOB7+PBwpCeRWho3HTcIBMINw8hv8n3Z2wf5fvEA50VTYrssok5UvzhAs53fHC89eXFoB8mw/nrFAYrRLUin2JokJMhLvIU3thM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR08MB4937;7:b39p2+gKov0BY2UFBhJKvoOoyr/SFu+2676dlELpJIp5ARXWQTSdS+D7SiZ0bepdGxfAGvFx7OTHCUx8GmJUbmcUDkIm7tJq7TBL+nIjI4Q7qhPDpWhdFeQ/YEBxMPuPbuSVFffVC6zEJNrZAdzNadecB6xX7vKh8CN/oK6oDWNbgkYCImOkWm4naxRxhrARYWsZckEpN+b53aNEnawNia1OtlMciCaQGl5Fnp4h7lNKdhEM+hV5tBOUnmBCPOZF
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2018 23:27:18.2489 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2586ae2b-3f8c-4105-f715-08d5e785d81d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB4937
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

On Wed, Jul 11, 2018 at 05:46:55PM +0530, Vinod wrote:
> > > >  -	jzdma->base = devm_ioremap_resource(dev, res);
> > > >  -	if (IS_ERR(jzdma->base))
> > > >  -		return PTR_ERR(jzdma->base);
> > > >  +	jzdma->chn_base = devm_ioremap_resource(dev, res);
> > > >  +	if (IS_ERR(jzdma->chn_base))
> > > >  +		return PTR_ERR(jzdma->chn_base);
> > > >  +
> > > >  +	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> > > >  +	if (!res) {
> > > >  +		dev_err(dev, "failed to get I/O memory\n");
> > > >  +		return -EINVAL;
> > > >  +	}
> > > 
> > > okay and this breaks if you happen to get probed on older DT. I think DT
> > > is treated as ABI so you need to continue support older method while
> > > finding if DT has split resources
> > 
> > See my response to PrasannaKumar. All the Ingenic-based boards do compile
> > the devicetree within the kernel, so I think it's still fine to add breaking
> > changes. I'll wait on @Rob to give his point of view on this, though.
> > 
> > (It's not something hard to change, but I'd like to know what's the policy
> > in that case. I have other DT-breaking patches to submit)
> 
> The policy is that DT is an ABI and should not break :)

I think in general that's a good policy to have for compatibility, but
if it's known for certain that the DT for all users of a driver is
always built into the kernel then I don't see why we shouldn't feel free
to change a binding. I agree with Paul that it'd be interesting to hear
the DT binding maintainers take on this.

Thanks,
    Paul
