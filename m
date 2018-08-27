Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D07C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 11:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FAC120891
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 11:25:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="lzCbJMrz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FAC120891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbeH0PLQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 11:11:16 -0400
Received: from mail-sn1nam02on0085.outbound.protection.outlook.com ([104.47.36.85]:53246
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726825AbeH0PLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 11:11:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NWk/vNA/LIZ2N41H4n7tTsNT4PBBOFLfImtws51zSdg=;
 b=lzCbJMrzq2uH3xWTxFcnTFHeOM6bLa54CQrYteJj8+kJ7/jwFxenMDcLHbG5m9xEn8Uwb+4Y+6t2Cw/McxDTrsxG+ix571wvoBGnvl0PXaxa8mSTMlUBbBYlPrbcZ8q4bm7MYCj9HdOJZLJU/E2u29U+s8gZwDAeXc9oekBghk8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by
 BYAPR12MB2679.namprd12.prod.outlook.com (2603:10b6:a03:69::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.17; Mon, 27 Aug 2018 11:24:56 +0000
From:   Brijesh Singh <brijesh.singh@amd.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH 0/2] x86: Fix SEV guest regression
Date:   Mon, 27 Aug 2018 06:24:38 -0500
Message-Id: <1535369080-20290-1-git-send-email-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: DM5PR21CA0011.namprd21.prod.outlook.com
 (2603:10b6:3:ac::21) To BYAPR12MB2679.namprd12.prod.outlook.com
 (2603:10b6:a03:69::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c96cf28-1807-4268-cadc-08d60c0fb807
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB2679;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2679;3:QLvXCBgHWdh6Eybtdu4SxbPcp1B8WH5nALMavBayuIFsqCiPr8KAErnMr2pjCes3fsi36IONnA46ZS1teBBaQScoVLPuZ/r/R+W0MF19yMqL7PWieS08ikwWWREz4mm9LCOXgc5t9XKkVjrbb91PEk3NSx0ve6cvlE0HxGRFCiK++KzZJNt93xh6tVlnryvX28pu3BMYirJlubhjWmbXrqdg/8VMLfzhVD0fwtmQDoF/Ygjfprq0y+fMlKsXly5j;25:55VtpdnJYvJ6wlFtFdKrZuePYLEVL+1PvKdmDBZePB3mZErOsGPEpXbCIh/0Dk72WOH341WuqhOZJx43svC1c1d+P9GGu4saMndKJxl4EheMP+W5UxGhgG3WIML2DpRyjogBt9lRZKoDORI5rGBEbYTNzMIKo9CrOe7D6k8R06gyCNPxiAWOoc8s7ADCgKo2imCHU0z9kbSroGhCpIdAQVhuZ+t3DIzTzWoKxrAQZCMwt897bwK2YJ+4bYhT9p0rqEQzN3frwO1gxTXWJKi2KdjZTfwyxXJnX/mmRdWu1v2HEZH5/sQUWdC2fL3wfapOhFJg8u0nrovCbFSKqi2f7Q==;31:Ws/PtQqHERoY2NliM/LoZ7pbPX8WKO4YS2ixEYx+Pj5KNc2/8Uy8Os0eIDVMLQFUKV+tzC3Jy0QqxiUsiCcmsD8tz39DMKodXjss6R3ZYUMmdtTKLP7LB9y4Ovw5keJOzOR+0M/U2PkIdrootiZZ3WWG1cgNP0PkLxH+mTqBc83Pm/UUUihZxCDyTu+OUp/1S5Sou516zDaWrvRSrRLlXvJdNzohGTHuk5sTe310RvQ=
X-MS-TrafficTypeDiagnostic: BYAPR12MB2679:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2679;20:CCNCQMgzL3jtHUNZlaGYw0J5TYVN7svpdHz4ijcayEmVxLgcfCq2904a5aASfWbPM20X+V+fRqSfGcSwhdl4MqfwtamkBL74jjBTxVhT8trrF2+k2XDLZBrSbsajuVFGjQRHE3Juc7MbKkYeGOvSjEeTPFivS4k6cmmw3DT9aFY+Qp5p1e5mRF9j+VGa/OJ+sLKc8HyT3dB+XB7peR+e8BpXWofotJzNFki3mlx2vBVrNg6ZPWSjDONX9gigP9BGYeyjykJyVJm+DYE+mC+yu1Iq5zlv6G5ojODezkRG3mOfHjLsGOkPV5Dl6Oyp+0C9/nXeK+sLycw/vNzyOyxilH9bf4a/RHbu0xZgInIbh0si7ogAx1b9En2Zt34RmbQO5/AFcdBl2kL1enFTlgAShQhhAVRCl7lblafeYxCvG8pcq1/hloEZSohoMtxH/D3Rcq08v/SKa92YWfbk96ElIWCbg7M7Kp2t6XHVGkoj4vmUl/P0Fdf5NE+Vq9H+0yYL;4:Z9rrUlh+8Vqoi9Q/rNm1f+rKMF268iT/0/gAhXlljmFOl3MMkA//KAk1AtGt0Iu8jKBp6gqEOzwTCxpRIApF/4p2mFtFHZ7o65t60OGfbYriID7q3LTg7CJtevBrohJlP4/sxoNzX06GiC8D91KOo9Na0FQTE/vMK+s80Fo5WdpRQGc7FJb7B0dV5hT7JfNq3dI+I9fd8Xq+3I6gmb4Umj78ShaU5EtumDNCF3iuGSrt52IwB3HWP3cxmJdrHqpc0az2FZyskf1AOVx34hWCkscn3C/ettR8teRaVUAI6gQPXowyPiG1mYHVyIBWEBayM7xYVETOvRk88pntkf8fGYUwcVeF85KbTMBsumagqXUTIeeJRPau6OUsdzRAe6LZ
X-Microsoft-Antispam-PRVS: <BYAPR12MB2679FF4D5841F1BFA8CBAEEAE50B0@BYAPR12MB2679.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(84791874153150)(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699016);SRVR:BYAPR12MB2679;BCL:0;PCL:0;RULEID:;SRVR:BYAPR12MB2679;
X-Forefront-PRVS: 07778E4001
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(366004)(136003)(396003)(189003)(199004)(5660300001)(8676002)(81166006)(81156014)(25786009)(6116002)(4326008)(23676004)(47776003)(316002)(54906003)(6306002)(86362001)(97736004)(53936002)(44832011)(7696005)(52116002)(305945005)(3846002)(7736002)(50226002)(2906002)(8936002)(16526019)(186003)(6486002)(105586002)(53416004)(26005)(106356001)(36756003)(68736007)(476003)(50466002)(966005)(2616005)(956004)(478600001)(2870700001)(66066001)(486006)(6666003)(386003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2679;H:sbrijesh-desktop.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWUFQUjEyTUIyNjc5OzIzOjg3Mk5BTzM3YWlqR01JeUV0TkJBdFBYeXF2?=
 =?utf-8?B?UHJEWWhTbm9PWDJVNFloMU4wT1BiNmxEY0VsVXRUcUY3cW9NeUxGbVhoNWIw?=
 =?utf-8?B?WmZKMWZOdlpiSUFIaGFTVUZkdlczZGhaQW9waE9uWGc2Snh6VWU3VFgwSnFH?=
 =?utf-8?B?WnJBa1FGdHBIUGlYZjZpalFiaGFiTm9MUCtUeCt2cm9SOHRibnppYjkxMUhr?=
 =?utf-8?B?MDlseXp0VDJQaElDVkF5RWRISnRndXhwNFhkUjRsUXN4UGVXSmFhWmZMQ0Fn?=
 =?utf-8?B?cVRmLy9jeTRGa0tTQ25MYWk3Vm1ZUzYzRThSS1Bqd2dTem1ueml3WFQ3RVRX?=
 =?utf-8?B?Q05VdEFGVTA2OHpUcGYrRDlXVGRtOUsxRElRQTVpd3FLbENXbFIrT1dpenNy?=
 =?utf-8?B?bU1ZNndKQWxlNXQ5TjBBbGpNYkRlVEhIK3dzUlZ1Mk54M0JnTU5Tb1hQNmFu?=
 =?utf-8?B?VDhrc0RrdDFWTWkxcnRXZ29Nb1pqZ1ZIZXJKdzBhcVhBdE1NaGpRZUNIMnA5?=
 =?utf-8?B?L1NSNVI4Snh5cC81N3ZQRks1K3N3OHhDZTJsb0JONUNHbGlHNXpncG5sZ3Ri?=
 =?utf-8?B?WExvMXUxV0ZWWHdlb0dHbmxrSFU3c25BV2Z4L01mTGJ6NUJKQXQ0dUR0US9w?=
 =?utf-8?B?bEJ5QUd5VkRJaXZreHhNNVduTEJRUFJGNW9BZmNaTkNyckxpV3pudVQ3VjZw?=
 =?utf-8?B?aFpZSFlzdnViM0w2ZGFMT1RBakhET0NQYXZYU0tKejJwcEkwRi9SSUlhdkc0?=
 =?utf-8?B?TVBNNUdoN0xKdHNqOUMxY00zNzVQdkNTSmIwbnJhTTY4YlNxbTBzME1iUnRv?=
 =?utf-8?B?bmZjeVdDKzdHK0xFNzkyMEtPbW1YYzRqa0dDdTRycUxCZEpEa3ZOa21KYXgv?=
 =?utf-8?B?b2RobzAxUk1PdG1WN2tzcjhQUXArdDZMN1RETC9sbjYzcnNtLysvYVZSM3J6?=
 =?utf-8?B?VU03b2pjaTlRWkxpMUtMMFhidGlLMWMzeldOMWxaWHg0ZDhFUDdBaUFaQU9s?=
 =?utf-8?B?b3VibGhlMWlTZzd5K2VMRmRaVjJ5NTlZdFBYeDk5VTVRYm9jRW95cE5wc3pF?=
 =?utf-8?B?MVd5anlFV2FZVnAzVEVTVTVQUXhuT3diNVp2UEhSa3owZWFUM3Z3dDYwUWdF?=
 =?utf-8?B?TXJHNzZYK2ZWZEhTK0cwQ0kxYnA4SmF6SnFlbzRNamZSZ25PbEZEYTVSVStR?=
 =?utf-8?B?MysyaTRScTVabUtPRnpGdVVzVXJjV1dFZDByMmF6S3JKM0NHWENXajVYYnFx?=
 =?utf-8?B?bkwzSFlJeW1KSTZmKy9XcW5PWWJGbkFOcW5kQXcrR0pqdTdPbHRHNkNCY2pv?=
 =?utf-8?B?aTkyZHNOMW95WXJwbStqbHZlOW9EdDByalhjTFlRNk90ZHA3N0RMOFJwdS8r?=
 =?utf-8?B?OHZ5WFhKVTI3OU40cGhSc2JmOUhZT2Y2OVlDbHpLNmhhUnYrWDhHMzNCeUxV?=
 =?utf-8?B?dlpzU1lzVENCWTJBOVZVTm1MRjVnTVYxcjQzbldkYUM2bmRObTdYWm9DWG50?=
 =?utf-8?B?bGdydmFQT2gxVTNQN1hmZVpaNmM2NU5ycVpVOVo1Z3RnU1F1SkM5dWhZVHoz?=
 =?utf-8?B?MjBlOUlkN29SWU9mTkg0ZGtHR3RWZEE9PQ==?=
X-Microsoft-Antispam-Message-Info: lp9F4Uj1wMWyurZqJItGWq9r5SORvHkuBBNBBGYTl2lK2dY5EsmDQIZeKquunS1lES3t1292ycAVmQojEdWuC6xvq7u2cRY03Z0/l5fuAUpnTlIpLlutA0oPVGJVjUZFErfk8QthqYGl8taiOXPKizjtTZsXpWTeZkFcbmjn4Fm46l/Gqn4Z2upxr3zGJJZvKt1qa8BWTB+/xLy1BIfGhRwM1yyqyC3eNLcd/yctVWAvr/zPdufeeMY894jNAgXmcgdnD0bkO5UbXO5CFcZrDQ5cnIFBySRQeDP9Wpcm7oY49k0lXG+JF6RX1v3jXFI7HgfH63DWjto4y3niHU1nBJqYdLbnipenypokP8Ohnb8=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2679;6:B6vggiVCgXipz83WkAqmCOlZNPjyWHpdz0ShZt0Fc+ZPgJXmROjQ4duwGy7UiK1HzF6nfa6WE9QgMvkqiBiY5N67MWmvw6Gj/cW0Aavxoc74Z9bIb2voY0TpLjJunjtwFG0yFwIycXzBde9SQYxpspLR1VZADLuWz5LDbF4SzLti18QCLUHU3U5Xa9E8WZhGYZEJhgZWXQsmeiGlsUiACh40gaHsyXtwdUvegFUuFZiu+NyUx8gGuv4QIRIcl/Y8FSjYn8xrg3JIao9qcglhS3u9digAPhNoZn5ys150C0QdD70xbuk2FzRiWh7KJLugNCqj9MoQn+GbbY0H/xpPvDoKrf/7LXSV8hexqA9q2VVuri/wXpUAtoVqm1hAwKRaDO4i/U2kNFfoMRiScDWBxFT6EROk/vIaBTTDx7b0Az8J7q+qMeq3WFCroBPQVFxnodbrVM9rVfD/4NpArtUf0Q==;5:9S6v76ZVp2mrutBqk8OlslQyrVY9qoFCaAU5W+TeNvqth+0XE6L4ruOmhQdOuw9G4JlrzNILo1N6Ug3G9TkMzk3hEL71lcXmgrl/8fYnCaZ+FlypccdGJUkmpKdMnir+P1TEDQ/09iTsAy+wh1QCeOB5uefYNtogfMfGZECrBMQ=;7:63HoUVvmWtcFJ3mWkE+FaHjAImUPZcQwFRiKjdmvAhJlBtZ4C0LWlnJjjfVPPiReOH6loOzUC/LkciSssbPrETMxChx6Zib4fmSSzngsrFwuaP0hBXR6ofUJdMjbwuanbbBdSbaCSxnSOJ0FFo38rn3zwPIOBaBiNj1on91usLQcxi0GdOmTZKM9VrNwywXtVc1OYFUepkXjzhMNM7beouXPAxBcAXfTMn+MJ0fT/7elYnxfptLl9OK4T9FugatR
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2679;20:o+AbBdx3E20NRa1/GbC/hVqqSLNwnDq9wS7LISB+4+Op/O4pwbqRTj/D/oUOPxDy1dcRlhpKoWyOEYF1cEKYErKURj80fqYSNz8W6CKtpGjHLcuGokoLb/dNpjHvpJlmtC6gxheSzzf90KivwQ2HdJDRckYr3FiEiuZ6n99rzVC0Btt5dnjHaSx9nGisIOsY9vHxp+V7M31hZdo2hW1SD1ANgcjoXP0PCLFqkmQPORu2GRVqWg8cPkZom3EQfPxt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2018 11:24:56.3049 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c96cf28-1807-4268-cadc-08d60c0fb807
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2679
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

Brijesh Singh (2):
  x86/mm: add .data..decrypted section to hold shared variables
  x86/kvm: use __decrypted attribute when declaring shared variables

 arch/x86/include/asm/mem_encrypt.h |   4 +
 arch/x86/kernel/head64.c           |  12 ++
 arch/x86/kernel/kvmclock.c         |  26 ++++-
 arch/x86/kernel/vmlinux.lds.S      |  18 +++
 arch/x86/mm/mem_encrypt_identity.c | 220 +++++++++++++++++++++++++++----------
 5 files changed, 218 insertions(+), 62 deletions(-)

-- 
2.7.4

