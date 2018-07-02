Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2049C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57A2225478
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ezEUm1uS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57A2225478
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752694AbeGBMZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 08:25:07 -0400
Received: from mail-dm3nam03on0076.outbound.protection.outlook.com ([104.47.41.76]:17536
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752216AbeGBMZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 08:25:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZ3cx+cBgahEgwgE+AaKDT2l/bwrcQz83I55iOpuBOU=;
 b=ezEUm1uSJAuUEQo6GFkct59CSXGU/ukOZ1ZLnCKW12gE7VzsjCDgDMdrgqW9Qn+bW5pKn3BQgxJCp3jcBV9LiF4y6r+K7IRLSwTewJMGI6SI4emwzyR7QloryHkU08uSw/qxY0jacqgc/Lrk1VSIGQB/xA8mZUgY8/S5LjpiiaA=
Received: from [IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740]
 (2a02:908:1257:4460:1ab8:55c1:a639:6740) by
 DM5PR12MB1722.namprd12.prod.outlook.com (2603:10b6:3:10f::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.26; Mon, 2 Jul 2018 12:24:52 +0000
Subject: Re: [RFC PATCH] mm, oom: distinguish blockable mode for mmu notifiers
To:     Michal Hocko <mhocko@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Sudeep Dutt <sudeep.dutt@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Dimitri Sivanich <sivanich@sgi.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>, kvm@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-mm@kvack.org,
        David Rientjes <rientjes@google.com>,
        Felix Kuehling <felix.kuehling@amd.com>
References: <20180622150242.16558-1-mhocko@kernel.org>
 <20180627074421.GF32348@dhcp22.suse.cz>
 <71f4184c-21ea-5af1-eeb6-bf7787614e2d@amd.com>
 <20180702115423.GK19043@dhcp22.suse.cz>
 <725cb1ad-01b0-42b5-56f0-c08c29804cb4@amd.com>
 <20180702122003.GN19043@dhcp22.suse.cz>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <02d1d52c-f534-f899-a18c-a3169123ac7c@amd.com>
Date:   Mon, 2 Jul 2018 14:24:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180702122003.GN19043@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1257:4460:1ab8:55c1:a639:6740]
X-ClientProxiedBy: HE1PR0301CA0002.eurprd03.prod.outlook.com
 (2603:10a6:3:76::12) To DM5PR12MB1722.namprd12.prod.outlook.com
 (2603:10b6:3:10f::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cdcac240-6a48-4ddd-5b25-08d5e016d496
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1722;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1722;3:nvRJGUgHMXI/dA0pLWY3U+SW4oyLtBAyJ7hcAOFiSY1XkAaTP5C7KU71oQ+RRISLCrOdBUzaio3l7rxSQMJT+TIMhe8OYiAKpCcbFoIrw7EO9eT+FySFkRuULWAMVZm7/R1jgzJLtGYf6ggF86JtoXEPaW6/+3ZxcvoOeNX7dUGM7ZcK8FgbFEhJasPvNHihHVF52imMFq/X4FPTybsfT6Ae1ZcsKMF8xbgf1MO0jRvMaXZnq4L7hUWuS1dGfbad;25:RrLYJ/5iWy+6hu7GaiHwO/P9pmARyINfE8WQ0lyS0njWdZeZxaGMUkJdSnbSxISkzYmPfkjHipUWnogbFSEdaFfcr+3AxiviU2iTYqC9tHF2CejFU1SOxwZqgm3Xwv3uAi40W/HYJ4m8XqDSNFXN14CMENAgbL6OBI6/Qw3wL/RC9JV/2N58kuylyxnbjab5tYs0hZASj1wvRpbnkm5bQojfOZuqWuPeKN8B/6wAPV4pzNLG9LbX5QDSHiR9DoDQVFaNdd6nEDOkqIUetTDtKOJ+edvgrmQIRqDuVJ9zyeqodHSO/euXpVLRoPKA9C4oF5B19jYuyXqyaXGRMedEIw==;31:bZM5cgeCp7BQx3ifwRy+jEF18QOaeow+utvvPAu/IKWOidJMwKWbs8aJOv909dXiee80fcJ2IseQMhVTOVvo8g9eSm9uqXjfLl09Jn146sIyJcIB9rKIlhDrxGxfOJqjS4Q/0Jg+GX3qoo850N2HiMZ941Yb74mG+BR1Ds2FeBhRzmvE0df+eJndY7kiVtsgxEZbNHYv1U5vtzo7lTCZHymFknM6nnZ0K4DRzVlTVlg=
X-MS-TrafficTypeDiagnostic: DM5PR12MB1722:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1722;20:PoAIJa5eyZPVK9sBce/G3LYKxNm8HFj+Adzuv2rlaWTCaaitodVlU7/CLS46g9stFNn05mM2Er+2/WTHKCGZ8TjHa6I6UsTQcTBXmv4KR0+dG063PDYArj1semdEa3wbCbZWVtfnsGJ8xeZhbgQ9yNkkke6yLQKVWtAziLbMqI6WaQHVeGiR6lJlGYZ9oiTfnLb040jyY6YPrqHT9skQjTgqeKXY50rqCcjeB58Culh2lMS+A2NYzOelPzlV5BH4W6d8goyep7oD5NED9GUGcKW1OkoXv4hYCtuBNzq8Yi6g6JrzMWZQtE3DTPx0insehS/If/8cftFrp+Rer43yZlO1elb5Nd6S6JlkNLCE/xTBSot6fqcG+HKPjYT9kP62w4Jievk3TsoMJxnsvw6ySvpeQ/UXYSA32zgd0ad555EWXV2iRVhGfKVjJqFp7MRONz4JSFL4ZqZ06EcKXJQXsEIIWKGmy7yVrfad8Q+ylziXh3r/SL7Fx1EUBg/F8vko;4:yWw8v3DMOZypjUp+RLp4lG33NoJp1BLPz8C3RY3333XG+hgRCq4ICbd+OLgMycPRyvY0PZRJoiwm3OFzU9WBI7oSbczdvCQL5ip33xaR6kFA7SXpn/brw94JYXdEVM+U170kIIAOfBSRDLjbOVDWL95zqMVG/Cg1U4OWUEN7IDFKIhMjAso/sl1T3dVD98gLIJK3hwPd1HMFdbZQz08QdpJQs53b+SWmsCsjnMu6Wfv6bcjfh9dbPaHlmOhzMc9UgGqH0YF+v3bpTOEkxjWyXg==
X-Microsoft-Antispam-PRVS: <DM5PR12MB1722EBDDCEE07BAE4CF76A5283430@DM5PR12MB1722.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DM5PR12MB1722;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1722;
X-Forefront-PRVS: 07215D0470
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(366004)(396003)(346002)(376002)(199004)(189003)(76176011)(46003)(25786009)(4326008)(2616005)(11346002)(476003)(446003)(486006)(6486002)(229853002)(16526019)(106356001)(50466002)(105586002)(23676004)(52146003)(2486003)(81166006)(93886005)(67846002)(36756003)(53936002)(52396003)(52116002)(386003)(6246003)(2870700001)(58126008)(64126003)(6116002)(65956001)(65826007)(7736002)(65806001)(31686004)(316002)(7416002)(54906003)(2906002)(478600001)(86362001)(72206003)(1706002)(47776003)(97736004)(305945005)(8936002)(6916009)(8676002)(5660300001)(68736007)(81156014)(31696002)(6666003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1722;H:[IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjEyTUIxNzIyOzIzOm10QWNrUDd2VWxzUThraUtwbFdUZlA2S09X?=
 =?utf-8?B?aFh4ZWcrbXhXR05rSVFtYTBSOE1EbTM1d0lwaHFLTFloVENtaVdTT2FONGZC?=
 =?utf-8?B?Z1Babm1vWHZIU1hUSVVLSERxUUFld3FUS214R2tWa08rTW01K2pHTU0zM2c1?=
 =?utf-8?B?dDFzdDZqb29BZENXb2x5VEtQRllXTk0vb3lla3N1b0w5QlNwTkRzMk9oUHBQ?=
 =?utf-8?B?bnI0YkJibTAwc1F6elpKWEJrQUU0Y2VHYVN0b25ybElOdm5MQkZOMFRvK3E1?=
 =?utf-8?B?dHNaT1psamVqaERYQVZiNEtIYTc3NzBNMVBrWVRuUEhUdDkyMEV3VjVXNzMx?=
 =?utf-8?B?V0xFRWZyTTZEd3YybDU1U0xEZmFqK05zOFJxMkZoTWxkNVVWOERqREtTbHBU?=
 =?utf-8?B?QzVLYVpBS0h4a0dtcTB3WlRsRlVZWTgvaUZlTEhmMXhZYTNXcGZLZy9paWZZ?=
 =?utf-8?B?NFJEYUJMVHNKV2dQYk5FdFVFNThIQ215Y1hvK1lYdjdPUjRrTE5EaENnSjhE?=
 =?utf-8?B?WWhTNGpUYUJySXlXdldVOVZzR2RzaWx6VUZjLzFWcWJORmIvM09RTGZyWW54?=
 =?utf-8?B?SkJiMm5mZGZ0aC85Ym1TNDdqbGp3SFhrZTArV3drN0RSc01LNklobURrcEJk?=
 =?utf-8?B?cUNHQlBQNkhBcWljbkFhZGZYTjZkVnNjeUw5WS93SXMwVWM2dVhDZGlpbHN2?=
 =?utf-8?B?d2EvZkF0UElXWFVwUTZBZzJrN0toOXFWSUlBV2NzdFU1VGZxNzQvcWVBSmwz?=
 =?utf-8?B?OVZFbmVwSmZuVHJVR21MS3J5WlRPZ1llWHI1cy8wWUkvMFFQenFZWjFlWG5j?=
 =?utf-8?B?TWlCTmdYZUtVUEoyWU9lR0UyODByb283R0ZwY2VhTTNtcHRUNk5PcEN2d0NP?=
 =?utf-8?B?RGdIUkhjclZXd3Z4cVVCTjZmcFlwNWFOdkNhc1JTaExpdHZFZUhKVjFhWCtY?=
 =?utf-8?B?OXRncW92K3V5d1B5MFhNaDRiMTZyMEdub0lUUWtHTENNeEg5MHgzSGFGNWsy?=
 =?utf-8?B?eis3QmZldENXUFloNW1vZ3N4Q1hRaUNRVnFSbVQrOElQOGp6UUF3ZllXdzE0?=
 =?utf-8?B?aGdSU3BZS08zSTBpUGtFRk9kV285ZnZtNDRmMndHakhyb2NlUWpPeDhrYU5a?=
 =?utf-8?B?MnRJN25hVHk2TTJpV2Z1M0wwNVl4SmNRbVFFZDUyQW80Z3VwSE1ZeC91R3lj?=
 =?utf-8?B?dFBvbGNrazZWUTBONk56NytXcVNZQ3l2Z214Q3RJR0JkZXM1QzJUTXczSWZC?=
 =?utf-8?B?WUovSFExQjFwNVA3aFpSdWM2QlhpNWNPeitQT2wvWUF4MXFLUWlDMWZ5S2Nk?=
 =?utf-8?B?WXZ5WDRsbXNJTS9nZ0JzMnNIQmFpMGl3b1RyL1ZsOUlMVW44N0JtSEZCcmUz?=
 =?utf-8?B?OXlWU3NCMWJPWXhpVHV0U3U4eXlxcVFndURHRFZxeW5hd3VlQUx0empEUnVp?=
 =?utf-8?B?TzRoQVRKc2lrZmRLYWV1OXhMdStqcHZQYlRuNFc2MGhzWjdVNU9vZ3JZN1lF?=
 =?utf-8?B?QW9QeFAxN1hJTnNXU3hnK0lkVlNZRVF2ZUNoWE1iZTcyejRmWHZHL1k1S3Iw?=
 =?utf-8?B?N2pIUGxkQTdwZG42eENMMjl1dCtxMWs1MkVlaGdkNktTTDFjbjFMWHlsck9o?=
 =?utf-8?B?OHBGUm9lWXJoUG42NTk0TzJXTUl6UHJaRFp2UityTmIvc1drY3F0ekRuYnM0?=
 =?utf-8?B?eVk2TGZHQ1A1WmVhT09UR216MHMzTHNHYUEzWVc2bkxQWFkzM0dnd1JQMkIx?=
 =?utf-8?B?QUdxaFlpYUs5M2h2cXlPSHF1R3kvSy9aZXVlV3lXM3FIemowNkxRNEtUUkh6?=
 =?utf-8?B?KzlkWjRPenRidXZQblBCU3R4ck1ibjJ3TnlNYUpsNENGV1oxaGRCeGg0aDdi?=
 =?utf-8?Q?YiDckjZnwJuqP9SWEKnmbPZCorNw4l8I?=
X-Microsoft-Antispam-Message-Info: uTtGhfGYryD5IdrEBecBhrhjG32oAiwOWMwasZJRkc9jwM2hYQf+4NyCq0iz/aGOSb/9BhCu2JMOmq+r2i5CqSDTKUhBuWdQG8eEL88Gc/v7teheswVczrzQo7bMAPrWl7F7xAqR19Uoq+jiWsOZay7kacIDfDprjx2c0snXd02YFGh+kLVWz6nuSyrWgAI87amJmY16hZY+1+ABdxN5r82ozy8qzQ2jAxMP1uLz5XZPhohWSbcE8PIAWuBx3+cD6f9s6UTkV/qVLuHk9z69IlJILenEkXbGNvNbDBB7v3/DPwR0Tnpscf/smzpWvC4q8nj5NTOgp3g8lRbC0Pq72kL8+6SgLQXAOAbaFeYfpC4=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1722;6:IpJENL67IfCOltWPcpBk2ViELe/I4JF0tf4J1GfDB6dx85ShGQM/qu/ZNT5fuU03iGwjXX4+YYA6/qBWKVgArZxOlTVDoOdjBHdR8olj45mmNAoVwysZSWhgTMXAtk9i+0T3nX5f3L3aAhH0RV+S3G8ooBCQEpihaxS/ASA1FUbCGqo31ztbdCYdroeZO+E5leQ6C+qclhqVQUx+FU60i5yRWp1M81eVKV8XYQTr7T268Nl353QvMSshCVF6bmckMAwb63lClyu8AQ2M+OSI0LMAPMVGMrsLDzLOZfqJmbJlrRouTCyt+FwByIGcLJ3LHZ3AwIhDE9iki4Gb04+kRCiTXSiV+kZ9TdJJd2lBasAM7ZG3RvfYS4czkN3zzYvhXSykgZp1MZyNDf81oJTMxJr1YPbwD/1u2U0rtcNvpSbvQQJLdBYUW75LZHjD7F6DB1CtcZkEVzdmtvpK9JmNXQ==;5:6Yn/0eWwbRSbiefYIZQSsKrArL0xQbJYz/4r7WVA7O/zJ4RW+VzdnurXurxL82J0Xmv9PrO1dusxz1GLVHIET4KYI9Tj6ZvEj/qql1JTX3MZjERl+QnTSo97CHihEG7IdX3qGlnFBXB/2kc3m6ymdjwfVgmnj606LVQFCjgVup8=;24:DXC+vzAG0SUY5xY2c/CD7fEI9wVV4AAD2evHWNv9UioOtU22hBRmLeRn6j7+qITZlUD5Ke28gCQN1okSe4jsmQqb88CiutA5O+7j0BKO07w=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1722;7:xESvx7RWYmqjTMciOksRVvyqHdnJcXbyxm6jRrLqJuTB+46JvYOt9rTyDoa/gKg8FNwPJxgEFqzGn4zeCoM2+jZnc7NFuW6DjjaXmLd28/xLgeHJ+Y2KapaGL4xrEhqRKWMNV/nJxow9jTLVN6E95OAR4AqDWJeiV1dlEfDos2R23plCi1awyCjZwaInMIZbZy0UjOBdY6Wr/dCDz1l8+FyOj9FaN/6F91OCqj4bkhlxWcIUXPxF/z5P5N908A0R;20:8fcT46OYZOoD5Xx5X6GPBTLHHvKa7MmkNol0zT+GI3rTrGi0xbn269YF3xGvNWCXJ93ehyE3Pn7qTV492NkYSXf4gPsBePJBTW0wkIhcGMTIZsBqxjHOHgAQnxbsJ80PrRYjMONCo7qRVY78NRj+JWVQHn0hiaAUgdv1FCjJN4iTK8mfZRMFEngnSWVLmkKeE+m/EUgi3LVaEjTT3caeb8HhiDJbH+GeF1geasDlNm1TYon9NPWK1u/o6+Vg8SHP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2018 12:24:52.2051 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdcac240-6a48-4ddd-5b25-08d5e016d496
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1722
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 02.07.2018 um 14:20 schrieb Michal Hocko:
> On Mon 02-07-18 14:13:42, Christian König wrote:
>> Am 02.07.2018 um 13:54 schrieb Michal Hocko:
>>> On Mon 02-07-18 11:14:58, Christian König wrote:
>>>> Am 27.06.2018 um 09:44 schrieb Michal Hocko:
>>>>> This is the v2 of RFC based on the feedback I've received so far. The
>>>>> code even compiles as a bonus ;) I haven't runtime tested it yet, mostly
>>>>> because I have no idea how.
>>>>>
>>>>> Any further feedback is highly appreciated of course.
>>>> That sounds like it should work and at least the amdgpu changes now look
>>>> good to me on first glance.
>>>>
>>>> Can you split that up further in the usual way? E.g. adding the blockable
>>>> flag in one patch and fixing all implementations of the MMU notifier in
>>>> follow up patches.
>>> But such a code would be broken, no? Ignoring the blockable state will
>>> simply lead to lockups until the fixup parts get applied.
>> Well to still be bisect-able you only need to get the interface change in
>> first with fixing the function signature of the implementations.
> That would only work if those functions return -AGAIN unconditionally.
> Otherwise they would pretend to not block while that would be obviously
> incorrect. This doesn't sound correct to me.
>
>> Then add all the new code to the implementations and last start to actually
>> use the new interface.
>>
>> That is a pattern we use regularly and I think it's good practice to do
>> this.
> But we do rely on the proper blockable handling.

Yeah, but you could add the handling only after you have all the 
implementations in place. Don't you?

>>> Is the split up really worth it? I was thinking about that but had hard
>>> times to end up with something that would be bisectable. Well, except
>>> for returning -EBUSY until all notifiers are implemented. Which I found
>>> confusing.
>> It at least makes reviewing changes much easier, cause as driver maintainer
>> I can concentrate on the stuff only related to me.
>>
>> Additional to that when you cause some unrelated side effect in a driver we
>> can much easier pinpoint the actual change later on when the patch is
>> smaller.
>>
>>>> This way I'm pretty sure Felix and I can give an rb on the amdgpu/amdkfd
>>>> changes.
>>> If you are worried to give r-b only for those then this can be done even
>>> for larger patches. Just make your Reviewd-by more specific
>>> R-b: name # For BLA BLA
>> Yeah, possible alternative but more work for me when I review it :)
> I definitely do not want to add more work to reviewers and I completely
> see how massive "flag days" like these are not popular but I really
> didn't find a reasonable way around that would be both correct and
> wouldn't add much more churn on the way. So if you really insist then I
> would really appreciate a hint on the way to achive the same without any
> above downsides.

Well, I don't insist on this. It's just from my point of view that this 
patch doesn't needs to be one patch, but could be split up.

Could be that I just don't know the code or the consequences of adding 
that well enough to really judge.

Christian.
