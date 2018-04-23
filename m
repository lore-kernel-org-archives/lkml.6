Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AIpwx4+8Ap95I4WKMLeM2KlK7EPJPnKeBCuG4r/4usrda8gd7ouF8jb8WRqlyodjP11eTsic9+eU
ARC-Seal: i=1; a=rsa-sha256; t=1524481603; cv=none;
        d=google.com; s=arc-20160816;
        b=boT/rOwJBXEraAuHeU1VHIbfu2KYqJzx9pOQz043YIbKfEfdWHg1Psk9tAGg8gYC6a
         GgFOUYhOkq/rJKtjAvkoJ8ImgKsIuAjhUUfT27PouHdDm2HIVsVY87xj/qA+UWHpcGV4
         GhJfkwJrF33EGRduNYwFqCtUXLBvxl6uCRr15q5y624V7UJNTH8Do44L9uoMk2GA0ixF
         Pghht3n3GTWqc/kbrM4ahm28muGZi0zEnq8fFoB43ZTCBBpSGhThzQKzPOGEoHNY+eV8
         MNwTEqkuoifsTHYuLmdKMGT6ylG4dV0x32iXl05mHAat0lUDeqlyrWLIiYuLNtSAnP/R
         V2BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=issOF39iVdedEH0zyrWZqAVvavJr1lKs0P9Maryc9aE=;
        b=DXL0TFwN01smThka8RsDkH3yLRmUTEtdDX/Hdth5AY/HuTfxNM1RhZbzUybZYLztGB
         I64ipiheeIwi5B0uJsuVzpWgvP4Vz9OBRLY/uueWm6pE9DXf3XfjSyjhDqDGdM/FLGzv
         kSurNx2Lc6tIO5oEXDSQqPoW7GQJG7DvnNJN+W+wIDTy4QO3wBE7MlWhg1A577xksthy
         Cm0sHxaBoyAkNx13L1KHRymmK3CKvpKRLDnjXgUpxlSQiEXfbtkeb/or0lOZKDUGy/UQ
         dB8stnlIVYWg38UEzGFILHD2B0nqvBXODzjxG3knUg+dXRlFpgymEU1YzjKg6nmpzYLB
         8iQw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=GT63JxOv;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 40.107.3.122 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=GT63JxOv;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 40.107.3.122 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: Re: [PATCH v2 04/12] mm: Assign memcg-aware shrinkers bitmap to memcg
To: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: akpm@linux-foundation.org, shakeelb@google.com, viro@zeniv.linux.org.uk,
 hannes@cmpxchg.org, mhocko@kernel.org, tglx@linutronix.de,
 pombredanne@nexb.com, stummala@codeaurora.org, gregkh@linuxfoundation.org,
 sfr@canb.auug.org.au, guro@fb.com, mka@chromium.org,
 penguin-kernel@I-love.SAKURA.ne.jp, chris@chris-wilson.co.uk,
 longman@redhat.com, minchan@kernel.org, hillf.zj@alibaba-inc.com,
 ying.huang@intel.com, mgorman@techsingularity.net, jbacik@fb.com,
 linux@roeck-us.net, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 willy@infradead.org, lirongqing@baidu.com, aryabinin@virtuozzo.com
References: <152397794111.3456.1281420602140818725.stgit@localhost.localdomain>
 <152399121146.3456.5459546288565589098.stgit@localhost.localdomain>
 <20180422175900.dsjmm7gt2nsqj3er@esperanza>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <552aba74-c208-e959-0b4f-4784e68c6109@virtuozzo.com>
