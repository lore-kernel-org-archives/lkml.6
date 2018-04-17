Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AIpwx4/e8knAqNS1SNMYaDe2gRApS7OKBVz7EEhDZgIWTaqCFfMn5kyKuwkNLJ65JPxw3qFs9W3V
ARC-Seal: i=1; a=rsa-sha256; t=1523980490; cv=none;
        d=google.com; s=arc-20160816;
        b=H8zwdbuigwEmp1EJlPF1QEfs2LTUMsXA2sWudweo8M+qw27LeFjud1qr58Zfio2NzD
         C830J8tafhYpiXcwMGfpdegnYC0XXktIARDhjAwGaJaPMHzsjahluHug3mTUV5lhpILq
         Yal3/PSBNXjCUOEpErQcdXuIao2j5oPqNnD9wFChC17Sd7MtyRMsdQ8p2xlxJ1TiYcki
         NASxdrAeT89XUfdsi8nR/fEjsMJcR6zJt2ChUGlHtuzOVA6UrO4eFqiWi/HRW9xIK6Zq
         /SxaZAb2A8zNWuXA4eO5U8HGpFt9rfFq9PR2jXqZfLHyNqG6LiZ8fXnRiWZNt1utVY6U
         EPQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:to:from:subject:dkim-signature
         :arc-authentication-results;
        bh=T23pHpzFAqmpGtriSooQUB0XSLIGqwFm3kInxR1XOyo=;
        b=eI8aWmoM3bp27y5dh0fSP4xhzYpLmzqLUFIp97CqnPkDindA0OUbEwu3K8pIHR8L5o
         +2Vs/PwtRdSMKKo8lZdyGvTtFE+8RC1KNHSuOH36uWPZU0t1em2qQdMdRN/2PJ5jtJ0z
         mat+f3Ug85/v0k5ltnDmjVjVG2YpdIO6+kQnNjpLo2vX4jy3Em/0V9TMClhPqru/bDWb
         pJ/zKlwogth2ity+Q4sV/vO8wVbRZTCVYphugK2uZ/9mzmGsbJ1Hwzw/HFgZekEFeiiU
         m8+34pvOn4Kx+5uB6HMLfWZiSlXFyqYMRyLP9nKjN7RhnU5AoNudIyJ4NK1XejbdU5F7
         wNSQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=JJjx7pqj;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.2.136 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=JJjx7pqj;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.2.136 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH v2 10/12] mm: Iterate only over charged shrinkers during
 memcg shrink_slab()
From: Kirill Tkhai <ktkhai@virtuozzo.com>
To: akpm@linux-foundation.org, vdavydov.dev@gmail.com, shakeelb@google.com,
 viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
 ktkhai@virtuozzo.com, tglx@linutronix.de, pombredanne@nexb.com,
 stummala@codeaurora.org, gregkh@linuxfoundation.org, sfr@canb.auug.org.au,
 guro@fb.com, mka@chromium.org, penguin-kernel@I-love.SAKURA.ne.jp,
 chris@chris-wilson.co.uk, longman@redhat.com, minchan@kernel.org,
 hillf.zj@alibaba-inc.com, ying.huang@intel.com, mgorman@techsingularity.net,
 jbacik@fb.com, linux@roeck-us.net, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, willy@infradead.org, lirongqing@baidu.com,
 aryabinin@virtuozzo.com
