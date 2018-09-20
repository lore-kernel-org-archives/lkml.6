Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0312C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 07:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E8BE2146E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 07:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="M7RN+YSw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E8BE2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ysoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731546AbeITN3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 09:29:49 -0400
Received: from mail-db5eur01on0088.outbound.protection.outlook.com ([104.47.2.88]:63856
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725925AbeITN3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 09:29:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sAG9v70sSUSFHlWr/83rp7iSrtTbqhyY4izQuLK3raE=;
 b=M7RN+YSwvL/S4WOswfdOfaeEesgOMUctMR3hVQl3n8I1T1vQ5aPGfvYXS59Zn7F1mLLsMKCHhPvhyPhj/Q4gXE8dwrNp4tXkzb97Q0A0QGcr82mtC+/HviVOvolqnV8jgOlFwgmkrhIQF35ijrLpyCls1v5oS395YKmw0QH3LIU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
Received: from [10.1.8.111] (89.24.100.190) by
 AM0PR04MB4657.eurprd04.prod.outlook.com (2603:10a6:208:75::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Thu, 20 Sep 2018 07:47:35 +0000
Subject: Re: [PATCH v2 1/3] video: ssd1307fb: Use gpiod_set_value_cansleep()
 for reset
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org
References: <1537363049-48399-1-git-send-email-michal.vokac@ysoft.com>
From:   =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
Message-ID: <9c7cbfd4-23dc-4729-a7ca-82bbc8f6c1aa@ysoft.com>
Date:   Thu, 20 Sep 2018 09:47:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1537363049-48399-1-git-send-email-michal.vokac@ysoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [89.24.100.190]
X-ClientProxiedBy: AM5P189CA0023.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:206:15::36) To AM0PR04MB4657.eurprd04.prod.outlook.com
 (2603:10a6:208:75::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86e1f6ce-c06a-45d3-e431-08d61ecd5530
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4657;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4657;3:0jq1nrxyHYIntXC2h5H7W6O1XibsLrFm0V9lGWVgq9ADIOulS1ZkaoHbntSK4D/nPxqm01pWmKdsnPXIvBl1l+HC/6bRCCh6WMBVGKBtRF/HHw7PhfCtL54jkN33THaGMPmPLWkMaItzPK++fBXbCgZWAQBZh3cHptbZrmwXAVizZep+cyNlTqCnvGMhtHqsn2IH5lWMfkeWRCm82afPcJtnkP0doP2S6Mt2nrK53ikgM0Zq8/RX/lRf5zLwrjY9;25:PEBJtLwpw6vEYyBVRh6VXsw8UewEcZV5PgYH/+dAGwXtFaVKpNJu/IsSybOW6PnqtiKyY0yzoFw5HWWehOmZ/87aENNhYLKFXkg7SFHTctk6tqTwTHHGP0W6LnoWGuWUyEHEx9Gt99YoVjjrdwpHhv28woft05ZXEE5f0B9PasAUPaa8/4v0xFSgCyCi35iehhI+Jkh2hELDGCZMWx37PyHobzy7foFvudf7gXsBM8p4SJiGxXm4PloaC5U3HxbmLmSTFAxQk4deEoyWgos7ihmoAWetafGs/avkwGlcQ2wJDH+u0zqQIAml6YrLSVVwOu7Y5GUFP+vYhQ2w9hjtlw==;31:ikOnz+Ii1DO8Bhkq0V7u2lV7dHJyyOn193Hct7GxTvkXixOPfLIh8eIsK2TwZBvk6YV/5ViRIjMr42HJ9xUsVqCPwPbFAgw9tb9K+zNwKlBxuZ4t1yzhKhm3HCpM/qM9lFB0Fs25u7S3ZMivEDNKGjM19WkElEmV99dQDLPgYaP1jNYdRx+vVB7eew9wdB0bw09dz5nB3TVgIXxDPzzKB418F5sK36t+7Z8fGabde6E=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4657:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4657;20:u2gV2CoxpmBsn940bNvxwQZCzbnkNR8QPovCfxQSMKtejfJUL/I+8oaEB8VG+K9t4ScJ1kiHqwHDyPsGudAP90QyRe3Tics2vIlIGSSJXCUc+0nvoyPSku/pp6AsIeMQKsypxJx0mErtFhoQQECDgP7FIv23YJf7ZLLujF+duAHCLFzFmT/8xCMp374tDlGCbClxC+zeB12YZxPs/56NOA1UVTFN02WbxJkE0ycsJ1YpQ4gS9NJ2atgCxj82Ct7v;4:gHtkzzh/q4DjLvBlZ/4gH7RQ8TOiGl2x9KaL2srWEV8joV+mzlgoSROeahbpqGOaZfUbKJYJqjd9tGRjHPpLVJM7FVwWP1dy1rJjXTg0HCYJKyU78XrzppSMQx2eIV+YJs8jZbvR96yz/3micdz4GMRNFDTPUQ2SQLlfXITZQdQI05XkGWX8xln0gIaZdwFryUvBGQ7QuB69bBRH5OjxAhLkuD/Ix2h8RdurRDJdbqd8hVf1ErR0GZkjDuBMRjCCXizyXqtjDrLJ69XKlyS5EA==
X-Microsoft-Antispam-PRVS: <AM0PR04MB4657B73EBE93ED6A11A358CD9E130@AM0PR04MB4657.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231355)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051);SRVR:AM0PR04MB4657;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4657;
X-Forefront-PRVS: 0801F2E62B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(376002)(346002)(136003)(396003)(366004)(39850400004)(199004)(189003)(65956001)(26005)(6486002)(16526019)(47776003)(6246003)(446003)(8936002)(11346002)(81166006)(2906002)(5660300001)(53936002)(36756003)(58126008)(65806001)(97736004)(229853002)(16576012)(65826007)(81156014)(110136005)(66066001)(4326008)(68736007)(956004)(31686004)(316002)(53546011)(106356001)(64126003)(72206003)(105586002)(23676004)(8676002)(386003)(186003)(305945005)(77096007)(7736002)(54906003)(67846002)(86362001)(2486003)(52146003)(76176011)(52116002)(478600001)(3846002)(85182001)(50466002)(6116002)(2616005)(25786009)(31696002)(486006)(2870700001)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4657;H:[10.1.8.111];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTBQUjA0TUI0NjU3OzIzOkpUL3BKNUNpSU8rRXZYR05lTVJFRWMrZitM?=
 =?utf-8?B?TGtFNENPNXdDdGtyM0NKbE9Uckk3ZWw2OUJ6MzJJVnJVTzMxNFE2SUVUemFr?=
 =?utf-8?B?cFJrclBsNFBCVHcyaWpIZnpIdFB0LytVWVZXL3R2MXFqQzAwZzdVbG14UFhi?=
 =?utf-8?B?K1VkT1k5dU9pU0EyaHA2OUZZVmd2QzFZdlBWVzlBVVBpbnBEKzVQRjlNaVJZ?=
 =?utf-8?B?TzNSOTFsb1N2WGtoQWMyaHJrQXQ2NkN4eXp6VDlYcy9FS3NMQzZDMEpnTlMv?=
 =?utf-8?B?NlArWjk1c0w1ZmFaQ1BzVVBmY0h5OWMySUdrTGM5NDZRcEdFODY4NDVRdXBk?=
 =?utf-8?B?WFpZdWhxRHIzdlAxQ3pBU2txbzVkNm5xZkRJMThlQkNGbDVaOXNIcVJZOW1F?=
 =?utf-8?B?UXV2SHhGM3htdEE2Mm90U0dSNUJaYUlDV3JSOXNNY2RxMVp5bzNWWFNsbUJR?=
 =?utf-8?B?Zjc4NEtiSFd6cmliVldoZ0VQMVY5SitiSVNDeTFTZkpoQmhUZFdieVVCbENN?=
 =?utf-8?B?SW5MdWdqcE50LytDZ0JSaW1KT0syU1RMQTgxVFUyN1huZXdjSWdUbmtLSXpK?=
 =?utf-8?B?NThrTHNpN0FjdW9rWjVGUUJUTnQxYXRESWFVbngrUm10eHB0Ni9xbVpWcnpj?=
 =?utf-8?B?KzI0eXNrcXp0V2JuNTdsaitPSDNEeFVWVjdaOVFFWFdOWmFrNUhkeUxwQkFm?=
 =?utf-8?B?dGJzZ2RCSGVOSjFUczYycWVTWmw0SkdZT2N2dCtXVDBrY1J2NFk5ZHRRWEFJ?=
 =?utf-8?B?ME14YzdRS1pvOU90Q2g1d25oTC9tR096c090R2VqYTVtbW44cVZYTmFQZkQ0?=
 =?utf-8?B?eXQ2OWs3WjNHNXhrQkt1S1Y2d1dlK2NPK0lYN3RBSmZ5UGlpeHBXeFRhM2dQ?=
 =?utf-8?B?VnBVTjZmYUZ6eElYRUwzeVpiQlo2RkNKbU8vSXQwbzUzUjgzNjBzUkZESUd6?=
 =?utf-8?B?ZE4zYmdpd0pxVHQyT2t6NUN1U2NRMEFUUHA1TUFCYjZWVWNTUTgwUC9JK2My?=
 =?utf-8?B?ZXdZd010OS9qUWwranBYRXpHZm5jZFZCVm5tNWUrRVo2UzRhV0RrK3BCZ215?=
 =?utf-8?B?NElaTTVQWHhtS1FKWGoramI3cHJrYlRrT2FmeU81REpPTGl3blZWL1UzR2JW?=
 =?utf-8?B?VUc5amhia2pNSjhia0t3ZnJsN21mbk52SmNxbnhVSXJyTmpXU2ZUQWMzWlVR?=
 =?utf-8?B?cjhpUTFsK2cxamxOWU1CSmpHbS9jQWdkcTBxMHUxU2xLUWt1MjhuaklyRHFV?=
 =?utf-8?B?dVlndnBBalY5OW8xc01NcUVlQWlEeVBhOEtKN2tJRnY0UFJ2ZzdnRUVuR2pG?=
 =?utf-8?B?UkhrOW95Unc0cWRTaVppMnFrY0VMYXRtbk9JNVpxT2dzMjFaaTgzSmVYSURT?=
 =?utf-8?B?NitKbnJmc0NpNDRaRjJCTU9pd2RZVFRRUWd6MnJDUVJsREg0ckpqOG1aejQ2?=
 =?utf-8?B?M0RhNytmblI5cktDZ0dHQ29CVnhBeExjQVd4YWtrbEIxMzl6RENOQmQxZDVy?=
 =?utf-8?B?OW9PdUZERDRFRUJYelFsbUZDTHhYZFBMamVXdjBVTkNjMnEwMkR1d1VTNUQ5?=
 =?utf-8?B?d2hXRUNTaTRsWlJzRG9qcHJxRmtLWG9Zai9xVHF2czlZS2tjSjB0bTVKVXpp?=
 =?utf-8?B?S0JxZ2FqWVQ3amFYZ251WVcwSFBOV0ZITXBxMk1uYnNPeVhBcnJSV1luUy82?=
 =?utf-8?B?ZE5SQkkwRmptQmJBUXk0MUNpMDRYdUlYTERXOExXMFFYNjhxSk5Mb3BrNEZR?=
 =?utf-8?B?TitKWDlLOWZvbUd2aTdDUVU4RVo5NGN0YzMrNGZOTGpQd2F6RHJWcG5xK01U?=
 =?utf-8?B?MTc4SzJhblNOUUttaWIwNm5XWDBhSldIbXZ0aFVRVzN0bm5hUUIzR3FxMjEr?=
 =?utf-8?B?d1h1RmFmdkZQd2tWL0Yyc1VOd0pmc1hJNktKdWxiNENxR2luSDZwclRyaEF0?=
 =?utf-8?B?SHVVY1FjL3ZFMnFHWWJHblB1V0I1bkJEQU9YeERjQTBVdmgrZHgzdkhITStq?=
 =?utf-8?Q?sklLf1?=
