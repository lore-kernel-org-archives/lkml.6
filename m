Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50776C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 01:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2CCE20658
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 01:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ZDUkVMbP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2CCE20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726093AbeIDFxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 01:53:19 -0400
Received: from mail-bl2nam02on0082.outbound.protection.outlook.com ([104.47.38.82]:42369
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725833AbeIDFxT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 01:53:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K2txtTs/dKgYSLSmfQ6fmp9U7m+Xsj1BFCJl0Pp9LE0=;
 b=ZDUkVMbPEUxPPJyJ80o0T9TMsPWdCsR8PBdgvAEdFCCsRnbMB96KbplEu4xa2n/4/TvP4NUnSyVl9XAzrNPHxlbA5w8HOG/dhdE+CJSrknKRzYPY3jhRnSHZ28ZcY5tiBMoJXLpkLZZB+dd6EwcsPKaKrqdl0CjTeOTvqeV26UQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by
 SN6PR12MB2687.namprd12.prod.outlook.com (2603:10b6:805:6f::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.18; Tue, 4 Sep 2018 01:29:59 +0000
From:   Brijesh Singh <brijesh.singh@amd.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH v4 1/4] x86/mm: Restructure sme_encrypt_kernel()
Date:   Mon,  3 Sep 2018 20:29:39 -0500
Message-Id: <1536024582-25700-2-git-send-email-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 88c02af3-d92b-43a5-6474-08d61205ee75
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR12MB2687;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR12MB2687;3:mTc7CAhA6MP1N115JshHI1S1GFvZMdzAzvEYG2/xhqjkrRK9LQVijtQKV2uYmfgsI7NUIkfY6ZWCHoH77t34qfbfnHIz4FUoGDHrfX8/vpmwdjY+tCQ6tb6SwqpIZmh99g2bY0v6Dve18FJEIEokJXf0MpYfILpWPxoWp8v7ZVNDuZGyKWPiaxeJWvjM67bNmqryQXlZvlJs2Sy9fgiSzfMAvqYmvr94vFBKPdTYDTeytjYA6W//6hnlcXlQ9IGZ;25:O9FOw3dn95TJApn0EjzIov1JsAq7vat7GE5JreVK3KfLkYus+Vt0mGg2SAFrHDG56NPI8G4JNnbAm7frmtGuviEnZ5JxsfFydI3H0zP9hLJDUpIpfaVsu6hbuNCmjn0yinIpY22c0EzYz6GSemtd6djIkaV01nCkfxX80nBrjtt540cIlojk03NsHEgyV5+sOxLGs5PzHgQY9T9BegHN7z74iRKwcu+CkGZbY5CgWe5fSvRcMi9tCcctSg6ZtyABJ80fQGXrK5P+ksXAZC3fPJjEqGFK7T4d1OzjwDRxelgeaNHV3KPcimoqm7K27++nwwgNzpdrWoLravBOn+DGZA==;31:Yf5tXUD76O8DQrVY+PM7VXeoVXrfKf0qmci2E57AXsuiyVHP9Pqx445UA9hMcSG7PT/ZacfrTZeS3jECxgvYVlVkVaziU7v1ux7bd+YlIyBjFYCtAYPRW1xHRZnkjaI9r65K4E/4ViCbEyQrrFUmrAZvyWOU6x7T5f8T06wNW3P0dqV+nqBhdOyf/Dp/KJ2D+mi9m7mMM36Bl83OWA6k1Xg8H9r6BAFJP7onWHTEh/M=
X-MS-TrafficTypeDiagnostic: SN6PR12MB2687:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR12MB2687;20:iSBbeCc6ByWaMRzzehQy7tbVDy0RY39wfpE0Z0OWZx2RFerv0crzIun6EcEaEWHpJroH57jOd4T+vu4/4zdXr0xuhnMFkXKw4yG9hBrsl6XKrjGQU/kxTFSG1dRPU+05VUQ4ObhQ9DNGXgWYYn2B3j4qi9jq9U5DROEunlTRm4yjM7urCJT5gfqt3ovPQQXJ989xqi2Ca24SaScnbd/Clh4ZBbHOEec67Lp8UhYJmbMUUycddnnwjxuAKtQJlmvqepMwI/sDMIR6ePEUSSVePm5m3sO0Aweo46j/yd3jo9zoqV+sP93iKyCh1ISZFwd+iGz8/oXZELD0+p4PnLTBfIVTRG4RMgyrO2rcoXwbAtXTCCrnsTezGis1PWPJoNhR3H+6Pte5nzGqMLOYJ9/LXv0zLZa8z+F+6SCO8n4uPFoBikZnfgfUlzpV4MnyPrpK/ut+6HWKZLlYUmWtYz73mpN2qp5pjvaPC8aR1XB3/1WT6UCF7YA8gPnap914czCn;4:2QgDLuWELV2ZSzxgrf3ht/nq6toSOucOcgR3vVVJeNMdlsotF4GfE+r+oG4WSVBm99zZKOgOIgfxRQfbmartcqn5mZpx6SzThBstecFm8He7qw9N7OUGW3jJXuprNFn4RS8Dw0GLIAwdWAqQYrRZPEtZ965AB8OVw0K5nsNruq/ZAyLAOM2TAKVJz4auqwsJNDEQxokDK+yy/b1baKl8CjFli5MA2wXiQjKn8PxtDoNu/mS4ZuZ08wy2sSmcJ09apVL4d57cB5BW8LgIVYICzyMj/Wp/d9XrQecq94NK9omvDeY07LiEA6e3trzAqXfIpuW28Do1FdZGsYlnziWyTwiYKH+jui1+qpTb7/L8xI1Np4JZhapDAKcjItA11yEg
X-Microsoft-Antispam-PRVS: <SN6PR12MB2687B817445764A49FCBBE18E5030@SN6PR12MB2687.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(767451399110)(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699016);SRVR:SN6PR12MB2687;BCL:0;PCL:0;RULEID:;SRVR:SN6PR12MB2687;
X-Forefront-PRVS: 0785459C39
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39860400002)(136003)(376002)(346002)(199004)(189003)(14444005)(6116002)(105586002)(76176011)(7696005)(47776003)(23676004)(66066001)(68736007)(52116002)(2870700001)(53936002)(53416004)(2906002)(316002)(36756003)(3846002)(97736004)(6486002)(50226002)(4326008)(25786009)(54906003)(106356001)(81166006)(81156014)(8936002)(478600001)(2616005)(6666003)(50466002)(86362001)(8676002)(44832011)(5660300001)(186003)(7736002)(305945005)(16526019)(386003)(486006)(476003)(26005)(446003)(11346002)(956004);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2687;H:sbrijesh-desktop.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjZQUjEyTUIyNjg3OzIzOkowc1lMUmdYR3ZROFhJbWhnMVRJVXpweFVT?=
 =?utf-8?B?bXhkU0lZV1M5dFVpMWRFN0JIVEtPT1lkMGhEdStXZEUzS2VwdjZJMDNoSngw?=
 =?utf-8?B?RnBPVllFNHFkazJqQU1odmF2SnRUQk4rU3kyd0JmTVQrc0VIckowaTRPc1oz?=
 =?utf-8?B?SVUybFpNSGRhYUlWOUt3Q25EZHlERVNCeUVVV3FpbFlIbmdocDFUU21kdDlC?=
 =?utf-8?B?UStEYmFsajJYb0d6LzB2bUk4blJDWmE5Y2V6RS8zUkNDdXVHczZQV0hNaXFv?=
 =?utf-8?B?dHZhd0UxSTFZMnRxNlR0TWlielhuTVVlaDF1Z2c3NTNnaVdoeUxURmFxLzNB?=
 =?utf-8?B?b1UzNkhXUm8wR3lVVGNhcmxPMVd2S3lHaFFIV3psN2Urd1VpVHl2eVl5NDNY?=
 =?utf-8?B?NGNIMDIvNlN5Mm5GQWVrdjlMUzRiUzJBVWRDUnRlK0pkdjhvMVM1cnVJNnox?=
 =?utf-8?B?c2F5cEVRaWdsVHVIWW1SWStXT2pkRjNJSDR3VzNLOEtuaGtPSG00MENYRlda?=
 =?utf-8?B?dHh3cGZiOXVNYitnM28yaFdmajBDSlc5SHRHc1FvZ1JqTHN2UlJIYTJoUW50?=
 =?utf-8?B?K1FnUm5pNk1ndzRIZFVyTzY1T2ZzOHVJSVU0RndMR3pybXZIcmx3aG1Md2Ru?=
 =?utf-8?B?RXFWakFEdlUyeENkdGNlR3RCZGI0US90aEltTUdNU0hoamJMMkFMM1MvR2ta?=
 =?utf-8?B?UDNQMmQ3aWhWTk8wTkI0emFRSllRamtQL0dxbWZHcDRlYXNtZnIzckVMemNL?=
 =?utf-8?B?Z3BrSTV4aGNYUDRrdVNUQ0JRa3N0bndNYkM3MmltMFVZVU1kRVZZeE5xdGxX?=
 =?utf-8?B?anJMTkFQbDlGaVIvVkl4NFBSSndZVkJVazd3MGxSQWNLaVg2QWVRSERBTGM3?=
 =?utf-8?B?VVR6ejluNzlxeXltb2JJTEhUMllLVXBuOFdZengvRjMwendERU1lWGhjcGRl?=
 =?utf-8?B?N0xIMzVqMmQ3REVmbHVOUUdZbDNSS0t1VGlUSnlzN0JJREZKODlXV2liczZk?=
 =?utf-8?B?OHR3dkpHbkUzSGdQS2FtdEhMNEVTaFc0aDdjR1p4cExGWTVBME9sbnJTeWtT?=
 =?utf-8?B?NVMvQWxPWm9FTFpRcGl2S3J1SEM2WFJSb2ZBRkRnY1hsd2paWldnZUxMemZn?=
 =?utf-8?B?Z3JzNGVoM05XNi90UHdtYmdyV0ViQkdodTd4ekdRQUtZdytkQitNbzBTMWVp?=
 =?utf-8?B?akVwZzIwenpZU1Myb2FCb21zN3hSaDRjMHRaVWdYSkl5b3lXd2ZqQWk5dzla?=
 =?utf-8?B?OEVQb2o0ZTRsbkp0V3daVVVFZFZmWjRsOERCZVdMSmJIRUNZS1J2YnppYnBl?=
 =?utf-8?B?MjRPMVZSSXAzd2R2RzNMVXd0ak9lWnE4eTVUMG0yYmg1NjltOVNNNjZydWJ1?=
 =?utf-8?B?YTBUdVc2cy8ra25aakpuNXFTc2VTaGtXWnpOSEJtVjJxbUJ4bngvWllzUG9Q?=
 =?utf-8?B?N1ZVd0xCTHRTVGFFblpNVlltUzJKUzgxY3ZtL3NjK0xxUy8vY0x2NE5DVjl5?=
 =?utf-8?B?aFU2WUVPRDFVU2pCa3hpZlQ5ZEx1YXVDeWduTVBZN1lxcWxvU3RHUFdVN3RF?=
 =?utf-8?B?NEszVG1YWFlsQWV6elo1djUwVzdIWjF5UjJ6dllBcVptTFlkN3VDdWdKaUNr?=
 =?utf-8?Q?4CtlmSMxMCU2/UUhbWCF?=