Date: Tue, 17 Apr 2018 21:54:34 +0300
Message-ID: <152399127400.3456.6644633244163904030.stgit@localhost.localdomain>
In-Reply-To: <152397794111.3456.1281420602140818725.stgit@localhost.localdomain>
References: <152397794111.3456.1281420602140818725.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0902CA0028.eurprd09.prod.outlook.com
 (2603:10a6:7:15::17) To AM5PR0801MB1330.eurprd08.prod.outlook.com
 (2603:10a6:203:1f::8)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1330;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1330;3:htbKiyQkBoaqr6dcq/G8d3RpinnApEih0zvrtRNLvMJZu4iMA3hch7dfK6N2QsSJGZVtxHYEBzu+mtApRgp9fuMldOjsQhfkJ16GveQmF4a9l/daqFRazioru+3+KCa0Io+TQiRw9ANwjwC8oALFMdYg5RRmz/ukzURPj3hIaD5q57OJY3w9f0YkDuzWB77N1aaHF8xTuYl87u87oxUgPA+cMm87lQzKco63cIaWM/CuMuzgvG/r4rqckSyYjdym;25:t5ZsikaWqp4GFjrd5h5ETcW2SgwBvDSLhzqgbibXnpdUC3NhJEdxp7E3FGG2NvAhKQ4ikgPGWC8/8TA2g+/OT84W20c7Hta0QFLESGJMm5uAVHdmQyYSNrSnW/qQvAL2ay8AiYV3RDZzqeP9k8rT+eEMZJfvViFpVt1r+nj6c9dkGqmREyb2ovi6itz6E2f0NoHDaNkJnxjKWZ5tY7N/MYb9HLhtbvd5rWCVb6K6NbKYmHGCyFOvKBnG1NHy80yGGZPImb2T9HwCeRpxV3rIkriCnhe8cNqzjIkWsh7rrQV2JB9lFjq9cofaZfCVJ9wxzGLWoGrtHCBhnKSD/kQZFw==;31:i8C9JXuwMyKLLb1UtxDeMeTDHDLzri/f6PF60Lc6zR2SIYZ8yLFxlydQLBGE2ls2nI2VwGZypBcovGMqG7CkkKijqwmTNs3gvITtixGLViiuq4h8wYQZBFDWbOrmgqWgMx5lLVhn7WON4EIudiaMbsq2MwsUuLJK7KJxAetaCdIedDd6MHOXjSk9kF/Qe7nA/23A13Vd6iyRpL0BP8e0Ajlb/hMiwdh0/OgqPGyTO+8=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1330:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1330;20:U0omdG0PtZBTUWIMKbPBuNU3RRptxMi5EHkqGSqy98HL1kkyz8P0vx4oCHvy96owUU2i9n/QPh2PlilfmEC9D0a0VK95ynnGtSUclsxPGK0UMXGqgaglbpeRcFUCQ87HIJJyAg5T9Ty5YpynXcMFBXh/5BZdOp2QfnbiOE4/9ebgr/61ge9etgCMeN3/cg2CJdPsNubvtAxKvbr51FOG6NPrtJKAEXxZwMon1F+cfUOabPc2bgOsEYYJEMmcVUzxLt6IITmLKJfJ+oIfLroNcA9baI+ph2/5BS6uSbkOEpT9SH8ML1IjqWax8QtzN5MbFMWaJzPf6hPPZxPSot1XfRQYmyLc7IYOHApV/rTaLWHTtlvKqmut5gFXmJ2k49dW4bjXcJKT9VQRegz0qs7PQIfjDgU7ftQ3zzzwthSDjmr8I7XjE2eKVy+SwGHISjiGeXfMwVCRX0WD1HUBAJzDtj4OgVMslyTEjmydMjOFypmDna7WsM8E/4BKalqQXKpS;4:wpW/BqmwS8QAi3A7SeUKsWwC8XC0/HSh48wnuZJ+/G7c3MLVpnXHSmzk51k9gTlcuPe6+1WiuPxQMny4RQh6c84ctWND/Odjyt6ED03exGAGDMTTQ1KFAw65qL4aU4gISrua3S3OXlNemrJ3XW8vgQEZauribYgKpXt35LvqArUWTMrDgct90QdFVeNFGM5JVyLxpoylA/eTFqZSwiRrgwFPxf2PUT5pjDSm4PexDN02npndXOHIfjiJdZaAjcC0uvQD6zo69ZO2ab32/4SjHw==
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1330E36E30E4AF7E0A706DC5CDB70@AM5PR0801MB1330.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231232)(944501327)(52105095)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:AM5PR0801MB1330;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1330;
X-Forefront-PRVS: 0645BEB7AA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(376002)(39380400002)(39850400004)(346002)(396003)(366004)(189003)(199004)(230700001)(68736007)(7416002)(186003)(55236004)(305945005)(16526019)(486006)(53936002)(86362001)(39060400002)(5660300001)(6666003)(6636002)(6116002)(446003)(316002)(33896004)(386003)(59450400001)(3846002)(2906002)(956004)(7696005)(52116002)(476003)(2486003)(11346002)(7736002)(26005)(6506007)(23676004)(58126008)(76176011)(61506002)(81166006)(478600001)(81156014)(8676002)(106356001)(105586002)(47776003)(25786009)(66066001)(97736004)(103116003)(55016002)(9686003)(50466002)(8936002)(921003)(1121003)(309714004);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB1330;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjEzMzA7MjM6U0tISStyd0xMaXYxQzd1Y2NRdXI0VEY1?=
 =?utf-8?B?QUlKSTJsemVFdys4OXg3aXBObzdDL2VMNE0zTU9nd1NNK3ZwYUtJeTZnb2E0?=
 =?utf-8?B?b3dnaDQzUFJSbjBiTStLaGdMZ2FoZ28rRUVoN0trcXppRnAxQVNxZDJrUWVp?=
 =?utf-8?B?WWo4N2lpcGNob3ROUWFWSi8wK0l1VEZmUHdERU5ZUEZ5b0t2ckRwMTdWcTZU?=
 =?utf-8?B?cTBFOGhKRjB6WitVaEk3ZHpIakorZE1rSWVZZVRURjgxYUszVno5eU9VelVN?=
 =?utf-8?B?cEpTWWlCWm51MGllcS9NZ3lTNVIzWm9Ddkt3S0pkTkV1U3NRWTFtMVBRdk5x?=
 =?utf-8?B?S0V5UGlzcE9ScWJBNXgvWTJhNzZQZDlzZUtLQ0VhSFo2MnFFU2NOVURZSXJs?=
 =?utf-8?B?Y2xCTk9ZeUtGWFErL0RwRWFSOWFDdmtDc1kveWhFYjY3VFY5c0w1NWI0QUti?=
 =?utf-8?B?cGxTVEhvMVJzem10ZmszdktUY2tCN3lEUFVmQWZ1bmszV01sVW9Jeis2SnI3?=
 =?utf-8?B?YStZVE55akxCR2paNXY3NHNScGJyK0JuYVNMcDljMFpBWG10RkNMdXh2eW5o?=
 =?utf-8?B?ZXJRcVkwbVFTVE8zUGNvcHJKNm9uRllxUnpuMFJvaXpyTGt5MUdRK01iMjdj?=
 =?utf-8?B?MnE0bzVGVjliZnpJNWt5WC8xVDRNTEpmZWJpWVVJenp2RkJIQmZIY3RkMmNK?=
 =?utf-8?B?NlB6MURIdm5FY2JjQTZRN2J3aEExcjBORTh0ZmpzMmpJOFVFSHUwYkpUcnla?=
 =?utf-8?B?RXZJRUM4M2RheWpYRmx4bDhTeVY5Sm9YekRnU1lSWWlCeFgyUnB0WWMzditX?=
 =?utf-8?B?U0hrVk5lVDJ3SG9KSEVKbjFUM1RpT1dYbHlGcHR4ZnZ1c1NxMmRwL3ZHSURW?=
 =?utf-8?B?aTYzYlh5WXlVVUZwMG5NdHJUbkxmcDIwY0VtOHNaeXA3UTU4YUExVDk1czFJ?=
 =?utf-8?B?b1M1OHVCeW03cGlwbmdveVo3WGFsMEhSQVRFSFRWNm5JOVNDSWJmZm5oSlhW?=
 =?utf-8?B?QzJWYWtMTHRIWll1MWwxeXpFWnZrWS9Uc2NZS2k4eXEvRC80OEdsQTA0T2Nh?=
 =?utf-8?B?a1JMVDVUR3FUVWxWWEE2aG50eDdWaGFLY0dQZUppNjg0SDA2aVFxN1dzem9m?=
 =?utf-8?B?Wm04bGxkeFU4eGsyVTFnbVZHZ3A3SFdkTUx1ZFRDUDA1VXNiY2w2OWRjeEZ6?=
 =?utf-8?B?akMxcWp5KzJyQnlmeXFUd1BPNFNxVWhJbXFXNkRFdm9uOFhYYkQvaHkvcVUz?=
 =?utf-8?B?cmVLUXJTaU5RUDR3TkZESHhQS2djTk0vTVRFOHUyTzJha3VkeUwwaFJwM0Vx?=
 =?utf-8?B?ckhGZnZGUUtSYVhmMTJLa3BDeUxiWG9IZnVwbEhYNWdSRVpjNVVUYTlxYnli?=
 =?utf-8?B?UGdmRmF4TzlHaEJ3eU5LMkV0NnhqbFBad0Q5SWpMZ1lKcERXL2hsaVJYYzRL?=
 =?utf-8?B?STF0Z1hFUzRxd1h5MzBVUVY1Z2ZHNXd6WExndGhLTU9uZnM5NGIwcVRGcU83?=
 =?utf-8?B?YVpkUE5FN1MyVjYyZ1BPZ3JTRytOZkc2Mmp4V2cxcEl4ZUJudDdlTGdJL2VK?=
 =?utf-8?B?OEpGd3BmQU11NmUwQjBnaGI1U2hydndmNCtHalpiRU4yQzI2Q3pnV2tncktE?=
 =?utf-8?B?b1RtVnVxakE3Q1VOelA0S3pWM2pnd3RVSGVzWE5xbGUySGtsOWtWSXJqV2E2?=
 =?utf-8?B?OVU3MEwwWDRRblo3Y09jTGdOcnJzeWNUdFpDMkR2b09jenkwSmI4L1RLeXd2?=
 =?utf-8?B?RzVwNElBdi9hVGNaLzhWS2tWU3pJdmF3NFhIUVZMS3J0eWFjcDJkWjR3eG5J?=
 =?utf-8?B?NW01SjZISVlBVWZZZHN0MFhLa3A5aVMrQkl6RGErVGtFWW4xSXRwQzdrTzRB?=
 =?utf-8?Q?xmghV6kmkevcw=3D?=
