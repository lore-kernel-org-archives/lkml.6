Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F10FC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 11:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9E1320652
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 11:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XhoByKwM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9E1320652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbeIFQSq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 12:18:46 -0400
Received: from mail-bn3nam01on0067.outbound.protection.outlook.com ([104.47.33.67]:46448
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727728AbeIFQSp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 12:18:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BdJUFBsYLNgYsE/wjTdOS5mKAPWVjyMJBQGIgs0NlnI=;
 b=XhoByKwM8QeFjQAjEkUdhh6mj3JR+4nlvZddACW2opAbOxqA7I4dAg3UgCRg7pSoeow5M8XvAEZlkw8ctwI9nOYsA9lWZEE1KA1Ch0uAB41ozUHXkhsRnRy7grh+3UuCQNX03+p2BWO7TOaoPSMsdlsxag1qByOAGylHdJOqbdA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by
 BN7PR12MB2675.namprd12.prod.outlook.com (2603:10b6:408:29::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.18; Thu, 6 Sep 2018 11:43:30 +0000
From:   Brijesh Singh <brijesh.singh@amd.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH v5 2/5] x86/mm: fix sme_populate_pgd() to update page flags
Date:   Thu,  6 Sep 2018 06:42:59 -0500
Message-Id: <1536234182-2809-3-git-send-email-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 27ac7bb2-5019-45bd-5c9e-08d613edf887
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN7PR12MB2675;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR12MB2675;3:gCaHFB8LkhXvFmB9W/WanrKpydGFT2lg76RkDDr7F1WRc31JwAHsYtiZS1ZrN62HaXXugvmVPWiR8ymb9s65X22pNz7MPAZgLVpsFny1nHLhnuhDDJA6qviBA8cHVICMOfn3Hu5u6bKW1zdp4m+58tp3rcaRC5KIWQK6OKLo5bk10QOmHm10LPQ6iFUKNOQdLXn5S69jJUg407GRW06WU0Z8HsLlel/fDADCDYoi9jTHR1ymNzjGzVeQRP3UHVp+;25:Ah1Th40zeBFKWk9wXvWo9z1g/UFoK3ZV+R3RJrtjI+nUlw9O03Sh7ptKtMTvfJGH6qGVRl3I0+vnTYPHrfuZM/rcz3+fjm2RwfAMl8zCOGB/CYJiXcJJKcQyrFCFfZZzaLP/gb1RVNA1+ULGRv0X64c+nGNMZ8fB/OWk/S2gqUCARj2rem9yQvKV/ranIkC2OeK/qsetO4btuDAMLFANq+YXFtBGEBqXUUqLFG/OX5ipnpeHd7o7IkVbLwK5V3GWBVIVQA1efd+nEnTe9fVIFp+sD+cI3fdDaoW8X9Y+DNfTBDXdGbIgQnVndU3YfTUfbP1NDQvphiSCNaKygwWCyQ==;31:cUWCMiSz7rYgrhJm1PDEbDeIRTqAgNpjQ9G0Kljmf/S9HRakiz+TLQ+Fsxd0W7jamIXPT37iyKiBkzgR9jTDYVU81eJURlRVCzjRHHxp/hI2yzpeQTTrC0jsPQxuN2ZYjlwTEsAmm4W4P2I64HXp2qtvDtFCpXooGK+i0Ge0pwBj7AfkI7TYA0GVr/UWYgLglqIIqewxQr0qpNB7I4v7z39VO1snBMw3RM8kGLbD3tc=
X-MS-TrafficTypeDiagnostic: BN7PR12MB2675:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR12MB2675;20:Dysphu6JhiopVZW5GDbnmIIKmgXD03fT4GGlFszT44wue0xm9MiGD2UnE+L+XEXQirZKWd+mktpA25PP3B4gX32YfXYb79ytfm3MQOEqLoRlOSu31WN57hgmBD0kH/2VER3sbDYbYRn4iROuLG6snLUofBSlkhJNYW3Q/b8tc5WQK6HlKs2n3f6SBlVIU3Lu3Z17J1orxgux85nW0Xiil/B8lUhrNUCtDbkzUA0fkem8K0z4+IcmaTcvZqsmaUPwO6ZeuRB8LS+o6p6oSMVHLsRcj80DhXRmMTZf0nhNNOKUqHK4XDQ0FtwofTKI1xOQzMHDd9ljdLIwM89hq/ivnryuh1R+9hdNTMCyrZk/AIp6GG51k5MVeJU8eHIIfGwCAmAnpoyY4ytlbUJQ4XSYbUecYjwdvbQulggyl68BwNtpwK9t9SSeqgkZE14Xxe83xwhBG4MXtS3EBAPCKeenhv+jvOOvhSeL1TcLwPPgjlw7O74/ncuJKSwqprxGNnTt;4:8fUTXKjPgspIZFdSb4oW8hMY+mATTfnB1vfiDweE49J+Cfj4UBri+YeIptieSzMSbTbmv4MpHurJ4HIxDcR5Nhn45NFMGQ0NLNJLZEEdozCuSZvopgmqVkMhCLZPPWPuh2hb3jgtoR9zpGNbDocYLUB17RAZ6U+4Am05CqqyZUqompgXerwN93GPm/WrTU4Vr2CVnRrZVPDuMovPh5i5RvTEKr7XSl5ajqunkfMMXazVFU1nq/9xnI48Droz3wrBmVIJ5Y0omwpkHu2vukL5GKzBA44PXr/JWDCxp6FKQu7QhaNBGlRq0VckAf8s5xwDkNrEyU+z5oJlSrxo8LRcopG7bBYiw3zNF8XRMOj4pJ6Waj5Uos7qs/XKA4milpgG
X-Microsoft-Antispam-PRVS: <BN7PR12MB2675E34E7CD5A9F0D585C9B6E5010@BN7PR12MB2675.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(767451399110)(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699016);SRVR:BN7PR12MB2675;BCL:0;PCL:0;RULEID:;SRVR:BN7PR12MB2675;
X-Forefront-PRVS: 0787459938
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(376002)(366004)(346002)(136003)(39860400002)(189003)(199004)(25786009)(47776003)(86362001)(14444005)(68736007)(66066001)(7736002)(6486002)(53416004)(106356001)(6666003)(5660300001)(3846002)(305945005)(4326008)(6116002)(36756003)(105586002)(26005)(7696005)(50466002)(52116002)(8676002)(11346002)(50226002)(956004)(446003)(2616005)(53936002)(2870700001)(97736004)(23676004)(478600001)(316002)(76176011)(186003)(16526019)(54906003)(81156014)(81166006)(2906002)(44832011)(476003)(15650500001)(386003)(8936002)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR12MB2675;H:sbrijesh-desktop.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjdQUjEyTUIyNjc1OzIzOloxSnE3ZDh0bVVmQkNSRkZFSDQ4UzA1Zi8w?=
 =?utf-8?B?ZHlXcC9rNVFtYldyMkVoeGtXUVVYMksyNUh1VkdUOWpQcWQwV28vRWVvRk5z?=
 =?utf-8?B?K3dtYldMdmpOSVMya3JObnlQWmlwMVFZbXh6ckdLMGV5L3RSVXFiZjVsUUlw?=
 =?utf-8?B?N3Rqdm5DMlVmYjdMaEZuQ0ZOb0R4MjZ0SFArdWlmeXE2L1ZQZ1pTL0dpUy9p?=
 =?utf-8?B?Nmp0dkxDSlV5WEVkZUhhQzhrSjJqUmFEQXFrMUhiZndOVE1LbVFNSG9qSklM?=
 =?utf-8?B?WmFTOE5MRjhVcFFDYlZVNzJXUTM2bG5OQzkzZzFoNGxZL1ZoeHRjSlJpMXhq?=
 =?utf-8?B?YUt2WC9rdzl4d2t2aGlXY3Uwa21BM2NranFrWWVOSkl5N1daK09rdUMyZWlL?=
 =?utf-8?B?MFZmeU9QcHQ3QVhNTldzQmh4eEFnY3N2a2tMcCtDUWtaSFlKT2Eyb1dhTnRM?=
 =?utf-8?B?cXZHdkNOajVPaFFCeXdxblBPbW5kWm16b29aT2J6NHd1NnJCM0VtRy9kdWt6?=
 =?utf-8?B?TkZSRUFXemlTN3pVOHNOTGxUODlSVWFkKzJrcm15d3RnZWxPZnExUHE4MUVh?=
 =?utf-8?B?Z2Q1QVhSQllTcW5iNzYwUUtXSWcvUUY2VlpRSnZqdHNjdmsrVW1KbUVpWGFT?=
 =?utf-8?B?dXlpdkN1bmdzVDkyNU1pMFlsMWVIaVFPNmRzLysvcllBTjhHclRScmNGa2ph?=
 =?utf-8?B?bldpeFFMQUhNSUJONjIrSVVHT2xPUGs2S0p6aXNtb0IxY2ZDcUJESFRnRGVM?=
 =?utf-8?B?TERkY1U2dkpxSHgzVFhjN3M2RjJSMW5GNkkwbUpsYjVDMWZOMG5nMmZvWC9Y?=
 =?utf-8?B?c3JmY0t0R1dxdEdaczFVNEhoSzJqODBqWUgzTWlGVHpmYWxPQUthRWI3TEYy?=
 =?utf-8?B?UWsydVRHK2VDR3ZsZXFvNm8ySXFta3VjZkZUWkEvK1RZaWNFVGFNaGFjZXQy?=
 =?utf-8?B?ZWNTQ0RqYmQvOXVPZEYvb3VmbDY3aGZlcXVEUy9la1I0QUxNTk5KMlNiamVW?=
 =?utf-8?B?RDZlZ3g5ZXphUVhSV3g1RkJMdVJSaDUySW1PK0RyeU85eTQxbEFFS0ZGc2Jr?=
 =?utf-8?B?TjEyRVBiNXVubXA5Y2hkNGdCZFpRWkZqdENQTm15MEFvQXZIbTdlL0ExNVNt?=
 =?utf-8?B?Qno2RiswdFF3KzY4K0FQZHNoQ2lOQVJrYitKczJ1VnhwT2wyWlVWdmhNRVVG?=
 =?utf-8?B?ZWkraXZWaDRJOFA0YnlxTkhIaHhaRDMzVlYvWG1ldEpMMnNzTlA5R0ZGZjVK?=
 =?utf-8?B?WWVtN0F0bXlaMGRIbmlVcmgyR2Z4UDIreWpTeUd3d2QvYTNoQ2o5UTU5UzQx?=
 =?utf-8?B?Rm5HaUFSM3F0VzhlTUorSHR6ZjNjV2FrSm1XTE1HRERLd1hwSGNsckdFMmg0?=
 =?utf-8?B?VDdXNVJ0VEc5TUR1RjYrTk1kbkF4dFZtZ1FCeXVyd3FEMFZDREQxNlpkMUJs?=
 =?utf-8?B?RzFHa0NVMXhCVVJQYXJIMUtqcW1VUWY2MlYxVVE1Qk5WM21ZM3NGdnVUTUx5?=
 =?utf-8?B?eUlnYzQ5VVZJSVJTOHN2S2xqWmtzcVU1S2w1M2ZvdmJnWW9zcC9zMzF6ZHRQ?=
 =?utf-8?B?QldTS3VoZ25zNWdmMW14NldiM0M4YzBPcUwyd1BFTjdkeC80aWhuQ1pvRzRI?=
 =?utf-8?B?Wi85b3NSTWU2a0VRcUFNR0N4VGZxUHpSY1psa243UzAxVGdWaFQ0RlJnPT0=?=
X-Microsoft-Antispam-Message-Info: Nv9SClGfHVtb1HFiuOzhZSwDZ5MwtEQ4BzRFWSxBDdFr9nibCjHFHrU7TR+DunHYl9fE0kPlLZLYGtKu+8OBK2fBubDqkjwICJ5pdgmnqjJ3ibyzD/nr0Asc4Eh0tLdw9UqlnGJPfuM7Jd1SgYyjC0DleUxlZ9Z1xk0mPMsUtou7UR0XubYCE/f7uVQN//TguYXC4vTRLuPcYIsiTyBdY76S5wHJpQdK8SZ6c+SlDiOiv2tv6pEHlVs+NNqwTo2Yk1Qa7jVTd91W0DhdMsCXMWTcIyTuSEh751geEGctbn9gIMspbRC2EWYiePxe4uiJSFdyfjvqEX4NdjbWCUy9LmmiEsH99Z7vt9WLCOnCjYE=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR12MB2675;6:s6itTV6gnPe6IZqbB9PNUnTHrToQWEFSHSxZJmACSJwj2dUDbSwb38E0I/Q9UUIZ/Yft2ZruD1uOluT2bKfVu1PNnxX/G07lgQfibQy6odyXTmhUMeyTgDe2KpDR5IiXpoBLu+IODzXf07PjayzJM7efM61ELHxF8S2bphChby68EZ7ZMvutUp5jy1XoYOn5JpoTzRN7jql7KSDViXudk0tlf1zABHmVwCYgGH9+0HadIFtKi3+gccQrM3vuxTjpD/TIabesYcVQ+nvoxGNCLzCI9obfRZzh4kw0mVhqugLalTujkJMBTsCQR2uyC8z6JGI3ZrqNenbdjxE4UJg5dzevfqg5w7+vHX/T636XYOH/ZiWUVcq7kcqp3MhnDxc4NB6K477v8BESnFBz9QeN9rMuP4R4kz6Gnu49RtrLT67jRiM/y2UWXXtKa8/uawdlIRu9DNrs5rhXTlkAmlv0uQ==;5:nbo34QS7ljZQ3iDCyspnPpOv4ZRVBMoJe5ze49IDouTjeliMHBl+qGJNjI3iTHBO4HWKw06KwwKA/GvEsaOoQIJVajCPuwnpgxyLRlVI8EhSHuYwGBdvOmbi1SidDWpy1gA/niyUtTB6n3u8lKSmMbRUp0J39g+H4YBSy+6Ug90=;7:pTZJpUW1AVTRqGqwMy/i9nG5ZASuFcGe+Gn/IzaWlsorpT3d/0mh4QUuom+p9jjGci4oeW1l288rYl5IsM2Amf48iFb9PXrJqMHtu15rM197PoiZChgOJQqn6qihPgJhq4ZfFJLPqJZZmIveFg6U9x3s5aK2nMjt/GOdY4gmK1Mq5X4ek4aQns0+SE8fGWMBY8h/PwHMbyePTVdnYBjjPYx/bTISUxA4WKD4cqxO4lvfNmw+bZugH9rc12uWhoik
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN7PR12MB2675;20:9z0pnxNvzLUHBIB4NZ0a2GluCSuH5XQxukqRZGYEUgQykSZfnnnwLvGlOuhdaEfr2zEU33P+rB5L4QULP56nHgi2rVK2A8+BRY6CRXPHNmUbp2rVvw/w2sVweQTcrmX7HIG9D8SjB9KQ7mMmy4Q6INUjfPHO5ePmfkyd3BDGKV58n6G392/4lifW70uQPiGmFcW4HymZNElxICKE+TLgOmQOR6y0PQoJG5w0B045IqbdJRqF2sSVjcOay7uTS3n5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2018 11:43:30.4488 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27ac7bb2-5019-45bd-5c9e-08d613edf887
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2675
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

