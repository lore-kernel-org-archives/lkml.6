Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AG47ELswIqJ3W2inpjWjCUUIjq9T8xkVzRsHZgWrv6gMDvakvRao6LtY1GDtQeDorritcXnlCK2M
ARC-Seal: i=1; a=rsa-sha256; t=1521736758; cv=none;
        d=google.com; s=arc-20160816;
        b=EWFs1B3bHyjuCG6MADzMX0ea4sSu3cubxIpzGqGJObbucX5vCFzwiWchB+3lzkW1Re
         QKGDE1HTQTCvaHW/VmGE7ekbhkNOZmy8pi2smE5+PABiceFVlNnWX9dqd1TfAFvIQybk
         3EIiF95C57YMfDKqZitmU8Nyip1XgzZ1uuOJqdGm7UU/mDtEACXNSp5i9wquHjGrATIX
         /TVjJtEWuzB9TwOtlQfiNDiX0w1MJWmGs+hwE7jbyIGnL89OZOqOK7r49iVSlXFU7OAA
         m9xLA09F8s0N2g8pStt2GpYs2/bCpOqokkYlX1NCz0u1ap9lElVfisi17w+1BJLzrlOk
         YbtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=5TYXSwcMgJbhgrkJ4SZd4y8nfZUXINLbeHUedSN6NxM=;
        b=sdZlULXILB06mTtcB2ZFKTNqz5Kq9CNecrvTPF3s3sUAvQS+TAsXGq+aDeXFIT89jW
         PQ2sjVYVPjqNkXO9y2xVoogAUyfpewzdyvcRjAZ2Z+HqFFB/8rAENCLDnZ2wjVdwv5VS
         iawl3XEE+DDN0bTWtJaHLMQaWmAJ1QHtzvvE7VTIczM8uMBlc1t1TzDzxzNu7Ry9Bbsl
         9/bGIl+1FGj6nZY0VY74l2TKDpPQvi6Jwi8y73Rh4Y7sBXKW15pY70gy+I33qnOgGd/O
         EcwmDMgXRdy09gtm+MPA5nSiqMRl3N3rrEQ0yBpOZFzaMlnU3swwxb4//gWghCu170yn
         oCIw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=HDq2+a4/;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 2a01:111:f400:fe02::715 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=HDq2+a4/;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 2a01:111:f400:fe02::715 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: Re: [PATCH 03/10] mm: Assign memcg-aware shrinkers bitmap to memcg
To: Matthew Wilcox <willy@infradead.org>
Cc: viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
 vdavydov.dev@gmail.com, akpm@linux-foundation.org, tglx@linutronix.de,
 pombredanne@nexb.com, stummala@codeaurora.org, gregkh@linuxfoundation.org,
 sfr@canb.auug.org.au, guro@fb.com, mka@chromium.org,
 penguin-kernel@I-love.SAKURA.ne.jp, chris@chris-wilson.co.uk,
 longman@redhat.com, minchan@kernel.org, hillf.zj@alibaba-inc.com,
 ying.huang@intel.com, mgorman@techsingularity.net, shakeelb@google.com,
 jbacik@fb.com, linux@roeck-us.net, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <152163840790.21546.980703278415599202.stgit@localhost.localdomain>
 <152163850081.21546.6969747084834474733.stgit@localhost.localdomain>
 <20180321145625.GA4780@bombadil.infradead.org>
 <eda62454-5788-4f65-c2b5-719d4a98cb2a@virtuozzo.com>
 <20180321152647.GB4780@bombadil.infradead.org>
 <638887a1-35f8-a71d-6e45-4e779eb62dc4@virtuozzo.com>
 <20180321162039.GC4780@bombadil.infradead.org>
 <d738c32f-78fd-7e95-803d-2c48594d14e2@virtuozzo.com>
 <20180321175453.GG4780@bombadil.infradead.org>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <ef34c7c8-0ce7-f427-6743-2cbd8d844298@virtuozzo.com>