X-Microsoft-Antispam-Message-Info: Qnn3dUZtZtSwFNHkt5ESu4pW/DEirR6ykBVLOU44npS3ehmXPeGODPrwmnS3zqMdH/fpPiXZqRGlqlDKbkMGyUN0WIGLTPyn4FHBGHlHsZ3dGYJj2mNmiUHEEQqhOF6ldbWPjJd3L/Dd1LzCrfykG23IIFTIFoFcTDI00XoGDJdXsn7Z+zIz8h4YwV1j619y
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1330;6:xJkdKvp9gATTcsMONHoAvkm0/092sM4tnr+99nHTxI5wAdvJ6Ovipni21Xj0NE+52wm8etAVI/sD3q2D45Vz1+2mCd2Ui4o84TJpXWaw2dTXVHwitacTu4XMI73d+w7s7FK5JG4PQAEVdXFaD8s893vGES3EG7p747FnkMpnKw49X2nmWc85CkNSh74jZa7ERobhIn17+SzoXk52FzG0cq8sxVvXZr1d+kPtcw5aSht5YYif0647XGmzYNLv2lOxmM/xud6kErBbd22XuUZIdUUn1MvaFIcy9u4+XulAKWXirKd5LqqOR32xtuYe3IhxL8uqfRbAf79srBQe2dUZmsH0uMz5vrpu3D+vpqKwMTmBwCrELVIJguBAxu2Ig/6DOO0pdEd/afaqVsfMY2Jwgv9ILcTyXISM80D/n7GCDiBsf7LGDywfFM5Zm+ZSWzhOG56xP170Q0biVScu52rMhQ==;5:rlp27wMyBJD+lmEHuRXKv8YxLb8nfuNLpA3b4CrvLoo3a5i7wi9a55YtyhsZnt7z6oaCfEkf0CTJ7JX3xHER84Ac3qiXHLfptwWtJJUB+64iKlmiNBkWrd4+QB3XGptPWaz8lKVvSXH+B80Z7LrNOfnVHzO5avOmwpdhm4i+64g=;24:7YJjVj5aDu8K44Znat/ziMo5QHGjBx72ZMe/Hv8DXzWQpyzATI9kexZP8aDZZYUGbr7W0fQbCK8QOvVfNy5jJBpQViJ06XzI1fDE5ymLAss=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1330;7:5oAhtZSoC1sTIpmhCCeGUBLXXEIcz3wH0c0OTDCPlA51wQ7XJq463kxZ5pA8nDdAY0SNEEaklw2rTlUyw/ipcNi4anKND0y+wAsYDUIWXTUCs85+MUFSsy0SsvlRF+33zoGtaDgUR/jnXbe7g3czosfIlTkIbGvpQds3V7uihU0hCfHpspwZKJG4+8LMxDVsrmZFLmJ2mRJjLjxjENkloxZ+AsnNdoAG0m1bLQ4PDoKnT4QjNgSsR+UTqD2o6l3g;20:ODfDarCX7w7r7CYE3e3tLNgQXAms4UNosTYZPAxL9zO3D+tIHgCwe5J5hXK5NUGW3x4x7QZm8xgJLtEkCLh1nI5fyfaIKtNGMJYCWKVs3RekXNYy3qIH8yx8vD6kOospm7fdNzasBdEpxYLZBFOpnPn1mMNUgrpQvJpeBLoJKek=
X-MS-Office365-Filtering-Correlation-Id: dbd95634-c39d-49dd-bc5b-08d5a47b8a65
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2018 15:54:43.5024 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbd95634-c39d-49dd-bc5b-08d5a47b8a65
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1330
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598009366566226885?=
X-GMAIL-MSGID: =?utf-8?q?1598009366566226885?=
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
 mm/vmscan.c |   88 ++++++++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 72 insertions(+), 16 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 34cd1d9b8b22..b81b8a7727b5 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -169,6 +169,20 @@ unsigned long vm_total_pages;
 static LIST_HEAD(shrinker_list);
 static DECLARE_RWSEM(shrinker_rwsem);
 
