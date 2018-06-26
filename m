Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 322F2C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 11:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5409026A10
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 11:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="wHZu4QEZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5409026A10
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934942AbeFZLyT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 07:54:19 -0400
Received: from mail-he1eur01on0122.outbound.protection.outlook.com ([104.47.0.122]:45072
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934063AbeFZLyN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 07:54:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EYNEeWvTCTzEs44JKADwB6Wr3aUvpqgap6bI3C/7yOg=;
 b=wHZu4QEZMjBLfskDU2INI2wrfeh2QJ8CTgPpbIvBG8pXwL/1gWIR0H6ATpedbE6cH+BHGyuALbmcmARylF2PrY7BHmggbwZLYCKRF7blM2Zh0SZCKgZwuIqB5RtOlBIUjnvvxN7h8hIBuy028uOAuHPtUPZ6pLVWQpg38NLNSy0=
Received: from host-90-235-16-91.mobileonline.telia.com (90.235.16.91) by
 AM5PR0201MB2452.eurprd02.prod.outlook.com (2603:10a6:203:35::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.884.23; Tue, 26 Jun
 2018 11:54:08 +0000
Date:   Tue, 26 Jun 2018 13:54:01 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <20180626023757.l54suaryim2fieq3@ninjato>
References: <20180620085157.30121-1-peda@axentia.se> <20180620085157.30121-2-peda@axentia.se> <20180626023757.l54suaryim2fieq3@ninjato>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/5] i2c: smbus: add unlocked __i2c_smbus_xfer variant
To:     Wolfram Sang <wsa@the-dreams.de>
CC:     linux-kernel@vger.kernel.org,
        Vadim Pasternak <vadimp@mellanox.com>,
        Michael Shych <michaelsh@mellanox.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org
From:   Peter Rosin <peda@axentia.se>
Message-ID: <79E4A06C-26EF-4FF4-AFEA-7E7769FDF995@axentia.se>
X-Originating-IP: [90.235.16.91]
X-ClientProxiedBy: HE1PR06CA0139.eurprd06.prod.outlook.com
 (2603:10a6:7:16::26) To AM5PR0201MB2452.eurprd02.prod.outlook.com
 (2603:10a6:203:35::9)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ca5c4d9-53a0-4c59-4b43-08d5db5b8639
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(8989117)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:AM5PR0201MB2452;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2452;3:02EqG8Wx1MjupzOHm1n7NHGQiijh+FQcDanmZ8bbsDCzzWJXP7bS1Nd3Txk7mizT+IxOk86fUM4r8qmtFo5xy6eRJm/ZVqMOLswVpUSAWiUNyKJqzg9wXPns9ElnNFIptyMDA7xneto0cmrxYZbUKlo1C3W/gNlzJInqKBnkLrY3IoEzVwm6dXgFIF6JS5Me5c9HICP7yFWK8/5zL6GpUv17ew1G/ZH4NwMgvcbFIKxbNsCRZb4Ge+J4xY9fNAc4;25:MWHQb843dKDzak+Tc6lOKdIEdzNL/qWfXZZ2IKXX0ASib+BzAaeboh4jz/mVnhAYdZWiwSImMXwC9pjQMH8MW0lotjfyCOPH9yRJAoPr3cILhqnfYnaJlj9OOSgsrEUnvuEvbLeT3QERYOgxkH8eBoanw9EmZKTKMeecV0sHGcEmpyeD2IjRvbXri0eOWpxTrMUoRl7HSSD2CdU9/VDYeX1s9D6tDowgOFrMnwENPdteBthHQh5Fk3Ouv+cYeVcVEfKTWNwTP+KVjnlT9baShowlJ1BdC49HF/OOLltXLuo2QCabyCv3wjkJ351ew9DfIYYHDB8PUwmlrrgEsMWBtw==;31:Zcj9624z63V97iKL63xM5lqc6NbcWfjXp7GYilk16HsD39pvIcY+XyxEFxP+LJ9KYyAVBv0VMLao5Vp3z1TaKaFZdt4JvVTc2u/lqUMgPhXNbc9ghgy0Bv4FwTDAOZgKSARYkQrLabVrr85PDo817StIqdtYV67HYtMn2rwgI2gjHATTaCRPKy0D9kMcWhkL4WXaKRpgV4ALN2Zaxd+xZfrVY/jOLbEUzhmFKEo6Imk=
X-MS-TrafficTypeDiagnostic: AM5PR0201MB2452:
X-Microsoft-Antispam-PRVS: <AM5PR0201MB245283D1F4A2839175EEA88BBC490@AM5PR0201MB2452.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(2016111802025)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(6043046)(6072148)(201708071742011)(7699016);SRVR:AM5PR0201MB2452;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0201MB2452;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2452;4:giNaimGOz0N5GzEuoAwX8TV8H5tIjC9fzXuN4O7VpSJBY0CyV/EvtS87zbw+DiG33zMjN4I5vWkgpfvkxwS+WPjdZ4Dh9vhcLQ242s/S1Cv5ZgBXeIhx4s/MGgx7qFa/XAIsbgnDVGNLdBNIrfR8wWPjo8I3M4G2EKdr3BEVYAPg1V6bdDkIfRPz3jBjbIBrSM5nuHowwNClgPnsCXhwK5MMOPQdiOkHAVeOi5et/XS4plI6syz9HzBwW1TGHGTxmofPt6qT0UEmHGDY7z7RuA==
X-Forefront-PRVS: 071518EF63
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(979002)(366004)(396003)(136003)(346002)(39830400003)(376002)(199004)(189003)(81156014)(478600001)(53936002)(6486002)(81166006)(229853002)(8676002)(8746002)(8936002)(386003)(15760500003)(86362001)(316002)(36756003)(54906003)(2906002)(6246003)(25786009)(4326008)(83716003)(58126008)(6512007)(39060400002)(6506007)(68736007)(105586002)(50466002)(97736004)(2486003)(82746002)(106356001)(486006)(476003)(33656002)(2616005)(74482002)(11346002)(26005)(7736002)(6346003)(446003)(66066001)(6916009)(305945005)(186003)(47776003)(5660300001)(6666003)(76176011)(16526019)(52146003)(956004)(52116002)(6116002)(3846002)(23676004)(70780200001)(80456001)(42262002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0201MB2452;H:host-90-235-16-91.mobileonline.telia.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:3;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjAyMDFNQjI0NTI7MjM6czRYaHprNlpiOU55SWQ0dmQyRjA5V0J1?=
 =?utf-8?B?VlJXQWtkRjFWQkI1d2tVT2RxVFJoRk9TVlNVRUpCbFZLR01rS0tjTDlXenkw?=
 =?utf-8?B?K05ySXQ5WDFEVDV0eXhqUDhqWEdNaWFHaGNqUk5tR2xVaVY1azZJeGhZbjdI?=
 =?utf-8?B?VUpCWTJ1SVhHbThNajgyYWowVzRuSnVYTG1IZkVBODNoaU1tVU9GUDNvM0NZ?=
 =?utf-8?B?bjd5QVhvMHNqV2NJOG40QklESmw2dFB3Z0NaMGhaTmR0cTFscmF2UzJqMFF1?=
 =?utf-8?B?VGxmWUlVSkRJV2lwamFoc3V5dVY2ZTlLeXF4SWNuNkJvUUI3Z2Q5Z2d3WjRt?=
 =?utf-8?B?RUpXTGFDdnhkeWM0d2c1SjduNjIrVy9IM1VhZjVxYkU0eHpzb256ZjFKbjhO?=
 =?utf-8?B?c0pxQlgvNDFjV3BDVmhPNVdaMFVWeDdhVCs4NUtuK3ZSS3FrdmJ5TmEzUTha?=
 =?utf-8?B?cjl6Y3VrMUZDb3NTNFg2aDZhODU1TkV2cytyeVNUSUFTNHJtYytLSHFEbmF5?=
 =?utf-8?B?dXRNSWJwMzFpNG8xbldjWW5UeXlQVnhKVWNFL3JyZHFsUjFSRXp0UXNES2Qz?=
 =?utf-8?B?ODFhMWgzWkFPcEtqbnVlZy8yYjd2OXorOTJ0Y3NCV3poUXZ3MHB1TmQ2M2hQ?=
 =?utf-8?B?Wk5Wd0k3NW40R1JpNjdFbXVrY1BhbTMzMm5iQjVoV2RrN3Q2YmJjUlBxV0NC?=
 =?utf-8?B?YWhHMW9LNnZJYVpITnJ1Tk51Q1VFODQ2cWFzQ2x1Nm1tN1FnYlRHbUZvaStZ?=
 =?utf-8?B?Mkl2RVEwQ1E2SmdoeWtrSWxlZnA2MTNwOTVvdWxUWS84TzJCVlVHUlBsVWpw?=
 =?utf-8?B?RngrMjlraVpWWHRneHQ2TFBBUmlkYWRrN21FM0tpWW1nRXlQdW53NlJSTyt2?=
 =?utf-8?B?OGNtR2p4elBrdUhPMEdSZ1F2a2FOY1REd0srQndvQUJIVytpM2l2dkNVckpy?=
 =?utf-8?B?Q3ZoV05DLy9NRUNPbmYvRnllcktnTFl3bWVpRWRiQjZXNVZjc1FWajg4L3R4?=
 =?utf-8?B?bi9SYTNzS2E4Vlg4d0IwbGdjdGpYOUpncElPMjlNbDM3NXJiU2wvRmtRazJk?=
 =?utf-8?B?U3hWRFQ1RWh1T0R2a016SUdOVHE2Z0VDQmNLeWk1dnlFUm1GbjFNU3ZrK3JG?=
 =?utf-8?B?bmFLSFREQ0s0d2EyblhZRnF6S1hkbnRVRHB6TmY0YjhjMG9vbFc0ZXlldTZB?=
 =?utf-8?B?UlJQbTE1RTJpUFNoL2ZoL0x6VXFiTmsyajh5T2xrTk1Fb1Q2VXBKV2lxU3dr?=
 =?utf-8?B?UFZ4VlI5YTJSK0NTMHJaNC9COGR2OTJTdVZ6LzJpOG9wWEhydkpSYXBOSjhY?=
 =?utf-8?B?ODZQMTFWZkFHZmZncUs2RXJwSXl4Tk9kWVJ5OWZZbmlWRjZQMTBLckdkN0hi?=
 =?utf-8?B?eUlJTkwzbXlOWmpJYmd4V1ErT01oM2x1U3F1MWYzenRRTkxIUytFUHBDUFlK?=
 =?utf-8?B?dTE4azMwMFpVNW1USW9wcFlMVENSNktFeXhGd1I4Nms1QStMOEdPclZHdElI?=
 =?utf-8?B?VDdaMjBJT0t6QzNLbTdEeEFPYlJLWWZDZXFSZjRWeXJYeHhiOXZzS212SE5j?=
 =?utf-8?B?ZWJQWENhL3RuSzlreVRQOHpSeEtKNHE3VUlBM2l0Z2ZHMEpIZ2lRQ2Y3bDhQ?=
 =?utf-8?B?TDJSZzZaTkNvTjJ6eHFHWUt6eVlDOTV5WnFJdW5iUlVQQysvZGRYVnFaeFVH?=
 =?utf-8?B?NVpsZFNqdXJkbW5lL0pvSEhheFV6blp2TUN3ak8rK2FjbC9vMW14QmZRUnlB?=
 =?utf-8?B?Z1BXcVQ2MkNhUkxITFE2Vk5yVlVpOW9BUG1kcExzVzhzdCs2SFl4SUYxZk5V?=
 =?utf-8?B?dmhHa3RLaFB6RTMzMkFlUHFZdzlVOTZ1U3lXT2t3MkhiOTJyVGs2T3Fnd3J4?=
 =?utf-8?B?U3d4QzRrcmF3NldPVTBUTkhPdkNCTmRwR0VybC9PakNFdWJJbHAvOFBDUEsy?=
 =?utf-8?B?UFlJcVlvV2RUMUlwZi9QV0UwY2dMaDdEVXYxK09hc1UvRENvdUpTekVlM0E4?=
 =?utf-8?B?Vnd6QTRPZE1uTHd0SWptZXM2SmdiQnlKdDB0RHlXSlNkV2VBMFBpbHBPMDFy?=
 =?utf-8?B?ZXl2d25YREdmTXY3WkROUThkdU0vR2ZNRGwzM3E0TU82NXMzeUhLZnBvZzlB?=
 =?utf-8?Q?KWE0kz22Jp1FeIY2ki2a3cpkY=3D?=
X-Microsoft-Antispam-Message-Info: 2Ph6I3TRBEm4BPv+PYuRabrWXIUEAuACcSd7iY3crOUVVaLfgUJ8nx7zSw9b4sQk9Xw2gzN5WWfdVmUKfXOmTyJNcW3xG2aXu+HuCxcgm4pUlRxjyY6BzeHSgXnp04VID6ZzQEh+/tt2plJrpBd1MhAkVJXG0NEqV4LMoyv/YUeO1Zshj6lRmcxfD6m5XkNA2b9m+tTyO94DnL3NnvZy/YW1BwryACCRQSfvL0ImE9zsEbOQ11Wrb84nz8EuuUIXMmzmsIX6U/UT+PbsMo5oTSTqy7sJ47Q8ms7tbkVrCSDapK+yGK3ysotu9/yOVy94Riec19ZvJLofs/Yd1CfTwZGMCd4t/X22PXUdwoTSF5o=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2452;6:dCUljTSkSV+G8iHDsShDsorLnw2txyfy9k4YtZbEyTXAtFZbPE/WNgeHOq0Qkx8RvOW88AMArG69ovNA1WieWTwtcUMbY4eTzk1dsXxSzbNkPfPsJsVazj6dNu5K/ic/RUMA9gYBdYq1rlbL53FOmBb7VZRCZT8ZR2ROxTJhValpwAnUjO7HLpnKQJyrWZCJyN/TNjXNAS5tTKzq91er8MiyH+JkQ9cWIUJ7iTlEFHFY7tH0tQKL3PT8wCM/0waMjnldiGkgTkK3uGYpf1BM0LBoev20QS76B3lNbPy55bEz86QCwwqHIOGl+Cltq8up7mPp6+wrHcoBACPIZSrdWmXg1z8+hXZmiJTv3BOssBNZlcNk2FBV3N77kI58FjdT09L509L4PRJ/lyyFSuo6gLqv6UUci/856YS2249GdQAHLuVEZnDEjLnSPmOr2v/QbmeQjUb/Rc0Zhm0vbE4Diw==;5:OMdCaQGVrCoZ/w1wzhJLZl5La++avYA0RDVqRiMR19bTSs9igQu+44Hq2mTal25PgcXNIVkfAEnbhTtawOML61hReHk5Rqk2lb9PsPSb0Q+9+kdUGru5ZubmH3DREZpyGcaTxqxDyWXwmFO7e6cmdujqzJ/6HYF3YW5bi8eP6qk=;24:42WJDCDEZ1GzkWsBbKfb7OU3n/Di0Elgwds6hF9jpbG5zF1V/EIYB0N4E1P6nIqnjQLC1dnwVAL3f0D8VWCU7ATC4K7TYifsabjlb95I+gA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2452;7:oc3Ao2/pOOxfBUy1RGKLfPWP2PJ+ZSa6ZFlYOV7x2BDeVuBmYDJcbhZh5t1QnjHydIBIrpIZ0uKIq4GCPm4LbYatlAsxHc6F6jLBwItiXF7TS0izrsVAS7nkn3gMAno+Fxzeisu+QExdFfBYtuPJYA0L0/6OQMO4EqmuffsrSeRI51eNnzLM6bv0lr8pm2B8FmFCmRY3LAufJVUiILgbp4XE/Ikom0bHaRFMtTee3q60zCjUUBAHogoViXaRSQsm
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2018 11:54:08.0189 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ca5c4d9-53a0-4c59-4b43-08d5db5b8639
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0201MB2452
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On June 26, 2018 4:37:58 AM GMT+02:00, Wolfram Sang <wsa@the-dreams=2Ede> w=
rote:
>
>> This is not perfectly equivalent, since i2c_smbus_xfer was callable
>from
>> atomic/irq context if you happened to end up emulating SMBus with an
>I2C
>> transfer, and that is no longer the case with this patch=2E It is
>unknown
>> (to me) if anything depends on that quirk, but it seems fragile
>enough to
>> simply break those cases and require them to call i2c_transfer
>directly
>> instead=2E
>
>Couldn't we just add the same trylock-code path here as well? I always
>wondered why I2C and SMBus were not in sync when it came to that=2E Yet,
>I
>didn't want to change the code for no reason, but it seems we now have
>one?
>
>Rest of the series looks good to me, very nice diffstat!

I don't think it's that easy as I just thought about another problem with =
lifting the locking from the emulation function=2E It calls kzalloc(=2E=2E=
=2E, GFP_KERNEL), at least in some cases, and that's not a very good idea f=
rom atomic/irq context=2E=2E=2E

Cheers,
Peter
