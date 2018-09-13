Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B309BFC6183
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 21:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5785A2147A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 21:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="VGOEjIIR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5785A2147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbeINDCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 23:02:50 -0400
Received: from mail-bn3nam01on0056.outbound.protection.outlook.com ([104.47.33.56]:7648
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728222AbeINDCt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 23:02:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IIRFSon0tHNcv6kJA1Vaiy3U7u4p1v7qrHJatqT/uXI=;
 b=VGOEjIIRoDVxMOn6/yjo3DnWjSg94wYyyk+yrQvt9x4oYnd2Zlj2C1KMquljGGuuqWEvVUzMxRbTSWO55LncZwht/MIwYKJtAGqRbdNqQkg3slH5DeMHJsD3dvpnKJrlgW3+JXqwLXhVWTJxmOfwe/568iIiUzvqwuWuDVXe6DM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by
 SN6PR12MB2688.namprd12.prod.outlook.com (2603:10b6:805:6f::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.16; Thu, 13 Sep 2018 21:51:24 +0000
From:   Brijesh Singh <brijesh.singh@amd.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH v8 2/2] x86/kvm: use __bss_decrypted attribute in shared variables
Date:   Thu, 13 Sep 2018 16:51:11 -0500
Message-Id: <1536875471-17391-3-git-send-email-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536875471-17391-1-git-send-email-brijesh.singh@amd.com>
References: <1536875471-17391-1-git-send-email-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: BN7PR10CA0019.namprd10.prod.outlook.com
 (2603:10b6:406:bc::32) To SN6PR12MB2688.namprd12.prod.outlook.com
 (2603:10b6:805:6f::29)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f8843a1-dd53-47b4-7726-08d619c30d6a
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR12MB2688;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR12MB2688;3:50mJue67oIYM9TTL5wL8lcrPtl6GtHBcrXjVhJQYL08cyEjNH6Jifk5LSGPIkFx0vdKi2iomWQUafmWlG/VraYJxeU2+M9NmuuohZX98k9METga9rcl6pusEfcjxElTXissccss70j0zsOLEm3RheDtX19azAZqQjnVXA9nLv61CbssbNKa1PCBY/R7KgsA9eZh+R30ELdxMtmbN+DGh0L7BT5Rho35xz/fppp/EM5CtL0P21fiblFbMGpSRIn0V;25:4gos5NhS20DFTfSQDjepzVVhaXO2yhJ6a+kIufQk0IMmVSLMdzfwY25S4vv+YRDqPFY7N7vHIwhj8zTCGGv+wpjztB3iMbM7IQ9vj69AD92VkEh4E8nPuIPprsVUWhE2T15h9rrDTxWE6kAz+4Mfj0kDx4GNLe1en6ZCe0NNDzKuCySuhYCsHGDIFlp9oEZ0Wo9eNEwwRypsq1uVyUS0sFr8HM5Q1FHTifCHXa9tAeyvYuIaq2oQ3WHWAKFtI3qtc+l7DLucRHxLIkxP2Mx3FDS97n1nCK3ZlSylhl3TAjB+yKbprTCaSTlNt9PiBUlm99eUwt54YyY+IDnkHxSGog==;31:7wZyubEObWD06iiuoZ11wZx0lV/+G8s16YKXrbBocoPiXy64OKMuJMHfPGOjS+mAiXmVSBGH3jwBMLiFhC0lsR8bxsF7yB5sn+CWLvoWNZeiwlBb0RkGrJEf1NKvesmuOV/iOT7lv1lreCvqdcTDS02xAFg9rRLBVzqgc7Wsmn3ZlenoIur4IXwbMzWqJVDaEXVQSwikbWc3T3oTiqHU17QShIZzK6utmwQY44rJpBI=
X-MS-TrafficTypeDiagnostic: SN6PR12MB2688:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR12MB2688;20:FQqaBgRwRIDGF/QCSBVN35LWyxh+g6t1leBrBawBZkYsbl6x0HDlMFwTgvECBG83wAo5FTWC3XNiXyPzMza/XmpwxeKZN5vh3Cd1zyTiBi7YQa9yppC2TkitL6aqC7YPLuONDl/cqUEOkUsvciypn5pTiuMli47s6Z7rPP/R6z4F98Xw4i3EcOg7+4im2Tn6U+mHfFEdurIYIwl6acHNXQhemBv0yD1jfjUncRODQ3Nz2Ce62oAATFpXtaLE0Ug1jbq4Kn8r8yywX70lZ+XVuo9RWnWDopq2wlK/tKfqoSWZzVDAx9dVMEIta3S9GvwVpx1/TE2r9NuWsXKd2XCHLx8Wk1I+9TsqEILhaWcng95qujlzN2nv5CVXXQianD61VDDS1RCvGWSODsKIJluXIACZaBGztefozYe7sCYCGgtTOtrRm1WIfYxQL0QLTlx7CEEUL9OI8hw0PrUFmlvOXZcGz2Ax2jBZA9fPg6JoprQhfGeCtGHs3Osl6IqpvNYE;4:BJvfmCPOC0kswvpleiNT6zz10+nhCn31Q6tT52khprTV9zRFNp86r1mJpFmf9NTEyIM6xjHk+XUZcbD4rhPJ71bTp6vb44fdHVghE+GbxKKKhPblgE1xnpoj8pztml67+cTB/1v2UcDfUdAT4n0+v8ePnHSgR+5EzMScLbo0lAb7+z5ZzDDe5Ut8xdpCx50gf/RCl0dTKY4aV8W0qbN01DSpqLWwd/gVXpUdTUrMI3+WKDaNjeKcMGFdRqrj1KYEd0RZdJfxf4bir2Ez830pGrOcK+wUFAH8qASpbEa6zhqvabDTYxX73A+HUXxNP3GKot8nZJAjunr46wO65cZp5BsTJ1F6sWYAvgXYKtFyzGYdAwB4IMk+nJ9AiOMux1b0
X-Microsoft-Antispam-PRVS: <SN6PR12MB2688CA1F67AC41EB7F3EECFEE51A0@SN6PR12MB2688.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(767451399110)(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(3002001)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699050);SRVR:SN6PR12MB2688;BCL:0;PCL:0;RULEID:;SRVR:SN6PR12MB2688;
X-Forefront-PRVS: 07943272E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(366004)(376002)(346002)(199004)(189003)(26005)(8936002)(81156014)(478600001)(316002)(53936002)(305945005)(76176011)(16526019)(23676004)(52116002)(7696005)(14444005)(7736002)(36756003)(47776003)(3846002)(6116002)(50226002)(66066001)(186003)(6486002)(5660300001)(2906002)(486006)(68736007)(54906003)(476003)(2870700001)(8676002)(386003)(25786009)(2616005)(50466002)(956004)(81166006)(44832011)(53416004)(4326008)(446003)(105586002)(11346002)(97736004)(6666003)(106356001)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2688;H:sbrijesh-desktop.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjZQUjEyTUIyNjg4OzIzOkNqb3JqMzZlQmxFMzZVODZWSG1IQmtlU3dY?=
 =?utf-8?B?UzRzcGIyQlhQVmRqeEdkUWRVZ2lwUjZSdUZnSm40QU55M3RpbVFGbGM0NlNr?=
 =?utf-8?B?WmVpLzZXcXRIZFZ5TFRDQ3VtVFMvMWF5VFp3K0Q3VUhqK1FUWlZCTUdndkVP?=
 =?utf-8?B?eU5GdmQzWndWY0RMZUt5RXNibXZYVWNpWlpnNlpsSS9HQ3RLRmZ1TEpvTUVE?=
 =?utf-8?B?S2tUU2I3aEhsak9QVEtRV3dLR0ZmUmlYQk85ak8rT0NUdi9JNlFBNzdacW9S?=
 =?utf-8?B?VEJVbXZ1LzlmdG5Ibjd3bzluYjFzQmIxNUxIUDV1dCs5OGZjdHhKQjlSN0tk?=
 =?utf-8?B?c1diRk10aU9WazhmQkdlNGFhQ2cvV1pSejlpd2FhKyszMzMyaTVsVDZiNlFi?=
 =?utf-8?B?YVBnVFhtL205Ni9pT1BvYWxJZXVSVzczQTJTODgwd05qVTc0dzk3aWNsTVR5?=
 =?utf-8?B?blpDSGoyTy9uNWtIN2pjcXFUaWtaRG1zQXhQZUM1Z2NsVldJWFZiWFhzaXBi?=
 =?utf-8?B?WHVSdnJrK0R6VnVXVVVHbmhIN2YxZ0hyTkN1QS9mNXdxOEZUOUtCZUFIemxv?=
 =?utf-8?B?UXBtNjFJY3BLMGl3MFZrR0dXTHJSRzNwMXI4SDkrN3hSZ0YrdFBERnZidSt4?=
 =?utf-8?B?Uy9CT1pkVmFZczQ3cTZIUGhNV0U5aUtDcFhUMHRRSnZWblJENWJlNkRRSk05?=
 =?utf-8?B?aVFxSnpsR1U3TW1EbDU0cFhlM0NEeCtVdDlSb09CdW4zZHFtNlh3dk5zR1ht?=
 =?utf-8?B?MkxpTVh4RzV1amRPYUo4dElGRHZ4UVUrdy9XZW52L0psUnRRR2VOL2N0Rmhj?=
 =?utf-8?B?dkxyb1JVVFNPVERPakx1NU5mbUVueW1OZ1IwZktheS9tc3I5bnduRjJ6SE5R?=
 =?utf-8?B?cnBCQ2JESUs0OEM4eS9jVFNnd3FDVFNySWFMVE41Q1Q1QkxXajRYSXBTK2Iy?=
 =?utf-8?B?c3N0b2NQd2hXRlB3OHh0R3dncW5RNVpwbXVEaVJrQS95QlM2dHFMN290dHRT?=
 =?utf-8?B?ZnV4SC9reHhCclUvanhkb1NJKzVOSEpUYWNNYzlhZEZWWG1tSjQvQW50b1BT?=
 =?utf-8?B?bDVWeisvTTdnSGh5N0lvbGZKRXJEZUowTVdKTXJjTmhxc3J6M0I4eG1OcHBL?=
 =?utf-8?B?SWJySDVkUzdHZVNuRzVXaUlONVo2Wmo4TUtZTjJLY08wSHgzQVg4VHdCU3NX?=
 =?utf-8?B?emttQW0wa0UrZHZnUEFnNUtxd0pXcVdpNHlIaXhlV1I2R3MwczM1ME9sVGhx?=
 =?utf-8?B?NGgrVnVONHdxb1BwU0FrNTdTUE5oTG82UllQdW5EOG5VNy92OTJuZ20zYThM?=
 =?utf-8?B?S1ZkMW92RG9XdnMwVmlFbUlzNlVZMThsNHY1ZWlaZFp3V3FGR0M3REtuaHkv?=
 =?utf-8?B?b3g0RGt6eUtTMnRiUDhSZTVrQ0VXS0xCKzk1MVFwbWcvZDd1TDJVSkdxSCtC?=
 =?utf-8?B?K2NrcVhYSTI4SThoMndScXYyVHNYejM4cm9kQi9SYjJ3MnQ3eG9RVzlaZGxm?=
 =?utf-8?B?YWxDQ21vbzFIbzRXTEphZFdJcXV6R2tERjBMQmFhY2RMTmtNNWlPOGZ2amhv?=
 =?utf-8?B?eTN6ZTdtMUNhdDNEQnF3Z3hWcUgwVXJyRXdqWUR3V0xVRitXUktxNzRoZTdw?=
 =?utf-8?Q?8xAQQco5A/XNB05W+F77?=
X-Microsoft-Antispam-Message-Info: qEiLOKxpjjes2nH5xTyeJwHFAEysKkNNihbkhKzYH+TDLA6trAgb/BSZYjqEIyC4R9SLq8E6zu8u080hGqbQ+9OC7EPnq1Dp3aWUnEvvJRZt3lS5aVUxPsfoNoMsSP9MsPM+6xH29AaAPup3zF4zio8Ej+Ap2rnY1lRGiXYHqA+P67QxdMcwcy23kFGu2kfhtzQ5Kt1QQJ/SLAMyCvQLEry7TVMk4Wo9U4Ch2qdY646w7G0WGXbJKpMHiRp3pL1iwEmxOx3F5jTAsWzIM6PMcIYWr1Igrl6WoSOH3xplqc2aP4hwoTuSkcZnNxPwe3eFQGaPv1ClFmg1jvBbEwgUIW4kDC34lxGz/NzcqQlLqHE=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR12MB2688;6:hRiOzr67T95hrEX7DRlzUo6SfJW8+lsOw+ljXljjsllGOTX5rz8Wxkm0dgnjIzgMQD+d1fbXeCqx/ACf8n86ZaluxRXFF9uhjLzGfxQG4y+UinmOkt2eMbcPl0wqJd1D+Lk1PzKwWZ5hdBWdXFn3mQSfjOegQ4L9jM1IXA88R33CIbU6kcMxJYVBdlx2shgmKd45mjsIQpy3Tq7M5+UDgjFr/HRBBEfZHTAlvRPDBbeLVVNIEa7gH5XgcTSNNTJONMGu1LR0Xg5vwW1NTBX19uXVwauXTn6ncyGWHODBaaS+tGP6jnRuGvcYF0F9BDfmVD/HQK5vKFlvPsw/7HUICKcdlRW/dELO22xH9GfmO1Sb9eEqOI9EuR5ZIdpZbBQPsmsEk6ztTU/mD0Bf5RZWFTxy3fFULEemlCVH/FQlwoEIA1GPyawG0XROA82LOQ67Z0fPDc8Scfztc/NUB8zHOw==;5:nruUCC0n8Od9/yt9V4iQ1LrCBw60ml0iXGcj6zG9h5Sj0XZjNfsojoennyBHkF5gGkvtHyqGdjQzxej6xJdBngrLbpgiRYUEtslwEDSiTQNc9X2qzUI8SpqEjE9o6ebctomG2P8y1QxHhVTlIKkwofxVWw5vY/1Cm8cFE4LsE4M=;7:NyqVN+wuWwCgSBB/iMYSV3Ii7sWToCvofUTHns9JpqxItr6G3+uFBRIEnLj3/seyOCLIgbZBjuFvjgacqyCxfAZcXRxoUrK3FWNwMCJaQCkZrSj/W+S0c60g+q+1RjLf+TvFzuNLeCZDYa8J7vRn/b1FsYyOjFkIme/btUK2+YBZJOx7zYxo9ffrMfJloO89zVDQjWDWXboEVCUqQMJ56GV0MEUA3i063ReYontuyM8jUX58rmFOcNwVTeUSMVxv
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR12MB2688;20:c5GQ+xURApLXWYOoYg32icNkxdpUj0FWFQuF4GRMPr6LiIIyfm0fXCbtDwrtzWzroz38mO0maXXGEzyxtSeWO78jOoJ3+UA3d+dHD3OyefUbhMXe6Zc85ARmx/HbXzbw4cjveTDtwvgkFCAY8jEBPPasP0bPh/xRm1KpDqo8rwmDG87kbZAWJLy3KPPOOf3CBxJuuIeAkT0QxbRC7ytOASsH7JxyH94U2ZwcYVGuXMcZvHz3X9+fB61yREHJGFfY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2018 21:51:24.2804 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f8843a1-dd53-47b4-7726-08d619c30d6a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2688
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
 arch/x86/kernel/kvmclock.c | 42 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index a36b93a..84f29f1 100644
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
@@ -236,6 +238,35 @@ static void kvm_shutdown(void)
 	native_machine_shutdown();
 }
 
