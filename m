Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D77DC04AB8
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 21:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6D342147A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 21:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3d7K+zm9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6D342147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbeINDCt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 23:02:49 -0400
Received: from mail-bn3nam01on0056.outbound.protection.outlook.com ([104.47.33.56]:7648
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728090AbeINDCs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 23:02:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QbLj0XPm6vr8zgXNRzbcdu80J+v5lVg1zpUm8KtD1o4=;
 b=3d7K+zm9x1lcEBvYYG/oO4JaNXBIVs1U3KT7fQXyoJM7jser9VHn1UXx6b454zgVqNw6m6MfnptBArDbFmoIl5wbFLavgdPHdLY9vihCEa7LKvhaFOdzHZNDDjn7i6vgNM1BWVtiEa+K0r9yxfZnW+Embgmn5Yp3ByW4pGeSnPc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by
 SN6PR12MB2688.namprd12.prod.outlook.com (2603:10b6:805:6f::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.16; Thu, 13 Sep 2018 21:51:22 +0000
From:   Brijesh Singh <brijesh.singh@amd.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH v8 1/2] x86/mm: add .bss..decrypted section to hold shared variables
Date:   Thu, 13 Sep 2018 16:51:10 -0500
Message-Id: <1536875471-17391-2-git-send-email-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536875471-17391-1-git-send-email-brijesh.singh@amd.com>
References: <1536875471-17391-1-git-send-email-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: BN7PR10CA0019.namprd10.prod.outlook.com
 (2603:10b6:406:bc::32) To SN6PR12MB2688.namprd12.prod.outlook.com
 (2603:10b6:805:6f::29)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc635e2e-061f-4a61-5577-08d619c30c5e
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR12MB2688;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR12MB2688;3:5MOrOOMmMk74WouE5R0JMVmp1SZ0LR1j5+L3599w+viaDgnwntusbvkZPze5kczVBFVfR3zFLtVMsfNOTrQbmt/0pnKHGUnjzkI6l7gKYca3Dln9rFAtczq96hLr2UUf+k4rm3laQPJsykcTwI4nB8PlEZQ1QWELJk4O9/jfBKX4G19ND8e79M38/FRYj4pYPYIFP5h33xcTC+egb5LkmPBXbiArin9Bwn9R1h/UxYg55CtwnvF7zNocqZ+BQ5+g;25:RJCSM65RLhosnWI3AgoaUO0KCMW/oaV/P7cfF8+ABqF7oTfQjLsl8xw1jf+EmTuy6KJf0/Ie5yUzveb3nTVc5Xr4+tQk9edXyqPhBvlOuxI+IO4ggguXxGoC3wFgP7ALhjeCK7WL67ysyKcfGTY+DwlLjYzqvqhOfxl7TT7bhSn3jgYwvbyg2cNzEE6uLasHf0fTc4m6HSTl4WMoMH1yNboqIrvR0qWXtSNwP0VNBRXb3Lycx8WU9R1ByeBs9g4yLxArqkgn1Pb39cOT+x3n/iHJhnhEfLi84yfeIHiJ92jKpRifyOkjUCYsqNcVofpOgHP2dZtApvdpTNKN5o1D1w==;31:pNHeFBxh3VgTmm3Ni74DUWDXinwqR1RUTs9JRVlexzS8ilrCufDHg0413UzysDbcfy9ZJsWvUDLoNTiwSpptaATG/oUn9uY96sH2cPCAXKQUKN5Eg5Owgr1yLyatMq1cT9ICk1mqUeTbIoerCY8T4or1/t8tjMF+32tgiDfSIwMs9Uhpf1V+RZCy5vvTFg0K0RLc6t6tysCXfVBRXzaAgMXgOw2mkhsXyXFcYQ/toa0=
X-MS-TrafficTypeDiagnostic: SN6PR12MB2688:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR12MB2688;20:z+Igbx+kkbzIWlMaZfYhK8XIqgauoX4BhhT9vLBqBTEVEKj7zPNMR1EoCvQvAkh1ZSV5t8Ky3WNbmNe7zLKChf14yR0o1twrqMpEC2R4e3Q1pmRBcDgpfn7hxWiB/coCKpQAyokT1bQ6nejbSDqKk3zyHZsuwvlr/eWLJ5a920wOYtYf2GharDhpd7aDsXCrecQqURPWvAG51KzPQTkXknsHvmJzpEvenbWUisvQqP/WM1qLE5ZXiTM/tjYpWCgH7COlVjV5e68N/MYssLF0QUPP/BvDI7tlnKZd9eV1vY18rnR6idywxyPGQDIP+B0ua2ZjyAgLm5vphAybMLjQq+iHCkKQinOakCbfzPLgmGLZJT6c9L45mkLdKbjUG7BTHQhg9/WQnlNlBXmyK8PxTPJ1ucU9U+H9YJdInHXnRGtwwZR7xqzxuI+IC8KBTYmTJ78P0Y5W8IiqlQd8vmXInAqIkXftrPrBYmenJdLgPeV1E7mfo6Wy8zH6LmtulpKO;4:I53nLUNp0RrOqrMC1TDVS9/Mrl4100sU+OCUxZvok/FAH7TP06LtlJ4cWu8JQR1fSkrWl2NPVmIpYONx+jI/QIdjO9eLdhCaiu8D46fcVv/uOrwWR1Y2NKGubNeeNbw5LW116Gd3Xnagsgqy0ZHuS7FFtaXtzsARudYx4m2YAtnzYudcV02Cgc9lRTbwZSbFoWskHCbx5Brln3TJyvRZGyDP0B0KP0gS7FhYjMvmIDXpyZKMJjURI76T2/dkWbcZEl1is68Ip8SCfE8ZbJWnkIQqvzCIJ3yDTcOOEbsSNYlCLDHERyaq6+bqRwylUGmI9VFnqVTvkj8FMcQMiV1f4xjnF4Tnd1Vm7nCU+MPmkXk7vVcSqg8icrrsO122ovKh
X-Microsoft-Antispam-PRVS: <SN6PR12MB2688EC4B14F1BC865E7536A6E51A0@SN6PR12MB2688.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(767451399110)(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(3002001)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699050);SRVR:SN6PR12MB2688;BCL:0;PCL:0;RULEID:;SRVR:SN6PR12MB2688;
X-Forefront-PRVS: 07943272E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(366004)(376002)(346002)(199004)(189003)(26005)(8936002)(81156014)(478600001)(316002)(53936002)(305945005)(76176011)(16526019)(23676004)(52116002)(7696005)(7736002)(36756003)(47776003)(3846002)(6116002)(50226002)(66066001)(186003)(6486002)(5660300001)(2906002)(486006)(68736007)(54906003)(476003)(2870700001)(8676002)(386003)(25786009)(2616005)(50466002)(956004)(81166006)(44832011)(53416004)(4326008)(446003)(105586002)(11346002)(97736004)(6666003)(106356001)(86362001)(142923001)(101420200001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2688;H:sbrijesh-desktop.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjZQUjEyTUIyNjg4OzIzOkN0Z0tmUFY0N0x3WCsrNDFIdDJoLzJrRWxh?=
 =?utf-8?B?Z2lDOVhtZ3JlYXIxRXlnMFNMRU5BalNPUkVLTStiM3VsK2lmV1BJc2gyc0s0?=
 =?utf-8?B?YmRqUE5VTEVWSkEydkRETEcySWNmVnV0TGUyOGQ0U3djRDdjNktGbTVXVStZ?=
 =?utf-8?B?NUFaN01Ld21OUXhkWC81Q1h1czNlcW5VSk9zazcrZlVlU3cySFpwZ2RPYThk?=
 =?utf-8?B?aXErQWs1cGJuNktBRDhpalI1dmViaU9nUW5MbFdUSXlyTXNDaityalI3aS9D?=
 =?utf-8?B?WkFBUVZjeEg0azZSMWMvb2dpTE5hUFpZVldnazAveU41TVl4anZYSGc2MEox?=
 =?utf-8?B?NFp6bHJvM2IzNjg2WDlzVXNtM0Q5Z3ZxbDdwL2U3dXIvZ1FjMWdVeUxVRkVR?=
 =?utf-8?B?WkFISDF0dzhOZytxbjVicExXNFB6Uk5CRHlWVmU3Ykl0eFg3QzJrVnZnZlBV?=
 =?utf-8?B?dW1WcGJsd0xPMkJIQy9pM0VMdzZwVG0zdG1ySFpSSDM3Q2J0QzZxZWczaXQz?=
 =?utf-8?B?amIwcnVydzZ2Y1l0OGNoL05sdTh2Qks4MnVVd3ZaV0p4MjQrT3pUUGdCK1hr?=
 =?utf-8?B?dlE2ZTJRZjcvbys0VytWRFR2U1prMUk4ZWxRUUt0TURFUjd1d3lYckhiT3c3?=
 =?utf-8?B?U0FSbS84ZFFvTTdySTNsa2JmZ0VwQXQxV1UyMVFUY2MyUDJVNTdtRFFkRHFp?=
 =?utf-8?B?c05hVGVnVTdMWVMxbjFzTVpEQkFXM1AxS1dtVkNmYWhOdHN1WWhUZFpCZ2Vy?=
 =?utf-8?B?OVllYnJlNk55VHlDczlmMDl5bG5XenFwVFAwV2NuWmQwYlJzK0puRWNPOS9y?=
 =?utf-8?B?RmJBeDVkaFVWb2cyZXErL3hHNGg1VmNmdXN5dkRJanlCTmZhVHRSQmJ5OHlj?=
 =?utf-8?B?SE0xN0Y0VjM1Wkh6UUY5SEdJM0k2WTlMYkxibmhlR3JQejRwS3o1aWpJRitr?=
 =?utf-8?B?ZEUwd1dFbCtRSWw2c0liaEJZekRhdDRGMHZXWG9pZnF2Rys5TmhwWnlMWDN0?=
 =?utf-8?B?MmtnNVlyaUtvbjVCdnRldUM1aG9oNzdWdDk3akhmeGhRd1hINFMyWHJ0aFBh?=
 =?utf-8?B?RGpwcWhaNk43dS9VZXU2OXN6Ky9pOXNqdzhJaVRtbmdVVE41UG5QMzFvS0xt?=
 =?utf-8?B?ZnNqN3JGeVluYWpORzJkcWw2YzlZSXc4dkFkWmhTNFEyNlZNTStZZXo4ajFa?=
 =?utf-8?B?WUtRek1zMTV4RjdXbllJcEcyK0h1c29DQmF0TnFCMURid1pqQXlKYVA2Snov?=
 =?utf-8?B?djVBdCtuTENzNEd0ZkdLaXRsYzFjcEFSeVBxbld3S3VzQ2FaNkpkL2gxYmp6?=
 =?utf-8?B?RUpaNmhWYjMvbWp4WTJDdk5NQWZZNUN6eWNkQS9ZbkgydkRKYWw2UDdKWXNY?=
 =?utf-8?B?WkNRY2U0ZTIwVi9qTEhRUC85UTgyT1JVbFgxajZmRDJaZXdGTFdFK0phQ3l0?=
 =?utf-8?B?SXBpQWgrUWE1ZGhuWUtHNU1MeXB5VnVuZjlBQUNjTk5tb1BZeERaYVBPUFp2?=
 =?utf-8?B?ZmIzZnFWbzJZWVpNQ0JDQ04vVjRTeEVMWTBmdlo0MUhWVVg5OTkzTlQxWEtM?=
 =?utf-8?B?QVZtZzRaVnN4c3FmNWRraHI0eUN3VXRMTCtGRUlSRXNBQS9mMWxjY3E4bHBQ?=
 =?utf-8?B?RlRBSldXQnVUKzlwOXc1cDdsOHRFRFpTSi9YdjRYLzVSeERDR2dSbG5nPT0=?=
X-Microsoft-Antispam-Message-Info: zJAX8Rjn+Zcg9pdUa7vU0NA2yfX0PWImF2dV4h4qC6hhbigmDzYp2UyDBPm0k27kg9hQaJEgjdRI51XB9uiGo5DG7OqF85GSdYGNk+n7wgYjBfiitxIl+7FLeLtAjW6r/AFdr4yoQ/T44IMfobcjbKvDZLfiP5OGU6sXOd+zrMmne9wQUdpZnx8XZyEAc3nAoqxgNqAsAXZ4IDaum4HiEloJhICdOt61DgX6BNUkmYlXYRRvivGg1DVkqjjN75reja/HMEG+ZHDYjXlxiga6YRE0/P+8MhAQfXnqyxnzodVaZrw9D7P15NHvkhy17AeTNB0jSlNktGpSflpt6aJHqXm0vEa4zTqsN7p9RLbMucs=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR12MB2688;6:UjI4bg+9e7n8kG806XXZLENCd4Tf5YuamqN5xaKje5QCAPO60A6CNaTKa8vBm0NpSNLCQdpyriuKtF0GoxrfIbOpKRUdTW9YYllkVcLIABKOFPgEUbJyCtJhRVURjpQ34asnMX/GKeZC+HXxTBcu+lmDN+fH75Z6OVTPpgVI/fRbcpiHQrqjx2yvqCHDkfVxPxoq5zciXTg5JlJGDJKHF1lShQ+W2K/36Y8rH429ysYyIBWo0hkbqqrfjPFFe9bSMXCjCQY3s/6ZkVivbCy1JvrPlXI9R+2u1Q3NQbkLPWu2D8wLrq0hr3Dl46h6rTzxf/B5F1sye1RXVnD3OZDXtSUH872v18o1whHh7P/sWq+/kL1/rfijNWHqSVGUOUjEltot1WIkYN57PqtMbHoDCKdXPbC8A9EvAIj82ghHmFvz0ZcVRBFar5qBbw1hdWnC+7/etpubS2g9HM9DN25s5g==;5:LpYz3LS5nmReXbwAlPz0s9XxAeBxRzI87RAq6NoCxSH+6Uvr2+NUQJOFffTgT4qJCtxyKcnTurijIaLwUAHi59jbXjOIqZbcqvcAPoMui3H3FFvFpbdRpC4v8cL0Z9OyqQURs3mNnXUHVsNX2I+KiTcacaUWz91FKmFJIlzsbsI=;7:gwVtJfIcMTqblBnE77TMYPNL1vEAri6p3Zlw4Uk6MFeyVCcnbnVJ7ZiRL4bKMkyqJ7q+wJxkawzifXcOdKsBgdsE3F+iMZMD8NaTFqBcSk9p3fvxwAFCoUB6vVqco3D56YAt8ccYR8wj6/U//S4Am2HDU8BOoSYU4I6Wd7UQIYBXZaexNZ55SgdKdvTRM9tg0zpxZoZMJTwsKKMoNeJclty+cI28LqfeUsIbPbEb83Rm0lA0ZSC8ZxAuBxu/SjpJ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR12MB2688;20:sTYcek0LFP5cIhGEOOmJXEDipobSQXZMeSsYzA4kMOfeXNecx6y+hcLgp/x18VeDhgAitoGTvMS83s6M2PpG+QdF65U8nw6W1xlV9Pu1wO6u3N87g7KrQ8TUmjLSRoQj9in/U4+SmgN8EXi4qLZ1XxgjS0k+Cxjj8h/LgezTDg/8Blxm8chiEXeNMhbftZuq1Fz83WkbpYclboGUTErWLJ2IIBZOSK5DIKRug/z5STbGif6q/5AvXqO/hDsCXrVE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2018 21:51:22.5462 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc635e2e-061f-4a61-5577-08d619c30c5e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2688
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kvmclock defines few static variables which are shared with the
hypervisor during the kvmclock initialization.

When SEV is active, memory is encrypted with a guest-specific key, and
if the guest OS wants to share the memory region with the hypervisor
then it must clear the C-bit before sharing it.

Currently, we use kernel_physical_mapping_init() to split large pages
before clearing the C-bit on shared pages. But it fails when called from
the kvmclock initialization (mainly because the memblock allocator is
not ready that early during boot).

Add a __bss_decrypted section attribute which can be used when defining
such shared variable. The so-defined variables will be placed in the
.bss..decrypted section. This section will be mapped with C=0 early
during boot.

The .bss..decrypted section has a big chunk of memory that may be unused
when memory encryption is not active, free it when memory encryption is
not active.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
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
 arch/x86/include/asm/mem_encrypt.h |  7 +++++++
 arch/x86/kernel/head64.c           | 16 ++++++++++++++++
 arch/x86/kernel/vmlinux.lds.S      | 19 +++++++++++++++++++
 arch/x86/mm/init.c                 |  4 ++++
 arch/x86/mm/mem_encrypt.c          | 10 ++++++++++
 5 files changed, 56 insertions(+)

diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index c064383..616f8e6 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -48,10 +48,13 @@ int __init early_set_memory_encrypted(unsigned long vaddr, unsigned long size);
 
 /* Architecture __weak replacement functions */
 void __init mem_encrypt_init(void);
+void __init mem_encrypt_free_decrypted_mem(void);
 
 bool sme_active(void);
 bool sev_active(void);
 
+#define __bss_decrypted __attribute__((__section__(".bss..decrypted")))
+
 #else	/* !CONFIG_AMD_MEM_ENCRYPT */
 
 #define sme_me_mask	0ULL
@@ -77,6 +80,8 @@ early_set_memory_decrypted(unsigned long vaddr, unsigned long size) { return 0;
 static inline int __init
 early_set_memory_encrypted(unsigned long vaddr, unsigned long size) { return 0; }
 
+#define __bss_decrypted
+
 #endif	/* CONFIG_AMD_MEM_ENCRYPT */
 
 /*
@@ -88,6 +93,8 @@ early_set_memory_encrypted(unsigned long vaddr, unsigned long size) { return 0;
 #define __sme_pa(x)		(__pa(x) | sme_me_mask)
 #define __sme_pa_nodebug(x)	(__pa_nodebug(x) | sme_me_mask)
 
+extern char __start_bss_decrypted[], __end_bss_decrypted[], __start_bss_decrypted_unused[];
+
 #endif	/* __ASSEMBLY__ */
 
 #endif	/* __X86_MEM_ENCRYPT_H__ */
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 8047379..c16af27 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -112,6 +112,7 @@ static bool __head check_la57_support(unsigned long physaddr)
 unsigned long __head __startup_64(unsigned long physaddr,
 				  struct boot_params *bp)
 {
+	unsigned long vaddr, vaddr_end;
 	unsigned long load_delta, *p;
 	unsigned long pgtable_flags;
 	pgdval_t *pgd;
@@ -235,6 +236,21 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	sme_encrypt_kernel(bp);
 
 	/*
+	 * Clear the memory encryption mask from the .bss..decrypted section.
+	 * The bss section will be memset to zero later in the initialization so
+	 * there is no need to zero it after changing the memory encryption
+	 * attribute.
+	 */
+	if (mem_encrypt_active()) {
+		vaddr = (unsigned long)__start_bss_decrypted;
+		vaddr_end = (unsigned long)__end_bss_decrypted;
+		for (; vaddr < vaddr_end; vaddr += PMD_SIZE) {
+			i = pmd_index(vaddr);
+			pmd[i] -= sme_get_me_mask();
+		}
+	}
+
+	/*
 	 * Return the SME encryption mask (if SME is active) to be used as a
 	 * modifier for the initial pgdir entry programmed into CR3.
 	 */
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 9c77d2d..0d618ee 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -65,6 +65,23 @@ jiffies_64 = jiffies;
 #define ALIGN_ENTRY_TEXT_BEGIN	. = ALIGN(PMD_SIZE);
 #define ALIGN_ENTRY_TEXT_END	. = ALIGN(PMD_SIZE);
 
+/*
+ * This section contains data which will be mapped as decrypted. Memory
+ * encryption operates on a page basis. Make this section PMD-aligned
+ * to avoid splitting the pages while mapping the section early.
+ *
+ * Note: We use a separate section so that only this section gets
+ * decrypted to avoid exposing more than we wish.
+ */
+#define BSS_DECRYPTED						\
+	. = ALIGN(PMD_SIZE);					\
+	__start_bss_decrypted = .;				\
+	*(.bss..decrypted);					\
+	. = ALIGN(PAGE_SIZE);					\
+	__start_bss_decrypted_unused = .;			\
+	. = ALIGN(PMD_SIZE);					\
+	__end_bss_decrypted = .;				\
+
 #else
 
 #define X86_ALIGN_RODATA_BEGIN
@@ -74,6 +91,7 @@ jiffies_64 = jiffies;
 
 #define ALIGN_ENTRY_TEXT_BEGIN
 #define ALIGN_ENTRY_TEXT_END
+#define BSS_DECRYPTED
 
 #endif
 
@@ -345,6 +363,7 @@ SECTIONS
 		__bss_start = .;
 		*(.bss..page_aligned)
 		*(.bss)
+		BSS_DECRYPTED
 		. = ALIGN(PAGE_SIZE);
 		__bss_stop = .;
 	}
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 7a8fc26..faca978 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -815,10 +815,14 @@ void free_kernel_image_pages(void *begin, void *end)
 		set_memory_np_noalias(begin_ul, len_pages);
 }
 
+void __weak mem_encrypt_free_decrypted_mem(void) { }
+
 void __ref free_initmem(void)
 {
 	e820__reallocate_tables();
 
+	mem_encrypt_free_decrypted_mem();
+
 	free_kernel_image_pages(&__init_begin, &__init_end);
 }
 
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index b2de398..718acdf 100644
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
+			(unsigned long)__start_bss_decrypted_unused,
+			(unsigned long)__end_bss_decrypted);
+}
+
 void __init mem_encrypt_init(void)
 {
 	if (!sme_me_mask)
-- 
2.7.4

