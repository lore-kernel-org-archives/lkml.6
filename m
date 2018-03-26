Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AG47ELvaRMtlsV0f0fv8HMxWDQ6v9IH/7GPRzNgoJZqZuDmDJ4iwmjUjS8tF2qWAb/2EMTLd7qj3
ARC-Seal: i=1; a=rsa-sha256; t=1522078422; cv=none;
        d=google.com; s=arc-20160816;
        b=M7ILr3RIWbh6d2dethF92eMy7i5AVlb3jM/MwhazshkOxX0pAId3Mhbol9HV08XbGc
         gsmm5YgZK0EFInzIm0cHDPJEmnT4qPo9i+cTwegjN8LrihdWcAFa+ChKOz0PXVfh0HOJ
         jp3Lz+JdiPPt44optAM4GUmgjbP1/L/QjdvXUc73Gbx691H1ijtCE47Hyi2MI/wh8hmH
         3b7kRcggI7ZKIkJvlFS3kBRH43s/4reATOGzdi79qg0RnSrVLZlTVIbVfYOQ9NwHax/j
         /VK29eJJqS6kBessQSq8frMwSaaMXMoAa0O/GZtCt58Ew/PQCiJKGOhd3ttd/rZBN1kL
         2X1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=/2QTlJjOXOP80ppYHDECgnN2Eh0ZUUYJuLYwFuszP5s=;
        b=FpioeBOV62ZX2BQiF8VC5qR8y02w5oJhMoo7IetklgbczbgYh1kxA6yU7E3wobKKC7
         3xaTWQEWTiNj1fMnu2tAUAptXhIH4eQuEPXInG7pUETAGMfa83997Itiehe7OjI9f/zV
         0N/0vZxN+Y2sV4ZF9OjJkB3mcn1B5o4dRADYrTGBu/QLRAHjVKs9UYJtTQnsi6yq905z
         DyFhayzaItlsFuBAd+2ILbca/YC9AMOuB0qoJ/2LykWGRf9v/bdlepS73po6QtsDR4HL
         Zoa1wy8hBgwslnw5UM+awYON0N2HDs5ZPGHVIcAu4i/SwwPvSGvOvZySJ6M6NlKLmTpG
         u8hw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=QBA7DzEd;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.0.130 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=QBA7DzEd;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.0.130 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Subject: Re: [PATCH 09/10] mm: Iterate only over charged shrinkers during
 memcg shrink_slab()
To: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
 akpm@linux-foundation.org, tglx@linutronix.de, pombredanne@nexb.com,
 stummala@codeaurora.org, gregkh@linuxfoundation.org, sfr@canb.auug.org.au,
 guro@fb.com, mka@chromium.org, penguin-kernel@I-love.SAKURA.ne.jp,
 chris@chris-wilson.co.uk, longman@redhat.com, minchan@kernel.org,
 hillf.zj@alibaba-inc.com, ying.huang@intel.com, mgorman@techsingularity.net,
 shakeelb@google.com, jbacik@fb.com, linux@roeck-us.net,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, willy@infradead.org
References: <152163840790.21546.980703278415599202.stgit@localhost.localdomain>
 <152163857170.21546.16040899989532143840.stgit@localhost.localdomain>
 <20180324201109.r4udxibbg4t23apg@esperanza>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <161e6bcb-82d9-ae19-0eb7-d3e913d139ff@virtuozzo.com>
