Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA9A4C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 16:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AA1627691
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 16:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nio365.onmicrosoft.com header.i=@nio365.onmicrosoft.com header.b="d7aDAtxQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AA1627691
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ni.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967372AbeF1QhQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 12:37:16 -0400
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:40680 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S965002AbeF1QhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 12:37:11 -0400
Received: from pps.filterd (m0098780.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5SGa0Av014758;
        Thu, 28 Jun 2018 11:36:58 -0500
Received: from nam03-co1-obe.outbound.protection.outlook.com (mail-co1nam03lp0022.outbound.protection.outlook.com [216.32.181.22])
        by mx0a-00010702.pphosted.com with ESMTP id 2jvdqwums4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 28 Jun 2018 11:36:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector1-ni-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MCvNDY+oLGNFROWfm2+wQWBhyppDQmbX7px9Dj9TXHw=;
 b=d7aDAtxQXm9wb2JwWy+WlGBQZLuBlDHyhgByn8H9PbK7NKtKVW4hW8HenXfVN6mOA/BtwffdycOEzt/Z7i8r+ha8Wo3kGHGNo6Bu2bVhiu6nbsMGwbVX+2c7sFxd019mE11b/15q9yTtpUrzbquw6+eOvy8pqYF9KxN5zCIokcs=
Received: from harisdt.amer.corp.natinst.com (130.164.62.119) by
 SN6PR04MB4637.namprd04.prod.outlook.com (2603:10b6:805:a9::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.21; Thu, 28 Jun 2018 16:36:56 +0000
Subject: Re: [PATCH v4 1/2] timers: Don't wake ktimersoftd on every tick
To:     Mike Galbraith <efault@gmx.de>
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        daniel@bristot.me, hokanovi <haris.okanovic@ni.com>
References: <alpine.DEB.2.20.1707182206110.2425@nanos>
 <20180306233944.11271-1-haris.okanovic@ni.com>
 <1523332961.4827.1.camel@gmx.de>
 <c2664fbe-52e7-1044-e9f9-de4875047ee8@ni.com>
From:   Haris Okanovic <haris.okanovic@ni.com>
Message-ID: <7d21ff63-3dce-b8ea-a0f1-81d53617747d@ni.com>
Date:   Thu, 28 Jun 2018 11:36:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <c2664fbe-52e7-1044-e9f9-de4875047ee8@ni.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [130.164.62.119]
X-ClientProxiedBy: SN6PR04CA0008.namprd04.prod.outlook.com
 (2603:10b6:805:3e::21) To SN6PR04MB4637.namprd04.prod.outlook.com
 (2603:10b6:805:a9::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e56ac8f8-cf21-47bf-ccd1-08d5dd155cd7
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:SN6PR04MB4637;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR04MB4637;3:LMIUdJZN7M20GielpKKlINsJ/4t7bQPnJKMw4wmCm9uZRcWH+pzZLIzIMPSA+kmoXsCl9iAF5oJ655hjWlHxKMl+gW9W9KAm4X5MIm9y+xL/yaeZTx/r1iRbtg7Vkpmj0dlV5bKSSssK3P3HWGJZkQYUaA8JhX+oj/aTC/wTrz4hIzDqpMXQcWuPnT+lzRMvdqORRZ03rVx3ZpsvszcxK8+Yn6FVIEqEmBq7OOW05HwbKGW3wS4ulrqCi4yDwu0/;25:znrh9IP/nqB4ex1q8y70q7NjMs9fPaXOlo9Uuwmzdwwr6NAzj90mpRMGpDdlwZyoUK2jLTd+Sk9PYiWlOMqkcXTxXco/UKjozT0gfvR5KPJ/r6YYAaEvjqKUclSd7kxOTlYsWS3716nHYCOvx4VPE0lSqArJNFAyOtZQiULQYOk7mb4Mx40gK7HFOSCDiZGomJxVMmm3LZCLx+lWOftcym5P4CT35c7iHGqIXLRO8KBGujyyGEPWhWVgDCogvWiG1Wk5otaou38ocLNOJNg9CmV0JLYLkE1HEsBF79cgW4oHekql6s4yXwg8RMD9r0JRhVPvx4FFH40hvjJkzYas6Q==;31:4s9LPxkcNfjJFGCEqEuIx+6oV7vjSiQtSFMlmh6Mi0npfzwxAl6qB7caGqfjlGy5PqVmIjW/2SyTLXYbY8FCBy6Htyh+Bfzd/c/BFPKYL5bapsXKzg6iC4OEgiFyrMpa3aHrIgEkI9M+fDljhTYfS11cWMI1X9nKqG9C1Kjj4sSO+pEA/M2tWlbegT22KmYu7+kdJXYqMUzox1LTnkfVc52ALRrenE+wygzma0QoEhM=
X-MS-TrafficTypeDiagnostic: SN6PR04MB4637:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR04MB4637;20:7x8y+H8G9PwKvSsXpTAcxGO77A29xPhTcFjHalpPNAqd+hsdun0ZHgWMAprppl1J2nPE6osOYpAsyltogLbzzypeIOjRoehpC0+L28PyhGk7abUkO9ATKxMEiIekFTFO+SDemoQQ89AbWNWr65omVKaElT+QKDNq36G0AMHc0lleOz5QWmJUArh9vSLo0jOzUfLQAVkNQ2+x2FQvustY50+PxDr+/5D+uD4KSPy51/iKyxmBaw+pN532jPGRgjoyV+j8FRChrNdNMT9e1vUeW5VAoYMD70mFP4ZOfYYsjNuuJwYaXABu949to/pyoQtzODSGNI5tXUPEXmuu2E7dMIMxmD6WuGK1rQnl1AZlFnjIA/aAmmAu9Cjb8WtEDTDkeZp1Jy23E7GFIkKGxQiuGObQOgdhrwYdPBX5BNU32C0HwdAsnEyu0/TCISrV9HANDcxfsaLsG/ZoPqOT+N021Ugu/Snr5MXlgq86n5y9eo9i93iQyrJFFrNTrFP2lVJgLnksQ8jr9usDpq5ilLVy/eEamzaBYvrle32CeC7jGx0Xjmz/MvSAm+tHPbG4FXWSHTKeRo6OsQXijnhZ9o6CLUvigFK/CgIVw5m32Dq9EwQ=;4:qzj7ADEqsr7U905y2/IuOD1m4VEtmv0Grxt3dQQKoEW/jdfBdiNSnT0v3PxVyadLUpOYRzAley+wAHMo/e+eAPE77tTQhwbDygk5KCxFtOsExhYjSYFue3CgcQNmU4iIj8ka13HOI1JqtTOQNlZO87rYJBeB9TyFvax+cCL2N3jiwIuqFLWQa5uBnFiumKpu0vpUmk48lDZJ3C88wJehs/sqYFWcUVsaUrMuITjvJ1Z2IRgkLh4WOUngJv6qlO7HUKFjrPfXjq1BKq8tXUP3xzAcihy25S8L1k1b9wZxAbnSS0yy+57P+1C9Kq3SdCU0
X-Microsoft-Antispam-PRVS: <SN6PR04MB46376AEB10BD917C1420059AE54F0@SN6PR04MB4637.namprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(211171220733660);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:SN6PR04MB4637;BCL:0;PCL:0;RULEID:;SRVR:SN6PR04MB4637;
X-Forefront-PRVS: 0717E25089
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(376002)(136003)(39860400002)(199004)(189003)(446003)(64126003)(2906002)(97736004)(31686004)(6116002)(7736002)(50466002)(478600001)(2870700001)(67846002)(58126008)(305945005)(93886005)(81156014)(81166006)(3846002)(65826007)(8676002)(4326008)(36756003)(6486002)(6512007)(316002)(25786009)(8936002)(47776003)(44832011)(23756003)(229853002)(105586002)(31696002)(486006)(2616005)(956004)(575784001)(68736007)(6506007)(386003)(76176011)(26005)(11346002)(53546011)(65956001)(65806001)(6246003)(66066001)(5660300001)(16526019)(106356001)(6916009)(476003)(86362001)(52116002)(14444005)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4637;H:harisdt.amer.corp.natinst.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: ni.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?iso-8859-15?Q?1;SN6PR04MB4637;23:tSukWsg26RjOCKseW6hq7Sk3R4tz9kOxO2ANRp?=
 =?iso-8859-15?Q?3mZaKjja9Fr9n3xhdz0mLHedPD1/zV58XJwslYVU6K2Sy6i4xNUFILhZ3?=
 =?iso-8859-15?Q?qoKwPvz6UH50ByL0FQCPlm6N77M3P7JzHmfKYLU17gBO5FdHEzhbeeFdv?=
 =?iso-8859-15?Q?lNvXjcYJD/OmZPw/n2qXMSiW7HmcrAxevNpdu9qZPMknB6yGYqwkoFHwR?=
 =?iso-8859-15?Q?BfP2nbAfT0F4W+41iycqDm0EZ8hFxdgrrp5Dc9bFcowFAZWFdxna/AQDI?=
 =?iso-8859-15?Q?m+y7xcaYWris2mttRCRvr7kyBhcNYkveuzC5TqaWFKZ2QXliqLTsPg8bN?=
 =?iso-8859-15?Q?3BoWl6vRxBmfYYNbpdqqV3p/Cc7lYKn8Zxw33UlPmo3GryFvnW2tJ1N/j?=
 =?iso-8859-15?Q?Xt5pFF1VunporU8DadCIh8DbjqPdkVc7sJJF8nsoxWNpjKIOhDCV5PE9e?=
 =?iso-8859-15?Q?ZbO/4r18GOAWBrKUp7oNiFWpDsj9p+E39dUnG3ZRVC5DjcshBWJei4BMX?=
 =?iso-8859-15?Q?wKL+uWIG0vD3wnyCjg00QafxJIpSHgngvhLilH/mOB0I7ttufjgNC1I/T?=
 =?iso-8859-15?Q?cYj7nBs541UA2cAloFw3Q6WPiWDEDMTgiUmpXfyMgvi+NbdPL4QBTYfJK?=
 =?iso-8859-15?Q?q3c6Ikmt7DiPrRyI/k2my2UfzlkNzEUmYla5h++AllaB5gwzotRJk+25B?=
 =?iso-8859-15?Q?7sCwfpqoeKFZAEaDxkQs49kVTss0fgtjeDd7f75F+5AQR0dGavziWG3Bq?=
 =?iso-8859-15?Q?B974gs2VyjI3MglWe+WzW9Yz7u4u2QKXKy4khWWbBb5jaBR5XFkOAXOjs?=
 =?iso-8859-15?Q?xOjyPqd3vszrEUm6X1Ne4CDgW24jn2QGuYF0Vy1bzy/FWssEsV1aX2X1F?=
 =?iso-8859-15?Q?/eS02A0b6hGnNsficX+PFNdR4tMRIDK+KiFhQRRV9fOKrlFlsFEmrKYVe?=
 =?iso-8859-15?Q?Ji/YBp1xYi5FeUKa9C4u8F7xW2DRdkageRz81RaruQpA7PuKPUk+1dpPx?=
 =?iso-8859-15?Q?4d3alLgCGBo2SCX/OGtFWY5J4hENod4aWn529AGyeeuar/QoPcJKShslj?=
 =?iso-8859-15?Q?2piHKpOt0ETU+58yhhG3PAxo2P2VYW1sYzdxKaESzgSmZz6nv2AOZDy4Z?=
 =?iso-8859-15?Q?FHJc5WWkeJMaAfsO0IHWvtJoRvv3x2udC6Hx4Z0FF9ZeGBTvniTmJPl4i?=
 =?iso-8859-15?Q?06qRhrRJIK0OOgIB6drevqjaUYncQCBlHTM+V9oz51okoHGxaeD1+Rzqo?=
 =?iso-8859-15?Q?yR264sl533V+xz2Uqfcj1FgF8Um8Koa67fMPhGgQ+s312KUvQxshg5Oxd?=
 =?iso-8859-15?Q?nCng3PPYsGoD3Stx/IBOoFA/+b7Oka2R2DFw3R8NQb+VdrJPkU49IdpY9?=
 =?iso-8859-15?Q?PglF4G4qAZAbVmvFxwNslaA8GRJAMiawQxc3QLk62j0GO2NHViJesu3gG?=
 =?iso-8859-15?Q?XZ4zzaAZARhHkyDAQKQfr0T7jrs7v/4j71CxwWruq66AU9gRMj9/sSmG1?=
 =?iso-8859-15?Q?8B6TAjFBfrF+7Xt1tk+zJ+GQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: TaiY6J+cx0BoN1KUvYmBuu6m0C/I7hvOoUK7eyfZv7Btle9MuVx7y1EZb5ScG3QHq4YwxpCRWjQDa5O08m+CTdks1KHNxcgJAe+TVL0lZiEM4CTcoIhLGNkYu58cuJhlE+rxJvk2728vWvE+78SWC6eqsMwUVPyKPVxSwQMpk1biu55xwIhAQpSMJCrWm0hODhr4SlKZRfQUb/zAF2EdOTsCoMKwwH/OSP2JaMSIi8LROpX/QjVRr/UCLQUe2oAebRaGpZ2W3voUbyNmC0NMffJffcvr1IrkBJ7z8SUCsj6JpjhHgy+axXhN3fpXj9VNnyI1j9QwYPRmgSoigbvMzV4EpIJ0lsHOaf4+Y+di1D4=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR04MB4637;6:zHGAJho7aJKkkcd/rMvfkCgI3bl2aAbLqgIsqlQzFG24z1RRcdqT13tstvbkoJZS5ePns60DDhlvvhDJ+6swCsFR6kioh11fEsbSw6f4nQZddyG1J7fJL4u856y0qORX3LHB01Np4AExsV6fQFpXbLDX7Qr4nFPZIch5jWDr4gmGQWfTcznwouMACl1wKpxwvr9SoNMBGLTUZIf2I3yi0hWbe0yDoTGZ4CpYZKMxuIsqkxQAVRqNslfoUa0TGjT2AClfvDuoiNTn0O3gdTeVQmghL+yPn4wA67S+0hbXMDj6nBposSSM8MWXZqGS3ehZxZTeud05NKm9NKizTFmFgcfWmBf+f0iSLGl4Fm2aRWQVTMS90wGUVAnKHxyF7/peKU4JdKR9oXGDvvD//LXbBzD3mfsSNYkTh9dZ281PMbg+K2uRbp2UTcNM7TtkIEUqo0Wzq91R0KxxAmiKXX/iaQ==;5:AqUEM1iYkkqBDOeMkhHDyttscDiPEFnjkJJSXvl91uXkS/ixpLmlhzvLAqz6mR6AEeXU2+uru33i+O/H/PQfmAskSKD1oxIUgcDD6J63wThB0AhHdT9B6LD0WucMjG4JmOcSFeiLB9eI0dQLeJZx2CLC6Y1gx0VZXqhWqYOrWmA=;24:sfZfN7sLFsmMQgespW7rgjmqPpQEd5D8MzVJ1vekGwo7JvMf1axCGJlqGEgOvnus88A7i5jOBf8DupLImdc5SPA/78SV383ReBA1ke8WdUQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR04MB4637;7:BW6k+zXTF4/upoDr+1Dw9Ry4XAnL1X6gd7Y9F4nXOUurMexUULQNJ0qrqKGHBs765ldNSOEbTPJIwJIjfdb0VyLKHnFmyYaNI729Jfe7XgU18yH4WTe+LEqXGs3RJ3on/jatt22p0n4q+Yifb6CaQuwFKbSCHDkFHcOWMmwiOqkO8T6frN25pcqyVxAL2tbh1X+/qUSI8YoDg4OzLnGEC7iMaTB2LRaydqqFH866dfibBElK1D9p2n0OFuHjI6dY
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2018 16:36:56.3110 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e56ac8f8-cf21-47bf-ccd1-08d5dd155cd7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4637
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-28_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_policy_notspam policy=inbound_policy score=30
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806280188
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I found the problem: Running `dumpcap -D` (E.g. by wireshark) creates a 
timer that's sometimes re-armed with 0 timeout in it's callback function 
prb_retire_rx_blk_timer_expired(). My change introduced a subtle change 
in __run_timers()'s stop condition, which causes ktimersoftd to spin 
when such a timer is present. This blocks all other timers including 
those from workqueues.

ktimersoftd stack:
  __run_timers()
  [...]
  call_timer_fn()
  prb_retire_rx_blk_timer_expired()
  _prb_refresh_rx_retire_blk_timer()
  mod_timer(..., jiffies + 0)

The current implementation deals with this corner case by deferring 
0-timeout timers to the next tick, where they expires late. I'll submit 
a v5 shortly to match this behavior.

Thanks again for reporting this issue, Mike. It's a good find! And my 
apologies for the late fix. I've been busy the last few months.

-- Haris


On 04/12/2018 10:00 AM, Haris Okanovic wrote:
> Hi Mike,
> 
> I haven't tested the patch with wireshark until now. My system also 
> hangs shortly after it starts. I'm pretty sure I hit workqueues in my 
> earlier tests via the block driver, but it's clearly not whatever 
> wireshark is using. I'll look at it and try to post a fix. CCing the 
> list to avoid this patch until then.
> 
> Thanks,
> Haris
> 
> 
> On 04/09/2018 11:02 PM, Mike Galbraith wrote:
>> Hi,
>>
>> Are these patches dead, or are you planning another submission?  I ask
>> because I discovered that with them applied, firing up wireshark hangs
>> the box 100% repeatably, with wireshark never fully initializing.
>>
>> Applying them to an otherwise virgin 4.14.20-rt17 to be sure...
>>
>> crash> bt 6016PID: 6016   TASK: ffff95dd68572180  CPU: 2   COMMAND:
>> "dumpcap"
>>   #0 [ffffb490094f3bc0] __schedule at ffffffffa56d55b9
>>   #1 [ffffb490094f3c40] schedule at ffffffffa56d5a03
>>   #2 [ffffb490094f3c58] schedule_timeout at ffffffffa56d8467
>>   #3 [ffffb490094f3cd8] wait_for_completion at ffffffffa56d6e34
>>   #4 [ffffb490094f3d18] __wait_rcu_gp at ffffffffa50e59cd
>>   #5 [ffffb490094f3d58] synchronize_rcu at ffffffffa50ec14e
>>   #6 [ffffb490094f3d98] packet_set_ring at ffffffffc0c74da0 [af_packet]
>>   #7 [ffffb490094f3e50] packet_setsockopt at ffffffffc0c75d23 [af_packet]
>>   #8 [ffffb490094f3ef8] sys_setsockopt at ffffffffa558a5e2
>>   #9 [ffffb490094f3f30] do_syscall_64 at ffffffffa5001b05
>> #10 [ffffb490094f3f50] entry_SYSCALL_64_after_hwframe at ffffffffa5800065
>>      RIP: 00007f3107a1cfaa  RSP: 00007ffc9745c2e8  RFLAGS: 00000246
>>      RAX: ffffffffffffffda  RBX: 0000000000000001  RCX: 00007f3107a1cfaa
>>      RDX: 0000000000000005  RSI: 0000000000000107  RDI: 0000000000000003
>>      RBP: 000055ae1d8eb470   R8: 000000000000001c   R9: 0000000000000002
>>      R10: 00007ffc9745c350  R11: 0000000000000246  R12: 00007ffc9745c350
>>      R13: 0000000000000000  R14: 000055ae1d8eb200  R15: 000055ae1d8eb2d0
>>      ORIG_RAX: 0000000000000036  CS: 0033  SS: 002b
>> crash> dmesg
>> ...
>> [  483.808197] BUG: workqueue lockup - pool cpus=2 node=0 flags=0x0 
>> nice=0 stuck for 52s!
>> [  483.808204] Showing busy workqueues and worker pools:
>> [  483.808206] workqueue events: flags=0x0
>> [  483.808208]   pwq 4: cpus=2 node=0 flags=0x0 nice=0 active=1/256
>> [  483.808211]     pending: check_corruption
>> [  492.695124] sysrq: SysRq : Trigger a crash
>>
