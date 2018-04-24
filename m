Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AIpwx49UpxRH4TKbTJ8+T3dxKoHomg1m4XzNHif1012hmcL3+yGRK2rqMREqajExMkOxQH8os6NS
ARC-Seal: i=1; a=rsa-sha256; t=1524572703; cv=none;
        d=google.com; s=arc-20160816;
        b=uk1CPml6GVhJNPoON3npx2P75jgnvrhy8jmFGqfbggiZjctI3OKdeDinRF0AwitHYD
         tH1i9CzuISUhIOuWkhsqYxJ6DJq4ziXDenCwAkqlJEWoHyAt+4zsnWOV4afdTcPWpmz5
         y6j+3EeFwpyLltjFDHWeCIO3fjt2b6ykFuJeV05D167LiZos/CcgdTjpvKy+jYZHOJFC
         SKYYTLvcXGadBXeGAECq0GUQkcmFCSzSRttgYlo2AMfuDN11TCINjYJ/9YfYKs7kID8Q
         dTLo5H56JNmKxoX9pXdcU8VkwuIqq+RDgQ7GROPm0hB8cLqEL3vTMLOtdUr193+9rKUo
         bpqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=LVXeBqWTSuI0PI+zURvsy+V4jFsMFNs4oVqKP0uFtYI=;
        b=lIGAKImkLk68kiLTPvJIiuMOvuc2txHsX0rj4cXLp6ZPkSKtU4IRvgo9RcM8mqvZgh
         QgWruo5qHpJBRDJs6C3rW6Hx721Rh1sPyrIdpyyzQY9LCWdoX4yD5kefAfiYTMDABHHd
         E20tB/QgmwALyeeQTLhUuXctM2O7kQ2ca4ZOuUK/UkQZfWRW//N5yPafhjyLrg4UXcx0
         /kgeoCAU9wBwKe2LeABomHYRPmWjCx/OoGwURfWdpHytGXt2zI82cB5gPyFXJv33OkG+
         /+quqVI/lAAqpjxTd0daDyGtMFHwiKvQP5/nV9bG1JdbVcdjhLLM0Ev3BaCaNSicRt+r
         wqlg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=S+h/EBLo;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 40.107.4.125 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=S+h/EBLo;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 40.107.4.125 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
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
 <14ebcccf-3ea8-59f4-d7ea-793aaba632c0@virtuozzo.com>
 <20180424112844.626madzs4cwoz5gh@esperanza>
 <7bf5372d-7d9d-abee-27dd-5044da5ec489@virtuozzo.com>
 <20180424121516.ihn6lewpidc34ayl@esperanza>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <402281e6-6fea-3541-1435-a2f81e705e2b@virtuozzo.com>
