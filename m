Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id C0415C07D5F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 18:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35D962086D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 18:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="uwdQrhuW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35D962086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934416AbeFKSdU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 14:33:20 -0400
Received: from mail-eopbgr720073.outbound.protection.outlook.com ([40.107.72.73]:46056
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933493AbeFKSdQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 14:33:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dKmdGH/V8sH7UIWDtJLYzD1FvYtzLEhpMwlHNz/YYwk=;
 b=uwdQrhuW1vAeEfvTYcBUXrW03bUXaxFVI15dHo2rD8YBW5Rp4p9On4avAqjhV7TLYwUdnMy2mUpqT1WMP58QFcnGMpyXXIHlXmc4i4U+PX8qGE/JNcfrx9lVYxkmF9QtngPuiKC+Pke/O8IYdPaboEJuilQp3FvkqGz0toYwijY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
Received: from [10.236.64.67] (165.204.78.1) by
 DM2PR12MB0169.namprd12.prod.outlook.com (2a01:111:e400:50ce::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.841.18; Mon, 11 Jun
 2018 18:33:11 +0000
Subject: Re: [PATCH] optoe: driver to read/write SFP/QSFP EEPROMs
To:     Don Bollinger <don@thebollingers.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     brandon_chuang@edge-core.com, wally_wang@accton.com,
        roy_lee@edge-core.com, rick_burchett@edge-core.com,
        quentin.chang@quantatw.com, jeffrey.townsend@bitswitch.com,
        scotte@cumulusnetworks.com, roopa@cumulusnetworks.com,
        David Ahern <dsa@cumulusnetworks.com>,
        luke.williams@canonical.com, Guohan Lu <gulv@microsoft.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20180611042515.ml6zbcmz6dlvjmrp@thebollingers.org>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Openpgp: preference=signencrypt
Autocrypt: addr=thomas.lendacky@amd.com; prefer-encrypt=mutual; keydata=
 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
 zSNqP+QUNp6BotWI
Message-ID: <496e06b9-9f02-c4ae-4156-ab6221ba23fd@amd.com>
Date:   Mon, 11 Jun 2018 13:33:07 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180611042515.ml6zbcmz6dlvjmrp@thebollingers.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SN1PR12CA0068.namprd12.prod.outlook.com
 (2603:10b6:802:20::39) To DM2PR12MB0169.namprd12.prod.outlook.com
 (2a01:111:e400:50ce::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM2PR12MB0169;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0169;3:LWF1OR4vbtlKbL8aJVq7NbWqZhs+Y32RGk8sXMPYmcXI8IPtm5iuwlfkWH8KN3h0YGzN9i21dy2hxuk7zm/dquTvWSeEivhQwGSMSRtEUWyPtm+mTRzSnud9Knxls+jR3pG+nLaULumOCA8Q7yh4EnOp2gsCIHK9Op3XRUthCXkip8YakeRw2er9+4VfFu+MqDPkjGM3FKuuLjj0LxWvziUkcgvMoLaTfUZHdCVLMeJewSROvWOe1UVt/SmeOxOX;25:6b+o5FFOOuz3RYer3N/kycVyC1AyOHFm/KVjXZGtpny9jFaBPgroC2Fpep3YeHK4UvpG5Q9IkUjyHC1tF1j5BlC0eD/Cv9ZyYGJm7vSYyzIIF2S4VaFCYLGzhyVVyqbM3yNrid3QZUma4to/hwod0Ra82lfXxaGXlq0ZCBv2bc8gm2ExGYdocfMgLv2a3JbSc8gockBNcteuQjQOwmlncr3nYgoINBcywi1ZzNCVco7o474t5fbC+GQcXYOFxBo2okMlgCiUnfIkZ6DYISPlGeKSoibfEnGmt4x96bJb6lU1C6wPKdTeDcYWwi+BiMD3DHLOf5xbDRvdLo3bS/D6SQ==;31:lmq5+Fgb6meLEanznftUo46yPv2nq4OAW9GZ2bKZc5jSbC0TUkxSYR+ytqPYknExcZEkgokNjGfZJojv1fFLWXaA0m09aAdKdEQint9arhcXZpEwhkqbPBcZKu01eTybuIV0zdfCY5qwJgxs7NaTOwggRc2TFOz5OHWGm1f3lC0m88jXYbLFr0yPMG+t0U0+dp9NhR3mm9etYCxUjntPTHTAAi8eYypMXenx+jpfBnQ=
X-MS-TrafficTypeDiagnostic: DM2PR12MB0169:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0169;20:Zk+DX9nCyXaHiogXnjAYHSikNr0SywNbmyeuADIcr/+ZuNtGix+RlxlxCDEn0H9/if4gNPuRDObb4TMWjTRudx6bf4TTjkN2MI29iLiWbDsIATB1VaR3MJpMbA0ZyV9Zv88sHDO0Sm8pSJOwDuw3WeMv5zp7VhyI9pHmhkRbIcsGJpnFfsnEVxLjyYc7CfmpkIcBh1pPGb6/qI2h7Glzban8lRJcxmPZWlyCd1gdV8r2QYofnvZNql+yvL6Z0/FYt/TYheVG8R+UKMxIXWpE5ncemriHK41DJQkaZObV5qT11K42Kwz+MU21L7IarqVbTNIep3rbLQm+q0HzlFJCYH8CMvZkVj7MszKrHYqClzKO7d4890I/QXmAqSFFQejBt1E2upBaF2tEb2tTTCP3ztV2sEEYySVUwRoenTvdTuwPke2ng6Y+Yq/18VosXm6Yem7O/WQWJh3CE7SrpFF3YQ44nrUjcNfrMdF31VqBfMDjRAIWHga2AjBd4D68Cnvv;4:HXBE+mfXGQ/s5d2blKkccBH0+CosJ8i+kRGB9h3g0OfDMxN2DimywZMBkPGnaeJLyhfjDN1fgl49HsdOo0CoNwnHSATeXsoxWDkptC0QUoWRc2/Da0ARMfLXo6dhxLSugSDbU0proDW7EyrG4FLxXXyfyrHI9jz3WJWaUmFgYEkcBuV1hlTaakhDimTPi/9CAxQNBn908aN+seOYtt22MBPXe4VOqGqgb7M1trVOn+h0uL+x8ZQ6tzIHhP/8GHYmmnco1O0zqiIX3tNVGl2Eid66iNQ3xd9IowPxums4zam7F0RJzRGspZEt/K4NTpoZi2fuDyAP3kIIddGg0LCigsmnkJ/PMxoHEveTqe1uwFg=
X-Microsoft-Antispam-PRVS: <DM2PR12MB01699A937B896BC12792EA36EC780@DM2PR12MB0169.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(20558992708506)(278428928389397);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DM2PR12MB0169;BCL:0;PCL:0;RULEID:;SRVR:DM2PR12MB0169;
X-Forefront-PRVS: 070092A9D3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(396003)(346002)(366004)(376002)(39380400002)(39860400002)(199004)(189003)(50944005)(8666007)(50466002)(6666003)(68736007)(6246003)(72206003)(64126003)(8936002)(36756003)(2616005)(7416002)(65806001)(956004)(97736004)(7736002)(47776003)(5660300001)(65956001)(486006)(2906002)(106356001)(65826007)(446003)(45080400002)(551544002)(478600001)(305945005)(476003)(53946003)(2486003)(23676004)(6486002)(81166006)(229853002)(16576012)(186003)(16526019)(25786009)(3846002)(6116002)(3260700006)(4326008)(52146003)(110136005)(31696002)(386003)(66066001)(76176011)(77096007)(316002)(26005)(86362001)(575784001)(105586002)(31686004)(53936002)(53546011)(11346002)(551934003)(59450400001)(54906003)(81156014)(58126008)(230700001)(52116002)(8676002)(2004002)(579004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR12MB0169;H:[10.236.64.67];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTJQUjEyTUIwMTY5OzIzOjE4L2pUZzNML3VDemdYQzBZNlV3THVlczlm?=
 =?utf-8?B?MkpRSXpLRzluRlowYnRtK2xhRElDamVnODFNTVNCUlJRVENHeEJXNTdKeHBw?=
 =?utf-8?B?dEwwdEZBQVBTRDFGU2JoemRvQjVLWlRkOFBCR2FLMWJaMnFtWFFzVmdNbmtD?=
 =?utf-8?B?ODlUVlptNUk2SE9RakZlOFIvZkNRWGdKLy9XUmRIbzk0aTF0UEJSbUlpM1dV?=
 =?utf-8?B?SmZXcHRVSU5VQldZS0N3dDM4QzJpejJNTW9BMUxxT1FRQ2c2WU9UQlV0L2Fj?=
 =?utf-8?B?N1g3SG14N2dtbDZEU1pTR3hxdVZMdXZiYlhkdlZrdkxtMXAvcEFBWWVscE1K?=
 =?utf-8?B?bjlLRUY2eEpPc3daeStlcGVZbi96aHlkM3hHaloySHNCY0NWVE5BU1FRazhY?=
 =?utf-8?B?a1BWd3lCcHRrd0VPL3BVejVrbzZkL3BHMnhuS05KR1pTbWQ3VmFYZjBMMEsz?=
 =?utf-8?B?SDJYZVVUa3orS1V1aTAxS1VMTk0vNis1UE9FWGNWajhnN2x2S0s2WHU4djBl?=
 =?utf-8?B?ZHVuNnlXbjl1Vm9UTnp5ZUtuV2F6NTdTOXhBeTQrNTBvOUh5b0Zhb3RTZFA2?=
 =?utf-8?B?dklFOWlRc3NOSE9OZXNFMUFOUGtVNzc2OVJmbU8rRksyOFRBTE9mUjFpbEJD?=
 =?utf-8?B?OThrNHN1ZmsxQXRjZS9udUNBNld0RzhQNENVT0o0MWF2THdJVlg2MVBDbnU5?=
 =?utf-8?B?ZEhRWHVBb2t4ZGZjK0hNMFZVS05sYUhvMFFUb1BTN24yN1BWWlhEV2ttUnRC?=
 =?utf-8?B?NzRiNkREcDl2NDh0TnRwOXdNUERYYVN0Z1BINEFLNXdQVzE5V0Jjam42dTJz?=
 =?utf-8?B?ME5TRGcxQUljYkI2aVRVNGNvY0FTTm1JMC85M2F4S3djcGdLY25mcWM5YVB0?=
 =?utf-8?B?UG5FRnNUV0cweU93Uis0RllyU0xseWJyQlkyalpWRjBZUTZmcUpmRFlsaUdQ?=
 =?utf-8?B?V2JRZXBKOUwzN2M5dWxiMjhndCtMSllqcTV4N2czS0xhekIzV2ExaDNXNEhJ?=
 =?utf-8?B?SlJrRnhvUGd0bVNhQnVMS1c0LzdubTk3NHBCNDNNRXRaa25ZT0JHbC9kMWpD?=
 =?utf-8?B?NnA3UW15enFHbG5mSXBsalRKN3krcHJzYXh6VjJpVnFrbnJrbGxVSUF4cnhX?=
 =?utf-8?B?Vk53MnhnWk9UdUU4N0xWR2VxMGNvYXJ3RjJTb01BdEVJd2NOU1QyQVYvV0R4?=
 =?utf-8?B?K1loaDBDdE5iZnF3VUVCVUVRZU1NQ3dObGZPTDBUUWt0MlQwdnhxNmVIS210?=
 =?utf-8?B?U08rS0kyZkFKYUxRMFYzODVPdkRSRWJLL3FoVUYzSzQ1SzU3YXBmd1FvdEZB?=
 =?utf-8?B?ZEVSV3AxaEFYK0RUUldsM29Edk1ZRTFMcUpUcjJNc2N4MlFuQi9xNjA0SEE0?=
 =?utf-8?B?N1BrR2UxNU53WGhyRjdOT0pST25hTmFhYXE3amlhbGs0Y05oam96bG9vWUhk?=
 =?utf-8?B?SlkveVVxZ3duMzRNM011OXlKYnNpTjlQWVJETzNEQzdTSlQyRmZpaWd6c09m?=
 =?utf-8?B?TFZGa2o4R2RJejRNdm5yY05vekJ5WjJheWRSYk9QSXcxMUdLTzZQY01INzht?=
 =?utf-8?B?WmNSSVNLWCtQSjM0QnZNdGpIb29uZy83TUJJekJtL2tudnR0Z3FFb3R4ZGxV?=
 =?utf-8?B?N3c4QU4wc1poQStZOVpndWxDamZWdjBKU1RhVkVkRzVtZjFRSmNCZFVtdFU2?=
 =?utf-8?B?UUVzRWdDRGhKak9LLzhMeStDN05jSzRMMDBnN2cxYWVkTDZTa1ROMU11blcr?=
 =?utf-8?B?VzlJWFVheTc0dTk2TEZWbzJiUXpyRUcyaWRYRXpXdFE0eHpoSlVuR0FBVlFT?=
 =?utf-8?B?dG5GUVVzY3JMbks4S3poNTF6MjR1Q0Rwb2dnaWFTRjFWM1VKNmNhLy9NVTR1?=
 =?utf-8?B?MHRtQjYrc0U5QkgrSWhkOGZ3djZzWnhKNTgvK0Q3V0JVd1d6cHM3dFBYRThT?=
 =?utf-8?B?Yi9QeTNjWVdpNmJxbXlsaU42Skd6aytSRFVTQ3hzS2VLUi9xQUl6NmZQWVMy?=
 =?utf-8?B?TFQ1WGNrcnl6SVNCOEpXRjR4UUZiV2xMc0JjQUY2RWR4bkFibnNpd2FITkpt?=
 =?utf-8?B?dUVpSGxwYldYWFhvclBEdTYyN3MyRHhkUDZ6cHp2UHBzTnJvRFNQdWZyWmtB?=
 =?utf-8?B?aWVKTnR0ZzdObGZNMy9pTmYvV3NQRVY5N1Juczhac1k3eksrcTd0OUcwYnpz?=
 =?utf-8?B?UUxvTnl1QkhxUlRtOTlLM3RoNHhTditlMHdvTDEwTkNITW1kMldZdGJTKy81?=
 =?utf-8?B?TDNpRmJvVGJhMHVOUE1sblF1OCtpOU1vOXNmWGVIUFBrWUJpTjBOLzBHRUhy?=
 =?utf-8?Q?DmqW+OfFqy5GaGykf/y4pLP3QfRXW5giNT9+R?=
X-Microsoft-Antispam-Message-Info: J8NXn+opAwKEoicHJBxg3wmP3ciAIURiLjLRpBpqgqPAwCdugc66FW7lS1ymqQS9/E7hdCBCNMk5J9xQjO1oyLmkBC0YA/RHwnnXoIhnfd2mrSESPa5vxueWqZUyoPjTYopQXPFHJRwpRgVlgv3ytg7YuEvZPyKtCZbIgBq4HIRSfzuGnCU+W+YfL0UgHZSe
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0169;6:RrQ57MiQYb/qb4YThCOwtY57je0122w5do/LCFjGLwXvKJUi0ZmpP9YyVnb9jRRq2ytcaBx+IcwcnEFEaERWOtJVAyzssG6pYTgCkOMe4s2qpGNyj8WceKjSyHDxe8ZDFxAoLunnotzdQ66AkWKOz93ob4ZuCN4VQWeTkIKpid3Wnj2bcAYUghHE/kEvMw59kblVM1W2sv6gzz0yKOtnD4c0iMeOrXJgcRFv1nQaIBEPqroYAHoWeZLWmZLw5dMjVDUN72sm0It+grrd1XUZxFr3XQjXoM7X/FcbVdZ5bAdtyaPG6cbA9SMahntJiN8mp7iem4LTh0C3NHeQlZHQNRTvyhMt+QsxaSy5DkWx2jEJ9kwpi/ZSVAV+BdlY76dIk9+tlWWDlMFl7TxR1kMxqIs8mm/cddYYGxroDs0rOk4/WLnwfMaoUbtfuW4hgc8g8XSOJW2obirZkf/N5RsCHA==;5:gHqzhFB1aWL4NGWfCTEVMSXMuzakzJdIqxbo2tUeJT/7/bSIggjfXDe4f2h7EpC7lwKDgnXefM8Zw/uZfYeLTuke4CVcr5GwzarOKg0/owRpcicCwAhNX4auh8HKqsVt1XV7z3fgrGyeY4lPm0pT+gG0tfpi4SjnvmkhGqZpJRI=;24:XOmmXPL31BfgUels5xmnuGKcyjVbl/tQYhSKTzRZAkDccj6f1B0fvm9zupN9SYGGxBPUKMzp/2+Apyk6ebLU4HWV47fZB2wkUjDUqVk089o=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0169;7:IIJ23KeKZFCRyt4Bj1w0H/IrmOK8fbg+6PPNW3PuBqygiGIqevP+JuV8gheZhDeQaZx/2Ka7S2Hqequo6cu8Gsw4okC/9CydwoXY84xx530KSRhSA6jX1ckqfUF6gGOtbgFR7HT0wOf3EKPez1fFSNsjBWqntz/O3nOCOtL6CDnHdH02w5kehIvmF6RcIB2F2JeYwBPM9m9BPw+aYRt21yV1oypClbUeL3zZlkKp6UIQjsDeSl39Do2+xTaScphj;20:sOOUHiMoCyTUbifViLKfDJhxgpJuiywvk/JjBRa9DwFZLtud30ccLUdYw2nwlslhT6vtiB03Q2/LEgmzRo8UW+oudBSX52JyUZF8/P4FL6+t3jT9YqKFcz8vcQRuz5lNgPcimJ91Ja3rrU76JbSZddBncpPAlrzJy+IXaetkPNcfgDr7GdxGrqww4j41eseDDCXiTOTlJZ15fKIUwWKxolOpWCgHKQaQoaEVFakAaOzmA0q9B+J/+DkbrmX4k9cc
X-MS-Office365-Filtering-Correlation-Id: ab80239e-76d0-4902-5fda-08d5cfc9c9c3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2018 18:33:11.2355 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab80239e-76d0-4902-5fda-08d5cfc9c9c3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR12MB0169
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/10/2018 11:25 PM, Don Bollinger wrote:
> optoe is an i2c based driver that supports read/write access to all
> the pages (tables) of MSA standard SFP and similar devices (conforming
> to the SFF-8472 spec) and MSA standard QSFP and similar devices
> (conforming to the SFF-8436 spec).
> 
> These devices provide identification, operational status and control
> registers via an EEPROM model. These devices support one or 3 fixed
> pages (128 bytes) of data, and one page that is selected via a page
> register on the first fixed page.  Thus the driver's main task is
> to map these pages onto a simple linear address space for user space
> management applications.  See the driver code for a detailed layout.
> 
> EEPROM data is accessible via a bin_attribute file called 'eeprom',
> e.g. /sys/bus/i2c/devices/24-0050/eeprom.
> 
> Signed-off-by: Don Bollinger <don@thebollingers.org>
> ---
> 
> Why should this driver be in the Linux kernel?  SFP and QSFP devices plug
> into switches to convert electrical to optical signals and drive the
> optical signal over fiber optic cables.  They provide status and control
> registers through an i2c interface similar to to other EEPROMS.  However,
> they have a paging mechanism that is unique, which requires a different
> driver from (for example) at24.  Various drivers have been developed for
> this purpose, none of them support both SFP and QSFP, provide both read
> and write access, and access all 256 architected pages.  optoe does all
> of these.
> 
> optoe has been adopted and is shipping to customers  as a base module,
> available to all platforms (switches) and used by multiple vendors and
> platforms on both ONL (Open Network Linux) and SONiC (Microsoft's
> 'Software for Open Networking in the Cloud').
> 
> This patch has been built on the latest staging-testing kernel.  It has
> built and tested with SFP and QSFP devices on an ARM platform with a 4.9
> kernel, and an x86 switch with a 3.16 kernel.  This patch should install
> and build clean on any kernel from 3.16 up to the latest (as of 6/10/2018).
> 
> 
>  Documentation/misc-devices/optoe.txt |   56 ++
>  drivers/misc/eeprom/Kconfig          |   18 +
>  drivers/misc/eeprom/Makefile         |    1 +
>  drivers/misc/eeprom/optoe.c          | 1141 ++++++++++++++++++++++++++++++++++
>  4 files changed, 1216 insertions(+)
>  create mode 100644 Documentation/misc-devices/optoe.txt
>  create mode 100644 drivers/misc/eeprom/optoe.c
> 

There's an SFP driver under drivers/net/phy.  Can that driver be extended
to provide this support?  Adding Russel King who developed sfp.c, as well
at the netdev mailing list.

Thanks,
Tom

> diff --git a/Documentation/misc-devices/optoe.txt b/Documentation/misc-devices/optoe.txt
> new file mode 100644
> index 000000000000..496134940147
> --- /dev/null
> +++ b/Documentation/misc-devices/optoe.txt
> @@ -0,0 +1,56 @@
> +optoe driver
> +
> +Author Don Bollinger (don@thebollingers.org)
> +
> +Optoe is an i2c based driver that supports read/write access to all
> +the pages (tables) of MSA standard SFP and similar devices (conforming
> +to the SFF-8472 spec) and MSA standard QSFP and similar devices
> +(conforming to the SFF-8436 spec).
> +
> +i2c based optoelectronic transceivers (SPF, QSFP, etc) provide identification,
> +operational status, and control registers via an EEPROM model.  Unlike the
> +EEPROMs that at24 supports, these devices access data beyond byte 256 via
> +a page select register, which must be managed by the driver.  See the driver
> +code for a detailed explanation of how the linear address space provided
> +by the driver maps to the paged address space provided by the devices.
> +
> +The EEPROM data is accessible via a bin_attribute file called 'eeprom',
> +e.g. /sys/bus/i2c/devices/24-0050/eeprom
> +
> +This driver also reports the port number for each device, via a sysfs
> +attribute: 'port_name'.  This is a read/write attribute.  It should be
> +explicitly set as part of system initialization, ideally at the same time
> +the device is instantiated.  Write an appropriate port name (any string, up
> +to 19 characters) to initialize.  If not initialized explicitly, all ports
> +will have the port_name of 'unitialized'.  Alternatively, if the driver is
> +called with platform_data, the port_name will be read from eeprom_data->label
> +(if the EEPROM CLASS driver is configured) or from platform_data.port_name.
> +
> +This driver can be instantiated with 'new_device', per the convention
> +described in Documentation/i2c/instantiating-devices.  It wants one of
> +two possible device identifiers.  Use 'optoe1' to indicate this is a device
> +with just one i2c address (all QSFP type devices).  Use 'optoe2' to indicate
> +this is a device with two i2c addresses (all SFP type devices).
> +
> +Example:
> +# echo optoe1 0x50 > /sys/bus/i2c/devices/i2c-64/new_device
> +# echo port54 > /sys/bus/i2c/devices/i2c-64/port_name
> +
> +This will add a QSFP type device to i2c bus i2c-64, and name it 'port54'
> +
> +Example:
> +# echo optoe2 0x50 > /sys/bus/i2c/devices/i2c-11/new_device
> +# echo port1 > /sys/bus/i2c/devices/i2c-11/port_name
> +
> +This will add an SFP type device to i2c bus i2c-11, and name it 'port1'
> +
> +The second parameter to new_device is an i2c address, and MUST be 0x50 for
> +this driver to work properly.  This is part of the spec for these devices.
> +(It is not necessary to create a device at 0x51 for SFP type devices, the
> +driver does that automatically.)
> +
> +Note that SFP type and QSFP type devices are not plug-compatible.  The
> +driver expects the correct ID for each port (each i2c device).  It does
> +not check because the port will often be empty, and the only way to check
> +is to interrogate the device.  Incorrect choice of ID will lead to correct
> +data being reported for the first 256 bytes, incorrect data after that.
> diff --git a/drivers/misc/eeprom/Kconfig b/drivers/misc/eeprom/Kconfig
> index 68a1ac929917..9a08e12756ee 100644
> --- a/drivers/misc/eeprom/Kconfig
> +++ b/drivers/misc/eeprom/Kconfig
> @@ -111,4 +111,22 @@ config EEPROM_IDT_89HPESX
>  	  This driver can also be built as a module. If so, the module
>  	  will be called idt_89hpesx.
>  
> +config EEPROM_OPTOE
> +	tristate "read/write access to SFP* & QSFP* EEPROMs"
> +	depends on I2C && SYSFS
> +	help
> +	  If you say yes here you get support for read and write access to
> +	  the EEPROM of SFP and QSFP type optical and copper transceivers.
> +	  Includes all devices which conform to the sff-8436 and sff-8472
> +	  spec including SFP, SFP+, SFP28, SFP-DWDM, QSFP, QSFP+, QSFP28
> +	  or later.  These devices are usually found in network switches.
> +
> +	  This driver only manages read/write access to the EEPROM, all
> +	  other features should be accessed via i2c-dev.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called optoe.
> +
> +	  If unsure, say N.
> +
>  endmenu
> diff --git a/drivers/misc/eeprom/Makefile b/drivers/misc/eeprom/Makefile
> index 2aab60ef3e3e..00288d669017 100644
> --- a/drivers/misc/eeprom/Makefile
> +++ b/drivers/misc/eeprom/Makefile
> @@ -7,3 +7,4 @@ obj-$(CONFIG_EEPROM_93CX6)	+= eeprom_93cx6.o
>  obj-$(CONFIG_EEPROM_93XX46)	+= eeprom_93xx46.o
>  obj-$(CONFIG_EEPROM_DIGSY_MTC_CFG) += digsy_mtc_eeprom.o
>  obj-$(CONFIG_EEPROM_IDT_89HPESX) += idt_89hpesx.o
> +obj-$(CONFIG_EEPROM_OPTOE)      += optoe.o
> diff --git a/drivers/misc/eeprom/optoe.c b/drivers/misc/eeprom/optoe.c
> new file mode 100644
> index 000000000000..7cdf1a0a5299
> --- /dev/null
> +++ b/drivers/misc/eeprom/optoe.c
> @@ -0,0 +1,1141 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * optoe.c - A driver to read and write the EEPROM on optical transceivers
> + * (SFP, QSFP and similar I2C based devices)
> + *
> + * Copyright (C) 2014 Cumulus networks Inc.
> + * Copyright (C) 2017 Finisar Corp.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Freeoftware Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +/*
> + *	Description:
> + *	a) Optical transceiver EEPROM read/write transactions are just like
> + *		the at24 eeproms managed by the at24.c i2c driver
> + *	b) The register/memory layout is up to 256 128 byte pages defined by
> + *		a "pages valid" register and switched via a "page select"
> + *		register as explained in below diagram.
> + *	c) 256 bytes are mapped at a time. 'Lower page 00h' is the first 128
> + *	        bytes of address space, and always references the same
> + *	        location, independent of the page select register.
> + *	        All mapped pages are mapped into the upper 128 bytes
> + *	        (offset 128-255) of the i2c address.
> + *	d) Devices with one I2C address (eg QSFP) use I2C address 0x50
> + *		(A0h in the spec), and map all pages in the upper 128 bytes
> + *		of that address.
> + *	e) Devices with two I2C addresses (eg SFP) have 256 bytes of data
> + *		at I2C address 0x50, and 256 bytes of data at I2C address
> + *		0x51 (A2h in the spec).  Page selection and paged access
> + *		only apply to this second I2C address (0x51).
> + *	e) The address space is presented, by the driver, as a linear
> + *	        address space.  For devices with one I2C client at address
> + *	        0x50 (eg QSFP), offset 0-127 are in the lower
> + *	        half of address 50/A0h/client[0].  Offset 128-255 are in
> + *	        page 0, 256-383 are page 1, etc.  More generally, offset
> + *	        'n' resides in page (n/128)-1.  ('page -1' is the lower
> + *	        half, offset 0-127).
> + *	f) For devices with two I2C clients at address 0x50 and 0x51 (eg SFP),
> + *		the address space places offset 0-127 in the lower
> + *	        half of 50/A0/client[0], offset 128-255 in the upper
> + *	        half.  Offset 256-383 is in the lower half of 51/A2/client[1].
> + *	        Offset 384-511 is in page 0, in the upper half of 51/A2/...
> + *	        Offset 512-639 is in page 1, in the upper half of 51/A2/...
> + *	        Offset 'n' is in page (n/128)-3 (for n > 383)
> + *
> + *	                    One I2c addressed (eg QSFP) Memory Map
> + *
> + *	                    2-Wire Serial Address: 1010000x
> + *
> + *	                    Lower Page 00h (128 bytes)
> + *	                    =====================
> + *	                   |                     |
> + *	                   |                     |
> + *	                   |                     |
> + *	                   |                     |
> + *	                   |                     |
> + *	                   |                     |
> + *	                   |                     |
> + *	                   |                     |
> + *	                   |                     |
> + *	                   |                     |
> + *	                   |Page Select Byte(127)|
> + *	                    =====================
> + *	                              |
> + *	                              |
> + *	                              |
> + *	                              |
> + *	                              V
> + *	     ------------------------------------------------------------
> + *	    |                 |                  |                       |
> + *	    |                 |                  |                       |
> + *	    |                 |                  |                       |
> + *	    |                 |                  |                       |
> + *	    |                 |                  |                       |
> + *	    |                 |                  |                       |
> + *	    |                 |                  |                       |
> + *	    |                 |                  |                       |
> + *	    |                 |                  |                       |
> + *	    V                 V                  V                       V
> + *	 ------------   --------------      ---------------     --------------
> + *	|            | |              |    |               |   |              |
> + *	|   Upper    | |     Upper    |    |     Upper     |   |    Upper     |
> + *	|  Page 00h  | |    Page 01h  |    |    Page 02h   |   |   Page 03h   |
> + *	|            | |   (Optional) |    |   (Optional)  |   |  (Optional   |
> + *	|            | |              |    |               |   |   for Cable  |
> + *	|            | |              |    |               |   |  Assemblies) |
> + *	|    ID      | |     AST      |    |      User     |   |              |
> + *	|  Fields    | |    Table     |    |   EEPROM Data |   |              |
> + *	|            | |              |    |               |   |              |
> + *	|            | |              |    |               |   |              |
> + *	|            | |              |    |               |   |              |
> + *	 ------------   --------------      ---------------     --------------
> + *
> + * The SFF 8436 (QSFP) spec only defines the 4 pages described above.
> + * In anticipation of future applications and devices, this driver
> + * supports access to the full architected range, 256 pages.
> + *
> + **/
> +
> +/* #define DEBUG 1 */
> +
> +#undef EEPROM_CLASS
> +#ifdef CONFIG_EEPROM_CLASS
> +#define EEPROM_CLASS
> +#endif
> +#ifdef CONFIG_EEPROM_CLASS_MODULE
> +#define EEPROM_CLASS
> +#endif
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/delay.h>
> +#include <linux/mutex.h>
> +#include <linux/sysfs.h>
> +#include <linux/jiffies.h>
> +#include <linux/i2c.h>
> +
> +#ifdef EEPROM_CLASS
> +#include <linux/eeprom_class.h>
> +#endif
> +
> +#include <linux/types.h>
> +
> +/* The maximum length of a port name */
> +#define MAX_PORT_NAME_LEN 20
> +
> +struct optoe_platform_data {
> +	u32		byte_len;		/* size (sum of all addr) */
> +	u16		page_size;		/* for writes */
> +	u8		flags;
> +	void		*dummy1;		/* backward compatibility */
> +	void		*dummy2;		/* backward compatibility */
> +
> +#ifdef EEPROM_CLASS
> +	struct eeprom_platform_data *eeprom_data;
> +#endif
> +	char port_name[MAX_PORT_NAME_LEN];
> +};
> +
> +/* fundamental unit of addressing for EEPROM */
> +#define OPTOE_PAGE_SIZE 128
> +/*
> + * Single address devices (eg QSFP) have 256 pages, plus the unpaged
> + * low 128 bytes.  If the device does not support paging, it is
> + * only 2 'pages' long.
> + */
> +#define OPTOE_ARCH_PAGES 256
> +#define ONE_ADDR_EEPROM_SIZE ((1 + OPTOE_ARCH_PAGES) * OPTOE_PAGE_SIZE)
> +#define ONE_ADDR_EEPROM_UNPAGED_SIZE (2 * OPTOE_PAGE_SIZE)
> +/*
> + * Dual address devices (eg SFP) have 256 pages, plus the unpaged
> + * low 128 bytes, plus 256 bytes at 0x50.  If the device does not
> + * support paging, it is 4 'pages' long.
> + */
> +#define TWO_ADDR_EEPROM_SIZE ((3 + OPTOE_ARCH_PAGES) * OPTOE_PAGE_SIZE)
> +#define TWO_ADDR_EEPROM_UNPAGED_SIZE (4 * OPTOE_PAGE_SIZE)
> +#define TWO_ADDR_NO_0X51_SIZE (2 * OPTOE_PAGE_SIZE)
> +
> +/* a few constants to find our way around the EEPROM */
> +#define OPTOE_PAGE_SELECT_REG   0x7F
> +#define ONE_ADDR_PAGEABLE_REG 0x02
> +#define ONE_ADDR_NOT_PAGEABLE BIT(2)
> +#define TWO_ADDR_PAGEABLE_REG 0x40
> +#define TWO_ADDR_PAGEABLE BIT(4)
> +#define TWO_ADDR_0X51_REG 92
> +#define TWO_ADDR_0X51_SUPP BIT(6)
> +#define OPTOE_ID_REG 0
> +#define OPTOE_READ_OP 0
> +#define OPTOE_WRITE_OP 1
> +#define OPTOE_EOF 0  /* used for access beyond end of device */
> +
> +struct optoe_data {
> +	struct optoe_platform_data chip;
> +	int use_smbus;
> +	char port_name[MAX_PORT_NAME_LEN];
> +
> +	/*
> +	 * Lock protects against activities from other Linux tasks,
> +	 * but not from changes by other I2C masters.
> +	 */
> +	struct mutex lock;
> +	struct bin_attribute bin;
> +	struct attribute_group attr_group;
> +
> +	u8 *writebuf;
> +	unsigned int write_max;
> +
> +	unsigned int num_addresses;
> +
> +#ifdef EEPROM_CLASS
> +	struct eeprom_device *eeprom_dev;
> +#endif
> +
> +	/* dev_class: ONE_ADDR (QSFP) or TWO_ADDR (SFP) */
> +	int dev_class;
> +
> +	struct i2c_client *client[2];
> +};
> +
> +/*
> + * This parameter is to help this driver avoid blocking other drivers out
> + * of I2C for potentially troublesome amounts of time. With a 100 kHz I2C
> + * clock, one 256 byte read takes about 1/43 second which is excessive;
> + * but the 1/170 second it takes at 400 kHz may be quite reasonable; and
> + * at 1 MHz (Fm+) a 1/430 second delay could easily be invisible.
> + *
> + * This value is forced to be a power of two so that writes align on pages.
> + */
> +static unsigned int io_limit = OPTOE_PAGE_SIZE;
> +
> +/*
> + * specs often allow 5 msec for a page write, sometimes 20 msec;
> + * it's important to recover from write timeouts.
> + */
> +static unsigned int write_timeout = 25;
> +
> +/*
> + * flags to distinguish one-address (QSFP family) from two-address (SFP family)
> + * If the family is not known, figure it out when the device is accessed
> + */
> +#define ONE_ADDR 1
> +#define TWO_ADDR 2
> +
> +static const struct i2c_device_id optoe_ids[] = {
> +	{ "optoe1", ONE_ADDR },
> +	{ "optoe2", TWO_ADDR },
> +	{ "sff8436", ONE_ADDR },
> +	{ "24c04", TWO_ADDR },
> +	{ /* END OF LIST */ }
> +};
> +MODULE_DEVICE_TABLE(i2c, optoe_ids);
> +
> +/*-------------------------------------------------------------------------*/
> +/*
> + * This routine computes the addressing information to be used for
> + * a given r/w request.
> + *
> + * Task is to calculate the client (0 = i2c addr 50, 1 = i2c addr 51),
> + * the page, and the offset.
> + *
> + * Handles both single address (eg QSFP) and two address (eg SFP).
> + *     For SFP, offset 0-255 are on client[0], >255 is on client[1]
> + *     Offset 256-383 are on the lower half of client[1]
> + *     Pages are accessible on the upper half of client[1].
> + *     Offset >383 are in 128 byte pages mapped into the upper half
> + *
> + *     For QSFP, all offsets are on client[0]
> + *     offset 0-127 are on the lower half of client[0] (no paging)
> + *     Pages are accessible on the upper half of client[1].
> + *     Offset >127 are in 128 byte pages mapped into the upper half
> + *
> + *     Callers must not read/write beyond the end of a client or a page
> + *     without recomputing the client/page.  Hence offset (within page)
> + *     plus length must be less than or equal to 128.  (Note that this
> + *     routine does not have access to the length of the call, hence
> + *     cannot do the validity check.)
> + *
> + * Offset within Lower Page 00h and Upper Page 00h are not recomputed
> + */
> +
> +static uint8_t optoe_translate_offset(struct optoe_data *optoe,
> +				      loff_t *offset,
> +				      struct i2c_client **client)
> +{
> +	unsigned int page = 0;
> +
> +	*client = optoe->client[0];
> +
> +	/* if SFP style, offset > 255, shift to i2c addr 0x51 */
> +	if (optoe->dev_class == TWO_ADDR) {
> +		if (*offset > 255) {
> +			/* like QSFP, but shifted to client[1] */
> +			*client = optoe->client[1];
> +			*offset -= 256;
> +		}
> +	}
> +
> +	/*
> +	 * if offset is in the range 0-128...
> +	 * page doesn't matter (using lower half), return 0.
> +	 * offset is already correct (don't add 128 to get to paged area)
> +	 */
> +	if (*offset < OPTOE_PAGE_SIZE)
> +		return page;
> +
> +	/* note, page will always be positive since *offset >= 128 */
> +	page = (*offset >> 7) - 1;
> +	/* 0x80 places the offset in the top half, offset is last 7 bits */
> +	*offset = OPTOE_PAGE_SIZE + (*offset & 0x7f);
> +
> +	return page;  /* note also returning client and offset */
> +}
> +
> +static ssize_t optoe_eeprom_read(struct optoe_data *optoe,
> +				 struct i2c_client *client,
> +				 char *buf, unsigned int offset, size_t count)
> +{
> +	struct i2c_msg msg[2];
> +	u8 msgbuf[2];
> +	unsigned long timeout, read_time;
> +	int status, i;
> +
> +	memset(msg, 0, sizeof(msg));
> +
> +	switch (optoe->use_smbus) {
> +	case I2C_SMBUS_I2C_BLOCK_DATA:
> +		/*smaller eeproms can work given some SMBus extension calls */
> +		if (count > I2C_SMBUS_BLOCK_MAX)
> +			count = I2C_SMBUS_BLOCK_MAX;
> +		break;
> +	case I2C_SMBUS_WORD_DATA:
> +		/* Check for odd length transaction */
> +		count = (count == 1) ? 1 : 2;
> +		break;
> +	case I2C_SMBUS_BYTE_DATA:
> +		count = 1;
> +		break;
> +	default:
> +		/*
> +		 * When we have a better choice than SMBus calls, use a
> +		 * combined I2C message. Write address; then read up to
> +		 * io_limit data bytes.  msgbuf is u8 and will cast to our
> +		 * needs.
> +		 */
> +		i = 0;
> +		msgbuf[i++] = offset;
> +
> +		msg[0].addr = client->addr;
> +		msg[0].buf = msgbuf;
> +		msg[0].len = i;
> +
> +		msg[1].addr = client->addr;
> +		msg[1].flags = I2C_M_RD;
> +		msg[1].buf = buf;
> +		msg[1].len = count;
> +	}
> +
> +	/*
> +	 * Reads fail if the previous write didn't complete yet. We may
> +	 * loop a few times until this one succeeds, waiting at least
> +	 * long enough for one entire page write to work.
> +	 */
> +	timeout = jiffies + msecs_to_jiffies(write_timeout);
> +	do {
> +		read_time = jiffies;
> +
> +		switch (optoe->use_smbus) {
> +		case I2C_SMBUS_I2C_BLOCK_DATA:
> +			status = i2c_smbus_read_i2c_block_data(client, offset,
> +							       count, buf);
> +			break;
> +		case I2C_SMBUS_WORD_DATA:
> +			status = i2c_smbus_read_word_data(client, offset);
> +			if (status >= 0) {
> +				buf[0] = status & 0xff;
> +				if (count == 2)
> +					buf[1] = status >> 8;
> +				status = count;
> +			}
> +			break;
> +		case I2C_SMBUS_BYTE_DATA:
> +			status = i2c_smbus_read_byte_data(client, offset);
> +			if (status >= 0) {
> +				buf[0] = status;
> +				status = count;
> +			}
> +			break;
> +		default:
> +			status = i2c_transfer(client->adapter, msg, 2);
> +			if (status == 2)
> +				status = count;
> +		}
> +
> +		dev_dbg(&client->dev, "eeprom read %zu@%d --> %d (%ld)\n",
> +			count, offset, status, jiffies);
> +
> +		if (status == count)  /* happy path */
> +			return count;
> +
> +		if (status == -ENXIO) /* no module present */
> +			return status;
> +
> +		/* REVISIT: at HZ=100, this is sloooow */
> +		usleep_range(1000, 2000);
> +	} while (time_before(read_time, timeout));
> +
> +	return -ETIMEDOUT;
> +}
> +
> +static ssize_t optoe_eeprom_write(struct optoe_data *optoe,
> +				  struct i2c_client *client,
> +				  const char *buf,
> +				  unsigned int offset, size_t count)
> +{
> +	struct i2c_msg msg;
> +	ssize_t status;
> +	unsigned long timeout, write_time;
> +	unsigned int next_page_start;
> +	int i = 0;
> +	u16 writeword;
> +
> +	/* write max is at most a page
> +	 * (In this driver, write_max is actually one byte!)
> +	 */
> +	if (count > optoe->write_max)
> +		count = optoe->write_max;
> +
> +	/* shorten count if necessary to avoid crossing page boundary */
> +	next_page_start = roundup(offset + 1, OPTOE_PAGE_SIZE);
> +	if (offset + count > next_page_start)
> +		count = next_page_start - offset;
> +
> +	switch (optoe->use_smbus) {
> +	case I2C_SMBUS_I2C_BLOCK_DATA:
> +		/*smaller eeproms can work given some SMBus extension calls */
> +		if (count > I2C_SMBUS_BLOCK_MAX)
> +			count = I2C_SMBUS_BLOCK_MAX;
> +		break;
> +	case I2C_SMBUS_WORD_DATA:
> +		/* Check for odd length transaction */
> +		count = (count == 1) ? 1 : 2;
> +		break;
> +	case I2C_SMBUS_BYTE_DATA:
> +		count = 1;
> +		break;
> +	default:
> +		/* If we'll use I2C calls for I/O, set up the message */
> +		msg.addr = client->addr;
> +		msg.flags = 0;
> +
> +		/* msg.buf is u8 and casts will mask the values */
> +		msg.buf = optoe->writebuf;
> +
> +		msg.buf[i++] = offset;
> +		memcpy(&msg.buf[i], buf, count);
> +		msg.len = i + count;
> +		break;
> +	}
> +
> +	/*
> +	 * Reads fail if the previous write didn't complete yet. We may
> +	 * loop a few times until this one succeeds, waiting at least
> +	 * long enough for one entire page write to work.
> +	 */
> +	timeout = jiffies + msecs_to_jiffies(write_timeout);
> +	do {
> +		write_time = jiffies;
> +
> +		switch (optoe->use_smbus) {
> +		case I2C_SMBUS_I2C_BLOCK_DATA:
> +			status = i2c_smbus_write_i2c_block_data(client,
> +								offset,
> +								count,
> +								buf);
> +			if (status == 0)
> +				status = count;
> +			break;
> +		case I2C_SMBUS_WORD_DATA:
> +			if (count == 2) {
> +				writeword = (buf[1] << 8) | buf[0];
> +				status = i2c_smbus_write_word_data(client,
> +								   offset,
> +								   writeword);
> +			} else {
> +				/* count = 1 */
> +				status = i2c_smbus_write_byte_data(client,
> +								   offset,
> +								   buf[0]);
> +			}
> +			if (status == 0)
> +				status = count;
> +			break;
> +		case I2C_SMBUS_BYTE_DATA:
> +			status = i2c_smbus_write_byte_data(client, offset,
> +							   buf[0]);
> +			if (status == 0)
> +				status = count;
> +			break;
> +		default:
> +			status = i2c_transfer(client->adapter, &msg, 1);
> +			if (status == 1)
> +				status = count;
> +			break;
> +		}
> +
> +		dev_dbg(&client->dev, "eeprom write %zu@%d --> %ld (%lu)\n",
> +			count, offset, (long int)status, jiffies);
> +
> +		if (status == count)
> +			return count;
> +
> +		/* REVISIT: at HZ=100, this is sloooow */
> +		usleep_range(1000, 2000);
> +	} while (time_before(write_time, timeout));
> +
> +	return -ETIMEDOUT;
> +}
> +
> +static ssize_t optoe_eeprom_update_client(struct optoe_data *optoe,
> +					  char *buf, loff_t off,
> +					  size_t count, int opcode)
> +{
> +	struct i2c_client *client;
> +	ssize_t retval = 0;
> +	u8 page = 0;
> +	loff_t phy_offset = off;
> +	int ret = 0;
> +
> +	page = optoe_translate_offset(optoe, &phy_offset, &client);
> +	dev_dbg(&client->dev,
> +		"%s off %lld  page:%d phy_offset:%lld, count:%ld, opcode:%d\n",
> +		__func__, off, page, phy_offset, (long int)count, opcode);
> +	if (page > 0) {
> +		ret = optoe_eeprom_write(optoe, client, &page,
> +					 OPTOE_PAGE_SELECT_REG, 1);
> +		if (ret < 0) {
> +			dev_dbg(&client->dev,
> +				"Write page register for page %d failed ret:%d!\n",
> +					page, ret);
> +			return ret;
> +		}
> +	}
> +
> +	while (count) {
> +		ssize_t	status;
> +
> +		if (opcode == OPTOE_READ_OP) {
> +			status =  optoe_eeprom_read(optoe, client, buf,
> +						    phy_offset, count);
> +		} else {
> +			status =  optoe_eeprom_write(optoe, client, buf,
> +						     phy_offset, count);
> +		}
> +		if (status <= 0) {
> +			if (retval == 0)
> +				retval = status;
> +			break;
> +		}
> +		buf += status;
> +		phy_offset += status;
> +		count -= status;
> +		retval += status;
> +	}
> +
> +	if (page > 0) {
> +		/* return the page register to page 0 (why?) */
> +		page = 0;
> +		ret = optoe_eeprom_write(optoe, client, &page,
> +					 OPTOE_PAGE_SELECT_REG, 1);
> +		if (ret < 0) {
> +			dev_err(&client->dev,
> +				"Restore page register to 0 failed:%d!\n", ret);
> +			/* error only if nothing has been transferred */
> +			if (retval == 0)
> +				retval = ret;
> +		}
> +	}
> +	return retval;
> +}
> +
> +/*
> + * Figure out if this access is within the range of supported pages.
> + * Note this is called on every access because we don't know if the
> + * module has been replaced since the last call.
> + * If/when modules support more pages, this is the routine to update
> + * to validate and allow access to additional pages.
> + *
> + * Returns updated len for this access:
> + *     - entire access is legal, original len is returned.
> + *     - access begins legal but is too long, len is truncated to fit.
> + *     - initial offset exceeds supported pages, return OPTOE_EOF (zero)
> + */
> +static ssize_t optoe_page_legal(struct optoe_data *optoe,
> +				loff_t off, size_t len)
> +{
> +	struct i2c_client *client = optoe->client[0];
> +	u8 regval;
> +	int status;
> +	size_t maxlen;
> +
> +	if (off < 0)
> +		return -EINVAL;
> +	if (optoe->dev_class == TWO_ADDR) {
> +		/* SFP case */
> +		/* if only using addr 0x50 (first 256 bytes) we're good */
> +		if ((off + len) <= TWO_ADDR_NO_0X51_SIZE)
> +			return len;
> +		/* if offset exceeds possible pages, we're not good */
> +		if (off >= TWO_ADDR_EEPROM_SIZE)
> +			return OPTOE_EOF;
> +		/* in between, are pages supported? */
> +		status = optoe_eeprom_read(optoe, client, &regval,
> +					   TWO_ADDR_PAGEABLE_REG, 1);
> +		if (status < 0)
> +			return status;  /* error out (no module?) */
> +		if (regval & TWO_ADDR_PAGEABLE) {
> +			/* Pages supported, trim len to the end of pages */
> +			maxlen = TWO_ADDR_EEPROM_SIZE - off;
> +		} else {
> +			/* pages not supported, trim len to unpaged size */
> +			if (off >= TWO_ADDR_EEPROM_UNPAGED_SIZE)
> +				return OPTOE_EOF;
> +
> +			/* will be accessing addr 0x51, is that supported? */
> +			/* byte 92, bit 6 implies DDM support, 0x51 support */
> +			status = optoe_eeprom_read(optoe, client, &regval,
> +						   TWO_ADDR_0X51_REG, 1);
> +			if (status < 0)
> +				return status;
> +			if (regval & TWO_ADDR_0X51_SUPP) {
> +				/* addr 0x51 is OK */
> +				maxlen = TWO_ADDR_EEPROM_UNPAGED_SIZE - off;
> +			} else {
> +				/* addr 0x51 NOT supported, trim to 256 max */
> +				if (off >= TWO_ADDR_NO_0X51_SIZE)
> +					return OPTOE_EOF;
> +				maxlen = TWO_ADDR_NO_0X51_SIZE - off;
> +			}
> +		}
> +		len = (len > maxlen) ? maxlen : len;
> +		dev_dbg(&client->dev,
> +			"page_legal, SFP, off %lld len %ld\n",
> +			off, (long int)len);
> +	} else {
> +		/* QSFP case */
> +		/* if no pages needed, we're good */
> +		if ((off + len) <= ONE_ADDR_EEPROM_UNPAGED_SIZE)
> +			return len;
> +		/* if offset exceeds possible pages, we're not good */
> +		if (off >= ONE_ADDR_EEPROM_SIZE)
> +			return OPTOE_EOF;
> +		/* in between, are pages supported? */
> +		status = optoe_eeprom_read(optoe, client, &regval,
> +					   ONE_ADDR_PAGEABLE_REG, 1);
> +		if (status < 0)
> +			return status;  /* error out (no module?) */
> +		if (regval & ONE_ADDR_NOT_PAGEABLE) {
> +			/* pages not supported, trim len to unpaged size */
> +			if (off >= ONE_ADDR_EEPROM_UNPAGED_SIZE)
> +				return OPTOE_EOF;
> +			maxlen = ONE_ADDR_EEPROM_UNPAGED_SIZE - off;
> +		} else {
> +			/* Pages supported, trim len to the end of pages */
> +			maxlen = ONE_ADDR_EEPROM_SIZE - off;
> +		}
> +		len = (len > maxlen) ? maxlen : len;
> +		dev_dbg(&client->dev,
> +			"page_legal, QSFP, off %lld len %ld\n",
> +			off, (long int)len);
> +	}
> +	return len;
> +}
> +
> +static ssize_t optoe_read_write(struct optoe_data *optoe,
> +				char *buf, loff_t off,
> +				size_t len, int opcode)
> +{
> +	struct i2c_client *client = optoe->client[0];
> +	int chunk;
> +	int status = 0;
> +	ssize_t retval;
> +	size_t pending_len = 0, chunk_len = 0;
> +	loff_t chunk_offset = 0, chunk_start_offset = 0;
> +
> +	dev_dbg(&client->dev,
> +		"%s: off %lld  len:%ld, opcode:%s\n",
> +		__func__, off, (long int)len,
> +		(opcode == OPTOE_READ_OP) ? "r" : "w");
> +	if (unlikely(!len))
> +		return len;
> +
> +	/*
> +	 * Read data from chip, protecting against concurrent updates
> +	 * from this host, but not from other I2C masters.
> +	 */
> +	mutex_lock(&optoe->lock);
> +
> +	/*
> +	 * Confirm this access fits within the device supported addr range
> +	 */
> +	status = optoe_page_legal(optoe, off, len);
> +	if (status == OPTOE_EOF || status < 0) {
> +		mutex_unlock(&optoe->lock);
> +		return status;
> +	}
> +	len = status;
> +
> +	/*
> +	 * For each (128 byte) chunk involved in this request, issue a
> +	 * separate call to sff_eeprom_update_client(), to
> +	 * ensure that each access recalculates the client/page
> +	 * and writes the page register as needed.
> +	 * Note that chunk to page mapping is confusing, is different for
> +	 * QSFP and SFP, and never needs to be done.  Don't try!
> +	 */
> +	pending_len = len; /* amount remaining to transfer */
> +	retval = 0;  /* amount transferred */
> +	for (chunk = off >> 7; chunk <= (off + len - 1) >> 7; chunk++) {
> +		/*
> +		 * Compute the offset and number of bytes to be read/write
> +		 *
> +		 * 1. start at offset 0 (within the chunk), and read/write
> +		 *    the entire chunk
> +		 * 2. start at offset 0 (within the chunk) and read/write less
> +		 *    than entire chunk
> +		 * 3. start at an offset not equal to 0 and read/write the rest
> +		 *    of the chunk
> +		 * 4. start at an offset not equal to 0 and read/write less than
> +		 *    (end of chunk - offset)
> +		 */
> +		chunk_start_offset = chunk * OPTOE_PAGE_SIZE;
> +
> +		if (chunk_start_offset < off) {
> +			chunk_offset = off;
> +			if ((off + pending_len) < (chunk_start_offset +
> +					OPTOE_PAGE_SIZE))
> +				chunk_len = pending_len;
> +			else
> +				chunk_len = OPTOE_PAGE_SIZE - off;
> +		} else {
> +			chunk_offset = chunk_start_offset;
> +			if (pending_len > OPTOE_PAGE_SIZE)
> +				chunk_len = OPTOE_PAGE_SIZE;
> +			else
> +				chunk_len = pending_len;
> +		}
> +
> +		dev_dbg(&client->dev,
> +			"sff_r/w: off %lld, len %ld, chunk_start_offset %lld, chunk_offset %lld, chunk_len %ld, pending_len %ld\n",
> +			off, (long int)len, chunk_start_offset, chunk_offset,
> +			(long int)chunk_len, (long int)pending_len);
> +
> +		/*
> +		 * note: chunk_offset is from the start of the EEPROM,
> +		 * not the start of the chunk
> +		 */
> +		status = optoe_eeprom_update_client(optoe, buf, chunk_offset,
> +						    chunk_len, opcode);
> +		if (status != chunk_len) {
> +			/* This is another 'no device present' path */
> +			dev_dbg(&client->dev,
> +			"o_u_c: chunk %d c_offset %lld c_len %ld failed %d!\n",
> +			chunk, chunk_offset, (long int)chunk_len, status);
> +			if (status > 0)
> +				retval += status;
> +			if (retval == 0)
> +				retval = status;
> +			break;
> +		}
> +		buf += status;
> +		pending_len -= status;
> +		retval += status;
> +	}
> +	mutex_unlock(&optoe->lock);
> +
> +	return retval;
> +}
> +
> +static ssize_t optoe_bin_read(struct file *filp, struct kobject *kobj,
> +			      struct bin_attribute *attr,
> +			      char *buf, loff_t off, size_t count)
> +{
> +	struct i2c_client *client = to_i2c_client(container_of(kobj,
> +				struct device, kobj));
> +	struct optoe_data *optoe = i2c_get_clientdata(client);
> +
> +	return optoe_read_write(optoe, buf, off, count, OPTOE_READ_OP);
> +}
> +
> +static ssize_t optoe_bin_write(struct file *filp, struct kobject *kobj,
> +			       struct bin_attribute *attr,
> +			       char *buf, loff_t off, size_t count)
> +{
> +	struct i2c_client *client = to_i2c_client(container_of(kobj,
> +				struct device, kobj));
> +	struct optoe_data *optoe = i2c_get_clientdata(client);
> +
> +	return optoe_read_write(optoe, buf, off, count, OPTOE_WRITE_OP);
> +}
> +
> +static int optoe_remove(struct i2c_client *client)
> +{
> +	struct optoe_data *optoe;
> +
> +	optoe = i2c_get_clientdata(client);
> +	sysfs_remove_group(&client->dev.kobj, &optoe->attr_group);
> +	sysfs_remove_bin_file(&client->dev.kobj, &optoe->bin);
> +
> +	if (optoe->num_addresses == 2)
> +		i2c_unregister_device(optoe->client[1]);
> +
> +#ifdef EEPROM_CLASS
> +	eeprom_device_unregister(optoe->eeprom_dev);
> +#endif
> +
> +	kfree(optoe->writebuf);
> +	kfree(optoe);
> +	return 0;
> +}
> +
> +static ssize_t dev_class_show(struct device *dev,
> +			      struct device_attribute *dattr, char *buf)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct optoe_data *optoe = i2c_get_clientdata(client);
> +	ssize_t count;
> +
> +	mutex_lock(&optoe->lock);
> +	count = sprintf(buf, "%d\n", optoe->dev_class);
> +	mutex_unlock(&optoe->lock);
> +
> +	return count;
> +}
> +
> +static ssize_t dev_class_store(struct device *dev,
> +			       struct device_attribute *attr,
> +			       const char *buf, size_t count)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct optoe_data *optoe = i2c_get_clientdata(client);
> +	int dev_class;
> +
> +	/*
> +	 * dev_class is actually the number of i2c addresses used, thus
> +	 * legal values are "1" (QSFP class) and "2" (SFP class)
> +	 */
> +
> +	if (kstrtoint(buf, 0, &dev_class) != 0 ||
> +	    dev_class < 1 || dev_class > 2)
> +		return -EINVAL;
> +
> +	mutex_lock(&optoe->lock);
> +	optoe->dev_class = dev_class;
> +	mutex_unlock(&optoe->lock);
> +
> +	return count;
> +}
> +
> +/*
> + * if using the EEPROM CLASS driver, we don't report a port_name,
> + * the EEPROM CLASS drive handles that.  Hence all this code is
> + * only compiled if we are NOT using the EEPROM CLASS driver.
> + */
> +#ifndef EEPROM_CLASS
> +
> +static ssize_t port_name_show(struct device *dev,
> +			      struct device_attribute *dattr, char *buf)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct optoe_data *optoe = i2c_get_clientdata(client);
> +	ssize_t count;
> +
> +	mutex_lock(&optoe->lock);
> +	count = sprintf(buf, "%s\n", optoe->port_name);
> +	mutex_unlock(&optoe->lock);
> +
> +	return count;
> +}
> +
> +static ssize_t port_name_store(struct device *dev,
> +			       struct device_attribute *attr,
> +			       const char *buf, size_t count)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct optoe_data *optoe = i2c_get_clientdata(client);
> +	char port_name[MAX_PORT_NAME_LEN];
> +
> +	/* no checking, this value is not used except by port_name_show */
> +
> +	if (sscanf(buf, "%19s", port_name) != 1)
> +		return -EINVAL;
> +
> +	mutex_lock(&optoe->lock);
> +	strcpy(optoe->port_name, port_name);
> +	mutex_unlock(&optoe->lock);
> +
> +	return count;
> +}
> +
> +static DEVICE_ATTR_RW(port_name);
> +#endif  /* if NOT defined EEPROM_CLASS, the common case */
> +
> +static DEVICE_ATTR_RW(dev_class);
> +
> +static struct attribute *optoe_attrs[] = {
> +#ifndef EEPROM_CLASS
> +	&dev_attr_port_name.attr,
> +#endif
> +	&dev_attr_dev_class.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group optoe_attr_group = {
> +	.attrs = optoe_attrs,
> +};
> +
> +static int optoe_probe(struct i2c_client *client,
> +		       const struct i2c_device_id *id)
> +{
> +	int err;
> +	int use_smbus = 0;
> +	struct optoe_platform_data chip;
> +	struct optoe_data *optoe;
> +	int num_addresses;
> +	char port_name[MAX_PORT_NAME_LEN];
> +
> +	if (client->addr != 0x50) {
> +		dev_dbg(&client->dev, "probe, bad i2c addr: 0x%x\n",
> +			client->addr);
> +		err = -EINVAL;
> +		goto exit;
> +	}
> +
> +	if (client->dev.platform_data) {
> +		chip = *(struct optoe_platform_data *)client->dev.platform_data;
> +		/* take the port name from the supplied platform data */
> +#ifdef EEPROM_CLASS
> +		strncpy(port_name, chip.eeprom_data->label, MAX_PORT_NAME_LEN);
> +#else
> +		memcpy(port_name, chip.port_name, MAX_PORT_NAME_LEN);
> +#endif
> +		dev_dbg(&client->dev,
> +			"probe, chip provided, flags:0x%x; name: %s\n",
> +			chip.flags, client->name);
> +	} else {
> +		if (!id->driver_data) {
> +			err = -ENODEV;
> +			goto exit;
> +		}
> +		dev_dbg(&client->dev, "probe, building chip\n");
> +		strcpy(port_name, "unitialized");
> +		chip.flags = 0;
> +#ifdef EEPROM_CLASS
> +		chip.eeprom_data = NULL;
> +#endif
> +	}
> +
> +	/* Use I2C operations unless we're stuck with SMBus extensions. */
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
> +		if (i2c_check_functionality(client->adapter,
> +				I2C_FUNC_SMBUS_READ_I2C_BLOCK)) {
> +			use_smbus = I2C_SMBUS_I2C_BLOCK_DATA;
> +		} else if (i2c_check_functionality(client->adapter,
> +				I2C_FUNC_SMBUS_READ_WORD_DATA)) {
> +			use_smbus = I2C_SMBUS_WORD_DATA;
> +		} else if (i2c_check_functionality(client->adapter,
> +				I2C_FUNC_SMBUS_READ_BYTE_DATA)) {
> +			use_smbus = I2C_SMBUS_BYTE_DATA;
> +		} else {
> +			err = -EPFNOSUPPORT;
> +			goto exit;
> +		}
> +	}
> +
> +	optoe = kzalloc(sizeof(*optoe), GFP_KERNEL);
> +	if (!optoe) {
> +		err = -ENOMEM;
> +		goto exit;
> +	}
> +
> +	mutex_init(&optoe->lock);
> +
> +	/* determine whether this is a one-address or two-address module */
> +	if ((strcmp(client->name, "optoe1") == 0) ||
> +	    (strcmp(client->name, "sff8436") == 0)) {
> +		/* one-address (eg QSFP) family */
> +		optoe->dev_class = ONE_ADDR;
> +		chip.byte_len = ONE_ADDR_EEPROM_SIZE;
> +		num_addresses = 1;
> +	} else if ((strcmp(client->name, "optoe2") == 0) ||
> +		   (strcmp(client->name, "24c04") == 0)) {
> +		/* SFP family */
> +		optoe->dev_class = TWO_ADDR;
> +		chip.byte_len = TWO_ADDR_EEPROM_SIZE;
> +		num_addresses = 2;
> +	} else {     /* those were the only two choices */
> +		err = -EINVAL;
> +		goto exit;
> +	}
> +
> +	dev_dbg(&client->dev, "dev_class: %d\n", optoe->dev_class);
> +	optoe->use_smbus = use_smbus;
> +	optoe->chip = chip;
> +	optoe->num_addresses = num_addresses;
> +	memcpy(optoe->port_name, port_name, MAX_PORT_NAME_LEN);
> +
> +	/*
> +	 * Export the EEPROM bytes through sysfs, since that's convenient.
> +	 * By default, only root should see the data (maybe passwords etc)
> +	 */
> +	sysfs_bin_attr_init(&optoe->bin);
> +	optoe->bin.attr.name = "eeprom";
> +	optoe->bin.attr.mode = 0444;
> +	optoe->bin.read = optoe_bin_read;
> +	optoe->bin.size = chip.byte_len;
> +
> +	if (!use_smbus ||
> +	    i2c_check_functionality(client->adapter,
> +				    I2C_FUNC_SMBUS_WRITE_I2C_BLOCK) ||
> +	    i2c_check_functionality(client->adapter,
> +				    I2C_FUNC_SMBUS_WRITE_WORD_DATA) ||
> +	    i2c_check_functionality(client->adapter,
> +				    I2C_FUNC_SMBUS_WRITE_BYTE_DATA)) {
> +		/*
> +		 * NOTE: AN-2079
> +		 * Finisar recommends that the host implement 1 byte writes
> +		 * only since this module only supports 32 byte page boundaries.
> +		 * 2 byte writes are acceptable for PE and Vout changes per
> +		 * Application Note AN-2071.
> +		 */
> +		unsigned int write_max = 1;
> +
> +		optoe->bin.write = optoe_bin_write;
> +		optoe->bin.attr.mode |= 0200;
> +
> +		if (write_max > io_limit)
> +			write_max = io_limit;
> +		if (use_smbus && write_max > I2C_SMBUS_BLOCK_MAX)
> +			write_max = I2C_SMBUS_BLOCK_MAX;
> +		optoe->write_max = write_max;
> +
> +		/* buffer (data + address at the beginning) */
> +		optoe->writebuf = kmalloc(write_max + 2, GFP_KERNEL);
> +		if (!optoe->writebuf) {
> +			err = -ENOMEM;
> +			goto exit_kfree;
> +		}
> +	} else {
> +		dev_warn(&client->dev,
> +			 "cannot write due to controller restrictions.");
> +	}
> +
> +	optoe->client[0] = client;
> +
> +	/* SFF-8472 spec requires that the second I2C address be 0x51 */
> +	if (num_addresses == 2) {
> +		optoe->client[1] = i2c_new_dummy(client->adapter, 0x51);
> +		if (!optoe->client[1]) {
> +			dev_err(&client->dev, "address 0x51 unavailable\n");
> +			err = -EADDRINUSE;
> +			goto err_struct;
> +		}
> +	}
> +
> +	/* create the sysfs eeprom file */
> +	err = sysfs_create_bin_file(&client->dev.kobj, &optoe->bin);
> +	if (err)
> +		goto err_struct;
> +
> +	optoe->attr_group = optoe_attr_group;
> +
> +	err = sysfs_create_group(&client->dev.kobj, &optoe->attr_group);
> +	if (err) {
> +		dev_err(&client->dev, "failed to create sysfs attribute group.\n");
> +		goto err_struct;
> +	}
> +
> +#ifdef EEPROM_CLASS
> +	optoe->eeprom_dev = eeprom_device_register(&client->dev,
> +						   chip.eeprom_data);
> +	if (IS_ERR(optoe->eeprom_dev)) {
> +		dev_err(&client->dev, "error registering eeprom device.\n");
> +		err = PTR_ERR(optoe->eeprom_dev);
> +		goto err_sysfs_cleanup;
> +	}
> +#endif
> +
> +	i2c_set_clientdata(client, optoe);
> +
> +	dev_info(&client->dev, "%zu byte %s EEPROM, %s\n",
> +		 optoe->bin.size, client->name,
> +		 optoe->bin.write ? "read/write" : "read-only");
> +
> +	if (use_smbus == I2C_SMBUS_WORD_DATA ||
> +	    use_smbus == I2C_SMBUS_BYTE_DATA) {
> +		dev_notice(&client->dev,
> +			"Falling back to %s reads, performance will suffer\n",
> +			use_smbus == I2C_SMBUS_WORD_DATA ? "word" : "byte");
> +	}
> +
> +	return 0;
> +
> +#ifdef EEPROM_CLASS
> +err_sysfs_cleanup:
> +	sysfs_remove_group(&client->dev.kobj, &optoe->attr_group);
> +	sysfs_remove_bin_file(&client->dev.kobj, &optoe->bin);
> +#endif
> +
> +err_struct:
> +	if (num_addresses == 2) {
> +		if (optoe->client[1])
> +			i2c_unregister_device(optoe->client[1]);
> +	}
> +
> +	kfree(optoe->writebuf);
> +exit_kfree:
> +	kfree(optoe);
> +exit:
> +	dev_dbg(&client->dev, "probe error %d\n", err);
> +
> +	return err;
> +}
> +
> +/*-------------------------------------------------------------------------*/
> +
> +static struct i2c_driver optoe_driver = {
> +	.driver = {
> +		.name = "optoe",
> +		.owner = THIS_MODULE,
> +	},
> +	.probe = optoe_probe,
> +	.remove = optoe_remove,
> +	.id_table = optoe_ids,
> +};
> +
> +static int __init optoe_init(void)
> +{
> +	if (!io_limit) {
> +		pr_err("optoe: io_limit must not be 0!\n");
> +		return -EINVAL;
> +	}
> +
> +	io_limit = rounddown_pow_of_two(io_limit);
> +	return i2c_add_driver(&optoe_driver);
> +}
> +module_init(optoe_init);
> +
> +static void __exit optoe_exit(void)
> +{
> +	i2c_del_driver(&optoe_driver);
> +}
> +module_exit(optoe_exit);
> +
> +MODULE_DESCRIPTION("Driver for optical transceiver (SFP, QSFP, ...) EEPROMs");
> +MODULE_AUTHOR("DON BOLLINGER <don@thebollingers.org>");
> +MODULE_LICENSE("GPL");
> 