X-Microsoft-Antispam-Message-Info: tQ8nxaHtxHsKe2O5GFkdWtWCk0Ab+LQkj39aevs8tgYNXv9hpijdcPHeAkc3jES6hztdW6dgvNd7vQyNzzpt1Rlu3fG/LnocjAwBeFZkTsHfX37pzz2+awdIqnjYsvQA+PH7OEtjUbD4XEGhpTLe7JTmCQXo/7PNYG7vRVT3lVJVqo9uBhmSVpzYEQnqXbqKqxC5X2MVDDMlRITFgHmRpud4HlPSvgihlv+87Z+isMsBX2Hjtf6jJcwp9XrPBSC9BGwo+t0F39WCQGasOVfHkkCnYoVg5LWR3jswnuZ4MKRhyYBTBWJ5pH9bWJ3wW75Q1k9/93BtItsZpjmqXp5SLlbgkVBz1zAq5W5h5RPJSjE=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR12MB2687;6:9WiwyTooMFC0e0fPpFzlekrcNtAS1mvW0xOK6/Pl+POyc3UJZGIwV/QzZkWGrlkEjteiCRHEF2OolHLOsGEpQ/qpcCMpx9I2HIIqWmkT5/G/gqaSxRD6QThXQJyLZ61q0R4cuOcesTNw+LSrPG4lSYJxlBxge1BTdtHC+hXmNRieFZHZVU6hIPfSVi9nIkxe7HQF3WZmo4AvwykXeyB4WVpbAadikGGpzK7Md+FMl2JveyfLhipXchUiES4BErpguP20V9knLiIeW6Q0TkPXTBU5+elinnbpYiLEiKm8dfp6cs+vOJ5fyrsEteygM4BDXm4vDvefVqEX9K1x8bGEFQ8TNFGsOICrbm/hUJhVH+uvjhye72TrKJkE+GfQizAmtQjt11ltyy7YC15PcKAPQaYKu4+Ys7hpn+MLXY8WR+ALCuHfaDSVaUlypPMwSrf/RHg8ys/zY/YBcLoKS6rQ4Q==;5:vYgjx7mWcJc6/9A+p+JGZ8zvWzmd94ICJaxrEY9OEWeLuSdLri7SaQSzO5sB5MDbefX+5bQsXUgjBeUm3+q79jC6CnDQhA6Li7LKVqzPjDYJqCvPi/M4zvg/JVOvcHDJ6hInEqdvbmPwsiPO3yINl2eU0GiXkpAqC7E4HAxsV58=;7:wuoZdqaBpC6SVci/GqWz71WCn6UVMgShH3CcsWILq0iqiDAWyL5vJxd9xdo5nAm7OGBZwsHHJqaaEm4J0P0i2ujS7LsQ7L3RFkh07BF0/hp7LRMMP9R07rIkdVhP1LqoFpbiP6abIfMqRVu6pSbzoUNFHuW/F+IkpjSMwt8bPV6n69riaO5WYMI2HQQmuilHcnQvb6IGqEz2uENQEFUd2PxYPHn7dlmuudW/OyMQbeeuFpo720f7qZnrBtBO7WAq
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR12MB2687;20:vxXBnIyes4b0rtWC8wxHkCs59Dw6aBsudJIRpS1t7SyDSR5nrFkfrnxZfalO5tLvk+No5XJE7nKDV4mP1GtmNhpCX5PJceaifRoYSoskUNaOp/50ZnKISsSj0jipcUgxWX5ZwgTUcFKo/gP2QMdOX0GSGiDszUrSld/Z+YnEzhUgbxVhuijpQH33oEi19++YnkqE5HZ7L1q875Fi+aDe83y0G/mmaXirQYxdWbOWgECD7Mapdk+4lXuItkHgM+Un
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2018 01:29:59.4154 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88c02af3-d92b-43a5-6474-08d61205ee75
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2687
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Re-arrange the sme_encrypt_kernel() by moving the workarea map/unmap
logic in a separate static function. There are no logical changes in this
patch. The restructuring will allow us to expand the sme_encrypt_kernel
in future.

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
 arch/x86/mm/mem_encrypt_identity.c | 160 ++++++++++++++++++++++++-------------
 1 file changed, 104 insertions(+), 56 deletions(-)

diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index 7ae3686..92265d3 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -72,6 +72,22 @@ struct sme_populate_pgd_data {
 	unsigned long vaddr_end;
 };
 
+struct sme_workarea_data {
+	unsigned long kernel_start;
+	unsigned long kernel_end;
+	unsigned long kernel_len;
+
+	unsigned long initrd_start;
+	unsigned long initrd_end;
+	unsigned long initrd_len;
+
+	unsigned long workarea_start;
+	unsigned long workarea_end;
+	unsigned long workarea_len;
+
+	unsigned long decrypted_base;
+};
+
 static char sme_cmdline_arg[] __initdata = "mem_encrypt";
 static char sme_cmdline_on[]  __initdata = "on";
 static char sme_cmdline_off[] __initdata = "off";
@@ -266,19 +282,17 @@ static unsigned long __init sme_pgtable_calc(unsigned long len)
 	return entries + tables;
 }
 
-void __init sme_encrypt_kernel(struct boot_params *bp)
+static void __init build_workarea_map(struct boot_params *bp,
+				      struct sme_workarea_data *wa,
+				      struct sme_populate_pgd_data *ppd)
 {
 	unsigned long workarea_start, workarea_end, workarea_len;
 	unsigned long execute_start, execute_end, execute_len;
 	unsigned long kernel_start, kernel_end, kernel_len;
 	unsigned long initrd_start, initrd_end, initrd_len;
-	struct sme_populate_pgd_data ppd;
 	unsigned long pgtable_area_len;
 	unsigned long decrypted_base;
 
-	if (!sme_active())
-		return;
-
 	/*
 	 * Prepare for encrypting the kernel and initrd by building new
 	 * pagetables with the necessary attributes needed to encrypt the
@@ -358,17 +372,17 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
 	 * pagetables and when the new encrypted and decrypted kernel
 	 * mappings are populated.
 	 */
-	ppd.pgtable_area = (void *)execute_end;
+	ppd->pgtable_area = (void *)execute_end;
 
 	/*
 	 * Make sure the current pagetable structure has entries for
 	 * addressing the workarea.
 	 */
-	ppd.pgd = (pgd_t *)native_read_cr3_pa();
-	ppd.paddr = workarea_start;
-	ppd.vaddr = workarea_start;
-	ppd.vaddr_end = workarea_end;
-	sme_map_range_decrypted(&ppd);
+	ppd->pgd = (pgd_t *)native_read_cr3_pa();
+	ppd->paddr = workarea_start;
+	ppd->vaddr = workarea_start;
+	ppd->vaddr_end = workarea_end;
+	sme_map_range_decrypted(ppd);
 
 	/* Flush the TLB - no globals so cr3 is enough */
 	native_write_cr3(__native_read_cr3());
@@ -379,9 +393,9 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
 	 * then be populated with new PUDs and PMDs as the encrypted and
 	 * decrypted kernel mappings are created.
 	 */
-	ppd.pgd = ppd.pgtable_area;
-	memset(ppd.pgd, 0, sizeof(pgd_t) * PTRS_PER_PGD);
-	ppd.pgtable_area += sizeof(pgd_t) * PTRS_PER_PGD;
+	ppd->pgd = ppd->pgtable_area;
+	memset(ppd->pgd, 0, sizeof(pgd_t) * PTRS_PER_PGD);
+	ppd->pgtable_area += sizeof(pgd_t) * PTRS_PER_PGD;
 
 	/*
 	 * A different PGD index/entry must be used to get different
@@ -399,75 +413,109 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
 	decrypted_base <<= PGDIR_SHIFT;
 
 	/* Add encrypted kernel (identity) mappings */
-	ppd.paddr = kernel_start;
-	ppd.vaddr = kernel_start;
-	ppd.vaddr_end = kernel_end;
-	sme_map_range_encrypted(&ppd);
+	ppd->paddr = kernel_start;
+	ppd->vaddr = kernel_start;
+	ppd->vaddr_end = kernel_end;
+	sme_map_range_encrypted(ppd);
 
 	/* Add decrypted, write-protected kernel (non-identity) mappings */
-	ppd.paddr = kernel_start;
-	ppd.vaddr = kernel_start + decrypted_base;
-	ppd.vaddr_end = kernel_end + decrypted_base;
-	sme_map_range_decrypted_wp(&ppd);
+	ppd->paddr = kernel_start;
+	ppd->vaddr = kernel_start + decrypted_base;
+	ppd->vaddr_end = kernel_end + decrypted_base;
+	sme_map_range_decrypted_wp(ppd);
 
 	if (initrd_len) {
 		/* Add encrypted initrd (identity) mappings */
-		ppd.paddr = initrd_start;
-		ppd.vaddr = initrd_start;
-		ppd.vaddr_end = initrd_end;
-		sme_map_range_encrypted(&ppd);
+		ppd->paddr = initrd_start;
+		ppd->vaddr = initrd_start;
+		ppd->vaddr_end = initrd_end;
+		sme_map_range_encrypted(ppd);
 		/*
 		 * Add decrypted, write-protected initrd (non-identity) mappings
 		 */
-		ppd.paddr = initrd_start;
-		ppd.vaddr = initrd_start + decrypted_base;
-		ppd.vaddr_end = initrd_end + decrypted_base;
-		sme_map_range_decrypted_wp(&ppd);
+		ppd->paddr = initrd_start;
+		ppd->vaddr = initrd_start + decrypted_base;
+		ppd->vaddr_end = initrd_end + decrypted_base;
+		sme_map_range_decrypted_wp(ppd);
 	}
 
 	/* Add decrypted workarea mappings to both kernel mappings */
-	ppd.paddr = workarea_start;
-	ppd.vaddr = workarea_start;
-	ppd.vaddr_end = workarea_end;
-	sme_map_range_decrypted(&ppd);
+	ppd->paddr = workarea_start;
+	ppd->vaddr = workarea_start;
+	ppd->vaddr_end = workarea_end;
+	sme_map_range_decrypted(ppd);
 
-	ppd.paddr = workarea_start;
-	ppd.vaddr = workarea_start + decrypted_base;
-	ppd.vaddr_end = workarea_end + decrypted_base;
-	sme_map_range_decrypted(&ppd);
+	ppd->paddr = workarea_start;
+	ppd->vaddr = workarea_start + decrypted_base;
+	ppd->vaddr_end = workarea_end + decrypted_base;
+	sme_map_range_decrypted(ppd);
 
-	/* Perform the encryption */
-	sme_encrypt_execute(kernel_start, kernel_start + decrypted_base,
-			    kernel_len, workarea_start, (unsigned long)ppd.pgd);
+	wa->kernel_start = kernel_start;
+	wa->kernel_end = kernel_end;
+	wa->kernel_len = kernel_len;
 
-	if (initrd_len)
-		sme_encrypt_execute(initrd_start, initrd_start + decrypted_base,
-				    initrd_len, workarea_start,
-				    (unsigned long)ppd.pgd);
+	wa->initrd_start = initrd_start;
+	wa->initrd_end = initrd_end;
+	wa->initrd_len = initrd_len;
+
+	wa->workarea_start = workarea_start;
+	wa->workarea_end = workarea_end;
+	wa->workarea_len = workarea_len;
+
+	wa->decrypted_base = decrypted_base;
+}
 
