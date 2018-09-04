Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB4CC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 01:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D488F20658
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 01:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1Pxc4Ykr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D488F20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbeIDFxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 01:53:21 -0400
Received: from mail-bl2nam02on0082.outbound.protection.outlook.com ([104.47.38.82]:42369
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725990AbeIDFxU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 01:53:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BdJUFBsYLNgYsE/wjTdOS5mKAPWVjyMJBQGIgs0NlnI=;
 b=1Pxc4Ykr0nDMuunsJYmepDMDq+wI77lS58PU0xoK5HybJs0FLI2oQttzztkbfyt3UwW6vGfmgm8iOSJwURhnP3oYlBOTssDyPcv8ZUGChrAV5/9CKiLKFdm0lpiIMW5q/LBUT1ax1VQf+6VErTbkBQgMX/PokR5LYkKZSENB0AE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by
 SN6PR12MB2687.namprd12.prod.outlook.com (2603:10b6:805:6f::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.18; Tue, 4 Sep 2018 01:30:00 +0000
From:   Brijesh Singh <brijesh.singh@amd.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH v4 2/4] x86/mm: fix sme_populate_pgd() to update page flags
Date:   Mon,  3 Sep 2018 20:29:40 -0500
Message-Id: <1536024582-25700-3-git-send-email-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9855e9b2-ee8f-4d0a-32ba-08d61205ef66
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR12MB2687;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR12MB2687;3:SgYDL3VQNE6Fo5lJBDHVVwU2FeSRGhAxlo2gZ5rwa6bq0JCMxrS6bDuTy+bKys3Pl7nYkyapt5+yyK5IvtLFVcDTH0AHd1a4XBjac/fK29yReEQUf9KbMcwBpQ+Iu4V+28w5QcPNYyd5OZ7DpCY/FaN9jLHua5A1TnDXW0H4XPrjxEGg+sQPbIUBnNvO+Xk0/KUhjaQcPQyAkG1CMDuXnDyR8tlRXHZojU/Lnne2fvh1vwUi6caP7tlSy6xHbw0N;25:+YdFcpb4IdwvuCHyqr6TmFVD19e2NWefNKvrt0FH8ydI5hL7Ai8fRMSD/gHHNV2sgg0w+yvilj79GxBP34nX7LlG3NlbbItBdhd68luxwXBQOvvicyluuXrfDqvFmWbmBcsCVmbbaNfotsILn06VMN7lQlnrEuVNTcCoeUqGw/r/2wzsBCfR7Pc6i2DwNUcMEOZEiSBul2BbmYUoyTYb1+kM1WU4wVLY+0KhUeHo6S9ixSX6FF00HfQXyOIxVOs6EH8hqXR5S1Lz0iZltdoc1Moq/F+7L59ap1cuzUhrpk73II6iyER28GcBE5D+BS7KH7fC7N3rJk7hYGg/GW0U6Q==;31:hZCjY0nli7LnYZ8QNtLq66VcbKYZFgg/lNQ8+22N2kGbJyOTFeXW9y3VVD4AT7ZqKw1pZjgAAnbwRMOEDsxeIzHB8xdtFmvbuqYV7CUIDZpYCZ0CBqeRvcG5pKB8roFH0q+vIQwYLd0tVArQsm8TvuN0iIl8rddin72EQMXsfTZUdvims+q8e6oiVgAhbChxgltwN4VH8Uua5V3Wrq+0d3744xA7Uuf3x9pwfIH3YOY=
X-MS-TrafficTypeDiagnostic: SN6PR12MB2687:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR12MB2687;20:TfEGx8H0QQxwrzJDMpLWQ6ZG3SeOCOeeh1e+FWaS2U7DegHgr1+uiTTlAAUfF2a0Z7D+/9udm2uweDIghpchwlqD1oG2NXAmzyfhr1yJaRLfg3+N04KOGXlW510lX7a4SxLmht0JplTh/wYOzb633YCewDY3LyFkfluLnFi1ZbJoADophJ3o8SO1Miz7rLKwR9iNnER4TET1Bib8qhRlPAJJP0ImYWhsrp2mGc6RYBZIWGCOj2sCqYGPdALKLmjXEGS0e6c4PPxmzEUcBv530VTltHB3bwns8d1Vvzfj7ZBW4f8TZHDWdKnwedrR1XxvyWtE6w5G0rCgW+I0DeCkLYthBlJPdcszbAARtAYqRYSnNsi5+TSQjhYAsbmxEnECjUKNh0EK3oFNc7wjO20kuqU1drhdzM0AFipokaew3G4dM5JH0rtKBMa4LSG2Ks2zLHtmh9NYiiRpGWy46cHrC+28MDOf2G3vrUZiSCWqCrCcKLsM5ae2pGNxFLxx8Bvn;4:dIqmSQXwCG22Y9UJPE6+rkmxQAnntHqPZklHlP+DdaHBeRqaPeRMVLnhGrmXyaMPAuC88m+x5BDRoVAoMTzd9QjK7klFeGT8kK+GIvIbbObKKCeuCgVN3gO2+SMHsONTVSwWPUzo44PzeleHb6Hud52tX8dSQC7cVg1//Lx4ZWWYLGiIH48Qe1ANM7DFMWDv7tAddCmouiKnhyEja8hJanMOwxcvGz4/MvhkLL3brTHpWA48Cqxetw82gANSzJcMxL7MbztZljRKR8eeAHlZahg5T91bCM+c9s7AsaO3yaUEJX6dYp5JF9rxa0YO3c7Wz8S7TdPS+4E/ib5PwrSweVE4znxE94U+ZNT/FjkRoUpK15jYkI2knNgtitLCYFxD
X-Microsoft-Antispam-PRVS: <SN6PR12MB2687008FA6B729C9A6540210E5030@SN6PR12MB2687.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(767451399110)(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699016);SRVR:SN6PR12MB2687;BCL:0;PCL:0;RULEID:;SRVR:SN6PR12MB2687;
X-Forefront-PRVS: 0785459C39
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39860400002)(136003)(376002)(346002)(199004)(189003)(14444005)(6116002)(105586002)(76176011)(7696005)(47776003)(23676004)(66066001)(15650500001)(68736007)(52116002)(2870700001)(53936002)(53416004)(2906002)(316002)(36756003)(3846002)(97736004)(6486002)(50226002)(4326008)(25786009)(54906003)(106356001)(81166006)(81156014)(8936002)(478600001)(2616005)(6666003)(50466002)(86362001)(8676002)(44832011)(5660300001)(186003)(7736002)(305945005)(16526019)(386003)(486006)(476003)(26005)(446003)(11346002)(956004);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2687;H:sbrijesh-desktop.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjZQUjEyTUIyNjg3OzIzOmJ3YlFIUWJBZnZ4bnlYaVVqZWtUeFRPRWZ2?=
 =?utf-8?B?aVBwaVF5d3g1TnFPYlc0Y0UyVFo3THV0NTJFUW1rckNycG85dXZwSWRGQmxx?=
 =?utf-8?B?ZzdTZHhwQmpyUzN0SnR0bzNPWnBPeWFPTXJWa2NmK0dHK1ZiOUQxRUpxMTlt?=
 =?utf-8?B?MWhWUVJJQ0wxQ2hwZS9zeTZIVFNRMk4xbVZuZy83bk9qeWp5cTl3UkNDN0Ji?=
 =?utf-8?B?T3RiNFhPbnYwSHU1bGpuMHdaY0QwVHpMYW9LQ0pBOHVpaFJyRDlLZmFyVXdY?=
 =?utf-8?B?bzBERHVGWmVFOEpBWGJYeHN5azJBV1VUTmZrQklDOGJNcGhEUDlBeHE2MVhH?=
 =?utf-8?B?eHVJRFJJY2I1YjhSaTBKL0tiRGRtaUZmK001QVlKalVZNVIraHNycE5mZ0pB?=
 =?utf-8?B?cEpHN3oyR1VnbmY5S09oTVQxTlUxQm40YWFqdVJ6enIzSDAzK3BQUkw1dDhL?=
 =?utf-8?B?Vk1ackc1bEJoQVkycVFNd3FUZXVCRjBoMHV4eFNrNXREeUtlWVM1QTJKU0Rm?=
 =?utf-8?B?U0RvRDl2ZTFBcVpVNzJXd0ovS1FLMjB5V3U2QWJlYkxKZWoxR1puU1dWc3Zx?=
 =?utf-8?B?ZzM5TWhXVWNjK1A0VlpmTFFMREdqaUFybzBzbHFpbkdZVEZZVzZzam50cFpy?=
 =?utf-8?B?b3AzK2dlNmV6WWV6eHhJekJES2NHZUJYVWlyQkFTUFY3QmRQWDRHRTRUZ3VF?=
 =?utf-8?B?MXBLZjhnbDg5RVBuTzMreGdCdzUwMFJmUk9pdTVFNEpERGtwbkhZVi9kTUpq?=
 =?utf-8?B?MkRFNTljZm5lbm55WnhHdEw5d05saDY5RDIvRVFrUHByVHp5b0tac09yRHdu?=
 =?utf-8?B?bVVYS0U3bW4rWUo3NHJpdjMydklndFVqdEJzd2d0d1ZaOUI3OWFIOEpJT0NK?=
 =?utf-8?B?NG52Y0hnNDFBdlJlcjdpbk5lSnc1eE5Bc3dWeXdPZ2d6VGVOcThvVStrY1BF?=
 =?utf-8?B?SzR3VHZmVFlJbzJHbVBnMFZ4djlsMFZNYk4zSXBhM2hUVWJNZG03WHFlUFd2?=
 =?utf-8?B?OWNpMHRkL1pKOW8rSUhkRVFIV1hRbmhLNSszWDZrWVFNbGJYOER2UzFLWjVF?=
 =?utf-8?B?NXJvbTRNWHVjNFJZbTVHVmt1cENBbndGMjVHZjNuaEplcmIzVTVDNHNkZ2di?=
 =?utf-8?B?bGVTR2l0WkFBWTBOUG45SzhBQzZBMUJ5NDcwaDJuSHk1RVJ3WTJLS3hnVmY1?=
 =?utf-8?B?UDN5UUZLRE9JazZ1L0ZFVUQzSHJ4VjE3c3hFQkxyVG4xSlE2RzlOVE5WZVpS?=
 =?utf-8?B?UVNQa1U0UGp2czYvUkFlMklkVmJkaU1kYjlOaWsyTmZnQnQrbTVvRVhEWFhC?=
 =?utf-8?B?T0VhYmt3MTR2eTdRUDNzM2dPRGI5cVpiVXdhWGducStMRllGRkxpalUxY2V4?=
 =?utf-8?B?dkpTSVlNb29yeVFnWnJKa1poWHZVaTVUZldJcFQyLzc2QXpnWndqbVdSdEla?=
 =?utf-8?B?b05rZjJOcmJuYkp0T2ZPNUFvZ0hTQk8zZHJTTklTY0tqVmo3a3J2TWRoU0RW?=
 =?utf-8?B?a2pvNnFwOTl6dWtOUFEyd3gvNk1UdC84N00rRmpQOGdTNENQWEcyNzAzcjNs?=
 =?utf-8?B?VDNtT3J4U2hVeWRtRE9UY3ZnRlo0SWJCdXNwbUJuNG1MRzMxeVBML2FEbnli?=
 =?utf-8?B?Nmk0NE5BWkdIcWhNWFRtVlc5WVdiSVhubHpLb05RS2R3d2pVNnJvZ2pRPT0=?=
