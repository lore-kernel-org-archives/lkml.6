Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7CF8C4321E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 01:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7038020658
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 01:30:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gsMAMDno"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7038020658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbeIDFxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 01:53:25 -0400
Received: from mail-bl2nam02on0082.outbound.protection.outlook.com ([104.47.38.82]:42369
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725837AbeIDFxZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 01:53:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6tObxVukwyqWeihVatFhIVvDkEbDhPcuBsbQp6yoncs=;
 b=gsMAMDnoOTXUa22HtmP9RaqlzsStK/1xpESQXHE+mV7BACwqppy91w7w/fX2Ne9cN2BL2XNG3JefaUyshwnoMtaqhtpqPw8I3FrjJ064UeXpfdI2W7UKwjnKNUGgQOQfaQYQNEObeCANjM8SVw+jfs6HN6uNC8Wtgth4ap3KeoA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by
 SN6PR12MB2687.namprd12.prod.outlook.com (2603:10b6:805:6f::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.18; Tue, 4 Sep 2018 01:30:03 +0000
From:   Brijesh Singh <brijesh.singh@amd.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH v4 4/4] x86/kvm: use __decrypted attribute in shared variables
Date:   Mon,  3 Sep 2018 20:29:42 -0500
Message-Id: <1536024582-25700-5-git-send-email-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536024582-25700-1-git-send-email-brijesh.singh@amd.com>
References: <1536024582-25700-1-git-send-email-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: BN6PR20CA0066.namprd20.prod.outlook.com
 (2603:10b6:404:151::28) To SN6PR12MB2687.namprd12.prod.outlook.com
 (2603:10b6:805:6f::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57f75fe8-c8a0-4a95-f7a5-08d61205f12f
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR12MB2687;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR12MB2687;3:5fM6m96X8o8lYB3XQgeIW6SVVRUTzfSGTiJxDAKXjPv1NIwsX+wPxA4uk4sOb4I9x/yxfNWmSQOWGArc4wvghutLa9nnA4dCK9i+X31xqTJkw/wSwsiBTZGMGiHkFReD0WYqRz7WIu1KUBdRaKx7C/orqfWQ3ZA4CVQjealw1isqiVU+YshZ2fZV0m/fHHaDe5MyBmg3RbP4vR+8BZ9GVAd0lnOHh5C7vyU3BikAvkMVYRj6ZfBcdBOSuXqWgcUd;25:iGqbZIY5wljqHETjuhtumXICAoXdXNTGzIkkV1oZWIK3vUZsz7TpjrHFcT21TO0Yasqb20RTPH4ei58WZTWVOTvLAWH6MB0R0ZeUVf929eY2FoDhCowbrUQgxGBlnlam6VOmnKnUSte29vjZ8n11pLvUAk2WEAWXiOQ9Xod38VO19C73/cI5sl/9SAoaLLARnmQVmyRIx6MlWdJ+QtaZRX5zUYB8SXz+w+6Dt0Zjqcp2fr2mF2MAfBilojFg785UllSInuax4VAaOsoR0BcfEWzksj9K8lKjawf0LdIAzv8VLNV78C+kVmEr2pnpH13IdNcMC+zQ8uGpLBa+sI2XAw==;31:xgpPtl2eTGhGd05MNcKOtrtip2+2D8WHjLOcypu63ko7D9v3FWyOt6qIr/sVQa3byk5fkNI84lHiW0eSY1uuYFG5HZgjuZFWObJ1yVrj/st+TywUV79K6V8GXdA3rj9eX22JP5Sy9+4qnYTwnnWbhz5yJ7EMZKV4r8+rrf4Al3MtdkC1ch6qxoJXYrTjT77jRiLWjjLVfKCVYFfSIv4rBz4jIdywAQ2DjCFSHFCPOLw=
X-MS-TrafficTypeDiagnostic: SN6PR12MB2687:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR12MB2687;20:z8JlcFiIBC0adFU6b0BQPEVHQBGozBQsFn0QXOHP44mzOEhS0sLakbso1fZDHz7c6w0VaHBW/CcPaj+lbkNBLFTul+ofgKnx/1ueC6Z59WtnqipZt3LjVZPuJwx8oREW3NilL1TJ04P1ImiM9FaFQiQkdoX8YhEmkkLJwDQO0xkXVw4rsv9HqFPhZQq/CzX7TDhkSfWcIuAhgfrHisTEQ6c8MYftobMdAaqfXcR5KB6TK9f0YUkM9RNP5jNzz721yDkfGJiwR3pW37/5mo9tNf1I7LkgR7E+HYmLc+3NiU39IKOt8MyJ0eXPf1YXWo9Twll1mZplv362vPlJeH6oC6P55U52S6C5aS4hPZk6P5vr3FLNuGOXYemmWfXvxb1zvA8DHkVgyaAN8rX5uNuxC6DmGUPwdQDOqhcOwOJrDXDXkvbWkT7p7rGE8ylHMPOamAKHsvBbQgJKVAxSzgTyS7p9U3vMgeGs1fFKU/4sVuqQWX9pNkNlSlLWeYmm/g9T;4:Om5dtLG7qJAaWqEeWejCEGcAYERzFUfpBBfmckPHC74H6p6u0Pk2blszm9mDnwcBozjR8bFS4QILmYiAo7DJGgi9mkpDOXIkgZL7FwojfcY5azdvtW6zqjbWNYiEw8pu7Oh9meLIbije725BPbTJVwXjn9jRj9pcTnrZawvgZ8Iz4RUd55OaR4iYh5Nvfb0JWziEZs4kzCfVxwHU3NK8QbOznatWXQaksYEG89H77r0diPg7kJ4giNHLNRZrp07wrf8I2lbzbDK8PyBsdkfp/iaelJGJ0A89qd4nXu5HrLPk+DgARUABwZ7OF371Nj8Xqq2otHzYgvvsOH6rNaq7P4xcTwiCAbStPWellTs1DzJzGSkpLf5eYKmQ98IPtU11
X-Microsoft-Antispam-PRVS: <SN6PR12MB2687AF6F9455FD2DCBC783CDE5030@SN6PR12MB2687.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(767451399110)(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699016);SRVR:SN6PR12MB2687;BCL:0;PCL:0;RULEID:;SRVR:SN6PR12MB2687;
X-Forefront-PRVS: 0785459C39
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39860400002)(136003)(376002)(346002)(199004)(189003)(14444005)(6116002)(105586002)(76176011)(7696005)(47776003)(23676004)(66066001)(68736007)(52116002)(2870700001)(53936002)(53416004)(2906002)(316002)(36756003)(3846002)(97736004)(6486002)(50226002)(4326008)(25786009)(54906003)(106356001)(81166006)(81156014)(8936002)(478600001)(2616005)(6666003)(50466002)(86362001)(8676002)(44832011)(5660300001)(186003)(7736002)(305945005)(16526019)(386003)(486006)(476003)(26005)(446003)(11346002)(956004);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2687;H:sbrijesh-desktop.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjZQUjEyTUIyNjg3OzIzOm9XMXlYQmNmaUUwWG4yRHNpM1R6ZDdXSmR5?=
 =?utf-8?B?WE00T05oeitsL2ZRb3pJMHhOWFYvelpUYkFVSnBQc1huaEhETjBlWE9VK3B1?=
 =?utf-8?B?bEN3bTZCRXVtelJudTBaYXpTU2NPT09yS1AzOWFlcHpZQ2Vyd0RxSkljdndQ?=
 =?utf-8?B?QjhTb0lFbFZ5cnpwdzdMTXFaSlQvdEhJZVVEMURPSGRXeWNSZzBjT0IwRUFH?=
 =?utf-8?B?ZUxFQTNYY2huUDlZQjhHYUhWUVZtVUVSdGgyaEpnYnp2bXV1RCtha0VoSlNo?=
 =?utf-8?B?MFJuZVI1clIrNXdZcU9kZWZrT1Z1MytVWEdMaHlzZU9nQnRSb2NQRTVWWE9B?=
 =?utf-8?B?Wm50ME5ZekdkVitDTXMrU09DWlJhWjlwMGhQZ2FycTlIUk9mSXh2VDdLRHR6?=
 =?utf-8?B?a3QwSERzdlVxUFIyamVCN3JMNVhWclhpTGNLZDJmK0FwU0ZES2hJMWJhSUpI?=
 =?utf-8?B?Vk1pUHY4M0tlcHVpZEdWdkdmYXhtWlpCM1FxK29DbmZENm1WTTFwY2lST3JF?=
 =?utf-8?B?Njh3M1IyUnM0cTVEZ0ZKVUhpeTJHMzRvL2xFaS84ZXZFSFF5YzRudGM0cHFW?=
 =?utf-8?B?MmEyS08vMjNFbyttcmZnc1NOZk1MZ2djMTczTlg5bkRteTdRNGE5eXNIZURx?=
 =?utf-8?B?aDJiVENUN1VrcnE2cGVEcTZzRGFUMnpwRmJuNEN3YllmTU1zREpCZDBSOHUr?=
 =?utf-8?B?WXJzMmdBcTNhdm5ETzhMYVpwbkg1MmpkY3RsS1lnRGNGOUE5TkZQZCtuRHJB?=
 =?utf-8?B?NHEyV212cWQxQzdUcWd0ZWF3TS94WUppK2JpMkwzSXJSTEE1WEMvK25TYUc1?=
 =?utf-8?B?a0RoR01oblh3Y25SLzBydmdtK1NkREtJSHMzMGJtQ1F6c1JuVHAzNzRONElj?=
 =?utf-8?B?TlFtWkhIcXdmU0dqd3puTEN6TGNvdXdSZVNxcmlYYURtWUZlZG5YWlRXSGFS?=
 =?utf-8?B?ZWNTMnkzMFhhTlZaelowVWhxd29KYVhBSzErSXBic0R2VzJ0MlBNdW4zWFA2?=
 =?utf-8?B?azZkRVBrNjZ2STBhN25oVFNYZ202VXRhMjVjU0lpNVRlc2lDcURHZHBiYitv?=
 =?utf-8?B?eVhCZExkN1VTbjJUdHZNU1ZuejUwQ1M5QVFxaVdPVVBNMmRXalZxM3hYTFp1?=
 =?utf-8?B?b1krQWxZOHo3U0RzaGJxK2pUdWYzVkF3Rko4ZUdTQVZ5Y0FuRVhxUFFkNmtU?=
 =?utf-8?B?d1ZWTWJ4aWpqZWxBWVF2bEJVbERoSnZTTFdONDl3S1VVY3hkVGh3eUdDUGVl?=
 =?utf-8?B?UnFVR1RxejlxZTlGWnd5QW9ySWlkTFJ4YjB4MW9oNGNaR1dXM2lyZlhiUXV6?=
 =?utf-8?B?N2plbU5UblMwMkIzbVVqZjZxTUNLbUFQOGpubWpLdGJ2REdsdTN1L3dPSk9k?=
 =?utf-8?B?R1BDWFBvZHdUQUlDNWZ4UHFxTFdNK2h3SU5mand2Z1JmTXNIVitDanJ1ckhW?=
 =?utf-8?B?Z282SnljeDd1SVF5d0tNeE94UTh1VU5ucnVvcjN1eTZRWWMzaXdFYnRoRE9W?=
 =?utf-8?B?TGZ2cVFGUVNBVXZtbFF2eEtkN1ZWUmxWVVRTU0pOdEtDbytTWENLVitOL0g0?=
 =?utf-8?B?MXlvYXplaEJJSklsY2JlT3B5RVNIMERrTTl4Q2tET2NGbitzUXJDTjBYeTJ6?=
 =?utf-8?Q?mrOiaOo4KbrT/oQbyZVf?=
X-Microsoft-Antispam-Message-Info: 4XxUlP6/MyWIvNWa9LDxTFpUkKd9x0UT0mI+G5mpWGJVn4irVl2LJH5cUR8e4EYDV75cmqDNJ3yTC8ISCuGq/sqS/NrKD85LIn+B1HDpETY/zqABbbA9l+cec4K6W9puaYCkfpntF54I1oMSyPmW6UBFqXTnz52PBloKqlEd8cLECKG8MERDrnbdYV92qjBIIQT+vzIAil0CKheU+udi4tOWE5OwEyRB6pvlaIsDMAnqI/z0hZNUhxRnvaBTCrq414ZHBdPAGiGdxk8p+BwWC7KM1rLoOmBFlPezOMkWcnFswPANXqCqAocfe+BufRImB9yY4TQjzQrr3Sb6+AIX/51LTwmJ4zzcdI9HLWZlqSc=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR12MB2687;6:oW38tdx5MQBwrC5pBHYn79/DqDhkzDfcAYmT0SqkvKznV7cgnHNNP5YKjjerQFHU6PB7UtYei5eIJgBWpSM2QI685v/9hikb6Gmbpd1g/eQO9P9/r5UNP9nXJvp9qTUr7Z6AI5wRSY6pNsB39GAJdb0NY3EW978MFL05qReiXwjGeL6X9EyEXBnmuEhnZuAdBgB5qKu9x5DtMt18NP6ht04+pqK95DLhpcaPCbko7RNfZ9ti/coTMEuEL2bGKl95/lzrBiCVpcVqqJYmGLwwcImaw7Y4wZDUxgwP95gSJ4ohFJpJX9KMvp4UYk3bT54y0yNhWg3Bj5RXGprZUiby94eD7RIIPVf4a2/dmgO59m6oRoMKFJsYgs4oy+wepa5YB0YGZzPTsqZNgEs47V9e9FBx7uitigvW4OGH4FPJxITOkvuljRK002SSoGn/WOymyWApSzjh07n7yHlc3tC89w==;5:iujXbbr+Km3KO9ac6k/CBLQ4PNCJyFxQB0jTEv8UaxDhZhTuOhMoRtjpwfmytsPz0mLfFzgQQMdqWKtpCqxleYSUg99FZIvKs4mE5EZ7FRzt6iePk+RF0sfuYOCevO34+0dFMiKQ4ia7tShiyPX88FyRw535KhuAq7WN8fv3gT4=;7:39aJcW+slZR41eUGCsJ2ruCIp7cMToqDN3CQ/sbEScvelZ8ayMhKh+uPtcnTcK96CiiVqJb7wV+BrF9N/GPqUqg11jUcpSX+VxUF5HuBlohxKDMUs96h0zACIspor3ojg3g0I2j9SO1iXj1qZ4T/41V8wR4k0bqzAVOMJsDWZ3iKAzGrcrvCl2W/duOiYl08fwDqY58KqHrGsYd5VyEVLqF8M8y7qV/x33mDQoOCEkDeg9CSoE7prLc/BDsTP+17
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR12MB2687;20:fjyHXe2W6jDd9SuJiv47tAxOqosQYx7pmJ4bU3iEaa08tjly/rXGECpxujr78+9y9BT9WuBTC+x23D0FmvjVZkQ+E4lntJ0YW1s9OMYv0B/sME52UDeGtd5Qii0qxKZz8K+LRLBTjRjIMbHOmClnfBKf5VXHVHuWb/EpRIAiE0DfAu39zna9bEDGX9uG3rsSV2OXJk511ZT6SjO2hJuJaTQ1K8Vf+vJlcLOZ8zAAaiPi8PQZoEWw1tmTXEWt9Vy2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2018 01:30:03.9936 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57f75fe8-c8a0-4a95-f7a5-08d61205f12f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2687
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit: 368a540e0232 (x86/kvmclock: Remove memblock dependency)
caused SEV guest regression. When SEV is active, we map the shared
variables (wall_clock and hv_clock_boot) with C=0 to ensure that both
the guest and the hypervisor are able to access the data. To map the
variables we use kernel_physical_mapping_init() to split the large pages,
but splitting large pages requires allocating a new PMD, which fails now
that kvmclock initialization is called early during boot.

Recently we added a special .data..decrypted section to hold the shared
variables. This section is mapped with C=0 early during boot. Use
__decrypted attribute to put the wall_clock and hv_clock_boot in
.data..decrypted section so that they are mapped with C=0.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Fixes: 368a540e0232 ("x86/kvmclock: Remove memblock dependency")
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
 arch/x86/kernel/kvmclock.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 1e67646..08f5f8a 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -28,6 +28,7 @@
 #include <linux/sched/clock.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
+#include <linux/set_memory.h>
 
 #include <asm/hypervisor.h>
 #include <asm/mem_encrypt.h>
@@ -61,8 +62,8 @@ early_param("no-kvmclock-vsyscall", parse_no_kvmclock_vsyscall);
 	(PAGE_SIZE / sizeof(struct pvclock_vsyscall_time_info))
 
 static struct pvclock_vsyscall_time_info
-			hv_clock_boot[HVC_BOOT_ARRAY_SIZE] __aligned(PAGE_SIZE);
-static struct pvclock_wall_clock wall_clock;
+			hv_clock_boot[HVC_BOOT_ARRAY_SIZE] __decrypted __aligned(PAGE_SIZE);
+static struct pvclock_wall_clock wall_clock __decrypted;
 static DEFINE_PER_CPU(struct pvclock_vsyscall_time_info *, hv_clock_per_cpu);
 
 static inline struct pvclock_vcpu_time_info *this_cpu_pvti(void)
@@ -267,10 +268,29 @@ static int kvmclock_setup_percpu(unsigned int cpu)
 		return 0;
 
 	/* Use the static page for the first CPUs, allocate otherwise */
-	if (cpu < HVC_BOOT_ARRAY_SIZE)
+	if (cpu < HVC_BOOT_ARRAY_SIZE) {
 		p = &hv_clock_boot[cpu];
-	else
-		p = kzalloc(sizeof(*p), GFP_KERNEL);
+	} else {
+		int rc;
+		unsigned int sz = sizeof(*p);
+
+		if (sev_active())
+			sz = PAGE_ALIGN(sz);
+
+		p = kzalloc(sz, GFP_KERNEL);
+
+		/*
+		 * The physical address of per-cpu variable will be shared with
+		 * the hypervisor. Let's clear the C-bit before we assign the
+		 * memory to per_cpu variable.
+		 */
+		if (p && sev_active()) {
+			rc = set_memory_decrypted((unsigned long)p, sz >> PAGE_SHIFT);
+			if (rc)
+				return rc;
+			memset(p, 0, sz);
+		}
+	}
 
 	per_cpu(hv_clock_per_cpu, cpu) = p;
 	return p ? 0 : -ENOMEM;
-- 
2.7.4