Date: Mon, 23 Apr 2018 14:06:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180422175900.dsjmm7gt2nsqj3er@esperanza>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: DB7PR03CA0015.eurprd03.prod.outlook.com (2603:10a6:5::28)
 To HE1PR0801MB1338.eurprd08.prod.outlook.com (2603:10a6:3:39::28)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1338;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;3:db4UBItGPRtHKWMYMGbJRUVv+iPbvCIwIkmlplXKm6Ls6BkJKIzVZAyGy1Osex7VL7jdVxOF1SCZ5Pxrx8UOiVC3LSKUm+IrVNafuCvLCPSrmE/CVItgYCiICAalJRxGTj6804ZDMHdCE0X7OVySh+i8zZy7MwJWu/EwqUOHhgc9xD6Gq6JOs7VO7TBBOxhRg9a4XtEIbaCV8/5uLRmCZlmHdwlia1PbhWpu0y6KXmxrQwKMU8PSExg6Vck5Fkpw;25:P5OiCyqWt4YlcBBoRwABRtNV7FuILlYW2ByYBKlb+mJxOdQaMrGd5CmrqnaU46bYwNoqJN12PSVj6foMqL6+21khZuyoPV+mgkykdwtbikWvQGDiSO9u0kHStrCfOH1PLn+ToGJ9INJfurtPxalNaNAhvVbgYbiFy+Zu8hFPQRdbiiAuiZ0mI3WNw7eF7m1i+y45IyH8p5ZAbxQmvTXdgc0gGIzu0yuanRrvn7ipYNW2whB8ex4AGpBKbwk14R+6ERBKtO509Js4JNV+sqWAic8QvpvK2InkoOONEFBnpHR4cKD5GKVSAr+YlMZEY5cXdj5fLq1y7QSAuiTH5K/MHQ==;31:W6ORjFB4y+kNUm467K2RgN4AQDjy69+RnAnq2kGST0IRp9iFl3xDSa/bd96qjhLDeFwqORfquskho07f+yaHJOdPp89yYK2uZILELSFM2X7A3zL17NGYNW2D8WUoZqmhF37OxhSMhswsy3Ul/3gySXONKo7NJyT1JnBc0e+2yeTq91DsK+QaIcvX9u0GdkzgLS76tRf/zTD04IAFBliwEpX9oL3ippgTsH7v//b7/ZU=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1338:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;20:+qPkjm6gmJP+CroEpdPqcc0TA303CCDNBJ2w24KMQzgOBmk8V89kDGjsjHAEPGnLUq5vt9h8dJr8mPkngbAw/XlVt9aWMxXY6fJOigSRjf7aCWKons9taDvvofFM69C16dQEZF9OpHo4msX/oKBpzIV32WYsrRVWuW2+QkL+BD871OP0Fe8oW7iMQHQpEbSLy85MqZzAmEr0tMHO59nxL1o+Rkg2JRs0urKaRC/MRhz65rxcH8jgEwAlIVQI5iGgE/J+rHtsLQAmvMk5AFsgQGVOQqtp0iMaeUaYZ8DpzqehmraXjCYAihCsw9WRJr63bjUv/dw1jy9vMV8V/CRmit+RovKhqU8Jw2cDcTP5HyYZ7xSyXzR8nH2rNLMW9W4wTf1OmzTk1ug6p6qumq5dRFfdrbP1/F2HUnvfnU5fXYHrvmxdOqjiGrhog6o0Qr49ljUygDd2HVdkeLq8hG2fkKASrz+fHW8uAagOm8Yuf+K/C/Clj0bDRYwswcdAn0hw;4:075G7JSnl3HisfdqCTyXwZVV1vxpeDY4k6iuRVl7Ifep0Mm/4sRm7FtmsOXkGBxslbHwCxIPSpEQ1t9PokJkCNW93U48wdZ8nBJ2LsMSIkRIKraxrFq3fSZ6U+8+8O9oy/buwlwDhbDPvEQ9M4T0adi0Z9iWEh8I/Mcda3u156I675rpus0jRIql1mSL0sdeGWwdjl/V95E4EKL/xYHhJFaFifag+Wvf9fkYd4bakas99VleJRojzXNUU2AT3NlNXwPbnmGa4wVK2SxnV4FzucRJlCmLhtSyZ0xGyIlQ/5HqXSGE5cA3ILxJP61PILp7
