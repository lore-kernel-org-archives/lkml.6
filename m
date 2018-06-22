Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 704FFC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19B65246F4
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YGkPrLxj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19B65246F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934186AbeFVRwp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 13:52:45 -0400
Received: from mail-sn1nam01on0051.outbound.protection.outlook.com ([104.47.32.51]:52544
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933285AbeFVRwn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 13:52:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CcEidiBK45MtDOj4nJU1rOmRmKGy6zzb7/4Q+i0mthE=;
 b=YGkPrLxjEeAwxhsFRLufhedD0CkL4luN+fRs0tCn4qbC69qMrSv4EimD6BF7yOgRTzXOAct07QDXJNaWJ8SRbupg5Vkih+tvrJ3YmJO7JlIb1Jeq7IvVEotPYa9JrL99yO6KJlrDd7wSficsbH+b426hI7VlKQanv8fNdimJ//k=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Harry.Wentland@amd.com; 
Received: from [172.29.157.77] (165.204.55.250) by
 SN1PR12MB0190.namprd12.prod.outlook.com (2a01:111:e400:5144::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.19; Fri, 22 Jun
 2018 17:52:32 +0000
Subject: Re: [PATCH] drm/amdgpu: Count disabled CRTCs in commit tail earlier
To:     Lyude Paul <lyude@redhat.com>, amd-gfx@lists.freedesktop.org
Cc:     =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Tony Cheng <Tony.Cheng@amd.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        Shirish S <shirish.s@amd.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20180621204832.22448-1-lyude@redhat.com>
From:   Harry Wentland <harry.wentland@amd.com>
Openpgp: preference=signencrypt
Autocrypt: addr=harry.wentland@amd.com; prefer-encrypt=mutual; keydata=
 xsBNBFhb4C8BCADhHHUNoBQ7K7LupCP0FsUb443Vuqq+dH0uo4A3lnPkMF6FJmGcJ9Sbx1C6
 cd4PbVAaTFZUEmjqfpm+wCRBe11eF55hW3GJ273wvfH69Q/zmAxwO8yk+i5ZWWl8Hns5h69K
 D9QURHLpXxrcwnfHFah0DwV23TrD1KGB7vowCZyJOw93U/GzAlXKESy0FM7ZOYIJH83X7qhh
 Q9KX94iTEYTeH86Wy8hwHtqM6ySviwEz0g+UegpG8ebbz0w3b5QmdKCAg+eZTmBekP5o77YE
 BKqR+Miiwo9+tzm2N5GiF9HDeI2pVe/egOLa5UcmsgdF4Y5FKoMnBbAHNaA6Fev8PHlNABEB
 AAHNJ0hhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPsLAdwQTAQgAIQUC
 WFvgLwIbAwULCQgHAgYVCAkKCwIEFgIDAQIeAQIXgAAKCRAtWBXJjBS24xUlCAC9MqAlIbZO
 /a37s41h+MQ+D20C6/hVErWO+RA06nA+jFDPUWrDJKYdn6EDQWdLY3ATeAq3X8GIeOTXGrPD
 b2OXD6kOViW/RNvlXdrIsnIDacdr39aoAlY1b+bhTzZVz4pto4l+K1PZb5jlMgTk/ks9HesL
 RfYVq5wOy3qIpocdjdlXnSUKn0WOkGBBd8Nv3o0OI18tiJ1S/QwLBBfZoVvfGinoB2p4j/wO
 kJxpi3F9TaOtLGcdrgfghg31Fb48DP+6kodZ4ircerp4hyAp0U2iKtsrQ/sVWR4mbe3eTfcn
 YjBxGd2JOVdNQZa2VTNf9GshIDMD8IIQK6jN0LfY8Py2zsBNBFhb4C8BCAC/0KWY3pIbU2cy
 i7GMj3gqB6h0jGqRuMpMRoSNDoAUIuSh17w+bawuOF6XZPdK3D4lC9cOXMwP3aP9tTJOori2
 8vMH8KW9jp9lAYnGWYhSqLdjzIACquMqi96EBtawJDct1e9pVgp+d4JXHlgIrl11ITJo8rCP
 dEqjro2bCBWxijsIncdCzMjf57+nR7u86SBtGSFcXKapS7YJeWcvM6MzFYgIkxHxxBDvBBvm
 U2/mAXiL72kwmlV1BNrabQxX2UnIb3xt3UovYJehrnDUMdYjxJgSPRBx27wQ/D05xAlhkmmL
 FJ01ZYc412CRCC6gjgFPfUi2y7YJTrQHS79WSyANABEBAAHCwF8EGAEIAAkFAlhb4C8CGwwA
 CgkQLVgVyYwUtuM72Qf+J6JOQ/27pWf5Ulde9GS0BigA1kV9CNfIq396TgvQzeyixHMvgPdq
 Z36x89zZi0otjMZv6ypIdEg5co1Bvz0wFaKbCiNbTjpnA1VAbQVLSFjCZLQiu0vc+BZ1yKDV
 T5ASJ97G4XvQNO+XXGY55MrmhoNqMaeIa/3Jas54fPVd5olcnUAyDty29/VWXNllUq38iBCX
 /0tTF7oav1lzPGfeW2c6B700FFZMTR4YBVSGE8jPIzu2Fj0E8EkDmsgS+nibqSvWXfo1v231
 410h35CjbYDlYQO7Z1YD7asqbaOnF0As+rckyRMweQ9CxZn5+YBijtPJA3x5ldbCfQ9rWiTu XQ==
Message-ID: <1fe657b7-41ee-f955-7ac6-756faa059d64@amd.com>
Date:   Fri, 22 Jun 2018 13:52:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180621204832.22448-1-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YQXPR0101CA0044.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::21) To SN1PR12MB0190.namprd12.prod.outlook.com
 (2a01:111:e400:5144::24)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 785bc69f-f80a-44e7-1c7c-08d5d868ef92
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989116)(4534165)(4627221)(201703031133081)(201702281549075)(8990106)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB0190;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0190;3:eX0bdM2ZDioBYwc/YHC22Gj4yu3WbpPxxOuzV7/DgvmneEcSrw+e8NGrd9s2qXcsc3Z6YwL5R+L+1ik5I8kmNK2Gw87puIpCX2jxjvz3aMIw6IWVaKieN/79URMmXtJU8Wv6m1RMpSwFQKSLc+in5HBgZ2SWxV56TmlKIHGyJUiHZ4yj7ijYMWn7vVZ1+WWOnMP82cnSgbXtWbylPOXDRtj3abwKiSFZR+WyxqjK/sEqruJ8UQ4otR+xPET4bmqu;25:D8+JGkDZBTh4Cky0tqBnqiJFV+RsDHmb9GUndeqb/5Tdkra4ZjfhJVe/Cdauon0M2eRl+YsDWiWZDkKm0VfF0iAeI0wycod0/S/6elwEifLm2gHQ42AZ4asBKWwdvnWppICjFoo0sciQeBWdFCdGGi3LNp+FAVylNn+gFFFykqLtRieIp9LIC/aFEZytzkF7oszqu2HHp0JtIOq8gHqV1+9zPSKrfOmWxUwszy/DF/T3y0BHroQNTs8vLbjCgeNM9jb/KtWe+9NH+G/SobyDgXeq/lUssSjXmLnxpoLAGjy58ixnnA0aA++NGqE9Y9EqhUR0Qn9NO0Jn0PMBmIFW7w==;31:8OXLjm+s43oAPZuElLAm9bSFg/vj/vJpAgdotDbjV7SSe2VsxGv6aNTh/L0DXt0g3dcq6a+loNY1wTipyjN0NxiKOvF+Qi1uXlxYYblERTgM81xYiau6xzfohOXl/iXSBtaqVJ46gHeU8rh2xa+5rPpY7uyji+JfKvNds7/2kC0WeCRQJtuo7Zp1VOIJxiTZ68wbg3NTlJ2z3GDqBPxU5n2xMf0VSTztjgUJw98H9pY=
X-MS-TrafficTypeDiagnostic: SN1PR12MB0190:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0190;20:ara8KmeuqOX9or8Zlxdu46XicPNMWTYSlahwcZN+Y0uFeRzPTDNkf+YmKCKUPkLBrh5mqIndIkGeUnv51C83TJOXl7fGYyKBlHNp9p2MDnFid8LED0CsELqITW1uQMjjwISXWtg8D1Vd4plRxBGHbyv8JOqWzYNmF99vq87B6bvFlwWEq9+MybEA3aTpSpIKkz92q8YwHP2pOIr7sv4CQ43dwdjTZSWthPRr/AOsK/hcsV6IiQRn6sxVArOA1GxUU/NsWTiJwT0CkxR/wkL8+4f2t9Hgbfb+4rZJXB+yVlfMLcV2PfnZzCVtc+ROo/G9kjwFOJBFqvpzc+9g9AlZRQ76ROM2bGLQ3+9NB0INAhGeJlRjRsObWqmWH7VYGtBIcqKwv1YJo5T3arw0cu8loPfsG+IOqQe41uV8xrDMtqsPBznIdb6MJ7qTQKjiVlwnka7UKN2T6Wns5HaCTJkdP75YgtL2ErXcJJqoPqSp0Td38BFg0bshCDhBQ/tQLlWp;4:8/dqOdrmoaC03iSYb4AlyEPxWP/I9jJo6UwAiZfFs+X1hc56QXiqF3MjAG3661TFQhrg7OlVTGA5P1HPx+DK6O7v4FIFm+y+yOy2Y+dciUXvu+AsTMCyUau5WXJMxmDkKgx8m7rQv286t5JCtVHU6xXeu82pI15QZOtQt9TyFeaFPs6jO5mejvIaup7UOntZhq9g5uF53raCn+P4GTIUm/ck2v6/2Ls7wCxSQkrOlrP610swl5v48yQCvs/IAFDCc6fNrCov1HRpxv2EWFW7mnDcOpZJy9HPcsXzTVDMo29Nhbd7BnAzHRcbpFGWoIP1YyG+YIVFelhUms+gqloi9Q==
X-Microsoft-Antispam-PRVS: <SN1PR12MB0190E382033848A1AD0E29AC8C750@SN1PR12MB0190.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:SN1PR12MB0190;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB0190;
X-Forefront-PRVS: 071156160B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(39380400002)(376002)(396003)(366004)(346002)(51234002)(199004)(189003)(106356001)(305945005)(7736002)(186003)(77096007)(26005)(16526019)(8936002)(31686004)(36756003)(486006)(81166006)(81156014)(8676002)(956004)(476003)(2616005)(58126008)(446003)(11346002)(16576012)(97736004)(316002)(54906003)(68736007)(44832011)(59450400001)(2906002)(53546011)(386003)(2870700001)(76176011)(229853002)(4326008)(3846002)(6116002)(65826007)(105586002)(52146003)(23676004)(52116002)(6246003)(2486003)(53936002)(5660300001)(31696002)(65806001)(65956001)(66066001)(50466002)(64126003)(25786009)(86362001)(478600001)(6486002)(6666003)(47776003)(72206003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB0190;H:[172.29.157.77];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjFQUjEyTUIwMTkwOzIzOnFSdFBJZGpGOTh4V1BOOTFDWlp3bVVUSE53?=
 =?utf-8?B?dUJJTDRWTStaWWY0VE1HVzNJQWtWMldTdEtSWjFPSzJ1TE9TWWVHS3RueDJB?=
 =?utf-8?B?d21wbjJxTWVLY2dTOEp4OGk4OHduek4raHRSUlRkaHBZV0ZDRWlTdEJ6S2ht?=
 =?utf-8?B?TlQrVVNBYmxVc0N3L0FBRFR2UjM1R2hsTURzRzIvUk5ydVVOL1pkeEZqck9o?=
 =?utf-8?B?dmV2dHNmbHUxTnQ3T3pVSDlJeEJ3N3Z3dWRlbVBWMUk2akdQOWNkakFhdGtx?=
 =?utf-8?B?eUMzSjRBc3VjNmltSk1XZXFGSlVSa3NBa1BFNm9hMlhLZVJsVzFsS3hSYW1B?=
 =?utf-8?B?YzVIYmFzOHhUdVlKWDRkZWFIcGZSTlZVa0cwYkQ2aUd4ZnlXbVBiVFpLd1Bw?=
 =?utf-8?B?SjlYais2TzlnNkIzUWZ0SzZEMmEvTWI2YmRaUzlRVFpIUE5RSmQ2a2ZhaGVq?=
 =?utf-8?B?eGJra3BCaC96cnRyMmI3SFQ5QWkrbDRPT0tjYnQzTVRXT1duUExzbHU3M3JG?=
 =?utf-8?B?WXJGeFhPeWFnOGVleGZ2OGR3ditoQS9ld2N4TmR1VmE4RUNnOEZsbjZ4Sjhv?=
 =?utf-8?B?RUNmZGhiZVFobHhUWFhSMzgyYUM2dFROOTBGZHlLenh5ckU0ZG02NU5pY0Zn?=
 =?utf-8?B?eExNRmphcXBtQjA5cyt4eC8wbGtlL0RWSUxyWVVoMWgxQ3R6aEM1eXNRbWcz?=
 =?utf-8?B?TXM4c2Q1ZTBYR3BUY0JXdE5RL0pYZDAyRFJmWHFFNmlQQVZxSitYSnZ3ck8y?=
 =?utf-8?B?eUQ4dVFBZWJhdmpLT1Y3aGtSZStnNU1OM0pXNEFML3l1ZEtxbG5waU5WOERa?=
 =?utf-8?B?eFVHdTFDK3VoMDZEVXdUek8wUlhPdlpWRFpKaFMxb1VMVTdCSklTakJlWnZU?=
 =?utf-8?B?aXRTTjR2WS9oQ29JUWNCS0tIWTNIUUtXRTJqUEdLQlIwd1gvM2trMTYvR3NP?=
 =?utf-8?B?M0VTclZsUDFXVHo3NGFnTDVib3lEamt5RVlJUmNUUXhiWTUyUjFWaEFSKzdx?=
 =?utf-8?B?VmphZU9aei9YNlRCcC9LdktEbm94TFlmQlFiQ0N3eUJ5RGJDMWFUMGpXWFd0?=
 =?utf-8?B?c3dTQ2pPUE5QZC8vSFhCOWlHejlTR1J4OXVndEtIS3FsZHRjZUJvMkgvWHgw?=
 =?utf-8?B?amxSa25HcHkxUUc4VFJqZStCS1ovOG9xZnA0cjEyTFpSOC83dDRFMFltTEhq?=
 =?utf-8?B?bHFhSEFIVTN2THlhU0p3VW1JUCtULzBDZEtvTGpZS0g1cmJteTRacmEzcmZG?=
 =?utf-8?B?cVVZejlwcHdtNllUb21tTmFNUkVJRzRjOThKdFhhelh5RmRsem8zbjFDUE9V?=
 =?utf-8?B?MkpLbHpsODVXN3Jtb0dnRG5jOU84S0sxdy9PZytEcnUvVytxQk1qdFF1Vnhp?=
 =?utf-8?B?YWNrRUhrYnA4Kzg2Y2lVN0R4OVdWNFcxMXlzQVZlUXpNV1FKbHNhV2VxSHo0?=
 =?utf-8?B?Qkp2MUxHZFoxVmxIMWhMZXhPSE1VZFN3VktNZzZpaGRPZDF1WUxJbWRmNVdY?=
 =?utf-8?B?Q0ZRbk5MMUExRFVyZFlpNDhOMEN3K2xjQlBsbkF3OGRRakdEY09hckRvSGo5?=
 =?utf-8?B?UWRqOTN3eXlENDcyUkZnSFREa0FwanpLeHlmbkFVNGZlUVBkVWEzT05oMVRO?=
 =?utf-8?B?VGlLNVdDWGVCS2tZampBSUQ3bEV0ZnRnUUhCUXJDdlpBVXpQd0ZzZnJQZ3pI?=
 =?utf-8?B?KzR4UUcvY3pvbnYvaUhubkJURnV0MTB3QU5DekRxQVZGZS9Tdk9hdjI5dldR?=
 =?utf-8?B?VEt0SHA3QmErWWN5VnJiZTZwQ3BuTHdoKzZVclJPZmxvRWNubWJOWFZGV1hP?=
 =?utf-8?B?VDFWSzI1VnUyOU92OWhCeERjRS9MYjN0UVNxd0xOTk0xTk0rQUhDWXZaRmpn?=
 =?utf-8?B?WGQwQUkzRko0Y2NVRVQxa3cxQThONmYzcFkyQ2V4dnlNazBxYjEyb2JSb0V5?=
 =?utf-8?B?MUphQ1hJcGhnMzVsUWRtV0xEcUpCRHZRa3NpZzBhY3FmdkZNd2NxbFZXR3pq?=
 =?utf-8?B?bHp5U3RCTklHT1JTTXQvWWdjWWV5ZTZ2YjVqRFIvT0VKMHdDSlFURzFyeFEv?=
 =?utf-8?Q?aRiQ=3D?=
X-Microsoft-Antispam-Message-Info: PUKqPY+lNPKEmMlGby2NabPHP+h3EtnB+zOzjvyG/oyCl1Bl7JXz5hd5YoIMZuB2RI1j3pio1oOJaT0dYSpqdSeEm90L6FcMIQlSGsl8ceeQPPBrdA4WEilmrZ0DuCHVN40eDbH5UjBwX9+ef6k4dOqazA3vTn1lJXX0vHyPYmHSM0v2LNKopWi9C4T+ASukwwbaUnBL5d8NEulleNtRKox8lpEq8SLtrWAdh6rieuFWUV33QtTiN15dbDw40NcMibi71j7zlnH8VT/+faepHCT56P/0ej56Gzwct5QU9LxXgcgqcVpDy8Rcv22bU9CN/YW9PR1OXL4UZkep60Y1JA==
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0190;6:Dfk+tyKVFydaxAby31sEQcChNZz+0IrP4sHTA3bO8d8d/WA4FHf1CocLh3cOQ0IMSuAKSgfdpcle2HsS8P02v86FEDfX8gg2yoc2Ef1DzXJL0NeH1s9UGub/8502TmnASV5BQ7NespCnZ8lqrn+rpjkdc6e4nH3BLmcG9sx39OjxQ08hWs/4Vyg9lJDcH2inbjH2q5sOwHki6S/p4YPAu9L+ocNIeOnzDXYY6vWMDgPZvf1DAexGbR1swx8PirkGuASivkJkTkl90POFwJMAKbFDitZIrP7GaZsHyxrHHSAu2LW1f3ZaPDcLTM0d58KVgiXI8Hl9IA1uztg0M2EhEUHejC8lkTxf1loEn+kP8VVBD1R31EPjd15n4U+dez442n+yukzwlBmzRL5AHcP5nNaMpe8m8TkRTPTBO2umdb++zP8HoxWwCpPXWM/zcdN0REt/aUJjpY4LspVRQxJWZA==;5:D+7vKhXsvUPFM4/yY+8vczXwtN2YlnTw2fCA38qpL+EfZNyWzZ4U+bzYe2fxx0f+obnVfJLm2zK+DnCR/aBgCRQhxXZj13SCIMzM2umuaQ7parXuWTSMDlOsIG5ak38UFpf26lmrXCSmqmK703GA/Pz1Kl94y0fimVfuZdnvg/w=;24:3aZvjL4WkiY+QPXh01mmmROByYn05X2u7ZHqHEGOmKdJJO64HLzAf0HnwO9L2bkd0iDoZjkLQjIrMiLr+hF94rWv8vAMX2BimnA1t65y/Es=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0190;7:B5X15JT1YZRaWExgz5yYP3g8+ADvuGOtciBsExoKPdD0hn87mtunZPn2WQOD51V9ETnsEXtTZNtJPDe6s6ab0T/LCueqDK2n2Fw8R2To9shgJOY5dXlJI98ygZuaeI7wA60wIHlwoiiW1GCXitypVkmOHbfxdBI3Pc324vuAhlOeNcnz97keHgS2iJYkzvEGBQX9DsXF7sSdyEtTqHE/GADK/mASF7vhjgaiMT+hKFlFt+ihVPlGI7pktutkk6An;20:zb/81if/T4dSI/+zlGncNzdXADu48Pyjo2uHfgoOHjQDFnO+hJTOnu7zMJsjjQd2OkL6ID/g6w5bOPxzJEVPZu4Dw0SHvQqU3Lvo5d2w+WsoBHYRQxWEsOn9ykQkc4u/OosU27qzZ6m7Rh/yzJ1IJBXevO4rqRXe83On05m0JILXOCMrEHBPpTJ0yJM2RCPqoSUHwNqdbljjn4aHzWtIoVwp6Bj8jSI1h92RGKiGH6GhhKz4jMJT/0QaVhJZut3+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2018 17:52:32.8602 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 785bc69f-f80a-44e7-1c7c-08d5d868ef92
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0190
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-06-21 04:48 PM, Lyude Paul wrote:
> This fixes a regression I accidentally reduced that was picked up by
> kasan, where we were checking the CRTC atomic states after DRM's helpers
> had already freed them. Example:
> 
> ==================================================================
> BUG: KASAN: use-after-free in amdgpu_dm_atomic_commit_tail.cold.50+0x13d/0x15a [amdgpu]
> Read of size 1 at addr ffff8803a697b071 by task kworker/u16:0/7
> 
> CPU: 7 PID: 7 Comm: kworker/u16:0 Tainted: G           O      4.18.0-rc1Lyude-Upstream+ #1
> Hardware name: HP HP ZBook 15 G4/8275, BIOS P70 Ver. 01.21 05/02/2018
> Workqueue: events_unbound commit_work [drm_kms_helper]
> Call Trace:
>  dump_stack+0xc1/0x169
>  ? dump_stack_print_info.cold.1+0x42/0x42
>  ? kmsg_dump_rewind_nolock+0xd9/0xd9
>  ? printk+0x9f/0xc5
>  ? amdgpu_dm_atomic_commit_tail.cold.50+0x13d/0x15a [amdgpu]
>  print_address_description+0x6c/0x23c
>  ? amdgpu_dm_atomic_commit_tail.cold.50+0x13d/0x15a [amdgpu]
>  kasan_report.cold.6+0x241/0x2fd
>  amdgpu_dm_atomic_commit_tail.cold.50+0x13d/0x15a [amdgpu]
>  ? commit_planes_to_stream.constprop.45+0x13b0/0x13b0 [amdgpu]
>  ? cpu_load_update_active+0x290/0x290
>  ? finish_task_switch+0x2bd/0x840
>  ? __switch_to_asm+0x34/0x70
>  ? read_word_at_a_time+0xe/0x20
>  ? strscpy+0x14b/0x460
>  ? drm_atomic_helper_wait_for_dependencies+0x47d/0x7e0 [drm_kms_helper]
>  commit_tail+0x96/0xe0 [drm_kms_helper]
>  process_one_work+0x88a/0x1360
>  ? create_worker+0x540/0x540
>  ? __sched_text_start+0x8/0x8
>  ? move_queued_task+0x760/0x760
>  ? call_rcu_sched+0x20/0x20
>  ? vsnprintf+0xcda/0x1350
>  ? wait_woken+0x1c0/0x1c0
>  ? mutex_unlock+0x1d/0x40
>  ? init_timer_key+0x190/0x230
>  ? schedule+0xea/0x390
>  ? __schedule+0x1ea0/0x1ea0
>  ? need_to_create_worker+0xe4/0x210
>  ? init_worker_pool+0x700/0x700
>  ? try_to_del_timer_sync+0xbf/0x110
>  ? del_timer+0x120/0x120
>  ? __mutex_lock_slowpath+0x10/0x10
>  worker_thread+0x196/0x11f0
>  ? flush_rcu_work+0x50/0x50
>  ? __switch_to_asm+0x34/0x70
>  ? __switch_to_asm+0x34/0x70
>  ? __switch_to_asm+0x40/0x70
>  ? __switch_to_asm+0x34/0x70
>  ? __switch_to_asm+0x40/0x70
>  ? __switch_to_asm+0x34/0x70
>  ? __switch_to_asm+0x40/0x70
>  ? __schedule+0x7d6/0x1ea0
>  ? migrate_swap_stop+0x850/0x880
>  ? __sched_text_start+0x8/0x8
>  ? save_stack+0x8c/0xb0
>  ? kasan_kmalloc+0xbf/0xe0
>  ? kmem_cache_alloc_trace+0xe4/0x190
>  ? kthread+0x98/0x390
>  ? ret_from_fork+0x35/0x40
>  ? ret_from_fork+0x35/0x40
>  ? deactivate_slab.isra.67+0x3c4/0x5c0
>  ? kthread+0x98/0x390
>  ? kthread+0x98/0x390
>  ? set_track+0x76/0x120
>  ? schedule+0xea/0x390
>  ? __schedule+0x1ea0/0x1ea0
>  ? wait_woken+0x1c0/0x1c0
>  ? kasan_unpoison_shadow+0x30/0x40
>  ? parse_args.cold.15+0x17a/0x17a
>  ? flush_rcu_work+0x50/0x50
>  kthread+0x2d4/0x390
>  ? kthread_create_worker_on_cpu+0xc0/0xc0
>  ret_from_fork+0x35/0x40
> 
> Allocated by task 1124:
>  kasan_kmalloc+0xbf/0xe0
>  kmem_cache_alloc_trace+0xe4/0x190
>  dm_crtc_duplicate_state+0x78/0x130 [amdgpu]
>  drm_atomic_get_crtc_state+0x147/0x410 [drm]
>  page_flip_common+0x57/0x230 [drm_kms_helper]
>  drm_atomic_helper_page_flip+0xa6/0x110 [drm_kms_helper]
>  drm_mode_page_flip_ioctl+0xc4b/0x10a0 [drm]
>  drm_ioctl_kernel+0x1d4/0x260 [drm]
>  drm_ioctl+0x433/0x920 [drm]
>  amdgpu_drm_ioctl+0x11d/0x290 [amdgpu]
>  do_vfs_ioctl+0x1a1/0x13d0
>  ksys_ioctl+0x60/0x90
>  __x64_sys_ioctl+0x6f/0xb0
>  do_syscall_64+0x147/0x440
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> Freed by task 1124:
>  __kasan_slab_free+0x12e/0x180
>  kfree+0x92/0x1a0
>  drm_atomic_state_default_clear+0x315/0xc40 [drm]
>  __drm_atomic_state_free+0x35/0xd0 [drm]
>  drm_atomic_helper_update_plane+0xac/0x350 [drm_kms_helper]
>  __setplane_internal+0x2d6/0x840 [drm]
>  drm_mode_cursor_universal+0x41e/0xbe0 [drm]
>  drm_mode_cursor_common+0x49f/0x880 [drm]
>  drm_mode_cursor_ioctl+0xd8/0x130 [drm]
>  drm_ioctl_kernel+0x1d4/0x260 [drm]
>  drm_ioctl+0x433/0x920 [drm]
>  amdgpu_drm_ioctl+0x11d/0x290 [amdgpu]
>  do_vfs_ioctl+0x1a1/0x13d0
>  ksys_ioctl+0x60/0x90
>  __x64_sys_ioctl+0x6f/0xb0
>  do_syscall_64+0x147/0x440
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> The buggy address belongs to the object at ffff8803a697b068
>  which belongs to the cache kmalloc-1024 of size 1024
> The buggy address is located 9 bytes inside of
>  1024-byte region [ffff8803a697b068, ffff8803a697b468)
> The buggy address belongs to the page:
> page:ffffea000e9a5e00 count:1 mapcount:0 mapping:ffff88041e00efc0 index:0x0 compound_mapcount: 0
> flags: 0x8000000000008100(slab|head)
> raw: 8000000000008100 ffffea000ecbc208 ffff88041e000c70 ffff88041e00efc0
> raw: 0000000000000000 0000000000170017 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> 
> Memory state around the buggy address:
>  ffff8803a697af00: fb fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>  ffff8803a697af80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>> ffff8803a697b000: fc fc fc fc fc fc fc fc fc fc fc fc fc fb fb fb
>                                                              ^
>  ffff8803a697b080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff8803a697b100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ==================================================================
> 
> So, we fix this by counting the number of CRTCs this atomic commit disabled
> early on in the function before their atomic states have been freed, then use
> that count later to do the appropriate number of RPM puts at the end of the
> function.
> 
> Fixes: 97028037a38ae ("drm/amdgpu: Grab/put runtime PM references in atomic_commit_tail()")
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: Michel Dänzer <michel@daenzer.net>
> Reported-by: Michel Dänzer <michel@daenzer.net>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index f9add85157e7..689dbdf44bbf 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -4206,6 +4206,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
>  	struct drm_connector *connector;
>  	struct drm_connector_state *old_con_state, *new_con_state;
>  	struct dm_crtc_state *dm_old_crtc_state, *dm_new_crtc_state;
> +	int crtc_disable_count = 0;
>  
>  	drm_atomic_helper_update_legacy_modeset_state(dev, state);
>  
> @@ -4410,6 +4411,9 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
>  		struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
>  		bool modeset_needed;
>  
> +		if (old_crtc_state->active && !new_crtc_state->active)
> +			crtc_disable_count++;
> +
>  		dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
>  		dm_old_crtc_state = to_dm_crtc_state(old_crtc_state);
>  		modeset_needed = modeset_required(
> @@ -4463,11 +4467,9 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
>  	 * so we can put the GPU into runtime suspend if we're not driving any
>  	 * displays anymore
>  	 */
> +	for (i = 0; i < crtc_disable_count; i++)
> +		pm_runtime_put_autosuspend(dev->dev);
>  	pm_runtime_mark_last_busy(dev->dev);
> -	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state, new_crtc_state, i) {
> -		if (old_crtc_state->active && !new_crtc_state->active)
> -			pm_runtime_put_autosuspend(dev->dev);
> -	}
>  }
>  
>  
> 