+static void link_shrinker(struct shrinker *shrinker)
+{
+	down_write(&shrinker_rwsem);
+	list_add_tail(&shrinker->list, &shrinker_list);
+	up_write(&shrinker_rwsem);
+}
+
+static void unlink_shrinker(struct shrinker *shrinker)
+{
+	down_write(&shrinker_rwsem);
+	list_del(&shrinker->list);
+	up_write(&shrinker_rwsem);
+}
+
 #if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
 static DEFINE_IDR(shrinkers_id_idr);
 
@@ -221,11 +235,13 @@ static void del_memcg_shrinker(struct shrinker *shrinker)
 #else /* CONFIG_MEMCG && !CONFIG_SLOB */
 static int add_memcg_shrinker(struct shrinker *shrinker, int nr, va_list args)
 {
+	link_shrinker(shrinker);
 	return 0;
 }
 
 static void del_memcg_shrinker(struct shrinker *shrinker)
 {
+	unlink_shrinker(shrinker);
 }
 #endif /* CONFIG_MEMCG && !CONFIG_SLOB */
 
@@ -382,11 +398,9 @@ int __register_shrinker(struct shrinker *shrinker, int nr, ...)
 		va_end(args);
 		if (ret)
 			goto free_deferred;
-	}
+	} else
+		link_shrinker(shrinker);
 
