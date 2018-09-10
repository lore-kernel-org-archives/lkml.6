Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B8B7C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 21:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1DBE20865
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 21:50:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XDHNpzft"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1DBE20865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbeIKCqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 22:46:31 -0400
Received: from mail-by2nam01on0054.outbound.protection.outlook.com ([104.47.34.54]:62169
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726217AbeIKCqb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 22:46:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8toznBI3kRi6b/9jCowEx1qjVmin/J0RLmxFSCAkd+c=;
 b=XDHNpzftmsuHo8RNCFchAZ4bhuX1wCVfhoQTg5O+lhyIhrBr7d9x+DWYAl0pe2JfuavW9f6cBTdGnGUjOJqawJyjSDcMdOZWToLk1emCv7mOX1lJ0GKR8NDUkt5ue/loGiH7j14rMGneQgTtR5EkyqeoHU7kaIx00/HjMOtElnI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by
 BYAPR12MB2680.namprd12.prod.outlook.com (2603:10b6:a03:69::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.15; Mon, 10 Sep 2018 21:49:33 +0000
From:   Brijesh Singh <brijesh.singh@amd.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH v7 5/5] x86/kvm: Avoid dynamic allocation of pvclock data when SEV is active
Date:   Mon, 10 Sep 2018 16:49:11 -0500
Message-Id: <1536616151-16738-6-git-send-email-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536616151-16738-1-git-send-email-brijesh.singh@amd.com>
References: <1536616151-16738-1-git-send-email-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: MWHPR13CA0010.namprd13.prod.outlook.com
 (2603:10b6:300:16::20) To BYAPR12MB2680.namprd12.prod.outlook.com
 (2603:10b6:a03:69::29)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9317c3d-9e65-4c5f-0d86-08d617674c21
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB2680;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2680;3:cWqhx6UXSVg2TjgXv84GnyOiEReuMfoolBA4K1zTdkmbgKVh2rQ9rDGWk7zyMJzVozZ3akR6Gm5lUX6vyGRHSB04Venbe1DSsbiF+h7rln9q+tTtAEx46UVg1c2iNPQKA/wUJWItQWlYQuLaXY5b4n6qgBw2X1Mi8hh5z5Kd9IiloyEAPoSsO21cdR/+PWnODaY0vtX+76JyIMEb1YNypv7XF31NRENBap3BkFbJnnc+n0D8GJsijsBjPVjlOYLr;25:0az+VwaLGCI7nQkLeIlNoYOjBjV9W8Jh+h2rGVrhaK6iYR6WJT+i5lTQCcFInMybTJn/QbnjgsaFUrewpH7IXV2tVCQ9pLZGck0duFHoH1EUuk+h+yKAuiSmhZ4KFz7XZcwHVqsRESNQttNuTK45T/xFrtPbK+aA0BOje6MtUlsqo723cOFEZF1hoK6/iXq4qNc9mYGqLVGSPgz6jwqZ0CM68yXm4jmfmnimNaQWFgHHr2RFDsilEV+6U2iWGwortORtvKt1WtBYWtyG6nETkcPJlRnzKPlEamMb877j9NHOlrI9gCKZIjxZaT3HEpg5cSt0MKVl6GYy7JhjMCfM1Q==;31:OHeF4KFZkDaOoelmxMN6EVIkCtIIhZavlrd2ehkBrYzF3JZ2xgMf23xvGTy3JTu7//+4BDxEpNoFU1VV8Gs1A+fC7n5L+a9kF/m39nq5u/L6gh69jsINi/2IFS4G0YldE+4pw0W0vCLhe8Zj3f1FvC92pW855KeJCRDW1Z+v9mp0knr4TiO18SiGIjhHMCMP8/2XrWpe7rSTsBsZww5KBZPV9+vs6aqLnh6FjIcIXC0=
X-MS-TrafficTypeDiagnostic: BYAPR12MB2680:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2680;20:8tNJTRwXV2yof+cRs2qxuN91i2ZQqXYTmBMDaxoHfsD7ioH48Jayzip6Pe041EHAJwgeqbw5vAPmfLlAGFVA0lh4JgIgSKXEaU+BEeP+Jw9HTNM8HSPh0TPLI35ZfktMYH8F0jzHb6Q1RHuGv7qlH1ZBHbWsjx0M9dLoMkCpZdmV3Pgtkdvj/5cgymvhqqHxZTw0K7NTg4OAlYXpU8hhf8bN9RpReIiB9x/RDqce6lYVDisTvoXxDVQy9kIfcuwWC5wW+rrVYPFUqjfE5FZZMDyOZtHEwPpV7gsCYABKQrwpQGCILMngMz0Nyb5/6nHycVhRHEGz8OdPERJNXyapYt3MfUSuQwdAhxCJBiOobCYuOcfB8fy8cifxWBxUWUtnlynl4GGPfvYbUID0IAv49rS9KudUUaU57Z43UyQLiKfhDp75KtZ+2lcS5BKqTYp5LuZ0/run90OLTRST3pL4DKh59n6qTFGV82WbtmyfFDcymBl/Y5Pq1cCpzWrbbCvy;4:tdo9uXm+Vicpe7jmZ6iLJ5aGZ+7i3q3Jl21T8YtFqifE1LjPfX6SJsuL4Jdoe8cyNk0yRc/hzStNJTiRWX7dgmDr8go04xvqj875k1J/otOTA3l5XShlEmkwPEV1XeOtdHWwDY1iKlgIiE2cjxliPn4REpR5Kf83Uq4zlZx4UrjcmPlDldsnUzYHpKICcDCvBx+chCYlWVxF4tGmlxj8qBLTB+CkjeZUAqPAISYhtR9mZnJ07HMpX+ANLVI5xybftNZmd1WlCO1mq0ngOqRaO7fdrkh50mREhzHWOOp6w3zuNc+yf6kKoznkhojf0CuY1Nu0QcrlyUOdaDiY+octylL34j6q1p1tNqv7U351lg85wuFDe61Il1gWnlGMGwTm
X-Microsoft-Antispam-PRVS: <BYAPR12MB2680F773F4AB4E77D6742907E5050@BYAPR12MB2680.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(767451399110)(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(10201501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699050);SRVR:BYAPR12MB2680;BCL:0;PCL:0;RULEID:;SRVR:BYAPR12MB2680;
X-Forefront-PRVS: 07915F544A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(346002)(396003)(39860400002)(366004)(376002)(199004)(189003)(6666003)(386003)(8936002)(53416004)(7696005)(52116002)(25786009)(23676004)(76176011)(105586002)(8676002)(106356001)(50466002)(50226002)(26005)(186003)(66066001)(16526019)(6116002)(54906003)(3846002)(47776003)(2906002)(97736004)(2870700001)(4326008)(316002)(81166006)(36756003)(446003)(81156014)(476003)(2616005)(11346002)(305945005)(7736002)(5660300001)(956004)(86362001)(44832011)(6486002)(68736007)(53936002)(486006)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2680;H:sbrijesh-desktop.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWUFQUjEyTUIyNjgwOzIzOllnd1NxbWtrbW5ZSGFyTHZLMWx5UjVRRjR2?=
 =?utf-8?B?cjg5MlZacEx6Wm1KMFlEbFo0WWVwQUNNSTNQTkZCWmw4UlpMZTJDaW9idUpk?=
 =?utf-8?B?eHhrSVVnR0lqQ0xlZ01wR0lxUkRYR0wzYW5LTFJEOXZOeE5PZEV5NjhETFVi?=
 =?utf-8?B?bEZoMWZvc2NuUUpoQ0FiNlJVQ05nQlNHMlBFMm1zbmV1THE5NUdGdWlsT2Qv?=
 =?utf-8?B?Umc0OEFLY291UmFvV3I5dmtQT1hRVVV4VkZ3TmdUNG8zS2FiUWJESlM1WVpT?=
 =?utf-8?B?OTYrd0hRRXhRNFRaUkt1ZzRtMzk0QmYxYjAxRmp0NFJnWGd2WVd0K0lka1NM?=
 =?utf-8?B?WFlUOU80emx6WkMrcFh6LzNmVGQ4Z0xueEtNYytNR3JFOFh4ZnFUN3Ixa1pH?=
 =?utf-8?B?TVBsZTJacjQ4KzdnL1lET0VZOFB6NDNjME8wbkZLYXhodVIvWFIyZjBPT2JG?=
 =?utf-8?B?OGgySkgzeXF2aE5JZ21UY1NSNjJucnN5NGYxVGcybjFMd3ZuWTk2ajlQYUsw?=
 =?utf-8?B?aHlXVGVSUUVudUE0eU9xQURnVkJIUGpVN0hmL1dCSUpnRG5VTTJHc3BGZmRK?=
 =?utf-8?B?dmdWeldYRHcrWVhLVURMNGRKSUQ0aHBoMUtwSGxtQ3U4OVRoZXlNdVJOT2lT?=
 =?utf-8?B?ZDY2Sk9WWSsvdGU0aTcwdEYxTHh5VUhleVF3ekM3ZFliZGRMeEs5bUZtWkRB?=
 =?utf-8?B?Qy9vcS94c2tnZURwRERocnUySG1xU01WYmNZYVhBZHRSS1VaTlZ5OHg5RWFi?=
 =?utf-8?B?SnZHcGUwV1U5M0dNYjVHcGkrb1RVbGZIZlBlRW5mcVl3cEdLWmw1b2gvdjJl?=
 =?utf-8?B?a0RvZUs2NnZFUUQ1bFIveGJKMGFQaWN4cFk0UUdkRW1FbTR5K01xdEl6bFdk?=
 =?utf-8?B?Y2FleFdrRjhVeklrSjFYVHRtcmZaQlU2am9hTmpaQWFQQ2FPRkpVSXFMSEly?=
 =?utf-8?B?cE5UUFJibTUzckMxZ0RqS29kVmFKY3FhaG84eE1MUmc0d3dNdHNRZmEyQVI1?=
 =?utf-8?B?V2RldE1rN2Zya0JYYXNHalhXdkpYa09VeEp2SG1ZUXN1dmliYXV1dHE4SzJJ?=
 =?utf-8?B?ODQ4K0dRdHpVZ200SFJnQUh6OTdENVRtY21HVzhBTk80QlhjazlIbW42ZmpZ?=
 =?utf-8?B?eWVnSEJIZGlWRnErS01xTVM2SDFFTXo5Qm9nV3RTTXZ5ZTZHMGowc1h4dW93?=
 =?utf-8?B?SDY1UUNMZ04wU3RNMnUrdm4xSHo4bitQRjhjMm1vMzROVUFTRjErVG5mOEtL?=
 =?utf-8?B?cWtpOE50NFhpY1doeU80aHZNTW9uanV5NnQyYzRrZy9odE14d01aQTdtT1Zk?=
 =?utf-8?B?c0RpS2FBVFIzR0FBa0k2NnVyckZnR1ZvV0JPOWU4QlNkUkU3dWZELzZwVTJW?=
 =?utf-8?B?ZWM2aW50N0NFaU5LNXZJeTN2Tk9uNjluNTB2aXRyZkdDaEMxNW0weTVRcUFV?=
 =?utf-8?B?ZitieXNWWE9DWUgxOGE4VkNSS2w4T3VsYUgwbU9JVDMxSnpuWnp0UmZ5cmZF?=
 =?utf-8?B?aDNVMGd3NjNxYXBxNnVQSVZ2a05LOG0rQm9EdmZJQXZvYUd6eEt2bzI1S0dL?=
 =?utf-8?Q?oROke6b4yhnKqJPI39b8ZAqLqoVJmD3Y2NreeyUyokas=3D?=
X-Microsoft-Antispam-Message-Info: ASfjUyFKUAgf8vz2fJ1j9tyIYhHng/h/pDglG6MqHFqZRyMzodujx1Cnoh3XiStoYNNF4/Uby8AwAa6eC2wfFURHGBGxYlefOw0W1ACcH69Hi4p5va+TtxE1qL1zLeUVd3qCqef/lC7NYYnebvg+jPLB9VIqRaICSJiP1ANWOQO4QRomaWbPdbmJNSvTRt6M1dRm7lN8Q9Pv1xyZM121tfy5D6dsyNSCBY9zCt4O2vlxFrw6AftHwo/6EFQuaZ/K14W0cpgKB7JpwKe/Iilom+8Ud/fR7o2QmTybydpnN+4fCfOhYX2Nb7f7yp5GsQkIx3xEhGdV2bgxH/RsTtQ5AXaJ5Ub4kw+O1JivwsgNUD0=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2680;6:DtFUKZYMer0e/n421Y6jAcHrpdEUCYsfGADzJIhOT0QcudZXK+tYJIm5R2CQA49kpWZpifMb9gVLmcL8ho+aj5rWmDfzpXccwkonMk4Am0iNTYXNQPLJGAgIA64eaxufRwM3uDnp/ZRg0Y67R9sSMb8rEkEvexjrzeA+i/kQ0C2CvFv6kFbZWhz7uHg52AOYFa04RWSBW14Eccuaa/+riT/efzRrqZK01Xcr288bkrgSaVYWQFgff0dJzBzmLGwARS5Xw/mm67ccmUErDTmp+SyYmm2U9L7oTaye3HIIxWYp0Ah0UM6u1/48fzUShrFEcRF0fJy7sjjXGUexmrDSocGNFf4RTPXYJ8J4hqW9W5M7aSa5pkmqAGG2qZYefysZPxvtAnBI/tpcj4b4hL3K1a9/wmdC80z7UwLmdx5iDJzPdeSSIhB9UbNxyy37s75+A64Prs7IW9btAXZvzct8Sw==;5:9eMvt3X/194VS2KQ9XRZkkJvXO0gS0lezaebTGXxeOoV+GGo+bfVBqHtVPXxLjm3SGBn6sOLDP+cLhQMzj4RZbp540K3skmgvWQdrg1tsrNXzxLZGDjy8CkElFV1/2q6ECb528tg6BRXGbVK2y1x+cdzqALhDal3NK59LccEyBQ=;7:U3L46R1YAj2pnLgYUpFjBZgfGpwQ9fPZ7DJz28oNxHka7kzAP0K6j3aoZIjFqZWfcVFrgIvMatj4z294EKVbp/8vq31DczV1Wql4u12C8dsSz7h09aY+l1WIBNx2YHsTElNEGwWlgT+kCSzgwQpxlgGAuhb73mFgZms9YuPMeFbsec5W84k4Vk5elMGjshjSBRLpILVMmRsaDq+YJabWWynVPYt0xyqL/7hZ1orZlkq1WEm+WclNbHU3gsTmbRc2
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2680;20:QEOgJ1gWiffElO1/9jNxt38fZAh+hn4luh4jMNZvKBLsamwwv54pEzxTxaDbL/Dw1gEtcA4EyYG063oFsGF0nGSzJZvtgZtXN3RKAKSXlGW6LfEtdXljS/ByKZuLW7kYFv1LmTEdEI1vddpraPGwbrG2cSMAtE1Ysm3j3d9j8/tBuEae6hjKMhF5gs+AFkMcfZjK0Pe2CQ3P26P0HJerTmzxVZn04WQzsiPmgCxwzjWzgwpSMCGWO4xbQFWkjFOX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2018 21:49:33.3209 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9317c3d-9e65-4c5f-0d86-08d617674c21
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2680
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the preparatory stage of CPU hotplug, the per-cpu pvclock data pointer
assigns either an element of the static array or dynamically allocated
memory for the pvclock data pointer. Currently, the dynamically allocated
memory is not mapped decrypted. However, when SEV is active this memory
range must be mapped decrypted.

The C-bit determines the encryption status of a 4K page hence a full 4K
page allocation would be required to store a single 32-byte pvclock
variable. This could waste a fairly sizeable amount of memory since each
CPU will perform a separate 4K allocation.

Instead, define a second static array which will be used when SEV is
active. This array will be put in the .data..decrypted section so that it
is mapped decrypted during boot.

The .data..decrypted section has a big chunk of memory that is currently
unused. Since the second array will be used only when memory
encryption is active, free it when memory encryption is not active.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Suggested-by: Sean Christopherson <sean.j.christopherson@intel.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: kvm@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
---
 arch/x86/include/asm/mem_encrypt.h |  4 ++++
 arch/x86/kernel/kvmclock.c         | 14 ++++++++++++++
 arch/x86/kernel/vmlinux.lds.S      |  3 +++
 arch/x86/mm/init.c                 |  3 +++
 arch/x86/mm/mem_encrypt.c          | 10 ++++++++++
 5 files changed, 34 insertions(+)

diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index 802b2eb..3f2a5e3 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -48,11 +48,13 @@ int __init early_set_memory_encrypted(unsigned long vaddr, unsigned long size);
 
 /* Architecture __weak replacement functions */
 void __init mem_encrypt_init(void);
+void __init mem_encrypt_free_decrypted_mem(void);
 
 bool sme_active(void);
 bool sev_active(void);
 
 #define __decrypted __attribute__((__section__(".data..decrypted")))
+#define __decrypted_aux __attribute__((__section__(".data..decrypted.aux")))
 
 #else	/* !CONFIG_AMD_MEM_ENCRYPT */
 
@@ -80,6 +82,7 @@ static inline int __init
 early_set_memory_encrypted(unsigned long vaddr, unsigned long size) { return 0; }
 
 #define __decrypted
+#define __decrypted_aux
 
 #endif	/* CONFIG_AMD_MEM_ENCRYPT */
 
@@ -93,6 +96,7 @@ early_set_memory_encrypted(unsigned long vaddr, unsigned long size) { return 0;
 #define __sme_pa_nodebug(x)	(__pa_nodebug(x) | sme_me_mask)
 
 extern char __start_data_decrypted[], __end_data_decrypted[];
+extern char __start_data_decrypted_aux[];
 
 #endif	/* __ASSEMBLY__ */
 
diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 0b3110b..9d8bad5 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -65,6 +65,15 @@ static struct pvclock_vsyscall_time_info
 static struct pvclock_wall_clock wall_clock __decrypted;
 static DEFINE_PER_CPU(struct pvclock_vsyscall_time_info *, hv_clock_per_cpu);
 
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+/*
+ * The auxiliary array will be used when SEV is active. In non-SEV case,
+ * it will be freed by mem_encrypt_free_decrypted_mem().
+ */
+static struct pvclock_vsyscall_time_info
+			hv_clock_aux[NR_CPUS] __decrypted_aux;
+#endif
+
 static inline struct pvclock_vcpu_time_info *this_cpu_pvti(void)
 {
 	return &this_cpu_read(hv_clock_per_cpu)->pvti;
@@ -269,6 +278,11 @@ static int kvmclock_setup_percpu(unsigned int cpu)
 	/* Use the static page for the first CPUs, allocate otherwise */
 	if (cpu < HVC_BOOT_ARRAY_SIZE)
 		p = &hv_clock_boot[cpu];
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+	/* Use the static page from auxiliary array instead of allocating it. */
+	else if (sev_active())
+		p = &hv_clock_aux[cpu - HVC_BOOT_ARRAY_SIZE];
+#endif
 	else
 		p = kzalloc(sizeof(*p), GFP_KERNEL);
 
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index ae8153e..b78e117 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -77,6 +77,9 @@ jiffies_64 = jiffies;
 	. = ALIGN(PMD_SIZE);					\
 	__start_data_decrypted = .;				\
 	*(.data..decrypted);					\
+	. = ALIGN(PAGE_SIZE);					\
+	__start_data_decrypted_aux = .;				\
+	*(.data..decrypted.aux);				\
 	. = ALIGN(PMD_SIZE);					\
 	__end_data_decrypted = .;				\
 
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 7a8fc26..b3cc33d 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -815,9 +815,12 @@ void free_kernel_image_pages(void *begin, void *end)
 		set_memory_np_noalias(begin_ul, len_pages);
 }
 
+void __weak mem_encrypt_free_decrypted_mem(void) { }
+
 void __ref free_initmem(void)
 {
 	e820__reallocate_tables();
+	mem_encrypt_free_decrypted_mem();
 
 	free_kernel_image_pages(&__init_begin, &__init_end);
 }
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index b2de398..f1ab7f5 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -348,6 +348,16 @@ bool sev_active(void)
 EXPORT_SYMBOL(sev_active);
 
 /* Architecture __weak replacement functions */
+void __init mem_encrypt_free_decrypted_mem(void)
+{
+	if (mem_encrypt_active())
+		return;
+
+	free_init_pages("unused decrypted",
+			(unsigned long)__start_data_decrypted_aux,
+			(unsigned long)__end_data_decrypted);
+}
+
 void __init mem_encrypt_init(void)
 {
 	if (!sme_me_mask)
-- 
2.7.4

