Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175AFECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E6D32098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Xl1/xAhB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E6D32098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729908AbeIXUpa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:45:30 -0400
Received: from mail-eopbgr60113.outbound.protection.outlook.com ([40.107.6.113]:3688
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728421AbeIXUp3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:45:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lKiMqYh8w3kgaPxh2EQYQZeqVgbCPqHclIfv6e/GmNw=;
 b=Xl1/xAhBovNU+dfC6sUqR5Gldv/EoT9Ez1D3m768vDKK0llE1Ewfc8WOth7kchtPaLbpnhYudkbUOjjRNYLcHeURg5cIANe783Sq8sHxqYHeo6/zbbR3a1aHMjGWvCrUnHUMJ0InIXz2UyokawUWj5ukyX2cf4pSL/HTShRSm3w=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com; 
Received: from [172.16.25.12] (185.231.240.5) by
 VI1PR08MB3264.eurprd08.prod.outlook.com (2603:10a6:803:3d::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.22; Mon, 24 Sep 2018 14:42:52 +0000
Subject: Re: block: DMA alignment of IO buffer allocated from slab
To:     Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Ming Lei <tom.leiming@gmail.com>,
        linux-block <linux-block@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "open list:XFS FILESYSTEM" <linux-xfs@vger.kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Lameter <cl@linux.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <CACVXFVOBq3L_EjSTCoiqUL1PH=HMR5EuNNQV0hNndFpGxmUK6g@mail.gmail.com>
 <20180920063129.GB12913@lst.de> <87h8ij0zot.fsf@vitty.brq.redhat.com>
 <20180923224206.GA13618@ming.t460p>
 <38c03920-0fd0-0a39-2a6e-70cd8cb4ef34@virtuozzo.com>
 <20a20568-5089-541d-3cee-546e549a0bc8@acm.org>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <12eee877-affa-c822-c9d5-fda3aa0a50da@virtuozzo.com>
Date:   Mon, 24 Sep 2018 17:43:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20a20568-5089-541d-3cee-546e549a0bc8@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: HE1PR05CA0368.eurprd05.prod.outlook.com
 (2603:10a6:7:94::27) To VI1PR08MB3264.eurprd08.prod.outlook.com
 (2603:10a6:803:3d::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63ce7588-48b5-40f0-7676-08d6222c02d8
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB3264;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3264;3:rHJLI9mLcfynvwupkvVMuJFHUPVwM4FDw2Xx7Ly8LbnLD2C6W1289eFDYaXDh2pQft3KXf74GpMHVEuAhvbu3HP9aPgflSpE38KdHBe7JZikFMGOuR59aIHSfUkGfsTvu8HIofotKqh1qOrGGqkTnyUf4bhonFAakA7y+FI5uzy4qa7Xzvhirk5PnhypMZax95whPQK9xrk9NHS/ywOnTpWac9dIOpAcuEooJafOeL/HaKOuqNJ+6BBzMiZYJyhn;25:pcoImGCe7oeXMJZILbU9bRo0KnxUo4IE5cU46a/eBQjpnJcGOjJJipUC278dFe3wy8iaXOC8SlEg2AcMtJIrT5Ui0h4cMRqcCyk9UMBzCAPvvSNo7ic+twEXzJEskF4s4ahyqdg6a3uB1Cp4xeZMKVs0Gfkkf4Fpf/HiGrraXYNWhR655FEfAbLuzoSSEtgFN/MRmnBXH7Dt9ZokLUepADZ77klKbvfcBPSXQMIR5tuVF3OHAH0MTetSF8JFC00gYr4j1ryeUSlA5zeKP8So6a7q6OPqt4x+K8oT67ySMTupRpIu5bkTpCpPZOR4/AQb+fRqnno9GNx4Fk4QWnpGzw==;31:IbOxbPq2ZHEVmxfjhGZkMQgSSxVuqsdmvIHvsgdtHDEUWFZCXT0lxd6wXZ5FDXEW8SrGROd0BmNIAKC7pCxYWKnV2lxGSu7VfoIdJh4VETKwJvlKlF1RGfQRUjYVLrUc7SNxgBAmzUELl2g5mTEbfPVThedgIG16/38Oau0DV3flzK+0UGn4YVX0B4yRCYxobCA8SbtoeCwMcu/c93vdjWtJqT62htDq/5rQvVKLNhM=
X-MS-TrafficTypeDiagnostic: VI1PR08MB3264:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3264;20:aLLl+uD36UVvurN09lsREyBU6+SE+VxyCYass+3oZU1wBwxIGuop45iaMPl0AJWh+imsoDeFpj2lY2zTFlSyMc0W0P2SinDP3bXTybq/04VfFP5j5vesphG6xbMtqUnGO05zpEdzMPHtMsYihm8SuKdwOr1/MTwyuilvkVz2ITJDyxeVewTMKXYnlMGx17NrWkWTVW2i6lx0yzmtB6oP6WStWmMRUeF2F7miMCSMho+jgVdgXVqzoU2vgyfV6UyN/IMODzMX4X7se6VxXr/GfzCX1kKMs00oA6Wo9fA2kXnMAS6bJG2JKEeW2fG020X966PiybCYcvel4DOoBLZytEN9B16fMEHDfya/N2kp6MWAVZL3e5wWEBukIxSEcrxTNX7Erku/ngrfGzJ5TOICjVAxXDlFXDCT0xZ9YzcPP/D6tO8ehwAWEJW0wUq9jmuCWGQJqmkeZCgRpmFWx2vn/8QCZNWjYYG7UNn8BFPJTpVuAxcPJO5bKg+5bH3Wt4nK;4:AMNWVGsKp4YqrmcZ3xmAO8PaqKFGx8I6OmLGAFAChG2+4PilVNbSk/jTkbBZ9Mwa7fMxHb4rjmmcMJu+yIPUDHmWqqe35KNt/Oei6RfVPXYZcoI8yFwnYXYxK7Lhx7qowyR4jmSm/ZAMAazf5PLGnvJzl5WNdSRbZUduf55hZwJmvZs48ysYybINQO/VMD8dCl0oXyN4FdIFD/3a5xfkorp6M85IbKX9tr1hRg40CAeiJ7ii9EUmy/YHhHeE9FmdJ8JAJAHHOvqSWQNm0H6iQw==
X-Microsoft-Antispam-PRVS: <VI1PR08MB3264D9AF83C926BAF958730AB0170@VI1PR08MB3264.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(149066)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:VI1PR08MB3264;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB3264;
X-Forefront-PRVS: 0805EC9467
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39840400004)(346002)(366004)(136003)(396003)(376002)(199004)(189003)(97736004)(68736007)(39060400002)(4326008)(11346002)(47776003)(25786009)(478600001)(446003)(65956001)(65806001)(66066001)(26005)(6246003)(77096007)(81156014)(81166006)(8936002)(16576012)(8676002)(3846002)(186003)(16526019)(106356001)(316002)(105586002)(64126003)(50466002)(31686004)(93886005)(6116002)(2906002)(2870700001)(956004)(476003)(2616005)(486006)(229853002)(7736002)(6666003)(31696002)(23676004)(2486003)(36756003)(53546011)(386003)(52146003)(52116002)(76176011)(65826007)(7416002)(6486002)(86362001)(305945005)(53936002)(5660300001)(54906003)(110136005)(58126008);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR08MB3264;H:[172.16.25.12];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4TUIzMjY0OzIzOlQ5VUZsQXZFQ1dLaXJhK0ZuTXhSTXdKOHds?=
 =?utf-8?B?ODZUTHlET3hrMFlrUHlYUFcydlUxN0RBR29CR21YOStsZzlEUlYxRmkvRTYy?=
 =?utf-8?B?MDhMRURrVmo4eXA0MndBMGdtWWt5ZHBPTkhncXNTWWRjclBSVS9CNjhheTdv?=
 =?utf-8?B?d1FERzByVUFZc0ZIT00rVlNrbUt3WEFNdE01aWRRSGVPS0FUQXd3UjF5QVQz?=
 =?utf-8?B?SWlFNmtDN3ZuajRZa2N1S2pZUlZnTlZaSDVoSExmemFPKzh0U0xoODhRenkw?=
 =?utf-8?B?UlRHdmVucnJ0NVZRTDFxU056ZU9pdEU5SlhoNnh0MVhEb09qVlJlQ2pEeDZx?=
 =?utf-8?B?Y0Mvckw3UXFLb1VEZ21yc2ZwSEdlQi9YbU9LNnI5bExxckFJZW1VL2JMVUF5?=
 =?utf-8?B?WDcvR0xsMXNRd2dmQ0dTL2NwdU9qZHFYTXMxNXlyc1ppOFNZTTdObDNiendO?=
 =?utf-8?B?Ry94dFArbFVCRkpkRFdLM3ZNemNLNVNlQlFvNHMvMzdOTG04SkpqQ2pkTTJR?=
 =?utf-8?B?d2xyMThSS1ArTEdvTWh6dDNSVnNpV05TeWVlTUJPNWpEQ1ZYUHkvNVJsZ0s5?=
 =?utf-8?B?VlJaM2xoZjhqaGNlZEVMYldIclVwc051a0FSbFJaRHdKbjNrSU9Mako4SENs?=
 =?utf-8?B?a2N3L3lLMVFycEpVajV2L2sweWZQNEg0V1NSN1JDRGJOeldCbmVGN3d1bkdO?=
 =?utf-8?B?anVoS2QwbEZHK0RJcWEwRTBnLzg1S01PUk5Mam4vZzllaXRUSUtTekNzZ3Bm?=
 =?utf-8?B?R0pXcUJZRmFWQlV0RjZKY3NHVEc0aUkvbFByQkFQam9NalYyNXIwNnBzQXJZ?=
 =?utf-8?B?WWJNOXB3RVNITTlhcjJhZWY2MGhDMUJBa041QWFkckNDNWQ1MHBSYjNLR1NC?=
 =?utf-8?B?ZFFJUUpCV0JNVHhBb0pybTJnNS9TWmtGdmY3VTZLcGx1T2NDZlJneXNoRWRY?=
 =?utf-8?B?SnpxMzFlZUh2TjhvN3g0ckV4c2NZbUtVbjZWWnlXelJKbDBOMjY2b3NKZkcx?=
 =?utf-8?B?R1A0ekV6eXh1c2pYNVpGOEJ2STFiVGZ5RU85QmpFcFhHamk0NmJ0RUk0RkZ0?=
 =?utf-8?B?N1hqYVVBWHd1bU1wUDBKc0JydHpjNmw3Q3BuVzVJWHRXYU5CR2NSYzhBNzg4?=
 =?utf-8?B?dkdNTjUrOWgzZkFLcFc0YzNUM3R1c0lUVElPSHNUckZ6NndwY3Q0QWRORWFT?=
 =?utf-8?B?TklUZEw4WGpzdGFXZnQ3NjhuVkVDOWNRM3YwSTB4Zis0c1pqaVBJQmZtTE5M?=
 =?utf-8?B?ZkNsRWFqY0orV3NUODZVK1E5UXFVWmpkQ1h5RWNTOVZQdWhISUNCTFE0ekp5?=
 =?utf-8?B?bkZrRmttK1FMTXFnMnJETkNTNjJsUkJsU0ZqK3c5R2xEMWxiKzVaMVJESnNM?=
 =?utf-8?B?R1B2L0pDTUtCRDcxdExaZk9ab0loUXBVemthZ1FUalpWaXQ2Q01NYnl5SWRn?=
 =?utf-8?B?MG1KRUdOdlRDTW5aTGFiQW5pVWx5UUFyTVdKMEkrRzNjczBqU0l2U05xbjZu?=
 =?utf-8?B?SXMvT2N3VzJhL2JhMjVNWFQ1N0tDTitZcEc5bzR1QjRvZWxQbzF1dXdDWXFr?=
 =?utf-8?B?ZjlwamI0MmM1TXI4VW5JdExVNTA1VHMyMlNIL0xnbzdoUlpoeTRFRmwxVisr?=
 =?utf-8?B?cDdmdWdSS2E4KzhqTEV5NW8yenZ1TWNQSUpVTVZXL29scXFEdmM3MmlmU1dR?=
 =?utf-8?B?Tm11MUdMcUg5MGZxcUEvN0ZldVZwenNpbEhVYnp5M2ZraHVIZXlqdlRkYTZm?=
 =?utf-8?B?NWNOdTNua3JMTmpRM3pDNzNScGlvUlc0VFIwNk8rTTdzVEtFNG5JdTY4bERa?=
 =?utf-8?B?U2JSN3dWMHFUdzVWRXd0ZDBpZ05IcWJ2SWp6RDRzckc2OWR1UzdvN2MvMzhM?=
 =?utf-8?B?bEJGb3lYNVpibEZ4RjNST3dJTUg5VFBEaGZPK2pMSzBYSndhcEN0K3Ixa3Iw?=
 =?utf-8?B?VC82YTJvY0N4NjYxRlg3VWJXd2NKVzBrdWZGM2VsMmtoV3dLdXRZNU5WMS9n?=
 =?utf-8?B?S0RyTVF3cXRzU2N1QjBYdmVicGtTcDR2dXVLZz09?=
X-Microsoft-Antispam-Message-Info: t2S8HSkdSpXwTHTI9b/UrD+MSZnzF49c5L4FXL7eGyFRDO5dHW8oxMTaQLwhvqpZhr4nXe92sGiS6TH4B0sxDL11lvzvbImuxt2aUiYvvM27g7IyuA/Vox2ZKv9Zw+xJ+8lDvnoLsOEj1OALg6v40TVePAoFW5liX11ZhZzHC3qMGWn7s3D2ibffnz7Yytrzvr8fkq9KmeBAK1BEKs9PAr3pTt5FdUDx5Wh9RAUW5f0tuCI7174MmuunUTWzVIDJskLbaYFVRmW9ow/l3YuOO7i9Zfif7UgSdM2fvoNxgmmgeggq2mA4yDQ3nvszFH6bfo/PbjvzlhGx/I4g2bCe3eqqEBQV/Af9xDOQ1uyYwsY=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3264;6:5AeNEVmg1vXjUtOp5vPrWNpNApgP/RkTVBOtytPLgREt9XVoePF/MuaBvYVOgEd5bwtyle3CfoOSvptj3x+YXk5XfBp8Lip/0Utn11Hr8PApf2O3066DWcoN80rr1Tg2GD0fhrkA46r1P4RUsEtisntYU32HVrBu9YF/d2YFVAo24LqI1XbhdxM3o7N6xGNSp1n7ktdA1PN1F6ouVZ00Ggm1x2PAKYW2r1WvmUu/9HCzTkqLEWH6ZaCENIUw/uJ6KKjhvX9s/CSTBW+hjU3a9jveFwixioatqILfQgkE+tT5OCWirrEPFNlDl6RkrYMizoVV8GHMu6+sfNoCZwj8RUX50CUWzlBkW54HxoXKHiJIiCT8M/iNl1XO2GNbjuOi0krQlq+ATFBfEv2VVUGYbYsi/2UREAtZXiOz8j+pqQTTdFoOsKIyNLS7i4s1luBmmM1oMU000dsruIPeVJK6Sw==;5:AA3JOuctVFRgowYYv0IoYACyA5TKpnwbXoVkFx1YD+8m4uzXfh6dHVvjtHv8HZ/oDuCgndj65Tv3vkrfkjyRmzLMdnScbwz+KupVJXAd6290/2aN7qqqen6siFQDWVNxnDYAfsK/wIZWJrpZSqJlXuPJxpckkRX+lNxZpmyPLdU=;7:t2TBboUOn8j1Nm+FwNt8NzZph2S3Qfu6h6d9LTStg3AMzGS1BSidgs12/8lyxyMZkvi5FD7oh8y9BI8NRJq3sCglr0DYD4mH7xmNwkoYNUfVUabSz8W7fFdVl0c3wFcGn6h9k6NNKS5OeBrm8+rMrl8oTwRPFL0c4pseCBEgGt24zDhKzF59OWk6fTDrf5uRTeH2n2zx7OnGANKkpdTYTnVH7NBwC+/zUjkpyc/vV2xyh8nNf3HFWQkcR9M4GFwe
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3264;20:GVdXeE1aYIDoOsVpRwiW34LJJ5ClX8uZn4I7Tez2WuJfUg1WH2frJRp1g92zYqMlK5niMWhngXRX3cYRwE6uMn04rnjpGQpPxVFNZoe5A01Rx2ner0RxK5GjJJB4RcnziM5xzXm9HLhykbZbtcqovjY7SwVFkud4RfrlZmIciRk=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2018 14:42:52.6462 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63ce7588-48b5-40f0-7676-08d6222c02d8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3264
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/24/2018 05:19 PM, Bart Van Assche wrote:
> On 9/24/18 2:46 AM, Andrey Ryabinin wrote:
>> On 09/24/2018 01:42 AM, Ming Lei wrote:
>>> On Fri, Sep 21, 2018 at 03:04:18PM +0200, Vitaly Kuznetsov wrote:
>>>> Christoph Hellwig <hch@lst.de> writes:
>>>>
>>>>> On Wed, Sep 19, 2018 at 05:15:43PM +0800, Ming Lei wrote:
>>>>>> 1) does kmalloc-N slab guarantee to return N-byte aligned buffer?  If
>>>>>> yes, is it a stable rule?
>>>>>
>>>>> This is the assumption in a lot of the kernel, so I think if somethings
>>>>> breaks this we are in a lot of pain.
>>
>> This assumption is not correct. And it's not correct at least from the beginning of the
>> git era, which is even before SLUB allocator appeared. With CONFIG_DEBUG_SLAB=y
>> the same as with CONFIG_SLUB_DEBUG_ON=y kmalloc return 'unaligned' objects.
>> The guaranteed arch-and-config-independent alignment of kmalloc() result is "sizeof(void*)".


Correction sizeof(unsigned long long), so 8-byte alignment guarantee.

>>
>> If objects has higher alignment requirement, the could be allocated via specifically created kmem_cache.
> 
> Hello Andrey,
> 
> The above confuses me. Can you explain to me why the following comment is present in include/linux/slab.h?
> 
> /*
>  * kmalloc and friends return ARCH_KMALLOC_MINALIGN aligned
>  * pointers. kmem_cache_alloc and friends return ARCH_SLAB_MINALIGN
>  * aligned pointers.
>  */
> 

ARCH_KMALLOC_MINALIGN - guaranteed alignment of the kmalloc() result.
ARCH_SLAB_MINALIGN - guaranteed alignment of kmem_cache_alloc() result.

If the 'align' argument passed into kmem_cache_create() is bigger than ARCH_SLAB_MINALIGN
than kmem_cache_alloc() from that cache should return 'align'-aligned pointers.


> Thanks,
> 
> Bart.