Date: Mon, 26 Mar 2018 18:33:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180324201109.r4udxibbg4t23apg@esperanza>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0402CA0057.eurprd04.prod.outlook.com
 (2603:10a6:7:7c::46) To HE1PR0801MB1339.eurprd08.prod.outlook.com
 (2603:10a6:3:3a::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b93023c-2b16-4f74-3f4d-08d5932ef240
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1339;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;3:2eqlgmPHKDxLuHn4T/inEK6xJdlQi99gHbDw+mOb1nFcEfgmYxVsGHAkM2EKtFANFMtsFxz+Rjk5pyxf2vHTOKWpITjGx4lrW1FEd0iyR7JjpkK+zPQIRMzfqmftLEI6RxUlIrV6XyzMQkIDoiqJDCE/ZqfzO+EkEa+qPUdVYmfZd46dEthIdAZHc4wDsVUroLnOU9Q1cr9lW+qR/Sz3qhaweV3Z4QdSFQukGqxirytvHPv+NHXR2KpcrbIUwPHH;25:gHESdo8mGUkOZRwB5/o/TZMYXfW7LsKM+dlBgWJpr4CQKcnJDQ8HVDFrzxZHtYXJxNqZ+6DM2/Kxn93ppLAh2Vr3nWQvtVmglRRj+2+FbPXxvzmHF7iWhCsc50S2iuB2SV2Qd1JQo2+M8//yjaOue0SYUS9wZ5a3OD3R3/kLzRSEMRV32xQ+li/Pao9A9VXv3f0GO+2hZdVLnwJAUO88kI6Qhau50nT+XoqhOLRANLvLtLqRYZLt6D7umpU0n8e1Bv8KH4j/sZg1Ap39aMQ1A0C0okzOftOQzm8gv8Yy6kjpyUCNQDAZZMBrUFFk3+zYfEHPWTbTpBVK49Ez4teW/A==;31:sNnloS9Pnzle1XWbXoN3/wOwo+KYV/QgAe8mdZUzV7WMRrdPyHlMG04vrBg/WIptRf8XvdldMMTJMbC/jmnX/V8w9fYhfQbcIH5k1POOwry+IUCXpFwM4uKrIhu2kflKGvK8CWqWY/hU2qEKHzkYEehPbPxxcenywQTZI3j2Lhn1JZBudI6aeUKk5AnUJnMNRMEgwE6FFPBjSu/6mvS2nGFcxuFXRWLw7tl/VlVUxR8=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1339:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;20:asc3iOc3qtp6Yr8poY2LN70VhBdOEikI03Ok1s3zUjkafrNLa+3l7vxfgr8a7xritnFZ5G0MiIjRdyTyxd/jrYhZixjbt2jt4EZLCIJ/3bYDn2FNSyC2Jx096vUHYrJIyOrI/CWPQqi9BI9a/wi5tTkyOaKoMhluQDyI0mvX4v8n6fSrvkuylLrxhEB53dXfS8HXDcIcAESsEYPrgx5oI9HQmAHEYyKeeo6opLunlJ9TFuoct4v+iyaLylIT8YnU8ZARA+duX1w8oznIqoYbw5ij19MPJvODc+3srDfvXDAie+dkqyJsnzk9pDpLftI3uk4PAS0bqavv4uhybFaFka2wmKTJ+vyf+hggEo2oyzIPutmu9j+OpFUTUC4+06g64H/vsnXBcY9s/Mly9cGWKeOdhRWRdVkpBJ6413AZA0Hug3Vafmap3jRyHYZgkbYhHnBVj64I8Fy8HKuvRkJEII+c18h3t1Poqj8H1Q9ypDEn+3LHNRIET9K7GCALqhOh;4:o6IJmJnHxjXfijN4xW14QkIlpWTX5CDbYqbuCOWv3JQJJC0G9bqihvlaKcka0srHevD0O9IU7krojG2b1lcircYb8Ts9Hti0+fQwt5GujLCY7VU0eozuMi/yykABrH6RgYoeSv5rhJ8zcqbtumPeOiO2hbrgE2ufXqwANuuO0nWKD6arWXLZaGQL9sdiLBDFCQf9VVUmHyTB5IEtDLOCzuUD8GJhhyHNWWAaI+7aR9lKex99ZxL+FoPss0hb7jV8eV0fFAYZpNwSmmq4iEHTcw==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB133923D36B7323D1925DDBF9CDAD0@HE1PR0801MB1339.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(10201501046)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:HE1PR0801MB1339;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1339;
X-Forefront-PRVS: 06237E4555
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39840400004)(366004)(39380400002)(346002)(376002)(396003)(189003)(199004)(58126008)(53546011)(386003)(86362001)(77096007)(26005)(16526019)(186003)(8936002)(8676002)(55236004)(6346003)(97736004)(81156014)(81166006)(2906002)(68736007)(4326008)(31686004)(486005)(486005)(39060400002)(16576012)(52146003)(6116002)(52116002)(2486003)(76176011)(105586002)(31696002)(23676004)(3846002)(316002)(6486002)(25786009)(66066001)(65956001)(47776003)(65806001)(7736002)(305945005)(229853002)(106356001)(230700001)(5660300001)(65826007)(6246003)(50466002)(11346002)(7416002)(478600001)(6916009)(6666003)(956004)(2616005)(446003)(36756003)(64126003)(53936002)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1339;H:[172.16.25.196];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzk7MjM6YzBmQXRoVktIU1FHbVNKdlVMY2doWVh6?=
 =?utf-8?B?ZHdBVVNQVmhLd0p2YzNYSXVtUi95OTRLUThnb0F6SVVEWHlOQk1IT1ZDZHV0?=
 =?utf-8?B?VkIwN29ndllRMjBUdFlHMTBBU3haZFVjbXBpeUNyWFlPc1F3K1FqaTRLOGx5?=
 =?utf-8?B?RnYwZWloY3Q5WTBDYVVIZ3FIenpSV3liOFZtckxiNGZrODQ1YkxXZHRnRDdD?=
 =?utf-8?B?ektxQnlEUnlEZnduSGxsVHk2d2QrZEVkb3ZxWjRNdFVvUDdsTmgvUzByaU4v?=
 =?utf-8?B?dVNqZFZCTmhjMXA1QmV4TzVJdE92R29RakhiamNkUlNLd3hEb3dLS2h4MUs2?=
 =?utf-8?B?YndGd3FWYTNURUkwaDBhdFpoWkVzNFYxdm1XTnV5OEpPeXFaOUo1WXQ3VzI2?=
 =?utf-8?B?SHp6RHArcEZ6NFE5WFNsQkRmMkRPQlJ1M095R3Z0RS8wWmVRMjFUVzVJeU9p?=
 =?utf-8?B?cFRPZVlqZ3BVTlgzZUR5VFZzM2d4YThpUXhFV0FkZ2Z0ajFzNTQ3ZkdhNGo3?=
 =?utf-8?B?aDdZZ2ExWkxMaEh1MzVwM1hhUytOYUNoaXdWREJzZng0VnlMSlA1QUM0cSsy?=
 =?utf-8?B?WnUzbW1nTk5xbmRZSFZhSTBhVWpEM1d5YWVaeHpWcjl1cWVERjNUMDNlRXps?=
 =?utf-8?B?aDN6azE0M3RwdkdZSE5Ca1c4VU5RVnRLM3NKc0ZqamM0OEtsUkZsRGJBYXNX?=
 =?utf-8?B?T09KR092VGh5MDNkSTc2NHhOb2drT3d4UGp1czJlM2E0VlFxSkdQRitpMjN4?=
 =?utf-8?B?anFIUEhtMTdIL3BkalZKTUVldnNHbDNDcUI3N3oxR2RNeXJrRmd5NW1Xemda?=
 =?utf-8?B?TmZ4Y1ZLUmdwMlliU3ZyRURlT25abVlMM29UN0ZlN1FWYW5WcVVLZloxSlU1?=
 =?utf-8?B?dVBuUlVhZnpCRzNRTFJvRVhEVXd2cjNrQmZEUERWYkJuRE03YkRpTnRKK0gz?=
 =?utf-8?B?V0htT2RmcEVXZWJHUExRVDUrWC9yZEUwNTNGNGM1Y1FKT3pra1o0dWJtekM2?=
 =?utf-8?B?bFB1Nm5McDErWWkzL3RrTGREMVhTYlgyQUhnbFNWVUtTaEk4K3NzQVFDcVB6?=
 =?utf-8?B?Yjhsb2RTYU5DK256V0QwUnpUeUZmb3UrdzYwV0JoL05Jem9UQXA4MUpBTktn?=
 =?utf-8?B?MCtHQTRLc0JzNUFnaWFUUW5PbzlXZjl6bkhhRURMb0gxbXNqVDQxY01iczRX?=
 =?utf-8?B?NEFrZ2t2N2szTEY1em9tamhBR3Nqajc4SlRTQUpCZTU2WFhiMXphRUhSUFcv?=
 =?utf-8?B?Rk92K0U3aG10UUhpbGJPSUdNMCtLUWJYYm92bmNPL1dHdlI3Q0lJVnRnb0x2?=
 =?utf-8?B?cVdOR3BoNGRGWmJSZlJQMDNKYjRZTGFOUEdzZU5zWk1EMDNQMHpjYWU5N0lZ?=
 =?utf-8?B?dXJMY21wTzd1TGh0ZmlLNktUM1Jaa1E0b0xieDBLSmtGNWVsSDZXOFhQdlpo?=
 =?utf-8?B?bnVVWnpqZGxndWNtMDhjZFpvQit3WklENEU5eWVlbnFMY0RIUzI4bjFwWnpv?=
 =?utf-8?B?amdUVlJESjlhclM2VEJsUzNKMkZ5T2R2VlZiWnVzU2YwZTNJVDV4TWt3WGVj?=
 =?utf-8?B?c2dEejVrUHRRTGtlTldlOEhzMnhzWS8ydDBGcEVuc011SWVvQ1MxT3RoY1Qx?=
 =?utf-8?B?Vnk1blMrWjduN1BEQzhSVDBTRXp3cVkrdXZDeUt4VzZuT3dGZS9YWlo1NElv?=
 =?utf-8?B?SGRiRE9uN2hGQjJjNlltb0QvNW1xVW11ajB6QmlTd0lWVXJDUjVQTnZpMU55?=
 =?utf-8?B?T1c3eXhPNDRqeHMzalgwYVIycElIa0k3cjNNTS9PWEcvUWZMd2pidDByemM1?=
 =?utf-8?B?QStEZ3NFSmlGYndVcjhoNXQyS25ZcGJuTDNNbWV2dmRxYURLNy9rcm9ld1pK?=
 =?utf-8?B?YTFncGpNUXhQWVBlVWkxSDNHNDZCTnBWRmVDMzRIS3ZFZzVOOVYxY0k5YVBN?=
 =?utf-8?B?VkpUeWhmUlRXb3RDbUxXcHhVN3QrVUV0UWNkVmM2VnpScU4vMFdFYk91N0pi?=
 =?utf-8?B?WjVHQy9udVdZNDluT25UcndqZ2hTZ2poQi84NTlmVXUvVXJZQU1KWmVCNUtB?=
 =?utf-8?Q?RJkptI=3D?=
