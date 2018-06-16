Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD40C5CFC0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 17:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F6A420864
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 17:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Q1bXYCOV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="cq2aB5aO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F6A420864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932710AbeFPRVj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 13:21:39 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:41086 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752814AbeFPRVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 13:21:37 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5GHHRKB027148;
        Sat, 16 Jun 2018 10:20:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=facebook;
 bh=v6KY/HKYw2olasscIeCNWdDlY0/JDbIWGJZChuCvD+I=;
 b=Q1bXYCOVtDM28pz8g/9GLmbfzboslzLMbH/7H2vd55Y3nOq/87yO0lHcJXpD0sVBgEDw
 /WJSGiinVfiVyYRavDhP8UkSkSwJEfVWUAfhtDAO8fTQuArZzWRIwBT1x6JOkmWcIUzX
 0BFLljLsoTbH2BchyB943bqh5uBnCdEINFg= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2jn1us8ern-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Sat, 16 Jun 2018 10:20:54 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.28) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Sat, 16 Jun 2018 13:20:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v6KY/HKYw2olasscIeCNWdDlY0/JDbIWGJZChuCvD+I=;
 b=cq2aB5aO3qCWqGoePaD9kEAX/p1kBmfD+K4/zOcinYjXXGzzvtOEnOVrwPhOOcLIBbThPuvak+agyIDMDZBg8cAlNVARMancUFTjPHMjt/bHRqzRh0b+BmBKs9kj9K7bu+J1K1PCQ1db7wwQPid2OgmkAi9vrH6FPtdoXc3JSO0=
