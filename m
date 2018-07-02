Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A047C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECACD22B72
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="cV5DW5Ad"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECACD22B72
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752271AbeGBMOH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 08:14:07 -0400
Received: from mail-by2nam03on0069.outbound.protection.outlook.com ([104.47.42.69]:16800
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752156AbeGBMOD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 08:14:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gvLNApG42wYVnh5k+MPVOmPRdu/kT2VNZUyUr4s8Nww=;
 b=cV5DW5AdMaSR3LioQUzwOwqKeaX3Ks6WHyNHpq2Cr4NbOjSGdxkp86BI+s5MXhJndSMTGjiTGn6ufedllz5LVe2MJvadE+8Au/4G75916NQgXq4+up+A2Lip/3ZfWiEPBEyi7Nnl3qVcv8KDaS8uxclg3xox7o/9MR9Q1oxeHE8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from [IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740]
 (2a02:908:1257:4460:1ab8:55c1:a639:6740) by
 BN6PR12MB1715.namprd12.prod.outlook.com (2603:10b6:404:106::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.24; Mon, 2 Jul
 2018 12:13:53 +0000
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
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <725cb1ad-01b0-42b5-56f0-c08c29804cb4@amd.com>
Date:   Mon, 2 Jul 2018 14:13:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180702115423.GK19043@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1257:4460:1ab8:55c1:a639:6740]
X-ClientProxiedBy: HE1PR09CA0065.eurprd09.prod.outlook.com
 (2603:10a6:7:3c::33) To BN6PR12MB1715.namprd12.prod.outlook.com
 (2603:10b6:404:106::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a360284c-ecfe-403c-d90a-08d5e0154b3b
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1715;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1715;3:GXPD4qtRHHIiBWjE9+GrqRRex7EuHIjtD7+sm+m7E6kGcNJNN+b0UEVe7paYzkIERsPzxwTLyQM3WeEOxXZDAgOS+sMantcXXSXAOTDmtVPaIWMB9ne1ir1HMETUWIKdQQQAiPzJsGQc5X4Zc53shDvF5SRAm2S1sETRlSOFr5RPd6LM15IOybbuRisCr0cXPxkRuwVLFnWnLKcufvGnkaCwYO92fYIgBiAHHM+Jkp3jg9IbdPokC/pLZHj4RNFX;25:rl40VJsMc9UjqVp516pCPeQpaBAdtu4bJnLzbCnAbRp3/PiJJ38mnkwV/bMw1EiksrmTcL611gNgPLERGTppr43HV03oUOtn3d7hPQ/yRmE6GEXC1UvKoWJYt3qE0K1cxVuGvPasUpK/wdvQct1SVNLCVU7kIDayqeTSIZ8gNcrGic3/ykF9lG2ZACqbyNPbEO37rbUXU3nFqOy+HreSNQPgvzmfW0akhDMyzixnHvmGEtEvWQE2iP6mZDgpZ0Q7SGihKg7TTkOZwXMXCFVQqfddvbTkSDUJ5QrEIysmOsYZfcxtOP8yt421vqds20KblG3CGbi+T3/nIV2uqKhACg==;31:ltd2JfMhEa/6ReRV0kDRMRUfduUG0yqngnyE2gc/bKWGn9xxccD+BpPrbIBZgsQ8cBcJo0BQYxpVIxHl3etIin/o0LDnJg64rOl+TVBluW3F7FLyqJvnPPNT0YqXa2kaNrIzQ+HynUYZho6RXWgmPqPDFDXE7VswC3kaPf1AgAeCaCi1tSdnymQQym95eCJ91AfisY8CYNgIBLjS5aSzl6d2lu5qD9sxF1kLPxZkaMg=
X-MS-TrafficTypeDiagnostic: BN6PR12MB1715:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1715;20:S7F4+vF7WekhRb2JAiqLzlj32quuAvRdK+CstLSpb2Ub8umOwXN87t0tEKTUgRGHn8+FeW/tNggOfCKZkW6/zqVmfWwxNgX+r+jVf/q1KOm/YUSjLDzS+AYifsf5wJRHdoh9eZ85llFFGGqw3m4C6VS7rKGsvch9ZezU4mAymtS/7m+AG8vlJPWWqumoLN1N7NG5wSRBp/V7WbUpjdGX4pCrFoqsLNdtdbBltUqm2fcHrvlZcw/Tz7dZYZqS1CoCHBkepB5JPETyNFSzJYbrlu8TW/XwC1otr6KB3c1Rc11Vd9hM9YdOIFnvAmZ1uGnUU6Y5MgkbwbecSVQQnboYcoOn3Nie0W43tdwqeyahMeFkfZWOCkZlEuQqN9Chu7Yr2pwD5IdkYTsDK+KqCj5EsjGgrYExiE+BszCpqXEpd0nP//4JjqymKQihLaLnFjAjSSweC5Fn8lbK4mXf2lw4fs2R8s4QydzoUczOs5QIuVbyW3mAFeZF7Bn+muCndSyE;4:JVQvRWTE99d6N4x1Y71OISKqBcoY2EHh5BV8aH5rJ6DFnQTCOcGPNUdLZItS7X8MKhB/ygEs+czvegA98TxogcdOnGKibtQdW/i+CmI79nZJY/leT8VIjsXvvVfJnzVb+5H1IvAuDwHFzGBnInvmtJmIW3aRIEibreYna2SFFTW/G9ThsO//qHSRHDrQqcfFNmrSYjRmYitTcrh+E6HfQ4PV0aRq3UcNK7AhSx3VKR4dbtxAKmPka7mbB93ZV8tyZal1gmBRk4sVwWj6W9XuzA==
X-Microsoft-Antispam-PRVS: <BN6PR12MB17151DDA50AD1F0E7224E96383430@BN6PR12MB1715.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BN6PR12MB1715;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1715;
X-Forefront-PRVS: 07215D0470
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(346002)(39860400002)(396003)(366004)(376002)(189003)(199004)(6916009)(86362001)(6116002)(2870700001)(8936002)(31696002)(16526019)(93886005)(1706002)(4326008)(46003)(81166006)(81156014)(7416002)(25786009)(97736004)(31686004)(6666003)(8676002)(6486002)(105586002)(229853002)(52116002)(2486003)(58126008)(316002)(52146003)(2906002)(53936002)(47776003)(5660300001)(11346002)(52396003)(446003)(106356001)(386003)(23676004)(7736002)(54906003)(478600001)(65826007)(2616005)(476003)(65956001)(67846002)(50466002)(6246003)(76176011)(36756003)(486006)(65806001)(68736007)(72206003)(64126003)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1715;H:[IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjEyTUIxNzE1OzIzOlhYRHRvTHpVN0NpdDBnaklIVXlrS0FFV2ZN?=
 =?utf-8?B?U0o3Ym9rbEtaaXZvcTIrNWlCa0VscWJlZHlhbGkyTmRKSXJEQTI2bzdjenJR?=
 =?utf-8?B?T0hvcVM2TVNXQkRaNU1hTGwxUnBkWjBmamFGVitTRnNlWXpVY2JzUmxFaG5E?=
 =?utf-8?B?a1g1VW5DUXZrOUVrdmRQREN4Nmx4eVg2aVV3UU1HZGIrT0xBZHJnQm9lbjV1?=
 =?utf-8?B?YXl6R0RQbzhLUFZxLzZEZkNvNERlQWE0Y0c1ZEVFUjkrMFBFcllWQ2k4Q0pU?=
 =?utf-8?B?RHFiSWltRWZEYlFIYkZMTmZwSTJxOGk2ZHFDc0Z5MStSL2JBYUJtU3VlalB1?=
 =?utf-8?B?b2o5Mi9teU92OXdlazNrVjJYZFZXaVBUOVRZWlcxUzBLdklYNktmVW1aeFI5?=
 =?utf-8?B?bmQvQzlLbTFJRVUzbGF6NWY2VTVBcnovd0I5Wm9GemRmcC9TV1dCTS9NTlkw?=
 =?utf-8?B?TjlvVWRFVDdqRk5XaERWNUJLREtPemM2Y1dLR1FheXBCS1QvSitrZHhDT2Ny?=
 =?utf-8?B?c2wrOG9pTDJ0NWhrK09USnowRjJZVXpxU1oreDBGbWEwMSs2MHZ5UDBnTENU?=
 =?utf-8?B?RmZrN2ZvWlNYa2xjNG03c1QwV21JUFl0a01GZExIZ1pIVnBVbEtnaEg5ZUNo?=
 =?utf-8?B?ZzkwUzVGRkZzN0grWmVJeENRc3d0ZkRrS21laDBpTGE1aWlmMXpHTTNqWk1x?=
 =?utf-8?B?N0FCdHlyMGhVUmc2a1NKbEppUDczMFlUODBoYVZMSG9HZmJlUjdLY0R0YVFj?=
 =?utf-8?B?QWc0cm01MzZUVEd0Qmlhc3krbTF4WjF3NTlIckxQcnZIWVh0elNOUFdiREpH?=
 =?utf-8?B?aE9Yb3BlenhBbEp5MlNJZXVhNDB5L1RPQnhKVVY0REFGazcrcTVmN2NkQXZz?=
 =?utf-8?B?b2x0SDlEWkxTV1lyb3RYcW1VMkMxWkJuVzR1ZEN2ZmxPYkFlT3M0eFVXZzlW?=
 =?utf-8?B?SkIvVEVaSWtQTktteCtYL0tuS2xrcWpaVENTRTNUcU1QYmVENnNmR25tTm91?=
 =?utf-8?B?OWNFSlRaeVBnSktVcm9lb0dxLzNTaEpLN09NWTd5OFZXalRDcWlOc1p2ZlFn?=
 =?utf-8?B?UHppNDgrNXF5TGczV05NT09SbldSbHBlS2w5VjZjRzM2ck5CQ2pkb0FwRnN6?=
 =?utf-8?B?UW1lMG9qM21CN3AzWmZxcjgzRjdYQ0dQTFZ6VVRaRmx2WG5XbGFqWDdFa1BF?=
 =?utf-8?B?MlluWGoyS1lQeFlLbTMxZDFsN3E1QUZ1STRUWmZjNTVGZzV5T2kzTjlhZlA4?=
 =?utf-8?B?ZnpXNC9UNkN0UmhSd09RcG1ucTB1dFFYOWRSVVQyUDdURGc4Q1RoQTVYWW05?=
 =?utf-8?B?N2c2UTNMWGVzRHorTHNOVE4wS0FCUXZDV3JIRjIwbWVmbUFFNWFFZDBHNFJp?=
 =?utf-8?B?VHRZT0NzQlY0STVBdVMrWjNFRXliNDlQb3dkOWhINkg5OUdtWU9Hd3VycllN?=
 =?utf-8?B?NHhLalUzaEFTdWhOSXR5ZXhvQXNQSTJkQ0NjaXFvOUxndWIvc2JUK1NheGE0?=
 =?utf-8?B?c3d0T3I5OExwc2ozdHhjcmZkanB6aDZ6Sko2enFYRDQ4aWdhSGZjUExTbUlL?=
 =?utf-8?B?UkFkc1RBOHJvNG9IbkcyL011a2s5bUVkdWM3TldBU2ZCQ0xXWUx6aUZRM3NP?=
 =?utf-8?B?aFhPbkIyVmoxaWRoVis5SWlpRy85SXFYR09KR1VBMVB0eW5Mb0lhTjBna2ZO?=
 =?utf-8?B?N2xSL3REbGVCZEJSNXMxYW1KOFNua0NYMkpuYnBmL2w0K3FybG1EOUU1R1Bq?=
 =?utf-8?B?VXUvUHdseG5zUXZJMjY1UEtaeUZ6WWIwMEFVU1hvaFErRVo5bEJocDM0dkZJ?=
 =?utf-8?B?cEh4MWhPc3NRTFFrNWlvRU84aEJCWCtaQlEwZW5WNzQrZUhPS1RkOVRpZEVM?=
 =?utf-8?Q?cKb6YqYc0wFInQHu5OgDKq2kTndLyara?=
X-Microsoft-Antispam-Message-Info: 6+WrfLTwghR5tk5kKDuM8PqWXgEkE26JChNjP9mZhXNtdhKdSNQ98tFjjGXVZkxCqdDcXRttjlDWMYzdt9UxL9XsaIMMxj3mdtke8CFa+y+QzbYT2H2rRARTMtO1a6z7DgwNEDKcGt4MkYYQjem45P9efQYKaGUJ9a3OwhF23meYFr0HOgfloNkdH1PUM3sr025J5+Mq7wmvOyvnk4hLd7TauB0J4IC3Wx4HdVRX+zdtoC9BY1CPK2osG0ZowY7d+uZ/njCmQ1tawa89Z72f4IY0ugjeOB2bshGMr9JxsqgF7fu68uq6naVJyc+lqKghEuiDWBS4dsaifFwr2CNvstyapDsLdn2aDP4NkwojFfc=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1715;6:LincABWIf/XUi6+g8MZXQQQ7ZHG/OzUzLqgMw6h9CweFnzd8+upT9ulhfh7aExzDsBacEnTg87CDxScvoe1pvHe/4LlWhjg8vrVmY1CUPAdDEVu7gG+m0n1EK4D77QKWhhGOcnQ+HqxsHVc6xq1NppFUH+UEpwkxkvsx+CpupP3tX/iyQFfn4CuHsCxtQ/frMc3Fr5MErqWHbCoudBZtONr33hjJvFhZk1fpIwMrYBc9udZ4QaCS5Y/HBCphmVVuWEAePrPFOQWL/X8wiOaUL2iSnDR7wO8lTOR1xSkiqc8dLRQ4ir5i9plezHU6Rfbq5IlK1YAaYuioC6B34hNwudlZiqXDjkmNTkjK0rPJE6KEDZLgPbICmL/xR7nqqhNITqezbfOfPflfLlXUG6eMl6LKVI6v2fMBaRY7khhmaezgE+HQCCLOuazQd+nV1oLQktyDymZnLbR6CCgGmbOs6A==;5:309f+dX/pxIDZMlDm5QXgjSboiMkDefOXFu/47xrINzQySyYPk5SAX1y/9czVxNdRZwvoEdXeoLlWq3wTqDSL1FHjHR1xCDnRdYdvO0N+Krksp0UoLY7mPlCXKqX+3y2Yw0UHks8eXdnvk4O21Dox2KUoigX/72QNrXwVGmD12c=;24:dx1gJRlB4woh3wLwtUzNKmqDDa3lCTppanRpFKKFk5KM6wJpjBuRR0A1aRhZeuT9WJh4AFBd1YJKFlU/l4XUybR+4q7GObV+q9+GKzNtL30=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1715;7:FX7o37KROPms9mIbIspMvSXvgtpvNhv2gd81Rfzo1wZwR/inZllfHrUKR4urNym1KUbm06q/OxUVTNhwrvufwGxSmTjqYnijyE9fRp3nty4Q5v9PzuhClXQHV2NkO1QBuCqm7AEN0pn1JZd79M9tAbD0/WRKd9o9YexhdkCnv7A9x6ovdzBv3IjMzrCiYSKF8irmMQR9og1G/7runPYIlg8OinfWHUTv9cKaRZ3cMwsLHDieD+38ukFbtKEHsyDW;20:4zeloteRsMf+xZl1iPfEcTHuQmpmxum5i2Bdu7Dztqya8GUMhkDkdKq1OflZETeULMG7GBj91zG1j6dX/d5NwX8r2cz+hWekiZqbRMR5hO7iKRmzUPLiaOS7GcV8EFDIqbC1rZ3oidWAwAPBmFHljVSUJjLnkx28hw2ZSmUquOCQumPua5napjyz4of+unP1+QxrFgUy02F2R1NBfEQHPctS2uRsGXHIXNSlo3194N2O/aaPXq7Tr4MXHeXYS1la
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2018 12:13:53.4097 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a360284c-ecfe-403c-d90a-08d5e0154b3b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1715
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 02.07.2018 um 13:54 schrieb Michal Hocko:
> On Mon 02-07-18 11:14:58, Christian König wrote:
>> Am 27.06.2018 um 09:44 schrieb Michal Hocko:
>>> This is the v2 of RFC based on the feedback I've received so far. The
>>> code even compiles as a bonus ;) I haven't runtime tested it yet, mostly
>>> because I have no idea how.
>>>
>>> Any further feedback is highly appreciated of course.
>> That sounds like it should work and at least the amdgpu changes now look
>> good to me on first glance.
>>
>> Can you split that up further in the usual way? E.g. adding the blockable
>> flag in one patch and fixing all implementations of the MMU notifier in
>> follow up patches.
> But such a code would be broken, no? Ignoring the blockable state will
> simply lead to lockups until the fixup parts get applied.

Well to still be bisect-able you only need to get the interface change 
in first with fixing the function signature of the implementations.

Then add all the new code to the implementations and last start to 
actually use the new interface.

That is a pattern we use regularly and I think it's good practice to do 
this.

> Is the split up really worth it? I was thinking about that but had hard
> times to end up with something that would be bisectable. Well, except
> for returning -EBUSY until all notifiers are implemented. Which I found
> confusing.

It at least makes reviewing changes much easier, cause as driver 
maintainer I can concentrate on the stuff only related to me.

Additional to that when you cause some unrelated side effect in a driver 
we can much easier pinpoint the actual change later on when the patch is 
smaller.

>
>> This way I'm pretty sure Felix and I can give an rb on the amdgpu/amdkfd
>> changes.
> If you are worried to give r-b only for those then this can be done even
> for larger patches. Just make your Reviewd-by more specific
> R-b: name # For BLA BLA

Yeah, possible alternative but more work for me when I review it :)

Regards,
Christian.
