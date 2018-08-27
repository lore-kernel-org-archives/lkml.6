Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D73FC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 05:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B558216FA
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 05:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="EM04SZWt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B558216FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=caviumnetworks.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbeH0JnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 05:43:17 -0400
Received: from mail-dm3nam03on0055.outbound.protection.outlook.com ([104.47.41.55]:4848
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726772AbeH0JnR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 05:43:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3rZib33FZGhiXR3C3ryfE/3WsLMw4HzXWYqVU2qU+6g=;
 b=EM04SZWtA8b6F3RikVAM3TKhMBo9x6nzvbeRy+EBJmkupv9k/dmYM3FgffFirnfYR1La+OAzUi8q2T2DV8EziRIaghUQFLgQzsz7BWK06qKxhR0JQ51io4sLNO7pNigcoMqM1IqaIfadvARIfoi9KKVZi8cFi6eKAmiQZ1+UlA8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=George.Cherian@cavium.com; 
Received: from [10.167.103.249] (111.93.218.67) by
 DM6PR07MB4923.namprd07.prod.outlook.com (2603:10b6:5:2b::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.15; Mon, 27 Aug 2018 05:55:12 +0000
Subject: Re: [PATCH 2/2] ipmi_ssif: Fix crash seen while ipmi_unregister_smi
To:     minyard@acm.org, George Cherian <george.cherian@cavium.com>,
        linux-kernel@vger.kernel.org,
        openipmi-developer@lists.sourceforge.net
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org
References: <1535109010-5074-1-git-send-email-george.cherian@cavium.com>
 <1535109010-5074-2-git-send-email-george.cherian@cavium.com>
 <cb0a1ee4-69d7-b66c-b79b-6f8f542a4af0@acm.org>
From:   George Cherian <gcherian@caviumnetworks.com>
Message-ID: <2d61212d-4b8e-e177-e53d-a6288f720102@caviumnetworks.com>
Date:   Mon, 27 Aug 2018 11:25:00 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <cb0a1ee4-69d7-b66c-b79b-6f8f542a4af0@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [111.93.218.67]
X-ClientProxiedBy: DM5PR16CA0037.namprd16.prod.outlook.com
 (2603:10b6:4:15::23) To DM6PR07MB4923.namprd07.prod.outlook.com
 (2603:10b6:5:2b::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e394248d-a4c5-4534-0cd1-08d60be1a89b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DM6PR07MB4923;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4923;3:+E5ogYcGM85qtEORBfGZpEhJTEF/SyqnrNFbtfNfMlRaCpMUNGftbHVV4cjoN/rHRLKeatFG1/Y43J5rieWjsmkBGINLpwfm8iEmH/KyCU++ywCAMglgQebJVTrIcnaGUMLptQAHxL38fMrzETd/TeSrwBrLsXDCkJLemTekoK/L+mdSSBU7mGzsZMpuVDLRw88c0K3pxYNr4p5QsRW33CU1t5D52Pz0IJ04KqbW8qGYM/uziU/J69jGCt7QiZRY;25:LojSPTW5lbxExJfjhJVZlbf0zTzIkWfy1GGvAuh3VL93/ck5hUpVPbeKd3bqKmqvHgEiz0kaYh4Wac07MrOIGjoL7kBVBqEiYQWUmLCA8P3ZSYaZ5+ekp0iamLUFFF8KekA2vCEVnVQ6Or3fDebfZBxVCCFb4Fio8t1i4yBVmBMPWZSwhrAtoEAidVH+AXCcvvyS+64aXlEx9wKehNsOwMv9LlqVVLP6LlFQ16+wCO5YHqtI8/eTRtiQOHiygSiUBkDN751F+af97gZwDdt5nPtYu25+Xfbj2qM+erijZVIVwzxr+fzbYOcuorku2ONbzoGwtYCbrA/bToYl9mXpkQ==;31:CtI9T4GVx7aZauP415tM1ZbG4TMAnTfHkufNCVp4qSpz9pbXdvhheRsHFOGgMgUPF0cQCpkSPFfz1AzUjXySATNgtB1dYuGFN/QU7AQgEWRN3brRV3rWAKAzz7lafaFt8Xc+iZheyDjvlFubgBvtf3Xsl8RJGXaSAh8SZiH4+jL5qmUTIdKR0elXbqkQJdPDj30PRxL6NllmEH6BpV1+V6tDIVZLWHMNNxFOdlaDFbo=
X-MS-TrafficTypeDiagnostic: DM6PR07MB4923:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4923;20:iLTDX6OnczGv5i0Fxb4ZhlDj15tLZD4/DVdNPZbEuC9qd5yhB1sv6i3rFyMyV/VENp3ntWlZmIJfutarfEXFGTfaEkKzswzgu0cjFVZrBxrCe1sGoSVCQF94ch3O/Cj3WxJLi0u2dGMi5Lmb0DKUG7lvoXb645BZ33wmDCa60kcIU+f8oHYOBHjas6qSP4fokTKdJkVDPzDvQUw2dBcHezCIHiAY81sk4O4i0px4gLeVe9DJz0EF+4B7kKuQ13ecrhnhgrR2XHsU1kslWD4i9yeb9sHBjMTH2j0Y+uziLTpMYu0OJaIycvCDylIfFzA5GxmwNq7EfFUu9N5zIv0c2o4KAYapqP3YqXrWL1gPC9dfYQ9SuCKWaQiK00FbTsfT0EPs/w2QGVLKHy+v0iAEvbWxFqRvS42LAnE5nS5EVsTS72Xf7jtRglH6LkhdWM4CbR7Dyd/9iVFxKCF+FbAysrj3wnq7jJGe28rvY64TemK15KPGYOXoJAp8uZsYoLfYzChvnNUOgibydwZ/kwmUS1Te2qZ5rNdr+8UoOlwe9Ac7RBWshxykOKme0iLvNMaHLiUEblKImHaNJ4Wy71bjC3IhUbJOJ9aIr8iIXTnurqI=;4:u6wmvFWsf8ugoTAfS1R8in1yNZRpt6UtE3SWJxIyR7SpADO1cBaEPs9/z3RDMkECJuiHBrlpNLcX+m2NrKTI0W/wdJcE2gBWH3x4sJ9Cdi/tIbq0Fzf+3th/2LNOXT2hZHZk98ihfQiKjxGPQsQ/B83mzhS52rpsFMThdlOKtq6dQOZ+DM/0smUNphbSgHLU4nwTIst6deXJUUii2tYBf8x+2zK/8HQeecHcCzPGG+wNxHJcm1elLdVaQOT2I5RskuKGFpvgaEPjQqaczEKz8AK/SP7XpyREPRQtmLPh01TNo9H9FIwUXhXuIyxadjv3
X-Microsoft-Antispam-PRVS: <DM6PR07MB49238D97A4BC87B5A2468A3BF90B0@DM6PR07MB4923.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(42262312472803);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(3002001)(10201501046)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201708071742011)(7699016);SRVR:DM6PR07MB4923;BCL:0;PCL:0;RULEID:;SRVR:DM6PR07MB4923;
X-Forefront-PRVS: 07778E4001
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(376002)(366004)(39860400002)(346002)(396003)(136003)(199004)(189003)(97736004)(305945005)(76176011)(486006)(6666003)(476003)(105586002)(5009440100003)(47776003)(31686004)(5660300001)(229853002)(65826007)(106356001)(66066001)(65956001)(65806001)(16526019)(6486002)(81166006)(81156014)(77096007)(2906002)(50466002)(186003)(72206003)(966005)(53936002)(64126003)(478600001)(53546011)(386003)(16576012)(8936002)(68736007)(58126008)(8676002)(26005)(316002)(6246003)(14444005)(6116002)(3846002)(6306002)(575784001)(42882007)(52146003)(31696002)(2486003)(23676004)(67846002)(2870700001)(25786009)(11346002)(2616005)(446003)(956004)(52116002)(36756003)(4326008)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR07MB4923;H:[10.167.103.249];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTZQUjA3TUI0OTIzOzIzOnJGS09WeDJ6MlgwSFlrSUZLTlROSGJERlQ1?=
 =?utf-8?B?ZWdCOEN5Tm9wZngyOG44d21LTEMwNkF1ZUZTaFhXVUJnbDh3TlpUUndzUDFL?=
 =?utf-8?B?VEF6TDIxU05vZ0p1Zkc2MEpOck91NFVMWFhmQ2dNWGd1REo3bDdSazNETDVH?=
 =?utf-8?B?aVBIcHRURURoN2grM1ZHbkQ4RTBXakFYMyt5N2hZekJRWFBzT2oraTUyQjhI?=
 =?utf-8?B?UktvVVdTaDl2b2wxWDcrdnpDNGJRdjJUcmhkR0d3MUVGRk00MVFEMTU3TUt2?=
 =?utf-8?B?Q1hXUXozeDdFMW1OcjhnS2VmRmwwTWxVMFpWNXJwbkJ1bWhCemViL3QxUmF0?=
 =?utf-8?B?WVpadnRsb0FBcml2T29VSmxYZ0hTUmo5L2gvVnFKb2EwYnRpVFNnWUgvUEd4?=
 =?utf-8?B?ZlJKZEx3UExaTzVoR1kxWHlKbVViWnRhSVFaQmMxSTJoTVpkck4xNVVwUmli?=
 =?utf-8?B?cEN6S3dvMDJWeDh2N2RmWWtNRjdoajZ2Nm9jK1FaY3lObTRmdzA0RHRFVUgw?=
 =?utf-8?B?Tld3dkNpZFd3M1hUa1NwamxrYkFDZXFFZ2plcVVBVFh3d0xHZUl1MU4vbDBq?=
 =?utf-8?B?TmRDZ2FkWlhjdmV3VVR0Rkc1czRYdmFSRFlIc0dkbURqYmxNMzAwcTcrZmJN?=
 =?utf-8?B?ZjBLWW5EankreksrM0g0NUREbW9aR045SDdqbmZ3RmlKdFJKekJwZHI4R2gy?=
 =?utf-8?B?MkxBMSsxcmJqTitZcWYrV0RTT0w3R3FLZzlBbTJzZ2hIOVZrT3h3SXdtSGFR?=
 =?utf-8?B?byt5WWVxMjNjMTRDRS9Ma09UOGpQVkJRMVZ4ck5RcXBBdXRKOFFXd3FZRm54?=
 =?utf-8?B?KzVESGJWNFRFeXNNRWhxSy8yL1U5ZXVKU09sUnJEQnFzUlM4dG5pb0Z0UnpE?=
 =?utf-8?B?aUptZ0ZrOFlTbFp5UjkwNFN2Y3RvTmhGOFpPWUxaY0tPU0JhOFRNMlRVNUFF?=
 =?utf-8?B?bWZ4aEYwQVNVUjZkZGxUTTZXK05rSlpqRlQxakZVVnl5QWlUZE4xM3dFYU9O?=
 =?utf-8?B?a3JlR21GWWI2RFpuTWxXL1BzenVWdzFLNjVQb004ZHZkQ01WdTVRb2M2ZVdZ?=
 =?utf-8?B?RkozRVV1ZTd0Vlc4SmZZY3pJMzhWRHZuRlpib0RXZHRTM203SjJEYTJXdHpP?=
 =?utf-8?B?RnJpVVFHNHdadFRXQW00alFpSXlBZ0xqK2JpVktaQ0pPMy9wQUUwTUJWbGVV?=
 =?utf-8?B?cElidW1WZFZQUjE4Q2JDeXlFdkNETSszUVFuajlUakRZL094cmlnUjIxQUNP?=
 =?utf-8?B?b3NGd21BN0EwdkpscDJrZXMzVlFLVE9TYUdYVWFHK1hPMzNmSFo0blI3K2Vt?=
 =?utf-8?B?eUE2TithdE9SS2twMkp6SUZYbHlCVmpwMFVZZFEwMmxwbllKUi9jb1V0L0FQ?=
 =?utf-8?B?cWVRRU0wWVVINndKTmZVRWZFVzlVN2EvM2FMTU13b3RWSnNSSWlkcmJlWVNu?=
 =?utf-8?B?c0l2Qm5FcTZhS2RNOVY4WXhHbDVuOVM5bTRnTEJ2S05xd3FjeE9EY0hHaDVU?=
 =?utf-8?B?UEplTlpENnh3ZkxVV0VERGJGdGtkTUZpVFFsQ2JhSUFQYjJFNWlSa1RyZC9V?=
 =?utf-8?B?TmhzVE5lcWx4VXV5VmgwUitmb01uRDBjT0J0YlBYaDByRm1pTzAveFhJeE1w?=
 =?utf-8?B?UC9OeFptVmJzdGNHYzJrN1pTZHVBazl5clJpTDFhR2JZazRLc0toS0FZcmpO?=
 =?utf-8?B?c3BvbmF1OGc4UnR4eXpWRHowcWVGdGY2aEhKckRZa3M2MTZqcTlXejBzNXoy?=
 =?utf-8?B?UW9QZjE2Skc2Z0tOMFBXTUJud0Vtb29HTmNuMG03U2M1WG5OOXRVNWZCeHNY?=
 =?utf-8?B?UUl2bDQ4dW0wazR5SVl6L2ljTXNxNHFIYjh0emxBSEE1QUZJVGllSTBmSWpP?=
 =?utf-8?B?bnBNOTlQY0xtZWxmY3lWdzBQeHIxeGR2RUwzblBIQXlLU3ZYa1BueUpuT0I5?=
 =?utf-8?B?M0dxcGIyYzFHQWFUUFdFV05FZVZ5RU95NmNHWmtQcmNmWFZPcm1jS3NqbkM3?=
 =?utf-8?B?UFpIMEh6dmVxRE9IYWdyS0ttNDd0aUtCTG5VSmpQMHpHNWtucG41SUp3YVpt?=
 =?utf-8?Q?4Bb3gl1b52ZOtSbXIrO0Q23jj?=
X-Microsoft-Antispam-Message-Info: aoPBaVLKgs6kvgDiEVV9i5MieBCtrYX/xx3YpLsNjSFWCY3x5NEJgAec0oJrM0UttA8rbymBxZ2e5hoMJt6NmR82OKYfKyxs8drhpV2HKVecTBqCBIls2TUYtcItDwhhgxXf/Bz4hvMs5F7Ig/eNuQug9MJwIMdYlJwEh6/gcCxoOv033QaMlKGO6/LZDtCcPH0aIHxAZhqenpbr0xdOJfFeHaWeCjC17CIM1Ma/3DrGjYP8E2zLRIfhRlIC3Jz20X9KwdGc8mM1JR2KY57Zm3kYmsCmxovzL900pg4t2FkFX4v1yI+aP29KZhH38H9VIZJRuHJkAs9I2A7LMnECj1kj1V1m/bj4MVC3XBia4Ts=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4923;6:clrjvw8tfJm5ZlThuZpT11WpDbv+E4Q6/975A7jcYe9oUd0B7q0piIhBm4DWJQ/QRM/N7nWSnSqwQvXvcXFcGSjFf+EHmvoaFBKv6gRjU3Mh2P4blRyB+O+j2zdSOD3BUpi6Q/3l1dz49sFJvArDoJqSgTRK+8XG01W8LW0tTWCUCeceiPZpAUK0IaT96akYO7LBguG6VQlBaxM7W9x4ceqWabhAfLksbkFt3Gy7EHRwi+M97Mfo2kKlKYXCtUzwy8i7kgf+9Z7kfdsOoNnyuZ77jkJY7D5KFihmRLSKaH8Ah+DleYk4upK7Sm0UwYOuqufLyD8e3SoM7vOI/2ZpfA66rG5aL356kmJb/ON1z8lv0sWr4TG/yA7JgPoBHmJkldDHTt2NKdXzTcH0GjcSfn4yZJNnnBILt4ShYor2792cALZJhSN2l+aCypnLXYfdzsaoBJjmKoIFla93olmaig==;5:7WrrQlEjPTfJ9pCmOYUWidm4mdPOfOZEUPJihtfYWX3QB4uA0AIVJGzcZjwnu8fI3HA+/nVocgr/EYQMDF7m+EgqXKlOEM/gnmowtBL1CKsD/cEh5xzbjrHEnLSR+TxG+i58+Nw7s6mkIKrl4d4gprXOVcDGAwcpCQDLhz7uFgo=;7:NtujcUFQWpqT0d5q1keR04ympdTPIdXaVmYKhLCUhZ79vVrUyxGZk6YmDtEGNkj7EWEIzbx6bRDaIyQoqp+93XCnz05oa3BmkMnHqf91h3MylWaipRP31Z11e9jBo3LcXDqWvs1HBHC7gsWfPVb02ckIpGoE2MWQMFqsNo7aw/FolG4REKFG6o7y+Jmpvvbgwkgy2opnY8JiRYdB3vrcPY4DGPRKHr0ZT5fGB652jhWU+2GosllLgF5yBZtAuOrt
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2018 05:55:12.3003 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e394248d-a4c5-4534-0cd1-08d60be1a89b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB4923
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Corey,


On 08/24/2018 06:38 PM, Corey Minyard wrote:
> 
> On 08/24/2018 06:10 AM, George Cherian wrote:
>> Dont set ssif_info->intf to NULL before ipmi_unresgiter_smi.
>> shutdown_ssif will anyways free ssif_info.
> 
> This is correct, but it goes a little deeper.  I just sent out a
> patch yesterday that included this.

Yes I saw the patch now, 
https://sourceforge.net/p/openipmi/mailman/message/36397896/
I will test and update in that thread.

> 
> Thanks,
> 
> -corey
> 
>> Following crash is obsearved if ssif_info->intf is set to NULL
>> before ipmi_unregister_smi.
>>
>>   CPU: 119 PID: 7317 Comm: kssif000e Not tainted 4.18.0+ #80
>>   Hardware name: Cavium Inc. Saber/Saber, BIOS Cavium reference 
>> firmware version 7.0 08/04/2018
>>   pstate: 20400009 (nzCv daif +PAN -UAO)
>>   pc : ipmi_smi_msg_received+0x44/0x3bc [ipmi_msghandler]
>>   lr : deliver_recv_msg+0x30/0x5c [ipmi_ssif]
>>   sp : ffff000037a0fd20
>>   x29: ffff000037a0fd20 x28: 0000000000000000
>>   x27: ffff0000047e08f0 x26: ffff800ed9375800
>>   x25: ffff000037a0fe00 x24: ffff000009073000
>>   x23: 0000000000000013 x22: 0000000000000000
>>   x21: 0000000000007000 x20: ffff800adce18400
>>   x19: 0000000000000000 x18: ffff00003742fd38
>>   x17: ffff0000089960f0 x16: 000000000000000e
>>   x15: 0000000000000007 x14: 0000000000000000
>>   x13: 0000000000000000 x12: 0000000000000033
>>   x11: 0000000000000381 x10: 0000000000000ba0
>>   x9 : 0000000000000000 x8 : ffff800ac001fc00
>>   x7 : ffff7fe003b4d800 x6 : ffff800adce1854b
>>   x5 : 0000000000000014 x4 : 0000000000000004
>>   x3 : 0000000000000000 x2 : 0000000000000002
>>   x1 : 567cb12f8b916b00 x0 : 0000000000000002
>>   Process kssif000e (pid: 7317, stack limit = 0x0000000041077d8a)
>>   Call trace:
>>    ipmi_smi_msg_received+0x44/0x3bc [ipmi_msghandler]
>>    deliver_recv_msg+0x30/0x5c [ipmi_ssif]
>>    msg_done_handler+0x2f0/0x66c [ipmi_ssif]
>>    ipmi_ssif_thread+0x108/0x124 [ipmi_ssif]
>>    kthread+0x108/0x134
>>    ret_from_fork+0x10/0x18
>>   Code: b9402280 91401e75 f90037a1 7100041f (b945bab6)
>>   ---[ end trace fb7d748bc7b17490 ]---
>>   Kernel panic - not syncing: Fatal exception
>>   SMP: stopping secondary CPUs
>>   Kernel Offset: disabled
>>   CPU features: 0x23800c38
>>   Memory Limit: none
>>   ---[ end Kernel panic - not syncing: Fatal exception ]---
>>
>> Signed-off-by: George Cherian <george.cherian@cavium.com>
>> ---
>>   drivers/char/ipmi/ipmi_ssif.c | 5 +----
>>   1 file changed, 1 insertion(+), 4 deletions(-)
>>
>> diff --git a/drivers/char/ipmi/ipmi_ssif.c 
>> b/drivers/char/ipmi/ipmi_ssif.c
>> index ccdf6b1..1490636 100644
>> --- a/drivers/char/ipmi/ipmi_ssif.c
>> +++ b/drivers/char/ipmi/ipmi_ssif.c
>> @@ -1226,7 +1226,6 @@ static void shutdown_ssif(void *send_info)
>>   static int ssif_remove(struct i2c_client *client)
>>   {
>>       struct ssif_info *ssif_info = i2c_get_clientdata(client);
>> -     struct ipmi_smi *intf;
>>       struct ssif_addr_info *addr_info;
>>
>>       if (!ssif_info)
>> @@ -1236,9 +1235,7 @@ static int ssif_remove(struct i2c_client *client)
>>        * After this point, we won't deliver anything asychronously
>>        * to the message handler.  We can unregister ourself.
>>        */
>> -     intf = ssif_info->intf;
>> -     ssif_info->intf = NULL;
>> -     ipmi_unregister_smi(intf);
>> +     ipmi_unregister_smi(ssif_info->intf);
>>
>>       list_for_each_entry(addr_info, &ssif_infos, link) {
>>               if (addr_info->client == client) {
> 
> 