Date: Tue, 24 Apr 2018 15:24:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180424121516.ihn6lewpidc34ayl@esperanza>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: PR2P264CA0026.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:101:1::14) To AM5PR0801MB1330.eurprd08.prod.outlook.com
 (2603:10a6:203:1f::8)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1330;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1330;3:kMiH3kOmSxxCksCxpm4ooeECA/DtUd3WTqkpqQCXizyDgkWcFNJRvCu9oXa3fYC8lwH7K16os14ZP5GBCDRr058t6boJneJK7ktYdgFzggOEJOu2SINrlPIpe2V4Nw+sP61SY1S736axGttpmNZF0LnP2guE024hnB45Fbxw2RmR2a0cpzfZFqlFYVI9hjdneImmKhhRSdvpI1WRWrNelM1w80pQyJMNxYkZ3yqLDgDRXh7IlIzDiLItjhwgW1aA;25:YDw1yoNkK6lCaB6sLGCZC4HMSauVch8nann43U7rhzD0nUDMeA9gGk8ydnBVqN+w22Sg/GHNphwWvtsSEY1AkYUDDo4YVB83uG2jbgk8rPrX/GHYzQl9LNy5s3vnD5jde6Yu1v/0+QNqh82+gFyOAaxXd2zYlSaP4QqrxHw0BKnrHv/b3i7Vw/cJzYlaecGv3C+cP6PU3P2MpmbDQ9/6TjlgFudqNyZmbK5jfzjMhevGonm2he3OnBVosGmXcVFnmCRQwsKQXmAYvcoi3+5KlEsRqJQdSrmlBvqF0t9qFvlLFQRg3vKNeAYMsPRW/3VTZlg9QO2pRe7dBdBp4nn0oA==;31:GToNy9//fVNapghGq3WNTtO9xfD8JAIhntey/sMfOCWbmGW15Ro4Rh5uuWSv2YZ3ENGGTmC0RcpWEK8cQ0fglSfGJ/06CMIJRH7k6R/CcRlBBMc/H2iwpLuJstH/cgXUxjoX0t0CK4Zd2OUWAQnlfaTVVpd4A7gDB6JgNGWNP63OrObHCgsGssaCVwcWT5l2YALvLdacvQEJ6FIc0UHpzjvH5i8L1y//fqg5TA/KwO0=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1330:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1330;20:CL8Nfnjn4KLJ3zqMw5qcFc1DqLKWenAgZ7vIKNdLLhrbrq6pUuvIXjsTbZ8ANC13WCrs6HF+if5n+sRlvc7LeZxm/9oUoKCdEwwwkYmtidScWHCMabvdtTAChYAeWMTnfudNh6VeATg0eYc7naFYbzCXnIg3u2clcncvMVq97b4X6qscTvxOb2ywFSPGhsmH/BQ38ICdnnoF2QG0pVmKy4P8ZrWcBwYovr0/kkWMN/bn6bsbVdD5oTIxiQu/4ez7cLF3t6A+2V1TY2tpNS+ah9xErX80miXI+wkD6ItI5EI575VFiSd85VngCCgBj5vn9UUUBbyIrDzRLKUvtvkbt4sImhuwsBYETekCzk80n0dAsnDGiENSaFb9tGudkP7Mijyat5MZ524V2DQlAM+AhXmyrliKvBnuBWhfKlDM8W3iWnIGZ6fQVTvzs2+uMEEyCmLvS56DRh2D7mTk35mrYZnwARnVlV/vo091isxJAcVAJInuWLdxPhd8CuhmGZO2;4:7Qr2oajEhuIevkD8vK/8S64hCPhpOvmCObzbudsjnzzXHP52FFJawXrnpu8Bm85R2wL377vOP6MjZM1j+GStAGcSxHGwlqJzs6vuEnPhe7I/DMnrQOJvn6mgiJbLEHR2gzXmbyUIE27/gVMhYR+XbdJBl3z3R4ROZAWA483Gnu/fSrpvQ5Fedog74vD3De63OoTgB9++ZW0He+6/v5uffq6ChW5NuC7aELEUH0LGz3N3VeLIywLiqcmwupeTotAnwKffIFlX1r1r5+36ZdeMDA==