X-Microsoft-Antispam-Message-Info: qs7q7nCLJ1r7vMDjzQG/437ZfgVyI48O6zRkwDgWYADtOXhPs492W4lmj6x8oPAmj+rXM/lNauyDvtEaZn+HmmOeFe+Zd3GV6D2bOcOdZpFvbXuWa3cr6pzX1VowoyBgK2gD4URaFPmokocJiCNphIsQ4fpVyF4tVjBryRJ3RSjHag4LrK3YQ0q3aWY8OUQImQA/DyB2mK4eO8941v/tKt1A8G/IFnvdAGsSd35y6xNAlikWP9cjGQjY7rlXIx6X9CQ9e+LBExXuWDuyWsW2pH3Qo4PJcQv9Vkpb52PeiEJ1dF686bIylE3cm2wV9cVWk7vr5eWglQZcaNYz7zHjsq3x+1EdUPRz+7JwYZaUGgY=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR12MB2687;6:yYtIS+78pIeK+vGdh9raOX9HvYdbybK6NQSlRvXU0XO3xNI9vjNJXQuITWPSA+V2sHkxWcZZVI4CcZ1uBzYSKv77uzdKNIxaW9OjV/PqMpy9oM3YqDe+gv6/GEe1twsPOZ8a6Z4/TVuwFPjISzik3yVEef+LidnjS+URCwEsQCoy0iNXrIWxSQbpRN72lbSDjMRZY/+1otsrNmotXWgusXd+vaj1ruF9cCD4y3QUwTH0kd3tuaHywXWJoNyHTv9cy1xIaUejhxHt+U/LshUrncKsRtlOqbuRNCzuOhKuwy/h/bl1lFSIiMteOEQjhi/G7uswwcprRMJ6XTPar3mOkqLX7iZZ3AAqGTOjf2bAH27dm9E7nuDK1Hs7m0ScWN5TZtl1kLAue62Tg+g+NdjxrlKxuj6aQ1gabYGEUvCm1ybxv+MHPpIKyWIQKGyPKM3QBOx5DtyriIBcASIqPfIM2g==;5:GSFKWfFFvFLpr1goQT8qnFBsli6V7+8eW0aYdHFQY7a79jyTb/rQs4WmisuhTLq0HWJkaOCtubxhqgJRs1I59LB59IPAvMe0ElOimkfbGlGmlH3ALZqm/NqEq9ZHZ+sl67Ox/DrZDYIJjGmBfHi23m3cufI1bS5xUbGrNp/PHiM=;7:KLPPNaxw7cL/gMdmi/H9KaNY6gLT1dd5BBhwJyQhOtOnrL7338UfUaQZZfmR3F2o3EVTUYmuboyMNPTM7977xJdE9LYqU/JjA2iWmBBealegPspIqommwMmHgQA5Xqwte3W+p5kO1VxJ3Hj5waujkSeX5hhmHnql7GIcPDIECxeiZpQKrddF8dQyuB4bTDUWXTvTg+AoFLnP4r8eMrztyplANljFFZY6T90aZx9mOasD4PNbtZepKMUFhR2XUtvh
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR12MB2687;20:y0Cz1I6xWKjPbUoca07Fkk3bvCw4G2lKRk7s7K3hcCTni60dHsg0uRi/IQ4MsjVPxXOFcq0EZic02pQi3PT5LOVBpWANzq+m+9MGqBS4BPvgXb689iTKybGThyB7PJZd8A9fzldqY9xKGvHIJL41nk+mBn2NhezfgYgqmc8JyUZ7Tk0UrDiLuMPB/0G3IvVd+3Wx3Ybfl0HRkQzuGhkij3NlccbHJ3bTjCettdWTRemhmNYBYTOwroTRvAPrPD/A
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2018 01:30:00.9936 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9855e9b2-ee8f-4d0a-32ba-08d61205ef66
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2687
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sme_populate_pgd() to update page flags if the PMD/PTE entry
already exists.

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
 arch/x86/mm/mem_encrypt_identity.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index 92265d3..7659e65 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -154,9 +154,6 @@ static void __init sme_populate_pgd_large(struct sme_populate_pgd_data *ppd)
 		return;
 
 	pmd = pmd_offset(pud, ppd->vaddr);
-	if (pmd_large(*pmd))
-		return;
-
 	set_pmd(pmd, __pmd(ppd->paddr | ppd->pmd_flags));
 }
 
@@ -182,8 +179,7 @@ static void __init sme_populate_pgd(struct sme_populate_pgd_data *ppd)
 		return;
 
 	pte = pte_offset_map(pmd, ppd->vaddr);
-	if (pte_none(*pte))
-		set_pte(pte, __pte(ppd->paddr | ppd->pte_flags));
+	set_pte(pte, __pte(ppd->paddr | ppd->pte_flags));
 }
 
 static void __init __sme_map_range_pmd(struct sme_populate_pgd_data *ppd)
-- 
2.7.4