+static void __init teardown_workarea_map(struct sme_workarea_data *wa,
+				         struct sme_populate_pgd_data *ppd)
+{
 	/*
 	 * At this point we are running encrypted.  Remove the mappings for
 	 * the decrypted areas - all that is needed for this is to remove
 	 * the PGD entry/entries.
 	 */
-	ppd.vaddr = kernel_start + decrypted_base;
-	ppd.vaddr_end = kernel_end + decrypted_base;
-	sme_clear_pgd(&ppd);
-
-	if (initrd_len) {
-		ppd.vaddr = initrd_start + decrypted_base;
-		ppd.vaddr_end = initrd_end + decrypted_base;
-		sme_clear_pgd(&ppd);
+	ppd->vaddr = wa->kernel_start + wa->decrypted_base;
+	ppd->vaddr_end = wa->kernel_end + wa->decrypted_base;
+	sme_clear_pgd(ppd);
+
+	if (wa->initrd_len) {
+		ppd->vaddr = wa->initrd_start + wa->decrypted_base;
+		ppd->vaddr_end = wa->initrd_end + wa->decrypted_base;
+		sme_clear_pgd(ppd);
 	}
 
-	ppd.vaddr = workarea_start + decrypted_base;
-	ppd.vaddr_end = workarea_end + decrypted_base;
-	sme_clear_pgd(&ppd);
+	ppd->vaddr = wa->workarea_start + wa->decrypted_base;
+	ppd->vaddr_end = wa->workarea_end + wa->decrypted_base;
+	sme_clear_pgd(ppd);
 
 	/* Flush the TLB - no globals so cr3 is enough */
 	native_write_cr3(__native_read_cr3());
 }
 
+void __init sme_encrypt_kernel(struct boot_params *bp)
+{
+	struct sme_populate_pgd_data ppd;
+	struct sme_workarea_data wa;
+
+	if (!sme_active())
+		return;
+
+	build_workarea_map(bp, &wa, &ppd);
+
+	/* When SEV is active, encrypt kernel and initrd */
+	sme_encrypt_execute(wa.kernel_start,
+			    wa.kernel_start + wa.decrypted_base,
+			    wa.kernel_len, wa.workarea_start,
+			    (unsigned long)ppd.pgd);
+
+	if (wa.initrd_len)
+		sme_encrypt_execute(wa.initrd_start,
+				    wa.initrd_start + wa.decrypted_base,
+				    wa.initrd_len, wa.workarea_start,
+				    (unsigned long)ppd.pgd);
+
+	teardown_workarea_map(&wa, &ppd);
+}
+
 void __init sme_enable(struct boot_params *bp)
 {
 	const char *cmdline_ptr, *cmdline_arg, *cmdline_on, *cmdline_off;
-- 
2.7.4

