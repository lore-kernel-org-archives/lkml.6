Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F12C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 11:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8CEC20652
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 11:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vd1rqaHf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8CEC20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbeIFQSt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 12:18:49 -0400
Received: from mail-bn3nam01on0067.outbound.protection.outlook.com ([104.47.33.67]:46448
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727851AbeIFQSr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 12:18:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1kAZqKdOFTzMMAAeVXWLDFW+lmC15xXpNRUUXTogFWM=;
 b=vd1rqaHfDi1oR3hEtGaNAl4rDizRFxVzxuNVbywfcOLGunqhwN5PPUSusMYEM8GpNd2LE+dy7W+1sv2RNBbMUBGAFBd6h+Y5WomFv5gu5tI8rZbHn81qgrY3mmHvRgds7YhvfGfAE27tBHJ5gndTS7eMJ8QXMzxVsCkYNfjXO2g=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by
 BN7PR12MB2675.namprd12.prod.outlook.com (2603:10b6:408:29::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.18; Thu, 6 Sep 2018 11:43:32 +0000
From:   Brijesh Singh <brijesh.singh@amd.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH v5 3/5] x86/mm: add .data..decrypted section to hold shared variables
Date:   Thu,  6 Sep 2018 06:43:00 -0500
Message-Id: <1536234182-2809-4-git-send-email-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536234182-2809-1-git-send-email-brijesh.singh@amd.com>
References: <1536234182-2809-1-git-send-email-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: CY4PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:903:33::12) To BN7PR12MB2675.namprd12.prod.outlook.com
 (2603:10b6:408:29::29)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b89d0707-b008-45ca-02e1-08d613edf990
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN7PR12MB2675;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR12MB2675;3:vGOcO9Obj8nuAn0DRyNodAR5ICArE0kriN+ovVC7l8BV/Rl6zJU8RxSmaU3H6gYCizVKKxU4CqGxg2+zbUwHG1/piqSWN7oOXDBh+uUC2JLjgYIBF0fASLbjjWzJbZ+20lOAPy5xa5MUiaMULsjd1+s9JgY8THnTAJGUKegFbvK/i4X1Ts4s1YVeoOPduhv8vUk0mgLtrOMnI2wr50hWvVx7Uq03jSKu0Nt9jbyLYJNxH7Q8vb25xHI9S7Zuo+Kj;25:UK/mU+PF/c6DsV4Zgnx5gySGQvM4QJZiB2P8Tulh+T8vU0I6RLbPy0kuZAXEzK9ESle6BpF4lOk/liHWdy/GaI7RheDywmewZm2h3nmn4tc/yfkdQar37yb6m9nBX/NNOBFz3jhcwkmjKQq5iJpgnQy8PQ8jsUUUKgNyhHGOPG3YtWu9PU/pKjxn/yd4/ERLoOOcWYRI7TJWRm6kixX3flGRjY5rX2ku8QqbkdeDBpK22j9IGD8/Q3LZ74vu61Hv8urFgwsHPo8JHApTUELngv80hlPSSOEBtkpBJI3MYUfnhz7Xk6XcAEsOGZ+bMFDyA9a07ETM7EoSR/pFYOxG2g==;31:ul33pe7MlQkt4wKxhCk/EjKYyhDf4n7mPVB6Acrhpk+fi5Kak3nqMd+GwL2NYaSDnN4+YKiywNe3cQK6bg9+KnTCY+X9VSuXKYqWrdYm644XMHVZxlkRVOS6VIpmwJIOPovOpr1pEAPNcglTPG+zx3Ct3DFJ9X+6n7egGgFgTubavwcOYnn5Q+wcAWjD1XWD5MbSdbjPP/extm0HVwjvVx6Oi9HfS9mNXNzPwOvVRcA=
X-MS-TrafficTypeDiagnostic: BN7PR12MB2675:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR12MB2675;20:sllJnzpxMzTP03/aFS5MexdJRKS2LzVFeT6zg9w6ipTrS6x/R97/l7hqdKcABHzADNmUSHhSzjBwHY2/LpLUIyIfDVrxKxR9343NtPjTI1nMQS/hprywPNqWvBFs2KTHPYu5MXmtP3K5UmMHXGGQHCC5gjJNnQIpscIewylX7u5iYgr9QIo4x3azbeoYdLPp9HKy4oytOHnaKRufikva7/4+5Qal0/S5AQSyIiZjF8c4SKYa1zV/PhA3wJVPl07Li9FXzrBA9TR1IseJULr3ZFnLkJrgOcVgaFR+K+gLu/3uWpX5/CsxnTOvoVWYSA3/tDKywWPw7aGPpYJiyZsZZrQOZzSXoJQzPKlA4SDukmAsnVjIe1XgQBNB0jboRHjG8cu/vf6SGAMgnahl7bh42ecxNaY5/5s7RZsEP0gcuGp3IY6K51xrCsMbcvUa8r0ijYoKDeMcD+w7pbaRqsU4FimSBlw6uo2VMQKvclmyAyCw79JV8HapoW3+KT2duEOJ;4:GZo0dgkFC8UFCrh/CfiYmNqPf+bgN5vkU28CeB6QJlWtbkdV1hL7x3UQg+HNl7RNO09b1J4wSr5Ruj4TWUpv8aPJXSb1QJNbO4l3m5dktKmT+Ofz+4awhmu5HZ8Yl/JlqK4jxKeMWulShoPy//e+jVOQaJRDuEO6gCIZCGJ8zCRE2VsY3M2/Mma/aTJnBLIOBrQ2MtvVpvQ9ejsaH0EwWEWveQJjoIRE5pLx/kCJjEPweNut5XAtGh5SN9m4lH20dygbQ4F9ebpJx182VO6vsmnTAiXmL0os4rGXZP1bF1ff3Xm9wv8V5aQn9RQ+z/jEs5tU0R8EiRe+fbRfiU+hk5yP0D1GHdY4+NsHjSe4VilAmC8gCTYVTLby2AQDWll97fkTO9jVxO8Y8V8twjpGHQ==
X-Microsoft-Antispam-PRVS: <BN7PR12MB267501E26939ADB3EFE79A9FE5010@BN7PR12MB2675.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(767451399110)(163750095850)(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699016);SRVR:BN7PR12MB2675;BCL:0;PCL:0;RULEID:;SRVR:BN7PR12MB2675;
X-Forefront-PRVS: 0787459938
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(376002)(366004)(346002)(136003)(39860400002)(189003)(199004)(25786009)(47776003)(575784001)(86362001)(68736007)(66066001)(7736002)(6486002)(53416004)(106356001)(6666003)(5660300001)(3846002)(305945005)(4326008)(6116002)(36756003)(105586002)(26005)(7696005)(50466002)(52116002)(8676002)(11346002)(50226002)(956004)(446003)(2616005)(53936002)(2870700001)(97736004)(23676004)(478600001)(316002)(76176011)(186003)(16526019)(54906003)(81156014)(81166006)(2906002)(44832011)(476003)(386003)(8936002)(486006)(142923001)(101420200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR12MB2675;H:sbrijesh-desktop.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjdQUjEyTUIyNjc1OzIzOnJQT05uSzQrbjBGOUNqcmpRZGhFTUsrR3Rz?=
 =?utf-8?B?amcyNWRCd3A4N2FFY2JxVU43SVVzQmxxR2dQK2tRYm9Na0hScVVTRktrMjBp?=
 =?utf-8?B?VitLUmxkT3BEbk9FVzVDMXZRQ0xPNHRTUWgrVEczckNYTjdwWVBGWjBmbE9i?=
 =?utf-8?B?WkIrOFRuMXErVmFTUXhGbW5yQ2VJa3NFWHViUmRlbnEyVVBQcUhITjR3d01I?=
 =?utf-8?B?RXA3MEtwVEVqMTcydFBFRGlsU0tnc2FaZ3NCZERqYWx4eUdZZzNzc0tUQVJT?=
 =?utf-8?B?NFcrTjVwbnNTeDRQMjh0WFJlcTdVSnNvMHF3d1hQZ2xWd1VnUThrSmtBOVhh?=
 =?utf-8?B?cDRiUGRXMHd0SlhkcXJMZUx5b2tFcmJqYW5BMkExOEhWYytzOThOeXRjQVpl?=
 =?utf-8?B?cWdhWW0xV3F2aitFQmFreDgzUFJXdmFZYkMzMG5pTklEdU9MMDdMMC9XUmEr?=
 =?utf-8?B?Y2NLVDFaTThmaXUrLzNSS2tVQlZrZnJ6SkU2cVp0QXZlS3k5MWlSdDRSb2du?=
 =?utf-8?B?QzVaS3ZKV0JpVDlROG1JR3o0cVVTY3JJTnFsVGc3WjJvRHNJdjhWRG93UWRU?=
 =?utf-8?B?M1hZbGhXeDh1VmtwbCtTYkNKOEx6c1hVSnBSZ2Q1Rmtyd2FHTmMxYWlhMktF?=
 =?utf-8?B?eW54L1BlY041Q2xqakdlc3VjMW9ZRW8xVTg1cGdWSmxBWjBSOVNBcFc3d2NZ?=
 =?utf-8?B?T0M1K2NQejdBcWc2eEFUT2NWVi96M2MyZ0N3bVBhWUtCb01EbGVKb1pBNlhF?=
 =?utf-8?B?SlBPSmo0ZWRVNzZGWUZmeTQxVnFNWVJkSW5aWkI4a1htekd6TVo3STAwWlpE?=
 =?utf-8?B?QlZvL3FxWDZSb3RQK0VOWlY5OHpUTGpuYjh5YjQ1KzJMYlBkeVErRllXR213?=
 =?utf-8?B?Z2NmWjM1S0ViNUxxZmYxbDVYaFpVbU1Tc2lJWmNYUjEwU1E1WUxoV1VMQ05W?=
 =?utf-8?B?ZTRjU0xYb2NvUkZjdGlsdFQva0hud3NoaE9hbVgzYU5rRi9KWjZBNm9oWGg4?=
 =?utf-8?B?NUdDc0g1dnkveitsUHlJTkJyaXhJdTlmdTE4NjQ0ZEdLV2E5QUxqdWFuRG9o?=
 =?utf-8?B?cThKVnBqbDVJNXZxWk1oVHc1YVdFL2xIWGxWQ1hJeitZNGdqajdQOTZzMnBQ?=
 =?utf-8?B?UWgyQ3BWSTZhd2NTUHpLd25yRWY3T2kwenBmQjNxUzZGNnh4YzZ4SjF4ZUlU?=
 =?utf-8?B?ekdpTFI0OGV2RlhJSWtnblAyNmI0ZHcwNW13b3hpZHdNRDBSOU1wWFh3czQ3?=
 =?utf-8?B?Z0hnZ1cwL3E5NFUyS0x0SFZ1cFJLNEV1dDc5UDZLRlQ1UVY5YTRYdVVjZEJx?=
 =?utf-8?B?MWhwVldwdWxzMVRWL1dXRG9LeWhyd1B0TksvOTVGMWlRZFplWjhnRzlxVTZh?=
 =?utf-8?B?Vis0OGlOMjFzRjJDRXBHN05BOUpUOGhxZWsxMzE1d0lUUW1wWktWLzF4dXB4?=
 =?utf-8?B?L2dicks1cjl3VHViQ0JocEJRblY3S2ZvYTh3QlloQW5pYS9xVGgzT21vRURV?=
 =?utf-8?B?YUVDWTdhUkJQZFZxWmw4bk5mbkJDMFdBRTVvYmZ4TFRVUFFrUzZTMm9hNzMw?=
 =?utf-8?B?TC9OQkx6blJZd1JaOFRZdE5qbnQrQVUwb2o4NjdjazhrUW1WMjVyV2xnaEhB?=
 =?utf-8?B?M2xpR2R1SXNvK3MvM1QvWTh3VW9CODF3NmlFdE1TN2VEcVpSOEUvMlhGUHVu?=
 =?utf-8?Q?Sqt7VagViFO5IN+1bs=3D?=
X-Microsoft-Antispam-Message-Info: KNpEXKLzP8firHxqNvss026GCXhWwPN4NfqJCIDHNaa5FaAXTVBUc4ucjiewLOBgIq2N/Ulr5lbqnipeQyVw23x+0sDfmTzRk6uTxAmUb4eTmQRMzUZ1fjPtm+5a7YZtQQmBcw3UOaVI96WXnKqjYaU+/l1RF4raVOECVhci3G6UBfeSQ2RHC8zsIPHF+bs0GAiAYk9y4eqRX58eqxJGUAYj5Az+0h35uHPJZqOixh03UH8BSj7/aJ6XZviDB3BpRV1kQpnQgZMWSoJFcPpbiIa+DD1Qr0DJ4Asly8W9GqiajOoY7p8d84hpjJLY7O5daZ+8tO+/gCiQcun0+rXFpU6x6Ei8Brnrfj4x8bgjXwk=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR12MB2675;6:yPoE4w4nQ7wRT3l9Vd9te/aYHsS5bawESZHnpXUfQMusuzvSTyxk8XlkrAakM91DNvR9XAeg+ZpC9T/dw6ATpl3AcBk5dFrZek8IEV9jTL3o0LTzDCc8ed/YaEyQ9RSekd3ReJjg5vZB+ssmisiW7WTJRLRgvEfX3WXFjIz/nqj6uqBew438N/gkohCdYSFW6HMqAetdmyPKgvJcSPi692In2C1/Wqo+Wp5T2o7E49Bb2X1hp2BArohvPvjLQitHZeMySSepIgeLpI8UTy5DYyChPT+owecQ3xlTkBs869id+3ILwX4dZVEVGiGqqqrMdqVHrTPTOiVPp555lEq/Ro1X/ti4tveuV062CP9ZVSSuDnbrMZiExI7zjsj/hbzFL1kDDRA3njruvT2aImXpvHTpyhbd72kg/L5EwED6z3J/OSgYt2Y0ySODhxZhP/2bKTzblU2esdsNEqzFAKsdvQ==;5:u84kre55/lJ0Ksucp5x4eVML/BbB3J/LJ6VsmEaY/aRY7CDVd5sxqUwt52ocZkoScUVynWQaGpjQiver34dfcZsPfUCE/06VcZlUD45IpuKjYpbyZqlTfKDSxygQVh2SIla3qdj+lBYAOFHRzVj1dJB8yIPPnbtidH2dyQzodgk=;7:EJT7cLvxmG4XfxI2v6gAhfPjOLPrrrs5axgE0xeH1IhE3aHya/0YTnKHxUufq1uk1dVQhiFFWcIchHBrzKl2MNHIUapA6G5RufvfdBlDnTblTmDBAq+1rYIdJ4ROe6sErb4YZAAD4GB7dsjYyUCN/coxt9Xtvrih3L4QIq9Tr7WLYbar+Zu4kg1WoHTd1nKKtsiBlpshZhjA3VPGTVEz8zO2XpjXoqcHkitP6n9BOEr+WJz9DyNRIqgwXQFFSBbE
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN7PR12MB2675;20:BwqXIllJwjMhxzokwx9KPLSVsgGjsegYXv+tQTstQFQ6tcyKNstcmb02ws/CYJ2gdUtGPl3YepX8nd1aVeU9GUfTzX4GWdZxdf/jcsJ66cVP7iKcHVo+JlddwgboH94M7LEkqWs8BHwYUZmgRkQuGbti2CQ8qa1EdjOi4gY58f8f/4r96blSA8Xxc6WiVXlm40aduTjI1kk5d90LKCyqQ68+uUHYzegj4OmCJoiu+HJ/IWYziZ2E+eNCGhdZ9W3S
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2018 11:43:32.1988 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b89d0707-b008-45ca-02e1-08d613edf990
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2675
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kvmclock defines few static variables which are shared with the
hypervisor during the kvmclock initialization.

When SEV is active, memory is encrypted with a guest-specific key, and
if guest OS wants to share the memory region with hypervisor then it must
clear the C-bit before sharing it. Currently, we use
kernel_physical_mapping_init() to split large pages before clearing the
C-bit on shared pages. But it fails when called from the kvmclock
initialization (mainly because memblock allocator is not ready that early
during boot).

Add a __decrypted section attribute which can be used when defining
such shared variable. The so-defined variables will be placed in the
.data..decrypted section. This section is mapped with C=0 early
during boot, we also ensure that the initialized values are updated
to match with C=0 (i.e perform an in-place decryption). The
.data..decrypted section is PMD-aligned and sized so that we avoid
the need to split the large pages when mapping the section.

The sme_encrypt_kernel() was used to perform the in-place encryption
of the Linux kernel and initrd when SME is active. The routine has been
enhanced to decrypt the .data..decrypted section for both SME and SEV
cases.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: kvm@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: kvm@vger.kernel.org
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
---
 arch/x86/include/asm/mem_encrypt.h |  6 +++
 arch/x86/kernel/head64.c           | 11 +++++
 arch/x86/kernel/vmlinux.lds.S      | 17 +++++++
 arch/x86/mm/mem_encrypt_identity.c | 94 ++++++++++++++++++++++++++++++++------
 4 files changed, 113 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index c064383..802b2eb 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -52,6 +52,8 @@ void __init mem_encrypt_init(void);
 bool sme_active(void);
 bool sev_active(void);
 
+#define __decrypted __attribute__((__section__(".data..decrypted")))
+
 #else	/* !CONFIG_AMD_MEM_ENCRYPT */
 
 #define sme_me_mask	0ULL
@@ -77,6 +79,8 @@ early_set_memory_decrypted(unsigned long vaddr, unsigned long size) { return 0;
 static inline int __init
 early_set_memory_encrypted(unsigned long vaddr, unsigned long size) { return 0; }
 
+#define __decrypted
+
 #endif	/* CONFIG_AMD_MEM_ENCRYPT */
 
 /*
@@ -88,6 +92,8 @@ early_set_memory_encrypted(unsigned long vaddr, unsigned long size) { return 0;
 #define __sme_pa(x)		(__pa(x) | sme_me_mask)
 #define __sme_pa_nodebug(x)	(__pa_nodebug(x) | sme_me_mask)
 
+extern char __start_data_decrypted[], __end_data_decrypted[];
+
 #endif	/* __ASSEMBLY__ */
 
 #endif	/* __X86_MEM_ENCRYPT_H__ */
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 8047379..af39d68 100644
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
@@ -234,6 +235,16 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	/* Encrypt the kernel and related (if SME is active) */
 	sme_encrypt_kernel(bp);
 
+	/* Clear the memory encryption mask from the .data..decrypted section. */
+	if (mem_encrypt_active()) {
+		vaddr = (unsigned long)__start_data_decrypted;
+		vaddr_end = (unsigned long)__end_data_decrypted;
+		for (; vaddr < vaddr_end; vaddr += PMD_SIZE) {
+			i = pmd_index(vaddr);
+			pmd[i] -= sme_get_me_mask();
+		}
+	}
+
 	/*
 	 * Return the SME encryption mask (if SME is active) to be used as a
 	 * modifier for the initial pgdir entry programmed into CR3.
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 8bde0a4..78d3169 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -89,6 +89,21 @@ PHDRS {
 	note PT_NOTE FLAGS(0);          /* ___ */
 }
 
+/*
+ * This section contains data which will be mapped as decrypted. Memory
+ * encryption operates on a page basis. Make this section PMD-aligned
+ * to avoid spliting the pages while mapping the section early.
+ *
+ * Note: We use a separate section so that only this section gets
+ * decrypted to avoid exposing more than we wish.
+ */
+#define DATA_DECRYPTED						\
+	. = ALIGN(PMD_SIZE);					\
+	__start_data_decrypted = .;				\
+	*(.data..decrypted);					\
+	. = ALIGN(PMD_SIZE);					\
+	__end_data_decrypted = .;				\
+
 SECTIONS
 {
 #ifdef CONFIG_X86_32
@@ -171,6 +186,8 @@ SECTIONS
 		/* rarely changed data like cpu maps */
 		READ_MOSTLY_DATA(INTERNODE_CACHE_BYTES)
 
+		DATA_DECRYPTED
+
 		/* End of data section */
 		_edata = .;
 	} :data
diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index 7659e65..08e70ba 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -51,6 +51,8 @@
 				 (_PAGE_PAT | _PAGE_PWT))
 
 #define PMD_FLAGS_ENC		(PMD_FLAGS_LARGE | _PAGE_ENC)