Date: Thu, 22 Mar 2018 19:39:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180321175453.GG4780@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR05CA0144.eurprd05.prod.outlook.com
 (2603:10a6:7:28::31) To HE1PR0801MB1337.eurprd08.prod.outlook.com
 (2603:10a6:3:39::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9dd0ffdf-e337-4c51-0871-08d590137087
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1337;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1337;3:CAdjHxkBUhPnJwVYDnTngWbptArnwQTH6HkNT5Xa+vLExKh+oKVK/p++T6L3+rOY9GE5H6JF9E1VRYFEnQ2FtwRbmIywzbEUVtQZI0ZI5hObsYvGhF8iM90ttWP7aJUaCfFuwf+CBHbQ5zyuPoWQn2voQXcub+GjajtO1JAlXQ7E24tli4vF+r2biM8wKwnfdB7krw/SHFeAdlxF+wmdHIMHJBkF127719zUJNLcFz6zLagslNTqk2MEAbEIJ3gR;25:0PSvBG0V+keRTvs3j3kuNg98nqBes3P3TvrLu9H3djaW2hluruU/7107+m1YubIBB63WMbyCUw3iDg5ggxz0wG5/DDa4JoBByhV+14+NB7BOkFhR1oxiOj1kJ/bsmqwGduDIeiryRjORBtK7InPLNeBq8GiGhDCcV2KFKmNymwUecEOuyKQGj2Ts0n3Vi+9QJZBSuG5jb1e0WrDT5iCpoiSnfU1EIi/2DHZApE4IcdHN4eSTAgpqOZwVIIPZ/5dNvggUk/+hIU8bebXQAaB+HgRaPf7wBXL+LsOmSQSV6KfRccqFgXttoVzdl94nM64txjbpFakpr2sEdFZxHJuYqg==;31:mfGWBVPBK2ePMEew80jrC56Ih8w5eqAL9qCbSO4bvuDaS0NlbgIYF9RKCFeaqqSV1zjeDl22/Sp9HCi2I83u/Ff19uPnQ6up9fF8S5QMnBZo7MfhGRaW6XWPEEpESYh5EI06gq7OqJuJlPpCZsFPzQmSSmYR1h+iq0QaitFt57PpvaBydz5pisHQ9r8KbVhZ1Xk2+L2ui8a84yuuFFFRd//7dUXp3+uqMbgeYzbChZU=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1337:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1337;20:Wz6bWMu01qYfDGi6Vk8t1sbybpDbzzneo6FaggyEodPNU3Ow5K+4ICKx9MEHTH1yKQMmfmpVyKwnEuPW/FVojY/OhPTQwKqfZE1MSkF3JQxEskjp5TPMzg/S4OfkyMYe1w1b6R+O+0Hb6Ae3gA9xuBIQEeNY7P47x1379lDKPYHbPrdwzFiC16CiBXoxhPdcbWaoK8h03mWU1r19FBNhaSgVcnCKbcvwInzjAb81UmYjymQi3ugGWD3GNucFOJY0e0Oo9i4YX4rl3HPmgT0s96MfxMzEgA1PpCkrso4CnxmSPBa+52dGSjcxdZcBULrI7hZ6bYgmeYkmns0wByMk3hQegyKKPfISidsQF/9sDVATvAL2XvCsUpqKcrCXeONmQEW3Qgn0S5BjTK5zmDPXuBQwmWnX3NhW51HKwPdyAjxIzrdsfevBxVnAWqtwpu7f9/n2d99UmbqK02rcgRMep2hMt6+drcDOcvePjSD/35f84UiSy/NehOaKh7vt4FWi;4:+SgPVRXwDnZ8ciclWS4+GoeqR80TYEdQL+IotTCDfW4spqMI43e9i5yU0WPZ6p0fdGLyaEAY9a82BNW7j9WcSQkX19X0uBnGtC5ZBARnYumDXxYyAqoATSSweUPKSwvPD6ps48LbGNyf6byoo7Ez3GifQ/nG8UKqVZB4R2M4YX7Jrt0RvnOaMnr/tmUup+Q91BLKHMYhP0TE6Kq0MIAg6Zvd8v+JNgSf0MuBcMCMO46U+rvl+7oAoFVwc4zy3vdPl8MgyCFTHPTx7WuE492Spg==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB1337AEAE45780E639EF20A62CDA90@HE1PR0801MB1337.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231221)(944501327)(52105095)(10201501046)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:HE1PR0801MB1337;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1337;
X-Forefront-PRVS: 0619D53754
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39850400004)(376002)(39380400002)(346002)(396003)(366004)(189003)(199004)(65806001)(58126008)(105586002)(6916009)(65826007)(31686004)(81166006)(6246003)(64126003)(16576012)(77096007)(26005)(31696002)(5660300001)(316002)(36756003)(52116002)(6486002)(50466002)(106356001)(8676002)(68736007)(81156014)(2486003)(59450400001)(55236004)(6666003)(97736004)(76176011)(23676004)(7416002)(229853002)(8936002)(53936002)(7736002)(53546011)(4326008)(25786009)(386003)(93886005)(2906002)(39060400002)(305945005)(86362001)(230700001)(478600001)(52146003)(66066001)(65956001)(3846002)(6116002)(47776003)(186003)(16526019)(446003)(11346002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1337;H:[172.16.25.196];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzc7MjM6dlk2OTJ2c3A2RldWcGU2N1NwVVJQQ2ZZ?=
 =?utf-8?B?MzNPWVo5cmRjTkVReGRBbUk3bjUrRWlMZURZZFgxbHhPbElzY2JheG9PSlhT?=
 =?utf-8?B?Z3B1clNZakhDQmVaMnVsWVNST281UTQ4Q3djTUVFaTA5WDJ6eGF3ZGYwUUZG?=
 =?utf-8?B?QVF5QzFDbk15STBNbEVMVTFMTWFRbGFCTEVQQ0hrdk1vbGdmOTlHcUdNSUwv?=
 =?utf-8?B?V0JpUVUyVmJTWmdQdXZIbzBPNWlGcHBqbnFzM0FVZVY4bHNLSDN6WkdBVjVs?=
 =?utf-8?B?Z1NWUnh6TGZGZExKUUpqL3FjbktNNmIzMXdZK0ZXbUlic1M1UEdrRXZubFhv?=
 =?utf-8?B?elpHSlNISmEvNzlJN000RVM4V1pTVkNpMzcvV0xKQ0h4TXNFNTRFRGpaTjBx?=
 =?utf-8?B?dzF5M2piYlNhajVDQjV2QXdEYnVHSEJlQUxmc014Z1IwRWRuR2pqeFNYZ2VU?=
 =?utf-8?B?aUpBWnRyZVpKRU9GdEIwTVd0VURrZ1RQZEcwK1lFd2VOS0FPbGgvVTRoc01x?=
 =?utf-8?B?a2I3OGM2YWZmYitIZWcrZnN1MElQYi9UMG1pcTd3eVZqaEF0OEFDb042bGZi?=
 =?utf-8?B?TDN4ZFY3WVd5aEhVcGNoaC9OOEREQnJneDVOWG4vTmhFQUdDUDZOVjhJOFJr?=
 =?utf-8?B?b1JCa0FVcFdaMENoVVkvRXo0MCsrRmp4a09oajkrSGFzVk9yblB4ZlQyWFVE?=
 =?utf-8?B?aC9XVDFpWEU0VFdMazVsQ1BWWWx5a0dWK2ZoaG1hREw3ekNJSnVCSG9sc0RB?=
 =?utf-8?B?QjQ1U2tSNUFFOVlIekFyelBSL2RkZ2tUWE1zeFR5L2RKejltSFpUQVR0bjRw?=
 =?utf-8?B?ODR6NnF1QkZpemp0OVp1TlN1VDNVaDZFSk5QazE4cVJUZWxhWVFuTlF4aFZT?=
 =?utf-8?B?VGVCanBncU1FWnl6cFJTTmd2K0tQNnk4eWh5WWlmUzdkOXNUSXhMb2d1aTJx?=
 =?utf-8?B?b1Q2dVFDNTZ5WElmMnNSdUZsdXBTWmdSQTFXajk4QWJBak0zc21PSFNybGlF?=
 =?utf-8?B?TVRraFd4a0drc1BWZzVVMTFha3U1Wlp5RnhpaUxnYWxHbXFXQjFHZGhNcStI?=
 =?utf-8?B?Tk05QzA1MHZ3RmZ6TWd6Z2NxcjZOdWZlU0JkbWhtKzd0blV4WWc5bE5zVS8z?=
 =?utf-8?B?Y3JkQ2RZTmVNYVVXY0JNeGlkTFJpckcvd0Z3cU5TVFFHZlRHdmxkekVUK29Q?=
 =?utf-8?B?VFZjNmZlSXA4QzFKYkw2YkRGQS9qekVZZm9Qbm00SlBJY29LUzZqUHdoNFdK?=
 =?utf-8?B?QklJR0ZJdGVlQjdsNVQ0ampCM0JRU2t2ZzJ6NGN0aG9UMDVGTmxsNEV6NkFx?=
 =?utf-8?B?cjNMZ1dTeHp4TloxLzhYNXJoYmNmSk5PN2tWUFVOT0RoYkErWDlIRTFFVnVP?=
 =?utf-8?B?bElRVkpaUUU2R3hOMG1qYUJjTVJZK2tKdG95dHNRVWk1bVBpMjluOFEwczBo?=
 =?utf-8?B?Qy9XYlBZWS9jdU9DRU5mUDdaMmNwcHJvWW9jQ0VKanpaQTZsbXR2RjVtVGRt?=
 =?utf-8?B?Y2o1U2ZrV2Y0dG91NFJOM2Vtek01dW12TG9Oek9YZjcrcGtCUWVJRldvcGhs?=
 =?utf-8?B?Q21NNGpRbGhOUXNYaTB4TFZYZXF6dnJnVTJWeWp0MkoyUVpzZFdTeVQxdW4v?=
 =?utf-8?B?WEpnaEJteURtOVhJRG9pSzE2aUgycXFvMGduMEd5SlNSNVFFNHV1d0ZLQVNi?=
 =?utf-8?B?RFdBK1BrRTd2WGpsZkNHRHVLSHRhNlc1dks4TFBhdVA0WEtUeWpuWmxOWGV5?=
 =?utf-8?B?NHNwcCtTc3J0dnZYaURNdHJDNWdLK2NRUklWZ0dwMFN2M2oyYlpWbDd2c1lm?=
 =?utf-8?B?RTFCbk51bjNZQXpuU0QyQ2Z3bFRDZXF3OU1nM2tQYmxjYTZvVFlSR2x6RnU5?=
 =?utf-8?B?WEQ1NkpEZUN3bUNnbm96NUlpa3lJSlI1RGNTcWRHU0huRkhvTVNBbGRqWjZW?=
 =?utf-8?B?K0Z4blpVTWNZSkF1ZDAzTlVNRTI0K1g3blVnc21YL2ZyR1hxazF5bUh5YWlp?=
 =?utf-8?Q?gNv/FV9M?=
X-Microsoft-Antispam-Message-Info: NztHgvJn2ITv2wLBMFBZG9OSm2D063jVKOvb/cVUtWgV0quIkhrpQXEkluVwacP4EF9jGoJ1+NmKDVEUD4Wopi2QEigH0LObeeUeJeFNWdg3p811mdJsh4nt2l5doQuw9T4+266cDmcZkK0HyzeBw1rOHQN5gl1Zodg3LZLofcWbgr6JS5c1miEJSuj3w3yO
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1337;6:QvvO56/e8y+XEKQcCRaj/C1kPsNsla7r0VMSJmh94ntvfU90uxbXrYz/fqGjuWORakzt4ZxTLhz/Z1Aboye0M8WFZqhnTKRO2UOs7qIEiEQacxQvzA5RdsZCNb01viY4jGJXYp2CfaH4mFvCx8sJKIvqEHF3FAYaxI+Q8Ezv567G+DR4lmCBVzQo0VYRJ6FMVolmtBfVADOkTAHiLoO+85cYM1DzgxhbkAYLt6m46u2aKpXA/zuQAsR8rWI9s0bKDN5BTl0CghJKoxm2uL6CiWLGV8boujz8RHLMwYuQC0hIlHcloNgq46U4kG8EeLaFPCl4oUJxqzPxJQa8sOzeWUDKCvPPwX9dBBBOkTVC/NU=;5:6tFFh9wFe2CcaBV8IX45GX2Pvpssj8iIEu5EUVKiOC4/58inoK6BC2syAPZxeF0066hZiuX6tBj00rDEc+7IM9Fl5ou6vP9iwjwyWeYDB0faHMuJN1KMWWjMtowQJB2YZExlA1M6AlHlzIYZNAFlQ4HgUGQqKfLyjKGz/LbRgQE=;24:lFibOF8FriTRovOUjLwO0P++GF6EzvyOCW9fsy3NLIphmu3Z+URwFXhOFENWTv7C7yL5L2qlrxHZg3oN2xap4yrNVYxP/Svd7iQRLRogyZE=;7:37RfGijq0OvpM/DLrFmcnkSfGAEVZ2VFwtOe9hjJAlJ1UmlGLSPhuIlqgmGYat2amUCJ1r1Lyaj+T4am8pZ+MalZneSfavTiaJCMYVQtfMw3oRdypx+Kf1kTOQABQ2tgZ/n9B6EpZyR4EV8FF+AIBJjikYBOuYFbxJHRIMRmYMBw/N0+UeICzeoiXNO7LEtviZcuEjbhtcdz195Asl2B1hjgFggZGhG97a1PTwMD4aZQ7cnLchreEsDhqJmWluil
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1337;20:B/EQ9zkXu2I1JWmvDQzfQ2Qf5FAjKzHfNo3xcWOhLML7hmFS1uwRFa+jhEJzzyhFutM/7/BJkvSkgRC31fuvQhW+ZCpeezPw0hQuFl6Fufs0iOdqj5/5AtWEiw0+kxDuhibF2ObjQE6vwl9tOGq/RZkqNO6JwoSkymwW7gKFZbg=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2018 16:39:10.0562 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dd0ffdf-e337-4c51-0871-08d590137087
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1337
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595553622756842955?=
X-GMAIL-MSGID: =?utf-8?q?1595656643185943626?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 21.03.2018 20:54, Matthew Wilcox wrote:
> On Wed, Mar 21, 2018 at 07:42:38PM +0300, Kirill Tkhai wrote:
>> On 21.03.2018 19:20, Matthew Wilcox wrote:
>>>> Sound great, thanks for explaining this. The big problem I see is
>>>> that IDA/IDR add primitives allocate memory, while they will be used
>>>> in the places, where they mustn't fail. There is list_lru_add(), and
>>>> it's called unconditionally in current kernel code. The patchset makes
>>>> the bitmap be populated in this function. So, we can't use IDR there.
>>>
>>> Maybe we can use GFP_NOFAIL here.  They're small allocations, so we're
>>> only asking for single-page allocations to not fail, which shouldn't
>>> put too much strain on the VM.
>>  
>> Oh. I'm not sure about this. Even if each allocation is small, there is
>> theoretically possible a situation, when many lists will want to add first
>> element. list_lru_add() is called from iput() for example.
> 
> I see.  Maybe we could solve this with an IDA_NO_SHRINK flag and an
> ida_resize(ida, max); call.

But what will be the difference to bitmap, if we allocate maximal map anyway?

> You'll also want something like this:
> 
> 
> diff --git a/include/linux/idr.h b/include/linux/idr.h
> index 0f650b90ced0..ee7185354fb2 100644
> --- a/include/linux/idr.h
> +++ b/include/linux/idr.h
> @@ -273,6 +273,22 @@ static inline void ida_init(struct ida *ida)
>  			ida_alloc_range(ida, start, (end) - 1, gfp)
>  #define ida_simple_remove(ida, id)	ida_free(ida, id)
>  
> +int ida_find(struct ida *, unsigned int id);
> +
> +/**
> + * ida_for_each() - Iterate over all allocated IDs.
> + * @ida: IDA handle.
> + * @id: Loop cursor.
> + *
> + * For each iteration of this loop, @id will be set to an allocated ID.
> + * No locks are held across the body of the loop, so you can call ida_free()
> + * if you want or adjust @id to skip IDs or re-process earlier IDs.
> + *
> + * On successful loop exit, @id will be less than 0.
> + */
> +#define ida_for_each(ida, i)			\
> +	for (i = ida_find(ida, 0); i >= 0; i = ida_find(ida, i + 1))
> +
>  /**
>   * ida_get_new - allocate new ID
>   * @ida:	idr handle
> diff --git a/lib/idr.c b/lib/idr.c
> index fab3763e8c2a..ba9fae7eb2f5 100644
> --- a/lib/idr.c
> +++ b/lib/idr.c
> @@ -612,3 +612,54 @@ void ida_free(struct ida *ida, unsigned int id)
>  	spin_unlock_irqrestore(&simple_ida_lock, flags);
>  }
>  EXPORT_SYMBOL(ida_free);
> +
> +/**
> + * ida_find() - Find an allocated ID.
> + * @ida: IDA handle.
> + * @id: Minimum ID to return.
> + *
> + * Context: Any context.
> + * Return: An ID which is at least as large as @id or %-ENOSPC if @id is
> + * higher than any allocated ID.
> + */
> +int ida_find(struct ida *ida, unsigned int id)
> +{
> +	unsigned long flags;
> +	unsigned long index = id / IDA_BITMAP_BITS;
> +	unsigned bit = id % IDA_BITMAP_BITS;
> +	struct ida_bitmap *bitmap;
> +	struct radix_tree_iter iter;
> +	void __rcu **slot;
> +	int ret = -ENOSPC;
> +
> +	spin_lock_irqsave(&simple_ida_lock, flags);
> +advance:
> +	slot = radix_tree_iter_find(&ida->ida_rt, &iter, index);
> +	if (!slot)
> +		goto unlock;
> +	bitmap = rcu_dereference_raw(*slot);
> +	if (radix_tree_exception(bitmap)) {
> +		if (bit < (BITS_PER_LONG - RADIX_TREE_EXCEPTIONAL_SHIFT)) {
> +			unsigned long bits = (unsigned long)bitmap;
> +
> +			bits >>= bit + RADIX_TREE_EXCEPTIONAL_SHIFT;
> +			if (bits) {
> +				bit += __ffs(bits);
> +				goto found;
> +			}
> +		}
> +	} else {
> +		bit = find_next_bit(bitmap->bitmap, IDA_BITMAP_BITS, bit);
> +		if (bit < IDA_BITMAP_BITS)
> +			goto found;
> +	}
> +	bit = 0;
> +	index++;
> +	goto advance;
> +found:
> +	ret = iter.index * IDA_BITMAP_BITS + bit;
> +unlock:
> +	spin_unlock_irqrestore(&simple_ida_lock, flags);
> +	return ret;
> +}
> +EXPORT_SYMBOL(ida_find);
> diff --git a/tools/testing/radix-tree/idr-test.c b/tools/testing/radix-tree/idr-test.c
> index 6c645eb77d42..a9b5a33a4ef3 100644
> --- a/tools/testing/radix-tree/idr-test.c
> +++ b/tools/testing/radix-tree/idr-test.c
> @@ -358,8 +358,12 @@ void ida_check_conv(void)
>  		assert(ida_pre_get(&ida, GFP_KERNEL));
>  		assert(!ida_get_new_above(&ida, i + 1, &id));
>  		assert(id == i + 1);
> +		ida_for_each(&ida, id)
> +			BUG_ON(id != (i + 1));
>  		assert(!ida_get_new_above(&ida, i + BITS_PER_LONG, &id));
>  		assert(id == i + BITS_PER_LONG);
> +		ida_for_each(&ida, id)
> +			BUG_ON((id != (i + 1)) && (id != (i + BITS_PER_LONG)));
>  		ida_remove(&ida, i + 1);
>  		ida_remove(&ida, i + BITS_PER_LONG);
>  		assert(ida_is_empty(&ida));
> @@ -484,7 +488,7 @@ void ida_simple_get_remove_test(void)
>  void ida_checks(void)
>  {
>  	DEFINE_IDA(ida);
> -	int id;
> +	int id, id2;
>  	unsigned long i;
>  
>  	radix_tree_cpu_dead(1);
> @@ -496,8 +500,22 @@ void ida_checks(void)
>  		assert(id == i);
>  	}
>  
> +	id2 = 0;
> +	ida_for_each(&ida, id) {
> +		BUG_ON(id != id2++);
> +	}
> +	BUG_ON(id >= 0);
> +	BUG_ON(id2 != 10000);
> +
>  	ida_remove(&ida, 20);
>  	ida_remove(&ida, 21);
> +	id2 = 0;
> +	ida_for_each(&ida, id) {
> +		if (id != id2++) {
> +			BUG_ON(id != 22 || id2 != 21);
> +			id2 = 23;
> +		}
> +	}
>  	for (i = 0; i < 3; i++) {
>  		assert(ida_pre_get(&ida, GFP_KERNEL));
>  		assert(!ida_get_new(&ida, &id));
> 
