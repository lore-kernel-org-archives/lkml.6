Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADD5C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10DEA2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XsyHckiH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10DEA2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbeIGWjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 18:39:53 -0400
Received: from mail-eopbgr680053.outbound.protection.outlook.com ([40.107.68.53]:59456
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726365AbeIGWjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 18:39:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BdJUFBsYLNgYsE/wjTdOS5mKAPWVjyMJBQGIgs0NlnI=;
 b=XsyHckiHF0bQ407764b/zFB0xVdm31iU7s0ZKohgJmN0St/sJF0kMdBaUM2kNevpn7q7QzP4/tf9zhl+aI4r7zHNp1eK8DB5slgFK7HCrIBsMPHewFdIULRrzOstNodu8eTYsHfIHzScnBEXKqDSlWmZo/5cpXb+yOAypkMLfac=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
Received: from sbrijesh-desktop.amd.com (165.204.77.1) by
 DM6PR12MB2684.namprd12.prod.outlook.com (2603:10b6:5:4a::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.16; Fri, 7 Sep 2018 17:57:40 +0000
From:   Brijesh Singh <brijesh.singh@amd.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH v6 2/5] x86/mm: fix sme_populate_pgd() to update page flags
Date:   Fri,  7 Sep 2018 12:57:27 -0500
Message-Id: <1536343050-18532-3-git-send-email-brijesh.singh@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8323c752-601f-4ac5-29c6-08d614eb67e7
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB2684;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2684;3:Coozletobzfnrwuwhwvf0Dqh8VMWD2RqJZMGBB+n10MqgRFfF3YtI5XWLkRxcY4hiGI/9SRjB0IHioV9M6gWXtwG5d7ytfsQ4/KHDX6vDPEeA6HoiKbnsL3kflfUG0hRjsSDJlawCHnXHHok12HLVI6ZvnWkXPtFyoS7lDbB0jWERfFUkko5v2K2F/1yUT9MVMDqm1Lk94S+hJ0ZDBM/NI069GvrPGfjAVSQueGBHIETijgYfFUl6AbrPmJ3oc8m;25:yg9EQzGoWghGdkoRNYAKeyHEZvivqGPnJmWtP7Xrb7LgZqaeJAatBrFnU8xROnw8BbrQe71IxBJIBqeUghNLJ8IZZ/95QPC2Xd+jh0/ezWuKJqe6rkVaUi+E/P3bmzHXbYmNNJt6It8tgt97IewL6Zq5WoeVpAv3w6KxONVjhjPPqsIbZWpo4dIq9bO8SvawTz9AnXclt29F8Te5rpJcMKAfEYoMoIVJQPJNi4siENFv8CdL3bK09jUHgnT9a0nQa5FuzNG9upPsOL9nHWaf99AJr+0UnJ+gakGILzAt+Rpjc7bIuzx/IwD+nwfxAVZT7UYWFyiBYq7h6/MQ20Uq0Q==;31:sr+FDmcM+z4RTkCxJaIx7ZeerMSECu7mcRzxE3Kq9x7NULJRoTkpb1OgPMQ/Ea7sZdbBCy2UK37xg2znq863aon6HbUgXGpxAkj44A7KTk4wvQ9KposAvcQJdyn3Dkhc3Zw6pBEzMowGGKlQVP/6A3y/dgwGmxPrV70DHSDo0OnN34dm0A6TCxZ/Y50Cjiv0YBnEofVbm25Ci9ED+xaD6EuAg5Y8mUOra6eR/KO5bRg=
X-MS-TrafficTypeDiagnostic: DM6PR12MB2684:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2684;20:wDSuzL7IAqIVUvCL48nW+XrlhdBn+JrclL6HiMt9WahHoOvIL9znvPKUrv4lJ+07quzh9jEpVEbVAxaDE7BrM9lHNaue5PK6SeiCYYAeYaqDM00FR8/Ze+GU+nQ++lO0Ucta+W2G5Jn8GadBxZNQ6ZgahI94Zipd2uiSbc9seaj7oKm4yfLiYvcT6HEywu/oJrbNYAV44V9dX8z0AJEe2Q0SyJ1T3O/+m7hxIQ28uKgFjz7BYVYEB8PK+70zTPTWDgI+SwwEJFMZniEVeIqqwwRU9gaR5zCGEd8WGge2zQTkmqXrYP3pCBJxdNNg/Kyg01dMcl0a6JO0H+/eV3yz/yqgwJp1bSS8HU2pXOhEpE/eRG2VJ66vy23Is8M4QmJjpQsk6OZ4MQF/1OqA1y4giqFqRQsgK+vcJrC37Gtv2YXHZn3LLYyluzU4l7RIXxvfvpOBzcHe3xX4fi+95RaeGiandYAbWraO/4mi0600ey82Xuvou4VkPTaN9gadPwo9;4:w94c9urZZkB9NoWeHqchQELb4At7vHjqwiGf4pQyXft0KGLQHfrYVYKkD422wYlj/wNywXqzpUFdJDhEoDxFu5rmfC9dHeIjw++noMGc7Lv9j0QgDpVYaIHlk2IkvAzZ6d1s0Nss5i5Zwo0BSHiq7yavLd96GZn+LbZA75yOEXiy0zKWOqO5iqR6oNEz16mZqpv3oc9SP1YosUoI+4zIhFyCYedBhR1rfmQKV4EsbGEkKLja8bVnEvrJTFvBGEOaH2Yb2BhJH6DV3i1A/NIcsecNRJ5Ldztmi7epZqTeEV7vXfW4F/jao9MQQoO3V7s0rQJQhT7McsgBIVH5SCIwYXs7x997KPVdZ+BZ9yEr84mW1pd/6n7JisYnhpFwt3H7
X-Microsoft-Antispam-PRVS: <DM6PR12MB26844B252A8AFD5A4E19AEACE5000@DM6PR12MB2684.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(767451399110)(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699050);SRVR:DM6PR12MB2684;BCL:0;PCL:0;RULEID:;SRVR:DM6PR12MB2684;
X-Forefront-PRVS: 07880C4932
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(39860400002)(396003)(136003)(189003)(199004)(14444005)(8936002)(81156014)(81166006)(446003)(476003)(2616005)(956004)(86362001)(11346002)(36756003)(15650500001)(486006)(2870700001)(44832011)(2906002)(47776003)(25786009)(50226002)(66066001)(4326008)(6116002)(97736004)(6666003)(7736002)(105586002)(316002)(54906003)(106356001)(76176011)(3846002)(23676004)(7696005)(8676002)(305945005)(52116002)(16526019)(386003)(186003)(68736007)(6486002)(26005)(5660300001)(50466002)(53936002)(478600001)(53416004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2684;H:sbrijesh-desktop.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTZQUjEyTUIyNjg0OzIzOjEzeDNEQlk5d0RkUThBNHVoR0VrbEF3RjhX?=
 =?utf-8?B?K0IrcU9yWUUrVEtmT1ZaWThZTDlLZWRRajRGMGtoVkswUFRVWStteWZibmkv?=
 =?utf-8?B?RGNNR1RiR3JhU1hxZmhkS1ZaYlkzK1FRdDhHOFJqMTVKVzVBbTZvcVJuUmdD?=
 =?utf-8?B?YityaWRzOFVielZ3Z3lDSWhMRmVJcUwxVm5UZXpidUdRUDNwRlRaL1NScUhO?=
 =?utf-8?B?VTNqbHJrb1JOUDNzQ0FYU2U4dU9kSStFOW1ObHJlNTlGcE80SzJhaDZNb0ds?=
 =?utf-8?B?bGxtUVlFd2ltOE5FM25Va2NDc3pHd0hNcnlidnhyMFdkbUpzaGh3QjM1bWk2?=
 =?utf-8?B?ano4RHd2UDFpaHdUWHRPdlpNOHQ1Tjd5Y3hVc2dFbTFKVXlmWGkrVmlRcFNF?=
 =?utf-8?B?dTdpaTlRUGZEdFprMmdJMWxOa08vR2YvZ1JYRWFTaTk2OGFzQXlTcThVb1VX?=
 =?utf-8?B?bUFJaFg3Nnk2SVJNQUNYQVl6YlJSRWFwaHRzTmE5aWZ0aEdMV05vVE5QYWVG?=
 =?utf-8?B?cXI5TjhxaUM4Z0huZXNBTERyZjNmcWhxakpJWUNPQ1h1WVhlUkR1K285Vko5?=
 =?utf-8?B?VW9DdDlKaUYvRzRLeW9WTVVCUTE0UStRdVZwODNhVDdUdHdFMy9ZOTA3blBq?=
 =?utf-8?B?K1BiRXpPVlgvZVJzOVEvSzFXZnd6YUxweGwyNEFUS21yQVNnQU1jM1lyVlIy?=
 =?utf-8?B?dlcvRHVkcFAzREZDTUhTRksya1lkZTAxcy9JbTdLMHRKNk54OWdvUTBnak4y?=
 =?utf-8?B?N1VuR1UzUWxseWd4dU84UFNNZXA5aGI3N0I3cWFpcWUrek5pbU94TEo2S3d6?=
 =?utf-8?B?TzRTcWNWTmdKVWYwU2JhaDczQ1NuKzh6R3JYd29ZbjhvSWdNNVZLaGxHS0Fw?=
 =?utf-8?B?bUZVNXIrNzdOc3gxUkl3ZjVidFBsbnhSdm9rZVE4cm0zZkJ2MnFCR2FwLzZ2?=
 =?utf-8?B?a20rd0JSS2djNlVTNmF2VjZCbWlic01WVW9MM0dTTmczTGw0MDZiOHVKa2Ra?=
 =?utf-8?B?d0NlWmFIRWdTSGNjOXpNYmhzS3RKbzJvMVZwdFltQnlweHlJOGNrL0FtdDl5?=
 =?utf-8?B?Sk1uU0lGcVhPS2RMRGU0Z2Y2SE1mWnIwalhEVTROYzBYa1F6R3FjcDJJUThY?=
 =?utf-8?B?dUpuNlFGVjlFcDlsT0ZNNlQ3VXkyOG1JQ2szMFRWeHZ1eE82anJqUTN2Y3dz?=
 =?utf-8?B?WEVqWXVTUG9LTkg1MFlHcmtncFdWendsVUk0a2NUclBlNUVIdEUvb05XWjFT?=
 =?utf-8?B?WmJKQ0tDM1dGL0xTcVUvVUtxbEtQTU5KMHNXZTVVVmpWdVpXeTJGSHN2eHBG?=
 =?utf-8?B?WSs1VkxlQzAySEZUb1ZQQ05nUmdMQVNOdjJzYndBQ2Y5elkrTWpkc0E1Qm1p?=
 =?utf-8?B?MXJqZ2pBN1V1dGhvcUU1dFVyTjgrRWRlUzBLZlJKaGxEamJsUFdTdlF4NnM1?=
 =?utf-8?B?ZjFheWhEYTVwOU9CL0hGMC9DckhCSTRCQzRFVzZUdm1laktwRDdHOFJOOVNy?=
 =?utf-8?B?Y0xhaERaVW4vWWRPd2taUVBhZW1xOWlGL2VmcXFIeDc2WklhUytaaWhYaTBm?=
 =?utf-8?B?NHhyL3gyWEVMdkZFSDdXUnFJdWxIVTNCajZQSFJ1VCtlY2dKM28rUnI5bGYv?=
 =?utf-8?B?bnNJc01rV2RJWHgxNTl3YWdxRHN1bXYxVm1uWGJxdzJXTVRkNkxRWVBRPT0=?=
X-Microsoft-Antispam-Message-Info: Mz/RazLWPD+Ab0QRQjmOp+yQT1YiNZeswXaKt/G7eh5k9Uuz3q0ee8xqzISoQqsMP6DtGNOyxpGdBb0qwhRfxR6eH4kw9B9M1KkcXKNHWwuOFJIjK2FWQ4w1JVdU5lrpmrrfd28LaHeXQ8RjA4jvqGqf2qinNwXa+EoCt9aXINk+wKVbxjHKa1RZORI4B8I9l1UqyUd58M5M5+lnzUyMCOo5ftwgxPx+zILxjmZHE4zmxoz/ttFEX3TQ9s8kjEKAe2VQu0exa5WJrHSD1b8HAZBoWIF0sMHZIXa7pft34TC1gsLirITnvxhtJEzkZaq+rT9Sek0TyEQvtaQS7QDCDAnnYeTi1Jwy7VEottSv9Io=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2684;6:5c2rKVTxJ01ni5wJK5dfN2pCZ4fLiwHrOL3RfwnvfkMvXY1/iAVCIGWcUyxRQjTJHaTNTxbL9A42aEXQAOI/1YFFQ4TeE3IaqLsgpUsYxM7yNBKSQVkVgQugJnOz8qL1Qem/oCJOThTlIU7Sa6Aln9BP2Kxw4xNudNk68662diA6AywNl+rXx4Tjfa31E9z35nZ9Xat/B3Gpph2AZlRoP3OGZdYIsR8ObplXM4s3G+SMcgtBurFQAXFPTW7BFDiCBYCQ04G9CWiqbHFP+d0firmOQBKsxzG/Otlr2eD44F6ibxp7DaSRB5EZfnqyPraDOHO6qfQZq8/ps9Z5n5Dgj9w8pIHTgecLRfXa4Q0m31h4aNoG8j91FlbkCQhNdqyVDVvruOUNwrFzOdQk+b4HGScUDablDOqqF5VhrMbvj/3D50nrpgjwuMT1NACOJzhu1dAxjkSwZ8hlBHAVQ0hkOg==;5:EVWzBIiD327NY6HPNIH29aS6NaFfm1GHA5ZHH+ohQGlSzkbX/U8bEDZWbJUFqJNdqNi77EYxdLzhaECH3hlLKw7+plrGxrq8oDzTYCkdiE9vZJ488bwMu282SHD24A/QEBu4FCV/uQ4yu3sJq8PpRpHtKKtu4+M/5d4tpSWfSWk=;7:yIUeNNzmoh1w9+iRqXaJ7ezST4t3VwupMn0g3EYDGW5U7g7Nj7E9kN7k3zy5ocv78lsb/HlNPqHXqq3SoJcwmB1+CchKppSZR3gSinQHsVYBZ/jxtqBEa76kfACUeCSeOnJB7znSErzXruvFi2krP0SaMGiTaFjVIKJB6S/0g1jnHGvcjEN4hLCO4mTIZ67tCerqlgjjz6NIOJbCoqN8nCc+GYXSWYwQ1OBj1LLz9HzaafJS3gZXVVZlGtxfaOza
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2684;20:AnWYzLG8AEdG6YeN6JcfPhJCiJKPGQBA0UMiobITXkDGcD2eLN+2Hr8dAmrULnIpmoBCidaXJQqCQkkLGDAvXMmlntOXOjLWkOzIVcVk2fMfd5KcEEjX41FpU8H0u8TCcnRvwGQ45MwVqZPfuuzTFceuWMLb6H/4XQ6ye59fU7tsy8n/Um4mIHBF27KYcMk8wPBz/HGpzj57kAVPeNRDIiF0xehfOzjbpIrY0H9avkM2s3kNDCc0A9eM16R9q1cs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2018 17:57:40.5982 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8323c752-601f-4ac5-29c6-08d614eb67e7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2684
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sme_populate_pgd() to update page flags if the PMD/PTE entry
already exists.

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
 arch/x86/mm/mem_encrypt_identity.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index 92265d3..7659e65 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -154,9 +154,6 @@ static void __init sme_populate_pgd_large(struct sme_populate_pgd_data *ppd)
 		return;
 
 	pmd = pmd_offset(pud, ppd->vaddr);
-	if (pmd_large(*pmd))
-		return;
-
 	set_pmd(pmd, __pmd(ppd->paddr | ppd->pmd_flags));
 }
 
@@ -182,8 +179,7 @@ static void __init sme_populate_pgd(struct sme_populate_pgd_data *ppd)
 		return;
 
 	pte = pte_offset_map(pmd, ppd->vaddr);
-	if (pte_none(*pte))
-		set_pte(pte, __pte(ppd->paddr | ppd->pte_flags));
+	set_pte(pte, __pte(ppd->paddr | ppd->pte_flags));
 }
 
 static void __init __sme_map_range_pmd(struct sme_populate_pgd_data *ppd)
-- 
2.7.4

