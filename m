Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SORTED_RECIPS,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F96C3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 14:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13634208CA
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 14:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="hJIx3F6L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13634208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753622AbeGHOma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 10:42:30 -0400
Received: from mail-eopbgr30096.outbound.protection.outlook.com ([40.107.3.96]:19001
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752806AbeGHOm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 10:42:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKj/kEe45uhnAgx5BpK1bUOBfT9oh6Nffqg/0lDe8rk=;
 b=hJIx3F6Lyz9rJO4oLC3mW+kLTirMVGxcL2RReA5txRUqF15pt86Ss8PCRxvBZxDQQn4j+MG+wJ07jsR52AJe8jXsn4KvjrIXBVRMqmGgBgNIvn9QCkVd03CPBxxBFqHvkp8OB6pUlNyMSezPq7KYFbId8etE3FuRT5GHtSJFsOo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from [172.16.25.5] (185.231.240.5) by
 AM5PR0801MB1329.eurprd08.prod.outlook.com (2603:10a6:203:1f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.19; Sun, 8 Jul
 2018 14:42:22 +0000
Subject: Re: KASAN: slab-out-of-bounds Read in find_first_bit
To:     syzbot <syzbot+5248ff94d8e3548ee995@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, aryabinin@virtuozzo.com, guro@fb.com,
        hannes@cmpxchg.org, jbacik@fb.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mhocko@suse.com, minchan@kernel.org,
        penguin-kernel@I-love.SAKURA.ne.jp, rientjes@google.com,
        sfr@canb.auug.org.au, shakeelb@google.com,
        syzkaller-bugs@googlegroups.com, ying.huang@intel.com
References: <000000000000af3c0305705c5425@google.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <b52255a2-9680-70dd-6a21-2f05bd0315b6@virtuozzo.com>
Date:   Sun, 8 Jul 2018 17:42:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <000000000000af3c0305705c5425@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: HE1PR02CA0085.eurprd02.prod.outlook.com
 (2603:10a6:7:29::14) To AM5PR0801MB1329.eurprd08.prod.outlook.com
 (2603:10a6:203:1f::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5953a39-e545-4774-38f3-08d5e4e104ae
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1329;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1329;3:SzZcxqM9I3vfMGwyH6uIqNv8D0GsSRW6uVw4RV+AGa86gCd0nEn15mzxXVvBP/yR7Yw+ReTra0A/tiy/6TykFZPryoKgLjriL9wjV8U/uObXHZEQHRHQmBQ0aJV2oHPO9weK86pVt3kNvcbuUTFeXj3gygX66JKb+LMstpuuanbri3sZuIx4p8EUlgGXZB0LNCsdN/h8VVxVbkuG9VItTUDpgbL4cagDz2WMVe6xUbnSpkPBCR5x0GsHVRPqqZJA;25:5cH3zYmz380Vez+cykpXyZzPm9gDOpkLAKeN01x7XiTa5b6KHUiE2j7Dmd2oifHjwfJfBZ9QGwxveTanIlA21DFkBmraV3qzNTE4EEul11mzNqGtfjOvo5Y1cBDrHsv0ZZcwRYMpYNB/k5VmGGx9ILvBTSpaGoBl6SZ+L4dthkSewLqEqkDY09D3DnoZ+1qpU5qDL38exPQjItwJAugMENmBS8i/6POE4HF3hHF3DLYLm+1QpCWfhiDIMq7cWBf5keUYnejeeZjjorDI+IUVTHb9FZVtIVTPVfv+XkN0aaj5yBBWc0cstxTV1YgZo7xi2oj2pzmWysv//65FxwNbhg==;31:vYB9DlawuoOxs2ax6bE3TU/Fxh3kwZFMIklFdy1KpEsKxQ6rHoJqecKh1InatYBWNiZxTNw4BwgF6Geo2njW/Xx2sDurjnc447CfluOuiOs7nNE/AMnoo0OuIAiasELGpUylPg3QENR31WDmWbI7Vl/X+x/wFOC1ie+3JuP2UIbWjIjxAYBdDDTwetgt44T6GwzYZZGbg/u6YuUhaQqTkdNssXd7jISZIHTUE9mnIzM=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1329:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1329;20:WXEcdkEKHKlvVXzwCnSiKURzlZj8fobHKAn6Ylw2LhSz2L2/fsaoG+AgwkU/YlkXE5JoBWG8U99CD1a2x32HjRrWF+Qgu1gdrIAItBLIsn0hdgEYIQDXjsD1hWriRWhHSPhkT3AGEkfxJCGNK8U/8t3tSocDWzJI8un5H7tOn7R+98+3H/lrBuAOwg8KKUl2qfCV+eK6aQWxZwcusTuW+kuG9ANH5Xzc3XVI7LvDYCCaArWOS73s5JXVJfGuB/qxzCKFS0Icm4VClyoh0UscJrgiayXJBM+HZaB+YCcmtUJHfb+JSjyPyHbdgW41OfusC+CmEwitfnXd2v97oeN44AWK+ru8R845rS4wZRg1nbYbiCOF4G4bSFQbksCAVQfKF9+V8a+jivz6+bENKParxTbsGiPrWHCPBO3+EnNshn4bhqNTsb6HtfB3ZeZAzatyklV1yYsepFN/sO3Zir0EP3MBOjf2QAQiOgcHw/E7Bsd6BHeD85lZqJ3il6l2Q/YK;4:wveFGz1aEX1m59N/TC9leLjFVXGjoRXyucXn9UyaVN8UBmSEpYSnNXV+i0/eTaNrQglJAIk3h7RROS56pB90nxfgOZfutZLZ8B9np8lgI3iynNi+6lxGsx0PeoQZbDY0mTjcl95NyxCOkLec5DY+1MbUqzG0ZUmNAeZRRSUHE+VtQjfaTmP9v4pk1kkpxp+Ao+xrLJm66V3Iwb7lgujAIUMWbIJR3VGuyd9dPSBqQlzqrDHZfbUxF8MoCzMtGbGhihjka/4MqRXIhZXXgubcJ74HGF5QKaaYt3yC5Z5QPbPikjOl/BndfeCywekGEJIhIZdm56l+msw0MABwh8LoV5QX3nbmB3yOmLT7551oudM=
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1329AA4B46441DE928177946CD450@AM5PR0801MB1329.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(209352067349851)(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:AM5PR0801MB1329;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1329;
X-Forefront-PRVS: 0727122FC6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39840400004)(376002)(346002)(366004)(396003)(136003)(189003)(199004)(52116002)(86362001)(76176011)(2906002)(53546011)(23676004)(52146003)(2486003)(5660300001)(7416002)(47776003)(316002)(16526019)(6246003)(26005)(25786009)(386003)(575784001)(476003)(11346002)(6116002)(3846002)(65826007)(956004)(446003)(186003)(58126008)(66066001)(65956001)(65806001)(2616005)(2870700001)(6666003)(68736007)(486006)(16576012)(77096007)(14444005)(50466002)(6486002)(478600001)(8676002)(31686004)(64126003)(8936002)(31696002)(305945005)(966005)(53936002)(7736002)(36756003)(81166006)(106356001)(81156014)(97736004)(6306002)(105586002)(229853002)(99710200001)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB1329;H:[172.16.25.5];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjEzMjk7MjM6cCtibUx1UlQ3d0dhcDlXN1ZYcy8vRjVs?=
 =?utf-8?B?Nmo5ZTROVTcyNkpudEpoUnQrMFRReHQrWGJLeEFSeE9EckFIdEM2cEtNQTlV?=
 =?utf-8?B?SVN2VkkxY0RBS29aYjVLMHVRa01uMnN1QTR4S2Y3Nit5UVVaZk1ZZnFUaXhQ?=
 =?utf-8?B?RUYzZkZyNEhKSzd3TVp1TWhkN0k5U3ZIa0NUNTIwbWlYRGZWMmxESlB6T3NC?=
 =?utf-8?B?d3NpS3AzQTJ5RnQzazMvUHhhQ2lwNlNaaVcrbHNEaHQremg3ck9jVEpuZlkr?=
 =?utf-8?B?aGhadk00RXRzcmc5YkJkd3UvVTN6c1hwSklGUEx3MnpHNEYrMHdQQlYyQmZn?=
 =?utf-8?B?bHJPWTlVWkxnVmV0SEVFMWw5em4wc1JDK2prTkpVRC9HSUkwdW9sVkNZV3h2?=
 =?utf-8?B?Vm4yTFlYQ2tvUUtsVk5lSDFVRXU4amQ3OUsyV0R4UGFOYWhxYmt1dzQrMHBi?=
 =?utf-8?B?ZnNzaEpxQ0xqOUJMNVF5dHJaWFFVMWJvVlIxUlBaaUY5TXQ3UVAyWThuaXF5?=
 =?utf-8?B?cUpaajVxYUJEYUtzOXVRTDlwU1NHYlpTc0FhZFBaaHVnOVdDSGo2dTVuTFQ4?=
 =?utf-8?B?dTVtM3FCUFREZ1FTR1FmSE5nejVLUHN5KzgrY09rVjlTQVNIUFdWVWVsTys0?=
 =?utf-8?B?WUdRWklFaU5TaXd1Qmt1N3RBUXZDSzNWZy83dXdteGxsQVhUdXNHNk1BVnB3?=
 =?utf-8?B?TDRWZ1I4WktjenJQdzdUNm9NenpGQnphY0NIU25XZkhRVUwxdDF0cjVVQ1Vv?=
 =?utf-8?B?ZER3TW9GWjRoM3UxS2Z0YjhJWjBUVERtVUVaRHBiK0JYSTRubnpWUnlObXc0?=
 =?utf-8?B?aDNCTThNTHJqUzRnbmdNK01RdHdYRmM1d3c1WnVYbUlVQ2t5eUR2U1pudjBS?=
 =?utf-8?B?ZW1rMGJJUUpGVjVPRks2U2ZqeDRCTW5FTWNzZFBkcVNkRDZoNG83bUY2V3pN?=
 =?utf-8?B?MVF5ZGhSaFJOMDRsL2VVK3BVRlFkNndrdWhqMytsa1FVbDloU0VSUGJGMGtu?=
 =?utf-8?B?R0JCV0UyQ2VGQjRRSlNmTDBjQ1pMMGgwOURNY1VPaFBlVkRYYllYVkVEZFVV?=
 =?utf-8?B?QjFvK25rclZUQ290MU42TXhsZ1JxWWZDNlkzeXhMT2xwRm1VYTMwME5ZY1VS?=
 =?utf-8?B?QVBLSGszei9leUQvZ3VrYzRMUU5NRVcwNEhmVWRJMFJ1SE04Q0VaWHRDNTY0?=
 =?utf-8?B?VkFtb1RVNXIyNjZ5MEY2OWxyQjVUYTAvODBqWkRjTTlYS2l4LzU0Ni8weTNF?=
 =?utf-8?B?UVcrV0dHdEVhSkwycm1xVjFOVXlLelhMcmZyN3VGRFBMWHRQVVhIM2U3MXUw?=
 =?utf-8?B?YXhqRVJCZ0FmVWhKQWJNK1JVTDFQaU0xNVpKcjJrdlNjbkQyNmU3UGpSTEZG?=
 =?utf-8?B?UU9FdVNvSHNBSTNBZ2xLR0hOdGxybS9qOWgwRVUwb1ZmcmVSY0JTOXVHNWVo?=
 =?utf-8?B?bHhZblZvcVVwVk5xSm0xbjMwQTVCUCtKaWdmcWYyTGdhVExvYUY0eml3R0ZG?=
 =?utf-8?B?ZWxwWU5NM3hWM2ZNc0g2Z3d6c2FtRmFtZTdjRGk0OGxMNlVvTUJVcS8wRi9y?=
 =?utf-8?B?bmtMMm5VcmN2M1lhaVlGSnhBM1IzVEl0aWlRVHJKWjlxUzFMNENWZ2tkejFM?=
 =?utf-8?B?WDFpK0lMdEFuSlBlYVQ1VFNZZjQ1bzNtLzl5ek9Qa2ZoMVhtSWJDQmpkVzdR?=
 =?utf-8?B?ZU4wZWpIcjFNNDFteXl3WHZXQm1yKy9PSXo2bFJTUG5YUnYxYkZKNzBIeUt5?=
 =?utf-8?B?aXNmSWZRR0RXaGhFZTE4Y0lWM2tNb0szRE1Ec2lKV2N5aVZPTnFQVW5Wb2Rv?=
 =?utf-8?B?TVpQVXhiMEZ0V2tCTm9INVVxMWtBQWxOVTlSQThiOWhReUltcVFpV1Z2emVY?=
 =?utf-8?B?ZW92WGlSWHN4a2s4ZVA1bWp1YjdOam5YV0VFbTd6QlcvM0NTV0txZHJnTC9P?=
 =?utf-8?B?NjJubmVVTXFRSjlsSy9ZcVFNYTlzL21KeFFSTGR4dDhBa2pBRTh0SzJXdzds?=
 =?utf-8?B?MlFWWlhaT2dJa3lOcmlhSHFXM3UzNGJscmFQWmI5WW1LQXRPSFJoeVFjeXdG?=
 =?utf-8?Q?de8Nhy2kINKXD0GnSCalDO4jQs2?=
X-Microsoft-Antispam-Message-Info: VekOhYJ0EOcedk+Fyi0VXdkh5/oSrbrIRr9guslaO9YP3kx3phQq3n7AM1rlsHv9mGKfnW1qFo+xoDHhg8jyl/RWhAtJ4QbFAaZNtEobcni+YQbO9Uticj/19po62FXRgJ5FkmPOqbgdzfgOK3kFWH9HdYV3CGEbg/OnHTY1vH9Y7zNLCtwnJvuPocb7i//QfvYdGvNn9PaL+qRKU4UJfuoFX4Kg0RAg+v4Wsbj/lvpvuA+9iWdeCzOHTJ48cO5AEtRJDKaL58tctf3cDUqPoyTi3BsGn5cQkiYMXECWKnHWbKXAC8MpqhxQGAHER3NVedV/Ik/Ujjsd/I/8hAXkxIUxDcEoN0dIbKHyydKRBD0=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1329;6:+BagGKWVqRsf0k1vUqw+W5Rku/Azkg+8XjmRuypi+AYSORiFQhg0DczaXVNLmMRpZ61xgaAFm6UpqTvcpwgqNzQBUaQKTtGDHT+bZB3++xvQLawfY1kZKw6TN5ARQ+3Jgz8oRjmYN4YqntBaYs/E6xgDfogYBwT0VhJ2fgNGc/lF+T2a7g59yzFgPoPg4KAjlmspcY7Ip3Wrj8gNG64XZ1ZE9We8l8BgP8e8I1cW/A+JSVzOy9CGHMuKziR3SRdo9/t/qvsHDPCT/M/j4eDkMDzBnKdEdgKsD2WFml6udGu4qA55XIrfagGUfLD+y2Qe8/njLHC188gfQchkU2oDQDJzRdrtEY+8CLGkX9z8r6eitSK5WkpngydgmLFPuHJWB2BHR+kQRkZqkZKS/hgSnI0O7YqIWOCqZ8FZQpogNTM9XV+ofXcjYFXOql5KMMIZq3mwuVlHCw8UEgExGv6gnw==;5:rAyEuHahxWj+bjZBChcDcSjZMTggtZtGrTS8w4kz7v1cBz2BGodsz1Y+Gk7ZOF+dD6MYmiGBSTUNZf5/kNu7hNgwZvQN99+NxQJqEcjlGVQqa6rZslGIWGwrAi0NLHv3cgyjGToqlV7cxVLX3SpcBxAEThcQcNQRedIbDNoLuSw=;24:mXHDDRiTbFY3fe4w9YluqfDvWP8oWEnMKzx05uK/Tk4DYWWlq7kDSuz2OLa92Ka06KTW5rouAZJAP+5MpiXB2VUWiKTnPh6tELi66ht6KH4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1329;7:gpNpodqVsjc8Quobe6rm8Vj4zWArE/lsadwyBDR/jO1RPuCsFfS1AqNI13lNKrRM8/lSrXP4NymUNs0OxDfD1Hjetx5ZhxFl/XCXnjDmBXqQpkgn5gLGgwLiuMPnv+QdrwsQQLQQe2hdLLDMdfMJD++LC6+HEPOEoCsmAMUMk+6iq1v0bUoOb2CdFqH394un7AIWNSnBBFUNVio35nLpKgXxH+ZS4x7ZM4iyjPdPv7p0FNd78yAHmJ3Ep2QELpX7;20:bnHH4qBNEyohfyNXTuETWa13YJB+EykC03tzgM8KGjf67jxhprzG8Kf6wgRHPgP/5ZIRS4fdup+1YH6pgn3MPrNpoffgG59JbHlyeTMhQPzWmQfInEEPaJNCWO2RdjOtci2+KQ9hf7bBO2MCMF1uYs3KuzxYJzvu5kBRC4Yd4Bk=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2018 14:42:22.5718 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5953a39-e545-4774-38f3-08d5e4e104ae
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1329
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.07.2018 01:39, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    526674536360 Add linux-next specific files for 20180706
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=13e6a50c400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c8d1cfc0cb798e48
> dashboard link: https://syzkaller.appspot.com/bug?extid=5248ff94d8e3548ee995
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=13a08a78400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17a08a78400000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+5248ff94d8e3548ee995@syzkaller.appspotmail.com
> 
> random: sshd: uninitialized urandom read (32 bytes read)
> random: sshd: uninitialized urandom read (32 bytes read)
> random: sshd: uninitialized urandom read (32 bytes read)
> IPVS: ftp: loaded support on port[0] = 21
> ==================================================================
> BUG: KASAN: slab-out-of-bounds in find_first_bit+0xf7/0x100 lib/find_bit.c:107
> Read of size 8 at addr ffff8801d7548d50 by task syz-executor441/4505
> 
> CPU: 1 PID: 4505 Comm: syz-executor441 Not tainted 4.18.0-rc3-next-20180706+ #1
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
>  print_address_description+0x6c/0x20b mm/kasan/report.c:256
>  kasan_report_error mm/kasan/report.c:354 [inline]
>  kasan_report.cold.7+0x242/0x30d mm/kasan/report.c:412
>  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
>  find_first_bit+0xf7/0x100 lib/find_bit.c:107
>  shrink_slab_memcg mm/vmscan.c:580 [inline]
>  shrink_slab+0x5d0/0xdb0 mm/vmscan.c:672
>  shrink_node+0x429/0x16a0 mm/vmscan.c:2736
>  shrink_zones mm/vmscan.c:2965 [inline]
>  do_try_to_free_pages+0x3e7/0x1290 mm/vmscan.c:3027
>  try_to_free_mem_cgroup_pages+0x49d/0xc90 mm/vmscan.c:3325
>  memory_high_write+0x283/0x310 mm/memcontrol.c:5597
>  cgroup_file_write+0x31f/0x840 kernel/cgroup/cgroup.c:3500
>  kernfs_fop_write+0x2ba/0x480 fs/kernfs/file.c:316
>  __vfs_write+0x117/0x9f0 fs/read_write.c:485
>  vfs_write+0x1fc/0x560 fs/read_write.c:549
>  ksys_write+0x101/0x260 fs/read_write.c:598
>  __do_sys_write fs/read_write.c:610 [inline]
>  __se_sys_write fs/read_write.c:607 [inline]
>  __x64_sys_write+0x73/0xb0 fs/read_write.c:607
>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x4419d9
> Code: e8 ec b5 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b 08 fc ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007ffcd44b9a78 EFLAGS: 00000217 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00000000004419d9
> RDX: 000000000000006b RSI: 0000000020000740 RDI: 0000000000000004
> RBP: 0000000000000000 R08: 0000000000000006 R09: 0000000000000006
> R10: 0000000000000006 R11: 0000000000000217 R12: 0000000000000000
> R13: 6c616b7a79732f2e R14: 0000000000000000 R15: 0000000000000000
> 
> Allocated by task 4504:
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
>  set_track mm/kasan/kasan.c:460 [inline]
>  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
>  __do_kmalloc_node mm/slab.c:3682 [inline]
>  __kmalloc_node+0x47/0x70 mm/slab.c:3689
>  kmalloc_node include/linux/slab.h:555 [inline]
>  kvmalloc_node+0x65/0xf0 mm/util.c:423
>  kvmalloc include/linux/mm.h:557 [inline]
>  kvzalloc include/linux/mm.h:565 [inline]
>  memcg_alloc_shrinker_maps mm/memcontrol.c:386 [inline]
>  mem_cgroup_css_online+0x169/0x3c0 mm/memcontrol.c:4685
>  online_css+0x10c/0x350 kernel/cgroup/cgroup.c:4768
>  css_create kernel/cgroup/cgroup.c:4839 [inline]
>  cgroup_apply_control_enable+0x777/0xe90 kernel/cgroup/cgroup.c:2987
>  cgroup_mkdir+0x88a/0x1170 kernel/cgroup/cgroup.c:5029
>  kernfs_iop_mkdir+0x159/0x1e0 fs/kernfs/dir.c:1099
>  vfs_mkdir+0x42e/0x6b0 fs/namei.c:3874
>  do_mkdirat+0x27b/0x310 fs/namei.c:3897
>  __do_sys_mkdir fs/namei.c:3913 [inline]
>  __se_sys_mkdir fs/namei.c:3911 [inline]
>  __x64_sys_mkdir+0x5c/0x80 fs/namei.c:3911
>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> Freed by task 2873:
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
>  set_track mm/kasan/kasan.c:460 [inline]
>  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
>  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
>  __cache_free mm/slab.c:3498 [inline]
>  kfree+0xd9/0x260 mm/slab.c:3813
>  single_release+0x8f/0xb0 fs/seq_file.c:596
>  __fput+0x35d/0x930 fs/file_table.c:215
>  ____fput+0x15/0x20 fs/file_table.c:251
>  task_work_run+0x1ec/0x2a0 kernel/task_work.c:113
>  tracehook_notify_resume include/linux/tracehook.h:192 [inline]
>  exit_to_usermode_loop+0x313/0x370 arch/x86/entry/common.c:166
>  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
>  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
>  do_syscall_64+0x6be/0x820 arch/x86/entry/common.c:293
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> The buggy address belongs to the object at ffff8801d7548d40
>  which belongs to the cache kmalloc-32 of size 32
> The buggy address is located 16 bytes inside of
>  32-byte region [ffff8801d7548d40, ffff8801d7548d60)
> The buggy address belongs to the page:
> page:ffffea00075d5200 count:1 mapcount:0 mapping:ffff8801da8001c0 index:0xffff8801d7548fc1
> flags: 0x2fffc0000000100(slab)
> raw: 02fffc0000000100 ffffea00075d5448 ffffea00075d3b08 ffff8801da8001c0
> raw: ffff8801d7548fc1 ffff8801d7548000 0000000100000039 0000000000000000
> page dumped because: kasan: bad access detected
> 
> Memory state around the buggy address:
>  ffff8801d7548c00: 00 04 fc fc fc fc fc fc 00 03 fc fc fc fc fc fc
>  ffff8801d7548c80: 00 05 fc fc fc fc fc fc 00 03 fc fc fc fc fc fc
>> ffff8801d7548d00: 00 07 fc fc fc fc fc fc 00 00 05 fc fc fc fc fc
>                                                  ^
>  ffff8801d7548d80: 00 00 00 fc fc fc fc fc 00 00 00 fc fc fc fc fc
>  ffff8801d7548e00: 00 00 00 fc fc fc fc fc 00 00 00 fc fc fc fc fc
> ==================================================================

Since find_first_bit() reads memory with unsigned long alignment,
we have to use it for allocation:

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 0ab20e2a5270..2da65d58520e 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -401,7 +401,7 @@ int memcg_expand_shrinker_maps(int new_id)
 	int size, old_size, ret = 0;
 	struct mem_cgroup *memcg;
 
-	size = DIV_ROUND_UP(new_id + 1, BITS_PER_BYTE);
+	size = DIV_ROUND_UP(new_id + 1, BITS_PER_LONG) * sizeof(unsigned long);
 	old_size = memcg_shrinker_map_size;
 	if (size <= old_size)
 		return 0;
