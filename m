Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AB8JxZoNgFKW6A8zDae7MO+XhFhNEx5OVVROIUfkTkvA3c0h1jr8p1rPh3DsU4HrSoTn547zbYtf
ARC-Seal: i=1; a=rsa-sha256; t=1525946041; cv=none;
        d=google.com; s=arc-20160816;
        b=wRiCxLlRZGsF1xlwLy/I7QqFKYpie5t1T5uO0JQWX8f0j60M9LtKzEh39ElQB2nvUf
         hKslgc0UXKD84QSWx1reUCMRZirI1jCgTUAw1x0c/MPrInM3XTCmymP4HRCqFhYJO2dx
         Dh+NXH37vWVWG3uVhUp0bfE69WIg78QvBcAKZjhMQT7WJFTT16nb4T/jWBFPgBYHPSo4
         OrkfzJslRtN8qJtz9ggMP4LUJR7NLSn04eaG/Qz+4UWAddiZHn+rx5MjXTqUdAcFgKYV
         oEaeoy/cB+mBlfFimsGO0utz5O5AY1kgcIxCVYzWzaWnhlIEQSlUbo7qJ/l2pNErwEJJ
         vi0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:to:from:subject:dkim-signature
         :arc-authentication-results;
        bh=H32YWD1cM0yVnGiOjrbNIUiAwtkUBs3L/HxRaNiexuA=;
        b=RHzmVEDb34u9V8hqqzqvMbQ5LgDkYgaLj9Yz0Ov4IrHAxh30qfBVVkKDnhYBuzvhal
         1LQPWlNoParijOAUY67CS4nu7uAOQpmEdXOdKdZZQUYcDCJfpx2Ly6LzXkJo3mQySind
         sfqiqiuqc5PhZUnRRRNbTY8FazqA2S94P4QhZGtHUtBn0+L33rBFC7ip0kfVJ8vGAu7f
         FbNdNvzZiJ98sq5CRmZkESOyRct7HD+7qvR2ZWCAVfBfOI5q0HTe77lnlKYSlaGKLj1k
         Xkkr0ZpEfPhXnDwk6fAv3KCObkytc0EUyPRxdGlL0gU9nxcxaeYkKRuTkaX7LOHYrcic
         mrig==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=Eu3L+Y1s;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.1.105 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=Eu3L+Y1s;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.1.105 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH v5 11/13] mm: Iterate only over charged shrinkers during
 memcg shrink_slab()
From: Kirill Tkhai <ktkhai@virtuozzo.com>
To: akpm@linux-foundation.org, vdavydov.dev@gmail.com, shakeelb@google.com,
 viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
 ktkhai@virtuozzo.com, tglx@linutronix.de, pombredanne@nexb.com,
 stummala@codeaurora.org, gregkh@linuxfoundation.org, sfr@canb.auug.org.au,
 guro@fb.com, mka@chromium.org, penguin-kernel@I-love.SAKURA.ne.jp,
 chris@chris-wilson.co.uk, longman@redhat.com, minchan@kernel.org,
 ying.huang@intel.com, mgorman@techsingularity.net, jbacik@fb.com,
 linux@roeck-us.net, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 willy@infradead.org, lirongqing@baidu.com, aryabinin@virtuozzo.com
