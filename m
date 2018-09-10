Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C81FC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF1312086A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fWhe7OuG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF1312086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbeIJWRh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 18:17:37 -0400
Received: from mail-eopbgr710068.outbound.protection.outlook.com ([40.107.71.68]:14896
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728021AbeIJWRh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 18:17:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jtz3DtiM4rWo7Tg9JYwwBmHzxv/0XrlyR4xaqqTax+k=;
 b=fWhe7OuGIYHJ6ifGUmhH1SJiRwp+iEW6F9YqBKDAbD6GdzHAi+KlyN8LReTSB3F/040ONbi5BCkSabKy3LGVTIdccVdtSNHTKE4EpAlRVqePB5kkB7U8wDnQ97CM/tjvWEquIaGmIQTpzoJN7QzZXdYYL3jsvN8JM8xy7/TuI3k=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com; 
Received: from [10.224.119.73] (125.21.194.1) by
 MW2PR12MB2361.namprd12.prod.outlook.com (2603:10b6:907:7::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.15; Mon, 10 Sep 2018 17:21:32 +0000
Subject: Re: [PATCH 1/2] ASoC: AMD: Fix simultaneous playback and capture on
 different channel
To:     Mark Brown <broonie@kernel.org>
Cc:     djkurtz@chromium.org, Alexander.Deucher@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1536566815-3271-1-git-send-email-akshu.agrawal@amd.com>
 <20180910113820.GD5856@sirena.org.uk>
From:   "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Message-ID: <df52a9e6-457d-754d-ce6e-333752e97ae2@amd.com>
Date:   Mon, 10 Sep 2018 22:51:13 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180910113820.GD5856@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [125.21.194.1]
X-ClientProxiedBy: BM1PR01CA0095.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00::11)
 To MW2PR12MB2361.namprd12.prod.outlook.com (2603:10b6:907:7::32)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3dc9a75-eadf-4d4e-f389-08d61741dd18
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MW2PR12MB2361;
X-Microsoft-Exchange-Diagnostics: 1;MW2PR12MB2361;3:tqmsNUxT/gJlNkp7++Y1cAeXQxGvYCpj3gsyUt3SW7HOzTvbGo5UOrv9w/WYiA4Eux2KJDRYyORd1vtY4RVSBUyvSUqWZpXvkJ83iV6YdQNZHmaH8MXj/2/s/W3AWAw3YApgO/V75vmJyL0hBWRf8BBaFt2d7Z1pDERP78maDIIfX+RodNWaiuLmy9d6S3JArvXfVNnxOq8zEXs/s6h/t0a6eeRnRIhSZNiqk50pdQIJDP+xR9jzPwg0hg5H5rwO;25:efp2OBjv3IqaDJtIpyroWLeW72P4xhVk3lPuZNhUs1tQx09E2TrGxdzfuHoo5SmsjGxYE96sl2fhRvWuz7wc1wq8t707aAbfTg/JBSpv+GxVSTRoH9FeTCLYKVdz32k5rldbzByrR3QpY20dPpScYebnEPkLLiGnKJbaTrlO07KDSXkXBozvvyiSiNOzkiDVP9JCV4HL+EkWI4cO0eVZatPSmXw443lhyzysGsKRN6xMqfYojiprXUE9PonPPCt9D3390E+g67XCItEhqv7Ma3kwcFv49PPhw6wknR3g5TPak0xFlmcipPqFiQpN9IO4nF3P3mEzzLDCmGeiMAHvug==;31:Q/ctgMVBXCOqWt3jiJJVwsok1p1pKxnY9aUi79yhY+Sr0gJ1yVDj6Cc0Ac5hc1lxRect9QZrd7t0+ktItpu+NpWd0gtgMNWJAxkABCvId6lHO1kRVFVAIB1zlDxi046cTriaw3hYdFb6kBCvNK24ZWTlJE+RthV8dZvRD0Kw4hf5JWS+R8xEtvw/NvU+Qn/JrCxF2XjlJN1o1DiImfAO0+Y2qqK0cCzigWl0QA5npLQ=
X-MS-TrafficTypeDiagnostic: MW2PR12MB2361:
X-Microsoft-Exchange-Diagnostics: 1;MW2PR12MB2361;20:GpGCQfHa0uJmElCPPRTkbgDGhbb5SuYly80Q5qsTd0uC3JQD1gY/F5BtOSIoqRP900Azq53DB0VxU/Djz5PHGNv2oigo1FPZjl72dpPsgHL9R/57+22F0zGz3gBp4gOCnDrGXvBrTmSCETEjBRXn+WY7BWV9PsawTfrYlH5LEtZkE2mtGv490bz9jHy5qM1BHamLL0NHNkEvrJVTmCx01HVesQ3yHmrzZt4DhToxFQ1s0QKqb9d043ftZ/kCK1+S3PD2mQlRjhIt6EAEzCXet+OtHlFY4oKZgsGcm+yaHKbBoIe+boPCFdrKueI+KXB4PujQNZK5F3u1/f2efVJqkHvGsczWlDzQTSsKzsl1OSkALVH9+Fvz7kLQhaSOKFImbMowgMBsvwa4w457/VZUX+TuMst7TALHxV2TK5aDTRn7/q4Xj09aoR1LroDdCsUvTE6paN7CDQe6HKrRMaexRMgNGTcwCeEOI6F0ulWGrkq695t4fKDhTS+aaIa1rikJ;4:w6YGOXmu/R/YGsptanoZgPdYeESpSwZuQ+iO1UkAAjziDYV44i06kVSLBxPP4Y4bbnIr6DRGak1Rv61IaB8DpmSUtfGur7jppJxVDP396ResIxMGbS7OaRV4SbzO8dtTXYo9gZEEiLgdUhOfyrRs6YJO2rT0NVCGzKaBYCqx2ia5gtHR9QJgNLbl3ZvWUzoSV5pk8yLWVnZSZLEULKhqzQrZd9N4griH76exa4feifBfhVCa6BbhD7jgCYHkB0ZrupX3rlKN8C7XeSb7mA+o6Q==
X-Microsoft-Antispam-PRVS: <MW2PR12MB2361AEF3D471A72AEFCCC606F8050@MW2PR12MB2361.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699050);SRVR:MW2PR12MB2361;BCL:0;PCL:0;RULEID:;SRVR:MW2PR12MB2361;
X-Forefront-PRVS: 07915F544A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(366004)(396003)(346002)(376002)(136003)(39860400002)(199004)(189003)(53546011)(478600001)(64126003)(72206003)(316002)(3260700006)(25786009)(16576012)(305945005)(386003)(81156014)(81166006)(8676002)(39060400002)(105586002)(106356001)(4326008)(2906002)(6246003)(31686004)(6666003)(31696002)(8936002)(14444005)(47776003)(65956001)(65806001)(66066001)(5660300001)(54906003)(58126008)(6916009)(7736002)(65826007)(68736007)(229853002)(97736004)(6486002)(2616005)(956004)(11346002)(476003)(446003)(77096007)(36756003)(26005)(6116002)(3846002)(86362001)(50466002)(76176011)(52116002)(23746002)(486006)(186003)(16526019)(53936002)(230700001);DIR:OUT;SFP:1101;SCL:1;SRVR:MW2PR12MB2361;H:[10.224.119.73];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;MW2PR12MB2361;23:ea0TMBJUZUgihozNsK4NOdJvoLRcvFKLedXuU?=
 =?Windows-1252?Q?lZmP4UW1CvcBQB4fkl3iFdg0lL+KGmqk0F1zmz2/zwNlSxRclVv2PUBA?=
 =?Windows-1252?Q?Agal8aVXe57qAcnJI4WAtlPqALZELgxT63YbjUjkIawjEoeyVyBsLx3f?=
 =?Windows-1252?Q?PBRfrI6mEKqKhMMH1Sm0cWdvuZDIqFArIpxqE5shCtUAea8/dVRBffxO?=
 =?Windows-1252?Q?pWwiNyqRNFF6ivfvf2AItSv22DfKcOj2O3UI563agPix4USTgcBsLYwZ?=
 =?Windows-1252?Q?axXCuCe4glqi984osfzkPH+VVuqmGSDA0Ho6eu6WpJ5ljgBQsWRU73Ut?=
 =?Windows-1252?Q?EA+KI40dvEGEO+v/Z6WIuMIfr2+rtmT8NISeDjinSjztrkbLcNqpJn1B?=
 =?Windows-1252?Q?ISrUA/NZZGTtJdkPK5hXLMUNyjEnBm80stN1TuqCYbvzOubDP1/byX4A?=
 =?Windows-1252?Q?ci0n89zFPlqPgeWqkfFXovVHvq2TgpTJ6eOIWQe40P9RnQaRSYd2COP5?=
 =?Windows-1252?Q?KK8/thaEdjkG9wHLi+uQNnQhjHKAMylW1Nu4lEmmpQy8/Izg3c0geR/k?=
 =?Windows-1252?Q?puk1MoyuXct6do4cfMBoyjfkyQ+8QsCauAOpX/Pg8D+vv6wDqlj9kAX7?=
 =?Windows-1252?Q?hcLINhDNzF7WyWL9T7HbKLL+G/+AuZA0rCX6MLlNUigOnIRpEMc9X7EW?=
 =?Windows-1252?Q?wOjU4K3fgd1xSpbrqK85/ryjCWwX9aUYEqkqvaL0o+lkpRH60AhUkp88?=
 =?Windows-1252?Q?UcuOg5lcD68pYqKt9MSIw2eoExrNjSYNFE8j28LIhc/ge16auUmPFRdx?=
 =?Windows-1252?Q?ocuIAPtNceUysfog8Yd05OmelmnUkWWjzX3s/BzIyisI2zbiPp36cbfi?=
 =?Windows-1252?Q?tA4eKkKd82TPHrgtu/o8ZafHkm7auTa21ZksOyeoqngzO8WMOChFs2/i?=
 =?Windows-1252?Q?ZDWd2EL3nAXF6k0A66N0kb7Ghef2hG8ftvQ+FTvsBwO8bT8LBDHQiHuc?=
 =?Windows-1252?Q?H9qeP+asPw2aumxJOiHGREjFamDvPu+CDn1cfzEU/Xd2dzI9fbYdc0RR?=
 =?Windows-1252?Q?Wmf6oEmykIwcehpgqxVHmc4y5/NUoQ85XhXitPdS6hZZPSX6H/6vYDFt?=
 =?Windows-1252?Q?iAYUT0ZT1l5B8HjaIa5qc1W42obJsBUEljB3V+v+O8vQ83d3qo2Ge9DT?=
 =?Windows-1252?Q?BVneg7JgCbIr/CfO4D97EDDxtT64NcqtjsM7wCtGLbHCs2HvUCIMk8kS?=
 =?Windows-1252?Q?uZY306OHAZ1j1k1SmcSlaXfBIvut/MIdUBd1PYI2kZws2DNWYoqg1ggf?=
 =?Windows-1252?Q?XmBAEN3+kXRJMxs3fqu4wQehgim+iqcMP+TemCBKuGlceyTx6BTviHt2?=
 =?Windows-1252?Q?5Hmoymo7gHPeZbADfeeeXGUo39kOxnyBPjmjQNHmTCZFydcSyiR+ZZaF?=
 =?Windows-1252?Q?hcEGllmrw1CTAW/OdqyjztNOogSLcAeR0EQ/tH4aNsKRRNYuJS+1mEag?=
 =?Windows-1252?Q?LW0fH/Y9oTqBdOfWun/SnnothKZKmYt1WdyB3zFjgN+e98Pn5X/lU59m?=
 =?Windows-1252?Q?8zzKrAsPbYcgMuivmh8I8cQxjF7jYyB+9Iz?=
