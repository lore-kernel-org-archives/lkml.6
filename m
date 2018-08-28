Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CE8C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 22:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A476B2083B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 22:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ztRuyreQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A476B2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbeH2CG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 22:06:58 -0400
Received: from mail-eopbgr720088.outbound.protection.outlook.com ([40.107.72.88]:47232
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727245AbeH2CG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 22:06:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z95SsxDw8SM9uYWCWbZUbnp/BOF09SLG3TtrAvNJomw=;
 b=ztRuyreQksFELF2SuDdV6V84oqJ1DcLCHCW6cpIf6pQo3tQhz6umbHStn1B/yHJTHccJKOlg/yfocrNCvkIEV4V2+dWF6hxoEMteAmk1Yp7vmZ+1dTC/poz2xWTS04lO1U4BSkVQ24eg8SdblWfffROwoUOSp/zNnYxkxdspw2I=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by
 DM6PR12MB2682.namprd12.prod.outlook.com (2603:10b6:5:4a::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.15; Tue, 28 Aug 2018 22:13:11 +0000
From:   Brijesh Singh <brijesh.singh@amd.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Brijesh Singh <brijesh.singh@amd.com>, stable@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH v2 2/3] x86/mm: add .data..decrypted section to hold shared variables
Date:   Tue, 28 Aug 2018 17:12:56 -0500
Message-Id: <1535494377-25600-3-git-send-email-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: b7a66862-6765-4e97-9aed-08d60d337214
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB2682;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2682;3:xGUZR0KEaRLgvtFFs5mrRcbGSH9O+K1bsetxamm2Ay0b4YxCk5LBmwOYMaqPlXmGF56h0Jle9HCPqx9pgutdDcvJ38ZZKg3XtTKx0aGvl/M6+SEaImuahI6HMWVDpCK8vIJuwlpqyxkfBAkAVCNogApXRa8XzyiMzT2XiCXbIypcehqDzM2PweWMwhLM3soMTbKHC82GdnOhHt23tagILlWk5xFRDkHPbVtgMSVfDGyTJtve59b+15miCCpOAjV4;25:Z2eWp/mHYqYPxgkXjQqLvsAtTX0jJjvj7aTiA6PctlW+FRKTAdbvgdn9MjRPAyUZyuq0p+FSkUFjZX/ViYI3BVnsG8vhmt5xE2Ay6P88McB0WQ5+n77H40s05NUhrcfV13HtCKpgpnE9hL1oxwLlWpo6LQFz2mj5cUUvvdAIXQ4bdi8v7C5/yvqsRdFkUaxjy/eIueqRx3FaPmASJwk08xlF7ZriqwgCJsPM8m+lj+rAnuCIlylDq5P4tPhRtr49+HlAqRtB94zqXlH1oGTZx6PhFrRdI3Y+xAfccXPQcd/4C0Dwhj5EJ/961utPwM7ze6aXoq8SGB+l1T7NgXHfCg==;31:vRPPa2g1W0HBNjBstrWZFrmyryzWQqUd/5xvpm8bNW5Yq0BLV02ofo9E0SyCuvew8KI1kzVlw7nrr2Dt4Ug+XuEaTmM5E3IMadauUnuC3Aj3vFUafDut0vBLt6wzXzNl8QWRxkMC2e/rKk9yDnfJAud4emSjNAp/CWmfFhTvyghtzTQ0/TAvxdq4e+70RnitM+nY2MoVvZecV0tLW4zoHvbAw2FqzEHDUeDEC7ogMyY=
X-MS-TrafficTypeDiagnostic: DM6PR12MB2682:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2682;20:YqbVMWqCU2FZjJqIdlSMXQoX+RyC5JYtZqHyrKHI58/rmVtGqbha7EBa2jVT29/VC/8kiLJi9oxnHM2Kijz3gSVgsib6U/8jVa/6d0EAZ6uoEWeayABMsFIitVlswrNU5NA3PMjRXgYyuMVVzx2/SVaSLDosN4zuV48nc0uw8GO6TdYYGKxJgF3sQguWvO42Z/CKqO6on9mW5YzsFJuSDQxHoosqiVY0bLjrENI7vtePQzCvsvSpqH6cfmFeIjX6a1uetq9YCTV+/0P7LxltIP91xMvwi4dnSAGgUOf9K8Vk+fGrpC1Lk2sGLt+VmjW/6f8gJbrY8F2jT76sr8TKF4LFm9jZ4hvoftW3TR8g1T2VPvaaijOzUMFtP+f40rAqlllOYZGiuT2ATFUfOMj92/4bV899i7el6U/YBjvmcfIF9xUHWVVay2LyzFTg+xyg8NImSiE9zKcTg49xXRJo5mD9MdQ2or8vigK/+eddsqDE20fumRPWkvCiLfthfOMM;4:LbY1FmeHwChbPfRAotIvFkVWPC7pAhmfmKSXzgFUeDhi/Dv8CpxEqrESIYlBssGsJjLIDOghvR+/upTEMcM58Sr/B1Q8VXunQ30CuFiyMya38WyV06cnjfgJXQkeK/AqU4N9Pr574Kj8gWtq4xU5+gXnisR0np2u8tT02UtWxNohf2Hv0KrgWY70qX+oJThBX4PGxm9u/0y6ldXG5IA3cDy0yNLlZmY9pdIM/o/s9AYOhZduFJ1OhkKGbFkrtc8W6SKsNGpVwT7IiSFyIbAosI/7E12peefQCqrFdJ54ttoL3xOlSWIJ9yJSxMGrkfE5OdmKeROnm60YgpUJku+HLPSSeAgIOaNyLdh3LOESk+geZM1CW4knzWMDYY3NmIO7gqRQeFugm4RXTnKizOPPzA==
X-Microsoft-Antispam-PRVS: <DM6PR12MB26828349C6D0176E4C0149C6E50A0@DM6PR12MB2682.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(767451399110)(163750095850)(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699016);SRVR:DM6PR12MB2682;BCL:0;PCL:0;RULEID:;SRVR:DM6PR12MB2682;
X-Forefront-PRVS: 077884B8B5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(39860400002)(346002)(366004)(199004)(43544003)(189003)(186003)(50226002)(52116002)(7696005)(7416002)(4326008)(305945005)(7736002)(105586002)(8676002)(106356001)(478600001)(97736004)(23676004)(386003)(316002)(53416004)(16526019)(68736007)(25786009)(76176011)(26005)(54906003)(2870700001)(86362001)(575784001)(66066001)(36756003)(47776003)(6116002)(3846002)(6666003)(5660300001)(2906002)(81166006)(11346002)(81156014)(956004)(50466002)(2616005)(14444005)(486006)(476003)(8936002)(44832011)(446003)(53936002)(6486002)(142923001)(101420200001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2682;H:sbrijesh-desktop.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTZQUjEyTUIyNjgyOzIzOnJ2Z2tvZmxtOVRjYUIzNVR3eHpKSTJtYnNX?=
 =?utf-8?B?MlFmbVIySTlncWVmdERGc0NxWlFla3dpZXNsREpxYmZyR1FSS3ovNHUwZkpR?=
 =?utf-8?B?ZVRNWkFuY1VuN1ZuZHlrbUcrcEI4Rm55VXN5V1VOdi9ZYXlUU1pENytKV3Y5?=
 =?utf-8?B?OFcvMlZVcmQvU25PcnZWZHZUZXUraXFCaHBzOTYzcXdKMTdjNmhMQVNPMHZI?=
 =?utf-8?B?SXF3MGRBL29BWDFSakVMcFNKWkw1TitueTQ2Ky90K1ZzQ0xpTEhOWDZVdjlj?=
 =?utf-8?B?SmxBWU5MRE9KbENSR1RtOExlKzJqM2NlbmJyMlp5RmMrRUM2N1VuZUJzaTl1?=
 =?utf-8?B?YkRzOWVTNHV1aGZLNUhVVmNLK3lDaHViU3pqV0FBQWplVk43TXFaRWljNWY2?=
 =?utf-8?B?dXlPWHBoaytWM2xmdE1HbW92OEoxYTFvc1VseUVTQm5RenZhbGtnaVgvUmF2?=
 =?utf-8?B?YVZMa3ErNndEOVV4MWorZWhwZjYvck1jaGJWRHVxeS9PMy90SHNvVGxBb3Az?=
 =?utf-8?B?Mm1iR1R2R0ZaQS9ieWYza0pzYWtHUmp0RFJmVFJuRHY5VWdOdmFIR21mc3Ir?=
 =?utf-8?B?MUtLWlZCYS8zS0s1UmxwQnZpV0ZZQWRsSXVxUEd0TVpCMllNZE9BKzQzbnVF?=
 =?utf-8?B?WW02WnNscFFYQ3h2SHJZMGg5WWZnbmxKTFhRNmFUdmcyb0dib2pSVHFveE9j?=
 =?utf-8?B?ZjJkMExvTTRHdm9qTXUwdTBJUGFndjZSQmhjcFkyNUgyUnFpRndONytsdzg5?=
 =?utf-8?B?Z3ZKTUhoWnhUYklCcVEyVkNxU05lcTEyVUlzVXA1VU92dTdUeGlhS08xKzFZ?=
 =?utf-8?B?WUU0VG1IT1NCVWhaZnRpYjNMdWFRd1NUSkZDdk5RczZKdkx6UVFzOHFHcUZx?=
 =?utf-8?B?dFRvVWREb0tING9PL3kzZ0R0bWVqZ0M1VC9XWitaZlIyK1VieWVjU3BJK3Bt?=
 =?utf-8?B?enRYZStwTGRFTlZ4bkJybTQxR0htQUpHMkZ5Y1FGajBNRDFYMEo5ZlFqS3VF?=
 =?utf-8?B?ZjdyYTZWWmc2Vk9TYi9zS1k0SUdRcW5XODhjWGdxQU1tRXJIOVBzRmU2RFlC?=
 =?utf-8?B?RGY3bTBpc2ZINGlWdnJKMlR1b09JU0NpUUZEOW5GdUtpUXVLQkVSMnl1azV5?=
 =?utf-8?B?UnhpdWZyMVZpblNWM0svNjRRZitqTExSQkpjVTI1SEdQWTBldGJQL1BuMzZz?=
 =?utf-8?B?Nnc1L3lhMEl5WUlYQnZRTnpkSW51WTMrUS9kL3ZGVHVBdjlyeHU0cUR0SVhI?=
 =?utf-8?B?VjRzRHp5Q0c4aWx2eG9GblNjd2QwM3kxQjcxNFIzbzRtMTFJOTM5Q1FjSWRP?=
 =?utf-8?B?emIwUGRTQ21VVmpHYXFLS0Z1THd6V1JjSHpzcEhIZ2hqOStpZmtRazA4bXAx?=
 =?utf-8?B?ZDN5R3lFam5OeXR2RFBJODIrRi9WdE1HOTRWUTNjZVJNMnovV2xFRUx3dXd2?=
 =?utf-8?B?WDJCb3p3QnhWOVJqTlZuY0phc3V6ZlRSbVhuOFJuSmVMWktTb0wvK085MnFs?=
 =?utf-8?B?c2lzWTFJTnV1Ni84TWdjSmp2K2xJSDhya2FyQUkxc1ZubkNHcHF6MnJ4TXps?=
 =?utf-8?B?b0RoTWdGVktuSVEyL0JtMmlaOThCUCtqd216eHkzbGNJUFB3ajhHMkNaanFy?=
 =?utf-8?B?bVZGN1RxVk1jQ3l0V2ZRSzZodkxxUUtsM2RFbE1lZ01zdmY1NENEL3dDeW1y?=
 =?utf-8?B?eFUrRHNvajluNEV3dzhDR3NuTlZ1STJwU3hxdU56MWd6REduMlZkSHlYTzRP?=
 =?utf-8?Q?Y5RKy5l1ryWEN+LjhKBhxS6n0/jPISCuEbRdw=3D?=
X-Microsoft-Antispam-Message-Info: BJG7XKh4ryglCHVtTxR9k+SS1h6cH0OVvhOMl5TZvhKQThKTNEMCPt41/xZOaDm/wrU64Gaak8Udn7erEjrh42De770otEPD9iYlqCEa869YopgxI6Pqb3duCYxCqLevae4vRH47a7lOiYKAgjED4chk/MUlCafkezEmSVtR74oUbpu2RPdqbT2DcrWHKI8DXXSd7dV89jfjLNObF+YB/C8itG1g/myqbDn2HdQTM5kq/dNbW3bsB7EVPqINarD99JPhCn/s5jDhnWDy6kcTyu3MboQRMkKX60lapGfGTepbnIHfT0gRFyFpEeAmRwY0Alhxkk4vBEFU5UKX0U10f231v8DgkDqnQkgxg7O5WQ8=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2682;6:KAC304hzwY1lQya0/jZSQwtvnU/6cWZpQfJ6qvmKj3pUgk7uIzhNxLzoc25X36JYPpvm8rgGKi80j8rQEAiq+PeHlg/oVI/s2cSiVgmvNbuXGmlLou3TUnfmgQfMKDcvEEuzAPi2tPIoQSEjcQKDIK8MNePQMKbGddxYe7o/fDIptIqrqxsJXIg6sIzFgutY/yeyhO/M6FS6nK8blvEVCLVSjbERr45VEI0FH2T5WjtEoTQQ5YE7bEj5dL9nJ2U158y9OE2CRQR+pEDLVqKi/HuN2+WE3KfGJWOIYn/3UdfPlNLBMFlO6HF4MD94gdmUoPufPj9GmzjOx8AExMFIS/QoHCRCgZjnsR1IWxPO1eEDDzEWf/bC0PEPRBvSAS9LJe9n/NpK7hngChGAmCrLyDc7ZipKqK5iKoDAMW94Cj1Yk2GwtfqmkUhdRKIcL6VggpEbw3hlMRJbybkZZKNDVQ==;5:/NrV95PviNYrQSHT6eR4oMEbo9KMtFjEZ30UF8RSKTc0aho9eN0X1Eg8BOZERyZD9yobukKhG1T6B0wVQHJX2KHspHV8qp3uxXR+zY58kCjDKOm0axZu/R5zmvma7/ByBiDlPhmIqS0qNpniYGrm4Jy8tdolIcGxmjmdciajgr8=;7:2OLSlONnK4fk0iRQ+1QbM2tNQyZSeYUZeleXDqb1WnIl3XrX+RineDwtK9tr0Lt0SFgQz/gvOiMyCS8uyXPtuhzFdcsURve6prbnhkOAFJ31xjrlOblYFOPvaTry6ce1ZPAmDYKtGfTS64rlr9bL6PK9F99Yx4gIgQZqggOg00QHUuHyC0cQr3dUiRxfysSZ1fGb6pP9FIk1WwXnn+t9RTxQ9yEYAk4S4mfoQ1W/t+7Y4uWqpSqohDyypusz6Ko5
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2682;20:/nN9E/8gg9MGyIVMfLej9gre2f1B4Dwj4rc+8HQo+DHD0GXILoGNI+5DDtNqBdCXV2d5HMKccg11+9WudlhbmVhW0NIH4OWV3lR2+wx8xic8u2I38bKxp0o+3DLxoe501t9Plf3wv8mFoV24eJ/G5nZnUUJz1kYBZM82ZRWqX9qJJpZLGRVtEruNY/YTgChuy/JY57x7heVyAZWXvMrr8FInWQ4CZy4uvMbturSpboIcJeWsGYQe/ErnCOXVLZyg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2018 22:13:11.4043 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7a66862-6765-4e97-9aed-08d60d337214
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2682
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kvmclock defines few static variables which are shared with hypervisor
during the kvmclock initialization.

When SEV is active, memory is encrypted with a guest-specific key, and
if guest OS wants to share the memory region with hypervisor then it must
clear the C-bit before sharing it. Currently, we use
kernel_physical_mapping_init() to split large pages before clearing the
C-bit on shared pages. But the kernel_physical_mapping_init fails when
called from the kvmclock initialization (mainly because memblock allocator
was not ready).

The '__decrypted' can be used to define a shared variable; the variables
will be put in the .data.decryption section. This section is mapped with
C=0 early in the boot, we also ensure that the initialized values are
updated to match with C=0 (i.e perform an in-place decryption). The
.data..decrypted section is PMD aligned and sized so that we avoid the
need to split the large pages when mapping this section.

The sme_encrypt_kernel() was used to perform the in-place encryption
of the Linux kernel and initrd when SME is active. The routine has been
enhanced to decrypt the .data..decryption section for both SME and SEV
cases.

While reusing the sme_populate_pgd() we found that the function does not
update the flags if the pte/pmd entry already exists. The patch updates
the function to take care of it.

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
 arch/x86/include/asm/mem_encrypt.h |   6 +++
 arch/x86/kernel/head64.c           |   9 ++++
 arch/x86/kernel/vmlinux.lds.S      |  17 +++++++
 arch/x86/mm/mem_encrypt_identity.c | 100 +++++++++++++++++++++++++++++--------
 4 files changed, 112 insertions(+), 20 deletions(-)

diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index c064383..802b2eb 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -52,6 +52,8 @@ void __init mem_encrypt_init(void);
 bool sme_active(void);
 bool sev_active(void);
 
+#define __decrypted __attribute__((__section__(".data..decrypted")))
+
 #else	/* !CONFIG_AMD_MEM_ENCRYPT */
 
 #define sme_me_mask	0ULL
@@ -77,6 +79,8 @@ early_set_memory_decrypted(unsigned long vaddr, unsigned long size) { return 0;
 static inline int __init
 early_set_memory_encrypted(unsigned long vaddr, unsigned long size) { return 0; }
 
+#define __decrypted
+
 #endif	/* CONFIG_AMD_MEM_ENCRYPT */
 
 /*
@@ -88,6 +92,8 @@ early_set_memory_encrypted(unsigned long vaddr, unsigned long size) { return 0;
 #define __sme_pa(x)		(__pa(x) | sme_me_mask)
 #define __sme_pa_nodebug(x)	(__pa_nodebug(x) | sme_me_mask)
 
+extern char __start_data_decrypted[], __end_data_decrypted[];
+
 #endif	/* __ASSEMBLY__ */
 
 #endif	/* __X86_MEM_ENCRYPT_H__ */
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 8047379..3e03129 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -112,6 +112,7 @@ static bool __head check_la57_support(unsigned long physaddr)
 unsigned long __head __startup_64(unsigned long physaddr,
 				  struct boot_params *bp)
 {
+	unsigned long vaddr, vaddr_end;
 	unsigned long load_delta, *p;
 	unsigned long pgtable_flags;
 	pgdval_t *pgd;
@@ -234,6 +235,14 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	/* Encrypt the kernel and related (if SME is active) */
 	sme_encrypt_kernel(bp);
 
+	/* Clear the memory encryption mask from the decrypted section */
+	vaddr = (unsigned long)__start_data_decrypted;
+	vaddr_end = (unsigned long)__end_data_decrypted;
+	for (; vaddr < vaddr_end; vaddr += PMD_SIZE) {
+		i = pmd_index(vaddr);
+		pmd[i] -= sme_get_me_mask();
+	}
+
 	/*
 	 * Return the SME encryption mask (if SME is active) to be used as a
 	 * modifier for the initial pgdir entry programmed into CR3.
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 8bde0a4..0ef9320 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -89,6 +89,21 @@ PHDRS {
 	note PT_NOTE FLAGS(0);          /* ___ */
 }
 
+/*
+ * This section contains data which will be mapped as decrypted. Memory
+ * encryption operates on a page basis. But we make this section a pmd
+ * aligned to avoid spliting the pages while mapping the section early.
+ *
+ * Note: We use a separate section so that only this section gets
+ * decrypted to avoid exposing more than we wish.
+ */
+#define DATA_DECRYPTED_SECTION						\
+	. = ALIGN(PMD_SIZE);						\
+	__start_data_decrypted = .;					\
+	*(.data..decrypted);						\
+	. = ALIGN(PMD_SIZE);						\
+	__end_data_decrypted = .;					\
+
 SECTIONS
 {
 #ifdef CONFIG_X86_32
@@ -171,6 +186,8 @@ SECTIONS
 		/* rarely changed data like cpu maps */
 		READ_MOSTLY_DATA(INTERNODE_CACHE_BYTES)
 
+		DATA_DECRYPTED_SECTION
+
 		/* End of data section */
 		_edata = .;
 	} :data
diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index bf6097e..88c1cce 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -51,6 +51,8 @@
 				 (_PAGE_PAT | _PAGE_PWT))
 
 #define PMD_FLAGS_ENC		(PMD_FLAGS_LARGE | _PAGE_ENC)
+#define PMD_FLAGS_ENC_WP	((PMD_FLAGS_ENC & ~_PAGE_CACHE_MASK) | \
+				 (_PAGE_PAT | _PAGE_PWT))
 
 #define PTE_FLAGS		(__PAGE_KERNEL_EXEC & ~_PAGE_GLOBAL)
 
@@ -59,6 +61,8 @@
 				 (_PAGE_PAT | _PAGE_PWT))
 
 #define PTE_FLAGS_ENC		(PTE_FLAGS | _PAGE_ENC)
