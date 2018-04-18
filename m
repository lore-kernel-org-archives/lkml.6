Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AIpwx4+7UhAGp2HzUOGAyxTq577hsgxiDM1p9sW3oNk2A45PwLolJP1f8GuVEK/MzB9Dl02sHDjw
ARC-Seal: i=1; a=rsa-sha256; t=1524061636; cv=none;
        d=google.com; s=arc-20160816;
        b=I26HU2A2YtE37NAbHmtGfZbcVBxpDjZdWxZDYnQS/FhzEdPMf8jkFphovtvKBPFJv8
         ypIKguPa2m6ljY0NlAioQq9ug7n+rU3EMKRVAAsbkzoNTzGLYKmvXvaGdAyHIjOO4PBJ
         RFYN7wEEUzFosqbH7y/faZEsrTFeK7XixFQHCbQP7Edlu84wBV2yXs2E2ahZTylxTFEB
         zZV1OLxvHHhXgj0V9ZNLo5uH8poG8R4kzPcl5HAOKT+sH1L5plO4AL+JefUvzuUPwisK
         g0wRY0lVQbwYm2BzlRuK11fcA87LxycUDf/bppIFSPBo5xPj5SO+r3U4iW8T0+yGErfO
         6Ktw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=kfAPFRS5NEe++o6IMXC5FcRk3mUuS1/GM7jaLdI+YMk=;
        b=uUOteQGnW2JPnZIxBGczlbG07ryJdu1vJdDlRNghHnUwJi/Uw47TEzF0+KWmQp9Gre
         kUL9k+qAZY+enFLPnWSxB8ftIhzIkba2i6QQOVX64BBkT8C16Q6EsD6BdeEcpjOxAQqV
         cjI5va/ZjSSX2eCpo/Hng8K5KQIiy86eZCQaD9/T7mjUjc5DF6YhCutAnyrKNbdXNqav
         OYEYFkqHDosA50zqfsuwJvB3u8NjqKjlwXszHnOn+LfGkL6Cw15AuUI8O2ab6j3NN2kQ
         nBDZtMSPrkbhu8rsaWFblaKjVVIIO/S6q0KIAxRLbJn3kVmCpcB217qTGXWKow2K3M6r
         j7RA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=ZPNoRt5I;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.1.101 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=ZPNoRt5I;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.1.101 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Subject: Re: [PATCH v2 01/12] mm: Assign id to every memcg-aware shrinker
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: akpm@linux-foundation.org, vdavydov.dev@gmail.com, shakeelb@google.com,
 viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
 tglx@linutronix.de, pombredanne@nexb.com, stummala@codeaurora.org,
 gregkh@linuxfoundation.org, sfr@canb.auug.org.au, guro@fb.com,
 mka@chromium.org, chris@chris-wilson.co.uk, longman@redhat.com,
 minchan@kernel.org, hillf.zj@alibaba-inc.com, ying.huang@intel.com,
 mgorman@techsingularity.net, jbacik@fb.com, linux@roeck-us.net,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, willy@infradead.org,
 lirongqing@baidu.com, aryabinin@virtuozzo.com
References: <152397794111.3456.1281420602140818725.stgit@localhost.localdomain>
 <152399118252.3456.17590357803686895373.stgit@localhost.localdomain>
 <201804182314.IIG86990.MFVJSFQLFOtHOO@I-love.SAKURA.ne.jp>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <b544689c-718c-abda-889c-5ec5eb755854@virtuozzo.com>
Date: Wed, 18 Apr 2018 17:27:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <201804182314.IIG86990.MFVJSFQLFOtHOO@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR02CA0102.eurprd02.prod.outlook.com
 (2603:10a6:7:29::31) To AM5PR0801MB1332.eurprd08.prod.outlook.com
 (2603:10a6:203:1f::10)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1332;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1332;3:aEOLQP3zVZkFTCdWKNRrpR4kj1PjV6p4dv/JB24vcvp2HTXgR8lDxwXwZnd9DwoHH1IbBcOkUp3gM/oXSepHtoCyOSvIxjaQQoQcrg/Z2xVBP7ZCHrGMcQq09oQqNcgZADlIF7z+Y7+1Coj/j+PvDORh5xRIxNKnEP19adA093ojibXkvrR2BTLABMC4cgnNofIayDImolJgepz0+QarjKoKw4uY07jdqcUuJBKc1qSPTCrv7K1rvw/mH02iL2k4;25:8dmqX09zjURO0H9eROodr2GLoqnRdMIRzXNhaV/bcLvWEca3d7uANuc7a6Pi/wjWRAiCtdOQHSyRQ6Nm89tCcrFHUpq890r+n6VX0EEM2l6M9BW/PealKIjp+yilN6kKhCHcm2kqBONs0SyH7i9dMcyyMq0RA2NUTay0ZJNmb5TId/FXJ6PQ2uF0mF27YiR8Q/ZPHyHSqboSseopb1dK2IglVlgX/31TDLSrPIJTfuu9z1RcOoT4XLrs5caCDrU22mvaZcB3Roiig3w0jzgQH5GR/DXAEq8OSaLESULa1DjfZjldH7ESXvI++GYqbwKKLpiT08B50hDuEz6yWQdVKQ==;31:ZtKU4VrQ3fWFqirkoHlHlVSy9ZVgnnLDVE5QaZOAm0PSNihbzrq+LRzZte2X42lT2nVBxGjiKJSqLvUwktI4JlkfMyBsSlOmsmmq8f/8C+zqpkEtdWuuy15Y2PIo3f0xznAI+uJVkxV9qN8xrPXM9ijX9R6FYUZpDztd6uyuSmg9wGpCDvkb5lAQhQuZY+Gt7n8JzmenMdIJ8+u+OQpXYkeRRjSRTBxp26n14X65+mA=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1332:
