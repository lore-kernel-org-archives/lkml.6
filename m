Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AB8JxZoPqMujPUjNz8xFrjODC/XVv4gCr/W4ItycNbepqw4bt506U7T483HucRM2c5xB7Be94KhA
ARC-Seal: i=1; a=rsa-sha256; t=1526395813; cv=none;
        d=google.com; s=arc-20160816;
        b=JDQeWlh56nCUCi5jo+Ot9k1zYTVYv19TGTVD+dHz5Uc7oVooj1NudUxbw7TvAmyANM
         Z2KhGz+VWGkJE3Uv3K7cH9w7B0eFs3JuSEDN140JHiD2vcykV6izbKjSYJ2GKAbt5L+f
         AiwrDAPz8lpK68kKIjoj65gMK6QmO5c2XtnbT7Bw5wAKu5udQrMheMijkFjLyO+GMwdr
         fFG5SUNccAJ9vp+MMVCPr3K4CX8lJXXrymsbXyuma7B3oYLxUWkeDzwwX/kzjJa55Keq
         inRdhx8mOzrCw1cITOsXWqe7Mtk2Hq74u/c1BUtyL1g383nL9+tIF9mLS8h35Dz+9H8V
         Lmtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=3d5NLG9DC29iUpSzXCBQPUWVHIckYUrp89CVpEY4F58=;
        b=lvJk5Njj2MPLga+j526DoleaqGXtbrmghX8E6g7FDzabrufOjjpKn6pvrq1sQBhtjb
         mMHeaSCsiCT/7p3VXMDLDSHqe/8kKrFZlc5ndeBe1hs0K6qCqiYg7eLR1XE8HNVPM7xT
         Uis9fTI/l8ja6e69i5tBJg5ncyJC6DN3cYp1KUd0eTfvs+VckqDpFi7nKegimhBf+Ebg
         r5Th2hLFHVMg7EFUL/YNtb5flKbagdM4Q6+5uQXYdD7WNdd0kK++uzl5woAp4cLVnnSV
         rHvFdpXbW7N8p/zJ34JZG75axvL9yKtS5LUwPEPuXJbnTzuMgluIO2jz9CNPJK7pWxcI
         cK/g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=YfIUWss1;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.0.133 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=YfIUWss1;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.0.133 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Subject: Re: [PATCH v5 11/13] mm: Iterate only over charged shrinkers during
 memcg shrink_slab()
To: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: akpm@linux-foundation.org, shakeelb@google.com, viro@zeniv.linux.org.uk,
 hannes@cmpxchg.org, mhocko@kernel.org, tglx@linutronix.de,
 pombredanne@nexb.com, stummala@codeaurora.org, gregkh@linuxfoundation.org,
 sfr@canb.auug.org.au, guro@fb.com, mka@chromium.org,
 penguin-kernel@I-love.SAKURA.ne.jp, chris@chris-wilson.co.uk,
 longman@redhat.com, minchan@kernel.org, ying.huang@intel.com,
 mgorman@techsingularity.net, jbacik@fb.com, linux@roeck-us.net,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, willy@infradead.org,
 lirongqing@baidu.com, aryabinin@virtuozzo.com
References: <152594582808.22949.8353313986092337675.stgit@localhost.localdomain>
 <152594603565.22949.12428911301395699065.stgit@localhost.localdomain>
 <20180515054445.nhe4zigtelkois4p@esperanza>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <5c0dbd12-8100-61a2-34fd-8878c57195a3@virtuozzo.com>
