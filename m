Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69658C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 119FF206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:21:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 119FF206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbeJBVEr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 17:04:47 -0400
Received: from g2t1383g.austin.hpe.com ([15.233.16.89]:35012 "EHLO
        g2t1383g.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbeJBVEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 17:04:46 -0400
Received: from g2t2352.austin.hpe.com (g2t2352.austin.hpe.com [15.233.44.25])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by g2t1383g.austin.hpe.com (Postfix) with ESMTPS id CBEA71401
        for <linux-kernel@vger.kernel.org>; Tue,  2 Oct 2018 14:21:08 +0000 (UTC)
Received: from G2W6309.americas.hpqcorp.net (g2w6309.austin.hp.com [16.197.64.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g2t2352.austin.hpe.com (Postfix) with ESMTPS id 413FCB6;
        Tue,  2 Oct 2018 14:21:07 +0000 (UTC)
Received: from G2W6309.americas.hpqcorp.net (2002:10c5:4033::10c5:4033) by
 G2W6309.americas.hpqcorp.net (2002:10c5:4033::10c5:4033) with Microsoft SMTP
 Server (TLS) id 15.0.1367.3; Tue, 2 Oct 2018 14:21:06 +0000
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (15.241.52.13) by
 G2W6309.americas.hpqcorp.net (16.197.64.51) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3 via Frontend Transport; Tue, 2 Oct 2018 14:21:06 +0000
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=mike.travis@hpe.com; 
Received: from [192.168.2.157] (73.222.225.80) by
 DF4PR8401MB1130.NAMPRD84.PROD.OUTLOOK.COM (2a01:111:e400:7610::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1185.25; Tue, 2 Oct
 2018 14:21:00 +0000
Subject: Re: [PATCH 1/2] x86/platform/uv: Add is_early_uv_system check
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        Hedi Berriche <hedi@sgi.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Borislav Petkov <bp@alien8.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ram Pai <linuxram@us.ibm.com>, Juergen Gross <jgross@suse.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Petr Tesarik <ptesarik@suse.cz>,
        Sinan Kaya <okaya@codeaurora.org>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Hedi Berriche <hedi.berriche@hpe.com>
References: <20181002012204.297193336@stormcage.americas.sgi.com>
 <20181002012204.453928259@stormcage.americas.sgi.com>
 <alpine.DEB.2.21.1810020818530.32062@nanos.tec.linutronix.de>
From:   Mike Travis <mike.travis@hpe.com>
Message-ID: <b63d338b-c93f-cd05-2d99-59d66662d390@hpe.com>
Date:   Tue, 2 Oct 2018 07:20:55 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1810020818530.32062@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [73.222.225.80]
X-ClientProxiedBy: YQBPR0101CA0056.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::33) To DF4PR8401MB1130.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7610::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae355303-85e3-414f-9be4-08d6287249cb
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DF4PR8401MB1130;
X-Microsoft-Exchange-Diagnostics: 1;DF4PR8401MB1130;3:QrK1/zPgIb/95U1bvdlZdQaWZXrFsndKpH+85WKVQ3KZN5FSktpTjyyQmt6BdrCUYhncssP+xSxB8chDm4Wm5YSfQpimM/32p3LsShL5kXIWL12U8CozXwAUyUupa89hTbMz3ZLh+pnMELMTqOQZWRUwW8FBxO3KaLEfb+f2belhqV9d1DLx8eSUiLvFxuu+7ZtWlw8HZ5kL69QWNmCUMGudzFy6Msbe5zIHVbhfl5NtGZymcjz3/bKWvnT4vQg6;25:tTgQRtqGhUXDIgw5J3YPnR0CgcURbXHzNBuLpKL+4HnNe/rcyMnH06jqLJkwMFSetUAKP5RZX49oiic8DoX1hrHddRFs4M7TksCJOlwiMpRciBkLP9Zond9qQ/RQqyTdXvgjaSfepzkI6pXuxE/XeG6VxXsSZHNCu9DayHihxlZO9vlyGZZb54+r/O5QXsHemHC0xkStHGDboSICQhtSdwp0DjptP30Pe0Vl6Ft06rxOb+Dpm88/V+uCv6NBl041e/kUXWAvryhbfR0lyvcKwZewpHzzb4nNn2jS7JDUppB55RSK4IU0t7l81jxalVX4ZiSC6wnjQAMGR7o/SgI25g==;31:Q1KR79f9TKSmHcNObqTWHmhHMfBoxvz/qqjh66l2f1JmFHKN5+VD3kbh6JYwb1VqK1mQwSKAAa2mU9JnBBn2zMv2oQc5dBJObfu/c87RAE5gC22JF1NuPFX1Ly8X+I1RvMWWdUwnQgPxSfWYj6Y54yPDKdtjVhkU3iLptg12jNFnP2xcnPLKBeFrnQ6/smEdsCZ5cvqk8l9fZ+mjxcSQmnKZ33LZmTkvNFZqtQ0w5FA=
X-MS-TrafficTypeDiagnostic: DF4PR8401MB1130:
X-LD-Processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;DF4PR8401MB1130;20:rPT8YlYT6eaAfJCMJXFBXbFs6Y5QWTGqqC7WmsVMvXVwRN2tcikfmfLs2zoOBxmdQ/8vM8j23MSrd3FWeJs/u4y+nXKK8ji13ZwHc+104fjF1CMjfJo2164NKVa0x/Oe63qI8/Td4zTRYP6VldKgqz6WZYi8DVjctwXK/wfUWqhJG4iNWeomkMvLRN1cJXemhkKoEEl6+e5AwGppdHLAXM8VBLpiL1m+8nmHjNt/jmyaRcbCudOTHIfInhrXM/qOoEtyN5hBaEOcHRD5EcIsRd8EltTFLfzhLmrg6jniuGiznqpawOYufD8L2wBmHYna8RFIP81flFJWsD/vbUZvuSaIvN8dsEE9GSMsx0y1ZKDvzEpMpzC0E1KwLD0zrF3i7aIJCvMyDcLOYxqvwmGkhCWAlCnt6DxYDPH2GuSi5VSe10x/YgL38mUbuexEr92qAy2jhfYMcME4hREtgiE7h638fmoAZjb1cMX/Rafbg4n59Z2oqrcTareHzxIiAFt7;4:deayr4JFemB5f7QI42tUr0WFlBZ/SEIbFr5PS92fFzI911dLHecCq+RuXr99osrBpDFYnJqeU2nVQK/E58f3PR1RVrPuVjOKL84TmbAWwNp9bYDKISkMbSGp0xBHDrLdxknOydplU9rFYcKAvja5+Czb9bbHqlQwHfF1ruyZWfJc/45djrKchYsHoNjB5U6NZipd+KpGjZZnrHsa4D9/XdWyQlWyuHk52hHNhXrvnsUkFLroEicVmw2A8Z1IVTp+XMueMM9STS2m2DRwkBK8Pzcq8s5SOTvZLAvsbh76TV/jNR5a3yBOVB2FbUx3VNKNJMykeGTyew9mN3vav2AVtFVkwoWvy7d6Zo0Lda7mfsk=
X-Microsoft-Antispam-PRVS: <DF4PR8401MB1130324E5AEC01BFA18F0C37E7E80@DF4PR8401MB1130.NAMPRD84.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(222181515654134)(227479698468861);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231355)(944501410)(52105095)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(201708071742011)(7699051);SRVR:DF4PR8401MB1130;BCL:0;PCL:0;RULEID:;SRVR:DF4PR8401MB1130;
X-Forefront-PRVS: 0813C68E65
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(366004)(376002)(136003)(39860400002)(346002)(396003)(199004)(189003)(47776003)(106356001)(316002)(64126003)(3846002)(53936002)(31696002)(7736002)(305945005)(6116002)(230700001)(229853002)(478600001)(97736004)(68736007)(2906002)(7416002)(6486002)(16576012)(8936002)(81166006)(81156014)(16526019)(67846002)(44832011)(6666003)(58126008)(77096007)(26005)(54906003)(36756003)(8676002)(52116002)(50466002)(386003)(476003)(2616005)(486006)(6916009)(117156002)(11346002)(65806001)(3260700006)(65956001)(25786009)(66066001)(31686004)(105586002)(6246003)(4326008)(5660300001)(956004)(65826007)(86362001)(23746002)(446003)(53546011)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:DF4PR8401MB1130;H:[192.168.2.157];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;DF4PR8401MB1130;23:nt7bLWJRt4KHWuzxGqbiWjM3ocnxetl3CZA?=
 =?Windows-1252?Q?asM3EgV8Y0f0Y49Bcp4psydTZ/qnAxuUNH78H48lN68OvOUL8gPIqGCz?=
 =?Windows-1252?Q?fhOOkxUlQWcgoymCmDmyTiBHRCkcTMqemsGV25mUuPmZVqIenFYaMr5S?=
 =?Windows-1252?Q?HASi+pJbwxrVUZgK9ID4GLLptiv8l3BdWc4E7X15H0p4qzjxeeK4OO8j?=
 =?Windows-1252?Q?8C8s3qNLtMIImJ5EXYWMiG+2jmCB0FIuucK0MewSxoG6TU1gR9Gv1NPH?=
 =?Windows-1252?Q?UtQB003fpOdLiPlx2px7nuWOMIQJT1x3errPSQBJvlmU5J2KBjC9+tnQ?=
 =?Windows-1252?Q?AlPUgJlvlU1xJG37+rPzuNcqwRAvW/O0OuFvOzsWGeqXAe3uQrOtFeGB?=
 =?Windows-1252?Q?UdMllRl3SXDCyBSTvuVrTJXqjHWpKJj8ZVR5iALJOH0YdOAsW6Hhw4Bq?=
 =?Windows-1252?Q?1hgacKghQ4VjZKRn7Ma6cqMWQdojQT3a4dYb5RZpe0eRcV7YA6qJS3NE?=
 =?Windows-1252?Q?l8OBECzbpU1gppnW/Yiqg10Ew6R0Noud1YmmUJuY906QB2H+kqvbrsl/?=
 =?Windows-1252?Q?/E7Tk6Fr1NGnBlRKLfZCeS6aUCswiaB7IWOQBinnmQHVxyfz1Mdvxcoh?=
 =?Windows-1252?Q?12cWhgWlskLVeRseWA/Bs4m/qkCvJYzIDxlxgF9TLbnsCxDqEiaz7vrP?=
 =?Windows-1252?Q?7BmHl7Z4sIOjDJr69ywZ5wNK9T5abCHJ1DwCbx3FJJ/txiDj0SRfyt3l?=
 =?Windows-1252?Q?zp2s2hjdH1tlqoQQJohJDERA3lxwYPsRCPs9kZW4YBK9Lx6/NKuE5iWV?=
 =?Windows-1252?Q?/EV28eUuuC1wCJfrf820Ao+569b/Bz/DQHVOpxuBdVQoo/5CN4FAAjgW?=
 =?Windows-1252?Q?voRoeNu99DR4yNq8D6uoYHPDMgHUPJAWzLG0EgfOw/X2pO24WTiVe3xL?=
 =?Windows-1252?Q?4/cuXfDWJcWpzLpWJeMetC1Clugi8M+ADrOwlQqDHMbaH12e0DxJxSYh?=
 =?Windows-1252?Q?a2uca24tAJkBqK/jZK+TGEMIhnVwL8GbBhfenu+hd7z4emQwacgataic?=
 =?Windows-1252?Q?DzJb71YyHKl+sE1sWDZi3ZISr6GXEhT60C9tUN4lKeKLekF6eSmJl+us?=
 =?Windows-1252?Q?d2iNsZmy8tHwy/eo7EYTWjum52cpRBHlTJ5G6iFUyWvo1BscOOchbM2s?=
 =?Windows-1252?Q?UzPPfSJuys29ZikFTo0jSHL4W52eRme4SxhNyhnq8dOxSo5mNtDOUp6F?=
 =?Windows-1252?Q?eVctX9tY34qcmuQcKdnBFgFcojl/bwcKJbV2OEHOjoIoHwdX83X6cxPT?=
 =?Windows-1252?Q?3VQcKp1cNR2J4ZJD468Tl0LzTaY149o85vQp6t0UMXcjCFxHJpFYmABo?=
 =?Windows-1252?Q?1WokigGGs30tFFXaoKP+jrbI8F465sVrr+/T7mydTq924xA1YH4YtM8J?=
 =?Windows-1252?Q?Jl2RDRapFt41yKC9GuEh92AWLWViL3wWmaGdzcAjPDeEgUB9yQIX1mFI?=
 =?Windows-1252?Q?aFyNPURiHm5JMjyyQg9F2OIPAqE7H/8z/ltVZYI/oOM5OI/QykjA6ooC?=
 =?Windows-1252?Q?rL27VMCq6oX90xgEKxhdWYT6W87QiFcICdqm8?=
X-Microsoft-Antispam-Message-Info: fHB6U6e8DgR0Ybn7UBhWcvYRzM6ktbJNXNsH1725l5/t+6KKNQ0H0NERR7sdh6Y/dhjbQzzpAxcMxgxnkSgE3N0IFz9Uw6Xq1IpzmluVrCglYm35334Xx/3rjEO7LVL7w44MjfgekI/K01n3iivBrSibpxxVnt8Hf1LnEsNZMizjYKplXkCwKhSoosPRthIIsPFWk5YpT8E6SatSCAclrsov15XguAz2AbgIbUooNHdM0f+pFYXQWdlkUHKc499QvnK3r8DqSSQe0vKboCoMC+iWYtfgSadBlJF53VlLgwn7DLTBx41U6SqERIvntLZTbZzGmVQIDoViHKgTeWKISgjihnvZ0dt9XqXvSJji6F0=
X-Microsoft-Exchange-Diagnostics: 1;DF4PR8401MB1130;6:OxymndDPfl/oR/1tQAlYpJM2mozDH9QBd7ea4Tyo31gWuPFWTN/G4a2zcMeXsMXFzErY0vZSakR4z+nzbEkpQz0gZvxZLmxvuAk+umFINiDIwvhgPPU2vPg+qEjewi4IpqTKLvRSYDNcS2dT5GVXwfdfyL4qe3fe9qg2gQuCJ5Dqf3qVTKTfuDHDmU8kh2tqcIoBiQIAuGpk1Sa2Bj0roFqHxH2g7DG4e34xHFCzOBvp50Yoy/mulvzB+yqYwkXvo5oxolVrzS8IKYjhxKQEkdutZ+P3wcSFEv8ejDCx+37v/P10OpR+6gIVxsWyZglhxY8Etoou9Sr0zSnO+gUBkuoTP0Pw16BfEBarGH5C42KeWJzl7AqWlQHSPsj1OMc1DOYVp+Ua3lkCblJxCEUaJjfLz5QdukmB+nmjNv5rUGsACqDKLb7dkb3FGwZ0WgRZXUT4S86N3aiUeJkN5Cj8Tg==;5:CaX8nyFrVJQA0xpabId8NldpfHd2IE2XQXqOCK8Of0ikSNBuX3Jy6vPXC7pSxQChhoCwQI6UzrYtGeOIH+tm8RZ+2HEQWHaGX9jn6G2FmeaxS9TRw9XrmIaKvYIgFWpBoRdeCvbBXolRztN/VXI4L3j+lG8T9De1/qmeistZf80=;7:imdeb5xCLWCBkoYUlMuNLvh07xjRZQuDvHFhe0h2v0kMOhsQ0Aq+YYmAKQ2m1qch9AG2o+LPt/mYh8zaaYFH+/LZMQbfpGZjvZoeRK4IVk0Srkx7eLB18bx5fg5DHeuo+zg3KNCQWpzjZoaoVjmTJNgb8usnen3Vpomrq27COLbQnLM37rqDGN0/QMWkh7xbQmF+m0aUgz1EivmRLgjK3I51hocE6H+ZqlGbluEyyoe5TFsdh6EHAEIEJulZdKrA
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2018 14:21:00.8341 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae355303-85e3-414f-9be4-08d6287249cb
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DF4PR8401MB1130
X-OriginatorOrg: hpe.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/1/2018 11:20 PM, Thomas Gleixner wrote:
> On Mon, 1 Oct 2018, Mike Travis wrote:
> 
>> Introduce is_early_uv_system() which uses efi.uv_systab to decide early
>> in the boot process whether we're on a UV system.
>>
>> This is needed to skip other early setup/init code that might break UV
>> platform if done too early such as before necessary ACPI tables parsing
>> takes place.
>>
>> Signed-off-by: Mike Travis <mike.travis@hpe.com>
>> Signed-off-by: Hedi Berriche <hedi.berriche@hpe.com>
> 
> This SOB chain is wrong. I don't see how Hedi is involved in this. If this
> wants to express that the patch was developed together please see
> Documentation for the Co-developed-by tag.

Hedi suggested a "Suggested-by:" tag, would that suffice?
> 
>> Reviewed-by: Russ Anderson <rja@hpe.com>
>> Reviewed-by: Dimitri Sivanich <sivanich@hpe.com>
>> ---
>>   arch/x86/include/asm/uv/uv.h |    6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> --- linux.orig/arch/x86/include/asm/uv/uv.h
>> +++ linux/arch/x86/include/asm/uv/uv.h
>> @@ -10,8 +10,13 @@ struct cpumask;
>>   struct mm_struct;
>>   
>>   #ifdef CONFIG_X86_UV
>> +#include <linux/efi.h>
>>   
>>   extern enum uv_system_type get_uv_system_type(void);
>> +static inline int is_early_uv_system(void)
> 
> Can you please make this bool?
> 
>> +{
>> +	return !((efi.uv_systab == EFI_INVALID_TABLE_ADDR) || !efi.uv_systab);
>> +}
> 
> Thanks,
> 
> 	tglx
> 
