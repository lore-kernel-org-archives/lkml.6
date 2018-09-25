Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB9ADC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C9CA20877
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="U7kdNyQP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C9CA20877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbeIYPZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 11:25:30 -0400
Received: from mail-eopbgr80110.outbound.protection.outlook.com ([40.107.8.110]:24119
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726660AbeIYPZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 11:25:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KEtwZ3lZYhuHxpP3uMOZzvUSzzdkYcKe/iP4D2GxSyE=;
 b=U7kdNyQPZuTCmOmtM1fcAPM1J5ZS+GbQey4lfhMGa8jHFgBuTOaY4aVGCdR6RicGa8A1jvsm5uVqOXQAJCkXOMOYoM9/xYcTRODf85u8PaCl0Nd66wRZvtuaFsZuf5NdoKjrJQElf1ksn6B757Rf27UMN6p5R1eTcqoh1m2MWl0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from [172.16.25.169] (185.231.240.5) by
 HE1PR0801MB2026.eurprd08.prod.outlook.com (2603:10a6:3:50::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.15; Tue, 25 Sep 2018 09:18:44 +0000
Subject: Re: WARNING in request_end
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     syzbot <syzbot+ef054c4d3f64cd7f7cec@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
References: <0000000000006971fa05769d22f6@google.com>
 <CAJfpegu9hZjJOUa7wHAj9KiTpcUuitsqnEMYvQzp6Mha2Yat-g@mail.gmail.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <274aafd2-5076-6b14-f55e-360411fb8169@virtuozzo.com>
Date:   Tue, 25 Sep 2018 12:18:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAJfpegu9hZjJOUa7wHAj9KiTpcUuitsqnEMYvQzp6Mha2Yat-g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: DB6PR0202CA0003.eurprd02.prod.outlook.com
 (2603:10a6:4:29::13) To HE1PR0801MB2026.eurprd08.prod.outlook.com
 (2603:10a6:3:50::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 496afc74-167c-4051-f26c-08d622c7e49a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB2026;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2026;3:oyirLNXFwsAirvpeACQZwZQZLTvLfEIM+Au79Bt2Gv/hsmvnTgftuqqmleY02ugrMJUsDd61S22hDAI2fHmuQDCkgXczm3w7KF1INWUaMUIKTXeqjL8LxxFugqT1VmQyk10DeZb+S/6gTxs7Iz3EU8mntQdaLQvgZChfDMRz9poBpZ12Er1K9rS/TJ2zPmQsUrYUoIyYK5aAWr/C7aHP9c88AWDDKHv4whMZnyk3ng5lxKRUg8Pbcxw73VABagsL;25:1Me3EqCXgGkip1NLKz5bkoZutHyD2fJFFQ4ApnUq5L4Y9UKqPm6MYnESELI/8WWf1PIdZYDAWSN5sjQJVoDWtuHBgmoLBea76DV7RwTGP++3DNYZSx7kdCVxsB9rN2+GIvRig3ejTkzZvjPUfr0o7taIBG2HZGhh0uRH3rC6zwM8+Vt5YOymQ4DAHORVdf2Khpd4xpyziUFR1rtWGjF/gJFqHYuART1p0EOTrpASOf8tTxmiewXrOCklvS036u6U02NCsTZ14qryFSHXXzM2iPYWXrfpql4z6Wwc+bFZ6JiVpps0LcDdLvIoskjTbN4+z/skVYdFkg23VzFv/AsdNQ==;31:6++5kXpsoVgWCTmmPuDYWO22ZdUcrrnc1l3pWQkayhZuhmQSqlA1jwn5zYefyWnSPOv5ah/EDs7rla1i0LmGA0Ey5/BAdGQHXQ121BIJwDu+h2xL5P3yj0aJyklh2yjWgsPFGWfu1tZkSnKtLXd0LWeLdSQ4MEA9OPOalWWla4iiZ8I5DHMNTm+A5balABB8ygPUNuH71ZvDuq3LdDROg8IQJl1M7FtFsUxBR23RfuY=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB2026:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2026;20:CiVrOKPe9sQrOSknSc2SbxfbfXR8OGtXSxyqd6+Pu3LZ/f48zEnw9Q+4bBBOSfGUVSChnk/m2GkqO8SaEcN54PBiGXeRCHYqPcCSAOoOAuzqq+rFM9JKil+dRxtEowwqR2Df0wzOz2AbqKiVy+0nN1V4ml1/1I6FxwZ+BavIPVxxYlnRUSWSsULShvIswAAghCGCD/80mvIgTZD5ZdnBUWXroYjsTC6efeeflRpiDHME1xO3y27X1RTUh8+rXgLHQB2Yz+JlVsl9sdrN2AZR15la7o/F8OgkWajXQ1CKwD7ZihQ4uiHJ60DIq2wRi2RpO+qLmErCjxJNn7JkrO5lIhUBnhBKl47z11G07qtQfNKLzjxsszkxseijFGO64D6jyPBcjI138cgq29SH5G0MVmE4xzoXwxlI0VeJ//iICuvUHUCKC7E/q+rYgETJ5e3rD1qH+Uz8p6S6Z3j8phUEL/h+pD6rozKbw0xJDRVTlMZXRwWDHPbEcfb8Lm7qD0d4;4:HheNZmN0TENzCxUcxvPdTdtx8MgnHVLv2sxOq5yerDTwDj+nNFKlfpWfgD5cq2jrmg+W3/I+nsKjfeWguZQcRY2um2Gkwy7hUHtSNWVbEx0nkw3npy2d1w0IAhOlH1+IZIYxo3teeLlu/tlLkbqj2OYP4oWoHX9PONyjd8PJVEoJdp52tNX+1VHCaRHsgjnF0Asuc7MhN8qh0AnEbTVa3t0Rjuw0fC7gPAjC2OXDItGdQ5sxmCUBr+RllbNhMULM5rCdzEav3oCxjsm/Y+977dRnY5DRpA8jE+Wg/eqxQ/q52jUoM7GRyAMs1UvHk3bM
X-Microsoft-Antispam-PRVS: <HE1PR0801MB20268C0B33B0BA3A2F33ECFECD160@HE1PR0801MB2026.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149066)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201708071742011)(7699051);SRVR:HE1PR0801MB2026;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB2026;
X-Forefront-PRVS: 08062C429B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(376002)(346002)(136003)(39850400004)(396003)(366004)(52314003)(189003)(199004)(105586002)(186003)(4326008)(5660300001)(6116002)(956004)(53936002)(478600001)(966005)(305945005)(7736002)(2616005)(486006)(31696002)(50466002)(476003)(446003)(11346002)(106356001)(47776003)(3846002)(230700001)(86362001)(14444005)(65956001)(66066001)(65806001)(386003)(6916009)(6666003)(97736004)(36756003)(81166006)(8676002)(6306002)(316002)(81156014)(54906003)(8936002)(2486003)(52146003)(23676004)(52116002)(76176011)(16576012)(77096007)(26005)(229853002)(6486002)(7116003)(16526019)(64126003)(31686004)(25786009)(58126008)(68736007)(2906002)(6246003)(53546011)(65826007)(99710200001);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB2026;H:[172.16.25.169];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjIwMjY7MjM6ZkFqelVvTTZSUkVLWFduK3lJOGw2K25R?=
 =?utf-8?B?RDN2MzNPQW1rY3JMZk5nakdVYzJXaXA3T0o1b2xEa1ZrZzBVVXZIMnVoNTB2?=
 =?utf-8?B?bkRIem8xbnBNdCt3TkJwTXR6Ym5UNDE0cys5QWUyc01qV0lxRDJuanRQaHd2?=
 =?utf-8?B?dkFHWHc5TlkwTkRRWWhoMnhmbXJtS1lCSjc0R05vTE5NY2NmU25jbXB2UExE?=
 =?utf-8?B?WXR2M3UxWXpzbnJlK2tFWjUrTHQyRGJlQllHWStsMG5wU0Ixak1yeVA4RFkv?=
 =?utf-8?B?NG1ieWJqczJ0UGVXZ0s3QWZ6eU5wUTZPT2ZwT2xONlVWandEbnlySVdROXRr?=
 =?utf-8?B?K01DZ09QbGdDNVZiQVdGRyt2SmNXbmh4dTVQUVJ2cWtyZUpYbk42b2YyVTZ6?=
 =?utf-8?B?NjFKVjNqWWRQeUpuWVRTZkhKcDNsdHlaMTRJRUU1NHdIc2JlMnZEZnVRRkFU?=
 =?utf-8?B?Y2NUVmloUVd4cVBlTjk0VG10emc1NktGWVNjbjkxTElzTmRWc3lOamd2WmNC?=
 =?utf-8?B?L1lVTmloZUg4ZFRQblFOeWVqMHByU0pQZE5PZWdvNlByRzNmRVRVMFVObDZj?=
 =?utf-8?B?NDdLdTlnODdNalQ3TjBvNEdhdHRwM0JZN0hTcU1oWEJCK3MrN0pVdWYvMEJq?=
 =?utf-8?B?WE45YnF3eEo1RHVBeTdFV3czRUJWcUhQMEhrM2F2cS84bVhIcWwwb1RTazh3?=
 =?utf-8?B?S1lPSy95L2NybFR6bVV1WTNPTUUvWHp6S2JIVmVGbWhFblM2dGpBSjhRdmtO?=
 =?utf-8?B?eFNVeWJGTzlMUG15QTRDT3A1dzBBanlIWVVCQ0NDbE04dDdtOXVlYVVYOUJS?=
 =?utf-8?B?bFhLU2UwcmRkc0VMd3JsQ2IyS0lvYmxFZTcyMjJJbkRFZGtxanBPeG9OcUlU?=
 =?utf-8?B?aFE3ajFSTGN2c0Z4NS9EUVp5bUpCbUprOFM2UjB1L2VKL05IM3pyQk9SRmIy?=
 =?utf-8?B?N2l4RndMNjFScVFEd0kvczFYYlcraHlCNURMV3NPQkNJNnNNT3JJRHhEajRD?=
 =?utf-8?B?bHVSK1did1FabGI3UjlPc0J6MndLd0tzV01mQ3lpK1FFeGpObUlmZHdVSHVI?=
 =?utf-8?B?Qm1SZ201NzRMREY3VXBpN0lHZndoa2FmbVZQa3RGUVBQUVdJOTNiUG5PVDIv?=
 =?utf-8?B?Y1FYbnpoelByUlBrbXJMeWpveGg2VzdTeDNyVGM0a0twa3dyaksycTZFenlr?=
 =?utf-8?B?aTF2c05nTU5uRXB6RUlqUGZyd1hnLzZQejZqMDhaKzZMMDhveExubTdjZllU?=
 =?utf-8?B?Nk5jTkV2bU5ROTMxZE1GUkprS0I1cnhZOGlXTmFuRnFRbmVDdUowQitHcDNE?=
 =?utf-8?B?Y1FFeFpsWkJudFNkTlU2Njh6OFhyeFJWQXAwSm4zdnVENzJNTWlTNi85MzF3?=
 =?utf-8?B?enZvWFRndFR6YnBWdWxnSHV5dEtrZlBoaDE1UXlyd2JyZEMrdFNQSlJid3I3?=
 =?utf-8?B?ZXFjbTN6bTcvM2F1c3hSQkN0WDJGRGdFMWh6YTB1YmJhTzNva0hZcG9XUzB2?=
 =?utf-8?B?T1VXcGNndEpwVEFhSGFNVzEraFV6dTRIK1k1cE0vc3JhNXJsOGZJMmxYcysz?=
 =?utf-8?B?ZXRCd2NkL2JRK1hZQUJUR0NCYU9FOU5HNVVvVEd4V2JSSFM5c3c0NTg2ZlVT?=
 =?utf-8?B?MXNVQ2NYenlrVVVnU2Q4U3N5TW4yUWNqZDBzY2pLYUlOKytjaUp6aWpIMlNQ?=
 =?utf-8?B?c0l4UXY1MUt5bkpXK3VpblRwYjlGeE4zLzBVZkNXa0NZYUxvRnpSR01WVzNB?=
 =?utf-8?B?Rkk2dnNxcTJsS0VhQmtKSk52M042aElqOUh6V0YvTGdwME1JSVN3dHNWa2h1?=
 =?utf-8?B?Nmw0TlZxZXpuMHlWY1Jvakc0SmRKZytkNzkrZTExek5BRTFSVGZaTTRmUnVy?=
 =?utf-8?B?cHRrL2dXSElKaGhuaWZtSkgyRG9DUXhqdk5VMzRWWXFMY0VKMmNDcnhlWnNW?=
 =?utf-8?B?UTljdG5zZHdLeloyYlhrK21kb0R4RGVlZFMyVWZjMFhzaXc2dnlxWWtHNjVv?=
 =?utf-8?B?aXYrMUVndDM0c1gwcWhwRXRxTDZ6VDBBOFViTHAvMWhNeU5vRHZ6cWQvME1u?=
 =?utf-8?B?cHczKzZ6Z3dLVHlyRjVTdkN0b20wUEpFWk82R21LNEdxTlVPVXJrSUUxOGxK?=
 =?utf-8?B?V0dPQT09?=
X-Microsoft-Antispam-Message-Info: 9AU2b4KiGEX6+B1KlcQjq5mNJcyRnf4xPidIZoc/awY9QeZJGZoyxtxefBnxGS9b8RKTuXUdifOLQGduekfZxi4e4TyX578RtBoG/FrN6kLiMaV1L2+Qm1QIt96LORqz1eY7ytvzEcDV4x2rW1n5u3c63Kzow2AkKmf2k0Bp47WJahc39QjrKELswnWFsAlz+1k0Iul2S49lFln3Z85V7PtgPYdhuPxGHmqn2mPv4lSjfVyHEddscmAyDk6zjx9AIYyZWd8Y1Ych2ubK+0ecNcdhsZDeeRrweFM93mxyCeNTwh0XINqFmiOBv/3nR3HVc2hZgQdawGENExbLDmzhPIXYjlSEZW7ejD17vVyktFw=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2026;6:vVUeiu6V/ld29J6zDw0MN3IB45pSOkmgjCgtwX6DAm8u5uJ/Sjyjpth860EAwLjeQR299tKhkySiAstjTW+wPnHhDY6PAPcPnmshZ/X1ecBFO9fp6sVB4/I6BLpseTLe4bhJ10Z4F6fbLfIKPBUBe0O7zaHX1Bs5dEaJdYHWciHmXa1Ldo2YsfNEgItLLBW4Pz9qvazQ7pStzOlvfeRi0kcfA59xDJMzOjQEqB218ghe722GLH2ySBSvPsRHeC/d6FQraK3xDq3FHzSdC/mutT5yx+J/jjKQPXLCc0/kKdV21oGGygxlwJBpqCkDjfP6rWkG/MpJ8UBk5fLJdpK20trsQHfC8SY6XL0O6k9Z8kjcpIIRhO96+jPqDikZcGBNC0ocvacbD0iyyuXihWSowHOQc5hVU5Sznux0H+Udbpwsr+uJl6xfOj0NMOcIpuarvN2jBHMA6yWu4UBVvFqD6A==;5:HuUSFghUBnYxwkuGXHIzN1NcDwQBBhBEyW0IP3XfhFNa3wN2JDvGTH6eQZSdUWbUbvi1vS7y3XnS/igH1wbVultf0+68uz3gpE9fawXtnxUmaK/dfsWWoo/lcqgfRooRdTF1wHOBUoXfHfAOWVr4G84whuYOUZ553PbITnMw8i0=;7:hQAHVF8p/Ako7aOJRftW02PRm7wlYZLoxhceSM8eetDV01B9CWTz2hs6h7Tc/cZjEeGhVUWvMarpMm4LdfiaY3RC7lSKouI7KoXR28AdO+daoyRPz4URdXXp7bcT/734MiZpQ9E0hVc9sRUQjW0fuOi/E53nbyy3JyRjmL6tDjZo3ZrRlsM4G9dwC2+RmTsppnnmuBf7goujxN51C08fqZkWfdKJ+Cb00VGobLpAINmxyiSfCeDL4mzx1Seul5UX
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2026;20:pdFXSZSl2oX1gY6TxNeg3Q9OQ/U4IHw93YTP1y5lukKsVWpWqXj7zEvrJ7a+9KbXEQMPlZvrO5lHs6nvE3F9AZfEQallpnxkSqOQxgdCJYpUayvy3rUM5fJfo1+pkrWtV9mnIL5yYmTgvckgNJs9fswA3nLPhkrldUsJYJHcLeA=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2018 09:18:44.1103 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 496afc74-167c-4051-f26c-08d622c7e49a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB2026
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.09.2018 17:44, Miklos Szeredi wrote:
> On Mon, Sep 24, 2018 at 2:29 PM, syzbot
> <syzbot+ef054c4d3f64cd7f7cec@syzkaller.appspotmail.com> wrote:
>> Hello,
>>
>> syzbot found the following crash on:
>>
>> HEAD commit:    6bf4ca7fbc85 Linux 4.19-rc5
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=159149c6400000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=22a62640793a83c9
>> dashboard link: https://syzkaller.appspot.com/bug?extid=ef054c4d3f64cd7f7cec
>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>>
>> Unfortunately, I don't have any reproducer for this crash yet.
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+ef054c4d3f64cd7f7cec@syzkaller.appspotmail.com
>>
>> WARNING: CPU: 0 PID: 9445 at fs/fuse/dev.c:390 request_end+0x82e/0xaa0
> 
> And  there we have the bug likely caused by the set_bit(FR_SENT, ...)
> not being inside the fpq->lock-ed region.
> 
> So that needs to be fixed anyway, apparently.

I can't confirm, since I haven't found yet the direct way, that set_bit() results
in this stack...

We have one more (unrelated) possible use-after-free here:

cpu0                                       cpu1
fuse_dev_do_write()                     fuse_dev_do_write()
  req = request_find(fpq, oh.unique)    ...
  spin_unlock(&fpq->lock)               ...
  ...                                   req = request_find(fpq, oh.unique)
  ...                                   spin_unlock(&fpq->lock)
  queue_interrupt(&fc->iq, req);        ...
  ...                                   ...
  ...                                   ...
request freed                           ...
...                                     queue_interrupt(&fc->iq, req); <- use after free

Something like below is needed:

@@ -1875,16 +1877,20 @@ static ssize_t fuse_dev_do_write(struct fuse_dev *fud,
 
 	/* Is it an interrupt reply? */
 	if (req->intr_unique == oh.unique) {
+		__fuse_get_request(req);
 		spin_unlock(&fpq->lock);
 
 		err = -EINVAL;
-		if (nbytes != sizeof(struct fuse_out_header))
+		if (nbytes != sizeof(struct fuse_out_header)) {
+			fuse_put_request(fc, req);
 			goto err_finish;
+		}
 
 		if (oh.error == -ENOSYS)
 			fc->no_interrupt = 1;
 		else if (oh.error == -EAGAIN)
 			queue_interrupt(&fc->iq, req);
+		fuse_put_request(fc, req);
 
 		fuse_copy_finish(cs);
 		return nbytes;