Date: Thu, 10 May 2018 12:53:55 +0300
Message-ID: <152594603565.22949.12428911301395699065.stgit@localhost.localdomain>
In-Reply-To: <152594582808.22949.8353313986092337675.stgit@localhost.localdomain>
References: <152594582808.22949.8353313986092337675.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: AM0PR0202CA0011.eurprd02.prod.outlook.com
 (2603:10a6:208:1::24) To VI1PR0801MB1343.eurprd08.prod.outlook.com
 (2603:10a6:800:3b::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1343;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1343;3:NS3TSTt1ZB9jI8NHtEtdGDrWZ1Rhz1eOhOCxXho7DMwhjtaFcs6odn+L3jViQQaqF31zNeKJEndb+e6jI6ib9locRzIVIRSwopbkmh1Stup030wKwPIyh4OksVzujIOYCkh5ZmEpVwjv4B49xORMJWnEvnERsWGfeNzya9GH0IQj3RhmqhpBcjrMKO4svVZNeon9ZuAZmpPvuPnlVII1pq+coTNKJ+ID3bmccUI8s2K7TjDhNBhDCE/T4Aamw7Wx;25:E+8LoXt2A/LZ8IQ4yV85khvYZ/Bj8RYkJXJTf8FHNH10W/6OQLM0hGgg59a0Wj4kRfJJ2uBpvhR3G0l1V8jZBF4jWChrWLzODTVgMakiSPqdwLTUnrfRMyCBk4hyGzinEkAa6cw1JARKZ6L86BR+10eOlUOo83BRP0F6sfr0BQsd+XThWWVX8omHecNdjCPynJxUvj0bJX1xUu2iR1hFahZ/Lm+7h9beUew25I/dUImnDd8hS/E/C1goulWAZpPMP5f9vyzBpFIx42okUS/vIjt689jeH59MQC/qNHMKXQfdjbS0KaXIiGDXIwBzl7tgKB+WmZlTWLaWBYrjkVhUjw==;31:dZ4ymB5Y+9QM5uUB/TxYWDY6uE0KAloG7HBX6vtWfamCU2Y/PRcW0UTVeNId0hKy2A4fDGaDvwiduS294Ee+WE5wmPzqmXGxmWwTmv9F/CNS3vDnp4vlToYQdQeU3u2HWcfkZmk71YbTn/GP0QQjTneNr+AUJ+EAmfS93/BvD+GnbV5gTscMKbRwA2+SxyQ2cfnG966D9QLIA0d0zIy9sN7JJfnDcdu34K7ISGErj0k=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1343:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1343;20:Zgs5QFAABIvQ4c58vqlFP6VtmrInhsE2gYDKrFPDPyTnakpz2a6l1aNh4b7qvJhkOBr4KJK2RFte1eMRmTWwuW1a5Qi7lQyrM3pPWTxM/FMwwwNbt2Q8CAs+yvZbHsQxxT8EMKwbh1vnjOAbD207J5s7Ag8jSi85lrDAgr2ihRVzVXy7kioqpWAZcgCTx3tyFBnnkuiFA7Y0dXoYRs1yir2W/60tq2vnN4RtihjmNROb+uEDMEK7f4uB+4jlTl76hYXoDG+wYXe9os/WLfKJSnt5rp1cH6ZpR0lym1f+OVUAybtRCfpzN+EEB68m+TzYnvDA2Id2zjtWnW0kbKG4FCNcFX6hUBLNYUyKGiiLYv2KlxYxQTdUiqY9u0KBK5Ack6HAwHn4EfqTRR6ZPmK4zP4m+KhGSYS29y60MqcQDK5wEwEGGYpnub3Kl/RXeKhDSPbqspW6BamLEuSNGCVcBvSVCgnBj1r28AtOoBY/PqioY3P8urc06oRRBFG7VjOU;4:UNeClYu+Bk4EctSah3i/RoYuIaHI+QZ2MLH8CM0dxD/pAb8vB0IWXoUWhdhvxPHdhRXR72try6y6Rbpua2jE2hVHAHbs3F95kPZOVkQ4wG4XaUa60uSA2N4rKUPt3zUexef8y5PDylBVD+K6AS7rMXCWBGstKTFlZaYGxOVE1NXoIzvZVM49c4JSOg9SiTB5sKB3mFbT1OHPw5Cmz3YW0MzP5JV69LeZ6VhgU6UVGYSp6EUpIHVwie7xdqwX7vmyFPu/GTaXY4JI2i7VJ5+55A==
X-Microsoft-Antispam-PRVS: <VI1PR0801MB1343E3237A43ED4A249B6F05CD980@VI1PR0801MB1343.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:VI1PR0801MB1343;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1343;
X-Forefront-PRVS: 066898046A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(346002)(366004)(376002)(396003)(39850400004)(39380400002)(189003)(199004)(25786009)(6506007)(5660300001)(103116003)(230700001)(39060400002)(97736004)(476003)(53936002)(486006)(81166006)(47776003)(81156014)(105586002)(106356001)(8936002)(66066001)(956004)(11346002)(55016002)(9686003)(8676002)(68736007)(7696005)(23676004)(61506002)(2486003)(7736002)(52116002)(26005)(305945005)(55236004)(316002)(86362001)(6116002)(3846002)(186003)(16526019)(33896004)(386003)(59450400001)(58126008)(76176011)(6636002)(446003)(7416002)(478600001)(50466002)(2906002)(921003)(1121003)(309714004);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB1343;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjEzNDM7MjM6ZHkzNnN5eGhnczN3K0NDdHZSb0xlRm1M?=
 =?utf-8?B?VnZVWjdBVXBscmFxVkh0RUhZOHY3bWVNMUJtTElRamQ4ZHZsYnU0U2RTVVEx?=
 =?utf-8?B?VG9MQ1NVby9Ld3BkUm9WNUdIUnRGbmtjUUNlV3RuaW93Rk0wdVFUSzVKVStp?=
 =?utf-8?B?Z24zTFlOMjFSMXU0eHRsVWJzbzlFTW5EQTZvSys0azZJTDRrZVAySk9xbkR3?=
 =?utf-8?B?R0pWbnRRSEFsMDNZYmpnaiswcnBnT2RkRFhaUWV1OXRDYi9qM2Nycng4VlZM?=
 =?utf-8?B?UnJ2ZVpSQzBCVmI3SUFEanpaMWFGVE9sQ2luYzFiTENuSEtac1NwZTA2aWtp?=
 =?utf-8?B?a1pkbVJnemsvUDM0OU82WkRHaUJCUDZrSzZDRWo2NzVFUjNpQ1F6QWxxV3NI?=
 =?utf-8?B?L1NIaDlBeVZGd3M4cGZrRXorYkZENEs2VHF5SkFBZGlYellSMjZsQWNlRTFJ?=
 =?utf-8?B?bkszN1B0djd5Y3VGSVd3SnBJOTVKZmFhaHZTNE4zMjk0Ri95SHJXVCt4Vkh4?=
 =?utf-8?B?ZldqVDNFclpmNys3anNrN0dSU0FRRFNtZ3A5TzdBZndKYjZJT0ttSEM3NnpR?=
 =?utf-8?B?VjVOY3VtNyt3K3YrQ0NJL01IZXNxMmc0K05Wby9qdVUzRHltTVpodVNRRmYv?=
 =?utf-8?B?ejJOTS9STW4xMTRzM29RS1U2aXVubk9ob25SdXYyN0tuMzB1TllxVzk4Wk9m?=
 =?utf-8?B?M0orK1VkWXlFeTR0dXJaVU1zbmM4dmpkTXgvV0FCMHFHWUswbyt1MGZ3NlNR?=
 =?utf-8?B?OFZ0N1M2QktrSzZUV3YrNTFFdFFuM2VBTjRTa2d1QTBHYkplQklBeC9rLzA0?=
 =?utf-8?B?WnZrWmxEOUpBenY1Z2xDUUJOSkxhb1J6eUMzdmthc2FmTWltSS9HYUw3WFQ3?=
 =?utf-8?B?YW9FZUFVVjB6emxoWVpMTkx0NzQ2MHc0bVE2b0ZrS3pCUGxLQ1lpaHNCMnJq?=
 =?utf-8?B?dWJNY1Q3VVpTMVdqTlFBZU5MK3U5bW1DSGxWbEduRWtNdndrMzBZZ3NMNUQx?=
 =?utf-8?B?NUJQSVhTYld4MnpIS1BRbzJVTGdrTlNYSHRBcGVuL3pCb2tFSnZUaEMvQk9x?=
 =?utf-8?B?NGVTakVJTUNUM0Z1S3E3MkNEWlFocHdoZUQzRVJjSkhacElTbG8rSllVUnBX?=
 =?utf-8?B?WkRCTmFDQWVzTmttYXE5S05KRWFsclRFNndHdG1manNuZ2ZFdEtPUEpPNk55?=
 =?utf-8?B?NWd5eGdCaE5iYjJPRDFGWjJMMms5dTV6NUd5cEhmMEpjK09tbGlBT2c4bmtp?=
 =?utf-8?B?czlQd3IyMnRSblRVajdJRWh4WGdqMytLY1RnQUgrY0owZkdZdy9vcXJERU1q?=
 =?utf-8?B?eG1KTUpBaXMzNlo1NUlTaDY3OG5JNUhSM0dRMkdHMU9laGxwM1ZJVXBESzFI?=
 =?utf-8?B?V2MwZ2k0cEU3bWMvNUF2WkVhcGRPRVRTNEwrUG1wTGlWMnBwS1FLdzJGMUl3?=
 =?utf-8?B?bGIrQjFRaVVGcUdRaTVVaXJvakNBdHk0S2VUWlViaHhDbHN6UjFWaWNjR2xU?=
 =?utf-8?B?bFd0QTR6bjZzak4zd21HU2lWRWxRdlNOenFhU2VrQ3g5V2VuZGRxZEQ2TTRN?=
 =?utf-8?B?bmNuMGMvTmllNnpZKzhnK2M0czNyS21QdEFRZkR4bVVzSHMwZTUrYTJPcUdG?=
 =?utf-8?B?bDM5RGMxaEJzUXZwY2J0QkRYQllSRk1WekRyV2VBOTloaWMyTjE0aWV1WDFP?=
 =?utf-8?B?UlpSV1E0cTdiWEdETUYyMUs5YnZQOG1WUGtlQTNOM3BHZXlZU0pVNERhMDRw?=
 =?utf-8?B?M2ZndWh5eVNlQWZ3eGl1Z21oTi9RNVZZbjJRTUlvQkNnTnE1cHFuYjdKUExj?=
 =?utf-8?B?elpWUkJVSUEvR0l2dGh1dlZ1V3NsQlBraHBLdkE0b1g2eVdxQT09?=
X-Microsoft-Antispam-Message-Info: chFUdg0onM51jinr/zFMZiCVT6tMHVW2vVAlklcGX3qPDBud6HDyWOzQ2vHbohJ1okKaeok6FhbkNRBGqMtDI8uB0NuiOr/v6Ppt4vO6McXHD5VQqiqG6Vlxy6t2GfvqHog2HKdTNUHuCqAx6tcjKFL81sFno9qVseB9prC5dewzzG1JG5iLTcWDYT4cy+Po
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1343;6:g1jY+hhFceSBc5GBHPqaaZmN+kFBRKerAqVv8PVxG8nClBvm6gBu8E3pG3wJpX++pkwhawLkyyxXfQsEQZv8PMXd6YDiA3MgsF+g3igIb5thTcglZ2T+gR8+zOPbQy1Si3FxiwH51F5enA2awMOPX1DrJUORySjBCIpKoDzeOMUmzfOpiExVxzZwdk3Ej6vMChKmwYXPMRTjXyCvyeHNym3RbjrnTrTgI+6yTb7dQ/vNbUTGh4ga9EwOPStsjEXih4LjpUkqOe4+tlj12ev7i2pdbEmkOtPoVApzOnVrEdH33Gbd5hgtBxu/fl4vgOp8xK4oZP1x14P+F06J6y/HfDuxYZSWfLSrEELZCBn4/1aG0MFaCqoaWf51KG336dfCUSxVZzskJ9a9kxRlPrqMX5c2LAep67tMf+pHu9CRPHjdpuinWxtSwiQaKfKrLH4LFxo+hpK1TnQmi1x5bR+9Sg==;5:cF7faK05+7geMGJmKR5q582yjnuU+CPjMBAhMJ1/pGGs4yxNGR6Sg/J8c4OcLYCF2Crvn7NEapXDOOtLqlTacbCcA1/1ROT/wICk/8Tbtca4vdZfqwRHqk4gHHWezaxgoXVy7XBU3+Ltbu/m7dxWBEISOwqzjXOJIsMTwdD8ZdA=;24:ueB6ZSkpGKmOsDy8kSUvaPFnBxaLWLV2lW/DQP8dut51uuETceG1DgcqCO1lLXQhH+QfyYTQEVjfEw5ewe17USVmHU6msBulkH0akzuU9sI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1343;7:5eZGzmpb42yWJtI1GvtqY0JNfYL1btVZqRlz1bXs3QHp3YHSmljg1k0kwcc0RjzxJnlZpBLvbrB+L1l6Lj8w0TrqNGyFzX/+JWRSINQSPAFCVKinmJKdl3f/67gWe27qP0WS8hSMfLOXyqyYUpm+ONFbEErPv4wNHJ8YrU0Bom0/bUML4HvZXrCI0cdTMo4dhCttAAoqZ+aGL1L2YxPR6w4EfZhX4uuyVQoYQDihT9eyIuANdiiXv7hA3R/muGWN;20:/zwUqcBszfCUPjwiffLy+5Pv3nbVT3aFOjcWeEcbBG6f4M3dt0gZBQDUjbEKGPIUY8ERuEYjqpgTiZjYgf/Y1JJRItZSHJs/q5f35hMVP7ZoiDSzzDzR+nSKOOnHf7r3+t3NzjSDCqZpAvnGAwKHWaNkf53VHvpD7Frwo55zYYI=
X-MS-Office365-Filtering-Correlation-Id: 1ab96571-7986-4264-55c8-08d5b65bf3db
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2018 09:53:57.3559 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ab96571-7986-4264-55c8-08d5b65bf3db
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1343
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600070396521697862?=
X-GMAIL-MSGID: =?utf-8?q?1600070396521697862?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Using the preparations made in previous patches, in case of memcg
shrink, we may avoid shrinkers, which are not set in memcg's shrinkers
bitmap. To do that, we separate iterations over memcg-aware and
!memcg-aware shrinkers, and memcg-aware shrinkers are chosen
via for_each_set_bit() from the bitmap. In case of big nodes,
having many isolated environments, this gives significant
performance growth. See next patches for the details.

Note, that the patch does not respect to empty memcg shrinkers,
since we never clear the bitmap bits after we set it once.
Their shrinkers will be called again, with no shrinked objects
as result. This functionality is provided by next patches.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 include/linux/memcontrol.h |    1 +
 mm/vmscan.c                |   70 ++++++++++++++++++++++++++++++++++++++------
 2 files changed, 62 insertions(+), 9 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 82f892e77637..436691a66500 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -760,6 +760,7 @@ void mem_cgroup_split_huge_fixup(struct page *head);
 #define MEM_CGROUP_ID_MAX	0
 
 struct mem_cgroup;
+#define root_mem_cgroup NULL
 
 static inline bool mem_cgroup_disabled(void)
 {
diff --git a/mm/vmscan.c b/mm/vmscan.c
index d8a2870710e0..a2e38e05adb5 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -376,6 +376,7 @@ int prealloc_shrinker(struct shrinker *shrinker)
 			goto free_deferred;
 	}
 
+	INIT_LIST_HEAD(&shrinker->list);
 	return 0;
 
 free_deferred:
@@ -547,6 +548,63 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 	return freed;
 }
 
