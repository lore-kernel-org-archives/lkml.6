Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD44C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 13:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31E1020652
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 13:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="V+TP611E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31E1020652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbeJOViT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 17:38:19 -0400
Received: from mail-eopbgr60068.outbound.protection.outlook.com ([40.107.6.68]:42577
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726499AbeJOViT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 17:38:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=urlY3hJM1LlAfhl7PYXhnyfzWf3WVQZtpFfDitD/hy4=;
 b=V+TP611EanC53Ej1rjLTQDI66FDd61SY3pR9bgakXaWun+1fGZagUTBKShUvpdepTWRvUpo3GRn+iozxp8zN6kdd6lbcuLZrWn9z2OKb02LZRo3lC+d/aHxZpRZ4gSkXaZ7qT/rbUCFdpJPUf7jwbEX0si8ht914yc1ybRCTLiQ=
Received: from [10.1.196.75] (217.140.106.50) by
 AM0PR08MB3091.eurprd08.prod.outlook.com (2603:10a6:208:5c::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.23; Mon, 15 Oct 2018 13:52:35 +0000
Subject: Re: [PATCH 1/1] iommu/arm-smmu-v3: eliminate a potential memory
 corruption on Hi16xx soc
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     LinuxArm <linuxarm@huawei.com>, nd@arm.com
References: <1539592576-24352-1-git-send-email-thunder.leizhen@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <db0943c2-7a20-d0f9-0a2c-e37b57618761@arm.com>
Date:   Mon, 15 Oct 2018 14:52:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1539592576-24352-1-git-send-email-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [217.140.106.50]
X-ClientProxiedBy: LO2P265CA0357.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::33) To AM0PR08MB3091.eurprd08.prod.outlook.com
 (2603:10a6:208:5c::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eaad23f1-d1c0-4c17-f862-08d632a57669
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3091;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3091;3:B9MAeeqTGQ/uy9CwwiPxHdzxk1aAwCrpmu2e1/CvOECr5YVzoPfNgyP4p4GR+CwmgX1MSqFaU9cTJycjLKzF9vN0eTj1t4ELQ0hSEqRTflHM2RkjvxtuLqkByiEdz3Q88NH2uinq0RZ4pB37ar2mx90imn9VKA38PynqMN1cMeu4kUFxm3mhxpNszgNXW72wivle3m5eHhNzyfo+pEAPIsTJ6omxphu4nyNy3iqGOg8dNgMeWN8GibXIAf5B0eQM;25:nc9kmV7vL557KirIjCgWAT76iIhrkQFRbpjpU5e40/TznWnMLJkoFyQM+UxJ0EUR62YoPY6hhnBFyiuadXZqXacweejudC0oHE3bfPYszjcMOAcrJOXw+ZZDQtErZly2NWVoN9B5P3Clphn7hPvTuIMNRAx6LrtBvEJsrrqjkBCsT4lHfrJpjcmvzLTtdSs22JOum71Thp+F7SYpykX0SKI/iRk9+kST/eD7vKnCsTZYiXhaGpGQmZ281SQ81GoJRlW+au0BVh7N6yuLsSCOx0c55z/IgoqP15MgTbtEGd9wCZPoQE1fP5wYtEFvqA5GeEcPgYN/mnxCrgl/DfG7XA==;31:ScfKYVlB1vqMejixsQq2+R8GGhCWYRVna4mcFxaUlEgTAKg8SsZYBJR/Ad29RyKp0t7k+Pzr6qLoxEYxlj8YnyUDpFbLaKMvfPU+t9Iq9NA178pA0Jr7UDbKsYlmL6A6DclUJzjMJiYs9yk2wvZnwUCsKxiHPUC+6ZPC2RY+Foa0ZtIfexbtBKynopj4DFWVbMlkz26yT/WGiknHBQOfi5UB35ksemOIVM9dSu5R9hs=
X-MS-TrafficTypeDiagnostic: AM0PR08MB3091:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3091;20:k29DcapQi42mRLMSN6v9qzD1BeN59gD8xnKSxFAiTgaBiwyEDVEllCtHdx26isWWdoan1wK0kg7iP3Cd9FEmjE94icBVmcHWwRrR5JzAV9NwUK1+3ouiKSh9qeiF5165FVzmtMwu52J2aR5/lI41+/fDf/Yaysep6AZ9v6cAYOQgzBOGE7CWIaXOyXC+l5JADNvQ6hCjyjyDrnRo6lC6dzw1z3dNJP00L+n6TLm1CnUNouxLxuiED2x7KQxYy9pmwAuIxR75fKMLzyNSMM1osXR0IUdSQBR+XGiC0C0oI7loqIkvVRrAvpKW5cZQDqyGc75kRLmncLDwXdyawETXpAshp6cMvsiM3cFP5W5cNFHeg0XcAAUUayNuL6LHgS5R6HoMCmBoDfuLZisrpTZ09Fs/Y6YdkSpdIVkVvi/SNWI=;4:DZRp3wyyNxZQ/FwwqqnowQfegvMrvtKl+E8WSSCgtlJm0GkATF4iLvq7QcACt/w7DQlNh0d+GHliGKgJneHmKO9Vk1BL13mKh+NxiZZlmfHG7UrPEk5P9+1jCXhoXFWwYNLhH9v21dcZ9NAd1HEOWVO7JKXQf8/amvsKQ/T3eQLM36pzwjIttbt/e4H+0o0TgZ0pT2/HR4bCuimiJ6Mn+4FWVpjvtDBuBy6K7zp9yXHR/dsKsRe7sPK51z3lDWgKzvqd/9XNhmwxbMmkbOJHs5NEAbHeK8rt+0FQeisY8vYTzSTUfJybdqfmCEwlPXyN
X-Microsoft-Antispam-PRVS: <AM0PR08MB3091755CDA29B72F76EF9F1D96FD0@AM0PR08MB3091.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(50582790962513);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(3002001)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991067);SRVR:AM0PR08MB3091;BCL:0;PCL:0;RULEID:;SRVR:AM0PR08MB3091;
X-Forefront-PRVS: 0826B2F01B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(366004)(396003)(136003)(376002)(346002)(189003)(199004)(8676002)(16526019)(186003)(81156014)(81166006)(478600001)(36756003)(6346003)(6246003)(64126003)(16576012)(229853002)(77096007)(6486002)(26005)(53936002)(72206003)(8936002)(486006)(2616005)(11346002)(316002)(4326008)(31686004)(446003)(476003)(106356001)(956004)(575784001)(105586002)(86362001)(31696002)(68736007)(97736004)(44832011)(47776003)(386003)(66066001)(65956001)(65806001)(5660300001)(305945005)(25786009)(67846002)(7736002)(50466002)(3846002)(110136005)(65826007)(76176011)(52116002)(23676004)(2486003)(52146003)(53546011)(58126008)(230700001)(6116002)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3091;H:[10.1.196.75];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Robin.Murphy@arm.com; 
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTBQUjA4TUIzMDkxOzIzOjh4QjcrYjExU0wwYzlIcVgyK3M5QmZ4aXp5?=
 =?utf-8?B?YkJrWVdCeUZBUlh5ZnhnQW1YTGYwS2g0NlZXTWxaRWxheXpySHRNR2NCSm9j?=
 =?utf-8?B?bGxwR3kxQ05pZzR5WklOejR6LzBYK2l3eUkvdjl4U1dMMVVjakY4bnp2cHdH?=
 =?utf-8?B?VzRTelpvYk0rR0hGSkxZcnA4c1pMNGRHdTJsbGszKzQzZEtGa2NtZlhQbW5n?=
 =?utf-8?B?MFpUcW1nWE9xOENEeE1YRUE5ZTNSZTN2eUthbWtUZkpCQ2p3Vm9aSGJKOVJW?=
 =?utf-8?B?OWVYb0RncWI0QzRCVlMxV01hdGVuQXlSME8xRGI0bTZoNno2ZmxuMUVIRVg1?=
 =?utf-8?B?Ni9ERzdDS3NjbTFrVXBVNU51bEs3WkhxZWEvRXpJQmh6SWlhc3BnT0kraE9F?=
 =?utf-8?B?d0I3R2ZWQmJqaEFoT0s2K0FWRVZkeGdDbVpBbTFua1lxNDdXcWNsZ1doa0Qw?=
 =?utf-8?B?SzJFclRHS0JUTHVSOVZ4QXlIQXNwdHBDTW1BTGNFMkhCc0ZZT0pDdzhBTmlq?=
 =?utf-8?B?NFRqNUNBQTZ0TGdWenV6OG80M2I3RGNNQ0QyVmNlUTJyV21LOEpWZVprMW5n?=
 =?utf-8?B?aEFGWDY2Z0UrYVlpRm1SV2F3TyswNHZiS2JUNXc5SmtLN1M4aG44UkRTWlVD?=
 =?utf-8?B?NFZHTWg4R0FDUUtyOWh1VWIwOUtTVkJzRDBncW1PM3lBM01QdDJrMzQ0R0pJ?=
 =?utf-8?B?bVRNdnlHNzZMcEhLTTFveWhBTnZDOG4zaThtd2lZTDlaVyswSkJqSlROK3lY?=
 =?utf-8?B?ZDRuZkVQeDVrb0NxeEpFNVBKdHNrRVd4SitQcDdFUXZiR0cvOWlGVEE3dW9z?=
 =?utf-8?B?cDBxYXczbVBaQzhBdG04TEFUWnFQeUFZZThaQWRibzRtM0dCNTVzdDZONnNi?=
 =?utf-8?B?YysrbEFQc2RoakxGY1lheWlCUDZsdGtJdHRYeEhBVDVJY2J5ckl2d204dEZz?=
 =?utf-8?B?RjVCWDhEODdEZEZJd0pCZDZjUDN1d2l1RWxIT1FZQkoyZ2h1WmVnMTRjMVM4?=
 =?utf-8?B?L1g2QUNoWjZKTENiZGhpU1VHeWlrYjlKT3kvWk53Q1RRb3FBRER6UWJGRjI3?=
 =?utf-8?B?QS96bSs0U2ZjaUZna3prWlVya2VMUXVVWkpIaWFHcEhtSXU2VGF6R1JhRnBY?=
 =?utf-8?B?UWNHdTFNREdLdDdlblJBcDdudDVQVWFnaDhWcmZ1S0F3UXZhZXl0SmZMdmtO?=
 =?utf-8?B?YXJ1SFNteFI2WDBlU3A3a01XRmNuUkxJUzYxZmRqcmhJUjZiNDk2YVh5L3ps?=
 =?utf-8?B?dURTYm9KUmN1aUw2Mi90WEliWkszbW93RUJ5LzEvV281N3YxYUNiU09UVlRB?=
 =?utf-8?B?N0J0a3dMcTRBQ2NzdXJiZkM3L3p4MXlPS0FhVnRwSGRiNVdwdHNXM0hxYkc2?=
 =?utf-8?B?SW81MWhZL0VaUHY4bDkvZ0pmcWtocXFneWp6N0g3NDgxTE5URWlzb2hqTFlp?=
 =?utf-8?B?V29BVCtpZHlhVzBUcmhkOTdVdVBXVUpIeFhES1Q2N2JsZnBOc2FZTzlOaEdp?=
 =?utf-8?B?eTVsdHdYUVJoK25xYlZqc3ozcEY4bmRRdEhVRTJRZXFUZDZ0cjM0VDlyWW12?=
 =?utf-8?B?QWE1T3loaGxGVE1sbmNkekJMdkpNSlJUZGNxVlBZanpBM2J3ZkdjM2NHUnIz?=
 =?utf-8?B?K05TTlR2MWU0WlJKd21lOG9lM3dHZzZrNGIyd2dubXoycEcrRjV0VXdpblND?=
 =?utf-8?B?eGs3ZjZyVVM2dEJ1NG9UTWp5L2xSUjFWUnVDOVZDODRPMnlPKzcxRHFOMWE0?=
 =?utf-8?B?Z3p3emJSQkdQaWZFTjBkZml4L2w4b0lLWjZNb3dHSk95TlVsazUvLytlMTFa?=
 =?utf-8?B?NVAwUlJ4ZWpYYXI1UXVuRUtRTCtaQWQzL1RLQ1haZDBRUS9MNng2VTZOMW5O?=
 =?utf-8?B?OFVSNUtYQXNLdEZnMDdUdnk0Rlg3Z0tZSk1ORWN6TTNRWG05dmNnVE9QZURx?=
 =?utf-8?B?bGxYV2toY1grS1V0RGthdUhMRGoySE5LNzAyQ0RMTjR4Y1IrMGZWU3VXSU9w?=
 =?utf-8?B?RUtsdFNVaVNjMzBrSjBKWlAzYXdaMmcwMUZMZz09?=
X-Microsoft-Antispam-Message-Info: I0OofwcOy8Z+SOu2llfBi/Dugr5iHkEFiXlS2Fcqc/B3692KSpNwB9omfnhzkOZo1yRBmAiw0j/6w0e53kYHRjgQW1foQAQ8vWGk/9v5qsudJsHkoGo8MXxiHVLE3ycGtNbjkvJVst92KJvxOwYjniDJiHGrG+XkVlgkFRRkrhqgmwzhQZIvM73TAsL4N+PpdMlUkgv4fNdcxn2z2Ztvl0zYdvKsuLAzQgUetuICeIEZ+mavRv3gvpqV8UxLSg/PaRSAJ5FZ0PfqeBEh4gK+7qm91iIgA8AXoADOGP/4eSXegtSE0oxidMfmyKD/pQiW7BzdmHYgNQreLWnOLuU52mBb39b8gbaRgil4rmYqdJQ=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR08MB3091;6:3I9J7c0TnGMsxVPTkhdYFhQAq3ZNzDWaoMjmKDEEOsCPJtWjjCd7/Ap1/HR8DYP18jy4Ij+fmbU7Oi6OBlsevfV52GlY1qC72AZywuoTzH9e0nzvR0AyWyqhyZbhV0/Qdc0ovR0Euz1ENQYhArejuB3LswjEAtgexvvCm4OYNkKMKEh1LWIEUWRlDHCH034xegO5qf1PtPTgXovTQ9vNTRKTeViRqy32fE3GkfkP5+awrbofxnpnVPrUvC9oswhWsq+8xKsSCKcToOnHOx5Zm2WwAUvPUp9z9ghA6f3azTOHPNT0qZuAa7Q+JY/qN2sE/uMs9JP1BqgJlJDAmNjKEHIlWG4G7G/aK3flmwddAsuOSr+YKwFKj8XSglSm+7WUybg8lpDOW7BD1h0SeEruXLNjTsNeLme4hdzMHDQeI6DQWBbAmHNPm32IqP8VzvNBDTW4uDL7yiavD7LuAiPrWQ==;5:H+zJwlcEhUsQZpXygqaLYc+ulWbyazxivaYMES4u/7AYqyFT2gdxwvwIRku0AjhHIbUnYNNMOdHaEmE9e5c1oDkCgzOwWiDvyhjxnf2Sm8W67L4+WcKE6EjGKBawPuFkdcf/iVGIMtUm2tStG5IfZ3mFXyM2JTefnH1cbVxBDPI=;7:Kx7d4s8Ca13KG5qVZJbEgQDiLH2HlAG3qOf1VLZMpsKkGtq7yNo+FyYfyVxi32I1dPsn1kW9trry0dED3DwCZ/df0AFXPGJWWG7CQMGFR9mGvF7eGHLryUDhZakll1CsUVvwwbarBd+SC+/JTC6eCKycrSCX4bK4NpUO6to3iBjjUPjqgNVK+C3pRe7LNWuAhVZFo2JX781iQ+61pl8stPvOAwZqkm5FacmD7Q3xA7EWMJzCkrbDBnx12wO3R0LY
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2018 13:52:35.5434 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eaad23f1-d1c0-4c17-f862-08d632a57669
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3091
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/10/18 09:36, Zhen Lei wrote:
> ITS translation register map:
> 0x0000-0x003C	Reserved
> 0x0040		GITS_TRANSLATER
> 0x0044-0xFFFC	Reserved
> 
> The standard GITS_TRANSLATER register in ITS is only 4 bytes, but Hisilicon
> expands the next 4 bytes to carry some IMPDEF information. That means, 8 bytes
> data will be written to MSIAddress each time.
> 
> MSIAddr: |----4bytes----|----4bytes----|
> 	 |    MSIData   |    IMPDEF    |
> 
> There is no problem for ITS, because the next 4 bytes space is reserved in ITS.
> But it will overwrite the 4 bytes memory following "sync_count". It's very
> luckly that the previous and the next neighbour of "sync_count" are both aligned
> by 8 bytes, so no problem is met now.
> 
> It's good to explicitly add a workaround:
> 1. Add gcc __attribute__((aligned(8))) to make sure that "sync_count" is always
>     aligned by 8 bytes.
> 2. Add a "u64" union member to make sure the 4 bytes padding is always exist.

Surely the u64 member inherently makes the union, and thus the u32 
member as well, 64-bit-aligned anyway?

Robin.

> There is no functional change.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>   drivers/iommu/arm-smmu-v3.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 5059d09..a07bc0d 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -586,7 +586,10 @@ struct arm_smmu_device {
>   
>   	struct arm_smmu_strtab_cfg	strtab_cfg;
>   
> +	union {
> +	u64				padding; /* workaround for Hisilicon */
>   	u32				sync_count;
> +	} __attribute__((aligned(8)));
>   
>   	/* IOMMU core code handle */
>   	struct iommu_device		iommu;
> 
