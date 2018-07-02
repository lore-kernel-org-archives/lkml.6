Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A74C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 09:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEAAE252EF
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 09:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ys7Npd/N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEAAE252EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964855AbeGBJPX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 05:15:23 -0400
Received: from mail-bl2nam02on0072.outbound.protection.outlook.com ([104.47.38.72]:57423
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751455AbeGBJPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 05:15:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rPF9lbAMjERK++4hqvAFAZO/EuwwGQRrrfE/WgCHYWo=;
 b=ys7Npd/NAuApVGaXninRIs23p6gVQ4/K8ZLHDnm8S85fHOLg9PuayqrzzRma3t2Yy0R18EAg5Vq0MJSsdWLFxIqu7orBOPupWIkPHhKHvYN2sMRMhyYOwtg/Wrnb4YQK/ThU6KIk0vLqa9V2crUD2hYJkN+bleA7cHMzHufgFJg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from [IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740]
 (2a02:908:1257:4460:1ab8:55c1:a639:6740) by
 CY4PR12MB1719.namprd12.prod.outlook.com (2603:10b6:903:121::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.20; Mon, 2 Jul
 2018 09:15:07 +0000
Subject: Re: [RFC PATCH] mm, oom: distinguish blockable mode for mmu notifiers
To:     Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
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
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <71f4184c-21ea-5af1-eeb6-bf7787614e2d@amd.com>
Date:   Mon, 2 Jul 2018 11:14:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180627074421.GF32348@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1257:4460:1ab8:55c1:a639:6740]
X-ClientProxiedBy: LO2P265CA0098.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::14) To CY4PR12MB1719.namprd12.prod.outlook.com
 (2603:10b6:903:121::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ac745bc-efea-4cc7-c268-08d5dffc5184
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:CY4PR12MB1719;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1719;3:CuZC+on27qNX3Z0rC5LDCDrJKM4AeEwkM+B4t9rBsE1sHh87hH43q04KoPQgsccP3apTdezFbjMnuYpN6/x3bVwJYG1O101qOa6wk8inRZ0GMNA9+CRQy+AFNhkFEMCheadTRWO+gll7PIkpwTBeEsFQLiclwGMbPK4J9vz5WarRqwEwBdHu1SsPzZzQg0N0MrVPrZyEKvxfkJImYC4+ahVtSdF2XRt6Nknv/QcBrEEiaag6iBFVOmB7cdO8mzd1;25:hnTLPxdvTQdyWeAz69z4B05WbnfKJSbbjnCnWAJhi71WtoRfm4Kkbae84u9Dkcguick7k1qOkwY4IZCR57iz7nCTTvC1TyvxBPDniK7HbqzqmF+eCn5HnHvOgu/ox5sqJD170bUkpyejr2fPmCy/jPtEzElx0LcWnwZDhi3THV7by4Hvnm9DnIFh8CjYCrA2Bk2rBBWHMv2P1825jAk38hwbxowOvbyRdr+E1Ev+HzQG9y4ZLgTtcp0ORpbm5OoH7ksGSqBcoMWVUnPehJ5XhXAapJG7DqfF69cqcFApMENMqi4c/xYPiSyviiOJzblw480gqo6ZmeK3LrA3Xd7fPA==;31:0M8J6E9Vb0UKB6CLkbt/AsvnJk3baXQ1lCSkAo0Ls63gaJgpiEjH8+x9PNJ+MnWjrmzMboeJKY8+LQcss+GYf7YdoDsBSyz+O1JJijJx+U1JiclIQ6STjWkkyUzeOkpZs1RSAXVPPlOG5O3Q3kA+pKKIMRbahjWyX8ASaea/ls45fQG5hZ3dVQApKpxDEIxwlABuNU2l0gsK5eQ06020HQp5FkbnpI1zR+AgDB8bwYs=
X-MS-TrafficTypeDiagnostic: CY4PR12MB1719:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1719;20:vQrw+b0H2t2ZlCrphU/cQz8rj5t2o/TJtbpffIlZduwQfDHMyO/N5b+LcedV2lquUQlWJ5wtnvOu9wZ1zLlnMW0Nu4RPEKKrLproOpVMYN7EXbyjlt7awutEeyyRqnVBxfgJsFv5TgZ+fU81WVg3qk40ymSUhL31q/VptOvVVGqb3d/ccm3ukRXF5TcrWEchM41iIWw7RtZ/xqSAUlxs9ovQmO6LehR6Vk8p2Qz1r6paWaClE340gyeuLPy3TDaqZZPMNK2bQsLP8k3fziLjWrUenEGFP9aQz0KWMQ5yXoFWW7V7PqCxmwjl7XciVET7MofE6O7Ws6bh+da0LZY/RCNcCfi1guOaeIzGXfT3hZfDxKmfSgOJuL6BCSswMqLACvjbhvNFna3obMgV9WEuhoNMVYrfhSjuWEn3vkd7tsFX7NvYYTMcnVc7930PnfPmB0dCgKeGwN88ZOCx6Dw8TxvXg8TdPBe4RzjeZyGfhXjAq1FHSfl+HGD5i+R9kAtp
X-Microsoft-Antispam-PRVS: <CY4PR12MB1719073AE7BF8869FD61EC3D83430@CY4PR12MB1719.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(767451399110)(58134797142442)(211936372134217)(217544274631240)(153496737603132)(146099531331640)(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:CY4PR12MB1719;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1719;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1719;4:OsQ+1o6PLKMl+nTkyyIBfcmn1X9GqsbtrTkKhD14yk48hh0STBegv8VV4PvrqkfwVpLoY3JsbguHLtxDhVBGDf9CMHepjzgd85sgZF828gm6C3FFHBPQTcYcujfgUq/uI9aBvnyLkjI4lQKScNqOjq1lRGQOsAlmF/7oLKdfKtxLymxVCTHFMpkZjhnG8wpLqk6FfgBX8TtlvhuqjgA8N/CL+aAnzh7LgLckVhZ0RndnWHJfVHxv+EKJfRUmAt7IPFmQisTHJpc1yij9YeqyY/Lk/Pw2VV0H9tKefwhnILQ5wzmTtYuLE0HOVi0ElwsQ3l0GegFmBEp/mnR/vRRvM4Gw0F5Cfu3M8Fza8SMv8tDZjPlZdRc2Twi4MFY1ckU6kKd9hXZlnF+Q5rZPYXVPt11JsaGQQnsRgxk5PxcaZpKP7oDZMw626AU+zDdtUVu6i4hqz+WYM3TG0hzcYFg+X4+60Ryv1C+lVFdqtxwasmZTPzDLuGcO65yvcH3UunebZmlz0oPqxigxFCcbjPXJnrwJSw6wE5QgDN9+ytNtSHc=
X-Forefront-PRVS: 07215D0470
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(396003)(376002)(136003)(346002)(199004)(189003)(64126003)(23676004)(52396003)(53936002)(31686004)(53946003)(25786009)(316002)(110136005)(4326008)(52116002)(54906003)(65806001)(47776003)(65956001)(58126008)(65826007)(6246003)(46003)(386003)(16526019)(53546011)(2486003)(52146003)(478600001)(76176011)(6666003)(67846002)(72206003)(6486002)(106356001)(105586002)(68736007)(7416002)(229853002)(1706002)(5024004)(2906002)(2870700001)(8936002)(86362001)(11346002)(97736004)(486006)(575784001)(2616005)(446003)(50466002)(14444005)(476003)(8676002)(5660300001)(36756003)(81156014)(7736002)(305945005)(6116002)(81166006)(31696002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1719;H:[IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjEyTUIxNzE5OzIzOjg4N0tFWHpZMGFxNzdyU2c0bGZVVmpvTjQ4?=
 =?utf-8?B?MkoxMXJSMmwyeWZjcXFlNGFJc3pZWm1vNVorbEt0bXZiSmRnc2pWUytMSHF6?=
 =?utf-8?B?dC9FVTJNSU5OS0tHOUVjcGpYOXR3N1FlZkxUcVQwdzlEZmdrS3FLaVNaYjRs?=
 =?utf-8?B?NENneUo3S0RESXRjeExwMHhIU0RFUGs5UmJEZ3NJbXc3RUNxeEJyeHgzdUNw?=
 =?utf-8?B?THZUVjdUWGR0VVVIRnprQURQUXJtQ2dVTERqSUVEbVQvQ2krYzg3UktkSHd6?=
 =?utf-8?B?SmRJTzAzQm8vNGlGWVJnYklEdXFib25aQ2VkbUVESUZmVDMvZVVOaXJZd3RF?=
 =?utf-8?B?SkpWd1Y2V0VDZzIxUkcwNGo0OVRwSWY1MExpVERYbUJ2N1JseEl2M21LWG81?=
 =?utf-8?B?TUhlemtPTGZ2WDNJTm0yVDZSb3crRTZQMkFkckdZRHkwVklFTTNpN2w2bzJR?=
 =?utf-8?B?TGlCS3oyUFlBYTJiNDY3TVBlT3AxZnBPNGhvUzdETVFJaWprVkZCazVTUEU1?=
 =?utf-8?B?SVA3OTZmMThiMU5Jc0V6enlFK056bGtvSzBvRmpRdDBZSG9JNmRjK2hYZHJy?=
 =?utf-8?B?MDBPMzRlNlM1YnBTaUQrMDAzeGYwdHdCaUJNeGo4ZmhlWFVKQUhzb1JEcFJ5?=
 =?utf-8?B?SXg1Smp0OTg4UHZvY3RSaStMRDhUbXF5WFVqdDI1S3FkL0Nna0hnWU52NTR3?=
 =?utf-8?B?VnE4WmNMZUN6NnpTODlVclNENTVVZWxDRGh5QWRjUWRyMk0yeE5sOTRsYmds?=
 =?utf-8?B?ZlE1a2ovODJEd2dReVU5ajNxMmtOWk4wODRUZk9BOGpvTDNJSS8rOEZmNnI3?=
 =?utf-8?B?YXFpSU1HYW9oTGNHNWZPczdWMnpEUk4vNmJvY0o1bUc4VllEQk1UNWo5MjVO?=
 =?utf-8?B?SDBtbFhaM05Ma25FaVB4aWJUUjFOWld3aVFPK3J3TUpZNVN3L3V0YW5iUXpO?=
 =?utf-8?B?TG5jYmh2RGhnTWVxS3JLNkhVSTZuNGphdllNUlVHTE00SXV1VmlabUlHWjFR?=
 =?utf-8?B?QllWZkQ4dG1Ib0E4NVVVeU0yRW1nZ3JMMS9JQTVUNmFtNWdoZ3pMUVErekRT?=
 =?utf-8?B?QmowNVMrTTE5bmk2WGhQQ3lZeklFRjFGOTFGQ1ZOYzRSWDZ1SWkzYUwweVBL?=
 =?utf-8?B?ZmI4T0pIRjYzNDZNdmNlaFkwdE95encvZFh1amdXeG45V3hodnhlYzNnUzZO?=
 =?utf-8?B?bnhDc21uenRNVHF6VGRMMks4di9JeUxIbkY4ME1wL045bDJKOHBNUXRqQzVq?=
 =?utf-8?B?TTlHZTFJdUt3aXN6aW9sbnI1RWwza2xPWnlJSWxtRzB5dWtsaXhtVEFxVDdT?=
 =?utf-8?B?WCtkTzhXTDRNNnAvMDNaOS9uUVF2bm1HMjlLTXlsRFlWRTJaeHJ3NHFTNWdk?=
 =?utf-8?B?NUdEOUhSSnpEWnkvZU55d2dmNkdkRUpDMHluV3lhc3Z2TWxzdHRPL2tiMTJD?=
 =?utf-8?B?S2wzK1lIRXRjSzBiYTZobktkenZyeVd0dUdORnFhRW9nUGdmd3NXNEFNSlpM?=
 =?utf-8?B?NjJ1RWZpTzFicWZ0Y3RMYzJJU3FmT0g1N1FIVWtRcXV3bmtHdW42VXdreTlo?=
 =?utf-8?B?Y2k1TnJ4Q0RPaVhnQnAxT0RFenc3cDFzQ01IMVFHeTI5d3JnSDZJaUwzVEQ0?=
 =?utf-8?B?MTVxNXZlVk1EWExQalVhRVI2eXVJWTZtNWpCKzIrQmlXRnpSUDhwY01EQmFi?=
 =?utf-8?B?WjNKVGlCWnNMdE90bWF5WDYrTWkwOUhHMjlZdENOS1pzN2s5SG9hSHRZemda?=
 =?utf-8?B?cGZSRXhLSjN0clM1YVhpY2VhRDRVdFJVM0JpSjBWaFkwb1ZSZ0VKVGpKTmxy?=
 =?utf-8?B?MWFneWp2L2hndlcrSG9SbEt1cC82QmN0OEhWc1Y2S3c4WFhPVmFiNXI1VE1s?=
 =?utf-8?B?NFJhNzZNY1RoZWtJSjFiMFpwQjRHMWlPeE51S0w0WGZ6VVAvUVhlb1VMemEz?=
 =?utf-8?B?YVNURGZEWGhEa1Njc0ZOY0UxTkhlWm9HR3BxbjdXNE1LVVhqdElxQ3UzaHdY?=
 =?utf-8?B?akZmVnd1WmZjb2tPTGRVYnpSUTBKWkUyWm16Zz09?=
X-Microsoft-Antispam-Message-Info: flRFFChqCJuBHNERUPZus2CcpZA9kpTk61yDdKsR2c5S5Nr7eYusswammkaicx32RfnmIlVD8eg7hgJGDakVgdvghQ+ql8XolNNBS4kaGmDbfrEB9nAXxX8Ac65ExeE2FVjr/HKFTyAaeGIp+7tBLCFA/BRC2+qJYz3g9iRcmmsZjFWAzlG5sfqnLsFCRhWQOnXBy3nvrJEVchCVuebDjixsf1hufDa0TcAt4hIRFd3Dseg20Gxs4PPuSFgSdtOZM8TrJb7QVmYKtfOkUcxjhTGLkeQOsfrI/2soJXc2L3C5Pnd4AhA4rFm/lLI+9GIfRY9C6DJeF+K1DqNRk29Lm29+4ut4xB+h0agPKOExlO4=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1719;6:1irnNSKyVxOIMbcAeZ1HeIo07iiVGSHHd99LE9ang2q/8HLKTh+J34eHnQtw1SS34LUk1qhZV/jckxnQF/9mLpxyWome0IIjGZXruUnRTm8YwBa3lCgECqvbzLxea7NpB0FgypBh0tBBex9yWfrx+RzwDuTR+tAbuRS0C54eLBMcsYKPvVrgmbSaivnPbOqzUBiG6rmcUNGNv5QiCFuC0zkIiTfp38LurgC02km+j/A2d223HIVfoQV5jCo4LlGKdbopUQtJiYiFdNwl5IZyIABOVXPPEwepez2715RjHg2lHbsOUCQP7xAXNhc4qFWH76ThGcNPvXO2TYhMjCwWRc6kbDOtNZX5LtCwdfPuRIzQSUgU8tc+9XQ5ZUFzJbPV3NdCZLUGvbmnq0yYpGDwQsVccRaeORVBLt3fkkdZJFPY+Z6oLflaUO1D8SI1480Hah2VSh6/xKAhWcbRMBtwFg==;5:GztWXGOX1gaOsOajzjhxgUXd2IEeWnfO4dMurHjh7hHzTK8YK3jHH2RhmXuZaG8ADPVAnsNSYLUqaQqfkUAbCucrI6Yw85c5xwRKR9r3nq9xJ6xq9f3cdcxTzNufMhzc7ixJoMw5YxvzRHumYxHOqoBrsYwf8NDq/5L2WhYRXSU=;24:h22KdrmiS70h/E8vDLD5O3gs14VeC7V5SLH35O0Y9B5GJOVsnOEx0KXEIFbdpfOOlUfCp5qp+Iswkp+Ik6JxFW43M5Cmv2WoKOhNxomZNVg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1719;7:/mfFECTE56alUyDt3kqN0ecbD254HrRlEmB/ukYd7pBw5llLySQ/ywgnHg13L8lnvv8yVq39Ea44NLHpQPNxuHVUf4mbRV2TrGeU0ylcwqLpUYUBMt/JikJLB/x+gDS6dqjU4dVKp8y57gyt2c7iQJKldYNKYd1Vd58mgeAF+czg3Mu78Y9Gbo4RGbm9ODcuwlEnvqGVep1GCgXwZdvz8DnSP8v1FCAuzERYK3GXn1E5RB2eE/d4+Cro5B0tbDaO;20:N1Qva4hH5dOkqHGHFTPQDNrjLckt2J31m/hXShvGwnrfU6tc7+a4v35it5+eijnnF596UHSxBppzDQzBBd6QYM8KErWu3lEjL2tK95yIlk2XJvQK1rxFcqGP1j1DR9Ho8GfeTMrZE0Wv6i0HgDGl6kXrHzCCC1Yhvr2JP3lNRQy5Im9nzVQdUI5MeW/cD+XJ08NVsUtNcAZmRE6VdkZY9vqYSjcCjgupPOePs0YMKAdSzpgeOjg0v+Y3gVcJyAfu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2018 09:15:07.8394 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ac745bc-efea-4cc7-c268-08d5dffc5184
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1719
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 27.06.2018 um 09:44 schrieb Michal Hocko:
> This is the v2 of RFC based on the feedback I've received so far. The
> code even compiles as a bonus ;) I haven't runtime tested it yet, mostly
> because I have no idea how.
>
> Any further feedback is highly appreciated of course.

That sounds like it should work and at least the amdgpu changes now look 
good to me on first glance.

Can you split that up further in the usual way? E.g. adding the 
blockable flag in one patch and fixing all implementations of the MMU 
notifier in follow up patches.

This way I'm pretty sure Felix and I can give an rb on the amdgpu/amdkfd 
changes.

Thanks,
Christian.

> ---
>  From ec9a7241bf422b908532c4c33953b0da2655ad05 Mon Sep 17 00:00:00 2001
> From: Michal Hocko <mhocko@suse.com>
> Date: Wed, 20 Jun 2018 15:03:20 +0200
> Subject: [PATCH] mm, oom: distinguish blockable mode for mmu notifiers
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
>
> There are several blockable mmu notifiers which might sleep in
> mmu_notifier_invalidate_range_start and that is a problem for the
> oom_reaper because it needs to guarantee a forward progress so it cannot
> depend on any sleepable locks.
>
> Currently we simply back off and mark an oom victim with blockable mmu
> notifiers as done after a short sleep. That can result in selecting a
> new oom victim prematurely because the previous one still hasn't torn
> its memory down yet.
>
> We can do much better though. Even if mmu notifiers use sleepable locks
> there is no reason to automatically assume those locks are held.
> Moreover majority of notifiers only care about a portion of the address
> space and there is absolutely zero reason to fail when we are unmapping an
> unrelated range. Many notifiers do really block and wait for HW which is
> harder to handle and we have to bail out though.
>
> This patch handles the low hanging fruid. __mmu_notifier_invalidate_range_start
> gets a blockable flag and callbacks are not allowed to sleep if the
> flag is set to false. This is achieved by using trylock instead of the
> sleepable lock for most callbacks and continue as long as we do not
> block down the call chain.
>
> I think we can improve that even further because there is a common
> pattern to do a range lookup first and then do something about that.
> The first part can be done without a sleeping lock in most cases AFAICS.
>
> The oom_reaper end then simply retries if there is at least one notifier
> which couldn't make any progress in !blockable mode. A retry loop is
> already implemented to wait for the mmap_sem and this is basically the
> same thing.
>
> Changes since rfc v1
> - gpu notifiers can sleep while waiting for HW (evict_process_queues_cpsch
>    on a lock and amdgpu_mn_invalidate_node on unbound timeout) make sure
>    we bail out when we have an intersecting range for starter
> - note that a notifier failed to the log for easier debugging
> - back off early in ib_umem_notifier_invalidate_range_start if the
>    callback is called
> - mn_invl_range_start waits for completion down the unmap_grant_pages
>    path so we have to back off early on overlapping ranges
>
> Cc: "David (ChunMing) Zhou" <David1.Zhou@amd.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: "Radim Krčmář" <rkrcmar@redhat.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian König" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Doug Ledford <dledford@redhat.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Mike Marciniszyn <mike.marciniszyn@intel.com>
> Cc: Dennis Dalessandro <dennis.dalessandro@intel.com>
> Cc: Sudeep Dutt <sudeep.dutt@intel.com>
> Cc: Ashutosh Dixit <ashutosh.dixit@intel.com>
> Cc: Dimitri Sivanich <sivanich@sgi.com>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: "Jérôme Glisse" <jglisse@redhat.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Felix Kuehling <felix.kuehling@amd.com>
> Cc: kvm@vger.kernel.org (open list:KERNEL VIRTUAL MACHINE FOR X86 (KVM/x86))
> Cc: linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT))
> Cc: amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS)
> Cc: dri-devel@lists.freedesktop.org (open list:DRM DRIVERS)
> Cc: intel-gfx@lists.freedesktop.org (open list:INTEL DRM DRIVERS (excluding Poulsbo, Moorestow...)
> Cc: linux-rdma@vger.kernel.org (open list:INFINIBAND SUBSYSTEM)
> Cc: xen-devel@lists.xenproject.org (moderated list:XEN HYPERVISOR INTERFACE)
> Cc: linux-mm@kvack.org (open list:HMM - Heterogeneous Memory Management)
> Reported-by: David Rientjes <rientjes@google.com>
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> ---
>   arch/x86/kvm/x86.c                      |  7 ++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c  | 43 +++++++++++++++++++-----
>   drivers/gpu/drm/i915/i915_gem_userptr.c | 13 ++++++--
>   drivers/gpu/drm/radeon/radeon_mn.c      | 22 +++++++++++--
>   drivers/infiniband/core/umem_odp.c      | 33 +++++++++++++++----
>   drivers/infiniband/hw/hfi1/mmu_rb.c     | 11 ++++---
>   drivers/infiniband/hw/mlx5/odp.c        |  2 +-
>   drivers/misc/mic/scif/scif_dma.c        |  7 ++--
>   drivers/misc/sgi-gru/grutlbpurge.c      |  7 ++--
>   drivers/xen/gntdev.c                    | 44 ++++++++++++++++++++-----
>   include/linux/kvm_host.h                |  4 +--
>   include/linux/mmu_notifier.h            | 35 +++++++++++++++-----
>   include/linux/oom.h                     |  2 +-
>   include/rdma/ib_umem_odp.h              |  3 +-
>   mm/hmm.c                                |  7 ++--
>   mm/mmap.c                               |  2 +-
>   mm/mmu_notifier.c                       | 19 ++++++++---
>   mm/oom_kill.c                           | 29 ++++++++--------
>   virt/kvm/kvm_main.c                     | 15 ++++++---
>   19 files changed, 225 insertions(+), 80 deletions(-)
>
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 6bcecc325e7e..ac08f5d711be 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -7203,8 +7203,9 @@ static void vcpu_load_eoi_exitmap(struct kvm_vcpu *vcpu)
>   	kvm_x86_ops->load_eoi_exitmap(vcpu, eoi_exit_bitmap);
>   }
>   
> -void kvm_arch_mmu_notifier_invalidate_range(struct kvm *kvm,
> -		unsigned long start, unsigned long end)
> +int kvm_arch_mmu_notifier_invalidate_range(struct kvm *kvm,
> +		unsigned long start, unsigned long end,
> +		bool blockable)
>   {
>   	unsigned long apic_address;
>   
> @@ -7215,6 +7216,8 @@ void kvm_arch_mmu_notifier_invalidate_range(struct kvm *kvm,
>   	apic_address = gfn_to_hva(kvm, APIC_DEFAULT_PHYS_BASE >> PAGE_SHIFT);
>   	if (start <= apic_address && apic_address < end)
>   		kvm_make_all_cpus_request(kvm, KVM_REQ_APIC_PAGE_RELOAD);
> +
> +	return 0;
>   }
>   
>   void kvm_vcpu_reload_apic_access_page(struct kvm_vcpu *vcpu)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
> index 83e344fbb50a..3399a4a927fb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
> @@ -136,12 +136,18 @@ void amdgpu_mn_unlock(struct amdgpu_mn *mn)
>    *
>    * Take the rmn read side lock.
>    */
> -static void amdgpu_mn_read_lock(struct amdgpu_mn *rmn)
> +static int amdgpu_mn_read_lock(struct amdgpu_mn *rmn, bool blockable)
>   {
> -	mutex_lock(&rmn->read_lock);
> +	if (blockable)
> +		mutex_lock(&rmn->read_lock);
> +	else if (!mutex_trylock(&rmn->read_lock))
> +		return -EAGAIN;
> +
>   	if (atomic_inc_return(&rmn->recursion) == 1)
>   		down_read_non_owner(&rmn->lock);
>   	mutex_unlock(&rmn->read_lock);
> +
> +	return 0;
>   }
>   
>   /**
> @@ -197,10 +203,11 @@ static void amdgpu_mn_invalidate_node(struct amdgpu_mn_node *node,
>    * We block for all BOs between start and end to be idle and
>    * unmap them by move them into system domain again.
>    */
> -static void amdgpu_mn_invalidate_range_start_gfx(struct mmu_notifier *mn,
> +static int amdgpu_mn_invalidate_range_start_gfx(struct mmu_notifier *mn,
>   						 struct mm_struct *mm,
>   						 unsigned long start,
> -						 unsigned long end)
> +						 unsigned long end,
> +						 bool blockable)
>   {
>   	struct amdgpu_mn *rmn = container_of(mn, struct amdgpu_mn, mn);
>   	struct interval_tree_node *it;
> @@ -208,17 +215,28 @@ static void amdgpu_mn_invalidate_range_start_gfx(struct mmu_notifier *mn,
>   	/* notification is exclusive, but interval is inclusive */
>   	end -= 1;
>   
> -	amdgpu_mn_read_lock(rmn);
> +	/* TODO we should be able to split locking for interval tree and
> +	 * amdgpu_mn_invalidate_node
> +	 */
> +	if (amdgpu_mn_read_lock(rmn, blockable))
> +		return -EAGAIN;
>   
>   	it = interval_tree_iter_first(&rmn->objects, start, end);
>   	while (it) {
>   		struct amdgpu_mn_node *node;
>   
> +		if (!blockable) {
> +			amdgpu_mn_read_unlock(rmn);
> +			return -EAGAIN;
> +		}
> +
>   		node = container_of(it, struct amdgpu_mn_node, it);
>   		it = interval_tree_iter_next(it, start, end);
>   
>   		amdgpu_mn_invalidate_node(node, start, end);
>   	}
> +
> +	return 0;
>   }
>   
>   /**
> @@ -233,10 +251,11 @@ static void amdgpu_mn_invalidate_range_start_gfx(struct mmu_notifier *mn,
>    * necessitates evicting all user-mode queues of the process. The BOs
>    * are restorted in amdgpu_mn_invalidate_range_end_hsa.
>    */
> -static void amdgpu_mn_invalidate_range_start_hsa(struct mmu_notifier *mn,
> +static int amdgpu_mn_invalidate_range_start_hsa(struct mmu_notifier *mn,
>   						 struct mm_struct *mm,
>   						 unsigned long start,
> -						 unsigned long end)
> +						 unsigned long end,
> +						 bool blockable)
>   {
>   	struct amdgpu_mn *rmn = container_of(mn, struct amdgpu_mn, mn);
>   	struct interval_tree_node *it;
> @@ -244,13 +263,19 @@ static void amdgpu_mn_invalidate_range_start_hsa(struct mmu_notifier *mn,
>   	/* notification is exclusive, but interval is inclusive */
>   	end -= 1;
>   
> -	amdgpu_mn_read_lock(rmn);
> +	if (amdgpu_mn_read_lock(rmn, blockable))
> +		return -EAGAIN;
>   
>   	it = interval_tree_iter_first(&rmn->objects, start, end);
>   	while (it) {
>   		struct amdgpu_mn_node *node;
>   		struct amdgpu_bo *bo;
>   
> +		if (!blockable) {
> +			amdgpu_mn_read_unlock(rmn);
> +			return -EAGAIN;
> +		}
> +
>   		node = container_of(it, struct amdgpu_mn_node, it);
>   		it = interval_tree_iter_next(it, start, end);
>   
> @@ -262,6 +287,8 @@ static void amdgpu_mn_invalidate_range_start_hsa(struct mmu_notifier *mn,
>   				amdgpu_amdkfd_evict_userptr(mem, mm);
>   		}
>   	}
> +
> +	return 0;
>   }
>   
>   /**
> diff --git a/drivers/gpu/drm/i915/i915_gem_userptr.c b/drivers/gpu/drm/i915/i915_gem_userptr.c
> index 854bd51b9478..9cbff68f6b41 100644
> --- a/drivers/gpu/drm/i915/i915_gem_userptr.c
> +++ b/drivers/gpu/drm/i915/i915_gem_userptr.c
> @@ -112,10 +112,11 @@ static void del_object(struct i915_mmu_object *mo)
>   	mo->attached = false;
>   }
>   
> -static void i915_gem_userptr_mn_invalidate_range_start(struct mmu_notifier *_mn,
> +static int i915_gem_userptr_mn_invalidate_range_start(struct mmu_notifier *_mn,
>   						       struct mm_struct *mm,
>   						       unsigned long start,
> -						       unsigned long end)
> +						       unsigned long end,
> +						       bool blockable)
>   {
>   	struct i915_mmu_notifier *mn =
>   		container_of(_mn, struct i915_mmu_notifier, mn);
> @@ -124,7 +125,7 @@ static void i915_gem_userptr_mn_invalidate_range_start(struct mmu_notifier *_mn,
>   	LIST_HEAD(cancelled);
>   
>   	if (RB_EMPTY_ROOT(&mn->objects.rb_root))
> -		return;
> +		return 0;
>   
>   	/* interval ranges are inclusive, but invalidate range is exclusive */
>   	end--;
> @@ -132,6 +133,10 @@ static void i915_gem_userptr_mn_invalidate_range_start(struct mmu_notifier *_mn,
>   	spin_lock(&mn->lock);
>   	it = interval_tree_iter_first(&mn->objects, start, end);
>   	while (it) {
> +		if (!blockable) {
> +			spin_unlock(&mn->lock);
> +			return -EAGAIN;
> +		}
>   		/* The mmu_object is released late when destroying the
>   		 * GEM object so it is entirely possible to gain a
>   		 * reference on an object in the process of being freed
> @@ -154,6 +159,8 @@ static void i915_gem_userptr_mn_invalidate_range_start(struct mmu_notifier *_mn,
>   
>   	if (!list_empty(&cancelled))
>   		flush_workqueue(mn->wq);
> +
> +	return 0;
>   }
>   
>   static const struct mmu_notifier_ops i915_gem_userptr_notifier = {
> diff --git a/drivers/gpu/drm/radeon/radeon_mn.c b/drivers/gpu/drm/radeon/radeon_mn.c
> index abd24975c9b1..f8b35df44c60 100644
> --- a/drivers/gpu/drm/radeon/radeon_mn.c
> +++ b/drivers/gpu/drm/radeon/radeon_mn.c
> @@ -118,19 +118,27 @@ static void radeon_mn_release(struct mmu_notifier *mn,
>    * We block for all BOs between start and end to be idle and
>    * unmap them by move them into system domain again.
>    */
> -static void radeon_mn_invalidate_range_start(struct mmu_notifier *mn,
> +static int radeon_mn_invalidate_range_start(struct mmu_notifier *mn,
>   					     struct mm_struct *mm,
>   					     unsigned long start,
> -					     unsigned long end)
> +					     unsigned long end,
> +					     bool blockable)
>   {
>   	struct radeon_mn *rmn = container_of(mn, struct radeon_mn, mn);
>   	struct ttm_operation_ctx ctx = { false, false };
>   	struct interval_tree_node *it;
> +	int ret = 0;
>   
>   	/* notification is exclusive, but interval is inclusive */
>   	end -= 1;
>   
> -	mutex_lock(&rmn->lock);
> +	/* TODO we should be able to split locking for interval tree and
> +	 * the tear down.
> +	 */
> +	if (blockable)
> +		mutex_lock(&rmn->lock);
> +	else if (!mutex_trylock(&rmn->lock))
> +		return -EAGAIN;
>   
>   	it = interval_tree_iter_first(&rmn->objects, start, end);
>   	while (it) {
> @@ -138,6 +146,11 @@ static void radeon_mn_invalidate_range_start(struct mmu_notifier *mn,
>   		struct radeon_bo *bo;
>   		long r;
>   
> +		if (!blockable) {
> +			ret = -EAGAIN;
> +			goto out_unlock;
> +		}
> +
>   		node = container_of(it, struct radeon_mn_node, it);
>   		it = interval_tree_iter_next(it, start, end);
>   
> @@ -166,7 +179,10 @@ static void radeon_mn_invalidate_range_start(struct mmu_notifier *mn,
>   		}
>   	}
>   	
> +out_unlock:
>   	mutex_unlock(&rmn->lock);
> +
> +	return ret;
>   }
>   
>   static const struct mmu_notifier_ops radeon_mn_ops = {
> diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
> index 182436b92ba9..6ec748eccff7 100644
> --- a/drivers/infiniband/core/umem_odp.c
> +++ b/drivers/infiniband/core/umem_odp.c
> @@ -186,6 +186,7 @@ static void ib_umem_notifier_release(struct mmu_notifier *mn,
>   	rbt_ib_umem_for_each_in_range(&context->umem_tree, 0,
>   				      ULLONG_MAX,
>   				      ib_umem_notifier_release_trampoline,
> +				      true,
>   				      NULL);
>   	up_read(&context->umem_rwsem);
>   }
> @@ -207,22 +208,31 @@ static int invalidate_range_start_trampoline(struct ib_umem *item, u64 start,
>   	return 0;
>   }
>   
> -static void ib_umem_notifier_invalidate_range_start(struct mmu_notifier *mn,
> +static int ib_umem_notifier_invalidate_range_start(struct mmu_notifier *mn,
>   						    struct mm_struct *mm,
>   						    unsigned long start,
> -						    unsigned long end)
> +						    unsigned long end,
> +						    bool blockable)
>   {
>   	struct ib_ucontext *context = container_of(mn, struct ib_ucontext, mn);
> +	int ret;
>   
>   	if (!context->invalidate_range)
> -		return;
> +		return 0;
> +
> +	if (blockable)
> +		down_read(&context->umem_rwsem);
> +	else if (!down_read_trylock(&context->umem_rwsem))
> +		return -EAGAIN;
>   
>   	ib_ucontext_notifier_start_account(context);
> -	down_read(&context->umem_rwsem);
> -	rbt_ib_umem_for_each_in_range(&context->umem_tree, start,
> +	ret = rbt_ib_umem_for_each_in_range(&context->umem_tree, start,
>   				      end,
> -				      invalidate_range_start_trampoline, NULL);
> +				      invalidate_range_start_trampoline,
> +				      blockable, NULL);
>   	up_read(&context->umem_rwsem);
> +
> +	return ret;
>   }
>   
>   static int invalidate_range_end_trampoline(struct ib_umem *item, u64 start,
> @@ -242,10 +252,15 @@ static void ib_umem_notifier_invalidate_range_end(struct mmu_notifier *mn,
>   	if (!context->invalidate_range)
>   		return;
>   
> +	/*
> +	 * TODO: we currently bail out if there is any sleepable work to be done
> +	 * in ib_umem_notifier_invalidate_range_start so we shouldn't really block
> +	 * here. But this is ugly and fragile.
> +	 */
>   	down_read(&context->umem_rwsem);
>   	rbt_ib_umem_for_each_in_range(&context->umem_tree, start,
>   				      end,
> -				      invalidate_range_end_trampoline, NULL);
> +				      invalidate_range_end_trampoline, true, NULL);
>   	up_read(&context->umem_rwsem);
>   	ib_ucontext_notifier_end_account(context);
>   }
> @@ -798,6 +813,7 @@ EXPORT_SYMBOL(ib_umem_odp_unmap_dma_pages);
>   int rbt_ib_umem_for_each_in_range(struct rb_root_cached *root,
>   				  u64 start, u64 last,
>   				  umem_call_back cb,
> +				  bool blockable,
>   				  void *cookie)
>   {
>   	int ret_val = 0;
> @@ -809,6 +825,9 @@ int rbt_ib_umem_for_each_in_range(struct rb_root_cached *root,
>   
>   	for (node = rbt_ib_umem_iter_first(root, start, last - 1);
>   			node; node = next) {
> +		/* TODO move the blockable decision up to the callback */
> +		if (!blockable)
> +			return -EAGAIN;
>   		next = rbt_ib_umem_iter_next(node, start, last - 1);
>   		umem = container_of(node, struct ib_umem_odp, interval_tree);
>   		ret_val = cb(umem->umem, start, last, cookie) || ret_val;
> diff --git a/drivers/infiniband/hw/hfi1/mmu_rb.c b/drivers/infiniband/hw/hfi1/mmu_rb.c
> index 70aceefe14d5..e1c7996c018e 100644
> --- a/drivers/infiniband/hw/hfi1/mmu_rb.c
> +++ b/drivers/infiniband/hw/hfi1/mmu_rb.c
> @@ -67,9 +67,9 @@ struct mmu_rb_handler {
>   
>   static unsigned long mmu_node_start(struct mmu_rb_node *);
>   static unsigned long mmu_node_last(struct mmu_rb_node *);
> -static void mmu_notifier_range_start(struct mmu_notifier *,
> +static int mmu_notifier_range_start(struct mmu_notifier *,
>   				     struct mm_struct *,
> -				     unsigned long, unsigned long);
> +				     unsigned long, unsigned long, bool);
>   static struct mmu_rb_node *__mmu_rb_search(struct mmu_rb_handler *,
>   					   unsigned long, unsigned long);
>   static void do_remove(struct mmu_rb_handler *handler,
> @@ -284,10 +284,11 @@ void hfi1_mmu_rb_remove(struct mmu_rb_handler *handler,
>   	handler->ops->remove(handler->ops_arg, node);
>   }
>   
> -static void mmu_notifier_range_start(struct mmu_notifier *mn,
> +static int mmu_notifier_range_start(struct mmu_notifier *mn,
>   				     struct mm_struct *mm,
>   				     unsigned long start,
> -				     unsigned long end)
> +				     unsigned long end,
> +				     bool blockable)
>   {
>   	struct mmu_rb_handler *handler =
>   		container_of(mn, struct mmu_rb_handler, mn);
> @@ -313,6 +314,8 @@ static void mmu_notifier_range_start(struct mmu_notifier *mn,
>   
>   	if (added)
>   		queue_work(handler->wq, &handler->del_work);
> +
> +	return 0;
>   }
>   
>   /*
> diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
> index f1a87a690a4c..d216e0d2921d 100644
> --- a/drivers/infiniband/hw/mlx5/odp.c
> +++ b/drivers/infiniband/hw/mlx5/odp.c
> @@ -488,7 +488,7 @@ void mlx5_ib_free_implicit_mr(struct mlx5_ib_mr *imr)
>   
>   	down_read(&ctx->umem_rwsem);
>   	rbt_ib_umem_for_each_in_range(&ctx->umem_tree, 0, ULLONG_MAX,
> -				      mr_leaf_free, imr);
> +				      mr_leaf_free, true, imr);
>   	up_read(&ctx->umem_rwsem);
>   
>   	wait_event(imr->q_leaf_free, !atomic_read(&imr->num_leaf_free));
> diff --git a/drivers/misc/mic/scif/scif_dma.c b/drivers/misc/mic/scif/scif_dma.c
> index 63d6246d6dff..6369aeaa7056 100644
> --- a/drivers/misc/mic/scif/scif_dma.c
> +++ b/drivers/misc/mic/scif/scif_dma.c
> @@ -200,15 +200,18 @@ static void scif_mmu_notifier_release(struct mmu_notifier *mn,
>   	schedule_work(&scif_info.misc_work);
>   }
>   
> -static void scif_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
> +static int scif_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
>   						     struct mm_struct *mm,
>   						     unsigned long start,
> -						     unsigned long end)
> +						     unsigned long end,
> +						     bool blockable)
>   {
>   	struct scif_mmu_notif	*mmn;
>   
>   	mmn = container_of(mn, struct scif_mmu_notif, ep_mmu_notifier);
>   	scif_rma_destroy_tcw(mmn, start, end - start);
> +
> +	return 0;
>   }
>   
>   static void scif_mmu_notifier_invalidate_range_end(struct mmu_notifier *mn,
> diff --git a/drivers/misc/sgi-gru/grutlbpurge.c b/drivers/misc/sgi-gru/grutlbpurge.c
> index a3454eb56fbf..be28f05bfafa 100644
> --- a/drivers/misc/sgi-gru/grutlbpurge.c
> +++ b/drivers/misc/sgi-gru/grutlbpurge.c
> @@ -219,9 +219,10 @@ void gru_flush_all_tlb(struct gru_state *gru)
>   /*
>    * MMUOPS notifier callout functions
>    */
> -static void gru_invalidate_range_start(struct mmu_notifier *mn,
> +static int gru_invalidate_range_start(struct mmu_notifier *mn,
>   				       struct mm_struct *mm,
> -				       unsigned long start, unsigned long end)
> +				       unsigned long start, unsigned long end,
> +				       bool blockable)
>   {
>   	struct gru_mm_struct *gms = container_of(mn, struct gru_mm_struct,
>   						 ms_notifier);
> @@ -231,6 +232,8 @@ static void gru_invalidate_range_start(struct mmu_notifier *mn,
>   	gru_dbg(grudev, "gms %p, start 0x%lx, end 0x%lx, act %d\n", gms,
>   		start, end, atomic_read(&gms->ms_range_active));
>   	gru_flush_tlb_range(gms, start, end - start);
> +
> +	return 0;
>   }
>   
>   static void gru_invalidate_range_end(struct mmu_notifier *mn,
> diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
> index bd56653b9bbc..55b4f0e3f4d6 100644
> --- a/drivers/xen/gntdev.c
> +++ b/drivers/xen/gntdev.c
> @@ -441,18 +441,25 @@ static const struct vm_operations_struct gntdev_vmops = {
>   
>   /* ------------------------------------------------------------------ */
>   
> +static bool in_range(struct grant_map *map,
> +			      unsigned long start, unsigned long end)
> +{
> +	if (!map->vma)
> +		return false;
> +	if (map->vma->vm_start >= end)
> +		return false;
> +	if (map->vma->vm_end <= start)
> +		return false;
> +
> +	return true;
> +}
> +
>   static void unmap_if_in_range(struct grant_map *map,
>   			      unsigned long start, unsigned long end)
>   {
>   	unsigned long mstart, mend;
>   	int err;
>   
> -	if (!map->vma)
> -		return;
> -	if (map->vma->vm_start >= end)
> -		return;
> -	if (map->vma->vm_end <= start)
> -		return;
>   	mstart = max(start, map->vma->vm_start);
>   	mend   = min(end,   map->vma->vm_end);
>   	pr_debug("map %d+%d (%lx %lx), range %lx %lx, mrange %lx %lx\n",
> @@ -465,21 +472,40 @@ static void unmap_if_in_range(struct grant_map *map,
>   	WARN_ON(err);
>   }
>   
> -static void mn_invl_range_start(struct mmu_notifier *mn,
> +static int mn_invl_range_start(struct mmu_notifier *mn,
>   				struct mm_struct *mm,
> -				unsigned long start, unsigned long end)
> +				unsigned long start, unsigned long end,
> +				bool blockable)
>   {
>   	struct gntdev_priv *priv = container_of(mn, struct gntdev_priv, mn);
>   	struct grant_map *map;
> +	int ret = 0;
> +
> +	/* TODO do we really need a mutex here? */
> +	if (blockable)
> +		mutex_lock(&priv->lock);
> +	else if (!mutex_trylock(&priv->lock))
> +		return -EAGAIN;
>   
> -	mutex_lock(&priv->lock);
>   	list_for_each_entry(map, &priv->maps, next) {
> +		if (in_range(map, start, end)) {
> +			ret = -EAGAIN;
> +			goto out_unlock;
> +		}
>   		unmap_if_in_range(map, start, end);
>   	}
>   	list_for_each_entry(map, &priv->freeable_maps, next) {
> +		if (in_range(map, start, end)) {
> +			ret = -EAGAIN;
> +			goto out_unlock;
> +		}
>   		unmap_if_in_range(map, start, end);
>   	}
> +
> +out_unlock:
>   	mutex_unlock(&priv->lock);
> +
> +	return ret;
>   }
>   
>   static void mn_release(struct mmu_notifier *mn,
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 4ee7bc548a83..148935085194 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -1275,8 +1275,8 @@ static inline long kvm_arch_vcpu_async_ioctl(struct file *filp,
>   }
>   #endif /* CONFIG_HAVE_KVM_VCPU_ASYNC_IOCTL */
>   
> -void kvm_arch_mmu_notifier_invalidate_range(struct kvm *kvm,
> -		unsigned long start, unsigned long end);
> +int kvm_arch_mmu_notifier_invalidate_range(struct kvm *kvm,
> +		unsigned long start, unsigned long end, bool blockable);
>   
>   #ifdef CONFIG_HAVE_KVM_VCPU_RUN_PID_CHANGE
>   int kvm_arch_vcpu_run_pid_change(struct kvm_vcpu *vcpu);
> diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
> index 392e6af82701..2eb1a2d01759 100644
> --- a/include/linux/mmu_notifier.h
> +++ b/include/linux/mmu_notifier.h
> @@ -151,13 +151,15 @@ struct mmu_notifier_ops {
>   	 * address space but may still be referenced by sptes until
>   	 * the last refcount is dropped.
>   	 *
> -	 * If both of these callbacks cannot block, and invalidate_range
> -	 * cannot block, mmu_notifier_ops.flags should have
> -	 * MMU_INVALIDATE_DOES_NOT_BLOCK set.
> +	 * If blockable argument is set to false then the callback cannot
> +	 * sleep and has to return with -EAGAIN. 0 should be returned
> +	 * otherwise.
> +	 *
>   	 */
> -	void (*invalidate_range_start)(struct mmu_notifier *mn,
> +	int (*invalidate_range_start)(struct mmu_notifier *mn,
>   				       struct mm_struct *mm,
> -				       unsigned long start, unsigned long end);
> +				       unsigned long start, unsigned long end,
> +				       bool blockable);
>   	void (*invalidate_range_end)(struct mmu_notifier *mn,
>   				     struct mm_struct *mm,
>   				     unsigned long start, unsigned long end);
> @@ -229,8 +231,9 @@ extern int __mmu_notifier_test_young(struct mm_struct *mm,
>   				     unsigned long address);
>   extern void __mmu_notifier_change_pte(struct mm_struct *mm,
>   				      unsigned long address, pte_t pte);
> -extern void __mmu_notifier_invalidate_range_start(struct mm_struct *mm,
> -				  unsigned long start, unsigned long end);
> +extern int __mmu_notifier_invalidate_range_start(struct mm_struct *mm,
> +				  unsigned long start, unsigned long end,
> +				  bool blockable);
>   extern void __mmu_notifier_invalidate_range_end(struct mm_struct *mm,
>   				  unsigned long start, unsigned long end,
>   				  bool only_end);
> @@ -281,7 +284,17 @@ static inline void mmu_notifier_invalidate_range_start(struct mm_struct *mm,
>   				  unsigned long start, unsigned long end)
>   {
>   	if (mm_has_notifiers(mm))
> -		__mmu_notifier_invalidate_range_start(mm, start, end);
> +		__mmu_notifier_invalidate_range_start(mm, start, end, true);
> +}
> +
> +static inline int mmu_notifier_invalidate_range_start_nonblock(struct mm_struct *mm,
> +				  unsigned long start, unsigned long end)
> +{
> +	int ret = 0;
> +	if (mm_has_notifiers(mm))
> +		ret = __mmu_notifier_invalidate_range_start(mm, start, end, false);
> +
> +	return ret;
>   }
>   
>   static inline void mmu_notifier_invalidate_range_end(struct mm_struct *mm,
> @@ -461,6 +474,12 @@ static inline void mmu_notifier_invalidate_range_start(struct mm_struct *mm,
>   {
>   }
>   
> +static inline int mmu_notifier_invalidate_range_start_nonblock(struct mm_struct *mm,
> +				  unsigned long start, unsigned long end)
> +{
> +	return 0;
> +}
> +
>   static inline void mmu_notifier_invalidate_range_end(struct mm_struct *mm,
>   				  unsigned long start, unsigned long end)
>   {
> diff --git a/include/linux/oom.h b/include/linux/oom.h
> index 6adac113e96d..92f70e4c6252 100644
> --- a/include/linux/oom.h
> +++ b/include/linux/oom.h
> @@ -95,7 +95,7 @@ static inline int check_stable_address_space(struct mm_struct *mm)
>   	return 0;
>   }
>   
> -void __oom_reap_task_mm(struct mm_struct *mm);
> +bool __oom_reap_task_mm(struct mm_struct *mm);
>   
>   extern unsigned long oom_badness(struct task_struct *p,
>   		struct mem_cgroup *memcg, const nodemask_t *nodemask,
> diff --git a/include/rdma/ib_umem_odp.h b/include/rdma/ib_umem_odp.h
> index 6a17f856f841..381cdf5a9bd1 100644
> --- a/include/rdma/ib_umem_odp.h
> +++ b/include/rdma/ib_umem_odp.h
> @@ -119,7 +119,8 @@ typedef int (*umem_call_back)(struct ib_umem *item, u64 start, u64 end,
>    */
>   int rbt_ib_umem_for_each_in_range(struct rb_root_cached *root,
>   				  u64 start, u64 end,
> -				  umem_call_back cb, void *cookie);
> +				  umem_call_back cb,
> +				  bool blockable, void *cookie);
>   
>   /*
>    * Find first region intersecting with address range.
> diff --git a/mm/hmm.c b/mm/hmm.c
> index de7b6bf77201..81fd57bd2634 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -177,16 +177,19 @@ static void hmm_release(struct mmu_notifier *mn, struct mm_struct *mm)
>   	up_write(&hmm->mirrors_sem);
>   }
>   
> -static void hmm_invalidate_range_start(struct mmu_notifier *mn,
> +static int hmm_invalidate_range_start(struct mmu_notifier *mn,
>   				       struct mm_struct *mm,
>   				       unsigned long start,
> -				       unsigned long end)
> +				       unsigned long end,
> +				       bool blockable)
>   {
>   	struct hmm *hmm = mm->hmm;
>   
>   	VM_BUG_ON(!hmm);
>   
>   	atomic_inc(&hmm->sequence);
> +
> +	return 0;
>   }
>   
>   static void hmm_invalidate_range_end(struct mmu_notifier *mn,
> diff --git a/mm/mmap.c b/mm/mmap.c
> index d1eb87ef4b1a..336bee8c4e25 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -3074,7 +3074,7 @@ void exit_mmap(struct mm_struct *mm)
>   		 * reliably test it.
>   		 */
>   		mutex_lock(&oom_lock);
> -		__oom_reap_task_mm(mm);
> +		(void)__oom_reap_task_mm(mm);
>   		mutex_unlock(&oom_lock);
>   
>   		set_bit(MMF_OOM_SKIP, &mm->flags);
> diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
> index eff6b88a993f..103b2b450043 100644
> --- a/mm/mmu_notifier.c
> +++ b/mm/mmu_notifier.c
> @@ -174,18 +174,29 @@ void __mmu_notifier_change_pte(struct mm_struct *mm, unsigned long address,
>   	srcu_read_unlock(&srcu, id);
>   }
>   
> -void __mmu_notifier_invalidate_range_start(struct mm_struct *mm,
> -				  unsigned long start, unsigned long end)
> +int __mmu_notifier_invalidate_range_start(struct mm_struct *mm,
> +				  unsigned long start, unsigned long end,
> +				  bool blockable)
>   {
>   	struct mmu_notifier *mn;
> +	int ret = 0;
>   	int id;
>   
>   	id = srcu_read_lock(&srcu);
>   	hlist_for_each_entry_rcu(mn, &mm->mmu_notifier_mm->list, hlist) {
> -		if (mn->ops->invalidate_range_start)
> -			mn->ops->invalidate_range_start(mn, mm, start, end);
> +		if (mn->ops->invalidate_range_start) {
> +			int _ret = mn->ops->invalidate_range_start(mn, mm, start, end, blockable);
> +			if (_ret) {
> +				pr_info("%pS callback failed with %d in %sblockable context.\n",
> +						mn->ops->invalidate_range_start, _ret,
> +						!blockable ? "non-": "");
> +				ret = _ret;
> +			}
> +		}
>   	}
>   	srcu_read_unlock(&srcu, id);
> +
> +	return ret;
>   }
>   EXPORT_SYMBOL_GPL(__mmu_notifier_invalidate_range_start);
>   
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 84081e77bc51..5a936cf24d79 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -479,9 +479,10 @@ static DECLARE_WAIT_QUEUE_HEAD(oom_reaper_wait);
>   static struct task_struct *oom_reaper_list;
>   static DEFINE_SPINLOCK(oom_reaper_lock);
>   
> -void __oom_reap_task_mm(struct mm_struct *mm)
> +bool __oom_reap_task_mm(struct mm_struct *mm)
>   {
>   	struct vm_area_struct *vma;
> +	bool ret = true;
>   
>   	/*
>   	 * Tell all users of get_user/copy_from_user etc... that the content
> @@ -511,12 +512,17 @@ void __oom_reap_task_mm(struct mm_struct *mm)
>   			struct mmu_gather tlb;
>   
>   			tlb_gather_mmu(&tlb, mm, start, end);
> -			mmu_notifier_invalidate_range_start(mm, start, end);
> +			if (mmu_notifier_invalidate_range_start_nonblock(mm, start, end)) {
> +				ret = false;
> +				continue;
> +			}
>   			unmap_page_range(&tlb, vma, start, end, NULL);
>   			mmu_notifier_invalidate_range_end(mm, start, end);
>   			tlb_finish_mmu(&tlb, start, end);
>   		}
>   	}
> +
> +	return ret;
>   }
>   
>   static bool oom_reap_task_mm(struct task_struct *tsk, struct mm_struct *mm)
> @@ -545,18 +551,6 @@ static bool oom_reap_task_mm(struct task_struct *tsk, struct mm_struct *mm)
>   		goto unlock_oom;
>   	}
>   
> -	/*
> -	 * If the mm has invalidate_{start,end}() notifiers that could block,
> -	 * sleep to give the oom victim some more time.
> -	 * TODO: we really want to get rid of this ugly hack and make sure that
> -	 * notifiers cannot block for unbounded amount of time
> -	 */
> -	if (mm_has_blockable_invalidate_notifiers(mm)) {
> -		up_read(&mm->mmap_sem);
> -		schedule_timeout_idle(HZ);
> -		goto unlock_oom;
> -	}
> -
>   	/*
>   	 * MMF_OOM_SKIP is set by exit_mmap when the OOM reaper can't
>   	 * work on the mm anymore. The check for MMF_OOM_SKIP must run
> @@ -571,7 +565,12 @@ static bool oom_reap_task_mm(struct task_struct *tsk, struct mm_struct *mm)
>   
>   	trace_start_task_reaping(tsk->pid);
>   
> -	__oom_reap_task_mm(mm);
> +	/* failed to reap part of the address space. Try again later */
> +	if (!__oom_reap_task_mm(mm)) {
> +		up_read(&mm->mmap_sem);
> +		ret = false;
> +		goto unlock_oom;
> +	}
>   
>   	pr_info("oom_reaper: reaped process %d (%s), now anon-rss:%lukB, file-rss:%lukB, shmem-rss:%lukB\n",
>   			task_pid_nr(tsk), tsk->comm,
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index ada21f47f22b..16ce38f178d1 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -135,9 +135,10 @@ static void kvm_uevent_notify_change(unsigned int type, struct kvm *kvm);
>   static unsigned long long kvm_createvm_count;
>   static unsigned long long kvm_active_vms;
>   
> -__weak void kvm_arch_mmu_notifier_invalidate_range(struct kvm *kvm,
> -		unsigned long start, unsigned long end)
> +__weak int kvm_arch_mmu_notifier_invalidate_range(struct kvm *kvm,
> +		unsigned long start, unsigned long end, bool blockable)
>   {
> +	return 0;
>   }
>   
>   bool kvm_is_reserved_pfn(kvm_pfn_t pfn)
> @@ -354,13 +355,15 @@ static void kvm_mmu_notifier_change_pte(struct mmu_notifier *mn,
>   	srcu_read_unlock(&kvm->srcu, idx);
>   }
>   
> -static void kvm_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
> +static int kvm_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
>   						    struct mm_struct *mm,
>   						    unsigned long start,
> -						    unsigned long end)
> +						    unsigned long end,
> +						    bool blockable)
>   {
>   	struct kvm *kvm = mmu_notifier_to_kvm(mn);
>   	int need_tlb_flush = 0, idx;
> +	int ret;
>   
>   	idx = srcu_read_lock(&kvm->srcu);
>   	spin_lock(&kvm->mmu_lock);
> @@ -378,9 +381,11 @@ static void kvm_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
>   
>   	spin_unlock(&kvm->mmu_lock);
>   
> -	kvm_arch_mmu_notifier_invalidate_range(kvm, start, end);
> +	ret = kvm_arch_mmu_notifier_invalidate_range(kvm, start, end, blockable);
>   
>   	srcu_read_unlock(&kvm->srcu, idx);
> +
> +	return ret;
>   }
>   
>   static void kvm_mmu_notifier_invalidate_range_end(struct mmu_notifier *mn,

