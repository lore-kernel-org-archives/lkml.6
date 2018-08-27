Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C44C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 07:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 646942084C
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 07:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="NMOyG9b6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 646942084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbeH0L1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 07:27:23 -0400
Received: from mail-eopbgr680072.outbound.protection.outlook.com ([40.107.68.72]:5536
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726882AbeH0L1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 07:27:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QFmcbXk/+f4jQy/M0FsV3c4bqRWfvz4GpdRrsy/qCjs=;
 b=NMOyG9b6wVSbPgrkH4xZ6qynPHjEUloOrkrmrwxUd/w2k5u/3UQXnk58mIClcR6x/jp1P/6sidmzbXwBIfadKUkPlfBh6tBugRLsYh1oShDs7ss4AeBxYLcSj8jE4TIHKirKHHRDKgvX01ai25SayAmhOnNxIwFjFnYgGIeXEfg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from [IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740]
 (2a02:908:1257:4460:1ab8:55c1:a639:6740) by
 DM5PR12MB1723.namprd12.prod.outlook.com (2603:10b6:3:10f::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.17; Mon, 27 Aug 2018 07:41:40 +0000
Subject: Re: [PATCH] mm, oom: distinguish blockable mode for mmu notifiers
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Michal Hocko <mhocko@kernel.org>
Cc:     kvm@vger.kernel.org,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sudeep Dutt <sudeep.dutt@intel.com>,
        dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dimitri Sivanich <sivanich@sgi.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Doug Ledford <dledford@redhat.com>,
        David Rientjes <rientjes@google.com>,
        xen-devel@lists.xenproject.org, intel-gfx@lists.freedesktop.org,
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
References: <20180824120339.GL29735@dhcp22.suse.cz>
 <eb546bcb-9c5f-7d5d-43a7-bfde489f0e7f@amd.com>
 <20180824123341.GN29735@dhcp22.suse.cz>
 <b11df415-baf8-0a41-3c16-60dfe8d32bd3@amd.com>
 <20180824130132.GP29735@dhcp22.suse.cz>
 <23d071d2-82e4-9b78-1000-be44db5f6523@gmail.com>
 <20180824132442.GQ29735@dhcp22.suse.cz>
 <86bd94d5-0ce8-c67f-07a5-ca9ebf399cdd@gmail.com>
 <20180824134009.GS29735@dhcp22.suse.cz>
 <735b0a53-5237-8827-d20e-e57fa24d798f@amd.com>
 <20180824135257.GU29735@dhcp22.suse.cz>
 <b78f8b3a-7bc6-0dea-6752-5ea798eccb6b@i-love.sakura.ne.jp>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <0e80c531-4e91-fb1d-e7eb-46a7aecc4c9d@amd.com>
Date:   Mon, 27 Aug 2018 09:41:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <b78f8b3a-7bc6-0dea-6752-5ea798eccb6b@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1257:4460:1ab8:55c1:a639:6740]
X-ClientProxiedBy: HE1PR05CA0138.eurprd05.prod.outlook.com
 (2603:10a6:7:28::25) To DM5PR12MB1723.namprd12.prod.outlook.com
 (2603:10b6:3:10f::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a0b4e90-0dbd-4f2a-d477-08d60bf08b63
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1723;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1723;3:06iM0ydyjyM10NMhvMgba9rytzsd+qZvf1vCkl0khqyJJztpCN4iagipzWfIaFgpuMfH+f8oPKQNfjCJBBsPEJQAt7aMar+n40lCAq1JoQflJ6+dTUAjz46tWLr7h+Mp+N1uiLXKiSf+RgwsvWFgj6G1SuL3dbn+SrQsL2aceMsF7jt6hLKAOsUvbO9Jp+ffhKrmgNe9Xe5kC6gCRQ0ff4+RuJLcbe9JzuXmbLhOabfgFfL/HSu/NPShrt7ZFq92;25:Y8skNpKpgzJeMrlG/F3vNbcFb+1k6Msm56r97EgUlSqEo1S5VhBoTr9QfylTrA2hjAWHT16LMeTD8duaM0W54DxD2Cltm/3l8A+6rpSTxmRmk+KTvXr1Q5/Ex/CGqPoq1VQ0R2RNzthtCTSFGjl74MrB4Q1OQoxPOvn5IkNIAcn3zYfTCPKoioucdfsR4Hc/vl3cdyYDmRpSytG4FQlcU/wriy2w7eRD9vOs/cPsvPAOrL9GKAgh6kDZCfoNeLMEUC05E18JVzmxpde8qP/cf7ulne2oQlDyw3PEHIj8jiX84UhzwtjANWv9gIKi2WQeiJF9j2fa4YWyzXZqQtXZTA==;31:3TnEQpFRSprkmHeMrWHxSxIVHe/1F8/WFXKHvD0gWLUSXRC6GVhffLdz9Grz7aKM8NUof4hp5FeTNbEbkwHi2UVWZ3Zup1ab3KhqmoM6Ov4V8UcxJIypgrrQvkUOv7Zj8BTJSjWrQuiGvda7x5Ww7rNlHEXmPL/3z7U7B81yz6y3+dVO4O9x13XlAK4J3yAwLacdjdE/pm3GN2ubCN3b4au49ukLJQk8+ewfeEX0Y9E=
X-MS-TrafficTypeDiagnostic: DM5PR12MB1723:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1723;20:y6BaAQX+wSEA2kd01oHrrqkMwdT05+kR7m+ie7WXqO20MNfwOiUK4BtSA3OcnyhjQ+DdsjrBHMqX1YnnqwRpZtCexNECt/hgvhnHOi8ipTSK0MfL6csOyYMevv9ZT9QXiZ0YProVN5JfaFsqueUImlS4UkER3t9MCRtFFTFirLRHUvrccWWIg8q1xcMxphWHPVK2G03sMGEbvcU34he+r3jn7SN+yKF+EEo8o8JSJquBO05oFEpEjIKe0lXc280YVazpDfx1nc0bmQK4L26rHMG3pIQx34ELsfbHuRRq8vnOwXeq5jGOaI7oPItMtnEHgmrh4AW2adgAixbVPnYk1F3qeXzmzIjFvuvXfyoDFBkcgq6Yan9rmTipnoHwg2Sy/cXDvibIvQUJODg5a9+PI20UrTvTpDkX51QkXP1oVRVtlp/8Ck9EhPyJqO54Gn6gBqQPu7PkiXsi5sqaJXx/IYWqoAm3GYbwli/7pD60fihG7OgAcHqt2nD0SOe77Y6G;4:jAy2zR+chTxpfe/HL1fjKPhCQ4aNicEN24U6pcdQAFtDrfuL0X/XIn5wB8wHAGW4R7TkkF4iNI87MRC0d5lDHbb3vBo16KBQbrxGZ6jSv8PPp6PdwCI2lYveyyLwuBePVFBLcbcmEWh3G0BWmHDtABHthpmp1uzh5Pq8+OnUibUp5SDXIJ16m/JP8rLmyWmY6ccwBAsyF6ee/z/+/UoVURM9ekbE1FmgxD8nkfJYGA1mClkBWJ5IZHhx38cvrNGz/ZOesIhMe+wN3WnEBx2rRg==
X-Microsoft-Antispam-PRVS: <DM5PR12MB17237C4B40CD3FC7AB74C834830B0@DM5PR12MB1723.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201708071742011)(7699016);SRVR:DM5PR12MB1723;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1723;
X-Forefront-PRVS: 07778E4001
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(136003)(366004)(396003)(346002)(189003)(199004)(97736004)(64126003)(105586002)(81156014)(316002)(53936002)(72206003)(1706002)(6116002)(81166006)(106356001)(68736007)(46003)(58126008)(8936002)(478600001)(6486002)(36756003)(16526019)(31696002)(86362001)(7736002)(305945005)(53546011)(7416002)(229853002)(8676002)(52116002)(476003)(54906003)(65806001)(67846002)(2486003)(52146003)(76176011)(23676004)(5660300001)(6666003)(65956001)(65826007)(93886005)(230700001)(4326008)(31686004)(25786009)(486006)(52396003)(110136005)(50466002)(14444005)(386003)(6246003)(11346002)(2616005)(47776003)(446003)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1723;H:[IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjEyTUIxNzIzOzIzOjRhdHhuQ1hWQ0tOYVNGNlU1MHhZWWEvMXgw?=
 =?utf-8?B?QkRzUUlNclVPcGc3TFMxOVlIQkVRUEJuT3YvRGRZNzBDREtkallVRlVkdjU5?=
 =?utf-8?B?NEZjazJvVXpnNFo2UjdFRS9aemlyZDBqbTJDTmVDS0dhT2RXOEQvVXphR3FJ?=
 =?utf-8?B?MGo2dXo4dkozbFlLaU5Dc0NXakZjNVdqTW5LYUwycERuOXpDSFR3SE1GclMr?=
 =?utf-8?B?QUUyeStWNG5IcmRqSU5lV281SjY0dDdFUG5hR0Y3MkprM3d5Q0I4SzAxblQ0?=
 =?utf-8?B?VFRtRXJKNzJBeW1XQ3V4RlBYeldVRU5oUWFmbmFKQTVwL1BaQ3BnS0s0QXd0?=
 =?utf-8?B?QXdKQWhlN24xQmF5Nm1NY0hlVmFqazcrN0E1SG9YZzhtOUxya2tWSjdRTERk?=
 =?utf-8?B?M0E3RFRNOG9lTDNGRnNZVWp3aVd3WWFJRlJKZ2pKTkQ5SStMVWMzb3BqMHRO?=
 =?utf-8?B?a2ROdlBMMnZmQy9VN05FZC9kY25BRHpJU3pxcTZ2SVJPSzhkaVV1R3FaUWQ5?=
 =?utf-8?B?dmNrdzFrd2M3UWx5YjVMRlZlOVVQYUI5bG9SR3BaNTRwNndqaktlVTlxYzAy?=
 =?utf-8?B?d1JDZTJ3aDkzdElZVUJ5K1BIemFtQmJtVXpmTHlzUjdRZEJOY0dJU1dIVlVO?=
 =?utf-8?B?citYYnhNQ1ZXa3M3MzU1YXBCSVZvZGhrSkh5RXBIR08xd3l3ZUhOdVR1SUhy?=
 =?utf-8?B?UGpDRlU4aXFkK2RqNUFnTm81RjdBSENHQThyT0FjVStSMTErNkpEVkxJTmdw?=
 =?utf-8?B?L3cyaUFnMUdWVlptVzNXQ3FjY0VzeEdXQXAvUGNML1BXay9DQkRjcjA3YmdK?=
 =?utf-8?B?emZGZFh0RHAyQWdPS2s4TXp1b2VGamxXMTNoZnBCMWkvZ2J3d0dNLzlWRXd2?=
 =?utf-8?B?aXFPVWFjLzFhUFQrcEtnbjhFK1FCYngwQi9mYXhURU9WR1dFNXZlYThFcDdl?=
 =?utf-8?B?UndHR3dTNHFIWDUyQlcyVVNWNHRtMllsVDh6Z3UxV0lFRGV1dkdRQVh3bUFn?=
 =?utf-8?B?T3MrdkxmNzAxWlZUNVJvcEZLSFBsVnNZYzlmSVZrL01rNUgrOEI5bk9vUGhp?=
 =?utf-8?B?WWczQmxSNEdQYlBScUJZcnVrV0F5dEhFTHF5K1JlZGdTeENWeTJBeGVyeVR6?=
 =?utf-8?B?WTJodjhMTlNsZ05KVmtlb0l6d3U4dFB6NEN6cm02RGd1NWVkc0Y3b0kxNkJL?=
 =?utf-8?B?NEhkaXVBMUdicUFkV215YjNtS1pSY0VoK0NEWDcza0RHS2kvQVBtTlBkMGtI?=
 =?utf-8?B?Slphd3BBWmp6MGZlTXJEdm9mVVVVcmpmVjdsQnYyZmRXYnZLWUI1cEw0YXRq?=
 =?utf-8?B?cW9NQk5QOTdiczl1aFVXQkNuU0g5ai9oOG9QeEJ2ZStCQ0VOOHhiNFltQ1Zt?=
 =?utf-8?B?bUFiWml4ODlYUXFOeUNibEY4TXplYzEwMmg2WnY4aEVwc0JiRkxCS1pEZGNY?=
 =?utf-8?B?WEZuV0NIbWZHT3Q4Y09DZVd3ZVRwNjk1RmRaKzYzWkdPV1hDckRZTGhubFBV?=
 =?utf-8?B?VWM2cUJkRDBnemRYNG1NWjdKbXl6d05tZllNOW5sZ0JnVVZKUm5lMHcrMGVQ?=
 =?utf-8?B?eGhLY3o2NXE1UFNqUk5KNU9mdWpSNExubzZoSkk4Y3NsMElIT21obTA0c21j?=
 =?utf-8?B?amdDbWwyTmNhRXJmRXVoemxXZ0t6eFUrZlU1azNPbUNCNnErSnFtVC9BeHhD?=
 =?utf-8?B?YjZTWFR0cnEvZ1oxZ2NjK05XR1BiMmdiSHVWcno3d3g5YTVGdlJlL1ZLQ25J?=
 =?utf-8?B?emJGc3BCalN5WUFxaGdoTlUyaVlXRTUwVHN1OEdjNkk4TXp2dmpuTVc2eXMy?=
 =?utf-8?B?L0JFNHA2RGVBQkZVWXBTQ3lHa0VGbkR5Ti9DVEd0WDRVTDRIczVJMm8weHhC?=
 =?utf-8?B?TlVSb1Q0bHNldnZEdHg1RTYvUzAzZ0pQUVVnNzBuMkZKVlAvNUFvTzdxclhm?=
 =?utf-8?Q?82PQGOvkM1asChf67p6SFCxK4lMLTk=3D?=
X-Microsoft-Antispam-Message-Info: +dqVseecARSEVPWbS4Xh0DCm5gxuO2Ao9BgiaaNINlCiLKUSDML4jgVkWbmFKjS6rYnxWRzpTr8Rm4e8pxdykq0ogyT4C1sJLfBd78f7sq4mgzwKHyPVgNOy43xj9882celD7mw1fP7VKziGdU9NYD5z1CZ2k68c4Px7liFK1EFEJwjaXLDHWTp9MO0y38EJ5N3b5WAcCEohC+UMnLDt3jHqSI6HyAA4yoH2uEceFdFjZaNYHXTy6l/QA+6EO3/k0l2rsdHnQzk1qexkUivjw+lzqt9UGQlH6ii8Sewv0S6YY3ZZTDN7qF36fVyJr0aGfOXxefErqCj8bv9gV53ltboAijnpe+SAG1p0b9qtd2c=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1723;6:/gNO1avvCPIdOTp8vAhkEYBpI5aTNL4x8Nx2MpYol8lE0qWS3X4ajpjMWNI9F08b7683K6NNJyddpIMSLqI2Wwa5sc2UYdTm2EIL09VsjuGZ1GKAKcgMcCUxd2tPHKAphdX0NXYvEJA26BkB+jRjqTcTgW/1JLCUPx8Olp7nLiI1mwQRvXtSUIpdk4ita2ZCUit/AoA3W0iyaGZ9TePDmcTCR1VJ3Srs4B5GOCuneDzFkhXq5iRo22PXRh7Cuxpqlm+f/audyAVg09Iw+qGTI97UpSQQH5pwFZpyC2s7c4fxWdo8l/WHW0SN5LcuKF7/44GbAODVQRAbA2ePFSNeuKt2Hta/EyD9GnR3wSuEp1OCzU28nK4Q3VnzcP+w5tUiG/v4GaZmw7GZkB7f8BBQlzB3vqzJsJYJWtgHEStwF0X0ODfpASoFsRDvsxDQ/EPMI/SbtzXHNZnkNROBzK8e9w==;5:+zETMBEKCqljTBnN/S80X7cnaoZxKDPe91Ba7X+JMDCBPTI2JU97drPukJphBBTqXBixI1pGmAWtqsfmjJ+lmG4upFYhBYrdU41YuUp02Y0WJ3mionmfrnEyzLb8OHsSi4w7/JmoXD+aL4nKZSIZYmzGYlh7IF2O22LGDES8M84=;7:iiOENYdYFMnmrF+s64KGYRqoTwiYu5J5c86gXLdG/u4iswlz+UAfVqHI8l2Gti4r9KB+Yl4U3FGf9/yhYaLO1BEtHodBCDdFnpNiUTikesYiAZjBKgE7WwNA6UHZ09ePfWGhSse1/i3/XLUxd5jYJ9tB2pdrW6lSgYp2YujLkAlBiVZZ1qcQFlGsVWT2xXUcO9y8VszLbiGnfxwakRWz/QcP3Z5ojwBv0qh22tg4Bs8ryczs4T5Q+cWhucteMFuS
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1723;20:1pmGR1nKgJPWwVM9aBnzWs+/Xrm8e+mW2Eq1HsG/GBSDjibumFO6BMFoxzkiJeNUmw1pn2QirJvIdKFtqwWymd5QUz5S6zcBiCKHhYsAQ4EJpsxpKl/nUS7u+Pys88/gxYbSwF/CMpLi8zekWDPGYeSW1uQU7EiYCDzYTpLQKWYsREO7hxT3yYZh/u++gaBSMbsCpO6WLlPb/DPZGq5QaYIfNt4Fm/fK19ubsTm/L4GWXsUE9HAqBCe3SxGteRay
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2018 07:41:40.7917 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a0b4e90-0dbd-4f2a-d477-08d60bf08b63
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1723
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 26.08.2018 um 10:40 schrieb Tetsuo Handa:
> On 2018/08/24 22:52, Michal Hocko wrote:
>> @@ -180,11 +180,15 @@ void amdgpu_mn_unlock(struct amdgpu_mn *mn)
>>    */
>>   static int amdgpu_mn_read_lock(struct amdgpu_mn *amn, bool blockable)
>>   {
>> -	if (blockable)
>> -		mutex_lock(&amn->read_lock);
>> -	else if (!mutex_trylock(&amn->read_lock))
>> -		return -EAGAIN;
>> -
>> +	/*
>> +	 * We can take sleepable lock even on !blockable mode because
>> +	 * read_lock is only ever take from this path and the notifier
>> +	 * lock never really sleeps. In fact the only reason why the
>> +	 * later is sleepable is because the notifier itself might sleep
>> +	 * in amdgpu_mn_invalidate_node but blockable mode is handled
>> +	 * before calling into that path.
>> +	 */
>> +	mutex_lock(&amn->read_lock);
>>   	if (atomic_inc_return(&amn->recursion) == 1)
>>   		down_read_non_owner(&amn->lock);
>>   	mutex_unlock(&amn->read_lock);
>>
> I'm not following. Why don't we need to do like below (given that
> nobody except amdgpu_mn_read_lock() holds ->read_lock) because e.g.
> drm_sched_fence_create() from drm_sched_job_init() from amdgpu_cs_submit()
> is doing GFP_KERNEL memory allocation with ->lock held for write?

That's a bug which needs to be fixed separately.

Allocating memory with GFP_KERNEL while holding a lock which is also 
taken in the reclaim code path is illegal not matter what you do.

Patches to fix this are already on the appropriate mailing list and will 
be pushed upstream today.

Regards,
Christian.

>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
> index e55508b..e1cb344 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
> @@ -64,8 +64,6 @@
>    * @node: hash table node to find structure by adev and mn
>    * @lock: rw semaphore protecting the notifier nodes
>    * @objects: interval tree containing amdgpu_mn_nodes
> - * @read_lock: mutex for recursive locking of @lock
> - * @recursion: depth of recursion
>    *
>    * Data for each amdgpu device and process address space.
>    */
> @@ -85,8 +83,6 @@ struct amdgpu_mn {
>   	/* objects protected by lock */
>   	struct rw_semaphore	lock;
>   	struct rb_root_cached	objects;
> -	struct mutex		read_lock;
> -	atomic_t		recursion;
>   };
>   
>   /**
> @@ -181,14 +177,9 @@ void amdgpu_mn_unlock(struct amdgpu_mn *mn)
>   static int amdgpu_mn_read_lock(struct amdgpu_mn *amn, bool blockable)
>   {
>   	if (blockable)
> -		mutex_lock(&amn->read_lock);
> -	else if (!mutex_trylock(&amn->read_lock))
> +		down_read(&amn->lock);
> +	else if (!down_read_trylock(&amn->lock))
>   		return -EAGAIN;
> -
> -	if (atomic_inc_return(&amn->recursion) == 1)
> -		down_read_non_owner(&amn->lock);
> -	mutex_unlock(&amn->read_lock);
> -
>   	return 0;
>   }
>   
> @@ -199,8 +190,7 @@ static int amdgpu_mn_read_lock(struct amdgpu_mn *amn, bool blockable)
>    */
>   static void amdgpu_mn_read_unlock(struct amdgpu_mn *amn)
>   {
> -	if (atomic_dec_return(&amn->recursion) == 0)
> -		up_read_non_owner(&amn->lock);
> +	up_read(&amn->lock);
>   }
>   
>   /**
> @@ -410,8 +400,6 @@ struct amdgpu_mn *amdgpu_mn_get(struct amdgpu_device *adev,
>   	amn->type = type;
>   	amn->mn.ops = &amdgpu_mn_ops[type];
>   	amn->objects = RB_ROOT_CACHED;
> -	mutex_init(&amn->read_lock);
> -	atomic_set(&amn->recursion, 0);
>   
>   	r = __mmu_notifier_register(&amn->mn, mm);
>   	if (r)