X-Microsoft-Antispam-PRVS: <AM5PR0801MB133054AAD329D8EDDD561754CD880@AM5PR0801MB1330.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231232)(944501410)(52105095)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:AM5PR0801MB1330;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1330;
X-Forefront-PRVS: 0652EA5565
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39850400004)(346002)(376002)(39380400002)(366004)(396003)(189003)(199004)(52116002)(16526019)(81156014)(52146003)(8936002)(77096007)(97736004)(23676004)(2486003)(36756003)(8676002)(31686004)(6666003)(86362001)(6916009)(106356001)(65826007)(64126003)(76176011)(31696002)(478600001)(50466002)(81166006)(93886005)(25786009)(5660300001)(3846002)(2616005)(6116002)(2906002)(6486002)(59450400001)(386003)(53546011)(7416002)(66066001)(229853002)(47776003)(6246003)(107886003)(65806001)(26005)(65956001)(39060400002)(446003)(68736007)(11346002)(476003)(956004)(105586002)(230700001)(305945005)(53936002)(7736002)(316002)(16576012)(486006)(58126008)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB1330;H:[172.16.25.5];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjEzMzA7MjM6TGpENGlqNFYwa2htc3Y4RmpxbmN6aEs4?=
 =?utf-8?B?bFd3eXZJVDNIYXhFVlZ2SmJwdXdIRDlKRFBSUTRWb1BJaDJvN1pncUhxR0dY?=
 =?utf-8?B?dmFZcmNEeDZkQ0lsbWJyTnkvOS9ZR1paWEZ3amhxMUxZZ0NJQmk2ZGJUS3ph?=
 =?utf-8?B?V1JvbHY4cTdlWjMyL2VVeVZjOTdnS1pLU3RxRlRiN2lGR09nVFY4cWExdnhY?=
 =?utf-8?B?bHpKRXBrNzJTcGh1bFhPMkpwUlZUYWNqM1Vqb0laQUZqVzFVUWJwVmhQN0tC?=
 =?utf-8?B?bFVNRFAyeThkdVU1U2NXWU5sRHY5SVJ3WWt2V3hWTmw5Wi81cUhnOURTQkhk?=
 =?utf-8?B?RjBlMm5sc21nRG1udnMyckZsWjh6UWVNQy9HdHl4WU9jdmZhK25pWDBuZ3I0?=
 =?utf-8?B?QndlcFR5Z2JUM3AzOERzWHF2NWVDbTVhaHRKVUpLSkUyTzlPR2VhL3hsLzFU?=
 =?utf-8?B?RTltQWdNYnhIYXRwZURPVncrNDB0bG52YS9TVWxMR1FFSDZvN0F4Ti9iV2xY?=
 =?utf-8?B?ZG4rNDFVdDE2L2ZYK2o4NkQ4Q1ZBSUNaNnlnRmdGQUJLUlVGZmFsTVNXY3V5?=
 =?utf-8?B?YVovbzZZck0rWnk4R3FCOVlDQ1p4N20rQVVzNE1nRTN6cTIraVViOWxWdi82?=
 =?utf-8?B?ZWU4U1Q1bFh5WjZwTmMxc25KYXJEMDJCZnlGcWFwaWY4ZEh4Q2QrT0l1MWdS?=
 =?utf-8?B?WnQxclNvOFNBTUdQckJkeXdqQ2hrQmtiR01mbURFVW4ydjkvTUFZR1REYllw?=
 =?utf-8?B?UzcyY2lnd3NTUTJhQWV1eHNYV0FDcVpncG5lME4wakEzVklXRnFaQk5DZ2dm?=
 =?utf-8?B?YjAwWlNWMU1pbjU0YzhzdTlWelc0TTdrSmhPMHVQMGVVQ1hvcFkvdG5Peklz?=
 =?utf-8?B?ZGpxaXZXMzY0cHZpV1NBSXZWQUxJbzdseVM3dzFUVkt1TkxrS3Y4MVdzSGpP?=
 =?utf-8?B?clNHTVVsYWQwSk5XYnIxV2kvL3c5WVQ2WVFzTnNWSHBwcGFoOExNOGREWHFI?=
 =?utf-8?B?WEk4WkUzcFltVEdCbzJqazR1TmFlMkhYdTZnYmlzczFCSjNTQ0NpZG5LdW1s?=
 =?utf-8?B?UTJWVllwMzg2MTBrQVpjV3gxRmlHOUdhVEtCU2VEbEllenlldmcyQThyUjNm?=
 =?utf-8?B?OTUvNkJ1cUJwSTA3OC9INEpiSDdickhBY2gzMzNKa0RUMmJQYTFCOUZJMlhL?=
 =?utf-8?B?ZCtkT3NBS3BQZWZlZGVzUVc2NkFVT1EzZHRrMUJYR2NQOVowYjBwSnR0OXBr?=
 =?utf-8?B?dm9rRDdzVlc1T2kvWmVZb1o1MXAzZVF6K3IwUW52amc1SEhhUXE4c2MxUnYz?=
 =?utf-8?B?VTkzay9SZm5saTlVQW5mQytibGJqZStmL1BNRW1jZTZDelN1cmNrcWFkaDRl?=
 =?utf-8?B?YUZFZ0JmZmtlc0Q3NWpKeWtGQTIyQUVWWDlGaTNxMloxYVJkN1lhYnZVVStX?=
 =?utf-8?B?bXRGZGFTZk54WEFUVDI0ZnppZXVDdTZNaWRPdWZFdEZVOXEyNWlHc0lDUE5W?=
 =?utf-8?B?TC9uSlg3WEV6YTFlTDBJdnM2U0N4M2hyd29KbjN6RE81VmJlUS9PNVM1N2ZV?=
 =?utf-8?B?RnBMVmJQL3NjOFZaMjJTUW5RQ3VWY1V0SUJzYmp2UEVURE1NTGtub0JJUTZP?=
 =?utf-8?B?Ri9iUUVSTTRXTW1LYmRpbml3dlJBZmpNdFYvNExaSXZ0UXVMaldZNDRnWC8z?=
 =?utf-8?B?b0xhNFVSa0Jvd0cwSkE0djBaalFvYTAvRW5RYzNXWmZVc0hCZ0xUanJZdE1v?=
 =?utf-8?B?VlpUWk5UWHduSU9zeVZ1N0VMT290WE5vMFFpbVJOM0tSb0tGZWhyQ29WS3Iy?=
 =?utf-8?B?cml5TmRoMllQdTZNNFNQdmFIQjFaMjAwRW9UQTl6dEpCS2tYZnF3VU5ZOXZw?=
 =?utf-8?B?RmNDcHA5Wkh3STRBSHdRbC9mdDdtOWhPN25xT01CS2dFUlJyQXRVbWRuUGNn?=
 =?utf-8?B?NE9aR09OSnNpMGdnWlN3RXJZclpuZE1rc1d0U0E0YW42Y3BzVGxRYnN0WG9P?=
 =?utf-8?B?dG02SkIyKzZJVHExbVUyUFpkb1J0Vkh2Zk9xV05CSldpRVYyT0pNd1RTVFBs?=
 =?utf-8?Q?7N1BIg=3D?=
