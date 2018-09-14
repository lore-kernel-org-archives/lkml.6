Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABA8ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D012206B5
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="UBqdL8NI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D012206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbeINTBT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 15:01:19 -0400
Received: from mail-eopbgr720041.outbound.protection.outlook.com ([40.107.72.41]:36592
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728054AbeINTBQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 15:01:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Gq28C+dXKwSYwLiQsF5aGq7BMURAtYgUC3uPMGV97s=;
 b=UBqdL8NI6wvQzXrbKirKn87xlJUO/zrdglzX/Z7HbMjaemHFWTQ7QVfscnxolx5QFuvY+yEQhm/TIrofSAlUXkpeeKiash77n3o6OCO5mWtrzVt1LjyayGhzgH/vtwC+4V7E665g+vBDaSHJYpzR6IoGnrtLW5eTYAqkOZceJsg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by
 BYAPR12MB2679.namprd12.prod.outlook.com (2603:10b6:a03:69::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.15; Fri, 14 Sep 2018 13:46:19 +0000
From:   Brijesh Singh <brijesh.singh@amd.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH v9 2/2] x86/kvm: use __bss_decrypted attribute in shared variables
Date:   Fri, 14 Sep 2018 08:45:59 -0500
Message-Id: <1536932759-12905-3-git-send-email-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536932759-12905-1-git-send-email-brijesh.singh@amd.com>
References: <1536932759-12905-1-git-send-email-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: BN6PR21CA0013.namprd21.prod.outlook.com
 (2603:10b6:404:8e::23) To BYAPR12MB2679.namprd12.prod.outlook.com
 (2603:10b6:a03:69::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 064d95d6-b6c1-468a-2bdd-08d61a48745a
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB2679;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2679;3:lKUTgcK7m9E/jfNMaxszVb4LKV0JVc+sO/8Ajt5z7/RAGFaT1QVuGGhRY+m8LB0Ptrek8AlpB6T4sqF0nqKdTucLeYug+nbxxvtUYtkd1NxvRDjQ7j71at5Rz4puyMolBS2D8XOLf4A9DrzbUXZoGYHBsNqgo2FzIEgzYe1g2Clk/Yx8zB6kLf+eqWaQ0z3uM7xLjdAG1MS4IUp/WequP05PxLf/aLXpU6rhOUKg7bB3Ndl/y54LZ5D3tqcG1JrP;25:L8x3NCcI6Ci1+VwxKagti4caQID7vOCd8wQm6pLaB5iBrZQrZagJOp/GzHdNq6Rp86rT8XsNT1dkqBqwC8I4A3MhXAGbHjnbSi58+7QQmApCA9oidDMa4MUs/xcggi3B0h+PtJDUHPGDfKpBs7L6SxJOKYgEf9eaQ6BlJYYYSdoSGC+YX5yjwIyu/USV4SFt6cVX+Xer73nfcPHhgaRa8uw7olzcxZs9aOR69iCl2twWISCtQkhfSIXOz0ebJ5bnq4N9QYq6Kp/BXt4vNd/VVW/c0eTgJvZjN55LWchlnBHswPQdgx583uKXfc2iVSPDelawh07s+U5m/9NJSltTiA==;31:s7/Q/wg3TforsKwkxrgKJ9YW7AZRXzmYgq0PznDCIX6Yao7vZ9kV1NbOzc2wdMEncZs4i0MAO60RFd1DV4dzU355/GzSfnXzMjfuNL6Fru/K/ZeTP0RykZlQ5+lSwrbwE2BJO5qQQtv2KyiHO5nNFVjEHE7U8AvsSTxFyfHp7B7DneCtyUAgrwpR8s40EbhpJ/RI80LK6UN9ICfDzqAx+p+g6qCOB6T+flJehbCjPLE=
X-MS-TrafficTypeDiagnostic: BYAPR12MB2679:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2679;20:bZziR3zFPRiBtSuyI/t+xzSo9gTn2yIlZDOMhiI1+TUkQUahiX1XPFHCp32hPTDbc5hjAV+ViT86ERV7gMDagfOpiizAn4Y3TSOugciNM35l/Xy9BdHhSp6dKHwsQAeMmk8j3Ga/wdHewJDTSOgFLhmBNfn2KwnhyEzKHy6F1TfW39MBVvH0IEkNx+El4gGXI2Gzgmq97g8Xnx2CbwAdY2UkG1DkwhgWFMr6U2jv3uDvQrU512jIbaFNidDKQ/iWYn8Qb8CnlLPpcxZ0geNKruMCNkm4pZR/LiWdiZNseljrB08JPTXT4dVGKplwCRB41weWx6sHd47rDjtBU8/gAf9fXKQDcb8tir0zyrpHbnkCdzOVu3PvmAsYIgCHQP0RF4qoD6nwaTm2xZzEGizrMDmpqcBjE6Sg146PxiegKdwWYiFMFXE6OJiojOxQl8dS1jwS3L//DgOOO1KIe+/UwXoCYvh1nFFk5yRsw6WjV5ATOp3vz8+B+c3ux3UFmo42;4:cYvAY976yaw+nvXNDRDbe5bCdVcXztBnOKpFoeJfjb+QEMevEheb8rNA0eY9WiHkhTE+ZgCAmW0QmMCEZYTGJB3adu+bvYP3sB/Z6zWzNvbAYkEkD/Id3A3Bp4VLrn80/19BYTf2zCr9qObVYUI9DDXCtlK0YqMPHoLn16r+Y6i1KivWlcf4G+EHjIOQp1thz5/DIC4FBES22PIZCj5zsJiQOz/dogBdoQ/G6VM7YZtoA8GZSEw9c4XfGI7JN1/dJJ0mIt6cQwMk/2JSN/9Y0ZsTVczTAZLPWLuz3e219MKVZhk8XEx65ZdB4R7w8OaiyXYwXi8df5yWqaUXpdzrdGOm00vwaHGgFj3rcy5TORlntvQJlrVzCfz7m4g1MarC
X-Microsoft-Antispam-PRVS: <BYAPR12MB26794ADAE475F0F72B286209E5190@BYAPR12MB2679.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(767451399110)(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201708071742011)(7699050);SRVR:BYAPR12MB2679;BCL:0;PCL:0;RULEID:;SRVR:BYAPR12MB2679;
X-Forefront-PRVS: 07954CC105
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(376002)(366004)(39860400002)(346002)(396003)(199004)(189003)(53936002)(6116002)(106356001)(44832011)(305945005)(186003)(446003)(16526019)(11346002)(26005)(6486002)(476003)(956004)(486006)(50226002)(68736007)(66066001)(7736002)(2616005)(478600001)(105586002)(23676004)(8936002)(6666003)(7696005)(4326008)(25786009)(76176011)(52116002)(3846002)(81156014)(8676002)(47776003)(81166006)(2870700001)(5660300001)(2906002)(386003)(36756003)(50466002)(316002)(54906003)(97736004)(14444005)(86362001)(53416004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2679;H:sbrijesh-desktop.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWUFQUjEyTUIyNjc5OzIzOmZVVFEyKzBoZTllNWlmNUZnTjRaWHRtTXJ1?=
 =?utf-8?B?NkVodUtSaERvNm1hTWsxYlRtdWlDMGdHNHVKckJ0cnNGbVpCcHFLNms4OGpY?=
 =?utf-8?B?NmhmUFg3MDB3amQxeG1jUTVmWXIwZmVYL1piNm9aMHpmZUQvZmpPeUQwVWgr?=
 =?utf-8?B?UGMzUjhVbUFsa295OFNJWUp4WUp0SWNBQ0pwQnhFazRIZTNJZk0rNndoNHFz?=
 =?utf-8?B?YlVIQVFQa3BqblRPV2dMWHRBRUlhY1V6b1ZNQTB0NVY3QVBXZkdWZVNqVXNI?=
 =?utf-8?B?RW44ZGZzU2RhRGltaVYvWG1ick5CZTI5MWlNUkZHelpFL0VOSXcvTEVici9U?=
 =?utf-8?B?SHlvb3NiN2hzc3JjbE10NFlkNWRWMmlqVTcvVi8zWlRPazZ1bXpCRFRwTTV5?=
 =?utf-8?B?M00vMHNEZWpCVTEydkZXYjlibFFWcWJpNHlac1ltU2YxNjAveDBMekhMWWMx?=
 =?utf-8?B?WE53cGRKRzIvWHZSeTJCMldJdXd3ZEdGNFBNUWtOQko4VzI3Sm5aQVRLMCtT?=
 =?utf-8?B?TmV2dmgxVldPR3dGY2hwZmk1NjZTV2hpUnBUc3lCa3FCNko1QnhBRjJncmU0?=
 =?utf-8?B?MVdmbG9idE9Xb0RiLytrME5DdU12R2xYSVNRUWdZZUNzd0FiVWV5bEdxZFlX?=
 =?utf-8?B?MS8rZ215Vzh6YU5HSDFCeUZTUzlhVEVaODAvQ3JTbzh6bmxaMk1IeGtMR0FC?=
 =?utf-8?B?M1lvTjhIWDRMOEIwdTNUbE92cjk3eVZuT0U2UFE2RTVRTU83SGZTckYrTzV2?=
 =?utf-8?B?cVlzVnRwckVJczY3cU9PZmNFV0VnT2JYM1E1NFVEdkQ0Q202ZzlIbG9QSnll?=
 =?utf-8?B?eU9QRmY4RkdTWllUTndxelR0WHlPQWlLcitaLzBIYjFJTW1GYWFkUDl6azZj?=
 =?utf-8?B?UTBkNTNYK1hiRUVYNFZhbk84eHRqOFNTZzAwVWhwZ3RMRmZKU3ZBV2hidDQ5?=
 =?utf-8?B?SWhXb0Rmbnpqc0czUmE5U2x4WXFheHZzY0tqdlhQVzZhQXh4VXZ5eThuZWtB?=
 =?utf-8?B?VUtLU2t4YUVXTFZIT2VBWU5IYm5BSFU2Z2laVzA4MTFBZ2xyOXVVdHZwblBM?=
 =?utf-8?B?OXgyeUdYbTUySTFidFA1akVKUS9TUFc1eitlMDc2R3ppaVlHUE5qblRXVmRq?=
 =?utf-8?B?cUJJZ242amJVdk85L2tLNmNnREl3b0Q3ZkZEeVFzTDJTUmRLcm1KVW9lbEEz?=
 =?utf-8?B?Uko1RzV4UnhVWmt3L1ViazdoR0M4dHdnc2J4VjhXUm9QV1JSeFVDczJlT0cx?=
 =?utf-8?B?M2xkMy8xTzZzT25NWW5zT1ozY3Bva3h6YzkrRzFBRDJkT2c0OTdXYm56Y3kx?=
 =?utf-8?B?WEtGR0lFd2hpcVo2bUN4Yy9BdVhidjBmZUNaMlpTbmx5aWhEbDVQTUVXOVB4?=
 =?utf-8?B?N2t3Vk1xWE5sTWNlNDhWK0RHdVFTYVZXT0JmdWJCN1ExQjRUak9rMEwzbG4v?=
 =?utf-8?B?T3JLdWNweURUN1lxbG1YSUhwMDBwMjcrS2I1YnZZRHYyc2hWclNocGJ3ZjRH?=
 =?utf-8?B?a2psVG9JaUcvaENCaXdxcHUwVDFHMHltZC9lczVrQmx6aGJZUGdqWVpnYWJF?=
 =?utf-8?B?bjd6YkFodDBQSnJrS1hWdVBtQ09JYVNrY3B0OFoxTkRONXlIRlpRTldzQzF3?=
 =?utf-8?Q?1E9adRrTm1EyvLLeTSXh?=
X-Microsoft-Antispam-Message-Info: gJPENmkzw8Mmdr53E+C8GrigHDyJGfm2g8/kEqV2r5SZabkAoBQqed3QZEJp5TsQ4EdYqO38JmvVyM6Ozh8qcBXz1J2r5Hd6CzSM5bmTCKLITzb4mWO1TbPANCVxHgxFZ2EUrCCk5i06s1cCl0sbnlqIYjMBnJcUcL1XbDTvcUXJDudU50kyIv+tJQdWebwhh8NrpTkxjlWQpVn2ImaWY558Ysjqf6r7H1G7Hgzfc1BHqrs5qqTzLMOqYxKQftP9tEe6ehUMNBMpQfwRBvJsrV3BUXO11I1e9aHVyGowWbpx52/0NbaJCFuXAgXop9TdbbpbGWVtFpSeNwlqhqsTXaY1fDCkPI3Xzh558HVz/GU=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2679;6:Lcm209nmriV2ZNspvtu40IlXNVjNAM0T7otCwaHsH7bUa/0cUwrB2RSZRqOFJJZVVy4jfJg1ojiekCOr78/N8aWJuLh8ULQzXz27NXqOa0CFBsgG+PzXPowvddPb4sNj/HzKwwVZN4ifAzZB6o+2DR7KgSeMchwyVsPRqLAvUMpEj3p/Q8YZzwHNDAMi6eZi+v/0cIg99fL3boA8BeQmB/zoFgzryJW+8XZuRR4He8/U6lm4rwjlCEY5AFKvLwghcaKs3hgpOoSGtP7RfeVZ8A1/mnHyTRbYlseZXPT93Zt4gEHrZWtXqAGuGvxy/bO0otuRVzqKF/+3/7ijGfu9ogsCsU9oYIF1EqzpQFmtl641sahSThgio2tfznKrK7DmZBxg5aiLf7l0KZJ+lVm1hS1jAPnt0Cqqt1k2ezS+LtzAWz8SKatdwT+qCvuH/kDPpa4YgT5wO2f62xTHU1/mZA==;5:MNIsYgmgPiTw8beGaqBqmC7A4GIw9DnVaBcJ18XywxyqS9IxiIKTbYzLSBWOdxHWceQfgNksemBH4GtNu1XKQq4A+Wt3B2zo9W1i8UpG0n8jAn8N3cTnGkiP16kliI3i2Rse1kU4JQhMMMzoWG1XeXeia9tg4nLSrZJVxhbVY0A=;7:pfUrouFwPfy8HYysdlOIzdUpFxvnXD0K6uMCq+2JEPCQVd/ev7PuMBzRMR6sF0u7oftRYteMsBNEoYtx/LmtjOCX54qF4rubJiGsZtzmP2OZTqlYZu7J17WuTB58GuNjA/WicerPtF7wCSa/Ir/o3OUD0onafEggKI6mjQJj2lzsv7TkXdDFITdCLKl1Cu59okXNepIVYzUXrSV7qzM5mWhSrmdy/3md1db3jHN6ayUaRPK9bqgOWn6SNPK0mrzR
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2679;20:0zsk8O5qkiSIxIB7zLKnRYdfagv6aEF5xciNn4tH41UFpY6r17eXh5HnWU4ciTgCqTdVldEMG85BGi+/mH9lz14MtchhncoDVBLwWgXMn25Xsp49GBfrmJUcR6H9cUe0TugkbMCSVQMcHy9vhpQO1+BR7+JAnzI5VffiJC5gf/yq+Zp3d5z1lDJZsW7aKBVkl5r5waE8UiRUjMfTDdD41+YdG7BDVyjbezP2aQkoi5FQmh1RV18t5ELWSUem5EYP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2018 13:46:19.6382 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 064d95d6-b6c1-468a-2bdd-08d61a48745a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2679
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The recent removal of the memblock dependency from kvmclock caused a SEV
guest regression because the wall_clock and hv_clock_boot variables are
no longer mapped decrypted when SEV is active.

Use the __bss_decrypted attribute to put the static wall_clock and
hv_clock_boot in the .bss..decrypted section so that they are mapped
decrypted during boot.

In the preparatory stage of CPU hotplug, the per-cpu pvclock data pointer
assigns either an element of the static array or dynamically allocated
memory for the pvclock data pointer. The static array are now mapped
decrypted but the dynamically allocated memory is not mapped decrypted.
However, when SEV is active this memory range must be mapped decrypted.

Add a function which is called after the page allocator is up, and
allocate memory for the pvclock data pointers for the all possible cpus.
Map this memory range as decrypted when SEV is active.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Fixes: 368a540e0232 ("x86/kvmclock: Remove memblock dependency")
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
 arch/x86/kernel/kvmclock.c | 52 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 49 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index a36b93a..6378f1a 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -28,6 +28,7 @@
 #include <linux/sched/clock.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
+#include <linux/set_memory.h>
 
 #include <asm/hypervisor.h>
 #include <asm/mem_encrypt.h>
@@ -61,9 +62,10 @@ early_param("no-kvmclock-vsyscall", parse_no_kvmclock_vsyscall);
 	(PAGE_SIZE / sizeof(struct pvclock_vsyscall_time_info))
 
 static struct pvclock_vsyscall_time_info
-			hv_clock_boot[HVC_BOOT_ARRAY_SIZE] __aligned(PAGE_SIZE);
-static struct pvclock_wall_clock wall_clock;
+			hv_clock_boot[HVC_BOOT_ARRAY_SIZE] __bss_decrypted __aligned(PAGE_SIZE);
+static struct pvclock_wall_clock wall_clock __bss_decrypted;
 static DEFINE_PER_CPU(struct pvclock_vsyscall_time_info *, hv_clock_per_cpu);
+static struct pvclock_vsyscall_time_info *hvclock_mem;
 
 static inline struct pvclock_vcpu_time_info *this_cpu_pvti(void)
 {
@@ -236,6 +238,45 @@ static void kvm_shutdown(void)
 	native_machine_shutdown();
 }
 
+static void __init kvmclock_init_mem(void)
+{
+	unsigned long ncpus;
+	unsigned int order;
+	struct page *p;
+	int r;
+
+	if (HVC_BOOT_ARRAY_SIZE >= num_possible_cpus())
+		return;
+
+	ncpus = num_possible_cpus() - HVC_BOOT_ARRAY_SIZE;
+	order = get_order(ncpus * sizeof(*hvclock_mem));
+
+	p = alloc_pages(GFP_KERNEL, order);
+	if (!p) {
+		pr_warn("%s: failed to alloc %d pages", __func__, (1U << order));
+		return;
+	}
+
+	hvclock_mem = page_address(p);
+
+	/*
+	 * hvclock is shared between the guest and the hypervisor, must
+	 * be mapped decrypted.
+	 */
+	if (sev_active()) {
+		r = set_memory_decrypted((unsigned long) hvclock_mem,
+					 1UL << order);
+		if (r) {
+			__free_pages(p, order);
+			hvclock_mem = NULL;
+			pr_warn("%s: set_memory_decrypted() failed", __func__);
+			return;
+		}
+	}
+
+	memset(hvclock_mem, 0, PAGE_SIZE << order);
+}
+
 static int __init kvm_setup_vsyscall_timeinfo(void)
 {
 #ifdef CONFIG_X86_64
@@ -250,6 +291,9 @@ static int __init kvm_setup_vsyscall_timeinfo(void)
 
 	kvm_clock.archdata.vclock_mode = VCLOCK_PVCLOCK;
 #endif
+
+	kvmclock_init_mem();
+
 	return 0;
 }
 early_initcall(kvm_setup_vsyscall_timeinfo);
@@ -269,8 +313,10 @@ static int kvmclock_setup_percpu(unsigned int cpu)
 	/* Use the static page for the first CPUs, allocate otherwise */
 	if (cpu < HVC_BOOT_ARRAY_SIZE)
 		p = &hv_clock_boot[cpu];
+	else if (hvclock_mem)
+		p = hvclock_mem + cpu - HVC_BOOT_ARRAY_SIZE;
 	else
-		p = kzalloc(sizeof(*p), GFP_KERNEL);
+		return -ENOMEM;
 
 	per_cpu(hv_clock_per_cpu, cpu) = p;
 	return p ? 0 : -ENOMEM;
-- 
2.7.4