Date: Tue, 15 May 2018 17:49:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180515054445.nhe4zigtelkois4p@esperanza>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0802CA0023.eurprd08.prod.outlook.com
 (2603:10a6:3:bd::33) To HE1PR0801MB1340.eurprd08.prod.outlook.com
 (2603:10a6:3:3a::8)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1340;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1340;3:Zn9btT+wg+/ssDsnl9harsBlyHJbMWlV7kAXic3WmEhYnveoWU9dtmZtHCaLzMmYVl9nHYMlpVvNoH1AheXxPJBouSpcm/v5Z05ul0QJHpnA5vF4NOPH1zEkzL/nhpn5iVmyxj1vMTXiJJ/S7fSNjB8I5kp/5dMbaxoKz989LV1rww9zet5Nn2QF1xB7ZcapxiGY0Fv5mHp7q2jMiq7+qAjgf+AOr8mYw3FNWAXFMzjUAfzX2rk3DRx9rWUCIZ/7;25:vILlQ119Fn9K3gkzTQkuH1A7XHXNUBEubR6gOTuN8wPhWM8P+XPnzqdGHVZE8SQIvYGdzjyilz1Mn9XKCuLVNmmeg4wCAdZcBrl16ElzPm5ivQ6wBkuven7t0lhJy+ygG5ZADUJV6hb+cMTPtEGYY1pCvfx48TqqCtwg0/ZzGxdVxr5Y3rNAhjJV3GUw5PgebJKc4HBjP6aotulZFNg/fgCJryHmUQmusebmJjwGiwB7ipcsa1ndbxn2+E5WrbWMvgzQUcsyZCeIqYhvh8IqpSLb1j/38mXZCjnc60V+WVAjuK17qySo0yd/GX6BYbgH0qAtzI735qPxmNYoTAgZ0A==;31:tKjLpoZQfZiRTslGj3y1KADxX+cBcWE4GUC+hbj0YMYQXhbRuDp3VJBHqG1O+3a9XPyng/8quRrPUR2MwpObdWSBKbsH3/Qnv0ivFO2330m0+XHSiyCXVR+dpVcT4FYSVQpU+z76JJyicfE/9Jb+mx+d3h+aRwt//Ek2ov+eyp3ot2bPKj1SlZTRIt+TGFP2SA9lf//0MYhz3sS94+5vntddZu+M9QbXE4/Mgz9c7RA=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1340:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1340;20:SyqFbIXEQORZiH6zHcMbUwlnBMGksyBYiDokbMbdSCGbanfiqo0+Z+fJjBuYO2+sKbMTDNpnDrq8Tm5CbeeCOW2yj8ON/6K5i2rd9qUhn0SKiiIvA4YQdenkp2PNFACKBPS4g1HmTVG7+iT/4Qq24Fz9+mnVaB4a/qRXB1xJJjIZ6BHGhhM8y0OeQlM4bHIHtIdhjDAkc5ONAumhSWXgMWrPMsgXHfX12rXsEUdHuc1vlTP6Zf3/R1mAak5yFTOycPHSMAkodkWXQhfNWtfY2/4TryX4flxQeUlC5IRqggsgQjsEKzhnfLcW+mqqPTWzT676CH37gipbmXWWlnzP7wFZ5ZknBuiUSIHPEEPKTm1fYSH5zrsLGVve+24dJwHIPHpVom3qQ1Rnar+rkjIaR46yN4HgYZA39vydyznMQwyWYRTvV+lQjsQTR8yyCMXLx+Zpp+mDV6txKIwctbyc+SYxgpK59oEp/TKB/xa2lNkEkt8YiaV3IQvPYKaMI6LW;4:Io0Ttowx+X75zGSkqnZqeejZ1YXfALNZWQVk3B0XeZOK2cYn08ZD5M+1ldkZZubSnF8QB6YSMEjr/uw8IQF5vv7eNbBMie4t8CrHLepJ1dsgHhmIAwCdxMhOuG3n0RqMTsl0Zw2lB0MpD6KWyN9JTg9fj7c3fYe9APg76/mH6uWR9KZ1xug1dNaoXpAFCW8Dik1bPZ3GS71o4RNd0o3pCP9dAYTUE+qb5tMgzuQKGlnAAa4TEAKI94sgJpiNGLJHoTquySWD8+JKFDF5hPhsIg==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB1340FA2C1F78EE4190864D6ACD930@HE1PR0801MB1340.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:HE1PR0801MB1340;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1340;