Authentication-Results: outbound.protection.outlook.com; spf=skipped
 (originating message); dkim=none (message not signed) header.d=none;
 dmarc=none action=none header.from=virtuozzo.com;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1332;20:GEb8oIuhhn+SBfRfQbu3f3jevYlDJ2QEiwyluMjOTcw8Daw40TRlP6IFS5mG/wzQ8vtoWKeK+kN53DFZBLBeoDYVxUnoXX+cMqrcFNh2v/1RAys3kXbcpPpNTuW+s7QCNJ+mu/lf5LO3liNDA5W/b1USEY9dBvWHEP4uKyAOLGWkBJ7MuLBNYjWLANX+FoFT4rsYNmo2kJMWzD5HmsNQMp8jbj4M7LoKJKR1gMrcDJzAUvlyy1IKbpKP5lYzR6f24GpPGSEIpAvn0+pR5AUs1IS09ax84xeSUL1POIstyaT+CvLACSjLbhDDH/OQlGurSUnm5MSB3oZ4I8wQ0H6zTUIIEaFAfKu/vjSN+TCqzj+ybxMljtTTEsG88MazigBcpkn/F6Ct2LA+rr4BYm51TqcOV5tsnRABlgUNFCVE8OW/jguepGjAIKQXeSL4/YUMzpPWWrM2f96n7cTva4crZRTuFHusDlu7TgNOL2sbxh8m/aFSFYYtPFrGpblCJJVG;4:dE4gbaakX2wWdBFDP4vP72egvsilEVM9LrH9ei5k+c9X0X83jVKfPciica06TZzxyO1Qe8EicCd1MKOdgCx4gHzozs6ZYxgR0hB8WLQ0O+jyGHgWyeKMl6F2ICmMsiyp34za2eRY2FYBknDsmZdXaIWbi12vV7opoyKOYEkLPj8cjvSOnxyM36rmCuNNgVjeS/HFFj4wxSyfn+LDZkyJZBL/jFlXP4up3YwBo+BkQwtJizwbljUhlWA170zOWHbGQlvPV1tL8RggZGNRcHf+nw==
