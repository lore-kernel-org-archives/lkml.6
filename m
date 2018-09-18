Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDC7ECE561
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 06:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 182EA20685
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 06:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="X52pU1CK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 182EA20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbeIRLbk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 07:31:40 -0400
Received: from mail-by2nam01on0042.outbound.protection.outlook.com ([104.47.34.42]:10304
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726414AbeIRLbk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 07:31:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JoCDdnUkD7o5IrNl3TI40egmg9e0KqbSrhA98FhS5cM=;
 b=X52pU1CKRTtLbA+YyFPTiFLK7gZAJ+/smOZhnpaAZHFsO/Zc4jOzxZKTptsdxA2V/VFmSQhvplek7h/ZnVFBcJUfX69672SIXzlNxSc33qTVJUYMQ32t6RBVECVReUEypdCtppnyQYAkYEUP5ROhI4myAWlqPFqMR62pRpULMZQ=
Received: from DM5PR12CA0006.namprd12.prod.outlook.com (2603:10b6:4:1::16) by
 BN4PR12MB0739.namprd12.prod.outlook.com (2a01:111:e400:59bc::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.18; Tue, 18 Sep
 2018 06:00:20 +0000
Received: from CO1NAM03FT041.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::207) by DM5PR12CA0006.outlook.office365.com
 (2603:10b6:4:1::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1143.15 via Frontend
 Transport; Tue, 18 Sep 2018 06:00:14 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXCHOV02.amd.com (165.204.84.17) by
 CO1NAM03FT041.mail.protection.outlook.com (10.152.81.163) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1164.13 via Frontend Transport; Tue, 18 Sep 2018 06:00:13 +0000
Received: from [10.237.40.91] (10.34.1.3) by SATLEXCHOV02.amd.com
 (10.181.40.72) with Microsoft SMTP Server (TLS) id 14.3.389.1; Tue, 18 Sep
 2018 01:00:10 -0500
Subject: Re: [PATCH] list: introduce list_bulk_move_tail helper
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <amd-gfx@lists.freedesktop.org>
References: <20180917120834.13993-1-christian.koenig@amd.com>
From:   "Zhang, Jerry(Junwei)" <Jerry.Zhang@amd.com>
Message-ID: <84fbcd38-8433-1e87-e6e9-90dcb96168a9@amd.com>
Date:   Tue, 18 Sep 2018 14:00:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180917120834.13993-1-christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.34.1.3]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(376002)(396003)(2980300002)(428003)(189003)(199004)(486006)(77096007)(97736004)(68736007)(186003)(305945005)(7736002)(16526019)(6116002)(58126008)(110136005)(426003)(356003)(16576012)(316002)(53546011)(53936002)(446003)(47776003)(336012)(6666003)(26005)(229853002)(36756003)(3846002)(65956001)(64126003)(65806001)(126002)(476003)(50466002)(86362001)(23676004)(76176011)(11346002)(81166006)(2616005)(6246003)(8676002)(65826007)(39060400002)(81156014)(2201001)(67846002)(8936002)(105586002)(106466001)(31696002)(478600001)(2870700001)(104016004)(5660300001)(2906002)(31686004)(72206003)(2486003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN4PR12MB0739;H:SATLEXCHOV02.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM03FT041;1:kWza2C8I4FeW0lIkzG8x+jM+TzO16vgp62Vx7Lf/bt7oeETawawGfUyh4Ao2euo+Mf/IdPG4RKs13cpCnXy3SO8HprunQ1pxtIZqRniIUJranq+PEetR410SgjCLPWro
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bef3cdda-4d56-442b-98b8-08d61d2c003d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN4PR12MB0739;
X-Microsoft-Exchange-Diagnostics: 1;BN4PR12MB0739;3:xUOKWEby9bM11sZ+9jQ07G8s6Nbgyzz9aUyBeqcYMOuj/sTwaSNNs4xH4SS3zfjlbgUNPQLSUjcKHTkQCfgYQAWnKwxSeRzhVdFNyU2HHXIOKHt7DhSsbg45HQQoV60apP0+gbO47e87n849oEBst8nrdwvEi/r/TaJ1KHy4hfg8DXg7KVVnPEbbIQCNaEhH6pM6t8o5kgqWQ3m0zTnHKSfvkfTDovKIwLN8MdvReb8oQ3s8Od93Lx323ev/e0waI6cpNGJX8CNw3bQWFOOWROtTfOyLFeQ0qcodPcHmj3lt77Aa2TWQ0T/aVqB4H9aO/ACSWWtXCbOQ40ms1byTzaAOAHlCqgkISLql4ARG/E0=;25:gvoVyyKSQrvOx0tiqW/NUSvNoH94W/Np+IxpO3gmP7UldOWt7YOKO0bXMP3OfVd/sdHpDdiAFEO0thG1/wH0utRlFfAQg2LJuVpZhp7mI2nLFpvfCKdGnM8bveUTbbGrs6WnljjjBgnUTLGiw9gg92d+k1xFnP5I380TXPTuV2k1vv/oxGKJcA/Ix0waDb9zlcrliy7PkHIE+4q/SSePu6J9FW7V77LLCsd8BtzEvTwS2yIGaWqgCx5SjAwN5qXBlFXkZOzG4KGBEubJRztsNv2yIKxL2UDN9rMU7qXBzewh4R3MvFMx171GaNdy95yDOci3+li7WedgGTmDA/f6tg==
X-MS-TrafficTypeDiagnostic: BN4PR12MB0739:
X-Microsoft-Exchange-Diagnostics: 1;BN4PR12MB0739;31:nnPbJJ8vN/yVjuhBB+Yl7ATnBA3ct1kGfwEzLQ2SEKXqn0OLYeY+miTC9gcqPpghaOHT4548R/CsjFm7Im2KW0p2IhQx08g02Eh3xBuYjxog0O908YsAzmLs+xdpXsrsBEfu0IZgVGY0hUXS41GRH98tdWv/JMtxpdu57Z34Z1wNBOT14X5lWdJxCI0eyrS8FzZxLEzafe4BaZc7p0zixVbt80qilP5VAtjX021CM7o=;20:q/U59oBTLaehC/yMC0np2U6nC91QEzTg21Rj3jkSMC61QrrpQbio+UJ2gDaoQ27LjciHoVzU8Oy1iafeMIQn9E49j58YRkooS1zOwlVmVvmnmsNOK8D1eUBkeA7uxlZSTZAbokg4msi9DmbEAWwPGFECYSs5A6ia/l4H3UpOQeOOs1KP2C8aZZtv0R0lrzI99LwlgYa/8b0xqU/44+ktafldiB5FKZzmC9aCL72hE7T5EZov4J3JS98VnlJnqiS4Ma0tJU9p+JJFTohTcdvmwf6TMmUzr+Gn/mhRF1krJLyEc0NvU/PxrT+OGDnO4/Crkp/I52fsQhHah6U5IuLuZ9wcK7dr40Uqcy8BfLK65INua5d7hnfr9nOsg6FxBdQxu7+v62SmR/x2YYNbWyiY53ptrifgM4YcBVI6Q5DVIFXH+XHI3/EXzaesWVQo8EDB+KsdyE8uEjDVToSZy9XABNerl/SRC1pWj9O8Wc4EvYOO+kjIvXcMTP2GgG0kQsL6
X-Microsoft-Antispam-PRVS: <BN4PR12MB0739D04DA23FAC57FED3E4A1FF1D0@BN4PR12MB0739.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93003095)(3231355)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050);SRVR:BN4PR12MB0739;BCL:0;PCL:0;RULEID:;SRVR:BN4PR12MB0739;
X-Microsoft-Exchange-Diagnostics: 1;BN4PR12MB0739;4:54wSIHKnz+gKVqRIITTpfPOJ0UAjPHrfom8ZDa3jOzsAvaQ4+cZnkAretir2Aw74VtxC7sE9WyipoylPCHp3Zhl5pfh5bpSXqH4Yi6FIesSotZGu0CQEL7+jvkeQIebajKLjAYuyGvLL5yWw6Zd+Q92XDTyRIPQbWG8GKPrF0OeHsbjEBmZj9rLZzGTUJl2SPnF6RJQE3oKlw6db9J1Lqtl9GEVL7iOq0R1M0doHC1Y2P7j0cAIWj24ZZVpHOW4GALb7xoGFjQMDmkDjEXOky4W3jb1QZd+jREQnRjucLmpBufNMoXlBF6QCcmHtR5oB
X-Forefront-PRVS: 0799B1B2D7
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjRQUjEyTUIwNzM5OzIzOmxlUmhOUC91a3ZTOFNWcisvVWdBTGRsZjZE?=
 =?utf-8?B?V2VpZzhhQzZVRnRNRGV6bmhBWVJXaE8wQVZKRHZsTHkzYThEeUxLV2hqVlRx?=
 =?utf-8?B?aHNFakxiVk94ZENQYlZrdVFaS1hUUDhUcEhEUGVDMFd1T0NaNURzclBQVG4v?=
 =?utf-8?B?a0p2US85bkZTckQxeTNYRjBzeWRpeWh4VENwZTY5WVFyb1ZoeEVFVWNxVk5E?=
 =?utf-8?B?MEhUUGUwNkozczYwOHllTXJJazhhdG8yZXArNlZneUFmcG5mQURuTXhwUEJD?=
 =?utf-8?B?dk5XMWdKRG8rOENYNFBWTExrVkRvQ1hobWdXOWxOZXZmNThPdWszVzRacVNQ?=
 =?utf-8?B?aW80T1E3cjZsdVhEc0ppUDdtbXZjYmVzNEpFUnZPeDBYT01FU3A5M0JTQ0RG?=
 =?utf-8?B?T2xKYVJBb1hPVDhMMm9OejZUeURSTWl2ZmVsWm5BK0s2RkNjL2Rtd2NHeWlp?=
 =?utf-8?B?ei9Gc291eDFROS9tQm96MlNIaHNoM0xYa0VJTVU1MiswcU9ycmlIa0djRlkw?=
 =?utf-8?B?RnIvc05XWU9oU2VqR0NSbDd5KzQ5UmpjRys5bTlJYkdVaG9VZ2RmUlZLVWZ3?=
 =?utf-8?B?K2crMUwyY3pJS1pwSkhoOWl4YU1UcnlETUlKOFhiWC9TNHVEV1dMalRVSDNO?=
 =?utf-8?B?TU5peDA4ZGJxQktLbk5RL3FZbVRjN2hrb0xhWk1saHV3UDluTy9OKzlCR3py?=
 =?utf-8?B?WEdNdE0zQlRzWjdwTUtJR3ZuUUNBQ1VHcWtKZlR6bS9EVU84QzRjRUd2dTM2?=
 =?utf-8?B?QmM4WkliT2sxamNWU1J1UXkvZ3MwdFV0Mm43U2srd1poRlBEc0dUZFBRU29r?=
 =?utf-8?B?c2Z5bUZ0Z21GK2t1akVWQW9BU1pmWk83R3k0RVU0M2dIV0Y1aURIMTlJZVYv?=
 =?utf-8?B?UmVpRVdLeE1oa0RuSlUyZ0xNN0Vyb3M4WTgxRFZJUkY3VCtoVHlXOWpFNlQw?=
 =?utf-8?B?bU1FakVPY1R0TGdiZ1ptL2Jsd3VjdE9GUjQxSDhLR25qdEFoZGRoUHNuMlJQ?=
 =?utf-8?B?Nm8vaGlqWmhtS1BXM3I5RVNhdmgwYXQ1ZFlsQnNPUkE1YitMd2NjczhseFFw?=
 =?utf-8?B?eS8zNmZLU2hGbmlKeTZpMGpNeGtYd3F5ZS9RaEk1ZU5zUDRPNEd5aWQzaVZZ?=
 =?utf-8?B?b3oyTUVYQ3FXZ3ZkSUlmeHJMVUtlTS8rRjVqNTZzOU04ank3OUFlS3dnK1hV?=
 =?utf-8?B?QytmTmtxQzhQc1F6RFpLbjI2RWlIcVlVWkJGbHN5bGd1Sk84Z2dGS1lpMFhj?=
 =?utf-8?B?clUzTW4wWVQ1aytaL3dUR1ZvTEE2L2xJMU1OVHBhQ2xWbXJnWjRlNWNPVURx?=
 =?utf-8?B?NFIwTXZkWmcrRWZ3WlhJaUIvZzF3b3JkVFFXazBXRUl1MDRwWEU4eGxXM2Yy?=
 =?utf-8?B?MDJqRGVLTnA2OElqNjFCUlM1clNRLzJWUWJXQjlmUkg4QjJsalVOWWFtS1Rs?=
 =?utf-8?B?cGI2T0NGZlRtL0I5WHZXU1pYVndhKzhEZ09mNi95dXNwdnJGTE1JQ3dLZ2Fj?=
 =?utf-8?B?Nm91cVJTVUdPSU1mbUQ4MmVNdWJNOXIwbk0ya09qRUlsRmg4OWVkck1NRjFl?=
 =?utf-8?B?eUdpb1R6aTVUZXZkSzEvdHNJRU1RMThXN2FKMWdBUCtlWlBpTGZKaHlsL3Vs?=
 =?utf-8?B?V2h3eXR1bmlXWWxDc2pQT3FHZHNkS3dXWVFLeXBQRVcxN1ZRN1FLZWl6bEhX?=
 =?utf-8?B?WVVYR3FVOXFrNUdrWHkyRGlBRFpzR3NqenRBWDBYdmo5Z0xydDMyQVNYN0xs?=
 =?utf-8?B?WG5LRzArWnFTbWJsVFVsT21PTHdWU2RVZ3h6bDlvUXVDdTY0UEtWUnRQQ0V1?=
 =?utf-8?B?djYyTy9VcTNyUHZhTERvbmhLQ3ZTWmJzOGQyRDNsMkZYbVA0V0xQR3g0K2hn?=
 =?utf-8?B?N282K1J1UElzQTJUUVdsOXUvYk1QbE1zclZjanAzY3p5SmZQVjcwbXJQRkhm?=
 =?utf-8?B?YzFERDc5M0h3PT0=?=