X-Microsoft-Antispam-Message-Info: d0TOj8DHs6JRlQrvFFb6yLIhUCiONz1tWJ7uiumSYRk9wzcPdo7smpIOfl6zzsq4hvMB5B9gDjylGxQjctHQzk/rhQvMCR/8rZ8eF9ah6JaMlvfZykCiuWksNPwQMtZCkN7k6hGIUcijvn286Ptx8AYMYtHVlf3pz8jL0NXqYe/0xq0fGzS0i83LgDnZ9FuJ
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;6:j2PGJ6oJqKUB51CabISPnpB5XRvfnz9r8Ric2huc3DJ13+CROc16xnv2yG8XcCilCGGc6+V3ruLYeQ8C5eu39U8fs/jHLfyMScIdFRBT0gVU6mbXGrGSadno4upCZ0/F89aNyeCA16w+Qni2sronVxkILYrl6W1lZnoVVPRi+nFbbBjHYr4s/poQDSuVoQJsSgUwHxXryZA8yqXekAlPxhI0cU/fJ3IJGtfiytE7Ykg0QOSck5Ne0bXgmjcOua6oyhQjvhBUuY6O5khRRlZ/9ax7K/NuAio2gz2kyY12/N13FPWHtIWMJkdg6dAMbLCI9PslTgUFTONXG6Kgh1ISG2Yj2Qsc31mDe93Q+dY1PhGzXfRhhT6HAL84Q1mqcFtGhF9qKC8rjIXWJR7/zZUZ9jvnCfoopbbT9N8nut5O+0CgZgP/gg/u7lg/ruJcSmBcRqQiI5LRk9x7SP/gVkKEGw==;5:kKadmyKXT5i8MhV3VXxpMcl7Db0/7S8cK/G2syaHs36VgYxdf8KZY+rGnMbzjZ8Bm7scfmAOXlte0g250rartbpn77BUflS7sTgA9g+2dBuScoJltaenWmjD0Sih3QO6QACwlCSrfI5DY4LVAkALlNIkEKepPaAdnOzZu/Qgff0=;24:K2QKss2OcbavaUV4b/X0xrVjY660kQ3Qq1IgoLVUj/esGptdvcQylq8m7Z5pTYKHmIvaGjf7m/pi7od8Is9Z2hPjMD96f1SlU0FkG5ann1s=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;7:uof9VeAPGeaL//Fe4kgSRmQ6ofGpBHa/nay/n9qk5wCyc7aS9yH/eZNfQKpk/y60srS+S5aMrWCS6DLE3dhyaxpwFZ5KVZVhc9oNk3gdghGYyn70akMeePhHA4u38LS/VUbIQX/d3INIo5b6HrB4vJX+k0FXxng+v5dYeuMBY7n7cQC6KFw6mWAZAt8xeHbBBZ+/mOP9xLjBMIciLJtKbUiNEeD2Fixsr5DfSyJ5fepWpjiPEn93V1gEjTs0HbHd;20:MVd9UFnfrwpzkdBJOKLLXGQoN5OnDNMkwZdnB+g2lDiqqWH6K8k3b4gW/CmOHEZ8HWuS0cG+6IJPz1d+HU8b038KV3y4QxRq68rdexNkd/IIz3HPTPa5rUf27xfzmqMSCt5aR7IPlYRoYaAk6pSc1xMdcBFp88ZKa+TjN330NSQ=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2018 15:33:37.3930 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b93023c-2b16-4f74-3f4d-08d5932ef240
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1339
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595553697180792132?=
X-GMAIL-MSGID: =?utf-8?q?1596014904303110870?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 24.03.2018 23:11, Vladimir Davydov wrote:
> On Wed, Mar 21, 2018 at 04:22:51PM +0300, Kirill Tkhai wrote:
>> Using the preparations made in previous patches, in case of memcg
>> shrink, we may avoid shrinkers, which are not set in memcg's shrinkers
>> bitmap. To do that, we separate iterations over memcg-aware and
>> !memcg-aware shrinkers, and memcg-aware shrinkers are chosen
>> via for_each_set_bit() from the bitmap. In case of big nodes,
>> having many isolated environments, this gives significant
>> performance growth. See next patch for the details.
>>
>> Note, that the patch does not respect to empty memcg shrinkers,
>> since we never clear the bitmap bits after we set it once.
>> Their shrinkers will be called again, with no shrinked objects
>> as result. This functionality is provided by next patch.
>>
>> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
>> ---
>>  mm/vmscan.c |   54 +++++++++++++++++++++++++++++++++++++++++-------------
>>  1 file changed, 41 insertions(+), 13 deletions(-)
>>
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index 265cf069b470..e1fd16bc7a9b 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -327,6 +327,8 @@ static int alloc_shrinker_id(struct shrinker *shrinker)
>>  
>>  	if (!(shrinker->flags & SHRINKER_MEMCG_AWARE))
>>  		return 0;
>> +	BUG_ON(!(shrinker->flags & SHRINKER_NUMA_AWARE));
>> +
>>  retry:
>>  	ida_pre_get(&bitmap_id_ida, GFP_KERNEL);
>>  	down_write(&bitmap_rwsem);
>> @@ -366,7 +368,8 @@ static void add_shrinker(struct shrinker *shrinker)
>>  	down_write(&shrinker_rwsem);
>>  	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
>>  		mcg_shrinkers[shrinker->id] = shrinker;
>> -	list_add_tail(&shrinker->list, &shrinker_list);
>> +	else
>> +		list_add_tail(&shrinker->list, &shrinker_list);
> 
> I don't think we should remove per-memcg shrinkers from the global
> shrinker list - this is confusing. It won't be critical if we iterate
> over all shrinkers on global reclaim, will it?