X-Microsoft-Antispam-PRVS: <AM5PR0801MB133250BDE99F6555E56F66C7CDB60@AM5PR0801MB1332.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231232)(944501368)(52105095)(3002001)(10201501046)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:AM5PR0801MB1332;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1332;
X-Forefront-PRVS: 06469BCC91
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(366004)(39380400002)(346002)(396003)(39850400004)(376002)(25786009)(230700001)(478600001)(6916009)(106356001)(31686004)(6666003)(6486002)(305945005)(229853002)(7736002)(65826007)(5660300001)(7416002)(50466002)(68736007)(53936002)(81166006)(11346002)(956004)(4326008)(58126008)(2616005)(8676002)(476003)(47776003)(16576012)(66066001)(23676004)(65956001)(52116002)(16526019)(3846002)(64126003)(6246003)(386003)(36756003)(316002)(107886003)(76176011)(52146003)(39060400002)(86362001)(31696002)(77096007)(2906002)(2486003)(26005)(446003)(65806001)(6116002)(53546011)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB1332;H:[172.16.25.5];FPR:;SPF:None;LANG:en;MLV:ovrnspm;PTR:InfoNoRecords;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjEzMzI7MjM6NXowRTcwell1WDNWMlFXc2ttQVNiQWwr?=
 =?utf-8?B?aVd2MndCS0dQUWs0d0crUjlFZVEveVAyZFBkSW9FOEt0ajNJK080V0FxcEFJ?=
 =?utf-8?B?bzhaM0UzT2NnQ0ZBeFpSaERGcWxxUzg4SXRWeTVDS011eG1pLzVrV2hKc1hR?=
 =?utf-8?B?ZFpWUUhOQmNjU2xNNEVsWWdhRjBDV1lIdE1zL3hIQ3MxMURrRG1rQVY5bXZo?=
 =?utf-8?B?TFB1MWI1bTVmUDhQUnRMQ2ltaUdicytHTG9XV2swZVlqTGw1Q1BJeWUrZUx4?=
 =?utf-8?B?cXVCZ1RnNEpCQ1Y0dHNXTVVkNFloUjJYcjlKMDVLemtOT3MzUjY3M3ZJR2Na?=
 =?utf-8?B?RUxveE11L1l2VDRRMzdTRVo5TXNUTjBybmlWc2E3d2pYY1QxNFcyYXNPaHBB?=
 =?utf-8?B?TTQ5b2o1RDFyM2VTS1lwa2xqUE5pUW5ORXhvWXF6WGljS3F1aFRyTXMrMHRj?=
 =?utf-8?B?TVc0Rmhjenpta0xYaWhZYU5rVTlHL3FvSGIwRU1pSC9jMUpWci9HZGZvQ0lG?=
 =?utf-8?B?TjRSVTVlV2loSVZxYTQxbm0yamRSWGZuaUl3dTNQeGM0dTNlSnFEM3NKbStx?=
 =?utf-8?B?UXB3b2Z5bWFBTXhUZ1VyRWo5T2dTa3ZSNHVldk9YbCtoY1UzM1dwWE9iTDFy?=
 =?utf-8?B?SHJEK2VrOFlWTzN4ZkxOUUxvRllRdk9aaTh1OWVKd1BqM2MweEFBczhiUEVB?=
 =?utf-8?B?OERkN0pPVTBHTWNzU3NKNll5MEJuYTU3a2Q5VTFjN3RRWUlEOGZteFVmZ3pu?=
 =?utf-8?B?UmpQaWdJbzZQVkV5ZXhLSjRSMzdmRUVNSHRRVkRnVE41ajk3K3l1M3h3NnhD?=
 =?utf-8?B?Wm8yaTIweUlYTnJQNk5iWXl2WjRhMlBRZ0xGUVllS2RILzZnOVlHTElRcXQr?=
 =?utf-8?B?MXVlbDZNc1dBTldTT1cvRDE1dTdqMU4yT1JRcURzUWg0OUlzVzlTZzNLQ0d6?=
 =?utf-8?B?N21pVDdBMCswS0tOcFZjYnRlMHpHSzJLNmNublpteEhuMWl3OVFvQjJFbllL?=
 =?utf-8?B?aEQ1QkFkZFhNTTJCWUZaNkNkbUlWRHBYbnhHWHlDOHdwVTdOaWtJVzY2TFNp?=
 =?utf-8?B?S3pzVW96M1B3dmQ2cndhd0RlUTF1eGRmakpGcDVwYXF3SjljNG1yQ0J2elRy?=
 =?utf-8?B?Y0xIWXZiK2hhQmxTeUxnSlhFd0dTZzJtbTd6dmJ6S2pPVXBCekxJdW5NOUVQ?=
 =?utf-8?B?ZmRNb0JLcDBGelRzZVBEd2ZabGY0dU53SGxrRzlvN3J6eHh2czRiZ2MvQTRx?=
 =?utf-8?B?NmErZ2kraXIxa1owUWx3aFd1SWp2YVFtU3NTeEtUY0UrVTE2eitIb1lWNUFD?=
 =?utf-8?B?YzYraXZ3UzgwU1JNTHdpVFV5U1JWdEZvTmN4RXhWbFlIdVBIcG5ZOFFUL0s2?=
 =?utf-8?B?V2ZqZld1R2J0amRGL25HSFJEUDBNaXJqODBUTnEvSW4xVk85akZFNG10WGsy?=
 =?utf-8?B?VSszYjB0SHpjWFdxSTFDblpjSjR6cmRxczc5TXRwNktlaVFOU2pkTTFCQW9S?=
 =?utf-8?B?bmtSZUsvMVBONE81aDBEQjRybEo2TDRnaWsvYTVjcVR4TTBYU2xsRjlKcGor?=
 =?utf-8?B?MFhjWHZiRnpVekFPYUZDSEZqc1QxdnNxYm1aUDVBc3ExaENzMjl5Vm5Wd1do?=
 =?utf-8?B?VERpaTBNYmJKNlBDODFXQnhYNjdHWXJIaDBYcTVBQnFBL3VWZkZWZHR3QjR4?=
 =?utf-8?B?S2h2QWpoQkxwQzlkTXIvTlBTdDhBSDJ3QXFpemZXVFRvcVQvZHpCdmtUbG5C?=
 =?utf-8?B?WnBPakdnRmZRSk1Rd1F6cjJnVjJxSW1WWUIyUTNBSXdOeXFwV2MxQ0ZOejl2?=
 =?utf-8?B?ZVJhaGpWNTRBRXdIQ2xQbncwYk1oai84Sk9pNzlmSEpvQThjZz09?=