+#define PMD_FLAGS_ENC_WP	((PMD_FLAGS_ENC & ~_PAGE_CACHE_MASK) | \
+				 (_PAGE_PAT | _PAGE_PWT))
 
 #define PTE_FLAGS		(__PAGE_KERNEL_EXEC & ~_PAGE_GLOBAL)
 
@@ -59,6 +61,8 @@
 				 (_PAGE_PAT | _PAGE_PWT))
 
 #define PTE_FLAGS_ENC		(PTE_FLAGS | _PAGE_ENC)
+#define PTE_FLAGS_ENC_WP	((PTE_FLAGS_ENC & ~_PAGE_CACHE_MASK) | \
+				 (_PAGE_PAT | _PAGE_PWT))
 
 struct sme_populate_pgd_data {
 	void    *pgtable_area;
@@ -231,6 +235,11 @@ static void __init sme_map_range_encrypted(struct sme_populate_pgd_data *ppd)
 	__sme_map_range(ppd, PMD_FLAGS_ENC, PTE_FLAGS_ENC);
 }
 
+static void __init sme_map_range_encrypted_wp(struct sme_populate_pgd_data *ppd)
+{
+	__sme_map_range(ppd, PMD_FLAGS_ENC_WP, PTE_FLAGS_ENC_WP);
+}
+
 static void __init sme_map_range_decrypted(struct sme_populate_pgd_data *ppd)
 {
 	__sme_map_range(ppd, PMD_FLAGS_DEC, PTE_FLAGS_DEC);
@@ -378,7 +387,10 @@ static void __init build_workarea_map(struct boot_params *bp,
 	ppd->paddr = workarea_start;
 	ppd->vaddr = workarea_start;
 	ppd->vaddr_end = workarea_end;
-	sme_map_range_decrypted(ppd);
+	if (sev_active())
+		sme_map_range_encrypted(ppd);
+	else
+		sme_map_range_decrypted(ppd);
 
 	/* Flush the TLB - no globals so cr3 is enough */
 	native_write_cr3(__native_read_cr3());
@@ -435,16 +447,27 @@ static void __init build_workarea_map(struct boot_params *bp,
 		sme_map_range_decrypted_wp(ppd);
 	}
 
-	/* Add decrypted workarea mappings to both kernel mappings */
+	/*
+	 * When SEV is active, kernel is already encrypted hence mapping
+	 * the initial workarea_start as encrypted. When SME is active,
+	 * the kernel is not encrypted hence add decrypted workarea
+	 * mappings to both kernel mappings.
+	 */
 	ppd->paddr = workarea_start;
 	ppd->vaddr = workarea_start;
 	ppd->vaddr_end = workarea_end;
-	sme_map_range_decrypted(ppd);
+	if (sev_active())
+		sme_map_range_encrypted(ppd);
+	else
+		sme_map_range_decrypted(ppd);
 
 	ppd->paddr = workarea_start;
 	ppd->vaddr = workarea_start + decrypted_base;
 	ppd->vaddr_end = workarea_end + decrypted_base;
-	sme_map_range_decrypted(ppd);
+	if (sev_active())
+		sme_map_range_encrypted(ppd);
+	else
+		sme_map_range_decrypted(ppd);
 
 	wa->kernel_start = kernel_start;
 	wa->kernel_end = kernel_end;
@@ -487,28 +510,69 @@ static void __init teardown_workarea_map(struct sme_workarea_data *wa,
 	native_write_cr3(__native_read_cr3());
 }
 
+static void __init decrypt_shared_data(struct sme_workarea_data *wa,
+				       struct sme_populate_pgd_data *ppd)
+{
+	unsigned long decrypted_start, decrypted_end, decrypted_len;
+
+	/* Physical addresses of decrypted data section */
+	decrypted_start = __pa_symbol(__start_data_decrypted);
+	decrypted_end = ALIGN(__pa_symbol(__end_data_decrypted), PMD_PAGE_SIZE);
+	decrypted_len = decrypted_end - decrypted_start;
+
+	if (!decrypted_len)
+		return;
+
+	/* Add decrypted mapping for the section (identity) */
+	ppd->paddr = decrypted_start;
+	ppd->vaddr = decrypted_start;
+	ppd->vaddr_end = decrypted_end;
+	sme_map_range_decrypted(ppd);
+
+	/* Add encrypted-wp mapping for the section (non-identity) */
+	ppd->paddr = decrypted_start;
+	ppd->vaddr = decrypted_start + wa->decrypted_base;
+	ppd->vaddr_end = decrypted_end + wa->decrypted_base;
+	sme_map_range_encrypted_wp(ppd);
+
+	/* Perform in-place decryption */
+	sme_encrypt_execute(decrypted_start,
+			    decrypted_start + wa->decrypted_base,
+			    decrypted_len, wa->workarea_start,
+			    (unsigned long)ppd->pgd);
+
+	ppd->vaddr = decrypted_start + wa->decrypted_base;
+	ppd->vaddr_end = decrypted_end + wa->decrypted_base;
+	sme_clear_pgd(ppd);
+}
+
 void __init sme_encrypt_kernel(struct boot_params *bp)
 {
 	struct sme_populate_pgd_data ppd;
 	struct sme_workarea_data wa;
 
-	if (!sme_active())
+	if (!mem_encrypt_active())
 		return;
 
 	build_workarea_map(bp, &wa, &ppd);
 
-	/* When SEV is active, encrypt kernel and initrd */
-	sme_encrypt_execute(wa.kernel_start,
-			    wa.kernel_start + wa.decrypted_base,
-			    wa.kernel_len, wa.workarea_start,
-			    (unsigned long)ppd.pgd);
-
-	if (wa.initrd_len)
-		sme_encrypt_execute(wa.initrd_start,
-				    wa.initrd_start + wa.decrypted_base,
-				    wa.initrd_len, wa.workarea_start,
+	/* When SME is active, encrypt kernel and initrd */
+	if (sme_active()) {
+		sme_encrypt_execute(wa.kernel_start,
+				    wa.kernel_start + wa.decrypted_base,
+				    wa.kernel_len, wa.workarea_start,
 				    (unsigned long)ppd.pgd);
 
+		if (wa.initrd_len)
+			sme_encrypt_execute(wa.initrd_start,
+					    wa.initrd_start + wa.decrypted_base,
+					    wa.initrd_len, wa.workarea_start,
+					    (unsigned long)ppd.pgd);
+	}
+
+	/* Decrypt the contents of .data..decrypted section */
+	decrypt_shared_data(&wa, &ppd);
+
 	teardown_workarea_map(&wa, &ppd);
 }
 
-- 
2.7.4

