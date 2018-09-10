Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7589C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 21:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FBF520866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 21:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Vas3Wv1m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FBF520866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbeIKCp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 22:45:56 -0400
Received: from mail-sn1nam01on0063.outbound.protection.outlook.com ([104.47.32.63]:25492
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726217AbeIKCpz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 22:45:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eKvQDgTFLscDgbQUR++JFzq2ef9N4Y5hdB+2IUJue2E=;
 b=Vas3Wv1mhct41WwXcSD6c10vNrHPTlTJaTOxi5iWvgYGYjcaFdyPAzEdHgz5hD7R9vC3iNk3+Sw1FdEgRlPEJE4g8wLntfNaapaml9bcvWKaYPMfz08YzyKIfmjwIEEll4KVv0YcFAnIf2SGP9Xg6VpBJ6SolfJoQr3YPbA9Doo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by
 BYAPR12MB2680.namprd12.prod.outlook.com (2603:10b6:a03:69::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.15; Mon, 10 Sep 2018 21:49:29 +0000
From:   Brijesh Singh <brijesh.singh@amd.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH v7 3/5] x86/mm: add .data..decrypted section to hold shared variables
Date:   Mon, 10 Sep 2018 16:49:09 -0500
Message-Id: <1536616151-16738-4-git-send-email-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536616151-16738-1-git-send-email-brijesh.singh@amd.com>
References: <1536616151-16738-1-git-send-email-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: MWHPR13CA0010.namprd13.prod.outlook.com
 (2603:10b6:300:16::20) To BYAPR12MB2680.namprd12.prod.outlook.com
 (2603:10b6:a03:69::29)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66acefb9-4ee3-475d-53b1-08d617674a27
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB2680;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2680;3:2ghb6STWDQKeqOyQoIDC1EjjwKEF4YMAPSajS6nrw5PgQVIxYOb58epyv+isfWQpC27HD2qTYOW2MV0fwV4soPHGJkv0/4tOFzzc76O6jf60rVuUnBcDW04Eao7uJc01/cRoPPfNfoK24kfugDWL4oIaWaTkMgwNs3mXPgB3uigWgAuik5q1EL11zftPEuI7QGG5NvrqFRC4tfE6lTESMaEded9JgWOGDfLa+6Bnot+AL343ZfZnrcMeLaTBJEDq;25:irqPKtWxpAlLtm0eyW5x4G+/+e/JEGvulN3vuXr6pYEg2EzbGokk7a5ytedngsWWFpcnbq7eWylEeKY2rMdqiVi1HwZ6tYnFmQDyIsinpWaHZGdkS8cD9KW2UmoP2sr+Hw3hcpicXqWQ9Y2xPBn9KTrvY3zySs9A27BP9oYFMcOUbSBIOQ9aSJon2hRv17jGMtbG9GvtLdQfvK4ub16xfEwWdks2X2Eon86rCY3Lk2E8nk/vjQcwvttgi5ASqgUnpuYFFHt76+mGoeFafzxUIEnliG2oUBe9U2PM/4uE7JhyPzsr1/M4n8iEsDXwMpCQygjfXfqPG83Uv5Pz1QZL9A==;31:6BTC45Ey0eWlpAWVsgTjfjhOkl2YXOqPEHVpBfb28Qh05jBdXTuVq8W//wOoUm0kIyBaSS2l51DtMgSdV7DxM4z1cXojeubmUAnSA1cd6nmltHP+LNDtb3Xy2imaSX30heTuiR2zFZPCmYPNnvCBuykyBOrRys6Bn6UhciwFHY7dPytVA2dm7qoxMf2eutx2/3QEVQpWbspWJLtSzZII/Goa0J8jF8HW/uIG8mghV24=
X-MS-TrafficTypeDiagnostic: BYAPR12MB2680:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2680;20:RLIP7OiF1hWLaUvCjlBAgQzjkvflecVVJpAQu+wv4hcqKsKM6lxa2el+ojt8LQbzZft6vhWbA5qSKT+tAy8mUJDZWkkW9TlAcprjBKBlP7tqTVeDcPisY7Z87v41TYx1tcI99AqwrDcly8qiSnnQq3vqIOXd4c+fZhpZy6kBjkZU8fZo+8vWXaflxRh7L2tVB03j9rmQ0BcXUf3Ov1Q5YU1OPb3J2FMR9x/ayQBTpA4Yzs1nSI7yyZIZKC4Fb2paAqGk9u7nAYN1IcTlJyV2LqNzgxIDxCdcu4C7Rj3xnjedHfCNLVk9QUPKnY+9z9IEunZNhF7lbQUXLFRDHwK3kyzXmy2vnHIVSlBxRfqIMsJOluynPyjFDANphJPZA0vLNDQPFMoHrIbhXTYzSV+46SwJ3qjx717tm4tOtloAwQGLHCrntUXvxBqyCSAsOjxMOzRtsYINkT8c3ZyDGs4ZWyMQAkKJawAsg1zCvh8/lb/efkhOc0cVpNswQgb6RoPY;4:B1TFipDb1TuniElRgo0gZcyc9o1wCf8QE1+MLVbrJ5M1fA+xykWRJprBckyKTzBEpV3Y3eYQQA3jNQw8aLFyKgCxPv2LP/5PGvbYKttDSAwzvVdolyvw++dhdAy5f3f/0cYFYJ6a57R5DTYfGwIciLGSPJjICrT6mLD5jbxpH2LFltnICs4EwOZkhRq705ca4wqDCyOP6OZYOK0KEzOs6hfyh81xevQklCxCNlJnhhCbABxdfavAx5G+G/woDDQC5Nv1xQa0l+j8G7x+BgMTp06vtZWk1Bju/wwhUyLwI4ws2pGRJzZlN44Y2qOqurM32+/bzP07ZqjEzJOh030W++WB7onAKDNC3mmWSbv0oH20EMohMax4JL4h9ft+OpGp/aT8Evz5HW5vW/hWpf+8dw==
X-Microsoft-Antispam-PRVS: <BYAPR12MB26804AFBAEF275328161F971E5050@BYAPR12MB2680.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(767451399110)(163750095850)(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(10201501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699050);SRVR:BYAPR12MB2680;BCL:0;PCL:0;RULEID:;SRVR:BYAPR12MB2680;
X-Forefront-PRVS: 07915F544A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(346002)(396003)(39860400002)(366004)(376002)(199004)(189003)(6666003)(386003)(8936002)(53416004)(7696005)(52116002)(25786009)(23676004)(76176011)(105586002)(8676002)(106356001)(50466002)(50226002)(26005)(186003)(66066001)(16526019)(6116002)(54906003)(3846002)(47776003)(2906002)(97736004)(2870700001)(4326008)(316002)(81166006)(36756003)(446003)(81156014)(476003)(2616005)(11346002)(305945005)(7736002)(5660300001)(956004)(86362001)(44832011)(6486002)(68736007)(53936002)(486006)(478600001)(142923001)(101420200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2680;H:sbrijesh-desktop.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWUFQUjEyTUIyNjgwOzIzOlVSNUdORnFpNDAybEVkWjZINFo2ZHptR0Vl?=
 =?utf-8?B?a2U4ZzlUK0UxWVdkVkZEM3pTQXRVbGNrQzlMOVFjOEt1cXBVOEZUQ0lCcmwx?=
 =?utf-8?B?eW1QeWE0MlJmRGVnZkdwTDFYTmF4SFVZRGJPSVRqSFhSU1ozQ1RCVTRaaGpM?=
 =?utf-8?B?WDdqZFJSbUlPUHM3MW44YmUrREJvajQ2K2RHVnM4OFRiMWhYN1QzK1FxRnhj?=
 =?utf-8?B?eXcxOTlwYktoYkVhRndqZ2NSWDZXMVpGcTQ3OHBIU0djc3BiWkQ1RHVGSVBn?=
 =?utf-8?B?ZEp0YUxJQ0xQVFdjS3RWcnZCTGdkQ1BiZUJqSjhwSUxWV0dRTzdWVndRK2ZD?=
 =?utf-8?B?S0czbHFtQi9WTkdMVVdZaXlHOUQweWNWV0NKV24vYkVIcFJ2NWE4L3hQYzR5?=
 =?utf-8?B?Um1jSkxXczRNY2RPQWFQMlIydXBpQnRaTGV1emx3ZWcvblJUc2lDYlNIN2ZV?=
 =?utf-8?B?RHA4TUZSRVpqTnVYMnhQcENob2tSbkExTlJvQW1KQ1R6NmwxV3k2VTRvM3Zy?=
 =?utf-8?B?NTFyTWdrZEhrZjREZWJ0RG00UXhsYWtpRElxZExIMWlidEZ1a3E3ektlYTlS?=
 =?utf-8?B?ay9PcGNKdjVyVE9yQ1RhS0ZJNjE0cVgxZm9RUlNhdkZ2dnArbTlCY0l4d0Vp?=
 =?utf-8?B?TU5Za2FVVUhEU0FXNUV2M1dVaTl3UzhwKy82R3JUOCtJQVpiUGpIejBYVVc3?=
 =?utf-8?B?YVRrdmROaVVBSm4vVHhMR3Y5ZllpWElraGovUnJ0dDZLekFvb25udUhXK04w?=
 =?utf-8?B?ci9udmNtVFJ1OFJSR3N0T0liZUpGOXpKR1RlQ3ZZWEpWRzJUZ0FWeDNBVWtO?=
 =?utf-8?B?VW1DZXdzazN4Y3BhaDh3MWphTU9Yb1dEZ0l3cWgxVkM4eGNudVRQU28wYkl5?=
 =?utf-8?B?Z0ZiZlJhdDZGWlY1YmtlOUtncmVQQ1R1MFlZcXRMWkFscXZ2UGRYbzY1eHda?=
 =?utf-8?B?enl3OWFOSnBBYUJ0b2Y5WjZSSXc0YUlZeDZKalo0VGFadVNYZjRHTUtyam9r?=
 =?utf-8?B?Yk4xWUUyZUdBUzVJWjJSVW82NWxnV2tySnQ5L0RoeEpYVXkwdSt5UFVnQ2NH?=
 =?utf-8?B?QXdsTzNnQUxxaXI4OTUxekxMUlZNcXFEbFNGT2Mrc3NaYW9hR2VhTWJKemp2?=
 =?utf-8?B?czJNOGVYQlBObzV6RkFZbVYwUTcwSUVPeU1rZjVyTU9qOWc4SS9sS3J5VjVy?=
 =?utf-8?B?Z3JBQ3oxM0VNRzFBZytCajhaV1pjMmtYYmJ2RkdHUHpLY0ErQnpsQzhDNWln?=
 =?utf-8?B?UGpXL0IxdlNjdkt0MTg5VldDQ1lxbEFSYWM3dWU0cG1yWjBzRWVobjhmZHU2?=
 =?utf-8?B?KzFZREhBSW9uNWFpcG9hcENWUWhnVnExaXdiVnh2WUJJVDJ4ZjdpR29Wd21y?=
 =?utf-8?B?ZGdDSmIwNysyYmk1RXM0NDd1L21RZEFhQWowSDF5NXBPcHU2M0o2WXlsanJI?=
 =?utf-8?B?Ympkcit0aWFxR2hvR2hGNEwzKzJ6Q0VLVzF5ZGtYRzNlRnFMT0VwYTJROXBQ?=
 =?utf-8?B?eCtIQ0tKVVoxUGdnMmZHdmRqcjZuL0RubmhhVUpRdFNNMld3d0FvaHJ0OEFM?=
 =?utf-8?B?M0pCaUJaOE1LZFoza0dyUEVaN3ZrNmlKbmZGOVBYVmRSQ0dxQ2FSZytNaU8v?=
 =?utf-8?B?eUI3bGtnK1BINjBjL0FhbzBPUlAzc0F6S0duYmhPWjVHR205MHdOczJnPT0=?=
X-Microsoft-Antispam-Message-Info: 1uhLsfNFT7v1exWJi2BXz3ORROwGPFwLGhpi85zFL8aSwv3S0OncRZou4XdoAqnxLz4z3gPuh+lXSd7Qut0Ple/ZanP80cTK8HEx2Gs8E3eMIxAJLJ8GRmfj3kH+xXZ/Gc9siTkwXF+RLTqrelpE2K3cHYq+JKDd+s9+Qi5ryZa7hiTtSHz12qPRHgfRd9JtnW7jjJYGJ/qX8aQDbCpJvkBasjBpteTR6znpfknZAEJS8nC3qcNF8EE3bUEeruHsl0P1ewBAkP+fX5hcPfUJ4AmifU0lT99oWO7UEQUJCxp+ipO3rPoa77Xm6Ai2+az59I54dZQUAYPuRii8MYSeCY/psbPJuirMv1uwsdT3Y1A=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2680;6:8zV8WIzXsYkPR8Ue0+LnQhySneA/4+toQloPtnE4OGIkHMuOgSKAd8C5QvOJWFCP6iEp9+EmBiLQyDYBGFTM4Lr0vJF2hD5rFOlumVpqAFmuv3K6GKT/RMVN4ZmErXLbK4D1Ay5Z9XsHABjvJxZATvywFtInbQB7nmHhqMMNOTOZlAvV+FH3IP7EmD82ax2j/rCBMv28gvoAhWcOQ3O1vCx081waysZHdOAgyK6Yi78p/gLHlrQ9SNR8oFP/+GzaxjDSuTTiq47NmXF1Esihhh1/PNCb/7iOaDNxcAdxpWH2lCx9/STO9pckLTEii74AiZDy+A6cqfxzCcP0xv5q1lO65cxNSJXlg2U9BU6TCvqTkIt9SEiE0kZh423KpdVkcYZZdFjO92k8gO2OHguWf67zSgBKn4i2i0ubzhzPS6hQk3vLqUH8djnD/qdU3gBQ5eqYPoFKSRFfDKBeq7pFrg==;5:LYm7rho3nhsMXxnAcrXs8MmaHzbdUTs+Zr7wtqjMbIDxsmuIDBwZTMD6yLqKdLyvjl0OSH2lXvwBL4B1Y2z0s//Yon8KWAw35KFNZcNPBg3iOmiBNFj+gmZIgMqY0LmAaV5ueEAmF3XfGj72/T0s7FFnoA4WPJ6np6l0gBDDbSQ=;7:RSZWm1xTDYTTF9rRdLDkbReZRvV4BOAwePBBUpTHLbCfED1RIx/yVKCuB9wZxVsXb7GcyvX2YC6pIJIccGWe8n2dNrKmpvt5gQT5yzqoauSy/CeOQhN6Bia0/1/lZCIxzeLnbnu96jqKlfE4+ujtleG8FQWz7+jbu0fPhVvrEE2YNpRpp99vz/J1mcvoyBUe5hGVT382oELPs7jIH1qAXZeNyez1MFMJ4RODhbNw9UT9ctDwY9NnRChxLr2Jul6O
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2680;20:bsZttWhAjm6Gb0+TZPtJl8uzh6BhSMXT+L80SXH+hkZ/iF5GWyLhbyu5pPdsnXkJgAoDBmfY8MtsolL4xMbVKS0W55eDbhl7SNtnkH4pcmWvY5HlYHZvDS68D/GVuS6B1wzIZJ1NQRGOhY2J0UB6aJwt79nTHtQ7RdKvpm8Hruihx+MigbZ/4MNSOT+Rdb5QHqmTqi5ygAwoZH+u3IP5YvGUy3buvmv1dhnt5qlOjSKLIkenrVC6a7Wt5QsapkQq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2018 21:49:29.9766 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66acefb9-4ee3-475d-53b1-08d617674a27
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2680
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kvmclock defines few static variables which are shared with the
hypervisor during the kvmclock initialization.

When SEV is active, memory is encrypted with a guest-specific key, and
if the guest OS wants to share the memory region with the hypervisor
then it must clear the C-bit before sharing it.

Currently, we use kernel_physical_mapping_init() to split large pages
before clearing the C-bit on shared pages. But it fails when called from
the kvmclock initialization (mainly because the memblock allocator is
not ready that early during boot).

Add a __decrypted section attribute which can be used when defining
such shared variable. The so-defined variables will be placed in the
.data..decrypted section. This section is mapped with C=0 early
during boot, we also ensure that the initialized values are updated
to match with C=0 (i.e perform an in-place decryption). The
.data..decrypted section is PMD-aligned and sized so that we avoid
the need to split the large pages when mapping the section.

sme_encrypt_kernel() performs the in-place encryption of the Linux
kernel and initrd when SME is active. The routine has been enhanced
to decrypt the .data..decrypted section for both SME and SEV cases.

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
index 9c77d2d..ae8153e 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -65,6 +65,21 @@ jiffies_64 = jiffies;
 #define ALIGN_ENTRY_TEXT_BEGIN	. = ALIGN(PMD_SIZE);
 #define ALIGN_ENTRY_TEXT_END	. = ALIGN(PMD_SIZE);
 
+/*
+ * This section contains data which will be mapped as decrypted. Memory
+ * encryption operates on a page basis. Make this section PMD-aligned
+ * to avoid splitting the pages while mapping the section early.
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
 
@@ -161,6 +177,7 @@ SECTIONS
 		/* rarely changed data like cpu maps */
 		READ_MOSTLY_DATA(INTERNODE_CACHE_BYTES)
 
+		DATA_DECRYPTED
 		/* End of data section */
 		_edata = .;
 	} :data
diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index 2b245af..65da705 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -52,6 +52,8 @@
 				 (_PAGE_PAT | _PAGE_PWT))
 
 #define PMD_FLAGS_ENC		(PMD_FLAGS_LARGE | _PAGE_ENC)
+#define PMD_FLAGS_ENC_WP	((PMD_FLAGS_ENC & ~_PAGE_CACHE_MASK) | \
+				 (_PAGE_PAT | _PAGE_PWT))
 
 #define PTE_FLAGS		(__PAGE_KERNEL_EXEC & ~_PAGE_GLOBAL)
 
