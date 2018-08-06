Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3169C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 07:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 560EF219DB
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 07:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="VKgrNANj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 560EF219DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbeHFJuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 05:50:10 -0400
Received: from mail-eopbgr710064.outbound.protection.outlook.com ([40.107.71.64]:64480
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725951AbeHFJuJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 05:50:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=94BYJmSjAIZSRF9mWH2T/640WYxx3bQjHL+K7oPPu+Q=;
 b=VKgrNANjZuCyMUjqhhc/r8FWGosvmpVe6wAzpZdIPht34PJ9jJ53IvbYhcxPp780ZKaRvYX/fgJjsJw/vYDqTnShfnTKeTWiscpSfy3ZK5EMciJh1KE9GgmitWJQFwu+MN4inRblso6DyqTFZ72g5r+ieC48hKKrfNSNqStQt0s=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com; 
Received: from [10.136.131.27] (202.56.249.162) by
 BL0PR12MB2354.namprd12.prod.outlook.com (2603:10b6:207:4c::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Mon, 6 Aug 2018 07:26:56 +0000
Subject: Re: [PATCH 1/3] ASoC: AMD: Make ACP->SYSMEM DMA non circular
To:     Mark Brown <broonie@kernel.org>
Cc:     djkurtz@chromium.org, Alexander.Deucher@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1533192134-11626-1-git-send-email-akshu.agrawal@amd.com>
 <20180802095617.GC9117@sirena.org.uk>
From:   "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Message-ID: <70bbe810-5a84-85b6-01d3-1226c7645825@amd.com>
Date:   Mon, 6 Aug 2018 12:56:39 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180802095617.GC9117@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [202.56.249.162]
X-ClientProxiedBy: BMXPR01CA0002.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:d::12) To BL0PR12MB2354.namprd12.prod.outlook.com
 (2603:10b6:207:4c::32)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca568dc2-0aa4-4e89-8847-08d5fb6dff31
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BL0PR12MB2354;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR12MB2354;3:HNN1SzX4f/SEQXnr3DFXlY8XDZEKEAwrbvHCclI+/RoQ5cXfCm8+ekR2ULnbLNwJ1AeWmSf6VCBzDZ+UQ/qR0ytaFE5M20BOC8f3t6loKXre4RnTVg//lPudh9kgLUziKo5jUGJvZaxCgYMKyfwxLQoGZOF7qkcf2cUzCfo3syB2wnaiNYitqLFD+F1fxUfyPFjOwlNfGkF+V+okz2v4hTJ3ntXV05JD09Ber8gNleI6ulRe3qsYKwDVe2SIEutH;25:YJghz/hkbNGXqrH8XX+dxkRNjhLHvT8IZPU1bhGHM1WIp6/Cw3m2rUktPQRPXbtKwk10eCDA3xB1eXl/J+4i8gwju9SM+l024UyOLxHcUVjFERY4aNGtts3iEhloFp1DE9jpUg4aovlacALOhSyXMiJopK6ph2VCwqDXvdC+mkhrhp51UetSgwCFSZZ1xvjgzY1DnperajF5NDL8Kq6ONRKoOX47rL2H7xO1/+5awI1K6mmnltS3OVVB9XJUC3opXgWeZ4CC3H98ox/swOQvc4DdogbsRZz/p+IUdC2a747iuo5EqRkc/Q2Z8+zIc/WDM9CcvIfdY6d28xUelQARnA==;31:kD2mNdntWLwG0KbjFgfo7pvGSApsDAS3juH/kncfrA7RZLV7i38IN84E9XAgYrwVBbhTm5ZF5zH2/Z5n3COSFKosAwCx5X2/Ctious3ZiFgnI5Tc5RyLddEbBi3pcVP3VSgnSzpVQTwIb0VxthNkTGmg5x8U3FJi6+/W0pmfIVKA6H+YnH7di64CSr240rO6Q+H4jpH7VtLKAr+8Q/kZuJqpirBuI7xrXUAfX5DLa28=
X-MS-TrafficTypeDiagnostic: BL0PR12MB2354:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR12MB2354;20:3Ul8/y5dDMvsCka/uZFEma/Ec4bmNHKSx/RJjTSU6BGvqXH+OBc0f+VRO3hCntOpHoZsV1wVzSMFZyAiBDinjSyQaegEb2N/LzVXZso+PjLbjY+3aEa6WSK9ZwnvrPBTN/uuxo3omRTq2x/qLSxwy7fR3vN71JYrWhqIioCL4wXhFjljhDgikDuJZQ1bWCGeSCnQ4MYCVevq85NOdp7HGgEngZV39xhAQcwjl6kLSMIINCEBUQz10oUYyI4/qdnLj6OUcaNHh9G85D4JJ5OiGqO+MHqHhMbtNXK4+n9nh01FPwSWOd/fWR3PvwRY2VzFrDVC0s311GdBEmni10J7lqOsC/ba7TMCAE3Ae5srqXSrTnK35kw60587C0zooi0PtnRdbWpcMAySTvs0Rvwjh9FALH7vMFGRjEO3RGCqXF2ae2JJTcf04Maj2NPUVbPLk4e5YYlR8/fph0wsUIjf0YeNAZToEHDY8lI6wC5yHe4zKFmAjcKXdVuNzhOfXTr4;4:iNWhQDiZK3Vh0pr84v+xLXSgsxxy8fHF1DVHnzGdp061Isk+wpKli7vyiffVg09xi4lHy1ntONSWxnXdVpgqEmVx73eMO1loDj10vRqCAF/2s0v1UDZZPjEOwfvLOXEYnPSJgq66bUMU3LrtknyuODfitjwjSZPt+idfxSQGMA/GYelUkm3hrJIHUckgdMDwr2yike6sY6qxxEBvQbaYUrgUvzyLKCnGHL+lu0Bp7raC5UJwdI0bAEgKimhqTg7MhIvn2NGjn+64qvosGtA/tw==
X-Microsoft-Antispam-PRVS: <BL0PR12MB2354F8A6F2B5B4E515FC8F75F8200@BL0PR12MB2354.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BL0PR12MB2354;BCL:0;PCL:0;RULEID:;SRVR:BL0PR12MB2354;
X-Forefront-PRVS: 07562C22DA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(366004)(376002)(396003)(39860400002)(136003)(346002)(189003)(199004)(86362001)(58126008)(6666003)(7736002)(23746002)(229853002)(5660300001)(65826007)(65806001)(25786009)(3260700006)(65956001)(305945005)(76176011)(16576012)(52116002)(316002)(47776003)(6916009)(39060400002)(31696002)(54906003)(478600001)(72206003)(31686004)(106356001)(2906002)(6246003)(4326008)(6486002)(105586002)(97736004)(50466002)(186003)(16526019)(8936002)(230700001)(36756003)(68736007)(26005)(77096007)(8676002)(66066001)(2616005)(6116002)(476003)(53546011)(53936002)(11346002)(446003)(3846002)(386003)(956004)(64126003)(486006)(81156014)(217873002)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR12MB2354;H:[10.136.131.27];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;BL0PR12MB2354;23:pCgxPZDgBho9EdtTbesa27Vx2ZMYXq1RmQOqc?=
 =?Windows-1252?Q?7ySxiTrZszw/atMKKDB1Hw09Imw+5wOiO/hAC5/YjSUHFXZEvwKkjcJk?=
 =?Windows-1252?Q?C+TQ47BMY/3ia8opdrxBhC+1jF3MoAx8uJ8QqOI7zJGuYsdbnI5EkNij?=
 =?Windows-1252?Q?AHWhi06DmQ+7m2Bpb5p4jjdDf6+XCYsCMnriGMF3hvmVSKrPW8rXunIm?=
 =?Windows-1252?Q?ROUNup0uyUnWwg9UKd6d0h3gytFGK0HtWboh2NbJLZI5867EC3fB3ar6?=
 =?Windows-1252?Q?fSUplVnF11OmX0g9Sk+dF0LDpD8ql8MxdyQnI60HujjoRf/nE2aQwSKU?=
 =?Windows-1252?Q?G/0MSIoFG3Ti953l67PHbuomcvjJw5kWdNLpl6Zjra07xbfR+EnnmY2B?=
 =?Windows-1252?Q?RdoIvtVcYDPXIQ3BCMVlzKpvE2ZyaKqZTO/c4ZNy2OeTZ0zaKsw/Ymuy?=
 =?Windows-1252?Q?gXluTLo6w+aiBXVxD2/yuJTSapi+E6v9+wPHAzFoxEN5me1sR8rCziYw?=
 =?Windows-1252?Q?YsC8CXJLWM/ABvDMjuCm2Q+GuBvPhlqox3dTymqyrL24Kj+Vqb6FaHAS?=
 =?Windows-1252?Q?qaiN1ZsXU+lZX8pgWf7jcZp9IZm+IO6t79m823XkBxmubEiYFReQXAn1?=
 =?Windows-1252?Q?vx4agbPx7SkmITmBg/1hmlENOBSTnaPpd0DL9AYqniIWKewVC00noxCC?=
 =?Windows-1252?Q?5OXwsq5yBp+ES/bweZU8PCnDmBsGW3Elz96GttxBZpJ6Q78dtxrP+IUT?=
 =?Windows-1252?Q?UvC7mZ9QI61X7kPoUJcRPPSaG+mbTcMrLLKOaqAaVn3TbJfCINUAiXjY?=
 =?Windows-1252?Q?jhcindD3MQdgDOP1SCtc8f2L2TYYWge1tP9zL6AeEfjsNwsH/pROeOee?=
 =?Windows-1252?Q?M9PbMTNa6Kqlr6ejFIL+8+R+lO2bj+NJxVEn0S5FtllxoTC4lmSAccky?=
 =?Windows-1252?Q?AgKu4AcFHUxAhXjKavrbZeb3DfRPcGHg06Lc/iMX6+8eplDxBuMLGde8?=
 =?Windows-1252?Q?aKeO2elqUkWdvs5K8XMRAUTKsP0ueHum/sDG7cPL4ZVIZfWGYs0kzYg4?=
 =?Windows-1252?Q?sWKds9Sa/AzHKTpXyb6OYLTaIAYi3GPouTQdvS+kuSXRrHykTxfqQ5th?=
 =?Windows-1252?Q?hTCGg/t6hj0hG5l1BnE+1CMt/CJD9PelVA7SHwilb50tDkSJmRpMcOrT?=
 =?Windows-1252?Q?HUgqXTPrrisIYoK6Rwqt7u2l0MiGJzz4n75Ari6r+rYx1MX1zhHubNvY?=
 =?Windows-1252?Q?R5KyC+pq5VxePrqRYVzX6RaBLwN3V3KWPT1V+Tr8CAYFpFwAHapQc66S?=
 =?Windows-1252?Q?VqOsrFBMKVFq/lQFr9/ujsVIOrV6MwmzPG9KNoihzPuPZoQoZ6/5/Qfr?=
 =?Windows-1252?Q?0jBD9+t9GPZHU/RVE/tCQoH/P/ySHqF1kO8pePQ0HgzV+lEJlohbyu3a?=
 =?Windows-1252?Q?kw/LF9u0BImSObGW2ZBrARUpaWpuTL8EbHFwq7FDSpdpynFogO0N1Yjm?=
 =?Windows-1252?Q?Z4H4jXAQ8TKeanmBbwU6Dg6NAc3PKnLICoyrhV4f2j/Ed2HlYzZu9Iw2?=
 =?Windows-1252?Q?CubCVsOqemszzso4bUVkm3K2xvgOoiw0ooJINbNWvTygaVWMhdikkfk6?=
 =?Windows-1252?B?UT09?=
X-Microsoft-Antispam-Message-Info: 06DFUhIRp/iVX4AI/DGJxPO0RFh8RgljBtFFP8AViqLHO2KpLdJIX0eg7Ine0LdQcLXMa5echD/lyso/14ainBTJIEOFcLL4+9ocNInEEpjA+/D6rOpIRRZU7rLHvyCWp9VU282V4f7evzi0Sh814oNdiCeVBGXq0Uj7sc+euYrwLsdCES22LOV9D0Buj/XByt7WpukHyiGTNGlGgTV07YH0SqJurK5YAAbU+qsx1SAb9w5y4Tbsnt1Z8Y5MUi+WEfawzvYPEcnnZrYxU7F6HpGzqPk0iQSCdvvxj/6UcLwb6RA/MyYKCVkm3oury+zOSoJ+L/ONzKNmteoQwDVhIzEKvMTyaz3R6toVmsHbJuI=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR12MB2354;6:XQUJiEj7VAUgMu0fRLl5ywZ1NhkphUkhv8KSGbupNCJJrmXIOzH0MZ3Ub2G672dzPZAdlWuHVabLxiRdRDpyNjGNl2OO826t40ssWjYqiVuXFhn5LzbxsYocRqPYf6NAIhNJkq+LxUV5KOdTvOLn7NPxeWyghaiU9n0N242J72tz0p3GW0Lce3atOMxjZ6OQsu96JWy/MTX+e/M6iM8FOgVMzb3dEuTPLAxWKABNBRCOspVDOhP9xT/MDX5780HdfuhYgbNqrQbu5Igh9rK+oNDx//rHoO3S1Znf7OIm5PIPtVl9Ab6pSGZM85OrSykwjRGXMRqAiaTd7rn/VYn5S7ECM5orz8Tlt+EbCw9+j67KaNCAyMIx3V8ddndQzZ0tkCmedlrj3nQXGOW6RR2dCkWke/lq+3kHblMVtt/RIHYCvlQXGxF7qUMUF8iFT1x/nrAuSRrJ0IkDnzA0j0q9hw==;5:K81x0pfoZmJYWbl09Yoo87GiOkGqDVCBTQamYOkiGJWInecjTHZjAvvW3u99av/fGr1sFbDnTXBkZvWaKSNJi6hln9FsVsWxy5nq+kx7eKRan3WDVdjyUc8ewUMTToshBMBgKyNDmn9HGVQLkC43LuYxCSVGplEIQzGfBGAJQlE=;7:rX+uvld1dhXYNpYWYXb1ENrqSm6UKKPKeSVOfAkzluD5IyAvKtmVePz/ngig/NfSOIfUzcTVn9YDYAhF3bzk1ogOm4v5yYl6JT2Y2Uvx9tXvq41BInKgpP70CGnG09CtYRW1hD7oSpXicQvWv2MbUTmxwWkUvU00or81gYYhsPc5t3+0u1m1Lbi4DnFoCbDecwkuSWZRC8CxXqS+6m9vVGiFKhCIeF+aRQmnFiNRZt6kO0BQJ9f6gwfA/Hl74kSA
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL0PR12MB2354;20:/hGj/j3umEuFk6N7tFYIUtB0pScLMko3TqfVqWSOteK1LMcn17RVbVQc4tGXtGvTByiRk6XmQbG2t6IzwVLe1QRVbS2JJ2WnbvlsoLkou8IHMI6bOniq4D5pZ2VyyFSHJ9D8w6l/fM0fGuQjN2ZEhZHgtBlG4JwME+SU81b9n7m5xSQ/HxQCuqYZZv65Q+SXrWkSmDHlznJY9WjTdaqKvVhmnrCOshha0XAUF1uv2wF3DFStrWZqOZAX4tyNL2XB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2018 07:26:56.5105 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca568dc2-0aa4-4e89-8847-08d5fb6dff31
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2354
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/2/2018 3:26 PM, Mark Brown wrote:
> On Thu, Aug 02, 2018 at 12:11:54PM +0530, Akshu Agrawal wrote:
>> In capture case we don't want ACP to SYSMEM dma
>> to be circular. This is because if an in place DSP
>> filter is applied to captured output then circular DMA
>> can overwrite the filter value with stale data.
> 
> Isn't that just a problem with userspace not giving itself enough buffer
> to get the in place processing done before we loop round again.  This
> will simply change the type of error, it won't actually fix anything
> AFAICT but perhaps I'm missing something.
> 

Sorry for the delayed reply. Will try and explain more on whats happening:
We have 2 DMAs, one being I2S->ACP(Audio Co-Processor memory) and the
second being ACP->SYSMEM. When ACP->SYSMEM is circular then this DMA is
faster and keeps updating from ACP memory. This leaves no time for user
space to do any kind of in place post processing. This design works fine
if the user reads the data from SYSMEM at capture rate (that is the rate
at which I2S->ACP transfer happens). But, when an in place post
processing happens on SYSMEM then the data gets overwritten.

Sending and updated series with changes in 2/3 and 3/3 patch.

Thanks,
Akshu
