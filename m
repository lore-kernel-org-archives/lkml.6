Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB6AC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 581A2249C5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="GOLUQhis"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 581A2249C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934030AbeGCQxL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 12:53:11 -0400
Received: from mail-co1nam03on0123.outbound.protection.outlook.com ([104.47.40.123]:53871
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932392AbeGCQxJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 12:53:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RwLYOo76zaYO/lwQKJeN9Ea3MseAQisFZnNumDlUHUk=;
 b=GOLUQhisp88xhF1GMGGTji2HYk3MAKU+Oxiz2CW2Nq8ZcpZSKvGP6Md5UNrBXWOr3C7nOtpgiYF1k0WLS7yvmTm9inQojm1d3J3zoJbTHNqo5TKYe2iRxIpeb01v3d3w+ShYWPQS+lhcr5DE062u8wYITQfu2ufHlN0ftQaHaEw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 BYAPR08MB4935.namprd08.prod.outlook.com (2603:10b6:a03:6a::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.26; Tue, 3 Jul 2018 16:53:05 +0000
Date:   Tue, 3 Jul 2018 09:53:02 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Mathieu Malaterre <malat@debian.org>,
        Daniel Silsby <dansilsby@gmail.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 02/14] dmaengine: dma-jz4780: Separate chan/ctrl registers
Message-ID: <20180703165302.3gdukxwwro5cwqba@pburton-laptop>
References: <20180703123214.23090-1-paul@crapouillou.net>
 <20180703123214.23090-3-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703123214.23090-3-paul@crapouillou.net>
User-Agent: NeoMutt/20180622
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: MWHPR1201CA0011.namprd12.prod.outlook.com
 (2603:10b6:301:4a::21) To BYAPR08MB4935.namprd08.prod.outlook.com
 (2603:10b6:a03:6a::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf131c84-aa33-4f47-e29d-08d5e10572db
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600053)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB4935;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4935;3:gNZTRApb5njPZfO9cm3QekqNyqDdmKBAsiAviVVxoaVUlq2zmrAYEFWJLbHxRzcQqRHRaziT6GNK/nw62cXlfHEX+PCbl2r06EAHw30ideT+YL6FVN+d9HfJFWjq0U9Hc7PEkiNrAZOezGy43AtTn10XNge/4Ir29Iep3zCTUvcqwaNWY4cxMasOZp6J49XQHbSF4Tu90sWIdsKnSTBoyR+M6GUiJCkAFT6Fs4RHO+yciC2RlJMSEhsnateMDwy3;25:yESr8Pe1DojEAV0KWvLxcEh0RlNGb/Z0YtzTcLmJOs1PsJqTkP7Iw5cRfFjOfFZQNQCmJCGMI2Ru3GrrnA2c7iI8XsgapYWSEpRFpMWmRJKsqOweqpLD0Lc03hiUS2GMfeHmwZytDyXBLnvGgBydVBjH/dUN8r6SibLpUcTcv/pyBINBp9/h5WX8YyW7j13/pj8JNP4MnxJR/bCCPwFSCtpSzkyaVg3iqnSrgYkX8CACyU65Il1F09cSGImta7aNG2loEHAGXedQxG2reew4zb4iRfFfO6AiXwgy6VlkQQ09DTgZQSx3ethi9OnVuXirzk7mYoYEtE9VQhn7/nb3GA==;31:4+ENP51phv61Vbf7E1uYJeJ5NFJA5hbpK4WPN+2I154S9oVPSePrJuJ7nonlQBmsHM49GoKbgwq0/org7XQRo/FRR4k8uWHH1w3V+B9/M7kPVrQNHdzUSKxo/7j46rPwaVZ7mo07iUQan+c0CA1bR8rSuP3pMsajWDGbPA3nW96siMk/TFkWA0RsEkTH2xFfUFxChH94+8jkD3ua5jbEeRG3Yf/9u5gpH24DGEdUhs4=
X-MS-TrafficTypeDiagnostic: BYAPR08MB4935:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4935;20:s+irqDk7A3OpIaSizmg4BML8pz2MAWocfuEkBuKqqA0XBjw/bqJYOgJV45EySXekJOz7D9vUJQxllf0oXocSvdVLDJ8g1MR+77871jqO40PfVu3QMhDqMFhsc26pSlFrD56f/S7ZS6fTc9ok6L3J4/riqbslKQtjSn7bl4SMI90JqZq17q2RKobeqH4jc3Zys8WBo8ZW51lRKqqMLLnDWfevaoTOyJOhvPEXnOd81gN2GfkczfJ70ZQYiaITo2Ae;4:A7SzxjofaE+oMrpOEwYZHY6iEZvaQV8fDr4SETH0NXXtYzIqUPfEr4tnMKkB0YHm6v0Zn9VJzWj2sZJjAlYBHzK45RE0kpmtEAJm46mh4Qztq0U59f08OTNSmpf+irbbvLzvIbekkXVAKYvDu4l9sGMj2/EbyBfDBQjMKubaIoRrnl6esC6D+0mPFB2JN3bjU8AoV8vosM8k9ekCT3qoNFYZCv/TxgkECbPVyHElXceqdEPdtTvcO4xmnqcu2CuqRz6duCRwWi3pJ/ALwDm84Q==
X-Microsoft-Antispam-PRVS: <BYAPR08MB4935A7793B312A9AC92181BBC1420@BYAPR08MB4935.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(2016111802025)(20161123562045)(6072148)(6043046)(201708071742011)(7699016);SRVR:BYAPR08MB4935;BCL:0;PCL:0;RULEID:;SRVR:BYAPR08MB4935;
X-Forefront-PRVS: 0722981D2A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(346002)(376002)(366004)(39840400004)(396003)(136003)(189003)(199004)(16526019)(76176011)(25786009)(9686003)(305945005)(6666003)(6496006)(33896004)(52116002)(4326008)(39060400002)(58126008)(316002)(54906003)(8936002)(2906002)(956004)(11346002)(446003)(8676002)(81156014)(16586007)(81166006)(44832011)(14444005)(476003)(7736002)(97736004)(105586002)(66066001)(47776003)(1076002)(53936002)(486006)(42882007)(6486002)(6246003)(33716001)(106356001)(386003)(229853002)(76506005)(23726003)(186003)(50466002)(7416002)(478600001)(6916009)(26005)(5660300001)(3846002)(6116002)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR08MB4935;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR08MB4935;23:1yWvXqlxYwpKu35K3bG70mqQWYPb08hK6J6wPXKmV?=
 =?us-ascii?Q?M4OUbzDZdTQnNiIcczXv4uao5W3SIQ0Cb7zdzhSgwejnJceynJ8qP4NmDXC/?=
 =?us-ascii?Q?B76NnVKGALydwbRGM8DH4iQv5YCbEkhrV7jQ52GFY5G+uV++29GGOeDek2GX?=
 =?us-ascii?Q?bRKtqRf0LulokW07o8+OBo4jdHbzRLQmIrbB18I4/dXd480MMVbfG1ZzlO4I?=
 =?us-ascii?Q?ZRz/tx7ojvSJgz6SjCyRSoMZ+4JS3GorGqi0b0TsSndzmDSurTksYE+DKx5/?=
 =?us-ascii?Q?yLFy+OH1BYFBLfeC0YS4FCkZRjpFyS2O465SY9zxmYUlnuRu9YwOzRZeb0xE?=
 =?us-ascii?Q?9au0jHKDdLN7CKyM6xs7N3FUu0p6B9K43ZLH+4kKQ24k4GjLI1KQ4LvMB2Mw?=
 =?us-ascii?Q?3q6Bh2LNk1QJAaMYpehwzzSBjDfe0PanFJdNofV0HpRUYUxUB6JgQBqZritY?=
 =?us-ascii?Q?68Gv6JZzid1ACAmSoMzFuIvp4oNlfrkOFsfiwNy1jPnyS+357FyofLIoVW4E?=
 =?us-ascii?Q?9UF66qTfztlyoCMQFA7rLK4dcK04GY6N57UFwVl/qvXWLIKdoDetdrV9QAUt?=
 =?us-ascii?Q?QV6rZF5bFFpraCbw94zxOUaGpzK91pqNYYvMvBcNNoyaL05NUyA44HzQoAFs?=
 =?us-ascii?Q?2sZeBHtZaQtP5VsgD+S5IkSVfcqlABYNtfOe8Ne1wIYgA8EVkP0iHurGlZD/?=
 =?us-ascii?Q?6jWeRbvElDmXgcLpwn4UGEyihlpCmje9k6gV149V/sdNfHhjRMEqe4wtA3i5?=
 =?us-ascii?Q?I8/4wZlRD6XJo5hwucmvSIsb5kMa0208+u70LmjcYEcJLtVTaztUslJROiwU?=
 =?us-ascii?Q?eZ676LxoW5zekV0RZ+D+Z1jjGcmv3VDXeYAWXMDKZXS14DtWmAOJYSq7vqv5?=
 =?us-ascii?Q?LL57ccTt9swPIbIt2FfYgONUNqfLhGI6qvTyfHjlApGg+kHsS9J+6jyZmyYK?=
 =?us-ascii?Q?muT5VptakUiZGzIPfwPn6Cl4BYPO26vsXeUnFRpH7212dEBHqQOlYYIzrvhX?=
 =?us-ascii?Q?JRZ3vRphCHWpVqL1WwFHZVKWLNEwd/UVzKGYJVo/y1nVNVycI3tbiETlAIMd?=
 =?us-ascii?Q?SRmC4C/lxNYMVN5iqcZlziemC5fgXG/ptYRakynOFZiIn/YtosGbGIhByRpN?=
 =?us-ascii?Q?en4rmQREVZZa4q8HtffKVabXbDuGeNwubAuqS57Cm4GxwPRZnCnSFP9QTbF4?=
 =?us-ascii?Q?iL7GkupQal76vUcgoLfnZlXoetZC9woOcGDK7q8VVBCnrTyOGUFj1UEtQEyd?=
 =?us-ascii?Q?gl3LZkn6G4EiAoqN++QuY+7nj3yItP9L80+Aj3rRdh5f13m0kgpds0iDSMbz?=
 =?us-ascii?Q?vCeZJTYFZNQLa6Ikyge3qSH490GuG8lVJFmZ2tLjeY2oVaJTnkY0eP56Osxi?=
 =?us-ascii?Q?BuVdhqAU/FkadSmb9H4QhY95Z8=3D?=
X-Microsoft-Antispam-Message-Info: WJ/dZmSw9tF4DyXJ+wLbRBBS+/Gb9KZOjTq3wb1svtmah7hWiDxgR6Y2tfnEGk/9pt8IQeKewhVNCaZp46uqZg9vDGMAL6PrrqIGjWCVT5ZTdhCfrv/AhfXZ5FN+8xxMuy3+E4H4YVE/tB7bk0u5dMuxJ1U/ZD4iRvII3QKHHN48xTDuCxnweSnBkMg6w5gWNixs/yzm4Gb1AvLLjC0uMjRWqd07bg23WlpPWZMNdXZn5ckAZpdOTWYWVDq7rU7c5OHtHCDLJOXu4iUgbv4Mwa1SiTt3wsvj25tTCzgVxNQxgsKshJ6sCCRswxwyOU3QnKveH0IvDIEo0CxuVbMBtrsXJssqEU85H2+Nvrw77iY=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4935;6:uIM4XArnVIizNvXkur3K9eLRBzPQ//9lM8xriwsDef99/TrFHUmbd8Mu+5WAhIkPLJFWrY0iefnGhFwT/K0+jUIsd+8B3PDuXblJxI2doXN6GhVS12LFjLPgAUTyDrPq3XvdEsJm+AMluofW86JM9EpQTpf5dQee9qhZBqKxocA/Y/BrnbllC7gIGhwaf9Bratf7y6r3C2keyqHxlij/3LOtD4pnisY03iaU1bL2/olVhNN2UavloMMxK3QUZGTDzt21hshATgQuVbjRwei08cgg9yYCly7U0ZFcv5ritAZNTmIB6H0mQs/KFGa6uhrXVAQ/5WqG/+nWzMWjlu4QNkku+acTXjrJ/37XOXxnBYRWQiVFEHAE1SvBUEOllym4GAiCWv8JjYXMV04b0krggxAEPsetx6JiLBn1krx0lnTI/YiHN8O6CuVYkekY16frIqWNJerSJkrJgqlCKHicSQ==;5:IuasGBPqaI7vm6c7HbHW0unELqML6yPJNbuxjwwuEoo8JBgjbv+bRMTvNzvGD8bqv3XWPuP9OfOp73/zymx04gRmhgrwB/1C1rSe+Jz70bmhImibYFPgmK/b0YOrLlWpuJf4HFnJCPI5seX9wUJeliNYhxrHspiewWZCjZH+N6w=;24:y+cLvplHU5jWLSM4bCR6FnIiKi4qjhsepPszUHqYP7xgvzTzL94OinsdCF1BHZrB1tAeT8onKRGOXV7pUHtH4KNqHr1XpJGEdpykGYKuZvg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4935;7:ZXEFYTp925n5imDhX2UumjqJdJykjumAmrT430uSNU2CzKKjRrIrfUTdTZab+X9E3Hww2SkDiMr0a/JpZpbwhmM6v393eoAVGd+XqNndmNl6TvbESEXqNQ1hoHBBJFKF5zh6G82LgiL2i6OiE4Vxj17FKjWUcd8e97PKERjWgDmt/9jbtMMNAWD0bW7jr/yGncWeOkEMa8nLiKHZLcMa6516wFGEy1d68BItoiFnoOt0JI4XBjvmvLTU0uxJHtBn
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2018 16:53:05.9351 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf131c84-aa33-4f47-e29d-08d5e10572db
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4935
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Tue, Jul 03, 2018 at 02:32:02PM +0200, Paul Cercueil wrote:
> @@ -804,9 +818,19 @@ static int jz4780_dma_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> -	jzdma->base = devm_ioremap_resource(dev, res);
> -	if (IS_ERR(jzdma->base))
> -		return PTR_ERR(jzdma->base);
> +	jzdma->chn_base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(jzdma->chn_base))
> +		return PTR_ERR(jzdma->chn_base);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	if (!res) {
> +		dev_err(dev, "failed to get I/O memory\n");
> +		return -EINVAL;
> +	}
> +
> +	jzdma->ctrl_base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(jzdma->ctrl_base))
> +		return PTR_ERR(jzdma->ctrl_base);

Could we have this failure case fall back to the existing behaviour
where we only have a single resource covering all the registers? That
would avoid breaking bisection between this patch & the one that updates
the JZ4780 DT.

For example:

	#define JZ4780_DMA_CTRL_OFFSET	0x1000

	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
	if (res) {
		jzdma->ctrl_base = devm_ioremap_resource(dev, res);
		if (IS_ERR(jzdma->ctrl_base))
			return PTR_ERR(jzdma->ctrl_base);
	} else {
		jzdma->ctrl_base = jzdma->chn_base + JZ4780_DMA_CTRL_OFFSET;
	}

Then you could remove the fallback after patch 13, to end up with the
same code you have now but without breaking bisection.

Most correct might be to move patch 13 to right after this one, so that
the JZ4780-specific fallback can be removed before adding support for
any of the other SoCs.

Thanks,
    Paul