@@ -60,6 +62,8 @@
 				 (_PAGE_PAT | _PAGE_PWT))
 
 #define PTE_FLAGS_ENC		(PTE_FLAGS | _PAGE_ENC)
+#define PTE_FLAGS_ENC_WP	((PTE_FLAGS_ENC & ~_PAGE_CACHE_MASK) | \
+				 (_PAGE_PAT | _PAGE_PWT))
 
 struct sme_populate_pgd_data {
 	void    *pgtable_area;
@@ -232,6 +236,11 @@ static void __init sme_map_range_encrypted(struct sme_populate_pgd_data *ppd)
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
@@ -379,7 +388,10 @@ static void __init build_workarea_map(struct boot_params *bp,
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
@@ -436,16 +448,27 @@ static void __init build_workarea_map(struct boot_params *bp,
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
@@ -488,28 +511,69 @@ static void __init teardown_workarea_map(struct sme_workarea_data *wa,
 	native_write_cr3(__native_read_cr3());
 }
 
+static void __init decrypt_shared_data(struct sme_workarea_data *wa,
+				       struct sme_populate_pgd_data *ppd)
+{
+	unsigned long decrypted_start, decrypted_end, decrypted_len;
+
+	/* Physical addresses of decrypted data section */
+	decrypted_start = __pa_symbol(__start_data_decrypted);
+	decrypted_end = __pa_symbol(__end_data_decrypted);
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