+static void __init kvmclock_init_mem(void)
+{
+	unsigned int ncpus = num_possible_cpus() - HVC_BOOT_ARRAY_SIZE;
+	unsigned int order = get_order(ncpus * sizeof(*hvclock_mem));
+	struct page *p;
+	int r;
+
+	p = alloc_pages(GFP_KERNEL, order);
+	if (p) {
+		hvclock_mem = page_address(p);
+
+		/*
+		 * hvclock is shared between the guest and the hypervisor, must
+		 * be mapped decrypted.
+		 */
+		if (sev_active()) {
+			r = set_memory_decrypted((unsigned long) hvclock_mem,
+						 1UL << order);
+			if (r) {
+				__free_pages(p, order);
+				hvclock_mem = NULL;
+				return;
+			}
+		}
+
+		memset(hvclock_mem, 0, PAGE_SIZE << order);
+	}
+}
+
 static int __init kvm_setup_vsyscall_timeinfo(void)
 {
 #ifdef CONFIG_X86_64
@@ -250,6 +281,9 @@ static int __init kvm_setup_vsyscall_timeinfo(void)
 
 	kvm_clock.archdata.vclock_mode = VCLOCK_PVCLOCK;
 #endif
+
+	kvmclock_init_mem();
+
 	return 0;
 }
 early_initcall(kvm_setup_vsyscall_timeinfo);
@@ -269,8 +303,10 @@ static int kvmclock_setup_percpu(unsigned int cpu)
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