X-Microsoft-Antispam-Message-Info: vqHI26QTkxzmFIeTFPkZc1kjOTQUKsTQnrjI7y7svRWl+tA5LGgEVrlgClC1NIKRTTTU4yPe7ImLXoS77w+75HHrjRYnBReULitD2u1MY4UbY58IVn310/Kr/WOf3DGZTicO8kN9IJy3jC1ayKZJ7sXU5d9vqcRO2fgJjooCjV+zeZebta7ZagHa9WH1rdfjgpuF27R36ZxVVaRPR66w5drJTdmFEiZVYPy0gDx/fZIK3tsn9AeK7uSNTlRzd26FZBiZ0XL1W+wOmedjBaZOdoRhFgFWbcSaUBWoRlTT0UYDcSmPXaUG5NBKIVQHs0bA9kXnVBd+lMCxdfZK3Yan9HEBDly7bVc72ZD2JUJ9j2A=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4657;6:TyRzuEzWh9uyP3MUbjL5hqvTdad0kBuDrw1G7HTJEGxcQerX16XxRgB4/96lbapwEZv8Cbe8ph05xGFjyOTMqFH2Rp5xE+iNvNi7mBez5Ra6yln6LbEJ1rTpzQglTg1JZprHncaSuzWAgZKarlVoaVEENBeCX7stX9Xh+ErokeT8XPd02dJUxBKqqbUzjUhWC1KqTcKJzuPy+/EMkrYInTHEJP9KhVwcSDMdxwjH78pHj1sEvUCCrXBFD5744tpQsCNTdMcZ4cNxAeWflK2fxV6JFRJNtfPjFqXefZ3iey1TYf/AWKjQsSdiPZzq0nyZ6l/rroSU/9GsnnvExqeTXrKgpsjw+SY6ZYHKYl5dSOU7qh4tfUfF5YnN5MuKQobjO3xXMKyGWNFZ6ghe4911Xb9sGIqPVMpg/04FByJPsB6hANUJmE9OTBkhVEu/5A+Iq3wv7pZcWYgfTIAR5YSQkw==;5:OAd31jfYQACeFzePvNV1vJh7E54lhiHZSCWp9h9Te5ViZ9GTciZg9yNj4E0UoC5kCsxY3Fegp1ILVKUG1NICz/3GFcDy837VNP3fBuR55QHNRUB+lNPnv/dwD9TqVXOUA+rbiDz747niDrWPu6VQZ9mpBbb1fsKOUtPOf07ByY4=;7:ggxkNP912AwozJBj7SByvkZf7jtOs3GS550CqWSNMj/dJC40aM0gxz/W+cxc1j/MbbklVp8JFxfJi/qX/BVOEKbqKiKcZPbDRkQu5fX+sl0VnX3ow+RUcqE1n8TG262t1x9Ajwcn15+R/ootQ+xv7SIeZStfJOVfcVrp87BT2YKeAX4rZ4Hq6qAKdOKgpGdTflFJVajkQm0lpsRrEMVqqsICV86teuSXOJNFCT9OSYlhW6Defz7Afb1irbT4A1O3
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2018 07:47:35.9745 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86e1f6ce-c06a-45d3-e431-08d61ecd5530
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4657
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.9.2018 15:17, Michal Vokáč wrote:
> The reset signal can be produced by GPIO expander that can sleep.
> In that case the probe function fails. Allow using GPIO expanders for
> the reset signal by using the non-atomic gpiod_set_value_cansleep()
> function.
> 
> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>

I forgot to add R-by from Fabio from v1, sorry.
I made the respin in a hurry and skipped my pre-submission checklist..

Michal

> ---
> v2 changes: none
> 
>   drivers/video/fbdev/ssd1307fb.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
> index ba66c02..e7ae135 100644
> --- a/drivers/video/fbdev/ssd1307fb.c
> +++ b/drivers/video/fbdev/ssd1307fb.c
> @@ -728,9 +728,9 @@ static int ssd1307fb_probe(struct i2c_client *client,
>   
>   	if (par->reset) {
>   		/* Reset the screen */
> -		gpiod_set_value(par->reset, 0);
> +		gpiod_set_value_cansleep(par->reset, 0);
>   		udelay(4);
> -		gpiod_set_value(par->reset, 1);
> +		gpiod_set_value_cansleep(par->reset, 1);
>   		udelay(4);
>   	}
>   
> 

