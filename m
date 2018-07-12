Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DABC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 04:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F18CB20C0C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 04:41:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="kxgTZc5q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F18CB20C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbeGLEtP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 00:49:15 -0400
Received: from mail-ve1eur01on0130.outbound.protection.outlook.com ([104.47.1.130]:11816
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725766AbeGLEtO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 00:49:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=auKt7kXkBwHBS9JRBvEVXqP/6mdkhm3pvxbT8CJ5Xv0=;
 b=kxgTZc5q+Gk3+TQUeT7GonoWJWSGHwHDEqjvxxuRncFDF6JUdJ5+VfU5MEZE0c4LPBmjT8V1Xqpw4mqbNG31//xCwiVB3BrqZR1B0pWMTrL+PAx/8O6nLkzQzMTJlISEwBSkR4jCFe0CTYYtj8QmArV/3bUNEj1ebT3dZWEbIa4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from [192.168.13.3] (85.226.244.23) by
 DB6PR0201MB2453.eurprd02.prod.outlook.com (2603:10a6:4:34::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.17; Thu, 12 Jul 2018 04:41:19 +0000
Subject: Re: [PATCH v4 01/10] i3c: Add core I3C infrastructure
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Przemyslaw Sroka <psroka@cadence.com>,
        Arkadiusz Golec <agolec@cadence.com>,
        Alan Douglas <adouglas@cadence.com>,
        Bartosz Folta <bfolta@cadence.com>,
        Damian Kos <dkos@cadence.com>,
        Alicja Jurasik-Urbaniak <alicja@cadence.com>,
        Cyprian Wronka <cwronka@cadence.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vitor Soares <Vitor.Soares@synopsys.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>, linux-gpio@vger.kernel.org
References: <20180330074751.25987-1-boris.brezillon@bootlin.com>
 <20180330074751.25987-2-boris.brezillon@bootlin.com>
 <CAK8P3a1aZXf2sQW2mgwJScycKPhdoOAwxRjm5cQG83513uc3fg@mail.gmail.com>
 <20180711164120.3e32fb08@bbrezillon>
 <CAK8P3a2EZB_tMS_47wv6M2Qpm79ZocxxhG5zLxXsBM_YjZgkyA@mail.gmail.com>
 <20180711191212.3855bb25@bbrezillon>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <a31dc625-56bf-7a59-d9a3-2841360b864e@axentia.se>
Date:   Thu, 12 Jul 2018 06:41:15 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180711191212.3855bb25@bbrezillon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR06CA0135.eurprd06.prod.outlook.com
 (2603:10a6:7:16::22) To DB6PR0201MB2453.eurprd02.prod.outlook.com
 (2603:10a6:4:34::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2fc5a03b-1e08-49ce-e0ff-08d5e7b1b83b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(5600053)(711020)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:DB6PR0201MB2453;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0201MB2453;3:Ae8Pf/3+Xk2HIiocwfpQGLi1fegp8oz1k77RqopslgKlpbK/gsy6vYd0dh/lhxv7lBvPIRuJonhE8mcNVkZ+uvG8xOQVJaGkcoaZeqrhs6Xuz7KPwGn6kfC3ZF9+9aqG/2apWolZD6QUoI5xM5qaISBkfhUTSNlszjJFz47qhkKGdiiLlCscwFyhi30in5bDY95TyxzfumOP97lkXSQw0C8awBTR9q71byLwFzNEUHVuaTi/8it15jN+yopWwRuB;25:pba0npZvamHd3OX0aaG2herg9Tw5K7SN0AiXDt12sdelYk1izQFXRw0kArpwulewyiVsjiDRL67A1o7O3iW0dkEi69hvF69sm+Ya+a7uav7f9ES7Erv0dWOXe+13/2rXJ7lq1z4IIof8BAM2U8oSvwjjkvUG0/S8uP9N60RXpR00stA7u8y/4C5970L2lV5hIckYT8YgyhYoVWBOZ0wyM3O3IoRDJJjZahYmfQlC7whAX1FNORl2bBjUgaAtxgBdckv6zx1PMbz23eBjiffQaODvx2eyuDNV+vCtekfII8Laqq8Jf1x3g77V78dihtbCeo9XIENVnQFkXWzpBZn/nQ==;31:U6jfqV9Z1nhQ3nIziahoVYuW6tXzSKniD0iSJNqZksZJV0CatM7LxYpCwFqEXHm3srIpPyv4XTIULUkGkx8PeW8luEib0JUkTpBUueflihR8wqSCSCcz8wJHba+jJO9EI4RCK0SlgBFwg0lqLGYd4SnkTV29e1V8T/k2aebdn+emI1k+gP0CiBupg4vPEtM3Ht4ZWoZ8HliuMMVEN4FGcZ2GEC4G5mJrxDNYnLjCN3w=
X-MS-TrafficTypeDiagnostic: DB6PR0201MB2453:
X-Microsoft-Antispam-PRVS: <DB6PR0201MB245311D0BB82A9F8ACC37BD8BC590@DB6PR0201MB2453.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(2016111802025)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(6043046)(201708071742011)(7699016);SRVR:DB6PR0201MB2453;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0201MB2453;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0201MB2453;4:ob3zYck9BMAlQs6kQr4AyP4w4QX/TXZoucKL4QtNAejRqwV+CwwOdT2dmGfxpMHhqzIeacoWuvNYNi8hanc7BKxPTmWMzrrrzXkUmIthMHVUrdG3jmXArU/P6SQEyAGXj1iw1CAPwZMI8fUNA+rLz7s/AIrh9NHEPcfl64174Wtoi7wmDqJYSGwdwUFQDooynTtUr98qTEY2RrdTze3bjET5tymz6AbOB6lSa8aEF4YucEf8tSF3q5eH6leJB6wNPjZFfKqIFwLuGudRApicHA==
X-Forefront-PRVS: 0731AA2DE6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39830400003)(396003)(376002)(346002)(366004)(136003)(199004)(189003)(36916002)(74482002)(2486003)(23676004)(52146003)(6666003)(52116002)(2906002)(316002)(31686004)(76176011)(5660300001)(36756003)(65826007)(230700001)(8676002)(8936002)(478600001)(81156014)(81166006)(77096007)(58126008)(86362001)(110136005)(16576012)(7406005)(16526019)(97736004)(386003)(7416002)(54906003)(31696002)(7736002)(53546011)(3846002)(305945005)(186003)(105586002)(53936002)(64126003)(4326008)(6246003)(229853002)(68736007)(26005)(106356001)(6486002)(14444005)(476003)(2616005)(956004)(47776003)(5024004)(486006)(50466002)(117156002)(11346002)(65806001)(6116002)(65956001)(66066001)(25786009)(446003)(3260700006)(93886005)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0201MB2453;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjAyMDFNQjI0NTM7MjM6QlNFZGpoelBEUVNabjNXQjNncDFadEtk?=
 =?utf-8?B?Skt2S3pBVUluTHFqQjFKeVQwYVN5UDZhNWZOa0pIK0dNaVgrRkVhRE1sU091?=
 =?utf-8?B?WmozejNudW9xR3BNTVJ1dnJaWURnbGRtRVl6WXdIMEN5b1BkM3JQdWltTzZq?=
 =?utf-8?B?d0E5b3J4bndsNVJFR2t6Z0hKWGYzZjhSSW16NXRnQnI3dnZtTUNJVy9Kdkhp?=
 =?utf-8?B?KzFMK21vRlVYS2V6U2xXWnFJTzQ2bkt4Wk1yS1Jwdk1CMUdsVlB4cEZNLzZC?=
 =?utf-8?B?QTlkVTdJZWhHMExLZTJvN1R6Z2M3UUNJM1h2ZW9aL0MvOWkwOWZ5QjlVSnNN?=
 =?utf-8?B?T2p0YS90dlAxeXhaT1dmUWlqTmU3d2loOUxFbmF2dCtqTmEwOWJiUDRNRGxj?=
 =?utf-8?B?QVFVdmo5TmhRS3hTNVBxSklHSUhsL0RxVWtmbnViWE9PS1dKeFo4am5oOHh3?=
 =?utf-8?B?WDF5dzREaWUwM2RHM040dXc1QitUdlVQWXhUbzhKWll4bnhIcGJhQzRoR2Vj?=
 =?utf-8?B?WU5rbGhZdTBXbTZweXVPSFo3ckxlenBMNWlTdlpOTk91YUxrYnQ1V2NKRTVM?=
 =?utf-8?B?ODhhaXhtejZ5aG9ET1MrQWMwU216bytwL05xSGlCYmY5TzB6eDBMWU85a25s?=
 =?utf-8?B?L1o4REREaFZYbTcyd2pKUTJIQVVOdklvRnloY3hQakYvenNLdUtOTlhHYlY3?=
 =?utf-8?B?QU1KRENMZVBzejJsQ2xiMkRRM2J6TWgwR2dhK3loNmtEU0l2MU9kUGUyYlhE?=
 =?utf-8?B?MDdhNXU0UEZ1SUlPRVR5RVN5R1RzamwzSlBhU08zbzljeEtWZWFJaEVkY1l1?=
 =?utf-8?B?U2NOOGNvd2NlTnppTjBVOHFnTmFkVHRHbytzVW9tblBwMXB3Ulo0ZGxsTDJR?=
 =?utf-8?B?L0tYN3FrakQrbyt6Q205djRRRzRVaUJPTnlIcE1pZ1dWZUQ5TXJ5S3RoMDZO?=
 =?utf-8?B?NHhIV0wvYzVtcmZIaG9uQVJyNE4wRlg4MENqa2Nsd3hUVVZBMXJGUHczZ2tJ?=
 =?utf-8?B?QkY4QldZOVdwZjJ5Q3ZETlgxcVlMcU5teVE2a3cveUhOM2t0d2FNK096aGp2?=
 =?utf-8?B?MXpFa1JsQkVsemdVZFI2TndPVWdyaFNaZ0VDWWxsdENTaUlGR1VJb1RTKzJi?=
 =?utf-8?B?MjBaOUtIcTUybTRrWEE5UHlBMUtzN1Q5Z1VPQy9rbVFnam5Xb0hlWHRtL0ky?=
 =?utf-8?B?VGs0YTE3YkVzb1h5aEk2OTNuSnBCdnF4SHVuUHBoLzBZaVNMOStEUWxrcEV3?=
 =?utf-8?B?anVGMXdTYVpQNThlUmZaZHlVbERxT29JdENuOHNXTnpNbWEvc3ZUcWkwL1Jp?=
 =?utf-8?B?MDZHcVlSUGYxeVFxbUFSSk50UXdlbXgxbDJFQnlXdVkwY2xzRCsrZnFCdTZ5?=
 =?utf-8?B?UXV5RVU1ZFlGU1FqWW1VbkRQMzRHc3ZHVmV0eDlEVkRZbGNYd2crSlpURUJm?=
 =?utf-8?B?TFNXR2lrT245ejhTd3J0SWUwd0Y4ZTRmenhSWG1MVGY1UXBZdlRhbU93UlR1?=
 =?utf-8?B?bWVSV0Vkbnh6OTdzV0NxSjdlR1lscEZWS3JIcjNLT1pidG1yVTFpNjBzcHJh?=
 =?utf-8?B?Z3JCc3p2eXJoRFc0TGNHSElySWczUjRseTBoZGxvWWRWS2QzMG4zQm5vMkhD?=
 =?utf-8?B?QlJYUk5JK0gzdzVKMlVKSlFsK3R4T2t3YitrTENSNEFpZkpoY1BCekxCVjFL?=
 =?utf-8?B?SXlQNWtyUmxVaFQ5eUNPRWxVcml5c1lxQ1NhT3QvbTlmN1VRZU9XRDdLRC9F?=
 =?utf-8?B?RUthTUk0OXBZTFpqWFFib2dvVFBvcTE0RGFDa3BndDdJOUc4UjRHdHBKN3Rw?=
 =?utf-8?B?K0tzSFdLOFBSZ2QrV0pPcUtlUFJ0MHFTRjBQR0VUZFpzZXQ1bUttZTExei9z?=
 =?utf-8?B?b0dsdmt6UmliS0xzS0JTZDJpSE5YMjA1NDJsaDh3RVl6ZFV2UmQ5UnAzMzBZ?=
 =?utf-8?B?bFhvRU9XRlhCVGZtMlQwcjdxWVlFamxlM2Z2SzR6bmJNbWtQSERkaUxIYlFU?=
 =?utf-8?B?bG1pSkk0U1QwbHFDU1BHSXhmbTBVMG5rRm11VmVGeHlBc3lMQ1hNaWRCVGg3?=
 =?utf-8?B?VFNjcjJXTGYzWDF0eHcvMXNSeUYxNWdENEQ0VkNXWk5Sdlh4UVRrZDFXakRE?=
 =?utf-8?B?Mkppc0pMOS9sTFFJSWFFOGRoOXpqSWdTN2F5aHFnSGxXUVBEcTVSck93OWNp?=
 =?utf-8?Q?QSyMsS9x9FndBF10GD50MJBB1x58q7JqGHNOCuD3hI+I=3D?=
X-Microsoft-Antispam-Message-Info: 1Ipa9EsMbuHxgF7iS86Ik13NCaL7cOMA0+BVahFstqm/oh506Q/csMrNC0OtARBGVTlVUjgPZlroLv6YHcKuvptCmeyVMiqfe7yonXDomOrTOvIn6s6H4CTXVFPotyfLpqjQc9Npo7fS0HNHuLteF5e5tFbQ4bFMKytAygucD1Dtx78AmcESm/Ef4nd1vUUHkdFn4CvBRwHuAoNlfV1vcOjeqgYMjOt597PLj282JAgYu7v4gZbXCr8d8cJSZ57cxFbazZcBwqpICRLR9EKtn6x5vcPZEeU3HLV7IvmS3LnabXCarPjv8z/KIJ66FiZoyhYFZ6c+X0IWi61TJKXgPtYOGDmWDUwrYrF2lzeSigI=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0201MB2453;6:4KA9wV71qVqFNdp2wN/fCvniedOJlO0K2e3trWcNSukzXlrh9uCn4DomRRgp503LJfeo/0QEkLv7L3RfT4jJjt9Jnkm+HxpMP5NR0UYunMrDgsa6R4V878RAVOuNYG/kKrr7JQ3rO5sZX5+hlk9k3kPNAkKa0xNPQucDDy00yoQpe0VgZ1whTT2lthS4hYqzn9e0A873bAJyVOvDitMDLQUnvl2nDu6PN2vvbw9SI8yDxKzJ3f+GmOqpGuyjyx5AHKWDNPgcavY1FPb9C+16fIQyNQ9maKxKBXFSc09fmHpTQL+JSx2CZZI0fGEUT58t0STnS728gTS6uxRAvIWPO05EENUd3NWMWe1zrxAIYG3+GJcF69Jzkg6/wROJqpAoDfcf2C2tbPInvs1lhuME6skjhEHAJbUXXaaG5o06seC+ZdfAc7jRj+q/DySLMJaiEz+JeDAOYvkTzMIVHktL6Q==;5:bBL7E0MqAjnFMnAyLST6JCtE+kOFk2uRfqGMQH3hQGuA70ydsVVdWwXLtUAb9kxzAZceYLTXrBeabhRkTkPOL7RzCm8chokEFGYOF7jmerDMQuhSNYTszV9WhDor77LezSX8sb4l3ZuoTuzbKVoudoq7C4P6p6Qpn14JEh+Wa1M=;24:44PSC2IOnn24t2YPeVeR5yYP/gAwb8ot03q7kawLpigL8t2iXN237bNyqXmTAOI2+0Rpd91bqarHcpGMbPbXf8EbZCmNk6kXoq/k8cfIR6w=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0201MB2453;7:9royIvIys/SDm2TH0PANDwubwPwfIG3EfzbxiyGGtHjN2g/1qlnj+qJ8cpRLojjJivI7A8qF/q3bIYPzjDn8e/fKL6FJcTpxxUgrQ5LQYQ1Rk9sBoC9K0bhCEAmjLn6KtMi22+Dfl2NATqX+jmYcySVw2FOzgMMnw0kU3wVovR+CFD4sEjWeXqyTz/rPobaEGoKnC4BQWVt0/OzcbyLK/1bib0nMiXXVXr8Kqc1d81LKnJXjpTK/tAZTVgFECE/3
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2018 04:41:19.4013 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fc5a03b-1e08-49ce-e0ff-08d5e7b1b83b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0201MB2453
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[tried to send something like this yesterday, but it appears to have been
lost, sorry for any duplicate]

On 2018-07-11 19:12, Boris Brezillon wrote:
> On Wed, 11 Jul 2018 17:39:56 +0200
> Arnd Bergmann <arnd@arndb.de> wrote:
> 
>> On Wed, Jul 11, 2018 at 4:41 PM, Boris Brezillon
>> <boris.brezillon@bootlin.com> wrote:
>>> On Wed, 11 Jul 2018 16:01:56 +0200 Arnd Bergmann <arnd@arndb.de> wrote:  
>>>>> - the bus element is a separate object and is not implicitly described
>>>>>   by the master (as done in I2C). The reason is that I want to be able
>>>>>   to handle multiple master connected to the same bus and visible to
>>>>>   Linux.
>>>>>   In this situation, we should only have one instance of the device and
>>>>>   not one per master, and sharing the bus object would be part of the
>>>>>   solution to gracefully handle this case.
>>>>>   I'm not sure we will ever need to deal with multiple masters
>>>>>   controlling the same bus and exposed under Linux, but separating the
>>>>>   bus and master concept is pretty easy, hence the decision to do it
>>>>>   like that.
>>>>>   The other benefit of separating the bus and master concepts is that
>>>>>   master devices appear under the bus directory in sysfs.  
>>>>
>>>> I'm not following here at all, sorry for missing prior discussion if this
>>>> was already explained. What is the "multiple master" case? Do you
>>>> mean multiple devices that are controlled by Linux and that each talk
>>>> to other devices on the same bus, multiple operating systems that
>>>> have talk to are able to own the bus with the kernel being one of
>>>> them, a controller that controls multiple independent buses,
>>>> or something else?  
>>>
>>> I mean several masters connected to the same bus and all exposed to the
>>> same Linux instance. In this case, the question is, should we have X
>>> I3C buses exposed (X being the number of masters) or should we only
>>> have one?
>>>
>>> Having a bus represented as a separate object allows us to switch to
>>> the "one bus : X masters" representation if we need too.  
>> ...
>>>>
>>>> This feels a bit odd: so you have bus_type that can contain devices
>>>> of three (?) different device types: i3c_device_type, i3c_master_type
>>>> and i3c_busdev_type.
>>>>
>>>> Generally speaking, we don't have a lot of subsystems that even
>>>> use device_types. I assume that the i3c_device_type for a
>>>> device that corresponds to an endpoint on the bus, but I'm
>>>> still confused about the other two, and why they are part of
>>>> the same bus_type.  
>>>
>>> i3c_busdev is just a virtual device representing the bus itself.
>>> i3c_master is representing the I3C master driving the bus. The reason
>>> for having a different type here is to avoid attaching this device to a
>>> driver but still being able to see the master controller as a device on
>>> the bus. And finally, i3c_device are all remote devices that can be
>>> accessed through a given i3c_master.
>>>
>>> This all comes from the design choice I made to represent the bus as a
>>> separate object in order to be able to share it between different
>>> master controllers exposed through the same Linux instance. Since
>>> master controllers are also remote devices for other controllers, we
>>> need to represent them.  
>>
>> Ok, so I think this is the most important question to resolve: do we
>> actually need to control multiple masters on a single bus from one OS
>> or not?
>>
>> The problem that I see is that it breaks the tree abstraction that
>> we use in the dtb interface, in the driver model and in sysfs.
>> If we need to deal with a hardware bus structure like
>>
>>               cpu
>>              /   \
>>             /     \
>>        platdev   platdev
>>            |        |
>>      i3c-master   i3c-master
>>             \      /
>>              \    /
>>             i3c-bus
>>              /    \
>>          device   device
>>
>> then that abstraction no longer holds. Clearly you could build
>> a system like that, and if we have to support it, the i3c infrastructure
>> should be prepared for it, since we wouldn't be able to retrofit
>> it later.
> 
> Exactly. For the DT representation I thought we could have the primary
> master hold the device nodes, and then have secondary masters reference
> the main master with a phandle (i3c-bus = <&main_i3c_master>;). For the
> sysfs representation, it would be the same. Only one of the master
> would create the i3c_bus object and the other masters would just
> reference it.
> 
>>
>> What would be the point of building such a system though?
> 
> This, I don't know. But as you said, if we go for a "one bus per
> master" representation, going back will be difficult.
> 
>> Is this for performance, failover, or something else?
> 
> No, I don't think so, especially since the mastership handover
> operation is not free. So keeping the same master in control is
> probably better in term of perfs.
> 
> One case I can think of is when the primary master does not have enough
> resources to address all devices on the bus, and let the secondary
> master handle all transactions targeting those devices.
> 
>> IOW, what feature would we lose if we were to declare that
>> setup above invalid (and ensure you cannot represent it in DT)?
> 
> That's exactly the sort of discussion I wanted to trigger. Maybe we
> shouldn't care and expose this use case as if it was X different I3C
> buses (with all devices present on the bus being exposed X times to the
> system).

For I2C, this multiple masters for one bus case was retrofitted in
the i2c-demux-pinctrl driver. It's a huge kludge with a number of
undesirable quirks. I don't know if the circumstances for adding
this I2C driver also applies for I3C, but it might be an argument
in favor of the proposed extra bus object...

Cheers,
Peter
