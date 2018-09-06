Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A982C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 20:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21E1620659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 20:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="eGJECvHk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21E1620659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729573AbeIGA6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 20:58:02 -0400
Received: from mail-co1nam03on0084.outbound.protection.outlook.com ([104.47.40.84]:36400
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728820AbeIGA6C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 20:58:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Cbf1nCYjecvV8U8eXmhRjufED1pgf1n2bYZWmqQgEw=;
 b=eGJECvHk5a2aNUJotZuco2GkYIuL5kOCtnKYj0bACMd0Z03HlpJ+0q3JKFcfSUishBVptNmoTthbMw6dsEhOkD/VuPp1f1zFWDcW8slFR/jiRw24tD7dHFI98ORQU95OvuwDfcdRcdt/dPXV9j2fTvrkiLA55dhNKtu7HGwmDGc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
Received: from [10.236.136.62] (165.204.77.1) by
 DM6PR12MB2681.namprd12.prod.outlook.com (2603:10b6:5:4a::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.16; Thu, 6 Sep 2018 20:20:50 +0000
Cc:     brijesh.singh@amd.com, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH v5 5/5] x86/kvm: Avoid dynamic allocation of pvclock data
 when SEV is active
To:     Sean Christopherson <sean.j.christopherson@intel.com>
References: <1536234182-2809-1-git-send-email-brijesh.singh@amd.com>
 <1536234182-2809-6-git-send-email-brijesh.singh@amd.com>
 <20180906122423.GA11144@zn.tnic> <20180906135041.GB32336@linux.intel.com>
 <20180906141825.GB370@linux.intel.com>
 <fcd5efe9-3e26-3aff-9173-9f8c3f3183f1@amd.com>
 <20180906184750.GB4570@linux.intel.com>
 <c219ec47-1a1f-5d19-0b5b-0cebb706ca6c@amd.com>
 <20180906194710.GA16605@linux.intel.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <9126c92f-ad3b-a5b6-ac44-416405489a7e@amd.com>
Date:   Thu, 6 Sep 2018 15:20:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180906194710.GA16605@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN4PR0201CA0025.namprd02.prod.outlook.com
 (2603:10b6:803:2e::11) To DM6PR12MB2681.namprd12.prod.outlook.com
 (2603:10b6:5:4a::30)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d30de1e-ff9a-4589-af3e-08d614363d2d
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB2681;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2681;3:ifAWL9D4iSe2JF7Ez0l35UR3Tfzibtv/vK4/Qb9JAw4Sv31tnS3Vh6QyVsLTTwY4NDh59YYD9u1GUXRTp9+VE6Gdbw9qMyaWg84svcElp723ukh9fyVgSv3Uo6SvyqON9Mr93obnrJe+wU03rsPXjP19siMDj5j0WcgYctzUfls4orV6nJwZXXucn8t5eXV/SRJidFAaoE6pa9r0UOvCBvvdpVcHemiOHotn1jlL7GuXTGqcFCXL2CBpFhcT/qz7;25:jQ5DVXnSRfMIrUbhXN5atsq3fIspUhXovCF2rPxCwDeV/uXkVU4x8n83Ea3vdfwmHj0K8mu7OoKqdZVwMqA7w3gbfHJFuSsJ/3tgNvV+oBqnWV+4aLRdBcUDKpE9MIfh9984nFJiK7HSuHAEYcDLJy/Cfb78idHL8CRJ3TcFb3sYqQ55ixz7VZ8up0OafzpGJhGLEREfylAZ/KmBuArd3R/nz/yWzxSPluJY2m1iII7tcbeA4R4FByRIC9+Wjdx7JMvH/4iOZS9XZndgYPP22c9Qj/PieZn3ok1HXjXACmtICTOBXhquZu5sOvgbK7pms+1Ad4uLtis7lTsdvNlk6A==;31:Cz3f21le7jMJBtJQpZ/e+N3EMaj+kYQ9wEjB8N9Hw3GDQsrSjW1Kj0dSBc3puzRN/ZpCQyf2FhBjI3h1YQsoYF78A1fzWbW4cb3DPTPxQX0+IJE7Z4nPruFlJseonHoAJDbK96OyQXhxXho4/MvQTTe5hV2mDgjT5lsMdyJVUTdTQJIutFMp/N+HI0eKxzT+LDuOdetbc34RWGuvGW4ETGyKAGb6XEmXf1xlLll7WYk=
X-MS-TrafficTypeDiagnostic: DM6PR12MB2681:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2681;20:3aNy3i2xwsVsH0mKHFC2lkTqjaHs3WQlXDORyh6XUNswjNEXlS91WT6OUEE0hEWWhBFD2/YumxWLHcNc69PmAwdgBHIgB1JcPKfCgSqNAmhkQ56T5uRlsbDIDr4XWbGB2JkZZIhuQD+1C/zLGrCsh+psfV8H/5R2d5oL/TEGsLDQ1x4YaMaeXo59WI0WFQRzIRJbI3tSeH9p0YWKbV+CldWEYWok4+gLzjgR/2+FYI0UfhTOXi1roXrei+mgronTcg6ICzdyFJm5b9VuDL8CMZ1WEszEviDhIQpNdUWQl1u6Z6tLka1QAYbala2Fq3Rh5qONOpflRdE6y6LCwtHbkyoZ9EySo9vgLMhODVEsv5/F4Re1AJlcJe6bEJkyZBciJWrHhE1BSv6eMJ2EfLR4JEwLtTTh9ue2tpIvB9+P9Anvfup7erjuWUlwtlxAC0SWNoMRN0cOa7+8Kq1Aa6M00Xj2wdCh1TMrpeI+cjzFzgHY42sx68werr0bpCuzwwi7;4:Tqst5Uk9judA6xhIQxfQ9WvbIAMN4VkDs1B1HiMjhcNtZ9ewknaxghmZ6L6Keg4OYAmjuXA9G+lI9s1w09ThS6frd7htVoBFEd2JBreBwQh/7XSF7bQnEqS74OTz9JU7zBBSPjZwznZMaD1IP/SdOoKKGHzCcOU+RCA7jJxvbeP/xLXIUIY5CtU64dtMk4J20/jgN4//y0fXbuSD/M4FNYB0wYiT/kKodMXrwoxzmrbmYUTtSbEyzoxkAo1m4T3X0RjW/LWNQQMTG8wfOvOwyQ==
X-Microsoft-Antispam-PRVS: <DM6PR12MB268122F96A4F8ACDD8B5DC25E5010@DM6PR12MB2681.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:DM6PR12MB2681;BCL:0;PCL:0;RULEID:;SRVR:DM6PR12MB2681;
X-Forefront-PRVS: 0787459938
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(376002)(366004)(136003)(39860400002)(346002)(396003)(189003)(199004)(52314003)(93886005)(65956001)(8936002)(81156014)(64126003)(31686004)(106356001)(36756003)(81166006)(5660300001)(105586002)(53936002)(65826007)(97736004)(6486002)(229853002)(76176011)(67846002)(386003)(47776003)(77096007)(4326008)(478600001)(23676004)(52146003)(2486003)(6246003)(52116002)(6916009)(25786009)(7736002)(316002)(305945005)(50466002)(68736007)(230700001)(54906003)(16576012)(8676002)(3846002)(58126008)(6116002)(186003)(44832011)(86362001)(2616005)(476003)(956004)(53546011)(486006)(31696002)(2906002)(11346002)(6666003)(446003)(26005)(66066001)(65806001)(16526019);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2681;H:[10.236.136.62];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTZQUjEyTUIyNjgxOzIzOlAyRzdUT1JVNE5SZTZwSGc3YVVsSEw1eWxY?=
 =?utf-8?B?bzNnS2tkb2NSUkY2bGhDOFJsaFlxSTVOT0taa0pUTVozbHpOeEVKSDBRTWNq?=
 =?utf-8?B?Y2NjRmpsUnJmdDV4bkhPS01lY2M0NUd3Q1ZhZklnWlV3N010YUM5c3dGUDIx?=
 =?utf-8?B?MjA5ZkhEa1VvYVlQSGdDNUsvT1gxdTYyODJndnpPb0dUU2RjUVpFQ2Zqd2tN?=
 =?utf-8?B?QVJsdmRpclMvTUoyd2NCVWsxMXV6MjlpSm11SUVSOE14VDRZMFdnNzgzTEE0?=
 =?utf-8?B?WHlDek8rSDNvRERWWlh2bVU2dHRkcEdMZktZVmNsTjh1elJtVWVzSDVKVUI2?=
 =?utf-8?B?dXhiWXNTUlZ4blh6TW9FaERBdU9CZFExcFk0WFFpendaT0RVeHpwcnQ5NmVj?=
 =?utf-8?B?d3diUmVuNDI2dWpEYThCODJ5OVR5REpSQjJ1eWpDSE9XNkV0aVNFd21YR0JW?=
 =?utf-8?B?dWZkc29TeGx0SkhKZEd6SWV6YzBoZSs2ZGRzU1dmbDUzMXUvR2syUjVyQXI1?=
 =?utf-8?B?VzZEcHNEQ3c2UHRKdnpWTjlJZ2gxcVFMMnIveVRGWmJHY3MxQ0R6M1JrOFB4?=
 =?utf-8?B?dHAxQVE5UlczdWFrMGY2UGU4b3pvZ0wreldheW1iWCs1U2wySlh0ZjA5Zm8v?=
 =?utf-8?B?UUVja2V0dVFpaGZZaHVnaXgwb2VJd0VTSlhwdFpOcU1kdThLb3pjRlE3amEr?=
 =?utf-8?B?Mkc4djlRaHZkVklJd2ZlYndYUW5xd3hSb0wwSVNMNGZQQWRwdU8rcmdxVkt4?=
 =?utf-8?B?aWVoZzNUYTg5MmVBVXlwZDZwaXZIa1QrM1ZFTDNlZTBsclZoVjVySkZKRExy?=
 =?utf-8?B?UHBaQktvajM5aHdCaVRIb3RTNnlXUHBYYnViSnl6R0E4MDZxcU5LUmFMNGdt?=
 =?utf-8?B?V2dLQlpDRjRRZG5hMGZtWUZ6M1lvMHZ1aUZWUTNRNnBhaUVoeXhUbzFuT2M2?=
 =?utf-8?B?dzVmbWxNTXRSU3dqQk5NeDJ5QzhWNERCaC9PZUNKSzhNaThXcjUwb2FVckpD?=
 =?utf-8?B?czlZS1J4WGlJTjhCcXlUNVQzVERteENYOTFUbTRMaXBmV2tONFNhQ0R1Y2ZN?=
 =?utf-8?B?L1h2YkxBRnlzU3VRUUIvT25QRXRnY3V1ZnJxUE1qbzd1VU9aMHJsYURscnBO?=
 =?utf-8?B?QnFVSzg4ZVIxY0dkZkVWeFlHdWZNQklpOUpDVDBnaGZ3Q1BqeWJNZnM0WXRG?=
 =?utf-8?B?L3BkMWZPdFlNV0tOaitocFVCVzEybDBsYXdNVzM4VlhqOW8vZkhScWM3NzVF?=
 =?utf-8?B?UE5aQTRoQmFwRWF6UWZjMm5hbnhtR2gvYmlCMWhyWEJFT1V5ZnNuNTRodjJy?=
 =?utf-8?B?QzdORW5nSHdiZ0IwR3RhUEZ2RWlkN1hGSFB6T3Y4Q3UwNk5ZUGFBc2tKcjhS?=
 =?utf-8?B?OW9scWVRZCsvbzF2c1N0OGlxc1NPdTBGVnVyZGZLbnhXTlJOZ21RYXd2TzZK?=
 =?utf-8?B?N05ObzJLUWlaa1BVcW9NbldDbWticlJqd3BjdXUwRlo4TURaRHh1akJiTWlM?=
 =?utf-8?B?dHNEMlZMSzdvSWFqS0N5OE8rSElnMGlxRHpuazhpa2Z6VDR2dVVDZ3RuMUlX?=
 =?utf-8?B?ajl1OVpTNWJ4RE12NVRmc0tMV0hkcFRsUkhXS3pqaGt3Rk0yRytTWjFxMjIx?=
 =?utf-8?B?b01iMzdOSGpWTWY1UHB2bWkwcHBBc3RCK1prMkxMMERzb2tJaFVwdFAzcitp?=
 =?utf-8?B?OUJ2cWNsOWk4OVgvNm9GMHZXKzFseFBYT3JqWDUzV3VGVjEzcUF1VUJRK2Iz?=
 =?utf-8?B?d1l1MzArdEZkeERXQitXWEZ1SW9XeXNZQmE1ZTlRMlZ2SnNsVTVBOHN5UEZY?=
 =?utf-8?B?NUNqQm1qU2pSUDQwU2VhSjR6WFAvUVVodEdRYkg5ME4rZ3UzUy9OUFRISlNk?=
 =?utf-8?B?d2NaZURyMmRZakY2L3pZVWVwRkdqRHdnWStpWGR2RFNHWWp3YWtXQTJXYzhB?=
 =?utf-8?B?VW9hSWZLMzcxaDBrbnBRR3Bta21VSi8wbVRzeDJaU2o4THF0cVlMVDN6ZUEr?=
 =?utf-8?B?akxIdi90cFJaNTZ0emVhczJWMXJTK0xxQWpRN3JXTHRLTXd0RytFKzZ6NlZW?=
 =?utf-8?Q?Xw8M=3D?=
X-Microsoft-Antispam-Message-Info: 8hhGFIqATgJyjvNSzlHDA4ErWpS3ouTQmnhajVR9xoF78R83+gSesuA3JVDdjsOdvHZ/Y/5O/zM62JdEOdcUiBDqMMoruzpuzcKRKv2clg/FGHC++r0aH4gPPUD2rhtbS6E1ehirZbuuSpYh7Fcb+6xQQshMZbj1uXjCNEwGswmSOdrCMmx/KQdH6Nt+uxKwvCtqVn8rzCz7ErfneNcRv3gSJjLdCX9YnTgV2tOBCrCEFmLA3wY857HHm81vhUt9h+sgOrU5bGVmRV+Jx1rrJMiNsBwxpRk10uSNa6G3csGuwvNfV5SXZOmfwMz3QI7UxhE0n5J4d0meLaPZe4oUlmvhRYUrjRWtN1LK92Mb5xU=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2681;6:+R143J5xl6CCic+AcyIE6eqkDTiDwRE8LAagxC4LEHbdK308XOYXC1gYV7fQih37znZXdF51rDFbC4hRJ2Dgvs+dM17q3v31K0RMwwqM4kkEhJx9S7d1wiMuinoOgZdnR61dc0uOfQDgJltES/9cr7hZsVEwV0eeA0udnsnq43gNRqJtUj9YrHir4k1J3PFYeWk5n2yzLiSVl1NwFg+4wqsWHOHHPhErZB4bfsVXWgigw9XI0/pjS42HmH+6KUK9WaPJMxi9M8wZQs4//liBYIVITzzBTtdjqFG5HmiWYLDd8vZJpxzufD2Pjb6p2CRMPEWWEg310eyrsDaUN2/wURHS8DruGWORKJkeiz1SwInxiVXeAHGzkjkwhdv6wSXUzoq5lVm3aJJXd5H/w9hXGEb9wFQqjQ7NJh4DB3XuzRV1l0u8VmRURKSPIFFomGkmeVGXAGD6hRYloM8DehLXHQ==;5:euhHNEO8kz1J/MzHEk7vjfwdRV1lMXbitRybDlMpUiSPmc5m1EUcEC+6rlEv+yXtzE5wRhc0AFKuRY57L6rImDywGweH0XySg2I+M5YYZnQAWIwhXcZrTJe0/UtDQyz0gvtjx4g8xREg5+M4mLw0SjtrhMaqJ1+oZb/Bx5qXHCs=;7:L7Mp4zsI6VC8QTRTwgFuS5Q3KFrUe2lL5oQpupRjT81L/Ko3B2fYF7wZZNm5QVbiSHdmx5PxeOciUGmoPj/se/KMMVwr1nJUav1rExzBKMYTBZr3GPGn4XzIPIbKBkL+4brNvzvUhtUt02qDRULKI9DWWB/aFEcfpdoUepoYwRIBpWGvXXEn/iYC730J+War1edLlje4xdakbXGsBHisd0+LFd/fbmdcpZLFw9CUP9pJvpJFHo4zVxQOZzQ/JlCg
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2681;20:fdgpNJ31QU56jE/sTtN860Bb81oP7O8JJTjC92rNGuIGDVqJ+WOn0dzEWUeE0uLTI56KIgxyDXfOyLVRqVy7uv6/SsbMxsISvttehNsTmRSUbD5SCAuIU40wtHICO4Jw0+7na/qgLdTYQyEr1uar9X+opieKUCkt1U8OFSPGfGW2kQhnBq9kbhpnYLXMsCQOFDq7QKy2X/EaP3M5KQlMiWQzzJy2H4MLVEb3xDeaDdEOmBaS/f2l+HQYl4YaWDgj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2018 20:20:50.0291 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d30de1e-ff9a-4589-af3e-08d614363d2d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2681
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/06/2018 02:47 PM, Sean Christopherson wrote:
...

>>
>> Yes, the auxiliary array will dumped into the regular .bss when
>> CONFIG_AMD_MEM_ENCRYPT=n. Typically it will be few k, I am not
>> sure if its worth complicating the code to save those extra memory.
>> Most of the distro's have CONFIG_AMD_MEM_ENCRYPT=y anyways.
> 
> I just realized that we'll try to create a bogus array if 'NR_CPUS <=
> HVC_BOOT_ARRAY_SIZE'.  A bit ugly, but we could #ifdef away both that
> and CONFIG_AMD_MEM_ENCRYPT=n in a single shot, e.g.:
> 
> #if defined(CONFIG_AMD_MEM_ENCRYPT) && NR_CPUS > HVC_BOOT_ARRAY_SIZE
> #define HVC_AUX_ARRAY_SIZE  \
> 	PAGE_ALIGN((NR_CPUS - HVC_BOOT_ARRAY_SIZE) * \
> 		   sizeof(struct pvclock_vsyscall_time_info))
> static struct pvclock_vsyscall_time_info
> 	hv_clock_aux[HVC_AUX_ARRAY_SIZE] __decrypted __aligned(PAGE_SIZE);
> #endif
> 

The HVC_BOOT_ARRAY_SIZE macro uses sizeof(..) and to my understanding
the sizeof operators are not allowed in '#if'. Anyway, I will try to see
if it can be used, if not then I will stick to CONFIG_AMD_MEM_ENCRYPT
check.

-Brijesh