X-Microsoft-Antispam-Message-Info: ZbEpwNB0nD0ut1aujIJWXaWfHY+qjKnBqKqkHiroCGkDmvnxSMEUl3EIfnsAFMhEOIpaPW1YgRfod4tbfZN0IomCl/0EAXB24xtv2jSYmaJcgmlyXoPhKXWiXmfVfXCkXQysNHIgpTwr2k/FidtNMZ3h1e7gF/U8BNWlz2qTlc6+g86ovr9Mq1oHbrJj1swH7eDp0au3EijPH6FlrEr+ySbYkRCHgiIZDVUCcNkVLhnTuWqgrbFW4py3AXOBjrcr/EXy6V8xABV+z5WNB8mmllY7XWJonw0HPsmUtNR62q4ww/sVgQ418I3r9re5l7k5PoslwGafc8WLES44EuOSTpSgAB6p6MpZpL0U8xSBdmc=
X-Microsoft-Exchange-Diagnostics: 1;BN4PR12MB0739;6:7hjwt3lvapAXmLugBQ01qT1V9B1icU620J6MLg5HhE0abrIvIDVM4e9EUnpaZMlIqU3IFA3eHPYQ9PUYOZoEGcq/gMXLnsZMSOg3wCSLoJhkOA/dS13/12TXhnayDzIIZTA03Q3II/Y4fmP/IjXhYfySNTdX1fh43V2kLLXMYtZ5jCJMvQYcIRXKjrBjPaz/l2t/4T2PiQdJ84nhGG4UP1dLPr4MYeo54XEeRwAirwILEJN0YUwsShxUfSOzwT0HbElImjBJCXh6tcce481pCxhPRfiZSK0nX2SgsuQxfRoHJEP+8Nd72uZBuAUx+t2P12u2MYPiy8vqDhhtSubgaZ000Iuf+cVzXqWDRwEqtmeoIFJmk88ejiQV3xN+MAiii/UbwdWH+/YUTmjMrNdyFaOQuuotwOAO3pRNWPOqyd7h8DUoSbOCrAAA4MSnFIsSen1gq3IU2XktQpwfbvzOhw==;5:XGsXOTygW6PwSIiESPtxT0/DIss5yMoGbrhsFBg9AHVZC2JDJwSomuVwUj8+yM48+vN5WZMwwbslXvsrEuq5iGSkJZb6FN5YSZKcV2LPvHpKmQAUNSrdY0DvwVWSp9Z+XozjN7g5PadQXBU2TQvN4arZ/YN+p2SDHhlZwKD/3pM=;7:0NzuLLdfQp5Yp6DmRO3RaOCdTNudRsFulT8TfsCITlwt+F8QLgwgK1wdmhE/+8207q4u1sXeRNBIhpvDF+ZbO6FJ744L9nUcybfEMKHNvsGIO8yU9dL9W5nrC4N8emKOCNIBpLL5wpCNWJgWVRj6MRnLJHXRhYzNLN6tyDZ2qsVWsYWKWZX1iD6UdRFZR28HifLVADfmnY7I+UOdbEYz+v6CEI2hjtSxO7CtNckSfZOaa5emAMMFYSoFhqSAxwip
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN4PR12MB0739;20:13y2O/TqvCcBxmxruhq+2poJ038uTvMepgTOVFBw65VV3fV1XprdRbx8CXuoTTP181ArYndkZC5hlT2/YrqwyMAX6a2E/3jQJVk6pqQlGhK3ZHwuEFPHFhzbYYU8ITqIscVZTWLjl3CoPBXl1koWcI47uz6sjIg89BHSD2RbqmoeJLNtN8UUv/G6LydZhdqP/sxwrywZPz01ZPCvFVLbAkO3qdnsBpl7sz0SmzVi2npWwu/hiWHKwM9gNCPv/HVC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2018 06:00:13.5708
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bef3cdda-4d56-442b-98b8-08d61d2c003d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN4PR12MB0739
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/17/2018 08:08 PM, Christian König wrote:
> Move all entries between @first and including @last before @head.
>
> This is useful for LRU lists where a whole block of entries should be
> moved to the end of the list.
>
> Used as a band aid in TTM, but better placed in the common list headers.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Junwei Zhang <Jerry.Zhang@amd.com>
> ---
>   drivers/gpu/drm/ttm/ttm_bo.c | 25 +++++--------------------
>   include/linux/list.h         | 23 +++++++++++++++++++++++
>   2 files changed, 28 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> index b2a33bf1ef10..26b889f86670 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> @@ -247,20 +247,6 @@ void ttm_bo_move_to_lru_tail(struct ttm_buffer_object *bo,
>   }
>   EXPORT_SYMBOL(ttm_bo_move_to_lru_tail);
>   
> -static void ttm_list_move_bulk_tail(struct list_head *list,
> -				    struct list_head *first,
> -				    struct list_head *last)
> -{
> -	first->prev->next = last->next;
> -	last->next->prev = first->prev;
> -
> -	list->prev->next = first;
> -	first->prev = list->prev;
> -
> -	last->next = list;
> -	list->prev = last;
> -}
> -
>   void ttm_bo_bulk_move_lru_tail(struct ttm_lru_bulk_move *bulk)
>   {
>   	unsigned i;
> @@ -276,8 +262,8 @@ void ttm_bo_bulk_move_lru_tail(struct ttm_lru_bulk_move *bulk)
>   		reservation_object_assert_held(pos->last->resv);
>   
>   		man = &pos->first->bdev->man[TTM_PL_TT];
> -		ttm_list_move_bulk_tail(&man->lru[i], &pos->first->lru,
> -					&pos->last->lru);
> +		list_bulk_move_tail(&man->lru[i], &pos->first->lru,
> +				    &pos->last->lru);
>   	}
>   
>   	for (i = 0; i < TTM_MAX_BO_PRIORITY; ++i) {
> @@ -291,8 +277,8 @@ void ttm_bo_bulk_move_lru_tail(struct ttm_lru_bulk_move *bulk)
>   		reservation_object_assert_held(pos->last->resv);
>   
>   		man = &pos->first->bdev->man[TTM_PL_VRAM];
> -		ttm_list_move_bulk_tail(&man->lru[i], &pos->first->lru,
> -					&pos->last->lru);
> +		list_bulk_move_tail(&man->lru[i], &pos->first->lru,
> +				    &pos->last->lru);
>   	}
>   
>   	for (i = 0; i < TTM_MAX_BO_PRIORITY; ++i) {
> @@ -306,8 +292,7 @@ void ttm_bo_bulk_move_lru_tail(struct ttm_lru_bulk_move *bulk)
>   		reservation_object_assert_held(pos->last->resv);
>   
>   		lru = &pos->first->bdev->glob->swap_lru[i];
> -		ttm_list_move_bulk_tail(lru, &pos->first->swap,
> -					&pos->last->swap);
> +		list_bulk_move_tail(lru, &pos->first->swap, &pos->last->swap);
>   	}
>   }
>   EXPORT_SYMBOL(ttm_bo_bulk_move_lru_tail);
> diff --git a/include/linux/list.h b/include/linux/list.h
> index de04cc5ed536..edb7628e46ed 100644
> --- a/include/linux/list.h
> +++ b/include/linux/list.h
> @@ -183,6 +183,29 @@ static inline void list_move_tail(struct list_head *list,
>   	list_add_tail(list, head);
>   }
>   
> +/**
> + * list_bulk_move_tail - move a subsection of a list to its tail
> + * @head: the head that will follow our entry
> + * @first: first entry to move
> + * @last: last entry to move, can be the same as first
> + *
> + * Move all entries between @first and including @last before @head.
> + * All three entries must belong to the same linked list.
> + */
> +static inline void list_bulk_move_tail(struct list_head *head,
> +				       struct list_head *first,
> +				       struct list_head *last)
> +{
> +	first->prev->next = last->next;
> +	last->next->prev = first->prev;
> +
> +	head->prev->next = first;
> +	first->prev = head->prev;
> +
> +	last->next = head;
> +	head->prev = last;
> +}
> +
>   /**
>    * list_is_last - tests whether @list is the last entry in list @head
>    * @list: the entry to test

