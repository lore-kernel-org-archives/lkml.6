Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB2EC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 05:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 869B32089D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 05:16:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="OSLajxs1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 869B32089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751005AbeGJFQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 01:16:13 -0400
Received: from mail-eopbgr80111.outbound.protection.outlook.com ([40.107.8.111]:45030
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750868AbeGJFQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 01:16:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2yu8rXiqMIxC8w6AwqqE9DuaYZwbuhLm6beWsiT93+8=;
 b=OSLajxs1YBRoFdUMa0MwoC59NaNIhQNq8O1nmHRGKlKwWvTVMuKH5ShipM8LCH/SqRyLORstv9ebBYGiXCfwCpdb+nQNZ9PlSD5jjY+6gMFHiqDvS/OxuyeU85Lf2ZAU/Qje4h2F4oqybSk5k7A/GrVIeyVd3EhisdianpL+Qas=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=avagin@virtuozzo.com; 
Received: from outlook.office365.com (73.140.212.29) by
 AM6PR08MB3255.eurprd08.prod.outlook.com (2603:10a6:209:47::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.17; Tue, 10 Jul 2018 05:11:55 +0000
Date:   Mon, 9 Jul 2018 22:11:42 -0700
From:   Andrei Vagin <avagin@virtuozzo.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Adrian Reber <adrian@lisas.de>, viro@zeniv.linux.org.uk,
        Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] aio: implement io_pgetevents
Message-ID: <20180710051141.GB21096@outlook.office365.com>
References: <20180502211448.18276-1-hch@lst.de>
 <20180502211448.18276-8-hch@lst.de>
 <20180704142116.GM17048@lisas.de>
 <20180708204359.GA19198@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180708204359.GA19198@lst.de>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Originating-IP: [73.140.212.29]
X-ClientProxiedBy: DM5PR13CA0040.namprd13.prod.outlook.com
 (2603:10b6:3:7b::26) To AM6PR08MB3255.eurprd08.prod.outlook.com
 (2603:10a6:209:47::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06e2031e-0464-46c0-3826-08d5e623a90f
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM6PR08MB3255;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3255;3:+eh+/Ke0SR/tbOYP0P54TOYdvfvXwbFovrxJPdiC5MPtyjNF4VV/FY/AwvttpqFGQaeqN+7zYGYRJrN2dniTzH1OdG4HpTD7TlpJ2GI7aL8DficUMY0kzu7yfBHlQE+Z3Mf1VZ2FpL3nFKB8Q5ivE4z9+T43jUaxDjkfRkRab3Ec19cBI9DflLl8VYsTGHDycVsX7ClAOnnp7rN4Uk5JVVMM6piA3AlIifpSPiU7nMBhy1Qa66M/qf9vmrS5MG25;25:oeQcMCrMq6py6qhBSs3wcXiSje77DmLShd5vy5GY1z9bnoRJSgD6hvAinjck4K3zVBSqCLkufADkN5vsuOHw/KwNNzKMOyBnppNwDjQ4GQdhb39BBiS3JNFgQAcgyHkCIZoWnlun33Th/36dUrlErCx6YMOP3iuwV6ltuuZT+hADdn9zTn3s+xYcQiqmKgoHhyn8YTAHqaI/uCnB2YsW9ugu1Ah67tJ6RJhYaBocReEm1xbwLqifVOwDIBAFnXISo99i2BWA2bhF6lVOwVwyP12TQ+mKhvSeOlYWqZ325XqZ8U2FDZoUrbUuHdFtX7iIHk3DW0F0SROK2LeopdGmlQ==;31:3EbmPGFAnH7rafr8Hl5duzV8vEAHz4YFEtK0F9sH+qcSMGRcHxzSTNqBVSTZi1Ob6X36tJ7Y45t5DyJbAdKUgI9+cfoxThwa/FN8QILTmizZa5tcllDExH9F73Cfj0x48yu++OdNaYznmh/DVAJtdBfCdoz8WTExFnuzBZkgCiQaNkbOjSSM4qTbq+Tz0SWQEEq4K3nzYmXsGFhQbFU8+qIi3a38VSPrlIKTPMBeci4=
X-MS-TrafficTypeDiagnostic: AM6PR08MB3255:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3255;20:b1j34Z3DfVTFgDHyYuMEnVdaBKxyj4tQtmbRNoe33tn42FwI9Vc1xS1yalua/qcx7+3WoU2xLX4avJRaQ1DjZdIzYQ5GaPJcilZTJapWp4sZZcCxa4twVfyc32H/q9rX6cB0vsWC6Llj+4YOWwHoGCdp4ZSSQBGBMaVgNZIE6+4AsqmlKK1XMSzA/VITCd6he/AiEChZG34p0S4Tu+1hxEQtUZ/gWtHa4saSjM+eKAFRd5zq0wcwEo620dXzO0FkLpOGZzj/eej3u0UFYYWkeOTUCueR+C5Ir1X6X5BD37jYqoHtilUTY0kL0uUSRs52pJXuj8iGgDSTaA6P3QWrelNS9R5GLvIRc9aG5lj0qSZVI93J/cfcIhVJ70ctQDwtwVdUqADmMGdWLn4zx+FZwkXX4b1jZq+Nvrm+H2gvrqZDtVKPMF8MlLOBKAJg+K4xWXBA5PSTpL0ykJgSosml5YGENzfymSLa1LpJBmu5m8ZZI3sraM61Ta7Gt5g6zxvl;4:/pnE0nVYmxaXWqejBUMBRqwGX+3fk8FnbQoCxund5be6Hzw/7XAh+RVIhhTgesM/Dy7OMw7NBs+0R3oFd2OhfX34ppmX9/ROC20/N42N8qKOpuoqHsK1W3Ypgjk16SObp/ao9U3K3+m4LNypmfSXJNXo6CsEYZhBB8mobQrFyc96viZl0fDI+lqyLXMq+ooju4xZMJuLy6lk8B9XBOfTaZFjOa5CSeRadjWCPKrP9KOhgAZUM0QJIJHTpXiOJrrnbQMGPacT6598UFfOFbz02w==
X-Microsoft-Antispam-PRVS: <AM6PR08MB3255A614A6345A7E2D76A8FFCF5B0@AM6PR08MB3255.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:AM6PR08MB3255;BCL:0;PCL:0;RULEID:;SRVR:AM6PR08MB3255;
X-Forefront-PRVS: 0729050452
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(376002)(396003)(39850400004)(346002)(366004)(199004)(189003)(11346002)(2906002)(476003)(446003)(956004)(486006)(69596002)(33656002)(8936002)(229853002)(186003)(16526019)(81156014)(81166006)(26005)(97736004)(6246003)(6506007)(386003)(58126008)(54906003)(52116002)(305945005)(7696005)(55016002)(316002)(3846002)(6116002)(105586002)(25786009)(7736002)(86362001)(52146003)(478600001)(2486003)(8676002)(2870700001)(9686003)(76176011)(5660300001)(1076002)(6666003)(47776003)(93886005)(6916009)(66066001)(53936002)(53416004)(68736007)(106356001)(23676004)(4326008)(50466002)(18370500001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR08MB3255;H:outlook.office365.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTZQUjA4TUIzMjU1OzIzOnEyRjE4UGVPaityaklScllhc2Z5UVZHZU9x?=
 =?utf-8?B?NEh3eVRNak5XMlFPeXlQNUkxSkV1RGtSL2oxNmF3ekFrWjdIekJBRnZ2QlR2?=
 =?utf-8?B?a2U1VXQ0Rk1LN09QQ3FDS0lnWDQ1dlhvdE1VTUlOQlp3NEgzOFZzZGtQRmtG?=
 =?utf-8?B?OUNsYkcrcWRQdFkxTWErTzY5YWNWSklVQTMxWXJseVZVTHc0bDNoZHVmOFlm?=
 =?utf-8?B?aWJicUkvOUc1SGJSSzdmK25LSnBiM2F2SUtRNVo0b2I5ZHdVb2hndndFQ3dJ?=
 =?utf-8?B?TUNsb2RxTndUMjk3cnZ3WDVIeFI0RkM4cjBmQ0JLcDJBdE5HQmRIYTBjSFZQ?=
 =?utf-8?B?TzlybzNLay92NEhqNitCRzVRSUVoc0doVjhoZkNNZmF4dDNwb1VWY3FlZ0s0?=
 =?utf-8?B?YnR0czdjVnhkczJRTU82UGFPUEx2aEZBbzFOSTRYcWNhOUZTb3VkbHFTckcv?=
 =?utf-8?B?VTFpVXVFWXI1OXVBUG1icHZkckMxbkNETlVtaG4vVS8wK202WkNPdklHSU5a?=
 =?utf-8?B?S1lGZUpBa1hkdER1eGR5Yy9KTmYrQjhBTnBXaHlLZHFqVnFFN1pDc2o0Vzdz?=
 =?utf-8?B?c1A1UURQLzVTNnFTYjhIdHIxZzZSbFY1ZnpvMUNIZytGYVEwaUxleEk0Yi9L?=
 =?utf-8?B?MytTc2tjTDU5ZGJNWEFUK3dqMWkzRFpLQ3EvNnlKTFhCbFRURXdjUmFGZ1li?=
 =?utf-8?B?ekRhcU50VjZrYjFnZGhma1pDeWNHZFgyU0g3NklQUW1BZGxqQytmeDY5c2pD?=
 =?utf-8?B?cjl0djNpMXJqSkNUL0t2TFVxY3NCdWNucnJ3Tm92a0RqRDZlSVRsY21GTWc0?=
 =?utf-8?B?ZWoxb3o3ajJmU0ExRG90UElmQU5sMGU5ZTlWaXgyRmNac1pEK0kwakJyRm83?=
 =?utf-8?B?aEl2UTVjMUk3N2xWR3VKUGJMYW00RFU1Z0pOWSs4UUVsREUxRlIxOGZQYmli?=
 =?utf-8?B?R3dNK3QzMTlCS2RuS0ZXOExpWFBadTVwaVRWcGpFaUEzcGtGNVFlVkFScWhy?=
 =?utf-8?B?L0J4VDhEUjNUblpidHhoaEFJSVhRV3l2OHBieE1icW5keks3VEhxdjloWXB4?=
 =?utf-8?B?VVJmcjYzYWg5dVFKNHhabXFnaDh3ZTVxcWdFUlV2QW43c0pES0VacUNXaXg2?=
 =?utf-8?B?WHAyUUt4UXcvQ0NHMHQzK3IyOEhCN25TMjl2MTk1anZONUdDdk5vallzLzRw?=
 =?utf-8?B?ZldKQVFiVnZpZ21rYUx3RmVheWZla01ra28rd1ZZeDJRR0kzS2ZSNDR5SzE2?=
 =?utf-8?B?UnRLSlgwUFdBNXp1VXBET2x5eHFGdjRWOVRNOXVoYXNldkJKQ3ZBbnltaTlW?=
 =?utf-8?B?OUJlYUZrYnMyQmFLQzJkRm4rdmcrbDVteGpMZDhCSEZaWWw4Y25TejlXQ0Z2?=
 =?utf-8?B?Wi9ITmFtU3dyWEFtcmJCV3Z5aTN1WUJCdnRFdHRaMEVvVzBGWEVuVXBsTE1h?=
 =?utf-8?B?ZnNoQVcyWUVuMEF1eXFnRUs5NkpBT3hvM24wYjJnYVd6UVptLzloZjVEdWRp?=
 =?utf-8?B?TlBsNTFYQW4rcytMQnlYOWMzdWI3M0UvVFFyOGo4SFlDcGllN2hOcllOSDFU?=
 =?utf-8?B?QnVPaHkyUCtyRlN2ZC9ZSFFMTUd3OXhLN0U1NFZOZnBCb1hvQmFUOWxxRHJO?=
 =?utf-8?B?WjVtZVhhRlNhWGdHSkppZW5hMVNWam9Da2E3VFI0YVVpQS9zSkMwQnl6TWFK?=
 =?utf-8?B?R29JMzlBa3hQckhPSkJlcnJHUlY4NXRsOWJ4VzNyY3V4ZkFzUmpWU2F1RnhN?=
 =?utf-8?B?aVNqcG1WeVh5ZllVa1JBZWNKZHVjTEtoanczYnJVa01zWStBNlBvMFdyRDYr?=
 =?utf-8?B?SVBTQTZ4TElvYWZ1SDFoWWFERmIxeVQ3OWI0czJlckwrM2c9PQ==?=
X-Microsoft-Antispam-Message-Info: WicvqMEdrzqrrH/9VR6yLG2nAUujSlmJ/ZByt9WauxWXokcy26C7sjqmEXnUIxJT14q+1hvtr6Y1DmvgW3uqPZdIaELAZVzDXoH7rhGN/Xu35IwZDFgat7I7VD/bAQdfeXbUY93j/AM8tEp/I6LG/9hWx9M0Yd/RRvZ2pCuUvtpFRPnakdPhMrF4H/q+WRMhuJMiu7lED+lN9r9vBXwR39BT0XowuroFdbxqBrLsjbcRHziR+mCXJa9MHR87QXL9RWlnIGY7OtmAgQDxNrnW/UXjBGCXawqRwJQ08xSXEvu55I5iKlaw8C7fLFldPvOUEAyjM64GVTOjqXIi9gOQOTkVmgA7MBdeB7bqgY2+R/M=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3255;6:vOBcaQ592fdbYoFuaYUJCGdi1++Wnh9RrIRkvktHxr94G41h2r6M3YPfXzRJ+DyERnbyykzZuMrlsd1KKljclE2TXAK5CAhYxnOgq5EPWLATW0a07o7PlKBjEVB2CURSJUHmxuLmk8SbYMIGkJFmBfwOQCteQ0c4bq6e2HAnCiRglZ72z1yJEfpuGy1udY6QW4mHIYLNjSmA3MopBuzXczPkgc7UQqMcnO2FbyjQfPDCbik6PVotGiv5KLpv/do6dHJKvd1lFp3Xfy5En7OoZF398Pi1K5mNofiObCN23bQyB2BxKXjBJfBh6jbtMcMJPNwWwio/TYMTzkA2pvizb+shGtvCUVnykcJDlO7EBMrqm1SgtOcuUIyOC3d79gAmTBGLtFfWKYF6tqQxp6/D42M3qKyXV6We2h7ltg/Pxsqwg1WKI9yMLT+B4muOM3p4I+ScN4Rb17dC8MKf2I6WJQ==;5:ITKOgYcBD8bE3v79RefruleAAEXtkoyOfo++dXMDBoCOvX/QW7Q3ldC/MpSgTBmd29IXd93wZaQ8/FCZVtgolijaSgtSxkPeVih1No973aMW4a+ea+1UyVFgiHCE4/NGffdjZxrbie9Zs8QU8vI+zHnP/zBri/q+Ds/FIznh9zs=;24:mmLflpEwWN4kBQNU0d1Eg9sei9HmhVU6F6F8ZdxS9YuRqtEIRIUa3SalIuY96vnbXxAPuVQz0mZajql56TNcPXiVwDApaRKmulGpw9X5ZGg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3255;7:SkJyfDKzWpQ52td2N7wwxCGuw7/i6qQAw7flY/fYAHmKw+fS0wM2IVgEOsLpBwQosmSDx3oGXekOTCV7D+nOhGVonaYbWsKL7jcMoq6n7IEG2Oi4IkzAK5LHaiEuWBpkwgYp5WBX4TDNcE1gIUvvObf3krt5C0uPXrV/UlSXCU/3kDKqunCiH+Tfp619Lw05zLp2POZtmXH6DVqsphwROHDCNMtPLjt3+awhVeY+ZPelOan9mwW9w2HxtPsL1aLf;20:Gb6AFoR6lgwJnxoCVmnmwodJace1kZJTa741/tRZzZ+CD6HGB1yTlxLHlhfmBNeBy5LNKjIWgqIxfCVlWMEeA05TXX18Uhp2o3g5Vu2ewCiyCJl+qPNvddqmMFpBAxFKG9uiyn6kMpbURudJnOAIyBjqndjxkSbWFeEbsnpIsGA=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2018 05:11:55.6849 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06e2031e-0464-46c0-3826-08d5e623a90f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3255
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 08, 2018 at 10:44:00PM +0200, Christoph Hellwig wrote:
> On Wed, Jul 04, 2018 at 04:21:16PM +0200, Adrian Reber wrote:
> > In file included from /usr/include/linux/signal.h:5,
> >                  from /usr/include/linux/aio_abi.h:32,
> >                  from include.c:2:
> > /usr/include/asm/signal.h:16:23: error: conflicting types for ‘sigset_t’
> >  typedef unsigned long sigset_t;
> >                        ^~~~~~~~
> > In file included from /usr/include/signal.h:35,
> >                  from include.c:1:
> > /usr/include/bits/types/sigset_t.h:7:20: note: previous declaration of ‘sigset_t’ was here
> >  typedef __sigset_t sigset_t;
> 
> I guess we could do something like the patch below, although it is
> rather ugly:
> 
> diff --git a/include/uapi/linux/aio_abi.h b/include/uapi/linux/aio_abi.h
> index 75846164290e..b7705ad66d78 100644
> --- a/include/uapi/linux/aio_abi.h
> +++ b/include/uapi/linux/aio_abi.h
> @@ -29,7 +29,11 @@
>  
>  #include <linux/types.h>
>  #include <linux/fs.h>
> +#ifdef __KERNEL__
>  #include <linux/signal.h>
> +#else
> +#include <signal.h>
> +#endif

I think we can not do this because this header specifies the kernel
API, but signal.h is provided by libc and sigset_t can be defined
differently there:

[avagin@laptop ~]$ cat test.c 
#ifdef TEST_LINUX_SIGNAL
#  include <glob.h>
#  include <linux/signal.h>
#else
#  include <signal.h>
#endif
#include <stdio.h>
int main()
{
	printf("sizeof(sigset_t) = %d\n", sizeof(sigset_t));
	return 0;
}
[avagin@laptop ~]$ gcc -DTEST_LINUX_SIGNAL test.c && ./a.out
sizeof(sigset_t) = 8
[avagin@laptop ~]$ gcc test.c && ./a.out
sizeof(sigset_t) = 128

[avagin@laptop include]$ rpm -qf /usr/include/signal.h 
glibc-headers-2.27-8.fc28.i686
glibc-headers-2.27-8.fc28.x86_64
[avagin@laptop include]$ rpm -qf /usr/include/linux/signal.h 
kernel-headers-4.16.5-300.fc28.x86_64

>  #include <asm/byteorder.h>
>  
>  typedef __kernel_ulong_t aio_context_t;
