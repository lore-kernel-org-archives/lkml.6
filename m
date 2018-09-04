Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2267C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 01:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57E3A20658
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 01:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="T8WR2Vke"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57E3A20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbeIDF4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 01:56:39 -0400
Received: from mail-bl2nam02on0089.outbound.protection.outlook.com ([104.47.38.89]:51709
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725827AbeIDF4i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 01:56:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x2L/HsnOQVaK2AxkFR+UNLTEx2FwZWXLvgCxaD4p7iI=;
 b=T8WR2VkehWpUvopZcR7ipXAf4Vufk5YEkPg+BWXU6cIz4/lieP1USAQeIkG+0+nj25SEhOtEf44TQmd8xnQKWFi13XrFYKixNLgadoXytPnwy1v90AjMBdcW3p7nuQfJd4xtxmeoT6vk3Zpzs0En4rxc7tNG4OXfdzCtPiZ1NVA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by
 SN6PR12MB2687.namprd12.prod.outlook.com (2603:10b6:805:6f::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.18; Tue, 4 Sep 2018 01:29:58 +0000
From:   Brijesh Singh <brijesh.singh@amd.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH v4 0/4] x86: Fix SEV guest regression
Date:   Mon,  3 Sep 2018 20:29:38 -0500
Message-Id: <1536024582-25700-1-git-send-email-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: BN6PR20CA0066.namprd20.prod.outlook.com
 (2603:10b6:404:151::28) To SN6PR12MB2687.namprd12.prod.outlook.com
 (2603:10b6:805:6f::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 255c5457-24c2-425a-94d5-08d61205eda3
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR12MB2687;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR12MB2687;3:YNgpLVvxG3N9qWku7++N4ZpmK4AQKMJhPQRuaNSR5AIreRjL5GuovCOXR+cK2rNGi/kz4pGVmsB7yirpfgMvKUGHBXh3ylt0vo27EGvBMRo5nZ3XitULB6V9OyBXBf6TzifzYLxM3WJunaWn19/VMj0vHk1pgKwKcLuUlmSz3RSLQtMGj3uPIzhiBb2xkj7Tkzi2U/0dpaoO7z6ByY1oNxvhA7d6QM4VOCRvRmMJIb6KIczTpTDZ7Ahd152BKseM;25:4fWLTIVfqd4YgwdPkkvvM9S24qBqzt85ob7eiizLIFB323prEve1GkzT2rje1IPC+a22iGH9JEyLiSgiATUXMqXG/+JwxAwjVtyXWUVY/KXCNdzEX/LPcSfk4pJsabWRROUi9FdGNoZ1+sJm4X5/OIB9ytN0BO3j0cyWsKU+8SQuTN0pySap3bTnF6HbF860D+pcWmzXr5GiokfzhQJi2PmI1PYoHz4K8FhpVa7MOa0cejJ9vCyDd7Ukpf8BU3l98S+DVc6zYq4DE+v5UaNNrsqCRNFvDp7asAToGAzTAhOGYR775YwA7xzYMbEe0PzYA1Fc/bIapDXOKc97sgkWbw==;31:XE+aELUbRgLHUBFajmHFxC0qNmFz4KZIxfaJcQ5bl0Wj/GyuEqP4/acX45eLAVzi9edEcaQaIAtof6QICv+hBcEJg3YXDrJDozoUS/+EPhn28oigRfQ2jVrL7NEN0Nea2/idmcg0+AkASCA0tTVeSe5oIJ+UJ0UusFlHLLGjGe/kC4MxU1lumU1obgeLiLIqkU/Ev3CNMrypP4+d0jKsZlJa+M5ssfk6EPYFqhhW3aU=
X-MS-TrafficTypeDiagnostic: SN6PR12MB2687:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR12MB2687;20:fLQOIlHO2dBRyGiibXpdq0uJuekfNC4ZuHPqmMsmFEjsl1MgG3abiOWYbuxrKJjJbxc2nOOnaFHSQOk/gcv6EBF5Y6A12ivz9eziN9O8VcvUBjbDKtgrBcNeybUWlO7982adhuJl3/MB3hy9UuFDKzxxcvzkAtaXC9O+2Pya3ChKOFXf/OR29h50UDb6Re5RK8d0HocHFi373ASFPmusR93vYC3QcDIkTMsY00QPSm0/IK0sBnxfUTfdqBBW4LZTkEa+ymlDkvph56WYTeznCueP33fIPAH5i2/3AokwGnhI1ULC88kWNl4UyBep80rQ/pByPEvxFI8HppBClwUzmF+pewCP057YiX8S4al5tTk+M2dV4EUPumhmCU2GSyUMM8UEKz88RNCTKFyxIOXE+eOJOFCzaKxUMVuwmlgb3POyBnramktQzSIGU10lwuUTnTJ1XiViLW36f8h6+BwUrXRoCrXlkI5oU3kIJz92F2RyIbZKUBAOWWTKvNRpeDjK;4:8Zqh9THc+gbca2O/kv5E/sXRxUWd5q33MOjfEPJNlZd1zZQJs4X0Nq9JDGNNlL5F53Dfbr39xE0gATe8qBMxy9Iutfu6JA5GdY6zEk4l+xBiS1wlPb9AmhYCCO7tqnQhwiV0MVx1l84zUf+eybWmraWMn4u/uMq5+Bl4LpKv3FrgUQdIpDuCnkxK/Q7AZhdcBYIHl7tlAU8wfNharpz5RGn/lmPsQsuixuObgP4nUd0PNG29Dmad139gBJPSadKHfmP82UjspuAbS2Pn802aIGv7DXZAA7882MWwbk4bDJShWA9/W6JGhRqWEKQ07LA1WFwzMEJTXoXkn4ijJy6FUaLzI4Ca/Ru1XrEs7plzBtDTOhpkiJaz+vJfXbUknC1f
X-Microsoft-Antispam-PRVS: <SN6PR12MB2687B7BA3F03EBFEA2F11FE1E5030@SN6PR12MB2687.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(84791874153150)(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699016);SRVR:SN6PR12MB2687;BCL:0;PCL:0;RULEID:;SRVR:SN6PR12MB2687;
X-Forefront-PRVS: 0785459C39
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39860400002)(136003)(376002)(346002)(199004)(189003)(14444005)(6116002)(105586002)(7696005)(47776003)(23676004)(66066001)(68736007)(6306002)(52116002)(2870700001)(53936002)(53416004)(2906002)(316002)(36756003)(3846002)(97736004)(6486002)(50226002)(4326008)(25786009)(54906003)(106356001)(81166006)(81156014)(8936002)(478600001)(2616005)(6666003)(50466002)(86362001)(8676002)(44832011)(5660300001)(186003)(7736002)(305945005)(16526019)(966005)(386003)(486006)(476003)(26005)(956004);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2687;H:sbrijesh-desktop.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjZQUjEyTUIyNjg3OzIzOngxcjhaNG1ibzAreUtHczJjc1ZJVFZtOWJ1?=
 =?utf-8?B?OWhzTzNoNjgrMXhpNlJuVzRJMWlqMHNpdWZXMzFRVEt4QUIwNCt6WUdSLzNN?=
 =?utf-8?B?Z2Z5OWFpUnFmZEtPVWQxRWpqalF6ZHRydTFHUFVxU0t3R1FKbEJ5enJxZG1t?=
 =?utf-8?B?UjJjQTY2RGYwM1hDYmx5a2NZNFRUZjlaaVJSanB6UlJzdWdHTTAwTzRTWDBO?=
 =?utf-8?B?TVZGQ0liL3pOVGZFVkdhQjUxL0F0WUgvV0JqeW9tUE53bnE1NFNkK2tMZjA5?=
 =?utf-8?B?bUdkcmNFc3FMeGk5Y0Z1SDBodEJEUEtpdy9lOXpVMzBqRU50ZmZpZWl6aXg0?=
 =?utf-8?B?ZE9FZkUwZnVCWTdDZWpWYkRZQkFSdHRHNm1tZzFsMUlZVkgwRnlkQllDRjUy?=
 =?utf-8?B?UkU1TTZ0VWpxak5zRjBGbklZditjNWhHV1k2bE5HY3VTSlNXNHYySVJEK21r?=
 =?utf-8?B?bi82ZE8xV3pQQ1hWSnJ6UW1obUhTUHZ0dDBVV0x4aUFqTmZBWUY3QlR6clpz?=
 =?utf-8?B?bFI2ekZjeEg4K1dyb2pxUnpFcW9ZRGdnbUZLWWQzZkZJaTBhSHNJYm1pOFV2?=
 =?utf-8?B?TG5iOW41WnRJWWNhaFF0THpkdjk0am1ZOXphSXRNb3FhdEJMSkhBR09BaDRU?=
 =?utf-8?B?cG82VEtZdUJLclcvT0dPVjQrckZqd0NTc3AxemhFMVlIcmpGV2cxdkZqd3hl?=
 =?utf-8?B?cWxadHplNVpUMDVFYkVMb2d6aGo0QWdneFl3V21XbmluYVVVb0NHc0NsNGw2?=
 =?utf-8?B?N0Uybm1LcXd1MjZGMXI4OE9OZzBQZ1owRllmR2hwMEdlblRibmpkZThzZjVr?=
 =?utf-8?B?TVUxajhYdWEydkZTc2lmRmNlaDhuZXZoeE9PeDN3cld4dHpvQzF4SnFTajZx?=
 =?utf-8?B?c1VoRndPTzBRRzhqdXFrcjU0OWtWQ0pyOFFPL05BRmEyRFZLQytiT21Zd21X?=
 =?utf-8?B?NUV5cW05VGFmRW1Ia2ZhL2YwYWtMWEk0SGUzUTJBVU56QXhFWVRibnJrYlVl?=
 =?utf-8?B?SExwUWNqRDNQUDg2STJ2dGpLOVN6R1dHcjhrdU9yRFR0TXlqVzNaZ2VVeUJR?=
 =?utf-8?B?OFpPcTFKaGZlSmxVYjJTVjZXdjJNY3EvTkQ2VFgvTHNqY0M1eFhrTjg0NGVS?=
 =?utf-8?B?TDVIZEFQbDZPY3dxUGl3M0VjS1IyN05yKzlldmdpT0Noekg5VTJiclgzWG5h?=
 =?utf-8?B?NGNwYm9xSXJiSmZjMVp4L2N6blFIbHlMODdienRYSUdJY2dzSWMzdS9SM3p3?=
 =?utf-8?B?NEtQeGMzemc4c1RUMW5JTm5Na25uaUZpcGl2MTBwVmRRTUU1N1NtZ2lDNXND?=
 =?utf-8?B?ck4rVTIwd3RYZmk3TVBYM1I0N3VpcDFBN243RlF6Y3BMYThmVnJjVGtlcGRn?=
 =?utf-8?B?dWZHZmh1Y2JrQm42L0tabktXNXJSM25mQXB4MUkvcFh5OXh0UzI2cld3dEc4?=
 =?utf-8?B?WGplQkUxMlZKVFFTSkxKNEFlSTBLUjRqTFc5ZEtLZnF2NUJtNzZ4YkRnYnAr?=
 =?utf-8?B?RVBra0RweU5nVEdMUUZMZHhNMHFBYm1RQzdzZXY5MVA3eTkxK0l3WFV2emhK?=
 =?utf-8?Q?zbxVPPJ+5gs8h2poTffRZN9Pus3ZVYQ5TZUbGVl32dH4=3D?=
X-Microsoft-Antispam-Message-Info: TWCOBof1sioDKHQrCK29Bll2UPxT++/7spUw4c716ezEiDdAu1pDt9556rAlS/8pKHv7jBemqIvPkx6V/JThpG8JpRKxPAuHKoKru6gi2lnjb6v7UV/Eg9VKpBjbJdUYl3nzsFdce1H366QuArr9QHYhlqNXkmudQOjL2omy22AwdAYSRXVHT04FsZ5fVJzsQ7jUuKHM8MSCtqJJQHTGRGPD1nzYjhKQsUgcYh5orDjX+i9hmt7ojWQrj2R0GxQt08lzCzoz7lVGTAW4JkJ8nj+zZZIgkVCOR/OmoyLNm1+J3i4G3AcwvLiM2QO19eUzi3m4BoVBzVu5I0WzWjGhhqsYRKfpI0RpA40e//O63tc=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR12MB2687;6:nmfrzxejyMETNGZZR2ql+/6B8EEIMrWXymNfVG1XJrsAGCZB7VE1O4+meVaYWhVvlRCfc55xMSG4Pma7kQ9xL0FoIsY1JdKrHVVsYg7agkQHkg2RTOLXRqs72vAmP01AmguFc/En6swuyUsrFtrD8esg0nEeea6Ha5gVStz01Lo2mULM2e+fCncrTB1D/2M1qIAFXvC5HKyBdn5pdKa9pbscDhSvteEK3+HL9eTIeZeUC+ieivKjJ8nkNXX2OiHQnme0UY2BLlWDwqTfVSfhU7D/59spATFnN6+Exs+O2lJCioW6Z0Zqh9H+SmxMi8dOFgV4Ye5+MyhuHPmyMHs8D5wmZd62ZjsIzZ8n85gFo83dGUfYGgtXBgjTIVq4mR2ZUNrWZ8rguVs33xYuBJZUK6+wOncxjqNYEkAgbi+kmiUXmiMYCRTNIu65/Lap8l2QAaFIjs4PfgJHM/cbj3Biag==;5:OetKwf1hIAF0TvUZjj2M0lp/vyaYR04Eg/7YOD5VouPGSS68aupGwP2rCic6L2Xmg3LERrMIjaEBVyTJjdIAotmPApGCowqzzNa5Popp6+ZgNj/SZxc2IfWruY3m8XsmZYW1iVJicNrUkqN/dT4dyS1VUXMGfHnmJy3p1L/EN3A=;7:6jmurzpDBBEuf0/DBu3apdBgn6VDGzbqOBPFGkozwptv/a2hmCHT/2eYbgyAfIFAPiC8MBeKYVvFQMnWVVsVZEP+mdgUInzmnmNTQLF6J+lekin1TIJ+rCamOEQwo/k5fvv+SilcgvNBmsbf/pbZvpQYq71hIFmhxw70i/2Xhu3q7w6Uloc7/UO92qT3lT//gz67Z/nONyyTY82Q+GKnZYV1Z2OYg8pfrxvBdn8StONBwg3g783jOj3+IH5MFE8V
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR12MB2687;20:XYZ8DGqI1KjC2iT2Z8H8PmJaFWKPNjZvKzabGRvM1ZKW+HvJA/FmY2VhqUTl4YxdJyxkVDDBW0FUKMpS79HgzcpKLmubieLqQLFwUJBL8O93AsDNyfmlvq0eIwI2bXUqkpDU0kqXFKO0rcPosct5Ae9CshXdN4RwJoxaPYUlmr0c5hIp5jV0L9jGVrfacwGgDwHfXuSSuZ3z3mupn7gQXWDgpFf2Cvi/LfCLJq6tqjmGJGSH+pRLNBtbYrOA7EdF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2018 01:29:58.1029 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 255c5457-24c2-425a-94d5-08d61205eda3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2687
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit

"
x86/kvmclock: Remove memblock dependency

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=368a540e0232ad446931f5a4e8a5e06f69f21343
"

introduced SEV guest regression.

The guest physical address holding the wall_clock and hv_clock_boot
are shared with the hypervisor must be mapped with C=0 when SEV
is active. To clear the C-bit we use  kernel_physical_mapping_init() to
split the large pages. The above commit moved the kvmclock initialization
very early and kernel_physical_mapping_init() fails to allocate memory
while spliting the large page.

To solve it, we add a special .data..decrypted section, this section can be
used to hold the shared variables. Early boot code maps this section with
C=0. The section is pmd aligned and sized to avoid the need to split the pages.
Caller can use __decrypted attribute to add the variables in .data..decrypted
section. 

Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@suse.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>

Changes since v3:
 - commit message improvements (based on Sean's feedback)

Changes since v2:
 - commit message and code comment improvements (based on Boris feedback)
 - move sme_populate_pgd fixes in new patch.
 - drop stable Cc - will submit to stable after patch is upstreamed.

Changes since v1:
 - move the logic to re-arrange mapping in new patch
 - move the definition of __start_data_* in mem_encrypt.h
 - map the workarea buffer as encrypted when SEV is enabled
 - enhance the sme_populate_pgd to update the pte/pmd flags when mapping exist

Brijesh Singh (4):
  x86/mm: Restructure sme_encrypt_kernel()
  x86/mm: fix sme_populate_pgd() to update page flags
  x86/mm: add .data..decrypted section to hold shared variables
  x86/kvm: use __decrypted attribute in shared variables

 arch/x86/include/asm/mem_encrypt.h |   6 +
 arch/x86/kernel/head64.c           |  11 ++
 arch/x86/kernel/kvmclock.c         |  30 ++++-
 arch/x86/kernel/vmlinux.lds.S      |  17 +++
 arch/x86/mm/mem_encrypt_identity.c | 232 +++++++++++++++++++++++++++----------
 5 files changed, 229 insertions(+), 67 deletions(-)

-- 
2.7.4

