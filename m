Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 9B404C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 13:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3937A20020
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 13:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="mHKqiSX8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3937A20020
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755337AbeFNNnX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 09:43:23 -0400
Received: from mail-by2nam01on0064.outbound.protection.outlook.com ([104.47.34.64]:3680
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755252AbeFNNnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 09:43:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RI5t7GwC0w3jDK6doYVPGH00OrS+wD6ADIVzE+wy0FQ=;
 b=mHKqiSX8+AYyYI3k0ewUaRcJjhKKRXguL3xjk/Vuy4xA+sUI1U3sUZmXH0JoZlSvxX90PWJ/T1cD/2nWn0AWrmOAMfwYJaa8W+2QYlRR/b8szqS/ocWw6oqoUPoeqz0nFXEc4zaGZyACdow8XF6W7qlfPm1fEvHhpS8MVDf1Hf8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=thellstrom@vmware.com; 
Received: from localhost.localdomain (155.4.205.56) by
 BN7PR05MB4578.namprd05.prod.outlook.com (2603:10b6:406:f2::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.6; Thu, 14 Jun 2018 13:43:10 +0000
Subject: Re: [PATCH v2 1/2] locking: Implement an algorithm choice for
 Wound-Wait mutexes
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org
References: <20180614072922.8114-1-thellstrom@vmware.com>
 <20180614072922.8114-2-thellstrom@vmware.com>
 <20180614113604.GZ12198@hirez.programming.kicks-ass.net>
 <7eb10c22-57b3-1472-0a77-7f787f612217@vmware.com>
 <20180614132905.GA7841@bombadil.infradead.org>
From:   Thomas Hellstrom <thellstrom@vmware.com>
Message-ID: <425f4d5b-d414-de46-f388-55f1e6821ba6@vmware.com>
Date:   Thu, 14 Jun 2018 15:43:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180614132905.GA7841@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [155.4.205.56]
X-ClientProxiedBy: CO2PR07CA0043.namprd07.prod.outlook.com (2603:10b6:100::11)
 To BN7PR05MB4578.namprd05.prod.outlook.com (2603:10b6:406:f2::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6fed7506-b41b-4fd5-bb2c-08d5d1fcc887
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN7PR05MB4578;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR05MB4578;3:f+qwrBVfCFU3vN8otiHVXBoAjzW3f4t92Cyfl4CCGcI3WhB4PDQAp81a0IyZ/yQTRmWCbBv2U21UoSjATOkL3K9uVFNcqY/49hXIOecpT7GqARn8mqe2jNa0HSACqF4iFG7Jo1pX2SfYjjVLUNtdVqpDsPOrqabFRYfpp6TGMawmtsS+IkqGFNJ/Pk8oBPVHH9/PRTDjfS7h+6WizdQeShp9WxAeno9Y0VowNzRAAp+zQtwsu9/AWRGOGgwnY3tO;25:pzNt+6PCNhmAqrzKyWquIaqozoje1Ly+aeYs879p4HobjjLaOu5rtaSBAw6HYjUWJzAnSWx5Cfa/bb0kYmSS/vdaaId8IvSy/nQ2h7RueQLg295bp/0uH4NDMs7ZWCzydVihuGb3lEWwXVOPnxnmlDamdKhF5SA3GjAw2y2J9Wg0xGAdngWBDAFCnJKYDpy2oQFQhvo2Yp2C3sg9Hb5W7e+bFO9B3LBSUBejdJuBX3PzYkeu75xZ72cEIQJ/1GPmKVz7Dfq5eMzD8FG/h13lBHxCzzHuLPjVt+nJUoEQvyCINzp+B2WZnaJTFZPhurnC+mgNcsvE+FGXi2RnOCGnlA==;31:GHNYvT4rTU/+FsYj/Wmgko4AAIEFwbBV4wqOBLtDHMHZqB6Fxdox34dRJDlZQa89xU1rmlvbEZO9merPdDBpwtoL71pz7H9qqQNXIa2lDAICQgfphu4XNM/LKn1gfyoRAaHjkphdnt5urCq30uK07rSWbmQJLsqjW0mt+WcBPSYIa4TYVvmf9O8gw5leuY5CL0gqlB4xi5mLR/M17nFcAyxRjiu5umd1r2gfgPT3KRU=
X-MS-TrafficTypeDiagnostic: BN7PR05MB4578:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR05MB4578;20:7ui9UuR3aaaDhDMt6I3rJY6Cg/BtPOCw5MLpzB91xruc6M38HThtM/xb/Om3aQeIlJvMYjSsjI+AIOgSg6vThyOW0/+qBHH27seWSf5OL3eKGE8rLjwDy34aVGbWxGDUemg/XqgPeJeXyBbQ/dlZMURkMeb7U7fYnhwKiivkfcTdrIoSG1VkG1pS4JraFlrXbOVwMPMcisdGDCsBZGa9KwiUs+8Gu9boodcNDfv33LsYGla3veq2KX+K+LUzBccQZ+H7DLElez2WmI2cmqUGjUuyfCW4q9vTvTY+ZVNFn7Gox2vsIhEdsz+jUqbY3TrHiN1aN8kF6Kedj3DRod2vJppMom+CyEVjADFYes88aSSEb/mk6b5YkobYvn0IWBD5Kn/Hy/Ipj5dE1o/HQJ9gDvp/iUj15SKSw+uqSvDLhjm67IxkgJ8JT0msdGqMqkDRORKjD/XBgXyWtjmvGC8dSKjvlmgB0M+zb/yFIOA9goL/DoqgquCrLSx75h4lzqQd;4:WfQTsXMGwSZxuihjIG346xlXBS5IyGVjaANhSqCBeiF0jYVWo/h4AEA1PMu+0MAbqz+MUEKZ1pzn85dlnXnTwPhwyRXxxergeoJstdjBMSBdqb93uPWpDh0nUE8pGyiihasmblZMibehveL+ONBB14MXeE/YgOQ6ytrGMU0BMOoQ8ObhlzSNDtfieMjytJ3lrHWFGcbhatAV5cqD8XtPA20ogiCnOsyN11bI31HP/wLhbuukowNLqukg+khlzkfXFxE5Av+SRyD1ML+3Zh+ARw==
X-Microsoft-Antispam-PRVS: <BN7PR05MB457826B355E4C52703583A3AA17D0@BN7PR05MB4578.namprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BN7PR05MB4578;BCL:0;PCL:0;RULEID:;SRVR:BN7PR05MB4578;
X-Forefront-PRVS: 0703B549E4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(366004)(39380400002)(39860400002)(346002)(376002)(396003)(189003)(199004)(186003)(54906003)(52146003)(23676004)(551934003)(47776003)(486006)(16526019)(58126008)(386003)(53546011)(59450400001)(6506007)(316002)(6916009)(26005)(65956001)(230700001)(65806001)(6666003)(64126003)(76176011)(52116002)(2486003)(93886005)(7416002)(67846002)(50466002)(3846002)(6116002)(68736007)(7736002)(36756003)(105586002)(97736004)(81156014)(81166006)(8936002)(4326008)(305945005)(6486002)(478600001)(6512007)(5660300001)(86362001)(2906002)(446003)(66066001)(11346002)(476003)(956004)(31696002)(106356001)(2616005)(65826007)(8676002)(25786009)(31686004)(6246003)(53936002)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR05MB4578;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjdQUjA1TUI0NTc4OzIzOi90K2RxUXVmSXpuUTVqR0ZuOXRGOUVCblB0?=
 =?utf-8?B?N3ZQalg5Zkk2emswWU5XZGlHcHZoNnJ6NmljeGFrd3JENFBBYU1tQVZlUmdH?=
 =?utf-8?B?SjBIRUJJT1lXODNDTy9NNTROMzFCdExKOXhsZUJMR2dQaGw4clY3UUpwajlI?=
 =?utf-8?B?MFdYd1ZWVVhZN2NvWTlhKzdsNUQ1eWphUzBPbmpwd05Db0pjc2preVFrZmtR?=
 =?utf-8?B?UkoxQkdvbUJLZUVtSmVDTXpHcGNBK3NQZlk0YkJLOENLRjhKQWJ5ZzhXZVl6?=
 =?utf-8?B?TkI2Q2lTZnAyT0Frd3FENW5CTTJMaHJjczRveDluUDNLSFU1MW11Z3Q5MXV6?=
 =?utf-8?B?dkhDY1ZVVE9GdnRtRXphN2tkdytvT2MvVDBNdWkrZVpMWWw1eG0rTW9JODBE?=
 =?utf-8?B?OStleXg1NER5ZlFFNmdRd3dBMHl2QzhUS1IyRlBTcHNpaUgrQnc2M2hpQUhG?=
 =?utf-8?B?b05zTFcvMWZ1YWplK1R2Z1RYNmF4Q0orZVBpdmlzMCtsR3ZqRlNJQmJTWkhx?=
 =?utf-8?B?Tkd6NldISGxXRTNoYm5sc0hiKzdmQVpJVTZSeWxDa2Y0M1gvTGtwMmVGYXRV?=
 =?utf-8?B?K2JOUXNka29mQmwzdHgvd0I0VEFBSWlMT2lJOGZ1OVRUU3N6Uk9RUzNTM20y?=
 =?utf-8?B?ajZ5UHpGenhxZFJJRE5FM2l1SEhaTDJaUDJMMXhCUnM4RnQ5eFQ1bkppVWEv?=
 =?utf-8?B?bnFaYlM4NWw4bWtyMFA0cGo2R1ZtZ1ZjOUZxOWF2M2tTWnN4aWJPME5TSTR6?=
 =?utf-8?B?Wmt2NmNHQjl5SUFub0U0V2hxSUlSZ2dtZHYyWEZmSE5kVU5lWVFNRnFiZ09F?=
 =?utf-8?B?QlJyc0o2b2YvQ2FLL0dFMFR2cWMyV2xHeno2VzVTSjBOTjAxNVhEaXRvZFJH?=
 =?utf-8?B?empQZHIwYlFWcThCQXNGMW90dTBKajg1T2c3dExrS3NpRHlBK2g4enNqVVhW?=
 =?utf-8?B?aUVFaUxBZmhEM24xYlVWekxwWUJBS0FIYUZQVnBDM0dGWVQrNENaOVFWN2JI?=
 =?utf-8?B?ZERLb1NkOHBRQ1YxdG5jQzNVaFI0SElZR1l3ZklFaGtMVHNZZWJOaTMyNkpp?=
 =?utf-8?B?MG0za1ZhSDczOERkaEMzcE94cngvcFRxQzRseGllRW1QeU1wTVJRWFpzZXFG?=
 =?utf-8?B?T0dobEw4K0NBWmhQSnkrZXRHdnowclRsakZFZEJlTkJRaEt2bXFzSHM1d3N5?=
 =?utf-8?B?ZVhWWXFlN1RzUWxiSXZ4WFl2d2RVdGJiM09EUmhjUHF6MUdJVFJlRkxkTHFO?=
 =?utf-8?B?b3ErVElKTUk4Y2RqTFlkY1NHbUIwbGV6R2xJOE1BdjlmaVNScDROY3BYM3Bj?=
 =?utf-8?B?UkU4ZWlOZGhyRUZHM3o0K2xoeVZNcWt5WGUvbE9kaTZoK0FwS2k0Y0pVckZG?=
 =?utf-8?B?QWRWYXBBOHhESVQ4cy82NXlxZkt1VEYvaFJnOC9MUitzUzAwUXkyd3RSV2ZB?=
 =?utf-8?B?ejloSVFnT3FZWHg5aGZWbmZwaGFzajlQUEo3b0I0aTNuMVpPSWJRNzlXUDR0?=
 =?utf-8?B?Z1k1RU9uOFczL1dEMlV3dHZpRjdiTmFYZ3ZpMWZibmMwUjNTU0N6aTdGMy82?=
 =?utf-8?B?OFo3bTczUXIvM2tmOCtzVHdBaTN1RlhDUTRRSTB4OGJ1dStUalUyNjB5UndC?=
 =?utf-8?B?WmRXUml5eFJYSWpnME1oWDN4eEZ5bFMyVGlyTkZVMWdkaUFDVnc1K3p3anpR?=
 =?utf-8?B?VVg0aEY0bGJFTUJ6TnBHUms5czhxRlRRUG9qTXYxYlJVUnEreWlOcHBvZm85?=
 =?utf-8?B?QmI0QjVlRVV5RXQxYWdWZEEzc1VQbDVYWVcvVHhTRkZBaVBRNHFEU0dRRUtB?=
 =?utf-8?B?YWZWWmhGYjRROEVOSUdLZDJsL24vbUl6NGJYdkw5SzB5NlZnZGNVN2V4Q3dj?=
 =?utf-8?B?WVBmVHVVWmNHQ3pWSUxiT0lrcG9UTnhzRVRTMzRXQldIMVVDdFlwamhIaTFK?=
 =?utf-8?B?cnFZTXZjVWdIVG5VenJkcCtXVHNVekRYWGVCNXhYQkRGeWJzYTBJRVFuemV5?=
 =?utf-8?B?SWNkUkZhUVdCR2I0cGUxSG5sMy9rL2ZyU29EOVdHdmVLWXJVYnBrTkVDVGR6?=
 =?utf-8?B?YTBndjgxMGhScGduVEw2YjZyZExpWi85dk5LSlp2YUIvU3NtUWh0YURGdnRQ?=
 =?utf-8?B?V3c9PQ==?=
X-Microsoft-Antispam-Message-Info: gVUsAkULAYx15WajsaILMpMPEXfA1QSDneJ8xl7yGBAyuZPDVxptHUOxY+BnSmsyoUUA3jocZb+A1CbJekZEmIIBtdyJ5MnBd4a1ClgSA+rJBcoqxXreFKhzt8JTJ1kmjkEMzl5SGqMp5FqWWtcLGj/B98pvGychB5Zed0bGSZ0hJTJM2GwX6q7j6VeFQmgs
X-Microsoft-Exchange-Diagnostics: 1;BN7PR05MB4578;6:NEY5jNt830aw0AjPsUeF8Q6PF5ZEckzkCl2WOSCTRcpgxphahstyTGidXQElSp7/83sVXCZSE2H8zkHKi17B2LDzYnsn5O8Sa9/ZSNQchbnKTSGMv8D5kvlH7Ei52BKD5KnM0QHBt1lurtdIS02uYSfObvBk4iszRF+PIQSMs6SW5nBvqsDZxZKZCeJAntHZhCie56A7mG3zKtWzMD+yiqPwqGYIaVf+sFng0KwXmRUZXe1F8EKY6fyKCpvhdujIlEyLDL8eMe9RCPs7jd4qpdLpLGNlmixeZQslKQV+418l0aqYPeqk6I8gN8GpkdCuGDNHZSzlb8lb0tA/spIrWzv/ZBcooHYBNlBX5fBNPf7CQo1KN/CgxIh0aDvYF0whOUPnxA1BCEAvtbz9qksEeeDgOF0tXfNW987GLKaAjSIydVVVvynCvLXvPzJpv/Ihrj9AhutsmvERB60dgux0tg==;5:X82okdJdSWHkiUHBA0He7QAsg8ySE6icjci08XPilQ7kI8WKnc7H/jSQa1dN4TJIybuGwyyxpgpD/NsTUBLI8qgwTOfDpwAO5Fr8YJJ8y34HdnP/kEfIix1g5VkUylxjwKFfC8lvvWxLT0JPn+xfYXq/pFKMR9eXOeLU3bP5DBU=;24:g++bJY2inXVc0n/y5KyU5WW2GJsHtm8YHATNmEpNjHef8x1qIU1Rxi3Ud/pOvcC9ioGInnNq1S/DKpMYUmIbsw8rsA2Op99hOmizGx0SIOg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN7PR05MB4578;7:YSS9iP8JQS06klpQY4x0EfBeTiBYltCt3I9CvmViCXI2Gw+cngeWQOUSvTMiz7UtoAJXMg5TH88rHBPBY0nx0R0FoDbrZzqX3r0gL9p+M142yDknLy2aVNXbkyUeV0+oT2hiP5vkKNTQz+oyq2/RmrkxgaGdLyhQ8IDvvWR/C9SpbnhgvJz5+80ZMTRMlC8O+b73Ue3B/a2eAVnm3FP/RqG9WsDNpoXpP+Tcd9yotC0M8vswU6VJion7BbwTfwJr;20:w2fNMLvVMaeU7yvmBc60tqUUmlNPs8lYVOG5Tzafdltxem7Q4T3GJ21C6jUj0iXTKzoZ28lzfrejxpuljFRj0iiEW073tnsvp60363cVyai6hkWSCPwb2PYCP5BLk0vm9kp3n1vSdsEFPC9nDHVhrJH8ADQzF0YvUvZ/VQqOI2Y=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2018 13:43:10.3490 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fed7506-b41b-4fd5-bb2c-08d5d1fcc887
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR05MB4578
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/14/2018 03:29 PM, Matthew Wilcox wrote:
> On Thu, Jun 14, 2018 at 01:54:15PM +0200, Thomas Hellstrom wrote:
>> On 06/14/2018 01:36 PM, Peter Zijlstra wrote:
>>> Currently you don't allow mixing WD and WW contexts (which is not
>>> immediately obvious from the above code), and the above hard relies on
>>> that. Are there sensible use cases for mixing them? IOW will your
>>> current restriction stand without hassle?
>> Contexts _must_ agree on the algorithm used to resolve deadlocks. With
>> Wait-Die, for example, older transactions will wait if a lock is held by a
>> younger transaction and with Wound-Wait, younger transactions will wait if a
>> lock is held by an older transaction so there is no way of mixing them.
> Maybe the compiler should be enforcing that; ie make it a different type?

It's intended to be enforced by storing the algorithm choice in the 
WW_MUTEX_CLASS which must be common for an acquire context and the 
ww_mutexes it acquires. However, I don't think there is a check that 
that holds. I guess we could add it as a DEBUG_MUTEX test in 
ww_mutex_lock().

Thanks,

Thomas


