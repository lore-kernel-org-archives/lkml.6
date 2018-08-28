Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83ADCC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 22:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B33E208A6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 22:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="L3u9tz6F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B33E208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbeH2CG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 22:06:56 -0400
Received: from mail-eopbgr720088.outbound.protection.outlook.com ([40.107.72.88]:47232
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727261AbeH2CGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 22:06:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=22cdJG5zL895cnj26ejpU8WVQBQQHhLP0FQR6QXm730=;
 b=L3u9tz6FbmLOolPVJh5xRaFlE/okQ+cFWxlN+cQKJonOOrrK70FtCdD0epBMPqIdGewKhKgUf6PRVtnUU3Jfe1kZ0TwSo2jgOr+Gll/CmCEOffv8Y5joKkMotcxQEXX2ujMuTnhaSpCE91yozU3vsppstlwKsBTO6M6YD4aFGyg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by
 DM6PR12MB2682.namprd12.prod.outlook.com (2603:10b6:5:4a::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.15; Tue, 28 Aug 2018 22:13:08 +0000
From:   Brijesh Singh <brijesh.singh@amd.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Brijesh Singh <brijesh.singh@amd.com>, stable@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH v2 1/3] x86/mm: Restructure sme_encrypt_kernel()
Date:   Tue, 28 Aug 2018 17:12:55 -0500
Message-Id: <1535494377-25600-2-git-send-email-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535494377-25600-1-git-send-email-brijesh.singh@amd.com>
References: <1535494377-25600-1-git-send-email-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: MWHPR19CA0010.namprd19.prod.outlook.com
 (2603:10b6:300:d4::20) To DM6PR12MB2682.namprd12.prod.outlook.com
 (2603:10b6:5:4a::31)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a7e6aed-64f2-4373-446d-08d60d3370fb
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB2682;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2682;3:GNLXPybGosJF2efH0+sqPqG7ee5589e1VoNiRH3+JpQuSfY0ZxC/A3gPd36hgRCZOyS939T2BI1OaBfsVdkebBSJnQN9IKteko2JWz8meXkakh+Qey/UJNXJY1jaMk1yUvyWta8U22sJOmvymycshweVBqeK9n1Fu4eLgFmjEIGTnJr31aDsYYh8qPhTaaNudeDf+OA/kYdWVkwwML81E7nH/XZJDH3X3SRBLMq4CP7unAXqA38jxsMoa8aZjSrQ;25:IgPnMhXLnW5vEHHO8m10RRRHPKaWm/9GVQgC1CXdzEr84IYX9yuQO+wX7eYsMrBMTuoagTasJo1/vfj0ckk0yQ71/4HGLLo98sgHShRGhFxygQMkacNTfjiD3FwJd1GD6z4yc7MA56dIb9fh5fJ7AlYLLo7GYdx/pGAR9f1y02iAfHQk+psRqy8yGi18vNasoq2epY7aZ0lmMi/6lx4Sa6fva8DpoEKMIhTKXfcDy4AIT+WOZwZU9P/7TuMZZx/LvCCKr2yEkdGBieHhQXDbRzN9RyZI/6EbXd76J5P/ha8Uo0znQWB4ovb1WB5cNxTZn013nKQI8Mp+9qwl+HBEbw==;31:98eanQHlyBhbwSiGZZhmMoOdmMmuT7jvcHIggTASXXVfBbHsX+4eeDYqqNsHSQZP47bvmIGj8Nq0NNSnaBH815ZAJmSjQTcd6LAyog4NohqBIyAgY65nORlAgEJTrchrQI3QqIRExtGp7ue3KEIQByr0jxN0+w3IGBkFjLu0zh0+AyOcu66KKE7dGVRpYKtGbYJKxQB48hJ/+omVv3b0p7FuFFyksw4n5SPBqGubgcc=
X-MS-TrafficTypeDiagnostic: DM6PR12MB2682:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2682;20:nyQBF8L3zotX0SgeVLKRMZkr5W6xR+khneFulOIY+KebRbYwZ9cUrnsGiAgF3S1pG3OV6nfeL0hWuTq6sCWbPB+L7MjIIEHj+MWWu38NAd8s/CjPDxoVYQUAuPyzAiOygpOipg40d1nBEFPgZRJfY5LFRVI+JFP/Ljq7fq9Fj+Ns6qGr/W6/oh0uZvcKzKfd6Kv1kqhgKLz0t1Mwtytp8dUUH7WvnBTseFnvO5l0RgxOFgOny1cInSQKDLWiIS/b49FVQ+606uh23erQex3M6jKuRIBxTQOirCv3x+QCDRbzz+qehmwale7J6CV3iAcC8HId+cPDgbve7QMjryxVA5/vKE8QJ0q179FZ34Fle7nOgJ0B5V4lcMuVu7RoSJZDcizKM0TG2TNWIJwzQ7LUA1CpS2MlllbFLX2XezWmL0fZC914esgTy1iq6fxg27HuMhLoG6mOsKf7LMJhB2PrKldprE5XKX6Y5k3CFqCwmir0TuTA8UkGptZL6raDeTFP;4:+07+62TbqXAnAUjyQgXv+5u5J9X/79+yE/jmTV08+VZDmFqvlJ/qFSubZqTJetnndCwl7h9eVon/5UUwsAw3qwm7vJf+hUfS7BAGeNBO9gPfypHSFICLFp2Rv8/yA1UNQML89uNcciuG5Wc30/QZZBNpgcRTSltDevYdIwDfGE7QWjaRZaVK/RopAK1RxHrtIppkzmmbo/SQU2TX0pd8ecGGVdy3pm0BSBtrVMdgNksLDZuYO9yN3D+AHIIVBeLdL2Bc+s3JgvpDxIBlDEiEtG+HiZt4rN3Raa6a68yHjkY/dk7ghlY+2lljqkhlJwcuH43b/3V3vVotRXwy3f4XQGUFWHUY02SZkPARyU95B4mcwgI0yYpkLxYEJBQTUWzP
X-Microsoft-Antispam-PRVS: <DM6PR12MB2682A67E06E0EB235A183C66E50A0@DM6PR12MB2682.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(767451399110)(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699016);SRVR:DM6PR12MB2682;BCL:0;PCL:0;RULEID:;SRVR:DM6PR12MB2682;
X-Forefront-PRVS: 077884B8B5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(39860400002)(346002)(366004)(199004)(189003)(186003)(50226002)(52116002)(7696005)(7416002)(4326008)(305945005)(7736002)(105586002)(8676002)(106356001)(478600001)(97736004)(23676004)(386003)(316002)(53416004)(16526019)(68736007)(25786009)(76176011)(26005)(54906003)(2870700001)(86362001)(66066001)(36756003)(47776003)(6116002)(3846002)(6666003)(5660300001)(2906002)(81166006)(11346002)(81156014)(956004)(50466002)(2616005)(14444005)(486006)(476003)(8936002)(44832011)(446003)(53936002)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2682;H:sbrijesh-desktop.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTZQUjEyTUIyNjgyOzIzOjVvakt6WVV2VUQvMldPKzRJTWU0MzVSa0Jp?=
 =?utf-8?B?bVBWY1ZGRkVyd2pWSFNPc3I1ZlQ2WkY1bytyS3g1NDI4Z3FyMFdJT2V6U0Vk?=
 =?utf-8?B?d08zQ1d2Z0FkdU1jSWlmeEU4dzZIcnB6REREUCt3VXQwb1VYRE8zcDJpZ3Jj?=
 =?utf-8?B?MG1odFhyQkgyMVJySUpCZDdLWXZFSmNlUjJiYU5RMzZNTEJMRVdJRThUbVZX?=
 =?utf-8?B?V1ljS1JlSlVrSldldWtaZlNLRjZUUTRkd3M2YUVLQng5Szl6T3pLdHV0WWYy?=
 =?utf-8?B?cDBIRnhpVm1RcDc3blRCWTVyYjBsMVpPemxxZk5rdHo4cjJvNkdseWxpYzZ4?=
 =?utf-8?B?eEw0QnZkUVhZbFdTOGpUL0ZKZzQ5cDdIOVRob1F1OWF1RnFVdTV3dWhIMHNw?=
 =?utf-8?B?cUpBejFwMjVFVytMbVdnZGErZTZ5MEVEZjkxbXQrYW5nWm5HbVUvVGJLbUor?=
 =?utf-8?B?QlU4NFZWV3NWOUpDRTNOYWg4TVVXYVZ6NHAzMUZocHpEUkRoWGxJMmZyRG1a?=
 =?utf-8?B?bGtrUTBrL2s3T3NNY3JYUkphT3RsOVFaL2lyTUh4bzZHKzhYZW96bUJjL0M4?=
 =?utf-8?B?Vys5NlNwZmkrRFNMWWJMZExDaFFOQUtCTEwwTTYvM0lZVElEU2JHYjVBWFN0?=
 =?utf-8?B?MlpQcWVMNjhQM1pTSkplYTd4N29BblNOL0VCazl2cVNiVUhoOXZJZWJOVG9k?=
 =?utf-8?B?RDd0ckNBRWpOeVFhUHhkb2xsb2UyWk9kcVZBdlI4SWk5blBiWHo1bDNoeTZ3?=
 =?utf-8?B?bEpob1dKbWh5NTBCRTR4R3N5cjZFdU92WWxXaTJjc0Y3a0p6Q3JDZVJvWUk5?=
 =?utf-8?B?dDJmaXUwaC85bHJ1TEN6NmZhQ3BzUVJmTkFBVTlBM0VGdkRpdEZITGFyRkNi?=
 =?utf-8?B?aExRK09iSTNDNWQrRVQzYnlweHR5MlBDOW5maFVGVzg5YmtuSEJ3YmNGQ2VU?=
 =?utf-8?B?bW1EaDhUTUMzTFR6TnJIVDVZZllLTE9QMkxpb2dLc0ZxbjhZSE1oRFZ5aHh0?=
 =?utf-8?B?NnhIQUh3NzE5OXJaYWFNOTFXUkg1TDVhWjB5SXBxNjdITkRWamtwcDJsbFhX?=
 =?utf-8?B?QnBIdmVRa3NqazFXeGNLNUxrQVUwRitxOEErZlltRDdhS0crZnYxRmZLV1hl?=
 =?utf-8?B?RmtIcGM0dFlLRzdYVzVHQ25OaGlHNk9vMWlCQXQ2YnZtRk9zeURiZkxSblNO?=
 =?utf-8?B?ZnZsaGMydXd3UndkaEg3U1NYbDdtbDBQVTdDbWFGYWUwY0FZa3huRENvRHVw?=
 =?utf-8?B?dzltRmdZRm1Ldk0xcDQ2WjdOZVMyRjMrR2VXWDEyeXhxSGY0eGtFdEdVeDVQ?=
 =?utf-8?B?KzF1b3FXWE03bDYrYXFvTCtpcGtVKzllUDljcHlPaXlwNDZnMHhiK2xQK0Jk?=
 =?utf-8?B?azJqNUFmWVdLZXdydldEUG9oMzJYcUhwbmZ1ZXYvalJ1cTArSmFrdUdQUWQ4?=
 =?utf-8?B?VTZiNVpQcnBnOHFDWHpUUUhhU3lXN29kSHEvRE1FN0lWTEgyeUZ0MUZCc2px?=
 =?utf-8?B?ZW1rUmoxNXZxTnZiVldHbzdVOGpEeCs0WkdoR2FhclR1MUk1QThCNXZLUDFp?=
 =?utf-8?B?R1ZWZVUycmdSNGN0MVB4TUs5UzUrMy94eHlIWkwwc0MzSndDYWxCSkxoOXdQ?=
 =?utf-8?Q?rA2j8qcMJjoQIYwIfyvD?=
X-Microsoft-Antispam-Message-Info: jhVFWJcvGMsMSSR/oHq+x1L5VQrtGkzpMXurOwPbR/HVAg2CztNNhQEW6Wk1R5mlH7bEkDlY+/xFPouHH0cFs8GVUOy4C7W++pFpMnsGcaTt1UmW6dQb3S9pokSywBDQ7WFMM1iQseOfRfsNiVoe7m9t3GJjsAMu5/TGjvx19a5ch8NTU2Th++KljnPJk8H2Tyqor5+J6k4tdfgLO8Z6m97OjrJtVEhPzkxdGKlQWwAJO7pcucPo3O6NGcYmviI+MeI7SFCu5a2OUr83Sqdamu4WHNdj1fl97/Ted9bRZbVga4HH9os3th0bcahQl3mIUKh+MoOCNZX5NcXUo9LehA0qR2MgjX95bb8QbUyjp+8=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2682;6:OWYABNPQc4U9nTRlHdvYS5y5yn4jRo2iyoUboGIVlH8j1efwC2ymERYIrhlEncC2GhVxpHXlg2wbR/mMSRRutrBMUGi9yFWejFVpSx8MxkEG35WIQbdiqhA/sXkkf565IpLCGw9/EryqNwnRscjU6Y+yVPxALXT95SKoJqEp00IxToYgYDd6+lWuS7rXj1sgI0feT38PcUQYJM4CHfBWnxpL6jtBiaopbZ4S+4FvA0DOAwhjjmFm2hwdpnOO/OA9a1r5GckgMPhz8/nUa9wfN+c5/eafKiM4m8B+Wp6yWRoxSdTfXw72mAsLHCKOZrGKuAeiEMZvnABxZyispFysWBOsNfmltnKcUtLOyakhFB4r9vB8QfLUl5pnPkolow9OXCPPS5OrNosLMnC3azv9T9kRjMBOoIuY4fvIl9TKSz5EyFfpIx7YinE8yFO+sN5Fbkm8AYF/+iBxZUge3WHdWQ==;5:CmBydy+4d3/yqygjZbY9Nt4MpVTLlIfUmes1czHwkfV7ACpERl2V0PvaShWllJxk93vs0l/p6ls+0SkUh+QWzZ4rdAzYEnAP8QT/mN1nMI36umIOv9xhLXgmL4djxX24MNOUdFC7QGxDPgsQFG8UVLCZSNOusSVmi3qjGRzCLhI=;7:/mVPbAtDpzYXCIEjO237IbxAMk5speozX+x4Jh2Nz8pQGuJJUIixGDmHNt3bPqr7ZrjlWdUP7raQKXlH7Q9pS36kNCfzXZEqlg/K0k/yiDtw9rfS9mx9DP4arhr9MOyM2MRdcdWBxFtUyBRpnAWqwxK6+8Y4JhU3XNXSRkhSfSiofaSI8UUA5o4xsb6w8nDpmrj8mBSDgy9GtA30mcEpFofF1Vwaa3AYG7aSzIMWaWYK6AnYTHoWqubuPX425llG
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2682;20:2mYjZYdP4UR2qLtApjWK9NwDHqXQOFrqJOXpgI9SWpn0deezTULSNqNOXMcmgSUdxV9TTAY4vuAv4CisMqTL3v/kZM1VBk+BafyLWmTHu88cze7LEAWwrczIFHqd8coze8KxK30U5/0UaF7W0H2KYTTcEeJdK4mD/IQmL5DIjayYw4CMBygqrBpj0NQwqdW4Pbd8+ArNEe5FbJNkTFS6PWYnICsfJvwuS9Qiwl0aQW8AfKs3JvaP5+v1svGYhiW9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2018 22:13:08.9043 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a7e6aed-64f2-4373-446d-08d60d3370fb
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2682
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Re-arrange the sme_encrypt_kernel() by moving the workarea map/unmap
logic in a separate static function. There are no logical changes in this
patch. The restructuring will allow us to expand the sme_encrypt_kernel
in future.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Cc: stable@vger.kernel.org
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
index 7ae3686..bf6097e 100644
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
 
+static void __init remove_workarea_map(struct sme_workarea_data *wa,
+				       struct sme_populate_pgd_data *ppd)
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
+	remove_workarea_map(&wa, &ppd);
+}
+
 void __init sme_enable(struct boot_params *bp)
 {
 	const char *cmdline_ptr, *cmdline_arg, *cmdline_on, *cmdline_off;
-- 
2.7.4