-	down_write(&shrinker_rwsem);
-	list_add_tail(&shrinker->list, &shrinker_list);
-	up_write(&shrinker_rwsem);
 	return 0;
 
 free_deferred:
@@ -405,9 +419,8 @@ void unregister_shrinker(struct shrinker *shrinker)
 		return;
 	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
 		del_memcg_shrinker(shrinker);
-	down_write(&shrinker_rwsem);
-	list_del(&shrinker->list);
-	up_write(&shrinker_rwsem);
+	else
+		unlink_shrinker(shrinker);
 	kfree(shrinker->nr_deferred);
 	shrinker->nr_deferred = NULL;
 }
@@ -532,6 +545,53 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 	return freed;
 }
 
+#if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
+static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
+				       struct mem_cgroup *memcg,
+				       int priority)
+{
+	struct memcg_shrinker_map *map;
+	unsigned long freed = 0;
+	int ret, i;
+
+	if (!down_read_trylock(&shrinker_rwsem))
+		return 0;
+
+	/*
+	 * 1)Caller passes only alive memcg, so map can't be NULL.
+	 * 2)shrinker_rwsem protects from maps expanding.
+	 */
+	map = rcu_dereference_protected(SHRINKERS_MAP(memcg, nid), true);
+	BUG_ON(!map);
+
+	for_each_set_bit(i, map->map, shrinkers_max_nr) {
+		struct shrink_control sc = {
+			.gfp_mask = gfp_mask,
+			.nid = nid,
+			.memcg = memcg,
+		};
+		struct shrinker *shrinker;
+
+		shrinker = idr_find(&shrinkers_id_idr, i);
+		if (!shrinker) {
+			clear_bit(i, map->map);
+			continue;
+		}
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
+#endif
+
 /**
  * shrink_slab - shrink slab caches
  * @gfp_mask: allocation context
@@ -564,6 +624,11 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 	if (memcg && (!memcg_kmem_enabled() || !mem_cgroup_online(memcg)))
 		return 0;
 
+#if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
+	if (memcg)
+		return shrink_slab_memcg(gfp_mask, nid, memcg, priority);
+#endif
+
 	if (!down_read_trylock(&shrinker_rwsem))
 		goto out;
 
@@ -574,15 +639,6 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 			.memcg = memcg,
 		};
 
-		/*
-		 * If kernel memory accounting is disabled, we ignore
-		 * SHRINKER_MEMCG_AWARE flag and call all shrinkers
-		 * passing NULL for memcg.
-		 */
-		if (memcg_kmem_enabled() &&
-		    !!memcg != !!(shrinker->flags & SHRINKER_MEMCG_AWARE))
-			continue;
-
 		if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
 			sc.nid = 0;
 
