Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936515AbeCBQaN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 11:30:13 -0500
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:43608 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932746AbeCBQaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 11:30:10 -0500
Subject: Re: [PATCH v3 2/2] timers: Don't search for expired timers while
 TIMER_SOFTIRQ is scheduled
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, julia.cartwright@ni.com, gratian.crisan@ni.com,
        anna-maria@linutronix.de
References: <alpine.DEB.2.20.1707182206110.2425@nanos>
 <20170803210657.19179-1-haris.okanovic@ni.com>
 <20170803210657.19179-2-haris.okanovic@ni.com>
 <28f05e39-6bc6-99c5-e1bc-91be3e79ea78@ni.com>
 <13c06708-f7ad-4f46-1c0b-f12d1ca16beb@ni.com>
 <20180301164755.pipco45y5nlvmdsy@linutronix.de>
 <7079102c-f53b-e8ab-c54d-1c40ff21d921@ni.com>
 <20180302145232.anp4hz25uwqygopa@linutronix.de>
From: Haris Okanovic <haris.okanovic@ni.com>
Message-ID: <98f4236e-9863-2af7-1170-51cd118f65bd@ni.com>
Date: Fri, 2 Mar 2018 10:29:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180302145232.anp4hz25uwqygopa@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [130.164.62.119]
X-ClientProxiedBy: MWHPR21CA0051.namprd21.prod.outlook.com
 (2603:10b6:300:db::13) To SN4PR0401MB3631.namprd04.prod.outlook.com
 (2603:10b6:803:47::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a554683-3937-4915-b619-08d5805ad8e0
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:SN4PR0401MB3631;
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0401MB3631;3:TnX8F6ewYHGn8E6mkqYcjrbfbrgYSCj5XfJyO0a3LD/0ULlwp566ZaKwyCwkRllB2OHR3BJHcnwPLnfo050KazJ8b41nlvIb0Qf6I5Ym6XoMaweeLBD32qhGMRM45MSx4tNlH6tbThwNfDVMI5eAiYwV9ywiHdTKbZpYHjDrr/haXo3oIpHdTdb0tin5qHrRYD3lx35hS4/U6bZoCQksOcWYOE/gZ9m6b9XO1FutsOw+n4blLTwp8ru5BUQlCztV;25:iVQ2QihCdBIGMo3UhSX2pZ+JoCLZkcCYu5orFEv7sa1n2HU00fBljKjJ8CTw/qnyvSRg/x/oHOPO5ogh9xZb3MK10qs2l3vvkXho6wmtTra3whoDpaPkeI0yOJk/O0o5oB0KtP2G0/ZUm6etnTeXeq5dgRS+BLtRLMQMsr15MkfvAgYC/Yz5Jq0cZpK8nxWqXhxSOXosDCt9xrZ4K1jL5v+bj7WYg5EJixXDmZGm0a/Ndc4PydKFRso6VIIYwlWNOT4CYyIXdxVofAihwbN6ZLAXZRdYUlRBZ4p2U+OQGvFxR4YP3hdfiZ+iaqWgIKWrGO05QWyu3YvxWZ/qHPlG0A==;31:EVeojBib/1ucFmWG91ffjrbKYFynhd5jUrv/YpAqjPPEaBuFOqZuCPAI66WIEaM0QV8dOnUhJFbxTcPDF0EITFYDi+/qMNAvQODyqRck41H9s5ao1MZ2l3lm1FKB2tNz2rl2/j7euz83BO+PYynM25K5TELNWfMokDwcJXZSu5VCQylN0v9ViNt/0Q9aZXyRa0F59a7SJmnJG6KSlczCcosyY/8SB3uJccAFFijFIrY=
X-MS-TrafficTypeDiagnostic: SN4PR0401MB3631:
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0401MB3631;20:91IGGDDupXrTt552sDF79TbT9iCP102Z/kTuzat34N/PM7AKCU/dOQoxDQ2vwIzTOVdmUkpTbaxC/1ZCA7+Z/jNv7EXL3Z+Kg4LKvoB+OaXNiBzyTWTIDM8oLIsWvV+x81EKAjozQNnnphpm3PHDqcPyrCL/CKjyarG9l2+PdeXUoYXpLKdaSAGfhXdyLDggZOjxYnm3mwLN/pPzUkn268sSBrXfhNYn/XftpEfcb4xY1xIkWy90iHrdNB0ItRMiQBUB2bCp3Et6b0VNTHJgTxYUtYTNn6ZXD4ueAwVa3MLY6hdKLVyHX3/lGl+X+VBohpVhsTqXWPOYlUgR7GS0ICPjlblxy96/ofi0fmeIYhiemGMc3hgr372OCmJk3SnuofzzOdlVn1farIl5dNdbEWhNN2hiIoqhZ2w0ifZvkz7O/tLlyucoiXD+LZuxC31vHbj6ZkshdMIMc6qJA6f2+/DDFeRFfxSBowoilm6S/KerraQmfpqMElxN5XSthIIKMv/Xb2abSrnf63naC7Z/MwbJw6szLbwnb8dYpicUdsTaXpDsQqBt+gGiA+Ct44QmzzhPNUJQpTD8ntVWxRvVGdq+zC53U/LKbzgT2SpgAck=;4:9y7K9oe7v0+Msp1dWPCe1zluKmwvNtzHdn55dxBbIENYRz/zGISdZSvKVQqeFh+ledNZjCoPFYWD3ZjSlpJLnWz6u1TNYHw+kJKYpCNhHtDBAUBO2TGIcd0r30oxN6r6nP4gnqqbDlLVzXHuFYjbxi8RmPp24inZ0yf88CZgmtQlGiiXrk+qrtp1LFW7vbRLCQP0RgAwZrT3Y9idaJh7ChwIbHrEj0ZvmGPcOnjDsHMXB96KMmXC/Yua8/QAIFVH7YozciIffcvnD3RVJ+k2Bg==
X-Microsoft-Antispam-PRVS: <SN4PR0401MB3631E9C92E8BB407E0D7EAC9E5C50@SN4PR0401MB3631.namprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231220)(944501241)(93006095)(93001095)(6041288)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:SN4PR0401MB3631;BCL:0;PCL:0;RULEID:;SRVR:SN4PR0401MB3631;
X-Forefront-PRVS: 05991796DF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(39860400002)(366004)(346002)(376002)(189003)(199004)(377424004)(58126008)(229853002)(52116002)(65826007)(230700001)(52146003)(23676004)(2486003)(76176011)(93886005)(97736004)(316002)(64126003)(86362001)(7736002)(31696002)(67846002)(68736007)(478600001)(106356001)(6666003)(25786009)(31686004)(6486002)(36756003)(2906002)(6916009)(2950100002)(53936002)(4326008)(81156014)(81166006)(8676002)(6512007)(8936002)(26005)(59450400001)(386003)(53546011)(6506007)(5660300001)(6116002)(6246003)(47776003)(3846002)(186003)(16526019)(65956001)(105586002)(305945005)(50466002)(65806001)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3631;H:harisdt.amer.corp.natinst.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjRQUjA0MDFNQjM2MzE7MjM6dUhJWHZuRlJ4bnMwbGZmZVV1U0xjVG9a?=
 =?utf-8?B?clhOeHY5ZEhjWHIzQlVOZEE3cjRpc1JUN0FLeTZmS3NtQXRpSzBOTjlLa2FG?=
 =?utf-8?B?R3k5cWVHRytESDVyT29ucTB4OGRINFppck92RUttWFF6b0JYRUlFNm03S0xh?=
 =?utf-8?B?dVN5aXJ2ZWZRTDVLd0VVd1JNRzNGTFpVeENsM1VnQ3N0bTJyOEtOME1SWEZu?=
 =?utf-8?B?LzhJRWRlUTZUZk95OWVRQ3lVdUlZVkgveEZackcrRk0rWXY4QXkxWHhOSGgw?=
 =?utf-8?B?NjF3RjVWenYzSzVReUVkNGhEVVdoQm9RZC9sMS9mNTk0aFVrQnZKRGR4U2pn?=
 =?utf-8?B?bnpwWnNTcDRiclZhMXR5VmhkV1djNllrNjZuZDZmWXdDaTk2Q1lkZGl4dmNH?=
 =?utf-8?B?ejVvQm5FQzBWOUNXdzUrYS9FdkdhYVhWVzF3Slh2ZnhuNzUrSHJqQ25MVm90?=
 =?utf-8?B?ZVZDZEtPZURIYlJnT2VQZDBNR2lEaEJmUjZmaFJpSlgwTVRsaXVDZ3ZyYmxj?=
 =?utf-8?B?V2xYM1RSTkxRT1JYOWVZQVJWU1piV1B4dzlQbWV2NDJQT3hZT2lvQ0hUYi8y?=
 =?utf-8?B?SVFEVExicjFzUXY5ZlozR3k2QW1kckZpblhKdFB1eUM1MEM3U0xCeEFNR3Fk?=
 =?utf-8?B?SW5pd2hjRE9OMkUyL1lHM2xDdjNDR05FeVpNdndldDdVejd3U1piU1VnUEVH?=
 =?utf-8?B?ejl5V0xLcWVJcDBvRmNCbFpxM05HZTFpNVZUK2FmSHk5cVNoMDZUT0RoZGhv?=
 =?utf-8?B?ekJwS3JNSGdrNzRQZjNBRE9vMkVJTEMzVjlkTUdCbjNWY0h4Vm43ZmtQSEhR?=
 =?utf-8?B?YXl0dXRHNmhkYjJGQUlSeFE1REU5OHBUOVdQeXlxMWk3RzhpVFM2RGtNSEdl?=
 =?utf-8?B?Mk1BeTg3RHNBM29XZnQ2YkVWVlRjYk96TExxdjBSeTZKaVBzVVFPd1VzdmRv?=
 =?utf-8?B?V1F1OUlvWTdTRmUxQnZaSGJ3REFKTVVpNXhMTUpWbVlvTytqeC9STkU5UEti?=
 =?utf-8?B?V3NKaWN0cVFoeUZyd2NhVThKZSsvRTdMUVpCa3V6cS9PbVNlRW5qYUdodU0v?=
 =?utf-8?B?cUtiYWFqK2lNTkJiWlZDSk4yd0JJUUNwa21lVW9NOC95cHFBUEpiUTRwZTIz?=
 =?utf-8?B?T214WnUyV2J1bFJYaFZ3YzRBakFZdmZRMnpQZFByY0Q3VHRkcnUyKzVEN3Fz?=
 =?utf-8?B?ejNqem1XdjU4QVhhTmdxQWVFOGM1NmZXMXdLTmxDaWtHRlNiV1d4UVdWR2JR?=
 =?utf-8?B?WjZUSWtpajB0SWlPaFNmbWIxZTJ3RkE3Nng4cjJOKzRwZno1TXJGUjltam5y?=
 =?utf-8?B?UC9ucTVQVy9mVEV6cEtwQzhtMVdURm0wT05WOEpHZnJQOXYrQTRqcFdGbWZJ?=
 =?utf-8?B?emJWV0orQ1BWaENieXJ5SldOZkoxazRKekY3TlgvQzZuczFoSUNWZi9Mc3Fk?=
 =?utf-8?B?OWFnN1dGbkVpMDg2UXpRN1JRZE5MVk5rUG9TcXE2VVpGeEFZZHVWWGZSMlFO?=
 =?utf-8?B?enVxR2duYkJHM0ZubGs0L3ZPVThFeSs3a2FyY1J1dkRMTVFTeDNsR2JJZ3hC?=
 =?utf-8?B?cUJUWGE3YzZVMXVCQ0hYa2ZQUG83Y0RFME9ZWXhkVlRYQVBsSUkyamdwbTFH?=
 =?utf-8?B?SG91d1hjL0RwV2pJL1lIMWM0TEpIb2p4U3RXNm1oTU9wVXV2aUo2S1pkSTFz?=
 =?utf-8?B?NGxDMWZZelhnQUtSSmhCNnJyS3Q2NHB0YjVHbDJLQUpDVVdJcUttMG5MOWpw?=
 =?utf-8?B?TnE0WVNseE43NlZYS202SGxaa08ya2Uvek1WdlJiWFg3SHhPU3VuOEJDZHky?=
 =?utf-8?B?R3lSRHJhR2ZsZTBSeUc3ZmpjTTFORnR3Q2hLbVM0ZzcyY041R0NORExSUVRp?=
 =?utf-8?Q?PAJXpHhxQEqZookuiwfPkH8tpdhZ68jV6R?=
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0401MB3631;6:siLGuV5b0uys0m2+6/3F/AnBdAgydX7LBsATDEHx/iFV0/R7kMm/Qfb8DvQ6MFeOn144MXiukiF0pW/xnfToSPNESPw+D81l03gCrpuxcnwDcz2YbbYBwoSc2kWANX7H27+4Bq7TSnr5daNnFLtxFOb4omwHZwwBUmTfIGQNsYhqB4voi3GZpVFGOBITD/hv4/m2/khI/SsyOgE2apzZPyu2IZIEWHhUdIzX5lWuDqU7BezwhR7spXdiGbf6kWZv4A3fgbMFXm0ppjNhFJIeSTOUM+8bL+kjoGe3b6litW8lO9LUwhB/QH/bLhVlCyDHl7xplvNTKuvUm8NFEPCildbhqbA57hNhXx1MgRA1yK0=;5:r3PtIcpj8Oiza5WuQ03qDgHYMnyx7tpEYUc7Uwnq3oHkrScpdpQKUKFHwibBsPl41iFbQTLMVo31Q/b3ECwC5T7xyohy63tV7IQsCsNXvg2Nan6NZhIYSZjrEXFcUVGplWtlWEKiwE6vBA66cdSYjhiui4K4WhHJ/ESRlK4PG+M=;24:Yy7QpLbnf4N96j5ORzR7crIZv6bolSvPtq/Z0RmUb4K6YWUNHqNHyoxn3LrZ/izTbIaVXRiPKk7/W9eUP0e3rFHcZ+WmS9QX0ZbztBTNZRE=;7:TBnrkmyuSrzVrzLK7cdXxRLbgh2SN4hhAxw6acitrQv9emxmzW96RxtDtLm9fD+qyQOGFKQIeWQqiYWPJczm/f48P0aALYmIf52JZbZ7ABOVp5KgBmWPgJbzURDSpFl5R4LX7UdfZl+e3M7WKOZLKcodqsBazTzIz4VtAXAgbTipmQ1FRkk5i8668XSHq02aVaxMF0VQWsP8BFHoFyq3f5WbZVyd8Ux/ktFi2IAkS/f/yxoMzGMj4hCUzjaPzQp8
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2018 16:30:00.7279 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a554683-3937-4915-b619-08d5805ad8e0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3631
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-02_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_policy_notspam policy=inbound_policy score=30
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1803020193
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Could please point me to the code/patches or something?

