Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1EF2C43334
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 11:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E3E2208D6
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 11:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="SUOYkpWp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E3E2208D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbeH0PLR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 11:11:17 -0400
Received: from mail-sn1nam02on0085.outbound.protection.outlook.com ([104.47.36.85]:53246
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726887AbeH0PLR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 11:11:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Alz50+TBGwFo4nlSvyV4wZOOOjLfRlHAkD+w4zEJ48Y=;
 b=SUOYkpWpIGHyj2Ub6zRGBsWHU9EQFc4Tjkfe2chC9XRkINa0TvtZzfPVX+IOlyjDig7YyF1DmAtDn4IVseGORQMRCLyKe7zgyhypvZKOfuGewp3m0lPSB4PHBvopLgHyKCXGkKqXtL2eayASIG0EgMZoj6YK1FwTNpgSEUGYWAo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by
 BYAPR12MB2679.namprd12.prod.outlook.com (2603:10b6:a03:69::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.17; Mon, 27 Aug 2018 11:24:57 +0000
From:   Brijesh Singh <brijesh.singh@amd.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Brijesh Singh <brijesh.singh@amd.com>, stable@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH 1/2] x86/mm: add .data..decrypted section to hold shared variables
Date:   Mon, 27 Aug 2018 06:24:39 -0500
Message-Id: <1535369080-20290-2-git-send-email-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535369080-20290-1-git-send-email-brijesh.singh@amd.com>
References: <1535369080-20290-1-git-send-email-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: DM5PR21CA0011.namprd21.prod.outlook.com
 (2603:10b6:3:ac::21) To BYAPR12MB2679.namprd12.prod.outlook.com
 (2603:10b6:a03:69::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cab76936-5413-4b0e-e672-08d60c0fb8d9
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB2679;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2679;3:4s9tZSHHnwQpbjsD/lpF+axJ0ZNYLZwhO+d5jzN6Iz+NdL3errb63V7CjPbod4EN+kiIqL+LHfCLqGw03Ise/waODnpORBiRAQK89CLCscZU64ZJx5JsbYYU6JWa18ykRa0UKG/mdijqvdrqg2QfO4/ne3Xh/ATnQNM8+yOSdQgJFquG0+i2gaMYpb/1AiGxL8X2/pIL1G3jtdUNtUryzD9HqeueAXZBWvqVQwiCwePaKcSiDRCgndOGP4X41iA8;25:7El62hnz+r4RDIlrc7XNekvNIRZHO8hQGCCHQ+mVlS5BU/CPdbjAvV5c2RA6l6SFMHOrdcC35uWBOIcz0fF7d1ukRqt+s8HJZqBeQiyoj6VPAr2r80TvKkOu8zyAppRj4v/LW/oEZjZqUoqDdAq80yUPpEkFJrsFDcuTL+bllwo1VIeeKT5kehKzWCh+NKRKBnbrknOku9IIDOHiUYXAADN2cSYimwpShi+2AFe2nJHvnEJE/GqEMyad6zq0ffMWD71htftJCBuJbfd632Grht/Wkw85MIBt0HOeU7EVLuUT5UrDOhvgURWbalFVxQag9LmTWuiOWJiRP/lBK16gGA==;31:8Mu6258CIdHD9LKFINmTmaLARUkUPgIqD6OuBan6s6M1GVkB6cGBoNZpV4bLvAHn7y7nLRlrAT2j+wBRSzqN/bT8gXz86R4wo5FKba3LrPOLeei/sWFA+wttAIu6OeAFNPSBlCUPwms7OtcmNI2m/EmW5XLSUvt3atqrrFeTPCxP4zudHmN0fbPkKnHUgv0ON4vQMLyShgGbD9HG30Wf/LgTbbdsySLzCb1+tw8twOs=
X-MS-TrafficTypeDiagnostic: BYAPR12MB2679:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2679;20:R1IluPhrTbZ/4L0QzyJ7gaevo+8fUtwkiXwjcKBCCRZQZzAe6mb8AA94l5BnVvHC4y5OKiZKM/1CzJehaFf9vi+Sv1PHOGGUJbal0KZtkyxQpocTgbzwm63W+XQhrwxLWPRgEBc6V183gls+Uu+fwOX3DMCwB4tGmM3zr3ROnX7LF627fyLN7RqKcGsxfOD4dze3OTk+XD4YxpKGHnjWJbWAnLbm+1Bu621r/KItU6GbTbj0/ql+4lXaO3x1IeKUHcFruLq+nDhsf32kG/wn/0AZDz5sdmw9CodjDVC19LU5mOz08/lEckjKfXSuWCu75uNmZgBiZxAaTRma+/2haNnimrFU7w8/ujSwIdqOUqX0EYahxvHpAGBPEaaXft7UvNFpwRrqzt0dg3b47IQlif8V9qcu6mBmJOC3w5d4Hw99whmpWnofTYzr87wttFESQ7wTx7opK5felL0LHIN55iR23YXtFEV7qZOGhWi5/dwDNUqN5OmqV8u5NvmwC4+/;4:2KFh0HpM0TFxny1KEShzyy62gIPZ7TvaPa64Hx+/U1h72vBQhWzguOXxlH0mVcrPtJz48ZniTiOj0Un/gKzT36jXZfYweSfjRBT3Pb7TlhjhPJ5MOVLIsBxpnQaSvOezu4GCWMZeWoZGm19m70jE+lip7aRPwN8mSsN97UFLNUw3+awjprh4BRX9vpUokNiIlGjR4JQp1cqTNu+RTOgyQdMCfgHLLJLVBJjsJI5PAtkofDhK91NZUCnlI3xxE5fOWiIuO6xudgpEdNDY3b9E8ok1/8IgxPpqdt/olR3dAdyoulnvZUgKXCq1ntNCApG/Olb/UAN3OWEOFhrNMmkwDgc5HB0pdse+uS1BW4E+P5pJv+n+WY6skrONZnb7sYVFZw1aOcpargp12mcaZy9v4Q==
X-Microsoft-Antispam-PRVS: <BYAPR12MB2679CBBC9EE6FBD7322057AEE50B0@BYAPR12MB2679.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(767451399110)(163750095850)(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699016);SRVR:BYAPR12MB2679;BCL:0;PCL:0;RULEID:;SRVR:BYAPR12MB2679;
X-Forefront-PRVS: 07778E4001
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(366004)(136003)(396003)(189003)(199004)(5660300001)(8676002)(81166006)(81156014)(25786009)(6116002)(4326008)(7416002)(23676004)(47776003)(316002)(54906003)(575784001)(86362001)(97736004)(53936002)(44832011)(76176011)(7696005)(52116002)(305945005)(3846002)(7736002)(50226002)(2906002)(8936002)(16526019)(186003)(6486002)(105586002)(53416004)(26005)(106356001)(36756003)(68736007)(476003)(50466002)(2616005)(956004)(11346002)(478600001)(2870700001)(66066001)(486006)(446003)(6666003)(386003)(142923001)(101420200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2679;H:sbrijesh-desktop.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWUFQUjEyTUIyNjc5OzIzOkFNY01uY2dJZGlYSVBQUG9vaGxiWU9rRTRP?=
 =?utf-8?B?VEpwL3RCOVdMc0lvN1EvVFBYRVBDTmptU2RWbXgvSTNaTVVrKzJkb000dC9S?=
 =?utf-8?B?Zkd1YVNFblJpemc0TFBpV3FkM2Q2TU9naG9OSjJLcm1TbGZ5T254NFk0anVR?=
 =?utf-8?B?TXA4SjkrOXAvL2wrRnl1RjhvVk85ZzhOV0o1aHcvTi80VlRseTVSdmx1SjBY?=
 =?utf-8?B?VER1ZzdITjVTYzVIbFNvcFh1eEFDdnZIQnR2RVZrdWF5cDlFdHcwWmFmQjJT?=
 =?utf-8?B?RlRoQXI0dDBNU0krRmFmTFJiYkdHOURob1lKcjJ4Skp0YWpmWEJDTFBpQlg3?=
 =?utf-8?B?NFNVc0JZL0Z2cE50aEFXZURCY0ZnNE9reUxWRVVhRXg4SzNnclFOUzFKL2o0?=
 =?utf-8?B?anRKTXBpelEvSmpJVDdHSWpVKzl2Q2xubWN5RlZGUnF0eFp5U3VUL0FNTTlY?=
 =?utf-8?B?a25EOHozZ09haEVCejV1MUphckp5VVpia3JiQVluY2RTK01UOWJLQ0tOajI1?=
 =?utf-8?B?V1dCblZveWFOTGhLdFpZTzVhSjVmb3praUJXV0dTc1JObHRLVTNndHVCaVVJ?=
 =?utf-8?B?UzhUWUpwR0l0eWJzVWFLU3NRZ2VwNXFyaWp3Mk9ibzd1d0wyL0JRMzBMRmZM?=
 =?utf-8?B?SXQ1dk5nSnFCR3lDOGRhZml4L1VDeUJqNzF4d3pVWEJZTDFURGZlYzAxVEVS?=
 =?utf-8?B?bGV4amxZR3pVT3NlbDNSNjdCTTZGZm9YbmNBQ2FmTllCLy83a3A2YXd1azBv?=
 =?utf-8?B?SVJjTmVkUUFJT0xPNXRZOEdiWU50bEg5MlZ5aTY4NnJueFkrUzI0Q2k0c0o3?=
 =?utf-8?B?T0dCUHZTbEYyaDlwNUREbkZpbmhZRUtpT1NRZ0diUkNmbFU2ZTVJT2pXejNa?=
 =?utf-8?B?VmpaL3pFby8zc0E0dWhNUmlFQXpPT1NjV3dFN3oveE80UnNueXhZQk0zODZ5?=
 =?utf-8?B?L2IxdEd5SFVkVm9pSE95dXNYQWdOWUN5RUZqaXd5ampveVQ2YmhnOTBENlRy?=
 =?utf-8?B?QVpsc0MxSG5OTGVZOE9qWjM1eWNUWkF0QkgyaDJEY002UmFBTmVKYnR4VEdz?=
 =?utf-8?B?L0lNOWpQSGxpRXpZaytTQXJQaGE2U3BYalg4V0ZFQURIRHV1L0J1VnFPNmxs?=
 =?utf-8?B?Vkh0YVlnOFpvUGxkblVjMmx3aXJseXZXU0Z2NTBUQ01JaTFzeTNxS0k3MHNN?=
 =?utf-8?B?WUtpdFc1Y2wvdCs0Q2dVNzRZaldTSm9uUmF3MDNkTG41Qi9MZHM0eFgwK3di?=
 =?utf-8?B?UXZ2RlZHTlJTUi9WUWVUVVJHNHpaNUp3bVBXS1Fqck40djRjc3VTOVZJRzlm?=
 =?utf-8?B?L0V2bGRZdlJnQ3pFb1JhM3pMVlZKclRoa1ZacEpoc29lbjJwOGFucWswWitF?=
 =?utf-8?B?ZHdDMWxLc1l0dnlxdjJaakJUbTg2SnFHL3ovbmVZOURTU2JZVi83Nys5Q2lk?=
 =?utf-8?B?eENTb2crMlV0N1hEcE5lM1Jid2JublZES2syemdyRmNpY2Q1U0dWaXVuU1Na?=
 =?utf-8?B?SjQ3bXNqS1RiRnlPZmROTk4wU1RzUmVzZmIrd2N4Y0JMREYrYVFFb1VZYkJD?=
 =?utf-8?B?cnE0c1NUMnlkdkttbncvM2c3ZEsxTStCaEdMREE1NC9ZS1pnZ3NESWhDdDFJ?=
 =?utf-8?B?eHIvQlFqSFFsMHNza2Y5Z3JIM2RPTkxEVCtvRFg5K2FtM25TcXNGZVpUSTlR?=
 =?utf-8?Q?FIODp/MOEskKqK3JUoh7QQ+nCPkCcZU+lR0nNX3?=
X-Microsoft-Antispam-Message-Info: lnGQ08X/2EimUyji5pMe3hNOhKjGHqWHyZVAdLqnBxn6R6HTg6aAI4Z27BBgBALStsxEcwoui11517ZYp8Rxh2O3HTTkSSyyFuJK3gM7IOyWcqPpvPfIe48paBr2d8V/KlNiBRwHpyMawKeklNt880UiO50rkVstgxDG4Ui2uC8v+EBvtvVa3/breAzBMolxFT97r/cVHNQIWtCqbAKRR6GG3sVdT0xBMLPbiA5u+zlOy/krS327iDl8ga3XwNEs13GSeYhg9Eaysp8L2zjvnpYmHwGa7uD1d3Ovf7BeSqWJdZZw1PWuO6JFloZsEeg+uly3zPEyfpSP0IHUVmS1M3ZsmzNE70s3rsjleD/5QwU=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2679;6:+rjp7uJTdoR/4a+t6mTAT9DyOBPGiI1eY5QNTVNfV+7J3hFmAfWG9iallq57wHQVKLxZ8f96YBWM2S6o2Ma6T0BDX4XlJ1FNaJtUdn0wWWZBsB59d1h4J7J7eT4W/3KlsejDIm3rZ+rHfwzWS3GMrxJHxEL1BcMTr8S9w/QkU70m7Ex4TegEuDiKO5fkc8nrEXg0zBgUzh3mn/w8MorAR8QgU8iuEgC2v3PvatHVbx81DdAaUm4V89jR0cdl1AzRYLuY8FpWe2LF3wn2fhU/h+UI5fAVaPm+5lNFBZ/LqzyyHKsUGa0m/lzyE2lcMsQct2t2zAurpofjMUjRe15n0szZDcE21z7xDfDosWFfuT/qNqZu//0dASXAirq0e4AG6r+386ggMx/glW2NNrQtjwfSBs8CYqv+Jy0XgZOHvnvY+0qifEgv27z1nMHc8pXSUz4Yfp6oT7nRCVKtkWn2wQ==;5:lr/5ubWnzKT/dBfJLLP1Dxel6jCyUiLJM20d6AizRVVYwuy9zAKUqjkFxJ9VI13LkvKaQW4dwObFWYUnFlpeLAGuQPA22eBThcZHahTE0do0oyEeYioyxSSxQCQL+/0d86PQqw+GykblIEHHiQrF8DHJon3LS7LLB1wi6MdHMhQ=;7:Fv3xQDDfh02b6SEg3jGdWSc/UHT1QgIZFr3VsauCURpgJ5YHK3ilr0KwHeqnufPHIb5ZJB++QIQVF1DYuRauXChsTipzENjVJHFIjFD/eZwMHfNp9s5LvSp1rXzD2BWqGIWtXiRYCbjyiRf2oKNn79Q+hHVNP7x4sYw7Ay8FeSUORf9Lzsbaud98HriU5WbFPHl7csoVlwac/NLGMODE0UGGhpXj4+NquBZ6BBSm7QK40gbDC9p1G0s33vWclPdk
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2679;20:+scXw+EEPVgPZlxp6I5HAXmubQq7fs6tMe6/mhVwog7h3jwrmdxcnPJpNejJyYi1xTlkhhSinuWF6dV+V9HkokTuL98eYQpgNbKDHmLDyVX2JgxYzucjXD7Dn0aSBoOxuj62Z39ni4XYkXsWYh+VFE/k9e10vgWC4G2DqtqfDtJgvKDFolsj4D+8AZMSTlojNgEg6aS0QkyRloVrF9ct5bJ8UyiKS2BulCsnW4Y23sMMRuj+gGJUGQby6VLoJKy5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2018 11:24:57.5478 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cab76936-5413-4b0e-e672-08d60c0fb8d9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2679
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kvmclock defines few static variables which are shared with hypervisor
during the kvmclock initialization.

When SEV is active, memory is encrypted with a guest-specific key, and
if guest OS wants to share the memory region with hypervisor then it must
clear the C-bit before sharing it.

The '__decrypted' can be used to define a shared variables; the variables
will be put in the .data.decryption section. This section is mapped with
C=0 early in the boot, we also ensure that the initialized values are
updated to match with C=0 (i.e peform an in-place decryption). The
.data..decrypted section is PMD aligned and sized so that we avoid the
need for spliting the pages when map with C=0.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Fixes: 368a540e0232 ("x86/kvmclock: Remove memblock dependency")
Cc: stable@vger.kernel.org
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
 arch/x86/include/asm/mem_encrypt.h |   4 +
 arch/x86/kernel/head64.c           |  12 ++
 arch/x86/kernel/vmlinux.lds.S      |  18 +++
 arch/x86/mm/mem_encrypt_identity.c | 220 +++++++++++++++++++++++++++----------
 4 files changed, 197 insertions(+), 57 deletions(-)

diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index c064383..3f7d9d3 100644
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
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 8047379..6a18297 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -43,6 +43,9 @@ extern pmd_t early_dynamic_pgts[EARLY_DYNAMIC_PAGE_TABLES][PTRS_PER_PMD];
 static unsigned int __initdata next_early_pgt;
 pmdval_t early_pmd_flags = __PAGE_KERNEL_LARGE & ~(_PAGE_GLOBAL | _PAGE_NX);
 
+/* To clear memory encryption mask from the decrypted section */
+extern char __start_data_decrypted[], __end_data_decrypted[];
+
 #ifdef CONFIG_X86_5LEVEL
 unsigned int __pgtable_l5_enabled __ro_after_init;
 unsigned int pgdir_shift __ro_after_init = 39;
@@ -112,6 +115,7 @@ static bool __head check_la57_support(unsigned long physaddr)
 unsigned long __head __startup_64(unsigned long physaddr,
 				  struct boot_params *bp)
 {
+	unsigned long vaddr, vaddr_end;
 	unsigned long load_delta, *p;
 	unsigned long pgtable_flags;
 	pgdval_t *pgd;
@@ -234,6 +238,14 @@ unsigned long __head __startup_64(unsigned long physaddr,
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
index 8bde0a4..511b875 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -89,6 +89,22 @@ PHDRS {
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
+	__end_data_decrypted = .;					\
+	. = ALIGN(PMD_SIZE);						\
+
+
 SECTIONS
 {
 #ifdef CONFIG_X86_32
@@ -171,6 +187,8 @@ SECTIONS
 		/* rarely changed data like cpu maps */
 		READ_MOSTLY_DATA(INTERNODE_CACHE_BYTES)
 
+		DATA_DECRYPTED_SECTION
+
 		/* End of data section */
 		_edata = .;
 	} :data
diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index 7ae3686..ccf6e2b 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -59,6 +59,8 @@
 				 (_PAGE_PAT | _PAGE_PWT))
 
 #define PTE_FLAGS_ENC		(PTE_FLAGS | _PAGE_ENC)
+#define PTE_FLAGS_ENC_WP	((PTE_FLAGS_ENC & ~_PAGE_CACHE_MASK) | \
+				 (_PAGE_PAT | _PAGE_PWT))
 
 struct sme_populate_pgd_data {
 	void    *pgtable_area;
@@ -72,10 +74,28 @@ struct sme_populate_pgd_data {
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
 
+extern char __start_data_decrypted[], __end_data_decrypted[];
+
 static void __init sme_clear_pgd(struct sme_populate_pgd_data *ppd)
 {
 	unsigned long pgd_start, pgd_end, pgd_size;
@@ -219,6 +239,11 @@ static void __init sme_map_range_encrypted(struct sme_populate_pgd_data *ppd)
 	__sme_map_range(ppd, PMD_FLAGS_ENC, PTE_FLAGS_ENC);
 }
 
+static void __init sme_map_range_encrypted_wp(struct sme_populate_pgd_data *ppd)
+{
+	__sme_map_range(ppd, PMD_FLAGS_ENC, PTE_FLAGS_ENC_WP);
+}
+
 static void __init sme_map_range_decrypted(struct sme_populate_pgd_data *ppd)
 {
 	__sme_map_range(ppd, PMD_FLAGS_DEC, PTE_FLAGS_DEC);
@@ -266,19 +291,17 @@ static unsigned long __init sme_pgtable_calc(unsigned long len)
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
@@ -358,17 +381,17 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
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
@@ -379,9 +402,9 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
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
@@ -399,75 +422,158 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
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
 
-	/* Add decrypted workarea mappings to both kernel mappings */
-	ppd.paddr = workarea_start;
-	ppd.vaddr = workarea_start;
-	ppd.vaddr_end = workarea_end;
-	sme_map_range_decrypted(&ppd);
+	/*
+	 * When SEV is active, kernel is already encrypted hence mapping
+	 * the initial workarea_start as encrypted. When SME is active,
+	 * the kernel is not encrypted hence add a decrypted workarea
+	 * mappings to both kernel mappings
+	 */
+	ppd->paddr = workarea_start;
+	ppd->vaddr = workarea_start;
+	ppd->vaddr_end = workarea_end;
+	if (sev_active())
+		sme_map_range_encrypted(ppd);
+	else
+		sme_map_range_decrypted(ppd);
+
+	ppd->paddr = workarea_start;
+	ppd->vaddr = workarea_start + decrypted_base;
+	ppd->vaddr_end = workarea_end + decrypted_base;
+	sme_map_range_decrypted(ppd);
 
-	ppd.paddr = workarea_start;
-	ppd.vaddr = workarea_start + decrypted_base;
-	ppd.vaddr_end = workarea_end + decrypted_base;
-	sme_map_range_decrypted(&ppd);
+	wa->kernel_start = kernel_start;
+	wa->kernel_end = kernel_end;
+	wa->kernel_len = kernel_len;
 
-	/* Perform the encryption */
-	sme_encrypt_execute(kernel_start, kernel_start + decrypted_base,
-			    kernel_len, workarea_start, (unsigned long)ppd.pgd);
+	wa->initrd_start = initrd_start;
+	wa->initrd_end = initrd_end;
+	wa->initrd_len = initrd_len;
 
-	if (initrd_len)
-		sme_encrypt_execute(initrd_start, initrd_start + decrypted_base,
-				    initrd_len, workarea_start,
-				    (unsigned long)ppd.pgd);
+	wa->workarea_start = workarea_start;
+	wa->workarea_end = workarea_end;
+	wa->workarea_len = workarea_len;
 
+	wa->decrypted_base = decrypted_base;
+}
+
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
 
+static void __init decrypt_data_decrypted_section(struct sme_workarea_data *wa,
+						  struct sme_populate_pgd_data *ppd)
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
+	sme_encrypt_execute(decrypted_start + wa->decrypted_base,
+			    decrypted_start,
+			    decrypted_len, wa->workarea_start,
+			    (unsigned long)ppd->pgd);
+
+	ppd->vaddr = decrypted_start + wa->decrypted_base;
+	ppd->vaddr_end = decrypted_end + wa->decrypted_base;
+	sme_clear_pgd(ppd);
+}
+
+void __init sme_encrypt_kernel(struct boot_params *bp)
+{
+	struct sme_populate_pgd_data ppd;
+	struct sme_workarea_data wa;
+
+	if (!mem_encrypt_active())
+		return;
+
+	build_workarea_map(bp, &wa, &ppd);
+
+	/* When SEV is active, encrypt kernel and initrd */
+	if (sme_active()) {
+		sme_encrypt_execute(wa.kernel_start,
+				    wa.kernel_start + wa.decrypted_base,
+				    wa.kernel_len, wa.workarea_start,
+				    (unsigned long)ppd.pgd);
+
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
+	remove_workarea_map(&wa, &ppd);
+}
+
 void __init sme_enable(struct boot_params *bp)
 {
 	const char *cmdline_ptr, *cmdline_arg, *cmdline_on, *cmdline_off;
-- 
2.7.4

