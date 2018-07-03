Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 205EEC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBE3421A89
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:09:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="UFPCbxmS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBE3421A89
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933311AbeGCPJH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:09:07 -0400
Received: from mail-eopbgr30094.outbound.protection.outlook.com ([40.107.3.94]:61982
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933098AbeGCPJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:09:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VsPzpjXEiYYi3mKYMXHgsU6et+vG3t8R5KGHlLq3UIo=;
 b=UFPCbxmSyWrCoOxezddPSVgGUorxdrQ9rZvGgssL7abNRt4vdj1wMeXPCN4mdv+rFmToWIPJ7B5qbDSwdj5EI58WXUjOouHO+4Uk7g5rmb/vI6gDLOMKv/fv23S+FdvbxBprxGBtQLZjmv4zRnufyiTQZCht5foesv2fL28u04M=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from localhost.localdomain (185.231.240.5) by
 VI1PR0801MB1343.eurprd08.prod.outlook.com (2603:10a6:800:3b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.26; Tue, 3 Jul
 2018 15:08:58 +0000
Subject: [PATCH v8 02/17] mm: Introduce CONFIG_MEMCG_KMEM as combination of
 CONFIG_MEMCG && !CONFIG_SLOB
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     vdavydov.dev@gmail.com, shakeelb@google.com,
        viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
        tglx@linutronix.de, pombredanne@nexb.com, stummala@codeaurora.org,
        gregkh@linuxfoundation.org, sfr@canb.auug.org.au, guro@fb.com,
        mka@chromium.org, penguin-kernel@I-love.SAKURA.ne.jp,
        chris@chris-wilson.co.uk, longman@redhat.com, minchan@kernel.org,
        ying.huang@intel.com, mgorman@techsingularity.net, jbacik@fb.com,
        linux@roeck-us.net, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, willy@infradead.org, lirongqing@baidu.com,
        aryabinin@virtuozzo.com, akpm@linux-foundation.org,
        ktkhai@virtuozzo.com
Date:   Tue, 03 Jul 2018 18:08:56 +0300
Message-ID: <153063053670.1818.15013136946600481138.stgit@localhost.localdomain>
In-Reply-To: <153063036670.1818.16010062622751502.stgit@localhost.localdomain>
References: <153063036670.1818.16010062622751502.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: VI1PR0501CA0047.eurprd05.prod.outlook.com
 (2603:10a6:800:60::33) To VI1PR0801MB1343.eurprd08.prod.outlook.com
 (2603:10a6:800:3b::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e838238-bf6c-4102-687b-08d5e0f6e839
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1343;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1343;3:mhe55bv8ZMmNT8cl+hb65TshUc1vEVhjD3wT00aDsBaDhCUBOCMck5BBU2PYT2/Hzkeeo6drxwi7qWmjtOt6MDtpwTFQZC1H1m5bURb0KBT+CGeHjdKikDnK7SC55vM98EndsadZK+vKHH1LYwJOBS+fi7MtNRVjud8mj+jV+AOGAy+K1ef8WfDAc1RBRBMDK6ecWPLqMTI6mUZo1inkbHSxIHs4Jtnt7bOyuNMPMjzHcwdpc8tBGwrKV0gp59nz;25:A6s8snHYzB5As12ym4NCZ0ojzM7iEQygl1rAZehMY7fBbeXEaUABTpQtZ3Blzcw/CJ6nnFQb59hKGErhRwM9QbgRHTTZSxWa5GgIGetqUIZ/Y6xsVGvHPB9v/EazVWhHjw0vGeGFQMk50NuSFs68cMLleGaFVf3NXdsRbKcvKFnbjSML+ch4QnGb+OJa1mpUCGJNKpaPPgPajd5DwdSRjKkWYIqDi8MCR32bl0w7psrgrQjrxJ7rbVaCurHoAvOsy9ISDUsWyB/H/tGt1EosBfW2kU/XvYSoKcLpBRhwsTdysqKx/lfpjSjyGgZ+Ju1aBXBooN/N85kJ3KwYwaXx3w==;31:gBlpIFlIZiCsIOBbnQ+hwYP4N8sArmtfb7KSNmXQl6N6X1YA1DCvX4sr3ndAHj6HYpiLjtVhuCYOLA/fWZnd495mYZEyHyJ3gb0uAi9uDgxZ8JQdsoGVX4P1fCM4nnzWdHv6aYuCGCErDHHqpaD7hCpagKFmzyG1me/17OUjD/PXnY3W6Ie4QEob1cBVIMrrfziwDqROYjP9Dsv3+XLcIY2QeSK8DBgDuy2lCPIcRlg=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1343:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1343;20:z3xkA6bzhTu6HqQl5ij78Bjn9EVUmH6d1Pz2l2v/E7yu5CT83IYU+dqvoTMm4ATpRL22y4zSideVS0d0mauLCvEsRD8pNm2lKNxJtblbWAlhUQNwhQDDv4lSAqFi5wvSqXEqQtM3X0TnrrRToaRZWvAvSFn0f1lw0MUUgvtakwSVFtbvvikPdouhMGaPAgFTwjDY4oKWuHFW88LPSgyRtLLYFAWnWjWAQ3GtX5wl7EBht44arwCo6wgEPoH3bmaJcjrFtJ49be4I077TkoKeC8JE2xp1TGrhK3B2UKEYuGJXbbGjLuySMvjB5Ra4vPDHKkiz8r1gRZz5X/jOfWEuYMpi9WSzw8BBg/lLlyaH9Z5zz5QtZzNVHGukluMXLTJtLne4YwmLLjytWHNaVkdZG7obWF58sCMMdc2KCpWyEU777C6JGnnIVY9GLPqxJPQrplzzZRo0t0UU8FoZT3lenIye2QOIStkFEb0DvmueS2w+/x3PJt1Pxl9duyOkqqRY;4:zG5w6cRmLMtxojctcRpGkqkvfzRaEEBgellORllsPAVDC7UdzpZEqw7OFce3Q/zOHhTFRK2C2htaXHwOmIr1SZD3Ges/H4fR8T/qbTG9dmXThnilzVht+ijDCjeUzQ1PxPx7XltKH+SKnBRMVHMPGxRaMjuuobGrYN3/SefH0R/uWHOb/Z87Xe0vPsEcckZzWsOHMWkaTFqnwashymXsrJbM4nsbRP/lgZlh0hxAku2B92IvoDRmPs/MFNc+/ss6g6+hbqcR1Bn3Srx7dZlaH1yo+l/tUXBu6aEwkmLHuvzTiowArak5iGKrUCxfcS8h/TddSET4pWPFT9GstxAQv7kc70liO5rSL6hsxN3RcvsScOTided1RyDPDa2x0yfD7j551d589O6T7u6PKbsmAepyjMtfO/nxuYSr2QkhQqQ=
X-Microsoft-Antispam-PRVS: <VI1PR0801MB13435E7240ACE3A5296C47D2CD420@VI1PR0801MB1343.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(788757137089)(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:VI1PR0801MB1343;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1343;
X-Forefront-PRVS: 0722981D2A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(366004)(346002)(376002)(136003)(39850400004)(396003)(189003)(199004)(50466002)(186003)(16526019)(103116003)(26005)(11346002)(230700001)(23676004)(53936002)(39060400002)(3846002)(7696005)(6116002)(76176011)(52116002)(2486003)(33896004)(6506007)(386003)(68736007)(25786009)(81166006)(81156014)(486006)(55016002)(8676002)(106356001)(2906002)(446003)(7416002)(14444005)(66066001)(61506002)(105586002)(305945005)(5660300001)(47776003)(7736002)(575784001)(956004)(316002)(478600001)(97736004)(476003)(9686003)(58126008)(86362001)(8936002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB1343;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjEzNDM7MjM6eDdiM05BMHphaTgyR3N4aXRTS0xEZjdU?=
 =?utf-8?B?NDlEZTFtUnM0ZGIxcmExWkdRRzRRNGFRcVRsTU9tK0VnMHZOTngrSFFJbFp1?=
 =?utf-8?B?aWxTSlVXazFYOWxXdDR4c0x4WjM5NWZnZVFPN3RHZmNWYVhzSFlEVzZEbGFy?=
 =?utf-8?B?NFFDdEZ3RzhFajRDelBaVWFZUkhiU2RaMEVURVBtQ2RQejU1dnRQNDlaanBa?=
 =?utf-8?B?alczWnNoNEVlNythdTI2WVoydTVLcjdKZ2pycmcxeWZYK2I4QlJCa2lMdTl3?=
 =?utf-8?B?RklrMHRIekJpMzlTdFNYRlFtZ0dFVERadXJCbERGa2VSSGtxRStGdDhxT21C?=
 =?utf-8?B?bitodTlEVCtyekZQNDk4Z2lNU2d6dVE1T3Jhb1htNk9iUGEwSjJaOU82MDhs?=
 =?utf-8?B?L0czY3VqdHBMbi9WaHcvblNPZ1RoLzJwdytYYVhQb1RRdnVmYjE0ZkVzL0lH?=
 =?utf-8?B?eVF3WDR2OGxHVjB6RzJ6eDBUZE5KZGx3OHliWTBOeWd4VzFTQ0JNM3FQR0oz?=
 =?utf-8?B?RVdtREh3eGxoNlZXNU4xKzQ0RDJvVGFESk5QMFQwSU1aQzAvbjZKT3VpSnlv?=
 =?utf-8?B?YWYvZWU0b3NacmIxcVJVOWFqbmVabWU1dUVKM2JuZks4RWpndzRFN2FnK0lu?=
 =?utf-8?B?LzF4ay9McFMwb3dGK042VEtxa2xGRStIV29CRFRZVzFSSmRWNVRDcTAxZXZK?=
 =?utf-8?B?T0l6ejcxaXp1M1J1OEhqcnJrRHpwUU1HcVpmNTNSbEJNRXYvS28yRDN6TTVY?=
 =?utf-8?B?c3p0S2FZNEpPTzhhWFZYSzliOVZxUHRXaWgxMWp3c2JrNElyZGgybnN3aUNu?=
 =?utf-8?B?UThURzc4UWEvRlFBZU0zdS80a0h1OGxIYXJ6VUZGQzJoRVdDOGRrSVV3NmR0?=
 =?utf-8?B?VUVnclVRTzNEOElxN082OW1FUHhWSjRaTEplK3dwdmVjZGJrbis4TDYyaUZv?=
 =?utf-8?B?TTR4S1pRVkNsNWdYUW1WVWw0OGd2dGRhV3lWZmVUaEJ0UytXcVhqcndLS2Iv?=
 =?utf-8?B?OVdraFJEV25MVTdHVXhrb2Z2dWdIK0Q0SjVkUStXcUw2cHJkcU12emRFTEZi?=
 =?utf-8?B?QnAyNUdlQXFNSHpwdlRsLy90YnRISkVxYXZUQnNNeThMOW1sQmI5cVlRMmlL?=
 =?utf-8?B?bWwxdXJrc3k1amVXeFdZczI3akpSMjQyZ2JIbVhJU0JOTmRsRDVRYzEzVkg3?=
 =?utf-8?B?cHh1ak5LblptNzBFMUx5dWNSUDBTMW05eXppVUFxRENBVTdhc0lLRFFiQmVp?=
 =?utf-8?B?cHc3YWRwSWN6VGI4VXV5bmNISXJRN1g3MkZIS2l3Vm4xNEJNRHpXckRGZE9h?=
 =?utf-8?B?ZStFRTY1ZytEdnBPUUlyV3RlVk9jYURzN3kxVlVZOUI5WFEyUGp2TlREcnhL?=
 =?utf-8?B?TTNJb2JVM1gyM2VBa1dKM0ZYNjFTVFNNZ2hNNURDcmw1N0FOdy9tNEpjemFt?=
 =?utf-8?B?OUI3eU8rQ1FHbEpGbDJlVTZkT2xTOHYvZTk3Zm8rWDR1MjMzSVFjYUtmN2RY?=
 =?utf-8?B?MDlySU4vZ3d3US8yb1dIaXNjM1BRYkM3UExHU1ZFMkc4MVZYMExMSThBZ2lm?=
 =?utf-8?B?Ti92bU1FMnJDL0gzaVpvaGJSeTV5UWRzY093MFVEcFJrQVBxeVFhdHRPdVI3?=
 =?utf-8?B?d05haWk5RnA1WDAvN0dKMXRHRmVpKzBmaXBkc3F4T0RTbUR0QVhmUVFtQlJl?=
 =?utf-8?B?YnViQ3pVN3NhMFFHN3JmY3Z3aHBWMmdPUk8xcVI4QlBlb3VYQkNRVW5RVDBC?=
 =?utf-8?B?L0ovbmExaU04NTNGQStHbE1nPT0=?=
X-Microsoft-Antispam-Message-Info: 4E7z7kY1I8nka0ehZF/fUqqgz4oO+O35Rk3Q983fSgxVjYlrlxqb4OeoZAhZ0BM2a3Fx97CrYfP/T78PZdgyinDPEelzgwzwfp/gM5/QGqte/okZHryYmfQWZipMVmpqrQSY6YVydDBUQb8dfmvZSuzLChV180RwgR1CY56x/l57OIcESZ4HYVLpfqDWDs8XrBLNdnDSaRTLGSvwBQjZW+iq10RvEFHlP9QPy/fFX1E1ycJsVPvP8YRR8scFhCOHQ8HJHFMThw5B4LzxXuCAVORdVXZae8PjEsbi7qP2YjNNwwAPrSfcX1L8CBzGl9RFwB8s/AnLCuAdWbFv0yE4shuEndTofKF6zAPvL7kbdhA=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1343;6:bQGqy262+gh3M+S4VfV6AsJGl7e3qAYXHm9eyAvx15xF85s0vdbJhTh75Ll3S8jWlC12KcIbyr3xWOKYxzgzw7TF6xIvrRKq27EAZpB+v6OfvwwunLKpsqyrs1jVz9HyLQhUji7QPBJhL6gYMA2W2FkLe+cf72fYoM/SX4YF2/5DE358MSpMV03SW585a8MXbeR03JQ8AT9HdUCH5yhRoNpiQKSOWO2pD0vvgfFIEZrCvmlT0SP7eWaSwCZ0MW6Q6SeMYj4MQQtUDOH8ycSQfX6NKE5CYWeAcetr48vH7uj1JY/QYwkN+EeIecJmphw1LQpYzfIhd2QOxtNHkEovg7lHCElAeJnYLJ1ruyw0tb6oVrByozeUyn+C470v4arB/yhSD8c6LXkqUVUH1tCTHZVHVDgn8Nc9X4ufY1nAh/UTFjSlvoapjn9TZXHFjbBMb5ZweQNr0PgQE9C1+7180A==;5:k5uLlXFSl6lb4Rr+To2uPdpyNQkP3ix2iRB4qiXO8IAATQur4hB6EgNkz78pofPYw0xuVedG0AtbvjN9A+A2AKwI85tUisgHpIQQ8ZSJm9iSfzF0yEJvf8XjdXljKtnOZjxAbeBJpwfMl4VRhCz+x0qW/Mc+zMpMhEcJnR/OnyM=;24:0TsZOPzgjupYsOi5yIq/WLlSAxeL+5ALlvj5PignTDMCdKbkGHSsal+/zQqS2EP+pPR9WLyJAljSFAf5FBdjwt7e/4HAp+njUEksn+XNBE8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1343;7:vRDaJVSj/43mLfxwyzNZunZwYOOVYH6Knk2mYY8wheAup/lbeREiySVj0tRBMZuFdldg32IJMbJ6CYYbTfOQQ88xsubn8hThVmgzWyeAUsbL8sOmRppAV/1tjwYfTIBq+Uf33UhA6gsLoy4uo/yK7QmHAfmFrldBead62etbCH7D2a0In2YH4uMV0+KVSPtQDNb/nFYEStidN65QmyZ041wW6DiUxTx3xRzxyVXC1zMwL2xfnEysdN4vvMA1+gvA;20:PqIQ7xQUz4B7KYU0eYtm6V3RpwNUJ6wUYnoE+bXmnZGjPJzhWNmtPti55CfisXZp6cuEjVoDxtxINnM0dtl3INNDpPi0t+OOHvXTShgzWugivI7Woaq6vUJKtTj5duAIoBmk86f+6TBUhICHtZgg6d6Xipx214rlRarMySd4YYc=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2018 15:08:58.7061 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e838238-bf6c-4102-687b-08d5e0f6e839
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1343
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces new config option, which is used
to replace repeating CONFIG_MEMCG && !CONFIG_SLOB pattern.
Next patches add a little more memcg+kmem related code,
so let's keep the defines more clearly.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Acked-by: Vladimir Davydov <vdavydov.dev@gmail.com>
Tested-by: Shakeel Butt <shakeelb@google.com>
---
 include/linux/list_lru.h   |    4 ++--
 include/linux/memcontrol.h |    6 +++---
 include/linux/sched.h      |    2 +-
 include/linux/slab.h       |    2 +-
 init/Kconfig               |    5 +++++
 mm/list_lru.c              |    8 ++++----
 mm/memcontrol.c            |   16 ++++++++--------
 mm/slab.h                  |    6 +++---
 mm/slab_common.c           |    8 ++++----
 9 files changed, 31 insertions(+), 26 deletions(-)

diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
index c2161c3a1809..5d7f951f4f32 100644
--- a/include/linux/list_lru.h
+++ b/include/linux/list_lru.h
@@ -42,7 +42,7 @@ struct list_lru_node {
 	spinlock_t		lock;
 	/* global list, used for the root cgroup in cgroup aware lrus */
 	struct list_lru_one	lru;
-#if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
+#ifdef CONFIG_MEMCG_KMEM
 	/* for cgroup aware lrus points to per cgroup lists, otherwise NULL */
 	struct list_lru_memcg	__rcu *memcg_lrus;
 #endif
@@ -52,7 +52,7 @@ struct list_lru_node {
 struct list_lru {
 	struct list_lru_node	*node;
 	bool			lock_irq;
-#if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
+#ifdef CONFIG_MEMCG_KMEM
 	struct list_head	list;
 #endif
 };
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 04b18ce4f1fd..62309f180ee6 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -280,7 +280,7 @@ struct mem_cgroup {
 	bool			tcpmem_active;
 	int			tcpmem_pressure;
 
-#ifndef CONFIG_SLOB
+#ifdef CONFIG_MEMCG_KMEM
         /* Index in the kmem_cache->memcg_params.memcg_caches array */
 	int kmemcg_id;
 	enum memcg_kmem_state kmem_state;
@@ -1253,7 +1253,7 @@ int memcg_kmem_charge_memcg(struct page *page, gfp_t gfp, int order,
 int memcg_kmem_charge(struct page *page, gfp_t gfp, int order);
 void memcg_kmem_uncharge(struct page *page, int order);
 
-#if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
+#ifdef CONFIG_MEMCG_KMEM
 extern struct static_key_false memcg_kmem_enabled_key;
 extern struct workqueue_struct *memcg_kmem_cache_wq;
 
@@ -1306,6 +1306,6 @@ static inline void memcg_put_cache_ids(void)
 {
 }
 
-#endif /* CONFIG_MEMCG && !CONFIG_SLOB */
+#endif /* CONFIG_MEMCG_KMEM */
 
 #endif /* _LINUX_MEMCONTROL_H */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 251245601719..bd5212523af0 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -723,7 +723,7 @@ struct task_struct {
 #endif
 #ifdef CONFIG_MEMCG
 	unsigned			memcg_may_oom:1;
-#ifndef CONFIG_SLOB
+#ifdef CONFIG_MEMCG_KMEM
 	unsigned			memcg_kmem_skip_account:1;
 #endif
 #endif
diff --git a/include/linux/slab.h b/include/linux/slab.h
index 14e3fe4bd6a1..ed9cbddeb4a6 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -97,7 +97,7 @@
 # define SLAB_FAILSLAB		0
 #endif
 /* Account to memcg */
-#if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
+#ifdef CONFIG_MEMCG_KMEM
 # define SLAB_ACCOUNT		((slab_flags_t __force)0x04000000U)
 #else
 # define SLAB_ACCOUNT		0
diff --git a/init/Kconfig b/init/Kconfig
index 4fac26b0efba..ce683fcbc701 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -691,6 +691,11 @@ config MEMCG_SWAP_ENABLED
 	  select this option (if, for some reason, they need to disable it
 	  then swapaccount=0 does the trick).
 
+config MEMCG_KMEM
+	bool
+	depends on MEMCG && !SLOB
+	default y
+
 config BLK_CGROUP
 	bool "IO controller"
 	depends on BLOCK
diff --git a/mm/list_lru.c b/mm/list_lru.c
index b93f64f25414..6743cdb76ea6 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -13,7 +13,7 @@
 #include <linux/mutex.h>
 #include <linux/memcontrol.h>
 
-#if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
+#ifdef CONFIG_MEMCG_KMEM
 static LIST_HEAD(list_lrus);
 static DEFINE_MUTEX(list_lrus_mutex);
 
@@ -104,7 +104,7 @@ list_lru_from_kmem(struct list_lru_node *nlru, void *ptr)
 {
 	return &nlru->lru;
 }
-#endif /* CONFIG_MEMCG && !CONFIG_SLOB */
+#endif /* CONFIG_MEMCG_KMEM */
 
 bool list_lru_add(struct list_lru *lru, struct list_head *item)
 {
@@ -297,7 +297,7 @@ static void init_one_lru(struct list_lru_one *l)
 	l->nr_items = 0;
 }
 
-#if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
+#ifdef CONFIG_MEMCG_KMEM
 static void __memcg_destroy_list_lru_node(struct list_lru_memcg *memcg_lrus,
 					  int begin, int end)
 {
@@ -556,7 +556,7 @@ static int memcg_init_list_lru(struct list_lru *lru, bool memcg_aware)
 static void memcg_destroy_list_lru(struct list_lru *lru)
 {
 }
-#endif /* CONFIG_MEMCG && !CONFIG_SLOB */
+#endif /* CONFIG_MEMCG_KMEM */
 
 int __list_lru_init(struct list_lru *lru, bool memcg_aware, bool lock_irq,
 		    struct lock_class_key *key)
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 20220b164616..31d203099af8 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -251,7 +251,7 @@ static inline bool mem_cgroup_is_root(struct mem_cgroup *memcg)
 	return (memcg == root_mem_cgroup);
 }
 
-#ifndef CONFIG_SLOB
+#ifdef CONFIG_MEMCG_KMEM
 /*
  * This will be the memcg's index in each cache's ->memcg_params.memcg_caches.
  * The main reason for not using cgroup id for this:
@@ -305,7 +305,7 @@ EXPORT_SYMBOL(memcg_kmem_enabled_key);
 
 struct workqueue_struct *memcg_kmem_cache_wq;
 
-#endif /* !CONFIG_SLOB */
+#endif /* CONFIG_MEMCG_KMEM */
 
 /**
  * mem_cgroup_css_from_page - css of the memcg associated with a page
@@ -2182,7 +2182,7 @@ static void commit_charge(struct page *page, struct mem_cgroup *memcg,
 		unlock_page_lru(page, isolated);
 }
 
-#ifndef CONFIG_SLOB
+#ifdef CONFIG_MEMCG_KMEM
 static int memcg_alloc_cache_id(void)
 {
 	int id, size;
@@ -2447,7 +2447,7 @@ void memcg_kmem_uncharge(struct page *page, int order)
 
 	css_put_many(&memcg->css, nr_pages);
 }
-#endif /* !CONFIG_SLOB */
+#endif /* CONFIG_MEMCG_KMEM */
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 
@@ -3060,7 +3060,7 @@ static u64 mem_cgroup_read_u64(struct cgroup_subsys_state *css,
 	}
 }
 
-#ifndef CONFIG_SLOB
+#ifdef CONFIG_MEMCG_KMEM
 static int memcg_online_kmem(struct mem_cgroup *memcg)
 {
 	int memcg_id;
@@ -3160,7 +3160,7 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
 static void memcg_free_kmem(struct mem_cgroup *memcg)
 {
 }
-#endif /* !CONFIG_SLOB */
+#endif /* CONFIG_MEMCG_KMEM */
 
 static int memcg_update_kmem_max(struct mem_cgroup *memcg,
 				 unsigned long max)
@@ -4464,7 +4464,7 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
 	INIT_LIST_HEAD(&memcg->event_list);
 	spin_lock_init(&memcg->event_list_lock);
 	memcg->socket_pressure = jiffies;
-#ifndef CONFIG_SLOB
+#ifdef CONFIG_MEMCG_KMEM
 	memcg->kmemcg_id = -1;
 #endif
 #ifdef CONFIG_CGROUP_WRITEBACK
@@ -6330,7 +6330,7 @@ static int __init mem_cgroup_init(void)
 {
 	int cpu, node;
 
-#ifndef CONFIG_SLOB
+#ifdef CONFIG_MEMCG_KMEM
 	/*
 	 * Kmem cache creation is mostly done with the slab_mutex held,
 	 * so use a workqueue with limited concurrency to avoid stalling
diff --git a/mm/slab.h b/mm/slab.h
index a6545332cc86..2215eec16c0a 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -203,7 +203,7 @@ ssize_t slabinfo_write(struct file *file, const char __user *buffer,
 void __kmem_cache_free_bulk(struct kmem_cache *, size_t, void **);
 int __kmem_cache_alloc_bulk(struct kmem_cache *, gfp_t, size_t, void **);
 
-#if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
+#ifdef CONFIG_MEMCG_KMEM
 
 /* List of all root caches. */
 extern struct list_head		slab_root_caches;
@@ -296,7 +296,7 @@ extern void memcg_link_cache(struct kmem_cache *s);
 extern void slab_deactivate_memcg_cache_rcu_sched(struct kmem_cache *s,
 				void (*deact_fn)(struct kmem_cache *));
 
-#else /* CONFIG_MEMCG && !CONFIG_SLOB */
+#else /* CONFIG_MEMCG_KMEM */
 
 /* If !memcg, all caches are root. */
 #define slab_root_caches	slab_caches
@@ -351,7 +351,7 @@ static inline void memcg_link_cache(struct kmem_cache *s)
 {
 }
 
-#endif /* CONFIG_MEMCG && !CONFIG_SLOB */
+#endif /* CONFIG_MEMCG_KMEM */
 
 static inline struct kmem_cache *cache_from_obj(struct kmem_cache *s, void *x)
 {
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 2296caf87bfb..fea3376f9816 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -127,7 +127,7 @@ int __kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t nr,
 	return i;
 }
 
-#if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
+#ifdef CONFIG_MEMCG_KMEM
 
 LIST_HEAD(slab_root_caches);
 
@@ -256,7 +256,7 @@ static inline void destroy_memcg_params(struct kmem_cache *s)
 static inline void memcg_unlink_cache(struct kmem_cache *s)
 {
 }
-#endif /* CONFIG_MEMCG && !CONFIG_SLOB */
+#endif /* CONFIG_MEMCG_KMEM */
 
 /*
  * Figure out what the alignment of the objects will be given a set of
@@ -584,7 +584,7 @@ static int shutdown_cache(struct kmem_cache *s)
 	return 0;
 }
 
-#if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
+#ifdef CONFIG_MEMCG_KMEM
 /*
  * memcg_create_kmem_cache - Create a cache for a memory cgroup.
  * @memcg: The memory cgroup the new cache is for.
@@ -861,7 +861,7 @@ static inline int shutdown_memcg_caches(struct kmem_cache *s)
 static inline void flush_memcg_workqueue(struct kmem_cache *s)
 {
 }
-#endif /* CONFIG_MEMCG && !CONFIG_SLOB */
+#endif /* CONFIG_MEMCG_KMEM */
 
 void slab_kmem_cache_release(struct kmem_cache *s)
 {

