Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9703C28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 04:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44FFE20862
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 04:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="lXVsCN/H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44FFE20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbeG1FyE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 01:54:04 -0400
Received: from mail-eopbgr680079.outbound.protection.outlook.com ([40.107.68.79]:63181
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726003AbeG1FyE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 01:54:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W61QgQ/Clg4mTR676ac4x0M2oh2nbpclRY4b34VGhes=;
 b=lXVsCN/HqVceYFsRH/+571CblXyrtD31eXNoeKlrR0uF/MwcZoDcO3tZzucn8WV7vPnMKxhXfIombFzpLvPcAuUHQ0zI9yJaodcxbJSLQtMdeIV/vTcR8xVSZL+0U8nDA8Xox6nrsIeaO5F+qfBc8TW8QfARguFfb8GVTcc5Emw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com; 
Received: from [10.224.118.17] (125.21.194.1) by
 BL0PR12MB2354.namprd12.prod.outlook.com (2603:10b6:207:4c::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.16; Sat, 28 Jul 2018 04:28:20 +0000
Subject: Re: [alsa-devel] [PATCH] ASoC: soc-pcm: Use delay set in pointer
 function
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>, djkurtz@chromium.org,
        Mark Brown <broonie@kernel.org>, Alexander.Deucher@amd.com
References: <1532686422-1790-1-git-send-email-akshu.agrawal@amd.com>
 <66c8b8c4-bdd0-0129-5e5b-850890cfdb8d@linux.intel.com>
From:   "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Message-ID: <e0990b62-897c-6dc7-8ac9-296932c505b7@amd.com>
Date:   Sat, 28 Jul 2018 09:58:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <66c8b8c4-bdd0-0129-5e5b-850890cfdb8d@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [125.21.194.1]
X-ClientProxiedBy: MAXPR0101CA0060.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:e::22) To BL0PR12MB2354.namprd12.prod.outlook.com
 (2603:10b6:207:4c::32)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 52b72e12-171f-4f7a-339d-08d5f4428e1b
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BL0PR12MB2354;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR12MB2354;3:ny0IMF29tI7HNOAAar25NLl/mEWVUN+NNvDfNAW6fNZMnxaqt6VFAvd5U6TO4l/8iCa1NFDBPq6Ksu0XAtDQHEAbVYAqBVN0a3YjP6IDa14EHs4zxM2OoQhu5YXmTwiMqtKsIrVgEBnOgI7xdsmFSJ/RTKnCYhIynWHZIoGdyw1P85EEPvxpjDpzVhF7mm79AWZtrHJomGIvG6ulW9mscpMWbvMU3YpTtKGpvqOwC3eT7g03nkM9NuSa5aJgEH+n;25:kpAYUhylzmu77CqKmiHRNSWzHVbSkjesExuSAQ8/R6XZtqu5OfeTfLhGN6dMyT95Bbshy58tNaKBYYiciGS8OvT30UjQKVoNqwbMZ1mH/Sn9+tLcsiHE8ctfR7BhIgdLhHzruBviueKp6Dy1ooQih1CYOFKOC0Qo/bgIKVfh2/lEW4o698xBer9A8kkmiB73uPLyW6vF3NXYaO2HZH+tE9ouj3D/csF14vlUglFrlLoPPChV29ysXdULJLQDeLyVG07FeEV3pjlZZeH8Ji8CBtS2p+ZVbkeXdK8BYnO284Kmp+0Yc5dUQjHEelRSW2XyNRA/X3NpefF0e3geXNIiuQ==;31:jgKacjpwT6YHceta6hzUwrE7Vt7xoKNsx7/nfyokat8ZuD+yLaU02XDDDi/nXztuIFAwDtAoxMkNvW2d+Q9dzfoXUKcXaCOAd4mLr/1X3g2SXwkRgQ9yaF4+KHoOLDMu5wwSVdQs/gQjJS7T8ArHDDuPfoePctc+7QW1eJlVJJjYdG1GOV9PF3t8E0mnEO3HWS2THwakL67EgDROM2ie3a5cx7nLBGn4uC/Q7h3lV0g=
X-MS-TrafficTypeDiagnostic: BL0PR12MB2354:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR12MB2354;20:7K13STVNC8rmwaUvT0yIESN5CfuicA2sbXMBrrl0HHSUJD6A0Yc7D1ssQdPR/3HHm14F28xPStJkHY5HEFiGgDKdFh7YV4Jpc8fGaXARwkhS01xIciHvVVUXHr2vKkGFBnpQNP0vbvS9zGXLViZywGnq2exfCa4RjGxj7ZDe+NPmHViv3N+lupZ3KdnfGSiMNKpy+HC6+hNNlvAO003A794og1VfVSghzk4vx9iDOg3ZIChM+qDgk6vIumoX8Vf/sDuqt3YZHmutcbIlo7iiEcSH/5g9NreCDm2IcIgDgr/Uu+dY3vhduANhU3rSpH+i6DPvAC24wy1xPAo4h+Ln+juTdqU5++o58u7HWjj7uMsf7hc3j+ed8N0eh3P7a2/kP87uyc3/B3DKXR4O+1thWGBT/unqaNEqkvS1UWkagLiL9ymoitRNzhJ5hHEfdWaozYNoGfWvEvtV7NYPAikW6pxgoi6yEEwlHDzZ7kKXYkivW7ivEGqiTf5WcAhocL+T;4:i4NqHXVsUCO0Q1cY1cYO/vR0x+w/6ZXnwbiXSXznGoHGPTkdbHsU/tPI9T9w0Yjr2f2SSX7YfWlzZSrA97g7w2V7Bt8VogvYB/AAe3BPvlqTvAUIu5Vlcnap0z3EOrkiEaRPplXcrh9N3IU4oxRDJjbxt/cC6PnxII8B2Egs8ROG8xmdGINiJBzawV9/Hq9VNkeEb/vy/vme2X23dDZDo5tymQfEDf1iN7SevisR9prZwF3nSb3KwvoONj7c3bgbeLEk8mnjgaCdBG7k9LuRwY7LU5EoQWG1HRY3OL2+6ig4r3HXq0JCUek9QFL2f7ot
X-Microsoft-Antispam-PRVS: <BL0PR12MB235476B2BEEBCE4E6EF69370F8290@BL0PR12MB2354.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BL0PR12MB2354;BCL:0;PCL:0;RULEID:;SRVR:BL0PR12MB2354;
X-Forefront-PRVS: 07473990A5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(136003)(39860400002)(366004)(396003)(346002)(376002)(199004)(189003)(305945005)(3846002)(229853002)(7736002)(6486002)(6116002)(39060400002)(36756003)(3260700006)(6246003)(486006)(97736004)(50466002)(4326008)(25786009)(230700001)(68736007)(86362001)(8936002)(31696002)(2906002)(16576012)(54906003)(316002)(23676004)(52146003)(2486003)(52116002)(76176011)(31686004)(47776003)(5660300001)(6666003)(77096007)(58126008)(64126003)(81156014)(16526019)(26005)(81166006)(386003)(6916009)(65826007)(53546011)(72206003)(8676002)(14444005)(956004)(2616005)(11346002)(446003)(478600001)(476003)(105586002)(106356001)(65806001)(65956001)(66066001)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR12MB2354;H:[10.224.118.17];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTDBQUjEyTUIyMzU0OzIzOnNyNGc2NlVUcVVPLzV3blZEdStHbkZjRFJD?=
 =?utf-8?B?SlVoMGNZc21jdEpNZnFsVm8vem9wY0Q4OWJjcDRxRVBZakNMbU8zMzBENm9h?=
 =?utf-8?B?aUJ6bllyS2xwY1Y5MmluSWNTalFYSjNSeHk3VHBuMElHUVRHcmRaektsWU01?=
 =?utf-8?B?Z1hzSFhUUm0zenN4aUZIcGIveUdPVGE4SnUxUXpwWEhXRFd4cHplYzFRTDMw?=
 =?utf-8?B?RmpnVkV2V2xKcUdmNVBjVTlUT2FkanBDbG0vTUhTbWhpQzBBak8yL2xqOXNZ?=
 =?utf-8?B?bFFyVHlIVktIUWcrSkg4RHZCakVkejIrWHhiOE9hNHZCZ3BBekJzM1JHU2s4?=
 =?utf-8?B?R2VOWE5GMUh4Zk9ZeGE0S3h0VzhROHlxMDFCZEFqbXh1SDQrVWJqR2VjVjVo?=
 =?utf-8?B?OGkwZytsZEZHaWlUNHNFTVpiMko0RlkrRytLeENUOG00SFVMMDBueWM1bk1s?=
 =?utf-8?B?T21wbytpN2YzakJxdVdkTmFEaFlyeDFKblRuYWJ5WUJKOGxjS3lGRW01YmhW?=
 =?utf-8?B?MWlSY1A2SFp2Ym9rRDdRaG51RHRhL2dQaVJKWVorL1Zvb0taOVVodThDdHBi?=
 =?utf-8?B?bzU1OVNldjJZZmVnTkJYTGdCeW5HVXozTXNLRzNFYmdZTjV1ZUxjWTRPWkJ0?=
 =?utf-8?B?Qkxla0lvWmpqM2FSTUhLMDBMOUZzUkhkaVlNQzBRdk5oaVpBdDQ4djFvODlO?=
 =?utf-8?B?SUNXY293aVMwaGl6amJveG1TVFpJeW80SHA2aEIreks3ckVLWFlDS0NGL2dF?=
 =?utf-8?B?M3I5T0M0MEdubGJsd0FEOUZkbjgxRjNqVmRYQTh4eU05QkJ0RXZxN3orMzlj?=
 =?utf-8?B?SXhod2FwdGtmQmJxdGI1TzczeWU0ZXlvcUY2VjJua3hhR3lPTCt6cFJYc0JN?=
 =?utf-8?B?UmEyT0tZYjBGWE9pUFNGRnhyZUlRaG94MUloY0lOLzNYMnF3M3hhTVY4K0ZS?=
 =?utf-8?B?c0dwNWUvdU9NaktLT05adkVBUHZmcDZmMS9lN3crbnl5UzB6OHlLcXp0TGZw?=
 =?utf-8?B?cFBxbzA4dGp3alVlN0N1QkNnaVVQUkx4a2pzTTFwYnlPYWg1WnAvK3lma2tM?=
 =?utf-8?B?NkVUdmc5REdjaWFQUVdBcmxpTFgxYStzNFN5SXhvR2xqN0FmSTZaRTZzTkVD?=
 =?utf-8?B?NW9BdXJZN0k3S3o0cldhS0tvM0dLQzZ3OG03Qmw5WmdHWjRHM2pRdlprRzlL?=
 =?utf-8?B?NjFMTFdSbTdmM2FLODhPN1ZKbXZuUFB5b0hzNkFhNHNwSGt6Y09RSWhWKzZt?=
 =?utf-8?B?OFdScmp5RTM3TVhkVS9jaHY3UWFQRjIxUUgzOGc3QzFhV3BwZERmZDRreFNv?=
 =?utf-8?B?VzgxellvNm5kMTJGMUFCNklaekw5L3V1SjJSb1ZieTJPam1rbGxHYjJCSFY1?=
 =?utf-8?B?Z2FXbTFjY05CSFkzdk5KUWw1R0x0bVJ6d2VKL0ZqcHdVbDFXeDdVUlplT2du?=
 =?utf-8?B?ZGxUaCsyRnVLZ1VNK28zdlE4bDR2bTV2WWUzQW5pRDVGbVAvWDZPWk1CRHhE?=
 =?utf-8?B?UHBjaEhuYS8vWk5pUXpEZmJuSTNXcGkvYkZWK1V5WC9rOVk4Uis4R1NmbmVC?=
 =?utf-8?B?QnRmRktzYjd0Y1J0WEd3TUw3RVNxY29aRHp5aW8wSWxjcG1sajJTanZrb1lw?=
 =?utf-8?B?YjRqQk5jbGhHc0Q3NTNDQWhSUlpheTJadDR5dEpsS25iNXNjcmVQNzdaSDV1?=
 =?utf-8?B?N1dxUFE1Y1VTU3pyQnVLc3M5dGN4N0lkYWJpa3owNDFieFNnQnRDRUU1WUYw?=
 =?utf-8?B?UkhVOGIwKy9CUmhueDh3TTlBMlZNVW1ZOUZPTWQyaFZkOTY3L3dBd3ZxZmZz?=
 =?utf-8?B?UzU2RTNKK3krWnVVb3BNbEdsZDQyVTBSa1dIenY5ck9EenVZVzFZR2NOQ3oy?=
 =?utf-8?B?Zmpna3NsTWdDUGYxNkZmV3pEK05pT0lDTjJ1a2pLU3I0THNxbGdteDdQaTIv?=
 =?utf-8?B?aHVSeXVkU3Y5R1NYZDZyUFA1WmhTbzRUd1NwZXNiUUE1bGtkOXd0Wjg5UWNL?=
 =?utf-8?B?T1pPOSsyd2Q0OG1JVXhZbjRQQVg4K3NrU0JCNGl3QzRqWUJzcWtVZlhtMUhH?=
 =?utf-8?Q?g6S0=3D?=
X-Microsoft-Antispam-Message-Info: ZjCvxPK1w2AVipjDQ9TtzznOE6td17sAvou1DcIhyctlYFQ7Gvv7ul6Lr7E4WSUETojcHU865ylHing4Pwj1SetS70ZpyxDSk7ObJsfLWw9hjiilV7jZH58OFU3VWOQye40d9Act2LJtVUflFqdX6Baus1ium3fgaMZU1CRUm+lusdMda8PopVe5pqg/1TDP82Kr4Lvrvpuia34UFX2rqxzhumTiDAZ3Q4bKtkZFwBoxeIVlVvTT7Rckwik0hgbvVaasW7qJJ2klaUHlb3vY0bNXtLkmt/O0cMe1nAtqFdIv8IZVf7zF21B8cGZMS2oCkY1wxrfHGXuOGsXhf11om3s2bPSPLv8ZoM5WxVlfYac=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR12MB2354;6:Mg2DBWneqWFQynYqsGr7OgH9OcBnXP7MrKMGSG0uZk2c1DKV20QtjtGUMSYPUwIPcAfb5rPeA8I0DV33FLV/YWa9V15hk7+SFEL3RjyylDmkqnzCwzXXxUXb9GZtykw2NhKKzsD1pAU+Aw6bPepr3jt2l3lYP6aZyoOp0OMEah6t5YBNP4qVFyTPnHEKkcX02dF0hu/5MHmdLp7xfmHbWfH6ZkPTCXyPEHnE6ydmdY8j8JTgkHhhR1ez2BSeym7d3iHNrVZ+MEEf15xenvZoNFRjKZ3hw7tfBkArwiHz+ExrmFxFbv5Y1YTa7p4FQdGUalN+aAbAKZAZEmv1sAZgiYz36jWDIdCP8sfEYSE1641+0/RYlrA1GztQIzU89OL9LCFf4dNpq42NGj+DRExNtspokjJdPMGMv+j73O190u6UKs+214YTMDUK8966zyNHM0dn2Wd8x3/SiT34VdqB3w==;5:mwTNCUkmUTKC7+C6SUM7NAifvH06HyR/saypjZrL/4G0F68PJ0C07Q2wPA+0uf4K6D1Tc2EUkPt7vHpCTyAATOxy3ZGSZ6hjbpLhLP6Y/tHSQhlNh55RalXjD/dSWesMuLtbJcaEybZHtikSKO+WykOu8TnV4MjbVD1+QJyqLRI=;7:iwprB6A+Ra4amBvrN4SOiKVFn3MCmGls4btakoXPqPuoau+MdG77X21gNgrnnjaP+vj/HYzbCgfmG9CrU972l2KDqMhQCfvqWd2DZJKWBe84DDLcGMh66Aj14t7YZo5hD5BMZqBR2rd5T5AYSdRIGmw0Lf6Ov+76rmNfMbZEveqq2SbabKPVJZmDK53oTMWZoyFgjs5HptdBUOpdkF6n4sb7me7RuXhDt7JRXvQhbunBGXEic0smvZUDDW0P7vUa
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL0PR12MB2354;20:lh9vS6sFRwGZTFr/Fvj485b2Are8zIyNzKfMZyOIAuezMgJVttYSIgcQ+xr7hZbAgb5dUMrURbZUJY/3rjunpLtYAfS2i8y/Zr8a/37l4WHd4q9Y+y56Ratbjs9G7S4OYspTRntZzJeBhc24fHwTiwzeWzIVJQ6VAiApxzAYytlbFxKXdyyf/naIJPgmJUSWGcjPJV4gLwWugnhnAom+W5A3XwCRMVZnRoeHvgC7PqtmXx0Xzt4Z89UJFi+4sJAv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2018 04:28:20.0709 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52b72e12-171f-4f7a-339d-08d5f4428e1b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2354
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/27/2018 8:39 PM, Pierre-Louis Bossart wrote:
> On 7/27/18 5:13 AM, Akshu Agrawal wrote:
>> There are cases where a pointer function populates
>> runtime->delay, such as:
>> ./sound/pci/hda/hda_controller.c
>> ./sound/soc/intel/atom/sst-mfld-platform-pcm.c
>>
>> Also, in some cases cpu dai used is generic and the pcm
>> driver needs to set delay.
>>
>> This delay was getting lost and was overwritten by delays
>> from codec or cpu dai delay function if exposed.
> 
> Humm, yes the runtime->delay set in the .pointer function would be lost 
> without this change, but the delay would still be provided in the 
> followup call to .delay.
> With your change, the same delay will be accounted for twice?
> 

It will not be accounted twice because no driver which is setting
runtime->delay is defining .delay op for cpu_dai. Vice versa is also
true, the drivers which define .delay for cpu_dai don't set
runtime->delay. And I think this is expected from drivers else it would
be a bug from their side.

.delay for codec_dai anyway is different and has to be accounted for.

Thanks,
Akshu
>>
>> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
>> ---
>>   sound/soc/soc-pcm.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
>> index 98be04b..b1a2bc2 100644
>> --- a/sound/soc/soc-pcm.c
>> +++ b/sound/soc/soc-pcm.c
>> @@ -1179,6 +1179,9 @@ static snd_pcm_uframes_t soc_pcm_pointer(struct snd_pcm_substream *substream)
>>   	snd_pcm_sframes_t codec_delay = 0;
>>   	int i;
>>   
>> +	/* clearing the previous delay */
>> +	runtime->delay = 0;
>> +
>>   	for_each_rtdcom(rtd, rtdcom) {
>>   		component = rtdcom->component;
>>   
>> @@ -1203,7 +1206,7 @@ static snd_pcm_uframes_t soc_pcm_pointer(struct snd_pcm_substream *substream)
>>   	}
>>   	delay += codec_delay;
>>   
>> -	runtime->delay = delay;
>> +	runtime->delay += delay;
>>   
>>   	return offset;
>>   }
>>
> 
