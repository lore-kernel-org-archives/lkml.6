Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AFFFC6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 17:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A049A23E0E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 17:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="nWwsyxsC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A049A23E0E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937179AbeF2RNm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 13:13:42 -0400
Received: from mail-dm3nam03on0118.outbound.protection.outlook.com ([104.47.41.118]:43271
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932446AbeF2RNg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 13:13:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LyhsDRXUH2sPPEwT4gG52+CxwHBA4171ewTZ7JiLFXY=;
 b=nWwsyxsCQ47lndbMetFi2NjrgraRYGhoOKLbQFjWuJmvlY2h8pFi6Z35WelWZQnX7Mb/0Q2Y2m6BfFW7jsvHxfNf5WBu9kF45HIRjFaV3Af0667L/aShxsN/w4XFdTd94r52a4H1ZeswhX+Qgot18PEGRvSYZ4GKUs5+iVkQbdg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 BN7PR08MB4932.namprd08.prod.outlook.com (2603:10b6:408:28::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.23; Fri, 29 Jun 2018 17:13:33 +0000
Date:   Fri, 29 Jun 2018 10:13:30 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     "Maciej W. Rozycki" <macro@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-fsdevel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/3] binfmt_elf: Respect error return from
 `regset->active'
Message-ID: <20180629171330.4giikc5x2cbxxuyc@pburton-laptop>
References: <alpine.DEB.2.00.1804301557320.11756@tp.orcam.me.uk>
 <alpine.DEB.2.00.1805102009380.10896@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1805102009380.10896@tp.orcam.me.uk>
User-Agent: NeoMutt/20180622
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: MWHPR2001CA0011.namprd20.prod.outlook.com
 (2603:10b6:301:15::21) To BN7PR08MB4932.namprd08.prod.outlook.com
 (2603:10b6:408:28::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 891f9003-da92-43f3-bcc8-08d5dde3a514
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:BN7PR08MB4932;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4932;3:6bPEvMwc5FPhUHuUbD1rMMiXjvtEbbIAOI+Lecj2CFgTptGtrozKQmPsm66n5erhC22HzBLXLFaidtslf9mxfWeaBW3hH80m5pmMbh4mcwO9D25JyedTD4Bp+QKTRfqWzfPkoqfF9dZI1qqAEy0Og7dCxqmT+mDP2fUuUQ8B8+M6VDA+pXTJa5ZtdpfXTskBPEkMRe1hI1F4aod7sjtPGGi/mXt9K9NsEl36iC4w66J+o1FJAIVD4I6v0s0WhA6K;25:QRMcbmAiJr0b4WDr1FsdhLZy06d+8XWT1JsEVmz8O3FJ3QOzG607/mXSLKbgygFyhFgf1ehIyy0yM0QgVK1pOheWlJ3Amqq45JM0V/LF2wUgPEuO5YyvdzivBeoF/LpHe+Kgc8OQ46sWUumN9nnuSeR2av2oxIEiZG6zOfHak33aArLfHob/uEZgrdfOop3j4ohgq0BucxZ8ymCE01Ti5y8ALSbxYk7LFC43rX3Lzka+oiaKuv8p62Bum8O6jQACTh8eyH0i11q9g6UMc/4PgfJ8NMqu9460xe2YkEtsZSI+s8RFkwVrc7XlfWw8JyA2ZyW02PuG6BZTztLX+/Sz2A==;31:pmu5ACnmDGtdL1qb2RgIxBrvNxWpuBl5Ro49AJZY+WUxk5pCgZMdqAbdJmJJQzgqBTvAuRLTym5nrv04s/rpZ8dwZBRVXRHNhuze4z8zJ3aRpU61yMJvKTQNHnF/SBLWXL6GgwkQbYZjxaRoVjYL04V4ptQTrI+wmSkMkZ9aPmRDl3/Bb9y6y05Esvu6tcTHdyZfHd8p1XmT6e46aRxzgZVIEpH5tepUi9uITXhE3rA=
X-MS-TrafficTypeDiagnostic: BN7PR08MB4932:
X-LD-Processed: 463607d3-1db3-40a0-8a29-970c56230104,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4932;20:cGn3E8VFDzrm7uI8KFtjunWuKAmNf87/0cF53GJ9fH02N6g3MPAQRxTlB/6WYWsBFUmBihJ4x5Y6tjBKXpPbQLJs+emxRKTJnlw1g1UJhL7P1wV+qUAjtgB5hUlxTDFHUK0/Cq2oCdWiLkX8gNwWf1n5DkCGbzezUiTo7b6YWFoagkknaqy378KXJvrCDq4v1SUIUR8b0mmBptjGIgy+tHFVHMRT05DazyDirj82FQq7ZEFvkxNXpueuZwBCxTwl;4:bfKtTxPY1Hvl/9ZWxjzxXQv0knkr9Wij46LqnGtVbQNhiu5CKuUQARt2jprHz/mmT7WnWJJ7xn2mKGZ8xfrf/4D/T5u5yiPJAIUr4hTIp8neIzU5Zc5ZtBP0SWlij7jjtO4sotVtcPqhTxJwzYdInVKS9YD+ia06AdMzi/5Kk7aZRd5AHUyMQ+X6yh/v2Qkr2FQAF+ayvqiBpN6J0RIGBTfq8sWX6xBLkN1twDX2wirEjgtfd7HWRH4o/LJSYOduW7c/SuQUr2KEfqp9uNJo/xZRi2YzWoolbK3tZlxI8FEO6D48nZdFyf0PuurnT70u
X-Microsoft-Antispam-PRVS: <BN7PR08MB49324767E0031C60F0C0C295C14E0@BN7PR08MB4932.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(10201501046)(3002001)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(2016111802025)(20161123562045)(6072148)(6043046)(201708071742011)(7699016);SRVR:BN7PR08MB4932;BCL:0;PCL:0;RULEID:;SRVR:BN7PR08MB4932;
X-Forefront-PRVS: 0718908305
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(396003)(346002)(376002)(39840400004)(136003)(366004)(189003)(199004)(68736007)(4326008)(956004)(9686003)(25786009)(44832011)(476003)(76506005)(66066001)(47776003)(316002)(81156014)(7736002)(81166006)(3846002)(6116002)(305945005)(5660300001)(11346002)(23726003)(1076002)(8676002)(53936002)(486006)(8936002)(6246003)(229853002)(446003)(105586002)(76176011)(6496006)(50466002)(52116002)(97736004)(58126008)(16586007)(33716001)(478600001)(33896004)(186003)(6916009)(2906002)(16526019)(386003)(42882007)(54906003)(6486002)(26005)(106356001)(81973001);DIR:OUT;SFP:1102;SCL:1;SRVR:BN7PR08MB4932;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR08MB4932;23:dvr0HUp1QzwMxxLKdgwXw9L8GF5youyKN9loojLTp?=
 =?us-ascii?Q?QD8vyyWD8lnE7fOqD+suMbhrEKieuVBM9SlV8HOpkzEro2UjwypfJ5kMC/Vf?=
 =?us-ascii?Q?eblftdZxhUvDcnftQJWW8sBCghiMPyj0/zoHOCjaepXkYD0j07VN4FNP2naG?=
 =?us-ascii?Q?nJC/Pb0of+424mbK8iiGmzGfhqle330tAWcB8KCK+J8gwqIJRMs4pzE5KVSC?=
 =?us-ascii?Q?eWag5JRbuUFBOFrk56vIkLRxobbAyZemlQw0yIQ/LUKS/pzMQG0nBvfPImQW?=
 =?us-ascii?Q?4IWNCT3m0ZHdw+0jzT5pFkRmBRg/RZXa0dY1/zWUSD+jxC12ijiWXh8nOSPw?=
 =?us-ascii?Q?RGjZiBsecdiMZuPPomg0ZuGD9sTz/n4gsGTcvEs43MrYarKmkPbQ9+TQ06XS?=
 =?us-ascii?Q?2nJO/zXlMAC3JF/0JeFtCeNlcTXzMyQT1fuvTkooR8MJeqHrWp5Vwu8SMfJ6?=
 =?us-ascii?Q?JVNL5UlHtduQHjnfhZdt+4eqftxRnkjolQeUFxUKpRPVtwlz6Ix+oRo43VD9?=
 =?us-ascii?Q?VpPW4A7cErpXh94NHAcQvlGSVSo41MdoUsKMRlNGb5bNgAfLLik9J4ZjagcH?=
 =?us-ascii?Q?SZzt9aYLpRGKLUlcfnequpq0zG5A9mv8RynrszysxWu1ppHcyKa1MqPJSB7r?=
 =?us-ascii?Q?reYCgxlMWXTyNh0+6pT38mQANE0yaXr0BwvIKKS1eYj4n++lJ+AZJwUkMGE8?=
 =?us-ascii?Q?5YQqwFMgAC4UnORNLDj7eHlVIkh/0sXakyBz8SX45v1HXsO/mc1sNOdAqp0m?=
 =?us-ascii?Q?ZFvLzH9kBCKiyPj3YNioj0m52rw+OICqJHnz8VMkawLCqzRZL8PbV4INHnh+?=
 =?us-ascii?Q?7j+MH55qo088dgvRMCi0rs/Rwqr5LT6yPPsuWoIUeCItiVwjzRbx+UMtiu4S?=
 =?us-ascii?Q?vnZJl9fW9AjBoC1eY27k+GpLV0m6XYiFKGxYUgeyZzGhMRcjt/xN/43SSn7H?=
 =?us-ascii?Q?jankdHP+vveDNg9ocKVeVcQXLffEd39H4zN1ZGcw2GyjUBt/48knBmIrwV4K?=
 =?us-ascii?Q?TYiseLZpvOeiIWsmyV0yx7IKN0HmmohTfBDCKjDT8Zd5eBGk3m4MbBeS47vO?=
 =?us-ascii?Q?UMDb4C7I2LSetxls9+G1a/7i1UMt+hopVS+q1cguEMnTTElMAsncml7CLM8E?=
 =?us-ascii?Q?t89FDNUYYVAzOeAKBa0VSVEhtzn5K3GHleA1quky89F3iCqgXoBnF5e03XxX?=
 =?us-ascii?Q?yQyu46HBmaM8e7L8ZwG2pstnqRNvCQhnn6QYAAncdhwX1kigjENS1lUlTR9T?=
 =?us-ascii?Q?I0epyPce7a9a+iG8fxSXj/Aycw/Qs+V/Q7EQ+5glHdCyr+rGmlksvkrfeuqg?=
 =?us-ascii?Q?9Z/ARvfFDqfqMxEG2sJttM=3D?=
X-Microsoft-Antispam-Message-Info: fzbQcNxnf9Ebz2aKw4z5wsuX3nRYeErIWWgpw8yV+9zy4NVdtRNcRnnRfUxgen9WKKneQPSm8iajyy9QLdiH8gIlk/ekgiZUPAaEcJRTAGl1kYmGOOR4hn/w94XEf3TKk5r3reHFD+DR1iYy+iVr2/7ztEISskcIQqiERvLJaj3UGxDshsxjSdRCxPWT0rX7ef9xQrH9Jipjyr0N5RSe9Siwmio2IGO0yFL2n/P7grfNSdNLJVnRHbdi72YHcHi3ekD8gNv9j6LqHZcYY7ykQy9qUye+5aRMP3pTnnqA+8/3nXEEDlSyAdeck9ldGzkkZ6GU7v8KCVEHww+7hXgeQkSyt/9/km54VfBB5Ic9rVo=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4932;6:hRo9WoYfQ6YjYVRGghwT6CFvTWmzGuAA8Bss9B2YhtLXSXrr6/NoF34YWEsDWqmjNz+H70WVnyCK+Jd2Fhlv9MN/l5DqMqcTccZkV2uax1VpVWU0LOOL4hR03xVNhAMzq/37+NEiAb6xPTWe6CVSKgq4PF2X/aKCJQGZs3vwlCiK7m5VVCHjS4oRZLa/2wVOfwAC4ElwIuxdSkX48lm1uEIXRj+9oxTW5jPLyw304O3CsIdY78k/tDsmBiBnQZhzpw02hed3x7Fb7Io7yUkpxoNkWb/mFwK4+vGejG78muzturHZsVh1hZjUs2UfBvZcq8ns5NhXaXJCtxn70OSXY9f/29wuMRTLzrFB8eU3pibc9ZMUax1uh4HKGYnz8h2oaJ7Cxhdw3M/KDmJHpW6Mt8sYpyq+Twl+15zH5l6tvmUQlZPmtGnHc8h6CGU48iOexMrbvPhojGHKMD2MZYCeHQ==;5:PaAgEW4SxZH3p6WM94PtKdQb+ykpMXRjH879BHX6Cj/BWXO10rJxSQLsatE3NHIafFlVP0jteQ8/nRFfvz5W+BN5Gm5rYhntVEyiXPwI8Od0QLZcCM1aWx0w1rEWy3kcYjaue4WwJLkP3hOqCm0xhcBxtsZzN/ZXUV6yb/djVP0=;24:syf7gfJzB0S5VJNTd1cRv42BViU7ljJqW08tPqUB9a4NdvOYOhWjcDbkqf9WZSIEYnFzV8PSwN0+h2BrMcLFmANUX6hYoH8Lf012k9oTWTg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4932;7:I09SNaWl6y2+wAR1+O+BXNoSFZw+2A1pW5JzUx0X/4KY/ekBczlS+J/H/MaDDqK8W2DLrggXYKXB69Apb4PwIjBeb8KByful4OFWTVODEDcXgx+Qw4PEAaKjsaNFLVrOgi1jGFYh1UnZGtk5GK91JsW5rAKzV8eVW50u0s72OGvnG4580WPNLJJKaljjUxnShF7KM6N305FGBVwBYd3o7YzXMW+o7b6sfF9sjdGSr0ilj32KEdiH3l413wvD9vIl
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2018 17:13:33.7315 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 891f9003-da92-43f3-bcc8-08d5dde3a514
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR08MB4932
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

On Tue, May 15, 2018 at 11:32:45PM +0100, Maciej W. Rozycki wrote:
> The regset API documented in <linux/regset.h> defines -ENODEV as the 
> result of the `->active' handler to be used where the feature requested 
> is not available on the hardware found.  However code handling core file 
> note generation in `fill_thread_core_info' interpretes any non-zero 
> result from the `->active' handler as the regset requested being active. 
> Consequently processing continues (and hopefully gracefully fails later 
> on) rather than being abandoned right away for the regset requested.
> 
> Fix the problem then by making the code proceed only if a positive 
> result is returned from the `->active' handler.
> 
> Cc: stable@vger.kernel.org # 2.6.25+
> Fixes: 4206d3aa1978 ("elf core dump: notes user_regset")
> Signed-off-by: Maciej W. Rozycki <macro@mips.com>

<snip>

> --- linux-jhogan-test.orig/fs/binfmt_elf.c	2018-03-21 17:14:55.000000000 +0000
> +++ linux-jhogan-test/fs/binfmt_elf.c	2018-05-09 23:25:50.742255000 +0100
> @@ -1739,7 +1739,7 @@ static int fill_thread_core_info(struct 
>  		const struct user_regset *regset = &view->regsets[i];
>  		do_thread_regset_writeback(t->task, regset);
>  		if (regset->core_note_type && regset->get &&
> -		    (!regset->active || regset->active(t->task, regset))) {
> +		    (!regset->active || regset->active(t->task, regset) > 0)) {
>  			int ret;
>  			size_t size = regset_size(t->task, regset);
>  			void *data = kmalloc(size, GFP_KERNEL);
> 

This looks obviously right to me, although I don't think it affects
anything until commit 25847fb195ae ("powerpc/ptrace: Enable support for
NT_PPC_CGPR") in v4.8-rc1 & even then not in a harmful way so I'd drop
the stable tag.

You show up as maintainer for fs/binfmt_elf.c though, so before I go
applying this to mips-next does it look good to you?

Thanks,
    Paul
