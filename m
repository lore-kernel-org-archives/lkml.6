Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SORTED_RECIPS,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F9C3C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 999E22084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="CffFFdz3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 999E22084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730897AbeGSLZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 07:25:07 -0400
Received: from mail-eopbgr30124.outbound.protection.outlook.com ([40.107.3.124]:37705
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726531AbeGSLZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 07:25:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PUr+mQhkUc9rS0zY/E5jIHjB9scBCxAJ0DlnZhui9uM=;
 b=CffFFdz3mPK4SztoSXTeJMvF+2lCMdT4Q469ZW3L7LPslqwWsLHtIG7cf214nwvl8TcgSj9cIcy3oeF3PgmdW84p5Ff/vab9EN9Nm7PP5TFIfPYrpPlVs7uxHgnJHAn9dZYGg3SWCwF41B9PAgGDLhGreMZjTollAbCfFdpWqK8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from [172.16.25.169] (185.231.240.5) by
 DB6PR0801MB2023.eurprd08.prod.outlook.com (2603:10a6:4:76::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.16; Thu, 19 Jul 2018 10:27:19 +0000
Subject: Re: KASAN: use-after-free Read in shrink_slab
To:     syzbot <syzbot+6a3cf57dddcf4e4ea443@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, aryabinin@virtuozzo.com, guro@fb.com,
        hannes@cmpxchg.org, jbacik@fb.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mhocko@suse.com,
        penguin-kernel@I-love.SAKURA.ne.jp, rientjes@google.com,
        sfr@canb.auug.org.au, shakeelb@google.com,
        syzkaller-bugs@googlegroups.com, willy@infradead.org,
        ying.huang@intel.com
References: <000000000000f0319c05706389e0@google.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <b7cf35c5-6be4-489e-7734-e364522ec96e@virtuozzo.com>
Date:   Thu, 19 Jul 2018 13:27:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <000000000000f0319c05706389e0@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: VI1P193CA0008.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:800:bd::18) To DB6PR0801MB2023.eurprd08.prod.outlook.com
 (2603:10a6:4:76::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7dd98f1-81ae-4d5a-eec4-08d5ed623656
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600067)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB2023;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB2023;3:+KXm2f9t3sr15QjLdWjN1wM8s2gw0d/k7epjV6b0CfYUmwrqe5YrAkEXrdKeYXD6uN6QD5yctRrp3bynI6ifMBV2dhnKBU29W7pnN2ioDPpXKch9af3YTLRN3AmPT2NBhJic6ZD2wcapBG66TRq4tFbef2TjnUTHZOOj5R9SHP0X66CrNam1qHmo1Cj27CBDYCjhRbrWC+7c98ssoPK7x0lbkbYObofDHHl7Hk7HTaqCA8luj/nzbPxImbA5X9hG;25:ou0Cffk36lCtFqjY5jIiyRKaO2kM4hbtPZWLd1jlXIdLFDvppgvO5VLEcNRTSq8wO99JXpvs/ILgx83oOmagz4ELZya1AZKyVaBlVJL+n3AMgiyAxjFv+0DJL3DiudWFXlFLcQcdWb2e261TRFjv7Yt1IVKIJOaP+3WgxhHCEdBbMwmeZiy6bNzQaqfaFGqud+WxuFHt8llCQibh+sIt82lll8X0okZoAM6/25rSwmR9KNAcXW3HsxyAKmmGyb2+mG/baPo623ztz87oH6iFyNTds3Kej52NRgHU8ovaLc/L1BZUm6pXHbKtOKQKp+46gN8f33UbbqwWOWyizTK0rA==;31:KDPlBd7z+705n7+Vze7+uRR7QWRrnQ5NQ2R3BkHoiGolKWUehJXMNZGG7NvnjC/79OIa4inJENwV27qJlB102718eGfPwxwcVbdEAieRM8OQRFSdnUI/OzTErjhYjQrxK2YsRbgMBiFYJ3lGjegD/mBGpGqRmOXpS5BfLemaKk7nM7LUIQ2GEOipXzLKidH2dxUPFjqqtvrqSI9+DzPIvkgz1bkyesVI+hReyCCah8g=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB2023:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB2023;20:Qn6SXSjhLThi9IWBj2oFN8XeYCz/6OZ0f5DsSQhRxOOB8xhJKLjm+tQM4xCPLcz7eGKTrAX4z8ptZ7K0z9GI2+FfEaPpkGU1pJ6Ise6dqdd4apc2nylyI6V+KHBL2IBzEu1Oi1bTh2Ev+sjLXhKI2i8OEmlDBbHd3uwrOx5GCfIDHZt1ALCYEhtkBQ9SqVASb5tVeoj25t5faip6EofmFP3C+5LybaKAWLDXEmR3/1IkMBR9syWQBC7Xfw9vm6Q6R7lDd5K085FS4G3+Pi4yS8Ji03bI7wgL4jShYLH7xxl8GSuumqMyWQyWJlrbssFDsRphRdmPfdK3o4clxeAfi3Fij6zDaGavXLrVz59bdhMeyYCM6g913fowMfQFkcWV9r1ceNvuJYO1gSjm4BAcgffV/1OIAcQzVRtU8D30//MafKG91D7yoV+E29GTL12Gw3YsM4NNZIVsFaPOZev87sJtcwdczlJC0Vh36Sb6dBdvPMXXYOiAXDJna9aTPkn0;4:CbuFGo+SrEoLBf7ojJWGWlulIfsVC6uQHRROAn4XSkrhxYzb6yOkeBsBPJ+VIGLscDBSs9Jk/p6yTtqppnCu5uoz5TKd+RZi9QYv7CjzL9YKx0f+cQD+PyE77ergRF561yN0nU4O1KLraYFrfrYJMdMLwwAndi4e8U5VGPGWpvHIVoyWkcqYW3aYSOb3KLXwBSLK1W1BtYq9iWAIm8MktaqI9D+wyDlxBm9/dNYYFki9Atnuj5hoWWUrKOcky8Sg78Op7Urx9cG5VXqJQB3sAvRpN8DFZ/5/V1C8q6PzukvnHZb8Au24w3XfSWsEEtdr
X-Microsoft-Antispam-PRVS: <DB6PR0801MB2023721614AE6A59A995029ACD520@DB6PR0801MB2023.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DB6PR0801MB2023;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB2023;
X-Forefront-PRVS: 0738AF4208
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(396003)(346002)(376002)(39850400004)(366004)(136003)(199004)(189003)(81156014)(36756003)(106356001)(7416002)(14444005)(81166006)(6486002)(47776003)(6666003)(65826007)(66066001)(305945005)(6116002)(65956001)(8936002)(50466002)(7736002)(3846002)(65806001)(229853002)(97736004)(31686004)(8676002)(966005)(16576012)(386003)(16526019)(58126008)(77096007)(53936002)(2870700001)(956004)(76176011)(86362001)(105586002)(53546011)(25786009)(6306002)(186003)(316002)(486006)(478600001)(64126003)(2616005)(476003)(575784001)(52146003)(52116002)(2486003)(23676004)(6246003)(11346002)(446003)(5660300001)(31696002)(68736007)(2906002)(26005)(921003)(99710200001)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0801MB2023;H:[172.16.25.169];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA4MDFNQjIwMjM7MjM6YUc5REs5TFNrS2FXbXBCN0tXc29JZzgr?=
 =?utf-8?B?K3dna0dtLzFPbXlOWER4ckRhSjN6VnNkaGZoS3lHTE5nR0hHWkZrQnN1NXVL?=
 =?utf-8?B?TXpjcXNUUkpwR1gxakoyaXVlQWc3TkxkY3ByWmpEUlZidU51M2t6K1BmYWU5?=
 =?utf-8?B?Q3VnRERmNTBZc3JQak56d2FOdjlxaExHeERNYnR1bHV4SmJ0NEFONTRaMVp2?=
 =?utf-8?B?bVI4bHlSdEdxM0xRcmxNaGJIdnAyaVdmTVhvTUMyTnYrTmZ3QnA4SzFqTDRx?=
 =?utf-8?B?YlNINWJEK2FxMnkvTHkraWlJVDEwZ2hMRDJXalYxNUFrMG1IYUdqdjRGWWVQ?=
 =?utf-8?B?citJd3h4TU9tZmkxZVk0SUsrUHpqaXMvVC9VaDlha2hsS0Z5dTdkaUpMclVn?=
 =?utf-8?B?RWNyL21WTm84SFRYWkZzWXlTMUxWU0lqcElrOVNTU1RvT1UvTG1qRE5NREFj?=
 =?utf-8?B?VFk1dzhoYjRPYmx6QUlqR0M2bzBTZ2V0ZTNBaDFlbWx2eElkdWJPUktkRC9w?=
 =?utf-8?B?RTV5K00zQXZQY2V4R05KWlJaQ3RBSzJ3S3Zqd0wzVGFzeTdxVkRTbEh6czhJ?=
 =?utf-8?B?dGRGRTZPNGh3eEVzWXpYblZWSm1RSWVqaEtJSk5kZkZQVkp3NW0xSFdMUkxT?=
 =?utf-8?B?RWErSVQxWnNrd2xOTnp3eVhiNjBhRjc1NzBOeG41Y2lGb3BUWUFFYUVwZEZN?=
 =?utf-8?B?VjczUklnNWgxTmY0bGxNYVpBU3hiNm1oMml1cEI5b29vTXVmbjhBZUpDUlNM?=
 =?utf-8?B?bDJFYS93TWVKL2labVArd3B2L1VQYTIyY2RFeVpZZ1dnQkZnSHBwdGJSZnRG?=
 =?utf-8?B?Qy9sNW41bkZsSlpaVkx3Y093R1RsN21FWE02WEl5b0dYdG9BQlVZM3VxMllD?=
 =?utf-8?B?UXBFbEdvVVpFRVR5UzdINzBIY1VQa2V5RzhJYVRGaHQzK3c3Ynlva0M1Q01u?=
 =?utf-8?B?RjZFZi94STEyaDQ5VlBKSTl4ZUJoRkpNcTMrVEUvTC9DYk5Zc1ZHN0NtdWtQ?=
 =?utf-8?B?Q3RsazJpQ3BQeTRFaC9zUUZKT2gxK2lQWTFWdFNFKzNnQndydi9yYlhpblBF?=
 =?utf-8?B?bXpXc0p1R2tOVlA2aXZRT3JHa3pHUnVxN3hxSGZ0VUVjQWo0dHg3YWxBLzQ2?=
 =?utf-8?B?T29ySVZGRVVmcVVaVE9yb1lSc2c5eXZtaHMyOGVPdldpS2gzK1FUU2wxYjF5?=
 =?utf-8?B?STRFbXA0c25mbUJMbnJjUTJMZitRcjRVUFRlbWpMS1RBcHA1dWFhU0xuRS9K?=
 =?utf-8?B?azlMd01CRjVxQWljOXQwUjViSUU3eDl5bmR4bWtJRlBiTHNEK0l4ZlVPQmpa?=
 =?utf-8?B?WWdtUlpZZTU2TXc4MHV1S01SdklaYnNENVJmam5RRmhDVVlLcG4waTUweENk?=
 =?utf-8?B?ZzlrdzJvbTRwdzRaNXFMYkNQSmpWWjJiaXYzVThiNFdpUk8zUmUrbUJpdnRx?=
 =?utf-8?B?c2FnbkRpVC9QTmJKcVpCTkRkMG5BL0xTQWFycnJ0Z2ZyQjhkNzFqc2ppbyt1?=
 =?utf-8?B?SmdNU1FpbGI0QWhaK1c2Z0drTzF6ZlF0cnloRThNVFBWVVlsYlBGbnFyZVRu?=
 =?utf-8?B?MjA3UW5oYUpRdmFmcTZmZXpQQXNwNWhtSW94RTZuUmVTanZvOXNieGZpSFZ5?=
 =?utf-8?B?ODFoUkVKL2hReUh5NjVLT1ZrRk05eXc2OTZXMTF4SkRpeUMwQ1NjUk0rWVdj?=
 =?utf-8?B?YWpKemxpL2tZVHplU2JsQktNRGFqUUxLNmhERTZHb2ZidEVHY2M2cEIzVUFm?=
 =?utf-8?B?Q2tZTEFtRDBobHp2SkV1VHBqNEI5dHR3YmltTWhld0hRdmpRUmpDQkpBR0tB?=
 =?utf-8?B?WHpPVnF1VjNqOERJelFvUkdhOW1KbDFFZFI5MUEzVk9KVWZBVVg2SGxWTnlj?=
 =?utf-8?B?Y1owZUcxQjRlRTg2RURkSVczNFN2R3YwajRXSVFUNHpsbXBWRXVtV0xsZFhl?=
 =?utf-8?B?Uy9rb1hDNXZWWEZTWVA0MXNUczB1UHErbm1jZWJjME81YW1oUjJiVlBFQWtv?=
 =?utf-8?B?Q1lOVHRISC9RbTg1aFBKR2lLYU5zNUxWTUdSR2RLc2lEVTZLTjhkMlRYcElT?=
 =?utf-8?Q?Q2/0e52hzPMhVEWL0VY+cXryUtd?=
X-Microsoft-Antispam-Message-Info: nnRPhby8Wz9z/cQB2a27Lx9om901TcqEM4/Hhd5uAY0p2399FW+VToIASOQ49OJx9J2kFQyZ+BieEhrJKqUWAcume6yHzY9+RY0NmlPNwExhvkDtf2K3Z2h/hpDF1tGg3ge7MpxCrTFck37ji8rSXLYgK6p8BpeJ+Ty14pLX5XExiZEyW0IMUdqVYk1tTxmXf8mleWE7PJAQXjkY3TWtJaSBjGPyPYuywLFk4f9NAY8RzVkeO29BOhIXb1iDWPDnUDH3BOmZPtStMU3qbhI7qFds/85pl5fnx6UUS44pnHRoRIBsDDdcpfVu2x+8qzi1mZJaPR9Y7PjKVomcO5DptC1HTsjsqHAJVDsodS/dA2s=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB2023;6:xZEFajDqbcz12Y42wuiAI07yZEWcX2NbvewZUm3lVa2DLlZB0Ui3vqjoo4DfFJ/WN6UFK3Usuu9xIxobbhlbAEFTKVZnXUVWx2ugI5IVmWG2XEHwMTX+RLYuMk8ra4rDNmEifvdAHNUaIBy6Ci2/ntjGoGqx9OuKI75ejuzRooZROe47+PjaQzsKmRhu7JYtwi5gzwFDYt0kvMO8sA91zSLRC0gUEuNfqYKYdlXBi28U3nO1dJB3uAx+A2zP37ueyNNorSMyoofD0g3yMrf9wchrLqtVbP5Fa9ug7S1wbRmk3W8efvFlumwU96/RhFcm2O9RCnM+g6Z+bWKJYOzSDaB/iZ6LNdYcIw3GpyYt5DIuPoMh9Cy03kNZ1sEQBFAYOc6PLC7P/KQhHyJgACZmA19jmqG3vKANEWSk3ct5IXu+Uq/mCNTppOaS8JHiaURb0ec3G/g/06pVpmZZmDfKaw==;5:OtmZyiyuEQXxBWzKmRxfKoNs1VTpykCZm8fEKYPY8VdmEUA7S8t3Xv8fIngn5fQbHN0+RyWpLp1lvisfxCKZ/X3t25fN9KTGgIIMk4UNuYJXVFo54XA58itO/p4EQSyplzUlNuY7yRPqqDs4I5czKv6BzuTS4d21DLYRQ01Gnnk=;7:dWtOl9TaAyAPcfl1ll1+FGCcAhLUXtyN6B/3K+pQHv7xYygxHspBlQ+plCmcCRyzZ1bdWz8eA0lqwNkCSsKIauj9+7HWWQ+57XKYnQTKpU2RQ5Jg09aKCrXymIAiDoS9Dymmhv5Io+F66rIkJRBC5f32SZ3TXLI2sHe3qqvJeFwQpwzZKL1lCWAZddBMQgQI/FAXoPMoVBxI63PfmGkFHoDhyVhK2a3T9P1HBNSbXfzXts311bMOWjLj4MQbDhSr
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB2023;20:MJzvnJORUS4VvOJBleIi59yI7Gi9+u4HyxZHZaqvVSgFOG09iF4EgEHskI2ujNlW69O39AmJTjCVxbfTs756seJPLrL/uRWUiwMph7RL0vhWriOXhHHaECnOmpT7zb0Ob0pMLv8It8PRC+5WG+dOUYuUujOd5pU2xcBKqlDknKw=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2018 10:27:19.9122 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7dd98f1-81ae-4d5a-eec4-08d5ed623656
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB2023
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.07.2018 10:15, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    526674536360 Add linux-next specific files for 20180706
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1703690c400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c8d1cfc0cb798e48
> dashboard link: https://syzkaller.appspot.com/bug?extid=6a3cf57dddcf4e4ea443
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+6a3cf57dddcf4e4ea443@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KASAN: use-after-free in shrink_slab_memcg mm/vmscan.c:593 [inline]
> BUG: KASAN: use-after-free in shrink_slab+0xd22/0xdb0 mm/vmscan.c:672
> Read of size 8 at addr ffff8801cc325210 by task syz-executor4/10315
> 
> CPU: 1 PID: 10315 Comm: syz-executor4 Not tainted 4.18.0-rc3-next-20180706+ #1
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
>  print_address_description+0x6c/0x20b mm/kasan/report.c:256
>  kasan_report_error mm/kasan/report.c:354 [inline]
>  kasan_report.cold.7+0x242/0x30d mm/kasan/report.c:412
>  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
>  shrink_slab_memcg mm/vmscan.c:593 [inline]
>  shrink_slab+0xd22/0xdb0 mm/vmscan.c:672
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
> RIP: 0033:0x455ba9
> Code: 1d ba fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 eb b9 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007fbb1ad41c68 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 00007fbb1ad426d4 RCX: 0000000000455ba9
> RDX: 000000000000006b RSI: 0000000020000740 RDI: 0000000000000015
> RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
> R13: 00000000004c28ce R14: 00000000004d4238 R15: 0000000000000000
> 
> Allocated by task 15966:
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
>  set_track mm/kasan/kasan.c:460 [inline]
>  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
>  kasan_slab_alloc+0x12/0x20 mm/kasan/kasan.c:490
>  kmem_cache_alloc+0x12e/0x760 mm/slab.c:3554
>  getname_flags+0xd0/0x5a0 fs/namei.c:140
>  user_path_at_empty+0x2d/0x50 fs/namei.c:2625
>  user_path_at include/linux/namei.h:57 [inline]
>  vfs_statx+0x129/0x210 fs/stat.c:185
>  vfs_stat include/linux/fs.h:3143 [inline]
>  __do_sys_newstat+0x8f/0x110 fs/stat.c:337
>  __se_sys_newstat fs/stat.c:333 [inline]
>  __x64_sys_newstat+0x54/0x80 fs/stat.c:333
>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> Freed by task 15966:
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
>  set_track mm/kasan/kasan.c:460 [inline]
>  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
>  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
>  __cache_free mm/slab.c:3498 [inline]
>  kmem_cache_free+0x86/0x2d0 mm/slab.c:3756
>  putname+0xf2/0x130 fs/namei.c:261
>  filename_lookup+0x397/0x510 fs/namei.c:2371
>  user_path_at_empty+0x40/0x50 fs/namei.c:2625
>  user_path_at include/linux/namei.h:57 [inline]
>  vfs_statx+0x129/0x210 fs/stat.c:185
>  vfs_stat include/linux/fs.h:3143 [inline]
>  __do_sys_newstat+0x8f/0x110 fs/stat.c:337
>  __se_sys_newstat fs/stat.c:333 [inline]
>  __x64_sys_newstat+0x54/0x80 fs/stat.c:333
>  do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> The buggy address belongs to the object at ffff8801cc324e00
>  which belongs to the cache names_cache of size 4096
> The buggy address is located 1040 bytes inside of
>  4096-byte region [ffff8801cc324e00, ffff8801cc325e00)
> The buggy address belongs to the page:
> page:ffffea000730c900 count:1 mapcount:0 mapping:ffff8801da987dc0 index:0x0 compound_mapcount: 0
> flags: 0x2fffc0000008100(slab|head)
> raw: 02fffc0000008100 ffffea0006609a08 ffffea0006b75508 ffff8801da987dc0
> raw: 0000000000000000 ffff8801cc324e00 0000000100000001 0000000000000000
> page dumped because: kasan: bad access detected
> 
> Memory state around the buggy address:
>  ffff8801cc325100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff8801cc325180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>> ffff8801cc325200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                          ^
>  ffff8801cc325280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff8801cc325300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ==================================================================

#syz invalid

This should be fixed by 49bf58ae4530 "fs/super.c: fix double prealloc_shrinker() in sget_fc()"
and 38a177aa7a72 "fs-fix-double-prealloc_shrinker-in-sget_fc-fix" in linux-next.

