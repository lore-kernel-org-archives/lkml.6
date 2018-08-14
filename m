Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E599DC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 06:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79C9F2173F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 06:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="Z5xFGrgU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79C9F2173F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731879AbeHNJgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 05:36:41 -0400
Received: from mail-eopbgr70102.outbound.protection.outlook.com ([40.107.7.102]:41424
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727670AbeHNJgk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 05:36:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pxVgpbi3GsznuzxFLpWGrgegWn9o0J1qh+ymCtTpKKs=;
 b=Z5xFGrgUo046fp5jAANo647Fb53WqaM+jithAwgvX0MnY4DIN6ZtUM1JopdvQ8e7i9ArPLLElJp6J5YR/fpoV+t99sZ5dUBVFUAFJ8DxB5iFKmxosHzEZkumabn2BD9GQMA92ctGc7avMEMEINzfure3ZZliSM4VBZyzztis4Bg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from [192.168.13.3] (85.226.244.23) by
 VI1PR0201MB2462.eurprd02.prod.outlook.com (2603:10a6:800:54::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1038.19; Tue, 14 Aug
 2018 06:35:40 +0000
Subject: Re: [PATCH v8 3/4] drm/atmel-hlcdc: iterate over all output endpoints
To:     Rob Herring <robh+dt@kernel.org>
Cc:     jmondi <jacopo@jmondi.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, Jyri Sarha <jsarha@ti.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Russell King <linux@armlinux.org.uk>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Sakari Ailus <sakari.ailus@iki.fi>
References: <20180810130359.9882-1-peda@axentia.se>
 <20180810130359.9882-4-peda@axentia.se>
 <20180813135949.32vrlrevtazr5x7d@apu3b.nibble.pw>
 <0baac94e-f3d2-53fd-4af9-854bb4498345@axentia.se>
 <CAL_JsqJPzwpN2TFghy-FfHZppexG9gW4qBy6iYtGpyP_Bp6dUA@mail.gmail.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <5c9853fc-e2ea-6983-ac88-b52b6e9e6ecd@axentia.se>
Date:   Tue, 14 Aug 2018 08:35:30 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJPzwpN2TFghy-FfHZppexG9gW4qBy6iYtGpyP_Bp6dUA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR05CA0233.eurprd05.prod.outlook.com
 (2603:10a6:3:fa::33) To VI1PR0201MB2462.eurprd02.prod.outlook.com
 (2603:10a6:800:54::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6a13b95c-872c-4ed4-ad69-08d601b02828
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0201MB2462;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2462;3:idylxEaV0TtSSCIFBoyt82/rNv8G+lKgHU6w190NpGEwu5y4hxNWg1zf4/Ewvwg7FJZKx3kDIKb0g4BcjUzSfDKfCUUxAD7aQt/BvJNvPZNfEhWhwSfec38gkTTVcfuNU4TRQb+9jAsAKBOI4KoHm9OASoyno9EGgfC03N5d9VBXFwe/oeZvhdTSHiy06DhdFlwg2w14gSYqKZl8R7p+ahtdk/PW77WuWDMH1JXC2VdaLY3aizlnkoJYY3zttpmq;25:vh8WZElz5++eMKFQMi2/7h+O2XeM5inE5S/VmLJS73VXteCRVuOwR4k4a4H8AHjWHqTw1zfsZvDKbL9Gs5PSp2iVTzBGz0mgQqrhn7IfLbsE5cRkzQfiIiaGBCsCSZ6f3hrvmnzTzSE5yw5z9kw0HLBWnPp9cTA+RijQrf7rhHcAoS2on9FPjFmIfGnPoIlKqSkaOxOGKq6aAwtB8wd8MrH4eRONIrhbYxm+koECd+zL7u5wS26TeaY0hHPDLV8fR8Svuri7D4ZMF/kARt6GMRydg6mJfT+1ckkv5gJiNML9WMZTozYEOxfD2RrgS1z82le+ZOAHfYoaOH1nPEYxlw==;31:LLV7AkOmSyfyvXz0xcJ4gsnNSfBmPu9+kf763aXDzOEjJ+t9NAJVNpidaqIPziwl8Te1awYrDneTssDsdBl4/tQviiYfeT7fX72ItPDTHkuq/HAihJDoiTOGsQuk79CkKCS7J9cVHHZn1L96zUH2Em6O1xjG3tylMYhnt1G+ZeqiIOkbWNQL5KmMEtCG+0iRyTR8VrKIdfkt/PkJdWqfR1H2caj2zVzUm9psSaxGmxc=
X-MS-TrafficTypeDiagnostic: VI1PR0201MB2462:
X-Microsoft-Antispam-PRVS: <VI1PR0201MB24623E9698FB207E51295A11BC380@VI1PR0201MB2462.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(2016111802025)(6043046)(6072148)(201708071742011)(7699016);SRVR:VI1PR0201MB2462;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0201MB2462;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2462;4:w7nOMD6TpdoYlcr/QiQ9oZ6MzaHbBR/CYmWg9lwxVGRgAXR0F9ZPo7azjAj9EvM19BfHwLOviQw7TXenH0y6tH05wEOcXYsnyyydapcwxrcMLOSy9LbG6w9Y+p+5+0LrMpPbW13M4czo6KlSci6x1kfob9UQE8tY0d1LdeeKplZQsey7hcxslJIpOY0Bs9MkggVrXaXZXF+JJcurnhanBSjBYIGtP246T/hQY3Qkt7joDNIJF4fXgpDL63gIvv4HgZyr1CWBmTY54CCXNFAABg==
X-Forefront-PRVS: 0764C4A8CD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39830400003)(396003)(376002)(136003)(366004)(346002)(199004)(189003)(8676002)(50466002)(81166006)(6486002)(7736002)(305945005)(53936002)(81156014)(229853002)(65956001)(66066001)(65806001)(47776003)(5024004)(14444005)(7416002)(6666003)(86362001)(74482002)(5660300001)(65826007)(478600001)(31696002)(4326008)(8936002)(31686004)(106356001)(446003)(11346002)(476003)(2616005)(64126003)(2486003)(26005)(105586002)(486006)(36916002)(23676004)(52146003)(52116002)(3260700006)(6246003)(25786009)(53546011)(386003)(77096007)(3846002)(6116002)(16526019)(186003)(956004)(58126008)(76176011)(93886005)(68736007)(97736004)(36756003)(16576012)(117156002)(230700001)(2906002)(54906003)(316002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0201MB2462;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjAyMDFNQjI0NjI7MjM6RkMyOWw3aFQ1NDNWMzNITUdEeG1XMmw5?=
 =?utf-8?B?T1YzR2VLK1A2QVU2bFR3Ykc1WWNkRkZ3VjNwTXhSVVNwR05nZ0lFdlNENXp4?=
 =?utf-8?B?MitZNlZHWUk4NUVJQXhDYldvdStjNHNUZ1dWVW5pbjRNcTJ4QzVuY2FjaVVh?=
 =?utf-8?B?K2pwMmQwZWYvUHFNOG9yNTlZUUZzeDUrUHJkK3YzU2RNU0kycGVEc2lWQXBX?=
 =?utf-8?B?T2RNUEs2R2RhTTQ5a0FqT2EvTjN3RUdDY25DRmVsVW9ucVF4dHMybnV0OWpm?=
 =?utf-8?B?Qk9SNnFMUERJL3FqcmtET3lxVHV1NWt4WmJBbm1FR1ZGZ1FYakpoWUZEWEZx?=
 =?utf-8?B?RHJwci9RcHpRbTNSbVVuQjV2VG1GeHJMYVlHbC92c0VxTk45c2RyQ1BVbGpY?=
 =?utf-8?B?cGQraFNiS3pzR08xOUV4Y2FhNWVES0dDQnlhZnhoTFZ1bmh4NG94SUtBM21s?=
 =?utf-8?B?SlNiWk4wRytpazArSkZRR2gzTXFhRlkxZFRIMTNoZmlYeEVJZ1plR3Nib3Yx?=
 =?utf-8?B?Qks1S05OYzdFN3RSNXdlVDV4NHpzVkdIRVExNnVDQXRDRUh5Qjl3QTVZUkVw?=
 =?utf-8?B?WkZkdlFUYmVMdk5zNE9kUlM4cTNxOWZBRWNVc1NKTFdnZktJS2xnKzdhR1Uw?=
 =?utf-8?B?M1hLcXhrOFNYUnNkSVBtZUZPZDBLUnpyQUdoY3RnS3ZURlBpbzFPeTVJMm1t?=
 =?utf-8?B?SERnRXQwY3A2YjlLRzF1ZGpuUHhzNVBmUXVTMll4WHhtMkFRa2gzSG1LUVhF?=
 =?utf-8?B?cTB4cWpiUHc3c2lrcWVCRFBsS09HNHhCS0JQaXRkUUo3OHZ5aUVFZkg3VXhI?=
 =?utf-8?B?a25IbFlvQVU4K1FSa244YXByelJIMm9tczV5ai94ZFMxYW1nNEU5VE9yc01P?=
 =?utf-8?B?YitQNUwvV1hrQ1pvZmhDemZ2eUJyQ2F6cUo4aUJwU24vNlJRSFUrakE5NXpX?=
 =?utf-8?B?dDN5QUx2cDFCZ1pYVXQyY21xQU5JdlNaTkc0YTZ4cUVnU25kT2VXNlJIM2R2?=
 =?utf-8?B?bEwrL0crTXRFWGU1bGF4bTg3VHVUOTN6YkFiUXh6Y284b3E0eHhQN0Q4NDhU?=
 =?utf-8?B?RUdmank1VUsvUHRRQ2VtY3F5eUlrZVhuZ1pKQTlNSHBhRWd5c0dlTGpNV0dm?=
 =?utf-8?B?R3VIblV3dFBTelI1cFFjU1UxQ2d4bmJIbU1pNW1qQUZ4WHBuMDFNRDQxRUVV?=
 =?utf-8?B?azVDdEFLeTh2QkRLaGhCN0E4NDRaWllpdC9sY004YjNreEVDVjN4MWRvU2xk?=
 =?utf-8?B?TFhZR0pNdHQzQzczMlRGM2tLN2E3TWlTYk5ScGkvNXhrUEJ2U2hNeFY4eWox?=
 =?utf-8?B?N3Rtb2tZTzBHOHlwTnQrUk5WRmU0Snl5Z1lDS3AxV1hRNERLSldpVWh6UkZQ?=
 =?utf-8?B?NnV5WkUrOEE0a2w0ei9sYjVwbENVdThlRm4zelB5Z0I1c0hTVVFNcWNqSXQx?=
 =?utf-8?B?UVlZc0VKaXpLTmhiMkYvVkZFZ2NJTGxSZlRESXRlelVsVmtRSG9zYllXbnJk?=
 =?utf-8?B?bHFxL1FnZ1l3bVd0b094MUVtNUh5c0RnL25jMVV3WmErMllDcnAyQ05Dbm5w?=
 =?utf-8?B?eE9IN3NwNFFIWjlLS1FsNU9GbGlMY3c0Z1B3VHlNOEl5SXJBNWNvbFdYZmQy?=
 =?utf-8?B?YisxYWpTdkljMUNSVEtZWnA0OXI3UXlmblpNcFBNWmtXLzlGYVhGMThUbmNP?=
 =?utf-8?B?NGE2REs3Q25aNGUrSDNmbEhTdUhwRnNGSGZZYUllMGtZMzNJNWozdThZKzVK?=
 =?utf-8?B?ZEx4OFg4NStyK1RQQ3Z4aWFwcUFiZjV5NFEyUW83VEw4QkRWb2dodUdTV3Ev?=
 =?utf-8?B?OVdiK2VTeU5leDZ4a2JQa1JQdjQva3VzZFJpVDZKTVBOV3ZkOWZ4U1djWVRq?=
 =?utf-8?B?c0F5MjRMYU5KUHgrZDVkSXpKN3ExTC93d0ZOQXNjb0hRUkJ5N2ZjNjRWb0xX?=
 =?utf-8?B?WGFvVmJJTCswOWtaU21DT0kvRTh1NGJ0ZUxRY1k2NWdhdlVVY1JBWDJIWE16?=
 =?utf-8?B?SzlrdTRTTGh1UjZiOFgzbUVpODl1S1VUSUlxb2ZWS1pxcE0xdmQ5QmdHeTJB?=
 =?utf-8?B?aFIxY0VxSms0MGlFM2xCZzBzMkY5bGs4ZWJMZ0habUNmOXl0MURzQW8rVDBZ?=
 =?utf-8?Q?Kwcx6S79Na0VlQ0Ntpxdhf8XuV2sf+oMUdJ2y6hWR0yFUl?=
X-Microsoft-Antispam-Message-Info: eGQoyT6xBF03ACpF/lUdG6tQ74Vp+ex2kDrsQ/TUbEdiLa0rvBXMp8F/gHALctuIR93ku/jEyB1hs64sEMDWFPZSeGZnaSNPhn6igQj1KRwvvmdYr1bFoLj3dtWf2evvY7/BblYVX+HlHq4bnubvMbJbDYn892tR23IEh22RClMP+OCd9TNphz8dUihHOF0ySzZmX1zGsHEeUZDeyFCdaBT7zgoGMyPOgMJTvIJNRGnDcn8Q9eh/mqJlATtaquv5vU/Gv3+BQK9QCRZ7SCCmQi2z2o37qzg4oRsSkZUiLH6RzB6aLYhWLojjLgcTCzDcOX+jR0ez4ciVvzBJlp5gyC5Fg6OPw+2QMH5tLUzVL2A=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2462;6:lTik8LDTgMQe/siCfDV0bMpIRaAPHtTQ7ftHgHR0fVNxDoRA/dhgoRy1b554cU7wOV4IwaMrxaQp29nhUcI/x/iNn813UnLbi0o2gz4m7WmgQMFvcfWOZshKJXurTE4IcP6bBOGEDDNq15KCx3c+kzYh/9ckJqOuE87LSOzh0Rg9PcirWFnZ/ECdpCKCiq285ZthEn4jx/OB9NUODRqkuTOtFsXjJUkajxqN/glmuFcQnFUGTzXRwimcBNfXpAuU0fS7h2xRTvuNjqqySCSHecmahpZL205qMeiFwMoQcP+BcO4k4pAivUiK+hngzoAlqeL9cOuAodo2vuQPqP5EvDCi+REAWGNc5XFYrqtcOZnVpqPGAZChFPbV+TJ575Cf061KBgwDNxVcNka6vMU39TbQL/TDcaI+GxQrgNT1h1wITJ3uwk2AWNvDTXq0TmfHkiiIioO7Vmel9cnwTo3Y/Q==;5:RWMlDYJq02l8/WjdhQJlwoQEicoA+4L6ktFOV6PA+qhnJWHHDjxCOkffNniO3F8Ey4S1x6Ey1+UCmjkWqqLnLqF0VzGwy0Vgzh9cwoXGihzJbeSaaUt06EyXfli7uKVe/pcGB/sOtX4oaKbv4dMSjW+HVtEhi38v2HVJn3NY+l0=;7:A5ZP12oXIDhds+tmzogB/xBPrZZHAp9fX9I59DWcrYZVZPWONQNTgwSrZnmnyGakD253I9Q8bDN/kv7nFJml2izNIxdaC7bApZJ3hGC+2prRt91a6hkCYlmgkAyZ2z1dmdn+xytrM47mD6PG6A7EPIBeWmwGgb2Hdab17hLMc3tzUTCV2Rx3+OHpQVcAuH/VN0lnXdBWujNI1KAWUvNCxhBU+zjwr5tvGzIWAr9JIvt9yNAiZuTI+td6UCEcBt2E
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2018 06:35:40.6942 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a13b95c-872c-4ed4-ad69-08d601b02828
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0201MB2462
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-13 22:52, Rob Herring wrote:
> On Mon, Aug 13, 2018 at 8:25 AM Peter Rosin <peda@axentia.se> wrote:
>>
>> On 2018-08-13 15:59, jacopo mondi wrote:
>>> Hi Peter,
>>>
>>> On Fri, Aug 10, 2018 at 03:03:58PM +0200, Peter Rosin wrote:
>>>> This enables more flexible devicetrees. You can e.g. have two output
>>>> nodes where one is not enabled, without the ordering affecting things.
> 
> Your DTs are not supposed to be flexible. They should be well defined
> by the binding.

I feel the need to explain the situation with more words...

We have a board with this atmel-hlcdc wired to both an LVDS encoder
and an HDMI encoder. Depending on how we integrate this board, only
one of these paths make sense. Hence, I would like to do the following
in a .dtsi for that board:

/ {
	hlcdc-display-controller {
		...
		port@0 {
			hlcdc_lvds: endpoint@0 {
				reg = <0>;
				remote-endpoint = <&lvds_encoder_input>;
			};

			hlcdc_hdmi: endpoint@1 {
				reg = <1>;
				remote-endpoint = <&hdmi_encoder_input>;
			};
		};
	};

	lvds_encoder: lvds-encoder {
		status = "disabled";

		...

		ports {
			#address-cells = <1>;
			#size-cells = <0>;

			port@0 {
				reg = <0>;

				lvds_encoder_input: endpoint {
					remote-endpoint = <&hlcdc_lvds>;
				};
			};

			port@1 {
				reg = <1>;

				lvds_encoder_output: endpoint {
				};
			};
		};
	};
};

&i2c2 {
	...
	hdmi_encoder: hdmi-encoder@70 {
		status = "disabled";

		...

		port {
			hdmi_encoder_input: endpoint {
				remote-endpoint = <&hlcdc_hdmi>;
			};
		};
	};
};


And then, depending on what components are fitted and what LVDS panel has
been attached to the LVDS encoder output, this can be used as follows
in the .dts file for LVDS case:

/ {
	panel: panel {
		compatible = "litemax,dlf2118", "panel-lvds";

		...

		port {
			panel_input: endpoint {
				remote-endpoint = <&lvds_encoder_output>;
			};
		};
	};
};


&lvds_encoder {
	status = "okay";
};

&lvds_encoder_output {
	remote-endpoint = <&panel_input>;
};


For the HDMI case, it would be this in the .dts file:

&hdmi_encoder {
	status = "okay";
};


The above seem so much better than just having the following in
the .dtsi file

/ {
	hlcdc-display-controller {
		...
		port@0 {
			hlcdc_lvds: endpoint {
				remote-endpoint = <&encoder_input>;
			};
		};
	};
};

and pushing the lvds-encoder and hdmi-encoder nodes (slightly modified) down
to the relevant .dts files. Especially so since we have to this point
delivered several variants with different LVDS panels. The duplication
is ugly, and the number of different panels is expected to grow...

But maybe I have misunderstood what endpoints are all about, but to me
the actual endpoint id is not that interesting and I see nothing in the
graph binding that suggests that endpoint id 0 has to be up and kicking
in order for endpoint id 1 to be examined at all.

For ports, yes, you are right that the port id needs to be defined and
fixed for a specific function, so scratch that. It was just a "maybe"
question anyway...

>>>>
>>>> Prior to this patch the active node had to have endpoint id zero.
>>>>
>>>> Signed-off-by: Peter Rosin <peda@axentia.se>
>>>> ---
>>>>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c | 32 ++++++++++++++++++------
>>>>  1 file changed, 25 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
>>>> index 8db51fb131db..16c1b2f54b42 100644
>>>> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
>>>> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
>>>> @@ -31,14 +31,16 @@ static const struct drm_encoder_funcs atmel_hlcdc_panel_encoder_funcs = {
>>>>      .destroy = drm_encoder_cleanup,
>>>>  };
>>>>
>>>> -static int atmel_hlcdc_attach_endpoint(struct drm_device *dev, int endpoint)
>>>> +static int atmel_hlcdc_attach_endpoint(struct drm_device *dev,
>>>> +                                   struct of_endpoint *endpoint)
>>>>  {
>>>>      struct drm_encoder *encoder;
>>>>      struct drm_panel *panel;
>>>>      struct drm_bridge *bridge;
>>>>      int ret;
>>>>
>>>> -    ret = drm_of_find_panel_or_bridge(dev->dev->of_node, 0, endpoint,
>>>> +    ret = drm_of_find_panel_or_bridge(dev->dev->of_node,
>>>> +                                      endpoint->port, endpoint->id,
>>>
>>> You are refusing endpoint->port != 0 in the caller, so that could be
>>> 0.
>>
>> Yes, it could. However, I intentionally did not write 0 here, so that
>> the logic related to "port has to be zero" was in one place and not
>> scattered about. I guess it's up to Boris?
>>
>> Maybe the port do not actually have to be zero at all? With the old
>> code, it was kind of understandable that the port number was fixed,
>> but for the code in my patch it does not matter at all AFAICT. There
>> is nothing in the binding docs (except for the example) that hints
>> that port has to be zero, so that's one thing in favor of just getting
>> rid of the port number checking altogether...
> 
> The port numbering must be defined and fixed. If that is not clear in
> the binding, fix the binding.

Ok, so the code in my patch does the right thing forcing the port
number to zero.

>>>> @@ -77,13 +79,29 @@ static int atmel_hlcdc_attach_endpoint(struct drm_device *dev, int endpoint)
>>>>
>>>>  int atmel_hlcdc_create_outputs(struct drm_device *dev)
>>>>  {
>>>> -    int endpoint, ret = 0;
>>>> -
>>>> -    for (endpoint = 0; !ret; endpoint++)
>>>> -            ret = atmel_hlcdc_attach_endpoint(dev, endpoint);
>>>> +    struct of_endpoint endpoint;
>>>> +    struct device_node *node = NULL;
>>>> +    int count = 0;
>>>> +    int ret = 0;
>>>> +
>>>> +    for_each_endpoint_of_node(dev->dev->of_node, node) {
>>>> +            of_graph_parse_endpoint(node, &endpoint);
> 
> I'd really like to kill off of_graph_parse_endpoint, not add more
> users (check the git history on this code). You should know what are
> possible port and endpoint numbers, so iterate over those.

So, add a comment to that effect in the docs of the of_graph_parse_endpoint
function.

How can the hlcdc driver know the actual number of endpoints? It's a
one-way signal path out from that port, and it can easily be routed to
1, 2, 3 or even more places. As shown above, forcing the endpoint id
to start at zero is a nuisance, and I don't see the point of it.

But I welcome suggestions on how to arrange the above dtsi/dts fragments
in a world where the endpoint id absolutely has to start at zero.

Cheers,
Peter

>>>> +
>>>> +            if (endpoint.port)
>>>> +                    continue;
>>>> +
>>>> +            ret = atmel_hlcdc_attach_endpoint(dev, &endpoint);
>>>> +            if (ret == -ENODEV)
>>>> +                    continue;
>>>> +            if (ret) {
>>>> +                    of_node_put(node);
>>>> +                    break;
>>>> +            }
>>>> +            count++;
>>>> +    }
>>>>
>>>>      /* At least one device was successfully attached.*/
>>>> -    if (ret == -ENODEV && endpoint)
>>>> +    if (ret == -ENODEV && count)
>>>>              return 0;
>>>>
>>>>      return ret;
>>>> --
>>>> 2.11.0
>>>>
>>