I rebase onto v4.14.20-rt17, running some sanity test before reposting 
to ml (cyclictest & Anna's timertest). Will post V4 sometime today (US 
Central Time) if everything goes well.

Are you also asking for a 4.9 version? I'm fine leaving it out of 4.9.

-- Haris


On 03/02/2018 08:52 AM, Sebastian Andrzej Siewior wrote:
> On 2018-03-01 12:37:49 [-0600], Haris Okanovic wrote:
>> It was added back into 4.9 at some point after v4.9.30-rt20. I see an older
>> version in v4.9.68-rt60, for example, hence my original email. It was
>> dropped sometime thereafter, presumably because it no longer cleanly
>> applies. I don't see it in v4.14.20-rt17, for example.
> 
> It was removed in v4.9.34-rt24 via 95d4a348841d ("Revert "timers: Don't
> wake ktimersoftd on every tick""). I don't see any leftovers or an older
> version.
> Looking at the queue I see two patches from you and that is:
>   timers: Don't wake ktimersoftd on every tick
>   tpm_tis: fix stall after iowrite*()s
> 
> and the former is reverted. This was v4.9.84-rt62 that I've been looking
> at. Could please point me to the code/patches or something?
> 
>>> Is there a newer patch pending on your side?
>>
>> Not yet. The latest version on patchwork is OK, just needs to be rebased
>> post-4.9. I'll post a new version when I get a chance to build and retest
>> it.
> okay.
> 
> Sebastian
> 
