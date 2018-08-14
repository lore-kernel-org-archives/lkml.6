Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC3AC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 15:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D5A4216FE
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 15:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="KixW6422"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D5A4216FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732704AbeHNRxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 13:53:18 -0400
Received: from mail-he1eur01on0138.outbound.protection.outlook.com ([104.47.0.138]:61101
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728880AbeHNRxS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 13:53:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W2XuOSOQDHAz3NGPrgp9LuMXJGBcTBlrzNr3CGnl/aI=;
 b=KixW6422SXa0o8MJc7B9S3p1AyPNfmzX+tz45ZvFnlFlIYtztdiIrsL7bCU3CQsbEXwe7bypqC6qNeIzYaG221aC7VTzeETh1+N2LzZntqxUpy4kedKIgXltSsMewbwkEQ+D4R12Np0pSf43JmYU6+marBGf/TbkPKN6dDVz780=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from [192.168.13.3] (85.226.244.23) by
 VI1PR0201MB2464.eurprd02.prod.outlook.com (2603:10a6:800:55::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1038.21; Tue, 14 Aug
 2018 15:05:32 +0000
Subject: Re: [PATCH v8 3/4] drm/atmel-hlcdc: iterate over all output endpoints
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        jmondi <jacopo@jmondi.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        David Airlie <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Jyri Sarha <jsarha@ti.com>, Daniel Vetter <daniel@ffwll.ch>,
        Russell King <linux@armlinux.org.uk>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
References: <20180810130359.9882-1-peda@axentia.se>
 <20180810130359.9882-4-peda@axentia.se>
 <20180813135949.32vrlrevtazr5x7d@apu3b.nibble.pw>
 <0baac94e-f3d2-53fd-4af9-854bb4498345@axentia.se>
 <CAL_JsqJPzwpN2TFghy-FfHZppexG9gW4qBy6iYtGpyP_Bp6dUA@mail.gmail.com>
 <5c9853fc-e2ea-6983-ac88-b52b6e9e6ecd@axentia.se>
 <CAL_JsqJHRL0f2YwvOJBpggKRVQwPWy8j08-+_nd-VifOOKYqFA@mail.gmail.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <56016787-0487-1571-7c28-2767033cda23@axentia.se>
Date:   Tue, 14 Aug 2018 17:05:29 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJHRL0f2YwvOJBpggKRVQwPWy8j08-+_nd-VifOOKYqFA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR09CA0082.eurprd09.prod.outlook.com
 (2603:10a6:7:3d::26) To VI1PR0201MB2464.eurprd02.prod.outlook.com
 (2603:10a6:800:55::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21840093-4833-42ee-8de6-08d601f7629b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0201MB2464;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2464;3:dbIex0OcayZ03GeO5Tf8ciLOXTaPpENrXwcC4ALue4xH7hMXuIabZO+IPVGFBVmoJipkpAuMlQQKY+vsuq7Q1fRXjaF0kHCsj4clp5Mxx0vOtarHMpv6LE42Lp39jIaVQdU638kNL/gMoJknoZ7fPsqjW9h0GSJHYwogKUPG5btl9NXqTNaPgk7LGEk0cPZu7VOtqmh7M2ooBV6IKOgyzVYaTH8iOuZOaTK9AfGMelIarfWu5z2kyfgsD00as8b6;25:sxUQgchvHHua11JExqT3Q/wWUMekUQiHinZk0muj0DGNT36j4MxNTeSHOs8dimE0acNyvGl8mIZtF9yEQ7ieu/Y+3yYNjC40WPBFFGYMeXmrILP9C+pdGVxA3ujbq5yut5GLla0DDqfH8hzTxZNWqwnHERFSuC7So/IE6azH5q6jxLT/LFEjborj2XG/piwTIlDe/4QovpEKJxgQ/JG/c/tX84Mn//OFKz5T/k/rgrojdawUmPDcy8NZ71keE1MjTnNQZbuXEMxsOpB0ebo5Dm3apvyys+W0R/WCA80Jms0agfET8FwC3GeOk4La+P03/FiuRQAr2zuhC+igPebyyA==;31:qXXnsv1QQo3mBS+PBAluBLy/ebRwapDSAnT2437RC3pLvTg8NEZqqQUJTsevA8WZFj6BdB7Vxmp9akoue+UqjVV1Ywt0ub46VD2iuK9uCSv3+YvfK4GYomijxRcO3pn8w6f6qEWblrvaKaFnS7kN257prCxfaUIaC8e8Prmvo3nv7m22tvkeet5nx6sqTvSPqtal7DaqxZHIYRutlX3m6o9/DBZukan+z9k+NqtA3wY=
X-MS-TrafficTypeDiagnostic: VI1PR0201MB2464:
X-Microsoft-Antispam-PRVS: <VI1PR0201MB24642CEAF4A167F0678EAC41BC380@VI1PR0201MB2464.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(2016111802025)(6043046)(6072148)(201708071742011)(7699016);SRVR:VI1PR0201MB2464;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0201MB2464;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2464;4:hLC8iwjbnw+kxKRHWGYT9WYKGHWyTXCno/O0BHIx1h6KkfDw2SRMVrIUASVCRPp362PHEEyl1GnCM3h3JgLhbQbCMt60RiRd652sXNNVMSa71pz/Rq0LUDgppNWa/C7mhI1Te/0SNdCbMUBuKX0nGsFnfRuYz2LCZG7Udy33bDgdkdm8soHEwGzuVx47xvR1DNYkgIjBwtlWE/6q7y1xnDd2gZsfOvq3xUhbM6UQ5ENy+6jLZy94wQj8BUK/RYE158zRl0sRCKK9C1ktQLNquw==
X-Forefront-PRVS: 0764C4A8CD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39830400003)(366004)(376002)(136003)(346002)(396003)(199004)(189003)(53936002)(3846002)(52116002)(6116002)(106356001)(50466002)(93886005)(7736002)(31686004)(478600001)(6486002)(105586002)(64126003)(446003)(486006)(53546011)(2616005)(81166006)(305945005)(476003)(11346002)(81156014)(97736004)(8676002)(956004)(386003)(2906002)(36756003)(8936002)(2486003)(52146003)(23676004)(36916002)(31696002)(76176011)(74482002)(7416002)(65826007)(230700001)(16526019)(5660300001)(26005)(77096007)(4326008)(186003)(6666003)(65956001)(65806001)(66066001)(47776003)(3260700006)(14444005)(54906003)(229853002)(117156002)(86362001)(316002)(6246003)(58126008)(5024004)(68736007)(16576012)(25786009)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0201MB2464;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjAyMDFNQjI0NjQ7MjM6OThJbXVtd0VpdEcwbGNVWU9IZDM1azRy?=
 =?utf-8?B?ZDk5VXo0QkFpUjVwblVVb1BKNlpkOERoWUtDS2NoT3ZGazNSZjNiK3JXb3Z3?=
 =?utf-8?B?MFdtdmtzcHpsbUN4UjM4V2ZUazQ3NkVHMytncXJ0akZ5dklNN0l0R2xmOUFk?=
 =?utf-8?B?SXN6WkR5bnl5QUhGL2xCcEVRSlA4WUZZQ1lnalZ4ZGNFTzdoZlBJcC82Q3Bk?=
 =?utf-8?B?TzBGem9EY09kRCthMlNUSWpOeVlyRE96NnJtWUN4alFVWERiaDhMdUNwc2R0?=
 =?utf-8?B?ME1KNldwbnJpM0ZCUEtaaDFEVExJNHJJdWJ1QUY3bTVJaWwvUHhSTGtSUmRG?=
 =?utf-8?B?a21kWE5DMEFiVVdtdHJJYytxeXFYanRRYVUrNWdYSUl0OEFueEhPdEZ5amVw?=
 =?utf-8?B?ZGM4cnA3eUdNSmJsa3h5YTQzcWk1MnZVQmVESll2eXVFTUFBVlBZckQyN1Mx?=
 =?utf-8?B?Nk9LdVdlMFNFNVF5c3VBbnhxK0pPMU43UWxUdUpOR1lUbjNoVmtSRVN2Uzlr?=
 =?utf-8?B?UjJrQUdhV3pTakpTMGN4NFd0TmZjYW5ZdWtKb082NVBnVm93WmIxV29uUWJx?=
 =?utf-8?B?YkpPMXJyejlBcy93S3orUEdKdHdXcUVzMEVHVHhJVDN4V09oYW1QOE1reGda?=
 =?utf-8?B?N2M4TjBWTVhlQ2VJb3JpWG40UzE1WlRJeHY4eDV6T1dhRUltbWlKVHQ1dGlr?=
 =?utf-8?B?K0lqdERURWRyaHQ3cld1QTB6TGY0bEFUSkI4enRqUlVacVRBcFNMOXhzZG5i?=
 =?utf-8?B?dnIzeFZubjJZSXY2OXN1c1FDWXA1TzMxSWVMVzFIeS9aUEJZMGtTRVd0M3hJ?=
 =?utf-8?B?akZ5bjN4VUlIYmJlTGlydDhveTJIbnAwNHZQdWNQcVoxdE96cFJSSk40T3hz?=
 =?utf-8?B?bFVZQkxteDlyczhybUNWNDlrUGIvWGkyMmJGUTk0bHpUN0JTTDBWSVBXUFZ3?=
 =?utf-8?B?WW5hZTBiUGFIeTBjVUxMbWZGVVVOenRFT3lseWhNcVBsNWhvZUhlSFJFSkhW?=
 =?utf-8?B?VUtvVXkvenppS3Voc3VUZ1pmSnN2R0srVXhtOEFkR2RCNzBwQjF5WmFXbmY0?=
 =?utf-8?B?eGQ5S2hMazFteitBTkpnWDFBZkl4aUhnSmppdFlFMHQwdzBoT29JZVc1c0ZP?=
 =?utf-8?B?SmZwcC93NHJxdlBuNU1UK2JsSFBScFRJUzRNWjRpcUh1QUVqT1loRU9ENVl4?=
 =?utf-8?B?YWNJYVBoSkNjMUp1T3ArYWhUYU1XN1pmd0M2RUkxUWFhZ1ZpZ0paUHFDMXNi?=
 =?utf-8?B?cUF1dkZHbk42cGdhZEJGMnZMT2k0MXMxRDdKNFJEYmFnbEVKMXlpVUdSTDk3?=
 =?utf-8?B?MzI1WmxEcTJpV0FNT3EyQXFjaDN5MU11UDFEeXRiSUJuQ0hST2JZdnVFbXRl?=
 =?utf-8?B?Y0VPY3lOT0M1a0RjenJGK1ZBYXhUSXdldEhsZ2JjWUhVV0lsOGphaHJ4dzEx?=
 =?utf-8?B?QklLdXIrLy9TVFlBc0J2N2tXeTVEN1FUdUk4Wll4WXE5TFZCNS95QUNiRXU4?=
 =?utf-8?B?b3RPc0RJUnI1bVFSY1pkN2VmakpkSDJXay9PeUJUb1pORzZCZnRyYktWSmtp?=
 =?utf-8?B?Y0Ntc1ZWb2wxV01tSlhHNEhIbTUxV2M2SWpSVlpLZDVobXpDTEM4M0oycWdB?=
 =?utf-8?B?b0RmTjJDSkUzb0lFQUxxdEpscVU0R05ONWVGTFNFNGJqeVhST20ycHVCQkM5?=
 =?utf-8?B?MFM2NGRRVXdRSkwvSnF6SFpwS1M4OHpKQ1BuNXdsRDE1US9HUTRCUU5ySURL?=
 =?utf-8?B?Q3c0aFhtUExOVEpzTnlrNWpXRzRSZ3JZd3R1YVJ5a1I3c2tzQmNja09sajZh?=
 =?utf-8?B?cDdRWHkrNW83L0hCT01LRW1CN2N0WUZ0UGlmR0U1RXkyNmsvWm00eXRaTUJw?=
 =?utf-8?B?NFBKSkdVWmJYMzhVc21jWGpFZGVCckpMRTYrblIxMEdIb0I3aXJjbVdxeXBL?=
 =?utf-8?B?bEVkY01uSVUzQVVTVGhFQTY0QWswUUltL3lWWDlkc3lBbEM5MnFxVEd6Rnhj?=
 =?utf-8?B?QlN5Y0tESnNLQjRtakx3TE1aeGlBZ01RQmVxTktxZGsxL0h3L3Z5OHJuTnVB?=
 =?utf-8?B?SXoybUtqcUl0Y05qUm0wUFd6QXo2bTRGTzlDSDZaZUVOQTg0aGU4OXp1Ryt0?=
 =?utf-8?Q?QCEre9o3af0TAvWogq6TVCvyH5y9ox8BMEnf33Rwwmhqen?=
X-Microsoft-Antispam-Message-Info: IOgoDsm/g684Hgf/XhpSL+5UPl3n5DZXMMhKdt4XrZ7/6M808Tlipg3K4GdAf+SrKOf2jmJbWAdxn7PCGxY7X8gtFIeGp1/Tf1AjFMOTZrL0Bp6+Ewxif2jReLTIPf2pZmajlB1LFUoIX0Gfrver4Gy8JbPxCPfEEP1unZvB/VTOHeDk2P9HUr4JDL1crR9J5U3dHRRemNtVDUIF81uxmTx8BWkk6gwo7q2YgmLD/kCcEpoyt7Y9Xo3IvEmW5lpdtXa9h9ekREIkgerafUam3YSkRP4ijfcTtkDyPCyd/MbWsytIJ+PsAc8d7cOTKa3ESsOG/r3WTZNAag/jJppBM0Kihsssxk1r8yvBoi/7h3o=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2464;6:iG4LRFESBA2lemI7hUq4G/qaZmQzXnthD48exOQDnHKcEofhCZ/UfI9oGhqChX48y9LzrbEFF0WCMt40zREkiOfqREU+rGqAveAX9I30sLES12M0gEGAk0uaEaCIzfCeNHete64m42mKaKLTDR1LlSE0yefpK+I2pEfT9QhtGqcCMhBnkIGHgWGSOeSSCSU0J69lahmMBTzWTitcS5+fbRlANmee9cVYNrduGK41oGGoZ/JnTqXgEf8hRM4OHAIjFfTY2vB7T13UitT/nRAfXxe1MRlBTWi7+VWWJz/Ws4F0mYYYmJLjLR0zej5pOpdA+fpibeZTNW3kBp4AYmDJPGnrH5y7jKlUMtmbS4pDkUZwpsbwVrZfrD1noPmDNuJFZvsXMVoQrCtKaxyahlUmSe+Qi6tqYltwUwF0l2bBG50Bv7bBKmWIn6zUzTHhctaTAkxDV+6vXz6nszueHKAK7g==;5:HE3SfScaMhEyVmmXPlytEUy7C6A5vDQYzl3sqAiym/woKMiUCJJ2ri7Mi0Me+cs+LySVc4fAdakLPh+wv+3u6/jvKhEa3O+nVYuuckUHrASWkLfZQdyCDdXyaps5H+dEzrtX+ecmTsXXzy23vu1YR5i7PT5fV2WwQIqhcGFKc7A=;7:zEY95YMAyZJ/Mn9t9voIVT14q78o2G7T/dNj7RoK8bw1B8rLJFckMUT9eFxuYH1b8XUbdY/RufbDyBhY1IFVejiV3oroykPCch+2RTfbAV+CbsL3y053Y2ZegWNSqUU20trwJRJirHZTEiLhvxEeeAo6DrddkUQOhNg2QgLtZ3SjKIo9U6cpThF3NQjEkKsa8EnjGGiKa6lLHC53R4Z2SnldsZWWCI2k6bZnCn8KjoiBoxu75gUQ3pzAWatwxXyh
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2018 15:05:32.8821 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21840093-4833-42ee-8de6-08d601f7629b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0201MB2464
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-14 16:33, Rob Herring wrote:
> On Tue, Aug 14, 2018 at 12:36 AM Peter Rosin <peda@axentia.se> wrote:
>>
>> On 2018-08-13 22:52, Rob Herring wrote:
>>> On Mon, Aug 13, 2018 at 8:25 AM Peter Rosin <peda@axentia.se> wrote:
>>>>
>>>> On 2018-08-13 15:59, jacopo mondi wrote:
>>>>> Hi Peter,
>>>>>
>>>>> On Fri, Aug 10, 2018 at 03:03:58PM +0200, Peter Rosin wrote:
>>>>>> This enables more flexible devicetrees. You can e.g. have two output
>>>>>> nodes where one is not enabled, without the ordering affecting things.
>>>
>>> Your DTs are not supposed to be flexible. They should be well defined
>>> by the binding.
>>
>> I feel the need to explain the situation with more words...
>>
>> We have a board with this atmel-hlcdc wired to both an LVDS encoder
>> and an HDMI encoder. Depending on how we integrate this board, only
>> one of these paths make sense. Hence, I would like to do the following
>> in a .dtsi for that board:
>>
>> / {
>>         hlcdc-display-controller {
>>                 ...
>>                 port@0 {
>>                         hlcdc_lvds: endpoint@0 {
>>                                 reg = <0>;
>>                                 remote-endpoint = <&lvds_encoder_input>;
>>                         };
>>
>>                         hlcdc_hdmi: endpoint@1 {
>>                                 reg = <1>;
>>                                 remote-endpoint = <&hdmi_encoder_input>;
>>                         };
>>                 };
>>         };
>>
>>         lvds_encoder: lvds-encoder {
>>                 status = "disabled";
>>
>>                 ...
>>
>>                 ports {
>>                         #address-cells = <1>;
>>                         #size-cells = <0>;
>>
>>                         port@0 {
>>                                 reg = <0>;
>>
>>                                 lvds_encoder_input: endpoint {
>>                                         remote-endpoint = <&hlcdc_lvds>;
>>                                 };
>>                         };
>>
>>                         port@1 {
>>                                 reg = <1>;
>>
>>                                 lvds_encoder_output: endpoint {
>>                                 };
>>                         };
>>                 };
>>         };
>> };
>>
>> &i2c2 {
>>         ...
>>         hdmi_encoder: hdmi-encoder@70 {
>>                 status = "disabled";
>>
>>                 ...
>>
>>                 port {
>>                         hdmi_encoder_input: endpoint {
>>                                 remote-endpoint = <&hlcdc_hdmi>;
>>                         };
>>                 };
>>         };
>> };
>>
>>
>> And then, depending on what components are fitted and what LVDS panel has
>> been attached to the LVDS encoder output, this can be used as follows
>> in the .dts file for LVDS case:
>>
>> / {
>>         panel: panel {
>>                 compatible = "litemax,dlf2118", "panel-lvds";
>>
>>                 ...
>>
>>                 port {
>>                         panel_input: endpoint {
>>                                 remote-endpoint = <&lvds_encoder_output>;
>>                         };
>>                 };
>>         };
>> };
>>
>>
>> &lvds_encoder {
>>         status = "okay";
>> };
>>
>> &lvds_encoder_output {
>>         remote-endpoint = <&panel_input>;
>> };
>>
>>
>> For the HDMI case, it would be this in the .dts file:
>>
>> &hdmi_encoder {
>>         status = "okay";
>> };
>>
>>
>> The above seem so much better than just having the following in
>> the .dtsi file
>>
>> / {
>>         hlcdc-display-controller {
>>                 ...
>>                 port@0 {
>>                         hlcdc_lvds: endpoint {
>>                                 remote-endpoint = <&encoder_input>;
>>                         };
>>                 };
>>         };
>> };
>>
>> and pushing the lvds-encoder and hdmi-encoder nodes (slightly modified) down
>> to the relevant .dts files. Especially so since we have to this point
>> delivered several variants with different LVDS panels. The duplication
>> is ugly, and the number of different panels is expected to grow...
>>
>> But maybe I have misunderstood what endpoints are all about, but to me
>> the actual endpoint id is not that interesting and I see nothing in the
>> graph binding that suggests that endpoint id 0 has to be up and kicking
>> in order for endpoint id 1 to be examined at all.
> 
> I guess it depends if the numbering is significant. For a one to many
> fan out like this, not so much. For a muxed input, then it would be.

Right, the endpoint numbering certainly *can* be important for some cases,
I can see that, and am not arguing against that part...

>> For ports, yes, you are right that the port id needs to be defined and
>> fixed for a specific function, so scratch that. It was just a "maybe"
>> question anyway...
>>
>>>>>>
>>>>>> Prior to this patch the active node had to have endpoint id zero.
>>>>>>
>>>>>> Signed-off-by: Peter Rosin <peda@axentia.se>
>>>>>> ---
>>>>>>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c | 32 ++++++++++++++++++------
>>>>>>  1 file changed, 25 insertions(+), 7 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
>>>>>> index 8db51fb131db..16c1b2f54b42 100644
>>>>>> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
>>>>>> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
>>>>>> @@ -31,14 +31,16 @@ static const struct drm_encoder_funcs atmel_hlcdc_panel_encoder_funcs = {
>>>>>>      .destroy = drm_encoder_cleanup,
>>>>>>  };
>>>>>>
>>>>>> -static int atmel_hlcdc_attach_endpoint(struct drm_device *dev, int endpoint)
>>>>>> +static int atmel_hlcdc_attach_endpoint(struct drm_device *dev,
>>>>>> +                                   struct of_endpoint *endpoint)
>>>>>>  {
>>>>>>      struct drm_encoder *encoder;
>>>>>>      struct drm_panel *panel;
>>>>>>      struct drm_bridge *bridge;
>>>>>>      int ret;
>>>>>>
>>>>>> -    ret = drm_of_find_panel_or_bridge(dev->dev->of_node, 0, endpoint,
>>>>>> +    ret = drm_of_find_panel_or_bridge(dev->dev->of_node,
>>>>>> +                                      endpoint->port, endpoint->id,
>>>>>
>>>>> You are refusing endpoint->port != 0 in the caller, so that could be
>>>>> 0.
>>>>
>>>> Yes, it could. However, I intentionally did not write 0 here, so that
>>>> the logic related to "port has to be zero" was in one place and not
>>>> scattered about. I guess it's up to Boris?
>>>>
>>>> Maybe the port do not actually have to be zero at all? With the old
>>>> code, it was kind of understandable that the port number was fixed,
>>>> but for the code in my patch it does not matter at all AFAICT. There
>>>> is nothing in the binding docs (except for the example) that hints
>>>> that port has to be zero, so that's one thing in favor of just getting
>>>> rid of the port number checking altogether...
>>>
>>> The port numbering must be defined and fixed. If that is not clear in
>>> the binding, fix the binding.
>>
>> Ok, so the code in my patch does the right thing forcing the port
>> number to zero.
>>
>>>>>> @@ -77,13 +79,29 @@ static int atmel_hlcdc_attach_endpoint(struct drm_device *dev, int endpoint)
>>>>>>
>>>>>>  int atmel_hlcdc_create_outputs(struct drm_device *dev)
>>>>>>  {
>>>>>> -    int endpoint, ret = 0;
>>>>>> -
>>>>>> -    for (endpoint = 0; !ret; endpoint++)
>>>>>> -            ret = atmel_hlcdc_attach_endpoint(dev, endpoint);
>>>>>> +    struct of_endpoint endpoint;
>>>>>> +    struct device_node *node = NULL;
>>>>>> +    int count = 0;
>>>>>> +    int ret = 0;
>>>>>> +
>>>>>> +    for_each_endpoint_of_node(dev->dev->of_node, node) {
>>>>>> +            of_graph_parse_endpoint(node, &endpoint);
>>>
>>> I'd really like to kill off of_graph_parse_endpoint, not add more
>>> users (check the git history on this code). You should know what are
>>> possible port and endpoint numbers, so iterate over those.
>>
>> So, add a comment to that effect in the docs of the of_graph_parse_endpoint
>> function.
>>
>> How can the hlcdc driver know the actual number of endpoints? It's a
>> one-way signal path out from that port, and it can easily be routed to
>> 1, 2, 3 or even more places. As shown above, forcing the endpoint id
>> to start at zero is a nuisance, and I don't see the point of it.
>>
>> But I welcome suggestions on how to arrange the above dtsi/dts fragments
>> in a world where the endpoint id absolutely has to start at zero.
> 
> Your dts file arrangement seems fine. Can't you just not exit the loop
> on -ENODEV? IOW, just iterate til you find an enabled endpoint.

That would regress cases where two (or more) endpoints are enabled
(which is currently supported). As I see it, the driver will have a
very hard time knowing when to stop iterating with any solution not
involving the equivalent of the functions for_each_endpoint_of_node
and of_graph_parse_endpoint. Open-coding of_graph_parse_endpoint just
to avoid it is a bit more than silly IMHO...

Cheers,
Peter