It depends on number of all shrinkers. And this is excess actions, we have to do.
Accessing their memory we flush cpu caches in some way. So, if there is no a reason
we really need them, I'd removed them from the list.

>>  	up_write(&shrinker_rwsem);
>>  }
>>  
>> @@ -701,6 +705,39 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
>>  	if (!down_read_trylock(&shrinker_rwsem))
>>  		goto out;
>>  
>> +#if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
>> +	if (!memcg_kmem_enabled() || memcg) {
>> +		struct shrinkers_map *map;
>> +		int i;
>> +
>> +		map = rcu_dereference_protected(SHRINKERS_MAP(memcg), true);
>> +		if (map) {
>> +			for_each_set_bit(i, map->map[nid], bitmap_nr_ids) {
>> +				struct shrink_control sc = {
>> +					.gfp_mask = gfp_mask,
>> +					.nid = nid,
>> +					.memcg = memcg,
>> +				};
>> +
>> +				shrinker = mcg_shrinkers[i];
>> +				if (!shrinker) {
>> +					clear_bit(i, map->map[nid]);
>> +					continue;
>> +				}
>> +				freed += do_shrink_slab(&sc, shrinker, priority);
>> +
>> +				if (rwsem_is_contended(&shrinker_rwsem)) {
>> +					freed = freed ? : 1;
>> +					goto unlock;
>> +				}
>> +			}
>> +		}
>> +
>> +		if (memcg_kmem_enabled() && memcg)
>> +			goto unlock;
> 
> May be, factor this out to a separate function, say shrink_slab_memcg?
> Just for the sake of code legibility.

Good idea, thanks.

Kirill
