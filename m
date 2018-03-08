Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751114AbeCHXRk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 18:17:40 -0500
Received: from mail-sn1nam02on0070.outbound.protection.outlook.com ([104.47.36.70]:50264
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750857AbeCHXRh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 18:17:37 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com;
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH] KVM: x86: Fix device passthrough when SME is active
To: x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Brijesh Singh <brijesh.singh@amd.com>,
        Radim =?utf-8?b?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Joerg Roedel <joro@8bytes.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Date: Thu, 08 Mar 2018 17:17:31 -0600
Message-ID: <20180308231731.27881.84826.stgit@tlendack-t1.amdoffice.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: CY4PR04CA0029.namprd04.prod.outlook.com
 (2603:10b6:903:c6::15) To CY4PR12MB1141.namprd12.prod.outlook.com
 (2603:10b6:903:36::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 88fe127f-384e-4e88-dfc2-08d5854ac6f7
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(2017052603328)(7153060)(7193020);SRVR:CY4PR12MB1141;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1141;3:ZrOmYdluPTbh/PNpHBYbBgaFd7WbZj4ef3r5tDYRnfIRkIAanSshmT1epA0hPEM2glC2RcBR8tdR1KazbVS1Tw3P2oNeZbDcwm1yDrn6cA8RL+/xkmN3OWvgxGRYIUTbueUvnblpce1K2XuY5DiD3T67UfAa1pZvvgUejB2sVVaFj4ItLkCQWSLE4s9oDt4jQwceofSoyrofcj8gC6ByBzQ9zIFmq90NWlCWi7Er017uo9WlkivZ+eCnoD/BWIdc;25:rbc0jOvR0WXPKdUODz/qwCdiXFWl4NM7OiNXeYFG5GxcSweGg0I8Yygu6TRxOx4UfnR6IbsIO4ZVXcQa1SEuxwMKeCUmfXrvmSuwz/vq/NIO2muGbLhSAAXI29TZoqKkwKfDSrZQg90tiDd9U7ExBD7uTCRGiH+1FI6n0E3VC1eLXH7a4BGiZFXAcw5Ij1W4dV8AurctPL9Uh7vPeqg5dl7cqSMY8udmXYxlKy26TdOVVuq7vh4OEXFrXtj9cV1TsxQzS62QT2+OaWuo+6mzrLRQ10rMSbzkt6+FwKBTBmniDlhXAX0RXD69hMtUqas0mz65LBo+ieAS9aAJOXLcXQ==;31:kd5fdJDJM7dR7w4bIJhkTlsExi+F7fTC7jEs9zEWXmIgWKWi1VHfUsty9j2Av2jWhIEXOC77SUJoZZnI5XBKXeVAiP+coWletXzjSfZBNqjDnV2GGsZQMuULEoth7QXqfO+FDdXS7TCD3guzIGEyf8bnT9EF/gSjICu3AN6mXKe1aOHrFnCvOarO43RbMxRAgocDVAdQ3pB9AZhfTyd9/1yCsxR1o/j7obHo080D6pU=
X-MS-TrafficTypeDiagnostic: CY4PR12MB1141:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1141;20:bXwkvvE6UEzrlVxntrg0M1L/JooIuuTSrxNCNnyONdHXrp+/GB9WUxz0VwClNFJrYVYKI1Tc1i1wJFe4EmtWED0cvBB6jBVX0sUJW9WBq1TQi7YmeLtSOVsOGT4E7VnqSACvPLaXYmLNfLu7JOlZxJiEltCY/PD3T98XV5hGFWMSe/OfafalXbVzK5xNcG8+cypdN191wtCL2O1FHYIUQUmis5ygjGo1sJbsCrxufa7fWZg/ef0mf7Y0mkm4/mGfDLEtNW67Cc7HsvC1kBQdKY8Mli1ZcDT318pZwLAaATfSqvozZ13YUJDfLKInsx5EDDiRs9LO+AX7ialCSfCXm/2L98E4XiRzxhoeKUJG3uRANr6A+QYTSqao8ni2UjuK4qoJ7ZQtUoc5PTRh4GZ2xlG6QSIaTnNP0YNF0vv+8hebnS0MpW8asq8K2muVGt7UDCYrHpMFXB3+uIF+Z7VzF6jBBLeYb+va0mqLH9WOq98uX9c2+/uPxTwVN0hD2Xm6;4:NOgOax1MlJv7ny9EA4HpMDredhdsDb06n8vfK7amIcc3HBxhv13qTscAc3usjzX2GcOrbaPLyFhm1Ab2n7cCuRspUH6JbDZVK3NxrrmAun7XvchAf3IgW2KiDEVz6n2nIhjOMZGOh7aatj8vKMGEZm47w57qkG9bFY1dHI133TA6YZr0h/fHUjZiiM/+vKMzE/+DlqJNsvUa2jczHod663EsbwZJx0Zyyh9Qwl9nUey36Ur7ig0AB5iUiJfL+vKq81YXNnNTyJ1/9lR7LK2PO2XT5Z8dwwxXDTcz9zADHqmjF1izwEQlNtiQCtIpXO4PE5kKrarq2yHDXO6Yz0LYLQ==
X-Microsoft-Antispam-PRVS: <CY4PR12MB11414D81157601731F4ADA98ECDF0@CY4PR12MB1141.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(3002001)(6055026)(6041288)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:CY4PR12MB1141;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1141;
X-Forefront-PRVS: 060503E79B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(979002)(396003)(366004)(376002)(39840400004)(39380400002)(346002)(199004)(189003)(4326008)(1857600001)(316002)(86362001)(26005)(50466002)(105586002)(5660300001)(53936002)(55016002)(97746001)(54906003)(58126008)(7416002)(66066001)(6506007)(47776003)(9686003)(16526019)(59450400001)(6666003)(305945005)(7736002)(386003)(53416004)(8936002)(8676002)(81156014)(81166006)(1076002)(72206003)(97736004)(478600001)(6116002)(25786009)(3846002)(69596002)(68736007)(103116003)(52116002)(7696005)(2906002)(106356001)(230700001)(23676004)(2486003)(71626007)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1141;H:tlendack-t1.amdoffice.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjEyTUIxMTQxOzIzOjZ4STZEL3RDeUowd2Z0bFRVdDZMeCtFWjd3?=
 =?utf-8?B?N2YzSkZRcVk1anRqcHBGczd5VDVnb3c5dGJaSWVCN1JZMVU0UXIwQkYvWmdn?=
 =?utf-8?B?SXE3NUh0djRobWY0UkZhUUgvRGhGQkpjSjArbWtTUFFNYnNaSlJLRDNxemlr?=
 =?utf-8?B?UnFEbTlsUUl5K0R5cGEyQXRBZDA2bWszdEUvYk5HVUovZGJwNm40bEtDMXkv?=
 =?utf-8?B?RlNmSzc2aDlra2MxVTZRZzd3UGdtbjJ6bjQzZkhCcmdlVTdkTlB6YkVCcmtU?=
 =?utf-8?B?MXd3R0VleDdEUk1pKzRSVGtHcnBKbFRjdnNUWUhQS3dVaU9UWkF4TThDZm9K?=
 =?utf-8?B?bGpZaUVYS3dxUHc4NUt3eTdRZFhuWjRXUnEzUE5uTWdHVjJYSDFSN0s3WHBG?=
 =?utf-8?B?WHZMckFoaWNLQ0VhbzZUS2xHbU5GV2U5cGM4QWdyN3U3K09MSmF4RkIrMy82?=
 =?utf-8?B?aklYSEUwcW95RTg2OEUzeVVYTjRVbllWOW5OQlZxQ1pGZHcvVDgvRWI0SkF2?=
 =?utf-8?B?RnpUV2NHK2xCbTRLU05SejJvU0dWZzhYWkJWbUJxMUdzL3liOEM5dkF0NVRp?=
 =?utf-8?B?MUxFYzlqbHRKVE0rZVVYajR5SVkrc0o5Ukc5NzRNU1hGZHE3VWE5SE9RRFBK?=
 =?utf-8?B?WHlZa0luVUdObXR5cXQ0TTZ4djIwNDBsTWF6WE9VM0tBK1pCOUxJK1hYMEZZ?=
 =?utf-8?B?cUpnTzJlWUFUMHNKbGQ5a0RMZnp6b3FWUXlKU011UE1NcnZzdFQzdDhTQjdZ?=
 =?utf-8?B?OWtXajNwRlRnejBvWWoxVmFKb2swOVpJTEZ3RVhKR3NlV3A0OXZpbGl5R29L?=
 =?utf-8?B?cW5YQ25KaHdNTW1RZGxWNkJmdDA5RVdFU3UxWWhBcGczWHpUZUxNblA4T25B?=
 =?utf-8?B?MnREWUNvUFByUStqeFBLak5TOGx5RldVWVZNV204ajFUMlZqenU4aEJ1RDdB?=
 =?utf-8?B?UUYxRDRRUFpDcDNkME5meWtjMzdNZzM4WGxWeHlhR2NzWC90MXZxRENLa3p1?=
 =?utf-8?B?N0lMSm9GVEhjRWNOMmdFaVFHemxyZDhXbElxbFVEa2FBZHo3cUpWeG5PQ0dY?=
 =?utf-8?B?SSswUFNRcXhFajcvWHBTZkFOVG5DOEJiZS9zM0o3bDg3SmNMRlJhdjRwL2Iw?=
 =?utf-8?B?QU45d3RVUFExbjBsd3AxTkRzVEg3ZDBzdExqVlJlU1FnRmNET2hSbnlWVENh?=
 =?utf-8?B?YkxnNU9oNTZqaE9kUURsWnpwamZZdWdzcnNJK2ZBTmh0VlFNcWxuNFc2eWVM?=
 =?utf-8?B?QWZpNkEwYnlydjlzOEczclFIUEpraDNaZkdLSnNpQ2t5RnRGSVJUTEdDbmdN?=
 =?utf-8?B?K08xRWVEa1hmT1RuQXNERW9zOTNHRWgrSGpBa3ViNFg3Mm9oYngrK09iL3c1?=
 =?utf-8?B?cFV3UTJrTjBNaW0xTmJNZWRZN0NTNzRQWFBZMUY4ZXloazVTQXcxTUZEV0V5?=
 =?utf-8?B?TjdZY2dNVG1LNDZqSDFWaTVWb2tBaUZSNXpWREw4aWo0U044SGNOZkJUVkQy?=
 =?utf-8?B?UktLZlBmT3ZQdWg0V1JxZEFyR1NJWHNSUERwdUU2WEMxbXBNZzhkVmVVS2Rl?=
 =?utf-8?B?R1h2SGEwbmdOeFZRbkNRK1lvQ0RLRGd3VVowRitCckcvalpteG0wakxDRkNW?=
 =?utf-8?B?Vkl2K2hjQ0JQR04ya0VQTlJqMnVZNHEzRHBzSmplMjNkMktYL2lTZEEvMDJV?=
 =?utf-8?B?ejYzUTVocU5NTTAvODBpWUpsMHFObnQ4UGlnQVlUTEJOWFg2eTdHd2MybXdk?=
 =?utf-8?B?ZFJHcWIvQUtuTEJBK1R1cDBnbG43SXUxVjRvWFBxaU5TN0dtSnkzSlg2aEZH?=
 =?utf-8?B?ZGZIWVhzM3pUQkRtdEp5c3FQaTQ4cGhITUoxOEJKRU9uR1E9PQ==?=
X-Microsoft-Antispam-Message-Info: Bo+/u72kxT4is26i3r3WIIeKLX6wQT20W6bYJABRMmkpXIfRLwXbRZPKuLfIaChepCs/1TgE8Dm6569zVRJuRQL1Y/9aXg4MotAwLvIu3nlZKixYTZKlmqV+co/bVrhR02mlsa9Av77Yl+wnNI9lRZ5lTvZE/cnw28mFJx2nt/KcfpKJoPR6oUJf/3OW+VW+
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1141;6:+ztL4gDgDGqG3/EsUlI8mEBRcRXo99y+G7qIdf6+gGh6xPOEww2duURiHiR5FnwkI3yT4N5D9+WoQmzuQbL+/vkGIaSPUDJtwYAa2cS5vdPooQehj/wPC6wJBfxdKOPLNT7pdRJZ1lx2APJHOEZLHH/mg63l9JSEh6+dZ1X6cr2G6slLi8/kQ/vqbOQ5yYZuJaEhQC5zA2TbBbi/iterWXlJjk2Jxq7i82Ce4REcxCt5obEJj50IAnEK/aeYRTo5LvLeBq3rmfFnsXceW3KXmvTizvoX10sSCtfPhHraxwN9yLMdozugap2DJIi7OshNQodz+hiz2LIr3bxK+UC/O8T5kO6waHCCgYR9nj90/oE=;5:qI6Mxj70574GtRGVomORM1w9L9nVHqNOBbQDQAl7IDHIPvsS5FHaMYpEHO4vdO6ySe3FtDSbHWs75Rwqktwacogrg971yqM5VYAT2ggehmu/YsmJqhV9ycxXAi7CGOprbLFKwmawxsieENZlH91vzD2e0YXtpGkzHm3em3IWOX8=;24:F6hTJoKq5iUSbO/n4cEBcO2mM3VlmnYz+++HtJMApep1r9lbbhPnAPeDZd8E3QQQ9Qj0j64z+cFxW3WukLiWJQejga6tgYLWFR7TMbpF7vg=;7:yKo/CDgal8uy1RfF4ateK1ZzRAdQwBewltX6Nr0xYgFhfD91ZX7/8KD9hN6sEDzscLEPnSqis6a9gFPyY40sPrm5XsQu4BuXd+oBY+XY7iyW+RZm5F9gqoLhSD/46qN35RIPgqShUhIfoZVdXhMT1Sewk6Tk089QHY0VvCO61DBwAE7X/6+UIH2g/4yI7Bls01i5FwzbFaFlUMZuforateFNawSYBkU7nAmqhLuxgLVhMfBUpSjmIsVWs1hmqul8
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1141;20:tBKBfy1AN9F3CNpO5hD0FdxezbqAWHYepA37fFKP9+W2eh3UV4pSq2goBzlleTZmYaUQLae1Ul/yTPxQIdYzPpf0mst0nOVoK8sOg6169gplpGS9y3E7ox+7yu+m/GFjexTu3CvzhG2Ki9wogJvP96ttEbCsSY7iSYtxGFZpKER7ujVrRwc6nWC8mbIi86dnTCjnMzx+GUqzEdNNE9TCS6SuYEoavNHxe4vi9mALNIIqNcOGBWh1NfZ8qkzGHqRB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2018 23:17:35.0469 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88fe127f-384e-4e88-dfc2-08d5854ac6f7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1141
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using device passthrough with SME active, the MMIO range that is
mapped for the device should not be mapped encrypted.  Add a check in
set_spte() to insure that a page is not mapped encrypted if that page
is a device MMIO page as indicated by kvm_is_mmio_pfn().

Cc: <stable@vger.kernel.org> # 4.14.x-
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/kvm/mmu.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index f551962..763bb3b 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -2770,8 +2770,10 @@ static int set_spte(struct kvm_vcpu *vcpu, u64 *sptep,
 	else
 		pte_access &= ~ACC_WRITE_MASK;
 
+	if (!kvm_is_mmio_pfn(pfn))
+		spte |= shadow_me_mask;
+
 	spte |= (u64)pfn << PAGE_SHIFT;
-	spte |= shadow_me_mask;
 
 	if (pte_access & ACC_WRITE_MASK) {
 
