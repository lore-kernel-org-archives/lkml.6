Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09EA2C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 15:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8535721557
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 15:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="T7YXWeKl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8535721557
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbeHXTQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 15:16:52 -0400
Received: from mail-eopbgr720080.outbound.protection.outlook.com ([40.107.72.80]:39904
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726374AbeHXTQw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 15:16:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E+Dt2jvZGcvFtqbvnSda1+yGHJiZjTiGcnoOVbLVims=;
 b=T7YXWeKlPytSXCt47cUnHSNF/htw4gGkX1mptXzdZpHuoz5j0/zVdFi+1jbDARL0nFmn0xIhLBKk6yfr1zqLn2ndJvAOTBW7/srhsHlz3/Q/GH4aZzbwalbYez8vhFEp9zdhhvyXB1KNSWHOqGyVPHLkzGBAINwM64LirDrhCX8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
Received: from [10.236.136.62] (165.204.77.1) by
 BYAPR12MB2680.namprd12.prod.outlook.com (2603:10b6:a03:69::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.13; Fri, 24 Aug 2018 15:41:37 +0000
Cc:     brijesh.singh@amd.com, Borislav Petkov <bp@suse.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: SEV guest regression in 4.18
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
References: <20ad6cd5-394c-d3ae-d99c-b656d7ef8293@amd.com>
 <20180821083911.GF24940@nazgul.tnic>
 <3d46f44c-dd78-8fa9-02ac-8206676ffde9@amd.com>
 <20180821151938.GA31212@nazgul.tnic>
 <92e2b80c-0dcc-94be-8d3a-5e11e5cf2370@amd.com>
 <20180822081417.GB4069@nazgul.tnic> <20180822150033.GA14200@linux.intel.com>
 <4d6ee892-a34f-28b3-18b7-1c663eb281c6@amd.com>
 <9635ebf0-7c99-6edf-1240-8dec28036a70@redhat.com>
 <20180823152907.GA1488@linux.intel.com>
 <60acb594-abe3-912f-9702-2f34961e575d@redhat.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <c565ae1c-c2f0-8a43-b1f5-404c2efe7c56@amd.com>
Date:   Fri, 24 Aug 2018 10:41:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <60acb594-abe3-912f-9702-2f34961e575d@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN4PR0501CA0017.namprd05.prod.outlook.com
 (2603:10b6:803:40::30) To BYAPR12MB2680.namprd12.prod.outlook.com
 (2603:10b6:a03:69::29)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f2010ba-e464-4694-bfb3-08d609d814ad
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB2680;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2680;3:+k23VKbfxlkvgXjXizIYyf5vxXNszJhz/e7TgXcWJnea11cmBbKAeD/zzKCa3McVO9qMB7+OVHmjYFgEatK7oka7tIuNyX/sww3Dj/R44c8Cv6bqEf1kLs6IDniqTAkC6X/hgo4p4eOSMLRoZZj+/Be1GTSCivA6Ixte+VaJ4EVpG9oUnSppemxmFzqM2zni+aGFoSei89g5YTIEJjiFqoiX84EWUNuf1hc++g+NgwNiuOK3eFHsUChqfil3p3ZA;25:q1eE/pUWEzJiBHuu+PL82pqN00MYUJSyTgF1CJJXISl7Sfet1Pp9cR+8Y+pE7y9R5rrGSVd9MHqShTRSjxAZZqW7oOR1yP+m28TBqNIpqcvnsY3tH/TxAgbBRX7rscPWGRBkBwHBbDPIhe5RQgyLZUN51PzCWzg4N1JRFslzzYo9lWDJKnjMiCIqU/+gyqAJctTUn2sb1c6hhop45jnh1TWgk8iw8Ww8VULuXPe4MvlRZjqCvPWCBn/L4rVc0rNTqJALaHKxrECXVW/KMItiZ1Njkn9DD2FpMLRUa23Yj37dmijlTBJHtGdKU718PBf7DaYZBD0FJUhRrJgsJn6m8Q==;31:Vzax3B/yyp3RECaGE7qMzEFWncJwom4PyQdAgPYxSoa6ErK2/xc+y6hpTy+cGEdE9l6gKZ7Hf3T4Wno1F+CE5iCSXm8vyAzAN/XCblgnpjH6wDqA4jMDgMVQj8R1pZeN0LSJmpKv0OOxQGxFSLuqc2/geFbSEpbScLukFlNzAjTVVMxOxJPq450BlcY4iuXr0GJI46sm9yld+rFBXMpcZqwRaDsP2TSLEZAkTDgpvXw=
X-MS-TrafficTypeDiagnostic: BYAPR12MB2680:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2680;20:xjsv9KW2xmalqmpqAM9E+awL9P34/SlaHHBMk8q6ieCyYTTkG3900sJNTmGTlarUcA3rm/OLpdY6bDJv5xF/j4teNUZXfcwU+u+p37abXC7ndso1HkEtJ0QdPicLPH3Gk2yFKYPRNPwBe/Tq/c8L+8l1XZ0cRJ9IyOhGv+4DklWggOi7oXdcpixZyYwmujMn78p9SIgsNBTh1+BAbOiPRiSUnW6bpFQNioZBXp16sUvPcUXIcbLgsrVaUNju0evmSX9iiNaCpHlTNFBbse23NAp3NHC0sVwLyt52M7k8blm5qO3KWYlLo2juZxUf0SWUduiL4u7Mqp8M7bTP8WOPM1sga2LE8FJELcJbh3SOM2tkmS7Fufvtqwb/hN2F5nc0WKCUubIVQqS/+5AzzF9aMzwKwO6rKZq/jnvXafOyLxjjELJ0PxZHnRSVBR4KGop9pYbheHjEVE6KCRtgp7QzWWawrJYsj6WqxcjEKj8FfcV8kp/vdw4iN2Ps/p6O6/kT;4:VIQrbs0aMSEypIrjZNoqHIYH7qZCUj2f+vaO6VQGZaW6VE67KhLk75rxlqhBCZKEGcerFCDUOdCuWEzcdkC1d4uZqVBPFvvLZorblTSVihGA9ae95jezpGTyVtmxND3M5mLujWJl7HqtB0ygLew4gNCpVL9ak8+4LadIKmV9X0GCACXmqzMsPQm81FH6HBtjI56ZE+V9cUG35IYw/Hz3RV6ivjOVacxJsz3Bmhk9eOBKTMu8ldfXmzrv+AtLJ8D41ArYaD77v3DmYDjt/rXu0Q==
X-Microsoft-Antispam-PRVS: <BYAPR12MB268080F22510621757FCBA2AE5360@BYAPR12MB2680.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:BYAPR12MB2680;BCL:0;PCL:0;RULEID:;SRVR:BYAPR12MB2680;
X-Forefront-PRVS: 07749F8C42
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(136003)(346002)(366004)(396003)(39860400002)(376002)(199004)(189003)(53546011)(6486002)(7736002)(4326008)(44832011)(25786009)(5660300001)(23676004)(2906002)(305945005)(65826007)(386003)(64126003)(11346002)(2486003)(16576012)(53936002)(16526019)(52146003)(76176011)(229853002)(36756003)(486006)(316002)(86362001)(52116002)(2616005)(31696002)(956004)(81156014)(8676002)(26005)(476003)(93886005)(97736004)(106356001)(230700001)(66066001)(6666003)(6246003)(68736007)(77096007)(81166006)(186003)(31686004)(50466002)(6116002)(58126008)(105586002)(65806001)(65956001)(3846002)(8936002)(47776003)(54906003)(67846002)(110136005)(478600001)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2680;H:[10.236.136.62];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWUFQUjEyTUIyNjgwOzIzOjVHdXFWZVFNNWQ2Z1ZVM3BrSGlKalpIM0pz?=
 =?utf-8?B?c05jcWV1NWYzVVkrcE1oL0VNTXRCbVZCaVROSndNNGxPV21yVWVyWGdkRXdq?=
 =?utf-8?B?bWU5b3p3Y05kTlhUWDlucExyMmxEZnlmeUdBblQvNGN4cFUzMUM0R0gweUtC?=
 =?utf-8?B?R0E0YXdOemFvcXRjRWlXZEU2WVBYb0pmMkMwa2syZVoxdytudU9YL29PNGtt?=
 =?utf-8?B?RU45QVp2VXZaYnY5MGxlbnFWN1YwMEtGZ2l1YmFvVVYyYmNxeUtqSFg0Q0FM?=
 =?utf-8?B?RnlhUXRobVZQeHNZeVBURmlLWEdoUTJ3V1IyYjdIZ1hWNkpMbHdQM25VNndo?=
 =?utf-8?B?TlFuYWl0MzZtdGtvYXp4YlJLM1ZRSExFTEkvdEdPNEVMaDREMVY2N3NJd0VL?=
 =?utf-8?B?SkNKNlFXWmRCZUlmbm4xZlJHelJSRkNqMHh1VlVVbjh5Nzh6Y2JlMTU1SEVk?=
 =?utf-8?B?S0VwR0hVY3c1bm5YRFVWUGpraDN2R1Q5ZmZWdjIyMzRzc0FRd09acm9aTkhJ?=
 =?utf-8?B?eWVObzhrdGE0UWlQYTFXbW8xZGZYWU1EM2M3REFDT29JUGdTV2tmQnpYNnhO?=
 =?utf-8?B?NWFkVFEzOTVpRm5hNS91a3BiM2lVbkhzSWpqTlRSNVRQWHNGSm85anR4UVF3?=
 =?utf-8?B?Wlo3NjdQck5DWkVOL3plWjRhYk9GSmV1TWlwakJFTWlZek9OeWgxaHNUT2dj?=
 =?utf-8?B?WG1aM1hzZEY3R3JBS0dnLzBlTm9wZVprQUpjVmZPUXN2K0FOTUlrWFFHUWRt?=
 =?utf-8?B?eVRDMGdCd3pyVHNITFVibFVxY0ROQkIrenM4eHJhRlVSdjBGM0p2VkthVkZD?=
 =?utf-8?B?UnFFcENFVmpuWURhbTgyQXNrcFU2K0xWd2FzOFlOdzl2NGdrMlp2WFg4K1Q1?=
 =?utf-8?B?NWl4Zno4bG9ZYzVlTXVtNnBSSGxqSkJXK2x6TDl5NnVjemxSeURXUVZ5Z2k5?=
 =?utf-8?B?VkRaV1dvVEwvdDBDdEdNQi9Da09BWmhlTzBwSDVlQ2lWZXpUMEJWeG9QZlNY?=
 =?utf-8?B?VWdQR3dzbFAxMXJyZ0oxelFxVk5tVFlxUElRNTFxTkd1R0todWdxeFhBVFVN?=
 =?utf-8?B?dG5uV2FrYVZ1TkdrTWw1dk14QjRsSWREem1CRXBsQyt5SjR3OE1jQ0xtN2xN?=
 =?utf-8?B?cFlOM3R4OXhxQUhkU0MxZjFrMlk5UkFNQkcvSk5ac2NFWG51OXE1TkVDeFBB?=
 =?utf-8?B?eFZKRkp3ME05UGNad0UrMmRIVHFpYWl1REtpRWJyY1gwK3ExNDZpakVuMFhP?=
 =?utf-8?B?QlRMK3VvZWhBS3RYV2R1VnVmdDFLN1JpRnBEVXBGTU1MNTYvU05LNEtkTEhL?=
 =?utf-8?B?WEx1THRUdDhUM2VycnJZVStIbDNIR3graUpLYVpxNTZORzAyNUpqSlRPdmtM?=
 =?utf-8?B?UmJZOUJSYTVLcFJ6by8zM3JKaGFsN2wxd1lwQnFUTlRpT1BSbkJFMEJJU2Zj?=
 =?utf-8?B?VmR2aWZrdzJZd0E2NHVnNTZYTHd3WGxpNmhuVDdWZGtzSTVuc2c4SExrK2Ez?=
 =?utf-8?B?RmpPZ2h3L1Y1QzJVQzNGZkFKaFNoYWtNUVhRTEROanBMeWc2RFNRMTJwVkNv?=
 =?utf-8?B?MnZHZ05ka3NSS0dMTlpZWXpOWTBHNVI0RHpsbDFISkdjcGxVY09EWlg0N2Nz?=
 =?utf-8?B?V3dlcWxLYVZyb213QVl2NGt5S0RvS2xiRzVOYVdrM040R1ZOcU5xM2RtRDFM?=
 =?utf-8?B?NzQyM2hQM0tzM0JNZmliWWlMejR0ZVV3emdNYnZ4Q2lxSHAzckVTNDBnc21B?=
 =?utf-8?B?bTZFTDlEdmFQVTJQR1l0Z0NmdTVsZTQ5NWpWVzVWMEJzTFZsdjhvNXdvV09n?=
 =?utf-8?B?cWxkcEtrTitWRGtheVRjLy9pRzJINnkrU0JkMzhEZEY2anlCZlpaWmdjTDhr?=
 =?utf-8?B?ZDROTXNsT2xUREFXNGtIeUZNdTdJU3JmaS9uUS9zSDF6d1VWbHRWOVlDZ09O?=
 =?utf-8?B?T2RqUHp0ZHBuczIwdi9lcHkzbkUwSGQzK1hkTHZLNTNwZ2lhRWR0THV2dFlR?=
 =?utf-8?B?MUVHT3R4eENWNm9EbG5PQ3Frd3VwK3BJeUdRZz09?=
X-Microsoft-Antispam-Message-Info: 8Xz4+4CXblbxXelLlNzMKZJiwJ9ehvn3J7W5GfPQ4ZHUy+RIGqoKy2SfMKIzF71fEndwJmpegLvcadSFoj2xegdfacIRXvkN/6/vZWvOIs8jUvymJq8NutMcXtP1Axy3Ftfu6617cu7PfrNCVUYg4pLKQN2Ji5paCPi0ZAYtRHrIFqmVmQA/cFrqmiSp2g870Vw14vm/+YvjUPinhSIIv2YVqCNygJ6MfnFYGPVVGvi2N7Qvu2NBPXIO08XQwamCEsdgdHZB96CkduQxryY1Evhta+kgKX0ZVv9zMQj+ps+1V0zfqOnMEuGEbaLjRpV+iiuNj67LYuqMwefsGyh+nriFWR/1m81eVV0Q1N7w8yc=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2680;6:uNg8HtBe1vANh3os8I1lqqcQhENgqwXWQAV6aRz6KoVOKZoZ4mmMv/rt7KE5jsyI0J0HcL/i1MM4roVmRfk5G4NkAdJmP0xuzIqzulR3XS2Veu65ABjfZtyDMvqJBiREntSr3WpAx8YNnbJvsiO1KfOpIdmWULJ1TORsR+hl9zcV1kuN004Md5ApjMePi41msIK/jxrcmosdnkRClVSON3E1XWYEXYwNscz26FJJDwbqbuHkpCbHWX6Zseilbz3EVQGfmMxc5bYv0YAxc6ZmaBvMikExAlbBBJzuP9TqVUxyp/8PYypUp+MF+0ScrXAMZFE/ZEOArZ8mZndcm4kkdDHjnNvycw5B8MUFpik6AcEyzWkp0tva0m1YzE24vglqoVfxXuXYi216/GLfa1WIuzFal8Ncr0l+SseHCvHNLz3eNQDvdOpCEeM2EtVcVq9bw63xb5UKmhYP4k/4IyKHnQ==;5:5jMJBLEIltTcbY0KMT3YyDd8/gtAjFrHyIA6OjF6veUnT/V0zrY9luCmcLWrDaoGPGiav/B1kaoT09ib7JlBSqD2IoBFsL9Aq5V90YhPR/EwNxVp3DbENLDibMGUSrxmZIjn11ChzPQ/31rmttqnjQh81RWfEZ02l7S0XNDRhQw=;7:3nXhQPEdF3v9PKtAAmH03VgsRgpWeOZSb6Qo+1wbJVw818ctUNpJdcP9pBURcqFQZgKySNm9EKeKtZFHfi7JQ1yVsqMX1YCIBS4GaIMDGcik6/2lnu0ZxfVsKGa5Egu/sHza4YHFnk0pEjhlpQP3mbaPCoXVknjdE1amcO8KDkC2bZA/DZ8o19xz6Z3tUSCq9wTTzhG+6+wu7PT/XZP7gEEg2E6rtHmwgIOw/ud1fZpnHOAICN/1cmK1Nyvo++mt
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2680;20:cH7TMaLSS6PjlnGHXsv5EyfhpNPZJ8AlMDT/xGT8U2801gLY5YPdLFdkWlNSPZspxGepPlRSrpdhDOsIZ4/wk4aPbg1BCGRySNg+aKPgpJ+C31+x5f9WEc/zZ1X5ddEueW2rDt9qqwfetZpYhp+qVZLzsI9/tpunRDZFONS+pPVTCC9x+fVu7QoULdtUPXz5Sd0NG8EKtkLNg2y4+LbvMP/gxrwS3DkOm7xTrqXX4Y+XJV1i7W6LDN6rJNy8KKO5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2018 15:41:37.3273 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f2010ba-e464-4694-bfb3-08d609d814ad
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2680
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/23/2018 11:16 AM, Paolo Bonzini wrote:
> On 23/08/2018 17:29, Sean Christopherson wrote:
>> On Thu, Aug 23, 2018 at 01:26:55PM +0200, Paolo Bonzini wrote:
>>> On 22/08/2018 22:11, Brijesh Singh wrote:
>>>>
>>>> Yes, this is one of approach I have in mind. It will avoid splitting
>>>> the larger pages; I am thinking that early in boot code we can lookup
>>>> for this special section and decrypt it in-place and probably maps with
>>>> C=0. Only downside, it will increase data section footprint a bit
>>>> because we need to align this section to PM_SIZE.
>>>
>>> If you can ensure it doesn't span a PMD, maybe it does not need to be
>>> aligned; you could establish a C=0 mapping of the whole 2M around it.
>>
>> Wouldn't that result in exposing/leaking whatever code/data happened
>> to reside on the same 2M page (or corrupting it if the entire page
>> isn't decrypted)?  Or are you suggesting that we'd also leave the
>> encrypted mapping intact?
> 
> Yes, exactly the latter, because...


Hardware does not enforce coherency between the encrypted and
unencrypted mapping for the same physical page. So, creating a
two mapping of same physical address will lead a possible data
corruption.

Note, SME creates two mapping of the same physical address to perform
in-place encryption of kernel and initrd images; this is a special case
and APM documents steps on how to do this.


> 
>> Does hardware include the C-bit in the cache tag?
> 
> ... the C-bit is effectively part of the physical address and hence of
> the cache tag.  The kernel is already relying on this to properly
> encrypt/decrypt pages, if I remember correctly.
> 
> Paolo
> 