Received: from macbook-pro-52.dhcp.thefacebook.com (2620:10d:c090:180::1:58f6)
 by CY1PR15MB0078.namprd15.prod.outlook.com (2a01:111:e400:5849::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.19; Sat, 16 Jun
 2018 17:20:46 +0000
Subject: Re: perf tools: LIBCLANGLLVM=1 build broken with llvm 7/clang 6
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
CC:     Jiri Olsa <jolsa@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
References: <20180616122608.GM30043@kernel.org>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <91a76633-54e4-984d-cb68-ca0445146b15@fb.com>
Date:   Sat, 16 Jun 2018 10:20:21 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180616122608.GM30043@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2620:10d:c090:180::1:58f6]
X-ClientProxiedBy: MWHPR04CA0098.namprd04.prod.outlook.com
 (2603:10b6:301:3a::39) To CY1PR15MB0078.namprd15.prod.outlook.com
 (2a01:111:e400:5849::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92067ff3-053c-4bae-39c3-08d5d3ad8000
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:CY1PR15MB0078;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0078;3:OV2qNX7OS9A1g6bTPH5yPvrYWTBMU8G27KaYB+p0mFL9dOKtzBKcfGFPM9bpvxuQL1UyQ68mxZGkDmeJe06rRpqsr08pVxcDFCDqDWj/Lfd5fvPbDLKgBytRHoYflWloOD5rAWP/4pfjHguR405Jso7uUMFpXMKVEr0mO34ZDk99DL/KHinFEdDf5+RhqteccZu8cyBFVK8fFRkgpzeGEywULRMfvQUo0WhH4xpYXxi1yGbkvTae7Wfy895YdhZR;25:EK7xrzrGYwskkQeZhwPmscCp7rGY1Giz1XjbyS69Yp/7zCnj3X6EexmXFLOC8GAkYJglr4oIcLTWdAk1fMKRARAwrSA0K6I6GivdBQcOtlzrzZLIyrwzA8uHWBiF6uxqhdxzP4OatrGI11QqJp9LudrG4hlBgDRy0m6G9bZLGZhJUudP1DzsmYHc/JxbzIhjJt4cM5T8ULrt5P2Hs5KD/jWDr42qkz+6v+1m4Li0UMuvlr7IYbS4P1wLavAlOcu8JoExW0F4QKsqm7UkugcFNmyt5L2PSrKceIoXzTP4nlW2kXPV2VFYhogWRrqe3y7BT3AdxsNhJNcJjte6ThrM3Q==;31:pmq8Qpr5Es8aINeXILa+PSa9ywuxwxTKJkjMh/IFrY3OPC6RpYoUuP6FkriAp3kHXxycUr2HVA/uvZJNTIpTb2BP1UxM2JpiySzeWg/WQinSudbzjST1h4GqhszKpWny5yfOFx1HVBIlzxC6sWkEr27nc3EqUJ39BnreqeyFfP0jmlAhyaibIdhvIPB+2jfgFGgImffGfjRT3jZj5owpK/cHTPnBX2g1QGQD4hjWA7c=
X-MS-TrafficTypeDiagnostic: CY1PR15MB0078:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0078;20:Ic/AJKwbqGbeRlPR2KDoBYGWYyxOZxfSFndgRvI8sFfac4mAa9/OgVmWJzpPGzUd32dIxlNG8PhkQqe3kP473R2nezFTxSdnkGHQLE6/o5ZOHH+rIbINEw/F3psHA8C5axPGwfWOeuKgWq9pKzIla0suY6WfJRwK/ZxgC0h4GhrB1MtGbPMKeWhPVhwxpIJrXgYHPJk/t93jgjswPTaSACaKHm1lVcYpM0t15xVBa4UGC4D0I4ve63p9k18S+jbkP/Zfkxw4teNB+SfS0+PcMUS1UoPNEgnd9GuBQzb7i3EyEDPTnGvLvirytA051yNc1B2JbNQCk9eYzM4XKyXgvJ/BOGUdigeZHIFhVRoRP9j8hZgpCpWorrPXY0b1jpE/qAVkxSQRwnShPnTSc2PYED+EBz6DxHOiv6ssYV9M+pEKLjQRz00tj6yKiN5EujUGqe762Lb6SlF8CFhoPioztxaTLzrramKTSe3OGknpqBjYOHrHFqJSPwErcrwbhyzu;4:liri7oNtsOUivJN2/cRuquWOZmayZmqvTqKbFANhC4ie8EHog0YOrkqYPbIluq+eAZYuKpS5PJD8C5krJnNjGyJb6oAEDlGb/SENy83FrSjNytFpKtYqIpHjMWvvx0lSYozsHuIPPSVnUV9r9kd1vx2pTJzD6sQ2JmYS2lQNnaQO0xs/28RzE9qke4ovE0bJ58rfy4jbiapQIpJiAdCdTtY8ZhOSZkE1TXQ6A0h8qFfzhyctnGxJaXzE9w6vnkllFTrbOQvCBJce8otKcv4xRw==
X-Microsoft-Antispam-PRVS: <CY1PR15MB00789A34DC2F766D7DA1FC3ED3730@CY1PR15MB0078.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:CY1PR15MB0078;BCL:0;PCL:0;RULEID:;SRVR:CY1PR15MB0078;
X-Forefront-PRVS: 0705EB1700
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(366004)(346002)(376002)(39860400002)(39380400002)(199004)(189003)(65956001)(65806001)(110136005)(58126008)(36756003)(23676004)(2486003)(52146003)(52396003)(76176011)(6116002)(31696002)(47776003)(53936002)(86362001)(386003)(52116002)(6506007)(53546011)(54906003)(6666003)(6512007)(305945005)(8676002)(2616005)(106356001)(16526019)(186003)(25786009)(6246003)(46003)(478600001)(2870700001)(7736002)(105586002)(64126003)(486006)(446003)(316002)(11346002)(8936002)(67846002)(68736007)(229853002)(65826007)(97736004)(6486002)(5660300001)(2906002)(81156014)(81166006)(31686004)(50466002)(4326008)(476003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR15MB0078;H:macbook-pro-52.dhcp.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTFQUjE1TUIwMDc4OzIzOk9nOFZxSmo2OFArRklKK0dFQjNUcndnU3k3?=
 =?utf-8?B?NnFEeXB5S3dVZUl0OHc2VGVROFdibmZCekp2cmo1LzFOa0FONzVzQWpZbWZW?=
 =?utf-8?B?RExUM1JVZE9KSURnN0hYbGorQTZQVHdodU8yYm41dUhaVGE0cGdvbVRraTBI?=
 =?utf-8?B?blJmOVJINkNzbHdIdkJLYVdiejlPUGVSSDc5bUt2RWJjYlZjZ1N0RGtHV2x5?=
 =?utf-8?B?d3VDcUtNUGt1dEpqa3VIbjBmZnMyS3BONUppWVZrb0M2a2RLanBQdEZoSWQr?=
 =?utf-8?B?WmhEb2t1ditXVS9qZFJZU1pDdzgySlMzSzJFbnVQdkV1aEUvNXBaTzc0QVZ5?=
 =?utf-8?B?U1FGN1Nkd1czYnpJdzNUc2p1Z1dvTDN3OSs2dmFnQllGckF0b2cyanJLVzhJ?=
 =?utf-8?B?RmtlNm0razZRNS9XVUNBdFJ4OE1sSmxrdTZSSjlONjdLZWNSR3k4REkraHFs?=
 =?utf-8?B?bWVMcW03WmpGdWcvQU50ZjBMbmRTekFHRlI1K0F5SGtxWmFTRWcwUjZOenVy?=
 =?utf-8?B?eWgxc3hENHZ2bExJVS82RGtLZk8xYnBlRVd3OGxTUmxzQU9IQXRRNVBiOHhr?=
 =?utf-8?B?ZlQzY0ZibWc4enBSaXlmeE1LRElGNVEvWFVwcW9scGdNRXR2YjZYNHhxb1hT?=
 =?utf-8?B?elZ3Zm1RcWlkU1BUMVFXNmJYZnpySmlTa2gvOS9tM3dseVlsQzl4TTdRb1Fw?=
 =?utf-8?B?Z1JaQTFHY1c0Uk1SSFVQdjZvMzBHM1VhTFdnakdHM0dtamlEVEE4SVlObitx?=
 =?utf-8?B?c0Z5V29rY21wWlBZRFZEQ2JaVjdzUzY2ZG0zbnpOa0xtSk1OWFFUbVdVeHhD?=
 =?utf-8?B?OUhnWnFpSUlMVXZYRGM3amJDQzFmSzlsUUFlblY3SE8zSlpwRUt2Q0NCQ2hr?=
 =?utf-8?B?MUEyeE82dlgwOWJoZW5QU3VxRndoUUx2eERzbnlXbU5qTjFuQnpCa0VhWmVH?=
 =?utf-8?B?WWZkUWtZcTM4OTlOOCtLWmhDRFdzLytlc2tKcno3Zk5MM0hIS1VHUGk1dkVJ?=
 =?utf-8?B?b0VhV0RUOGM5eGh1bHdVUTJIRHp1TEpDcHUvMnNIdHg4Y0tNUFFMM1dVMGY5?=
 =?utf-8?B?TnNYVzhKdWNucDNtK1UwR2FHMnJrdmg2MG5yTEJORUxmRlRFcVFiUUhNMU5V?=
 =?utf-8?B?R056aklHWDhXWlEzc0o1T3o2d0xiSEhhalQ4RDhIcURLdHE5Y0NJY2tpQk1B?=
 =?utf-8?B?ODNzVUVwc3RtaWhGa2JwREJHQWluUTE0ZnpsQ1ZvY2s4dHdDdTFsR21sdTR0?=
 =?utf-8?B?a3RtTVgrci82UWMySDliczRzaUZhVGI1NUZHYWliSERXK0lSK3hyTEJwdkJh?=
 =?utf-8?B?RUVsbkpWU3l4c3VGSm1SbGtseGZUTmE5Y3M4anhMYkdBclFRMHduVURFRmFs?=
 =?utf-8?B?aHdGMkY0clUxV2NVWlVtbm9nT2FEcVp5N0hVd3llMUN5UGxGSmtJc3owZE43?=
 =?utf-8?B?cENPQXoxYzFOOU9McVQ5SThvZlRnWVIyZmpTVk1OZE1QVStaM3BKbFowb05a?=
 =?utf-8?B?OERVU3dmUzVsd1VKdm5BdXgwdlovRGpYbTIrUEU5NUZ0WDZsOXpYSGM3VjdL?=
 =?utf-8?B?bE5iRGVSKzZBOFd4eHJFL0Z5OTNDZElwV1o1Y0pIZGlYMUVPTFR4Qm9PVlNB?=
 =?utf-8?B?WUt3QnA3dzFPbVRjQ3ZXMHdNekh6SzUrd3lxMEljZmZDSlRQZWI0Z1hDZFV4?=
 =?utf-8?B?QWJsU01CdlZhaHplSmFOemJGQ3JIOEpreXJmRDdoOWFIQkovbUwrSWJGTGVj?=
 =?utf-8?B?T3UwOFBxYU5RNlV2ZFdrejFOREtFaUZEY3V2Wjl4TjdnaEsvQlRtZ0dCZUpT?=
 =?utf-8?B?K2dBK3dVcWJWNG9MS2h6Rmo2c09ic09RRktaZFJxbTB5dGlGZ3dWMHJsa0xv?=
 =?utf-8?B?bEZUNGJibjlXV3FKQThXT2NGSWY4K1R2TXE5U3FmQk9LcitGT2t5WkZkLzNm?=
 =?utf-8?B?K1VrSDcyQzdRPT0=?=
X-Microsoft-Antispam-Message-Info: J569u16R/T2cI/71nslQt8L/LGvuZXxsuUwnGSi/d7TwARD3OegW49XgY//EvYGgS8mOFEbdAn7lhW6jbiKPXZFDQJZTG65rO2lZNhdco/SM3HLxyDklgWt3Ngw9usce58haAhL+3icraf6CLxF5bOvLeGXpZMFMl1KWY7NWAA2H2dDwWPoykomB5MOQwExv
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0078;6:U93lNtK7NnRxGK0AOJah4MImFypOW1OxWiiFjpyY+t4vugwgitiYkeRC7HXjf8L46BR4uqIiB9+KyOAT+kh9XKEa6OrXp5dotzuVdUX+B2Dry71sj3BV5nPL3ZM6MEgoxK1QHZLR/Z7vPy26T4wQGnNPVdfGmynmADkzmaiY7KmBZ6g+B5m9BOQv8nLYM0fSgZ+gwZm7kp+NgKXxqARI953XVCl5DC48lFaIjnSDVjdVgJeMuYha8FuWwiOx6HV+icRbb5xrOHN7ZVsI9mU/Lc/eMnMP+ROVdb31kU3wS7TC3SBzUML9WP/5Zghgub2t9YU1oDYF/zt/fLN7NQbgNMB/QhCmaNB3UZPrhkYaMaGK3Euq5LnPFxotIc7aNnmFi+6RP3zCEcB5VvyAJSm6sFXBxFsCjjo/vSGYjbK2y+LdLTwNu9SNfRJRRe3encLONNcOaO2mICNf2YRl79oQYA==;5:ADMI7W9n/CvjMO/UEW712q0m9tSMP1ZRot0D/gnF3YtPy9WKUjqlyez0mHNjRy75nEu0etIMYSZBklMBK77aooOW1tcMx/t2jnMlWusQmx7cvUEbw1OqCUh+ees1efoByfnNytvWLXs4Jz6ap3SLip4hmV48X7KsIUrR/Ho+LxM=;24:H0KXoKbCWkU0eWcZZI4xRvJGz/3AbpKDRmlvxlu6F2trifW3jeDodj3xnihiLbylWF6LFkKihYdHrWVH/xrBLx4YE+a1fQyE18lDt5nOmAU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0078;7:7gfDeF1O4vUf4l0ZMb+VVxrlXpwH5VvL0oz9NW850Knxw7+3Flki4GIqsns4gbV/or0elOfQzJ4YIMwsg0KbeVbUwEFQrccsG8IOuyXMj0ornz7hE9OnvyW+Tiw9mxVC+ymysyu3e2bWEyhA8G+0MomM9eO1bpDztn52i73RRjP/WflskWYQF/PBjd8qbUUKi3BKVcfyBpqc6dFrGrxPruLyTPLgYVG6nFEZqYOhsCrixmYx1J8nM1Nc/V/Sa+mg;20:aWCdc4syfwhyqaw/5xofuYGz6+1F2nFo/coCvSx/VExsS+YBdwjQN6UC2JdIMgP9TSoqPIMsAGC/LA85alb/HZ//89YK0Hx6ZHNwA7is443R+sXMDHFa6L9IHDqdU+m3BG3tkNK1FxRoeg2SJTJy84UnDnTpj1h6yp8OVrn/Em0=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2018 17:20:46.1285 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92067ff3-053c-4bae-39c3-08d5d3ad8000
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR15MB0078
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-16_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/16/18 5:26 AM, Arnaldo Carvalho de Melo wrote:
> Hi Wang, Yogong,
> 
> 	While reviewing the BTF patches for pahole, I updated llvm/clang
> to HEAD and then building perf with clang embedded I noticed this, will
> investigate, posting here to document the regression, maybe this is
> something you came across in other scenario:
> 
>   $ make LIBCLANGLLVM=1 -C tools/perf/
>   <SNIP>
>    CC       /tmp/tmp.t53Qo38zci/tests/kmod-path.o
> util/c++/clang.cpp: In function ‘std::unique_ptr<llvm::SmallVectorImpl<char> > perf::getBPFObjectFromModule(llvm::Module*)’:
> util/c++/clang.cpp:150:43: error: no matching function for call to ‘llvm::TargetMachine::addPassesToEmitFile(llvm::legacy::PassManager&, llvm::raw_svector_ostream&, llvm::TargetMachine::CodeGenFileType)’
>               TargetMachine::CGFT_ObjectFile)) {
>                                             ^
> In file included from util/c++/clang.cpp:25:0:
> /usr/local/include/llvm/Target/TargetMachine.h:254:16: note: candidate: virtual bool llvm::TargetMachine::addPassesToEmitFile(llvm::legacy::PassManagerBase&, llvm::raw_pwrite_stream&, llvm::raw_pwrite_stream*, llvm::TargetMachine::CodeGenFileType, bool, llvm::MachineModuleInfo*)
>     virtual bool addPassesToEmitFile(PassManagerBase &, raw_pwrite_stream &,
>                  ^~~~~~~~~~~~~~~~~~~
> /usr/local/include/llvm/Target/TargetMachine.h:254:16: note:   candidate expects 6 arguments, 3 provided
> mv: cannot stat '/tmp/tmp.t53Qo38zci/util/c++/.clang.o.tmp': No such file or directory
> make[7]: *** [/home/acme/git/perf/tools/build/Makefile.build:101: /tmp/tmp.t53Qo38zci/util/c++/clang.o] Error 1
> make[6]: *** [/home/acme/git/perf/tools/build/Makefile.build:139: c++] Error 2
> make[5]: *** [/home/acme/git/perf/tools/build/Makefile.build:139: util] Error 2
> make[5]: *** Waiting for unfinished jobs....
>    CC       /tmp/tmp.t53Qo38zci/tests/thread-map.o

There is an interface change in llvm 7.0 (trunk) for function 
llvm::TargetMachine::addPassesToEmitFile. The following patch
should fix the problem.

-bash-4.2$ git diff
diff --git a/tools/perf/util/c++/clang.cpp b/tools/perf/util/c++/clang.cpp
index bf31cea..11dee58 100644
--- a/tools/perf/util/c++/clang.cpp
+++ b/tools/perf/util/c++/clang.cpp
@@ -146,8 +146,15 @@ getBPFObjectFromModule(llvm::Module *Module)
         raw_svector_ostream ostream(*Buffer);

         legacy::PassManager PM;
-       if (TargetMachine->addPassesToEmitFile(PM, ostream,
- 
TargetMachine::CGFT_ObjectFile)) {
+       bool NotAdded;
+#if CLANG_VERSION_MAJOR < 7
+       NotAdded = TargetMachine->addPassesToEmitFile(PM, ostream,
+ 
TargetMachine::CGFT_ObjectFile);
+#else
+       NotAdded = TargetMachine->addPassesToEmitFile(PM, ostream, nullptr,
+ 
TargetMachine::CGFT_ObjectFile);
+#endif
+       if (!NotAdded) {
                 llvm::errs() << "TargetMachine can't emit a file of 
this type\n";
                 return 
std::unique_ptr<llvm::SmallVectorImpl<char>>(nullptr);;
         }
-bash-4.2$

Will submit a formal patch soon.

> 
> - Arnaldo
> 