X-Forefront-PRVS: 0673F5BE31
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(376002)(346002)(39380400002)(39850400004)(366004)(396003)(189003)(199004)(16576012)(64126003)(6246003)(65806001)(7736002)(107886003)(47776003)(8936002)(6116002)(2906002)(6486002)(8676002)(66066001)(81156014)(81166006)(7416002)(31686004)(3846002)(478600001)(5660300001)(65826007)(36756003)(39060400002)(68736007)(105586002)(4326008)(305945005)(316002)(229853002)(65956001)(53936002)(106356001)(6666003)(58126008)(6916009)(26005)(86362001)(2616005)(77096007)(446003)(11346002)(956004)(50466002)(230700001)(16526019)(486006)(2486003)(97736004)(31696002)(53546011)(59450400001)(52146003)(52116002)(23676004)(476003)(25786009)(76176011)(386003)(309714004);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1340;H:[172.16.25.5];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzNDA7MjM6S0dKdUtjajJTd1l0WldoTDJoUGVUaVVO?=
 =?utf-8?B?NmdRS0NXUWVzZEpWdmdINTdZeG0xTTd2SklTMnAwcEp4ajNPNGl1TXljOUhZ?=
 =?utf-8?B?YmgxVnVvK2NxUWFuV3BLOGFaZjJXenJibWJjVWd2MFJFNm96Z1UrTWRhako0?=
 =?utf-8?B?S1BkdmExOFdybGthZE1RN09sMWJlVEpEWWlzV2lWTlREbUwwcWc2RjFPTDd2?=
 =?utf-8?B?RmZIby9XV3JzazB5Z3cwVGRQemZkZzNMZ0tSMDlqUWVEV2R6bDNxekxiY2Iz?=
 =?utf-8?B?cDJodEpkWkVTT0NmYlJZOTE5OGl0ZjVUY1pWUTdQWGxiZU0yMHZmR1UzckQ2?=
 =?utf-8?B?bUM1VjN3NFpGT3VKcFFhU2RtTGEzS2YybE1ZbU5rTGN3MWNzQloyUHBQY2ZG?=
 =?utf-8?B?R3l2aU5UMDFHSUo2WVczZC9PV1ZQRC9oSGlscFJLdWU0SzVZNHRPR3dMK3dW?=
 =?utf-8?B?ZDZLWEhWSmhlQnJCZHRJN0d1RCtqQW1jUDdlUzYxWDFKTktGanBzazl0Y04r?=
 =?utf-8?B?YWlEOTV4WDduYnl0NGRnQ2xMSCtWV3RTUEh3a3UrWUdzeTBtQ0xZZDJJTU1Y?=
 =?utf-8?B?VFlydVZETENaTHNBbkdBMGJ4dUNQckd1UjhmbGJKdWZYQUZ6M3JvZnF4NlFN?=
 =?utf-8?B?eG5LcXBjWnhYZWMxQzJOODZnMk9BcUlzRmp5elZabVA0bS9jQ2NoUjNhV3hM?=
 =?utf-8?B?SUxCWTVhQnZUdkQwU3ZvQWNUMW9xb2NRSDNpNGtncEtDcXNhQ0t5RzY1RkFM?=
 =?utf-8?B?YUlHQ0N5S1ljNmtIajdydjJWTm1rRTlNa2JNb2NKdW1FMlA3S2UvRm16VGFv?=
 =?utf-8?B?V3M5b1RNMkJadFRvSXV2d0J3QUJjR243ODBzTDQvOEpTd0RTTXRxZWNIdURp?=
 =?utf-8?B?eWxPZ2FXcENRbm9BNzR4U0p2TTVTaVVoTUJVY0Qxem1GTXNMcVdlZHFRT3hz?=
 =?utf-8?B?M1FoNG5tUmEvVDJNQWZsRXE3YXZrMml5VVFyL2UybUx3WlVMUVQ0cm1lVzUr?=
 =?utf-8?B?Umx4K21MWGIxbkRpV2cyM0hsSHpLTm8rQldmdzlHTTdLdEFEWTVoTnhjN3pp?=
 =?utf-8?B?ZUdFNVZ3VVVwZmxsQ0tYWFF0a2JIVTZHeGtHdTdJeGRzZEljVVhZSHdqUWxO?=
 =?utf-8?B?MS96cDY5Q3Y3TmRWRnNBWitRVXQ3YXVMUWVPMXprbGtpNGlBT0VveExKd200?=
 =?utf-8?B?RURUTGlaVjg4bnV3REl5UTNrMHlnbURSNG9yOElPUG5zQnJxTEcvSVB5WFhF?=
 =?utf-8?B?eDVjL2pIcTNrZzErbGoxSzJHWGdFNkpFajdXdE1iM3JhcDA2WVlPTUthSUNO?=
 =?utf-8?B?SlNPaVRncnh4NnhnRCtpSE1rY2xmd0g2aG5hOHJWbmF2QWMweU84Y1k4UGxP?=
 =?utf-8?B?b2F5Q3d3aDd0NDEzcTJxK2lZOStCMFhGVXJhbU5BYTN4ZXoycmswc2RLOEhy?=
 =?utf-8?B?Q1R2SE1heHVHcWlzejdaNUhCQnErTEtITlZJcnB6ZnFCZGR3cWdsVEVTaWNB?=
 =?utf-8?B?M0VQYXRGdEt3SFJKNEY0aEVaei9Ha1lTS0RVVjNKd1IvQlcrZkZJY1BmWk5m?=
 =?utf-8?B?Y3JDUmxDdnVhdWU4QTRVbUJNcXFNTDhJMzIvb2tFbmRPWEhHUzMwMFlyeFNh?=
 =?utf-8?B?blNuTndRcktOZG53SVc3eFg1RXA3N3VrNHBqWDVhSlkwUE4vWTJ0aytteTlH?=
 =?utf-8?B?ZG01ZTBXeVNqMVYwZDl2NFBVVlJoT0drUTBiK2E5WkxXZE4wcHQ1RDdISnJW?=
 =?utf-8?B?K1hOTUZHdFAwVjJvQVRNMDNrK05HbkhOK0p5K2trM0hwc1MwRXMrQlBEVFE4?=
 =?utf-8?B?UnVYaUxNYm5tcjhKZHBRRHBWY0RWNkZSVXBwNW9zUUpVQkoyNloydEVBYkhQ?=
 =?utf-8?B?akQwbFB1Q0hzK2xjWW9aR3JDWDZmams4c2dxMjQyWlhJUWhwaWF6THdSbGJL?=
 =?utf-8?B?czN0WWlIdjZ4dW1jb05qVFRGWlBLZFhzdnJVd24xU3lHeXVnbGhaL1EzNkJy?=
 =?utf-8?B?U0w1TnlNaEwwOS93aEhhR0t2eTdFckt5VXlkdEdZemJ5dENvLzZpdE1paVBI?=
 =?utf-8?Q?m4wf7g=3D?=