X-Microsoft-Antispam-Message-Info: RA/1WLB7cH343hvBifLhvJRRjq2s3XnJuP77/oFLyf+oum1+pidvAA6/vkNMontVNyGERSVVuj9KFq3MeTh8ctVtjlA/0qocIzij2OG5cjgOaYkCsVJ09fXFWHu6ysGgICqUlr9XrukAeBUSxwmiHY7065NFijkqzJFLwMo0sW7sjgeFe10ArK+orLz910n/6FgqnwOy+FNOi8dK7PzQ4KFnv3t809PCdpoFBBL/PB1xb5W07v8HXqUL+S9QdGGZEQD7P4tfypY1iLlrJCcYDzZmqv6hGUhp/cHkN1Of5Q11PArDU5aEWNn9E1JnbbPoQ21SeKSrQv+8hzy6mF/B/pAKOUN4isAauL17n9tmVeE=
X-Microsoft-Exchange-Diagnostics: 1;MW2PR12MB2361;6:nSftPRU9nluGJeHVluvqPHcf4s437rafi0gWHfPDe8UcA5IN9wxuCzgn8muF+6qhokwyh+R8oNGrEqxnJC4VLi0OnAQg2OiqKZF8zT7LavyMzAX/evAS34vfJgt4VMIBw61UQbYxC/HPiUk9fUAPh1w82FEb1s43JzBIT+L649XmdwoMNcRSjCErq1FKC2Hf8Gio9lxbVFfgGSITJKPBfN7z7LQUz8MZiZexl/7ZdqELkwUu++7En1+hLnp8y1gKt/R2OkKR1wUEKf9LmzbvcufUFU1FbYG6AW2KvSG21j8oMlr6pIsyeVmXbFGwwFG/2inqYMab7bopU97j//JRKQZWvf2j8g0z1uTqWluhpSXa6P1TPLRYffEYkiQYqVWtQXRk4ld68n3r2lK/jwp5htNI+vlFlcHtyDyJ8wuwCLzCDqdFiiDjcb4KP3EXLPVnyF6CJQWks9WGxnXeydfX3g==;5:14o7J+f3Oxn04cC034QzH5FBeJqXBm/7X531Pdbp4wvek9wIs2gNdcnazrpKv+sr6MLwdmiLIxqCxOiSRJgTFA8G/2egLZ4Z8ByhygecYQOGiirQhy1aFv30GbYnxMnbfxVWWdGLuX6LTBOmNxXSYo4eEM+gCdeAG301abOeeNU=;7:E3BhaLMmJpi0EVBUp002VVyEJr0bcIuQq8BaWt63/uOe/tdUS5N2bDbXxkx2Gdp5GMTl6AgC5Envzk3h7712RuPj+yU0U6JiT5bZovuEH+/gOQy75oVgTxZml1WBTJaVta35aSUT+1En7sNIipWcQw0AhIZtEZq6fA8tiei2ImbHWwTKYhaiRbGhtGL6cPq87XrX0T+Oz1tCfNFVBLxJ/bHBSotiC5FkabHDjEGzGPKKlQ+e0Wb4S95iJZJW7nWS
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MW2PR12MB2361;20:3ep8WAwCUbvQQACaZ6iSKm+NQ5t2Iuy+4rnGW9+6PG59fsNWsNMN0myNctty4ID75uoV8HJ6S3fRtTeu8w4oUzbOrJ56eMgigjEMMypHAAVq1O/ey/P2OYFH49YjvDFLtVRHGzyiYPD6/qK/DAHwSInbIN2qx4yKA/tpXc6EvAlCg1qlHM57v2NhllRs1mHrSXi/J0ng1I0SCXS/2HZZ2D24Mpza8rsu4y621IzT02p+ZILTRnheA1Z7ZoHbDLmw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2018 17:21:32.6646 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3dc9a75-eadf-4d4e-f389-08d61741dd18
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2361
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/10/2018 5:08 PM, Mark Brown wrote:
> On Mon, Sep 10, 2018 at 01:36:29PM +0530, Akshu Agrawal wrote:
>> If capture and playback are started on different channel (I2S/BT)
>> there is a possibilty that channel information passed from machine driver
>> is overwritten before the configuration is done in dma driver.
>> Example:
>> 113.597588: cz_max_startup: ---playback sets BT channel
>> 113.597694: cz_dmic1_startup: ---capture sets I2S channel
>> 113.597979: acp_dma_hw_params: ---configures capture for I2S channel
>> 113.598114: acp_dma_hw_params: ---configures playback for I2S channel
>>
>> This is fixed by having lock between startup and prepare. This ensures
>> no other codec startup gets called between a codec's startup(where channel
>> info is set) and hw_params(where channel info is read).
> 
> This isn't viable - the driver will deadlock if the application hits an
> error and never gets to startup, or if the application tries to
> simultaneously configure two channels (ie, do all the prepares and then
> all the parameter configuration and then startup).

We can avoid deadlock by having another mutex_unlock in the shutdown
call of each of codec's ops. Wouldn't in all possible termination
scenarios, it will cleanup and exit via shutdown callback?

Having said that I think there is a better approach to this, is by
having 2 separate instance variable for playback and capture for passing
instance info from machine driver to dma driver. Respective codec in
machine driver will set the capture/playback instance. dma driver on the
basis of substream->stream can read the correct one. No fear of deadlock
in this.

Thanks,
Akshu
