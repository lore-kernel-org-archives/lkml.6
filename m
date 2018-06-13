Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id CC2FDC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 06:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69A8520891
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 06:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=epam.com header.i=@epam.com header.b="fwDJNTBK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69A8520891
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=epam.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754494AbeFMGvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 02:51:02 -0400
Received: from mail-ve1eur01on0085.outbound.protection.outlook.com ([104.47.1.85]:18560
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754398AbeFMGvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 02:51:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zmgZQSLX5ajYrWVLjODyo6a9LnyROlZjFCy+IahxnTE=;
 b=fwDJNTBK/KG/wL71xti3s7vnDGq9idEga6XbBu0PRBq2GxqXJLOL26kp1mSKnAwicmO7WrBzlo3uF7c5edMVKBP3ivP6C2UECmWLPYIWfT9u8CkKgWbUSpkOqA4VJSQxlXOQxv8O2m6UslIXGW369Oua1/TW9+U7A2NGlzZGQRY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Oleksandr_Andrushchenko@epam.com; 
Received: from [10.17.182.9] (85.223.209.53) by
 VI1PR0302MB3215.eurprd03.prod.outlook.com (2603:10a6:803:18::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.841.18; Wed, 13 Jun
 2018 06:50:55 +0000
Subject: Re: [PATCH v3 3/9] xen/balloon: Share common memory reservation
 routines
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Oleksandr Andrushchenko <andr2000@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        jgross@suse.com, konrad.wilk@oracle.com
Cc:     daniel.vetter@intel.com, dongwon.kim@intel.com,
        matthew.d.roper@intel.com
References: <20180612134200.17456-1-andr2000@gmail.com>
 <20180612134200.17456-4-andr2000@gmail.com>
 <124f3832-63b4-021d-0c6f-470229c7a056@oracle.com>
From:   Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>
Message-ID: <1817fea9-36fe-b14b-f266-8e40a5ed6169@epam.com>
Date:   Wed, 13 Jun 2018 09:50:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <124f3832-63b4-021d-0c6f-470229c7a056@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [85.223.209.53]
X-ClientProxiedBy: AM5PR0602CA0020.eurprd06.prod.outlook.com
 (2603:10a6:203:a3::30) To VI1PR0302MB3215.eurprd03.prod.outlook.com
 (2603:10a6:803:18::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 547aac17-a0f0-4c04-d4ad-08d5d0fa03c7
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(711020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0302MB3215;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0302MB3215;3:o1JspPl/jBhZRlgfcTbkTi1hoXrFUsW0vSWfMp7HwbyBb+MiLdDcqwSW3oEs4Z2FgNRB6yLta+kBPihr5N9dyaKynBY3Rv4yYjJerhOEe44vedtRmaV94JXWt/mW3Cc19ITcmF13iLI1lrOe6nsCjGk72RPTOskkEQWAwgBGsVjjMSIyYIRV0PVDqFsdAOwgW390ggS1lqXVrUhDyhtLOxheU5eqXtkblI3kfc762JoxXgmcB6MFqfKQ0lkg2oqs;25:95rSk3HNUe4YsS/C3v6lcH6k7P0mFXDRmRNaJEgjZnFZ6POWK+fukVU1K30LFxxopx+m1197Lm+BrOXB34H5hm6aZulINYhxlzNKffpiB0JAxEBER1scbmAyrvtLGMYt8b3y4rNtjwLZUfrw8eo2sfoSoeJuCxOAUoNUz+w5hdgbh3awqYw4Ljrx6lDofqLY9rr5tIlVOh0BYC5rxlkVcCHq6R/FG8iRIu9FLqrUUsGp/+8UACmu5tfp4aud2qtXep3udPxclN1E6jMhrpAGSa3evyflfUXRe5JiT1h95SPfFrI6u9tkBmKNuWbGDzC6XH5v9CMAG2q5+MuU1wRHMw==;31:RSut87t6rlPP7isiLISuTThIJfjge3UUQIwwevPVKFokVoGcfOLpPwgk6FUd3ouv1nHHTDVPTtjwTdVc/s533jQ5f1Eh4phf3Q7hL45eIXbc+fUrDcJHZ97ie2VyLFHdAHfRjXUv3qOYkeElThKTjosHk4AQH1T6xd6gyQJmDr2aDolTV2WXzSyES8RtSlCc696/oS8gSTYr4uVRZbTuvx9BGbMFOpc8FxU++IrjpBs=
X-MS-TrafficTypeDiagnostic: VI1PR0302MB3215:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0302MB3215;20:40KCtd+WUs4D/7wgl4q75RHIKhsaeqCgF2RWIxV9DlUXdvPXECygZctuU+ET53VCSQgRgrPM0zTeXsP77pfW2fdCQo+JltVwpLhtnrt2Z2VA0ZYwvp4khkI5uPV8KcRKBsZOfHYsM+subJcJDeDUpMBhdHNKGqzjCTUmtJlWPAVW5BceUYT+SmkzVhbi4cXPc14c53rxgkpgcSxbVCtyi7qLPCe2Wi269280IoFlrQ7AsNepU7aGC67VyDEMw61x0z+l+L+rK3Jm4fHH9afV++bp6SqRwkDQ/Yj4c86UF6TlApNIoM8yqLp/jvgTATZD8zVdOyHEcK2ToEHv+Jv0Cm66Ug6RKS9TJXB40d12n8S84b3NRgdxSzvEAinebNLjuJY/7dDhKp47qUpTuUexl3lGMo5BV1/BzGmJukpEJUNOolw8CIVbI4qEgvS9IRadpQlMrFty9Z0yWTbZjb2/pq87tI05Iz3wH6uIxojvLfBobRngHdsFNk8HFCLuFLsl;4:1TC6AkONJpmlALtQb9AVGTd39SJobZ2O2afbsT4c+guNydxXsYnyBi/3W59rXAd2vvefhDXs+TpT/BsWxh9yd3T2B71jct6f0Xixok1YJRI7cnvT9EtQwIsxChN0Mb6gNoDbf62QC0R1XRqMDJ4NdkaEPxLfePaiSfWVPmgu5LWTYqGykvFBketHwwSp/DVE3ZatccH/zx8peO6KvqZbS59gCqvp0ifoO+603kOLATfYMASllXz6dMfHpuGoLH1TXgVO/m9HnqjOWvZ0sYel7w==
X-Microsoft-Antispam-PRVS: <VI1PR0302MB3215511B2450F3AF4492796CE77E0@VI1PR0302MB3215.eurprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:VI1PR0302MB3215;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0302MB3215;
X-Forefront-PRVS: 07025866F6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39380400002)(346002)(39860400002)(396003)(366004)(376002)(189003)(199004)(446003)(31696002)(476003)(8676002)(956004)(2616005)(486006)(25786009)(81166006)(86362001)(6116002)(11346002)(6666003)(80792005)(39060400002)(97736004)(3846002)(7736002)(65806001)(31686004)(66066001)(65956001)(305945005)(8936002)(65826007)(4326008)(5660300001)(478600001)(72206003)(81156014)(47776003)(6246003)(55236004)(316002)(58126008)(50466002)(77096007)(110136005)(7416002)(2486003)(67846002)(76176011)(52116002)(52146003)(59450400001)(53936002)(23676004)(26005)(386003)(53546011)(229853002)(105586002)(64126003)(2906002)(36756003)(16576012)(68736007)(106356001)(186003)(16526019)(2870700001)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0302MB3215;H:[10.17.182.9];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: epam.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjAzMDJNQjMyMTU7MjM6a2NPZ3doRy96L2FKQStuRGtnTmo1dHdr?=
 =?utf-8?B?dEMva2tLdVZubDZpNzNXd0p3NXpqR2h4azJYbTNIaHppS3BNRTczTkFmTmdQ?=
 =?utf-8?B?ZGlka1VBRUdHUVUxazJjZkVkaDlGR1daMFA3bHhGbUc4WjNLaFg1Zmh2Z1hV?=
 =?utf-8?B?YnJGZ0JyZFZESytkNSs2WFlzMXI4TTVINXpySUtRT2g4VktIWTVxS1ZKbVAw?=
 =?utf-8?B?ekxVZ1kwbXoyMVVGWUFLWDBYYi9KOXB6Vmo0UjRRNm9vejViMG1JcSt2QnZR?=
 =?utf-8?B?dkJ1OUdsc1Q1QVppRVo4eE9EeTkzV2p0Q3ZFT2ZnU09CTUNPRjdDdFRmZExM?=
 =?utf-8?B?V2NCK0xRZ0FIYW9yLzh1L1pjRTJta1E3OXpqZHdLZlllNnc0bHUvTkNTa0hY?=
 =?utf-8?B?YXdMNFpnVzJiTzgrM2hsNzZ0YkRmcGJOZFREejN1L0d4ZjF5QUpjekFFSVc2?=
 =?utf-8?B?UUlxOXQvR1hONklBaGlTZHZCejdzMER4R0ZIeVVlbjMwVi8yWEszaFZqUWRH?=
 =?utf-8?B?alhQaENVZkE3UW40SkdSbE9zeENuWnpReTFvVHRyWm9kcXVZQUc4ZS9tc0xB?=
 =?utf-8?B?YW1GckRjUGJreFl4TWpBY2o5THBhcklvWS81MkdsVm4vY3JTbkthcWpwbTgv?=
 =?utf-8?B?em5wY3Z5ZFJidkp3clJGSE40dkNIbnUreUdHRHZHMnJSeDE4OWVsOWRsalNw?=
 =?utf-8?B?MXpRWWszTDMwejA2M1lpd3BKMEZNellYUnlmSEpxeTkza1JHdGM0VUlTeG5r?=
 =?utf-8?B?b3E1ZnROOXJha1FybHJkRG16aHE0TW5rUlljNHhWMmt0TmViQlRkaXlxa2wv?=
 =?utf-8?B?RW9Md1ZKeVI1aVJKMUZkeHdnS2E0UDlESW91cmhNcGlvd2pEWFdZNW9QYkJM?=
 =?utf-8?B?VDBDbXl0VFVQMXA4STBMQVgwaHJJbE1ienI4TCtBMzM5VjVwOFdVcEllZ2hH?=
 =?utf-8?B?bERISi9NaUhLamk1NmFNcWY0NUF4RWJnUmdmejR5YTZPUHQxbS9rNkNJaWxl?=
 =?utf-8?B?c25tdWZHakhTRFJ4Q1Jvd1ZVOVpQSTQzTlBUMnR2UkdiWUJrZERnMm1wSnRE?=
 =?utf-8?B?WFVnZCtaMnQreWk0d1RHZnM3cUE3VFpaRjlXZHpGVHZwaU9vSE53UlRXaVRN?=
 =?utf-8?B?bUtRWlRjMUpETGRPcUJtblBaQ3hPUWhJZSttcklTaFptT0tCTGhoUVd0c1JO?=
 =?utf-8?B?bWVFZVNUallCclR3K3FrT1BaMXhZN0toWm1NMUxnL25TNjg1ajRJRlphMFZl?=
 =?utf-8?B?OUpzRzhyNUJQUUluRkg3SmV0V1plN25HQm1QT05WMVpQUzRFR3VPeUJCOTlZ?=
 =?utf-8?B?cnVPODBOT0sxR0xMUUY3cElMdERGRHA3RmRSOHpMY0RoY0RqOEMwaWZCN3Y5?=
 =?utf-8?B?N0RPTUtod3F3SkhIOFZuMWcrMGlZemYzKzRlQ0RRWUlGdjk1Z0tGM0tqWVBK?=
 =?utf-8?B?WWQ3STRpd282L2tvQ0RwV04zdERYM1pnTzV2WUY4M1YvdVl1WmNST0x3SVI0?=
 =?utf-8?B?UmtnM0hCRnhtenhPZ3M2L1NDQWx0TC9IYkJQT2h5YTZsdzY3R25pTWJPTElV?=
 =?utf-8?B?YlhBdjhXelNPcWk2WlFkYzErUGtDQ1pPUkt6ZUYyUFZHVFgrc3N1OVVxaW1C?=
 =?utf-8?B?cUFEdGdxSFMxdGVWU2w5SDFWQ3FMZWZ6QkRsWW0ra0xTa0RLQlJQeUg2M0xl?=
 =?utf-8?B?RW10MnZxdTRSby80ZzZ6VC9GOHlONlgrakhmMFRRVzAwMWJYTEhTdkczTmF4?=
 =?utf-8?B?dEFNY3NzQjY4SE9JRDd3K2pEZUU3cTJ1aUM1RGpaMk9HYjFIem5vZG9BbGdH?=
 =?utf-8?B?aHRBcHhVeVB2SS8zemdHZmZrZ1hOdlhib2NqOTdheFhaRGFhMlRJTGtzYVE3?=
 =?utf-8?B?blVES1Fvc2x4SFlHY2NrM1JVa1VPbGk1UXNnWlk1MlRneWg2aHlXcjFZL1gy?=
 =?utf-8?B?THhzNzRqT2RGRjRVZjBuRnVIM3k3akNqcE1HRnliWWJQMFFJWkR1dEJYUXpH?=
 =?utf-8?B?S3M5Mi9UVi9iWTg1alk4T3dwQnlickx6UnFDQkg2ZGs3QVNuNzMyMmRseUZY?=
 =?utf-8?B?TkRraWptTlZUVnZXM1JDTTZNSy90Y3hkYmM2ekFKSlVyV1F4MTF2WkZzMlVG?=
 =?utf-8?Q?2hjr4uqRSDnCO1MaXN+n/CX9c=3D?=
X-Microsoft-Antispam-Message-Info: +YIfxAW/AAjWjZ181N0WdyyDTNhx2fFqimfIqJF9+lprL49S5eU7RcHJe5C3Ic+K+iNCwVGAQD85mxJqtWhzdtjGSk2voVO/d02iX5DVIGYrqYhqbgBIPOFJUo7jUvxS2PojnawBrMEQAu/VAlJY2kmoiA95Igc05XyFt71DQ4ul02hXngSveFwhEiUH3ycu
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0302MB3215;6:DtVAzguR1JlrsxXwVqyArKw+n6MhgdAnJwBjS0PLDYS1CmlX9wp7owbSGHtolNpK3cqGcsivgKoj8Z7VOx6kMBLClKslrJbJV+DrrB+xqqzCbC/q7s7BdsQ/kkHTIiicH/FGaKkFndyd0eqec6FKPtKFXlXi1QJqvMNktG0p1pAX/UtW66QslkmsZqXl7egwX0vyuBb0evAq3JZc2Axi5VoZXoJqu6XtEKoZ9XXMa2JGSUsDTRQzoXDEv64OK2nT6bw/YCVigHG6mEIPu4RTFMfa+3cz7eQYiybe+3GES41eYSJGFWgpEbnjUn88q2lKSvN3/2hfjNkiBBOc5dhiyI2zlBX+DMz0Rro+8MreQHS7XiFMc2gRNG6d+FYLDy2NvQb3/VPpKVTF9+2e2qjZBk0ptuaYVRuQR2O3O2xya3qKXeRHvEk/eYdxaC6suA1/X8ohIe5U/i+AiNfYCP9Kaw==;5:C7B/ClPXry/8r3XbgVStEjV0LZ31Pr5fPpLNVgt9ktl6h5W2Ece34NUajoYYgCG8aMuWE5gIcHtKRMue2qS1e/llcNi2bZm4ZjN9TDixjMMXK7tDLhpfHY1hXzOp+cIHhDsnuaAoqJhIByzd6CiETguYc7xpiEPbI3MhpIVCNJY=;24:l+X4F3Gigo7slTBs1u5JZEgJ3AsN/VgNR4rW301wpmcu6hFV9d1ToJNscY+5/RuPl/TV0uRFGn86fomL8vCYD/WAkFagmqq5VNt/er2jDuo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0302MB3215;7:7h86d1gLR+/QmCW1T09kG4J2H9ospsWmGeqqPzZKPzRYTxYaC7poqllaveRBL6/XGQwiMUafULf7q/Jc9udPIkNj1YsEnWtoKsqUA+nxp4fT5aFFa5U8TcO/91wI8OTqXhBJyNFW1yHJVeTppEl1Clz8mYoWGEOcCbwjv61AvvGkM9NrUcCGPZKHvTkvgnCOW68VHM8gtH0Cm+JTg9iwZnjBH/FqpP1EZtQGutDS6OoN0MlXY8mefMJnvofCvK5J
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2018 06:50:55.7746 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 547aac17-a0f0-4c04-d4ad-08d5d0fa03c7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0302MB3215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/13/2018 04:07 AM, Boris Ostrovsky wrote:
>
>
> On 06/12/2018 09:41 AM, Oleksandr Andrushchenko wrote:
>
>
>
> One more thing: please add a comment here saying that frames array is 
> array of PFNs (in Xen granularity), which is what 
> XENMEM_populate_physmap requires. And remove (or update to name the 
> actual call you are making) the corresponding comment in 
> increase_reservation().
>
I will remove corresponding comments from the balloon's 
{increase|decrease}_reservation
and move those into xenmem_reservation{increase|decrease} where they 
belong now.
I will also put a comment close to xenmem_reservation{increase|decrease}:

/* @frames is an array of PFNs */
int xenmem_reservation_increase(int count, xen_pfn_t *frames)
{
     [...]
}

/* @frames is an array of GFNs */
int xenmem_reservation_decrease(int count, xen_pfn_t *frames)
{
     [...]
}
>
>> +
>> +int xenmem_reservation_increase(int count, xen_pfn_t *frames)
>> +{
>> +    struct xen_memory_reservation reservation = {
>> +        .address_bits = 0,
>> +        .extent_order = EXTENT_ORDER,
>> +        .domid        = DOMID_SELF
>> +    };
>> +
>> +    set_xen_guest_handle(reservation.extent_start, frames);
>> +    reservation.nr_extents = count;
>> +    return HYPERVISOR_memory_op(XENMEM_populate_physmap, &reservation);
>> +}
>> +EXPORT_SYMBOL_GPL(xenmem_reservation_increase);
>
>
> And similarly, here we are requesting GFNs, and update 
> decrease_reservation().
>
Please see above
>
> -boris
>
Thank you,
Oleksandr
>> +
>> +int xenmem_reservation_decrease(int count, xen_pfn_t *frames)
>> +{
>> +    struct xen_memory_reservation reservation = {
>> +        .address_bits = 0,
>> +        .extent_order = EXTENT_ORDER,
>> +        .domid        = DOMID_SELF
>> +    };
>> +
>> +    set_xen_guest_handle(reservation.extent_start, frames);
>> +    reservation.nr_extents = count;
>> +    return HYPERVISOR_memory_op(XENMEM_decrease_reservation, 
>> &reservation);