+#define PTE_FLAGS_ENC_WP	((PTE_FLAGS_ENC & ~_PAGE_CACHE_MASK) | \
+				 (_PAGE_PAT | _PAGE_PWT))
 
 struct sme_populate_pgd_data {
 	void    *pgtable_area;
@@ -154,9 +158,6 @@ static void __init sme_populate_pgd_large(struct sme_populate_pgd_data *ppd)
 		return;
 
 	pmd = pmd_offset(pud, ppd->vaddr);
-	if (pmd_large(*pmd))
-		return;
-
 	set_pmd(pmd, __pmd(ppd->paddr | ppd->pmd_flags));
 }
 
@@ -182,8 +183,7 @@ static void __init sme_populate_pgd(struct sme_populate_pgd_data *ppd)
 		return;
 
 	pte = pte_offset_map(pmd, ppd->vaddr);
-	if (pte_none(*pte))
-		set_pte(pte, __pte(ppd->paddr | ppd->pte_flags));
+	set_pte(pte, __pte(ppd->paddr | ppd->pte_flags));
 }
 
 static void __init __sme_map_range_pmd(struct sme_populate_pgd_data *ppd)
@@ -235,6 +235,11 @@ static void __init sme_map_range_encrypted(struct sme_populate_pgd_data *ppd)
 	__sme_map_range(ppd, PMD_FLAGS_ENC, PTE_FLAGS_ENC);
 }
 
