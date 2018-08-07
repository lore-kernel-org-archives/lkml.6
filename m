Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D76B6C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 15:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CE8821470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 15:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="H3ZkR6BY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CE8821470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390049AbeHGRxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 13:53:39 -0400
Received: from mail-ve1eur01on0136.outbound.protection.outlook.com ([104.47.1.136]:7872
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387578AbeHGRxj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 13:53:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2uYe2qDeYfym+/n7FbyMe2UtdLf6NUQqwQG95QedNIE=;
 b=H3ZkR6BY2YtXy5QC5QYTbULVlgs/WojIMi7sbp3uqRnja9NfCXvUjkRdoXV2oXSySmGPXYIU8DrP2zxl16zTiNGAQ1OuGwgtivs0JEQyAKv/Vg/6NAMTXUarTyv9m7JJF9ojBcuYJ8V1ZlTmpg0cr3tSUw45uYKdf5TNb3Vylu4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from localhost.localdomain (185.231.240.5) by
 HE1PR0801MB2026.eurprd08.prod.outlook.com (2603:10a6:3:50::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Tue, 7 Aug 2018 15:38:39 +0000
Subject: [PATCH RFC 06/10] fs: Shrink only (SB_ACTIVE|SB_BORN) superblocks
 in super_cache_scan()
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     akpm@linux-foundation.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, viro@zeniv.linux.org.uk,
        darrick.wong@oracle.com, paulmck@linux.vnet.ibm.com,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        hughd@google.com, shuah@kernel.org, robh@kernel.org,
        ulf.hansson@linaro.org, aspriel@gmail.com,
        vivek.gautam@codeaurora.org, robin.murphy@arm.com, joe@perches.com,
        heikki.krogerus@linux.intel.com, ktkhai@virtuozzo.com,
        sfr@canb.auug.org.au, vdavydov.dev@gmail.com, mhocko@suse.com,
        chris@chris-wilson.co.uk, penguin-kernel@I-love.SAKURA.ne.jp,
        aryabinin@virtuozzo.com, willy@infradead.org, ying.huang@intel.com,
        shakeelb@google.com, jbacik@fb.com, mingo@kernel.org,
        mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Date:   Tue, 07 Aug 2018 18:38:36 +0300
Message-ID: <153365631661.19074.12075476211623702890.stgit@localhost.localdomain>
In-Reply-To: <153365347929.19074.12509495712735843805.stgit@localhost.localdomain>
References: <153365347929.19074.12509495712735843805.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: VI1PR0501CA0047.eurprd05.prod.outlook.com
 (2603:10a6:800:60::33) To HE1PR0801MB2026.eurprd08.prod.outlook.com
 (2603:10a6:3:50::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 056f8490-5f05-46c7-fee2-08d5fc7bdafa
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB2026;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2026;3:Ep2J8WJ9cstVkVfzYUct6fQuXh0K+MQaR/vRNrwpDOGF7IY9hgAwvH9kvuTRadeVLVafVBVLofD8x+87LW+W4SLXitAMMhh0uA1gjReWxOmIR/AZ/lFbZNq7R2/Ll/n80/I+BkP6/GVqD2gu7QZfEXdamfmsG6y5Kro+hBS3+cr4yfJqev56fFiqVleR3dIzVSLuw9PFzs8L1iDpXs86iKY/SKH9WgaW6LqVE3QJIR03tdNj+Q8NXt++3+XHGbzE;25:k2PMV37nlw386iO/+KBiciYAp74HxzwctN5AxYSZwF9dmyzM/uGPRFSSUGbWu8IzTtdFP42pKyzmouy8EygTmtVIzBIlj0SJNNl3e9CtSASxiXfNYiWoQsoFg4Cbg2Oq0FcT7eSHBRYencfCdbmEvd009OtrzRiXJrF+SIc/LUKvfbvqebkwE/Xg2Ysv6WCfesw2Gq65SO/IkL/5TXMrKhJySqucdFGG00UrQrEQrFTFZ/yujdfLTkAPlOsX2eVRqbxZyTRFwTfw8jh0v/CSFJQwjkMFbVcmjRW6SFkrw7wb769bfDg+fL8o6uE4CtAftagsnV5lzYqRLw42UhzhAQ==;31:rg/q8LmsdKDM/JgXMcQWzdK9u0Oh0au0/wbPRyNkTJbkqK8pk8KdfYWqWpCfmJr6cPduWJTSc8DDmoao/N3/8KKDm2OFhopEUXVNdik5B1BJsmqI8Og/DO/44saemtf8E+wAQX/t6IKVBu1HQ5WZO3RiUqHwATgIoF7vi91FhNTY0ifbSZKB+OA8Uyt8EWB64EzrCTpfpO8NHSJ3L+0N/W3ZygVPmLBybHBez3yXZvM=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB2026:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2026;20:ui+ZNGRgz5CluGPYaL/rdd64PzcWJ2StIj0oJc8Zr+s41GqADXsCSK1p85U4QiJCQXd+98zR2ef3ETbzN8Sv8G9BcyOzzjMZCh7OWaQRRKeCoLv25LrD3nk38kZCcP70HQsOxyiaZWopkgbrZ6+q4p40nNet92ygrfBaIrwSUGgL/f9yjfEhSOG0Pq7ceB76mxYl2A9DZIMq2mDNsfGs4l00CoVhfeRnvJGPYVAxlv9HRMwKn7M0V7C/UXKRV5m7Y0MIGjhQutMbUG02kBAcT7ZG6TY1VSqNjX51QziJiZ8Vr/RrUkU95rfB/dROz5+8/JcASAWlD4necYwD38HRPu/FaF7x6R660Gcqq+9wAfBU4AwdevmN/JAxaIxI18H5PkDxcENIGGeQhVAxeUyuf1Od3//kf2LNFZqKtGc71L+s46VC7hw1MTqFxVD3/NRQQmRNXuTX9JG9Ryr/Ym6Tfq0tHW4nDmhYCqJggVqox+PIoxgrlJ0QLNvCilPIDBof;4:TnDtMZqUN3B1lhd6NSFHVvabknAfxBAU1c2eSGk9eD/8NmHA2NAXDAMcLBoFXUYoVnFtEv+nwXDHZo1xPG+o8p6gPEhTnNlkB8ZqDT3UjONB8j5DfvjDmWTAw0x0u8mR8cw/Rv5ClP1S+s+pLCFzEJxCVu2w2S9z1z9uF4jjgveOyJTpY94BAWVR/QNuHc9VPbqqLp96sz+hrCATe4wn/FJDoEv1dZvinvSxTQBggB43XwK3PAMC21OljiL14GNO5G7Sm4VRLjK/0VhovaBcdQ==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB20264494E190C394BE90EA6CCD270@HE1PR0801MB2026.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:HE1PR0801MB2026;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB2026;
X-Forefront-PRVS: 0757EEBDCA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(366004)(346002)(376002)(136003)(396003)(39850400004)(189003)(199004)(386003)(2906002)(6506007)(39060400002)(478600001)(58126008)(26005)(5660300001)(53936002)(305945005)(68736007)(476003)(7416002)(186003)(7736002)(7406005)(16526019)(11346002)(33896004)(50466002)(956004)(486006)(86362001)(446003)(106356001)(230700001)(25786009)(66066001)(52116002)(47776003)(14444005)(7696005)(55016002)(105586002)(23676004)(2486003)(6116002)(3846002)(97736004)(76176011)(61506002)(6666003)(316002)(103116003)(81156014)(9686003)(8936002)(217873002)(81166006)(8676002)(83133001)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB2026;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjIwMjY7MjM6L0NmNXJRZVJxUWc5U2pWWnJvb1ZoZXYv?=
 =?utf-8?B?aCtuOEFJUTRnMWJybjVBQVVxZWkrNFczM3Y3RDVzRzBuY1BNNkhXTEhDMjFZ?=
 =?utf-8?B?dTBwVFJSc2IyTlVXYmJ5eVU0cTVoR1JkMHRabWFtaVRnMGtlV25IdUJ5Qk5X?=
 =?utf-8?B?b2c3WkZJRnA1WGJDWG81VnpvcVdlOGhBWmQ3YXBma1dFV0hlVUdxSlpsdE4z?=
 =?utf-8?B?S3U3Z21tdzZKUmN2SktHenRMYlFmb3A3d2J0WDVGOGRkUHFra1NhU1ozSUFJ?=
 =?utf-8?B?c3VWS0g1UlZ3S0N0VlNEUm5lWTFzT3BWakNrK3pkWHJsL0ZONE11cXAwaWVZ?=
 =?utf-8?B?VTVwelJZdGRvUGR3MFc3NFkrNW1XTUttVnhDblo1aHNTUTZaeTVpaFVZL1dW?=
 =?utf-8?B?TGRybFNQUjZoKzV2SWdmV2F3TkxqT3E3UDlzREFSOGNmNU5kK291cnZpVC9T?=
 =?utf-8?B?L0ptZ0NVUWR5dkxUL3FQZkR1QWJaOUt2WHBLVHJQVm9PVlMrU3F1ZkdmampY?=
 =?utf-8?B?WC9pYkVkNnpOaGtLdHVrZTl5TkVadGZGOElnTWV2alMwWHp4L245UnkzRHVJ?=
 =?utf-8?B?Yk1RUVhZYVZpZWtFdVZTckFLdk5kcXFxSUZBRTdXdk9RRmZkNDRqSEl2dlpi?=
 =?utf-8?B?aEFaTmVkOFI5UHM1QWJWVTVvSTIzYXN5M3ZFRURnakQ4NVJnS3FFMFhpQ25Z?=
 =?utf-8?B?WHlwQi82SDZDY25LcGZIcUJPN0g3K3owZzV5R2NNWE9GM3dSQ2l4VzNkTGZq?=
 =?utf-8?B?ZytEOU5EWWZiZmJxWlBlRjR1N1VrUHluNFc0TDFLd2tzT24xMi9CUGZEc0xw?=
 =?utf-8?B?YlRjNVg1M1d0blYyUlFRRnNyOEhEdFE5bkhmWnpPNUY0QzEyZ1RvS2VtV0tm?=
 =?utf-8?B?ZWNnYXAyenBhSXVESEhwbVJJbjlTUW5QV2RYK1Z5TGMrTW5XNzErVks4U2pz?=
 =?utf-8?B?NndqMjdkV293ZjVGSkx6QjRrTWR0a2xEaTduN1Uyb2xNdWJaTXdmYk9lM2NR?=
 =?utf-8?B?M3pEdmlCZWJ3RnBDWVVFZEFlcG1tdHlSdWVWSStIeFF4dlBrbWl1SEVNd2Jm?=
 =?utf-8?B?MERGdG5IK2J0UmcvTGJXbzVkV3F2NUZFSWk3UzdwYzFzNi9VSW1QNGpMSm9K?=
 =?utf-8?B?b014YnhVeVVqaFBBa1BuTEd1emtEL2FBeU4rZWlCMUVRVmtSNUVsYlhRTHhU?=
 =?utf-8?B?VTZiN2dUWkJpcmEwVUFFTm12L0RRdUk4K3hXR2tzWmRqZysyMmoraDgzVXI3?=
 =?utf-8?B?cmFxSXRNaUN3YnpPeGlHeDlQdHZ3Um8vekVNTm01ZTFWYnRDM0FVekg0Wkp0?=
 =?utf-8?B?OFlEVFpxQTJoenFtejc4ck84eTE2aTVGaUljdWNiMnVUYnhqeXNxSU50ZWFv?=
 =?utf-8?B?aFBoRmliVzBDQzRoU3ZRNUtuczZON1BWdHJyWWVOTTZJb0ErT25zNnprNU1t?=
 =?utf-8?B?aXg0dUxXbE9XU3BKZDJWR1BpL0Q5MlNpQVR5aTVUUE8wc3FuZjVCTnh3YjN0?=
 =?utf-8?B?dnNpKzYrQ21JWkV4QzFZa0FTYlhoUUtKM1FVSlkwR3RpMXlyZlFpY2srS1Zy?=
 =?utf-8?B?SlhRNTFUU1h1L3d2TnYvT0F4QVFyUFp3b01qT1dMZDdqdjJ5TGZzZTVpNWJx?=
 =?utf-8?B?b0plRmh4V3c3THBSQ3FCWC9XaEZNZjNjelE1MENFQzhNUDNBVFd6RHBoWThZ?=
 =?utf-8?B?VHkwQ0NvbkZDcFd0bUV2V2dlWUtYUkZtTkMzRmVDekc4SzN5Uy9nWTRTNEZF?=
 =?utf-8?B?aVY3M0lnWXJTNUJiazhxeEE1V1lSVWdMQzNsYm93WFZFbGNSblE2SUZ5b3N1?=
 =?utf-8?B?UFdXS2NKMnVqRmN6anJuMlJzd2dTOUdhZHBPZW80YXVaVjhIUT09?=
X-Microsoft-Antispam-Message-Info: gDVhyiA2ZJ9EgzAMvQtiuIEkU3snZMDjixvFsIeVaF+WA0wnh9DYf3BnsLh/IMTzgE9EcC3do2scqP5U2jTe8tt8f5HY1pPcLYgv1wjqs9hcqNOzEjWcAdENjhR9pcTfl1F+bR3Q+kU5q0csmT6j2TESPW5bIL3DptDBIXWXvy0qkhJPe4zwD/aftgZeYNEhxt3mmrOeNK0g7wQF8StTvYzlzmfdImlh4N6wWO0fu5d8u2yCaAW5iqh0faqYgyf0UgtWVGU7gIq33IY4IKqX25b7/nYt/pCwCGykcoDpzLqXrE51uOL3dH0LhiuKjJQ8QqsRyfoad7KyUuGwKu+b+xIA1emiccIJeBXGxWkLq2o=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2026;6:IoV7I4n0KaROAtdb3/hJqgmWNW+RJDR6MR7JQyBkVycZ56+C0BhbwSTv4aX5QtgwvYxED+lOSAkE6gaMJS0nKBSuh3ivhpAFFfuRBQFkR0ihzwNDmf2Dx9eE8CXcL2b4D/jy+rs1mmB13ssDKXdZ7iBn/LSoWKYxFko60eEXtyZVOWgD+mF8Smi5Gt2CAV7kgr03En3c4dnXOKGoe0d0/meHlJpU+sZL3zAJ+lhlepsMsrqi3PYN0oyoz7+XS0U4GL9yxU1Wycu/1YGlzYvn/PA0F+EPbZSBRg8WM9Jpt4+kf6IiXRQUFGMSgDneAyJYno+s7q4hfK+DNNrgdFQ3RFeuRwTcop7+1vlAHMouRLS1qwiPjUm9BmOu/BfOiryloRtu4I39+sJCJUXbyRzGyj4rcDl7gxUNzgHlXA4tLNPGIseyk+zvvAVJPAKAjcIGrZF8WEmGMTJcU5iC3vFKvA==;5:B2o9mc8KPmezlAx3CgCGxIJXqW0GgifaCZxwb8He5momAlqlK5FDRq9Zt0Jiyi7C7rLI2viEJjySQ6YNS824QM8M2xEG7ZLhhgpJYkPUgj1coZX4t1blFKglNCCM0v3yG7VZ5qfhkseRrkBTW7usNY5ffu9Tcatzze/OmC/W2mU=;7:NQkJ8HTTMTtNa54/V7IcTxMCqwHpRlC2Nv0HmOrqQTXKnkSqBKfwK8/TaofGJuMyIAGqzgo/qzILAJcUaD/8x5kdApHTNxUBXQ35sTXGj4jvjc5tskzjjN+L4UAf80TknrBFnSlRErpV8G4CYrAy5vzXS+9e5nCXY8otUYUaVN4RC6Ex7z2usuFuH6oWYullv3nRzrkMephA3lBaL4MFjWfHVBDjQ1GvtSg7vtCV5s1hWyiCVq6dLxVEOiNS05yu
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2026;20:em2/RxsE9Sx2dneLAl/4rA2Bzjcuc7IOmvxmOSmXBP8nDMG5R6q3mZ5D0oRcIGBJZd83ljUI6CZY5ylJpm8BYceaORhxZf7oIkh+8nRDggOMcDovZNevxOcLRL3TJGaN9zbCW46uRcLaCBuMpCF++BMTXOdI0s9RxnkqbLK/IIs=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2018 15:38:39.2227 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 056f8490-5f05-46c7-fee2-08d5fc7bdafa
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB2026
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch prepares superblock shrinker for delayed unregistering.
It makes super_cache_scan() avoid shrinking of not active superblocks.
SB_ACTIVE is used as such the indicator. In case of superblock is not
active, super_cache_scan() just exits with SHRINK_STOP as result.

Note, that SB_ACTIVE is cleared in generic_shutdown_super() and this
is made under s_umount mutex. Function super_cache_scan() also takes
the mutex, so it can't skip this flag cleared.

SB_BORN check is added to super_cache_scan() just for uniformity
with super_cache_count(), while super_cache_count() received SB_ACTIVE
check just for uniformity with super_cache_scan().

After this patch super_cache_scan() becomes to ignore unregistering
superblocks, so this function is OK with splitting unregister_shrinker().
Next patches prepare super_cache_count() to follow this way.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 fs/super.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/super.c b/fs/super.c
index 457834278e37..9222cfc196bf 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -79,6 +79,11 @@ static unsigned long super_cache_scan(struct shrinker *shrink,
 	if (!trylock_super(sb))
 		return SHRINK_STOP;
 
+	if ((sb->s_flags & (SB_BORN|SB_ACTIVE)) != (SB_BORN|SB_ACTIVE)) {
+		freed = SHRINK_STOP;
+		goto unlock;
+	}
+
 	if (sb->s_op->nr_cached_objects)
 		fs_objects = sb->s_op->nr_cached_objects(sb, sc);
 
@@ -110,6 +115,7 @@ static unsigned long super_cache_scan(struct shrinker *shrink,
 		freed += sb->s_op->free_cached_objects(sb, sc);
 	}
 
+unlock:
 	up_read(&sb->s_umount);
 	return freed;
 }
@@ -136,7 +142,7 @@ static unsigned long super_cache_count(struct shrinker *shrink,
 	 * avoid this situation, so do the same here. The memory barrier is
 	 * matched with the one in mount_fs() as we don't hold locks here.
 	 */
-	if (!(sb->s_flags & SB_BORN))
+	if ((sb->s_flags & (SB_BORN|SB_ACTIVE)) != (SB_BORN|SB_ACTIVE))
 		return 0;
 	smp_rmb();
 

