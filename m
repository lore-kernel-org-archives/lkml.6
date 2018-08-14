Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342FEC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 13:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9768021655
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 13:34:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="OGqs8psb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9768021655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732779AbeHNQVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 12:21:45 -0400
Received: from mail-eopbgr70115.outbound.protection.outlook.com ([40.107.7.115]:45799
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732324AbeHNQVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 12:21:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Fa2wtIK2y3bOznDHOEAJZ/OnXkTPv5KPlZBdGC4Lus=;
 b=OGqs8psbXB1xCPua3omif82PQ9ugwcz5EkpyWoWSDk+liVuXQio1yjPHmtLl6JwQDr1bUXfHeNsskvEApZOwB68qaVOZ5yQWe3l3OMmIYIiFcXusVhxtHQ112D1PEvHmEX5NzUJD+H3UT/3njGtY3wRw97Bawo5/JaLezoh8U/c=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from [172.16.25.169] (185.231.240.5) by
 AM5PR0801MB2018.eurprd08.prod.outlook.com (2603:10a6:203:4b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1038.22; Tue, 14 Aug
 2018 13:34:25 +0000
Subject: Re: general protection fault in cgroup_reconfigure
To:     syzbot <syzbot+d4eb75e353a836d57809@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, davem@davemloft.net,
        dhowells@redhat.com, guro@fb.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org
References: <0000000000008bc6660570637414@google.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <f6904a2a-5c4e-854b-8fa0-4ad184fed9d6@virtuozzo.com>
Date:   Tue, 14 Aug 2018 16:34:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <0000000000008bc6660570637414@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: HE1PR05CA0384.eurprd05.prod.outlook.com
 (2603:10a6:7:94::43) To AM5PR0801MB2018.eurprd08.prod.outlook.com
 (2603:10a6:203:4b::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 269af75d-73cf-4593-548f-08d601eaa799
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB2018;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB2018;3:wn1zZ1bLGie7KglRiD9tqfRObOlg4jM38S0rfXi9HAqyoswBAGg0cN0EHSVB+1asnB3jXAGa4b+UNcucBYn716ERu73JfJU+W4WcebHIMaapmIDKg1YoqJhaeCmwXtGLxWLzegdA91ngoflnhtma3d+clRCPeQO9lG/aUN/OsLjme51ptFIprYuMUv9LtI+wUld+U4rvzvEMT1SDmfVApeEt0QZzOZJIr5pl4xl9aWmD0NHvQ6MpZ9Tw3pyOXEpQ;25:pN7HTLsPy4zCtI9YvBaKvDcvr3nT27D6CYWCRwEzS40b7C4W/Nd95e8HNko9z2WgKprbHd0mh5TPte38zMTt4Q3NfaTXtdBf+xwUGNuFPxXFenRzmfASh7VA4sQWwrh7E0dXU+uuu55g4enb5r5Iv62rBWXW2rwYnv/p8ubxWMQpoOMnjp7NaXRbYtYCAKOZC+ncMeQsvfRf4R5weXVlTTV+HQznf7Xp6RgxVN80OK7EN86F51xqSCjd4Os9DgFukS3GmFEYl9y8B+BoY1GcDALf0g0gz6rjSx00MRbXyYqSzxuNSjlQXAx0qIlmnGZIoVAFNhYf9FZG9pyMhr61Cg==;31:opZ47UH3re/R63m8bln4lq9Bg9BCu6KDr9l4ua1yS3DWb0qOrogFH9Vu1jekGNZRMcV2IWkoNZSxowwID6csjsY/q0SzJBl/ggf6s8DPtaxR0oicbfCm/iLDenTs1EAG+CIkVARXU9E3++GF44B/LzZr5XucoE7mFfQ5jjwp4QVZ5ramQH/gehu+h8oUgAwWzF6V2Ws6obxiOlFqXg8JPEdq0rmoI4j+WLnyYKjp2fk=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB2018:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB2018;20:VM47czo+t3eWs6Ne0xbiXiKbLHAlySEV0OO4JzuICXVEyagEgjYd5wcTCfzSc5LXk7vF1mxA6o25yGpCoTbcq2UHu3aL+nU4/ivWvbOyTFU9L88/yqL4UYlqwyTtdJPsVH9pzTxhgQbzccFY59Ez/w/uQeow0qu99spTWM6IMPpclr5jhBsF+BAXJU9ifoCC6bsTJedc1WFJO9KU6QUQ7KWcF5ZsOqbhdNbCu6ZATsPxy0tI4ciPshObHriA51OkQKWCNXirZtYf6hHlEhiSiHzs20tJkvitw6b9Urp4iNgqSEoMPJRnYUONB/C1G0W/gzBym2LGeFy4glIaYT1EGFDoakQ1xKwTb5haUf4moiIcdalN14p0Y1jLLvTUnq7RBXabeRwZMuWJv7qDym/cezS4CpKiiAjYHVvBVMvr2Df7bbmVI7NYYiL4pp7LHjdrg5yy2sA72B69dNZtbnFJ+/17VWTHlQqzS2aUaV7WmUTF5G9EOTrYOqG6TcDlMtar;4:0lCPHlxVGkrzrlC9g+WDhXfirRPS1CjCoHuOnTkEcg9a1zhefzqIkHO/JHmgk4EFl1TeyvaYcW04cwOLyqLuJon4vaJO0G1K27QlwcGmtXXbvp6dEZrHKXFUloQwHAgvwEn5yM1jlB3rU/urKiiuYAB45/jmUGZAiGqTojVORxvznxoe39O8bYAefoHQJnD+3RYQ/zR7jvCB/xJtDJ0SFRSKIahHeHm5nV+m5d95/3c3u8EgImt922WVU4h/g03VYqqvLuXj2uZBTBAW5XCsYUvJWqIQx7kXd4ZNfkLWY2DqcZRhIv9DUBe9tikzr0i8
X-Microsoft-Antispam-PRVS: <AM5PR0801MB2018131CBABCC50612DE36BDCD380@AM5PR0801MB2018.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(148501403981450);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:AM5PR0801MB2018;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB2018;
X-Forefront-PRVS: 0764C4A8CD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(366004)(346002)(396003)(136003)(39850400004)(376002)(189003)(199004)(6486002)(305945005)(478600001)(81166006)(8676002)(105586002)(106356001)(31686004)(81156014)(47776003)(53936002)(6306002)(65806001)(45080400002)(66066001)(65956001)(966005)(2906002)(2870700001)(6666003)(7736002)(36756003)(229853002)(8936002)(97736004)(76176011)(50466002)(5660300001)(11609785009)(3846002)(6116002)(316002)(68736007)(65826007)(16576012)(25786009)(486006)(14444005)(446003)(53546011)(26005)(77096007)(31696002)(86362001)(575784001)(186003)(64126003)(2486003)(956004)(52146003)(386003)(16526019)(2616005)(23676004)(58126008)(6246003)(52116002)(11346002)(476003)(99710200001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB2018;H:[172.16.25.169];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjIwMTg7MjM6VkFNQ0RhVnd4eDBrL3puUlFvZU1nMkhG?=
 =?utf-8?B?Q2V4TUZoS1Q2SjJLK3gvQVk4ZEdSdDE3M3pXdUxsMGpGemVBODdOSmR2dUVN?=
 =?utf-8?B?ZDdsNXFLZk1oQkRBOFdsejZYUkZVc09hU0RGbnY2WTQvaW42TnZJT1ZsNHNX?=
 =?utf-8?B?WG9YTmNkMFV1K0ljd2VVMjdRbklFSUJqTXpWMmZrbEtLeTRacHc5dCtDZEd3?=
 =?utf-8?B?Nm1LWlE5aHY4Ry9hMG5xMGJzdkRLOEJ0QzlPY2VXRndaWThRMFJwODVvbWVK?=
 =?utf-8?B?ZmhkSE1XKysyUi9mT1UyVEdaRFFHcTJpQ3B4b05GeUd4dVZ5NE9zSU9Qc09a?=
 =?utf-8?B?R3Z5cmdkRzFwSVhLNVhrUnFNUnl6azRIZjBiVkhCckt5bWFjbXE3SXVReUtK?=
 =?utf-8?B?QUd1bW1Od2RVNWFCVzBCZHJDN25JaXlxMzRIY2owblV3TUFUNjJ3V0pYbTlX?=
 =?utf-8?B?ai9IQlRRNUpXZ25QbExEN2R1VlVXVzN0a1M5RWtJVHp4ZWZsRGVJZktoZTlC?=
 =?utf-8?B?Snc0U1hoYlR5Y3ZQeUFzWC9MNVZ6dHp0cUNqTUVGUTZRWkc2cm01N3FoUE5T?=
 =?utf-8?B?S2dVY2pnSzVNVFFTekc4OUN1NWVWRWJtQmxhc0tpMVNUdG9oalYvZ2hNbWJ6?=
 =?utf-8?B?N1hFaWh6YUcyR294YkwyK04xZXNPMUFPN3lTSk1DeUV1eTRibTI5K0NUL0ZL?=
 =?utf-8?B?TDNCb3ZHeVdzdUlGbUs1WVMxU0c3aTFNSkNtQlB3OTV2a0ZjQTVHQjRWbjdq?=
 =?utf-8?B?c2dWaHhvTFE3WTFzZGE3SlVCOWN6YWwrQWFQWDAvUVJVeE1KRHg3U1RaWVNm?=
 =?utf-8?B?YWtVbFErUVRjamc3OW1iS0FhVmxkcjVmZ0tuNDloYUc3SzFWand6cmM4SHpV?=
 =?utf-8?B?UFhoTTVPbDdaVWFpUlNhY1RlTUw4cmVtNW4zMWNqTDE0bDMwUk9YUllvTUlj?=
 =?utf-8?B?YW9RVTd6a0pCS3FFUHo5M0NXU25FMm5yZ2x4UmV3QlE3MmJmMTUyRWdIOXMr?=
 =?utf-8?B?TXJtdFV0UVdJeW14eG1VbEFhSVlNdFFzcVpiY0U3MjZudXdtM3lIQ0NWbkFY?=
 =?utf-8?B?d252M1A0OVRmMlhINDZTOXFLV01oL0ZvNFdKN1paNkFKN3VqajUxODdVWXRx?=
 =?utf-8?B?bFdTZUFtVTN4ZGl1V1JuL21ZQmdtU3Y2Qk8zZ3M5UjJEalB0MXVxckl2QlBl?=
 =?utf-8?B?eFR2dXg2dlFzMWJTZG8vYW5RODA5YjdHUVRwZGRtU0VCSVlTMHJQQ1dzcEIr?=
 =?utf-8?B?RllMelpQaEJsQU1KZmhmSTQrOFVyRjBVNVc2M1pTemhHS0txS2F5ZEgwZDJS?=
 =?utf-8?B?Q1V0U29zbzA5SGVCWnNwdXBIWGdPTUlxMkxTZE9pWDJvSnl0dFNvc3Y5ejMx?=
 =?utf-8?B?U041SWdWcUtyTmU4TFJOUy9IMUFCTzV2NE9EZ0ZxUUFTM1V2QTBUNTdYZ2ty?=
 =?utf-8?B?NXdKc1pIcy8yUmszeHNoR2U4czNFd1h4ZWxNNXpuVTNQbEQ5MHlTS2ZPN3Qv?=
 =?utf-8?B?b2dPMEhuN2lodWRWcCt4TkdzNmhoMjM1SjN5N0hKN1dsS2dCRGpvcW5Kcmgz?=
 =?utf-8?B?dGRyaVFQZDZtd2hxS3kzbGFwNmQyOGFTNXk1eDlWQUZtaGpXMnJuL3pRMmNE?=
 =?utf-8?B?VDZKQnJ1eldEeUo3SGo2bDRxMzJsdUo5YXRaRGJjTjBBUG9xUU9DWlJ3WWFD?=
 =?utf-8?B?SHhJaGNZS0Q5bjFycUFieVhLYW1mTE1vWGtWRDJlMUxMa0ZvS1UyV0dEL2dn?=
 =?utf-8?B?MlVnRXhwZy9nQjN0ZWVSc2YrTnRyU25aeFNoMHRyZHJvVWdhV0pVdStIWVFU?=
 =?utf-8?B?d3cwdXRpYmRiK1JMYnA2UWVITDdubzVxdzdOVU9HRURMTjZlQkxQVEYxZVN4?=
 =?utf-8?B?RkRPWFA5VjkyMWhYeUlpL2FuT0N3djBGRkl6UVNoT3FHeTZnajBlaS9pRWh4?=
 =?utf-8?B?QXlVTjBxUFJNWk9BdUJWMkcrNzNXSkNIREtQK2tCWXF3WFRYd3k2L2ltL08x?=
 =?utf-8?B?TlVKejlOQS8rZW5nWVdDMXNYZlJIakNRdDlCcWlIUE9NbkwrcHE5QUNuSFFa?=
 =?utf-8?Q?eeI+SFfXMdGxx2GoN5PPTfhRM09?=
X-Microsoft-Antispam-Message-Info: PbweDpRdaK0xK4H4hpvQ0gvdN9eglo26lWLCYyqFwxm6WaV9gloqGtlEEKPWD96OIRuh7yWHCe5u3y8NPy4RzE5jlydnT1rpvRi3//45m3phIozoX4Hio41B/y+QIaMirGMopZeNfOqddx5x89SMlZYdX1zJd3CgHVg6b76vrYI61PJ3Bp+D83812r6KfQUXfM5XzmZGidhu9ZmlNRPgdl2DyfjGRScRPxUj6qxWjP852sC9Ull9UF44rs9av4aP6ltgSBF4VGrsC6VQLsMWgzfTLZFL+bRBCsT2JVaQQodkkLm78G7oVbhjDQdtldaymH0t+rJE7GCK1+rdPhfS8kmOuzN2Tdc+43PXEl7GDqE=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB2018;6:fr1hIsmgvl5U93yeAgkV+M0XzgwtDpGRH0Qe8/Mu6Z1TnvL4S5wLELcLfQ3Swid9md14dm9tnmrYz0eemlnqurlSDVsCHCZqEjjBz6ogN6X62KcKp+HI2zhBlsz2WlRU+etSoBDB+ilhJC3Q6JE6SD7PvVQCXo2KKgzUUTUEFRN+QD0UZ5VP5dGnv3vB0uD9+nm+J84r0IveeLBhospsewoj/6g8tqU8cOlKSLEMk1PJy8MkS6jEJW+iahRN/97O1+Q1Tql/aYkPpXOI/WFd0FaMJlZNFWQNxztzH0UC6CEps+amAwjccrjlinr4yvAbiU7ZsYWLlspaMH1zIFnTMKYgZb9xhlJvZvU4rC6PQXTEvtu8XtNwAdUt0+c7UfPpSFf32Zuaw9SVVh7fMUJi+w2w+2pSjs/ujI1aFhQmPZzovQahK6SBkQl+dKsbjtQAaC0hw9YV5LCR6l+vH+JKMg==;5:n4uMexhHMuBc84cOrVJSEsv3mMBIK1XLAeJ3P1IYnLeig8ktiDqHquWc8a78sQOUR+umlU/8LPhTD5QosG56ksCoOWWCcpFZL7Xx+lnCUJ61rCfSn9CdFnhVfw6n88qqlEzTjBAYjhe1mLnwzmgX4lQ7tvogDxuoWcnCHRX1PrE=;7:75DPSEaX5HwPVk7ua3W/yjaemLO36CJO4T3D/S6oLCRxs+frD1nuEwZWYWJZLEW5lUkFKhSJOBoUesjydtJMyDKRXOeVvZYxXfuQmn6Wfej1LGjoX2tfV0z8CdN9sJVPxH2Q1M5xUMW+pXrEVOZhq3Ja/48H50nr6fQoZah+pXHmu6Rsp4hNVxSLVb4qciF5Cr49Zsnub+Eb6B8zU5LYtBz6kRJVuKyQkU7Dui9XTVNogoADlVNA/YVPzxnshEpp
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB2018;20:125ebWlUJQg6JO4TsfNSAsoG7ZQ/GMFUcXczURnNNLBTvJAfoTnup6J0W2EF5+6kjuGHitliTdqxEUj5pg1aAzz2In2TAVKtrvRmZKlER2yFp5ujImddmq7qUPK9MJ4bK6iQZJSrugjAx/h7Fj75Yw9DIZlm3bdwdqxMDonOLGQ=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2018 13:34:25.7666 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 269af75d-73cf-4593-548f-08d601eaa799
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB2018
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

JFI: Fixed by https://lkml.org/lkml/2018/8/3/351

On 07.07.2018 10:09, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    526674536360 Add linux-next specific files for 20180706
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=14b51a2c400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c8d1cfc0cb798e48
> dashboard link: https://syzkaller.appspot.com/bug?extid=d4eb75e353a836d57809
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=10ce2cc2400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=149cec58400000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+d4eb75e353a836d57809@syzkaller.appspotmail.com
> 
> random: sshd: uninitialized urandom read (32 bytes read)
> random: sshd: uninitialized urandom read (32 bytes read)
> random: sshd: uninitialized urandom read (32 bytes read)
> kasan: CONFIG_KASAN_INLINE enabled
> kasan: GPF could be caused by NULL-ptr deref or user memory access
> general protection fault: 0000 [#1] SMP KASAN
> CPU: 1 PID: 4415 Comm: syz-executor204 Not tainted 4.18.0-rc3-next-20180706+ #1
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:cgroup_reconfigure+0x25/0x80 kernel/cgroup/cgroup.c:1781
> Code: 00 00 00 00 00 55 48 89 e5 53 48 89 f3 e8 f3 e9 08 00 48 8d bb 90 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 75 45 48 8b 9b 90 00 00 00 48 b8 00 00 00 00 00 fc ff
> RSP: 0018:ffff8801acc1f9f8 EFLAGS: 00010206
> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff81c5edb2
> RDX: 0000000000000012 RSI: ffffffff8173906d RDI: 0000000000000090
> RBP: ffff8801acc1fa00 R08: ffff8801ad2e45c0 R09: fffffbfff11c24e5
> R10: fffffbfff11c24e5 R11: ffffffff88e1272b R12: ffff8801d9a14940
> R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000000
> FS:  00000000016f3880(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020000000 CR3: 00000001b24ea000 CR4: 00000000001406e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  kernfs_sop_reconfigure+0xba/0x100 fs/kernfs/mount.c:31
>  do_remount_sb+0x34f/0x850 fs/super.c:991
>  do_umount fs/namespace.c:1467 [inline]
>  ksys_umount+0xfa7/0x12f0 fs/namespace.c:1585
>  __do_sys_umount fs/namespace.c:1596 [inline]
>  __se_sys_umount fs/namespace.c:1594 [inline]
>  __x64_sys_umount+0x54/0x80 fs/namespace.c:1594
>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x440059
> Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007ffe8d0cd578 EFLAGS: 00000217 ORIG_RAX: 00000000000000a6
> RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 0000000000440059
> RDX: 0000000000440059 RSI: 0000000000000000 RDI: 0000000020000040
> RBP: 00000000006ca018 R08: 00000000004002c8 R09: 00000000004002c8
> R10: 00000000004002c8 R11: 0000000000000217 R12: 00000000004018e0
> R13: 0000000000401970 R14: 0000000000000000 R15: 0000000000000000
> Modules linked in:
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> ---[ end trace 2c2a1923aa2ae1cb ]---
> RIP: 0010:cgroup_reconfigure+0x25/0x80 kernel/cgroup/cgroup.c:1781
> Code: 00 00 00 00 00 55 48 89 e5 53 48 89 f3 e8 f3 e9 08 00 48 8d bb 90 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 75 45 48 8b 9b 90 00 00 00 48 b8 00 00 00 00 00 fc ff
> RSP: 0018:ffff8801acc1f9f8 EFLAGS: 00010206
> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff81c5edb2
> RDX: 0000000000000012 RSI: ffffffff8173906d RDI: 0000000000000090
> RBP: ffff8801acc1fa00 R08: ffff8801ad2e45c0 R09: fffffbfff11c24e5
> R10: fffffbfff11c24e5 R11: ffffffff88e1272b R12: ffff8801d9a14940
> R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000000
> FS:  00000000016f3880(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020000000 CR3: 00000001b24ea000 CR4: 00000000001406e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> 
> 
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with syzbot.
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches
