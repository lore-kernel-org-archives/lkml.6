Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8023ECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 10:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 656112152A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 10:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="pMNsGBa4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 656112152A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731946AbeITQLd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 12:11:33 -0400
Received: from mail-eopbgr30074.outbound.protection.outlook.com ([40.107.3.74]:35359
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726669AbeITQLd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 12:11:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ZY1tzTqhMHrNMLJPlI+S1+ZbaMnotNWDbUDsyN5frk=;
 b=pMNsGBa4l2wQG0PF5xagYvF1lgIT+Z7jd2J4qy4Ub+jWJTs2TLoPb2QNr+EyOfVEyFB9wETTAb24o47orJ90cHsXWoUPwoOjqMuGpqFVkuFxAMjRCGB0FWd0CjzFai0P+6QUXSGZfVgmeSOhN1BSQTe4DnYl8R73yKGpxgZife0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Szabolcs.Nagy@arm.com; 
Received: from [10.2.206.68] (217.140.106.49) by
 DB7PR08MB3292.eurprd08.prod.outlook.com (2603:10a6:5:1f::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Thu, 20 Sep 2018 10:28:41 +0000
Cc:     nd@arm.com, carlos <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ben Maurer <bmaurer@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>
Subject: Re: [RFC PATCH] glibc: Perform rseq(2) registration at nptl init and
 thread creation
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
References: <20180919144438.1066-1-mathieu.desnoyers@efficios.com>
 <c58d4d6e-f22a-f5d9-e23a-5bd72cec1a86@arm.com>
 <2052751374.8654.1537390886450.JavaMail.zimbra@efficios.com>
From:   Szabolcs Nagy <szabolcs.nagy@arm.com>
Message-ID: <b0a05883-befc-05f5-0bb7-d59b257238a6@arm.com>
Date:   Thu, 20 Sep 2018 11:28:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <2052751374.8654.1537390886450.JavaMail.zimbra@efficios.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [217.140.106.49]
X-ClientProxiedBy: AM0PR06CA0011.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::24) To DB7PR08MB3292.eurprd08.prod.outlook.com
 (2603:10a6:5:1f::30)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e3e4d3a-ef7e-4e8a-e3dd-08d61ee3d626
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR08MB3292;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3292;3:CEQFUX0V1PT0hshNpmilsIEpOg4wOfP/Vj2C43sQCrbdyt4CSHwAXNbv7XSX33JYxzkNe95+CUmkW41ZlfmXfWSn+258Q1r2UW9HHV07+U9Gb4AxFaWJm4iQgdg1fhla6xMpNGcdadAU3H1ElAd77VAip/FryISZmMDYTbwpHED45tD9LW/KsIsUX8Pia9rRfi2OGzzhJdkfmwsdwOTfhHxXzuR9QdSlh4CR1E6aAaid2EPl4+uSiWGDFjwKqkvx;25:F/LVTXaw8Ym6Dtm5Epn2bmUB4G/kWVx0HSlXKCvHVmWa+tLmdbbO2VoHVeHTETwHFRQ/uAA7m+5IkYd6Ag5KHsZy9CojHv8YRd9Jl0LWXL43CKwSTK+UpXVENdixB7CV8HLP1xu1mOD/4s1UYF/rwin6FeHCaZkvI8MtmZ/APpyAvNrqwjF+v8P1zgKhNkCt5/bmOvWCKoKcbt+fJ5AAku2idk/UXPEUWyG808dm3eatskKdBpyBZdwAfiHXpKinEPh4k/Y1KlUUyP2uond+9kmpvB9gm3jEni2gcGUACysEFUG0IHtlv99evPstqyxOIW+PA1lPOuMmmICXauUK9g==;31:qCK6hijqmUh+wYq0vRZ991Is4q1nwkVPUNZxLDgg6wsLX0uVEl9KkL/2dqSbcIRbV0hXk2nuAh6GXSYGF/WtOKTFxjKiGfqN4WqxiGD6uEgARXTArtg58NIKnC5eh1wxNpe+H8+zjovXM075EYSb10pIb5NOGIdNa6qjk1eiL74TiBgi/Q3OEPxoxtLzc5D11VE5EbCba7c4CSw9oYf2n6L3g1dlE7GIpufs0Ah8ne4=
X-MS-TrafficTypeDiagnostic: DB7PR08MB3292:
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3292;20:dMKms4HEmRvciVZK0Dt6WPWlsXxF4Gj2g9Oq8Awqb1dWTck+UAN6X1wvQ4PJ/3UXJmBjIY3AB7kToXdIMYNqLqbEL2DJjSI+/TmBbHdoeQeCKLJvft8bzsuZjSHZNN8lI5o1kd7zWJcVRn7dElGBz4Wue2EOuaWUP8al0aAuBEuLP+2yDBlnDulejTz1fXek8WYh5DA6YT1hrWCGnWhWNWPbJgr4kH2m7IddHz/I1JBoY6kY8pZ3Y/lr1hp//YGcqUkjjlzUk0vJQiRG1WLBusYNPK1DbVfzh0n3vdiJT9WF+vpreisMmvfX1HNE5GmOvZ3/zCD811ghpXLTtzHAmTFwjeYiADVtuAlU7pBt4O8YhCmLbc19dUUlifYlcNA3QUMeIPpeeTAk9oMk76BZTQX8hDrouSQtP9TAUGizmaE=;4:pa3YzY9beLDCKhAK+QnL+erUkMKOiXMGh+hpH7PrmH8vPgpgRd5parmYF2fZF6RudiELo4d1DnsKjgxMrXRu/102MAHnxTwwUWZEfmWAvlLqPATIkdj3LfWesCEgHfpqChVjDr40qgXbHAoJLyWf8wXxyCpUXUrS/blnS1odQWUm4r9dBCjHiGYVUJtIQPm3Q0qQgBbTmIqdpKbE0pUhLqiGrzH3TW7GRWmNzpCobSUMa9YzKXTCavRFBUAfPzvtWzcZpoJDsP+t6lAoYjWksbjr4CVpHYTGOC5RGl7Zvd7jleXPb7ARs7xFFWJ0XyDf
X-Microsoft-Antispam-PRVS: <DB7PR08MB3292ED14E783699AF9DA5F65ED130@DB7PR08MB3292.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699051);SRVR:DB7PR08MB3292;BCL:0;PCL:0;RULEID:;SRVR:DB7PR08MB3292;
X-Forefront-PRVS: 0801F2E62B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(396003)(366004)(39860400002)(136003)(376002)(346002)(199004)(189003)(446003)(8676002)(105586002)(31696002)(2906002)(31686004)(77096007)(5660300001)(229853002)(65826007)(186003)(956004)(44832011)(106356001)(486006)(14444005)(6916009)(11346002)(81166006)(26005)(97736004)(81156014)(2486003)(53546011)(76176011)(64126003)(23676004)(52146003)(52116002)(16526019)(8936002)(50466002)(386003)(6116002)(316002)(305945005)(478600001)(3846002)(966005)(36756003)(230700001)(54906003)(53936002)(16576012)(47776003)(2616005)(476003)(6486002)(7736002)(86362001)(65956001)(65806001)(6246003)(66066001)(68736007)(4326008)(72206003)(6306002)(58126008)(39060400002)(25786009)(7416002)(67846002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR08MB3292;H:[10.2.206.68];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjdQUjA4TUIzMjkyOzIzOmRPSVJ6NFQ4SW1zVzJYWlEraS9YSUkyYnBH?=
 =?utf-8?B?SWtOWXFBanVWck54Wmw0UWxtNGMxVUpLWm9wc1pXdEFXTUh2SlZ6dm5QN0RZ?=
 =?utf-8?B?NkRJZXpVaGE0aGpqdjVQRHhaMlUrYWFaUmhZS2p3MThrSytHQjJFbmkvRHFw?=
 =?utf-8?B?SXY4V0tTMktpVmJ5dTlYbExNVjVFQ1FXUFBubHRmc3JZalV4blRwY1NtSkVh?=
 =?utf-8?B?d0RKK2VXYWlMUCtZK0Uzb0xPRGFkSmxBZVRzbHhtZlJnNlpmWFNQaVNLQXFw?=
 =?utf-8?B?NWZLWUdrWEE2L1NCYlloWGloQkRmdzRuUTFUZGcvMWxaaXJKMlZweXRBYjdt?=
 =?utf-8?B?eUloc0R2QmN3V1hMSVdobis3OU5CbTlwbnYzR2VLQ2x5c2pBdDFMUzdKbzhk?=
 =?utf-8?B?aHRIaE4zNlNrVUI4ZXdqUVEzRjZjQW1KbEVQd25lR1I0aTMzRFR2dm81bzh2?=
 =?utf-8?B?bVFxZkxkOWh2NUMyUFlBZXVISVlSVDJWTzRpU1BMdFUvK2JFNEdYTmpYQno4?=
 =?utf-8?B?T3NYazgzUitJS2hYcUswdmFaVFB0NFZoTGtNU2tmZmxSakphTlN2Q2UwUzhn?=
 =?utf-8?B?YkRNTk9YWTN0WU1CbFd6S3ZCN1JsL2w3SUs3cGV3Qyt0OUNteFlXZ3YrbmZr?=
 =?utf-8?B?QitWL0hwQWV2LzRwYnR4QTM0MmRlVVFXRDlmMnpzZnFoUWxFR3BGSHo4d3RJ?=
 =?utf-8?B?SlA1L3I0TWNpSENzaG93OGozUWVJMHlpVmVEcEJtRm5GWTE3cWVKTFlpZVIr?=
 =?utf-8?B?eUQxOTBmbWlaMHYrSXhJc3YvV041c2ZZcGovYnRFbng2b0k3MVZ5c0hrbkhL?=
 =?utf-8?B?dGJoTUlCa1hpUG1mZk9jeEFuNWZwTW54UWZua3hQdzJ0Mm9aZ3FUaEZYaGds?=
 =?utf-8?B?ZHMwdHpOS3NYOGZWeUtZc2lqK20rVUYzcUI2SnB4SnM2ZnNjaDU4bXhTbGdW?=
 =?utf-8?B?akxSSDQ2bWJ3MERCOUR2QUVzSnVUMWNVS29zZE1DdWVFaXo4VTN0MEhLcEJF?=
 =?utf-8?B?RnR6UjYrRTJML285bDBQRXJxNUZwUzFSejk5MVZSQnlWckhiWURPV2JWUm95?=
 =?utf-8?B?aXVvdjY3T2RHL1UvMWVvNnQySDVGUElrMWtFcmR1WGtwakRhY2FTdHl5RHVh?=
 =?utf-8?B?WE1SOU44Qy9BNURXbTRXVVFSMi81byt2Vkd6bkh0QTg5YWUzczh3anlrMTUw?=
 =?utf-8?B?bG1JS0JsMGVxcXBDb0pISWgwakFvclBVVGMvMU9sdWxVQWpEbHQ4c2hVVURP?=
 =?utf-8?B?cU1EOXNpVzhiU0Z6cGhUZDYrUmdzaEVoTXVlWEdWYlZETTdmY05raEdFdXU1?=
 =?utf-8?B?U0k4L1laekROWFc2UnkrbEdnSWMxWlg4T3hGUnJ3S05DVXpQR2wwR3V3TWE1?=
 =?utf-8?B?RlNyNEVtMnIzVkcyamxBcWltc2s3QzZBRTIxZkNMVnpRdnBtWTJGRlZOZTBF?=
 =?utf-8?B?VkU0TUNnSzVicWlUc0pWM05NMVJ0aFZLQ0ZTK3g5bW8wQTNTL0tqYWRoTnRy?=
 =?utf-8?B?V3JKVDlNNW90N0JmL1FwZzlHQS9GZHJ5ZnFQcmRkeTNnUm5GZW94aWFyanlp?=
 =?utf-8?B?WGJmNUNFSmhuYlNrRzhKVisyK1VDMTArMkRTZ0dvSTlVNTNsdUN3c09VYlhR?=
 =?utf-8?B?N05XeDg4S0lOaGphcEFHSGJWWWJ5Vkp6bEloRHk5dDFkeHRHcUIvSmFsSTk4?=
 =?utf-8?B?NEJLMGsvc3NJS1FyYlRPdkh0QVFjTG5LL01RRmh0bG0zcVpFS0Q1WDhEbmND?=
 =?utf-8?B?RWFVN3hSTkZBbld1S2lNbkRzNk9vUFBmNDQ5V3BZTFZmNGxGYm95ZWZ4ZE1J?=
 =?utf-8?B?dmJxNG9VR1J5VVo3Zm4zVWJUQVk2ci9kMndXWDc0NXRSam5nSjZQU29EeXl2?=
 =?utf-8?B?NjNrQ1FHZFQ1a1FVVitKVWhFOVpyZUorM1BGRllvZDg5akhROUpZeGRXR0V6?=
 =?utf-8?B?QnFlZ0tWVld6MElIU3MzM0RtcUo4SFhmQWxkMEphU3dpWFR5L1p5ZkpPKzVw?=
 =?utf-8?B?QXRzRHBHVWduVEpiWkJBL010d0E0RVJ3dGpPYms0SFZDNU9TWGMvVE1id09n?=
 =?utf-8?B?eWpVWVlVSlRnc3ZQTXg3MjBRRVZlOHpMU1JaSXhOUzFaaWRyVVNYWVVkSy8z?=
 =?utf-8?Q?RCx5zLrxeDjx0iJinh6b1Sg=3D?=
X-Microsoft-Antispam-Message-Info: N6HYtTQ5zsCOuwNotN/EYjgT94GlhHO9cFsK2Ux2WNKrp2K00bjA8I60nUNWfuNzCh/2x5apEpAkU7O8RnmMMjI1h9B+odn2MHPU5NBlCaIkF2EP7BdF6M3kKwgmcfVFFAXS9rEaP7Y6XcSpgyrSu79pt4ndpO4n+jEyzxrb99gRvxtM47bgXLzk9TYEkPezCXgCudvgsV/I0+Taj7EUlHimZFtN4x24h9Tgq5z6utEFH4m8POfWbsJho1Ja1O3onVlsOTWmRUrmJ7IES/vYnjz9Q98rXHXCzDQhBDr1G9Vi81MekFNJxHp42Ggjq6N/Kkw66Kpyw2J2T2aL6fF6wT+PjOOFtN7HjXz0ivCIR5c=
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3292;6:odgR7n00Lua9yNfWqPrqD0X3Q2yUlb5w191y2BTRo2QvgoHyrEFGtfTfEPooVHR/NUfsEFTWP530QnRyL/cq6WqrAcdb83+1x5J2/uP3PuzkxIlh9MfsxtC0ELLMczomZMz/FyJT8ZR1jsWo5nz9FJkCt3gyu3RgBbPs0myh3xG+rerdJbVCyfqG8grNuAj7X9y54mlebzr7xE0BhKIc+O4w82eVSl5fKWx/SnFz8lqTm2bic7bN632tGCOUCDjhYZwgIgcXUUneHP9cVHqC7ZHdDeaZap03YZvtTJKnGf9GjVaMwNtO1/xwUcGnh09l07wDZHNaJCCl5ScjYBzOTrHfHuQdCcsFu6S7xd99Nfu8jk7JTwG0PMfdFZhmSFR7hnGe9B6/uNmpX67jRZ3n0yNWjpH5yrIfw7o2829kxomOFWrpRa/8zBGxFi2hrN/PmN55xIPhHa4mLBAcJ/TfCA==;5:Vx4gcfT2hn3j8ITg0BbUpSfN0EnkhoFeZdzBwh02WvpLlywJGxatprZJRFXTXOO81C88cWeEY1Yy9EkpCkUJFxnq0K+nOFp4N81jBGVBhzj6vvg0jLOUEJt72QWCilk2ABZaBVlfC/4zcW8V3e686TfpW5vrB76oTyGtH9hdMRY=;7:/BbNwjr1pDwqaJeijt/SZUBSSiWMnK5lYui6+DvfOfOlQfAsRYjY8bRlQMtoJVWmQqrPn8qNS9qN4Sx08ZL9rNcX0KQhdPt7FsXrs1CBrQzc1+A9AYybFIdJzEnxOOrPasmqEFMYq3KQXGye3NoiK2If4OzJrOCaclTq9Ey0f9US/HV0+9OfktZOSiIwR4ziaD9qkDUX9W4yZBa2XPPeB8rppYP9iFn8ZK13qDy7mB3d+Ome5pYvxZqOJNv9TIcD
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2018 10:28:41.2852
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e3e4d3a-ef7e-4e8a-e3dd-08d61ee3d626
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3292
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/09/18 22:01, Mathieu Desnoyers wrote:
> ----- On Sep 19, 2018, at 1:38 PM, Szabolcs Nagy szabolcs.nagy@arm.com wrote:
>> note that libpthread.so is built with -ftls-model=initial-exec
> 
> Which would indeed make these annotations redundant. I'll remove
> them.
> 
>> (and if it wasn't then you'd want to put the attribute on the
>> declaration in the internal header file, not on the definition,
>> so the actual tls accesses generate the right code)
> 
> This area is one where I'm still uneasy on my comprehension of
> the details, especially that it goes in a different direction than
> what you are recommending.
> 
> I've read through https://www.akkadia.org/drepper/tls.pdf Section 5
> "Linker Optimizations" to try to figure it out, and I end up being
> under the impression that applying the tls_model("initial-exec")
> attribute to a symbol declaration in a header file does not have
> much impact on the accesses that use that variable. Reading through
> that section, it seems that the variable definition is the one that
> matters, and then the compiler/linker/loader are tweaking the sites
> that reference the TLS variable through code rewrite based on the
> most efficient mechanism that each phase knows can be used at each
> stage.
> 
> What am I missing ?

in general if you rely on linker relaxations you may not
get optimal code because the linker cannot remove
instructions, just nop them out.

(e.g. on aarch64 an initial-exec access is 4 instructions
a general dynamic (tlsdesc) access is 6 instructions +
it involves a call, so the return address has to be saved
and restored (+ 3 instructions for stack operations if
there were none otherwise, which the linker cannot change))