X-Microsoft-Antispam-Message-Info: e4rooTY/arN6I7FR6OPMxcq4WYs4hTfRQogHg3EQRwQQ7Aw6fpbIW8ccuZdgjkEIMd3G6TWSJq6gMgjJKIa0Vq7pzQKrad0bmyS0g9BKe0xWsQy/xoIUZc6IWh3UHPlygpJ/G0lQT01tt9/dTc3pMRKDan8UAocP/lrtLxEJw9ZSsySIJ9Bsp3cGQv962Jlu
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1330;6:M145gzUT2itD9iEbFbNZOgEVQ1x28F0j4nUNyCHQQw04HtF0cCSEZvs5TgJFJULs32cznRFqmkC/YaNU6PR1rGaFcD8iAF5GzfZpIa7WP5VDTlsgEc+GP/355Gn04HDiU6iU/xyg835BhzwEpZi5LE8kDML27MNxO0w2mlegXIFgbQegQ8g8EWTE2pzwjgFpgz9ORV4NZcoca3IzLG6tEAfimbsjCvyn0NxD+jh8eUsHQv1GqJdA2VV3e29DYwUTqmeMIwJdAYgitLIUYAHvwQPI6XuYT+lZlLO1K5Fffa1bu4RmR97tlpwNVRkC3b9I/BrPcFDtV33jBa+eZ02WSc6cinqWcPDdZL+map0x9JBoyDyjy2PncvipYhmWFtNLEtB3cpSweOfvHPcusGJWfgU3eaLecNy0H9tuLDLpEmpfQxtMNvkRKuVOylsMkuyqrGESCn/9pFUOW9cQ0KMREA==;5:X6U68DuX+oL6o3WmfbliPB2YVJ43UvrOMhKSAiclIO4nJykLqtwzNtin1Qgo9EFx6QRqR/kYljky7dZsKwiieckC3o3fY983ataCfnA6zBZamew2CR7qlsAqfvg90DU1J5UMaDAHOCMvfkA7TJAL1Q154Qq4qmFtgwfRyFu7lps=;24:vyF2YHHj3W0OCwK3PoeFqYHjkH5ea7ZgBOKmNvswwL9jk7sZ1khgSBb/i1D4vxEnKyKUkYwNXejkfsx6W7tfHiuK9VM5fFNy/oRfKPe4rQQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1330;7:Gqty9D7zOGoAJ24YZ0vfD2N5DcX0lFRy6bqeiLmwJzhEWw5XQ/kfI3BMf7AB9Ri3yHNcOxskmCUvRhkENqHgn6VKoOEa2mXSwoeAPsJIB/4TS/0TzgkizaIDwtCfXG7p6kn/smbOwJNBuOxJvl2b/FiBbd3Gn8lBhhoreACnkddG7q3XRSp9Q4OKInX387jtm6kwY1VZUzv17Kt5vsbv7UWU+Ye9SUpaphUchRHwu1nbOnNHuZraiJKMvW5OwdAJ;20:T5sSewIrfoE2rwXgru6tBya5+5mAQF1HebquAYcSi8YnhYBqVn6e7zKxo6u69SblZKFyvH2vvGIUqbboNAW/q/OSya149OvhBb+JfZmcCw+qU1nZUCbn/BgRB0/vzW+PJCjjN7gkkeEomy1HUSsQ1A+cqgkZAP87AIesDo8B8V0=
X-MS-Office365-Filtering-Correlation-Id: 27317125-4f3d-4ce8-f817-08d5a9de650a
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2018 12:24:56.2906 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27317125-4f3d-4ce8-f817-08d5a9de650a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1330
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598009310068873507?=
X-GMAIL-MSGID: =?utf-8?q?1598630347170721854?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 24.04.2018 15:15, Vladimir Davydov wrote:
> On Tue, Apr 24, 2018 at 02:38:51PM +0300, Kirill Tkhai wrote:
>> On 24.04.2018 14:28, Vladimir Davydov wrote:
>>> On Mon, Apr 23, 2018 at 01:54:50PM +0300, Kirill Tkhai wrote:
>>>>>> @@ -1200,6 +1206,8 @@ extern int memcg_nr_cache_ids;
>>>>>>  void memcg_get_cache_ids(void);
>>>>>>  void memcg_put_cache_ids(void);
>>>>>>  
>>>>>> +extern int shrinkers_max_nr;
>>>>>> +
>>>>>
>>>>> memcg_shrinker_id_max?
>>>>
>>>> memcg_shrinker_id_max sounds like an includive value, doesn't it?
>>>> While shrinker->id < shrinker_max_nr.
>>>>
>>>> Let's better use memcg_shrinker_nr_max.
>>>
>>> or memcg_nr_shrinker_ids (to match memcg_nr_cache_ids), not sure...
>>>
>>> Come to think of it, this variable is kinda awkward: it is defined in
>>> vmscan.c but declared in memcontrol.h; it is used by vmscan.c for max
>>> shrinker id and by memcontrol.c for shrinker map capacity. Just a raw
>>> idea: what about splitting it in two: one is private to vmscan.c, used
>>> as max id, say we call it shrinker_id_max; the other is defined in
>>> memcontrol.c and is used for shrinker map capacity, say we call it
>>> memcg_shrinker_map_capacity. What do you think?
>>
>> I don't much like a duplication of the single variable...
> 
> Well, it's not really a duplication. For example, shrinker_id_max could
> decrease when a shrinker is unregistered while shrinker_map_capacity can
> only grow exponentially.
> 
>> Are there real problems, if it defined in memcontrol.{c,h} and use in
>> both of the places?
> 
> The code is more difficult to follow when variables are shared like that
> IMHO. I suggest you try it and see how it looks. May be, it will only
> get worse and we'll have to revert to what we have now. Difficult to say
> without seeing the code.
> 
>>  
>>>>>> +int expand_shrinker_maps(int old_nr, int nr)
>>>>>> +{
>>>>>> +	int id, size, old_size, node, ret;
>>>>>> +	struct mem_cgroup *memcg;
>>>>>> +
>>>>>> +	old_size = old_nr / BITS_PER_BYTE;
>>>>>> +	size = nr / BITS_PER_BYTE;
>>>>>> +
>>>>>> +	down_write(&shrinkers_max_nr_rwsem);
>>>>>> +	for_each_node(node) {
>>>>>
>>>>> Iterating over cgroups first, numa nodes second seems like a better idea
>>>>> to me. I think you should fold for_each_node in memcg_expand_maps.
>>>>>
>>>>>> +		idr_for_each_entry(&mem_cgroup_idr, memcg, id) {
>>>>>
>>>>> Iterating over mem_cgroup_idr looks strange. Why don't you use
>>>>> for_each_mem_cgroup?
>>>>
>>>> We want to allocate shrinkers maps in mem_cgroup_css_alloc(), since
>>>> mem_cgroup_css_online() mustn't fail (it's a requirement of currently
>>>> existing design of memcg_cgroup::id).
>>>>
>>>> A new memcg is added to parent's list between two of these calls:
>>>>
>>>> css_create()
>>>>   ss->css_alloc()
>>>>   list_add_tail_rcu(&css->sibling, &parent_css->children)
>>>>   ss->css_online()
>>>>
>>>> for_each_mem_cgroup() does not see allocated, but not linked children.
>>>
>>> Why don't we move shrinker map allocation to css_online then?
>>
>> Because the design of memcg_cgroup::id prohibits mem_cgroup_css_online() to fail.
>> This function can't fail.
> 
> I fail to understand why it is so. Could you please elaborate?

mem_cgroup::id is freed not in mem_cgroup_css_free(), but earlier. It's freed
between mem_cgroup_css_offline() and mem_cgroup_free(), after the last reference
is put.

In case of sometimes we want to free it in mem_cgroup_css_free(), this will
introduce assymmetric in the logic, which makes it more difficult. There is
already a bug, which I fixed in

"memcg: remove memcg_cgroup::id from IDR on mem_cgroup_css_alloc() failure"

new change will make this code completely not-modular and unreadable.
 
>>
>> I don't think it will be good to dive into reworking of this stuff for this patchset,
>> which is really already big. Also, it will be assymmetric to allocate one part of
>> data in css_alloc(), while another data in css_free(). This breaks cgroup design,
>> which specially introduces this two function to differ allocation and onlining.
>> Also, I've just move the allocation to alloc_mem_cgroup_per_node_info() like it was
>> suggested in comments to v1...
> 
> Yeah, but (ab)using mem_cgroup_idr for iterating over all allocated
> memory cgroups looks rather dubious to me...

But we have to iterate over all allocated memory cgroups in any way,
as all of them must have expanded maps. What is the problem?
It's rather simple method, and it faster then for_each_mem_cgroup()
cycle, since it does not have to play with get and put of refcounters.

Kirill