X-Microsoft-Antispam-Message-Info: wh/IULIC4uiQLUarMAfQbn9JkNfnqgXdTSScNiqFzXYBtflp419UbNq8J9cEfpoRBEKFyQ7rFjdroRA9yOUidTTVPwAM5dfZkUiWeNaLAX8/WKNZ58nJ1j59TtSgOKDUXtSP2Ft897i7GtcBWmE4Sd019zPCo9DWzPBQ9Uj7K3MPionfUh535ERf2ZjwPOO5
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1332;6:VMLB01hB4Nwt7lTBice0OTWwTzr1MJQCX8ODWgWLdhGMiLnddrQGuq/k7XGEd8U3Cq2SIxKpgtTqZ2CuJa16PTrnimp6+jNuG91LXrla61Nd79cz0kkqVvEImVlbIAyABV/k2HUj/ycd+5Cwe3Uzbnm/B88d0PDtJjkVUgPW6kVPvvVkiOtEDvzx9dXhz1X+cBTQtFaiqkEQeqyv7m3MmxVdMLriFUCQrz5pMi20NSQjhGtZDWkAQ/N6XZqoFJrOzWT1ZvJ7UGTSQIvKnq7rVrYba7eJs7J2RneJur1lA8qIXZAKbMNCDAJ+fsZMa/LqQMG99cUMNz3xnZJsyI6lv486Vlfdx1ZsA+o/vFmN5OU/RsBJm0Q6NcQgz2JM78laD81MGk6XFHbxz24dP+IpxHtnmJCqcJUsy1QRGBXTgUBtuqsxiOkdSuV9NWscvgUyeCWrUpocCYAYN7kaIGxpWQ==;5:xzv1O0tyQ9Wn8EyZZOVtJH82qwx5LuOs7Prp0MLzcHR2P6Ep48GT+/QZSy1S+QjgBnSek3vbhPS3JM9aLAEzdKkT9MffMYEVtD4VBJWU9nHAEpolaQKVPXKEig/c3qcd3wJDuSAEolk/LxF+Iq0IZoIdaT1qtUFNJoFuZgoo6tY=;24:/8GVTBaaWIpZRWnjRj2id++R7+jBoO6uyWwRbkRi3MzN0mBD7MmIOODgUpqExdeR9SwamAs8lrptPZZZxdHP5beyuM7p8kRQ0Yrrx9mfuuk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1332;7:tiO7+aXySFm7I35GRxGcp8P7Yr8BcvOnc9MEe4RWSnfaQR6FN2KkoVX3ueRs8bdMr7W3kON4PBgfoQ/ZikhqvUIpKmftGXdh5dzLIQggi4ifew0/TG8IHqTq2K9Lt5IzT48Bok1woFjo6wt1n91uLGhbzqAFiDK/ynHaIGa5ZiPkSFrfeMbdftkV+KHzpAj1uzW1oLv+LwAD/KJNqRYWcWFzkYUZ7nDDsm94BxbFIFX1eDBui0iPm17e7fT730wX;20:UAyq7eKKWL+dY1WUofJpmVOf3O4/cfayFDjzq/cWfIKIms9uIgfYGBXRMUNT5G2bS2J6G0i8bAco4ZizXocW7BwEsJZAsQzXvIiTmIc3scSueZ45g5w1lD93qF5DhGIEh0qYjNtmzSuDLP/ZUDbeQAtN2klJjZdfDUCeKo1xSZM=
X-MS-Office365-Filtering-Correlation-Id: 1efea578-b6b9-419d-e166-08d5a5387a1f
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2018 14:27:11.0938 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1efea578-b6b9-419d-e166-08d5a5387a1f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1332
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598009267479229519?=
X-GMAIL-MSGID: =?utf-8?q?1598094455071500049?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 18.04.2018 17:14, Tetsuo Handa wrote:
> Kirill Tkhai wrote:
>> The patch introduces shrinker::id number, which is used to enumerate
>> memcg-aware shrinkers. The number start from 0, and the code tries
>> to maintain it as small as possible.
>>
>> This will be used as to represent a memcg-aware shrinkers in memcg
>> shrinkers map.
> 
> I'm not reading this thread. But is there reason "id" needs to be managed
> using smallest numbers? Can't we use address of shrinker object as "id"
> (which will be sparse bitmap, and would be managed using linked list for now)?

Yes, it's needed to have the smallest numbers, as next patches introduce
per-memcg bitmap containing ids of shrinkers.

Kirill
