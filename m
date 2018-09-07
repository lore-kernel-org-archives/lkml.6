Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A589FC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3349420652
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gWV/n8yo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3349420652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbeIGWju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 18:39:50 -0400
Received: from mail-eopbgr680053.outbound.protection.outlook.com ([40.107.68.53]:59456
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726151AbeIGWjt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 18:39:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K2txtTs/dKgYSLSmfQ6fmp9U7m+Xsj1BFCJl0Pp9LE0=;
 b=gWV/n8yofpw0YE4WFP8KXOb7gnY+zHbnF9yZ1N4yCfCcKuHAllVXwNHqGEF+4baakPQRYVzPrXp6vH/F2X9uYp22gGUVLtSKW5v4zneWq73u7FKV7XQomQVrw3jXeWUper9f9U2xpsgn2daT4gxoneY5UfCFaPMnm1EXjMrxs7I=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by
 DM6PR12MB2684.namprd12.prod.outlook.com (2603:10b6:5:4a::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.16; Fri, 7 Sep 2018 17:57:39 +0000
From:   Brijesh Singh <brijesh.singh@amd.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH v6 1/5] x86/mm: Restructure sme_encrypt_kernel()
Date:   Fri,  7 Sep 2018 12:57:26 -0500
Message-Id: <1536343050-18532-2-git-send-email-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536343050-18532-1-git-send-email-brijesh.singh@amd.com>
References: <1536343050-18532-1-git-send-email-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN4PR0401CA0004.namprd04.prod.outlook.com
 (2603:10b6:803:21::14) To DM6PR12MB2684.namprd12.prod.outlook.com
 (2603:10b6:5:4a::33)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41bf32c4-4343-421c-b1ac-08d614eb6744
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB2684;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2684;3:UUE1+mRQwhDpT7lC068qRvcxh00nQgbALdwl58SXuglBY1h5wJ5bS6SDhFl2n/U8GHSJI6fu3nXogjY4efylcB1bJbLoE+KHScXlztbTufjB1+CbngtBNsAaraOvhuGjxu33d9ckz6TcHMXiDnDJqZ/hWAqrJuZN2QW2X9yUbKe2FGWWmldLko9EBWmouTn/Fa8P52M14i+flSxeyNT/oacNlt3g/4w8EM18+DY2a5NqSfUH9EyAvcU4J7Sy2Lc0;25:3A/cZ7pM03T+f3jI4WAhiq68bm4JkFSzE4LDyxp7NmScMqd2MwKBnQskTWBYuSLbx9Y2+W4uqhNp2UpXmaWotARPsCi48f0rGjFW0xcSkZZl4Eg+wA/fMZzPXSJ45k1ebg1VIA01vYmm9g1/9rAMD6TjvOLshBRjWHOsfD0/uIbxdiUcZoSA4YZki37zgUQXOuq/lCbzmrOat1g/crCDbDkLtJMpZ0k5gBBh9d/72dqwuQoBViEKln4m/OcYHFOqIjyKnPBzysPstpTs3mTcQ3m8nVf6UYo82+ib1cQzb7innXkp7FpfA7pTSyKEwOtI8rIbjRglcC9QdPysKUNm2g==;31:JVcRvG9Iehd7jBIUYcB4rf3DEJ304Uhars/us5b7YN5XjjGKJnPoKrJDmhrhd4UDjkH8scPLy2kL0YvD7EAV6Yw+Xu25gFAlJvOemgUaYAJJLm8MZzDoL5iP/8yCXvNEwOu9cyZ8uiiHtwg83j/23MkjAt6hp2xShoPfEc2SzYFVCtp5aT7ReFT2UHtRhGdQVKYrdlrQAfAnflvdstxu7IjEPQ90CTiZfUf4d06tY2A=
X-MS-TrafficTypeDiagnostic: DM6PR12MB2684:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2684;20:oRCO3Mbeqv4A100NkKcA/ye6THjX0dSuIuJRWnfJ9nxBSnU40pjncXSDeal0+w9/zxqqQ3oLd3H8gva9/BhnCzB3Y5Mllsh+xQsnfGHu/WjfXVaBYSFjpceVxxijmDIJjiOP+v41Yf/nqjx3GT/aqyfjda8yTRg2W+Ru5UZCcTxSAIWfpTGBoOpDLrq/KF1Dt8ebPwtn4nByK9njyoNo9YTOpAbbtVgKLDblVZdHKVzDFN9SEX/Dx9Lhbuz5EmK3ro6nZVKFj9e1Se8FzWdpJOgthKIq/RU9Hgz06K0Fmx0aVrN82fJ6NwI071klbOTGEki7SrJV9ItkEAzb3x8HAukQPnSVMXGMUMEZ9zXYUnNIOh6EogAJh4GxnBP2eJ1q23Wi1Dg6iaxSKjxl81lXDmr94MtTsAJ+2aZo5Q87qT77eS7pnuZReN+oUyhdbWdDKspMjfAsUI6tv0TP0+//hexdOrUXhBwAe3HCmzaWqXZazwaFvcT+BCix396Q/hBd;4:92cB3ImCBT7oejBYYSU73wdCpBSQCKTS7DSXuHvM0ChnHllJ94H86ykBAZnYcfn0KulnJXmwbOrnmo/Iu4ziR3yihURndR+4apnOEhHpUBtue3HLLcc/5NlhNxJMf17azduaQKg1YMaIEcaKy7RE82KzmObTbyf5UhaEqv8QSzKfUkuRs4uoQZRzB1eXle32SlkBAbuEq4QBWdxPlKC1/JfPDPoYyQP4hsmjYCQN1VV5/cWYxtfrubmC75zZOimE3zret1RrXa7GzyCmGNKsgBymUwd8UOuA+Yn06FWh3BatMBB9iGGwhqPy4ub2TJkU6PLCTxxUj/0HaxWCx/Sf8K7KV/FsfwhofRUJQxVA50+XGTsoR/JgQ0xDMempF8Y1
X-Microsoft-Antispam-PRVS: <DM6PR12MB26843406B41012AC4B0DA713E5000@DM6PR12MB2684.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(767451399110)(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699050);SRVR:DM6PR12MB2684;BCL:0;PCL:0;RULEID:;SRVR:DM6PR12MB2684;
X-Forefront-PRVS: 07880C4932
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(39860400002)(396003)(136003)(189003)(199004)(14444005)(8936002)(81156014)(81166006)(446003)(476003)(2616005)(956004)(86362001)(11346002)(36756003)(486006)(2870700001)(44832011)(2906002)(47776003)(25786009)(50226002)(66066001)(4326008)(6116002)(97736004)(6666003)(7736002)(105586002)(316002)(54906003)(106356001)(76176011)(3846002)(23676004)(7696005)(8676002)(305945005)(52116002)(16526019)(386003)(186003)(68736007)(6486002)(26005)(5660300001)(50466002)(53936002)(478600001)(53416004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2684;H:sbrijesh-desktop.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTZQUjEyTUIyNjg0OzIzOkJTbk04eVNqL3lqYnpHSUpZWFlFQjNkNmJv?=
 =?utf-8?B?TUxMNWxZa0EvYVlqU3RQTEpGdXo4TnJTeTFFTEVZQzg0RzJnQ01mZGNZcnZM?=
 =?utf-8?B?eW91TzFNY2d1elVKZW1wSGlTZGlVaDlRWk1CeDgxMzdGVHVNWmN4NUdtVnFr?=
 =?utf-8?B?UzFmamd6Sys4SGlUdFppU21MQWtJRzRvZDRXdS9QQXN0YzJ3bUpZbTNaQnVk?=
 =?utf-8?B?WFMvTS9Ea2ZqVEZnaGN3RHhxcTdtQTljN2x0WEl3TjFteTA0ZWJuQ2FCK3Y5?=
 =?utf-8?B?ZGIrdVJ2RVFhWjhxYmQ3dUdyZkN6NzY2Vk9JYXNxa0JON2QzUEV6NWFHOXUx?=
 =?utf-8?B?K3piblhuZ0tVMm5WUERJNlRKOUdUSkU5dC9iODJVdW5XZzZPTXNKSmZIbkU5?=
 =?utf-8?B?ZWM2OFEyQUU5L3lnN1VBcm80a3E3VUtsRmR6aEZvQTRSb3NVWXFzMnp3cEVN?=
 =?utf-8?B?MTBnWUVjcnFCZVRZYVZDcGVtQnFPUklXaUp0UnBxMGdpZkJrYWNQbEhiUXo1?=
 =?utf-8?B?U0FxMVRmRlhobUVXRlh1WmM5ajR5UVJuNW5rckJ3L2NNUWRxRWwxODdUUTc2?=
 =?utf-8?B?Q3QvdlM0WHhIUmo3RW9FVGFHeTBHR2xKdUtzZDFrTVRXaVN0SVpESGYvc0Vk?=
 =?utf-8?B?WDA2cEdEMFpUMVFuRklMbTRLeTg0RlFuM3dwNnJSZjJqLzZlREJZLzZ1My9P?=
 =?utf-8?B?bFNyNFNPbHUxZFJWWG85NTBMVnZINXdDMDN1UURtSTY1MU5kQzB1TlVtYTRq?=
 =?utf-8?B?L3NWemF6Ym1mam50T3dpOUw2T0ZRVVlwa3lzQWF5ZndFK29uak83UGUyU0pw?=
 =?utf-8?B?QncvWlgva29oZjlyVXdpb3ZUOWlHdjRnVzdDUzJWWk13RWpiQXF4U3ArQmE0?=
 =?utf-8?B?UzVGSGxsOHJtMzloRTg5di8yRHd3WHdiTmJpMTY5bGJGT2FlVWZ5KzlLYWJR?=
 =?utf-8?B?N3VRaU1YY0pKaGdtc2xqMVprZ3d0Tmppektaa0J3UjhreEJEaVAzZmptQUtI?=
 =?utf-8?B?dGkzMklCREpHbVYzZy94MzRDc0JDUzVwZnA0YUdWY1RsbjJZNERTSFVxcnZV?=
 =?utf-8?B?MldwR1BFcng2VzhBWkV4TUpTazUxWDRUZnNOSXV1bElUQ2VwMXFqNEQ3Nmpm?=
 =?utf-8?B?KzhOK3dEWlBiMjJObkQvanZxOXcxd2dlaGIzeis1Ylh5NWNTZ3ZxVzNrY0dI?=
 =?utf-8?B?NE1mcTdYUWJhRitibDBiWVRtWDJtTjE3R3BTRTIwdVdwSTFKWE5LZmt0N1BR?=
 =?utf-8?B?azJlREVCQ2h4TUFHNFIxK1pmTlQ2ME9DeTJ1K2pSUUpnNGdqb0Zob2l6Yzhl?=
 =?utf-8?B?YjluVEJucHh1aFU5MTBEUXBHTlV6ZmRySnZIYkhwVDJhOUlzTmVFK0Q5STZQ?=
 =?utf-8?B?WURrSkROUm11b2FnSmhQdEZ0QVg5SjdQU25mTlNXVE1Od09TZG84K016MDMy?=
 =?utf-8?B?dC9Db1JQb0JPdm00S1ZtQk5nTERjOC9XSU9TL1dnOVRsUzdQb1RWN0VNdDJh?=
 =?utf-8?B?V0FjTjBNTkdyY0dXVEx1YU8rbW50MGg5RGFrcWYxUWoyTEZDbDFacitUUWF5?=
 =?utf-8?B?MmlpUGlMUEdJTVozT20ybTgzZHBxNUxQbk5qOC9wKzd0aHp5ZFc4N2JpZTAz?=
 =?utf-8?Q?P9U182v3qUe+GNkkmOM2?=
X-Microsoft-Antispam-Message-Info: 7PRUMk9MI2HiI6y9mYots0omUS0pDL/BDNOwH7ixP7243+rFYm/uDPqsSfw8yYXVcZhh21TXfcxu39wk3uuwl1SsEPAGE0hAiJeJR7KC/AQ7uuOj1vJ39gR4hnI0G9jXDEP7DRb5yg9ZlEzDSbgNkf0yX3l8GxOI79VO8F+taU4UZ1NtF5Unzztk/6NiYk6vb+W1Bh3Zt2BJoEw4ErWBjEX6wGt26no5PbtfBM1YUJZ6jNywePJf05Qb9QJupkVDMeXnoEeO7vwMG+i22enjXcI7qdulwE2+1RoQVboMzuV7HrcFZuE+PSbH6bO+YPqmIUvmxouX1vcDWAFMiDie9KL/OSSUVXKghSHEUXSOwsg=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2684;6:OZFnr9V4V+2VVC5ZiOU1fAcNmjSDJb2z7CITXKV2XDeUxBEPfoJKlrKJe0AeztmGj0UhwwuoiQu/3x9sGFaikQCYKcFlqNqJsdcequLFMddZPpl7nForx22TS9PFBJD1rs9cO+ivzXFVMjb82LsS7YbsLVs+4CRV3b9em3LkFymfjjYr/nzUaFcMAwlp2Sw6aW4XfMLBZ1H6YQZOOO/CtklKaGpWYD9GFjh+y2r6qaRFE1TilTiSF7j8n2yuzTRV6Ia3ZeCMtyBpk8jebtVxWnEQ5Xr6wsIcyGSnmfL9PkHZj5cmFAkPLsn42nY+u0lEYK0R0dBNSEHEl+FQPNU/3KEJjgQ9H3YVmaAFPXhEBQSEWIHWC2Tc+PEXeuzKqHfEJp4qlfQsZ5nMvTqrlWGCALq10/UEyF/EwAOxwgg36sGW40Lqz8XxBwQKv2h8lg8WP42BUzONICX0vwi/EAO6kA==;5:XHp2MQ5SW0McfAioTb/BIRip/RRbrmg/nAthH4bDaiU4cGRYRW8OukJz6a2a+ilInW+PZkfIs5wgVbF7S0M0yc7ipek15iyil3rhDCMuEcbOc6El7pOI0jIREY8f7UBgrSJK3+F3QVoK8guNm0E/et86ttJax+COK9mN66RdRiE=;7:wbnERhJGarVmsHVH4tgUi01IhdP0TzVhGzRrflpWNCJU+e2MMipm5QfPcbmDQ3wgNxst1rhza3Duam/1rfSI5IHioOam6FAYDP710/tSZoeOsHdhAD8Dfnb0Ec+e9V/FUjfw/SwRz3fNe1n5vmk7V/b6ujfUbrFSjEnttgVnF05z4THd/ygjNyeEf3VjJ5NWp7Wl0Fk26ZLDb+ppDEfoIOs6+oKz0N+roSVpOQzMvlP+exAzZtnED8KoDubalA2S
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2684;20:1w6Go6bUsy3DFseGiDlodWGF4D2Wrd3rIuniYRtpTUWGFtMl6DFVkLYH6XD6DfPKUsq8/vzej86qJmqfIRHQWzrptqsHRsW9ZxSYHVueGDBzXhLsE8zgMBEHs2Z5U0GvjzHzDVMxniBiwBt8vpB5bklCXqkiJhXNHc52o23zjt69NESwaBrytuLunxkuMxuyyoMB8+ncZdjLEsMjmBIvcs5APqfoczgx0iLAvRowAR10szc5BgTna+sj9/My4gI6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2018 17:57:39.5344 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41bf32c4-4343-421c-b1ac-08d614eb6744
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2684
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

