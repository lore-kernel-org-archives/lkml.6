Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 048E4C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 21:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B1F1208A3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 21:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Hp84mzKZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B1F1208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753304AbeGCVRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 17:17:06 -0400
Received: from mail-eopbgr710043.outbound.protection.outlook.com ([40.107.71.43]:35904
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753085AbeGCVRD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 17:17:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lu4UsMZ9GBbaN4WW2EntV76gbOcqthxk8BjEbeGYteI=;
 b=Hp84mzKZV6avjQehRFE1w4EEaP9d1orCOWAflN0oC9y2QE/W5GYqng3acKAkusY8SwVnwwlhtvIDkLmrAp3bY3t9NB19uL1vqR5Ql7D0AoVNcI7HaeKuwATlhjy5l4HaI2Orcv1RiBS73ssbMbPz/5lJmyGm3wPIMtOul9wlvag=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
Received: from Brijeshs-MacBook-Pro.local (70.112.153.56) by
 SN1PR12MB2462.namprd12.prod.outlook.com (2603:10b6:802:29::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.23; Tue, 3 Jul 2018 21:17:00 +0000
Cc:     brijesh.singh@amd.com, the arch/x86 maintainers <x86@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        KVM devel mailing list <kvm@vger.kernel.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH] x86/efi: Access EFI MMIO data as unencrypted when SEV is
 active
To:     Borislav Petkov <bp@suse.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
References: <1530624720-32004-1-git-send-email-brijesh.singh@amd.com>
 <CAKv+Gu8MZ1O2U=OiONCdaFQjNGVPjqASMP7ubKCg-9ULdk7Whw@mail.gmail.com>
 <20180703154418.GC4643@zn.tnic>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <e17f101d-8509-17bc-f099-92cd7e817f49@amd.com>
Date:   Tue, 3 Jul 2018 16:16:57 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180703154418.GC4643@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [70.112.153.56]
X-ClientProxiedBy: SN6PR08CA0012.namprd08.prod.outlook.com
 (2603:10b6:805:66::25) To SN1PR12MB2462.namprd12.prod.outlook.com
 (2603:10b6:802:29::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e328f27e-ca8e-4e47-8f80-08d5e12a515c
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB2462;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2462;3:lGKU/Ph2i9KFESNM69goguXSgU39ROsIJBvhz7JeJOwuXnPUawGJj+UVuT7gcgUShyE3PEsMZ07DIslLCBt0N1tUfLcBg8Y4kT9WMBS8rzF7RxgqRNf8ujL/ILYbpgCZEVGfPQ4kwXC4I0QCfcRDI9YQBkePvDi64DGp6qYI2hpyMMrUuU+M8g1OmWfw4g9kYylZCURpCL0/6I/rMqGwaVgR1vZXwSC5Nl0P8oM0qDupQ33P6f1Ai/CYKBg5p5f8;25:1P530QUHZXaTC6x8D7/3U56zCpEypN48D2I6nO6z01s1SBPJx1/QZWTX6OO7IA+uPD+e6H7x6CZmjKIStiSq71MXw0P/fY0CYadpcizEYCp7DBjmNhUGJcCNPDzhOdfrc09VjsUu1bo9h8RTvLsVKs5KmFT9dh9J/GZV0fzw2x7TjcSbmhwpxND52AkzAUWKGvE7QuRSDrf+ixEj1JZyFPjbDR3qs9Wi3FfiURHeDHvXMfIpyJno5chNovhpSlb3qXn/3OZ79dybYNMq/irk6doD4uak8QY3XmuC+/Xm3IrvWWl4t1SqCSy2WsR7+CiIhxoipogQTw1ahsCxM5KX7A==;31:vMu1ud8G8xPNzxsuOYMVy5v7v5Y6GsoiImKqck5dta12T6Blg62dgib35KIQl+Ojnkav4Vk7jRYmGfcWOE1vC5eICepdVCkXMPDJVdr9e6qjCoKVVytfEqYaLANuU31ZY/r9oPYucoBzii8X7qj8hqKQ76fPW0DEKQsSd+VbvC8QkOdZErXOYYj7CfEB+xmQxKcwG87d8dgs8n1SLSPsAT8nqD6X4BOlBi0ZQDrLFYw=
X-MS-TrafficTypeDiagnostic: SN1PR12MB2462:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2462;20:IKAMBWKKKU3axNEJ2+LyOiYqXxuMZSPIRy+mAjgx6IPqyChDj8WfRM13bSzrRSg14PcH4oOXFx+tEDo8Mj8KfdENLD6ZpZ1SF5v7zRf9ovlVoN9oMh9vt/AExOB0OONsxEJgf3K2UCLmjxdtFpuNYsuYWu8VDcxJBgwlrSeclmcxncQ6tloimOz/Z8TM+HhM4VmkGJlXClt/fTjs7Kryf6Nctun13KUm7HaAG6MKcpZ8vAeGVR+vi/+7G46UO5h66CuvkMAet2OXsTQUezpQIFhEVNSB7OXJpib/2He6yxtc/lzb1ByLoh5S5DOYpVxXbTLssQOs9gDKNlzm05NriXbidDoJn313AjS9mVHndpM1GzZb6jiJ3cjNEmcvIo8ciFaQ0oPbY6AdUaL0YFZ9gS33rc+x3WjaaFl6l8Piu7n/8gpDhTdrOgg7aqK52YTqsseS6ibO9IYHkltdBQxxiCUb7vcFnh9UCQhNvhWiCWJ2y0a/7YkYdzKHFjsGJk72;4:WAUCeO94gZK4xxAEVD1KNukGxgqJqf5nNovozfcigsl+TqlV511axzVLSHUdJ+oxTgyuTiSbdivd0ktNKBFXJx+wdosU2TF4x7hCqSZIgIp/Vxby8UpPrxls4QlKmNuPQpDI1pPOH4b/AAeh2wfG2dfMArLi2pGiSjBQZP4VeNVqpWEOTbgEd+Iur9KHdFL+JDW6fYHBV2EI8pwyh0KOsonZFZIf/ABUek9YONxrxuMIvEO/PfmBvvsOT9yEMhgdlimdQZges6NfNvq08tD/o4NpWjBK70o2aar0ykumCjJsYqydVibVgc55Qy74Uq59
X-Microsoft-Antispam-PRVS: <SN1PR12MB2462261DDDB225110E62EE5CE5420@SN1PR12MB2462.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:SN1PR12MB2462;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB2462;
X-Forefront-PRVS: 0722981D2A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(366004)(136003)(346002)(396003)(39860400002)(199004)(189003)(36756003)(11346002)(2616005)(2870700001)(65956001)(65806001)(446003)(956004)(64126003)(4326008)(16526019)(2906002)(476003)(6666003)(44832011)(97736004)(186003)(478600001)(26005)(68736007)(5660300001)(6506007)(386003)(25786009)(7736002)(47776003)(66066001)(50466002)(53546011)(305945005)(76176011)(58126008)(2486003)(52146003)(23676004)(316002)(52116002)(65826007)(3846002)(86362001)(8676002)(31696002)(6486002)(110136005)(105586002)(6116002)(106356001)(81166006)(54906003)(81156014)(6246003)(53936002)(8936002)(31686004)(229853002)(14444005)(6512007)(486006)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB2462;H:Brijeshs-MacBook-Pro.local;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjFQUjEyTUIyNDYyOzIzOnkvYURuTEIrZzhsWmcxdkNURlB3dTdPMWNh?=
 =?utf-8?B?clJ2T3JKbmhQVHkrSm92L2hyNGd1MU9PbVUxNEJDVy9nMkY1OFFTbEVjTlc5?=
 =?utf-8?B?cm4wRXNZb1JHSFhVV25hVk1VUWZPaTA2WFpnYUVOS01RUm1EdTJEUzFlNDdp?=
 =?utf-8?B?WEdwMTRqU0gvMUNVcGZSRno2bFE1MDl1MmlIY28yNFNwUGhBV3RKMSt6S3BX?=
 =?utf-8?B?NldYMXRkL3hUeGpmNWJZVWdaa0FiaHBQalNsSmVLY29BUG1RYy9XZFVHS2hT?=
 =?utf-8?B?VTc0clZPMzFlVWtMUVNMUTF1S2tOdXVVaE9Od3JqNml2enkvcG5sd2xYOVNJ?=
 =?utf-8?B?RzVpcDVKK2xEajJOeWFzM0JCS2Y2eENwODBqN3ZLQUNWVFpVZy9QSWJ3cklH?=
 =?utf-8?B?MWQ4SFIxZDhkYjlRUGZEWjVmY21kVzE0aElYdnRMaE1tOFQwaGpVeFRWN0JX?=
 =?utf-8?B?cytWeFQ1Wk02N3lQUkE1N0FHd3FmS0EzRzhZMmp6UjlyM2kvRUF4Y3VUT0tY?=
 =?utf-8?B?WEV0T2UxdW5USjFkTEJKV29JNWRJdm9SNWR0UkhqcUhJRmRnYUpSZkYyTnJq?=
 =?utf-8?B?MXNKdWk0bU1vMGJsTk1ITTdvTXpWSjNxWXAxdnlqQkRLMEJMWmRYWlNFQnEy?=
 =?utf-8?B?a2g1VXBQUGRxNmtoK0x4SlpXTjZpazAyNjJDOUhvNmZCVmpvd05Bdk43UmNZ?=
 =?utf-8?B?eDdEOFJsRzJ0OU1vNnNFeUVPaldPM294ZExlYTduNmZ6eVozblRTWmxiMWhs?=
 =?utf-8?B?VU1JcWFTWEFJM3MzU1FFNGxpM3BzNDEwNkZrQXY2RFFYNkd6dFFlVXFqWnVo?=
 =?utf-8?B?L2M3TE1WdkFjVVgwaHRrYlI5QjdhR3pTQzJDZE4xcTljWFFQSW5COVovWm5j?=
 =?utf-8?B?MkEzQ1pXME1DeHhnL1ovZExKTFlxWDJJai9CL1ppUlJzWFdCMXh1ZkdTZFZu?=
 =?utf-8?B?VEdLcUJabVRNWFJONFhIUThQSzZCNVl0NWFpbmNGNU42QkZUTHpEZmQvY09j?=
 =?utf-8?B?UFF1LzNYbFVKYUlnT3BsN1BMZEJjb3ppN0FiczJXU0hnL05ESXR6bThxK1Zj?=
 =?utf-8?B?eE5makVwaldyc1BudG91Zy9kU244Z1UvUEd2L1Qzc0JUYytLbGtkVjZDWGdy?=
 =?utf-8?B?bXBDNk1sWGpnUTd5V3ZJYzJNMXBGYXV2Zmg4UDRGeitVMGcyby9NSEtRb0dh?=
 =?utf-8?B?TFdvUGMvOU1GQ0huQW5SeXUxNkNUc2NWSEpmdlhtemRSc3B2ZGtLOGkwbWFH?=
 =?utf-8?B?Mm1NbXpVWjF3RTlsS3J3M0J5UEhuSTVWOU9xZUN2cG1WNTJLQjFoZUhHaXNl?=
 =?utf-8?B?UnlLNm04TEN5QXJhSUwyd3dTcU9BR3VkNHlPYXNudkttVXBPWXhXRk9YQXFt?=
 =?utf-8?B?WmVhSUh5dHMxMExMaVBxMytHSmpweWx0NlVoSXhOakhQZWRUMGR4UVhrZnRa?=
 =?utf-8?B?TDRIWTJjVmNhNms4N0RaK1NEclV1Y2EySUMrYXhyazZBQkRsOFltK0FaellN?=
 =?utf-8?B?dXovN0MwdHlTeWszUVJPcGZaMDZ5NXhoSzhGbkdGVHJZaTJ3VlRJS3hjeUJn?=
 =?utf-8?B?WEs0TU9HaVhzbjdreG9RdkREWkFsWllFL2RDZjBRcXU1N0JJOTM4RTNlejgy?=
 =?utf-8?B?bFVUeWxRRDRNeHBiYzZxOGpOKzhueEozbjlMcHB2SEZqakpKYmZNL0ZQZWtS?=
 =?utf-8?B?VDk1c21uejJYYzRVU3ZOU3VRd240Y20xYytPakN4S1VId1l5NU0ya0RiaWlR?=
 =?utf-8?B?bjIrbVpJOHk5UWJYTGJUNXdXNmgySlF2MVh6cFR1dmdBRTExUHJLeElxMmwy?=
 =?utf-8?B?bUtnSjNtSWVnZUhQK3R3Mi9aWTZubUN2L1A2R01zRGJqeXByaFFBSG1MNXI4?=
 =?utf-8?B?M1pZbnBuTUVzRUcyYm1xN3NwY2QwYVppbWQwMEhyUjZ2dWhpNk9ZNC91T2o1?=
 =?utf-8?B?dWIzdEZOSzdrckcycERSTXgyTXN2SE4zZnY0TE5WeHZsZVhkLzQyNGJmbTVY?=
 =?utf-8?Q?ncuTRq?=
X-Microsoft-Antispam-Message-Info: jQb74OCPJsnxO/yI80N7TBhPVnMvdZw43JmlycX82yciipyTIWgYFX78b9UFyDv9Xp2FSmgFdYebcWWJn55Gm42ssWcGtlzln+4qMcDcyPsY11+JSusIvlE0LJt7FZKJq7B4KF0vzfBe0QTxGLYx2tK3ysU5nQele4/WYsYUYtva9snnr4crMDIRqTxGQRx0pJV65U23NjC46mHn5jvptvk87pPXOTu5kehfIfoiPbv4ggyObBc87ooNhvsXsrcHqvFDGZf6im73z0u4dj1SsO6MuKisnoMIqBriflBbFzG4PO0F9NfILLhqpzezpuGvPuy9A45jV7XA4eF7pPqdCvU/CFFVztI7KQfdNXT9u1g=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2462;6:n/3orhGubjAdC0XSZVn8JK3kd3KACcX5hX00c+A/3MNTLeKUTEEhm1Zujt0oG66micI1Sbrca3ZBf/pqgJhhtR5Omemr3UvCcI6xBeN5RD8MWCLcK+kbFlex6ws1Je6v7n/W2zlJxxQBFWPYzWvkY0aMv2UYS1yEhm+T9BrgT0k5H6tZBOat0Jpz1qKt8dyp8mXVNVBg38OBIDl20reWRx4xrdO1Nqzv38GKpxj4ZXffN4MZ63t5Vzxb/tlic5Pq4dnKaqHYRvfkk1GeHTbDTfXMyrRDlFM5HDk4QyPmvq3pFRingoHzj6NAaAyrYZnSDEa+Ca7NAB5TvVSWnWvPwNMcyGa90b2l00eXbPA8AZWh/apUJEY36kN8qEtUGmszfkxfSEtN6neqBjWYZC5PZGwCy9nJBn771sg4+1uXUJwHs9AfWA1zCAcnaep3Je5YMxzPUiUEaELHSjYqC+/ujQ==;5:nBwf84WBrt6MKCyWR7cu5Me0RaLPU35/0vQw4WAJbwn0UZlZOjFupEAnBcsw101yWH75rjXdtHSb9WrlG954ObWLSx3TYH1QsQM7Tc4JDk8+8gOn/KwMas+5Xg9Yty++9SyjA2Vg6MoUbJ/KDdw8rtHvSMnfNRnjU3zPdc00ezs=;24:ZWccnZkFT1vzfKo8XTcBwcjtd3NrxQZRtfiSjSJ4HhPytvC7YAv3sPpuNJtz/xUJLMUvgMrHyaY82XafWhk60kfiWjqzazgwoAYBpIvwOqA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2462;7:t4mgzE+8LzUKpYZDqrAIcEYz/BBmzs4qqUZlGZamFYxjexXJ5FQqZu43idAZfJ9eU6i1N+7LlUl0rOZxOxW1T773wef9yUBf2V3bKVVKMWQMcyDjxm0pn2O9+4yP6aQAFIr5a0KDvGcGNxL+hoLf5RsYHrMtKmKf/YTNpCe9T6+5sHRFcrxtOvJqddbTUhW2cOngU9fnv28Q+rsGVsyNfS2T50XqwBOTCWvcmAPmfjCSfn/WKNU7CLG6Mli7+Lib;20:o6sqwa6B2/4JVvNRJR8K+aq1DBCF6Y6c+pWyPGZ2/9Ww8djSEwH14U7iUutX5f5i4Ec93kEJcn3XKMGaaYk23Mw17GJ7oWBzHwoIFhznHgTuAhv5GfpEdyeCsYTCfEuxUx0sVIe22yDlNVmsVv3yJ9O+BVdY4zLvpkO8Dfk3+BYVW+4NaI4Brc1nvAvPE86ifFqQ2ts6Eb67yL7N4ARw8JNW6lp2VB3zXj/r3EK495XI15jK5/cyWIcjo6KCzL1g
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2018 21:17:00.7876 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e328f27e-ca8e-4e47-8f80-08d5e12a515c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2462
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/3/18 10:44 AM, Borislav Petkov wrote:
> (dropping stable@ as this is not how you send patches to stable).
>
> On Tue, Jul 03, 2018 at 05:37:18PM +0200, Ard Biesheuvel wrote:
>> On 3 July 2018 at 15:32, Brijesh Singh <brijesh.singh@amd.com> wrote:
>>> SEV guest fails to update the UEFI runtime variables stored in the
>>> flash. commit 1379edd59673 ("x86/efi: Access EFI data as encrypted
>>> when SEV is active") unconditionally maps all the UEFI runtime data
>>> as 'encrypted' (C=1). When SEV is active the UEFI runtime data marked
>>> as EFI_MEMORY_MAPPED_IO should be mapped as 'unencrypted' so that both
>>> guest and hypervisor can access the data.
>>>
>> I'm uncomfortable having to carry these heuristics in the kernel. The
>> UEFI memory map should be the definitive source of information
>> regarding how the OS should map the regions it describes, and if we
>> need to guess the encryption status, we are likely to get it wrong at
>> least some of the times.

I agree with Ard,  it may be good idea to extend the UEFI spec to
include encryption information. Having this information may be helpful
in some cases, e.g if we ever need to map a specific non IO memory as
unencrypted. So far we have not seen the need for it. But I will ask AMD
folks working closely with UEFI committee to float this and submit it as
enhancement in Tianocore BZ.

> I think the problem here is that IO memory can't be encrypted, at least
> at the moment. Thus this patch. I believe future versions will be able
> to handle encrypted IO but that's something Brijesh can correct me on.

Yes you are right, IO memory can't be encrypted. We map all IO memory
ranges as unencrypted everywhere else in the kernel. The
EFI_MEMORY_MAPPED_IO type should also be mapped as unencrypted.


> So it is not really about the UEFI spec but about what the hardware
> does/supports currently.
>
> And I don't think that change matters on anything else besides AMD with
> SEV enabled...
>
> Thx.
>

