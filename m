Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5EAAC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6450921C39
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="N5pqhLt0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6450921C39
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732285AbeHIQeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 12:34:20 -0400
Received: from mail-by2nam01on0070.outbound.protection.outlook.com ([104.47.34.70]:17168
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730839AbeHIQeT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 12:34:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yHO1BXxyTInRrhI+xhImPTcU16bq8rXTYF5jz4pwGYs=;
 b=N5pqhLt0ZjZ0CFnZ4Ze+anuGeQdOEgxoDf7gI8CNNqDVUJ9+vyoYNtyFWglfIeIBWFqsJhQfl1h2Ksu9AYNyGryZsa6569nxxQAp4Ls9YWcfBI3SM1iW8qHtDC8CumUBjyYnLTqWiz3tPIDn2iMkdWl2F8HQ9GzDDZEEJbEv50c=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
Received: from yaz-diesel.amd.com (165.204.77.1) by
 BYAPR12MB2600.namprd12.prod.outlook.com (2603:10b6:a03:6a::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Thu, 9 Aug 2018 14:09:04 +0000
From:   Yazen Ghannam <Yazen.Ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>,
        linux-kernel@vger.kernel.org, bp@suse.de, tony.luck@intel.com,
        x86@kernel.org
Subject: [PATCH 1/2] x86/MCE/AMD: Check for NULL banks in THR interrupt handler
Date:   Thu,  9 Aug 2018 09:08:33 -0500
Message-Id: <20180809140834.59264-1-Yazen.Ghannam@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: DM6PR05CA0026.namprd05.prod.outlook.com
 (2603:10b6:5:f8::39) To BYAPR12MB2600.namprd12.prod.outlook.com
 (2603:10b6:a03:6a::33)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65a3ab82-0fc5-48f7-047a-08d5fe01aa8b
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB2600;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2600;3:opXaoxZMq7bb6ievQ+/fVt1KhMhETf4f4+X2oGxKvIp9GKlWrW54ciZ1o+uKur9n1b/FN+L+5vgrdEx2pQIVHt5jsyVSo3Y+HvOFBdEJdfaQWLPLm4dEWMfUyUKY5zqX4X2idcPi1Zi0t0Gj1RuG3wl/jMC4FlONqll9vr7d8o/VtmmfhtS0yINvwVgSNpKab/Dp1/RdERqqPVH82D370vGQxLwA1BAttSExUR6rhk8oilFbxDKw98eT2SUKavfO;25:vEI2PPNzoh9fV2hQpp+/wMhCbT4z8lHREbmZ3pTs2Aqu83xWb8DAaJgZk5y2sdWkxEvUk6efeT9YmIGvn7VtRPJtHcbEOyWAIPFNEYOAQP3ey4CW4hrKvOOjyCp2olRUJInkn/NlCe50/HK93Ti3D0NhJGJYM8NyxF61ha5EARWsWFVIIZrD21pjkBIy9SWiCAQyAWruiMhv45rTyA3vgbH4Ah017g3qCp7DAhw/AeSQPgVQG6R98OtFSHsPQr2LbSPcz6uUXgobq6NftKAv29A4gfJAfxJe+gKOFjl399Lf6XWkrlTNxvlqcoA/SW55v62sIcn9bvqQFLrSELYrZw==;31:KYLUN5pgr8ToKrS/XMRbSEUoc7ZxFdghs+IikVh2zi8Jp4K+Z5Mkc9QVEIDCiBYyIvWqboAuRM/sOY1p+RLLmpKeKIdDHaUe2NZttnxkNRPqWVDjJcvkqx6SqQVVcOii9vYnLmQMMVrYcxjbK6Zv2YjbDHPWN45HHGb/Hc4JIjkMRSn2jYAuqUxNhuds0QfFDBKxrX7oMqx3qlTQy/++69j3UHkYR35w9qHHsGI8r7w=
X-MS-TrafficTypeDiagnostic: BYAPR12MB2600:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2600;20:9LPKX+UgAolHdC6qSxzmsx/wOqmouoyi7SnrT9hYA6Jv+YMc96FjpkxdHkccumQNpurv9emlbfiz0qbWEmKBjJ2RTs/7hAydLyk7kJj5dOOouNmEhfHmWoBy2p8b4TlMJMus+UaGL1yIG/H/lMioVPlRa+G+ipPjgDlMwRbII6aD45GZI5cdllwav0w9jcyCk01mfBkFSQBglvmZH9nWI2B3fJlr7v7oPE1k4SNqB6wgOfaP6wgDy9+0+G/356Oicv39QMz9yQi8eZkrm8EOt8NY2EHrSxd8/qJUWJj01z0GiFmz3SpMEhHCAyV9Y6BocZ5vAJ+eDFI2K45KElVpPA4FVNF322jh/gPHAE/pqhWXNijKVVEtojj2d8V8/sj3JtTwRY42b3KuxeWBbilyYz1/CsdUj2msTg48/fNjFPac0mSVKNSGI/h2UTxQ6jhzwcXsg6O5nQgbFnymBuqoXjXpEn1G5igEVM9MP/3IuVhciNngRC7sa1vZL0bCU0GN;4:JDemD77pMvbIAMKB+ftD8gPQ5IYEAQzWPCa6OA/pM6qGQGyNf0/ITtwwKBEfzpLDykt6Rly8lMPRkPT9b9/52uBulNZQrLtzxQvUlyRgb5/ua4iXCSLtt0KzuKg0Xi8EpcwQPwmmMEdrzstnxOmUYQFrZxNZdW6SoxDqNhnRP3YKU7gnKNByHUELSc3h37pExT3RuAfCu1QBNikog9fnUy0FhEhKGHzEwzrgJyF6bo976yjFiOSN86LrPrWgk1Fk6vKvyx4TBnCARBqFRoD1LPeO5QkpgxK2Zc6XO5MIHXtUWbGWrNsO9taOPmyLw9aesssZqDQ8HuNgyoLrDZM2JA==
X-Microsoft-Antispam-PRVS: <BYAPR12MB2600185D7160B8329AEFE4FAF8250@BYAPR12MB2600.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:BYAPR12MB2600;BCL:0;PCL:0;RULEID:;SRVR:BYAPR12MB2600;
X-Forefront-PRVS: 0759F7A50A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(39860400002)(136003)(396003)(189003)(199004)(8936002)(106356001)(50226002)(8676002)(105586002)(3846002)(81166006)(81156014)(68736007)(48376002)(6116002)(1076002)(36756003)(53936002)(72206003)(53416004)(2361001)(50466002)(14444005)(476003)(6666003)(25786009)(2616005)(486006)(2906002)(52116002)(6486002)(478600001)(4326008)(97736004)(15650500001)(386003)(6916009)(7736002)(2351001)(66066001)(316002)(86362001)(47776003)(16586007)(956004)(5660300001)(51416003)(7696005)(16526019)(26005)(305945005)(186003)(575784001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2600;H:yaz-diesel.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR12MB2600;23:enasMEAhzddNjmfqlTJLHKplKAyL9Q0SlZPIAotxS?=
 =?us-ascii?Q?l0MQ1sUjx+ZzkfI7kM0kiF0WArgWLfDG6ugLzxx8saHEYCIYHpXFXsvW01Jn?=
 =?us-ascii?Q?kytJW6kFGnU9F6Q09xL6EBB+cfX1RzCHvjrVusNeJTQxH1PP+wcMtoLRycDd?=
 =?us-ascii?Q?MvIygUgy4obQCjhdCxTy9w2o6GCQLrfq9KPzv9JaZkfqB38ofUz/mmV8+IjJ?=
 =?us-ascii?Q?dkWIxM6gepWntOWQRHBOWNE5e2toz9aWiT0ZPV+MlNO/N5JLuUy86tKbNXYY?=
 =?us-ascii?Q?0RjfMTTEnRLbv0vtea69QiLXp5uwi/DSZCiCqGuVXAz5YagMzSc2Cr8poIdj?=
 =?us-ascii?Q?sOwoj6/PuCnt7VgTFCA0mIp69xlKxOKBnqhW/fb9s7W0v+miNwlbZ0KLxU4I?=
 =?us-ascii?Q?ftziL1g7viN0wQNboERANPo9SA4HEGHUeKXeManMYOve/dVpQ85mEujS9Bk9?=
 =?us-ascii?Q?LdNtKR0j73kX8Rs3zvAiMaF+jVt44UxfmFw40xgJaHMxaa9En3dWVcsmgOce?=
 =?us-ascii?Q?5VNbj4jezn22o4ib9/xf9aYHH8fFEtnmUYezgFNwG051jCWBTvQcBTgGXHjx?=
 =?us-ascii?Q?OV5LoCc753V4ZdjjhwMRKsjg7tD6iJ0bqcOH18+KOfIeze1PAfTNMyHSs83F?=
 =?us-ascii?Q?RSwgRKEse5Z3KJX5tMOw51vm3J89177I5OHZJz/0oKGFz5H1vNMUfHj/Il9Q?=
 =?us-ascii?Q?MlAa77MUlF6q9gw+JEO5UcYK5XsYg3ZuUnBHNzdkuooCnFENcuDHHKekmjJ2?=
 =?us-ascii?Q?F/pfBRzteLCfYQ/aVo9rxYWVs3M7qkYzXLK6SoLRgQbJDUwbFa4AhzuhjSF+?=
 =?us-ascii?Q?Q36wl3UX6Bpul5SPOT4c6zDuZpUtlTn8HyO7p5kosN2Sypw6AW4ocbLG2LOl?=
 =?us-ascii?Q?T6D80sHrWCfK7myckN+Jojm+xon6AOdC2t0xWKr1DG0KgQr5kyrWacVXk20s?=
 =?us-ascii?Q?MJaFvunlf1+LfX0pHuPs6+nNGoeSgP3DyJmoZsy13dNDH5Ki86Ph3G6wVWjx?=
 =?us-ascii?Q?4ij/A4g6WSP+Q0RQhlznZ6I5bpaNAcAcFO0597Mz/3+4SHdbCy3ylrrV/DZ3?=
 =?us-ascii?Q?HThYG9WAQ0XcGdGP1DRyLsUnNnLpg1D3RZaFlvmq6okzfGH+qn41pu7F4PP1?=
 =?us-ascii?Q?bfZG22rbkAKSInkkMCg3ElJHtLMxW2LF7xYxnlPAtrlnhm+Ef8vxmezZLhQl?=
 =?us-ascii?Q?kD6r/FQ7q6IOU4UB/vf4v28fJOZAkF4Y86fksf+XY8Fmv+N0ymeyVfuLQmb2?=
 =?us-ascii?Q?wgTAexgcnommdPEsPS3vn96x9n0IMjG6hhi/DST?=
X-Microsoft-Antispam-Message-Info: bFdwDIpBDteYYRklxsD184GGt4cb6Va2+eDr0xRSTWzUdOtn7mHIXPqdPl4LFvcRaC6g0jV3cyhs3e6PXJB2nGAs6+jpyWhbX+TPYGRQrbeN4LNGiQR71RtME3hvlgUEQc3FTKH48I8LIrdodyWqswUw3+gUEwpHVRxsCgEPQ1P0wcCiZBvwd1dIwgxhYXHiu/684xBcsDw3olfB/Q8KyIZQfBvQmIm5BB/5Wdf5m1MTgdEcuRWrT+TYBaIj6wG8mQCkLkm92cmjj/DR8SMbnTj4o8lKtFzSnKK5hgJGtT5N3P0Y4goNPRo/xYJ0C4Zizp/J0t7jQqPPqUJyRXu5YCleOekU1rtQiI8al1EFNZI=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2600;6:rdaZrglP/mVg7pTpyKg5ddKKm0uUeZeyBY5Cei0dpR0vZoEocp7ETXX0ruKyIg/HTHNfsj+0uq5t4rIX9Z2T2FCWTQHxoEYH9fgrPX1d/jcxdiyeKiP6p9ikxtj7OjY68CYNPbgp08uMZEQsN5oIhNJw1dECwr8YXBj8SrRAQZT7iMzwcmCuuUelSNTEVYR4Oj4VmPk4QwW0jOcFStaekrpEqeLAzGW5yc7ewz330iBL0qh/SL4E8fiKvbgTUTbt/9GqKRRXOm2UWC5BOvJ1Zh5BnkymwJCc+FnyL5scXOoS+O5u5YHmNUeWZm/nd74n5kAQdhRPxJtIc36KxatyMd8+8j7WEsN4tWcTIeRanyuUo62W+EsMaoJmnICVUimOzKA3ZXqp9oGcCcm3renCP4hDJRgrIz2n2Foj34Hnq0OZtjgxrRfgH97qGjC+jb5A7esNU/nJXlpH3cgxBtMM+w==;5:dB5ZdBSNBYenzPIjPlj9Z8oLJLrtP8axmiNMQQpAU82ZArodJRUUV47mNfHB8ZuReaK2Len5sPkWWGXxz/zzAFOseNu/X3krKxPGiAXUSkn6CfOcKf/B2Q6oKrM8CpfPRORNk1HmEMwwk6851+Hem8s3z6uZhQ9br8wnWog0YLQ=;7:nVWVrR/lcMYENxtrZJc61XRzgB4gsLO+hQiP+jbXzya9K2OmmHy/tlMW9NyR4uLb1EteMbFc9SK94sJaY5Gyq03ToCFrnR8Iv4XjzvwKXetOfAHl587kIv6zSRyDx8wBRnk8aCBsA8feZxOUrQWyeVqnV/e21YVgc3SvqIrhqcjsi7y1yNsgUsSZ/gg+l/9IwSc0DCaNTn1qYKRKfUKoQTHRRQpU/Rl9kx5VTiy8gkADjEVmg2yODdpDi7E0Bp8Z
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2600;20:ByFVpS7LIwaf0VRNzLKXF34qFXFChe+Bym7hbU3o8L3xjyFhHqks+aUXg/jQncwzEwI+VBb/NJC3MiAgAlxO7m1gJLDM71O/NYh+YiPWMbijO3Q/86/uBcImMBDdUnbWUIXRVzzbOiANxMiaLnanWrlufkm5gXhWjwK/25LWOMjEQ9y9I0JbIoCIPWJhVwOZTDIa6Zc9DN3UPn9N3iNVhTlskfXQ6qgdEvh8ib+S8yiBUXOc+lmD70ZOJ5QgJ1Kd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2018 14:09:04.6468 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65a3ab82-0fc5-48f7-047a-08d5fe01aa8b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2600
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

If threshold_init_device() fails then per_cpu(threshold_banks) will be
deallocated. The thresholding interrupt handler will still be active, so
it's possible to get a NULL pointer dereference if a THR interrupt
happens and any of the structures are NULL.

Exit the handler if per_cpu(threshold_banks) is NULL and skip NULL
banks. MCA error information will still be in the registers. The
information will be logged during polling or in another MCA exception or
interrupt handler.

Fixes: 17ef4af0ec0f ("x86/mce/AMD: Use saved threshold block info in interrupt handler")
Cc: <stable@vger.kernel.org> # 4.13.x
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/cpu/mcheck/mce_amd.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mcheck/mce_amd.c b/arch/x86/kernel/cpu/mcheck/mce_amd.c
index dd33c357548f..2dbf34250bbf 100644
--- a/arch/x86/kernel/cpu/mcheck/mce_amd.c
+++ b/arch/x86/kernel/cpu/mcheck/mce_amd.c
@@ -934,13 +934,21 @@ static void log_and_reset_block(struct threshold_block *block)
 static void amd_threshold_interrupt(void)
 {
 	struct threshold_block *first_block = NULL, *block = NULL, *tmp = NULL;
+	struct threshold_bank *th_bank = NULL;
 	unsigned int bank, cpu = smp_processor_id();
 
+	if (!per_cpu(threshold_banks, cpu))
+		return;
+
 	for (bank = 0; bank < mca_cfg.banks; ++bank) {
 		if (!(per_cpu(bank_map, cpu) & (1 << bank)))
 			continue;
 
-		first_block = per_cpu(threshold_banks, cpu)[bank]->blocks;
+		th_bank = per_cpu(threshold_banks, cpu)[bank];
+		if (!th_bank)
+			continue;
+
+		first_block = th_bank->blocks;
 		if (!first_block)
 			continue;
 
-- 
2.17.1

