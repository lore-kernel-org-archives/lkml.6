Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AABF0C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 10:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 406FF21A8D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 10:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="doWHjPeV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 406FF21A8D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730122AbeHIMq4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 08:46:56 -0400
Received: from mail-eopbgr00103.outbound.protection.outlook.com ([40.107.0.103]:54893
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727371AbeHIMqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 08:46:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QKuxR3ayaXGiBcKNW8Q4eaLhVFZGDvkwh6QqVH9vs7w=;
 b=doWHjPeVXZFGXKPV0sm2iOfE+LoBCUdK5dUlh5gkSyYYbpHEFKamcdF2JGrgdc5VUrzt/86A0xdeNbkfJiVkjRnIBZL3Q0iDF89B6DYdoCmlz+VkSbrW9VezsoCGsljD/XGGHyWdwQPeYWaFSdQNVldzQFHY5giFxfry/+jhu1U=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from [172.16.25.169] (185.231.240.5) by
 HE1PR0801MB2027.eurprd08.prod.outlook.com (2603:10a6:3:50::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Thu, 9 Aug 2018 10:22:16 +0000
Subject: Re: [PATCH RFC 01/10] rcu: Make CONFIG_SRCU unconditionally enabled
To:     Dave Chinner <david@fromorbit.com>,
        Michal Hocko <mhocko@kernel.org>
Cc:     akpm@linux-foundation.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, viro@zeniv.linux.org.uk,
        darrick.wong@oracle.com, paulmck@linux.vnet.ibm.com,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        hughd@google.com, shuah@kernel.org, robh@kernel.org,
        ulf.hansson@linaro.org, aspriel@gmail.com,
        vivek.gautam@codeaurora.org, robin.murphy@arm.com, joe@perches.com,
        heikki.krogerus@linux.intel.com, sfr@canb.auug.org.au,
        vdavydov.dev@gmail.com, chris@chris-wilson.co.uk,
        penguin-kernel@I-love.SAKURA.ne.jp, aryabinin@virtuozzo.com,
        willy@infradead.org, ying.huang@intel.com, shakeelb@google.com,
        jbacik@fb.com, mingo@kernel.org, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
References: <153365347929.19074.12509495712735843805.stgit@localhost.localdomain>
 <153365625652.19074.8434946780002619802.stgit@localhost.localdomain>
 <20180808072040.GC27972@dhcp22.suse.cz>
 <d17e65bb-c114-55de-fb4e-e2f538779b92@virtuozzo.com>
 <20180808102734.GH27972@dhcp22.suse.cz> <20180808213125.GM2234@dastard>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <700b63d1-9b77-83be-6dab-cce9438f8ae2@virtuozzo.com>
Date:   Thu, 9 Aug 2018 13:22:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180808213125.GM2234@dastard>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: HE1PR08CA0066.eurprd08.prod.outlook.com
 (2603:10a6:7:2a::37) To HE1PR0801MB2027.eurprd08.prod.outlook.com
 (2603:10a6:3:50::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5af854d4-f7f1-4f56-4572-08d5fde1fc24
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB2027;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2027;3:PrPFYjqJtNOAVQhoXI2alta7Euxz5aj58oWhQp047i++4GIN8WTFXCS7rNNtI0ekJEyIZAubby1FJyblJx7lnpNqLuL7QIcMOfBjGsp/u/7qUlzYeIPUpmzssVN5BuZlvx0ChXS1Xns/bVPavzUmY6gkNJpT6Y3drkfvkkpSAuvD8ieFOZxXi3mz9O4yEHyNijTuskyHYLSsKhJKfW5srPwo8XSLPPdkP0yUnXm2fYmvL3Ni6HXayAX+EkcyF5F2;25:uLpWugzDPKvpGQMGCgB+s6fhHA1MK0hRckPP8ayQ/XmqmPi+4o8ObHf7+9GBvnBYm6KRBqGWqBUV6hiYvwaOJ1pfElHKtQnECvBCFLFi/PyM3km46vmgkjWHJdL8xOxAk+PS3Q442nx3vebjvBNdxtGxaSz5c21PLsYnyaU7mE0U+2B2YFYcUoVS7XTg7sS994TZHSppe+5M/lIz/Y8s9pQ/idt2cS4+v8xMsxtsRkIaaEl0EeoucVqsrlf+1Mt4x6fdpqulwPqSzME+a0CJDI+VZ4zhn0ypfBASILWGIQR5S0FsL2XI7CJEGgnCxDKUjtgJ2t5ceHqvarZddS3aAQ==;31:6q9tTnSaOF93f3b0d/WSPmnfReozKqyyRujsNkb3OvnsrBeyYTLmHJZkqCWx1Qr4MZLbNDJ9h9KX4nwXBkPfgzlCLoG1hgwGvG8IaaXEEQ9lw95IKJLUiX/ncq/LvFzCfveMwhtQUX77Tq88pVtDbOh7vJRNt58pnX6hcomgKe3nRYfN9Y39KaUEcq9XRZfcrBkNI3UdwXqdKGTcKppTwpFi0DQeG2wFZu3vw5fS9k8=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB2027:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2027;20:E3Ycq/v8MfItML+4bvBqjVWo7EC/A3dgdGTNXVdG0JYK+F7rMvDtawzyUOtn53rwGGSpBO1CNPktPx91LWmSHPPKkNA26VU3av1oGUk1tzVXeC421lWcLVn1tgkNqG80EeMjerJmDmNhEjsUSP5Kr17efRXZOuE+b0ljhxrQDCoO8TraPRctIfo14fJ/kVx2ysjEb5rwxDfJt8FNP6Oo6UP6UOr64n80CFl+dFOHhO5q/Nmve9ENT4LxYY81HLejpvpoHASFfdINN88i9StQUYBvE8j189lMQlfJvZI92iwRNtZzB/WUUd3cd1FLxFI0wpse4khx5+jg1PUc3B+Ji/uOhAxntovRrq7h2DJY2ausNnzY+1uWxLg2UGzvTJV+IsQY/Q1fo2Be/yD2xRI8erOKo5dkgpzVwrws6fkfrl9ToPodBECL6AthKhxDJKvWRct6pHcqiTGiKmyI1VBtWV0IYZaOnQfQn0x3PLSvYLmxQ6UBd7ijWb7az7qVOyCs;4:GuJnk8cgWN4eunge1gZHT8Dw5GDdLxdxz3MgsLRJ2WCM1L640/tmYFwtMEqcbtk13Cap9oO6zMLs3BciXzQJuDlwiooOyEyRi8jvq7Vi6HZC22LV+lbIbQ2/iWpaVBo5mq8IvxBp/RvPynDX2/qsfeuERFRa4PjQle7c6aK2e/uBdCVTgSu7YroPzX6JbNfglUJxhwijOlwMrzx3OKMKcCmER73rQhyr66Sh9XCZak2DT6s+XEqc8Sosq4xXm2TIb8ExpGAcvbxxtHu9evMndVF47lhtztjPIe+2aQvXY1gBqk6gJBIrXTvImunowW5NIHPDxv1vOrx5iXQpRTvgUNQazyS2S+GT2vja2l2wMGUJ0B72tDe5CJpcac90Yp2t
X-Microsoft-Antispam-PRVS: <HE1PR0801MB20275756FC414AFDEEE0C84FCD250@HE1PR0801MB2027.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(230824228335337)(158342451672863)(42068640409301);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:HE1PR0801MB2027;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB2027;
X-Forefront-PRVS: 0759F7A50A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(376002)(346002)(366004)(396003)(39850400004)(136003)(199004)(189003)(54534003)(105586002)(110136005)(486006)(217873002)(386003)(229853002)(316002)(16576012)(31686004)(478600001)(81156014)(58126008)(7736002)(5660300001)(106356001)(8676002)(230700001)(65826007)(77096007)(65956001)(68736007)(26005)(3846002)(6116002)(53546011)(305945005)(8936002)(66066001)(14444005)(81166006)(6666003)(2486003)(97736004)(47776003)(4326008)(76176011)(25786009)(23676004)(64126003)(52146003)(446003)(11346002)(16526019)(186003)(7416002)(7406005)(956004)(39060400002)(93886005)(53936002)(2616005)(6486002)(6246003)(2906002)(50466002)(6306002)(86362001)(36756003)(476003)(52116002)(966005)(65806001)(31696002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB2027;H:[172.16.25.169];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjIwMjc7MjM6ZXpLbnVnMnNoTURHZm1nTGttUHY0b2pI?=
 =?utf-8?B?S3JqMUsvODRlL2x0c2g2L2tGMFNUTVl4NWdad1FGMUhraThxY3hxbm4xTnpC?=
 =?utf-8?B?NHdibWhEaE1STkJrbXF3SlIwK1YxOVpKc0ZZTkFpWmJsSGIwRmQ0UzlHTkMw?=
 =?utf-8?B?NVJXc0hJTnFxdjNJVjhyV0hXSVVSK05sWkkwK1o4YXVCZ1lBaCttejJFT3ov?=
 =?utf-8?B?MDIyTFhKM2NFVXhpVjA0ZU5rSFc3dllGdkRjWE83VWZtRkFmZVYrcWpNMmRy?=
 =?utf-8?B?cU5OcHdaTTJWQ0wrNjJ6NnJqb3B0UVZLMkFIUnB4M2NzeUloT3RyWlN6WXNU?=
 =?utf-8?B?ZG9Edm9WVkQ1OFBFQ2NKUWlmOHFLOUI1d2xidk1FcVFPOWF4cnp1djR6MWh1?=
 =?utf-8?B?aHFVK3B2eWFyNU94ME9QaWN5eHRvY0VpYWVWZHZrZDArbzJMUVdRajA0UExV?=
 =?utf-8?B?dVFaNitBcS9iTUtWTXhkYVdPVHdFUnlGODRnd1lSeXBITnRBekRqaFRDaUFw?=
 =?utf-8?B?VFBZN3Z6Zlk3MUN4cC9iOWt1a29jdXZSNTdmSkxteXVnZ3dLRDBLMktRd25a?=
 =?utf-8?B?VWZIVDZ2ak5xUzhhWU11R2R1RGhYZjFNVXQrSkhjODVZRWZuWmMvVWJya001?=
 =?utf-8?B?NkQwMUhQRzBhdUpwdUI0WFo1cDgvMnhVbHMrQUVUVURCR0JjR3VlNDNlbFEv?=
 =?utf-8?B?bUxmbkpJUVpRWHY5b09BWk1CcUFNbjUyRDdDUUZjaFkrMGRkeFlCV2x5RGZF?=
 =?utf-8?B?OTNpMGZzSmhkQ0k1QmJ2RlVxbzFVQ08xMWRBV2NkTnZoYmsyNDVsUlNDRjNw?=
 =?utf-8?B?b0lSb0QvNTZ4cDMyeGlkeDJOU05vcTJubEY2Z0k0TUlrb3dUdDhTVnN3clhm?=
 =?utf-8?B?U25zQm95aWsyMHpkeTRvMFdGZTROWXUxdHBxeUQ2S2ZFUmMzdG96WVFIcm5Y?=
 =?utf-8?B?elF1SjNlRFZQQjFzSkdoN0RFVnVqWVlVcG5salVROGJtbGkvcmdQeDhsYWlI?=
 =?utf-8?B?NDlyTFRXdHdOODNuY3E3RHhRYTlHRlVXa1drOUY2MU5RRVVCRmh1Y1E5U3k5?=
 =?utf-8?B?M0pjaXJOVEorNlVtd0hkdGRrbkI2eWJaZ1R1MGxKaDEzVVk4dnF4VlNEeTBT?=
 =?utf-8?B?alJBd1RNMTJQc1JNclFsdElmTVlnaGVpWW5iT0g3QzZISFo5cDMxZzEybDZw?=
 =?utf-8?B?cE1FTzJWRlB3dXUzMFBQMUVROS81TlJ3bnYyejNTcFlFSVg4N0RxMmxjSUdN?=
 =?utf-8?B?ZnZhYU1Gck4wUENqU3gxV2VPV2FoU1V4cGhDSU5tMWV2alNiMFFrL1FUNGl1?=
 =?utf-8?B?TnVzd3pycm1ZbU9tOU01UU02cC9ubWlsWm15QkRRdWJLRW1FZHNsWDAwVUd2?=
 =?utf-8?B?RFc5dEtVRENxcVpSMDZlQ1FjdGoxbmRXS1dDVnFtOWNuWnFFaUgydWZCczdG?=
 =?utf-8?B?S2pWWm9SQXJ1TDVacjl2MkpGdnVwa2kzckljZ0V2QzFQYWtDUHlVNnJYNyt4?=
 =?utf-8?B?dU02ak9FbTUyU1dYU3NFSkZSeUhmUWhHR2pobGUwaVo2alVjeFFIR1pkd2V3?=
 =?utf-8?B?bnBZVjNnUXVOYUY4eXFLTU9zOExSalM1SU0yQ3FTb2V3N1pxbm1uOVdzdUM0?=
 =?utf-8?B?cnN3UE9TOWtia1ZjZW9xaU5GQ1JXWmRRTXdiR2hJWVFmOTJPNzdlWFlBN0Ri?=
 =?utf-8?B?QjY4ak5mV1hOYjJueFhJWnpmVG9WUFNMVUtjSmxndElxUkxkRlRHc3dFZGEy?=
 =?utf-8?B?RmJuSEU1M2JGc1orVXBiRWs2SnJremhLeDVvWFVSQUIycmttakpaaE10dmNM?=
 =?utf-8?B?Mm9GeTRmcnFld1VkZ1p1eFM3d1NmaFVIK2cvcjNhYW5CbnJuZWJKWkVCOVQ3?=
 =?utf-8?B?NGxNRkpGSkp2S3p5VERRSVNxZmxUSi9RVHdIcVBaR2dQY2FaWWY5RHhaS213?=
 =?utf-8?B?ajNWU0Uvc1ZnRFNLVGpjSGVHNGxROUFrSk5HZHJXVE9KaEh3SndZVTVGUUJ5?=
 =?utf-8?B?Z296SGJlMUhSd0JtWGxYTzFXQ3kwdjVidG02YjJaMURVQUhZSEdvMUdJSzlB?=
 =?utf-8?B?OW14R2crZ1Q2WWxqRFlrQ2NMR0MyMml0YWdhSUZkaDhxZGR3aGF2L04xbi9F?=
 =?utf-8?Q?qA0/v/xA/Vh8zG5t6SD3XjHPbAOwvzemQbmu7JQlAwFA2N?=
X-Microsoft-Antispam-Message-Info: lR7xbBtqgKkhgP9EgX0/0w/4mAVfUTbBb3Ol/epCTXIy++U5ZZZSOsaHR3WyAq+cqo9gJ+WkrAo3hJbpF2ORL2Uj91+r7uPXCktRti+z4ZK/mItBYDwgfS0JtuNZJVtRYVTjzN0Wr6wwilZt7SNoNynx6VcpORiBRebz/zQZHLLZ6hqsmaJBokkKWpBtWrSFCu9tPjWDXOD5NkdtZnNtSWF67V0iSqLjx56yXTTVYqPd8iqZYibZxktZnO2iCm9C9F2zmG/ZhhksdslebX1uLEpY8LmPsntefy+nbLcvNFxeRwFZBWn7SyeHtG1ttZ1SVMoQj2XnID+m0kkzlJnMMbyb+G5RtWY6s5Gi5aAJeGo=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2027;6:nC8z27ra7sOIKeoV3VYWUnZVQiE9/seMD3EJl8U+jrbifduVZpro3ui1yJoYQWqR7SEQ7ADGO49FhKnAz89DGMuRo7l30qKa9rBPQBzEsb9ORh7mIk3/N53TbmIYJNI6Qd3QAlUNwQi4d1u8oI3hzuovyW4bDGLoy8vbCoZt8PaN3p0XWYbkBMZsTqzy0+q49SZ5Xc7WYlB0Io6+tcAXgP43UDVL8lotD8iILMsn5GN5sF/VM7Cp7hcl17DxXGAKRclKmFKmDjw5q3OK4YjraxhdHccronDVeEp/6oolklXlQ/fFcKoQir7LgjF+0C53ZWWX2BMgp3D26uLLMMJTy4Za89btVySZElkccNBrNtHfwugwwY2cuxBgxv5jmT5F+Dt+zAkdVqb9vwrXtmeIfY7gBDr/Se367HiZgLylWMZ+vyXfkpm37OO6RSEnmWkcebLHDkGKKyMWmgZzUgktsQ==;5:swxpSxP3d/IuzUqBVCzmEKKusXeXWxXmJ6dqe+cpGbKgmnrtcZK9QaARO08U3k95QvWLwnw0JFZ1bHBCl+9YJQVsIfvTXQPqyFayO3Csqlp2cToHaksw8HWlfVIdNr/HOZ6g11T7k6h8erXOZX6sm/kk1wkHOufQm7Fp1PtKHuA=;7:Qmb2y5z0c9JmmiaaCaygiIlBeu5Id9YRVbuT/wBndfbCDp3+ceeCSUZs9FzFf+nsE12DSx2H3g8qmeQVbUuuh55x4DT/mueyRFIvYg0RTQtPvYeGVkn85cpCi4JV0MHmCM9pInxEx+z0qh6pm3n8kdZSgR91tq6x1ahFDoLz3X5Icl2JtdP/QW4ucJbo2lCf4BveLbv5yWWBe8GTulfMY4L7YFfTFyMAo/pdTNv+43NP5g969YZTJMI9WtymTvDi
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2027;20:q5gRMeVJaaY4lm5vgilMfT5Z08+dHp+j1F+AFAvVhXNNb7RAuOwjtOqL84KutJc0zAIN1WRl0dSjSAcsDjtrWuDGMwTQYuLb2RHSd5k3drt3SruxdEP22hpma+sB/ZwHU48kjUo/jC9TN9xXPky2xwtjHZ3O/+tRjICyP0j69ZA=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2018 10:22:16.3541 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5af854d4-f7f1-4f56-4572-08d5fde1fc24
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB2027
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.08.2018 00:31, Dave Chinner wrote:
> On Wed, Aug 08, 2018 at 12:27:34PM +0200, Michal Hocko wrote:
>> [CC Josh - the whole series is
>> http://lkml.kernel.org/r/153365347929.19074.12509495712735843805.stgit@localhost.localdomain]
>>
>> On Wed 08-08-18 13:17:44, Kirill Tkhai wrote:
>>> On 08.08.2018 10:20, Michal Hocko wrote:
>>>> On Tue 07-08-18 18:37:36, Kirill Tkhai wrote:
>>>>> This patch kills all CONFIG_SRCU defines and
>>>>> the code under !CONFIG_SRCU.
>>>>
>>>> The last time somebody tried to do this there was a pushback due to
>>>> kernel tinyfication. So this should really give some numbers about the
>>>> code size increase. Also why can't we make this depend on MMU. Is
>>>> anybody else than the reclaim asking for unconditional SRCU usage?
>>>
>>> I don't know one. The size numbers (sparc64) are:
>>>
>>> $ size image.srcu.disabled 
>>>    text	   data	    bss	    dec	    hex	filename
>>> 5117546	8030506	1968104	15116156	 e6a77c	image.srcu.disabled
>>> $ size image.srcu.enabled
>>>    text	   data	    bss	    dec	    hex	filename
>>> 5126175	8064346	1968104	15158625	 e74d61	image.srcu.enabled
>>> The difference is: 15158625-15116156 = 42469 ~41Kb
>>>
>>> Please, see the measurement details to my answer to Stephen.
>>>
>>>> Btw. I totaly agree with Steven. This is a very poor changelog. It is
>>>> trivial to see what the patch does but it is far from clear why it is
>>>> doing that and why we cannot go other ways.
>>> We possibly can go another way, and there is comment to [2/10] about this.
>>> Percpu rwsem may be used instead, the only thing, it is worse, is it will
>>> make shrink_slab() wait unregistering shrinkers, while srcu-based
>>> implementation does not require this.
>>
>> Well, if unregisterring doesn't do anything subtle - e.g. an allocation
>> or take locks which depend on allocation - and we can guarantee that
>> then blocking shrink_slab shouldn't be a big deal.
> 
> unregister_shrinker() already blocks shrink_slab - taking a rwsem in
> write mode blocks all readers - so using a per-cpu rwsem doesn't
> introduce anything new or unexpected. I'd like to see numbers of the
> different methods before anything else.

The difference is percpu_rw_semaphore makes readers to wait till RCU
grace period is finished. Sometimes this takes unpredictable time on
big machines with many CPUs, which is not good.
 
> IMO, the big deal is that the split unregister mechanism seems to
> imply superblock shrinkers can be called during sb teardown or
> /after/ the filesystem has been torn down in memory (i.e. after
> ->put_super() is called). That's a change of behaviour, but it's
> left to the filesystem to detect and handle that condition. That's
> exceedingly subtle and looks like a recipe for disaster to me. I
> note that XFS hasn't been updated to detect and avoid this landmine.
> 
> And, FWIW, filesystems with multiple shrinkers (e.g. XFS as 3 per
> mount) will take the SCRU penalty multiple times during unmount, and
> potentially be exposed to multiple different "use during/after
> teardown" race conditions.
> 
>> It is subtle though.
>> Maybe subtle enough to make unconditional SRCU worth it. This all should
>> be in the changelog though.
> 
> IMO, we've had enough recent bugs to deal with from shrinkers being
> called before the filesystem is set up and from trying to handle
> allocation errors during setup. Do we really want to make shrinker
> shutdown just as prone to mismanagement and subtle, hard to hit
> bugs? I don't think we do - unmount is simply not a critical
> performance path.

There are possible different situations, people use linux like they want.
Imagine, you want to reboot NFS server, but you want to enter clients
and umount them over ssh, and the time is critical. Something like this.
I believe there are many examples, people need this.