X-Microsoft-Antispam-Message-Info: JSNhvvmSGJk1ZSrhdE0HrvqcaS2sU1zUq83xeiAqVuHcBNw+B+rVY46RCCf7bqLrB2wxdqoRuG7xfNWwKsYm+pQrEPtDTGTPN6Z/Rhk771Z+4XgtKbRaGyKoa31ccqru7IMNLzvFgMgjLBzw645m9gXVShZ7dQ5vMjfjdhPmcgXyBSp2N2KRkY1tuwn7Zfoh
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1340;6:7kkW8QWoZlRp0Hb7TwfpTWKfdx2C/mrXoMRbpMwb4oVpo8OtB7th60YS8G/FywQljhDjZpk6Jy1pOIxN54y+HE2Cl6ohI6hWKqwbyI53h5S5ySYBYhoYsNb/ccCN+HNSG+t8ZOHapqed5vTaqB1xx5V2moNyY7vn9h3Mwn/qkJo0ICoIZYQiL+voRJbIA0mZDQE4ttLod1argwkiZG2WY+cP0/QhXAhP5UKLFQUp7gsQrU9mQMPUN6mTyzHKfMmYSh6aXfz+oFBkAgQXf3h+BcEaeITHoInZlzVWDKTV5d2OXIoKqeS9r5OS47rXOsOW/8AzcV/LCr6TJtF6dzhY3WtJtq3Ewy927n7pFHej3sBX9Rdl8CCp0K8xXq9ZCK1vhyMySs5lCoNde3CdiCv0WTuyubYkTmUBvb+S02AWx90lKIx1ByzBY8dIxvGgXyV1ReIKvRn5FMaARPk16Gyf3Q==;5:N1E1sl63rVEFMxwG/HiTzhKjf7wB+yqJHFTbVvIQnQp4XwfdnT/7WR24hw9SiAShC5IUs9B3nHn2bZHeC1wQfF5jX3TJzwkbn+5ql031McUW3/FSDjYQz3whyHZS/GMWpUhTWnC9UE6RR7pUR0SrVTymRnVWsq2mM9XVALwiRS4=;24:reKvZ06tEtlmkKhqGHlq5XEYrOK5RQGmmSPgCR18mH3GLgPkXFt52bvFpTxrQrN0VpP9S1txCYa47KHeSlLKGw/Xln8iuvpRNJlcJ/ZLwEw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1340;7:GrzPTw1qhj+ojyy8XwZ9192JmU2R85UddbRtni12MBSn8ZEBAEjC93cQatWBPreFEjt5jYvR1kZZLcJLSmeIyN9Nft6yAQoz0issEEh2h5myQkBpMP7mSm3SRWxxuwnQtP37r9vbAGgGAN88r67ssupjJnxanIuBoHRGLg4vm950oBASQ4j+illTVHidWo2Gr5t+azcwPGdk/4zMO6Psq/MtfOJbJZB2VO/frykOpxku7F8xDZrZn8M3rKhDena2;20:Bt19nmYAzEPFX8CXkexuU8Ug9K4eJn7b22CSXwNaLrufUlKW4ulVQQuoqKd068iS5F9Ka8dVosdum8CeNRUbxU69ri7+f3wMbmpaDuUw/9CpjnieAm1oaTQnQRtusQq0lKH718j3UduSy0UP/rcAye2iBU71sUZdI6HL4EuhRls=
X-MS-Office365-Filtering-Correlation-Id: 730e2fba-2d48-4f58-cb31-08d5ba7326c6
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2018 14:50:06.8298 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 730e2fba-2d48-4f58-cb31-08d5ba7326c6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1340
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600070396521697862?=
X-GMAIL-MSGID: =?utf-8?q?1600542016517484753?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 15.05.2018 08:44, Vladimir Davydov wrote:
> On Thu, May 10, 2018 at 12:53:55PM +0300, Kirill Tkhai wrote:
>> Using the preparations made in previous patches, in case of memcg
>> shrink, we may avoid shrinkers, which are not set in memcg's shrinkers
>> bitmap. To do that, we separate iterations over memcg-aware and
>> !memcg-aware shrinkers, and memcg-aware shrinkers are chosen
>> via for_each_set_bit() from the bitmap. In case of big nodes,
>> having many isolated environments, this gives significant
>> performance growth. See next patches for the details.
>>
>> Note, that the patch does not respect to empty memcg shrinkers,
>> since we never clear the bitmap bits after we set it once.
>> Their shrinkers will be called again, with no shrinked objects
>> as result. This functionality is provided by next patches.
>>
>> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
>> ---
>>  include/linux/memcontrol.h |    1 +
>>  mm/vmscan.c                |   70 ++++++++++++++++++++++++++++++++++++++------
>>  2 files changed, 62 insertions(+), 9 deletions(-)
>>
>> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
>> index 82f892e77637..436691a66500 100644
>> --- a/include/linux/memcontrol.h
>> +++ b/include/linux/memcontrol.h
>> @@ -760,6 +760,7 @@ void mem_cgroup_split_huge_fixup(struct page *head);
>>  #define MEM_CGROUP_ID_MAX	0
>>  
>>  struct mem_cgroup;
>> +#define root_mem_cgroup NULL
> 
> Let's instead export mem_cgroup_is_root(). In case if MEMCG is disabled
> it will always return false.
> 
>>  
>>  static inline bool mem_cgroup_disabled(void)
>>  {
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index d8a2870710e0..a2e38e05adb5 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -376,6 +376,7 @@ int prealloc_shrinker(struct shrinker *shrinker)
>>  			goto free_deferred;
>>  	}
>>  
>> +	INIT_LIST_HEAD(&shrinker->list);
> 
> IMO this shouldn't be here, see my comment below.
> 
>>  	return 0;
>>  
>>  free_deferred:
>> @@ -547,6 +548,63 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
>>  	return freed;
>>  }
>>  
>> +#ifdef CONFIG_MEMCG_SHRINKER
>> +static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
>> +			struct mem_cgroup *memcg, int priority)
>> +{
>> +	struct memcg_shrinker_map *map;
>> +	unsigned long freed = 0;
>> +	int ret, i;
>> +
>> +	if (!memcg_kmem_enabled() || !mem_cgroup_online(memcg))
>> +		return 0;
>> +
>> +	if (!down_read_trylock(&shrinker_rwsem))
>> +		return 0;
>> +
>> +	/*
>> +	 * 1)Caller passes only alive memcg, so map can't be NULL.
>> +	 * 2)shrinker_rwsem protects from maps expanding.
> 
>             ^^
> Nit: space missing here :-)
> 
>> +	 */
>> +	map = rcu_dereference_protected(MEMCG_SHRINKER_MAP(memcg, nid), true);
>> +	BUG_ON(!map);
>> +
>> +	for_each_set_bit(i, map->map, memcg_shrinker_nr_max) {
>> +		struct shrink_control sc = {
>> +			.gfp_mask = gfp_mask,
>> +			.nid = nid,
>> +			.memcg = memcg,
>> +		};
>> +		struct shrinker *shrinker;
>> +
>> +		shrinker = idr_find(&shrinker_idr, i);
>> +		if (!shrinker) {
>> +			clear_bit(i, map->map);
>> +			continue;
>> +		}
> 
> The shrinker must be memcg aware so please add
> 
>   BUG_ON((shrinker->flags & SHRINKER_MEMCG_AWARE) == 0);
> 
>> +		if (list_empty(&shrinker->list))
>> +			continue;
> 
> I don't like using shrinker->list as an indicator that the shrinker has
> been initialized. IMO if you do need such a check, you should split
> shrinker_idr registration in two steps - allocate a slot in 'prealloc'
> and set the pointer in 'register'. However, can we really encounter an
> unregistered shrinker here? AFAIU a bit can be set in the shrinker map
> only after the corresponding shrinker has been initialized, no?
> 
>> +
>> +		ret = do_shrink_slab(&sc, shrinker, priority);
>> +		freed += ret;
>> +
>> +		if (rwsem_is_contended(&shrinker_rwsem)) {
>> +			freed = freed ? : 1;
>> +			break;
>> +		}
>> +	}
>> +
>> +	up_read(&shrinker_rwsem);
>> +	return freed;
>> +}
>> +#else /* CONFIG_MEMCG_SHRINKER */
>> +static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
>> +			struct mem_cgroup *memcg, int priority)
>> +{
>> +	return 0;
>> +}
>> +#endif /* CONFIG_MEMCG_SHRINKER */
>> +
>>  /**
>>   * shrink_slab - shrink slab caches
>>   * @gfp_mask: allocation context
>> @@ -576,8 +634,8 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
>>  	struct shrinker *shrinker;
>>  	unsigned long freed = 0;
>>  
>> -	if (memcg && (!memcg_kmem_enabled() || !mem_cgroup_online(memcg)))
>> -		return 0;
>> +	if (memcg && memcg != root_mem_cgroup)
> 
> if (!mem_cgroup_is_root(memcg))
> 
>> +		return shrink_slab_memcg(gfp_mask, nid, memcg, priority);
>>  
>>  	if (!down_read_trylock(&shrinker_rwsem))
>>  		goto out;
>> @@ -589,13 +647,7 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
>>  			.memcg = memcg,
>>  		};
>>  
>> -		/*
>> -		 * If kernel memory accounting is disabled, we ignore
>> -		 * SHRINKER_MEMCG_AWARE flag and call all shrinkers
>> -		 * passing NULL for memcg.
>> -		 */
>> -		if (memcg_kmem_enabled() &&
>> -		    !!memcg != !!(shrinker->flags & SHRINKER_MEMCG_AWARE))
>> +		if (!!memcg != !!(shrinker->flags & SHRINKER_MEMCG_AWARE))
>>  			continue;
> 
> I want this check gone. It's easy to achieve, actually - just remove the
> following lines from shrink_node()
> 
> 		if (global_reclaim(sc))
> 			shrink_slab(sc->gfp_mask, pgdat->node_id, NULL,
> 				    sc->priority);

This check is not related to the patchset. Let's don't mix everything
in the single series of patches, because after your last remarks it will
grow at least up to 15 patches. This patchset can't be responsible for
everything.

>>  
>>  		if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
>>