+#ifdef CONFIG_MEMCG_SHRINKER
+static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
+			struct mem_cgroup *memcg, int priority)
+{
+	struct memcg_shrinker_map *map;
+	unsigned long freed = 0;
+	int ret, i;
+
+	if (!memcg_kmem_enabled() || !mem_cgroup_online(memcg))
+		return 0;
+
+	if (!down_read_trylock(&shrinker_rwsem))
+		return 0;
+
+	/*
+	 * 1)Caller passes only alive memcg, so map can't be NULL.
+	 * 2)shrinker_rwsem protects from maps expanding.
+	 */
+	map = rcu_dereference_protected(MEMCG_SHRINKER_MAP(memcg, nid), true);
+	BUG_ON(!map);
+
+	for_each_set_bit(i, map->map, memcg_shrinker_nr_max) {
+		struct shrink_control sc = {
+			.gfp_mask = gfp_mask,
+			.nid = nid,
+			.memcg = memcg,
+		};
+		struct shrinker *shrinker;
+
+		shrinker = idr_find(&shrinker_idr, i);
+		if (!shrinker) {
+			clear_bit(i, map->map);
+			continue;
+		}
+		if (list_empty(&shrinker->list))
+			continue;
+
+		ret = do_shrink_slab(&sc, shrinker, priority);
+		freed += ret;
+
+		if (rwsem_is_contended(&shrinker_rwsem)) {
+			freed = freed ? : 1;
+			break;
+		}
+	}
+
+	up_read(&shrinker_rwsem);
+	return freed;
+}
+#else /* CONFIG_MEMCG_SHRINKER */
+static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
+			struct mem_cgroup *memcg, int priority)
+{
+	return 0;
+}
+#endif /* CONFIG_MEMCG_SHRINKER */
+
 /**
  * shrink_slab - shrink slab caches
  * @gfp_mask: allocation context
@@ -576,8 +634,8 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 	struct shrinker *shrinker;
 	unsigned long freed = 0;
 
-	if (memcg && (!memcg_kmem_enabled() || !mem_cgroup_online(memcg)))
-		return 0;
+	if (memcg && memcg != root_mem_cgroup)
+		return shrink_slab_memcg(gfp_mask, nid, memcg, priority);
 
 	if (!down_read_trylock(&shrinker_rwsem))
 		goto out;
@@ -589,13 +647,7 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 			.memcg = memcg,
 		};
 
-		/*
-		 * If kernel memory accounting is disabled, we ignore
-		 * SHRINKER_MEMCG_AWARE flag and call all shrinkers
-		 * passing NULL for memcg.
-		 */
-		if (memcg_kmem_enabled() &&
-		    !!memcg != !!(shrinker->flags & SHRINKER_MEMCG_AWARE))
+		if (!!memcg != !!(shrinker->flags & SHRINKER_MEMCG_AWARE))
 			continue;
 
 		if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