+static void __init sme_map_range_encrypted_wp(struct sme_populate_pgd_data *ppd)
+{
+	__sme_map_range(ppd, PMD_FLAGS_ENC_WP, PTE_FLAGS_ENC_WP);
+}
+
 static void __init sme_map_range_decrypted(struct sme_populate_pgd_data *ppd)
 {
 	__sme_map_range(ppd, PMD_FLAGS_DEC, PTE_FLAGS_DEC);
@@ -382,7 +387,10 @@ static void __init build_workarea_map(struct boot_params *bp,
 	ppd->paddr = workarea_start;
 	ppd->vaddr = workarea_start;
 	ppd->vaddr_end = workarea_end;
-	sme_map_range_decrypted(ppd);
+	if (sev_active())
+		sme_map_range_encrypted(ppd);
+	else
+		sme_map_range_decrypted(ppd);
 
 	/* Flush the TLB - no globals so cr3 is enough */
 	native_write_cr3(__native_read_cr3());
@@ -439,16 +447,27 @@ static void __init build_workarea_map(struct boot_params *bp,
 		sme_map_range_decrypted_wp(ppd);
 	}
 
-	/* Add decrypted workarea mappings to both kernel mappings */
+	/*
+	 * When SEV is active, kernel is already encrypted hence mapping
+	 * the initial workarea_start as encrypted. When SME is active,
+	 * the kernel is not encrypted hence add a decrypted workarea
+	 * mappings to both kernel mappings.
+	 */
 	ppd->paddr = workarea_start;
 	ppd->vaddr = workarea_start;
 	ppd->vaddr_end = workarea_end;
-	sme_map_range_decrypted(ppd);
+	if (sev_active())
+		sme_map_range_encrypted(ppd);
+	else
+		sme_map_range_decrypted(ppd);
 
 	ppd->paddr = workarea_start;
 	ppd->vaddr = workarea_start + decrypted_base;
 	ppd->vaddr_end = workarea_end + decrypted_base;
-	sme_map_range_decrypted(ppd);
+	if (sev_active())
+		sme_map_range_encrypted(ppd);
+	else
+		sme_map_range_decrypted(ppd);
 
 	wa->kernel_start = kernel_start;
 	wa->kernel_end = kernel_end;
@@ -491,28 +510,69 @@ static void __init remove_workarea_map(struct sme_workarea_data *wa,
 	native_write_cr3(__native_read_cr3());
 }
 
+static void __init decrypt_data_decrypted_section(struct sme_workarea_data *wa,
+						  struct sme_populate_pgd_data *ppd)
+{
+	unsigned long decrypted_start, decrypted_end, decrypted_len;
+
+	/* Physical addresses of decrypted data section */
+	decrypted_start = __pa_symbol(__start_data_decrypted);
+	decrypted_end = ALIGN(__pa_symbol(__end_data_decrypted), PMD_PAGE_SIZE);
+	decrypted_len = decrypted_end - decrypted_start;
+
+	if (!decrypted_len)
+		return;
+
+	/* Add decrypted mapping for the section (identity) */
+	ppd->paddr = decrypted_start;
+	ppd->vaddr = decrypted_start;
+	ppd->vaddr_end = decrypted_end;
+	sme_map_range_decrypted(ppd);
+
+	/* Add encrypted-wp mapping for the section (non-identity) */
+	ppd->paddr = decrypted_start;
+	ppd->vaddr = decrypted_start + wa->decrypted_base;
+	ppd->vaddr_end = decrypted_end + wa->decrypted_base;
+	sme_map_range_encrypted_wp(ppd);
+
+	/* Perform in-place decryption */
+	sme_encrypt_execute(decrypted_start,
+			    decrypted_start + wa->decrypted_base,
+			    decrypted_len, wa->workarea_start,
+			    (unsigned long)ppd->pgd);
+
+	ppd->vaddr = decrypted_start + wa->decrypted_base;
+	ppd->vaddr_end = decrypted_end + wa->decrypted_base;
+	sme_clear_pgd(ppd);
+}
+
 void __init sme_encrypt_kernel(struct boot_params *bp)
 {
 	struct sme_populate_pgd_data ppd;
 	struct sme_workarea_data wa;
 
-	if (!sme_active())
+	if (!mem_encrypt_active())
 		return;
 
 	build_workarea_map(bp, &wa, &ppd);
 
-	/* When SEV is active, encrypt kernel and initrd */
-	sme_encrypt_execute(wa.kernel_start,
-			    wa.kernel_start + wa.decrypted_base,
-			    wa.kernel_len, wa.workarea_start,
-			    (unsigned long)ppd.pgd);
-
-	if (wa.initrd_len)
-		sme_encrypt_execute(wa.initrd_start,
-				    wa.initrd_start + wa.decrypted_base,
-				    wa.initrd_len, wa.workarea_start,
+	/* When SME is active, encrypt kernel and initrd */
+	if (sme_active()) {
+		sme_encrypt_execute(wa.kernel_start,
+				    wa.kernel_start + wa.decrypted_base,
+				    wa.kernel_len, wa.workarea_start,
 				    (unsigned long)ppd.pgd);
 
+		if (wa.initrd_len)
+			sme_encrypt_execute(wa.initrd_start,
+					    wa.initrd_start + wa.decrypted_base,
+					    wa.initrd_len, wa.workarea_start,
+					    (unsigned long)ppd.pgd);
+	}
+
+	/* Decrypt the contents of .data..decrypted section */
+	decrypt_data_decrypted_section(&wa, &ppd);
+
 	remove_workarea_map(&wa, &ppd);
 }
 
-- 
2.7.4

