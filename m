Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C4DC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 12:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DEFC21581
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 12:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XWrd7VVU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DEFC21581
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbeHXPxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 11:53:37 -0400
Received: from mail-by2nam03on0045.outbound.protection.outlook.com ([104.47.42.45]:5024
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726504AbeHXPxg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 11:53:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MtvdjbRTQsJNHHISb40sK1QbrLuQ5OpdP1yadGhMqnY=;
 b=XWrd7VVUR3uC4QIhsbvQVNPlpiDuzhW00ALTzXfVwsMdUu5E+6jS0wcu1VwKoSNGph2yiu15FdbrHhnIr3KTHDdXzksB48E3njlWJ7EY3jWqkAFMqHOogT93xzEYwy9O0cwsIiJJNW+7sODn2kNACaW30gN4a22hvCE8lyeBanQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from [IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740]
 (2a02:908:1257:4460:1ab8:55c1:a639:6740) by
 BN6PR12MB1714.namprd12.prod.outlook.com (2603:10b6:404:106::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.14; Fri, 24 Aug
 2018 12:18:57 +0000
Subject: Re: [PATCH] mm, oom: distinguish blockable mode for mmu notifiers
To:     Michal Hocko <mhocko@kernel.org>
Cc:     kvm@vger.kernel.org,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Sudeep Dutt <sudeep.dutt@intel.com>,
        dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Dimitri Sivanich <sivanich@sgi.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Doug Ledford <dledford@redhat.com>,
        David Rientjes <rientjes@google.com>,
        xen-devel@lists.xenproject.org, intel-gfx@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Felix Kuehling <felix.kuehling@amd.com>
References: <20180716115058.5559-1-mhocko@kernel.org>
 <8cbfb09f-0c5a-8d43-1f5e-f3ff7612e289@I-love.SAKURA.ne.jp>
 <20180824113248.GH29735@dhcp22.suse.cz>
 <b088e382-e90e-df63-a079-19b2ae2b985d@gmail.com>
 <20180824115226.GK29735@dhcp22.suse.cz>
 <a27ad1a3-34bd-6b7d-fd09-7737ec3c888d@gmail.com>
 <20180824120339.GL29735@dhcp22.suse.cz>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <eb546bcb-9c5f-7d5d-43a7-bfde489f0e7f@amd.com>
Date:   Fri, 24 Aug 2018 14:18:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180824120339.GL29735@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1257:4460:1ab8:55c1:a639:6740]
X-ClientProxiedBy: HE1PR05CA0161.eurprd05.prod.outlook.com
 (2603:10a6:7:28::48) To BN6PR12MB1714.namprd12.prod.outlook.com
 (2603:10b6:404:106::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0540525a-bef8-4763-8373-08d609bbc803
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1714;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1714;3:WcdFnaP7sqpELyeYhvmPgdohVLTtlw8N1rfn8VEui73Fn2gD5Ka124VnMikt4aZNgi+pm1BhlZp1uOdwzoyRjvWuwXIJXnJMtZMm4/5KkuNIM/SlYC3GCv3S2sCxtcPe+A14LuBoNuKPktO3h0Cq8Ie/fYxHKsVdWrNDsuKAsHYCoOXEmVcj0Sy/m1Yjfx+/6NfIdYv7e9ChvUnUOoBfOSyRaqbMb6l32Wyl0hs1/qEN4HEk8bPXYflBy2YDyDK1;25:NJjw8li8BY2vIIiiSA8xAUDeEfZ/Lsk5UJQYBrUBwJpGj66dZVu01zEzy3V8s2BEFhDoN896Xv6uUqSGby2ml1zownE8giGAGJdvDnkcz+wjokpFDX87olTittK0153E9SHiFEQSBCkyqwGAZYTzpnvL4MWaCNxI6uOlIz++WuI6CFbj1/TOlD6vpLiAiJrv8YWl/Wa7RKyyRv3ZoR5aMFpJewpOaq0HOvFoS1FlY7bQn5UXtRPT3Xg/wpaIosQ8oNCD1KjSXoiFJHxWLFLGFtKJitygH1EqCoPEEm9MCsz9Ulv7MZAjOEAIOwck8etcqCZJfc43Any8VeaaS9tWRg==;31:rv9TkdcUzeGwBzNgZGIo/h6Grx6OVPak+v0rNcC9Jbnv1HVoJofsu9HqXBHrCyAh/4t7zKEG+gdCLAQcAMY7QIbCLdlZUTtTQIHGnBRRD6uYb1wR71j9GFSJRtRoo9zTIL2IQB3Cuxtkn9WE3lS3YsBulWqQkJ1pY0XQJaXzkcnPNYeUiC7jaj7QjtzdHhrWqIs9+7o8lhVvs+jzndoW+GnneVcqHs2QM+k937CyPl4=
X-MS-TrafficTypeDiagnostic: BN6PR12MB1714:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1714;20:EP8+bguGjQLkgGU8hWg16BjOwdIbc3L3tG/CVq3G08GECXwIW5q+Vjkyz7xT8n4LoafYbjE8W4ymf6kB/vIZZxDK0gYs+Yep0cYtUFRgB7Ek+Hzgh69sqq+Eekuy3URCf4X603s9rSC6cuYcN4kQTAumE6iaDxL/Ln6SuO+judQtndac1TiNcmNsEEpsN11j+5vY0+Xd7s/D3TAYMd5o+x5BTENKdbxpgmDSakMzWbV7qIFaYInAGm+IVje+nNk9Q/8xaIU5zHHVXs6v7Npcck+TTc+X57VR65FQTcYmucM6KkyGGUSZ/oqxHZfw4/+IV1/H3qrBqXqSV55y5PXaZR5TyKkK/6Jtj3HWnuoE/kTXKFxOYCNvOqF0/LH4Y25Ez4Hauj8q/dY9HDjceVLdZqZbU4AZ3CtojLM7U+OyxLlLOWD2X91XCvf01wumjLgE5UFaxm0Klrjqw6buJE/jtmiBrEY1x3/1NYoClLurX5fPyoWlmZVjbQMsw2FHW1G/;4:W8tOeCsf2qJVxEtnRzJrPKLet3V5AAM4KDbyedYOH9AQZQHZhS+/CaqrEQyCUgAjr42E6Jw6BfsVHpaYqtZgXoZGWvEzRunAnv93hZR47q4IypIs5Av3Y4C7huLtczv8J2hzpHtvb4Vr08ezhQTL7aA46AGpWD7it3rVWSCDMUVfPa0+fRomV/m9rRKGNOEz61dxXQ0SPd8OTTO2JKmovtRV2FsHJdsIb24UXJ8rgw6o97D8CZl9VYO8ku4jJDUdHemtAA2tWthBYh9TILXpNw==
X-Microsoft-Antispam-PRVS: <BN6PR12MB1714A74ED3528D86895BE95F83360@BN6PR12MB1714.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699016);SRVR:BN6PR12MB1714;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1714;
X-Forefront-PRVS: 07749F8C42
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(396003)(136003)(366004)(189003)(199004)(65956001)(478600001)(7406005)(486006)(54906003)(65806001)(2906002)(7416002)(81156014)(81166006)(6246003)(4326008)(305945005)(86362001)(7736002)(8676002)(52146003)(25786009)(76176011)(67846002)(14444005)(52116002)(23676004)(2486003)(72206003)(52396003)(31686004)(1706002)(50466002)(6116002)(68736007)(53936002)(31696002)(229853002)(36756003)(6486002)(105586002)(476003)(2870700001)(6666003)(6916009)(386003)(64126003)(11346002)(47776003)(316002)(58126008)(446003)(16526019)(8936002)(5660300001)(46003)(93886005)(106356001)(97736004)(2616005)(65826007);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1714;H:[IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjEyTUIxNzE0OzIzOlhKT3o4cE5LMVZPZFNTNWZRb1c5b3d2ZmI1?=
 =?utf-8?B?RXhCRjcyWE92RktUbWpJWUgweS9nbmJLbW91YjBsTGZxcW5iZG5ZaktMZGhU?=
 =?utf-8?B?SkdjMzhuTDdxZ0pFMG9QVkRFSW9MU002MmhOeXZTd2ZWeE9tQnBld2d4dHJy?=
 =?utf-8?B?MlVrODYyQ3J1b1ZjeE9vb1lmSVZ1akh4QUtSZlU2enR1bmQvU3dLZ0ljQjZT?=
 =?utf-8?B?YkZ1MnBja0htZmw1N2RBMlFmcTBUdlMxaHhRWXZ3QVQraTAvY3h4S2lNQ2FB?=
 =?utf-8?B?NWUyRmJGSWdqVUFMdGV6Y25Od3RxQkthQS92SFFZSitqZkY1OU1Hb3pVNEYr?=
 =?utf-8?B?RU5XNk5BcWVYdkZGSTJ3VVNsWDdyTDNiUWZvMDZHbTMxK3I3Y1RLaG4vMm9J?=
 =?utf-8?B?emsxdmhBcWRpOGhRR2dzWXBubTZwK01WdmNSWlE4bk1WZXdoTXJMR1JmOHJS?=
 =?utf-8?B?cG5jak44OVhhRkpuRDNFS281M09PNFpSMTRpZFJGZGRHdTNpd1dsOXNvSHdi?=
 =?utf-8?B?QythNklCQ0lCY2w2Y1dRWk1HWEdMRmtjYnI3b2tVUWtSZHEzNnBSZ0JNV291?=
 =?utf-8?B?b05BTGppM3hTN3FwaXBrQy9XL3J4dFQ1V0ZKK0cvcUkwVjdDWEFFRTZjcGJy?=
 =?utf-8?B?OVk3ZHNPdW92N0lxZnV4VHRDeGlIckg3eTRPR01JSGg3Tk04a05SRE9BMXpD?=
 =?utf-8?B?UDNFV2N3T2FiMDNiTlpHNTFXWkM0c0NWeDhpSnhUeUp2R0h4QkQ0K0RmN0c5?=
 =?utf-8?B?NW1IK2lvbW9mbndKL3YwekJzSUZOcjE0SWtnMU82eVBBeTBEV2dHOTlBd1Q3?=
 =?utf-8?B?SStjKzU2QlVRbHl4NzZKVHpRbjFkKzZxeEhpeWNCeWkraHZXb1FGTlVHdnFC?=
 =?utf-8?B?ano0MEk4Y0R5WndyUVVidHdvLzdEcFdoYllZTWgxMlhIVmh4VmUyZXI1dUJ6?=
 =?utf-8?B?ZGVGUjZ2VXhzMFY5V0x3NytTSHBrV3VyM1JENVpkVzNhUWVHbDZhN3pBQUVX?=
 =?utf-8?B?T0hERGNEV3FyVVRZcFA4bVVmUFMxcHBUZWRtUEhncGxUOFBpeExFVnB0cUFV?=
 =?utf-8?B?bU5LNkN2YXJIckNGcnoyQmRzTnNZeU9vb0ZwNk1lYkRrTVRVM3ZXMVRJWC9G?=
 =?utf-8?B?QldLSjFNdEE3Y3RoeGpMOUhYN1p1SXpwbVp1VlR2MmthK003R09keUJnRCtP?=
 =?utf-8?B?VWVVUTVTdGJYb2E2L2tHYUY5SnVzeFVpOWJXU2duY3BEcEVqQ0JwTjJtaHNs?=
 =?utf-8?B?VlRYZk1DT3hYQzZkeWJKU21waWpnVU1CQTgwWnRuTnFGakF3U2src0lvV0lW?=
 =?utf-8?B?OTZTUS8wNTU5S3BjdVU2TjFPR3JhYkZrN003WFZXbFVBeFI4T0xBbmlQRnk0?=
 =?utf-8?B?ZnlIZFdiTE1vbm5mZFlqMm5zZ1hLeklZUE9GaDNoaHRVUGFrcjBFWEdPWWpN?=
 =?utf-8?B?MDBiMm84bFpKZVNCNWlpTjBMdmt5eVBEczVvYVE3KytZbU9CelVKS0tORUtw?=
 =?utf-8?B?WXVtNFdCbzVhR1E1SllwTFJKWXdQWlMzMWJBNEtkM293K3ZDV3VkcDh5MGU5?=
 =?utf-8?B?UWZGWHYrTUFEaTlsNjl2ZFJoTWxVYUpPeVVlQWdDdTdUcEIvV0V5UVJkM240?=
 =?utf-8?B?eEdrSGhpaVB4dk9XVHc5YU9Yb1NwQ0p2NzNhcDN6WVpEMWxGMWJCY2NxTlV5?=
 =?utf-8?B?NGRBTk85ZjhqRmE2OTlVMzRBODZFQ2dHZ05xRmhKWmcrdWU3V3hNTzFTZzdv?=
 =?utf-8?B?eDFCaVdUQVcvNThqcXBiS29vWlV6Y2pyOHN1Yzl6cmtJeTkvU0JLRmVTTUoy?=
 =?utf-8?B?RTI2MFIzNGVEUE5udEFPWVlOUi9oaFM5NWpiUlppMkh2dzQ4NUdwVy9JUmxa?=
 =?utf-8?B?bWY5VWZBSDBtS0kwalhSWGZZb0ZNeTB2WERVUVJySjdmaEVGRWxWSytuSWxz?=
 =?utf-8?Q?4OozIGcMsQnRnzlwZCqZGtVEbcE+tc=3D?=
X-Microsoft-Antispam-Message-Info: hFN/nGoDE59smWT2/D59+zf9Jye5xZM3EV8ehE4Dn9N1491vnEx08gnUltt9yOdTjxKCB4vzBtppbCaEYPIZMqeV1C5aa5kOSoEPhFRdgJ0uvIROtTcrqGfso7gyK3lFjTAxUYqiGHMl/ano+FQLrqKJkm15QzvSl8cOHpzpH03WCgrE3meS5KsFcJiTKx8W12P/gQqts9yFH8uABMx7o/A6ZH2MDr+Y1bFCslh/4XHJozpn4XoI25oSeTrZvhH1hRK4xVBoB+p7e2UrhMLvUesiMz4LTpG4zHx5gWWGFRh8461cfZOFt8ZlSLOJzo0mEnt6A7IDsFEOZpI1z3W5QI+aLWszc4nbECj+UzrxO8c=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1714;6:11Bve1L1f8WamZZ3qM9DYBE9vsUJ5Dn0nj9eeWgxHrQV/Zf9XkhkF3e2SIxYVgSbJc8AlMUXwtikAEuwDFCNztB1SxkPKNOdIdc3BIbU0/xk2uIRhcGA+RFts9yj27Dbm98swDiNXir/VT9GqcaLbol88afbYI+hfC8tTMawgisE8Sg/TK1HgwR0tUHqI2TBGvHBSLciY7Ra/g0/9qypPuMv8YUFue1Jb38giBd0vThVJ3w49XrU+ODUU4Diw82XZVDDRc0ml55qlp+hgPdqRw6vP+UatPJdfLtzMjOzSaKlwmea5gHYZ4RuWG8UCDVXWCdyDDn7zHWqP6yaAgvU5E2mPYzeHcfxJY3Q+mQmXLcxrheua4zm4VpjHnz8ZNYSuMtLUDKGdH6v4WShSoY1oHE96xLdn8EKHwwffjMfqwMEwyNkr0EgF9qdS4Em/3R8N1FCDcEHuZIcKdm4YypcBw==;5:fNO8woVj/2enkBv/0mMIP2786pwWRN2SH16S9tDlUmtWdyIrEtsVzm/IsVbsuD1Nv5CDPfAPNeBOpB7bnt+f3SNJ24xfqwjYbgbdcZcD1Ya/EyUkGefTrG/Jvr8ac9fTs1OYPOWuH2BklRBlM0U1YefMUKCdk2SP0SzT2JB/Uxw=;7:H7FAQRnZAVnyu4sSys+9LVLr1Y+14u9uHn/AM5tYi6avniT3zQ5l1gn5AgBDrETZ8AXvV2fasT7APzRMYIep95mQ9U9ZRgVoECJ2qDtEjY/F98lhlQUrrMCc9J2uxnFSdeik4lWfj3PSsi3TIuNS9pP4hMgeVcxp0FcGWztpIjWWu5RsgI/PEtvtDqoC9NF8NBZxw3r9I7mXGZiZFYKb1J1n/CbeOdLQ2G4P3P2MywHwBtCiTXOp/4/41AkNMf97
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1714;20:NQs0tbesGiASdw5H1mR4TUI93PySqyOaxhDYuLtsCy91Fng0fBupQAx1whpTbQRNFFO13JMBEnU/CDBM5/5QOLABQZywXnaP70jPcDR4SpKnZO932hsFenea4YTgLXTIEn33rTEeoFdAxPrslWJucqhJcE5zi+5NmjZ9KRYR5OEGMqcmr85Vg7YyaNfMPvtiR6M2Ee2P5ImgWdtHmaZUdD5FayvTIp6hLmG9cJ3ZJbpVfRwWDyBiLLovbzw+5MFm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2018 12:18:57.4261 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0540525a-bef8-4763-8373-08d609bbc803
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1714
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 24.08.2018 um 14:03 schrieb Michal Hocko:
> On Fri 24-08-18 13:57:52, Christian König wrote:
>> Am 24.08.2018 um 13:52 schrieb Michal Hocko:
>>> On Fri 24-08-18 13:43:16, Christian König wrote:
> [...]
>>>> That won't work like this there might be multiple
>>>> invalidate_range_start()/invalidate_range_end() pairs open at the same time.
>>>> E.g. the lock might be taken recursively and that is illegal for a
>>>> rw_semaphore.
>>> I am not sure I follow. Are you saying that one invalidate_range might
>>> trigger another one from the same path?
>> No, but what can happen is:
>>
>> invalidate_range_start(A,B);
>> invalidate_range_start(C,D);
>> ...
>> invalidate_range_end(C,D);
>> invalidate_range_end(A,B);
>>
>> Grabbing the read lock twice would be illegal in this case.
> I am sorry but I still do not follow. What is the context the two are
> called from?

I don't have the slightest idea.

> Can you give me an example. I simply do not see it in the
> code, mostly because I am not familiar with it.

I'm neither.

We stumbled over that by pure observation and after discussing the 
problem with Jerome came up with this solution.

No idea where exactly that case comes from, but I can confirm that it 
indeed happens.

Regards,
Christian.
