Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E28C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 14:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67801217C7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 14:25:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="r5LswUAW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67801217C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729167AbeHMRHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 13:07:32 -0400
Received: from mail-ve1eur01on0108.outbound.protection.outlook.com ([104.47.1.108]:35986
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728293AbeHMRHc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 13:07:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Acl12Ft5zKwyUSRJOWjeaiXpLwIvXULd3Ksya+0OjbU=;
 b=r5LswUAW2t2/YFyUMJYvohUPPAWXbJ4h7rREEl7LUaTve0nhy1tiGmjlOfV/mIdHw2/USXsNnOCvkmRDLehhQ0Eb6QtZueX6hKBOjgFVdasa6mDmlxZnQeOBi5Md3nBghXb4b+XnWI6tcGWLXB0sL8CT4Ak1doG4LBE/K6Tfwh4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from [192.168.13.3] (85.226.244.23) by
 VI1PR0201MB2461.eurprd02.prod.outlook.com (2603:10a6:800:54::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.18; Mon, 13 Aug
 2018 14:24:52 +0000
Subject: Re: [PATCH v8 3/4] drm/atmel-hlcdc: iterate over all output endpoints
To:     jacopo mondi <jacopo@jmondi.org>
Cc:     linux-kernel@vger.kernel.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Jyri Sarha <jsarha@ti.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Sakari Ailus <sakari.ailus@iki.fi>
References: <20180810130359.9882-1-peda@axentia.se>
 <20180810130359.9882-4-peda@axentia.se>
 <20180813135949.32vrlrevtazr5x7d@apu3b.nibble.pw>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <0baac94e-f3d2-53fd-4af9-854bb4498345@axentia.se>
Date:   Mon, 13 Aug 2018 16:24:49 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180813135949.32vrlrevtazr5x7d@apu3b.nibble.pw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR09CA0083.eurprd09.prod.outlook.com
 (2603:10a6:7:3d::27) To VI1PR0201MB2461.eurprd02.prod.outlook.com
 (2603:10a6:800:54::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ada721f-e87e-436a-e374-08d601288a05
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0201MB2461;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2461;3:tbGfXOEE7XJOpxVciNi0uyH93Eq83/qPp+TQbmHrBdXJcBrQASoXSvcQoK1CT/ZQf4maaYSCjEpSOHT385mHlp0056pdqApSTIYtBRuETv67XrHge9arEVJhu9M05tEo2LJm2vWCLWknXgeNbmft5ApkMytnDERRkl34hXOBcvJvzvIdLQG2xoJ3/JynzFYckHpWtdoc+7ywwjKSd1XrHEeMns3Lr26uGfEW7phMn6LX5PLtZPkTynHBfZA3/SQC;25:uuQCFFnoyZwD/e821O8iquMTBoEf+oPaGbTSZesbf+O3rqulHEKJCXnC6o6VPGIRoJsbJErEI/trY2CVFhhQy1V73ZeFTqGD4X69gJi8wr/uf+KLEQ2UFjJ5GvQem4AHDjLnT2H8e09BzdK7fjiYUD+vPvCVYv3wYMQynWxXe2CU0GYDmtaN/pMuCJoTqP71cjRg78GuwHF+MeklnTQbMQG0pAJ6ZBqYtGUsDfnplopINr+WWLYppf/4SHDMgNLJx1RN7j3V/1Xnfnfmv2mIbE39D+4AtCaG4g+inbTlOCGwC758c+I4/TTv5oP2e4DqBIkuek/OVF0zabO2c2vLNg==;31:hpbYY0m/8V2YGdRi+5LXWR4LITs/YyuyzDbSa5oyAYGJ/yaH9PH8UfRSqG18MVzAT5oRPf5ucuNLufA4nEkAhuqrcp/f3+80bqZUQh/YZzLodbNSxm3mWrKi6At1Z1JcaAjJ1Rhlcte/XEI0MRdqO7hxL7CdEGoS5l8Ccjaw+XSfqfssYS4MQigwE1BKWWrvk2RG8k9EYTRMHCA7M2Lye6ODJx6RsxsbNXIygbDJKy8=
X-MS-TrafficTypeDiagnostic: VI1PR0201MB2461:
X-Microsoft-Antispam-PRVS: <VI1PR0201MB2461043A6C222EDC1818ACC6BC390@VI1PR0201MB2461.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(2016111802025)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(6072148)(6043046)(201708071742011)(7699016);SRVR:VI1PR0201MB2461;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0201MB2461;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2461;4:ztg+nwjxS8Isl5HPV1bDPO2bhaD6DOpWQfszsjE8YjK+6ibsUCaQnn8KbBXLoUBmx7aLzhrR43iXtDwznqn0/FOQoqkQog97HncXq+S8LUDLVgv/6vJe0k9WMhkGlI96D/PSzlKLELi5Jjr3jwTq1yAbY5PgJZ2P3lWExin8BZcjPGVuHciH7pw/tsOkN0OPyqtDBdIW3v4g6uslq00ZplDJvJTimkcwcKo0W554GotExpsopvClfABPOdG4tY461ycyzoXXzF1FfKpVgNRPdA==
X-Forefront-PRVS: 07630F72AD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(366004)(376002)(39830400003)(136003)(346002)(396003)(199004)(189003)(7416002)(5660300001)(2906002)(97736004)(5024004)(74482002)(106356001)(65826007)(50466002)(2486003)(2616005)(36916002)(23676004)(52146003)(956004)(52116002)(229853002)(476003)(11346002)(31696002)(446003)(86362001)(76176011)(66066001)(65806001)(47776003)(117156002)(6486002)(4326008)(305945005)(6666003)(105586002)(68736007)(6916009)(65956001)(486006)(230700001)(7736002)(54906003)(77096007)(81166006)(6246003)(186003)(16576012)(81156014)(58126008)(26005)(8676002)(64126003)(53546011)(36756003)(386003)(53936002)(8936002)(478600001)(3846002)(6116002)(316002)(31686004)(16526019)(25786009)(3260700006)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0201MB2461;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjAyMDFNQjI0NjE7MjM6Q1k1RjI3NHJHWnY1VlJkNDZCMzdUVDVS?=
 =?utf-8?B?UkpveE9JMDdKVnpjNlUyYWRueDZTVlAxdGdPM2RYbFVubnF6VlBzQVFpMTVk?=
 =?utf-8?B?ZlhHZmtNU0tjRTB6WFQvZmxZaUpubmdQY2ZKNjBHUFFuNXRaMXVEM0REa1da?=
 =?utf-8?B?cnVyUXlGZ09sWTlDZmgwN1ZhNms3b0JGVzJGMEFDUTMxYzB5dFBqekZNYmRV?=
 =?utf-8?B?dmxVRmtydEdRQTRXeDNxeE5HY1ROWUVhMlNpYXpNSStJaUNVT1ZtZmdPdFdP?=
 =?utf-8?B?bWlpclNpMEI3NTZrK05lUFc2MDhNOVJuSlhlMFJObXovSmpsSEQ2aWZFTFBw?=
 =?utf-8?B?NU56eUplZEM4cnROVm9hWHJXejhlUEZjTEFsejJRbGQ0MnRaa2xVeTVPL0tL?=
 =?utf-8?B?T2N4Lys1eEszc1R1c3NQTTM5QVJaWGtvVW4xdzBrZmx5VmtqbmpScHEwZDRC?=
 =?utf-8?B?R0h0Y1c2L2RQNW1vRER1dnlKZ2k2NFJFRHhXRCtrekJxVXAvL2VSbHF2VEI0?=
 =?utf-8?B?dFI2dFVPM3gwRGd4UVExVTR0eVQrVWN4Y095WkdzYk5hVmJjODI0V25CeFlN?=
 =?utf-8?B?VEpWNHZnUzJYWjd2QThma21PSlkxNi9xSjN5ZVZ3ak9jek5HcVlHN21haWZJ?=
 =?utf-8?B?VGVnVHN2L1FqL2N2YkRoUHBmaDhMeVlXVkE3Wll6MDVaZWY1WDFNaUEwbXZ0?=
 =?utf-8?B?Mks2dEFiSnoxRllKdGhMdnFoU2Vtd2d4cXNWQWhndlJtMm44WkNibGpZKzBy?=
 =?utf-8?B?YjlTSFpVa0NwYnRGc0ZkS3hRbkZzUDVkcEV0ZURoaUtKWWdRdlQvWVhGR3VC?=
 =?utf-8?B?YXRYQ0NlSzFYZXhTU0UxSDEvTEZvRzI3clhja3ZmWlJaWUlYSlNTRGJCRDJ5?=
 =?utf-8?B?a0xmNi94NlRiTmtJdFZrUS9KcTNNdm8yOUxqcVIwNlFSVUQ4KzJIUVgrb2VD?=
 =?utf-8?B?UzNzSnIyN0lrRVEzb3lVNTNZSU1yLzRROTRrSjVrcGZQeitDaVZDb1RSV0lL?=
 =?utf-8?B?QVo2ZUt4cG1rYVpQLzdIOGZ0NWxCZ3VvRFFBTVhoT1hSQjNtTU1md2xnR2xq?=
 =?utf-8?B?NDlIRTZlUVZVNEcwU2xpeE9ERGZrUG5iVDdqeGZYWXkvY2sxZDhWUmg2KzJW?=
 =?utf-8?B?VlFRUWZIUitYRjB4c3RVb3BaYklieS9nbkZhb2NFZ2RDWEJyL09Ob1ZoaFRo?=
 =?utf-8?B?OGo0dC9UaUhwOUxUYm15a2JKT3l0SXg5OWw2M2tmVjh0NzVRdjNkWmZlcmR6?=
 =?utf-8?B?ZUYwOHlNWFB2YXFyU2N4WFJCM0FHSGMrMjhaZko3U1A0SnZXN01JOTdGVURD?=
 =?utf-8?B?UFBGcFZOTlFJMzM0dC96RDc5WU8wSlR3TndLSnVMcXhOY0ltOHFNdnNiV214?=
 =?utf-8?B?NVZtSEV1eFl6NmZER2kvTmRURW9NWWprK0svLzk2M2VSdnV5Y3hDYlVaSmtM?=
 =?utf-8?B?OEFBbGhmTjVXY3R5NlRLWGtSeWlDTVo5YmdNV2Y0aEVHRGdmSmpjbFhUc2s1?=
 =?utf-8?B?MExsenRZYmUycWh4U0dYOWhiTXZuL2pjUmlHTWhDL2FwZDl0UURaSFRackZS?=
 =?utf-8?B?UGJXL3FhQzR3U0R1WVlMVlk1NVNDZE1MVzIzZEFOUllsSXM2SmpqRkxGOGda?=
 =?utf-8?B?UXRIY2R4MXhDZkZQYkM5akhVL2dta2lLT0p5RXZ2ZGo0ek9CSjY0b1NsQ3Fq?=
 =?utf-8?B?cHQ5cHVnL3Mwc1ZjVzd3a2sxYkR2bnczU05nS256MHJhVmRaUWg2S09ZeSsr?=
 =?utf-8?B?Z1V6SWFocFo1RTNENzVYZGVETUFuSFpRSDR5YldhaG9IVEl0NmhYYlJLVWFR?=
 =?utf-8?B?QnJwKzJYV1h6bW9NSFloVkM1ZmVjYzB5NEFBOStkTTdTcXVSWXZpamJpRFJJ?=
 =?utf-8?B?TG9QMmsvUzI4QytFTFp2ODhHSERBNlRSNnUzSEpQMVQrNXRTVlQrUWs0eXI5?=
 =?utf-8?B?TW82VDhFeEZBUy82anlCNmFnS083cEc4SFdDcWRmeTdCa3grb21TTi9SU05w?=
 =?utf-8?B?YkFlcmpVWDB2U2plbGppckNPcmJ2N0U0ZDczaStNNlFNNjFITUd0UUtvTXpo?=
 =?utf-8?B?M0tmQ2pvNWVGSG1ZNGQrRVc5ZmFFNTcydVc2UGNlL3JqYXpwc0dKUmpzUjV1?=
 =?utf-8?Q?j6tKCuZPBvlZFoWqOduq6mxlU=3D?=
X-Microsoft-Antispam-Message-Info: hBpC2ZQvdN6DH7bTLplsnMEiytSOBYh9HskVALgBzKtSF7Fz35j5Ac0qsu8CJBsebZdRsFp95pv9GV/rJ9DiO/To/kUQoZDO3fDRfxDGp07OnoKJC0ThjFW+RgTAdTRZ+GlQM2hbJaXom8lrYMjmmhGrYHqq1Yq0kiYPIDhpKk8VMneCuv3/mkHxBle+ZS5eGgS07Ac/8AzutTo+rcCivrl+bAz30s02bVOJHiU+nsKD3GZjOzV0Xe1Z0MM/Zbz2PwtCkMvZuCt72pw0hFxAIGBBHWWhElH7AJYxnozPMbSPHuGn3R7mzXDD8xt+UWkGmHj0nbYv4yjKNM9HvqHxKrb44X/V60e2DxQtkZwTQAE=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2461;6:OsArNdWYbSGWPtLsrqQuoPi6Vky5VxkW6XkWo+ErCxc1quNVo04LMezld3ZozA81AH1mnHzdGjievppS2zuUn0pH5ClUBZavc88haYQQ/jgf6x85kjeJ1Q1X5fKOkGF6QRQh2XA7h4A2wNHmzU4v8DkIZfJ+qbrAjpNnYn45ig9WOpBu1hzGaHk4DiW+oD/cgwpA4jaSXL0FGJvhB/nVqT4AcOB2hAoiVdaCTu/F7qG+ozLSkytxE3dI9ss9LxmnPTQV4pmyhJBFSqnDsL9UqdZR0wUgOra5eHy6t1Ol+uPplUaaOk66c+MeiwpvkRRDYkB5tn53JoWNs31HGb3CyaKCosifrTcsoX/T+IivT8ymcx4X2N5Fy1/DuNd4eeILYyxvSUUN0Vu9kR6Qy3sjXfzHTcpbCSGREcv+t1e5kWGHpADxuHQpaxGiue+clxLnFw/ICl8u9581BNpNgoKkag==;5:n4pCaxROzGTi43YA2flS8EDEyvHN9A13LZMr9otZ0AlMYGr7MsmDDcXItNHwkaLLYCi75d1cxomWjv6OAuO3zIo8SZWT//FxNw1HEW+Pa9dNY7lEi7bZzDiNpCKb44Ly3P5W61OPpEPssUtwStQcnbmnTx2OBtq76HOGtOD1E5U=;7:DPsxPomHmMx+4ilPAC40zefnjkvVnemfiyHtXkfI+n0QSBoikcPXb5skHTQ6lOd45P8qTjyPswzptrkjegRLSx41vIKyc2/kMFZqmqli+w3vRihOVBjlyOIuT50JJklPFr0Q1lYK08uG1cfJmw17n09/ANtJ0h6uIHMSaoWYOk4qrvpLMgBZKBB5pnjiKZf83snTnqGwrW5/VDlrdAvBH4QqNf/ZmGfJLVsYUt65/4PNDhaiLpHiXGSpsynHv6nv
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2018 14:24:52.9441 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ada721f-e87e-436a-e374-08d601288a05
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0201MB2461
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-13 15:59, jacopo mondi wrote:
> Hi Peter,
> 
> On Fri, Aug 10, 2018 at 03:03:58PM +0200, Peter Rosin wrote:
>> This enables more flexible devicetrees. You can e.g. have two output
>> nodes where one is not enabled, without the ordering affecting things.
>>
>> Prior to this patch the active node had to have endpoint id zero.
>>
>> Signed-off-by: Peter Rosin <peda@axentia.se>
>> ---
>>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c | 32 ++++++++++++++++++------
>>  1 file changed, 25 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
>> index 8db51fb131db..16c1b2f54b42 100644
>> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
>> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
>> @@ -31,14 +31,16 @@ static const struct drm_encoder_funcs atmel_hlcdc_panel_encoder_funcs = {
>>  	.destroy = drm_encoder_cleanup,
>>  };
>>  
>> -static int atmel_hlcdc_attach_endpoint(struct drm_device *dev, int endpoint)
>> +static int atmel_hlcdc_attach_endpoint(struct drm_device *dev,
>> +				       struct of_endpoint *endpoint)
>>  {
>>  	struct drm_encoder *encoder;
>>  	struct drm_panel *panel;
>>  	struct drm_bridge *bridge;
>>  	int ret;
>>  
>> -	ret = drm_of_find_panel_or_bridge(dev->dev->of_node, 0, endpoint,
>> +	ret = drm_of_find_panel_or_bridge(dev->dev->of_node,
>> +					  endpoint->port, endpoint->id,
> 
> You are refusing endpoint->port != 0 in the caller, so that could be
> 0.

Yes, it could. However, I intentionally did not write 0 here, so that
the logic related to "port has to be zero" was in one place and not
scattered about. I guess it's up to Boris?

Maybe the port do not actually have to be zero at all? With the old
code, it was kind of understandable that the port number was fixed,
but for the code in my patch it does not matter at all AFAICT. There
is nothing in the binding docs (except for the example) that hints
that port has to be zero, so that's one thing in favor of just getting
rid of the port number checking altogether...

Cheers,
Peter


> Apart from that small nit:
> Reviewed-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> 
> Thanks
>   j
> 
>>  					  &panel, &bridge);
>>  	if (ret)
>>  		return ret;
>> @@ -77,13 +79,29 @@ static int atmel_hlcdc_attach_endpoint(struct drm_device *dev, int endpoint)
>>  
>>  int atmel_hlcdc_create_outputs(struct drm_device *dev)
>>  {
>> -	int endpoint, ret = 0;
>> -
>> -	for (endpoint = 0; !ret; endpoint++)
>> -		ret = atmel_hlcdc_attach_endpoint(dev, endpoint);
>> +	struct of_endpoint endpoint;
>> +	struct device_node *node = NULL;
>> +	int count = 0;
>> +	int ret = 0;
>> +
>> +	for_each_endpoint_of_node(dev->dev->of_node, node) {
>> +		of_graph_parse_endpoint(node, &endpoint);
>> +
>> +		if (endpoint.port)
>> +			continue;
>> +
>> +		ret = atmel_hlcdc_attach_endpoint(dev, &endpoint);
>> +		if (ret == -ENODEV)
>> +			continue;
>> +		if (ret) {
>> +			of_node_put(node);
>> +			break;
>> +		}
>> +		count++;
>> +	}
>>  
>>  	/* At least one device was successfully attached.*/
>> -	if (ret == -ENODEV && endpoint)
>> +	if (ret == -ENODEV && count)
>>  		return 0;
>>  
>>  	return ret;
>> -- 
>> 2.11.0
>>

