Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD22C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E5F020841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="SKixPdrh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E5F020841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732180AbeGaSmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 14:42:51 -0400
Received: from mail-ve1eur01on0121.outbound.protection.outlook.com ([104.47.1.121]:49184
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732118AbeGaSmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 14:42:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O7j1iORwA8ghLSTnaYmwh4fnKu05CX0KLIK5v76br2c=;
 b=SKixPdrhT4/0WSX+Y8zVuzEL8lsBDrA6e8VmgL1gRWlP0wDehi0+Ns99zHeKPRGPvJY9ytPGP+9qnPIMbjbKOSFNrWdOjqJ4Gdh2ZrDyGc48QyTXEyFOTwo13Q/5YmHmq9vXDV315JlEE/KWQyZzapdDNIDKPWxAlxmAIYmXXYA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com; 
Received: from [172.16.25.12] (185.231.240.5) by
 DB7PR08MB3258.eurprd08.prod.outlook.com (2603:10a6:5:1f::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.17; Tue, 31 Jul 2018 17:01:30 +0000
To:     Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        linux-ext4@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, Gerrit Renker <gerrit@erg.abdn.ac.uk>,
        dccp@vger.kernel.org, Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Eric Dumazet <edumazet@google.com>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Ursula Braun <ubraun@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: SLAB_TYPESAFE_BY_RCU without constructors (was Re: [PATCH v4 13/17]
 khwasan: add hooks implementation)
Message-ID: <e3b48104-3efb-1896-0d46-792419f49a75@virtuozzo.com>
Date:   Tue, 31 Jul 2018 20:01:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: DB6PR07CA0012.eurprd07.prod.outlook.com
 (2603:10a6:6:2d::22) To DB7PR08MB3258.eurprd08.prod.outlook.com
 (2603:10a6:5:1f::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d0ff1fee-750a-434b-6b73-08d5f707448f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DB7PR08MB3258;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3258;3:Aq4rSY5IDLsYzE5tG3hcJ+kZdsNo9p3hrSbLmbaZG62fJ0rrGnRwjzSdRQ00RfgriJWtcHXaWUESgq7M4XWLB8xr24IX+Lps/5paxbySab+nl1ZLSHodyxvl9+SCukvCz1HfwlV4+mRbGOKetgA4dG1WYgrJggZSBCwNcq/zQe4eaF9MpD/qFSQbZ8y5z9NC559F/swidRUdZYbcjEsipxeMkEwEueEAf0Nggs6c/PyiyQSLUWBfZJyY47SDXBXH;25:SASoN1QtCDub9G5jXnhQBntBGdbOms+W+5V9YtxFrO5XH9b5lZlaUreNyFipVTXvLYQ3EndHijqqJ8f3hiISUjqOogUtGIiCwjj2fsENbjKDbLE0+ntG6uYGKzftH1pPo4u22ACT18cO4BiQU2DPzzzGAojG7jxU0ALhryq+bEJ0VAguqWgBVmJ/AYKGNr0yWJIxvVhPx8FTWZrZ/JkNknT9GnGN3iW8B+vWBGa9+qCiTN4IPbwUDJhzCae23EQN/V4D80xgXKhBYxR3Kz0xpzD0JccCcqjeLsgY8wM5MM+pJBMD/A7rCZfaqM91wYJwNQIk/kffsx7kzvdnokBvEQ==;31:Ym259FYej1tWk2hpTANV+br6MWVHUnJyfelHqcELurwaTSJGfXTR+rc2C8PRbr1qG9P4UMDSXSipXFWf6KWuq4ojXvXkwjdgjzQQGwKT6Ajs6nG83GXcXqsWYQuRaEHGlMwI12dVOCmj1BnPqfhXA4l1kt2pkRfTYtkTIqATHpc3EGUX4n8w/DPPlbOZCs4xBhKuG5SQVZxskFg3HljbeAa8Htqq3E8AcDN1nq5NgLA=
X-MS-TrafficTypeDiagnostic: DB7PR08MB3258:
X-LD-Processed: 0bc7f26d-0264-416e-a6fc-8352af79c58f,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3258;20:Eeas+y8EJmDPZ4+qsZBQYDa/cwOXBipKkcYL/hT3Wfn+XRp/BFrgZKDpxLCOFV8VG09mJeN3f5NjgU5F1HT79EsnjGT+019DAyQV6Ih1/3k+0NIpOtBeW6hhdXZFWgFo3br2HyTG3kPqkeKIpyXSQ3URKcVGtgHIea/hoRQXizgai7A6DlgJuvm3hmnYGXVUMUinv3dMDcqzc0G1/+6Z2DL5d8ODgsCS6MFhyRpTI6AO0nVP8GZ0gUlysRKWjfMui40mVsMwp7q+rXJY6rCZTtJTrVD155W133S8faOJTqle3r8OthTO6zsDcq9oQEiginyvWUJc2KEMsxFRji3GjOxprBmVJ1sYUDUzSyFsbG6sNK663UtBj8lYy/jeXb6d4rmWzMqSJ/8EnRtlqwnjsdtnRVkFB8MkOvhDsiNQVnS0Me5ksp/A5O6E318jo2o+02fxHNQnIqk87WqbLxa541bHkKGN2iRTk7urWpYJGz6uf4lrnhUPqih+vxaRS/e0;4:49gvP4OBMo8M6VEbjufskdpX1YUu0Pu7r06BAYvHsT8yPO0t1enwkImAdXSSAZ1twL4AFi+TQwSnxGohXROFomcIVFIcTAQuRteg8lLkIuugcZCpvcVtNx0zqYzT0+RWWum+zcoWq6Q2CRiaPePswZuyCWKZRM5JXfRwQXaDLsrVRO2C5T8kuOlBCzWoh+me+VyV6q5qv2+PzeuLG39XGCGT/0oaiQSBOjU9e1RQMLRVXcQK45d446/0RoZSo4YwBh6Fm3dDSuqqXJF+oOuiEw==
X-Microsoft-Antispam-PRVS: <DB7PR08MB3258129DC7BFD684491BCA1FB02E0@DB7PR08MB3258.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:DB7PR08MB3258;BCL:0;PCL:0;RULEID:;SRVR:DB7PR08MB3258;
X-Forefront-PRVS: 0750463DC9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(346002)(376002)(366004)(39850400004)(396003)(136003)(199004)(189003)(47776003)(6116002)(8936002)(77096007)(52146003)(16576012)(110136005)(50466002)(7416002)(3846002)(7406005)(26005)(2906002)(36756003)(58126008)(97736004)(2486003)(52116002)(16526019)(316002)(23676004)(68736007)(230700001)(106356001)(105586002)(186003)(6486002)(2501003)(65956001)(66066001)(25786009)(65806001)(956004)(14444005)(31686004)(53936002)(305945005)(64126003)(2616005)(478600001)(81166006)(8676002)(81156014)(476003)(86362001)(486006)(53546011)(386003)(2171002)(7736002)(5660300001)(31696002)(65826007)(507254003)(556444002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB7PR08MB3258;H:[172.16.25.12];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjdQUjA4TUIzMjU4OzIzOkhwd0g5TVcrR0ZmL0xsMkczVWJUMXJZV1Rx?=
 =?utf-8?B?NkNhMW9aMlI2MzFvZm0wdmRycWE1Y1lWVFdkWVlDNzlGU0pKUEFmNC93UXZD?=
 =?utf-8?B?L0NsUEh0UElHWm1mNG9CV2JIVThrOTdQTmFWTXdpVk4rS2RsVXloUUdaYXlr?=
 =?utf-8?B?VUR0Tk1PN3JuMkVaRlJ1emRmQWYzazRBK1ZuNGVzcTFKeUxTbHFKQ3R6bXND?=
 =?utf-8?B?OEtJVUFMcGI2UGQ5UDRSVjlQd250eHpSUFh3MWY5QVh6eWQrLzNWaWlRVjIv?=
 =?utf-8?B?OEZ5NENqQzR3OWVrMXJkOXdTZ20wemd6dGV5MUlqeUJRS3hFLytUVGlNNG9w?=
 =?utf-8?B?R2JQOTN5YWJmUTFkcytYaHo2NXZVYUxPSmxpVzNsaVRGVGZyenZGdkxzUzk3?=
 =?utf-8?B?eCtpVVllRTJVaXJwU1VSV3NncUJ5UWZESG1ESzJtZXhDTnhBQVMvTWFCZW5O?=
 =?utf-8?B?c0FNcGQwOEpkb3ZTS0xHTmVJYzhXcmVTUlpYZjJ5TTQ0STJpNGdyWWtxcXYv?=
 =?utf-8?B?Tnkzb1RvbW9SNTRPNzFlWXVBRE85M0d2Z2N0ODRvUlY0UVRYdmtTRFlqM2hl?=
 =?utf-8?B?Q1hucUxkN1hTcHRIWDZlRGNaSHlrR3dLUlJTUnY5OThEVVQ1Y0JIcGhMZ0tj?=
 =?utf-8?B?bGJNTTVCb1ZaT1lCbnliNnJLYkZlelFJeVpzUEt4TnMyeE14M3RTRExJQ0lx?=
 =?utf-8?B?SXM4U1JSUlVJQ3J2N2JHNStZaFBYb3ZsWjJKNmdLSTVCZUFNNmlWTkFhV3Vq?=
 =?utf-8?B?SjNtaGV4alpnelhBS2U0dFlWTzM3dlY3dzRZYkVvRTE4cjUxQlBLcWIvaFZJ?=
 =?utf-8?B?ZU5lQjZqYk4yQlJsTkpVWnEyK3BWRy9sUGNwQktRekZpTVBuSjJlY3F3YTB4?=
 =?utf-8?B?amhON1R2bC9Fbm9TTlhvRkpLWVo0cWoxdUdkeGFkamg0V1l3NWZtb0dpTE5l?=
 =?utf-8?B?ZEpLMzZRblBqS05WMGtGVnpaZUxFTEdUem92WEVvakNhbk1Kck9nYUJHOWdu?=
 =?utf-8?B?WDhBdUo1ZEZpQVlvanRwNmk2TVBVUzR6dHFpRDNqWFI1VXRjd2hSZ3JWRE40?=
 =?utf-8?B?TW9kcDZSbE5OTlV5MVVHNWdEcU9rTDNBLzZ5RUE2NHRmaE5SbFl0SGZESnAy?=
 =?utf-8?B?TkpNcUoxK0ZMeCsvMTdsV3orWDBMMWhwRlBNeVFjajJ5eDJ0WWcrRExPWWla?=
 =?utf-8?B?U3VqcmFESTI4RVk2aGNRZG9ZYWpuNEhnWFpKUFhiQVZxU3FZSE1kRXViR1M0?=
 =?utf-8?B?Q1JuRitJaldpSDJVanY3WHJoZWY4MEdmL283Q3dBUmFJY0U2YjdEcnFDdTVP?=
 =?utf-8?B?VWNRSlZBN2pXbisrQTUrbG80Y3Y5cWc4NHBLODlDeWNZWnNodXZlV29XUENU?=
 =?utf-8?B?Sk11Yk1vRm85ZzdpUEhlMVFiTTVWdU5HTFZiOVNDdElwdzRvT01adUZLTGpQ?=
 =?utf-8?B?R0d5Y2tYUVBtZWIvNTZSc1hBVGZZTUFFZG8wc1FFVUgzU0JnV3hKZk9DZlBr?=
 =?utf-8?B?NVpQQml6TmVLZ1Aza20xYVRxNmd4Y0swWVUrOC9McXJ2S0lUUmpuRy9DZmZm?=
 =?utf-8?B?Y0JTbXlUY3BJWjErTk5YT2I4R3NLK094NXVsMFpVVmRtYUhiQllaTitMN29X?=
 =?utf-8?B?bkhxcEs0ZVlwaStwM0lBYllicUNuZ1lUclFLMDIyRkV4RzdTaHRKdDd4Tnli?=
 =?utf-8?B?aWl1T0Z6dGhsb0JEVTFxK20zMTl2c1NPbXQzVTVMOVMrQmdNdFd1UVdJQ2Vw?=
 =?utf-8?B?VUd5Ri80c1pLUkhBdDRGODUvd0w1VFo0c2hNZW96eWJ6T2hnSnlkSE1NRzQv?=
 =?utf-8?B?VG1tVmwwYmhpNE9oZjROTEU5VGZub3crS0JOZ2pRa0F5TlZwSmRlOG5MR28v?=
 =?utf-8?B?OFlSODRQQlFpdjF5WERaUHNqczhlbDhWTkJtdnVMSC93bDI0bGNQWHJzczNH?=
 =?utf-8?Q?Y+9xI6qf5myaLSnQom/73hi4miPk0w=3D?=
X-Microsoft-Antispam-Message-Info: G5uD2uCvZvHMMWDfneqfHZckiMwfXPkgqOv7BrFPhOfsOF66JbA8maNf4f9R8o0Bi7rEYuTx4J88+S1Rt/baOqMTDLWqVgbJaqt2xeCzzKfAniPsgzFa8YhEdoPkSYJC3Y7SNI3NQ8qsUyLox475jW9YCU2rGoY3MS9Q+8qFy9MP2BjXxcGPW4T8woTopWlXr+xaK+W211i027ihS4TUjpWpZOA/AO6nzgR6XR7ooLdXyqDzRQNmVakQfdQey4Yk2/GBeaKnaKdnwgW9RF91+yvzH2EvYF8MGdyQCnp6cTomZ346Cq/5hLpo5+RwmFpSCgHEAt85tnW73mpz8w7VwaaXcbXi9Lz30IQPpEz6EWQ=
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3258;6:0GnnoG51+K2gPsEAj9gXAO+hHej9XaHicsl+uQDDjFD/YbLht6st+dXZ05uURRXwrr86ZZ9eQky5QwlpAwDiDz+52PVMcuarIlAJCblsv2XOnt3jvCANosw8AgH1YwFepGwIo96IEWdSjkWi8yfFgjEDk4K1dyiypnZyAvL/hmvCcZuLyLHnsSQepUyylW2ucgQsGIt12xisNVCwCrr1iy6nInWkl6c6QlPzmWufQ2VdP5KT7wAullpEgZwdk3Tzmdv+g4IVMmRh3+BZool8262ag1f/U4fkJGW0Orw3GFXCqEJ7I78qni3bH2amo13+2qSAa3xG1JVZ4KUWuiiN2o1bo32IVx3Y2CFLdfYJsBZ9vFTdx8/iNM+NY+vLMcjxJR06W6y3yM4xF3SZ2idlEPrs8PpM1BCJJKiwpladx9x5I9h9/g6PL6zqNuWD5aOIvpC2igBzEGLQmQ05YLc4Jg==;5:r87vqB1gE/tQ0DrJJq2ewtOwwwZd73nqevlOLEPsp+DZdOdSnimJZiJpxGPX7eob65nkOwaZMEMU6W2YjbXPVyGG2biYRSO/qDnJh/QSRY9MCwc27lnGFXMnU5nLxmc4KF2tjcILfR6komwLrrFboLI8Y9s8+W0Pp++JAONe2gg=;7:FBKlUb9S4zcXkk5aDbEDKiHlZgumNf64yxFUaAog2WdbDrEzf/an0Mi0AnuK1GS3DmJRx3TK8nyo3zxJQFxlbHEy4HPPiLyLQPM3eVgcpVgrb2PCbn+4LxOkoJdOcgOAghb9CCF0LdksKM/SiDwAfPEHxcCKq1I9VkelkozGVj6LHevSVxSNhaTwa1hW4c2pkjgohiNJli+DOh35v3dIBsVNaJjwt3IIPN7FUaLGlFhOsauV19/ldaRuJfg2a/4h
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3258;20:Pgvv4ooT6FRdIhMbPXepPzZ3ffUjz8xRIwLG34QG8Z9LejjIhOQYRqS4OCW8jjfuum+tIEOsNkkMC0tEWMgkJ5JqM1SiaoJjl5+YRrX2aj1ac/qKqflN4v15j5+m2LBDS2ckA2b483FYnSWScOa2vyT1GQrJz+e8gffF+czsq7g=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2018 17:01:30.2530 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0ff1fee-750a-434b-6b73-08d5f707448f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3258
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 07/31/2018 07:04 PM, Andrey Ryabinin wrote:
>> Somewhat offtopic, but I can't understand how SLAB_TYPESAFE_BY_RCU
>> slabs can be useful without ctors or at least memset(0). Objects in
>> such slabs need to be type-stable, but I can't understand how it's
>> possible to establish type stability without a ctor... Are these bugs?
> 
> Yeah, I puzzled by this too. However, I think it's hard but possible to make it work, at least in theory.
> There must be an initializer, which consists of two parts:
> a) initilize objects fields
> b) expose object to the world (add it to list or something like that)
> 
> (a) part must somehow to be ok to race with another cpu which might already use the object.
> (b) part must must use e.g. barriers to make sure that racy users will see previously inilized fields.
> Racy users must have parring barrier of course.
> 
> But it sound fishy, and very easy to fuck up. I won't be surprised if every single one SLAB_TYPESAFE_BY_RCU user
> without ->ctor is bogus. It certainly would be better to convert those to use ->ctor.
> 
> Such caches seems used by networking subsystem in proto_register():
> 
> 		prot->slab = kmem_cache_create_usercopy(prot->name,
> 					prot->obj_size, 0,
> 					SLAB_HWCACHE_ALIGN | SLAB_ACCOUNT |
> 					prot->slab_flags,
> 					prot->useroffset, prot->usersize,
> 					NULL);
> 
> And certain protocols specify SLAB_TYPESAFE_BY_RCU in ->slab_flags, such as:
> llc_proto, smc_proto, smc_proto6, tcp_prot, tcpv6_prot, dccp_v6_prot, dccp_v4_prot.
> 
> 
> Also nf_conntrack_cachep, kernfs_node_cache, jbd2_journal_head_cache and i915_request cache.
> 


[+CC maintainer of the relevant code.]

Guys, it seems that we have a lot of code using SLAB_TYPESAFE_BY_RCU cache without constructor.
I think it's nearly impossible to use that combination without having bugs.
It's either you don't really need the SLAB_TYPESAFE_BY_RCU, or you need to have a constructor in kmem_cache.

Could you guys, please, verify your code if it's really need SLAB_TYPSAFE or constructor?

E.g. the netlink code look extremely suspicious:

	/*
	 * Do not use kmem_cache_zalloc(), as this cache uses
	 * SLAB_TYPESAFE_BY_RCU.
	 */
	ct = kmem_cache_alloc(nf_conntrack_cachep, gfp);
	if (ct == NULL)
		goto out;

	spin_lock_init(&ct->lock);

If nf_conntrack_cachep objects really used in rcu typesafe manner, than 'ct' returned by kmem_cache_alloc might still be
in use by another cpu. So we just reinitialize spin_lock used by someone else?