X-Microsoft-Antispam-PRVS: <HE1PR0801MB1338D065EF5A7B32B2CDAFA6CD890@HE1PR0801MB1338.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(209352067349851);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(3231232)(944501410)(52105095)(93006095)(93001095)(10201501046)(6041310)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:HE1PR0801MB1338;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1338;
X-Forefront-PRVS: 06515DA04B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(979002)(6049001)(39380400002)(366004)(376002)(346002)(39840400004)(396003)(59450400001)(6246003)(47776003)(16576012)(36756003)(65806001)(66066001)(316002)(39060400002)(386003)(58126008)(7416002)(76176011)(65956001)(64126003)(478600001)(52116002)(53936002)(25786009)(4326008)(2906002)(53546011)(107886003)(8936002)(31686004)(81166006)(8676002)(5660300001)(65826007)(7736002)(3846002)(6116002)(230700001)(305945005)(86362001)(6486002)(26005)(446003)(6916009)(2486003)(2616005)(11346002)(50466002)(956004)(476003)(31696002)(16526019)(229853002)(77096007)(52146003)(23676004)(6666003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1338;H:[172.16.25.5];FPR:;SPF:None;LANG:en;MLV:ovrnspm;PTR:InfoNoRecords;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzg7MjM6aHJGQXdNSi9TSE82SDNMTmtkOVRlZ2FR?=
 =?utf-8?B?MGdJN20wM1BpRGprN0NzczFaWGpkNmp3T0ZKTUJyU0dnRzRTMGM0TWtkWmVM?=
 =?utf-8?B?MmdBVGRUd3BaaUZpWXZ5YWhpaWdTRkFJbThsNHJHcXVDNGhUKzY1QkxsSXJL?=
 =?utf-8?B?Q0FYNmZVRlZiWnRPWis5a2lIbmVuQmVLZDFlcUV4Q2o1cXMwSUo0VHdjNytj?=
 =?utf-8?B?ZVpudE9MZTdHN0JDOUNzcUV0VE9udE5oZlNZMDVwNlgrajFwR3RVakxuUEF4?=
 =?utf-8?B?Nm1WUXJuZ1doRHBxd0duUzdUM3hhMVpmdnZnVEdPLzVYa1dWREJGZGx6NHdR?=
 =?utf-8?B?QTluSDJ3MnVXRTFrdFJmR2I3SlJGcFJtR0VWd0dBd3ljaTZ1MUFXcjNVSHg2?=
 =?utf-8?B?SkYwQWR5cEx0MlVibDlQYlN2eXNYNkpvWU9GUmplYW8wWDQ2QmxpUnU2Sm5H?=
 =?utf-8?B?alF2S08rM0JHcStXKy81Y1hHd1U2K1RBWmpFSXZLV0RBMGJ1NFNOTzhQNUtv?=
 =?utf-8?B?R1A0YU9XQW5mYmp6Mkx1cjJmNjErbTZpdUN5d25Za1VpVkZGdG5nTHV4ZER4?=
 =?utf-8?B?VWJwc2JQY2dDcGMxOVlhZ1U2UjNmSzJPa0xYdGdpeXZMUENOWiszZDVqclNY?=
 =?utf-8?B?QnlkbDMyem1LcVNvdWprNHEyUTdCRE0wdUJQeXlJZDg5ekxQSnpBOC8vWk11?=
 =?utf-8?B?bTJncFF5aXg2T2ZXQ3dqYWFrRnVZeDlDSEFlZmdKVGdxWG42RmdxYTcwZnlS?=
 =?utf-8?B?SnFFcEhIRGIyTFBOeDlZMVZXeTBnSUZDZ0RyZ2FSaG9aMCs1bDBIRnh2MXVR?=
 =?utf-8?B?Vm9pZEhDUXpjb2xXYk8wV2Z1ZnRuN2tMWTB3aGxCcStUYU9yMTd3ZGtXTXBR?=
 =?utf-8?B?cC8zNWw5aC9nU3UwaWRDNWpKanVTTHM3SStnYlB3ZndLOW5oMU9qZTJzUTZL?=
 =?utf-8?B?V3FhMjllYzN0Mnh2bEtmaHI1T1RBSVZVZVJuZnJhcHVSYXlWN1MxSVhobVNn?=
 =?utf-8?B?NnZoUHJoR2U1bENYTWNZUmVSM1c4TU54SW9oV1ovaVcwUUx1aHh1L01Sc1Jr?=
 =?utf-8?B?M3cwTTVxYS9rY2c5Nm5tbWx5QktrOTlhb2lXZjRIRUl3NDkzSFpkNGwrY2R3?=
 =?utf-8?B?RlBwK1JvVE9EcDNBNktHbFNBQ1QwS2grRDFxNk9SMTV2TzA1THdhVlF6amli?=
 =?utf-8?B?OGhSdk9ITjIxNncvZWNQanVWbCsxelJ0V3pleGpEdE5BNEQ3SWZyNDZxV2V2?=
 =?utf-8?B?dUkrZk1abTJsWlZMbzFlMG9sNlZGd0lTbXV4Sloyck43aXJNcFU3RjFlankx?=
 =?utf-8?B?S09Fc3N6SlJaTSt6WXRhQ2Vjc1MxNk05MTZOdDcwK3dBTDVPMTA3T0podzV3?=
 =?utf-8?B?RU93TUxxaWRlWVZITVcwNk5WRjl3RkppR0V6S1lBSmVPclpJaG1FSXV3VHNO?=
 =?utf-8?B?dmsvSnJlWng2bTZVaC9zeW91WGZ4L21ZYVJFUWh5WVF3WVFFbTVPRlU4Qkhl?=
 =?utf-8?B?UExnZFlkMDJWMjFXelhkS2wrdmkvakdEWGp6dzZROFpRTHRFemcvVzhKL0xY?=
 =?utf-8?B?bnFrZkQ2YWFYMERnbjRNWmpoeG5IWnI5NWpVYWdlM2p4ZEl0ZDEydGlQVmNj?=
 =?utf-8?B?UldramFyOGkxUW9qYkVuR000NFBNRnBReUo4R3F5TVc3Ym1HSG0rVFdIRklv?=
 =?utf-8?B?eUhhVjVnVi9MQ0lsWnFCMmNETmJGQjI5ZXJEOHoyZUdWOXBXNkZGTHhXUFQ3?=
 =?utf-8?B?aW9hamdWMFRQSDVSU2xTQVk4TFd5S2tUaVp2N1FtQ0UxRDNSTGpZYklqOTZa?=
 =?utf-8?B?Mjc3OU9CKzF5ZTNsV1pnazkvY29rOWM2VWpmNGFucTBoMVhZYmplKzUyZjZQ?=
 =?utf-8?B?YkNqekZpVFdHOTRRSHhCZzg3a1RSWkhtQ2ZnWTh5Ny9hZk9JUFFjdWFDUmgv?=
 =?utf-8?B?MTNqVEZHSWhUYkE9PQ==?=
X-Microsoft-Antispam-Message-Info: EQ3v5AZ0CTPEagTvBh+S2yGn4UhwdzJv/UCECMbOMjSKYOycypnPnGsIEcYKgi/TAzFQCr+jc8n8o8N3nT0qviw3tOQlbtzSS33px9tV7XS+vtEj3JuSol3DwiYiZT7Oyu/v0P/VFmkv9CFUakWJ/D0W1nVYdCZLia2j2Gk1+eJz6gsfPQK8a2RnATUwQFzL
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;6:SY8LcsIIAJnxJpd89nbcwy1Zrb4bvfDM1bUJfJBTiLOnGbyATPi9TdxIyoyzdtsDJ4m0RdKPd96skJN3R44w7GdYPMPCiQyesw4f7sTr09TO0cCwbyh1u8bM0ShI8wi0lrT47OLZ0yx6jb9ZL7U2AdvNZKAA7xc6lnRiobosWWhBszcx1KuEwTUnklOMiaHcXVG4/XqiOfHRLZSO2hfq0dh9AZOEG1awkkzn2dh2mWJyux5hookK1jPRnJWql+6+bkC4nTMtS9xd5H5jtP09TOWVtrEto/PjzLC72DSlGlKsbfDUuzuN1NS/nZw/1jJ7wqiNTIH8dudu13dAjEVFWHxYbBozXB9IJXxWYI7Ref04wNxAlsrpfAdM01KJGQDamig4SPzzEs2GmQfzO8YvajpCT0MS4bDYDvo2sOVo53kltnTTjgJajkFifkg7RIFUb/RAAAAQr9Q1at7ibABnNw==;5:g+mTaX1cnja2nS5Ly8D88/z6p4BnbdQ5tiNw6iGn7jbNQXRt1thwpis+HVkA68O7M5LdH61g2DSHuerVrJyZAGKoDYna/J/9Z1DTQTb8V5ngyUF7vDTB5JUVujyFA36juBAEU9MtlhrYyjyvStNKSTgGJU0e6jh8wsLWVLlxuY0=;24:V+p8T4Hs8xpwaqe+DASWGlwOoBZuZLcOarooSNq6IvqFS5TIn0sNlXEu9y0zuFj4wbwzKKfXZ7Kte6RtG+dQ/MPf2VfNCAFUFFlcvxs9RNo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;7:JSkfYx+A+ATUQA74M43EuAxEIFN8pVXmvNlInbRDpwLST4f4efg44ozlsXbCqE/xdBtDFDojTwNhC+/YHLXkYfFP94jULRw/skQKnNhSM1CEf0WjXTILwTDTlmreo/J4/QJ8zJJ4nHV7crJ+KO24YY1i5B45sVxf11Cistc4qf5+befMGAiA6gYYKMmi55YHJY5SIdo6PMWGG0/70wbw9/s3wsUY2+OXjC6AaDoo9zgyR0zz1nnpk445kmMQNsAd;20:gmhX/JbDE7Urd457FynYWdzHW602dcqRTDr11IHSRv+04G9R4wtlg4WxMhDJDsloKfbJ4BdnLx4CHQpGIo1qHFmI3/rqCWkzMUoGNszpo0ybPXsurwVMJ31jgCmoL4s6Z6N3AYEZ6sVMyN0DwG3ZtOg7FnZo6wv4PjV2HZvc8d0=
X-MS-Office365-Filtering-Correlation-Id: 324b75e4-27f2-4ace-ac01-08d5a90a48c7
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2018 11:06:34.6570 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 324b75e4-27f2-4ace-ac01-08d5a90a48c7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1338
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598009310068873507?=
X-GMAIL-MSGID: =?utf-8?q?1598534821595350438?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 22.04.2018 20:59, Vladimir Davydov wrote:
> On Tue, Apr 17, 2018 at 09:53:31PM +0300, Kirill Tkhai wrote:
>> Imagine a big node with many cpus, memory cgroups and containers.
>> Let we have 200 containers, every container has 10 mounts,
>> and 10 cgroups. All container tasks don't touch foreign
>> containers mounts. If there is intensive pages write,
>> and global reclaim happens, a writing task has to iterate
>> over all memcgs to shrink slab, before it's able to go
>> to shrink_page_list().
>>
>> Iteration over all the memcg slabs is very expensive:
>> the task has to visit 200 * 10 = 2000 shrinkers
>> for every memcg, and since there are 2000 memcgs,
>> the total calls are 2000 * 2000 = 4000000.
>>
>> So, the shrinker makes 4 million do_shrink_slab() calls
>> just to try to isolate SWAP_CLUSTER_MAX pages in one
>> of the actively writing memcg via shrink_page_list().
>> I've observed a node spending almost 100% in kernel,
>> making useless iteration over already shrinked slab.
>>
>> This patch adds bitmap of memcg-aware shrinkers to memcg.
>> The size of the bitmap depends on bitmap_nr_ids, and during
>> memcg life it's maintained to be enough to fit bitmap_nr_ids
>> shrinkers. Every bit in the map is related to corresponding
>> shrinker id.
>>
>> Next patches will maintain set bit only for really charged
>> memcg. This will allow shrink_slab() to increase its
>> performance in significant way. See the last patch for
>> the numbers.
>>
>> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
>> ---
>>  include/linux/memcontrol.h |   15 +++++
>>  mm/memcontrol.c            |  125 ++++++++++++++++++++++++++++++++++++++++++++
>>  mm/vmscan.c                |   21 +++++++
>>  3 files changed, 160 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
>> index af9eed2e3e04..2ec96ab46b01 100644
>> --- a/include/linux/memcontrol.h
>> +++ b/include/linux/memcontrol.h
>> @@ -115,6 +115,7 @@ struct mem_cgroup_per_node {
>>  	unsigned long		lru_zone_size[MAX_NR_ZONES][NR_LRU_LISTS];
>>  
>>  	struct mem_cgroup_reclaim_iter	iter[DEF_PRIORITY + 1];
> 
>> +	struct memcg_shrinker_map __rcu	*shrinkers_map;
> 
> shrinker_map
> 
>>  
>>  	struct rb_node		tree_node;	/* RB tree node */
>>  	unsigned long		usage_in_excess;/* Set to the value by which */
>> @@ -153,6 +154,11 @@ struct mem_cgroup_thresholds {
>>  	struct mem_cgroup_threshold_ary *spare;
>>  };
>>  
>> +struct memcg_shrinker_map {
>> +	struct rcu_head rcu;
>> +	unsigned long map[0];
>> +};
>> +
> 
> This struct should be defined before struct mem_cgroup_per_node.
> 
> A comment explaining what this map is for and what it maps would be
> really helpful.
> 
>>  enum memcg_kmem_state {
>>  	KMEM_NONE,
>>  	KMEM_ALLOCATED,
>> @@ -1200,6 +1206,8 @@ extern int memcg_nr_cache_ids;
>>  void memcg_get_cache_ids(void);
>>  void memcg_put_cache_ids(void);
>>  
>> +extern int shrinkers_max_nr;
>> +
> 
> memcg_shrinker_id_max?
> 
>>  /*
>>   * Helper macro to loop through all memcg-specific caches. Callers must still
>>   * check if the cache is valid (it is either valid or NULL).
>> @@ -1223,6 +1231,13 @@ static inline int memcg_cache_id(struct mem_cgroup *memcg)
>>  	return memcg ? memcg->kmemcg_id : -1;
>>  }
>>  
>> +extern struct memcg_shrinker_map __rcu *root_shrinkers_map[];
>> +#define SHRINKERS_MAP(memcg, nid)					\
>> +	(memcg == root_mem_cgroup || !memcg ?				\
>> +	 root_shrinkers_map[nid] : memcg->nodeinfo[nid]->shrinkers_map)
>> +
>> +extern int expand_shrinker_maps(int old_id, int id);
>> +
> 
> I'm strongly against using a special map for the root cgroup. I'd prefer
> to disable this optimization for the root cgroup altogether and simply
> iterate over all registered shrinkers when it comes to global reclaim.
> It shouldn't degrade performance as the root cgroup is singular.
> 
>>  #else
>>  #define for_each_memcg_cache_index(_idx)	\
>>  	for (; NULL; )
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index 2959a454a072..562dfb1be9ef 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -305,6 +305,113 @@ EXPORT_SYMBOL(memcg_kmem_enabled_key);
>>  
>>  struct workqueue_struct *memcg_kmem_cache_wq;
>>  
>> +static DECLARE_RWSEM(shrinkers_max_nr_rwsem);
> 
> Why rwsem? AFAIU you want to synchronize between two code paths: when a
> memory cgroup is allocated (or switched online?) to allocate a shrinker
> map for it and in the function growing shrinker maps for all cgroups.
> A mutex should be enough for this.
> 
>> +struct memcg_shrinker_map __rcu *root_shrinkers_map[MAX_NUMNODES] = { 0 };
>> +
>> +static void get_shrinkers_max_nr(void)
>> +{
>> +	down_read(&shrinkers_max_nr_rwsem);
>> +}
>> +
>> +static void put_shrinkers_max_nr(void)
>> +{
>> +	up_read(&shrinkers_max_nr_rwsem);
>> +}
>> +
>> +static void kvfree_map_rcu(struct rcu_head *head)
> 
> free_shrinker_map_rcu
> 
>> +{
>> +	kvfree(container_of(head, struct memcg_shrinker_map, rcu));
>> +}
>> +
>> +static int memcg_expand_maps(struct mem_cgroup *memcg, int nid,
> 
> Bad name: the function reallocates just one map, not many maps; the name
> doesn't indicate that it is about shrinkers; the name is inconsistent
> with alloc_shrinker_maps and free_shrinker_maps. Please fix.
> 
>> +			     int size, int old_size)
>> +{
>> +	struct memcg_shrinker_map *new, *old;
>> +
>> +	lockdep_assert_held(&shrinkers_max_nr_rwsem);
>> +
>> +	new = kvmalloc(sizeof(*new) + size, GFP_KERNEL);
>> +	if (!new)
>> +		return -ENOMEM;
>> +
>> +	/* Set all old bits, clear all new bits */
>> +	memset(new->map, (int)0xff, old_size);
>> +	memset((void *)new->map + old_size, 0, size - old_size);
>> +
>> +	old = rcu_dereference_protected(SHRINKERS_MAP(memcg, nid), true);
>> +
>> +	if (memcg)
>> +		rcu_assign_pointer(memcg->nodeinfo[nid]->shrinkers_map, new);
>> +	else
>> +		rcu_assign_pointer(root_shrinkers_map[nid], new);
>> +
>> +	if (old)
>> +		call_rcu(&old->rcu, kvfree_map_rcu);
>> +
>> +	return 0;
>> +}
>> +
>> +static int alloc_shrinker_maps(struct mem_cgroup *memcg, int nid)
>> +{
>> +	/* Skip allocation, when we're initializing root_mem_cgroup */
>> +	if (!root_mem_cgroup)
>> +		return 0;
>> +
>> +	return memcg_expand_maps(memcg, nid, shrinkers_max_nr/BITS_PER_BYTE, 0);
>> +}
>> +
>> +static void free_shrinker_maps(struct mem_cgroup *memcg,
>> +			       struct mem_cgroup_per_node *pn)
>> +{
>> +	struct memcg_shrinker_map *map;
>> +
>> +	if (memcg == root_mem_cgroup)
>> +		return;
>> +
>> +	/* IDR unhashed long ago, and expand_shrinker_maps can't race with us */
>> +	map = rcu_dereference_protected(pn->shrinkers_map, true);
>> +	kvfree_map_rcu(&map->rcu);
>> +}
>> +
>> +static struct idr mem_cgroup_idr;
>> +
>> +int expand_shrinker_maps(int old_nr, int nr)
>> +{
>> +	int id, size, old_size, node, ret;
>> +	struct mem_cgroup *memcg;
>> +
>> +	old_size = old_nr / BITS_PER_BYTE;
>> +	size = nr / BITS_PER_BYTE;
>> +
>> +	down_write(&shrinkers_max_nr_rwsem);
>> +	for_each_node(node) {
> 
> Iterating over cgroups first, numa nodes second seems like a better idea
> to me. I think you should fold for_each_node in memcg_expand_maps.
> 
>> +		idr_for_each_entry(&mem_cgroup_idr, memcg, id) {
> 
> Iterating over mem_cgroup_idr looks strange. Why don't you use
> for_each_mem_cgroup?
> 
>> +			if (id == 1)
>> +				memcg = NULL;
>> +			ret = memcg_expand_maps(memcg, node, size, old_size);
>> +			if (ret)
>> +				goto unlock;
>> +		}
>> +
>> +		/* root_mem_cgroup is not initialized yet */
>> +		if (id == 0)
>> +			ret = memcg_expand_maps(NULL, node, size, old_size);
>> +	}
>> +unlock:
>> +	up_write(&shrinkers_max_nr_rwsem);
>> +	return ret;
>> +}
>> +#else /* CONFIG_SLOB */
>> +static void get_shrinkers_max_nr(void) { }
>> +static void put_shrinkers_max_nr(void) { }
>> +
>> +static int alloc_shrinker_maps(struct mem_cgroup *memcg, int nid)
>> +{
>> +	return 0;
>> +}
>> +static void free_shrinker_maps(struct mem_cgroup *memcg,
>> +			       struct mem_cgroup_per_node *pn) { }
>> +
>>  #endif /* !CONFIG_SLOB */
>>  
>>  /**
>> @@ -3002,6 +3109,8 @@ static u64 mem_cgroup_read_u64(struct cgroup_subsys_state *css,
>>  }
>>  
>>  #ifndef CONFIG_SLOB
>> +int shrinkers_max_nr;
>> +
>>  static int memcg_online_kmem(struct mem_cgroup *memcg)
>>  {
>>  	int memcg_id;
>> @@ -4266,7 +4375,10 @@ static DEFINE_IDR(mem_cgroup_idr);
>>  static void mem_cgroup_id_remove(struct mem_cgroup *memcg)
>>  {
>>  	if (memcg->id.id > 0) {
>> +		/* Removing IDR must be visible for expand_shrinker_maps() */
>> +		get_shrinkers_max_nr();
>>  		idr_remove(&mem_cgroup_idr, memcg->id.id);
>> +		put_shrinkers_max_nr();
>>  		memcg->id.id = 0;
>>  	}
>>  }
>> @@ -4333,12 +4445,17 @@ static int alloc_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
>>  	if (!pn->lruvec_stat_cpu)
>>  		goto err_pcpu;
>>  
>> +	if (alloc_shrinker_maps(memcg, node))
>> +		goto err_maps;
>> +
>>  	lruvec_init(&pn->lruvec);
>>  	pn->usage_in_excess = 0;
>>  	pn->on_tree = false;
>>  	pn->memcg = memcg;
>>  	return 0;
>>  
>> +err_maps:
>> +	free_percpu(pn->lruvec_stat_cpu);
>>  err_pcpu:
>>  	memcg->nodeinfo[node] = NULL;
>>  	kfree(pn);
>> @@ -4352,6 +4469,7 @@ static void free_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
>>  	if (!pn)
>>  		return;
>>  
>> +	free_shrinker_maps(memcg, pn);
>>  	free_percpu(pn->lruvec_stat_cpu);
>>  	kfree(pn);
>>  }
>> @@ -4407,13 +4525,18 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
>>  #ifdef CONFIG_CGROUP_WRITEBACK
>>  	INIT_LIST_HEAD(&memcg->cgwb_list);
>>  #endif
>> +
>> +	get_shrinkers_max_nr();
>>  	for_each_node(node)
>> -		if (alloc_mem_cgroup_per_node_info(memcg, node))
>> +		if (alloc_mem_cgroup_per_node_info(memcg, node)) {
>> +			put_shrinkers_max_nr();
>>  			goto fail;
>> +		}
>>  
>>  	memcg->id.id = idr_alloc(&mem_cgroup_idr, memcg,
>>  				 1, MEM_CGROUP_ID_MAX,
>>  				 GFP_KERNEL);
>> +	put_shrinkers_max_nr();
>>  	if (memcg->id.id < 0)
>>  		goto fail;
>>  
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index 4f02fe83537e..f63eb5596c35 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -172,6 +172,22 @@ static DECLARE_RWSEM(shrinker_rwsem);
>>  #if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
>>  static DEFINE_IDR(shrinkers_id_idr);
>>  
>> +static int expand_shrinker_id(int id)
>> +{
>> +	if (likely(id < shrinkers_max_nr))
>> +		return 0;
>> +
>> +	id = shrinkers_max_nr * 2;
>> +	if (id == 0)
>> +		id = BITS_PER_BYTE;
>> +
>> +	if (expand_shrinker_maps(shrinkers_max_nr, id))
>> +		return -ENOMEM;
>> +
>> +	shrinkers_max_nr = id;
>> +	return 0;
>> +}
>> +
> 
> I think this function should live in memcontrol.c and shrinkers_max_nr
> should be private to memcontrol.c.

It can't be private as shrink_slab_memcg() uses this value to get the last bit of bitmap.

>>  static int add_memcg_shrinker(struct shrinker *shrinker)
>>  {
>>  	int id, ret;
>> @@ -180,6 +196,11 @@ static int add_memcg_shrinker(struct shrinker *shrinker)
>>  	ret = id = idr_alloc(&shrinkers_id_idr, shrinker, 0, 0, GFP_KERNEL);
>>  	if (ret < 0)
>>  		goto unlock;
>> +	ret = expand_shrinker_id(id);
>> +	if (ret < 0) {
>> +		idr_remove(&shrinkers_id_idr, id);
>> +		goto unlock;
>> +	}
>>  	shrinker->id = id;
>>  	ret = 0;
>>  unlock:
>>
