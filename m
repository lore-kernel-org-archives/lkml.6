Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A90C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0C2E20652
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="k9e47wt1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0C2E20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbeIGWjz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 18:39:55 -0400
Received: from mail-eopbgr680053.outbound.protection.outlook.com ([40.107.68.53]:59456
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726151AbeIGWjy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 18:39:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/33GApL/ZLaCxzsc0vsz+pMPr8mgVj6VJtr/v0y/t8w=;
 b=k9e47wt1uYoWIpB9W8dhHusb31PgMLBBR7DNZHesFL0Z53dbP6uGjUpyln9Qa3DIlbpcGMxyM9eAsiNaZ/Z3DVKgnMb8uwWxBrkgNQ1J9tz/Dg0XkxM1nTZg/ein9RwcyR/SlLG63MNcW65z0e4LK1FSpBPFjrn/gJufLbH6zRM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by
 DM6PR12MB2684.namprd12.prod.outlook.com (2603:10b6:5:4a::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.16; Fri, 7 Sep 2018 17:57:41 +0000
From:   Brijesh Singh <brijesh.singh@amd.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH v6 3/5] x86/mm: add .data..decrypted section to hold shared variables
Date:   Fri,  7 Sep 2018 12:57:28 -0500
Message-Id: <1536343050-18532-4-git-send-email-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: f80a6f82-ba4e-4cde-c43f-08d614eb6877
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB2684;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2684;3:8yu5wHoeoK/GmbKck++EkK9SfnBJig96KfZdtGywwIe+dGJy5MsEChqvrAx33e4B/auwSK4cCjSEF/P4taNlVMJQl1OVpA8y7FNktRCZJU4tyNyhYgbutJHW+eRjV4tdqbagRau8jbuf5/55qqqU1RAdbln/fL5/AQVmzpLriF33RMIOpyC+IAGHzy42PeFs8JuIdJ/Bd9zSURmCwUoLSzkCFaP0++liQdgbAxTHlf9/6dFVCUrCkzQQI4WRwBXn;25:if0QkngTE4fXuRKLnMbRJ1/apXAA5y4oF0Np1+zWDUpKCF+z349jwA1V4d9ffibxKp/cnuO/lLPOD1LbdF0n5LMiorfpGyukfkI5HFXoJ7T25dqJPpGi7gdg95Dj2POP00Onfj6qMwEUE4U+CIKBmGuRCbkWHGPClnZYe7h2vn5tOav/xlDSAkq56wIc9F3eEwXEsH98gPRVWu4YqDE5j3rSVBZSusR+Ac1wDAIaSfBeE7o1tTkz5d4sbLW/R1XAJUVLBSRHzDZOkiQNGMKOmu4sQrsu24X+DpZXQ9sxxQJmCaNYE10GTXBDEg7WHQwgxLxqxczK8GtB4shBdyW1gw==;31:cGmIYazjPLJcsswZF6EaRUcU+Er8Y3BRXPXzLHccP1bi8WH2updvVqvzZuTYowGK84F/stNFVcSkCA07N+wmAW7kE0CBTheWrJ1ZSQpjBYI5VmC+CtTPwso5F3mrbfW5K1TEwMTm+9BXc5neSSbQlva6D2U31uAtEeW3ontYZU+t5GWSncdEHF8Yo5AZVAXR1LcoqFJzTYrNYwGqItrpHpTeqxXmaZff8yKrggTXgug=
X-MS-TrafficTypeDiagnostic: DM6PR12MB2684:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2684;20:hqVO1kZ1QTNunBpcaspfAjq7u19Yxoi1d8Mjc/ulqK+xBmYrfXOjjmS4Os15BYgA9a2Nlh+49xdCldg9+Ny96LSk81C+5BPZrJz6+mfQvvo2zzPZprNonz73+10JuAGntsOheFMzA30JNZ7Y/y0u4m2TEDrg3hNBz70qIsoJyluU2z/Unm9PWJ1k3aQpd5AeZJMb6rkzqTfxOBtl9cleV1hwsNnQJZR6kMrgQjnwwJGxPfZ6TryZ03r6mgLudcBZdwjd10EC/8zQhNDdUubawVrAEZH+5msSC8T6NG20ZbIKUP2lWSCTek1AyFHotu4W0XrRyJk3qn+Do/CGSZF1jG2cKroGXeuKPme3rI3XyywtaAF1W5/IEa38sALCsmVd5rgcUMzl0UGAtYmxUr9+yQl25r7dFTz60tdvQxAXmMvQP0J7V+/Jw38SKYBYGO0tdQUns4lwRnfgH3kWNzNIOI7woAIkzaibbwZpHvAx47X0sPmp2iut+tnv8ivWbbSy;4:JBU/vgM4Luu43gIQ9DXSDStozFb0FLBZGdZJfs5rJVoNQtpx6GCbp/VMqK942yc1a+Iiw1Rfu4u3m5c/DtEOZjqEve9HXMAFRR527pJ0VEFuF457U199yZpk2YI3HwdtsdI0mOuEtILL+qULECqN0BXwRaGA7KlOEQLNB9z4FWUX6YfCm1sFe74OwcexJbtenuWxCM2Y17pwV7E87xwlNQm7y8paPxKWn8QfvcBuoaMKrpNOYcepS+4AVU2jjClyK+5VVFKDpKnm1bvZULNxTWuBj9ZJRc6AhkfFDrycquLqBzujslPOKtO8eSMM/trm2CwHrMmqYddwnkqY1grzbCydp/KQGsYXe3b19xT9QeQ/pdZGK1gIf6mLt9MtH1ygk5EGT6mrrb8dqd0jJedZPvxBTsPkjBn/1QgJqiXYwnA=
X-Microsoft-Antispam-PRVS: <DM6PR12MB2684B192506BDBF60974899DE5000@DM6PR12MB2684.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(767451399110)(163750095850)(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699050);SRVR:DM6PR12MB2684;BCL:0;PCL:0;RULEID:;SRVR:DM6PR12MB2684;
X-Forefront-PRVS: 07880C4932
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(39860400002)(396003)(136003)(189003)(199004)(8936002)(81156014)(81166006)(446003)(575784001)(476003)(2616005)(956004)(86362001)(11346002)(36756003)(486006)(2870700001)(44832011)(2906002)(47776003)(25786009)(50226002)(66066001)(4326008)(6116002)(97736004)(6666003)(7736002)(105586002)(316002)(54906003)(106356001)(76176011)(3846002)(23676004)(7696005)(8676002)(305945005)(52116002)(16526019)(386003)(186003)(68736007)(6486002)(26005)(5660300001)(50466002)(53936002)(478600001)(53416004)(142923001)(101420200001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2684;H:sbrijesh-desktop.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTZQUjEyTUIyNjg0OzIzOlNXYTkyaWFpSHVrMG1MQTN4THZMKzkya0tR?=
 =?utf-8?B?eFl0SG1FRnhHQWJQNHdwNDdLWFRKd3pYQUtiaDBxNktxSi9EcjBMa3NFbFE3?=
 =?utf-8?B?aHJCN2xZVnlINithRGhCbithQnp3UTJYcllpZHE1TEp5NDljNDVQQUNlQUg0?=
 =?utf-8?B?SDVFTlhwMVl6MXZSVlFUN3ZKUUJmbW9sNUNONWlPb25EOUNBTU1WdU1pVU9s?=
 =?utf-8?B?ditseFNiRk1ZWlpyM1Qvb000MWdZOWcvZ3hYSzAwR3BqOVVwQWZ4dFlHcDVk?=
 =?utf-8?B?OUMyYzAvNkJ6N0FULzNYVnpxSDVyc0tRcDFFRFhXdWlGVHFjVkxjOTNOejVZ?=
 =?utf-8?B?bkJRNURqOGM1MEZzSllPd3Q5ZmFiVWlXQjBCL09lTGd2d0hhbDFGYWtkYWI1?=
 =?utf-8?B?eFVmamhBV0g5RWdndlNsczFVTXhwWHZad3Y5T2lNbWtHVjdMekZXeUZCSUJ3?=
 =?utf-8?B?bnpTYWVUdU5qUnI3SGYyeHZkZEVObVEvY0wvemtjTzhvaFI1ZW9saEpaQVVk?=
 =?utf-8?B?ZWVlcWlhUWFkQWsrNnBFWXpYQWNhem5QbkpobjVpR0FkYUhINGhZQU9pNUtQ?=
 =?utf-8?B?T3hPTVZhMTJqaFdYL2JXaUE1MHVWbTlFVHFHN1pXOEJWZFZrUkgvUURuczBn?=
 =?utf-8?B?UlJLVFlzYzlsYkZkSyt5QU10NEllVGRCa0dLL0JmeHhEeTZMODR6cEJZOFYw?=
 =?utf-8?B?Q2NNU1FyOE5sYzlSazF5SGtGL1orcmp3clBtY2s3c3ZNSmU4ZFhMQmVIS01F?=
 =?utf-8?B?dkhQY0JFdGd6bTZHOTkrRHR1VU5ib3psSXNiN2hpK2k0akRjbUdKTk1RNnhj?=
 =?utf-8?B?MEJTTE9FWS9tQ0VuVHNEb0RWWUxyY0dEL1h0cllWUURuQVVQbURjK2h5SEE2?=
 =?utf-8?B?VnZmTDZlamo2NEdGck50OEhRS3Z0bE53Z2hHdDBCWlo1SHBUY2J3YlZyb21t?=
 =?utf-8?B?Z3lOV1FxeXRzc1AxaEd5djlDUkF5NFFMZ0pqU0dTdzdEenk1NDA5cHJMTldp?=
 =?utf-8?B?dm56d3F5ODlqVUdQVkJDMjZQWVdEdFBXMkVsSmpEcktJVnhranhaMWZEeEts?=
 =?utf-8?B?cmJEa3QvMzgrc2hVWDg2QmlCYUpIZ05SNE1yR25kNmZQN0NuV3NDVHFTc0l3?=
 =?utf-8?B?NFo2eDFRRHNWM2FqK1EvZmFSZml4MUFvL01TOWlxVEhHeXdBemEwMlMxYUU0?=
 =?utf-8?B?aE9NMWZjeGY0TTFNc1FrRTFORytMaU4wMml1OFRSSkxYN3hmZHRKbWpybVdq?=
 =?utf-8?B?cURlYjNuTThXcy9lQmNYTGcxcm1ZcDQyZ3BiNTFUZGpoS1U3MGNTcUMvM1dD?=
 =?utf-8?B?U2RDditwcnNQK29ZbjNUMnpTOC9hQnc3UStvakNUQUVOdnV4bVdXc29ZeUF1?=
 =?utf-8?B?WDRUbEZSZlFwWlowTVREOWI0Vm9CNU91d2ZBNElZOHVSbyttQ1NnMTBiUVdk?=
 =?utf-8?B?cithcVM1WWF5SGN0YU9EOWJtNHVnWENXZ1pjbmcrckxoSExGQ0NCSnJjUjU3?=
 =?utf-8?B?Nm41SkZZUjlOeVM1dkZUZGxvNWF4eE8zbmk2dktJTi9MMlRMRjdJK3JCTVJ0?=
 =?utf-8?B?YVpvNVVjaXFSMzEwNEZzL1pXS3JGT2IzTi9CWnZnU2F4ZWtCb3NlQ2l6dDFx?=
 =?utf-8?B?eHpiRkptNE5LclFKTktwWDhxcTRjSkpiRUZsRk90WXVFMERRUmg3RHNESS9U?=
 =?utf-8?Q?posCBvaSeo4pL8Pb1I=3D?=
X-Microsoft-Antispam-Message-Info: rWgUAUc3tfJjKhKa6NGQqit5jojqR3jua98kD/ILepx4iZ9abXBib93HfjoLm04yty1XsZjpfYXl6JluuGOftvGSTP4wusCVM1erHqhcEZKlJ/kYAP4mh2mfvfqGCl1pLe+fB2NS514Aj1dtb0GtFPff6jsyV8h18XIfy1TbDQ7noio5gNxh4rsLeKQIDOgBL6NECocal49360tFD1Tlx8LZBZgkbJyBk9xtwDrMJ2mdTFBur5Q6RScAwSkGy6TLwg9ZRfJkUEciRIqJgE+Q19g0Ede9c3tGKHnVeiSS6+d45EYXtdgAuosM5B6Rf3UUaiyZ2JyatJleqro+NrDN7drqqaYMnV+SOVvfBFXdqvg=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2684;6:+RFSJ2d8/xmL8r20rebl0NECKDDTZmZxq/VaBwpNoq3VvkBjY41QG76YBfTaBob0UckeaT052JO96z6G+aNc0THbC83VluR1VcS8Z90gWOFEQKOCHyOxi8azGulWFlgHE/MfFEV7FIAxsM0zqhILwzWuRpr1VJTUkIHv452jj9ZFkwIGbMoaQggaKW+1cAfFqflJtGAiZxO9gxa3Jxz6TdoRA/gkCgA6ZOBZU7uV/ayMZnWPFWwa8CgwfDYs+se/EgjPLtgwxMMWTHXmIRUoynIpzirxgr0lnscgEbPHpTcehRs1r9OLyV50ChMAdV6aWLAxTf7OBayi80Jvx5CJ+P//wlwWfyx/5H19qPvNjTXqMCugT5QuOpj/w4C2haKwD1tPxfUGA/Zqeeas044bgFDTqTHDZgt5w2T5osiD1OQFUFtnf4kerzp+rbE9EGIJsdaQ1rfmWfSepvhTr/GLbw==;5:+B6CgkZIo97v3qFRgDjCdwuHH3k+VTRG/31bLSB1kbeNz0YNTQAZjr6D9ErhzOhLgtKVg6EgXbaczialHv1tbh2D0p4hCoPF2iA0X03qDnCW4BGVAuu7o4ZhaOa9pPoZsfAwvsIH5lxV1BEvA3ciXXOMLTogwjPs79mP7gKHYrU=;7:JTfn7n+Ma6wMwOFF/mm7l3AAmYZNZpNlCBOnhWNr9nGgLN83BcWnSw2+05E+6d+izUYcbX6+UC9k0/hxxB2yoq9q9yXtOJrJYvLUVDMdJ29pM3JOMxH/cgsTusc6dYoEmU8vhwjJm9QrXb2U0ap/6tSvd0SB8tykypN2X/UuSR0Hr5yZw414vWXJJnLid+IGUCOqGpE/Jqz2qkEGaEylfGzva+/zTgK6hnjt7pmgJBoPd4epXV2heZ+bFXKU0nkK
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2684;20:Rg3T58Opph5/cYVDRHLsHlA77sSpcsW2lIovpN3j9WxWPHTrmza5MZYa0wxPfCF3ZBXjXU8oav4oGNSz69dY/zgAaoy3Yf3rBs/nzz4i6PMOlrh2HX4QDuyRYhdtOZ4h8+DIB534y0YVcdm3Kth+Brq2GpnguTiJeTWegXI2Bwj9o2wmTOiwi99/HJL5wl15U6CTOA3hWEq3bIiyfb80u/UX1cCrd8pwfPws4/5Kr7KOLJWpsI4874kK58X5mtZ1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2018 17:57:41.5428 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f80a6f82-ba4e-4cde-c43f-08d614eb6877
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2684
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kvmclock defines few static variables which are shared with the
hypervisor during the kvmclock initialization.

When SEV is active, memory is encrypted with a guest-specific key, and
if guest OS wants to share the memory region with hypervisor then it must
clear the C-bit before sharing it. Currently, we use
kernel_physical_mapping_init() to split large pages before clearing the
C-bit on shared pages. But it fails when called from the kvmclock
initialization (mainly because memblock allocator is not ready that early
during boot).

Add a __decrypted section attribute which can be used when defining
such shared variable. The so-defined variables will be placed in the
.data..decrypted section. This section is mapped with C=0 early
during boot, we also ensure that the initialized values are updated
to match with C=0 (i.e perform an in-place decryption). The
.data..decrypted section is PMD-aligned and sized so that we avoid
the need to split the large pages when mapping the section.

The sme_encrypt_kernel() was used to perform the in-place encryption
of the Linux kernel and initrd when SME is active. The routine has been
enhanced to decrypt the .data..decrypted section for both SME and SEV
cases.

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
 arch/x86/include/asm/mem_encrypt.h |  6 +++
 arch/x86/kernel/head64.c           | 11 +++++
 arch/x86/kernel/vmlinux.lds.S      | 17 +++++++
 arch/x86/mm/mem_encrypt_identity.c | 94 ++++++++++++++++++++++++++++++++------
 4 files changed, 113 insertions(+), 15 deletions(-)

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
index 8047379..af39d68 100644
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
@@ -234,6 +235,16 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	/* Encrypt the kernel and related (if SME is active) */
 	sme_encrypt_kernel(bp);
 
+	/* Clear the memory encryption mask from the .data..decrypted section. */
+	if (mem_encrypt_active()) {
+		vaddr = (unsigned long)__start_data_decrypted;
+		vaddr_end = (unsigned long)__end_data_decrypted;
+		for (; vaddr < vaddr_end; vaddr += PMD_SIZE) {
+			i = pmd_index(vaddr);
+			pmd[i] -= sme_get_me_mask();
+		}
+	}
+
 	/*
 	 * Return the SME encryption mask (if SME is active) to be used as a
 	 * modifier for the initial pgdir entry programmed into CR3.
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 8bde0a4..4cb1064 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -65,6 +65,21 @@ jiffies_64 = jiffies;
 #define ALIGN_ENTRY_TEXT_BEGIN	. = ALIGN(PMD_SIZE);
 #define ALIGN_ENTRY_TEXT_END	. = ALIGN(PMD_SIZE);
 
+/*
+ * This section contains data which will be mapped as decrypted. Memory
+ * encryption operates on a page basis. Make this section PMD-aligned
+ * to avoid spliting the pages while mapping the section early.
+ *
+ * Note: We use a separate section so that only this section gets
+ * decrypted to avoid exposing more than we wish.
+ */
+#define DATA_DECRYPTED						\
+	. = ALIGN(PMD_SIZE);					\
+	__start_data_decrypted = .;				\
+	*(.data..decrypted);					\
+	. = ALIGN(PMD_SIZE);					\
+	__end_data_decrypted = .;				\
+
 #else
 
 #define X86_ALIGN_RODATA_BEGIN
@@ -74,6 +89,7 @@ jiffies_64 = jiffies;
 
 #define ALIGN_ENTRY_TEXT_BEGIN
 #define ALIGN_ENTRY_TEXT_END
+#define DATA_DECRYPTED
 
 #endif
 
@@ -171,6 +187,7 @@ SECTIONS
 		/* rarely changed data like cpu maps */
 		READ_MOSTLY_DATA(INTERNODE_CACHE_BYTES)
 
+		DATA_DECRYPTED
 		/* End of data section */
 		_edata = .;
 	} :data
diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index 7659e65..08e70ba 100644
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
@@ -231,6 +235,11 @@ static void __init sme_map_range_encrypted(struct sme_populate_pgd_data *ppd)
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
@@ -378,7 +387,10 @@ static void __init build_workarea_map(struct boot_params *bp,
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
@@ -435,16 +447,27 @@ static void __init build_workarea_map(struct boot_params *bp,
 		sme_map_range_decrypted_wp(ppd);
 	}
 
-	/* Add decrypted workarea mappings to both kernel mappings */
+	/*
+	 * When SEV is active, kernel is already encrypted hence mapping
+	 * the initial workarea_start as encrypted. When SME is active,
+	 * the kernel is not encrypted hence add decrypted workarea
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
@@ -487,28 +510,69 @@ static void __init teardown_workarea_map(struct sme_workarea_data *wa,
 	native_write_cr3(__native_read_cr3());
 }
 
+static void __init decrypt_shared_data(struct sme_workarea_data *wa,
+				       struct sme_populate_pgd_data *ppd)
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
+	decrypt_shared_data(&wa, &ppd);
+
 	teardown_workarea_map(&wa, &ppd);
 }
 
-- 
2.7.4

