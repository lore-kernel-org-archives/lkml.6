Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C70C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 11:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDD6B20652
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 11:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ht0d8DOv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDD6B20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728246AbeIFQTB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 12:19:01 -0400
Received: from mail-bn3nam01on0077.outbound.protection.outlook.com ([104.47.33.77]:63622
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727851AbeIFQSy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 12:18:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IJyRe1yaUhlJxuOtYFyawnByYZXj5R61zk1BGm3kzY4=;
 b=ht0d8DOvhsxpqj+LG6YPFeGa3Q8RUVMc3K2HRn+ZQgY3/tnTjf5cBtClqA0jNPyxZwww1jJm8WwvJCOoWAOa9b5D/GfEikkSpUIpYbuBE3lwkExNv2kT8ChdTCvehRvi8zhKdDMdCb3epmmxmq1gRPhd5e08SYpOJpgZ6LKCAK4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by
 BN7PR12MB2675.namprd12.prod.outlook.com (2603:10b6:408:29::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.18; Thu, 6 Sep 2018 11:43:35 +0000
From:   Brijesh Singh <brijesh.singh@amd.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH v5 5/5] x86/kvm: Avoid dynamic allocation of pvclock data when SEV is active
Date:   Thu,  6 Sep 2018 06:43:02 -0500
Message-Id: <1536234182-2809-6-git-send-email-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: ac01797c-670c-4041-d8d2-08d613edfbaa
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN7PR12MB2675;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR12MB2675;3:dUeP52KiRvod9Hucas4LHifegeWrNJXKczApFdE33y0ajXDm09Mzzu0gdOMNWDIf4f/Uzc3K1RLS2autgLPvb8MJHYAAtmt2iR6mD0GAEOyyX3+yQwzf7NxRF3saNqZRYPtrqmF+sJ2DBIGGKJ4ZXOhHdYTas3TB5ZvQ9zGZ/ZSRWgL680lN7WRAt0eSPtgkbsNC0jnJ7qcmDKUsueZZ8Mv7i4urEa6wfDOFgKNodWunq7Xszk1y7hmVoviJHGve;25:LjjNOTloGm03WDokzE51VmFhNYKAORXmEhEpnIAA3FFOIG7zH+VqXWmktX0y1Qr7m4yb62REzgrGGQDu0T+uSlZcH7toUOl6OTllQu54gT92vqItFrh6D29ipkOjeHjBFKznbR92gSS1jlJ061/wdc7/Pl6bd5HaI5Se2pSPqVQuT/sr5MSfv5qxl+AgK2J0YfpIro052yh2hKp6ceYZyNaRQstOhf5CXzZaEE/ub5nrtccuy5lGSkeuNK5wMj9JbspwoaII41LIuPxxW5CWghUNzVeIwemdEgu20pE0BzIJ+1aW1F//0cOtUmeJCizIDW5ta74FQk996wYNvBG//Q==;31:KB1peQnXYuWpsNNHLR9zPlKwRw4Qc//IC61W8YCYTEN34CRUXskxVhJjH9yttk4Au9YXB/HE9IqE3+wn2Zp+L/xqpaWPDCAnJTbQijqQhx3bYFWYBElhNrTMvHcjrZ+yP8aVkTylYPIn89wgNJTwwzHyuJCVSOhDtQxr1BUEimNeXyBj3HGR7A6rxDFzck+gfWHf2fVy4zCpNKSEv1SEIhejHI89qZOmgAm1zKYlp54=
X-MS-TrafficTypeDiagnostic: BN7PR12MB2675:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR12MB2675;20:50Xke1OMS7Vw7CYS2DXflC+Ej2Cc+wZ+B1Sqdnv8R6kZ/RLgmEUcWBS7UcIYceefWPLPc4yUDw95UD34qDOiU2lFHLzQ+nbGlv6SFt2MBryBxXnIa4u/uAVkIAwJBj3ATIAGjJvSc1QgzrxXlgDWcRZxKgDJpXnMxuXzVRcw/spvrBdK6qhwXIrovIWq4Jfm/Ur+viwFJzIwpvaStDGJtccR95XEvfCSHan58Ebxt5h1o1tBKZrvnteHMqHGc/BsPeRyWAHMXPFb2Qo6vuunu6lHlx7PXrIZa3WaYwOWsWiAmzonvuR5wm6FaBHJNLpH/+QMNJbCm9sDjxGdv49Vut3sI9OHJL85j4OgzegI+1nHWSeNNu6I8aTHYq8zVqCDQvqSBJHinscw9z7+2ml57E0CkKMTBgujuMVyEKcCsKmF1LtwaXMZZVmPcAxBbpmisgMNIL67itAJ8Ae+NH1i1epYkpxJazXa/8tZVCtrXXD2T4Fct/TPjxTj5nTAhLZe;4:ZWRCElpoIPex/w/fLxjfx/4eSC04NYpZGUyD/hJ1Vh0vThsG1GpCc8vu8550lhwnMMVh1VIFhRfs5nq2HAi1mb+J1PbDt/ydVkPJn5/ymf1qhzxKOPZpKc+MOsJd3Eg8g8ARR2/YhbAuzS+5sUZRlofVJjJgdR/mmVlIRam/gVYoAzrMJ+spuKsh+0DRH41P/ZBl9M3g2zNuP+ub2/v7EGCKxh3uk/QzQXk2DBEbCK5XN8yILVpU1PeYmUOurQAvG1wcQ2leJojAeCuYF0ROlKRFWWmwonIhJ/SZCBeH0DOCXFgakCsb5rlHEwcjGh/A1orO51VmICMxN6yTaaBoxtVZeE3vnSSzYpl9qiWUCC9lesUS5holCRhyswRLDxWp
X-Microsoft-Antispam-PRVS: <BN7PR12MB26759F9B7888EA4DB006DEA8E5010@BN7PR12MB2675.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(767451399110)(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699016);SRVR:BN7PR12MB2675;BCL:0;PCL:0;RULEID:;SRVR:BN7PR12MB2675;
X-Forefront-PRVS: 0787459938
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(376002)(366004)(346002)(136003)(39860400002)(189003)(199004)(25786009)(47776003)(86362001)(68736007)(66066001)(7736002)(6486002)(53416004)(106356001)(6666003)(5660300001)(3846002)(305945005)(4326008)(6116002)(36756003)(105586002)(26005)(7696005)(50466002)(52116002)(8676002)(11346002)(50226002)(956004)(446003)(2616005)(53936002)(2870700001)(97736004)(23676004)(478600001)(316002)(76176011)(186003)(16526019)(54906003)(81156014)(81166006)(2906002)(44832011)(476003)(386003)(8936002)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR12MB2675;H:sbrijesh-desktop.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjdQUjEyTUIyNjc1OzIzOmY2QzZBRVl0SStUVFFZd1Z3NmJndUp3V0I2?=
 =?utf-8?B?WXhnSGUveTdDY2E3NHFRUXhweTFaTVF1MnRNaUd0TldGK2V6azE3eXpNWWwr?=
 =?utf-8?B?YnhSZSsvY2krM01JRkY3a3hOSkJ1OEpUSDc0aHRxQmlLamxyMHdpN1BvREc5?=
 =?utf-8?B?a1BKTEEveUFRTXI5SVg2UklUZ0U3bklTSHRoZ2dwblVRYlJPRUVsQnNUeDVp?=
 =?utf-8?B?eU9CWUxFWWRBQ3hUVzlWVEQ0WGtCN3RGSWVWZENJQVptWHduVTkrQyt6U0hN?=
 =?utf-8?B?YWZOdU5UTHA0NzIrMmp5aUJDL0pmMm9FOC9QRmp1ZUVOUXJ5Z2t0TXVrYXNq?=
 =?utf-8?B?MjFTbWI0bHdTd0xQSmxKS01mM2Q2NHEyV1ZGOG5WK1B2RVMvc052eTcraDBM?=
 =?utf-8?B?VzRaRTZjdEZiTkZKYjl0TDAydlduMGJOZjVqblZKNm5DUkF6VjR4QmE1SGpi?=
 =?utf-8?B?MWxYK093T0tESHlIWDhsazg4NXh4bjZBZkxOQ1dHaUNMUVdEbWRhMVI5aVZQ?=
 =?utf-8?B?UVUvMFBPZ2xmdjl5U0VoRGY5LzRCVCtWVlo5cG43bzBWWWNNbmZNcmNnTXBJ?=
 =?utf-8?B?NzROeDR6MTJuL0RVVUpVZUhObm5pNUpKdHR2UDVjVkhxaFhxRUl2cDZSNVRL?=
 =?utf-8?B?cVcxYUtMRExpcnRCbjA1eTZSWTRKNDVod09aSVlCZEVJRWlqNlE3dEZ3OVFy?=
 =?utf-8?B?VUxaOEJFM04ybmtoa2haSFlZL0hXNHdUZDFwalRSOUpWYkRwY0ZvczJ1Y05P?=
 =?utf-8?B?M3BacWlqdHhjeVhSNk83cEd0d1gxNDNFeFpaWklUUllmR2swdzJVYWU0VEhO?=
 =?utf-8?B?OXJaTFczdGRsSmU2aVpVYmh1YjEzYWlkclVqY2tJRElxUUczRmcwS1dPaVRa?=
 =?utf-8?B?MHR3VE81RWVjVGhiamJDMFJNVnhvRDl0U21QOGw4aDRwdG90SThEREVna0lt?=
 =?utf-8?B?QzVCcG9yTm5PTDF2VWw0bEdrbzZrOVFnZkpjVkFrZmR4a2dKZm01SDllVTRm?=
 =?utf-8?B?RWR3bE9DVVArbUo4cVRoWHFKWVgwNnFKeHRZcGp2RFdJY1hHbXFSdmc3MlQr?=
 =?utf-8?B?S3FJQnEvN3lSN3AyT1dydUZDTFdSTzZSdUp3ZnVIQWZodDNidk1FVHltaUE2?=
 =?utf-8?B?NDRoOXErQUhtaE9NUlBYM3VpekltWkpMSU16OWdXbGtqSVE1blFLS0NwS2xq?=
 =?utf-8?B?UDlhOE9qbzVDaGY1bTFYYkpDV0FsdmtOZXkrc0dLRHdSYlJwWUU2L1JRUzA4?=
 =?utf-8?B?RWFUYmRkNG5TaGV0Tml2UFpIU3Q0dFFyR3hFSFpZUFhGNUdwejNqUnc5Yy9i?=
 =?utf-8?B?c2ZCamwyaXp6ckVpV2p6MWFCcnF1cHJjYXk3M1ZLSVNzdXZrTzlITGdKd0hY?=
 =?utf-8?B?UVRKNUNYZGNBT1oxMG55ZjVJenM2eXIxTUVOQUh1VVJmMzc0WkxZMHFrYkpy?=
 =?utf-8?B?aEp0K1lMMFFhcG11d2RPS2RwUzlNRGVkdnBiS1IvS1QrTGZvSXN3ZzZCL1da?=
 =?utf-8?B?aHlEMVBtNy9OM0lYZFZFR2w4YVhMWXFIN2VISGdsemk0R2FHNUVUcTVpRjFj?=
 =?utf-8?Q?UGO8XnhU1DEjv5LH4nBm31fgajliQ0mFUwUmdGbFwC+0=3D?=
X-Microsoft-Antispam-Message-Info: hQ0oZ5XfgEBbxGa+lOOeRf0QweUNK8Uqk7rlVW+pyfG5cy/FxQhGDddWuyLD+YSGQjByIG6ZlB28zHJXxouX/BaXEArfBBv1KJEjt2lY4uJeE7M4ijRtPBO3BGrUC1chrYpSDpw0hE3m5E5ULVUcvxxWusw7hdfvAWRuMIDm7dhr5LJZQbMTkofGYruGuVuF2ZpRDSMK3VC5MXDCbKUgChR/bcRf/fmECofVpIQnOigh83nq0gy/xiIrqrPIEgZtLw24YRZYI0HLs9jfXKcpeS0t8fQCOrS7A4WefSTGpMZouwDpj9VYzzuKcSSzM022KjMDLc2pRvdBocmRMZMaWhKkhWwOXumBSP7S292q+8w=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR12MB2675;6:2wbrT53AqX94X8YZ4g9R9svETkMw9imAD6IYc4bhUA3/RpoWBQnCDwMj5CMDxcnNIV9hR1odgHd5NyUpG7dQT96+TQWV6tWMILal672ptNUp/FrmgSk2Er/Wcy+zrwrgCGJBtmzrQdNRyeFxACUB6dmYkB+C/w+lWsZWzN6B2ingCMWzCpgwbShtYoU9+nRVQVutEptBx9Ok2wmzGcMukw7qjSwIM/ivazq1g3/NAeBlsrkcsvCxOPqZYLtUJaqnQmwJHL1dGUC7mtY+Z0Mp4msmz9KCdt6NUcNbSs9BTnkMjOOEQAzhU1WQVcvqP1gh9Px/RZigkF7DlO07CV3XhM9L+PmN+4lvbwvkbuVXHMzooSU9+Ehw8xCuOyJdIrwLfDbmMq+Um6qiJiQ5PB9KYPUnlGWnsmXvgO9hmeWEngF0vXeUF4wmiAdTeN0t1qP+mD1j8+jap+a5eHoJ8c6N1g==;5:bUF0c/b7SRUg1QeDlt8TgggMhOMC3FF+b3+ym7uG0Uj6PpJlLqyuPqPvgDAy0U0mkFmqN+S5iNn52KlRU3RQwu3+R6Azu2i8B3elH+4sTUeUcPXQdAr6SRLqQI0EA91TNGQJbnT8pIb4emUtBSMH9T4J4cqyl7NzV3Ur7US0RY8=;7:vhr3IIUhRH/HCEtQJ5b+LltlBtmTZC1rvcndgG6zg5g/ec7iPoMCTGQEgI7gBkLtuBSuDbR4fVoJ4m8vo2PARrWBE4drxq6j59RNvopnBHx5ondXDbMMCuGZZJqxPBCaObYtVhjKDktuVwUdny6Y65aZ1zheQbiEAYkAmezqMpCwMxnxE73dRDyu7+EIJ+vF1DECHe2wc+ep32DTTZ8ihrgEdiSuidV7XV+oHt/Wi4iJT6mBDnFpRYvL+hMZ6TGX
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN7PR12MB2675;20:CC7M1f1SPQiTw98uyBl9d3PGut+REQDywEs7XgTIdDmG9F+2KEgnhnGKFNCfpmeMWE6EZ1lQFfI4FJJNl8djUnG7yVHnn/O1nam5a+AzcmG/xRzNZswSFfAhRK+wYkLgwUNU1/g2XoO9K5Es/r60a6vFRfL0pwWcFdNmC5MxoO6EF2ImPcFc/ee0nFBHMMyAf4zbVk35zx3qxDUSn/AirQfRR+H3XmTBAXU91o+IXXAj+jlIIROWjf1VWvvKr/wE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2018 11:43:35.7302 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac01797c-670c-4041-d8d2-08d613edfbaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2675
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the per-cpu pvclock data is allocated dynamically when
cpu > HVC_BOOT_ARRAY_SIZE. The physical address of this variable is
shared between the guest and the hypervisor hence it must be mapped as
unencrypted (ie. C=0) when SEV is active.

When SEV is active, we will be wasting fairly sizeable amount of memory
since each CPU will be doing a separate 4k allocation so that it can clear
C-bit. Let's define few extra static page sized array of pvclock data.
In the preparatory stage of CPU hotplug, use the element of this static
array to avoid the dynamic allocation. This array will be put in
the .data..decrypted section so that its mapped with C=0 during the boot.

In non-SEV case, this static page will unused and free'd by the
free_decrypted_mem().

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Suggested-by: Sean Christopherson <sean.j.christopherson@intel.com>
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
 arch/x86/include/asm/mem_encrypt.h |  4 ++++
 arch/x86/kernel/kvmclock.c         | 22 +++++++++++++++++++---
 arch/x86/kernel/vmlinux.lds.S      |  3 +++
 arch/x86/mm/init.c                 |  3 +++
 arch/x86/mm/mem_encrypt.c          | 10 ++++++++++
 5 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index 802b2eb..aa204af 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -48,11 +48,13 @@ int __init early_set_memory_encrypted(unsigned long vaddr, unsigned long size);
 
 /* Architecture __weak replacement functions */
 void __init mem_encrypt_init(void);
+void __init free_decrypted_mem(void);
 
 bool sme_active(void);
 bool sev_active(void);
 
 #define __decrypted __attribute__((__section__(".data..decrypted")))
+#define __decrypted_hvclock __attribute__((__section__(".data..decrypted_hvclock")))
 
 #else	/* !CONFIG_AMD_MEM_ENCRYPT */
 
@@ -80,6 +82,7 @@ static inline int __init
 early_set_memory_encrypted(unsigned long vaddr, unsigned long size) { return 0; }
 
 #define __decrypted
+#define __decrypted_hvclock
 
 #endif	/* CONFIG_AMD_MEM_ENCRYPT */
 
@@ -93,6 +96,7 @@ early_set_memory_encrypted(unsigned long vaddr, unsigned long size) { return 0;
 #define __sme_pa_nodebug(x)	(__pa_nodebug(x) | sme_me_mask)
 
 extern char __start_data_decrypted[], __end_data_decrypted[];
+extern char __start_data_decrypted_hvclock[];
 
 #endif	/* __ASSEMBLY__ */
 
diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 376fd3a..5b88773 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -65,6 +65,13 @@ static struct pvclock_vsyscall_time_info
 static struct pvclock_wall_clock wall_clock __decrypted;
 static DEFINE_PER_CPU(struct pvclock_vsyscall_time_info *, hv_clock_per_cpu);
 
+
+/* This should cover upto 512 VCPUS (first 64 are covered by hv_clock_boot[]). */
+#define HVC_DECRYPTED_ARRAY_SIZE \
+	((PAGE_SIZE * 7)  / sizeof(struct pvclock_vsyscall_time_info))
+static struct pvclock_vsyscall_time_info
+			hv_clock_dec[HVC_DECRYPTED_ARRAY_SIZE] __decrypted_hvclock;
+
 static inline struct pvclock_vcpu_time_info *this_cpu_pvti(void)
 {
 	return &this_cpu_read(hv_clock_per_cpu)->pvti;
@@ -267,10 +274,19 @@ static int kvmclock_setup_percpu(unsigned int cpu)
 		return 0;
 
 	/* Use the static page for the first CPUs, allocate otherwise */
-	if (cpu < HVC_BOOT_ARRAY_SIZE)
+	if (cpu < HVC_BOOT_ARRAY_SIZE) {
 		p = &hv_clock_boot[cpu];
-	else
-		p = kzalloc(sizeof(*p), GFP_KERNEL);
+	} else {
+		/*
+		 * When SEV is active, use the static pages from
+		 * .data..decrypted_hvclock section. The pages are already
+		 * mapped with C=0.
+		 */
+		if (sev_active())
+			p = &hv_clock_dec[cpu - HVC_BOOT_ARRAY_SIZE];
+		else
+			p = kzalloc(sizeof(*p), GFP_KERNEL);
+	}
 
 	per_cpu(hv_clock_per_cpu, cpu) = p;
 	return p ? 0 : -ENOMEM;
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 78d3169..1aec291 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -101,6 +101,9 @@ PHDRS {
 	. = ALIGN(PMD_SIZE);					\
 	__start_data_decrypted = .;				\
 	*(.data..decrypted);					\
+	. = ALIGN(PAGE_SIZE);					\
+	__start_data_decrypted_hvclock = .;			\
+	*(.data..decrypted_hvclock);				\
 	. = ALIGN(PMD_SIZE);					\
 	__end_data_decrypted = .;				\
 
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 7a8fc26..052b279 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -815,9 +815,12 @@ void free_kernel_image_pages(void *begin, void *end)
 		set_memory_np_noalias(begin_ul, len_pages);
 }
 
+void __weak free_decrypted_mem(void) { }
+
 void __ref free_initmem(void)
 {
 	e820__reallocate_tables();
+	free_decrypted_mem();
 
 	free_kernel_image_pages(&__init_begin, &__init_end);
 }
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index b2de398..865b1ad 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -348,6 +348,16 @@ bool sev_active(void)
 EXPORT_SYMBOL(sev_active);
 
 /* Architecture __weak replacement functions */
+void __init free_decrypted_mem(void)
+{
+	if (mem_encrypt_active())
+		return;
+
+	free_init_pages("unused decrypted",
+			(unsigned long)__start_data_decrypted_hvclock,
+			(unsigned long)__end_data_decrypted);
+}
+
 void __init mem_encrypt_init(void)
 {
 	if (!sme_me_mask)
-- 
2.7.4

